Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262383AbSJ0NLJ>; Sun, 27 Oct 2002 08:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbSJ0NLI>; Sun, 27 Oct 2002 08:11:08 -0500
Received: from 205-158-62-132.outblaze.com ([205.158.62.132]:31877 "HELO
	ws5-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262383AbSJ0NLH>; Sun, 27 Oct 2002 08:11:07 -0500
Message-ID: <20021027131720.25163.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 27 Oct 2002 21:17:20 +0800
Subject: [Benchmark] Chat results
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

		--- What is the chat benchmark ---
Usage: chat_s ip_addr [port]

       ip_addr:	ip address that the server binds to listening socket.
       [port]:	port number server binds to the listening socket.
		default is 9999.

Usage: chat_c ip_addr [num_rooms] [num_messages] [server_port]

       ip_addr:		server ip address that the client connects to.
       [num_rooms]:	the number of chat rooms.
			default is 10.
       [num_messages]:	the number of messages sent by each chat room member.
			default is 100.	
       [port]:		server port number the client connects to.
			default is 9999.

This benchmark includes both a client and server.  The benchmark is
modeled after a chat room.  This benchmark will create a lot of threads,
tcp connections, and send and receive a lot of messages.  The client side
of the benchmark will report the number of messages sent per second.

The number of chat rooms and messages will control the workload.
The default number of chat rooms is 10.
The default number of messages is 100.  The size of each message is 100 bytes.
Both of these parameters are specified on the client side.

(1) Each chat room has 20 users.
(2) 10 chat rooms represents 20*10 or 200 users.
(3) For each user in the chat room, the client will make a connection
    to the server.
(4) 10 chat rooms will create 10*20 or 200 connections between the client
    and server.
(5) For each user (or connection) in the chat room, 1 'send' thread is created
    and 1 'receive' thread is created.
(6) 10 chat rooms will create 10*20*2 or 400 client threads and 400 server
    threads for a total of 800 threads.
(7) Each client 'send' thread will send the specified number of messages
    to the server.
(8) For 10 chat rooms and 100 messages, the client will send 10*20*100 or
    20,000 messages.  The server 'receive' thread will receive the
    corresponding number of messages.
(9) The chat room server will echo each of the messages back to the other
    users in the chat room.
(10) For 10 chat rooms and 100 messages, the server 'send' thread will send
     10*20*100*19 or 380,000 messages.  The client 'receive' thread will
     receive the corresponding number of messages.
(11) The client will report the message throughput at the end of the test.
(12) The server loops and accepts another start message from the client.

		--- The scripts I used ---
#!/bin/sh
/etc/init.d/network stop
/etc/init.d/network start
./chat_s 127.0.0.1 &
> `uname -r`_total.results
for i in `seq 1 1 10`
do
	./chat_c 127.0.0.1 30 1000 9999 >>`uname -r`_total.results
done
grep Average `uname -r`_total.results | awk '{tot+=$4}; END {print "Average throughput: " tot/NR " messages per second"}' > `uname -r`.average
grep Average `uname -r`_total.results|sort >`uname -r`.sort
echo -n "Min throughput:" >> `uname -r`.average
head -1 `uname -r`.sort|cut -d ":" -f 2 >> `uname -r`.average
echo -n "Max throughput:" >> `uname -r`.average
tail -1 `uname -r`.sort|cut -d ":" -f 2 >> `uname -r`.average


#!/bin/bash
out=(`ls *.average|sort`)
total=`echo ${out[@]}|wc -w`
# echo $total 
> summary.txt
for i in `seq 0 1 $[total-1]`
do
kernel_version=`echo ${out[i]}|cut -d "." --fields=1-3`
	echo -e "\t\tKernel version: $kernel_version" >> summary.txt
	cat ${out[i]} >> summary.txt
	echo >> summary.txt
done;


		--- Results --- 
		
		Kernel version: 2.4.19-ck7
Average throughput: 57210.1 messages per second
Min throughput: 55007 messages per second
Max throughput: 61988 messages per second

		Kernel version: 2.4.19
Average throughput: 47250.9 messages per second
Min throughput: 45634 messages per second
Max throughput: 50940 messages per second

		Kernel version: 2.5.38
Average throughput: 62543.3 messages per second
Min throughput: 58416 messages per second
Max throughput: 64196 messages per second

		Kernel version: 2.5.40
Average throughput: 60115.4 messages per second
Min throughput: 52443 messages per second
Max throughput: 63264 messages per second

		Kernel version: 2.5.43
Average throughput: 58807.5 messages per second
Min throughput: 55376 messages per second
Max throughput: 60617 messages per second

		Kernel version: 2.5.44-mm1
Average throughput: 56060.7 messages per second
Min throughput: 53250 messages per second
Max throughput: 58617 messages per second

		Kernel version: 2.5.44-mm5
Average throughput: 56778.8 messages per second
Min throughput: 54685 messages per second
Max throughput: 59737 messages per second

		Kernel version: 2.5.44
Average throughput: 57906.2 messages per second
Min throughput: 49808 messages per second
Max throughput: 60197 messages per second



Comments/suggestions ?


		Paolo


-- 

Powered by Outblaze
