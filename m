Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTCJXxR>; Mon, 10 Mar 2003 18:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTCJXxQ>; Mon, 10 Mar 2003 18:53:16 -0500
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:8612 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262420AbTCJXw4>; Mon, 10 Mar 2003 18:52:56 -0500
Date: Mon, 10 Mar 2003 19:09:23 -0500
To: efault@gmx.de, ingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler starvation running irman with 2.5.64bk2
Message-ID: <20030311000923.GA1315@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, can you do the following to determine whether we're both seeing the
> _same_ problem?

> 1.)  build the attached rtnice utility (don't remember who wrote/posted this)
> 2.)  login on vt1 and set the shell SCHED_RR via rtnice -n 1 -p <pid_of_sh>
> -d RR
> 3.)  login on vt2 and renice that shell to -10
> 4.)  login on another vt as a normal user, and start irman
> 5.)  try login/out on another vt, or ps or _whatever_ (doesn't matter)
> until box is starving
> 6.)  on vt2, try to do ps (it should hang despite -10 priority)
> 7.)  on vt1, try to do ps (it should work just fine)

Here is the test as I understand it, splitted by tty.  Quick summary, 
only new process seems starved.  RR and nice -10 process behave okay.

BTW, this is now with 2.5.64bk5.

Below shows irman started, and it gets into the PROCESS
load.  Only thing odd here is the PROCESS load never completes.
(or I am not patient enough)

root@mountain:/usr/src/sources/i/irman# tty
/dev/pts/0
root@mountain:/usr/src/sources/i/irman# ./irman
Response time measurements (milliseconds) for: 2.5.64bk5
      Load       Max       Min       Avg Std. Dev.
      NULL     0.177     0.022     0.026     0.003
    MEMORY  1074.825     0.020     0.044     1.424
   FILE_IO   408.013     0.016     0.039     2.469


This is the RR shell.  It functions okay throughout the 
irman run.

root@mountain:~# tty
/dev/pts/1
root@mountain:~# rtnice -n 1 -p $$ -d RR
root@mountain:~# uptime
 18:46:33  up 8 min,  3 users,  load average: 3.21, 2.06, 0.89


This is the nice -10 shell.  It does okay too.

root@mountain:~# tty
/dev/pts/2
root@mountain:~# renice -10 $$
787: old priority 0, new priority -10
root@mountain:~# uptime
 18:45:18  up 7 min,  3 users,  load average: 3.39, 1.76, 0.70
root@mountain:~# uptime
 18:50:19  up 12 min,  3 users,  load average: 3.88, 2.98, 1.50
root@mountain:~# ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.5  0.0  1312  100 ?        S    18:37   0:04 init [3]
root         2  0.0  0.0     0    0 ?        SWN  18:37   0:00 [ksoftirqd/0]
root         3  0.0  0.0     0    0 ?        SW<  18:37   0:00 [events/0]
root         4  0.0  0.0     0    0 ?        SW   18:37   0:00 [pdflush]
root         5  0.0  0.0     0    0 ?        SW   18:37   0:00 [pdflush]
root         6  0.2  0.0     0    0 ?        SW   18:37   0:02 [kswapd0]
root         7  0.0  0.0     0    0 ?        SW<  18:37   0:00 [aio/0]
root       326  0.0  0.0     0    0 ?        SW   18:37   0:00 [eth0]
root       396  0.0  0.0  1368   92 ?        S    18:37   0:00 syslogd -m 0
root       401  0.0  0.0  1300   48 ?        S    18:37   0:00 klogd -x
rpc        421  0.0  0.0  1444   40 ?        S    18:37   0:00 portmap
root       534  0.0  0.0  2568  224 ?        S    18:37   0:00 /usr/sbin/sshd
root       544  0.0  0.0  1284   44 tty1     S    18:37   0:00 /sbin/mingetty tty1
root       545  0.0  0.0  1300   44 ttyS1    S    18:37   0:00 /sbin/agetty -h ttyS1 38400 linux
root       548  0.0  0.0  3352  256 ?        S    18:38   0:00 /usr/sbin/sshd
rwhron     549  0.0  0.0  2404   32 pts/0    S    18:38   0:00 -bash
root       593  0.0  0.0  2268   48 pts/0    S    18:38   0:00 su -
root       594  0.0  0.0  2400   32 pts/0    S    18:38   0:00 -bash
root       645  0.0  0.0  3352  300 ?        S    18:38   0:00 /usr/sbin/sshd
rwhron     646  0.0  0.0  2404   32 pts/1    S    18:38   0:00 -bash
root       690  0.0  0.0  2268   48 pts/1    S    18:38   0:00 su -
root       691  0.0  0.1  2400  512 pts/1    S    18:38   0:00 -bash
root       741  0.0  0.0  3352  300 ?        S    18:38   0:00 /usr/sbin/sshd
rwhron     742  0.0  0.0  2404   32 pts/2    S    18:38   0:00 -bash
root       786  0.0  0.0  2268   48 pts/2    S    18:38   0:00 su -
root       787  0.0  0.1  2400  520 pts/2    S<   18:38   0:00 -bash
root       844 23.0  0.0  1460  224 pts/0    R    18:41   2:10 ./irman
root       845  0.0  0.0     0    0 pts/0    Z    18:41   0:00 [irman <defunct>]
root       846  2.1  0.0     0    0 pts/0    Z    18:41   0:12 [irman <defunct>]
root       848  5.9  0.0     0    0 pts/0    Z    18:41   0:32 [mem_load <defunct>]
root       849  2.3  0.0     0    0 pts/0    Z    18:41   0:12 [irman <defunct>]
root       850  0.0  0.0     0    0 pts/0    Z    18:43   0:00 [io_load <defunct>]
root       851  1.7  0.0     0    0 pts/0    Z    18:43   0:07 [irman <defunct>]
root       855  8.9  0.0  1300  324 pts/0    S    18:44   0:32 process_load --processes 10 --recordsize 10000 --injections 2
root       857  7.4  0.0  1288  276 pts/0    S    18:44   0:27 child_process 10000 0 10
root       858  7.9  0.0  1288  276 pts/0    S    18:44   0:28 child_process 10000 3 12
root       859 13.0  0.0  1288  276 pts/0    R    18:44   0:47 child_process 10000 11 14
root       860 13.4  0.0  1288  276 pts/0    S    18:44   0:49 child_process 10000 13 16
root       861  8.0  0.0  1288  276 pts/0    R    18:44   0:29 child_process 10000 15 18
root       862 10.5  0.0  1288  276 pts/0    S    18:44   0:38 child_process 10000 17 20
root       863 11.2  0.0  1288  276 pts/0    S    18:44   0:41 child_process 10000 19 22
root       864  8.7  0.0  1288  276 pts/0    S    18:44   0:31 child_process 10000 21 24
root       865  7.9  0.0  1288  276 pts/0    S    18:44   0:28 child_process 10000 23 26
root       868  0.0  0.0  2568  108 ?        R    18:47   0:00 /usr/sbin/sshd
root       874  0.0  0.1  2544  668 pts/2    R<   18:50   0:00 ps aux


However if I start a new connection, it never gives a prompt.


rwhron@rushmore:~$ ssh mt
..  wait several minutes ... still no prompt.


>From the RR shell, one can see the new PID 876 for the sshd above.

root@mountain:~# ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.4  0.0  1312  100 ?        S    18:37   0:04 init [3]
root         2  0.0  0.0     0    0 ?        SWN  18:37   0:00 [ksoftirqd/0]
root         3  0.0  0.0     0    0 ?        SW<  18:37   0:00 [events/0]
root         4  0.0  0.0     0    0 ?        SW   18:37   0:00 [pdflush]
root         5  0.0  0.0     0    0 ?        SW   18:37   0:00 [pdflush]
root         6  0.2  0.0     0    0 ?        SW   18:37   0:02 [kswapd0]
root         7  0.0  0.0     0    0 ?        SW<  18:37   0:00 [aio/0]
root       326  0.0  0.0     0    0 ?        SW   18:37   0:00 [eth0]
root       396  0.0  0.0  1368   92 ?        S    18:37   0:00 syslogd -m 0
root       401  0.0  0.0  1300   52 ?        S    18:37   0:00 klogd -x
rpc        421  0.0  0.0  1444   44 ?        S    18:37   0:00 portmap
root       534  0.0  0.0  2568  224 ?        S    18:37   0:00 /usr/sbin/sshd
root       544  0.0  0.0  1284   48 tty1     S    18:37   0:00 /sbin/mingetty tty1
root       545  0.0  0.0  1300   48 ttyS1    S    18:37   0:00 /sbin/agetty -h ttyS1 38400 linux
root       548  0.0  0.0  3352  256 ?        S    18:38   0:00 /usr/sbin/sshd
rwhron     549  0.0  0.0  2404   36 pts/0    S    18:38   0:00 -bash
root       593  0.0  0.0  2268   52 pts/0    S    18:38   0:00 su -
root       594  0.0  0.0  2400   36 pts/0    S    18:38   0:00 -bash
root       645  0.0  0.0  3352  304 ?        R    18:38   0:00 /usr/sbin/sshd
rwhron     646  0.0  0.0  2404   36 pts/1    S    18:38   0:00 -bash
root       690  0.0  0.0  2268   52 pts/1    S    18:38   0:00 su -
root       691  0.0  0.1  2400  520 pts/1    S    18:38   0:00 -bash
root       741  0.0  0.0  3352  304 ?        S    18:38   0:00 /usr/sbin/sshd
rwhron     742  0.0  0.0  2404   36 pts/2    S    18:38   0:00 -bash
root       786  0.0  0.0  2268   52 pts/2    S    18:38   0:00 su -
root       787  0.0  0.1  2400  520 pts/2    S<   18:38   0:00 -bash
root       844 18.6  0.0  1460  224 pts/0    R    18:41   2:10 ./irman
root       845  0.0  0.0     0    0 pts/0    Z    18:41   0:00 [irman <defunct>]
root       846  1.7  0.0     0    0 pts/0    Z    18:41   0:12 [irman <defunct>]
root       848  4.8  0.0     0    0 pts/0    Z    18:41   0:32 [mem_load <defunct>]
root       849  1.8  0.0     0    0 pts/0    Z    18:41   0:12 [irman <defunct>]
root       850  0.0  0.0     0    0 pts/0    Z    18:43   0:00 [io_load <defunct>]
root       851  1.3  0.0     0    0 pts/0    Z    18:43   0:07 [irman <defunct>]
root       855  9.0  0.0  1300  324 pts/0    S    18:44   0:45 process_load --processes 10 --recordsize 10000 --injections 2
root       857  7.5  0.0  1288  276 pts/0    S    18:44   0:37 child_process 10000 0 10
root       858  7.9  0.0  1288  276 pts/0    S    18:44   0:39 child_process 10000 3 12
root       859 13.1  0.0  1288  276 pts/0    S    18:44   1:05 child_process 10000 11 14
root       860 13.5  0.0  1288  276 pts/0    R    18:44   1:07 child_process 10000 13 16
root       861  8.0  0.0  1288  276 pts/0    R    18:44   0:40 child_process 10000 15 18
root       862 10.6  0.0  1288  276 pts/0    S    18:44   0:53 child_process 10000 17 20
root       863 11.3  0.0  1288  276 pts/0    S    18:44   0:56 child_process 10000 19 22
root       864  8.8  0.0  1288  276 pts/0    S    18:44   0:43 child_process 10000 21 24
root       865  7.9  0.0  1288  276 pts/0    S    18:44   0:39 child_process 10000 23 26
root       868  0.0  0.0  2568  108 ?        R    18:47   0:00 /usr/sbin/sshd
root       876  0.0  0.0  2568  252 ?        R    18:52   0:00 /usr/sbin/sshd
root       877  0.0  0.1  2544  668 pts/1    R    18:53   0:00 ps aux


This is some info on PID 876 (sshd child):

root@mountain:/proc/876# cat cmdline
/usr/sbin/sshd
root@mountain:/proc/876# cat status
Name:   sshd
State:  R (running)
Tgid:   876
Pid:    876
PPid:   534
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
FDSize: 32
Groups:
VmSize:     2568 kB
VmLck:         0 kB
VmRSS:       252 kB
VmData:      100 kB
VmStk:        12 kB
VmExe:       248 kB
VmLib:      2108 kB
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: 8000000000001000
SigCgt: 0000000000000000
CapInh: 0000000000000000
CapPrm: 00000000fffffeff
CapEff: 00000000fffffeff
root@mountain:/proc/876# cat wchan
0
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

