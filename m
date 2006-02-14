Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWBNQkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWBNQkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWBNQkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:40:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33462 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422636AbWBNQkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:40:16 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, msalter@redhat.com
Subject: [PATCH] FRV: Use virtual interrupt disablement
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 14 Feb 2006 16:40:06 +0000
Message-ID: <3820.1139935206@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the FRV arch use virtual interrupt disablement because
accesses to the processor status register (PSR) are relatively slow and because
we will soon have the need to deal with multiple interrupt controls at the same
time (separate h/w and inter-core interrupts).

The way this is done is to dedicate one of the four integer condition code
registers (ICC2) to maintaining a virtual interrupt disablement state whilst
inside the kernel. This uses the ICC2.Z flag (Zero) to indicate whether the
interrupts are virtually disabled and the ICC2.C flag (Carry) to indicate
whether the interrupts are physically disabled.

ICC2.Z is set to indicate interrupts are virtually disabled. ICC2.C is set to
indicate interrupts are physically enabled. Under normal running conditions
Z==0 and C==1.

Disabling interrupts with local_irq_disable() doesn't then actually physically
disable interrupts - it merely sets ICC2.Z to 1. Should an interrupt then
happen, the exception prologue will note ICC2.Z is set and branch out of line
using one instruction (an unlikely BEQ). Here it will physically disable
interrupts and clear ICC2.C.

When it comes time to enable interrupts (local_irq_enable()), this simply
clears the ICC2.Z flag and invokes a trap #2 if both Z and C flags are clear
(the HI integer condition). This can be done with the TIHI conditional trap
instruction.

The trap then physically reenables interrupts and sets ICC2.C again. Upon
returning the interrupt will be taken as interrupts will then be enabled. Note
that whilst processing the trap, the whole exceptions system is disabled, and
so an interrupt can't happen till it returns.

If no pending interrupt had happened, ICC2.C would still be set, the HI
condition would not be fulfilled, and no trap will happen.


Saving interrupts (local_irq_save) is simply a matter of pulling the ICC2.Z
flag out of the CCR register, shifting it down and masking it off. This gives a
result of 0 if interrupts were enabled and 1 if they weren't.

Restoring interrupts (local_irq_restore) is then a matter of taking the saved
value mentioned previously and XOR'ing it against 1. If it was one, the result
will be zero, and if it was zero the result will be non-zero. This result is
then used to affect the ICC2.Z flag directly (it is a condition code flag after
all). An XOR instruction does not affect the Carry flag, and so that bit of
state is unchanged. The two flags can then be sampled to see if they're both
zero using the trap (TIHI) as for the unconditional reenablement
(local_irq_enable).


This patch also:

 (1) Modifies the debugging stub (break.S) to handle single-stepping crossing
     into the trap #2 handler and into virtually disabled interrupts.

 (2) Removes superseded fixup pointers from the second instructions in the trap
     tables (there's no a separate fixup table for this).

 (3) Declares the trap #3 vector for use in .org directives in the trap table.

 (4) Moves irq_enter() and irq_exit() in do_IRQ() to avoid problems with
     virtual interrupt handling, and removes the duplicate code that has now
     been folded into irq_exit() (softirq and preemption handling).

 (5) Tells the compiler in the arch Makefile that ICC2 is now reserved.

 (6) Documents the in-kernel ABI, including the virtual interrupts.

 (7) Renames the old irq management functions to different names.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-virq-2616rc2-2.diff 
 Documentation/fujitsu/frv/kernel-ABI.txt |  234 +++++++++++++++++++++++++++++++
 arch/frv/Makefile                        |    2 
 arch/frv/boot/Image                      |binary
 arch/frv/kernel/break.S                  |   77 +++++++++-
 arch/frv/kernel/entry-table.S            |   39 ++++-
 arch/frv/kernel/entry.S                  |   65 +++++++-
 arch/frv/kernel/head.S                   |    3 
 arch/frv/kernel/irq.c                    |   41 -----
 include/asm-frv/spr-regs.h               |    1 
 include/asm-frv/system.h                 |   88 ++++++++++-
 10 files changed, 489 insertions(+), 61 deletions(-)

Binary files linux-2.6.16-rc2-frv/arch/frv/boot/Image and linux-2.6.16-rc2-frv-int/arch/frv/boot/Image differ
diff -uNrp linux-2.6.16-rc2-frv/arch/frv/kernel/break.S linux-2.6.16-rc2-frv-int/arch/frv/kernel/break.S
--- linux-2.6.16-rc2-frv/arch/frv/kernel/break.S	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.16-rc2-frv-int/arch/frv/kernel/break.S	2006-02-14 14:23:11.000000000 +0000
@@ -200,12 +200,20 @@ __break_step:
 	movsg		bpcsr,gr2
 	sethi.p		%hi(__entry_kernel_external_interrupt),gr3
 	setlo		%lo(__entry_kernel_external_interrupt),gr3
-	subcc		gr2,gr3,gr0,icc0
+	subcc.p		gr2,gr3,gr0,icc0
+	sethi		%hi(__entry_uspace_external_interrupt),gr3
+	setlo.p		%lo(__entry_uspace_external_interrupt),gr3
 	beq		icc0,#2,__break_step_kernel_external_interrupt
-	sethi.p		%hi(__entry_uspace_external_interrupt),gr3
-	setlo		%lo(__entry_uspace_external_interrupt),gr3
-	subcc		gr2,gr3,gr0,icc0
+	subcc.p		gr2,gr3,gr0,icc0
+	sethi		%hi(__entry_kernel_external_interrupt_virtually_disabled),gr3
+	setlo.p		%lo(__entry_kernel_external_interrupt_virtually_disabled),gr3
 	beq		icc0,#2,__break_step_uspace_external_interrupt
+	subcc.p		gr2,gr3,gr0,icc0
+	sethi		%hi(__entry_kernel_external_interrupt_virtual_reenable),gr3
+	setlo.p		%lo(__entry_kernel_external_interrupt_virtual_reenable),gr3
+	beq		icc0,#2,__break_step_kernel_external_interrupt_virtually_disabled
+	subcc		gr2,gr3,gr0,icc0
+	beq		icc0,#2,__break_step_kernel_external_interrupt_virtual_reenable
 
 	LEDS		0x2007,gr2
 
@@ -254,6 +262,9 @@ __break_step_kernel_softprog_interrupt:
 # step through an external interrupt from kernel mode
 	.globl		__break_step_kernel_external_interrupt
 __break_step_kernel_external_interrupt:
+	# deal with virtual interrupt disablement
+	beq		icc2,#0,__break_step_kernel_external_interrupt_virtually_disabled
+
 	sethi.p		%hi(__entry_kernel_external_interrupt_reentry),gr3
 	setlo		%lo(__entry_kernel_external_interrupt_reentry),gr3
 
@@ -294,6 +305,64 @@ __break_return_as_kernel_prologue:
 #endif
 	rett		#1
 
+# we single-stepped into an interrupt handler whilst interrupts were merely virtually disabled
+# need to really disable interrupts, set flag, fix up and return
+__break_step_kernel_external_interrupt_virtually_disabled:
+	movsg		psr,gr2
+	andi		gr2,#~PSR_PIL,gr2
+	ori		gr2,#PSR_PIL_14,gr2	/* debugging interrupts only */
+	movgs		gr2,psr
+
+	ldi		@(gr31,#REG_CCR),gr3
+	movgs		gr3,ccr
+	subcc.p		gr0,gr0,gr0,icc2	/* leave Z set, clear C */
+
+	# exceptions must've been enabled and we must've been in supervisor mode
+	setlos		BPSR_BET|BPSR_BS,gr3
+	movgs		gr3,bpsr
+
+	# return to where the interrupt happened
+	movsg		pcsr,gr2
+	movgs		gr2,bpcsr
+
+	lddi.p		@(gr31,#REG_GR(2)),gr2
+
+	xor		gr31,gr31,gr31
+	movgs		gr0,brr
+#ifdef CONFIG_MMU
+	movsg		scr3,gr31
+#endif
+	rett		#1
+
+# we stepped through into the virtual interrupt reenablement trap
+#
+# we also want to single step anyway, but after fixing up so that we get an event on the
+# instruction after the broken-into exception returns
+	.globl		__break_step_kernel_external_interrupt_virtual_reenable
+__break_step_kernel_external_interrupt_virtual_reenable:
+	movsg		psr,gr2
+	andi		gr2,#~PSR_PIL,gr2
+	movgs		gr2,psr
+
+	ldi		@(gr31,#REG_CCR),gr3
+	movgs		gr3,ccr
+	subicc		gr0,#1,gr0,icc2		/* clear Z, set C */
+
+	# save the adjusted ICC2
+	movsg		ccr,gr3
+	sti		gr3,@(gr31,#REG_CCR)
+
+	# exceptions must've been enabled and we must've been in supervisor mode
+	setlos		BPSR_BET|BPSR_BS,gr3
+	movgs		gr3,bpsr
+
+	# return to where the trap happened
+	movsg		pcsr,gr2
+	movgs		gr2,bpcsr
+
+	# and then process the single step
+	bra		__break_continue
+
 # step through an internal exception from uspace mode
 	.globl		__break_step_uspace_softprog_interrupt
 __break_step_uspace_softprog_interrupt:
diff -uNrp linux-2.6.16-rc2-frv/arch/frv/kernel/entry.S linux-2.6.16-rc2-frv-int/arch/frv/kernel/entry.S
--- linux-2.6.16-rc2-frv/arch/frv/kernel/entry.S	2006-02-07 18:37:39.000000000 +0000
+++ linux-2.6.16-rc2-frv-int/arch/frv/kernel/entry.S	2006-02-14 13:55:08.000000000 +0000
@@ -141,7 +141,10 @@ __entry_uspace_external_interrupt_reentr
 
 	movsg		gner0,gr4
 	movsg		gner1,gr5
-	stdi		gr4,@(gr28,#REG_GNER0)
+	stdi.p		gr4,@(gr28,#REG_GNER0)
+
+	# interrupts start off fully disabled in the interrupt handler
+	subcc		gr0,gr0,gr0,icc2		/* set Z and clear C */
 
 	# set up kernel global registers
 	sethi.p		%hi(__kernel_current_task),gr5
@@ -193,9 +196,8 @@ __entry_uspace_external_interrupt_reentr
         .type		__entry_kernel_external_interrupt,@function
 __entry_kernel_external_interrupt:
 	LEDS		0x6210
-
-	sub		sp,gr15,gr31
-	LEDS32
+//	sub		sp,gr15,gr31
+//	LEDS32
 
 	# set up the stack pointer
 	or.p		sp,gr0,gr30
@@ -231,7 +233,10 @@ __entry_kernel_external_interrupt_reentr
 	stdi		gr24,@(gr28,#REG_GR(24))
 	stdi		gr26,@(gr28,#REG_GR(26))
 	sti		gr29,@(gr28,#REG_GR(29))
-	stdi		gr30,@(gr28,#REG_GR(30))
+	stdi.p		gr30,@(gr28,#REG_GR(30))
+
+	# note virtual interrupts will be fully enabled upon return
+	subicc		gr0,#1,gr0,icc2			/* clear Z, set C */
 
 	movsg		tbr ,gr20
 	movsg		psr ,gr22
@@ -267,7 +272,10 @@ __entry_kernel_external_interrupt_reentr
 
 	movsg		gner0,gr4
 	movsg		gner1,gr5
-	stdi		gr4,@(gr28,#REG_GNER0)
+	stdi.p		gr4,@(gr28,#REG_GNER0)
+
+	# interrupts start off fully disabled in the interrupt handler
+	subcc		gr0,gr0,gr0,icc2			/* set Z and clear C */
 
 	# set the return address
 	sethi.p		%hi(__entry_return_from_kernel_interrupt),gr4
@@ -291,6 +299,45 @@ __entry_kernel_external_interrupt_reentr
 
 	.size		__entry_kernel_external_interrupt,.-__entry_kernel_external_interrupt
 
+###############################################################################
+#
+# deal with interrupts that were actually virtually disabled
+# - we need to really disable them, flag the fact and return immediately
+# - if you change this, you must alter break.S also
+#
+###############################################################################
+	.balign		L1_CACHE_BYTES
+	.globl		__entry_kernel_external_interrupt_virtually_disabled
+	.type		__entry_kernel_external_interrupt_virtually_disabled,@function
+__entry_kernel_external_interrupt_virtually_disabled:
+	movsg		psr,gr30
+	andi		gr30,#~PSR_PIL,gr30
+	ori		gr30,#PSR_PIL_14,gr30		; debugging interrupts only
+	movgs		gr30,psr
+	subcc		gr0,gr0,gr0,icc2		; leave Z set, clear C
+	rett		#0
+
+	.size		__entry_kernel_external_interrupt_virtually_disabled,.-__entry_kernel_external_interrupt_virtually_disabled
+
+###############################################################################
+#
+# deal with re-enablement of interrupts that were pending when virtually re-enabled
+# - set ICC2.C, re-enable the real interrupts and return
+# - we can clear ICC2.Z because we shouldn't be here if it's not 0 [due to TIHI]
+# - if you change this, you must alter break.S also
+#
+###############################################################################
+	.balign		L1_CACHE_BYTES
+	.globl		__entry_kernel_external_interrupt_virtual_reenable
+	.type		__entry_kernel_external_interrupt_virtual_reenable,@function
+__entry_kernel_external_interrupt_virtual_reenable:
+	movsg		psr,gr30
+	andi		gr30,#~PSR_PIL,gr30		; re-enable interrupts
+	movgs		gr30,psr
+	subicc		gr0,#1,gr0,icc2			; clear Z, set C
+	rett		#0
+
+	.size		__entry_kernel_external_interrupt_virtual_reenable,.-__entry_kernel_external_interrupt_virtual_reenable
 
 ###############################################################################
 #
@@ -335,6 +382,7 @@ __entry_uspace_softprog_interrupt_reentr
 
 	sethi.p		%hi(__entry_return_from_user_exception),gr23
 	setlo		%lo(__entry_return_from_user_exception),gr23
+
 	bra		__entry_common
 
 	.size		__entry_uspace_softprog_interrupt,.-__entry_uspace_softprog_interrupt
@@ -495,7 +543,10 @@ __entry_common:
 
 	movsg		gner0,gr4
 	movsg		gner1,gr5
-	stdi		gr4,@(gr28,#REG_GNER0)
+	stdi.p		gr4,@(gr28,#REG_GNER0)
+
+	# set up virtual interrupt disablement
+	subicc		gr0,#1,gr0,icc2			/* clear Z flag, set C flag */
 
 	# set up kernel global registers
 	sethi.p		%hi(__kernel_current_task),gr5
diff -uNrp linux-2.6.16-rc2-frv/arch/frv/kernel/entry-table.S linux-2.6.16-rc2-frv-int/arch/frv/kernel/entry-table.S
--- linux-2.6.16-rc2-frv/arch/frv/kernel/entry-table.S	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.16-rc2-frv-int/arch/frv/kernel/entry-table.S	2006-02-14 14:05:04.000000000 +0000
@@ -116,6 +116,8 @@ __break_kerneltrap_fixup_table:
 	.long		__break_step_uspace_external_interrupt
 	.section .trap.kernel
 	.org		\tbr_tt
+	# deal with virtual interrupt disablement
+	beq		icc2,#0,__entry_kernel_external_interrupt_virtually_disabled
 	bra		__entry_kernel_external_interrupt
 	.section .trap.fixup.kernel
 	.org		\tbr_tt >> 2
@@ -259,25 +261,52 @@ __trap_fixup_kernel_data_tlb_miss:
 	.org		TBR_TT_TRAP0
 	.rept		127
 	bra		__entry_uspace_softprog_interrupt
-	bra		__break_step_uspace_softprog_interrupt
-	.long		0,0
+	.long		0,0,0
 	.endr
 	.org		TBR_TT_BREAK
 	bra		__entry_break
 	.long		0,0,0
 
+	.section	.trap.fixup.user
+	.org		TBR_TT_TRAP0 >> 2
+	.rept		127
+	.long		__break_step_uspace_softprog_interrupt
+	.endr
+	.org		TBR_TT_BREAK >> 2
+	.long		0
+
 	# miscellaneous kernel mode entry points
 	.section	.trap.kernel
 	.org		TBR_TT_TRAP0
-	.rept		127
 	bra		__entry_kernel_softprog_interrupt
-	bra		__break_step_kernel_softprog_interrupt
-	.long		0,0
+	.org		TBR_TT_TRAP1
+	bra		__entry_kernel_softprog_interrupt
+
+	# trap #2 in kernel - reenable interrupts
+	.org		TBR_TT_TRAP2
+	bra		__entry_kernel_external_interrupt_virtual_reenable
+
+	# miscellaneous kernel traps
+	.org		TBR_TT_TRAP3
+	.rept		124
+	bra		__entry_kernel_softprog_interrupt
+	.long		0,0,0
 	.endr
 	.org		TBR_TT_BREAK
 	bra		__entry_break
 	.long		0,0,0
 
+	.section	.trap.fixup.kernel
+	.org		TBR_TT_TRAP0 >> 2
+	.long		__break_step_kernel_softprog_interrupt
+	.long		__break_step_kernel_softprog_interrupt
+	.long		__break_step_kernel_external_interrupt_virtual_reenable
+	.rept		124
+	.long		__break_step_kernel_softprog_interrupt
+	.endr
+	.org		TBR_TT_BREAK >> 2
+	.long		0
+
 	# miscellaneous debug mode entry points
 	.section	.trap.break
 	.org		TBR_TT_BREAK
diff -uNrp linux-2.6.16-rc2-frv/arch/frv/kernel/head.S linux-2.6.16-rc2-frv-int/arch/frv/kernel/head.S
--- linux-2.6.16-rc2-frv/arch/frv/kernel/head.S	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.16-rc2-frv-int/arch/frv/kernel/head.S	2006-02-10 14:14:38.000000000 +0000
@@ -513,6 +513,9 @@ __head_mmu_enabled:
 	movgs		gr0,ccr
 	movgs		gr0,cccr
 
+	# initialise the virtual interrupt handling
+	subcc		gr0,gr0,gr0,icc2		/* set Z, clear C */
+
 #ifdef CONFIG_MMU
 	movgs		gr3,scr2
 	movgs		gr3,scr3
diff -uNrp linux-2.6.16-rc2-frv/arch/frv/kernel/irq.c linux-2.6.16-rc2-frv-int/arch/frv/kernel/irq.c
--- linux-2.6.16-rc2-frv/arch/frv/kernel/irq.c	2006-02-06 15:25:19.000000000 +0000
+++ linux-2.6.16-rc2-frv-int/arch/frv/kernel/irq.c	2006-02-14 14:30:53.000000000 +0000
@@ -287,18 +287,11 @@ asmlinkage void do_IRQ(void)
 	struct irq_source *source;
 	int level, cpu;
 
+	irq_enter();
+
 	level = (__frame->tbr >> 4) & 0xf;
 	cpu = smp_processor_id();
 
-#if 0
-	{
-		static u32 irqcount;
-		*(volatile u32 *) 0xe1200004 = ~((irqcount++ << 8) | level);
-		*(volatile u16 *) 0xffc00100 = (u16) ~0x9999;
-		mb();
-	}
-#endif
-
 	if ((unsigned long) __frame - (unsigned long) (current + 1) < 512)
 		BUG();
 
@@ -308,40 +301,12 @@ asmlinkage void do_IRQ(void)
 
 	kstat_this_cpu.irqs[level]++;
 
-	irq_enter();
-
 	for (source = frv_irq_levels[level].sources; source; source = source->next)
 		source->doirq(source);
 
-	irq_exit();
-
 	__clr_MASK(level);
 
-	/* only process softirqs if we didn't interrupt another interrupt handler */
-	if ((__frame->psr & PSR_PIL) == PSR_PIL_0)
-		if (local_softirq_pending())
-			do_softirq();
-
-#ifdef CONFIG_PREEMPT
-	local_irq_disable();
-	while (--current->preempt_count == 0) {
-		if (!(__frame->psr & PSR_S) ||
-		    current->need_resched == 0 ||
-		    in_interrupt())
-			break;
-		current->preempt_count++;
-		local_irq_enable();
-		preempt_schedule();
-		local_irq_disable();
-	}
-#endif
-
-#if 0
-	{
-		*(volatile u16 *) 0xffc00100 = (u16) ~0x6666;
-		mb();
-	}
-#endif
+	irq_exit();
 
 } /* end do_IRQ() */
 
diff -uNrp linux-2.6.16-rc2-frv/arch/frv/Makefile linux-2.6.16-rc2-frv-int/arch/frv/Makefile
--- linux-2.6.16-rc2-frv/arch/frv/Makefile	2006-02-06 15:25:19.000000000 +0000
+++ linux-2.6.16-rc2-frv-int/arch/frv/Makefile	2006-02-09 19:55:12.000000000 +0000
@@ -81,7 +81,7 @@ endif
 # - reserve CC3 for use with atomic ops
 # - all the extra registers are dealt with only at context switch time
 CFLAGS		+= -mno-fdpic -mgpr-32 -msoft-float -mno-media
-CFLAGS		+= -ffixed-fcc3 -ffixed-cc3 -ffixed-gr15
+CFLAGS		+= -ffixed-fcc3 -ffixed-cc3 -ffixed-gr15 -ffixed-icc2
 AFLAGS		+= -mno-fdpic
 ASFLAGS		+= -mno-fdpic
 
diff -uNrp linux-2.6.16-rc2-frv/Documentation/fujitsu/frv/kernel-ABI.txt linux-2.6.16-rc2-frv-int/Documentation/fujitsu/frv/kernel-ABI.txt
--- linux-2.6.16-rc2-frv/Documentation/fujitsu/frv/kernel-ABI.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-rc2-frv-int/Documentation/fujitsu/frv/kernel-ABI.txt	2006-02-14 16:19:09.000000000 +0000
@@ -0,0 +1,234 @@
+				 =================================
+				 INTERNAL KERNEL ABI FOR FR-V ARCH
+				 =================================
+
+The internal FRV kernel ABI is not quite the same as the userspace ABI. A number of the registers
+are used for special purposed, and the ABI is not consistent between modules vs core, and MMU vs
+no-MMU.
+
+This partly stems from the fact that FRV CPUs do not have a separate supervisor stack pointer, and
+most of them do not have any scratch registers, thus requiring at least one general purpose
+register to be clobbered in such an event. Also, within the kernel core, it is possible to simply
+jump or call directly between functions using a relative offset. This cannot be extended to modules
+for the displacement is likely to be too far. Thus in modules the address of a function to call
+must be calculated in a register and then used, requiring two extra instructions.
+
+This document has the following sections:
+
+ (*) System call register ABI
+ (*) CPU operating modes
+ (*) Internal kernel-mode register ABI
+ (*) Internal debug-mode register ABI
+ (*) Virtual interrupt handling
+
+
+========================
+SYSTEM CALL REGISTER ABI
+========================
+
+When a system call is made, the following registers are effective:
+
+	REGISTERS	CALL			RETURN
+	===============	=======================	=======================
+	GR7		System call number	Preserved
+	GR8		Syscall arg #1		Return value
+	GR9-GR13	Syscall arg #2-6	Preserved
+
+
+===================
+CPU OPERATING MODES
+===================
+
+The FR-V CPU has three basic operating modes. In order of increasing capability:
+
+  (1) User mode.
+
+      Basic userspace running mode.
+
+  (2) Kernel mode.
+
+      Normal kernel mode. There are many additional control registers available that may be
+      accessed in this mode, in addition to all the stuff available to user mode. This has two
+      submodes:
+
+      (a) Exceptions enabled (PSR.T == 1).
+
+      	  Exceptions will invoke the appropriate normal kernel mode handler. On entry to the
+      	  handler, the PSR.T bit will be cleared.
+
+      (b) Exceptions disabled (PSR.T == 0).
+
+      	  No exceptions or interrupts may happen. Any mandatory exceptions will cause the CPU to
+      	  halt unless the CPU is told to jump into debug mode instead.
+
+  (3) Debug mode.
+
+      No exceptions may happen in this mode. Memory protection and management exceptions will be
+      flagged for later consideration, but the exception handler won't be invoked. Debugging traps
+      such as hardware breakpoints and watchpoints will be ignored. This mode is entered only by
+      debugging events obtained from the other two modes.
+
+      All kernel mode registers may be accessed, plus a few extra debugging specific registers.
+
+
+=================================
+INTERNAL KERNEL-MODE REGISTER ABI
+=================================
+
+There are a number of permanent register assignments that are set up by entry.S in the exception
+prologue. Note that there is a complete set of exception prologues for each of user->kernel
+transition and kernel->kernel transition. There are also user->debug and kernel->debug mode
+transition prologues.
+
+
+	REGISTER	FLAVOUR	USE
+	===============	=======	====================================================
+	GR1			Supervisor stack pointer
+	GR15			Current thread info pointer
+	GR16			GP-Rel base register for small data
+	GR28			Current exception frame pointer (__frame)
+	GR29			Current task pointer (current)
+	GR30			Destroyed by kernel mode entry
+	GR31		NOMMU	Destroyed by debug mode entry
+	GR31		MMU	Destroyed by TLB miss kernel mode entry
+	CCR.ICC2		Virtual interrupt disablement tracking
+	CCCR.CC3		Cleared by exception prologue (atomic op emulation)
+	SCR0		MMU	See mmu-layout.txt.
+	SCR1		MMU	See mmu-layout.txt.
+	SCR2		MMU	Save for EAR0 (destroyed by icache insns in debug mode)
+	SCR3		MMU	Save for GR31 during debug exceptions
+	DAMR/IAMR	NOMMU	Fixed memory protection layout.
+	DAMR/IAMR	MMU	See mmu-layout.txt.
+
+
+Certain registers are also used or modified across function calls:
+
+	REGISTER	CALL				RETURN
+	===============	===============================	===============================
+	GR0		Fixed Zero			-
+	GR2		Function call frame pointer
+	GR3		Special				Preserved
+	GR3-GR7		-				Clobbered
+	GR8		Function call arg #1		Return value (or clobbered)
+	GR9		Function call arg #2		Return value MSW (or clobbered)
+	GR10-GR13	Function call arg #3-#6		Clobbered
+	GR14		-				Clobbered
+	GR15-GR16	Special				Preserved
+	GR17-GR27	-				Preserved
+	GR28-GR31	Special				Only accessed explicitly
+	LR		Return address after CALL	Clobbered
+	CCR/CCCR	-				Mostly Clobbered
+
+
+================================
+INTERNAL DEBUG-MODE REGISTER ABI
+================================
+
+This is the same as the kernel-mode register ABI for functions calls. The difference is that in
+debug-mode there's a different stack and a different exception frame. Almost all the global
+registers from kernel-mode (including the stack pointer) may be changed.
+
+	REGISTER	FLAVOUR	USE
+	===============	=======	====================================================
+	GR1			Debug stack pointer
+	GR16			GP-Rel base register for small data
+	GR31			Current debug exception frame pointer (__debug_frame)
+	SCR3		MMU	Saved value of GR31
+
+
+Note that debug mode is able to interfere with the kernel's emulated atomic ops, so it must be
+exceedingly careful not to do any that would interact with the main kernel in this regard. Hence
+the debug mode code (gdbstub) is almost completely self-contained. The only external code used is
+the sprintf family of functions.
+
+Futhermore, break.S is so complicated because single-step mode does not switch off on entry to an
+exception. That means unless manually disabled, single-stepping will blithely go on stepping into
+things like interrupts. See gdbstub.txt for more information.
+
+
+==========================
+VIRTUAL INTERRUPT HANDLING
+==========================
+
+Because accesses to the PSR is so slow, and to disable interrupts we have to access it twice (once
+to read and once to write), we don't actually disable interrupts at all if we don't have to. What
+we do instead is use the ICC2 condition code flags to note virtual disablement, such that if we
+then do take an interrupt, we note the flag, really disable interrupts, set another flag and resume
+execution at the point the interrupt happened. Setting condition flags as a side effect of an
+arithmetic or logical instruction is really fast. This use of the ICC2 only occurs within the
+kernel - it does not affect userspace.
+
+The flags we use are:
+
+ (*) CCR.ICC2.Z [Zero flag]
+
+     Set to virtually disable interrupts, clear when interrupts are virtually enabled. Can be
+     modified by logical instructions without affecting the Carry flag.
+
+ (*) CCR.ICC2.C [Carry flag]
+
+     Clear to indicate hardware interrupts are really disabled, set otherwise.
+
+
+What happens is this:
+
+ (1) Normal kernel-mode operation.
+
+	ICC2.Z is 0, ICC2.C is 1.
+
+ (2) An interrupt occurs. The exception prologue examines ICC2.Z and determines that nothing needs
+     doing. This is done simply with an unlikely BEQ instruction.
+
+ (3) The interrupts are disabled (local_irq_disable)
+
+	ICC2.Z is set to 1.
+
+ (4) If interrupts were then re-enabled (local_irq_enable):
+
+	ICC2.Z would be set to 0.
+
+     A TIHI #2 instruction (trap #2 if condition HI - Z==0 && C==0) would be used to trap if
+     interrupts were now virtually enabled, but physically disabled - which they're not, so the
+     trap isn't taken. The kernel would then be back to state (1).
+
+ (5) An interrupt occurs. The exception prologue examines ICC2.Z and determines that the interrupt
+     shouldn't actually have happened. It jumps aside, and there disabled interrupts by setting
+     PSR.PIL to 14 and then it clears ICC2.C.
+
+ (6) If interrupts were then saved and disabled again (local_irq_save):
+
+	ICC2.Z would be shifted into the save variable and masked off (giving a 1).
+
+	ICC2.Z would then be set to 1 (thus unchanged), and ICC2.C would be unaffected (ie: 0).
+
+ (7) If interrupts were then restored from state (6) (local_irq_restore):
+
+	ICC2.Z would be set to indicate the result of XOR'ing the saved value (ie: 1) with 1, which
+	gives a result of 0 - thus leaving ICC2.Z set.
+
+	ICC2.C would remain unaffected (ie: 0).
+
+     A TIHI #2 instruction would be used to again assay the current state, but this would do
+     nothing as Z==1.
+
+ (8) If interrupts were then enabled (local_irq_enable):
+
+	ICC2.Z would be cleared. ICC2.C would be left unaffected. Both flags would now be 0.
+
+     A TIHI #2 instruction again issued to assay the current state would then trap as both Z==0
+     [interrupts virtually enabled] and C==0 [interrupts really disabled] would then be true.
+
+ (9) The trap #2 handler would simply enable hardware interrupts (set PSR.PIL to 0), set ICC2.C to
+     1 and return.
+
+(10) Immediately upon returning, the pending interrupt would be taken.
+
+(11) The interrupt handler would take the path of actually processing the interrupt (ICC2.Z is
+     clear, BEQ fails as per step (2)).
+
+(12) The interrupt handler would then set ICC2.C to 1 since hardware interrupts are definitely
+     enabled - or else the kernel wouldn't be here.
+
+(13) On return from the interrupt handler, things would be back to state (1).
+
+This trap (#2) is only available in kernel mode. In user mode it will result in SIGILL.
diff -uNrp linux-2.6.16-rc2-frv/include/asm-frv/spr-regs.h linux-2.6.16-rc2-frv-int/include/asm-frv/spr-regs.h
--- linux-2.6.16-rc2-frv/include/asm-frv/spr-regs.h	2005-03-02 12:08:45.000000000 +0000
+++ linux-2.6.16-rc2-frv-int/include/asm-frv/spr-regs.h	2006-02-10 13:50:43.000000000 +0000
@@ -98,6 +98,7 @@
 #define TBR_TT_TRAP0		(0x80 << 4)
 #define TBR_TT_TRAP1		(0x81 << 4)
 #define TBR_TT_TRAP2		(0x82 << 4)
+#define TBR_TT_TRAP3		(0x83 << 4)
 #define TBR_TT_TRAP126		(0xfe << 4)
 #define TBR_TT_BREAK		(0xff << 4)
 
diff -uNrp linux-2.6.16-rc2-frv/include/asm-frv/system.h linux-2.6.16-rc2-frv-int/include/asm-frv/system.h
--- linux-2.6.16-rc2-frv/include/asm-frv/system.h	2005-06-22 13:52:26.000000000 +0100
+++ linux-2.6.16-rc2-frv-int/include/asm-frv/system.h	2006-02-10 16:44:42.000000000 +0000
@@ -40,8 +40,84 @@ do {									\
 
 /*
  * interrupt flag manipulation
+ * - use virtual interrupt management since touching the PSR is slow
+ *   - ICC2.Z: T if interrupts virtually disabled
+ *   - ICC2.C: F if interrupts really disabled
+ * - if Z==1 upon interrupt:
+ *   - C is set to 0
+ *   - interrupts are really disabled
+ *   - entry.S returns immediately
+ * - uses TIHI (TRAP if Z==0 && C==0) #2 to really reenable interrupts
+ *   - if taken, the trap:
+ *     - sets ICC2.C
+ *     - enables interrupts
  */
-#define local_irq_disable()				\
+#define local_irq_disable()					\
+do {								\
+	/* set Z flag, but don't change the C flag */		\
+	asm volatile("	andcc	gr0,gr0,gr0,icc2	\n"	\
+		     :						\
+		     :						\
+		     : "memory", "icc2"				\
+		     );						\
+} while(0)
+
+#define local_irq_enable()					\
+do {								\
+	/* clear Z flag and then test the C flag */		\
+	asm volatile("  oricc	gr0,#1,gr0,icc2		\n"	\
+		     "	tihi	icc2,gr0,#2		\n"	\
+		     :						\
+		     :						\
+		     : "memory", "icc2"				\
+		     );						\
+} while(0)
+
+#define local_save_flags(flags)					\
+do {								\
+	typecheck(unsigned long, flags);			\
+	asm volatile("movsg ccr,%0"				\
+		     : "=r"(flags)				\
+		     :						\
+		     : "memory");				\
+								\
+	/* shift ICC2.Z to bit 0 */				\
+	flags >>= 26;						\
+								\
+	/* make flags 1 if interrupts disabled, 0 otherwise */	\
+	flags &= 1UL;						\
+} while(0)
+
+#define irqs_disabled() \
+	({unsigned long flags; local_save_flags(flags); flags; })
+
+#define	local_irq_save(flags)			\
+do {						\
+	typecheck(unsigned long, flags);	\
+	local_save_flags(flags);		\
+	local_irq_disable();			\
+} while(0)
+
+#define	local_irq_restore(flags)					\
+do {									\
+	typecheck(unsigned long, flags);				\
+									\
+	/* load the Z flag by turning 1 if disabled into 0 if disabled	\
+	 * and thus setting the Z flag but not the C flag */		\
+	asm volatile("  xoricc	%0,#1,gr0,icc2		\n"		\
+		     /* then test Z=0 and C=0 */			\
+		     "	tihi	icc2,gr0,#2		\n"		\
+		     :							\
+		     : "r"(flags)					\
+		     : "memory", "icc2"					\
+		     );							\
+									\
+} while(0)
+
+/*
+ * real interrupt flag manipulation
+ */
+#define __local_irq_disable()				\
 do {							\
 	unsigned long psr;				\
 	asm volatile("	movsg	psr,%0		\n"	\
@@ -53,7 +129,7 @@ do {							\
 		     : "memory");			\
 } while(0)
 
-#define local_irq_enable()				\
+#define __local_irq_enable()				\
 do {							\
 	unsigned long psr;				\
 	asm volatile("	movsg	psr,%0		\n"	\
@@ -64,7 +140,7 @@ do {							\
 		     : "memory");			\
 } while(0)
 
-#define local_save_flags(flags)			\
+#define __local_save_flags(flags)		\
 do {						\
 	typecheck(unsigned long, flags);	\
 	asm("movsg psr,%0"			\
@@ -73,7 +149,7 @@ do {						\
 	    : "memory");			\
 } while(0)
 
-#define	local_irq_save(flags)				\
+#define	__local_irq_save(flags)				\
 do {							\
 	unsigned long npsr;				\
 	typecheck(unsigned long, flags);		\
@@ -86,7 +162,7 @@ do {							\
 		     : "memory");			\
 } while(0)
 
-#define	local_irq_restore(flags)			\
+#define	__local_irq_restore(flags)			\
 do {							\
 	typecheck(unsigned long, flags);		\
 	asm volatile("	movgs	%0,psr		\n"	\
@@ -95,7 +171,7 @@ do {							\
 		     : "memory");			\
 } while(0)
 
-#define irqs_disabled() \
+#define __irqs_disabled() \
 	((__get_PSR() & PSR_PIL) >= PSR_PIL_14)
 
 /*
