Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVDFAVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVDFAVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 20:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVDFAVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 20:21:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27882 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262029AbVDFAUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 20:20:48 -0400
Date: Tue, 5 Apr 2005 17:15:53 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: davidm@hpl.hp.com
cc: Andi Kleen <ak@muc.de>, Christoph Lameter <clameter@sgi.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <16963.2075.713737.485070@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0504051706110.12179@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
 <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
 <200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
 <20050318192808.GB38053@muc.de> <16963.2075.713737.485070@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005, David Mosberger wrote:

> That's definitely the case.  See my earlier post on this topic:
>
>   http://www.gelato.unsw.edu.au/linux-ia64/0409/11012.html
>
> Unfortunately, nobody reported any results for larger machines and/or
> more interesting workloads, so the patch is in limbo at this time.
> Clearly, if the CPU that's clearing the page is likely to use that
> same page soon after, it'd be useful to use temporal stores.

Here are some numbers using lmbench of temporal writes vs. non temporal
writes on ia64 (8p machine but lmbench run only for one load). There seems
to be some benefit for fork/exec but overall this does not seem to be a
clear win. I suspect that the distinction between temporal vs. nontemporal
writes is be more beneficial on machines with smaller pagesizes since
the likelyhood that most cachelines of a page are used soon is increased
and therefore hot zeroing is more beneficial.


                 L M B E N C H  3 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
-------------------------------------------------------------------------------------------
Host                             OS Description              Mhz  tlb  cache  mem   scal
                                                                 pages line   par   load
                                                                      bytes
--------- ------------------------- ----------------------- ---- ----- ----- ------ ----
margin         Linux 2.6.12-rc1-bk3          ia64-linux-gnu 1300         128           1
margin         Linux 2.6.12-rc1-bk3          ia64-linux-gnu 1300         128           1
margin         Linux 2.6.12-rc1-bk3          ia64-linux-gnu 1300         128           1
margin         Linux 2.6.12-rc1-bk3          ia64-linux-gnu 1300         128           1
margin         Linux 2.6.12-rc1-bk3          ia64-linux-gnu 1300         128           1
margin         Linux 2.6.12-rc1-bk3          ia64-linux-gnu 1300         128           1
margin         Linux 2.6.12-rc1-bk3          ia64-linux-gnu 1300         128           1
margin      Linux 2.6.12-rc1-bk3-dm          ia64-linux-gnu 1300         128           1
margin      Linux 2.6.12-rc1-bk3-dm          ia64-linux-gnu 1300         128           1
margin      Linux 2.6.12-rc1-bk3-dm          ia64-linux-gnu 1300         128           1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------------------
Host                             OS  Mhz null null      open slct sig  sig  fork exec sh
                                         call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
margin         Linux 2.6.12-rc1-bk3 1300 0.04 0.26 4.90 6.11 15.7 0.39 2.43 528. 1926 4853
margin         Linux 2.6.12-rc1-bk3 1300 0.04 0.27 4.86 6.10 15.7 0.39 2.45 522. 1910 4260
margin         Linux 2.6.12-rc1-bk3 1300 0.04 0.26 4.85 6.10 15.8 0.39 2.40 526. 1916 4429
margin         Linux 2.6.12-rc1-bk3 1300 0.04 0.26 4.84 6.11 15.7 0.39 2.40 531. 1838 4429
margin         Linux 2.6.12-rc1-bk3 1300 0.04 0.26 4.85 6.11 15.8 0.39 2.47 553. 1931 5118
margin         Linux 2.6.12-rc1-bk3 1300 0.04 0.26 5.09 6.37 15.7 0.39 2.40 537. 1934 5133
margin         Linux 2.6.12-rc1-bk3 1300 0.04 0.26 5.09 6.35 15.8 0.39 2.40 555. 1939 5389
margin      Linux 2.6.12-rc1-bk3-dm 1300 0.04 0.26 4.88 6.10 15.8 0.39 2.42 519. 1829 4787
margin      Linux 2.6.12-rc1-bk3-dm 1300 0.04 0.26 4.87 6.09 15.8 0.39 2.40 516. 1830 5057
margin      Linux 2.6.12-rc1-bk3-dm 1300 0.04 0.27 4.86 6.10 15.8 0.39 2.40 512. 1878 5166

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------------------
Host                             OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                                     ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------------------- ------ ------ ------ ------ ------ ------- -------
margin         Linux 2.6.12-rc1-bk3 7.3300 2.7400 7.0400 4.4600 6.6200 3.94000 8.38000
margin         Linux 2.6.12-rc1-bk3 7.6100 8.1000 7.3200 4.5900 7.1700 5.50000 7.84000
margin         Linux 2.6.12-rc1-bk3 7.2400 8.0000 7.2100 4.3800 6.7500 4.77000 7.37000
margin         Linux 2.6.12-rc1-bk3 7.4100 8.0400 7.0500 4.5100 7.2500 4.11000 7.03000
margin         Linux 2.6.12-rc1-bk3 7.2600 8.2100 7.2400 4.6500 6.6500 4.08000 7.81000
margin         Linux 2.6.12-rc1-bk3 7.4600 7.9000 7.3800 4.3800 6.6200 4.83000 7.27000
margin         Linux 2.6.12-rc1-bk3 7.4400 8.2000 7.2000 5.8700 6.8000 4.86000 7.95000
margin      Linux 2.6.12-rc1-bk3-dm 7.4400 8.3100 7.1300 5.6900 6.6500 5.49000 7.49000
margin      Linux 2.6.12-rc1-bk3-dm 2.1300 8.0100 7.3800 4.6700 6.5500 4.22000 8.16000
margin      Linux 2.6.12-rc1-bk3-dm 7.4900 8.1200 2.1500 4.3600 6.6900 5.54000 7.38000

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------------------
Host                             OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                                    ctxsw       UNIX         UDP         TCP conn
--------- ------------------------- ----- ----- ---- ----- ----- ----- ----- ----
margin         Linux 2.6.12-rc1-bk3 7.330  16.9 24.8  29.6  36.0  31.4  49.5  52.
margin         Linux 2.6.12-rc1-bk3 7.610  17.4 22.0              31.5        52.
margin         Linux 2.6.12-rc1-bk3 7.240  17.5 21.6              31.3        53.
margin         Linux 2.6.12-rc1-bk3 7.410  17.6 11.8              31.2        51.
margin         Linux 2.6.12-rc1-bk3 7.260  17.1 20.6  28.2  37.6  51.0  99.7  92.
margin         Linux 2.6.12-rc1-bk3 7.460  17.0 21.0  30.2  69.5  35.3  77.4  52.
margin         Linux 2.6.12-rc1-bk3 7.440  39.7 19.8  29.1  65.3  34.3  44.8  53.
margin      Linux 2.6.12-rc1-bk3-dm 7.440  17.4 20.5  29.4  37.0  34.3  86.7  77.
margin      Linux 2.6.12-rc1-bk3-dm 2.130  17.8 20.6  28.7  37.2  31.8  44.9  77.
margin      Linux 2.6.12-rc1-bk3-dm 7.490  17.5 11.3  29.0  37.4  77.1  46.1  53.

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------------------
Host                             OS   0K File      10K File     Mmap    Prot   Page   100fd
                                    Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------------------- ------ ------ ------ ------ ------- ----- ------- -----
margin         Linux 2.6.12-rc1-bk3                               340.0 0.162 1.26430  10.6
margin         Linux 2.6.12-rc1-bk3                               339.0 0.176 1.26310  10.5
margin         Linux 2.6.12-rc1-bk3                               342.0 0.180 1.25700  10.5
margin         Linux 2.6.12-rc1-bk3                               341.0 0.207 1.25640  10.5
margin         Linux 2.6.12-rc1-bk3                               339.0 0.166 1.26310  10.6
margin         Linux 2.6.12-rc1-bk3                               343.0 0.159 1.26350  10.6
margin         Linux 2.6.12-rc1-bk3                               339.0 0.174 1.25660  10.6
margin      Linux 2.6.12-rc1-bk3-dm                               340.0 0.185 1.26090  10.6
margin      Linux 2.6.12-rc1-bk3-dm                               340.0 0.128 1.26310  10.5
margin      Linux 2.6.12-rc1-bk3-dm                               343.0 0.159 1.25960  10.5

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------------------
Host                            OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                                       UNIX      reread reread (libc) (hand) read write
--------- ------------------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
margin         Linux 2.6.12-rc1-bk3 1172 1826 562. 1732.6  573.5  535.7  284.9 521. 514.7
margin         Linux 2.6.12-rc1-bk3 1169 1883 868. 1733.5  573.8  535.2  283.9 521. 514.6
margin         Linux 2.6.12-rc1-bk3 1149 1897 654. 1725.5  573.6  535.1  285.2 521. 514.7
margin         Linux 2.6.12-rc1-bk3 1167 1883 921. 1726.1  573.8  534.9  283.1 521. 514.7
margin         Linux 2.6.12-rc1-bk3 1167 1146 413. 1726.8  573.6  535.4  283.6 522. 515.1
margin         Linux 2.6.12-rc1-bk3 1156 1875 905. 1721.7  573.9  535.4  283.8 521. 515.0
margin         Linux 2.6.12-rc1-bk3 1103 1741 493. 1727.7  573.6  534.8  283.3 521. 514.8
margin      Linux 2.6.12-rc1-bk3-dm 1160 1361 886. 1718.7  573.6  535.0  284.7 521. 514.8
margin      Linux 2.6.12-rc1-bk3-dm 1166 1759 665. 1733.0  565.0  535.2  284.6 521. 514.8
margin      Linux 2.6.12-rc1-bk3-dm 1140 1879 606. 1706.6  573.6  535.1  283.5 521. 514.6

patch:

Index: linux-2.6.11/arch/ia64/lib/clear_page.S
===================================================================
--- linux-2.6.11.orig/arch/ia64/lib/clear_page.S	2005-03-01 23:37:47.000000000 -0800
+++ linux-2.6.11/arch/ia64/lib/clear_page.S	2005-03-31 14:25:17.000000000 -0800
@@ -43,7 +43,7 @@ GLOBAL_ENTRY(clear_page)
 	adds dst1 = 16, in0
 	adds dst2 = 32, in0
 	;;
-.fetch:	stf.spill.nta [dst_fetch] = f0, L3_LINE_SIZE
+.fetch:	stf.spill [dst_fetch] = f0, L3_LINE_SIZE
 	adds dst3 = 48, in0		// executing this multiple times is harmless
 	br.cloop.sptk.few .fetch
 	;;
@@ -53,23 +53,23 @@ GLOBAL_ENTRY(clear_page)
 	;;
 #ifdef CONFIG_ITANIUM
 	// Optimized for Itanium
-1:	stf.spill.nta [dst1] = f0, 64
-	stf.spill.nta [dst2] = f0, 64
+1:	stf.spill [dst1] = f0, 64
+	stf.spill [dst2] = f0, 64
 	cmp.lt p8,p0=dst_fetch, dst_last
 	;;
 #else
 	// Optimized for McKinley
-1:	stf.spill.nta [dst1] = f0, 64
-	stf.spill.nta [dst2] = f0, 64
-	stf.spill.nta [dst3] = f0, 64
-	stf.spill.nta [dst4] = f0, 128
+1:	stf.spill [dst1] = f0, 64
+	stf.spill [dst2] = f0, 64
+	stf.spill [dst3] = f0, 64
+	stf.spill [dst4] = f0, 128
 	cmp.lt p8,p0=dst_fetch, dst_last
 	;;
-	stf.spill.nta [dst1] = f0, 64
-	stf.spill.nta [dst2] = f0, 64
+	stf.spill [dst1] = f0, 64
+	stf.spill [dst2] = f0, 64
 #endif
-	stf.spill.nta [dst3] = f0, 64
-(p8)	stf.spill.nta [dst_fetch] = f0, L3_LINE_SIZE
+	stf.spill [dst3] = f0, 64
+(p8)	stf.spill [dst_fetch] = f0, L3_LINE_SIZE
 	br.cloop.sptk.few 1b
 	;;
 	mov ar.lc = saved_lc		// restore lc

