Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUCJD6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 22:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUCJD57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 22:57:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:50130 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261462AbUCJD5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 22:57:55 -0500
Subject: [PATCH] ppc64: Fix occasional crash at boot in OF interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078890877.9750.52.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 14:54:38 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The assembly code used to callback into Open Firmware client
interface in 32 bits mode used to backup the stack pointer in
the SPRG2 register.

That upsets Apple's implementation of Open Firmware significantly
and maybe others, causing them to crash in _some_ operations,
apparently the trigger is to cause a segment or hash table
fault, typically happens when letting that code initialize the
second display.

This patch fixes it, along with other cleanups of that asm code,
it did unnecessary register restores and backing up the stack
pointer is actually useless anyway.

Ben.

===== arch/ppc64/kernel/entry.S 1.30 vs edited =====
--- 1.30/arch/ppc64/kernel/entry.S	Mon Jan 19 17:28:26 2004
+++ edited/arch/ppc64/kernel/entry.S	Wed Mar 10 12:13:08 2004
@@ -570,11 +570,10 @@
 	 * of all registers that it saves.  We therefore save those registers
 	 * PROM might touch to the stack.  (r0, r3-r13 are caller saved)
    	 */
-	SAVE_8GPRS(2, r1)		/* Save the TOC & incoming param(s) */
-	SAVE_GPR(13, r1)		/* Save paca */
-	SAVE_8GPRS(14, r1)		/* Save the non-volatiles */
-	SAVE_10GPRS(22, r1)		/* ditto */
-
+	SAVE_8GPRS(2, r1)
+	SAVE_GPR(13, r1)
+	SAVE_8GPRS(14, r1)
+	SAVE_10GPRS(22, r1)
 	mfcr	r4
 	std	r4,_CCR(r1)
 	mfctr	r5
@@ -592,20 +591,16 @@
 	mfmsr	r11
 	std	r11,_MSR(r1)
 
-	/* Unfortunatly, the stack pointer is also clobbered, so it is saved
-	 * in the SPRG2 which allows us to restore our original state after
-	 * PROM returns.
-         */
-	mtspr	SPRG2,r1
-
-        /* put a relocation offset into r3 */
+	/* Get the PROM entrypoint */
         bl      .reloc_offset
 	LOADADDR(r12,prom)
 	sub	r12,r12,r3
-	ld	r12,PROMENTRY(r12)	/* get the prom->entry value */
+	ld	r12,PROMENTRY(r12)
 	mtlr	r12
 
-        mfmsr   r11			/* grab the current MSR */
+	/* Switch MSR to 32 bits mode
+	 */
+        mfmsr   r11
         li      r12,1
         rldicr  r12,r12,MSR_SF_LG,(63-MSR_SF_LG)
         andc    r11,r11,r12
@@ -615,22 +610,25 @@
         mtmsrd  r11
         isync
 
-	REST_8GPRS(2, r1)		/* Restore the TOC & param(s) */
-	REST_GPR(13, r1)		/* Restore paca */
-	REST_8GPRS(14, r1)		/* Restore the non-volatiles */
-	REST_10GPRS(22, r1)		/* ditto */
-	blrl				/* Entering PROM here... */
-
-	mfspr	r1,SPRG2		/* Restore the stack pointer */
-	ld	r6,_MSR(r1)		/* Restore the MSR */
-	mtmsrd	r6
+	/* Restore arguments & enter PROM here... */
+	ld	r3,GPR3(r1)
+	blrl
+
+	/* Just make sure that r1 top 32 bits didn't get
+	 * corrupt by OF
+	 */
+	rldicl	r1,r1,0,32
+
+	/* Restore the MSR (back to 64 bits) */
+	ld	r0,_MSR(r1)
+	mtmsrd	r0
         isync
 
-	REST_GPR(2, r1)			/* Restore the TOC */
-	REST_GPR(13, r1)		/* Restore paca */
-	REST_8GPRS(14, r1)		/* Restore the non-volatiles */
-	REST_10GPRS(22, r1)		/* ditto */
-
+	/* Restore other registers */
+	REST_GPR(2, r1)
+	REST_GPR(13, r1)
+	REST_8GPRS(14, r1)
+	REST_10GPRS(22, r1)
 	ld	r4,_CCR(r1)
 	mtcr	r4
 	ld	r5,_CTR(r1)
@@ -645,9 +643,10 @@
 	mtsrr0	r9
 	ld	r10,_SRR1(r1)
 	mtsrr1	r10
+	
         addi	r1,r1,PROM_FRAME_SIZE
-	ld	r0,16(r1)		/* get return address */
-
+	ld	r0,16(r1)
 	mtlr    r0
-        blr				/* return to caller */
+        blr
+	
 #endif	/* defined(CONFIG_PPC_PSERIES) */


