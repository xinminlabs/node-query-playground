FROM node:16 as build-deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . ./
ENV REACT_APP_JAVASCRIPT_BASE_URL https://synvert-api-javascript.xinminlabs.com
ENV REACT_APP_RUBY_BASE_URL https://synvert-api-ruby.xinminlabs.com
ENV GENERATE_SOURCEMAP false
RUN npm run build

FROM nginx:1.20-alpine
COPY --from=build-deps /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]