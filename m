Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263056AbVCQMT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbVCQMT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 07:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCQMSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 07:18:42 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:23223 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261300AbVCQMQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 07:16:41 -0500
To: linux-kernel@vger.kernel.org
cc: garloff@suse.de, ak@suse.de
Subject: 2.6.11 vs 2.6.10 slowdown on i686
Date: Thu, 17 Mar 2005 12:16:40 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1DBtvc-0002c4-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Folks, 

When we upgraded arch xen/x86 to kernel 2.6.11, we noticed a slowdown
on a number of micro-benchmarks. In order to investigate, I built
native (non Xen) i686 uniprocessor kernels for 2.6.10 and 2.6.11 with
the same configuration and ran lmbench-3.0-a3 on them. The test
machine was a 2.4GHz Xeon box, gcc 3.3.3 (FC3 default) was used to
compile the kernels, NOHIGHMEM=y (2-level only).

On the i686 fork and exec benchmarks I found that there's been a
significant slowdown between 2.6.10 and 2.6.11. Some of the other
numbers a bit ugly too (see attached).

fork: 166 -> 235  (40% slowdown)
exec: 857 -> 1003 (17% slowdown)

I'm guessing this is down to the 4 level pagetables. This is rather a
surprise as I thought the compiler would optimise most of these
changes away. Apparently not. 

Anyhow, this explains the arch Xen results we were seeing.

Results appended, median of 6 runs.

Best,
Ian


Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
commando-  Linux 2.6.10 2400 0.49 0.57 2.06 3.06 19.6 0.89 2.70 166. 857. 2972
commando-  Linux 2.6.11 2400 0.49 0.60 2.12 3.35 20.8 0.92 2.73 235. 1003 3168

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
commando-  Linux 2.6.10 7.5800 4.3300 8.1900 5.1100   33.1 8.37000    41.9
commando-  Linux 2.6.11 7.9200 8.3200 8.3200 5.8300   26.6 9.46000    40.4

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
commando-  Linux 2.6.10 7.750  19.4 21.3  37.2  45.5  42.5  53.2  76.
commando-  Linux 2.6.11 7.920  20.3 23.6  40.2  50.1  46.5  57.6  87.

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
commando-  Linux 2.6.10   39.3   16.2   92.7   35.2   122.0 1.200 2.14310  18.3
commando-  Linux 2.6.11   40.8   16.8   99.5   36.7   163.0 1.075 2.27760  18.8

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
commando-  Linux 2.6.10 313. 440. 222. 1551.7 1528.5  549.1  566.8 1550 784.8
commando-  Linux 2.6.11 554. 450. 224. 1564.8 1548.3  549.9  574.6 1528 760.5

