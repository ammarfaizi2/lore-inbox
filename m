Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268276AbTCCB7p>; Sun, 2 Mar 2003 20:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268281AbTCCB7p>; Sun, 2 Mar 2003 20:59:45 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:52651 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S268276AbTCCB7k>; Sun, 2 Mar 2003 20:59:40 -0500
Date: Sun, 2 Mar 2003 21:15:46 -0500
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com
Subject: 2.5.63-mjb2 (scalability / NUMA patchset)
Message-ID: <20030303021546.GA4322@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd be very interested in feedback from anyone willing to test on any
> platform, however large or small.

The objrmap patch in recent mjb and mm makes the autoconf-2.52 build (fork)
a few percent faster on uniprocessor K6/2 475 Mhz with 384 MB ram:

1205 seconds 2.5.63-mjb1
1216 seconds 2.5.63-mjb1
1219 seconds 2.5.63-mjb2
1226 seconds 2.5.63-mjb1
1238 seconds 2.5.63-mjb2
1266 seconds 2.5.63-mm1-dline
1267 seconds 2.5.63-mm1-dline
1279 seconds 2.5.63-mm1-dline
1297 seconds 2.5.63
1301 seconds 2.5.63
1309 seconds 2.5.63


The mjb patchset has a HZ=100 option that gives about 1.1% to several tests.
Note the 2.4 kernel and 2.5 with HZ=100 give very similar result:

 kernel                   Tower of Hanoi (unixbench)
 2.5.63-mjb1                     14156.4 (higher is better)
 2.5.63-mjb2                     14156.4
 2.4.21-pre3aa1                  14153.1
 2.5.63                          14002.1
 2.5.63-mm1-dline                14000.2
 2.5.62-mm3                      13999.9

Almost all of the unixbench metrics are a little better with mjb2:

kernel          C Compiler Throughput   Execl Throughput   Copy 1024 bufsize
2.5.63-mjb2                     190.0              368.1              6348.0
2.5.63                          180.7              366.4              6108.0

kernel          Copy 4096 bufsize 	Read 1024 bufsize
2.5.63-mjb2               6391.0             15636.0
2.5.63                    6308.0             14872.0

kernel          Read 4096 bufsize	Write 512 bufsize
2.5.63-mjb2               15775.0             20833.0
2.5.63                    14676.0             20833.0

kernel          Piped Context Switching   Shell Scripts (1)   Shell Scripts (16)   Shell Scripts (64)
2.5.63-mjb2                     73785.0               506.3                 34.0                  8.0
2.5.63                          77893.2               483.4                 32.7                  7.7

kernel          System Call Overhead 
2.5.63-mjb2                 232773.2
2.5.63                      231530.5


LMbench memory latency is a little over 1% lower on kernels with HZ=100:

 Memory latencies in nanoseconds - smaller is better
 ---------------------------------------------------
 kernel                          Mhz     L1 $     L2 $    Main mem
 -----------------------------  -----  -------  -------  ---------
 2.5.63-mjb1                      476     4.20   192.47      262.2
 2.4.21-pre3-ac4                  476     4.20   193.96      262.2
 2.4.21-pre3aa1                   476     4.20   197.31      261.9
 2.5.63-mjb2                      476     4.20   199.25      262.2
 2.5.63-mm1-dline                 476     4.25   195.99      266.5
 2.5.63                           476     4.25   200.82      266.9
 2.5.62-mm3                       476     4.25   204.81      266.7

Several other lmbench tests have approximately 1% improvement.

 AIM7 compute workload was about 1.9% faster with mjb2 compared
to 2.5.63:

 kernel                   Tasks   Jobs/Min         Real    CPU   
 2.4.21-pre3-ac4          384    325.4            7151.7  7129.3
 2.4.21-pre3aa1           384    323.8            7187.6  7160.3
 2.5.63-mjb2              384    322.8            7207.9  7180.6
 2.5.63                   384    319.4            7286.1  7255.7
 2.5.63-mjb1              384    318.6            7303.7  7169.7
 2.5.63-mm1-dline         384    318.0            7318.9  7289.4

On the AIM7 database test, mjb2 looks good compared to the other
2.5.63 kernels.  Recent 2.4 kernels have an edge here as the 
number of tasks goes up, though there is no measurement of 
fairness or interactive usability in this test.

 AIM7 dbase workload
 kernel                   Tasks   Jobs/Min          Real    CPU 
 2.4.21-pre3aa1           4      43.1              551.7   117.1
 2.4.21-pre3-ac4          4      43.1              551.8   116.5
 2.4.21-pre3              4      43.0              552.1   114.6
 2.5.63-mjb2              4      41.8              567.8   124.2
 2.5.63-mm1-dline         4      41.4              574.4   124.8
 2.5.63-mjb1              4      41.2              576.8   122.3
 2.5.63                   4      39.8              597.1   124.4
                                                  
 2.4.21-pre3              8      74.7              636.6   203.1
 2.4.21-pre3-ac4          8      74.3              639.4   203.5
 2.4.21-pre3aa1           8      73.5              646.1   201.5
 2.5.63-mjb2              8      67.9              699.8   212.6
 2.5.63-mjb1              8      67.5              704.3   209.4
 2.5.63-mm1-dline         8      67.0              709.1   208.6
 2.5.63                   8      67.0              709.4   212.0
                                                  
 2.4.21-pre3aa1           12     100.3             710.8   287.1
 2.4.21-pre3              12     97.8              728.7   289.0
 2.4.21-pre3-ac4          12     97.4              731.6   286.8
 2.5.63-mjb2              12     85.0              838.1   302.2
 2.5.63-mm1-dline         12     84.5              843.5   298.1
 2.5.63-mjb1              12     83.8              850.6   292.2
 2.5.63                   12     81.6              873.3   296.0
                                                  
 2.4.21-pre3aa1           16     118.5             801.8   367.4
 2.4.21-pre3-ac4          16     115.9             819.7   371.1
 2.4.21-pre3              16     115.8             821.0   377.1
 2.5.63-mjb2              16     97.7              972.6   386.6
 2.5.63-mm1-dline         16     97.7              972.9   383.0
 2.5.63-mjb1              16     96.7              983.2   376.1
 2.5.63                   16     96.1              989.1   381.3


--
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

