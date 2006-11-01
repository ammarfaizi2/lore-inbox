Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752533AbWKAWos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbWKAWos (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 17:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbWKAWos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 17:44:48 -0500
Received: from ozlabs.org ([203.10.76.45]:62186 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1752533AbWKAWoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 17:44:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17737.9045.492182.85458@cargo.ozlabs.ibm.com>
Date: Thu, 2 Nov 2006 09:44:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH v2] powerpc: Eliminate "exceeds stub group size" linker warning
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that the linker warnings on 64-bit powerpc about "section
blah exceeds stub group size" were being triggered by conditional
branches in head_64.S branching to global symbols, whether in
head_64.S or in other files.  This eliminates the warnings by making
some global symbols in head_64.S no longer global, and by rearranging
some branches.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 291e362..e720729 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -487,7 +487,7 @@ BEGIN_FTR_SECTION
 	rlwimi	r13,r12,16,0x20
 	mfcr	r12
 	cmpwi	r13,0x2c
-	beq	.do_stab_bolted_pSeries
+	beq	do_stab_bolted_pSeries
 	mtcrf	0x80,r12
 	mfspr	r12,SPRN_SPRG2
 END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
@@ -600,7 +600,7 @@ #endif /* CONFIG_CBE_RAS */
 	STD_EXCEPTION_PSERIES(., performance_monitor)
 
 	.align	7
-_GLOBAL(do_stab_bolted_pSeries)
+do_stab_bolted_pSeries:
 	mtcrf	0x80,r12
 	mfspr	r12,SPRN_SPRG2
 	EXCEPTION_PROLOG_PSERIES(PACA_EXSLB, .do_stab_bolted)
@@ -1046,7 +1046,7 @@ slb_miss_fault:
 	li	r5,0
 	std	r4,_DAR(r1)
 	std	r5,_DSISR(r1)
-	b	.handle_page_fault
+	b	handle_page_fault
 
 unrecov_user_slb:
 	EXCEPTION_PROLOG_COMMON(0x4200, PACA_EXGEN)
@@ -1174,12 +1174,13 @@ program_check_common:
 	.globl fp_unavailable_common
 fp_unavailable_common:
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
-	bne	.load_up_fpu		/* if from user, just load it up */
+	bne	1f			/* if from user, just load it up */
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ENABLE_INTS
 	bl	.kernel_fp_unavailable_exception
 	BUG_OPCODE
+1:	b	.load_up_fpu
 
 	.align	7
 	.globl altivec_unavailable_common
@@ -1279,10 +1280,10 @@ _GLOBAL(do_hash_page)
 	std	r4,_DSISR(r1)
 
 	andis.	r0,r4,0xa450		/* weird error? */
-	bne-	.handle_page_fault	/* if not, try to insert a HPTE */
+	bne-	handle_page_fault	/* if not, try to insert a HPTE */
 BEGIN_FTR_SECTION
 	andis.	r0,r4,0x0020		/* Is it a segment table fault? */
-	bne-	.do_ste_alloc		/* If so handle it */
+	bne-	do_ste_alloc		/* If so handle it */
 END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 
 	/*
@@ -1324,7 +1325,7 @@ BEGIN_FW_FTR_SECTION
 	 * because ret_from_except_lite will check for and handle pending
 	 * interrupts if necessary.
 	 */
-	beq	.ret_from_except_lite
+	beq	13f
 	/* For a hash failure, we don't bother re-enabling interrupts */
 	ble-	12f
 
@@ -1346,14 +1347,14 @@ BEGIN_FW_FTR_SECTION
 END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
 
 /* Here we have a page fault that hash_page can't handle. */
-_GLOBAL(handle_page_fault)
+handle_page_fault:
 	ENABLE_INTS
 11:	ld	r4,_DAR(r1)
 	ld	r5,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_page_fault
 	cmpdi	r3,0
-	beq+	.ret_from_except_lite
+	beq+	13f
 	bl	.save_nvgprs
 	mr	r5,r3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -1370,12 +1371,14 @@ _GLOBAL(handle_page_fault)
 	bl	.low_hash_fault
 	b	.ret_from_except
 
+13:	b	.ret_from_except_lite
+
 	/* here we have a segment miss */
-_GLOBAL(do_ste_alloc)
+do_ste_alloc:
 	bl	.ste_allocate		/* try to insert stab entry */
 	cmpdi	r3,0
-	beq+	fast_exception_return
-	b	.handle_page_fault
+	bne-	handle_page_fault
+	b	fast_exception_return
 
 /*
  * r13 points to the PACA, r9 contains the saved CR,
