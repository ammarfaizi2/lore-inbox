Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281762AbRLLSuP>; Wed, 12 Dec 2001 13:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281805AbRLLSuF>; Wed, 12 Dec 2001 13:50:05 -0500
Received: from dentin.eaze.net ([216.228.128.151]:4616 "EHLO xirr.com")
	by vger.kernel.org with ESMTP id <S281794AbRLLSt5>;
	Wed, 12 Dec 2001 13:49:57 -0500
Date: Wed, 12 Dec 2001 13:50:13 -0600
From: SodaPop <soda@xirr.com>
Message-Id: <200112121950.fBCJoDW17927@xirr.com>
To: linux-kernel@vger.kernel.org
Subject: Possible TCP LAST-ACK problem?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Possible TCP LAST-ACK problem?
I've been attempting to run the specweb99 benchmark on linux recently,
and have noticed some wierd problems that may be related to the reported
TCP LAST-ACK problem.

My setup consists of multiple PPC SMP partitions on a rather large
system, each running the ppc64 version of the linux kernel.  The current
version is roughly 2.4.13, using Rik's VM.

Anyway, what I am seeing is that at high network loads, I occasionally
end up with a connection that is closed on one end, but open on the
other.  I understand that this can happen, but I don't think it's
supposed to happen in the way that I'm seeing it.  Here are some
netstats, and explanations:


This is the server machine.  The two connections on port 22 are the ssh
sessions I use to monitor the progress of the benchmark and collect this
data.  The 5 CLOSE_WAIT connections are specweb clients that completed
successfully.  The ESTABLISHED connection is to a specweb client that is
hung, waiting forever on a network socket.
Note the lack of any connections to port 80, the web server.
-------------------------------------------------------------
snowy9:~ # netstat -nt
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        1      0 172.16.3.9:32801        172.16.3.7:2222         CLOSE_WAIT  
tcp        1      0 172.16.3.9:32800        172.16.3.6:2222         CLOSE_WAIT  
tcp        1      0 9.5.149.220:32798       9.5.149.202:2222        CLOSE_WAIT  
tcp        0      0 172.16.3.9:32797        172.16.3.2:2222         ESTABLISHED 
tcp        1      0 172.16.3.9:32796        172.16.3.1:2222         CLOSE_WAIT  
tcp        1      0 172.16.3.9:32799        172.16.3.5:2222         CLOSE_WAIT  
tcp        0    240 172.16.3.9:22           9.5.66.226:56789        ESTABLISHED 
tcp        0      0 172.16.3.9:22           9.5.66.226:56790        ESTABLISHED 
snowy9:~ # 


This is the client machine with the hung specweb process.  As usual, the
two ssh connections are for startup and monitoring.  The connection on
port 2222 matches exactly with the one on the server.  Note the final
connection however - it shows an established connection to the server on
the http port.  The server has no corresponding connection listed.
-------------------------------------------------------------
[root@snowy2 /root]# netstat -nt
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0     20 9.5.149.139:22          9.5.66.226:56804        ESTABLISHED 
tcp        0      0 9.5.149.139:22          9.5.66.226:56782        ESTABLISHED 
tcp        0      0 172.16.3.2:2222         172.16.3.9:32797        ESTABLISHED 
tcp        0      0 172.16.3.2:41683        172.16.3.9:80           ESTABLISHED 
[root@snowy2 /root]# 


The thing that makes this a problem is the state of the client that has
the 172.16.3.2:41683 socket open.  That process is blocked on a syscall
read(), and never wakes up.  If I send a harmless signal to this process,
the syscall is interrupted and the read returns -1, EINTR.  The client
then notices that the socket is closed, marks the connection as bad, and
continues on its merry way.

So it looks like somehow, in high load situations, it is possible for a
connection to be closed on one end, but not notify the other end.  When
this happens, a blocking read() on the socket will block forever (or
until interrupted.)

Are there any suggestions for what I should look at, or how I should
attempt to debug this?  Doing a tcpdump to catch it happening is likely
out of the question, given the load required to trigger it.  Things I
have checked:

1) It happens both on 32 and 64 bit ppc kernels.

2) It appears to also happen on intel x86 hardware (only 2.4 kernels
   tried.)  We suspect that other people are seeing this as well, as
   other people report random benchmark hangs and the 'recommended'
   solution is to add clients (thus reducing the load on each client)
   until the benchmark completes successfully.

3) It does not appear to be a driver issue:
   It happens with virtual ethernet between partitions.
   It happens with pcnet32 10/100 ethernet adapters.
   It happens with acenic GB ethernet adapters.
   It happens with eepro100 and GB adapters in x86 machines.

4) Tuning various things in /proc does not appear to help, though
   I do get performance and scaling improvements that way.
5) I have used various combinations of crossover cable, switches, and
   virtual ethernet.  A broken switch does not appear to be causing the
   problem.

The only thing I can think of is that either this LAST_ACK bug is being
triggered, or something similar.  I have tried the one-liner recommended
by Alexey to no avail:

> Well, you can just add one line to tcp_input.c to repair this. 
> 
>                 } 
>                 /* Fall through */ 
> + case TCP_LAST_ACK: 
>         case TCP_ESTABLISHED: 
>                 tcp_data_queue(sk, skb); 
> 

Any ideas? Thanks in advance,

-dennis T

(Please CC, I read list archives but am not subscribed.)
