Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbUKOTsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUKOTsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 14:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUKOTsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 14:48:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15767 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261667AbUKOTsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:48:08 -0500
Date: Mon, 15 Nov 2004 14:47:46 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] SELinux scalability and analysis patches.
Message-ID: <Xine.LNX.4.44.0411151431090.21180-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset improves the scalability of SELinux by replacing
the global avc_lock with an RCU based scheme by Kaigai Kohei.  The size of
the cache is made tunable, to allow administrators to tune systems for
different workloads, while statistics are exported via selinuxfs to allow
AVC performance to be monitored at a low level.

This code has been extensively tested and benchmarked (see benchmark 
results below).  Baseline performance is not improved, although it is 
clear that dramatic scalability improvements are achieved.

Baseline performance and networking scalability are areas where work is 
ongoing (in particular, we need to add caching of some network security 
objects so that we don't fallback to policy database lookups on each 
permission call).


- James
-- 
James Morris
<jmorris@redhat.com>


Benchmark results:

===============================================================================================

System: 4 node 16-way IA64 NUMA

- 'Stream' is based on http://www.cs.virginia.edu/stream/ , HPC memory bandwidth test,
  higher result is better.
- Hackbench: scheduler scalability benchmark by Rusty, lower is better.

Standard kernel:
  2.6.9-1.648_EL  SELINUX=0 : Stream 6159.987MB/s HackBench 53.144
  2.6.9-1.648_EL  SELINUX=1 : Stream 5872.529MB/s HackBench 1043.132
  
Kernel with RCU/AVC patches:
  2.6.9-1.689_avcrcu.root SELINUX=0 : Stream 8829.647MB/s HackBench 53.976
  2.6.9-1.689_avcrcu.root SELINUX=1 : Stream 8817.117MB/s HackBench 50.975

===============================================================================================

System: 8-way PIII 900Mhz Xeon with 9GB RAM
Fileystem: ext2 for all testing.

Notes:
    AVC was reset before tests, so avc was flushed.
    System was run in enforcing mode.

Key:
    std-nolsm:      standard kernel with LSM disabled
    std-lsmcap:     standard kernel with LSM enabled, capabilities LSM
    std-sel-strict: standard kernel with SELinux enabled, capabilities secondary LSM
    rcu-sel-strict: as above with RCU & AVC stats patches

---------------------------------------------------------------------------------------
Dbench
---------------------------------------------------------------------------------------
Notes:
  100 iterations each, results are throughput in MB/sec (bigger is better)

----------------------------------------------------------------
# Clients		1	2	4	8
----------------------------------------------------------------
std-nolsm		151.1	270.3	460.4	699.0
std-lsmcap		152.6	273.3	465.4	703.5
std-sel-strict		142.4	254.5	428.1	598.5
rcu-sel-strict		143.3	261.0	437.1	680.7
----------------------------------------------------------------

---------------------------------------------------------------------------------------
Unixbench
---------------------------------------------------------------------------------------
Notes:
  Run with parameters '-10 index'.
  Overall score is an index, higher is better.
  

std-nolsm		328.0
std-lsmcap		327.9
std-sel-strict		311.1
rcu-sel-strict		305.9

---------------------------------------------------------------------------------------
Apachebench
---------------------------------------------------------------------------------------

Notes:
  Loopback, httpd logging to /dev/null.
  Client and server on same system (hence peaking before 8 clients).
  Document size is 500kB, 20,000 requests.
  Values are transfer rate in Kb/s received: bigger is better.

---------------------------------------------------------------------------------
Concurrency Level	1		2		4		8
---------------------------------------------------------------------------------
std-nolsm		43083.26	49740.85	48657.74	47913.67
std-lsmcap		43888.87	48943.08	49475.39	48657.81
std-sel-strict		33551.52	35082.17	34854.14	34363.09
rcu-sel-strict		33118.51	36509.20	36621.59	35903.92
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
Webstone
---------------------------------------------------------------------------------------

Notes:
  Two physical clients, each via private GigE links.
  Result is total server throughput in Mb/s (bigger is better).
  1 iteration for two minutes.
  
----------------------------------------------------------------
# Clients		2	4	8	16	32
----------------------------------------------------------------
std-nolsm		67.79	284.43	374.35	420.09	427.09
std-lsmcap		67.79	298.15	373.50	420.84	431.80
std-sel-strict		78.42	272.48	345.99	378.81	376.30
rcu-sel-strict		77.53	268.91	348.65	390.76	391.35
----------------------------------------------------------------

===============================================================================================

Testing by KaiGai on a 32-way system during development:
---------------------------------------------------------

The following three benchmark programs were used.
* parallel write() system call (my original)
  - The results of 2.6.9.RCU scale linearly as 2.6.9(disable)
* dbench
  - The results of 2.6.9.RCU are almost same as 2.6.9(disable).
    The performance turned down in 32CPU, but I think it's a
    problem with dbench. (I'm not so fine about dbench configuration :( )
* UNIX bench(micro benchmark)
  - 2.6.9.RCU doesn't have a significant degration toward 2.6.9(enable)
These are as expected.

The raw results:
---- write() system call [Kcalls/sec] ---------------------
Num of CPUs     -1CPU- -2CPU- -4CPU- -8CPU- -16CPU- -32CPU-
2.6.9(disable)   773.6 1611.4 3160.5 6301.0 12605.0 24296.4
2.6.9(enable)    535.8  655.8  241.8  127.7    62.9    30.2
2.6.9.RCU        542.5 1042.9 2301.6 4518.0  8963.5 18033.6
-----------------------------------------------------------

---- dbench Through-put [MB/sec] --------------------------
Num of CPUs     -1CPU- -2CPU- -4CPU- -8CPU- -16CPU- -32CPU-
2.6.9(disable)   286.7  556.9 1056.0 1572.1  1663.1   395.5
2.6.9(enable)    268.7  500.5  771.4  381.3   164.3    84.2
2.6.9.RCU        270.0  524.2  994.8 1511.3  1489.5   386.9
-----------------------------------------------------------

---- UNIX bench Results [Index value] ---------------------
                     2.6.9(disable) 2.6.9(enable) 2.6.9.RCU
Dhrystone 2                   275.8       275.8       275.8
D-P Whetstone                  97.5        97.5        97.5
Execl Throughput              408.9       398.3       397.5
File Copy 1KB x  2000 blks    604.2       520.4       517.5
File Copy 256B x  500 blks    510.9       414.8       415.1
File Copy 4KB x  8000 blks    980.4       893.5       878.2
Pipe Throughput               510.4       403.5       396.9
Process Creation              253.5       251.2       249.7
Shell Scripts(8 concurrent)  1190.5      1165.0      1182.2
System Call Overhead          468.7       469.9       469.0
-----------------------------------------------------------
     FINAL SCORE              434.6       403.6       402.2


===============================================================================================

