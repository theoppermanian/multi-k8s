

docker build -t theoppermanian/multi-client:latest -t theoppermanian/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t theoppermanian/multi-server:latest -t theoppermanian/multi-server:$GIT_SHA -f ./server/Dockerfile ./client
docker build -t theoppermanian/multi-worker:latest -t theoppermanian/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./client

docker push theoppermanian/multi-client:lastest
docker push theoppermanian/multi-client:$GIT_SHA
docker push theoppermanian/multi-server:latest
docker push theoppermanian/multi-server:$GIT_SHA
docker push theoppermanian/multi-worker:latest
docker push theoppermanian/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=theoppermanian/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=theoppermanian/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=theoppermanian/multi-worker:$GIT_SHA

