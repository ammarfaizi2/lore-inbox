Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUCMEOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 23:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUCMEOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 23:14:21 -0500
Received: from [64.62.253.241] ([64.62.253.241]:63249 "EHLO staidm.org")
	by vger.kernel.org with ESMTP id S263040AbUCMEOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 23:14:17 -0500
Date: Fri, 12 Mar 2004 20:15:47 -0800
From: Bryan Rittmeyer <bryan@staidm.org>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] ppc32 copy_to_user dcbt fixup
Message-ID: <20040313041547.GB11512@staidm.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

copy_tofrom_user and copy_page use dcbt to prefetch source data [1].
Since at least 2.4.17, these functions have been prefetching
beyond the end of the source buffer, leading to two problems:

1. Subtly broken software cache coherency. If the area following src
was invalidate_dcache_range'd prior to submitting for DMA,
an out-of-bounds dcbt from copy_to_user of a separate slab object
may read in the area before DMA completion. When the DMA does complete,
data will not be loaded from RAM because stale data is already in cache.
Thus you get a corrupt network packet, bogus audio capture, etc.

This problem probably does not affect hardware coherent systems
(all Apple machines?). However:

2. The extra 'dcbt' wastes bus bandwidth. Worst case: on a 128 byte copy,
we currently dcbt 256 bytes. These extra loads trash cache, potentially
causing writeback of more useful data.

The attached patch attempts to reign in dcbt prefetching at the end of
copies such that we do not read beyond the src area. This change fixes 
DMA data corruption on software coherent systems and improves
performance slightly in my lame microbenchmark [2].

[1] csum_partial_copy_generic does not use dcbt/dcbz despite being
scorching hot in TCP workloads. I'm cooking up another patch to
dcb?ize it. 

[2] http://staidm.org/linux/ppc/copy_dcbt/copyuser-microbench.tar.bz2

Comments?

-Bryan


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dcbt.patch"

--- linuxppc-2.5-benh/arch/ppc/lib/string.S~	2004-03-12 14:06:50.000000000 -0800
+++ linuxppc-2.5-benh/arch/ppc/lib/string.S	2004-03-12 16:26:09.000000000 -0800
@@ -443,16 +443,16 @@
 
 #if !defined(CONFIG_8xx)
 	/* Here we decide how far ahead to prefetch the source */
+	li	r12,1
 #if MAX_COPY_PREFETCH > 1
 	/* Heuristically, for large transfers we prefetch
 	   MAX_COPY_PREFETCH cachelines ahead.  For small transfers
 	   we prefetch 1 cacheline ahead. */
 	cmpwi	r0,MAX_COPY_PREFETCH
-	li	r7,1
 	li	r3,4
 	ble	111f
-	li	r7,MAX_COPY_PREFETCH
-111:	mtctr	r7
+	li	r12,MAX_COPY_PREFETCH
+111:	mtctr	r12
 112:	dcbt	r3,r4
 	addi	r3,r3,CACHELINE_BYTES
 	bdnz	112b
@@ -462,9 +462,29 @@
 #endif /* MAX_COPY_PREFETCH */
 #endif /* CONFIG_8xx */
 
+	/* don't run dcbt on cachelines outside our src area.
+       it increases bus traffic, may displace useful data,
+       and busts software cache coherency. those factors
+       are typically worse than the extra branch.
+
+       if r5 == 0, then we have to stop dcbt when ctr <= r12.  
+       if r5 != 0 (partial bytes at end) we should do an extra
+       dcbt for them--kmalloc etc will not put multiple
+       objects within a single cacheline
+
+       -bryan at staidm org
+    */
+	cmpwi	r5,0
+	beq		52f
+	addi	r12,r12,1
+
+52:
 	mtctr	r0
 53:
 #if !defined(CONFIG_8xx)
+	mfctr	r7
+	cmplw	0,r7,r12
+	ble		54f
 	dcbt	r3,r4
 54:	dcbz	r11,r6
 #endif
--- linuxppc-2.5-benh/arch/ppc/kernel/misc.S~	2004-02-04 13:35:34.000000000 -0800
+++ linuxppc-2.5-benh/arch/ppc/kernel/misc.S	2004-03-12 17:07:52.000000000 -0800
@@ -787,15 +787,16 @@
 
 #ifndef CONFIG_8xx
 #if MAX_COPY_PREFETCH > 1
-	li	r0,MAX_COPY_PREFETCH
+	li	r12,MAX_COPY_PREFETCH
 	li	r11,4
-	mtctr	r0
+	mtctr	r12
 11:	dcbt	r11,r4
 	addi	r11,r11,L1_CACHE_LINE_SIZE
 	bdnz	11b
 #else /* MAX_L1_COPY_PREFETCH == 1 */
 	dcbt	r5,r4
 	li	r11,L1_CACHE_LINE_SIZE+4
+	li	r12,1
 #endif /* MAX_L1_COPY_PREFETCH */
 #endif /* CONFIG_8xx */
 
@@ -803,8 +804,11 @@
 	mtctr	r0
 1:
 #ifndef CONFIG_8xx
+	mfctr	r7
+	cmplw	0,r7,r12
+	ble		2f
 	dcbt	r11,r4
-	dcbz	r5,r3
+2:	dcbz	r5,r3
 #endif
 	COPY_16_BYTES
 #if L1_CACHE_LINE_SIZE >= 32

--azLHFNyN32YCQGCU--
