Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUIHFYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUIHFYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 01:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268674AbUIHFYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 01:24:09 -0400
Received: from ozlabs.org ([203.10.76.45]:52638 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267618AbUIHFX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 01:23:57 -0400
Date: Wed, 8 Sep 2004 15:11:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Handle SLB misses in realmode
Message-ID: <20040908051143.GD31597@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.  Tested on pSeries and iSeries.  Some future
plans for VSID allocation may mean we have to take this out again, but
that's a while off yet, and in the meantime it's a significant
speedup.

This patch makes the PPC64 SLB miss handler run in real mode (i.e. MMU
off) for it's whole duration, on pSeries machines.  Avoiding the rfid
used to turn relocation on saves some 70-80 cycles on Power4 and
Power5.  Not having to save and restore SRR0 and SRR1 saves a few
more, and means we don't need an extra save slot for r3.  Overall
there's around a 27% speedup on Power4.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/ppc64/kernel/head.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/head.S	2004-08-30 10:22:59.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/head.S	2004-09-07 14:42:13.108483416 +1000
@@ -199,6 +199,7 @@
 #define EX_R12		24
 #define EX_R13		32
 #define EX_SRR0		40
+#define EX_R3		40	/* SLB miss saves R3, but not SRR0 */
 #define EX_DAR		48
 #define EX_LR		48	/* SLB miss saves LR, but not DAR */
 #define EX_DSISR	56
@@ -421,21 +422,13 @@
 	std	r10,PACA_EXSLB+EX_R10(r13)
 	std	r11,PACA_EXSLB+EX_R11(r13)
 	std	r12,PACA_EXSLB+EX_R12(r13)
-	std	r3,PACASLBR3(r13)
+	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r9,SPRG1
 	std	r9,PACA_EXSLB+EX_R13(r13)
 	mfcr	r9
-	clrrdi	r12,r13,32		/* get high part of &label */
-	mfmsr	r10
-	mfspr	r11,SRR0		/* save SRR0 */
-	ori	r12,r12,(.do_slb_miss)@l
-	ori	r10,r10,MSR_IR|MSR_DR	/* DON'T set RI for SLB miss */
-	mtspr	SRR0,r12
 	mfspr	r12,SRR1		/* and SRR1 */
-	mtspr	SRR1,r10
 	mfspr	r3,DAR
-	rfid
-	b	.	/* prevent speculative execution */
+	b	.do_slb_miss		/* Rel. branch works in real mode */
 
 	STD_EXCEPTION_PSERIES(0x400, InstructionAccess)
 
@@ -449,21 +442,13 @@
 	std	r10,PACA_EXSLB+EX_R10(r13)
 	std	r11,PACA_EXSLB+EX_R11(r13)
 	std	r12,PACA_EXSLB+EX_R12(r13)
-	std	r3,PACASLBR3(r13)
+	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r9,SPRG1
 	std	r9,PACA_EXSLB+EX_R13(r13)
 	mfcr	r9
-	clrrdi	r12,r13,32		/* get high part of &label */
-	mfmsr	r10
-	mfspr	r11,SRR0		/* save SRR0 */
-	ori	r12,r12,(.do_slb_miss)@l
-	ori	r10,r10,MSR_IR|MSR_DR	/* DON'T set RI for SLB miss */
-	mtspr	SRR0,r12
 	mfspr	r12,SRR1		/* and SRR1 */
-	mtspr	SRR1,r10
-	mr	r3,r11			/* SRR0 is faulting address */
-	rfid
-	b	.	/* prevent speculative execution */
+	mfspr	r3,SRR0			/* SRR0 is faulting address */
+	b	.do_slb_miss		/* Rel. branch works in real mode */
 
 	STD_EXCEPTION_PSERIES(0x500, HardwareInterrupt)
 	STD_EXCEPTION_PSERIES(0x600, Alignment)
@@ -609,8 +594,7 @@
 DataAccessSLB_Iseries:
 	mtspr	SPRG1,r13		/* save r13 */
 	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
-	std	r3,PACASLBR3(r13)
-	ld	r11,PACALPPACA+LPPACASRR0(r13)
+	std	r3,PACA_EXSLB+EX_R3(r13)
 	ld	r12,PACALPPACA+LPPACASRR1(r13)
 	mfspr	r3,DAR
 	b	.do_slb_miss
@@ -621,10 +605,9 @@
 InstructionAccessSLB_Iseries:
 	mtspr	SPRG1,r13		/* save r13 */
 	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
-	std	r3,PACASLBR3(r13)
-	ld	r11,PACALPPACA+LPPACASRR0(r13)
+	std	r3,PACA_EXSLB+EX_R3(r13)
 	ld	r12,PACALPPACA+LPPACASRR1(r13)
-	mr	r3,r11
+	ld	r3,PACALPPACA+LPPACASRR0(r13)
 	b	.do_slb_miss
 
 	MASKABLE_EXCEPTION_ISERIES(0x500, HardwareInterrupt)
@@ -1169,7 +1152,6 @@
 	mflr	r10
 
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
-	std	r11,PACA_EXSLB+EX_SRR0(r13)	/* save SRR0 in exc. frame */
 	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
 
 	bl	.slb_allocate			/* handle it */
@@ -1177,9 +1159,11 @@
 	/* All done -- return from exception. */
 
 	ld	r10,PACA_EXSLB+EX_LR(r13)
-	ld	r3,PACASLBR3(r13)
+	ld	r3,PACA_EXSLB+EX_R3(r13)
 	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
-	ld	r11,PACA_EXSLB+EX_SRR0(r13)	/* get saved SRR0 */
+#ifdef CONFIG_PPC_ISERIES
+	ld	r11,PACALPPACA+LPPACASRR0(r13)	/* get SRR0 value */
+#endif /* CONFIG_PPC_ISERIES */
 
 	mtlr	r10
 
@@ -1192,8 +1176,10 @@
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
 .machine	pop
 
+#ifdef CONFIG_PPC_ISERIES
 	mtspr	SRR0,r11
 	mtspr	SRR1,r12
+#endif /* CONFIG_PPC_ISERIES */
 	ld	r9,PACA_EXSLB+EX_R9(r13)
 	ld	r10,PACA_EXSLB+EX_R10(r13)
 	ld	r11,PACA_EXSLB+EX_R11(r13)
Index: working-2.6/include/asm-ppc64/paca.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/paca.h	2004-08-30 10:23:00.000000000 +1000
+++ working-2.6/include/asm-ppc64/paca.h	2004-09-07 14:42:13.109483264 +1000
@@ -78,7 +78,6 @@
 	u64 exmc[8];		/* used for machine checks */
 	u64 exslb[8];		/* used for SLB/segment table misses
 				 * on the linear mapping */
-	u64 slb_r3;		/* spot to save R3 on SLB miss */
 	mm_context_t context;
 	u16 slb_cache[SLB_CACHE_ENTRIES];
 	u16 slb_cache_ptr;
Index: working-2.6/arch/ppc64/kernel/asm-offsets.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/asm-offsets.c	2004-09-07 10:38:00.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/asm-offsets.c	2004-09-07 14:42:13.109483264 +1000
@@ -94,7 +94,6 @@
 	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
 	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
-	DEFINE(PACASLBR3, offsetof(struct paca_struct, slb_r3));
 #ifdef CONFIG_HUGETLB_PAGE
 	DEFINE(PACAHTLBSEGS, offsetof(struct paca_struct, context.htlb_segs));
 #endif /* CONFIG_HUGETLB_PAGE */


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
