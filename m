Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbUKHPiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbUKHPiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 10:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbUKHPiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 10:38:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32707 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261876AbUKHOfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:37 -0500
Date: Mon, 8 Nov 2004 14:34:17 GMT
Message-Id: <200411081434.iA8EYHGJ023508@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 4/20] FRV: Fujitsu FR-V CPU arch implementation part 2
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patches provides part 2 of an architecture implementation
for the Fujitsu FR-V CPU series, configurably as Linux or uClinux.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-arch_2-2610rc1mm3.diff
 break.S       |  713 +++++++++++++++++++++++++++++
 cmode.S       |  190 +++++++
 debug-stub.c  |  259 ++++++++++
 dma.c         |  464 ++++++++++++++++++
 entry-table.S |  277 +++++++++++
 entry.S       | 1420 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 3323 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/break.S linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/break.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/break.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/break.S	2004-11-05 14:44:36.000000000 +0000
@@ -0,0 +1,713 @@
+/* break.S: Break interrupt handling (kept separate from entry.S)
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sys.h>
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/ptrace.h>
+#include <asm/spr-regs.h>
+
+#include <asm/errno.h>
+
+#
+# the break handler has its own stack
+#
+	.section	.bss.stack
+	.globl		__break_user_context
+	.balign		8192
+__break_stack:
+	.space		(8192 - (USER_CONTEXT_SIZE + REG__DEBUG_XTRA)) & ~7
+__break_stack_tos:
+	.space		REG__DEBUG_XTRA
+__break_user_context:
+	.space		USER_CONTEXT_SIZE
+
+#
+# miscellaneous variables
+#
+	.section	.bss
+#ifdef CONFIG_MMU
+	.globl		__break_tlb_miss_real_return_info
+__break_tlb_miss_real_return_info:
+	.balign		8
+	.space		2*4			/* saved PCSR, PSR for TLB-miss handler fixup */
+#endif
+
+__break_trace_through_exceptions:
+	.space		4
+
+#define CS2_ECS1	0xe1200000
+#define CS2_USERLED	0x4
+
+.macro LEDS val,reg
+#	sethi.p		%hi(CS2_ECS1+CS2_USERLED),gr30
+#	setlo		%lo(CS2_ECS1+CS2_USERLED),gr30
+#	setlos		#~\val,\reg
+#	st		\reg,@(gr30,gr0)
+#	setlos		#0x5555,\reg
+#	sethi.p		%hi(0xffc00100),gr30
+#	setlo		%lo(0xffc00100),gr30
+#	sth		\reg,@(gr30,gr0)
+#	membar
+.endm
+
+###############################################################################
+#
+# entry point for Break Exceptions/Interrupts
+#
+###############################################################################
+	.text
+	.balign		4
+	.globl		__entry_break
+__entry_break:
+#ifdef CONFIG_MMU
+	movgs		gr31,scr3
+#endif
+	LEDS		0x1001,gr31
+
+	sethi.p		%hi(__break_user_context),gr31
+	setlo		%lo(__break_user_context),gr31
+
+	stdi		gr2,@(gr31,#REG_GR(2))
+	movsg		ccr,gr3
+	sti		gr3,@(gr31,#REG_CCR)
+
+	# catch the return from a TLB-miss handler that had single-step disabled
+	# traps will be enabled, so we have to do this now
+#ifdef CONFIG_MMU
+	movsg		bpcsr,gr3
+	sethi.p		%hi(__break_tlb_miss_return_breaks_here),gr2
+	setlo		%lo(__break_tlb_miss_return_breaks_here),gr2
+	subcc		gr2,gr3,gr0,icc0
+	beq		icc0,#2,__break_return_singlestep_tlbmiss
+#endif
+
+	# determine whether we have stepped through into an exception
+	# - we need to take special action to suspend h/w single stepping if we've done
+	#   that, so that the gdbstub doesn't get bogged down endlessly stepping through
+	#   external interrupt handling
+	movsg		bpsr,gr3
+	andicc		gr3,#BPSR_BET,gr0,icc0
+	bne		icc0,#2,__break_maybe_userspace	/* jump if PSR.ET was 1 */
+
+	LEDS		0x1003,gr2
+
+	movsg		brr,gr3
+	andicc		gr3,#BRR_ST,gr0,icc0
+	andicc.p	gr3,#BRR_SB,gr0,icc1
+	bne		icc0,#2,__break_step		/* jump if single-step caused break */
+	beq		icc1,#2,__break_continue	/* jump if BREAK didn't cause break */
+
+	LEDS		0x1007,gr2
+
+	# handle special breaks
+	movsg		bpcsr,gr3
+
+	sethi.p		%hi(__entry_return_singlestep_breaks_here),gr2
+	setlo		%lo(__entry_return_singlestep_breaks_here),gr2
+	subcc		gr2,gr3,gr0,icc0
+	beq		icc0,#2,__break_return_singlestep
+
+	bra		__break_continue
+
+
+###############################################################################
+#
+# handle BREAK instruction in kernel-mode exception epilogue
+#
+###############################################################################
+__break_return_singlestep:
+	LEDS		0x100f,gr2
+
+	# special break insn requests single-stepping to be turned back on
+	#		HERE		RETT
+	# PSR.ET	0		0
+	# PSR.PS	old PSR.S	?
+	# PSR.S		1		1
+	# BPSR.ET	0		1 (can't have caused orig excep otherwise)
+	# BPSR.BS	1		old PSR.S
+	movsg		dcr,gr2
+	sethi.p		%hi(DCR_SE),gr3
+	setlo		%lo(DCR_SE),gr3
+	or		gr2,gr3,gr2
+	movgs		gr2,dcr
+
+	movsg		psr,gr2
+	andi		gr2,#PSR_PS,gr2
+	slli		gr2,#11,gr2			/* PSR.PS -> BPSR.BS */
+	ori		gr2,#BPSR_BET,gr2		/* 1 -> BPSR.BET */
+	movgs		gr2,bpsr
+
+	# return to the invoker of the original kernel exception
+	movsg		pcsr,gr2
+	movgs		gr2,bpcsr
+
+	LEDS		0x101f,gr2
+
+	ldi		@(gr31,#REG_CCR),gr3
+	movgs		gr3,ccr
+	lddi.p		@(gr31,#REG_GR(2)),gr2
+	xor		gr31,gr31,gr31
+	movgs		gr0,brr
+#ifdef CONFIG_MMU
+	movsg		scr3,gr31
+#endif
+	rett		#1
+
+###############################################################################
+#
+# handle BREAK instruction in TLB-miss handler return path
+#
+###############################################################################
+#ifdef CONFIG_MMU
+__break_return_singlestep_tlbmiss:
+	LEDS		0x1100,gr2
+	
+	sethi.p		%hi(__break_tlb_miss_real_return_info),gr3
+	setlo		%lo(__break_tlb_miss_real_return_info),gr3
+	lddi		@(gr3,#0),gr2
+	movgs		gr2,pcsr
+	movgs		gr3,psr
+
+	bra		__break_return_singlestep
+#endif
+
+
+###############################################################################
+#
+# handle single stepping into an exception prologue from kernel mode
+# - we try and catch it whilst it is still in the main vector table
+# - if we catch it there, we have to jump to the fixup handler
+#   - there is a fixup table that has a pointer for every 16b slot in the trap
+#     table
+#
+###############################################################################
+__break_step:
+	LEDS		0x2003,gr2
+
+	# external interrupts seem to escape from the trap table before single
+	# step catches up with them
+	movsg		bpcsr,gr2
+	sethi.p		%hi(__entry_kernel_external_interrupt),gr3
+	setlo		%lo(__entry_kernel_external_interrupt),gr3
+	subcc		gr2,gr3,gr0,icc0
+	beq		icc0,#2,__break_step_kernel_external_interrupt
+
+	LEDS		0x2007,gr2
+
+	# the two main vector tables are adjacent on one 8Kb slab
+	movsg		bpcsr,gr2
+	setlos		#0xffffe000,gr3
+	and		gr2,gr3,gr2
+	sethi.p		%hi(__trap_tables),gr3
+	setlo		%lo(__trap_tables),gr3
+	subcc		gr2,gr3,gr0,icc0
+	bne		icc0,#2,__break_continue
+
+	LEDS		0x200f,gr2
+
+	# skip workaround if so requested by GDB
+	sethi.p		%hi(__break_trace_through_exceptions),gr3
+	setlo		%lo(__break_trace_through_exceptions),gr3
+	ld		@(gr3,gr0),gr3
+	subcc		gr3,gr0,gr0,icc0
+	bne		icc0,#0,__break_continue
+
+	LEDS		0x201f,gr2
+
+	# access the fixup table - there's a 1:1 mapping between the slots in the trap tables and
+	# the slots in the trap fixup tables allowing us to simply divide the offset into the
+	# former by 4 to access the latter
+	sethi.p		%hi(__trap_tables),gr3
+	setlo		%lo(__trap_tables),gr3
+	movsg		bpcsr,gr2
+	sub		gr2,gr3,gr2
+	srli.p		gr2,#2,gr2
+
+	sethi		%hi(__trap_fixup_tables),gr3
+	setlo.p		%lo(__trap_fixup_tables),gr3
+	andi		gr2,#~3,gr2
+	ld		@(gr2,gr3),gr2
+	jmpil		@(gr2,#0)
+
+# step through an internal exception from kernel mode
+	.globl		__break_step_kernel_softprog_interrupt
+__break_step_kernel_softprog_interrupt:
+	sethi.p		%hi(__entry_kernel_softprog_interrupt_reentry),gr3
+	setlo		%lo(__entry_kernel_softprog_interrupt_reentry),gr3
+	bra		__break_return_as_kernel_prologue
+
+# step through an external interrupt from kernel mode
+	.globl		__break_step_kernel_external_interrupt
+__break_step_kernel_external_interrupt:
+	sethi.p		%hi(__entry_kernel_external_interrupt_reentry),gr3
+	setlo		%lo(__entry_kernel_external_interrupt_reentry),gr3
+
+__break_return_as_kernel_prologue:
+	LEDS		0x203f,gr2
+
+	movgs		gr3,bpcsr
+
+	# do the bit we had to skip
+#ifdef CONFIG_MMU
+	movsg		ear0,gr2		/* EAR0 can get clobbered by gdb-stub (ICI/ICEI) */
+	movgs		gr2,scr2
+#endif
+
+	or.p		sp,gr0,gr2		/* set up the stack pointer */
+	subi		sp,#REG__END,sp
+	sti.p		gr2,@(sp,#REG_SP)
+
+	setlos		#REG__STATUS_STEP,gr2
+	sti		gr2,@(sp,#REG__STATUS)		/* record single step status */
+
+	# cancel single-stepping mode
+	movsg		dcr,gr2
+	sethi.p		%hi(~DCR_SE),gr3
+	setlo		%lo(~DCR_SE),gr3
+	and		gr2,gr3,gr2
+	movgs		gr2,dcr
+
+	LEDS		0x207f,gr2
+
+	ldi		@(gr31,#REG_CCR),gr3
+	movgs		gr3,ccr
+	lddi.p		@(gr31,#REG_GR(2)),gr2
+	xor		gr31,gr31,gr31
+	movgs		gr0,brr
+#ifdef CONFIG_MMU
+	movsg		scr3,gr31
+#endif
+	rett		#1
+
+# step through an internal exception from uspace mode
+	.globl		__break_step_uspace_softprog_interrupt
+__break_step_uspace_softprog_interrupt:
+	sethi.p		%hi(__entry_uspace_softprog_interrupt_reentry),gr3
+	setlo		%lo(__entry_uspace_softprog_interrupt_reentry),gr3
+	bra		__break_return_as_uspace_prologue
+
+# step through an external interrupt from kernel mode
+	.globl		__break_step_uspace_external_interrupt
+__break_step_uspace_external_interrupt:
+	sethi.p		%hi(__entry_uspace_external_interrupt_reentry),gr3
+	setlo		%lo(__entry_uspace_external_interrupt_reentry),gr3
+
+__break_return_as_uspace_prologue:
+	LEDS		0x20ff,gr2
+
+	movgs		gr3,bpcsr
+
+	# do the bit we had to skip
+	sethi.p		%hi(__kernel_frame0_ptr),gr28
+	setlo		%lo(__kernel_frame0_ptr),gr28
+	ldi.p		@(gr28,#0),gr28
+
+	setlos		#REG__STATUS_STEP,gr2
+	sti		gr2,@(gr28,#REG__STATUS)	/* record single step status */
+
+	# cancel single-stepping mode
+	movsg		dcr,gr2
+	sethi.p		%hi(~DCR_SE),gr3
+	setlo		%lo(~DCR_SE),gr3
+	and		gr2,gr3,gr2
+	movgs		gr2,dcr
+
+	LEDS		0x20fe,gr2
+
+	ldi		@(gr31,#REG_CCR),gr3
+	movgs		gr3,ccr
+	lddi.p		@(gr31,#REG_GR(2)),gr2
+	xor		gr31,gr31,gr31
+	movgs		gr0,brr
+#ifdef CONFIG_MMU
+	movsg		scr3,gr31
+#endif
+	rett		#1
+
+#ifdef CONFIG_MMU
+# step through an ITLB-miss handler from user mode
+	.globl		__break_user_insn_tlb_miss
+__break_user_insn_tlb_miss:
+	# we'll want to try the trap stub again
+	sethi.p		%hi(__trap_user_insn_tlb_miss),gr2
+	setlo		%lo(__trap_user_insn_tlb_miss),gr2
+	movgs		gr2,bpcsr
+
+__break_tlb_miss_common:
+	LEDS		0x2101,gr2
+	
+	# cancel single-stepping mode
+	movsg		dcr,gr2
+	sethi.p		%hi(~DCR_SE),gr3
+	setlo		%lo(~DCR_SE),gr3
+	and		gr2,gr3,gr2
+	movgs		gr2,dcr
+
+	# we'll swap the real return address for one with a BREAK insn so that we can re-enable
+	# single stepping on return
+	movsg		pcsr,gr2
+	sethi.p		%hi(__break_tlb_miss_real_return_info),gr3
+	setlo		%lo(__break_tlb_miss_real_return_info),gr3
+	sti		gr2,@(gr3,#0)
+
+	sethi.p		%hi(__break_tlb_miss_return_break),gr2
+	setlo		%lo(__break_tlb_miss_return_break),gr2
+	movgs		gr2,pcsr
+
+	# we also have to fudge PSR because the return BREAK is in kernel space and we want
+	# to get a BREAK fault not an access violation should the return be to userspace
+	movsg		psr,gr2
+	sti.p		gr2,@(gr3,#4)
+	ori		gr2,#PSR_PS,gr2
+	movgs		gr2,psr
+
+	LEDS		0x2102,gr2
+	
+	ldi		@(gr31,#REG_CCR),gr3
+	movgs		gr3,ccr
+	lddi		@(gr31,#REG_GR(2)),gr2
+	movsg		scr3,gr31
+	movgs		gr0,brr
+	rett		#1
+
+# step through a DTLB-miss handler from user mode
+	.globl		__break_user_data_tlb_miss
+__break_user_data_tlb_miss:
+	# we'll want to try the trap stub again
+	sethi.p		%hi(__trap_user_data_tlb_miss),gr2
+	setlo		%lo(__trap_user_data_tlb_miss),gr2
+	movgs		gr2,bpcsr
+	bra		__break_tlb_miss_common
+
+# step through an ITLB-miss handler from kernel mode
+	.globl		__break_kernel_insn_tlb_miss
+__break_kernel_insn_tlb_miss:
+	# we'll want to try the trap stub again
+	sethi.p		%hi(__trap_kernel_insn_tlb_miss),gr2
+	setlo		%lo(__trap_kernel_insn_tlb_miss),gr2
+	movgs		gr2,bpcsr
+	bra		__break_tlb_miss_common
+
+# step through a DTLB-miss handler from kernel mode
+	.globl		__break_kernel_data_tlb_miss
+__break_kernel_data_tlb_miss:
+	# we'll want to try the trap stub again
+	sethi.p		%hi(__trap_kernel_data_tlb_miss),gr2
+	setlo		%lo(__trap_kernel_data_tlb_miss),gr2
+	movgs		gr2,bpcsr
+	bra		__break_tlb_miss_common
+#endif
+
+###############################################################################
+#
+# handle debug events originating with userspace
+#
+###############################################################################
+__break_maybe_userspace:
+	LEDS		0x3003,gr2
+
+	setlos		#BPSR_BS,gr2
+	andcc		gr3,gr2,gr0,icc0
+	bne		icc0,#0,__break_continue	/* skip if PSR.S was 1 */
+
+	movsg		brr,gr2
+	andicc		gr2,#BRR_ST|BRR_SB,gr0,icc0
+	beq		icc0,#0,__break_continue	/* jump if not BREAK or single-step */
+
+	LEDS		0x3007,gr2
+
+	# do the first part of the exception prologue here
+	sethi.p		%hi(__kernel_frame0_ptr),gr28
+	setlo		%lo(__kernel_frame0_ptr),gr28
+	ldi		@(gr28,#0),gr28
+	andi		gr28,#~7,gr28
+
+	# set up the kernel stack pointer
+	sti		sp  ,@(gr28,#REG_SP)
+	ori		gr28,0,sp
+	sti		gr0 ,@(gr28,#REG_GR(28))
+
+	stdi		gr20,@(gr28,#REG_GR(20))
+	stdi		gr22,@(gr28,#REG_GR(22))
+
+	movsg		tbr,gr20
+	movsg		bpcsr,gr21
+	movsg		psr,gr22
+
+	# determine the exception type and cancel single-stepping mode
+	or		gr0,gr0,gr23
+
+	movsg		dcr,gr2
+	sethi.p		%hi(DCR_SE),gr3
+	setlo		%lo(DCR_SE),gr3
+	andcc		gr2,gr3,gr0,icc0
+	beq		icc0,#0,__break_no_user_sstep	/* must have been a BREAK insn */
+
+	not		gr3,gr3
+	and		gr2,gr3,gr2
+	movgs		gr2,dcr
+	ori		gr23,#REG__STATUS_STEP,gr23
+
+__break_no_user_sstep:
+	LEDS		0x300f,gr2
+
+	movsg		brr,gr2
+	andi		gr2,#BRR_ST|BRR_SB,gr2
+	slli		gr2,#1,gr2
+	or		gr23,gr2,gr23
+	sti.p		gr23,@(gr28,#REG__STATUS)	/* record single step status */
+
+	# adjust the value acquired from TBR - this indicates the exception
+	setlos		#~TBR_TT,gr2
+	and.p		gr20,gr2,gr20
+	setlos		#TBR_TT_BREAK,gr2
+	or.p		gr20,gr2,gr20
+
+	# fudge PSR.PS and BPSR.BS to return to kernel mode through the trap
+	# table as trap 126
+	andi		gr22,#~PSR_PS,gr22		/* PSR.PS should be 0 */
+	movgs		gr22,psr
+
+	setlos		#BPSR_BS,gr2			/* BPSR.BS should be 1 and BPSR.BET 0 */
+	movgs		gr2,bpsr
+
+	# return through remainder of the exception prologue
+	sethi.p		%hi(__entry_common),gr3
+	setlo		%lo(__entry_common),gr3
+	movgs		gr3,bpcsr
+
+	LEDS		0x301f,gr2
+
+	ldi		@(gr31,#REG_CCR),gr3
+	movgs		gr3,ccr
+	lddi.p		@(gr31,#REG_GR(2)),gr2
+	xor		gr31,gr31,gr31
+	movgs		gr0,brr
+#ifdef CONFIG_MMU
+	movsg		scr3,gr31
+#endif
+	rett		#1
+
+###############################################################################
+#
+# resume normal debug-mode entry
+#
+###############################################################################
+__break_continue:
+	LEDS		0x4003,gr2
+
+	# set up the kernel stack pointer
+	sti		sp,@(gr31,#REG_SP)
+
+	sethi.p		%hi(__break_stack_tos),sp
+	setlo		%lo(__break_stack_tos),sp
+
+	# finish building the exception frame
+	stdi		gr4 ,@(gr31,#REG_GR(4))
+	stdi		gr6 ,@(gr31,#REG_GR(6))
+	stdi		gr8 ,@(gr31,#REG_GR(8))
+	stdi		gr10,@(gr31,#REG_GR(10))
+	stdi		gr12,@(gr31,#REG_GR(12))
+	stdi		gr14,@(gr31,#REG_GR(14))
+	stdi		gr16,@(gr31,#REG_GR(16))
+	stdi		gr18,@(gr31,#REG_GR(18))
+	stdi		gr20,@(gr31,#REG_GR(20))
+	stdi		gr22,@(gr31,#REG_GR(22))
+	stdi		gr24,@(gr31,#REG_GR(24))
+	stdi		gr26,@(gr31,#REG_GR(26))
+	sti		gr0 ,@(gr31,#REG_GR(28))	/* NULL frame pointer */
+	sti		gr29,@(gr31,#REG_GR(29))
+	sti		gr30,@(gr31,#REG_GR(30))
+	sti		gr8 ,@(gr31,#REG_ORIG_GR8)
+
+#ifdef CONFIG_MMU
+	movsg		scr3,gr19
+	sti		gr19,@(gr31,#REG_GR(31))
+#endif
+
+	movsg		bpsr ,gr19
+	movsg		tbr  ,gr20
+	movsg		bpcsr,gr21
+	movsg		psr  ,gr22
+	movsg		isr  ,gr23
+	movsg		cccr ,gr25
+	movsg		lr   ,gr26
+	movsg		lcr  ,gr27
+
+	andi.p		gr22,#~(PSR_S|PSR_ET),gr5	/* rebuild PSR */
+	andi		gr19,#PSR_ET,gr4
+	or.p		gr4,gr5,gr5
+	srli		gr19,#10,gr4
+	andi		gr4,#PSR_S,gr4
+	or.p		gr4,gr5,gr5
+
+	setlos		#-1,gr6
+	sti		gr20,@(gr31,#REG_TBR)
+	sti		gr21,@(gr31,#REG_PC)
+	sti		gr5 ,@(gr31,#REG_PSR)
+	sti		gr23,@(gr31,#REG_ISR)
+	sti		gr25,@(gr31,#REG_CCCR)
+	stdi		gr26,@(gr31,#REG_LR)
+	sti		gr6 ,@(gr31,#REG_SYSCALLNO)
+
+	# store CPU-specific regs
+	movsg		iacc0h,gr4
+	movsg		iacc0l,gr5
+	stdi		gr4,@(gr31,#REG_IACC0)
+
+	movsg		gner0,gr4
+	movsg		gner1,gr5
+	stdi		gr4,@(gr31,#REG_GNER0)
+
+	# build the debug register frame
+	movsg		brr,gr4
+	movgs		gr0,brr
+	movsg		nmar,gr5
+	movsg		dcr,gr6
+
+	stdi		gr4 ,@(gr31,#REG_BRR)
+	sti		gr19,@(gr31,#REG_BPSR)
+	sti.p		gr6 ,@(gr31,#REG_DCR)
+
+	# trap exceptions during break handling and disable h/w breakpoints/watchpoints
+	sethi		%hi(DCR_EBE),gr5
+	setlo.p		%lo(DCR_EBE),gr5
+	sethi		%hi(__entry_breaktrap_table),gr4
+	setlo		%lo(__entry_breaktrap_table),gr4
+	movgs		gr5,dcr
+	movgs		gr4,tbr
+
+	# set up kernel global registers
+	sethi.p		%hi(__kernel_current_task),gr5
+	setlo		%lo(__kernel_current_task),gr5
+	ld		@(gr5,gr0),gr29
+	ldi.p		@(gr29,#4),gr15		; __current_thread_info = current->thread_info
+
+	sethi		%hi(_gp),gr16
+	setlo.p		%lo(_gp),gr16
+
+	# make sure we (the kernel) get div-zero and misalignment exceptions
+	setlos		#ISR_EDE|ISR_DTT_DIVBYZERO|ISR_EMAM_EXCEPTION,gr5
+	movgs		gr5,isr
+
+	# enter the GDB stub
+	LEDS		0x4007,gr2
+
+	or.p		gr0,gr0,fp
+	call		debug_stub
+
+	LEDS		0x403f,gr2
+
+	# return from break
+	lddi		@(gr31,#REG_IACC0),gr4
+	movgs		gr4,iacc0h
+	movgs		gr5,iacc0l
+
+	lddi		@(gr31,#REG_GNER0),gr4
+	movgs		gr4,gner0
+	movgs		gr5,gner1
+
+	lddi		@(gr31,#REG_LR)  ,gr26
+	lddi		@(gr31,#REG_CCR) ,gr24
+	lddi		@(gr31,#REG_PSR) ,gr22
+	ldi		@(gr31,#REG_PC)  ,gr21
+	ldi		@(gr31,#REG_TBR) ,gr20
+	ldi.p		@(gr31,#REG_DCR) ,gr6
+
+	andi		gr22,#PSR_S,gr19		/* rebuild BPSR */
+	andi.p		gr22,#PSR_ET,gr5
+	slli		gr19,#10,gr19
+	or		gr5,gr19,gr19
+
+	movgs		gr6 ,dcr
+	movgs		gr19,bpsr
+	movgs		gr20,tbr
+	movgs		gr21,bpcsr
+	movgs		gr23,isr
+	movgs		gr24,ccr
+	movgs		gr25,cccr
+	movgs		gr26,lr
+	movgs		gr27,lcr
+
+	LEDS		0x407f,gr2
+
+#ifdef CONFIG_MMU
+	ldi		@(gr31,#REG_GR(31)),gr2
+	movgs		gr2,scr3
+#endif
+
+	ldi		@(gr31,#REG_GR(30)),gr30
+	ldi		@(gr31,#REG_GR(29)),gr29
+	lddi		@(gr31,#REG_GR(26)),gr26
+	lddi		@(gr31,#REG_GR(24)),gr24
+	lddi		@(gr31,#REG_GR(22)),gr22
+	lddi		@(gr31,#REG_GR(20)),gr20
+	lddi		@(gr31,#REG_GR(18)),gr18
+	lddi		@(gr31,#REG_GR(16)),gr16
+	lddi		@(gr31,#REG_GR(14)),gr14
+	lddi		@(gr31,#REG_GR(12)),gr12
+	lddi		@(gr31,#REG_GR(10)),gr10
+	lddi		@(gr31,#REG_GR(8)) ,gr8
+	lddi		@(gr31,#REG_GR(6)) ,gr6
+	lddi		@(gr31,#REG_GR(4)) ,gr4
+	lddi		@(gr31,#REG_GR(2)) ,gr2
+	ldi.p		@(gr31,#REG_SP)    ,sp
+
+	xor		gr31,gr31,gr31
+	movgs		gr0,brr
+#ifdef CONFIG_MMU
+	movsg		scr3,gr31
+#endif
+	rett		#1
+
+###################################################################################################
+#
+# GDB stub "system calls"
+#
+###################################################################################################
+
+#ifdef CONFIG_GDBSTUB
+	# void gdbstub_console_write(struct console *con, const char *p, unsigned n)
+	.globl		gdbstub_console_write
+gdbstub_console_write:
+	break
+	bralr
+#endif
+
+	# GDB stub BUG() trap
+	# GR8 is the proposed signal number
+	.globl		__debug_bug_trap
+__debug_bug_trap:
+	break
+	bralr
+
+	# transfer kernel exeception to GDB for handling
+	.globl		__break_hijack_kernel_event
+__break_hijack_kernel_event:
+	break
+	.globl		__break_hijack_kernel_event_breaks_here
+__break_hijack_kernel_event_breaks_here:
+	nop
+
+#ifdef CONFIG_MMU
+	# handle a return from TLB-miss that requires single-step reactivation
+	.globl		__break_tlb_miss_return_break
+__break_tlb_miss_return_break:
+	break
+__break_tlb_miss_return_breaks_here:
+	nop
+#endif
+
+	# guard the first .text label in the next file from confusion
+	nop
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/cmode.S linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/cmode.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/cmode.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/cmode.S	2004-11-05 14:13:03.070566125 +0000
@@ -0,0 +1,190 @@
+/* cmode.S: clock mode management
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Woodhouse (dwmw2@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/sys.h>
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/ptrace.h>
+#include <asm/errno.h>
+#include <asm/cache.h>
+#include <asm/spr-regs.h>
+	
+#define __addr_MASK	0xfeff9820	/* interrupt controller mask */
+
+#define __addr_SDRAMC	0xfe000400	/* SDRAM controller regs */
+#define SDRAMC_DSTS	0x28		/* SDRAM status */
+#define SDRAMC_DSTS_SSI	0x00000001	/* indicates that the SDRAM is in self-refresh mode */
+#define SDRAMC_DRCN	0x30		/* SDRAM refresh control */
+#define SDRAMC_DRCN_SR	0x00000001	/* transition SDRAM into self-refresh mode */
+#define __addr_CLKC	0xfeff9a00
+#define CLKC_SWCMODE	0x00000008
+#define __addr_LEDS	0xe1200004	
+
+.macro li v r
+	sethi.p		%hi(\v),\r
+	setlo		%lo(\v),\r
+.endm
+
+	.text
+	.balign		4
+
+	
+###############################################################################
+#
+# Change CMODE
+# - void frv_change_cmode(int cmode)
+#
+###############################################################################
+	.globl		frv_change_cmode
+        .type		frv_change_cmode,@function
+
+.macro	LEDS v
+#ifdef DEBUG_CMODE
+	setlos	#~\v,gr10
+	sti	gr10,@(gr11,#0)
+	membar
+#endif
+.endm
+		
+frv_change_cmode:	
+	movsg		lr,gr9
+#ifdef DEBUG_CMODE
+	li		__addr_LEDS,gr11
+#endif
+	dcef		@(gr0,gr0),#1
+
+	# Shift argument left by 24 bits to fit in SWCMODE register later.
+	slli		gr8,#24,gr8
+
+	# (1) Set '0' in the PSR.ET bit, and prohibit interrupts. 
+	movsg		psr,gr14
+	andi		gr14,#~PSR_ET,gr3
+	movgs		gr3,psr
+
+#if 0 // Fujitsu recommend to skip this and will update docs.
+	# (2) Set '0' to all bits of the MASK register of the interrupt 
+	#     controller, and mask interrupts. 
+	li		__addr_MASK,gr12
+	ldi		@(gr12,#0),gr13
+	li		0xffff0000,gr4
+	sti		gr4,@(gr12,#0)
+#endif
+	
+	# (3) Stop the transfer function of DMAC. Stop all the bus masters 
+	#     to access SDRAM and the internal resources.
+
+	# (already done by caller)
+	
+	# (4) Preload a series of following instructions to the instruction
+	#     cache. 
+	li		#__cmode_icache_lock_start,gr3
+	li		#__cmode_icache_lock_end,gr4
+
+1:	icpl		gr3,gr0,#1
+	addi		gr3,#L1_CACHE_BYTES,gr3
+	cmp		gr4,gr3,icc0
+	bhi		icc0,#0,1b
+
+	# Set up addresses in regs for later steps.
+	setlos		SDRAMC_DRCN_SR,gr3
+	li		__addr_SDRAMC,gr4
+	li		__addr_CLKC,gr5
+	ldi		@(gr5,#0),gr6
+	li		#0x80000000,gr7
+	or		gr6,gr7,gr6
+	
+	bra		__cmode_icache_lock_start
+
+	.balign	L1_CACHE_BYTES
+__cmode_icache_lock_start:		
+
+	# (5) Flush the content of all caches by the DCEF instruction. 
+	dcef		@(gr0,gr0),#1
+
+	# (6) Execute loading the dummy for SDRAM.
+	ldi		@(gr9,#0),gr0
+
+	# (7) Set '1' to the DRCN.SR bit, and change SDRAM to the 
+	#     self-refresh mode. Execute the dummy load to all memory
+	#     devices set to cacheable on the external bus side in parallel
+	#     with this.
+	sti		gr3,@(gr4,#SDRAMC_DRCN)
+
+	# (8) Execute memory barrier instruction (MEMBAR).
+	membar
+	
+	# (9) Read the DSTS register repeatedly until '1' stands in the 
+	#     DSTS.SSI field.
+1:	ldi		@(gr4,#SDRAMC_DSTS),gr3
+	andicc		gr3,#SDRAMC_DSTS_SSI,gr3,icc0
+	beq		icc0,#0,1b
+
+	# (10) Execute memory barrier instruction (MEMBAR).
+	membar
+	
+#if 1
+	# (11) Set the value of CMODE that you want to change to 
+	#      SWCMODE.SWCM[3:0].
+	sti		gr8,@(gr5,#CLKC_SWCMODE)
+
+	# (12) Set '1' to the CLKC.SWEN bit. In that case, do not change 
+	#      fields other than SWEN of the CLKC register.
+	sti		gr6,@(gr5,#0)
+#endif
+	# (13) Execute the instruction just after the memory barrier 
+	# instruction that executes the self-loop 256 times. (Meanwhile,
+	# the CMODE switch is done.) 
+	membar
+	setlos		#256,gr7
+2:	subicc		gr7,#1,gr7,icc0
+	bne		icc0,#2,2b
+
+	LEDS	0x36	
+
+	# (14) Release the self-refresh of SDRAM.
+	sti		gr0,@(gr4,#SDRAMC_DRCN)
+
+	# Wait for it...
+3:	ldi		@(gr4,#SDRAMC_DSTS),gr3
+	andicc		gr3,#SDRAMC_DSTS_SSI,gr3,icc0
+	bne		icc0,#2,3b
+
+#if 0
+	li		0x0100000,gr10
+4:	subicc		gr10,#1,gr10,icc0
+
+	bne		icc0,#0,4b
+#endif
+
+__cmode_icache_lock_end:		
+
+	li		#__cmode_icache_lock_start,gr3
+	li		#__cmode_icache_lock_end,gr4
+
+4:	icul		gr3
+	addi		gr3,#L1_CACHE_BYTES,gr3
+	cmp		gr4,gr3,icc0
+	bhi		icc0,#0,4b
+
+#if 0 // Fujitsu recommend to skip this and will update docs.
+	# (15) Release the interrupt mask setting of the MASK register of 
+	# the interrupt controller if necessary.
+	sti		gr13,@(gr12,#0)
+#endif	
+	# (16) Set  1' in the PSR.ET bit, and permit interrupt.
+	movgs		gr14,psr
+
+	bralr
+	
+	.size		frv_change_cmode, .-frv_change_cmode
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/debug-stub.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/debug-stub.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/debug-stub.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/debug-stub.c	2004-11-05 16:28:59.087204150 +0000
@@ -0,0 +1,259 @@
+/* debug-stub.c: debug-mode stub
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/serial_reg.h>
+
+#include <asm/system.h>
+#include <asm/serial-regs.h>
+#include <asm/timer-regs.h>
+#include <asm/irc-regs.h>
+#include <asm/gdb-stub.h>
+#include "gdb-io.h"
+
+/* CPU board CON5 */
+#define __UART0(X) (*(volatile uint8_t *)(UART0_BASE + (UART_##X)))
+
+#define LSR_WAIT_FOR0(STATE)			\
+do {						\
+} while (!(__UART0(LSR) & UART_LSR_##STATE))
+
+#define FLOWCTL_QUERY0(LINE)	({ __UART0(MSR) & UART_MSR_##LINE; })
+#define FLOWCTL_CLEAR0(LINE)	do { __UART0(MCR) &= ~UART_MCR_##LINE; } while (0)
+#define FLOWCTL_SET0(LINE)	do { __UART0(MCR) |= UART_MCR_##LINE; } while (0)
+
+#define FLOWCTL_WAIT_FOR0(LINE)			\
+do {						\
+	gdbstub_do_rx();			\
+} while(!FLOWCTL_QUERY(LINE))
+
+static void __init debug_stub_init(void);
+
+extern asmlinkage void __break_hijack_kernel_event(void);
+extern asmlinkage void __break_hijack_kernel_event_breaks_here(void);
+
+/*****************************************************************************/
+/*
+ * debug mode handler stub
+ * - we come here with the CPU in debug mode and with exceptions disabled
+ * - handle debugging services for userspace
+ */
+asmlinkage void debug_stub(void)
+{
+	unsigned long hsr0;
+	int type = 0;
+
+	static u8 inited = 0;
+	if (!inited) {
+		debug_stub_init();
+		type = -1;
+		inited = 1;
+	}
+
+	hsr0 = __get_HSR(0);
+	if (hsr0 & HSR0_ETMD)
+		__set_HSR(0, hsr0 & ~HSR0_ETMD);
+
+	/* disable single stepping */
+	__debug_regs->dcr &= ~DCR_SE;
+
+	/* kernel mode can propose an exception be handled in debug mode by jumping to a special
+	 * location */
+	if (__debug_frame->pc == (unsigned long) __break_hijack_kernel_event_breaks_here) {
+		/* replace the debug frame with the kernel frame and discard
+		 * the top kernel context */
+		*__debug_frame = *__frame;
+		__frame = __debug_frame->next_frame;
+		__debug_regs->brr = (__debug_frame->tbr & TBR_TT) << 12;
+		__debug_regs->brr |= BRR_EB;
+	}
+
+	if (__debug_frame->pc == (unsigned long) __debug_bug_trap + 4) {
+		__debug_frame->pc = __debug_frame->lr;
+		type = __debug_frame->gr8;
+	}
+
+#ifdef CONFIG_GDBSTUB
+	gdbstub(type);
+#endif
+
+	if (hsr0 & HSR0_ETMD)
+		__set_HSR(0, __get_HSR(0) | HSR0_ETMD);
+
+} /* end debug_stub() */
+
+/*****************************************************************************/
+/*
+ * debug stub initialisation
+ */
+static void __init debug_stub_init(void)
+{
+	__set_IRR(6, 0xff000000);	/* map ERRs to NMI */
+	__set_IITMR(1, 0x20000000);	/* ERR0/1, UART0/1 IRQ detect levels */
+
+	asm volatile("	movgs	gr0,ibar0	\n"
+		     "	movgs	gr0,ibar1	\n"
+		     "	movgs	gr0,ibar2	\n"
+		     "	movgs	gr0,ibar3	\n"
+		     "	movgs	gr0,dbar0	\n"
+		     "	movgs	gr0,dbmr00	\n"
+		     "	movgs	gr0,dbmr01	\n"
+		     "	movgs	gr0,dbdr00	\n"
+		     "	movgs	gr0,dbdr01	\n"
+		     "	movgs	gr0,dbar1	\n"
+		     "	movgs	gr0,dbmr10	\n"
+		     "	movgs	gr0,dbmr11	\n"
+		     "	movgs	gr0,dbdr10	\n"
+		     "	movgs	gr0,dbdr11	\n"
+		     );
+
+	/* deal with debugging stub initialisation and initial pause */
+	if (__debug_frame->pc == (unsigned long) __debug_stub_init_break)
+		__debug_frame->pc = (unsigned long) start_kernel;
+
+	/* enable the debug events we want to trap */
+	__debug_regs->dcr = DCR_EBE;
+
+#ifdef CONFIG_GDBSTUB
+	gdbstub_init();
+#endif
+
+	__clr_MASK_all();
+	__clr_MASK(15);
+	__clr_RC(15);
+
+} /* end debug_stub_init() */
+
+/*****************************************************************************/
+/*
+ * kernel "exit" trap for gdb stub
+ */
+void debug_stub_exit(int status)
+{
+
+#ifdef CONFIG_GDBSTUB
+	gdbstub_exit(status);
+#endif
+
+} /* end debug_stub_exit() */
+
+/*****************************************************************************/
+/*
+ * send string to serial port
+ */
+void debug_to_serial(const char *p, int n)
+{
+	char ch;
+
+	for (; n > 0; n--) {
+		ch = *p++;
+		FLOWCTL_SET0(DTR);
+		LSR_WAIT_FOR0(THRE);
+		// FLOWCTL_WAIT_FOR(CTS);
+
+		if (ch == 0x0a) {
+			__UART0(TX) = 0x0d;
+			mb();
+			LSR_WAIT_FOR0(THRE);
+			// FLOWCTL_WAIT_FOR(CTS);
+		}
+		__UART0(TX) = ch;
+		mb();
+
+		FLOWCTL_CLEAR0(DTR);
+	}
+
+} /* end debug_to_serial() */
+
+/*****************************************************************************/
+/*
+ * send string to serial port
+ */
+void debug_to_serial2(const char *fmt, ...)
+{
+	va_list va;
+	char buf[64];
+	int n;
+
+	va_start(va, fmt);
+	n = vsprintf(buf, fmt, va);
+	va_end(va);
+
+	debug_to_serial(buf, n);
+
+} /* end debug_to_serial2() */
+
+/*****************************************************************************/
+/*
+ * set up the ttyS0 serial port baud rate timers
+ */
+void __init console_set_baud(unsigned baud)
+{
+	unsigned value, high, low;
+	u8 lcr;
+
+	/* work out the divisor to give us the nearest higher baud rate */
+	value = __serial_clock_speed_HZ / 16 / baud;
+
+	/* determine the baud rate range */
+	high = __serial_clock_speed_HZ / 16 / value;
+	low = __serial_clock_speed_HZ / 16 / (value + 1);
+
+	/* pick the nearest bound */
+	if (low + (high - low) / 2 > baud)
+		value++;
+
+	lcr = __UART0(LCR);
+	__UART0(LCR) |= UART_LCR_DLAB;
+	mb();
+	__UART0(DLL) = value & 0xff;
+	__UART0(DLM) = (value >> 8) & 0xff;
+	mb();
+	__UART0(LCR) = lcr;
+	mb();
+
+} /* end console_set_baud() */
+
+/*****************************************************************************/
+/*
+ *
+ */
+int __init console_get_baud(void)
+{
+	unsigned value;
+	u8 lcr;
+
+	lcr = __UART0(LCR);
+	__UART0(LCR) |= UART_LCR_DLAB;
+	mb();
+	value =  __UART0(DLM) << 8;
+	value |= __UART0(DLL);
+	__UART0(LCR) = lcr;
+	mb();
+
+	return value;
+} /* end console_get_baud() */
+
+/*****************************************************************************/
+/*
+ * display BUG() info
+ */
+#ifndef CONFIG_NO_KERNEL_MSG
+void __debug_bug_printk(const char *file, unsigned line)
+{
+	printk("kernel BUG at %s:%d!\n", file, line);
+
+} /* end __debug_bug_printk() */
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/dma.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/dma.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/dma.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/dma.c	2004-11-05 14:13:03.073565872 +0000
@@ -0,0 +1,464 @@
+/* dma.c: DMA controller management on FR401 and the like
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <asm/dma.h>
+#include <asm/gpio-regs.h>
+#include <asm/irc-regs.h>
+#include <asm/cpu-irqs.h>
+
+struct frv_dma_channel {
+	uint8_t			flags;
+#define FRV_DMA_FLAGS_RESERVED	0x01
+#define FRV_DMA_FLAGS_INUSE	0x02
+#define FRV_DMA_FLAGS_PAUSED	0x04
+	uint8_t			cap;		/* capabilities available */
+	int			irq;		/* completion IRQ */
+	uint32_t		dreqbit;
+	uint32_t		dackbit;
+	uint32_t		donebit;
+	const unsigned long	ioaddr;		/* DMA controller regs addr */
+	const char		*devname;
+	dma_irq_handler_t	handler;
+	void			*data;
+};
+
+
+#define __get_DMAC(IO,X)	({ *(volatile unsigned long *)((IO) + DMAC_##X##x); })
+
+#define __set_DMAC(IO,X,V)					\
+do {								\
+	*(volatile unsigned long *)((IO) + DMAC_##X##x) = (V);	\
+	mb();							\
+} while(0)
+
+#define ___set_DMAC(IO,X,V)					\
+do {								\
+	*(volatile unsigned long *)((IO) + DMAC_##X##x) = (V);	\
+} while(0)
+
+
+static struct frv_dma_channel frv_dma_channels[FRV_DMA_NCHANS] = {
+	[0] = {
+		.cap		= FRV_DMA_CAP_DREQ | FRV_DMA_CAP_DACK | FRV_DMA_CAP_DONE,
+		.irq		= IRQ_CPU_DMA0,
+		.dreqbit	= SIR_DREQ0_INPUT,
+		.dackbit	= SOR_DACK0_OUTPUT,
+		.donebit	= SOR_DONE0_OUTPUT,
+		.ioaddr		= 0xfe000900,
+	},
+	[1] = {
+		.cap		= FRV_DMA_CAP_DREQ | FRV_DMA_CAP_DACK | FRV_DMA_CAP_DONE,
+		.irq		= IRQ_CPU_DMA1,
+		.dreqbit	= SIR_DREQ1_INPUT,
+		.dackbit	= SOR_DACK1_OUTPUT,
+		.donebit	= SOR_DONE1_OUTPUT,
+		.ioaddr		= 0xfe000980,
+	},
+	[2] = {
+		.cap		= FRV_DMA_CAP_DREQ | FRV_DMA_CAP_DACK,
+		.irq		= IRQ_CPU_DMA2,
+		.dreqbit	= SIR_DREQ2_INPUT,
+		.dackbit	= SOR_DACK2_OUTPUT,
+		.ioaddr		= 0xfe000a00,
+	},
+	[3] = {
+		.cap		= FRV_DMA_CAP_DREQ | FRV_DMA_CAP_DACK,
+		.irq		= IRQ_CPU_DMA3,
+		.dreqbit	= SIR_DREQ3_INPUT,
+		.dackbit	= SOR_DACK3_OUTPUT,
+		.ioaddr		= 0xfe000a80,
+	},
+	[4] = {
+		.cap		= FRV_DMA_CAP_DREQ,
+		.irq		= IRQ_CPU_DMA4,
+		.dreqbit	= SIR_DREQ4_INPUT,
+		.ioaddr		= 0xfe001000,
+	},
+	[5] = {
+		.cap		= FRV_DMA_CAP_DREQ,
+		.irq		= IRQ_CPU_DMA5,
+		.dreqbit	= SIR_DREQ5_INPUT,
+		.ioaddr		= 0xfe001080,
+	},
+	[6] = {
+		.cap		= FRV_DMA_CAP_DREQ,
+		.irq		= IRQ_CPU_DMA6,
+		.dreqbit	= SIR_DREQ6_INPUT,
+		.ioaddr		= 0xfe001100,
+	},
+	[7] = {
+		.cap		= FRV_DMA_CAP_DREQ,
+		.irq		= IRQ_CPU_DMA7,
+		.dreqbit	= SIR_DREQ7_INPUT,
+		.ioaddr		= 0xfe001180,
+	},
+};
+
+static rwlock_t frv_dma_channels_lock = RW_LOCK_UNLOCKED;
+
+unsigned long frv_dma_inprogress;
+
+#define frv_clear_dma_inprogress(channel) \
+	atomic_clear_mask(1 << (channel), &frv_dma_inprogress);
+
+#define frv_set_dma_inprogress(channel) \
+	atomic_set_mask(1 << (channel), &frv_dma_inprogress);
+
+/*****************************************************************************/
+/*
+ * DMA irq handler - determine channel involved, grab status and call real handler
+ */
+static irqreturn_t dma_irq_handler(int irq, void *_channel, struct pt_regs *regs)
+{
+	struct frv_dma_channel *channel = _channel;
+
+	frv_clear_dma_inprogress(channel - frv_dma_channels);
+	return channel->handler(channel - frv_dma_channels,
+				__get_DMAC(channel->ioaddr, CSTR),
+				channel->data,
+				regs);
+
+} /* end dma_irq_handler() */
+
+/*****************************************************************************/
+/*
+ * Determine which DMA controllers are present on this CPU
+ */
+void __init frv_dma_init(void)
+{
+	unsigned long psr = __get_PSR();
+	int num_dma, i;
+
+	/* First, determine how many DMA channels are available */
+	switch (PSR_IMPLE(psr)) {
+	case PSR_IMPLE_FR405:
+	case PSR_IMPLE_FR451:
+	case PSR_IMPLE_FR501:
+	case PSR_IMPLE_FR551:
+		num_dma = FRV_DMA_8CHANS;
+		break;
+
+	case PSR_IMPLE_FR401:
+	default:
+		num_dma = FRV_DMA_4CHANS;
+		break;
+	}
+
+	/* Now mark all of the non-existent channels as reserved */
+	for(i = num_dma; i < FRV_DMA_NCHANS; i++)
+		frv_dma_channels[i].flags = FRV_DMA_FLAGS_RESERVED;
+
+} /* end frv_dma_init() */
+
+/*****************************************************************************/
+/*
+ * allocate a DMA controller channel and the IRQ associated with it
+ */
+int frv_dma_open(const char *devname,
+		 unsigned long dmamask,
+		 int dmacap,
+		 dma_irq_handler_t handler,
+		 unsigned long irq_flags,
+		 void *data)
+{
+	struct frv_dma_channel *channel;
+	int dma, ret;
+	uint32_t val;
+
+	write_lock(&frv_dma_channels_lock);
+
+	ret = -ENOSPC;
+
+	for (dma = FRV_DMA_NCHANS - 1; dma >= 0; dma--) {
+		channel = &frv_dma_channels[dma];
+
+		if (!test_bit(dma, &dmamask))
+			continue;
+
+		if ((channel->cap & dmacap) != dmacap)
+			continue;
+
+		if (!frv_dma_channels[dma].flags)
+			goto found;
+	}
+
+	goto out;
+
+ found:
+	ret = request_irq(channel->irq, dma_irq_handler, irq_flags, devname, channel);
+	if (ret < 0)
+		goto out;
+
+	/* okay, we've allocated all the resources */
+	channel = &frv_dma_channels[dma];
+
+	channel->flags		|= FRV_DMA_FLAGS_INUSE;
+	channel->devname	= devname;
+	channel->handler	= handler;
+	channel->data		= data;
+
+	/* Now make sure we are set up for DMA and not GPIO */
+	/* SIR bit must be set for DMA to work */
+	__set_SIR(channel->dreqbit | __get_SIR());
+	/* SOR bits depend on what the caller requests */
+	val = __get_SOR();
+	if(dmacap & FRV_DMA_CAP_DACK)
+		val |= channel->dackbit;
+	else
+		val &= ~channel->dackbit;
+	if(dmacap & FRV_DMA_CAP_DONE)
+		val |= channel->donebit;
+	else
+		val &= ~channel->donebit;
+	__set_SOR(val);
+
+	ret = dma;
+ out:
+	write_unlock(&frv_dma_channels_lock);
+	return ret;
+} /* end frv_dma_open() */
+
+EXPORT_SYMBOL(frv_dma_open);
+
+/*****************************************************************************/
+/*
+ * close a DMA channel and its associated interrupt
+ */
+void frv_dma_close(int dma)
+{
+	struct frv_dma_channel *channel = &frv_dma_channels[dma];
+	unsigned long flags;
+
+	write_lock_irqsave(&frv_dma_channels_lock, flags);
+
+	free_irq(channel->irq, channel);
+	frv_dma_stop(dma);
+
+	channel->flags &= ~FRV_DMA_FLAGS_INUSE;
+
+	write_unlock_irqrestore(&frv_dma_channels_lock, flags);
+} /* end frv_dma_close() */
+
+EXPORT_SYMBOL(frv_dma_close);
+
+/*****************************************************************************/
+/*
+ * set static configuration on a DMA channel
+ */
+void frv_dma_config(int dma, unsigned long ccfr, unsigned long cctr, unsigned long apr)
+{
+	unsigned long ioaddr = frv_dma_channels[dma].ioaddr;
+
+	___set_DMAC(ioaddr, CCFR, ccfr);
+	___set_DMAC(ioaddr, CCTR, cctr);
+	___set_DMAC(ioaddr, APR,  apr);
+	mb();
+
+} /* end frv_dma_config() */
+
+EXPORT_SYMBOL(frv_dma_config);
+
+/*****************************************************************************/
+/*
+ * start a DMA channel
+ */
+void frv_dma_start(int dma,
+		   unsigned long sba, unsigned long dba,
+		   unsigned long pix, unsigned long six, unsigned long bcl)
+{
+	unsigned long ioaddr = frv_dma_channels[dma].ioaddr;
+
+	___set_DMAC(ioaddr, SBA,  sba);
+	___set_DMAC(ioaddr, DBA,  dba);
+	___set_DMAC(ioaddr, PIX,  pix);
+	___set_DMAC(ioaddr, SIX,  six);
+	___set_DMAC(ioaddr, BCL,  bcl);
+	___set_DMAC(ioaddr, CSTR, 0);
+	mb();
+
+	__set_DMAC(ioaddr, CCTR, __get_DMAC(ioaddr, CCTR) | DMAC_CCTRx_ACT);
+	frv_set_dma_inprogress(dma);
+
+} /* end frv_dma_start() */
+
+EXPORT_SYMBOL(frv_dma_start);
+
+/*****************************************************************************/
+/*
+ * restart a DMA channel that's been stopped in circular addressing mode by comparison-end
+ */
+void frv_dma_restart_circular(int dma, unsigned long six)
+{
+	unsigned long ioaddr = frv_dma_channels[dma].ioaddr;
+
+	___set_DMAC(ioaddr, SIX,  six);
+	___set_DMAC(ioaddr, CSTR, __get_DMAC(ioaddr, CSTR) & ~DMAC_CSTRx_CE);
+	mb();
+
+	__set_DMAC(ioaddr, CCTR, __get_DMAC(ioaddr, CCTR) | DMAC_CCTRx_ACT);
+	frv_set_dma_inprogress(dma);
+
+} /* end frv_dma_restart_circular() */
+
+EXPORT_SYMBOL(frv_dma_restart_circular);
+
+/*****************************************************************************/
+/*
+ * stop a DMA channel
+ */
+void frv_dma_stop(int dma)
+{
+	unsigned long ioaddr = frv_dma_channels[dma].ioaddr;
+	uint32_t cctr;
+
+	___set_DMAC(ioaddr, CSTR, 0);
+	cctr = __get_DMAC(ioaddr, CCTR);
+	cctr &= ~(DMAC_CCTRx_IE | DMAC_CCTRx_ACT);
+	cctr |= DMAC_CCTRx_FC; 	/* fifo clear */
+	__set_DMAC(ioaddr, CCTR, cctr);
+	__set_DMAC(ioaddr, BCL,  0);
+	frv_clear_dma_inprogress(dma);
+} /* end frv_dma_stop() */
+
+EXPORT_SYMBOL(frv_dma_stop);
+
+/*****************************************************************************/
+/*
+ * test interrupt status of DMA channel
+ */
+int is_frv_dma_interrupting(int dma)
+{
+	unsigned long ioaddr = frv_dma_channels[dma].ioaddr;
+
+	return __get_DMAC(ioaddr, CSTR) & (1 << 23);
+
+} /* end is_frv_dma_interrupting() */
+
+EXPORT_SYMBOL(is_frv_dma_interrupting);
+
+/*****************************************************************************/
+/*
+ * dump data about a DMA channel
+ */
+void frv_dma_dump(int dma)
+{
+	unsigned long ioaddr = frv_dma_channels[dma].ioaddr;
+	unsigned long cstr, pix, six, bcl;
+
+	cstr = __get_DMAC(ioaddr, CSTR);
+	pix  = __get_DMAC(ioaddr, PIX);
+	six  = __get_DMAC(ioaddr, SIX);
+	bcl  = __get_DMAC(ioaddr, BCL);
+
+	printk("DMA[%d] cstr=%lx pix=%lx six=%lx bcl=%lx\n", dma, cstr, pix, six, bcl);
+
+} /* end frv_dma_dump() */
+
+EXPORT_SYMBOL(frv_dma_dump);
+
+/*****************************************************************************/
+/*
+ * pause all DMA controllers
+ * - called by clock mangling routines
+ * - caller must be holding interrupts disabled
+ */
+void frv_dma_pause_all(void)
+{
+	struct frv_dma_channel *channel;
+	unsigned long ioaddr;
+	unsigned long cstr, cctr;
+	int dma;
+
+	write_lock(&frv_dma_channels_lock);
+
+	for (dma = FRV_DMA_NCHANS - 1; dma >= 0; dma--) {
+		channel = &frv_dma_channels[dma];
+
+		if (!(channel->flags & FRV_DMA_FLAGS_INUSE))
+			continue;
+
+		ioaddr = channel->ioaddr;
+		cctr = __get_DMAC(ioaddr, CCTR);
+		if (cctr & DMAC_CCTRx_ACT) {
+			cctr &= ~DMAC_CCTRx_ACT;
+			__set_DMAC(ioaddr, CCTR, cctr);
+
+			do {
+				cstr = __get_DMAC(ioaddr, CSTR);
+			} while (cstr & DMAC_CSTRx_BUSY);
+
+			if (cstr & DMAC_CSTRx_FED)
+				channel->flags |= FRV_DMA_FLAGS_PAUSED;
+			frv_clear_dma_inprogress(dma);
+		}
+	}
+
+} /* end frv_dma_pause_all() */
+
+EXPORT_SYMBOL(frv_dma_pause_all);
+
+/*****************************************************************************/
+/*
+ * resume paused DMA controllers
+ * - called by clock mangling routines
+ * - caller must be holding interrupts disabled
+ */
+void frv_dma_resume_all(void)
+{
+	struct frv_dma_channel *channel;
+	unsigned long ioaddr;
+	unsigned long cstr, cctr;
+	int dma;
+
+	for (dma = FRV_DMA_NCHANS - 1; dma >= 0; dma--) {
+		channel = &frv_dma_channels[dma];
+
+		if (!(channel->flags & FRV_DMA_FLAGS_PAUSED))
+			continue;
+
+		ioaddr = channel->ioaddr;
+		cstr = __get_DMAC(ioaddr, CSTR);
+		cstr &= ~(DMAC_CSTRx_FED | DMAC_CSTRx_INT);
+		__set_DMAC(ioaddr, CSTR, cstr);
+
+		cctr = __get_DMAC(ioaddr, CCTR);
+		cctr |= DMAC_CCTRx_ACT;
+		__set_DMAC(ioaddr, CCTR, cctr);
+
+		channel->flags &= ~FRV_DMA_FLAGS_PAUSED;
+		frv_set_dma_inprogress(dma);
+	}
+
+	write_unlock(&frv_dma_channels_lock);
+
+} /* end frv_dma_resume_all() */
+
+EXPORT_SYMBOL(frv_dma_resume_all);
+
+/*****************************************************************************/
+/*
+ * dma status clear
+ */
+void frv_dma_status_clear(int dma)
+{
+	unsigned long ioaddr = frv_dma_channels[dma].ioaddr;
+	uint32_t cctr;
+	___set_DMAC(ioaddr, CSTR, 0);
+
+	cctr = __get_DMAC(ioaddr, CCTR);
+} /* end frv_dma_status_clear() */
+
+EXPORT_SYMBOL(frv_dma_status_clear);
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/entry.S linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/entry.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/entry.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/entry.S	2004-11-05 14:13:03.077565534 +0000
@@ -0,0 +1,1420 @@
+/* entry.S: FR-V entry
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ *
+ * Entry to the kernel is "interesting":
+ *  (1) There are no stack pointers, not even for the kernel
+ *  (2) General Registers should not be clobbered
+ *  (3) There are no kernel-only data registers
+ *  (4) Since all addressing modes are wrt to a General Register, no global
+ *      variables can be reached
+ *
+ * We deal with this by declaring that we shall kill GR28 on entering the
+ * kernel from userspace
+ *
+ * However, since break interrupts can interrupt the CPU even when PSR.ET==0,
+ * they can't rely on GR28 to be anything useful, and so need to clobber a
+ * separate register (GR31). Break interrupts are managed in break.S
+ *
+ * GR29 _is_ saved, and holds the current task pointer globally
+ *
+ */
+
+#include <linux/sys.h>
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/thread_info.h>
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/ptrace.h>
+#include <asm/errno.h>
+#include <asm/cache.h>
+#include <asm/spr-regs.h>
+
+#define nr_syscalls ((syscall_table_size)/4)
+
+	.text
+	.balign		4
+
+.macro LEDS val
+#	sethi.p		%hi(0xe1200004),gr30
+#	setlo		%lo(0xe1200004),gr30
+#	setlos		#~\val,gr31
+#	st		gr31,@(gr30,gr0)
+#	sethi.p		%hi(0xffc00100),gr30
+#	setlo		%lo(0xffc00100),gr30
+#	sth		gr0,@(gr30,gr0)
+#	membar
+.endm
+
+.macro LEDS32
+#	not		gr31,gr31
+#	sethi.p		%hi(0xe1200004),gr30
+#	setlo		%lo(0xe1200004),gr30
+#	st.p		gr31,@(gr30,gr0)
+#	srli		gr31,#16,gr31
+#	sethi.p		%hi(0xffc00100),gr30
+#	setlo		%lo(0xffc00100),gr30
+#	sth		gr31,@(gr30,gr0)
+#	membar
+.endm
+
+###############################################################################
+#
+# entry point for External interrupts received whilst executing userspace code
+#
+###############################################################################
+	.globl		__entry_uspace_external_interrupt
+        .type		__entry_uspace_external_interrupt,@function
+__entry_uspace_external_interrupt:
+	LEDS		0x6200
+	sethi.p		%hi(__kernel_frame0_ptr),gr28
+	setlo		%lo(__kernel_frame0_ptr),gr28
+	ldi		@(gr28,#0),gr28
+
+	# handle h/w single-step through exceptions
+	sti		gr0,@(gr28,#REG__STATUS)
+
+	.globl		__entry_uspace_external_interrupt_reentry
+__entry_uspace_external_interrupt_reentry:
+	LEDS		0x6201
+
+	setlos		#REG__END,gr30
+	dcpl		gr28,gr30,#0
+
+	# finish building the exception frame
+	sti		sp,  @(gr28,#REG_SP)
+	stdi		gr2, @(gr28,#REG_GR(2))
+	stdi		gr4, @(gr28,#REG_GR(4))
+	stdi		gr6, @(gr28,#REG_GR(6))
+	stdi		gr8, @(gr28,#REG_GR(8))
+	stdi		gr10,@(gr28,#REG_GR(10))
+	stdi		gr12,@(gr28,#REG_GR(12))
+	stdi		gr14,@(gr28,#REG_GR(14))
+	stdi		gr16,@(gr28,#REG_GR(16))
+	stdi		gr18,@(gr28,#REG_GR(18))
+	stdi		gr20,@(gr28,#REG_GR(20))
+	stdi		gr22,@(gr28,#REG_GR(22))
+	stdi		gr24,@(gr28,#REG_GR(24))
+	stdi		gr26,@(gr28,#REG_GR(26))
+	sti		gr0, @(gr28,#REG_GR(28))
+	sti		gr29,@(gr28,#REG_GR(29))
+	stdi.p		gr30,@(gr28,#REG_GR(30))
+
+	# set up the kernel stack pointer
+	ori		gr28,0,sp
+
+	movsg		tbr ,gr20
+	movsg		psr ,gr22
+	movsg		pcsr,gr21
+	movsg		isr ,gr23
+	movsg		ccr ,gr24
+	movsg		cccr,gr25
+	movsg		lr  ,gr26
+	movsg		lcr ,gr27
+
+	setlos.p	#-1,gr4
+	andi		gr22,#PSR_PS,gr5		/* try to rebuild original PSR value */
+	andi.p		gr22,#~(PSR_PS|PSR_S),gr6
+	slli		gr5,#1,gr5
+	or		gr6,gr5,gr5
+	andi		gr5,#~PSR_ET,gr5
+
+	sti		gr20,@(gr28,#REG_TBR)
+	sti		gr21,@(gr28,#REG_PC)
+	sti		gr5 ,@(gr28,#REG_PSR)
+	sti		gr23,@(gr28,#REG_ISR)
+	stdi		gr24,@(gr28,#REG_CCR)
+	stdi		gr26,@(gr28,#REG_LR)
+	sti		gr4 ,@(gr28,#REG_SYSCALLNO)
+
+	movsg		iacc0h,gr4
+	movsg		iacc0l,gr5
+	stdi		gr4,@(gr28,#REG_IACC0)
+
+	movsg		gner0,gr4
+	movsg		gner1,gr5
+	stdi		gr4,@(gr28,#REG_GNER0)
+
+	# set up kernel global registers
+	sethi.p		%hi(__kernel_current_task),gr5
+	setlo		%lo(__kernel_current_task),gr5
+	sethi.p		%hi(_gp),gr16
+	setlo		%lo(_gp),gr16
+	ldi		@(gr5,#0),gr29
+	ldi.p		@(gr29,#4),gr15		; __current_thread_info = current->thread_info
+
+	# make sure we (the kernel) get div-zero and misalignment exceptions
+	setlos		#ISR_EDE|ISR_DTT_DIVBYZERO|ISR_EMAM_EXCEPTION,gr5
+	movgs		gr5,isr
+
+	# switch to the kernel trap table
+	sethi.p		%hi(__entry_kerneltrap_table),gr6
+	setlo		%lo(__entry_kerneltrap_table),gr6
+	movgs		gr6,tbr
+
+	# set the return address
+	sethi.p		%hi(__entry_return_from_user_interrupt),gr4
+	setlo		%lo(__entry_return_from_user_interrupt),gr4
+	movgs		gr4,lr
+
+	# raise the minimum interrupt priority to 15 (NMI only) and enable exceptions
+	movsg		psr,gr4
+
+	ori		gr4,#PSR_PIL_14,gr4
+	movgs		gr4,psr
+	ori		gr4,#PSR_PIL_14|PSR_ET,gr4
+	movgs		gr4,psr
+
+	LEDS		0x6202
+	bra		do_IRQ
+
+	.size		__entry_uspace_external_interrupt,.-__entry_uspace_external_interrupt
+
+###############################################################################
+#
+# entry point for External interrupts received whilst executing kernel code
+# - on arriving here, the following registers should already be set up:
+#	GR15	- current thread_info struct pointer
+#	GR16	- kernel GP-REL pointer
+#	GR29	- current task struct pointer
+#	TBR	- kernel trap vector table
+#	ISR	- kernel's preferred integer controls
+#
+###############################################################################
+	.globl		__entry_kernel_external_interrupt
+        .type		__entry_kernel_external_interrupt,@function
+__entry_kernel_external_interrupt:
+	LEDS		0x6210
+
+	sub		sp,gr15,gr31
+	LEDS32
+
+	# set up the stack pointer
+	or.p		sp,gr0,gr30
+	subi		sp,#REG__END,sp
+	sti		gr30,@(sp,#REG_SP)
+
+	# handle h/w single-step through exceptions
+	sti		gr0,@(sp,#REG__STATUS)
+
+	.globl		__entry_kernel_external_interrupt_reentry
+__entry_kernel_external_interrupt_reentry:
+	LEDS		0x6211
+
+	# set up the exception frame
+	setlos		#REG__END,gr30
+	dcpl		sp,gr30,#0
+
+	sti.p		gr28,@(sp,#REG_GR(28))
+	ori		sp,0,gr28
+
+	# finish building the exception frame
+	stdi		gr2,@(gr28,#REG_GR(2))
+	stdi		gr4,@(gr28,#REG_GR(4))
+	stdi		gr6,@(gr28,#REG_GR(6))
+	stdi		gr8,@(gr28,#REG_GR(8))
+	stdi		gr10,@(gr28,#REG_GR(10))
+	stdi		gr12,@(gr28,#REG_GR(12))
+	stdi		gr14,@(gr28,#REG_GR(14))
+	stdi		gr16,@(gr28,#REG_GR(16))
+	stdi		gr18,@(gr28,#REG_GR(18))
+	stdi		gr20,@(gr28,#REG_GR(20))
+	stdi		gr22,@(gr28,#REG_GR(22))
+	stdi		gr24,@(gr28,#REG_GR(24))
+	stdi		gr26,@(gr28,#REG_GR(26))
+	sti		gr29,@(gr28,#REG_GR(29))
+	stdi		gr30,@(gr28,#REG_GR(30))
+
+	movsg		tbr ,gr20
+	movsg		psr ,gr22
+	movsg		pcsr,gr21
+	movsg		isr ,gr23
+	movsg		ccr ,gr24
+	movsg		cccr,gr25
+	movsg		lr  ,gr26
+	movsg		lcr ,gr27
+
+	setlos.p	#-1,gr4
+	andi		gr22,#PSR_PS,gr5		/* try to rebuild original PSR value */
+	andi.p		gr22,#~(PSR_PS|PSR_S),gr6
+	slli		gr5,#1,gr5
+	or		gr6,gr5,gr5
+	andi.p		gr5,#~PSR_ET,gr5
+
+	# set CCCR.CC3 to Undefined to abort atomic-modify completion inside the kernel
+	# - for an explanation of how it works, see: Documentation/fujitsu/frv/atomic-ops.txt
+	andi		gr25,#~0xc0,gr25
+
+	sti		gr20,@(gr28,#REG_TBR)
+	sti		gr21,@(gr28,#REG_PC)
+	sti		gr5 ,@(gr28,#REG_PSR)
+	sti		gr23,@(gr28,#REG_ISR)
+	stdi		gr24,@(gr28,#REG_CCR)
+	stdi		gr26,@(gr28,#REG_LR)
+	sti		gr4 ,@(gr28,#REG_SYSCALLNO)
+
+	movsg		iacc0h,gr4
+	movsg		iacc0l,gr5
+	stdi		gr4,@(gr28,#REG_IACC0)
+
+	movsg		gner0,gr4
+	movsg		gner1,gr5
+	stdi		gr4,@(gr28,#REG_GNER0)
+
+	# set the return address
+	sethi.p		%hi(__entry_return_from_kernel_interrupt),gr4
+	setlo		%lo(__entry_return_from_kernel_interrupt),gr4
+	movgs		gr4,lr
+
+	# clear power-saving mode flags
+	movsg		hsr0,gr4
+	andi		gr4,#~HSR0_PDM,gr4
+	movgs		gr4,hsr0
+
+	# raise the minimum interrupt priority to 15 (NMI only) and enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_PIL_14,gr4
+	movgs		gr4,psr
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+
+	LEDS		0x6212
+	bra		do_IRQ
+
+	.size		__entry_kernel_external_interrupt,.-__entry_kernel_external_interrupt
+
+
+###############################################################################
+#
+# entry point for Software and Progam interrupts generated whilst executing userspace code
+#
+###############################################################################
+	.globl		__entry_uspace_softprog_interrupt
+        .type		__entry_uspace_softprog_interrupt,@function
+	.globl		__entry_uspace_handle_mmu_fault
+__entry_uspace_softprog_interrupt:
+	LEDS		0x6000
+#ifdef CONFIG_MMU
+	movsg		ear0,gr28
+__entry_uspace_handle_mmu_fault:
+	movgs		gr28,scr2
+#endif
+	sethi.p		%hi(__kernel_frame0_ptr),gr28
+	setlo		%lo(__kernel_frame0_ptr),gr28
+	ldi		@(gr28,#0),gr28
+
+	# handle h/w single-step through exceptions
+	sti		gr0,@(gr28,#REG__STATUS)
+
+	.globl		__entry_uspace_softprog_interrupt_reentry
+__entry_uspace_softprog_interrupt_reentry:
+	LEDS		0x6001
+
+	setlos		#REG__END,gr30
+	dcpl		gr28,gr30,#0
+
+	# set up the kernel stack pointer
+	sti.p		sp,@(gr28,#REG_SP)
+	ori		gr28,0,sp
+	sti		gr0,@(gr28,#REG_GR(28))
+
+	stdi		gr20,@(gr28,#REG_GR(20))
+	stdi		gr22,@(gr28,#REG_GR(22))
+
+	movsg		tbr,gr20
+	movsg		pcsr,gr21
+	movsg		psr,gr22
+
+	sethi.p		%hi(__entry_return_from_user_exception),gr23
+	setlo		%lo(__entry_return_from_user_exception),gr23
+	bra		__entry_common
+
+	.size		__entry_uspace_softprog_interrupt,.-__entry_uspace_softprog_interrupt
+
+	# single-stepping was disabled on entry to a TLB handler that then faulted
+#ifdef CONFIG_MMU
+	.globl		__entry_uspace_handle_mmu_fault_sstep
+__entry_uspace_handle_mmu_fault_sstep:
+	movgs		gr28,scr2
+	sethi.p		%hi(__kernel_frame0_ptr),gr28
+	setlo		%lo(__kernel_frame0_ptr),gr28
+	ldi		@(gr28,#0),gr28
+
+	# flag single-step re-enablement
+	sti		gr0,@(gr28,#REG__STATUS)
+	bra		__entry_uspace_softprog_interrupt_reentry
+#endif
+
+
+###############################################################################
+#
+# entry point for Software and Progam interrupts generated whilst executing kernel code
+#
+###############################################################################
+	.globl		__entry_kernel_softprog_interrupt
+        .type		__entry_kernel_softprog_interrupt,@function
+__entry_kernel_softprog_interrupt:
+	LEDS		0x6004
+
+#ifdef CONFIG_MMU
+	movsg		ear0,gr30
+	movgs		gr30,scr2
+#endif
+
+	.globl		__entry_kernel_handle_mmu_fault
+__entry_kernel_handle_mmu_fault:
+	# set up the stack pointer
+	subi		sp,#REG__END,sp
+	sti		sp,@(sp,#REG_SP)
+	sti		sp,@(sp,#REG_SP-4)
+	andi		sp,#~7,sp
+
+	# handle h/w single-step through exceptions
+	sti		gr0,@(sp,#REG__STATUS)
+
+	.globl		__entry_kernel_softprog_interrupt_reentry
+__entry_kernel_softprog_interrupt_reentry:
+	LEDS		0x6005
+
+	setlos		#REG__END,gr30
+	dcpl		sp,gr30,#0
+
+	# set up the exception frame
+	sti.p		gr28,@(sp,#REG_GR(28))
+	ori		sp,0,gr28
+
+	stdi		gr20,@(gr28,#REG_GR(20))
+	stdi		gr22,@(gr28,#REG_GR(22))
+
+	ldi		@(sp,#REG_SP),gr22		/* reconstruct the old SP */
+	addi		gr22,#REG__END,gr22
+	sti		gr22,@(sp,#REG_SP)
+
+	# set CCCR.CC3 to Undefined to abort atomic-modify completion inside the kernel
+	# - for an explanation of how it works, see: Documentation/fujitsu/frv/atomic-ops.txt
+	movsg		cccr,gr20
+	andi		gr20,#~0xc0,gr20
+	movgs		gr20,cccr
+
+	movsg		tbr,gr20
+	movsg		pcsr,gr21
+	movsg		psr,gr22
+
+	sethi.p		%hi(__entry_return_from_kernel_exception),gr23
+	setlo		%lo(__entry_return_from_kernel_exception),gr23
+	bra		__entry_common
+
+	.size		__entry_kernel_softprog_interrupt,.-__entry_kernel_softprog_interrupt
+
+	# single-stepping was disabled on entry to a TLB handler that then faulted
+#ifdef CONFIG_MMU
+	.globl		__entry_kernel_handle_mmu_fault_sstep
+__entry_kernel_handle_mmu_fault_sstep:
+	# set up the stack pointer
+	subi		sp,#REG__END,sp
+	sti		sp,@(sp,#REG_SP)
+	sti		sp,@(sp,#REG_SP-4)
+	andi		sp,#~7,sp
+
+	# flag single-step re-enablement
+	sethi		#REG__STATUS_STEP,gr30
+	sti		gr30,@(sp,#REG__STATUS)
+	bra		__entry_kernel_softprog_interrupt_reentry
+#endif
+
+
+###############################################################################
+#
+# the rest of the kernel entry point code
+# - on arriving here, the following registers should be set up:
+#	GR1	- kernel stack pointer
+#	GR7	- syscall number (trap 0 only)
+#	GR8-13	- syscall args (trap 0 only)
+#	GR20	- saved TBR
+#	GR21	- saved PC
+#	GR22	- saved PSR
+#	GR23	- return handler address
+#	GR28	- exception frame on stack
+#	SCR2	- saved EAR0 where applicable (clobbered by ICI & ICEF insns on FR451)
+#	PSR	- PSR.S 1, PSR.ET 0
+#
+###############################################################################
+	.globl		__entry_common
+        .type		__entry_common,@function
+__entry_common:
+	LEDS		0x6008
+
+	# finish building the exception frame
+	stdi		gr2,@(gr28,#REG_GR(2))
+	stdi		gr4,@(gr28,#REG_GR(4))
+	stdi		gr6,@(gr28,#REG_GR(6))
+	stdi		gr8,@(gr28,#REG_GR(8))
+	stdi		gr10,@(gr28,#REG_GR(10))
+	stdi		gr12,@(gr28,#REG_GR(12))
+	stdi		gr14,@(gr28,#REG_GR(14))
+	stdi		gr16,@(gr28,#REG_GR(16))
+	stdi		gr18,@(gr28,#REG_GR(18))
+	stdi		gr24,@(gr28,#REG_GR(24))
+	stdi		gr26,@(gr28,#REG_GR(26))
+	sti		gr29,@(gr28,#REG_GR(29))
+	stdi		gr30,@(gr28,#REG_GR(30))
+
+	movsg		lcr ,gr27
+	movsg		lr  ,gr26
+	movgs		gr23,lr
+	movsg		cccr,gr25
+	movsg		ccr ,gr24
+	movsg		isr ,gr23
+
+	setlos.p	#-1,gr4
+	andi		gr22,#PSR_PS,gr5		/* try to rebuild original PSR value */
+	andi.p		gr22,#~(PSR_PS|PSR_S),gr6
+	slli		gr5,#1,gr5
+	or		gr6,gr5,gr5
+	andi		gr5,#~PSR_ET,gr5
+
+	sti		gr20,@(gr28,#REG_TBR)
+	sti		gr21,@(gr28,#REG_PC)
+	sti		gr5 ,@(gr28,#REG_PSR)
+	sti		gr23,@(gr28,#REG_ISR)
+	stdi		gr24,@(gr28,#REG_CCR)
+	stdi		gr26,@(gr28,#REG_LR)
+	sti		gr4 ,@(gr28,#REG_SYSCALLNO)
+
+	movsg		iacc0h,gr4
+	movsg		iacc0l,gr5
+	stdi		gr4,@(gr28,#REG_IACC0)
+
+	movsg		gner0,gr4
+	movsg		gner1,gr5
+	stdi		gr4,@(gr28,#REG_GNER0)
+
+	# set up kernel global registers
+	sethi.p		%hi(__kernel_current_task),gr5
+	setlo		%lo(__kernel_current_task),gr5
+	sethi.p		%hi(_gp),gr16
+	setlo		%lo(_gp),gr16
+	ldi		@(gr5,#0),gr29
+	ldi		@(gr29,#4),gr15		; __current_thread_info = current->thread_info
+
+	# switch to the kernel trap table
+	sethi.p		%hi(__entry_kerneltrap_table),gr6
+	setlo		%lo(__entry_kerneltrap_table),gr6
+	movgs		gr6,tbr
+
+	# make sure we (the kernel) get div-zero and misalignment exceptions
+	setlos		#ISR_EDE|ISR_DTT_DIVBYZERO|ISR_EMAM_EXCEPTION,gr5
+	movgs		gr5,isr
+
+	# clear power-saving mode flags
+	movsg		hsr0,gr4
+	andi		gr4,#~HSR0_PDM,gr4
+	movgs		gr4,hsr0
+
+	# multiplex again using old TBR as a guide
+	setlos.p	#TBR_TT,gr3
+	sethi		%hi(__entry_vector_table),gr6
+	and.p		gr20,gr3,gr5
+	setlo		%lo(__entry_vector_table),gr6
+	srli		gr5,#2,gr5
+	ld		@(gr5,gr6),gr5
+
+	LEDS		0x6009
+	jmpl		@(gr5,gr0)
+
+
+	.size		__entry_common,.-__entry_common
+
+###############################################################################
+#
+# handle instruction MMU fault
+#
+###############################################################################
+#ifdef CONFIG_MMU
+	.globl		__entry_insn_mmu_fault
+__entry_insn_mmu_fault:
+	LEDS		0x6010
+	setlos		#0,gr8
+	movsg		esr0,gr9
+	movsg		scr2,gr10
+
+	# now that we've accessed the exception regs, we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+
+	sethi.p		%hi(do_page_fault),gr5
+	setlo		%lo(do_page_fault),gr5
+	jmpl		@(gr5,gr0)	; call do_page_fault(0,esr0,ear0)
+#endif
+
+
+###############################################################################
+#
+# handle instruction access error
+#
+###############################################################################
+	.globl		__entry_insn_access_error
+__entry_insn_access_error:
+	LEDS		0x6011
+	sethi.p		%hi(insn_access_error),gr5
+	setlo		%lo(insn_access_error),gr5
+	movsg		esfr1,gr8
+	movsg		epcr0,gr9
+	movsg		esr0,gr10
+
+	# now that we've accessed the exception regs, we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+	jmpl		@(gr5,gr0)	; call insn_access_error(esfr1,epcr0,esr0)
+
+###############################################################################
+#
+# handle various instructions of dubious legality
+#
+###############################################################################
+	.globl		__entry_unsupported_trap
+	.globl		__entry_illegal_instruction
+	.globl		__entry_privileged_instruction
+	.globl		__entry_debug_exception
+__entry_unsupported_trap:
+	subi		gr21,#4,gr21
+	sti		gr21,@(gr28,#REG_PC)
+__entry_illegal_instruction:
+__entry_privileged_instruction:
+__entry_debug_exception:
+	LEDS		0x6012
+	sethi.p		%hi(illegal_instruction),gr5
+	setlo		%lo(illegal_instruction),gr5
+	movsg		esfr1,gr8
+	movsg		epcr0,gr9
+	movsg		esr0,gr10
+
+	# now that we've accessed the exception regs, we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+	jmpl		@(gr5,gr0)	; call ill_insn(esfr1,epcr0,esr0)
+
+###############################################################################
+#
+# handle media exception
+#
+###############################################################################
+	.globl		__entry_media_exception
+__entry_media_exception:
+	LEDS		0x6013
+	sethi.p		%hi(media_exception),gr5
+	setlo		%lo(media_exception),gr5
+	movsg		msr0,gr8
+	movsg		msr1,gr9
+
+	# now that we've accessed the exception regs, we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+	jmpl		@(gr5,gr0)	; call media_excep(msr0,msr1)
+
+###############################################################################
+#
+# handle data MMU fault
+# handle data DAT fault (write-protect exception)
+#
+###############################################################################
+#ifdef CONFIG_MMU
+	.globl		__entry_data_mmu_fault
+__entry_data_mmu_fault:
+	.globl		__entry_data_dat_fault
+__entry_data_dat_fault:
+	LEDS		0x6014
+	setlos		#1,gr8
+	movsg		esr0,gr9
+	movsg		scr2,gr10	; saved EAR0
+
+	# now that we've accessed the exception regs, we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+
+	sethi.p		%hi(do_page_fault),gr5
+	setlo		%lo(do_page_fault),gr5
+	jmpl		@(gr5,gr0)	; call do_page_fault(1,esr0,ear0)
+#endif
+
+###############################################################################
+#
+# handle data and instruction access exceptions
+#
+###############################################################################
+	.globl		__entry_insn_access_exception
+	.globl		__entry_data_access_exception
+__entry_insn_access_exception:
+__entry_data_access_exception:
+	LEDS		0x6016
+	sethi.p		%hi(memory_access_exception),gr5
+	setlo		%lo(memory_access_exception),gr5
+	movsg		esr0,gr8
+	movsg		scr2,gr9	; saved EAR0
+	movsg		epcr0,gr10
+
+	# now that we've accessed the exception regs, we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+	jmpl		@(gr5,gr0)	; call memory_access_error(esr0,ear0,epcr0)
+
+###############################################################################
+#
+# handle data access error
+#
+###############################################################################
+	.globl		__entry_data_access_error
+__entry_data_access_error:
+	LEDS		0x6016
+	sethi.p		%hi(data_access_error),gr5
+	setlo		%lo(data_access_error),gr5
+	movsg		esfr1,gr8
+	movsg		esr15,gr9
+	movsg		ear15,gr10
+
+	# now that we've accessed the exception regs, we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+	jmpl		@(gr5,gr0)	; call data_access_error(esfr1,esr15,ear15)
+
+###############################################################################
+#
+# handle data store error
+#
+###############################################################################
+	.globl		__entry_data_store_error
+__entry_data_store_error:
+	LEDS		0x6017
+	sethi.p		%hi(data_store_error),gr5
+	setlo		%lo(data_store_error),gr5
+	movsg		esfr1,gr8
+	movsg		esr14,gr9
+
+	# now that we've accessed the exception regs, we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+	jmpl		@(gr5,gr0)	; call data_store_error(esfr1,esr14)
+
+###############################################################################
+#
+# handle division exception
+#
+###############################################################################
+	.globl		__entry_division_exception
+__entry_division_exception:
+	LEDS		0x6018
+	sethi.p		%hi(division_exception),gr5
+	setlo		%lo(division_exception),gr5
+	movsg		esfr1,gr8
+	movsg		esr0,gr9
+	movsg		isr,gr10
+
+	# now that we've accessed the exception regs, we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+	jmpl		@(gr5,gr0)	; call div_excep(esfr1,esr0,isr)
+
+###############################################################################
+#
+# handle compound exception
+#
+###############################################################################
+	.globl		__entry_compound_exception
+__entry_compound_exception:
+	LEDS		0x6019
+	sethi.p		%hi(compound_exception),gr5
+	setlo		%lo(compound_exception),gr5
+	movsg		esfr1,gr8
+	movsg		esr0,gr9
+	movsg		esr14,gr10
+	movsg		esr15,gr11
+	movsg		msr0,gr12
+	movsg		msr1,gr13
+
+	# now that we've accessed the exception regs, we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+	jmpl		@(gr5,gr0)	; call comp_excep(esfr1,esr0,esr14,esr15,msr0,msr1)
+
+###############################################################################
+#
+# handle interrupts and NMIs
+#
+###############################################################################
+	.globl		__entry_do_IRQ
+__entry_do_IRQ:
+	LEDS		0x6020
+
+	# we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+	bra		do_IRQ
+
+	.globl		__entry_do_NMI
+__entry_do_NMI:
+	LEDS		0x6021
+
+	# we can enable exceptions
+	movsg		psr,gr4
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+	bra		do_NMI
+
+###############################################################################
+#
+# the return path for a newly forked child process
+# - __switch_to() saved the old current pointer in GR27 for us
+#
+###############################################################################
+	.globl		ret_from_fork
+ret_from_fork:
+	LEDS		0x6100
+	ori.p		gr27,0,gr8
+	call		schedule_tail
+
+	# fork & co. return 0 to child
+	setlos.p	#0,gr8
+	bra		__syscall_exit
+
+###################################################################################################
+#
+# Return to user mode is not as complex as all this looks,
+# but we want the default path for a system call return to
+# go as quickly as possible which is why some of this is
+# less clear than it otherwise should be.
+#
+###################################################################################################
+	.balign		L1_CACHE_BYTES
+	.globl		system_call
+system_call:
+	LEDS		0x6101
+	movsg		psr,gr4			; enable exceptions
+	ori		gr4,#PSR_ET,gr4
+	movgs		gr4,psr
+
+	sti		gr7,@(gr28,#REG_SYSCALLNO)
+	sti.p		gr8,@(gr28,#REG_ORIG_GR8)
+
+	subicc		gr7,#nr_syscalls,gr0,icc0
+	bnc		icc0,#0,__syscall_badsys
+
+	ldi		@(gr15,#TI_FLAGS),gr4
+	ori		gr4,#_TIF_SYSCALL_TRACE,gr4
+	andicc		gr4,#_TIF_SYSCALL_TRACE,gr0,icc0
+	bne		icc0,#0,__syscall_trace_entry
+	bra		__syscall_trace_entry
+
+__syscall_call:
+	slli.p		gr7,#2,gr7
+	sethi		%hi(sys_call_table),gr5
+	setlo		%lo(sys_call_table),gr5
+	ld		@(gr5,gr7),gr4
+	calll		@(gr4,gr0)
+
+
+###############################################################################
+#
+# return to interrupted process
+#
+###############################################################################
+__syscall_exit:
+	LEDS		0x6300
+
+	sti		gr8,@(gr28,#REG_GR(8))	; save return value
+
+	# rebuild saved psr - execve will change it for init/main.c
+	ldi		@(gr28,#REG_PSR),gr22
+	srli		gr22,#1,gr5
+	andi.p		gr22,#~PSR_PS,gr22
+	andi		gr5,#PSR_PS,gr5
+	or		gr5,gr22,gr22
+	ori		gr22,#PSR_S,gr22
+
+	# keep current PSR in GR23
+	movsg		psr,gr23
+
+	# make sure we don't miss an interrupt setting need_resched or sigpending between
+	# sampling and the RETT
+	ori		gr23,#PSR_PIL_14,gr23
+	movgs		gr23,psr
+
+	ldi		@(gr15,#TI_FLAGS),gr4
+//	ori		gr4,#_TIF_SYSCALL_TRACE,gr4		/////////////////////////////////
+	sethi.p		%hi(_TIF_ALLWORK_MASK),gr5
+	setlo		%lo(_TIF_ALLWORK_MASK),gr5
+	andcc		gr4,gr5,gr0,icc0
+	bne		icc0,#0,__syscall_exit_work
+
+	# restore all registers and return
+__entry_return_direct:
+	LEDS		0x6301
+
+	andi		gr22,#~PSR_ET,gr22
+	movgs		gr22,psr
+
+	ldi		@(gr28,#REG_ISR),gr23
+	lddi		@(gr28,#REG_CCR),gr24
+	lddi		@(gr28,#REG_LR) ,gr26
+	ldi		@(gr28,#REG_PC) ,gr21
+	ldi		@(gr28,#REG_TBR),gr20
+
+	movgs		gr20,tbr
+	movgs		gr21,pcsr
+	movgs		gr23,isr
+	movgs		gr24,ccr
+	movgs		gr25,cccr
+	movgs		gr26,lr
+	movgs		gr27,lcr
+
+	lddi		@(gr28,#REG_GNER0),gr4
+	movgs		gr4,gner0
+	movgs		gr5,gner1
+
+	lddi		@(gr28,#REG_IACC0),gr4
+	movgs		gr4,iacc0h
+	movgs		gr5,iacc0l
+
+	lddi		@(gr28,#REG_GR(4)) ,gr4
+	lddi		@(gr28,#REG_GR(6)) ,gr6
+	lddi		@(gr28,#REG_GR(8)) ,gr8
+	lddi		@(gr28,#REG_GR(10)),gr10
+	lddi		@(gr28,#REG_GR(12)),gr12
+	lddi		@(gr28,#REG_GR(14)),gr14
+	lddi		@(gr28,#REG_GR(16)),gr16
+	lddi		@(gr28,#REG_GR(18)),gr18
+	lddi		@(gr28,#REG_GR(20)),gr20
+	lddi		@(gr28,#REG_GR(22)),gr22
+	lddi		@(gr28,#REG_GR(24)),gr24
+	lddi		@(gr28,#REG_GR(26)),gr26
+	ldi		@(gr28,#REG_GR(29)),gr29
+	lddi		@(gr28,#REG_GR(30)),gr30
+
+	# check to see if a debugging return is required
+	LEDS		0x67f0
+	movsg		ccr,gr2
+	ldi		@(gr28,#REG__STATUS),gr3
+	andicc		gr3,#REG__STATUS_STEP,gr0,icc0
+	bne		icc0,#0,__entry_return_singlestep
+	movgs		gr2,ccr
+
+	ldi		@(gr28,#REG_SP)    ,sp
+	lddi		@(gr28,#REG_GR(2)) ,gr2
+	ldi		@(gr28,#REG_GR(28)),gr28
+
+	LEDS		0x67fe
+//	movsg		pcsr,gr31
+//	LEDS32
+
+#if 0
+	# store the current frame in the workram on the FR451
+	movgs		gr28,scr2
+	sethi.p		%hi(0xfe800000),gr28
+	setlo		%lo(0xfe800000),gr28
+
+	stdi		gr2,@(gr28,#REG_GR(2))
+	stdi		gr4,@(gr28,#REG_GR(4))
+	stdi		gr6,@(gr28,#REG_GR(6))
+	stdi		gr8,@(gr28,#REG_GR(8))
+	stdi		gr10,@(gr28,#REG_GR(10))
+	stdi		gr12,@(gr28,#REG_GR(12))
+	stdi		gr14,@(gr28,#REG_GR(14))
+	stdi		gr16,@(gr28,#REG_GR(16))
+	stdi		gr18,@(gr28,#REG_GR(18))
+	stdi		gr24,@(gr28,#REG_GR(24))
+	stdi		gr26,@(gr28,#REG_GR(26))
+	sti		gr29,@(gr28,#REG_GR(29))
+	stdi		gr30,@(gr28,#REG_GR(30))
+
+	movsg		tbr ,gr30
+	sti		gr30,@(gr28,#REG_TBR)
+	movsg		pcsr,gr30
+	sti		gr30,@(gr28,#REG_PC)
+	movsg		psr ,gr30
+	sti		gr30,@(gr28,#REG_PSR)
+	movsg		isr ,gr30
+	sti		gr30,@(gr28,#REG_ISR)
+	movsg		ccr ,gr30
+	movsg		cccr,gr31
+	stdi		gr30,@(gr28,#REG_CCR)
+	movsg		lr  ,gr30
+	movsg		lcr ,gr31
+	stdi		gr30,@(gr28,#REG_LR)
+	sti		gr0 ,@(gr28,#REG_SYSCALLNO)
+	movsg		scr2,gr28
+#endif
+
+	rett		#0
+
+	# return via break.S
+__entry_return_singlestep:
+	movgs		gr2,ccr
+	lddi		@(gr28,#REG_GR(2)) ,gr2
+	ldi		@(gr28,#REG_SP)    ,sp
+	ldi		@(gr28,#REG_GR(28)),gr28
+	LEDS		0x67ff
+	break
+	.globl		__entry_return_singlestep_breaks_here
+__entry_return_singlestep_breaks_here:
+	nop
+
+
+###############################################################################
+#
+# return to a process interrupted in kernel space
+# - we need to consider preemption if that is enabled
+#
+###############################################################################
+	.balign		L1_CACHE_BYTES
+__entry_return_from_kernel_exception:
+	LEDS		0x6302
+	movsg		psr,gr23
+	ori		gr23,#PSR_PIL_14,gr23
+	movgs		gr23,psr
+	bra		__entry_return_direct
+
+	.balign		L1_CACHE_BYTES
+__entry_return_from_kernel_interrupt:
+	LEDS		0x6303
+	movsg		psr,gr23
+	ori		gr23,#PSR_PIL_14,gr23
+	movgs		gr23,psr
+
+#ifdef CONFIG_PREEMPT
+	ldi		@(gr15,#TI_PRE_COUNT),gr5
+	subicc		gr5,#0,gr0,icc0
+	beq		icc0,#0,__entry_return_direct
+
+__entry_preempt_need_resched:
+	ldi		@(gr15,#TI_FLAGS),gr4
+	andicc		gr4,#_TIF_NEED_RESCHED,gr0,icc0
+	beq		icc0,#1,__entry_return_direct
+
+	setlos		#PREEMPT_ACTIVE,gr5
+	sti		gr5,@(gr15,#TI_FLAGS)
+
+	andi		gr23,#~PSR_PIL,gr23
+	movgs		gr23,psr
+
+	call		schedule
+	sti		gr0,@(gr15,#TI_PRE_COUNT)
+
+	movsg		psr,gr23
+	ori		gr23,#PSR_PIL_14,gr23
+	movgs		gr23,psr
+	bra		__entry_preempt_need_resched
+#else
+	bra		__entry_return_direct
+#endif
+
+
+###############################################################################
+#
+# perform work that needs to be done immediately before resumption
+#
+###############################################################################
+	.balign		L1_CACHE_BYTES
+__entry_return_from_user_exception:
+	LEDS		0x6501
+
+__entry_resume_userspace:
+	# make sure we don't miss an interrupt setting need_resched or sigpending between
+	# sampling and the RETT
+	movsg		psr,gr23
+	ori		gr23,#PSR_PIL_14,gr23
+	movgs		gr23,psr
+
+__entry_return_from_user_interrupt:
+	LEDS		0x6402
+	ldi		@(gr15,#TI_FLAGS),gr4
+	sethi.p		%hi(_TIF_WORK_MASK),gr5
+	setlo		%lo(_TIF_WORK_MASK),gr5
+	andcc		gr4,gr5,gr0,icc0
+	beq		icc0,#1,__entry_return_direct
+
+__entry_work_pending:
+	LEDS		0x6404
+	andicc		gr4,#_TIF_NEED_RESCHED,gr0,icc0
+	beq		icc0,#1,__entry_work_notifysig
+
+__entry_work_resched:
+	LEDS		0x6408
+	movsg		psr,gr23
+	andi		gr23,#~PSR_PIL,gr23
+	movgs		gr23,psr
+	call		schedule
+	movsg		psr,gr23
+	ori		gr23,#PSR_PIL_14,gr23
+	movgs		gr23,psr
+
+	LEDS		0x6401
+	ldi		@(gr15,#TI_FLAGS),gr4
+	sethi.p		%hi(_TIF_WORK_MASK),gr5
+	setlo		%lo(_TIF_WORK_MASK),gr5
+	andcc		gr4,gr5,gr0,icc0
+	beq		icc0,#1,__entry_return_direct
+	andicc		gr4,#_TIF_NEED_RESCHED,gr0,icc0
+	bne		icc0,#1,__entry_work_resched
+
+ __entry_work_notifysig:
+	LEDS		0x6410
+	ori.p		gr4,#0,gr8
+	call		do_notify_resume
+	bra		__entry_return_direct
+
+	# perform syscall entry tracing
+__syscall_trace_entry:
+	LEDS		0x6320
+	setlos.p	#0,gr8
+	call		do_syscall_trace
+
+	ldi		@(gr28,#REG_SYSCALLNO),gr7
+	lddi		@(gr28,#REG_GR(8)) ,gr8
+	lddi		@(gr28,#REG_GR(10)),gr10
+	lddi.p		@(gr28,#REG_GR(12)),gr12
+
+	subicc		gr7,#nr_syscalls,gr0,icc0
+	bnc		icc0,#0,__syscall_badsys
+	bra		__syscall_call
+
+	# perform syscall exit tracing
+__syscall_exit_work:
+	LEDS		0x6340
+	andicc		gr4,#_TIF_SYSCALL_TRACE,gr0,icc0
+	beq		icc0,#1,__entry_work_pending
+
+	movsg		psr,gr23
+	andi		gr23,#~PSR_PIL,gr23	; could let do_syscall_trace() call schedule()
+	movgs		gr23,psr
+
+	setlos.p	#1,gr8
+	call		do_syscall_trace
+	bra		__entry_resume_userspace
+
+__syscall_badsys:
+	LEDS		0x6380
+	setlos		#-ENOSYS,gr8
+	sti		gr8,@(gr28,#REG_GR(8))	; save return value
+	bra		__entry_resume_userspace
+
+
+###############################################################################
+#
+# syscall vector table
+#
+###############################################################################
+#ifdef CONFIG_MMU
+#define __MMU(X) X
+#else
+#define __MMU(X) sys_ni_syscall
+#endif
+
+	.section .rodata
+ALIGN
+	.globl		sys_call_table
+sys_call_table:
+	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
+	.long sys_exit
+	.long sys_fork
+	.long sys_read
+	.long sys_write
+	.long sys_open		/* 5 */
+	.long sys_close
+	.long sys_waitpid
+	.long sys_creat
+	.long sys_link
+	.long sys_unlink		/* 10 */
+	.long sys_execve
+	.long sys_chdir
+	.long sys_time
+	.long sys_mknod
+	.long sys_chmod		/* 15 */
+	.long sys_lchown16
+	.long sys_ni_syscall			/* old break syscall holder */
+	.long sys_stat
+	.long sys_lseek
+	.long sys_getpid		/* 20 */
+	.long sys_mount
+	.long sys_oldumount
+	.long sys_setuid16
+	.long sys_getuid16
+	.long sys_ni_syscall // sys_stime		/* 25 */
+	.long sys_ptrace
+	.long sys_alarm
+	.long sys_fstat
+	.long sys_pause
+	.long sys_utime		/* 30 */
+	.long sys_ni_syscall			/* old stty syscall holder */
+	.long sys_ni_syscall			/* old gtty syscall holder */
+	.long sys_access
+	.long sys_nice
+	.long sys_ni_syscall	/* 35 */	/* old ftime syscall holder */
+	.long sys_sync
+	.long sys_kill
+	.long sys_rename
+	.long sys_mkdir
+	.long sys_rmdir		/* 40 */
+	.long sys_dup
+	.long sys_pipe
+	.long sys_times
+	.long sys_ni_syscall			/* old prof syscall holder */
+	.long sys_brk		/* 45 */
+	.long sys_setgid16
+	.long sys_getgid16
+	.long sys_ni_syscall // sys_signal
+	.long sys_geteuid16
+	.long sys_getegid16	/* 50 */
+	.long sys_acct
+	.long sys_umount				/* recycled never used phys( */
+	.long sys_ni_syscall			/* old lock syscall holder */
+	.long sys_ioctl
+	.long sys_fcntl		/* 55 */
+	.long sys_ni_syscall			/* old mpx syscall holder */
+	.long sys_setpgid
+	.long sys_ni_syscall			/* old ulimit syscall holder */
+	.long sys_ni_syscall			/* old old uname syscall */
+	.long sys_umask		/* 60 */
+	.long sys_chroot
+	.long sys_ustat
+	.long sys_dup2
+	.long sys_getppid
+	.long sys_getpgrp	/* 65 */
+	.long sys_setsid
+	.long sys_sigaction
+	.long sys_ni_syscall // sys_sgetmask
+	.long sys_ni_syscall // sys_ssetmask
+	.long sys_setreuid16	/* 70 */
+	.long sys_setregid16
+	.long sys_sigsuspend
+	.long sys_ni_syscall // sys_sigpending
+	.long sys_sethostname
+	.long sys_setrlimit	/* 75 */
+	.long sys_ni_syscall // sys_old_getrlimit
+	.long sys_getrusage
+	.long sys_gettimeofday
+	.long sys_settimeofday
+	.long sys_getgroups16	/* 80 */
+	.long sys_setgroups16
+	.long sys_ni_syscall			/* old_select slot */
+	.long sys_symlink
+	.long sys_lstat
+	.long sys_readlink		/* 85 */
+	.long sys_uselib
+	.long sys_swapon
+	.long sys_reboot
+	.long sys_ni_syscall // old_readdir
+	.long sys_ni_syscall	/* 90 */	/* old_mmap slot */
+	.long sys_munmap
+	.long sys_truncate
+	.long sys_ftruncate
+	.long sys_fchmod
+	.long sys_fchown16		/* 95 */
+	.long sys_getpriority
+	.long sys_setpriority
+	.long sys_ni_syscall			/* old profil syscall holder */
+	.long sys_statfs
+	.long sys_fstatfs		/* 100 */
+	.long sys_ni_syscall			/* ioperm for i386 */
+	.long sys_socketcall
+	.long sys_syslog
+	.long sys_setitimer
+	.long sys_getitimer	/* 105 */
+	.long sys_newstat
+	.long sys_newlstat
+	.long sys_newfstat
+	.long sys_ni_syscall	/* obsolete olduname( syscall */
+	.long sys_ni_syscall	/* iopl for i386 */ /* 110 */
+	.long sys_vhangup
+	.long sys_ni_syscall	/* obsolete idle( syscall */
+	.long sys_ni_syscall	/* vm86old for i386 */
+	.long sys_wait4
+	.long sys_swapoff		/* 115 */
+	.long sys_sysinfo
+	.long sys_ipc
+	.long sys_fsync
+	.long sys_sigreturn
+	.long sys_clone		/* 120 */
+	.long sys_setdomainname
+	.long sys_newuname
+	.long sys_ni_syscall	/* old "cacheflush" */
+	.long sys_adjtimex
+	.long __MMU(sys_mprotect) /* 125 */
+	.long sys_sigprocmask
+	.long sys_ni_syscall	/* old "create_module" */
+	.long sys_init_module
+	.long sys_delete_module
+	.long sys_ni_syscall	/* old "get_kernel_syms" */
+	.long sys_quotactl
+	.long sys_getpgid
+	.long sys_fchdir
+	.long sys_bdflush
+	.long sys_sysfs		/* 135 */
+	.long sys_personality
+	.long sys_ni_syscall	/* for afs_syscall */
+	.long sys_setfsuid16
+	.long sys_setfsgid16
+	.long sys_llseek		/* 140 */
+	.long sys_getdents
+	.long sys_select
+	.long sys_flock
+	.long __MMU(sys_msync)
+	.long sys_readv		/* 145 */
+	.long sys_writev
+	.long sys_getsid
+	.long sys_fdatasync
+	.long sys_sysctl
+	.long __MMU(sys_mlock)		/* 150 */
+	.long __MMU(sys_munlock)
+	.long __MMU(sys_mlockall)
+	.long __MMU(sys_munlockall)
+	.long sys_sched_setparam
+	.long sys_sched_getparam   /* 155 */
+	.long sys_sched_setscheduler
+	.long sys_sched_getscheduler
+	.long sys_sched_yield
+	.long sys_sched_get_priority_max
+	.long sys_sched_get_priority_min  /* 160 */
+	.long sys_sched_rr_get_interval
+	.long sys_nanosleep
+	.long __MMU(sys_mremap)
+	.long sys_setresuid16
+	.long sys_getresuid16	/* 165 */
+	.long sys_ni_syscall	/* for vm86 */
+	.long sys_ni_syscall	/* Old sys_query_module */
+	.long sys_poll
+	.long sys_nfsservctl
+	.long sys_setresgid16	/* 170 */
+	.long sys_getresgid16
+	.long sys_prctl
+	.long sys_rt_sigreturn
+	.long sys_rt_sigaction
+	.long sys_rt_sigprocmask	/* 175 */
+	.long sys_rt_sigpending
+	.long sys_rt_sigtimedwait
+	.long sys_rt_sigqueueinfo
+	.long sys_rt_sigsuspend
+	.long sys_pread64		/* 180 */
+	.long sys_pwrite64
+	.long sys_chown16
+	.long sys_getcwd
+	.long sys_capget
+	.long sys_capset           /* 185 */
+	.long sys_sigaltstack
+	.long sys_sendfile
+	.long sys_ni_syscall		/* streams1 */
+	.long sys_ni_syscall		/* streams2 */
+	.long sys_vfork            /* 190 */
+	.long sys_getrlimit
+	.long sys_mmap2
+	.long sys_truncate64
+	.long sys_ftruncate64
+	.long sys_stat64		/* 195 */
+	.long sys_lstat64
+	.long sys_fstat64
+	.long sys_lchown
+	.long sys_getuid
+	.long sys_getgid		/* 200 */
+	.long sys_geteuid
+	.long sys_getegid
+	.long sys_setreuid
+	.long sys_setregid
+	.long sys_getgroups	/* 205 */
+	.long sys_setgroups
+	.long sys_fchown
+	.long sys_setresuid
+	.long sys_getresuid
+	.long sys_setresgid	/* 210 */
+	.long sys_getresgid
+	.long sys_chown
+	.long sys_setuid
+	.long sys_setgid
+	.long sys_setfsuid		/* 215 */
+	.long sys_setfsgid
+	.long sys_pivot_root
+	.long __MMU(sys_mincore)
+	.long __MMU(sys_madvise)
+	.long sys_getdents64	/* 220 */
+	.long sys_fcntl64
+	.long sys_ni_syscall	/* reserved for TUX */
+	.long sys_ni_syscall	/* Reserved for Security */
+	.long sys_gettid
+	.long sys_readahead	/* 225 */
+	.long sys_setxattr
+	.long sys_lsetxattr
+	.long sys_fsetxattr
+	.long sys_getxattr
+	.long sys_lgetxattr	/* 230 */
+	.long sys_fgetxattr
+	.long sys_listxattr
+	.long sys_llistxattr
+	.long sys_flistxattr
+	.long sys_removexattr	/* 235 */
+	.long sys_lremovexattr
+	.long sys_fremovexattr
+ 	.long sys_tkill
+	.long sys_sendfile64
+	.long sys_futex		/* 240 */
+	.long sys_sched_setaffinity
+	.long sys_sched_getaffinity
+	.long sys_ni_syscall	//sys_set_thread_area
+	.long sys_ni_syscall	//sys_get_thread_area
+	.long sys_io_setup	/* 245 */
+	.long sys_io_destroy
+	.long sys_io_getevents
+	.long sys_io_submit
+	.long sys_io_cancel
+	.long sys_fadvise64	/* 250 */
+	.long sys_ni_syscall
+	.long sys_exit_group
+	.long sys_lookup_dcookie
+	.long sys_epoll_create
+	.long sys_epoll_ctl	/* 255 */
+	.long sys_epoll_wait
+ 	.long __MMU(sys_remap_file_pages)
+ 	.long sys_ni_syscall	//sys_set_tid_address
+ 	.long sys_timer_create
+ 	.long sys_timer_settime		/* 260 */
+ 	.long sys_timer_gettime
+ 	.long sys_timer_getoverrun
+ 	.long sys_timer_delete
+ 	.long sys_clock_settime
+ 	.long sys_clock_gettime		/* 265 */
+ 	.long sys_clock_getres
+ 	.long sys_clock_nanosleep
+	.long sys_statfs64
+	.long sys_fstatfs64
+	.long sys_tgkill	/* 270 */
+	.long sys_utimes
+ 	.long sys_fadvise64_64
+	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_mbind
+	.long sys_get_mempolicy
+	.long sys_set_mempolicy
+	.long sys_mq_open
+	.long sys_mq_unlink
+	.long sys_mq_timedsend
+	.long sys_mq_timedreceive	/* 280 */
+	.long sys_mq_notify
+	.long sys_mq_getsetattr
+	.long sys_ni_syscall		/* reserved for kexec */
+
+
+syscall_table_size = (. - sys_call_table)
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/entry-table.S linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/entry-table.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/entry-table.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/entry-table.S	2004-11-05 14:13:03.079565365 +0000
@@ -0,0 +1,277 @@
+/* entry-table.S: main trap vector tables and exception jump table
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/sys.h>
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/spr-regs.h>
+
+###############################################################################
+#
+# declare the main trap and vector tables
+#
+# - the first instruction in each slot is a branch to the appropriate
+#   kernel-mode handler routine
+#
+# - the second instruction in each slot is a branch to the debug-mode hardware
+#   single-step bypass handler - this is called from break.S to deal with the
+#   CPU stepping in to exception handlers (particular where external interrupts
+#   are concerned)
+#
+# - the linker script places the user mode and kernel mode trap tables on to
+#   the same 8Kb page, so that break.S can be more efficient when performing
+#   single-step bypass management
+#
+###############################################################################
+
+	# trap table for entry from debug mode
+	.section	.trap.break,"ax"
+	.balign		256*16
+	.globl		__entry_breaktrap_table
+__entry_breaktrap_table:
+
+	# trap table for entry from user mode
+	.section	.trap.user,"ax"
+	.balign		256*16
+	.globl		__entry_usertrap_table
+__entry_usertrap_table:
+
+	# trap table for entry from kernel mode
+	.section	.trap.kernel,"ax"
+	.balign		256*16
+	.globl		__entry_kerneltrap_table
+__entry_kerneltrap_table:
+
+	# exception handler jump table
+	.section	.trap.vector,"ax"
+	.balign		256*4
+	.globl		__entry_vector_table
+__entry_vector_table:
+
+	# trap fixup table for single-stepping in user mode
+	.section	.trap.fixup.user,"a"
+	.balign		256*4
+	.globl		__break_usertrap_fixup_table
+__break_usertrap_fixup_table:
+
+	# trap fixup table for single-stepping in user mode
+	.section	.trap.fixup.kernel,"a"
+	.balign		256*4
+	.globl		__break_kerneltrap_fixup_table
+__break_kerneltrap_fixup_table:
+
+	# handler declaration for a sofware or program interrupt
+.macro VECTOR_SOFTPROG tbr_tt, vec
+	.section .trap.user
+	.org		\tbr_tt
+	bra		__entry_uspace_softprog_interrupt
+	.section .trap.fixup.user
+	.org		\tbr_tt >> 2
+	.long		__break_step_uspace_softprog_interrupt
+	.section .trap.kernel
+	.org		\tbr_tt
+	bra		__entry_kernel_softprog_interrupt
+	.section .trap.fixup.kernel
+	.org		\tbr_tt >> 2
+	.long		__break_step_kernel_softprog_interrupt
+	.section .trap.vector
+	.org		\tbr_tt >> 2
+	.long		\vec
+.endm
+
+	# handler declaration for a maskable external interrupt
+.macro VECTOR_IRQ tbr_tt, vec
+	.section .trap.user
+	.org		\tbr_tt
+	bra		__entry_uspace_external_interrupt
+	.section .trap.fixup.user
+	.org		\tbr_tt >> 2
+	.long		__break_step_uspace_external_interrupt
+	.section .trap.kernel
+	.org		\tbr_tt
+	bra		__entry_kernel_external_interrupt
+	.section .trap.fixup.kernel
+	.org		\tbr_tt >> 2
+	.long		__break_step_kernel_external_interrupt
+	.section .trap.vector
+	.org		\tbr_tt >> 2
+	.long		\vec
+.endm
+
+	# handler declaration for an NMI external interrupt
+.macro VECTOR_NMI tbr_tt, vec
+	.section .trap.user
+	.org		\tbr_tt
+	break
+	break
+	break
+	break
+	.section .trap.kernel
+	.org		\tbr_tt
+	break
+	break
+	break
+	break
+	.section .trap.vector
+	.org		\tbr_tt >> 2
+	.long		\vec
+.endm
+
+	# handler declaration for an MMU only sofware or program interrupt
+.macro VECTOR_SP_MMU tbr_tt, vec
+#ifdef CONFIG_MMU
+ 	VECTOR_SOFTPROG	\tbr_tt, \vec
+#else
+	VECTOR_NMI	\tbr_tt, 0
+#endif
+.endm
+
+
+###############################################################################
+#
+# specification of the vectors
+# - note: each macro inserts code into multiple sections
+#
+###############################################################################
+	VECTOR_SP_MMU	TBR_TT_INSTR_MMU_MISS,	__entry_insn_mmu_miss
+	VECTOR_SOFTPROG	TBR_TT_INSTR_ACC_ERROR,	__entry_insn_access_error
+	VECTOR_SOFTPROG	TBR_TT_INSTR_ACC_EXCEP,	__entry_insn_access_exception
+	VECTOR_SOFTPROG	TBR_TT_PRIV_INSTR,	__entry_privileged_instruction
+	VECTOR_SOFTPROG	TBR_TT_ILLEGAL_INSTR,	__entry_illegal_instruction
+	VECTOR_SOFTPROG	TBR_TT_FP_EXCEPTION,	__entry_media_exception
+	VECTOR_SOFTPROG	TBR_TT_MP_EXCEPTION,	__entry_media_exception
+	VECTOR_SOFTPROG	TBR_TT_DATA_ACC_ERROR,	__entry_data_access_error
+	VECTOR_SP_MMU	TBR_TT_DATA_MMU_MISS,	__entry_data_mmu_miss
+	VECTOR_SOFTPROG	TBR_TT_DATA_ACC_EXCEP,	__entry_data_access_exception
+	VECTOR_SOFTPROG	TBR_TT_DATA_STR_ERROR,	__entry_data_store_error
+	VECTOR_SOFTPROG	TBR_TT_DIVISION_EXCEP,	__entry_division_exception
+
+#ifdef CONFIG_MMU
+	.section .trap.user
+	.org		TBR_TT_INSTR_TLB_MISS
+	.globl		__trap_user_insn_tlb_miss
+__trap_user_insn_tlb_miss:
+	movsg		ear0,gr28			/* faulting address */
+	movsg		scr0,gr31			/* get mapped PTD coverage start address */
+	xor.p		gr28,gr31,gr31			/* compare addresses */
+	bra		__entry_user_insn_tlb_miss
+
+	.org		TBR_TT_DATA_TLB_MISS
+	.globl		__trap_user_data_tlb_miss
+__trap_user_data_tlb_miss:
+	movsg		ear0,gr28			/* faulting address */
+	movsg		scr1,gr31			/* get mapped PTD coverage start address */
+	xor.p		gr28,gr31,gr31			/* compare addresses */
+	bra		__entry_user_data_tlb_miss
+
+	.section .trap.kernel
+	.org		TBR_TT_INSTR_TLB_MISS
+	.globl		__trap_kernel_insn_tlb_miss
+__trap_kernel_insn_tlb_miss:
+	movsg		ear0,gr29			/* faulting address */
+	movsg		scr0,gr31			/* get mapped PTD coverage start address */
+	xor.p		gr29,gr31,gr31			/* compare addresses */
+	bra		__entry_kernel_insn_tlb_miss
+
+	.org		TBR_TT_DATA_TLB_MISS
+	.globl		__trap_kernel_data_tlb_miss
+__trap_kernel_data_tlb_miss:
+	movsg		ear0,gr29			/* faulting address */
+	movsg		scr1,gr31			/* get mapped PTD coverage start address */
+	xor.p		gr29,gr31,gr31			/* compare addresses */
+	bra		__entry_kernel_data_tlb_miss
+
+	.section .trap.fixup.user
+	.org		TBR_TT_INSTR_TLB_MISS >> 2
+	.globl		__trap_fixup_user_insn_tlb_miss
+__trap_fixup_user_insn_tlb_miss:
+	.long		__break_user_insn_tlb_miss
+	.org		TBR_TT_DATA_TLB_MISS >> 2
+	.globl		__trap_fixup_user_data_tlb_miss
+__trap_fixup_user_data_tlb_miss:
+	.long		__break_user_data_tlb_miss
+
+	.section .trap.fixup.kernel
+	.org		TBR_TT_INSTR_TLB_MISS >> 2
+	.globl		__trap_fixup_kernel_insn_tlb_miss
+__trap_fixup_kernel_insn_tlb_miss:
+	.long		__break_kernel_insn_tlb_miss
+	.org		TBR_TT_DATA_TLB_MISS >> 2
+	.globl		__trap_fixup_kernel_data_tlb_miss
+__trap_fixup_kernel_data_tlb_miss:
+	.long		__break_kernel_data_tlb_miss
+	
+	.section .trap.vector
+	.org		TBR_TT_INSTR_TLB_MISS >> 2
+	.long		__entry_insn_mmu_fault
+	.org		TBR_TT_DATA_TLB_MISS >> 2
+	.long		__entry_data_mmu_fault
+#endif
+
+	VECTOR_SP_MMU	TBR_TT_DATA_DAT_EXCEP,	__entry_data_dat_fault
+	VECTOR_NMI	TBR_TT_DECREMENT_TIMER,	__entry_do_NMI
+	VECTOR_SOFTPROG	TBR_TT_COMPOUND_EXCEP,	__entry_compound_exception
+	VECTOR_IRQ	TBR_TT_INTERRUPT_1,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_2,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_3,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_4,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_5,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_6,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_7,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_8,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_9,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_10,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_11,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_12,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_13,	__entry_do_IRQ
+	VECTOR_IRQ	TBR_TT_INTERRUPT_14,	__entry_do_IRQ
+	VECTOR_NMI	TBR_TT_INTERRUPT_15,	__entry_do_NMI
+
+	# miscellaneous user mode entry points
+	.section	.trap.user
+	.org		TBR_TT_TRAP0
+	.rept		127
+	bra		__entry_uspace_softprog_interrupt
+	bra		__break_step_uspace_softprog_interrupt
+	.long		0,0
+	.endr
+	.org		TBR_TT_BREAK
+	bra		__entry_break
+	.long		0,0,0
+
+	# miscellaneous kernel mode entry points
+	.section	.trap.kernel
+	.org		TBR_TT_TRAP0
+	.rept		127
+	bra		__entry_kernel_softprog_interrupt
+	bra		__break_step_kernel_softprog_interrupt
+	.long		0,0
+	.endr
+	.org		TBR_TT_BREAK
+	bra		__entry_break
+	.long		0,0,0
+
+	# miscellaneous debug mode entry points
+	.section	.trap.break
+	.org		TBR_TT_BREAK
+	movsg		bpcsr,gr30
+	jmpl		@(gr30,gr0)
+
+	# miscellaneous vectors
+	.section	.trap.vector
+	.org		TBR_TT_TRAP0 >> 2
+	.long		system_call
+	.rept		126
+	.long		__entry_unsupported_trap
+	.endr
+	.org		TBR_TT_BREAK >> 2
+	.long		__entry_debug_exception
