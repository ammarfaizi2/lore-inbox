Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWBNFFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWBNFFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWBNFFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:05:33 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:9168 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030408AbWBNFFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:12 -0500
Message-Id: <20060214050450.536209000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:38 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux@horizon.com, Balbir Singh <bsingharora@gmail.com>,
       Grant Grundler <iod00d@hp.com>, Gabriel Paubert <paubert@iram.es>
Subject: [patch 47/47] hweight() speedup
Content-Disposition: inline; filename=hweight-speedup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
> This is an extremely well-known technique.  You can see a similar version
> that uses a multiply for the last few steps at
> http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel
> whch refers to 
> "Software Optimization Guide for AMD Athlon 64 and Opteron Processors"
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/25112.PDF
> 
> It's section 8.6, "Efficient Implementation of Population-Count Function
> in 32-bit Mode", pages 179-180.
> 
> It uses the name that I am more familiar with, "popcunt" (population count),
> although "Hamming weight" also makes sense.
> 
> Anyway, the proof of correctness proceeds as follows:
> 
> 	b = a - ((a >> 1) & 0x55555555);
> 	c = (b & 0x33333333) + ((b >> 2) & 0x33333333);
> 	d = (c + (c >> 4)) & 0x0f0f0f0f;
> #if SLOW_MULTIPLY
> 	e = d + (d >> 8)
> 	f = e + (e >> 16);
> 	return f & 63;
> #else
> 	/* Useful if multiply takes at most 4 cycles */
> 	return (d * 0x01010101) >> 24;
> #endif
> 
> The input value a can be thought of as 32 1-bit fields each holding
> their own hamming weight.  Now look at it as 16 2-bit fields.
> Each 2-bit field a1..a0 has the value 2*a1 + a0.  This can be converted
> into the hamming weight of the 2-bit field a1+a0 by subtracting a1.
> 
> That's what the (a >> 1) & mask subtraction does.  Since there can be no
> borrows, you can just do it all at once.
> 
> Enumerating the 4 possible cases:
> 
> 0b00 = 0  ->  0 - 0 = 0
> 0b01 = 1  ->  1 - 0 = 1
> 0b10 = 2  ->  2 - 1 = 1
> 0b11 = 3  ->  3 - 1 = 2
> 
> 
> The next step consists of breaking up b (made of 16 2-bir fields) into
> even and odd halves and adding them into 4-bit fields.  Since the largest
> possible sum is 2+2 = 4, which will not fit into a 4-bit field, the 2-bit
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                          "which will not fit into a 2-bit field"

> fields have to be masked before they are added.
> 
> 
> After this point, the masking can be delayed.  Each 4-bit field holds
> a population count from 0..4, taking at most 3 bits.  These numbers can
> be added without overflowing a 4-bit field, so we can compute
> c + (c >> 4), and only then mask off the unwanted bits.
> 
> 
> This produces d, a number of 4 8-bit fields, each in the range 0..8.
> >From this point, we can shift and add d multiple times without overflowing
> an 8-bit field, and only do a final mask at the end.
> 
> The number to mask with has to be at least 63 (so that 32 on't be truncated),
> but can also be 128 or 255.  The x86 has a special encoding for signed
> immediate byte values -128..127, so the value of 255 is slower.  On
> other processors, a special "sign extend byte" instruction might be faster.
> 
> 
> On a processor with fast integer multiplies (Athlon but not P4), you can
> reduce the final few serially dependent instructions to a single integer
> multiply.  Consider d to be 3 8-bit values d3, d2, d1 and d0, each in the
> range 0..8.  The multiply forms the partial products:
> 
>            d3 d2 d1 d0
>         d3 d2 d1 d0
>      d3 d2 d1 d0
> + d3 d2 d1 d0
> ----------------------
>            e3 e2 e1 e0
> 
> Where e3 = d3 + d2 + d1 + d0.   e2, e1 and e0 obviously cannot generate
> any carries.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>


 lib/hweight.c |   29 ++++++++++++++---------------
 1 files changed, 14 insertions(+), 15 deletions(-)

Index: 2.6-rc/lib/hweight.c
===================================================================
--- 2.6-rc.orig/lib/hweight.c
+++ 2.6-rc/lib/hweight.c
@@ -10,28 +10,28 @@
 
 unsigned int hweight32(unsigned int w)
 {
-	unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
+	unsigned int res = w - ((w >> 1) & 0x55555555);
 	res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
-	res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
-	res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
-	return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
+	res = (res + (res >> 4)) & 0x0F0F0F0F;
+	res = res + (res >> 8);
+	return (res + (res >> 16)) & 0x000000FF;
 }
 EXPORT_SYMBOL(hweight32);
 
 unsigned int hweight16(unsigned int w)
 {
-	unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
+	unsigned int res = w - ((w >> 1) & 0x5555);
 	res = (res & 0x3333) + ((res >> 2) & 0x3333);
-	res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
-	return (res & 0x00FF) + ((res >> 8) & 0x00FF);
+	res = (res + (res >> 4)) & 0x0F0F;
+	return (res + (res >> 8)) & 0x00FF;
 }
 EXPORT_SYMBOL(hweight16);
 
 unsigned int hweight8(unsigned int w)
 {
-	unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
+	unsigned int res = w - ((w >> 1) & 0x55);
 	res = (res & 0x33) + ((res >> 2) & 0x33);
-	return (res & 0x0F) + ((res >> 4) & 0x0F);
+	return (res + (res >> 4)) & 0x0F;
 }
 EXPORT_SYMBOL(hweight8);
 
@@ -40,13 +40,12 @@ unsigned long hweight64(__u64 w)
 #if BITS_PER_LONG == 32
 	return hweight32((unsigned int)(w >> 32)) + hweight32((unsigned int)w);
 #elif BITS_PER_LONG == 64
-	u64 res;
-	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
+	__u64 res = w - ((w >> 1) & 0x5555555555555555ul);
 	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
-	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
-	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
-	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
-	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
+	res = (res + (res >> 4)) & 0x0F0F0F0F0F0F0F0Ful;
+	res = res + (res >> 8);
+	res = res + (res >> 16);
+	return (res + (res >> 32)) & 0x00000000000000FFul;
 #else
 #error BITS_PER_LONG not defined
 #endif

--
