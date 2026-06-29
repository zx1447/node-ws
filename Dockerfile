FROM node:20-alpine3.20

WORKDIR /tmp

# 先复制依赖文件安装（分层缓存加速构建）
COPY package.json ./
RUN npm install --production

# 再复制主程序
COPY index.js ./

# 安装运行所需工具：bash、openssl、curl、procps(提供ps命令，脚本要用ps查哪吒进程)
RUN apk update && apk add --no-cache bash openssl curl procps && \
    chmod +x index.js

EXPOSE 3000

CMD ["node", "index.js"]
