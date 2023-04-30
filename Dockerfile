FROM mcr.microsoft.com/dotnet/sdk:5.0 as build
WORKDIR webapp

EXPOSE 80
EXPOSE 5024

# Copio los archivos del proyecto
COPY ./*.csproj ./
RUN dotnet restore

#Copio todo lo demas
COPY . .
RUN dotnet publish -c Release -o out

#Compilo la imagen
FROM mcr.microsoft.com/dotnet/sdk:5.0
WORKDIR /webapp
COPY --from=build /webapp/out .
ENTRYPOINT ["dotnet","WebApplication1.dll"]