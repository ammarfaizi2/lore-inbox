Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267510AbUHDXhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267510AbUHDXhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267514AbUHDXhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:37:23 -0400
Received: from ozlabs.org ([203.10.76.45]:59545 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267510AbUHDXgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:36:55 -0400
Date: Thu, 5 Aug 2004 09:34:06 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH] [ppc64] Set SMT thread priority to medium for all exceptions
Message-ID: <20040804233406.GC30253@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We need to set the thread priority to medium when entering all exceptions.
We may have been executing in low priority (eg the idle loop), but
definitely do not want to remain in that priority for the duration of
the exception (eg a device interrupt).

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/head.S~add_r2_to_exceptions arch/ppc64/kernel/head.S
--- linux-2.6.8-rc2-mm2/arch/ppc64/kernel/head.S~add_r2_to_exceptions	2004-08-04 17:46:43.497877597 -0500
+++ linux-2.6.8-rc2-mm2-anton/arch/ppc64/kernel/head.S	2004-08-04 18:22:57.642084383 -0500
@@ -303,12 +303,14 @@ exception_marker:
 	. = n;						\
 	.globl label##_Pseries;				\
 label##_Pseries:					\
+	HMT_MEDIUM;					\
 	mtspr	SPRG1,r13;		/* save r13 */	\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
 
 #define STD_EXCEPTION_ISERIES(n, label, area)		\
 	.globl label##_Iseries;				\
 label##_Iseries:					\
+	HMT_MEDIUM;					\
 	mtspr	SPRG1,r13;		/* save r13 */	\
 	EXCEPTION_PROLOG_ISERIES_1(area);		\
 	EXCEPTION_PROLOG_ISERIES_2;			\
@@ -317,6 +319,7 @@ label##_Iseries:					\
 #define MASKABLE_EXCEPTION_ISERIES(n, label)				\
 	.globl label##_Iseries;						\
 label##_Iseries:							\
+	HMT_MEDIUM;							\
 	mtspr	SPRG1,r13;		/* save r13 */			\
 	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN);				\
 	lbz	r10,PACAPROFENABLED(r13);				\
@@ -410,12 +413,14 @@ __start_interrupts:
 
 	. = 0x200
 _MachineCheckPseries:
+	HMT_MEDIUM
 	mtspr	SPRG1,r13		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, MachineCheck_common)
 
 	. = 0x300
 	.globl DataAccess_Pseries
 DataAccess_Pseries:
+	HMT_MEDIUM
 	mtspr	SPRG1,r13
 BEGIN_FTR_SECTION
 	mtspr	SPRG2,r12
@@ -434,6 +439,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	. = 0x380
 	.globl DataAccessSLB_Pseries
 DataAccessSLB_Pseries:
+	HMT_MEDIUM
 	mtspr	SPRG1,r13
 	mfspr	r13,SPRG3		/* get paca address into r13 */
 	std	r9,PACA_EXSLB+EX_R9(r13)	/* save r9 - r12 */
@@ -461,6 +467,7 @@ DataAccessSLB_Pseries:
 	. = 0x480
 	.globl InstructionAccessSLB_Pseries
 InstructionAccessSLB_Pseries:
+	HMT_MEDIUM
 	mtspr	SPRG1,r13
 	mfspr	r13,SPRG3		/* get paca address into r13 */
 	std	r9,PACA_EXSLB+EX_R9(r13)	/* save r9 - r12 */
@@ -494,6 +501,7 @@ InstructionAccessSLB_Pseries:
 	. = 0xc00
 	.globl	SystemCall_Pseries
 SystemCall_Pseries:
+	HMT_MEDIUM
 	mr	r9,r13
 	mfmsr	r10
 	mfspr	r13,SPRG3
@@ -747,10 +755,12 @@ fwnmi_data_area:
 	. = 0x8000
 	.globl SystemReset_FWNMI
 SystemReset_FWNMI:
+	HMT_MEDIUM
 	mtspr	SPRG1,r13		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, SystemReset_common)
 	.globl MachineCheck_FWNMI
 MachineCheck_FWNMI:
+	HMT_MEDIUM
 	mtspr	SPRG1,r13		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, MachineCheck_common)
 

_
