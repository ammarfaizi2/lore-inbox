Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291235AbSBQW4x>; Sun, 17 Feb 2002 17:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291241AbSBQW4o>; Sun, 17 Feb 2002 17:56:44 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:10959 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S291235AbSBQW4j>; Sun, 17 Feb 2002 17:56:39 -0500
Date: Sun, 17 Feb 2002 18:01:59 -0500
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [rmap] operator-sparse Fibonacci hashing of waitqueues
Message-ID: <20020217230159.GA17136@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Randy, any chance you could benchmark -rmap with this on top for
> comparison against standard -rmap to ensure there is no regression?

System is k6-2 475 mhz and 384 MB ram with IDE disks.
Here it is with a few notes on things I looked at more closely.
I also have the output of readprofile between each test.

dbench 128 processes
2.4.17-rmap12f       **********   5.0  MB/sec
2.4.17-rmap12f-wli   **********   5.1  MB/sec

unixbench-4.1.0         2.4.17-rmap12f-wli  2.4.17-rmap12f
Execl Throughput                  293.5           303.7  lps (3  samples)
Pipe Throughput                395378.4        391759.4  lps (10 samples)
Pipe-based Context Switching    78095.8        117697.0  lps (10 samples)
Process Creation                 1181.5          1143.0  lps (3  samples)
System Call Overhead           335203.8        335211.1  lps (10 samples)
Shell Scripts (1 concurrent)      586.9           591.0  lpm (3  samples)

pipe context switching in unixbench results initially looked concerning,
but looking at how the test varies, and context switch and pipe tests
in lmbench suggest that the lower number may not be significant.


LMbench-2.0p2 average of 9 samples.
-------------
Processor, Processes - times in microseconds - smaller is better
OS                  null null      open  slct sig  sig   fork  exec   sh
                    call I/O  stat clos  TCP  inst hndl  proc  proc  proc
2.4.17-rmap12f      0.43 0.71 3.43 5.47  49.3 1.46 3.25   904  3606 14035
2.4.17-rmap12f-wli  0.43 0.71 3.20 5.32  44.9 1.44 3.35   951  3671 13960


Context switching - times in microseconds - smaller is better
OS                  2p/0K  2p/16K  2p/64K  8p/16K 8p/64K  16p/16K 16p/64K
                    ctxsw  ctxsw   ctxsw   ctxsw  ctxsw   ctxsw   ctxsw
2.4.17-rmap12f       0.91   24.52  195.18  58.21  211.57  60.72   227.85
2.4.17-rmap12f-wli   1.07   22.21  189.00  56.71  206.15  60.90   226.34


*Local* Communication latencies in microseconds - smaller is better
OS                  Pipe    AF    UDP    RPC/   TCP    RPC/   TCP
                           UNIX           UDP           TCP   conn
2.4.17-rmap12f      10.52  20.22  40.52  147.4  68.74  198.0  279.52
2.4.17-rmap12f-wli  11.06  19.85  40.39  142.1  66.52  191.3  274.65


File & VM system latencies in microseconds - smaller is better
OS                    0K    File     10K    File     Mmap    Prot   Page
                    Create  Delete  Create  Delete  Latency  Fault  Fault
2.4.17-rmap12f      121.02  164.96  566.05  248.88   3300.3  1.18    3.8
2.4.17-rmap12f-wli  134.03  171.19  690.52  254.61   3314.6  1.17    4.0


*Local* Communication bandwidths in MB/s - bigger is better
OS                  Pipe   AF   TCP    File   Mmap   Bcopy  Bcopy  Mem  
                          UNIX        reread reread (libc) (hand)  read 
2.4.17-rmap12f      64.04 48.73 60.15  58.62 237.62  58.48  59.62 237.43
2.4.17-rmap12f-wli  64.93 41.48 42.89  62.43 237.59  58.43  59.57 237.42

The TCP and AF bandwdith numbers vary a lot between tests.  Oddly, the TCP
test appears to vary by almost 100% between iterations.  Here are the 
individual test results;

OS                           AF     TCP 
                            UNIX        
--------------------------  -----  -----
Linux 2.4.17-rmap12f        46.47  39.43
Linux 2.4.17-rmap12f        51.26  78.44
Linux 2.4.17-rmap12f        51.31  77.34
Linux 2.4.17-rmap12f        50.52  74.49
Linux 2.4.17-rmap12f        47.49  40.32
Linux 2.4.17-rmap12f        48.20  79.06
Linux 2.4.17-rmap12f        44.00  38.66
Linux 2.4.17-rmap12f        48.65  38.14
Linux 2.4.17-rmap12f        50.63  75.50
Linux 2.4.17-rmap12f-wli    43.24  39.72
Linux 2.4.17-rmap12f-wli    42.92  82.14
Linux 2.4.17-rmap12f-wli    40.96  38.19
Linux 2.4.17-rmap12f-wli    42.46  37.77
Linux 2.4.17-rmap12f-wli    44.61  38.10
Linux 2.4.17-rmap12f-wli    40.86  37.15
Linux 2.4.17-rmap12f-wli    39.26  40.63
Linux 2.4.17-rmap12f-wli    38.35  36.27
Linux 2.4.17-rmap12f-wli    40.63  36.04

The tbench test below doesn't show a large variation between the
two kernels.


Memory latencies in nanoseconds - smaller is better
OS                  Mhz   L1 $   L2 $    Main mem
2.4.17-rmap12f       476   4.20  190.41  261.95
2.4.17-rmap12f-wli   476   4.20  186.52  262.02


tiobench Average of 3 samples.
--------
2048 MB worth of files on ext2 fs. (filesize = 2048MB / num_threads)
Read, write, and seek rates in MB/sec. 
Latency in milliseconds.
Percent of requests that took longer than 2 and 10 seconds.


Sequential Reads   Num                  Avg     Maximum   Lat%    Lat%  CPU
Kernel             Thr  Rate  (CPU%)  Latency   Latency    >2s    >0s   Eff
------------------ --- ----------------------------------------------------
2.4.17-rmap12f       8   9.37 13.97%    9.788    980.34 0.00000 0.00000  67
2.4.17-rmap12f-wli   8   9.38 13.74%    9.759    886.07 0.00000 0.00000  68

2.4.17-rmap12f      16   9.90 14.99%   18.234   1301.80 0.00000 0.00000  66
2.4.17-rmap12f-wli  16   9.89 14.72%   18.311   1330.12 0.00000 0.00000  67

2.4.17-rmap12f      32  10.05 16.46%   35.398   2455.18 0.00000 0.00000  61
2.4.17-rmap12f-wli  32  10.14 16.61%   35.303   2483.88 0.00000 0.00000  61

2.4.17-rmap12f      64   9.65 18.54%   71.995   4745.45 0.00000 0.00000  52
2.4.17-rmap12f-wli  64   9.65 18.29%   71.986   4792.92 0.00000 0.00000  53

2.4.17-rmap12f     128   9.25 26.66%  148.095 136165.27 4.71210 0.02498  35
2.4.17-rmap12f-wli 128   9.31 27.08%  146.307 111566.57 4.54960 0.01964  34


Random Reads       Num                  Avg     Maximum   Lat%    Lat%  CPU
Kernel             Thr  Rate  (CPU%)  Latency   Latency    >2s    >10s  Eff
------------------ --- ----------------------------------------------------
2.4.17-rmap12f       8   0.42 1.058%  217.323    852.61 0.00000 0.00000  40
2.4.17-rmap12f-wli   8   0.42 1.073%  217.232   1016.86 0.00000 0.00000  39

2.4.17-rmap12f      16   0.48 1.406%  375.897   1485.76 0.00000 0.00000  34
2.4.17-rmap12f-wli  16   0.47 1.296%  375.872   1537.88 0.00000 0.00000  37

2.4.17-rmap12f      32   0.52 1.760%  667.107   3468.37 0.00000 0.00000  30
2.4.17-rmap12f-wli  32   0.53 1.640%  655.669   3331.63 0.00000 0.00000  32

2.4.17-rmap12f      64   0.53 2.176% 1283.121   8672.69 0.75605 0.00000  24
2.4.17-rmap12f-wli  64   0.54 1.784% 1288.162   7699.61 0.90726 0.00000  30

2.4.17-rmap12f     128   0.54 3.198% 2508.958  16549.40 5.24697 0.00000  17
2.4.17-rmap12f-wli 128   0.54 3.071% 2492.784  17542.43 5.80141 0.00000  18


Sequential Writes  Num                  Avg     Maximum   Lat%    Lat%  CPU
Kernel             Thr  Rate  (CPU%)  Latency   Latency    >2s    >10s  Eff
------------------ --- ----------------------------------------------------
2.4.17-rmap12f       8  18.11 82.47%    4.542   4140.63 0.00000 0.00000  22
2.4.17-rmap12f-wli   8  18.06 82.49%    4.553   5403.78 0.00306 0.00000  22

2.4.17-rmap12f      16  18.04 81.69%    8.921   7486.25 0.00744 0.00000  22
2.4.17-rmap12f-wli  16  17.99 82.15%    8.893   5086.09 0.00076 0.00000  22

2.4.17-rmap12f      32  17.31 76.08%   17.610  10609.26 0.02595 0.00000  23
2.4.17-rmap12f-wli  32  17.31 77.04%   17.808  11199.52 0.03033 0.00000  22

2.4.17-rmap12f      64  15.07 60.04%   40.287  15381.66 0.39444 0.00000  25
2.4.17-rmap12f-wli  64  15.18 61.79%   40.052  20057.21 0.37003 0.00000  25

2.4.17-rmap12f     128  12.52 47.48%   95.497  31261.15 1.64452 0.00095  26
2.4.17-rmap12f-wli 128  12.62 46.73%   94.113  29901.54 1.50032 0.00114  27


Random Writes      Num                  Avg     Maximum   Lat%    Lat%  CPU
Kernel             Thr  Rate  (CPU%)  Latency   Latency    >2s    >10s  Eff
------------------ --- ----------------------------------------------------
2.4.17-rmap12f       8   0.67 4.278%    0.490    666.50 0.00000 0.00000  16
2.4.17-rmap12f-wli   8   0.66 4.322%    0.659    688.43 0.00000 0.00000  15

2.4.17-rmap12f      16   0.68 4.492%    1.941    578.57 0.00000 0.00000  15
2.4.17-rmap12f-wli  16   0.68 4.419%    2.249    632.19 0.00000 0.00000  15

2.4.17-rmap12f      32   0.67 4.467%    0.818    835.38 0.00000 0.00000  15
2.4.17-rmap12f-wli  32   0.68 4.550%    0.663    562.35 0.00000 0.00000  15

2.4.17-rmap12f      64   0.69 4.668%    1.076    621.97 0.00000 0.00000  15
2.4.17-rmap12f-wli  64   0.69 4.585%    0.980    861.52 0.00000 0.00000  15

2.4.17-rmap12f     128   0.71 4.973%    0.975    917.19 0.00000 0.00000  14
2.4.17-rmap12f-wli 128   0.70 4.990%    0.803    940.80 0.00000 0.00000  14


bonnie++ average of 3 samples
1024MB file
Version 1.02a      --------------------Sequential Output-------------------
                   -----Per Char----- ------Block------- -----Rewrite------
Kernel             MB/sec  %CPU   Eff MB/sec  %CPU   Eff MB/sec  %CPU   Eff
2.4.17-rmap12f       3.38  99.0  3.41  15.12  97.0 15.58   5.14  40.7 12.64
2.4.17-rmap12f-wli   3.38  99.0  3.42  15.16  97.0 15.63   5.66  45.3 12.48

                    -----------Sequential Input----------- -----Random-----
                    -----Per Char-----  ------Block------- -----Seeks------
Kernel              MB/sec  %CPU   Eff  MB/sec  %CPU   Eff /sec  %CPU   Eff
2.4.17-rmap12f        3.55  85.0  4.17   19.07  23.7 80.57  122   2.0  6096
2.4.17-rmap12f-wli    3.56  85.0  4.19   19.14  23.7 80.87  123   2.0  6140

16384 small files
                   -------------Sequential Create-------
                   ------Create-----    -----Delete-----
                    /sec  %CPU   Eff    /sec  %CPU   Eff
2.4.17-rmap12f      4395  95.7  4594    4548  99.3  4578
2.4.17-rmap12f-wli  4214  98.3  4286    4268  91.7  4655

                   -------------Random Create------------
                   ------Create-----     -----Delete-----
                    /sec  %CPU   Eff     /sec  %CPU   Eff
2.4.17-rmap12f      4460  99.0  4504     3927  93.3  4207
2.4.17-rmap12f-wli  4154  97.7  4253     4109  96.3  4265


Time in seconds to build/run things.
kernel             autoconf    perl    kernel  updatedb  updatedb 5x
2.4.17-rmap12f     1217        1589    1295    29        44       
2.4.17-rmap12f-wli 1218        1609    1270    28        45       


tbench 32 processes (average of 3 runs)
2.4.17-rmap12f       ********************************  16.3  MB/sec
2.4.17-rmap12f-wli   ********************************  16.2  MB/sec


More details on testing method and other kernels tested at
http://home.earthlink.net/~rwhron/kernel/k6-2-475.html

-- 
Randy Hron

