Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268944AbTBSQEg>; Wed, 19 Feb 2003 11:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268942AbTBSQEg>; Wed, 19 Feb 2003 11:04:36 -0500
Received: from pinguin13.kwc.at ([193.228.81.158]:2798 "EHLO
	mail.hello-penguin.com") by vger.kernel.org with ESMTP
	id <S268944AbTBSQEd>; Wed, 19 Feb 2003 11:04:33 -0500
Date: Wed, 19 Feb 2003 17:14:32 +0100
From: Dejan Muhamedagic <dejan@hello-penguin.com>
To: linux-kernel@vger.kernel.org
Subject: vm issues on sap app server
Message-ID: <20030219171432.A6059@smp.colors.kwc>
Reply-To: Dejan Muhamedagic <dejan@hello-penguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 10 13 15 16 26 36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

We're running here a couple of 4-way intel boxes each with
6GB of memory and a SCSI RAID.  The sole purpose is to run
SAP applications (SAP app servers).  Basically, it's 30-40
processes accepting connections from ~150 SAP users and
making queries/updates to a DB server.  These processes are
long lived and may swallow quite a bit of memory.  The
standard estimate is ~30MB per user.

Currently, one box is running 2.4.20aa1 kernel and the other
2.4.20 with rmap15d and a bunch of NFS patches applied.
We're not entirely happy with either VM though the SAP
statistics show that both machines have acceptable response
times.

Both servers swap constantly, but the 2.4.20aa1 at a 10-fold
higher rate.  OTOH, there should be enough memory for
everything.  It seems like both VMs have preference for
cache.  Is it possible to reduce the amount of memory used
for cache?

The worst situation is when there's a high io load.  For
example, a file transfer over the Gb i/f (~40MBps) makes
almost all SAP processes stuck in the D state for some time
even making some SAP jobs fail due to high timeouts.  It
looks like the VM wants to fill the cache and starts to swap
more at the same time.  So we have to do big file transfers
when there's no SAP activity.  The machine also suffers
badly during backup.

Finally, there's a third SAP app server, an RS6000 running
AIX with the same amount of memory, which seems to be more
stable under various loads.

Anybody with advice on how to get Linux behave better?

I will paste here excerpts from vmstat and sysstat
(sar), which seemed to be representative, as well as other
relevant data.

Cheers!

Dejan

P.S. Please CC to me because I'm not subscribed to the list.

CPU and cache (hyperthreading enabled)

<6>CPU: L1 I cache: 0K, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>CPU: L3 cache: 1024K
<4>CPU0: Intel(R) XEON(TM) MP CPU 1.90GHz stepping 02

mem output (2.4.20aa1)

        total:    used:    free:  shared: buffers:  cached:
Mem:  6341193728 6131351552 209842176        0 29294592 5348958208
Swap: 12582862848 5425111040 7157751808
MemTotal:      6192572 kB
MemFree:        204924 kB
MemShared:           0 kB
Buffers:         28608 kB
Cached:        1982164 kB
SwapCached:    3241428 kB
Active:         831176 kB
Inactive:      4923396 kB
HighTotal:     5358496 kB
HighFree:         6040 kB
LowTotal:       834076 kB
LowFree:        198884 kB
SwapTotal:    12287952 kB
SwapFree:      6989992 kB
BigFree:             0 kB

mem output (2.4.20rmap)

        total:    used:    free:  shared: buffers:  cached:
Mem:  6321442816 6175191040 146251776        0 20500480 5473546240
Swap: 12582862848 2317144064 10265718784
MemTotal:      6173284 kB
MemFree:        142824 kB
MemShared:           0 kB
Buffers:         20020 kB
Cached:        4310704 kB
SwapCached:    1034556 kB
Active:        4752500 kB
ActiveAnon:    4057072 kB
ActiveCache:    695428 kB
Inact_dirty:         0 kB
Inact_laundry:  898608 kB
Inact_clean:    147680 kB
Inact_target:  1159756 kB
HighTotal:     5358496 kB
HighFree:        70400 kB
LowTotal:       814788 kB
LowFree:         72424 kB
SwapTotal:    12287952 kB
SwapFree:     10025116 kB

vmstat (2.4.20aa1)

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  5  0 5109180 202528  23508 2169176 1031 1035  1031  1035 4180  4728  11   1  88
 0  0  0 5108716 202384  23536 2169644 746 424   746   433 1200  1267   5   1  94
 0  0  0 5107060 201988  23524 2171300 791 362   791   378 1581  1831   4   1  96
 2  0  0 5107328 203968  23556 2171032 1585 1091  1585  1109 3689  4407  14  14  72
 0  0  0 5104392 204792  23600 2173968   0   0     0    14 1889  2214   4   1  95

vmstat (2.4.20rmap)

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0 1957348  21888  11092 4599932   3 105     3   105  386   315   1   0  99
 0  0  0 1957020  21244  11092 4600304  57 154    57   154  723   866   3   1  96
 2  0  1 1956784  18336  11092 4600540  27 102    27   102  480   461   1   1  98
 2  0  0 1957088  19572  11156 4600308  11 154    11   184  573   598   8   7  85
 0  0  0 1957080  19108  11252 4600320   2 194     2   227  474   525   5   5  90

sar averages (2.4.20aa1)

16:40:00     pgpgin/s pgpgout/s  activepg  inadtypg  inaclnpg  inatarpg
Average:       973.83    326.41    206077         0         0         0

16:40:00     pswpin/s pswpout/s
Average:       171.72     76.47

16:40:00    kbmemfree kbmemused  %memused kbmemshrd kbbuffers  kbcached kbswpfree kbswpused  %swpused
Average:       226761   5965811     96.34         0     70942   2551248   7429293   4858659     39.54

sar averages (2.4.20rmap)

15:50:00     pgpgin/s pgpgout/s  activepg  inadtypg  inaclnpg  inatarpg
Average:        75.94    120.10   1217300    109160     38560    296729

15:50:00     pswpin/s pswpout/s
Average:        16.68     26.29

15:50:00    kbmemfree kbmemused  %memused kbmemshrd kbbuffers  kbcached kbswpfree kbswpused  %swpused
Average:        14025   6159259     99.77         0     16786   4682172  10386017 -10299677    4962552.26
