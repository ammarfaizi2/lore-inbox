Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268342AbUHTRaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268342AbUHTRaN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUHTRaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:30:13 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:24071 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268342AbUHTR3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:29:39 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: copy_page(): non-temporal stores look useful?
Date: Fri, 20 Aug 2004 20:29:32 +0300
User-Agent: KMail/1.5.4
Cc: Ingo Molnar <mingo@elte.hu>, Jens Maurer <Jens.Maurer@gmx.net>,
       Arjan van de Ven <arjanv@redhat.com>,
       "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8TjJBgsxSOgcZ05"
Message-Id: <200408202029.32194.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_8TjJBgsxSOgcZ05
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I was playing with MMX, SSE and non-temporal page zeroing
and page-copying routines for quite a bit now.

NB: the CPU is Duron Applebred 1750MHz 64k L1 + 64k L2.

In short, this is what I found:

* MMX and SSE routines are very close in speed.
  Both are 5-10% faster than "rep stosd/rep movsd" ones.
* Aligning main loop gives 0-2% speedup.
* Prefetching data in copy loop gives 5-10% speedup.
* Using non-temporal stores gives 50-300% speedup,
  but copied data end up stored in main memory, not in cache.

Are non-temporal stores a win or a loss? We need to measure
not just a zero_page / copy_page speed, but also speed of
subsequent access for page data. Here's what I found:

* In small-footprint testing which fits entirely in L1 dcache,
  NT zero_page() is actually a loss if we are reading zeroed-out
  page afterwards. Since CPU typically uses write-allocate,
  we end up reading page even if code only writes into it.

* HOWEVER, I was unable to demonstrate that NT copy_page() routine
  is a loss when we read copied data back. Whatever I tried (small,
  medium, large dataset), NT copy_page() is *faster* than non-NT one.

* This contradicts Arjan's results - he says that NT is a loss.
  (I still would like to try to reproduce his testing. Arjan?)

How can that be? Below you will find all the gory details, thoughts,
and means to reproduce and/or test on different CPU.

Typically copy_page is done when kernel need to un-COW
a page when one of the forked processes wants
to write to a page, and I used
	alloc(buf);
	for(;;) { fork(); use(buf); }
code for copy_page() benchmarking.

It turned out that kernel zeroes out 3 pages and copies 8 more
pages on each fork, and, obviously, kernel does NOT use entire 44k
of resultant data. It accesses some 100 bytes here and there, and
that's all. Thus, testing shows that NT ops are a win for fork().

If I use smallish mmap'ed buffer so that sizeof(buffer)+44k still fits
into L1, speed gains from fork() outweigh losses due to slower access
to NT-copied pages.

If I use larger buffer and sizeof(buffer)+44k does not fit in cache,
NT-copy wins hands down, as expected.

Commented test results below. SSE results are omitted (very close to MMX).
Test programs/scripts and kernel code are in attached tarball.
Each tes was run 5 times, results are sorted.
NNN/MMM == NNN zero_page, MMM copy_page calls were made.
slow == rep stosd / rep movsd routines
mmx_APn == aligned loop, using prefetch, NOT using non-temporal stores
mmx_APN == aligned loop, using prefetch, using non-temporal stores
mmx_APn/APN == use NT only for copy (zero_page is non-NT)

NT zero_page() is a clear loss for small buffer (which is the most
used and most important case):
320k zeroing, 5x20000 loops:
slow:               0m9.584 0m9.612 0m9.635 0m9.687 0m9.887 8000297/497
mmx_APn:            0m8.355 0m8.506 0m8.531 0m8.548 0m8.744 8000266/444
mmx_APN:            0m5.413 0m5.426 0m5.448 0m5.550 0m5.653 8000262/448
32k zeroing, 5x200000 loops:
slow:               0m3.821 0m3.866 0m3.938 0m4.006 0m4.075 8000274/471
mmx_APn:            0m3.547 0m3.622 0m3.798 0m3.876 0m4.102 8000241/414
mmx_APN:            0m5.985 0m6.021 0m6.186 0m6.268 0m6.775 8000267/441

Ok, now, copy_page() testing:
NB: each copy test does one fork per one loop.
With each fork, kernel zeroes out 3 pages and copies 8 pages.
This amounts to 12k+32k bytes.
256k copying, 5x5000 loops:
slow:               0m8.036 0m8.063 0m8.192 0m8.233 0m8.252 75600/1800468
mmx_APn:            0m7.461 0m7.496 0m7.543 0m7.687 0m7.725 75586/1800446
mmx_APN:            0m6.351 0m6.366 0m6.378 0m6.382 0m6.525 75586/1800436
mmx_APn/APN:        0m6.412 0m6.448 0m6.501 0m6.663 0m6.669 75584/1800439
128k copying, 5x5000 loops:
slow:               0m4.732 0m4.747 0m4.751 0m4.773 0m4.776 75466/1000469
mmx_APn:            0m4.258 0m4.331 0m4.343 0m4.386 0m4.422 75406/1000422
mmx_APN:            0m3.658 0m3.672 0m3.784 0m3.798 0m3.818 75452/1000436
mmx_APn/APN:        0m3.713 0m3.713 0m3.840 0m3.850 0m3.857 75435/1000413
64k copying, 5x10000 loops:
slow:               0m5.869 0m5.885 0m5.894 0m5.904 0m5.906 150356/1200472
mmx_APn:            0m5.369 0m5.391 0m5.404 0m5.424 0m5.426 150345/1200444
mmx_APN:            0m4.804 0m4.826 0m4.843 0m4.843 0m4.934 150355/1200436
mmx_APn/APN:        0m4.878 0m4.883 0m4.926 0m4.937 0m4.962 150343/1200441
32k copying, 5x20000 loops:
slow:               0m8.088 0m8.125 0m8.241 0m8.245 0m8.326 300320/1600461
mmx_APn:            0m7.527 0m7.662 0m7.706 0m7.750 0m7.802 300303/1600438
mmx_APN:            0m6.630 0m6.661 0m6.681 0m6.696 0m6.735 300303/1600442
28k copying, 5x20000 loops:
slow:               0m7.678 0m7.804 0m7.817 0m7.888 0m7.920 300329/1500470
mmx_APn:            0m7.064 0m7.084 0m7.138 0m7.268 0m7.338 300298/1500437
mmx_APN:            0m5.956 0m5.960 0m6.048 0m6.107 0m6.200 300297/1500435
20k copying, 5x20000 loops:
slow:               0m6.610 0m6.665 0m6.694 0m6.750 0m6.774 300315/1300468
mmx_APn:            0m6.208 0m6.218 0m6.263 0m6.335 0m6.452 300352/1300448
mmx_APN:            0m4.887 0m4.984 0m5.021 0m5.052 0m5.057 300295/1300443
mmx_APn/APN:        0m5.115 0m5.160 0m5.167 0m5.172 0m5.183 300292/1300443

NB: above: non-NT zero_page does NOT improve (compare mmx_APN and mmx_APn/APN)

4k copying, 5x40000 loops:
slow:               0m8.303 0m8.334 0m8.354 0m8.510 0m8.572 600313/1800473
mmx_APn:            0m8.233 0m8.350 0m8.406 0m8.407 0m8.642 600323/1800467
mmx_APN:            0m6.475 0m6.501 0m6.510 0m6.534 0m6.783 600302/1800436
mmx_APn/APN:        0m6.540 0m6.551 0m6.603 0m6.640 0m6.708 600271/1800442

Dominated by fork() overhead. NT again wins! Probably because fork()
does not read back entire 44k of zeroed/copied memory.

I'd like to try some non-forking workload. Is there ANY workload
which will be faster on non-NT copy_page() than on NT one?

Comments?
--
vda

--Boundary-00=_8TjJBgsxSOgcZ05
Content-Type: application/x-tgz;
  name="fp.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="fp.tar.gz"

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
6Bd7zAYKAKAAAA==

--Boundary-00=_8TjJBgsxSOgcZ05--

