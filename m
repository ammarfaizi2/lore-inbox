Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274814AbRIUUPJ>; Fri, 21 Sep 2001 16:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274810AbRIUUOu>; Fri, 21 Sep 2001 16:14:50 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:17125 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S274814AbRIUUOk>;
	Fri, 21 Sep 2001 16:14:40 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C04728F82@xfc04.fc.hp.com>
From: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
To: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: major VM suckage with 2.4.10pre12 and 2.4.10pre13 and highmem, we
	 will help test
Date: Fri, 21 Sep 2001 16:15:01 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.10pre13 did not help our NFS SPEC testing on a machine with 4GB
RAM.  Refer to my previous message about those results:
http://lists.insecure.org/linux-kernel/2001/Sep/3036.html

In a nutshell, kswapd starts grabbing 99% of the CPU for long stretches in
time, which causes us to drop NFS RPC connections, which causes performance
to suck.

We have access to a few machines with lots of memory (4-8GB), and we are
more than willing to test any patches the community can provide to help
solve this problem.  It appears that some of the VM coders don't have access
to highmem machines.  We can help you if you let us.

We hoped that the following patch would help with the 0-order allocation
failure message that we see, but we discovered that it has been included in
2.4.10-pre13: http://lists.insecure.org/linux-kernel/2001/Sep/3044.html
Sep 21 12:48:10 catdog1 kernel: __alloc_pages: 3-order allocation failed
(gfp=0x20/0) from c012e1e2
Sep 21 12:48:10 catdog1 kernel: __alloc_pages: 3-order allocation failed
(gfp=0x20/0) from c012e1e2
Sep 21 12:48:10 catdog1 kernel: __alloc_pages: 2-order allocation failed
(gfp=0x20/0) from c012e1e2
Sep 21 12:48:10 catdog1 kernel: __alloc_pages: 3-order allocation failed
(gfp=0x20/0) from c012e1e2
Sep 21 12:48:10 catdog1 kernel: __alloc_pages: 3-order allocation failed
(gfp=0x20/0) from c012e1e2
Sep 21 12:48:10 catdog1 kernel: __alloc_pages: 2-order allocation failed
(gfp=0x20/0) from c012e1e2
Sep 21 12:48:10 catdog1 kernel: __alloc_pages: 1-order allocation failed
(gfp=0x20/0) from c012e1e2
Sep 21 12:48:10 catdog1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0x20/0) from c012e1e2

(there's plenty more where these came from on the 2.4.10-pre13 run)

Hardware:
- 4 processors, 4GB ram
- 45 fibre channel drives, set up in hardware RAID 0/1
- 2 direct Gigabit Ethernet connections between SPEC SFS prime client and
system under test
- reiserfs
- all NFS filesystems exported with sync,no_wdelay to insure O_SYNC writes
to storage
- NFS v3 UDP
- LVM
- linux-2.4.10-pre13

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

SPEC results before 2.4.10-pre13 test stopped:
            500     600     1.2   180047  300 3 U    5070624   1 48  2  2
2.0
           1000     992     1.4   297584  300 3 U   10141248   1 48  2  2
2.0
INVALID    1500     637    32.5   190544  299 3 U   15210624   1 48  2  2
2.0

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

The top screens from interesting parts of the latest NFS test are included
below.  I'm willing to try any patches (or measurement tools, within reason)
anyone wants to provide to solve this problem.

Erik Habbinga
Hewlett Packard

12:33pm  up 48 min,  2 users,  load average: 8.59, 6.52, 4.77
220 processes: 218 sleeping, 2 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 80.5% system,  0.1% nice, 18.4% idle
CPU1 states:  0.0% user, 83.3% system,  0.0% nice, 16.1% idle
CPU2 states:  0.2% user, 80.5% system,  0.2% nice, 18.1% idle
CPU3 states:  0.0% user, 79.4% system,  0.0% nice, 20.1% idle
Mem:  3924176K av, 3918500K used,    5676K free,       0K shrd,   96220K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3322056K
cached
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      19   0     0    0     0 SW   53.1  0.0   0:54 kswapd
    9 root      12   0     0    0     0 DW   30.3  0.0   3:48 kupdated
  320 root      10   0     0    0     0 SW    7.0  0.0   0:24 nfsd
  335 root       9   0     0    0     0 SW    5.3  0.0   0:24 nfsd
  352 root       9   0     0    0     0 SW    4.8  0.0   0:23 nfsd
  554 root      17   0  1080 1080   768 R     4.8  0.0   1:12 top
  392 root       9   0     0    0     0 SW    4.6  0.0   0:24 nfsd
  391 root       9   0     0    0     0 SW    4.4  0.0   0:25 nfsd
  325 root       9   0     0    0     0 DW    4.0  0.0   0:24 nfsd
  359 root       9   0     0    0     0 SW    3.7  0.0   0:24 nfsd
  293 root       9   0     0    0     0 SW    3.5  0.0   0:25 nfsd
  361 root       9   0     0    0     0 SW    3.5  0.0   0:23 nfsd
  374 root       9   0     0    0     0 SW    3.5  0.0   0:24 nfsd
  327 root      10   0     0    0     0 SW    3.1  0.0   0:23 nfsd
  388 root       9   0     0    0     0 SW    3.1  0.0   0:23 nfsd
 12:33pm  up 48 min,  2 users,  load average: 8.39, 6.51, 4.78
220 processes: 217 sleeping, 3 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 81.2% system,  0.0% nice, 18.3% idle
CPU1 states:  0.0% user, 82.3% system,  0.1% nice, 17.0% idle
CPU2 states:  0.0% user, 86.0% system,  0.0% nice, 13.5% idle
CPU3 states:  0.2% user, 86.2% system,  0.0% nice, 13.1% idle
Mem:  3924176K av, 3918436K used,    5740K free,       0K shrd,   96396K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3321192K
cached
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      17   0     0    0     0 RW   56.3  0.0   0:57 kswapd
    9 root       9   0     0    0     0 DW   25.1  0.0   3:50 kupdated
  294 root       9   0     0    0     0 SW    5.6  0.0   0:24 nfsd
  303 root       9   0     0    0     0 SW    4.5  0.0   0:24 nfsd
  334 root       9   0     0    0     0 SW    4.3  0.0   0:23 nfsd
  312 root       9   0     0    0     0 SW    4.1  0.0   0:25 nfsd
  308 root       9   0     0    0     0 SW    3.9  0.0   0:24 nfsd
  403 root       9   0     0    0     0 SW    3.9  0.0   0:24 nfsd
  554 root      15   0  1080 1080   768 R     3.9  0.0   1:12 top
  302 root       9   0     0    0     0 SW    3.7  0.0   0:24 nfsd
  412 root       9   0     0    0     0 SW    3.7  0.0   0:23 nfsd
  310 root       9   0     0    0     0 SW    3.6  0.0   0:24 nfsd
  404 root       9   0     0    0     0 SW    3.6  0.0   0:24 nfsd
  340 root       9   0     0    0     0 SW    3.4  0.0   0:24 nfsd
  295 root       9   0     0    0     0 SW    3.2  0.0   0:24 nfsd
12:33pm  up 48 min,  2 users,  load average: 8.68, 6.60, 4.81
220 processes: 214 sleeping, 6 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 94.0% system,  0.1% nice,  5.5% idle
CPU1 states:  0.0% user, 94.0% system,  0.2% nice,  5.4% idle
CPU2 states:  0.0% user, 94.0% system,  0.0% nice,  5.6% idle
CPU3 states:  0.1% user, 93.4% system,  0.0% nice,  6.1% idle
Mem:  3924176K av, 3919232K used,    4944K free,       0K shrd,   96472K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3321548K
cached
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      15   0     0    0     0 RW   59.6  0.0   1:01 kswapd
    9 root      12   0     0    0     0 DW   22.5  0.0   3:51 kupdated
  554 root      12   0  1080 1080   768 R    19.4  0.0   1:14 top
  325 root       9   0     0    0     0 SW    4.3  0.0   0:25 nfsd
  361 root       9   0     0    0     0 SW    4.1  0.0   0:24 nfsd
  336 root       9   0     0    0     0 DW    3.8  0.0   0:24 nfsd
  394 root       9   0     0    0     0 SW    3.6  0.0   0:24 nfsd
  302 root       9   0     0    0     0 SW    3.4  0.0   0:25 nfsd
  370 root       9   0     0    0     0 SW    3.4  0.0   0:24 nfsd
  311 root      10   0     0    0     0 SW    3.3  0.0   0:24 nfsd
  412 root       9   0     0    0     0 SW    3.3  0.0   0:23 nfsd
  368 root       9   0     0    0     0 SW    3.1  0.0   0:24 nfsd
  371 root       9   0     0    0     0 SW    3.1  0.0   0:25 nfsd
  375 root       9   0     0    0     0 SW    3.1  0.0   0:24 nfsd
  397 root       9   0     0    0     0 SW    3.1  0.0   0:24 nfsd
12:33pm  up 48 min,  2 users,  load average: 8.87, 6.71, 4.87
220 processes: 215 sleeping, 5 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 94.6% system,  0.1% nice,  5.0% idle
CPU1 states:  0.0% user, 94.1% system,  0.0% nice,  5.6% idle
CPU2 states:  0.0% user, 93.5% system,  0.4% nice,  5.5% idle
CPU3 states:  1.4% user, 93.4% system,  0.0% nice,  4.5% idle
Mem:  3924176K av, 3919148K used,    5028K free,       0K shrd,   96268K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3321116K
cached
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      14   0     0    0     0 RW   81.3  0.0   1:07 kswapd
  554 root      18   0  1080 1080   768 R    23.8  0.0   1:15 top
    9 root       9   0     0    0     0 DW   22.0  0.0   3:53 kupdated
  326 root       9   0     0    0     0 SW    4.6  0.0   0:23 nfsd
  351 root      10   0     0    0     0 SW    4.3  0.0   0:24 nfsd
  374 root       9   0     0    0     0 SW    4.3  0.0   0:25 nfsd
  289 root       9   0     0    0     0 SW    4.2  0.0   0:24 nfsd
  331 root       9   0     0    0     0 RW    3.7  0.0   0:25 nfsd
  406 root       9   0     0    0     0 SW    3.7  0.0   0:25 nfsd
  397 root       9   0     0    0     0 SW    3.5  0.0   0:25 nfsd
  332 root       9   0     0    0     0 SW    3.4  0.0   0:24 nfsd
  353 root       9   0     0    0     0 SW    3.3  0.0   0:25 nfsd
  346 root       9   0     0    0     0 SW    3.1  0.0   0:25 nfsd
  402 root       9   0     0    0     0 SW    3.1  0.0   0:25 nfsd
  412 root      10   0     0    0     0 SW    3.1  0.0   0:24 nfsd
12:33pm  up 49 min,  2 users,  load average: 8.88, 6.75, 4.89
220 processes: 214 sleeping, 6 running, 0 zombie, 0 stopped
CPU0 states:  0.1% user, 98.3% system,  0.3% nice,  0.6% idle
CPU1 states:  0.0% user, 98.1% system,  0.0% nice,  1.5% idle
CPU2 states:  0.0% user, 99.1% system,  0.0% nice,  0.5% idle
CPU3 states:  0.0% user, 97.3% system,  0.1% nice,  2.2% idle
Mem:  3924176K av, 3918888K used,    5288K free,       0K shrd,   96076K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3320648K
cached
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      18   0     0    0     0 RW   99.9  0.0   1:14 kswapd
    9 root       9   0     0    0     0 RW   18.0  0.0   3:54 kupdated
  554 root      19   0  1080 1080   768 R    17.6  0.0   1:17 top
  410 root       9   0     0    0     0 SW    3.8  0.0   0:24 nfsd
  289 root       9   0     0    0     0 SW    3.7  0.0   0:24 nfsd
  295 root       9   0     0    0     0 DW    3.7  0.0   0:24 nfsd
  342 root       9   0     0    0     0 SW    3.7  0.0   0:24 nfsd
  401 root       9   0     0    0     0 SW    3.7  0.0   0:24 nfsd
  369 root       9   0     0    0     0 SW    3.5  0.0   0:25 nfsd
  396 root       9   0     0    0     0 SW    3.5  0.0   0:24 nfsd
  322 root       9   0     0    0     0 SW    3.4  0.0   0:24 nfsd
  361 root       9   0     0    0     0 SW    3.2  0.0   0:24 nfsd
  291 root       9   0     0    0     0 SW    3.1  0.0   0:25 nfsd
  301 root       9   0     0    0     0 SW    3.1  0.0   0:24 nfsd
  318 root       9   0     0    0     0 SW    3.1  0.0   0:24 nfsd
12:33pm  up 49 min,  2 users,  load average: 8.73, 6.75, 4.90
220 processes: 216 sleeping, 4 running, 0 zombie, 0 stopped
CPU0 states:  0.1% user, 99.1% system,  0.1% nice,  0.3% idle
CPU1 states:  2.0% user, 97.4% system,  0.1% nice,  0.1% idle
CPU2 states:  0.1% user, 99.4% system,  0.0% nice,  0.1% idle
CPU3 states:  0.0% user, 99.5% system,  0.1% nice,  0.0% idle
Mem:  3924176K av, 3919156K used,    5020K free,       0K shrd,   96028K
buff
Swap: 1043900K av,       0K used, 1043900K free                 3320772K
cached
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    7 root      17   0     0    0     0 RW   99.9  0.0   1:21 kswapd
    9 root       9   0     0    0     0 DW   24.3  0.0   3:56 kupdated
  554 root      19   0  1080 1080   768 R    17.3  0.0   1:18 top
  388 root       9   0     0    0     0 SW    4.9  0.0   0:24 nfsd
  415 root       9   0     0    0     0 SW    4.9  0.0   0:25 nfsd
  381 root       9   0     0    0     0 SW    4.7  0.0   0:24 nfsd
  398 root       9   0     0    0     0 DW    4.3  0.0   0:24 nfsd
  396 root       9   0     0    0     0 SW    4.1  0.0   0:25 nfsd
  341 root       9   0     0    0     0 SW    4.0  0.0   0:25 nfsd
  401 root       9   0     0    0     0 SW    4.0  0.0   0:25 nfsd
  294 root       9   0     0    0     0 SW    3.8  0.0   0:25 nfsd
  347 root       9   0     0    0     0 SW    3.2  0.0   0:25 nfsd
  352 root       9   0     0    0     0 SW    3.2  0.0   0:24 nfsd
  303 root       9   0     0    0     0 SW    3.1  0.0   0:24 nfsd
  402 root       9   0     0    0     0 SW    3.1  0.0   0:25 nfsd

...and this contiues for quite awhile...
