Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTF0Q6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 12:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTF0Q6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 12:58:10 -0400
Received: from [65.193.106.66] ([65.193.106.66]:45588 "EHLO
	xchangeserver2.storigen.com") by vger.kernel.org with ESMTP
	id S264498AbTF0Q5o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 12:57:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: ~2.4.20-pre3 -> 2.4.21 :  nfs client read performance "broken"
Date: Fri, 27 Jun 2003 13:11:59 -0400
Message-ID: <7BFCE5F1EF28D64198522688F5449D5A025ED89C@xchangeserver2.storigen.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ~2.4.20-pre3 -> 2.4.21 :  nfs client read performance "broken"
Thread-Index: AcM8zzfncj36qQUBTu2UgoLqSF4TUA==
From: "Larry Sendlosky" <Larry.Sendlosky@storigen.com>
To: <nfs@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We recently started using 2.4.21, a move up from 2.4.18. Somebody
in the group brought to my attention a nfs client performance
problem using 2.4.21 vs 2.4.18. Single client read throughput can be
cut in half!

I've narrowed down the problem to the "congestion
avoidance" patches that went into RPC, specifically changesets
1.555.49.11, .12, and .13. A kernel built with 1.555.48.10
works just fine, and everything after exhibits the performance
problem I will describe below. Building a kernel from the RH9
CD sources shows the same problem.

I've searched the mailing lists and google'd and cannot find any
other mention of this problem, so I'm hoping that I've missed something
obvious because nobody else has complained.

Client: Dell 600 connected to 100Mb switch. 512MB memory.
Server: Tyan 2510 running 2.4.18 connected to same 100Mb switch. 1GB memory.

The 100MB switch has 5 ports with 2 other basically inactive systems
in my office.

Performance summary:

Client running "pre-congestion control" RPC (circa 2.4.20-pre3)
can read 50MB of file data in about 5 seconds realtime with
each 256K buffer read taking less than 40ms with 0 RPC client retransmits.

Client running 2.4.21 can read 50MB of file data in about 10 seconds
realtime with 2/3 of the 256K buffer reads taking greater than 40ms with about
300 RPC client retransmits.

The only conclusion I can draw from my data is that the "congestion avoidance"
code is fundamentally broken because it can't handle the degenerate
case where there is *no* congestion. 

Extra info:

In the RPC code, I tried treating UDP and TCP the same wrt the
"nocongestion control" flag, .i.e. in xprt_setup, in xprt.c

		       xprt->cwnd = RPC_MAXCWND;
		       xprt->nocong = 1;

for both protocols. My intend was to "neuter" the congestion avoidance
code. Well, the client reads never finished.

I also did some "spot" instrumentation and noticed that the new
code "ratchets" down the RPC timeout values as part of the algorithm.
In my test case, the timer gets down to 40ms and timeouts start to
occur and it continues to get some timeouts using that value thereafter.
This causes the retransmits. So, in another attempt to "neuter" the code, I 
changed rpc_calc_rto in sunrpc/timer.c to never return a timer value
less than 100ms. I know all my reads happen much faster. However, with
that change, I see just as many timeouts of 100ms timers! And, many
I/O completion times go above 100ms. This is one of the reasons why I
think the code is broken. 


Performance data:

Below shows the actual data I was referring to above. The 'workq' program
is an in-house tool that we use to "beat on" disks and filesystems.
'workq -r -t1 -f10 -S5M -s256k -dv' means use 1 thread to read 5MB
from 10 files using a 256k buffer. The files already exist.

Thanks for any help,

larry


[root@johny2 root]# uname -a
Linux pooperscooper 2.4.20-pre3 #2 SMP Fri Jun 27 09:35:01 EDT 2003 i686 n

[root@pooperscooper root]# !mount    
mount -t nfs -o rsize=8192,wsize=8192 lws02:/var/data /var/data

[root@pooperscooper root]# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
/proc /proc proc rw 0 0
/dev/md1 /boot ext3 rw 0 0
/dev/md7 /var ext3 rw 0 0
none /dev/pts devpts rw 0 0
none /dev/shm tmpfs rw 0 0
/dev/md10 /.metadata ext3 rw,noatime 0 0
lws02:/var/data /var/data nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=lw0

[root@pooperscooper root]# nfsstat -c
Client rpc stats:
calls      retrans    authrefrsh
3          0          0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 1      33% 0       0% 0       0% 0       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
1      33% 1      33% 0       0% 0       0% 

[root@pooperscooper root]# cd /var
[root@pooperscooper var]# ls -l data/fifty.dat 
-rw-r--r--    1 root     root     52428800 Jun 24 16:25 data/fifty.dat

[root@pooperscooper var]# time cat data/fifty.dat > /dev/null

real    0m4.820s
user    0m0.010s
sys     0m0.120s


[root@pooperscooper var]# nfsstat -c
Client rpc stats:
calls      retrans    authrefrsh
12736      0          0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 6       0% 0       0% 1       0% 9       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
6400   99% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 1       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
1       0% 1       0% 0       0% 0       0% 

[root@pooperscooper var]# !umount
umount /var/data

[root@pooperscooper var]# !mount
mount -t nfs -o rsize=8192,wsize=8192 lws02:/var/data /var/data

[root@pooperscooper var]# nfsstat -c
Client rpc stats:
calls      retrans    authrefrsh
12739      0          0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 7       0% 0       0% 1       0% 9       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
6400   99% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 1       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
2       0% 2       0% 0       0% 0       0% 

[root@pooperscooper var]# ls -l data                               
total 102576
-rwxr-xr-x    1 root     root      5242880 Jun 23 11:15 disk0.dat
-rwxr-xr-x    1 root     root      5242880 Jun 23 11:15 disk1.dat
-rwxr-xr-x    1 root     root      5242880 Jun 23 11:15 disk2.dat
-rwxr-xr-x    1 root     root      5242880 Jun 23 11:15 disk3.dat
-rwxr-xr-x    1 root     root      5242880 Jun 23 11:15 disk4.dat
-rwxr-xr-x    1 root     root      5242880 Jun 23 11:15 disk5.dat
-rwxr-xr-x    1 root     root      5242880 Jun 23 11:15 disk6.dat
-rwxr-xr-x    1 root     root      5242880 Jun 23 11:15 disk7.dat
-rwxr-xr-x    1 root     root      5242880 Jun 23 11:15 disk8.dat
-rwxr-xr-x    1 root     root      5242880 Jun 23 11:15 disk9.dat
-rw-r--r--    1 root     root     52428800 Jun 24 16:25 fifty.dat

[root@pooperscooper var]# /usr/local/bin/workq -r -t1 -f10 -S5M -s256k -dv

Copyright (c) 2000-2003, Storigen Systems, Inc.
All rights reserved.

 OP  THDS IOSZ FILS FSIZ BOFF FOFF BWDTH   CPUT  CLOCKT %CPUMbs CSWIT FAULT
---- ---- ---- ---- ---- ---- ---- ----- ------- ------ ------- ----- -----
READ    1  256   10    5    0    0 010.3 000.130 0004.9 0.01625     0     7
 10ms    =          0
 20ms    =          4
 30ms    =        192
 40ms    =          4
 50ms    =          0
 60ms    =          0
 70ms    =          0
 80ms    =          0
 90ms    =          0
 100ms   =          0
 200ms   =          0
 300ms   =          0
 400ms   =          0
 500ms   =          0
 600ms   =          0
 700ms   =          0
 800ms   =          0
 900ms   =          0
 1000ms  =          0
 >1s     =          0
 all_ios =        200
 min     =      0.012
 max     =      0.036

[root@pooperscooper var]# nfsstat -c
Client rpc stats:
calls      retrans    authrefrsh
25395      0          0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 18      0% 0       0% 12      0% 42      0% 0       0% 
read       write      create     mkdir      symlink    mknod      
12800  99% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 2       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
2       0% 2       0% 0       0% 0       0% 

[root@pooperscooper var]# 

*******************************************************************************
Bad performance
******************************************************************************

[root@pooperscooper root]# uname -a

Linux pooperscooper 2.4.21 #1 SMP Tue Jun 24 08:40:50 EDT 2003 in

[root@pooperscooper root]# cd /var

[root@pooperscooper var]# !mount
mount -t nfs -o rsize=8192,wsize=8192 lws02:/var/data /var/data

[root@pooperscooper var]# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
/proc /proc proc rw 0 0
/dev/md1 /boot ext3 rw 0 0
/dev/md7 /var ext3 rw 0 0
none /dev/pts devpts rw 0 0
none /dev/shm tmpfs rw 0 0
/dev/md10 /.metadata ext3 rw,noatime 0 0
lws02:/var/data /var/data nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=lw0

[root@pooperscooper var]# nfsstat -c
Client rpc stats:
calls      retrans    authrefrsh
3          0          0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 1      33% 0       0% 0       0% 0       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
1      33% 1      33% 0       0% 0       0% 

[root@pooperscooper var]# time cat data/fifty.dat > /dev/null 

real    0m10.183s
user    0m0.000s
sys     0m0.030s

[root@pooperscooper var]# nfsstat -c
Client rpc stats:
calls      retrans    authrefrsh
6412       304        0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 4       0% 0       0% 1       0% 4       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
6400   99% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 1       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
1       0% 1       0% 0       0% 0       0% 

[root@pooperscooper var]# !umount 
umount /var/data

[root@pooperscooper var]# !mount
mount -t nfs -o rsize=8192,wsize=8192 lws02:/var/data /var/data

[root@pooperscooper var]# nfsstat -c
Client rpc stats:
calls      retrans    authrefrsh
6415       304        0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 5       0% 0       0% 1       0% 4       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
6400   99% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 1       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
2       0% 2       0% 0       0% 0       0% 

[root@pooperscooper var]# /usr/local/bin/workq -r -t1 -f10 -S5M -s256k -dv

Copyright (c) 2000-2003, Storigen Systems, Inc.
All rights reserved.

 OP  THDS IOSZ FILS FSIZ BOFF FOFF BWDTH   CPUT  CLOCKT %CPUMbs CSWIT FAULT
---- ---- ---- ---- ---- ---- ---- ----- ------- ------ ------- ----- -----
READ    1  256   10    5    0    0 004.6 000.100 0011.0 0.01250     0     7
 10ms    =          0
 20ms    =         61
 30ms    =          4
 40ms    =          0
 50ms    =         29
 60ms    =         24
 70ms    =          0
 80ms    =         20
 90ms    =         56
 100ms   =          4
 200ms   =          1
 300ms   =          0
 400ms   =          0
 500ms   =          1
 600ms   =          0
 700ms   =          0
 800ms   =          0
 900ms   =          0
 1000ms  =          0
 >1s     =          0
 all_ios =        200
 min     =      0.012
 max     =       0.46

[root@pooperscooper var]# nfsstat -c
Client rpc stats:
calls      retrans    authrefrsh
12847      644        0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 5       0% 0       0% 11      0% 25      0% 0       0% 
read       write      create     mkdir      symlink    mknod      
12800  99% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 2       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
2       0% 2       0% 0       0% 0       0% 
