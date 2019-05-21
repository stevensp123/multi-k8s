docker build -t stevensp123/multi-client:latest -t stevensp123/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stevensp123/multi-server:latest -t stevensp123/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stevensp123/multi-worker:latest -t stevensp123/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push stevensp123/multi-client:latest
docker push stevensp123/multi-server:latest
docker push stevensp123/multi-worker:latest
docker push stevensp123/multi-client:$SHA
docker push stevensp123/multi-server:$SHA
docker push stevensp123/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stevensp123/multi-server:$SHA
kubectl set image deployments/client-deployment client=stevensp123/multi-client:$SHA
kubectl set image deployments/worker-deployment woker=stevensp123/multi-worker:$SHA