Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUHDXVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUHDXVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUHDXVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:21:50 -0400
Received: from ozlabs.org ([203.10.76.45]:34201 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267505AbUHDXVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:21:35 -0400
Date: Thu, 5 Aug 2004 09:18:07 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH] [ppc64] Avoid speculative execution after rfid
Message-ID: <20040804231806.GB30253@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Due to speculative execution, a CPU may execute some instructions after the
rfid. This makes profiles confusing, since profiling ticks could end up in
those instructions following the rfid that are never executed.

Add a branch to self after each rfid to avoid this.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/entry.S~rfid_no_prefetch arch/ppc64/kernel/entry.S
--- linux-2.6.8-rc2-mm2/arch/ppc64/kernel/entry.S~rfid_no_prefetch	2004-08-04 17:46:42.686872269 -0500
+++ linux-2.6.8-rc2-mm2-anton/arch/ppc64/kernel/entry.S	2004-08-04 17:46:42.702869727 -0500
@@ -194,6 +194,7 @@ syscall_exit_trace_cont:
 	mtspr	SRR0,r7
 	mtspr	SRR1,r8
 	rfid
+	b	.	/* prevent speculative execution */
 
 syscall_enosys:
 	li	r3,-ENOSYS
@@ -540,7 +541,7 @@ restore:
 	ld	r1,GPR1(r1)
 
 	rfid
-	b	.
+	b	.	/* prevent speculative execution */
 
 /* Note: this must change if we start using the TIF_NOTIFY_RESUME bit */
 do_work:
@@ -684,6 +685,7 @@ _GLOBAL(enter_rtas)
 	mtspr	SRR0,r5
 	mtspr	SRR1,r6
 	rfid
+	b	.	/* prevent speculative execution */
 
 _STATIC(rtas_return_loc)
 	/* relocation is off at this point */
@@ -704,6 +706,7 @@ _STATIC(rtas_return_loc)
 	mtspr	SRR0,r3
 	mtspr	SRR1,r4
 	rfid
+	b	.	/* prevent speculative execution */
 
 _STATIC(rtas_restore_regs)
 	/* relocation is on at this point */
diff -puN arch/ppc64/kernel/head.S~rfid_no_prefetch arch/ppc64/kernel/head.S
--- linux-2.6.8-rc2-mm2/arch/ppc64/kernel/head.S~rfid_no_prefetch	2004-08-04 17:46:42.691871475 -0500
+++ linux-2.6.8-rc2-mm2-anton/arch/ppc64/kernel/head.S	2004-08-04 17:46:42.707868932 -0500
@@ -221,7 +221,8 @@ exception_marker:
 	mtspr	SRR0,r12;						\
 	mfspr	r12,SRR1;		/* and SRR1 */			\
 	mtspr	SRR1,r10;						\
-	rfid
+	rfid;								\
+	b	.	/* prevent speculative execution */
 
 /*
  * This is the start of the interrupt handlers for iSeries
@@ -453,6 +454,7 @@ DataAccessSLB_Pseries:
 	mtspr	SRR1,r10
 	mfspr	r3,DAR
 	rfid
+	b	.	/* prevent speculative execution */
 
 	STD_EXCEPTION_PSERIES(0x400, InstructionAccess)
 
@@ -479,6 +481,7 @@ InstructionAccessSLB_Pseries:
 	mtspr	SRR1,r10
 	mr	r3,r11			/* SRR0 is faulting address */
 	rfid
+	b	.	/* prevent speculative execution */
 
 	STD_EXCEPTION_PSERIES(0x500, HardwareInterrupt)
 	STD_EXCEPTION_PSERIES(0x600, Alignment)
@@ -503,6 +506,7 @@ SystemCall_Pseries:
 	mfspr	r12,SRR1
 	mtspr	SRR1,r10
 	rfid
+	b	.	/* prevent speculative execution */
 
 	STD_EXCEPTION_PSERIES(0xd00, SingleStep)
 	STD_EXCEPTION_PSERIES(0xe00, Trap_0e)
@@ -727,6 +731,7 @@ HardwareInterrupt_Iseries_masked:
 	ld	r12,PACA_EXGEN+EX_R12(r13)
 	ld	r13,PACA_EXGEN+EX_R13(r13)
 	rfid
+	b	.	/* prevent speculative execution */
 #endif
 
 /*
@@ -867,6 +872,7 @@ fast_exception_return:
 	REST_4GPRS(10, r1)
 	ld	r1,GPR1(r1)
 	rfid
+	b	.	/* prevent speculative execution */
 
 unrecov_fer:
 	bl	.save_nvgprs
@@ -1146,6 +1152,7 @@ _GLOBAL(do_stab_bolted)
 	ld	r12,PACA_EXSLB+EX_R12(r13)
 	ld	r13,PACA_EXSLB+EX_R13(r13)
 	rfid
+	b	.	/* prevent speculative execution */
 
 /*
  * r13 points to the PACA, r9 contains the saved CR,
@@ -1190,6 +1197,7 @@ _GLOBAL(do_slb_miss)
 	ld	r12,PACA_EXSLB+EX_R12(r13)
 	ld	r13,PACA_EXSLB+EX_R13(r13)
 	rfid
+	b	.	/* prevent speculative execution */
 
 unrecov_slb:
 	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
@@ -1295,6 +1303,7 @@ _STATIC(mmu_off)
 	mtspr	SRR1,r3
 	sync
 	rfid
+	b	.	/* prevent speculative execution */
 _GLOBAL(__start_initialization_pSeries)
 	mr	r31,r3			/* save parameters */
 	mr	r30,r4
@@ -1777,6 +1786,7 @@ _GLOBAL(__secondary_start)
 	mtspr	SRR0,r3
 	mtspr	SRR1,r4
 	rfid
+	b	.	/* prevent speculative execution */
 
 /* 
  * Running with relocation on at this point.  All we want to do is
@@ -1940,6 +1950,7 @@ _STATIC(start_here_pSeries)
 	mtspr	SRR0,r3
 	mtspr	SRR1,r4
 	rfid
+	b	.	/* prevent speculative execution */
 #endif /* CONFIG_PPC_PSERIES */
 	
 	/* This is where all platforms converge execution */

_
