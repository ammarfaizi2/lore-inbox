Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319597AbSIHLmJ>; Sun, 8 Sep 2002 07:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319598AbSIHLmJ>; Sun, 8 Sep 2002 07:42:09 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:4102 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S319597AbSIHLmH>; Sun, 8 Sep 2002 07:42:07 -0400
Date: Sun, 8 Sep 2002 21:46:45 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: linux-kernel@vger.kernel.org
Subject: Performance issue in 2.5.32+
Message-ID: <Mutt.LNX.4.44.0209082131140.20784-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed a significant performance hit on my system since 2.5.32.  
lmbench shows major changes in context switching latencies for 2.5.32 and
2.5.33 (see below, and profiling results for lat_ctx after that). This is
on a dual celeron system with a Gigabyte GA6BXD motherboard.  I can
provide more hardware and configuration details if required.


                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
test1      Linux 2.4.19       i686-pc-linux-gnu  548
test1      Linux 2.5.31       i686-pc-linux-gnu  547
test1      Linux 2.5.32       i686-pc-linux-gnu  547
test1      Linux 2.5.33       i686-pc-linux-gnu  547

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
test1      Linux 2.4.19  548 0.64 1.09 6.04 8.10  49.9 1.52 4.81 498. 1399 6546
test1      Linux 2.5.31  547 0.61 1.15 6.77 9.91  44.2 1.48 5.12 576. 1698 7381
test1      Linux 2.5.32  547 0.64 1.18 6.24 9.64       1.52 5.08 703. 1884 8014
test1      Linux 2.5.33  547 0.64 1.15 6.29 8.18       1.52 5.08 733. 1884 7965

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
test1      Linux 2.4.19 2.890   10.7   94.5   34.1  130.8    35.9   135.0
test1      Linux 2.5.31 7.160   12.8   64.4   21.8  131.7    38.4   133.6
test1      Linux 2.5.32 1.460 1085.4   95.1  333.1 1078.8   200.6   634.3
test1      Linux 2.5.33 2.080 9.4200   93.8   37.4 1096.0   212.3  1079.8

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
test1      Linux 2.4.19 2.890  13.0 39.2              60.7       120.
test1      Linux 2.5.31 7.160 9.213 17.5              62.0       121.
test1      Linux 2.5.32 1.460  10.5 18.8              48.7       249.
test1      Linux 2.5.33 2.080  10.5 17.9             8018.       192.

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
test1      Linux 2.4.19  117.2   36.4  316.4   73.6   1811.0 1.234 4.00000
test1      Linux 2.5.31  123.6   40.5  341.5   83.5   3120.0 1.316 5.00000
test1      Linux 2.5.32  125.4   41.4  25.6K 5988.0   3224.0 1.223 5.00000
test1      Linux 2.5.33  121.5   38.8  198.5   81.8   3078.0 1.327 5.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
test1      Linux 2.4.19 164. 145. 78.8  216.1  443.3  155.3  154.5 443. 185.3
test1      Linux 2.5.31 215. 123. 84.9  235.9  440.5  158.8  157.9 440. 199.5
test1      Linux 2.5.32 203. 103. 6.75  199.5  388.8  143.7  142.0 387. 182.2
test1      Linux 2.5.33 130. 2.42 9.07  162.7  388.7  144.8  143.1 389. 182.8

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
test1      Linux 2.4.19   548 5.470  100.8  133.1
test1      Linux 2.5.31   547 5.478   87.0  133.5
test1      Linux 2.5.32   547 5.483  102.8  146.8
test1      Linux 2.5.33   547 5.483  110.8  146.5


* lat_ctx profiling data for 2.5.31:

"size=64k ovr=33.90
16 137.67
   868 default_idle                              13.5625
    24 system_call                                0.5455
    14 __wake_up                                  0.2917
    17 do_gettimeofday                            0.1181
     4 sys_gettimeofday                           0.0250
     1 pgd_alloc                                  0.0156
     2 pte_alloc_one                              0.0139
   938 total                                      0.0077
     6 schedule                                   0.0067
     1 do_page_fault                              0.0009
     1 copy_process                               0.0005

* lat_ctx profiling data for 2.5.32:

"size=64k ovr=33.85
16 629.19
  1329 default_idle                              20.7656
    22 system_call                                0.5000
    23 __wake_up                                  0.4792
     3 syscall_call                               0.2727
     1 syscall_exit                               0.0909
    13 do_gettimeofday                            0.0903
     8 sys_gettimeofday                           0.0500
     1 ret_from_intr                              0.0417
    33 schedule                                   0.0368
     2 remove_wait_queue                          0.0312
     1 schedule_tail                              0.0208
     2 pte_alloc_one                              0.0139
  1445 total                                      0.0117
     1 cpu_idle                                   0.0089
     1 session_of_pgrp                            0.0078
     1 do_softirq                                 0.0052
     1 sys_rt_sigaction                           0.0042
     1 do_sigaction                               0.0028
     1 copy_files                                 0.0014
     1 do_exit                                    0.0014



- James
-- 
James Morris
<jmorris@intercode.com.au>


