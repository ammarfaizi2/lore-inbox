Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUADR1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 12:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUADR1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 12:27:16 -0500
Received: from mail.boo.net ([216.240.97.204]:37090 "EHLO mail.boo.net")
	by vger.kernel.org with ESMTP id S265763AbUADR1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 12:27:10 -0500
Message-Id: <5.2.1.1.2.20040104120713.00a83500@boo.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 04 Jan 2004 12:34:53 -0500
To: linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: [PATCH] page coloring for 2.4.23 kernel
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it's a new year, and time for another page coloring patch.

www.boo.net/~jasonp/page_color-2.4.23-20040102.patch

This version folds in most of the improvements and suggestions I've
received over the years. mm_structs, inodes, and slab caches all have
their own round-robin counters. The code is cleaned up a lot, and the
page allocator engine also has a fallback path now if a specific color
page cannot be found.

I've removed the cache-size autodetect code; page coloring is configured
via "page_color=<kB in L2 cache>" boot argument. As before, the patch
provides statistics through /proc/page_color.

I've included lmbench results comparing the patched kernel with stock
2.4.23; some things are a little slower, other things are noticeably faster.
Kernel compiles are about 2% faster. These timings are for a 466MHz Alpha
with a 2MB direct-mapped L2 cache.

I'll be installing linux on a K7 system in the near future and rerunning
these tests.

In all honesty, there will probably not be a 2.6 version of this patch.
The approach to allocating pages here is completely incompatible with the
per-cpu quicklists in 2.6 that insulate processes from the buddy allocator.
I can't think of a clever way to provide specific page colors through the
per-cpu lists without making a mess. There is also the fact that people seem
to (violently) want other solutions to improving cache behavior in linux.

jasonp


                  L M B E N C H  3 . 0   S U M M A R Y
                  ------------------------------------
		 (Alpha software, do not distribute)

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh
                              call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
ds10       Linux 2.4.23  462 0.32 0.64 3.27 4.37 39.2 1.15 3.34 517. 3894 11.K
ds10       Linux 2.4.23  461 0.34 0.63 3.31 4.29 43.1 1.14 3.35 513. 3790 11.K
ds10       Linux 2.4.23  462 0.32 0.64 3.43 4.37 39.9 1.16 3.38 544. 4125 12.K
ds10      Linux 2.4.23a  462 0.34 0.66 3.80 4.67 43.9 1.16 3.24 572. 3892 12.K
ds10      Linux 2.4.23a  462 0.35 0.65 3.68 4.72 39.3 1.07 3.31 548. 3857 11.K
ds10      Linux 2.4.23a  462 0.34 0.66 3.68 4.61 39.4 1.10 3.43 564. 3861 12.K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                          ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
ds10       Linux 2.4.23 1.8500 1.5200   23.0 7.3300   36.0    10.7    47.3
ds10       Linux 2.4.23 1.4600 2.2300   14.2 7.8000   40.1    10.6    56.7
ds10       Linux 2.4.23 1.5700 1.9300   13.3 7.2400   43.9 7.87000    57.2
ds10      Linux 2.4.23a 1.5400 1.1700   13.8 7.9800   34.6    11.3    37.2
ds10      Linux 2.4.23a 2.1700 1.9300   13.7 8.4000   31.1    11.3    46.1
ds10      Linux 2.4.23a 1.4600 1.5800   13.9 8.6300   18.2    11.7    47.3

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                         ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
ds10       Linux 2.4.23 1.850 8.237 17.6              42.6       169.
ds10       Linux 2.4.23 1.460 8.644 16.8              41.2       171.
ds10       Linux 2.4.23 1.570 8.717 18.8              41.0       176.
ds10      Linux 2.4.23a 1.540 8.296 15.0              44.1       173.
ds10      Linux 2.4.23a 2.170 8.116 15.2              45.5       175.
ds10      Linux 2.4.23a 1.460 8.182 15.9              44.6       178.

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                         Create Delete Create Delete Latency 
Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
ds10       Linux 2.4.23   30.5   10.2  109.4   31.9   411.0 0.958 2.01450  34.7
ds10       Linux 2.4.23   30.6   10.4  110.4   31.8   412.0 0.770 1.98610  37.9
ds10       Linux 2.4.23   30.6   10.2  105.8   31.5  7143.0 1.020 2.66750  35.9
ds10      Linux 2.4.23a   31.1   10.9  108.6   29.9  6745.0 0.584 2.69460  35.3
ds10      Linux 2.4.23a   31.7   10.9  110.5   29.7  6978.0 0.899 2.64420  35.6
ds10      Linux 2.4.23a   32.3   11.0  108.3   30.0  6924.0 0.894 2.63630  35.9

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                              UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
ds10       Linux 2.4.23 378. 257. 121.  258.4  588.8  241.7  215.6 359. 320.8
ds10       Linux 2.4.23 387. 234. 132.  241.0  589.0  243.4  217.1 359. 322.1
ds10       Linux 2.4.23 362. 270. 128.  256.3  588.9  267.6  232.9 359. 334.4
ds10      Linux 2.4.23a 394. 241. 114.  328.0  588.8  261.0  236.5 358. 334.5
ds10      Linux 2.4.23a 390. 280. 119.  326.3  588.8  261.6  237.6 359. 334.9
ds10      Linux 2.4.23a 399. 282. 114.  324.6  588.8  261.2  237.4 359. 335.1

