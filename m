Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274230AbRISWXL>; Wed, 19 Sep 2001 18:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274228AbRISWXD>; Wed, 19 Sep 2001 18:23:03 -0400
Received: from atlrel6.hp.com ([192.151.27.8]:37904 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S274227AbRISWWm>;
	Wed, 19 Sep 2001 18:22:42 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C04728F72@xfc04.fc.hp.com>
From: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
To: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Heavy NFS load with 2.4.10-pre12 still fails
Date: Wed, 19 Sep 2001 18:22:55 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still seeing kswapd run wild during heavy NFS loads with
linux-2.4.10-pre12.  I'm running the SPEC NFS test
(http://www.spec.org/osg/sfs97).  I ran "top > top.log" during the test to
capture the kswapd behavior.

Hardware:
- 4 processors, 4GB ram
- 45 fibre channel drives, set up in hardware RAID 0/1
- 2 direct Gigabit Ethernet connections between SPEC SFS prime client and
system under test
- reiserfs
- all NFS filesystems exported with sync,no_wdelay to insure O_SYNC writes
to storage
- NFS v3 UDP
- linux-2.4.10-pre12

The spec results consist of the following data (only the first three numbers
are significant for this discussion)
- load.  The load the SPEC prime client will try to get out of the system
under test.  Measured in I/O's per second (IOPS).
- throughput.  The load seen from the system under test.  Measured in IOPS
- response time.  Measured in milliseconds
- total operations
- elapsed time.  Measured in seconds
- NFS version. 2 or 3
- Protocol. UDP (U) or TCP (T)
- file set size in megabytes
- number of clients
- number of SPEC SFS processes
- biod reads
- biod writes
- SPEC SFS version

"INVALID" means that too many (> 1%) of the RPC calls between the SPEC prime
client and the system under test failed.  This is not a good thing

SPEC results before 2.4.10-pre12 test stopped:
            500     497     1.2   149134  300 3 U    5070624   1 48  2  2
2.0
           1000    1001     1.5   299153  299 3 U   10141248   1 48  2  2
2.0
           1500    1587     6.9   476068  300 3 U   15210624   1 48  2  2
2.0
INVALID    2000     795    24.5   237732  299 3 U   20281248   1 48  2  2
2.0

2.4.7 Results (only first three numbers shown, test continues fine for many
more tests)
            500     497     1.2   149206  300 3 U    5070624   1 48  2  2
2.0
           1000    1005     1.5   300503  299 3 U   10141248   1 48  2  2
2.0
           1500    1502     1.3   449232  299 3 U   15210624   1 48  2  2
2.0

With 2.4.7 kernel, the test runs much longer, and INVALID is never seen.
That large jump in response time on the 1500 IOPS run is also not seen with
2.4.7 kernel

The top screens from interesting parts of the test are included below.  I'm
willing to try any patches (or measurement tools, within reason) anyone
wants to provide to solve this problem.

Erik Habbinga
Hewlett Packard

Top results:

Here's a top screen at the start of the test:

1:06pm  up 2 min,  1 user,  load average: 6.02, 1.92, 0.68
220 processes: 218 sleeping, 2 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 49.0% system,  0.0% nice, 50.0% idle
CPU1 states:  0.1% user, 50.0% system,  0.0% nice, 48.0% idle
CPU2 states:  0.1% user, 58.0% system,  0.0% nice, 40.0% idle
CPU3 states:  0.0% user, 42.1% system,  0.0% nice, 57.0% idle
Mem:  3924304K av,  437124K used, 3487180K free,       0K shrd,   15948K
buff
Swap: 1043900K av,       0K used, 1043900K free                  319056K
cached
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  552 root      17   0  1064 1064   760 R    11.5  0.0   0:00 top
    9 root      14   0     0    0     0 DW    9.1  0.0   0:08 kupdated
  305 root      12   0     0    0     0 SW    5.7  0.0   0:00 nfsd
   76 root      11   0   636  636   544 D     4.9  0.0   0:04 syslogd
  300 root      12   0     0    0     0 SW    4.9  0.0   0:00 nfsd
  306 root      11   0     0    0     0 SW    3.3  0.0   0:00 nfsd
  339 root      12   0     0    0     0 SW    3.3  0.0   0:00 nfsd
  385 root      11   0     0    0     0 SW    3.3  0.0   0:00 nfsd
  398 root       9   0     0    0     0 SW    3.3  0.0   0:00 nfsd
  399 root       9   0     0    0     0 SW    3.3  0.0   0:00 nfsd
  408 root       9   0     0    0     0 SW    3.3  0.0   0:00 nfsd
  294 root      11   0     0    0     0 SW    2.4  0.0   0:00 nfsd
  310 root      11   0     0    0     0 SW    2.4  0.0   0:00 nfsd
  315 root      10   0     0    0     0 SW    2.4  0.0   0:00 nfsd
  321 root      11   0     0    0     0 SW    2.4  0.0   0:00 nfsd

and here are some successive screens when swapd starts going wild.  This is
during the 1500 IOPS test.

 2:04pm  up  1:00,  1 user,  load average: 7.37, 8.25, 6.53
220 processes: 219 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.2% user, 18.4% system,  0.0% nice, 80.3% idle
CPU1 states:  0.0% user, 14.4% system,  0.0% nice, 85.0% idle
CPU2 states:  0.0% user, 16.0% system,  0.0% nice, 83.5% idle
CPU3 states:  0.0% user, 16.5% system,  0.0% nice, 83.0% idle
Mem:  3924304K av, 3917264K used,    7040K free,       0K shrd,   98464K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3255392K
cached
;10m
m  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    9 root      14   0     0    0     0 SW    9.4  0.0   5:05 kupdated
    7 root       9   0     0    0     0 SW    6.9  0.0   1:46 kswapd
  348 root       9   0     0    0     0 SW    1.9  0.0   0:30 nfsd
  341 root       9   0     0    0     0 SW    1.7  0.0   0:30 nfsd
  369 root       9   0     0    0     0 SW    1.5  0.0   0:30 nfsd
  552 root      16   0  1080 1080   768 R     1.5  0.0   1:34 top
  333 root       9   0     0    0     0 SW    1.3  0.0   0:29 nfsd
  360 root      12   0     0    0     0 SW    1.3  0.0   0:30 nfsd
  302 root       9   0     0    0     0 SW    1.1  0.0   0:30 nfsd
  344 root       9   0     0    0     0 SW    1.1  0.0   0:30 nfsd
  324 root       9   0     0    0     0 SW    0.9  0.0   0:29 nfsd
  330 root       9   0     0    0     0 SW    0.9  0.0   0:29 nfsd
  395 root       9   0     0    0     0 SW    0.9  0.0   0:29 nfsd
  305 root      10   0     0    0     0 SW    0.7  0.0   0:29 nfsd
  346 root       9   0     0    0     0 SW    0.7  0.0   0:30 nfsd
 2:04pm  up  1:00,  1 user,  load average: 7.02, 8.17, 6.51
220 processes: 219 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.3% user, 18.0% system,  0.0% nice, 81.1% idle
CPU1 states:  0.0% user, 13.4% system,  0.0% nice, 86.1% idle
CPU2 states:  0.0% user, 12.0% system,  0.0% nice, 87.4% idle
CPU3 states:  0.0% user, 12.3% system,  0.1% nice, 87.0% idle
Mem:  3924304K av, 3918572K used,    5732K free,       0K shrd,   98728K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3256352K
cached
;10m
m  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      18   0     0    0     0 SW    6.4  0.0   1:46 kswapd
    9 root      17   0     0    0     0 DW    3.3  0.0   5:05 kupdated
  396 root      10   0     0    0     0 SW    3.3  0.0   0:29 nfsd
  552 root      14   0  1080 1080   768 R     2.9  0.0   1:34 top
  321 root       9   0     0    0     0 SW    1.9  0.0   0:30 nfsd
  374 root       9   0     0    0     0 SW    1.9  0.0   0:29 nfsd
  342 root      10   0     0    0     0 SW    1.5  0.0   0:29 nfsd
  403 root      11   0     0    0     0 SW    1.5  0.0   0:28 nfsd
  287 root      12   0     0    0     0 SW    0.9  0.0   0:30 nfsd
  332 root      11   0     0    0     0 SW    0.9  0.0   0:28 nfsd
  334 root      13   0     0    0     0 SW    0.9  0.0   0:29 nfsd
  367 root      11   0     0    0     0 SW    0.9  0.0   0:29 nfsd
  302 root      10   0     0    0     0 SW    0.7  0.0   0:30 nfsd
  343 root      10   0     0    0     0 SW    0.7  0.0   0:29 nfsd
  347 root       9   0     0    0     0 SW    0.7  0.0   0:29 nfsd
  2:04pm  up  1:00,  1 user,  load average: 7.10, 8.16, 6.52
220 processes: 215 sleeping, 5 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 86.2% system,  0.1% nice, 13.3% idle
CPU1 states:  0.1% user, 86.2% system,  0.1% nice, 13.2% idle
CPU2 states:  0.1% user, 86.1% system,  0.0% nice, 13.4% idle
CPU3 states:  0.0% user, 85.3% system,  0.2% nice, 14.2% idle
Mem:  3924304K av, 3919380K used,    4924K free,       0K shrd,   98484K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3257296K
cached
;10m
m  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      18   0     0    0     0 RW   48.6  0.0   1:50 kswapd
  552 root      14   0  1080 1080   768 R    31.9  0.0   1:37 top
    9 root       9   0     0    0     0 DW   21.8  0.0   5:07 kupdated
  297 root       9   0     0    0     0 SW    3.8  0.0   0:29 nfsd
  248 root      15  10  6960 6956  4904 S N   3.0  0.1   0:15 hpCpuMond
  369 root       9   0     0    0     0 SW    3.0  0.0   0:30 nfsd
  333 root       9   0     0    0     0 SW    2.7  0.0   0:30 nfsd
  382 root       9   0     0    0     0 SW    2.7  0.0   0:30 nfsd
  374 root       9   0     0    0     0 SW    2.5  0.0   0:30 nfsd
  372 root       9   0     0    0     0 SW    2.4  0.0   0:30 nfsd
  397 root       9   0     0    0     0 SW    2.4  0.0   0:30 nfsd
  368 root       9   0     0    0     0 SW    2.3  0.0   0:30 nfsd
  378 root       9   0     0    0     0 SW    2.3  0.0   0:30 nfsd
  366 root       9   0     0    0     0 SW    2.1  0.0   0:30 nfsd
  413 root       9   0     0    0     0 SW    2.1  0.0   0:30 nfsd
  2:04pm  up  1:00,  1 user,  load average: 7.33, 8.19, 6.54
220 processes: 215 sleeping, 5 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 98.5% system,  0.2% nice,  1.0% idle
CPU1 states:  0.2% user, 99.2% system,  0.0% nice,  0.4% idle
CPU2 states:  0.1% user, 98.3% system,  0.3% nice,  1.0% idle
CPU3 states:  0.3% user, 98.3% system,  0.0% nice,  1.1% idle
Mem:  3924304K av, 3921476K used,    2828K free,       0K shrd,   97580K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3260192K
cached
;10m
m  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      19   0     0    0     0 RW   93.3  0.0   1:58 kswapd
    9 root       9   0     0    0     0 DW   37.9  0.0   5:10 kupdated
  552 root      17   0  1080 1080   768 R    36.0  0.0   1:40 top
  375 root       9   0     0    0     0 SW    4.0  0.0   0:30 nfsd
  381 root       9   0     0    0     0 SW    3.2  0.0   0:31 nfsd
  414 root       9   0     0    0     0 SW    3.1  0.0   0:31 nfsd
  308 root       9   0     0    0     0 SW    2.8  0.0   0:29 nfsd
  396 root       9   0     0    0     0 SW    2.8  0.0   0:29 nfsd
  314 root       9   0     0    0     0 SW    2.7  0.0   0:30 nfsd
  289 root       9   0     0    0     0 SW    2.5  0.0   0:30 nfsd
  317 root       9   0     0    0     0 SW    2.5  0.0   0:29 nfsd
  325 root       9   0     0    0     0 SW    2.5  0.0   0:31 nfsd
  342 root       9   0     0    0     0 SW    2.5  0.0   0:29 nfsd
  350 root       9   0     0    0     0 SW    2.5  0.0   0:30 nfsd
  374 root       9   0     0    0     0 SW    2.5  0.0   0:30 nfsd
  2:04pm  up  1:00,  1 user,  load average: 7.35, 8.17, 6.55
220 processes: 215 sleeping, 5 running, 0 zombie, 0 stopped
CPU0 states:  0.1% user, 98.5% system,  0.1% nice,  1.1% idle
CPU1 states:  0.5% user, 98.6% system,  0.0% nice,  0.6% idle
CPU2 states:  0.7% user, 98.1% system,  0.0% nice,  1.0% idle
CPU3 states:  0.4% user, 98.7% system,  0.2% nice,  0.4% idle
Mem:  3924304K av, 3921740K used,    2564K free,       0K shrd,   96768K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3261220K
cached
;10m
m  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      14   0     0    0     0 RW   99.9  0.0   2:07 kswapd
    9 root       9   0     0    0     0 DW   41.4  0.0   5:14 kupdated
  552 root      15   0  1080 1080   768 R    33.1  0.0   1:43 top
  391 root       9   0     0    0     0 SW    3.8  0.0   0:30 nfsd
  379 root       9   0     0    0     0 SW    3.5  0.0   0:30 nfsd
  394 root       9   0     0    0     0 SW    3.5  0.0   0:30 nfsd
  389 root       9   0     0    0     0 SW    3.4  0.0   0:31 nfsd
  412 root       9   0     0    0     0 SW    3.4  0.0   0:30 nfsd
  305 root       9   0     0    0     0 SW    3.1  0.0   0:30 nfsd
  366 root       9   0     0    0     0 SW    3.1  0.0   0:30 nfsd
  290 root       9   0     0    0     0 SW    2.9  0.0   0:30 nfsd
  309 root       9   0     0    0     0 SW    2.9  0.0   0:29 nfsd
  321 root       9   0     0    0     0 SW    2.9  0.0   0:30 nfsd
  330 root       9   0     0    0     0 SW    2.9  0.0   0:29 nfsd
  343 root       9   0     0    0     0 SW    2.9  0.0   0:29 nfsd
  2:04pm  up  1:00,  1 user,  load average: 7.75, 8.23, 6.58
220 processes: 214 sleeping, 6 running, 0 zombie, 0 stopped
CPU0 states:  0.2% user, 99.1% system,  0.2% nice,  0.3% idle
CPU1 states:  0.2% user, 98.5% system,  0.5% nice,  0.4% idle
CPU2 states:  0.0% user, 99.0% system,  0.5% nice,  0.3% idle
CPU3 states:  0.1% user, 98.4% system,  0.7% nice,  0.4% idle
Mem:  3924304K av, 3921660K used,    2644K free,       0K shrd,   95804K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3262244K
cached
;10m
m  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      16   0     0    0     0 RW   99.9  0.0   2:15 kswapd
  552 root      17   0  1080 1080   768 R    37.7  0.0   1:46 top
    9 root      11   0     0    0     0 DW   36.3  0.0   5:17 kupdated
  297 root       9   0     0    0     0 SW    3.3  0.0   0:29 nfsd
  334 root       9   0     0    0     0 RW    3.3  0.0   0:29 nfsd
  294 root       9   0     0    0     0 SW    3.2  0.0   0:30 nfsd
  299 root       9   0     0    0     0 DW    3.2  0.0   0:31 nfsd
  405 root      10   0     0    0     0 SW    3.2  0.0   0:30 nfsd
  289 root       9   0     0    0     0 SW    3.1  0.0   0:30 nfsd
  308 root       9   0     0    0     0 SW    3.1  0.0   0:30 nfsd
  361 root       9   0     0    0     0 SW    3.1  0.0   0:30 nfsd
  399 root       9   0     0    0     0 SW    3.1  0.0   0:31 nfsd
  288 root       9   0     0    0     0 SW    2.9  0.0   0:30 nfsd
  313 root       9   0     0    0     0 SW    2.8  0.0   0:29 nfsd
  358 root       9   0     0    0     0 SW    2.8  0.0   0:30 nfsd
  2:04pm  up  1:00,  1 user,  load average: 8.01, 8.28, 6.61
220 processes: 216 sleeping, 4 running, 0 zombie, 0 stopped
CPU0 states:  0.1% user, 99.3% system,  0.1% nice,  0.4% idle
CPU1 states:  0.0% user, 99.0% system,  0.0% nice,  0.9% idle
CPU2 states:  0.1% user, 99.2% system,  0.0% nice,  0.6% idle
CPU3 states:  0.5% user, 98.6% system,  0.0% nice,  0.8% idle
Mem:  3924304K av, 3921648K used,    2656K free,       0K shrd,   94628K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3263404K
cached
;10m
m  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      15   0     0    0     0 RW   89.5  0.0   2:24 kswapd
  552 root      18   0  1080 1080   768 R    41.3  0.0   1:50 top
    9 root      10   0     0    0     0 RW   28.2  0.0   5:19 kupdated
  404 root       9   0     0    0     0 SW    3.8  0.0   0:30 nfsd
  369 root       9   0     0    0     0 SW    3.6  0.0   0:31 nfsd
  392 root       9   0     0    0     0 SW    3.5  0.0   0:30 nfsd
  398 root       9   0     0    0     0 SW    3.2  0.0   0:30 nfsd
  380 root       9   0     0    0     0 SW    3.1  0.0   0:32 nfsd
  391 root       9   0     0    0     0 SW    3.1  0.0   0:31 nfsd
  367 root       9   0     0    0     0 SW    2.9  0.0   0:30 nfsd
  326 root       9   0     0    0     0 SW    2.8  0.0   0:31 nfsd
  414 root       9   0     0    0     0 SW    2.8  0.0   0:31 nfsd
  286 root      10   0     0    0     0 SW    2.6  0.0   0:29 nfsd
  342 root       9   0     0    0     0 SW    2.6  0.0   0:30 nfsd
  413 root       9   0     0    0     0 SW    2.6  0.0   0:30 nfsd
  2:04pm  up  1:00,  1 user,  load average: 8.01, 8.27, 6.62
220 processes: 213 sleeping, 7 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 99.3% system,  0.0% nice,  0.5% idle
CPU1 states:  0.0% user, 98.6% system,  0.0% nice,  1.1% idle
CPU2 states:  0.0% user, 99.4% system,  0.0% nice,  0.4% idle
CPU3 states:  1.7% user, 98.1% system,  0.2% nice,  0.6% idle
Mem:  3924304K av, 3921072K used,    3232K free,       0K shrd,   94140K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3263296K
cached
;10m
m  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      15   0     0    0     0 RW   99.9  0.0   2:33 kswapd
    9 root      14   0     0    0     0 RW   45.0  0.0   5:23 kupdated
  552 root      16   0  1080 1080   768 R    36.9  0.0   1:53 top
  360 root       9   0     0    0     0 DW    3.7  0.0   0:31 nfsd
  288 root       9   0     0    0     0 SW    3.5  0.0   0:30 nfsd
  308 root       9   0     0    0     0 SW    3.5  0.0   0:30 nfsd
  317 root      10   0     0    0     0 SW    3.5  0.0   0:30 nfsd
  389 root       9   0     0    0     0 SW    3.4  0.0   0:31 nfsd
  359 root       9   0     0    0     0 SW    3.3  0.0   0:31 nfsd
  396 root       9   0     0    0     0 SW    3.3  0.0   0:30 nfsd
  410 root       9   0     0    0     0 SW    3.0  0.0   0:30 nfsd
  306 root       9   0     0    0     0 SW    2.9  0.0   0:31 nfsd
  309 root       9   0     0    0     0 SW    2.9  0.0   0:30 nfsd
  323 root       9   0     0    0     0 SW    2.9  0.0   0:31 nfsd
  365 root       9   0     0    0     0 SW    2.9  0.0   0:31 nfsd

...and here's the final top screen

  2:49pm  up  1:45,  2 users,  load average: 8.98, 8.73, 8.01
222 processes: 219 sleeping, 3 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 48.4% system,  0.1% nice, 50.5% idle
CPU1 states:  0.2% user, 47.1% system,  0.0% nice, 52.1% idle
CPU2 states:  0.0% user, 49.1% system,  0.0% nice, 50.4% idle
CPU3 states:  0.0% user, 49.3% system,  0.1% nice, 50.1% idle
Mem:  3924304K av, 3676328K used,  247976K free,       0K shrd,   62212K
buff
Swap: 1043900K av,   21624K used, 1022276K free                 3255064K
cached
   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    9 root      18   0     0    0     0 DW   13.6  0.0  14:56 kupdated
  321 root      13   0     0    0     0 SW    3.3  0.0   1:06 nfsd
  552 root      13   0   976  920   664 R     2.7  0.0   6:53 top
  320 root      10   0     0    0     0 SW    2.5  0.0   1:08 nfsd
  361 root      10   0     0    0     0 SW    2.5  0.0   1:08 nfsd
  377 root      10   0     0    0     0 SW    2.5  0.0   1:08 nfsd
  293 root      10   0     0    0     0 SW    2.3  0.0   1:07 nfsd
  362 root       9   0     0    0     0 SW    2.3  0.0   1:08 nfsd
  386 root      10   0     0    0     0 SW    2.3  0.0   1:09 nfsd
  395 root      10   0     0    0     0 SW    2.3  0.0   1:08 nfsd
  402 root      10   0     0    0     0 SW    2.3  0.0   1:09 nfsd
  305 root      10   0     0    0     0 SW    2.1  0.0   1:06 nfsd
  316 root       9   0     0    0     0 SW    2.1  0.0   1:07 nfsd
  317 root      11   0     0    0     0 SW    2.1  0.0   1:08 nfsd
  348 root      10   0     0    0     0 SW    2.1  0.0   1:07 nfsd


