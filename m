Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbSLIIYV>; Mon, 9 Dec 2002 03:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSLIIYV>; Mon, 9 Dec 2002 03:24:21 -0500
Received: from tenax.loup.net ([65.169.6.40]:11884 "EHLO tenax.loup.net")
	by vger.kernel.org with ESMTP id <S264644AbSLIIYS>;
	Mon, 9 Dec 2002 03:24:18 -0500
Date: Mon, 9 Dec 2002 01:30:28 -0700
Message-Id: <200212090830.gB98USW05593@flux.loup.net>
From: Mike Hayward <hayward@loup.net>
To: linux-kernel@vger.kernel.org
Subject: Intel P6 vs P7 system call performance
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been benchmarking Pentium 4 boxes against my Pentium III laptop
with the exact same kernel and executables as well as custom compiled
kernels.  The Pentium III has a much lower clock rate and I have
noticed that system call performance (and hence io performance) is up
to an order of magnitude higher on my Pentium III laptop.  1k block IO
reads/writes are anemic on the Pentium 4, for example, so I'm trying
to figure out why and thought someone might have an idea.

Notice below that the System Call overhead is much higher on the
Pentium 4 even though the cpu runs more than twice the speed and the
system has DDRAM, a 400 Mhz FSB, etc.  I even get pretty remarkable
syscall/io performance on my Pentium III laptop vs. an otherwise idle
dual Xeon.

See how the performance is nearly opposite of what one would expect:

----------------------------------------------------------------------
basic sys call performance iterated for 10 secs:

        while (1) {
                close(dup(0));
                getpid();
                getuid();
                umask(022);
                iter++;
        }

M-Pentium III 850Mhz Sys Call Rate   433741.8
  Pentium 4     2Ghz Sys Call Rate   233637.8
  Xeon x 2    2.4Ghz Sys Call Rate   207684.2

----------------------------------------------------------------------
1k read sys calls iterated for 10 secs (all buffered reads, no disk):

M-Pentium III 850Mhz File Read      1492961.0 (~149 io/s)
  Pentium 4     2Ghz File Read      1088629.0 (~108 io/s)
  Xeon x 2    2.4Ghz File Read       686892.0 (~ 69 io/s)

Any ideas?  Not sure I want to upgrade to the P7 architecture if this
is right, since for me system calls are probably more important than
raw cpu computational power.

- Mike

--- Mobile Pentium III 850 Mhz ---

  BYTE UNIX Benchmarks (Version 3.11)
  System -- Linux flux.loup.net 2.4.7-10 #1 Thu Sep 6 17:27:27 EDT 2001 i686 unknown
  Start Benchmark Run: Thu Nov  8 07:55:04 PST 2001
   1 interactive users.
Dhrystone 2 without register variables   1652556.1 lps   (10 secs, 6 samples)
Dhrystone 2 using register variables     1513809.2 lps   (10 secs, 6 samples)
Arithmetic Test (type = arithoh)         3770106.2 lps   (10 secs, 6 samples)
Arithmetic Test (type = register)        230897.5 lps   (10 secs, 6 samples)
Arithmetic Test (type = short)           230586.1 lps   (10 secs, 6 samples)
Arithmetic Test (type = int)             230916.2 lps   (10 secs, 6 samples)
Arithmetic Test (type = long)            232229.7 lps   (10 secs, 6 samples)
Arithmetic Test (type = float)           222990.2 lps   (10 secs, 6 samples)
Arithmetic Test (type = double)          224339.4 lps   (10 secs, 6 samples)
System Call Overhead Test                433741.8 lps   (10 secs, 6 samples)
Pipe Throughput Test                     499465.5 lps   (10 secs, 6 samples)
Pipe-based Context Switching Test        229029.2 lps   (10 secs, 6 samples)
Process Creation Test                      8696.6 lps   (10 secs, 6 samples)
Execl Throughput Test                      1089.8 lps   (9 secs, 6 samples)
File Read  (10 seconds)                  1492961.0 KBps  (10 secs, 6 samples)
File Write (10 seconds)                  157663.0 KBps  (10 secs, 6 samples)
File Copy  (10 seconds)                   32516.0 KBps  (10 secs, 6 samples)
File Read  (30 seconds)                  1507645.0 KBps  (30 secs, 6 samples)
File Write (30 seconds)                  161130.0 KBps  (30 secs, 6 samples)
File Copy  (30 seconds)                   20155.0 KBps  (30 secs, 6 samples)
C Compiler Test                             491.2 lpm   (60 secs, 3 samples)
Shell scripts (1 concurrent)               1315.2 lpm   (60 secs, 3 samples)
Shell scripts (2 concurrent)                694.4 lpm   (60 secs, 3 samples)
Shell scripts (4 concurrent)                357.1 lpm   (60 secs, 3 samples)
Shell scripts (8 concurrent)                180.4 lpm   (60 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          46831.0 lpm   (60 secs, 6 samples)
Recursion Test--Tower of Hanoi            20954.1 lps   (10 secs, 6 samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Arithmetic Test (type = double)               2541.7   224339.4       88.3
Dhrystone 2 without register variables       22366.3  1652556.1       73.9
Execl Throughput Test                           16.5     1089.8       66.0
File Copy  (30 seconds)                        179.0    20155.0      112.6
Pipe-based Context Switching Test             1318.5   229029.2      173.7
Shell scripts (8 concurrent)                     4.0      180.4       45.1
                                                                 =========
     SUM of  6 items                                                 559.6
     AVERAGE                                                          93.3

--- Desktop Pentium 4 2.0 Ghz w/ 266 Mhz DDR ---

  BYTE UNIX Benchmarks (Version 3.11)
  System -- Linux gw2 2.4.19 #1 Mon Dec 9 05:31:23 GMT-7 2002 i686 unknown
  Start Benchmark Run: Mon Dec  9 05:45:47 GMT-7 2002
   1 interactive users.
Dhrystone 2 without register variables   2910759.3 lps   (10 secs, 6 samples)
Dhrystone 2 using register variables     2928495.6 lps   (10 secs, 6 samples)
Arithmetic Test (type = arithoh)         9252565.4 lps   (10 secs, 6 samples)
Arithmetic Test (type = register)        498894.3 lps   (10 secs, 6 samples)
Arithmetic Test (type = short)           473452.0 lps   (10 secs, 6 samples)
Arithmetic Test (type = int)             498956.5 lps   (10 secs, 6 samples)
Arithmetic Test (type = long)            498932.0 lps   (10 secs, 6 samples)
Arithmetic Test (type = float)           451138.8 lps   (10 secs, 6 samples)
Arithmetic Test (type = double)          451106.8 lps   (10 secs, 6 samples)
System Call Overhead Test                233637.8 lps   (10 secs, 6 samples)
Pipe Throughput Test                     437441.1 lps   (10 secs, 6 samples)
Pipe-based Context Switching Test        167229.2 lps   (10 secs, 6 samples)
Process Creation Test                      9407.2 lps   (10 secs, 6 samples)
Execl Throughput Test                      2158.8 lps   (10 secs, 6 samples)
File Read  (10 seconds)                  1088629.0 KBps  (10 secs, 6 samples)
File Write (10 seconds)                  472315.0 KBps  (10 secs, 6 samples)
File Copy  (10 seconds)                   10569.0 KBps  (10 secs, 6 samples)
File Read  (120 seconds)                 1089526.0 KBps  (120 secs, 6 samples)
File Write (120 seconds)                 467028.0 KBps  (120 secs, 6 samples)
File Copy  (120 seconds)                   3541.0 KBps  (120 secs, 6 samples)
C Compiler Test                             973.9 lpm   (60 secs, 3 samples)
Shell scripts (1 concurrent)               2590.8 lpm   (60 secs, 3 samples)
Shell scripts (2 concurrent)               1359.6 lpm   (60 secs, 3 samples)
Shell scripts (4 concurrent)                696.4 lpm   (60 secs, 3 samples)
Shell scripts (8 concurrent)                352.1 lpm   (60 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          99120.4 lpm   (60 secs, 6 samples)
Recursion Test--Tower of Hanoi            44857.5 lps   (10 secs, 6 samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Arithmetic Test (type = double)               2541.7   451106.8      177.5
Dhrystone 2 without register variables       22366.3  2910759.3      130.1
Execl Throughput Test                           16.5     2158.8      130.8
File Copy  (120 seconds)                       179.0     3541.0       19.7
Pipe-based Context Switching Test             1318.5   167229.2      126.8
Shell scripts (8 concurrent)                     4.0      352.1       88.0
                                                                 =========
     SUM of  6 items                                                 673.0
     AVERAGE                                                         112.1


--- Pentium 4 Xeon 2.4 Ghz x 2 w/ 2.4.19 ---

  BYTE UNIX Benchmarks (Version 3.11)
  System -- Linux brent-xeon 2.4.19-kel #5 SMP Wed Sep 25 03:15:13 GMT 2002 i686 unknown
  Start Benchmark Run: Thu Oct 10 03:48:07 MDT 2002
   0 interactive users.
Dhrystone 2 without register variables   2200821.4 lps   (10 secs, 6 samples)
Dhrystone 2 using register variables     2233296.6 lps   (10 secs, 6 samples)
Arithmetic Test (type = arithoh)         7366670.5 lps   (10 secs, 6 samples)
Arithmetic Test (type = register)        399261.4 lps   (10 secs, 6 samples)
Arithmetic Test (type = short)           361354.7 lps   (10 secs, 6 samples)
Arithmetic Test (type = int)             364200.0 lps   (10 secs, 6 samples)
Arithmetic Test (type = long)            345292.9 lps   (10 secs, 6 samples)
Arithmetic Test (type = float)           539907.7 lps   (10 secs, 6 samples)
Arithmetic Test (type = double)          537355.5 lps   (10 secs, 6 samples)
System Call Overhead Test                207684.2 lps   (10 secs, 6 samples)
Pipe Throughput Test                     283868.3 lps   (10 secs, 6 samples)
Pipe-based Context Switching Test         98205.6 lps   (10 secs, 6 samples)
Process Creation Test                      5395.9 lps   (10 secs, 6 samples)
Execl Throughput Test                      1612.9 lps   (9 secs, 6 samples)
File Read  (10 seconds)                  686892.0 KBps  (10 secs, 6 samples)
File Write (10 seconds)                  272217.0 KBps  (10 secs, 6 samples)
File Copy  (10 seconds)                   56415.0 KBps  (10 secs, 6 samples)
File Read  (30 seconds)                  681181.0 KBps  (30 secs, 6 samples)
File Write (30 seconds)                  272351.0 KBps  (30 secs, 6 samples)
File Copy  (30 seconds)                   20611.0 KBps  (30 secs, 6 samples)
C Compiler Test                             873.5 lpm   (60 secs, 3 samples)
Shell scripts (1 concurrent)               2970.1 lpm   (60 secs, 3 samples)
Shell scripts (2 concurrent)               1294.2 lpm   (60 secs, 3 samples)
Shell scripts (4 concurrent)                845.2 lpm   (60 secs, 3 samples)
Shell scripts (8 concurrent)                409.2 lpm   (60 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places           no measured results
Recursion Test--Tower of Hanoi            33661.9 lps   (10 secs, 6 samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Arithmetic Test (type = double)               2541.7   537355.5      211.4
Dhrystone 2 without register variables       22366.3  2200821.4       98.4
Execl Throughput Test                           16.5     1612.9       97.8
File Copy  (30 seconds)                        179.0    20611.0      115.1
Pipe-based Context Switching Test             1318.5    98205.6       74.5
Shell scripts (8 concurrent)                     4.0      409.2      102.3
                                                                 =========
     SUM of  6 items                                                 699.5
     AVERAGE                                                         116.6
