Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUFXM2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUFXM2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 08:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbUFXM2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 08:28:31 -0400
Received: from ozlabs.org ([203.10.76.45]:14989 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264386AbUFXM21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 08:28:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16602.50659.207406.720480@cargo.ozlabs.ibm.com>
Date: Thu, 24 Jun 2004 22:15:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] Better memset
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton noticed in some traces that we were spending an awfully long
time doing a memset.  The ppc64 memset is basically unchanged from the
ppc32 version, and it only does 4-byte stores and doesn't unroll the
loop.  Here's a memset that performs a bit better.  I have been using
it for 3 weeks now, and Anton has tested it on a variety of machines,
without problems.  Please apply.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN prom-cleanup/arch/ppc64/lib/string.S g5-preempt/arch/ppc64/lib/string.S
--- prom-cleanup/arch/ppc64/lib/string.S	2003-06-15 12:12:49.000000000 +1000
+++ g5-preempt/arch/ppc64/lib/string.S	2004-05-29 21:39:26.000000000 +1000
@@ -66,28 +66,69 @@
 	blr
 
 _GLOBAL(memset)
+	neg	r0,r5
 	rlwimi	r4,r4,8,16,23
+	andi.	r0,r0,7			/* # bytes to be 8-byte aligned */
 	rlwimi	r4,r4,16,0,15
-	addi	r6,r3,-4
-	cmplwi	0,r5,4
-	blt	7f
-	stwu	r4,4(r6)
-	beqlr
-	andi.	r0,r6,3
-	add	r5,r0,r5
-	subf	r6,r0,r6
-	srwi	r0,r5,2
+	cmplw	cr1,r5,r0		/* do we get that far? */
+	rldimi	r4,r4,32,0
+	mr	r6,r3
+	mtcrf	1,r0
+	mr	r6,r3
+	blt	cr1,8f
+	beq+	3f			/* if already 8-byte aligned */
+	subf	r5,r0,r5
+	bf	31,1f
+	stb	r4,0(r6)
+	addi	r6,r6,1
+1:	bf	30,2f
+	sth	r4,0(r6)
+	addi	r6,r6,2
+2:	bf	29,3f
+	stw	r4,0(r6)
+	addi	r6,r6,4
+3:	srdi.	r0,r5,6
+	clrldi	r5,r5,58
 	mtctr	r0
-	bdz	6f
-1:	stwu	r4,4(r6)
-	bdnz	1b
-6:	andi.	r5,r5,3
-7:	cmpwi	0,r5,0
-	beqlr
-	mtctr	r5
-	addi	r6,r6,3
-8:	stbu	r4,1(r6)
-	bdnz	8b
+	beq	5f
+4:	std	r4,0(r6)
+	std	r4,8(r6)
+	std	r4,16(r6)
+	std	r4,24(r6)
+	std	r4,32(r6)
+	std	r4,40(r6)
+	std	r4,48(r6)
+	std	r4,56(r6)
+	addi	r6,r6,64
+	bdnz	4b
+5:	srwi.	r0,r5,3
+	clrlwi	r5,r5,29
+	mtcrf	1,r0
+	beq	8f
+	bf	29,6f
+	std	r4,0(r6)
+	std	r4,8(r6)
+	std	r4,16(r6)
+	std	r4,24(r6)
+	addi	r6,r6,32
+6:	bf	30,7f
+	std	r4,0(r6)
+	std	r4,8(r6)
+	addi	r6,r6,16
+7:	bf	31,8f
+	std	r4,0(r6)
+	addi	r6,r6,8
+8:	cmpwi	r5,0
+	mtcrf	1,r5
+	beqlr+
+	bf	29,9f
+	stw	r4,0(r6)
+	addi	r6,r6,4
+9:	bf	30,10f
+	sth	r4,0(r6)
+	addi	r6,r6,2
+10:	bflr	31
+	stb	r4,0(r6)
 	blr
 
 _GLOBAL(memmove)
