Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267394AbUHJB6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267394AbUHJB6r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 21:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267390AbUHJB6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 21:58:47 -0400
Received: from ozlabs.org ([203.10.76.45]:2469 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267416AbUHJB6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 21:58:30 -0400
Date: Tue, 10 Aug 2004 11:49:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, dwg@dropbear.id.au, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [ppc64] Fix SLB castout issue
Message-ID: <20040810014909.GB19776@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Anton Blanchard <anton@samba.org>, akpm@osdl.org, torvalds@osdl.org,
	dwg@dropbear.id.au, paulus@samba.org, linux-kernel@vger.kernel.org
References: <20040809204415.GG24690@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809204415.GG24690@krispykreme>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 06:44:15AM +1000, Anton Blanchard wrote:
> 
> Hi,
> 
> The SLB rewrite removed a fix for a hard to hit bug, but the SFS guys
> managed to hit it straight away. We need to check both r1 and PACAKSAVE
> or else we could cast our kernel segment out when on the irq or softirq
> stack.

Bugger, I was aware of this issue when I did the rewrite, but I
obviously forgot to come back and check it.  While doing the rewrite,
I looked at things carefully and couldn't see any reason that we need
to check against both r1 and PACAKSAVE.  We do certainly need to check
PACAKSAVE *instead* of r1, though - I thought I'd done that, but
obviously forgot to fix it up in the final patch.

Anton, can you get the SFS guys to check with the patch below.  It
reverts your patch, but then replaces the old check against r1 with a
check against PACAKSAVE - assuming I haven't missed some corner case,
I think this is a better fix.

David.

Index: working-2.6/arch/ppc64/mm/slb_low.S
===================================================================
--- working-2.6.orig/arch/ppc64/mm/slb_low.S	2004-08-10 11:14:24.000000000 +1000
+++ working-2.6/arch/ppc64/mm/slb_low.S	2004-08-10 11:50:55.343025496 +1000
@@ -36,7 +36,15 @@
 	 * First find a slot, round robin. Previously we tried to find
 	 * a free slot first but that took too long. Unfortunately we
 	 * dont have any LRU information to help us choose a slot.
+	 *
+	 * Use paca->ksave as the address of the kernel stack, because
+	 * if we're on an interrupt stack, checking against r1 could
+	 * let us throw out the real kernel stack.
 	 */
+	ld	r9,PACAKSAVE(r13)
+	srdi	r9,r9,27
+	ori	r9,r9,1			/* mangle SP for later compare */
+
 	ld	r10,PACASTABRR(r13)
 3:
 	addi	r10,r10,1
@@ -45,32 +53,18 @@
 
 	blt+	4f
 	li	r10,SLB_NUM_BOLTED
-
-	/*
-	 * Never cast out the segment for our kernel stack. Since we
+4:
+	slbmfee	r11,r10
+	/* Don't throw out the segment for our kernel stack. Since we
 	 * dont invalidate the ERAT we could have a valid translation
-	 * for the kernel stack during the first part of exception exit
-	 * which gets invalidated due to a tlbie from another cpu at a
-	 * non recoverable point (after setting srr0/1) - Anton
-	 */
-4:	slbmfee	r11,r10
-	srdi	r11,r11,27
-	/*
-	 * Use paca->ksave as the value of the kernel stack pointer,
-	 * because this is valid at all times.
+	 * for the kernel stack during the first part of exception
+	 * exit which gets invalidated due to a tlbie from another cpu
+	 * at a non recoverable point (after setting srr0/1) - Anton
+	 *
 	 * The >> 27 (rather than >> 28) is so that the LSB is the
 	 * valid bit - this way we check valid and ESID in one compare.
-	 * In order to completely close the tiny race in the context
-	 * switch (between updating r1 and updating paca->ksave),
-	 * we check against both r1 and paca->ksave.
 	 */
-	srdi	r9,r1,27
-	ori	r9,r9,1			/* mangle SP for later compare */
-	cmpd	r11,r9
-	beq-	3b
-	ld	r9,PACAKSAVE(r13)
-	srdi	r9,r9,27
-	ori	r9,r9,1
+	srdi	r11,r11,27
 	cmpd	r11,r9
 	beq-	3b
 


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
