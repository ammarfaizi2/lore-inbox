Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUHIU61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUHIU61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUHIU4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:56:35 -0400
Received: from ozlabs.org ([203.10.76.45]:11418 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267243AbUHIUr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:47:57 -0400
Date: Tue, 10 Aug 2004 06:44:15 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: dwg@dropbear.id.au, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] Fix SLB castout issue
Message-ID: <20040809204415.GG24690@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The SLB rewrite removed a fix for a hard to hit bug, but the SFS guys
managed to hit it straight away. We need to check both r1 and PACAKSAVE
or else we could cast our kernel segment out when on the irq or softirq
stack.

Anton

===== slb_low.S 1.1 vs edited =====
--- 1.1/arch/ppc64/mm/slb_low.S	Mon Aug  2 18:00:41 2004
+++ edited/slb_low.S	Tue Aug 10 05:06:32 2004
@@ -37,9 +37,6 @@
 	 * a free slot first but that took too long. Unfortunately we
 	 * dont have any LRU information to help us choose a slot.
 	 */
-	srdi	r9,r1,27
-	ori	r9,r9,1			/* mangle SP for later compare */
-
 	ld	r10,PACASTABRR(r13)
 3:
 	addi	r10,r10,1
@@ -48,18 +45,32 @@
 
 	blt+	4f
 	li	r10,SLB_NUM_BOLTED
-4:
-	slbmfee	r11,r10
-	/* Don't throw out the segment for our kernel stack. Since we
+
+	/*
+	 * Never cast out the segment for our kernel stack. Since we
 	 * dont invalidate the ERAT we could have a valid translation
-	 * for the kernel stack during the first part of exception
-	 * exit which gets invalidated due to a tlbie from another cpu
-	 * at a non recoverable point (after setting srr0/1) - Anton
-	 *
+	 * for the kernel stack during the first part of exception exit
+	 * which gets invalidated due to a tlbie from another cpu at a
+	 * non recoverable point (after setting srr0/1) - Anton
+	 */
+4:	slbmfee	r11,r10
+	srdi	r11,r11,27
+	/*
+	 * Use paca->ksave as the value of the kernel stack pointer,
+	 * because this is valid at all times.
 	 * The >> 27 (rather than >> 28) is so that the LSB is the
 	 * valid bit - this way we check valid and ESID in one compare.
+	 * In order to completely close the tiny race in the context
+	 * switch (between updating r1 and updating paca->ksave),
+	 * we check against both r1 and paca->ksave.
 	 */
-	srdi	r11,r11,27
+	srdi	r9,r1,27
+	ori	r9,r9,1			/* mangle SP for later compare */
+	cmpd	r11,r9
+	beq-	3b
+	ld	r9,PACAKSAVE(r13)
+	srdi	r9,r9,27
+	ori	r9,r9,1
 	cmpd	r11,r9
 	beq-	3b
 
