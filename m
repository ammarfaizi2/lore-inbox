Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSIJSL5>; Tue, 10 Sep 2002 14:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317872AbSIJSLH>; Tue, 10 Sep 2002 14:11:07 -0400
Received: from nameservices.net ([208.234.25.16]:11712 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S317862AbSIJSJY>;
	Tue, 10 Sep 2002 14:09:24 -0400
Message-ID: <3D7E3730.A153E3A6@opersys.com>
Date: Tue, 10 Sep 2002 14:17:20 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] 8/8 LTT for 2.5.34: MIPS trace support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds trace support for the MIPS. These files are modified:
arch/mips/config.in
arch/mips/ddb5476/irq.c
arch/mips/kernel/irq.c
arch/mips/kernel/scall_o32.S
arch/mips/kernel/time.c
arch/mips/kernel/traps.c
arch/mips/kernel/unaligned.c
arch/mips/kernel/fault.c
include/asm-mips/trace.h

Revisions still pending.

diff -urN linux-2.5.34/arch/mips/config.in linux-2.5.34-ltt/arch/mips/config.in
--- linux-2.5.34/arch/mips/config.in	Mon Sep  9 13:35:13 2002
+++ linux-2.5.34-ltt/arch/mips/config.in	Mon Sep  9 19:06:34 2002
@@ -477,6 +477,8 @@
 
 source drivers/usb/Config.in
 
+source drivers/trace/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
diff -urN linux-2.5.34/arch/mips/ddb5476/irq.c linux-2.5.34-ltt/arch/mips/ddb5476/irq.c
--- linux-2.5.34/arch/mips/ddb5476/irq.c	Mon Sep  9 13:35:15 2002
+++ linux-2.5.34-ltt/arch/mips/ddb5476/irq.c	Mon Sep  9 19:06:34 2002
@@ -3,6 +3,10 @@
  *
  *  Copyright (C) 2000 Geert Uytterhoeven <geert@sonycom.com>
  *                     Sony Software Development Center Europe (SDCE), Brussels
+ *
+ *  ---- for LTT patch ----
+ * Copyright (C) 2001 Takuzo O'Hara (takuzo@sm.sony.co.jp).
+ *
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -12,6 +16,8 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 
+#include <linux/trace.h>
+
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/ptrace.h>
@@ -184,6 +190,7 @@
 	/* Handle the timer interrupt first */
 	if (mask & (1 << NILE4_INT_GPT)) {
 		nile4_disable_irq(NILE4_INT_GPT);
+		TRACE_IRQ_ENTRY(nile4_to_irq(NILE4_INT_GPT), ((regs->cp0_status & ST0_KSU) == KSU_KERNEL));
 		do_IRQ(nile4_to_irq(NILE4_INT_GPT), regs);
 		nile4_enable_irq(NILE4_INT_GPT);
 		mask &= ~(1 << NILE4_INT_GPT);
@@ -193,8 +200,10 @@
 			nile4_disable_irq(nile4_irq);
 			if (nile4_irq == NILE4_INT_INTC) {
 				int i8259_irq = nile4_i8259_iack();
+				TRACE_IRQ_ENTRY(i8259_irq, ((regs->cp0_status & ST0_KSU) == KSU_KERNEL));
 				i8259_do_irq(i8259_irq, regs);
 			} else {
+			        TRACE_IRQ_ENTRY(nile4_to_irq(nile4_irq), ((regs->cp0_status & ST0_KSU) == KSU_KERNEL));
 				do_IRQ(nile4_to_irq(nile4_irq), regs);
 			}
 			nile4_enable_irq(nile4_irq);
@@ -204,6 +213,7 @@
 		ddb5476_led_d3(0);
 	ddb5476_led_hex(nesting < 16 ? nesting : 15);
 #endif
+        TRACE_IRQ_EXIT();
 }
 
 void ddb_local1_irqdispatch(void)
diff -urN linux-2.5.34/arch/mips/kernel/irq.c linux-2.5.34-ltt/arch/mips/kernel/irq.c
--- linux-2.5.34/arch/mips/kernel/irq.c	Mon Sep  9 13:35:03 2002
+++ linux-2.5.34-ltt/arch/mips/kernel/irq.c	Mon Sep  9 19:06:34 2002
@@ -7,6 +7,10 @@
  *
  * Copyright (C) 1992 Linus Torvalds
  * Copyright (C) 1994 - 2000 Ralf Baechle
+ *
+ *  ---- for LTT patch ----
+ * Copyright (C) 2001 Takuzo O'Hara (takuzo@sm.sony.co.jp).
+ *
  */
 #include <linux/kernel.h>
 #include <linux/irq.h>
@@ -19,6 +23,8 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 
+#include <linux/trace.h>
+
 #include <asm/system.h>
 
 /*
@@ -244,6 +250,8 @@
 	struct irqaction * action;
 	unsigned int status;
 
+	TRACE_IRQ_ENTRY(irq, ((regs->cp0_status & ST0_KSU) == KSU_KERNEL));
+
 	kstat.irqs[cpu][irq]++;
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
@@ -302,6 +310,8 @@
 	 */
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
+
+        TRACE_IRQ_EXIT();
 
 	if (softirq_pending(cpu))
 		do_softirq();
diff -urN linux-2.5.34/arch/mips/kernel/scall_o32.S linux-2.5.34-ltt/arch/mips/kernel/scall_o32.S
--- linux-2.5.34/arch/mips/kernel/scall_o32.S	Mon Sep  9 13:35:14 2002
+++ linux-2.5.34-ltt/arch/mips/kernel/scall_o32.S	Mon Sep  9 19:06:34 2002
@@ -4,7 +4,12 @@
  * for more details.
  *
  * Copyright (C) 1997, 1998, 1999, 2000 by Ralf Baechle
+ *
+ *  ---- for LTT patch ----
+ * Copyright (C) 2001 Takuzo O'Hara (takuzo@sm.sony.co.jp).
+ *
  */
+	
 #include <asm/asm.h>
 #include <linux/errno.h>
 #include <asm/current.h>
@@ -48,6 +53,10 @@
 	bgez	t0, stackargs
 
 stack_done:
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+        sw      a3, PT_R26(sp)          # save for syscall restart
+	b	ltt_trace_a_syscall
+#endif /* (CONFIG_TRACE || CONFIG_TRACE_MODULE) */ 
         sw      a3, PT_R26(sp)          # save for syscall restart
 #error	lw	t0, TASK_PTRACE($28)	# syscall tracing enabled?
 	andi	t0, PT_TRACESYS
@@ -95,6 +104,35 @@
 	SAVE_STATIC
 	jal	schedule
 	b	o32_ret_from_sys_call
+
+/* ------------------------------------------------------------------------ */
+
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+ltt_trace_a_syscall:
+	SAVE_STATIC
+	sw	t2, PT_R1(sp)
+	move	a0, sp
+	jal	trace_real_syscall_entry
+	lw	t2, PT_R1(sp)
+
+	lw	a0, PT_R4(sp)		# Restore argument registers
+	lw	a1, PT_R5(sp)
+	lw	a2, PT_R6(sp)
+	lw	a3, PT_R7(sp)
+	jalr	t2
+
+	li	t0, -EMAXERRNO - 1	# error?
+	sltu	t0, t0, v0
+	sw	t0, PT_R7(sp)		# set error flag
+	beqz	t0, 1f
+
+	negu	v0			# error
+	sw	v0, PT_R0(sp)		# set flag for syscall restarting
+1:	sw	v0, PT_R2(sp)		# result
+
+	jal	trace_real_syscall_exit
+	j	o32_ret_from_sys_call
+#endif /* (CONFIG_TRACE || CONFIG_TRACE_MODULE) */	
 
 /* ------------------------------------------------------------------------ */
 
diff -urN linux-2.5.34/arch/mips/kernel/time.c linux-2.5.34-ltt/arch/mips/kernel/time.c
--- linux-2.5.34/arch/mips/kernel/time.c	Mon Sep  9 13:35:09 2002
+++ linux-2.5.34-ltt/arch/mips/kernel/time.c	Mon Sep  9 19:06:34 2002
@@ -368,6 +368,8 @@
 {
 	int cpu = smp_processor_id();
 
+	TRACE_IRQ_ENTRY(irq, ((regs->cp0_status & ST0_KSU) == KSU_KERNEL));
+
 	irq_enter(cpu, irq);
 	kstat.irqs[cpu][irq]++;
 
@@ -375,6 +377,8 @@
 	timer_interrupt(irq, NULL, regs);
 	
 	irq_exit(cpu, irq);
+
+	TRACE_IRQ_EXIT();
 
 	if (softirq_pending(cpu))
 		do_softirq();
diff -urN linux-2.5.34/arch/mips/kernel/traps.c linux-2.5.34-ltt/arch/mips/kernel/traps.c
--- linux-2.5.34/arch/mips/kernel/traps.c	Mon Sep  9 13:35:09 2002
+++ linux-2.5.34-ltt/arch/mips/kernel/traps.c	Mon Sep  9 23:54:39 2002
@@ -10,6 +10,10 @@
  *
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
+ *
+ *  ---- for LTT patch ----
+ * Copyright (C) 2001 Takuzo O'Hara (takuzo@sm.sony.co.jp).
+ *
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -20,6 +24,8 @@
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 
+#include <linux/trace.h>
+
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
 #include <asm/cpu.h>
@@ -34,6 +40,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
+#include <asm/unistd.h>
 
 /*
  * Machine specific interrupt handlers
@@ -186,6 +193,81 @@
 	}
 }
 
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+asmlinkage void trace_real_syscall_entry(struct pt_regs *regs)
+{
+#if 0
+	int use_depth;
+	int use_bounds;
+	int depth = 0;
+	int seek_depth;
+	unsigned long lower_bound;
+	unsigned long upper_bound;
+	unsigned long addr;
+	unsigned long *stack;
+#endif
+	trace_syscall_entry trace_syscall_event;
+
+	/* Set the syscall ID */
+	trace_syscall_event.syscall_id = (uint8_t) (regs->regs[2] - __NR_Linux);	/* v0 */
+
+	/* Set the address in any case */
+	trace_syscall_event.address = regs->cp0_epc;
+
+	/* Are we in the kernel (This is a kernel thread)? */
+	if ((regs->cp0_status & ST0_KSU) == KSU_KERNEL)
+		/* Don't go digining anywhere */
+		goto trace_syscall_end;		// takuzo: why? noone wants to monitor kernel threads?
+
+#if 0				// takuzo: I'll just do it later
+	/* Get the trace configuration */
+	if (trace_get_config(&use_depth,
+			     &use_bounds,
+			     &seek_depth,
+			     (void *) &lower_bound,
+			     (void *) &upper_bound) < 0)
+		goto trace_syscall_end;
+
+	/* Do we have to search for an eip address range */
+	if ((use_depth == 1) || (use_bounds == 1)) {
+		/* Start at the top of the stack (bottom address since stacks grow downward) */
+		stack = (unsigned long *) regs->esp;
+
+		/* Keep on going until we reach the end of the process' stack limit (wherever it may be) */
+		while (!get_user(addr, stack)) {
+			/* Does this LOOK LIKE an address in the program */
+			if ((addr > current->mm->start_code)
+			    && (addr < current->mm->end_code)) {
+				/* Does this address fit the description */
+				if (((use_depth == 1) && (depth == seek_depth))
+				    || ((use_bounds == 1) && (addr > lower_bound) && (addr < upper_bound))) {
+					/* Set the address */
+					trace_syscall_event.address = addr;
+
+					/* We're done */
+					goto trace_syscall_end;
+				} else
+					/* We're one depth more */
+					depth++;
+			}
+			/* Go on to the next address */
+			stack++;
+		}
+	}
+#endif				/* 0 */
+
+trace_syscall_end:
+	/* Trace the event */
+	trace_event(TRACE_EV_SYSCALL_ENTRY, &trace_syscall_event);
+}
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+	trace_event(TRACE_EV_SYSCALL_EXIT, NULL);
+}
+
+#endif				/* (CONFIG_TRACE || CONFIG_TRACE_MODULE) */
+
 spinlock_t die_lock;
 
 extern void __die(const char * str, struct pt_regs * regs, const char *where,
@@ -312,20 +394,28 @@
 
 asmlinkage void do_ibe(struct pt_regs *regs)
 {
+//	TRACE_TRAP_ENTRY(EXC_CODE(regs->cp0_cause), regs->cp0_epc);
 	ibe_board_handler(regs);
+//	TRACE_TRAP_EXIT();
 }
 
 asmlinkage void do_dbe(struct pt_regs *regs)
 {
+//	TRACE_TRAP_ENTRY(EXC_CODE(regs->cp0_cause), regs->cp0_epc);
 	dbe_board_handler(regs);
+//	TRACE_TRAP_EXIT();
 }
 
 asmlinkage void do_ov(struct pt_regs *regs)
 {
-	if (compute_return_epc(regs))
-		return;
+//	TRACE_TRAP_ENTRY(EXC_CODE(regs->cp0_cause), regs->cp0_epc);
+        if (compute_return_epc(regs)) {
+//       	TRACE_TRAP_EXIT();
+	        return;
+	}
 
 	force_sig(SIGFPE, current);
+//	TRACE_TRAP_EXIT();
 }
 
 /*
@@ -333,6 +423,7 @@
  */
 asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 {
+//	TRACE_TRAP_ENTRY(EXC_CODE(regs->cp0_cause), regs->cp0_epc);
 	if (fcr31 & FPU_CSR_UNI_X) {
 		extern void save_fp(struct task_struct *);
 		extern void restore_fp(struct task_struct *);
@@ -366,14 +457,18 @@
 		if (sig)
 			force_sig(sig, current);
 
+//       	TRACE_TRAP_EXIT();
 		return;
 	}
 
-	if (compute_return_epc(regs))
+	if (compute_return_epc(regs)){
+//       	TRACE_TRAP_EXIT();
 		return;
+	}
 
 	force_sig(SIGFPE, current);
 	printk(KERN_DEBUG "Sent send SIGFPE to %s\n", current->comm);
+//     	TRACE_TRAP_EXIT();
 }
 
 static inline int get_insn_opcode(struct pt_regs *regs, unsigned int *opcode)
@@ -395,6 +490,8 @@
 	unsigned int opcode, bcode;
 	unsigned int *epc;
 
+//	TRACE_TRAP_ENTRY(EXC_CODE(regs->cp0_cause), regs->cp0_epc);
+
 	epc = (unsigned int *) regs->cp0_epc +
 	      ((regs->cp0_cause & CAUSEF_BD) != 0);
 	if (get_user(opcode, epc))
@@ -428,10 +525,12 @@
 	default:
 		force_sig(SIGTRAP, current);
 	}
+//	TRACE_TRAP_EXIT();
 	return;
 
 sigsegv:
 	force_sig(SIGSEGV, current);
+//	TRACE_TRAP_EXIT();
 }
 
 asmlinkage void do_tr(struct pt_regs *regs)
@@ -493,21 +592,27 @@
 
 	if (!user_mode(regs))
 		BUG();
+//	TRACE_TRAP_ENTRY(EXC_CODE(regs->cp0_cause), regs->cp0_epc);
 
 	if (!get_insn_opcode(regs, &opcode)) {
 		if ((opcode & OPCODE) == LL) {
 			simulate_ll(regs, opcode);
+			//	TRACE_TRAP_EXIT();
 			return;
 		}
 		if ((opcode & OPCODE) == SC) {
 			simulate_sc(regs, opcode);
+			//	TRACE_TRAP_EXIT();
 			return;
 		}
 	}
 
-	if (compute_return_epc(regs))
+	if (compute_return_epc(regs)) {
+	  //	TRACE_TRAP_EXIT();
 		return;
+	}
 	force_sig(SIGILL, current);
+//	TRACE_TRAP_EXIT();
 }
 
 /*
@@ -623,6 +728,8 @@
 	void fpu_emulator_init_fpu(void);
 	int sig;
 
+//	TRACE_TRAP_ENTRY(EXC_CODE(regs->cp0_cause), regs->cp0_epc);
+
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 	if (cpid != 1)
 		goto bad_cid;
@@ -631,8 +738,10 @@
 		goto fp_emul;
 
 	regs->cp0_status |= ST0_CU1;
-	if (last_task_used_math == current)
+	if (last_task_used_math == current) {
+	  //	TRACE_TRAP_EXIT();
 		return;
+	}
 
 	if (current->used_math) {		/* Using the FPU again.  */
 		lazy_fpu_switch(last_task_used_math);
@@ -641,6 +750,7 @@
 		current->used_math = 1;
 	}
 	last_task_used_math = current;
+//	TRACE_TRAP_EXIT();
 	return;
 
 fp_emul:
@@ -654,10 +764,12 @@
 	last_task_used_math = current;
 	if (sig)
 		force_sig(sig, current);
+//	TRACE_TRAP_EXIT();
 	return;
 
 bad_cid:
 	force_sig(SIGILL, current);
+//	TRACE_TRAP_EXIT();
 }
 
 asmlinkage void do_watch(struct pt_regs *regs)
@@ -666,7 +778,9 @@
 	 * We use the watch exception where available to detect stack
 	 * overflows.
 	 */
+//	TRACE_TRAP_ENTRY(EXC_CODE(regs->cp0_cause), regs->cp0_epc);
 	show_regs(regs);
+//      TRACE_TRACE_EXIT();
 	panic("Caught WATCH exception - probably caused by stack overflow.");
 }
 
@@ -684,7 +798,9 @@
 	 * caused by a new unknown cpu type or after another deadly
 	 * hard/software error.
 	 */
+//	TRACE_TRAP_ENTRY(EXC_CODE(regs->cp0_cause), regs->cp0_epc);
 	show_regs(regs);
+//      TRACE_TRACE_EXIT();
 	panic("Caught reserved exception - should not happen.");
 }
 
diff -urN linux-2.5.34/arch/mips/kernel/unaligned.c linux-2.5.34-ltt/arch/mips/kernel/unaligned.c
--- linux-2.5.34/arch/mips/kernel/unaligned.c	Mon Sep  9 13:35:01 2002
+++ linux-2.5.34-ltt/arch/mips/kernel/unaligned.c	Mon Sep  9 19:06:34 2002
@@ -8,6 +8,9 @@
  * Copyright (C) 1996, 1998 by Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics, Inc.
  *
+ *  ---- for LTT patch ----
+ * Copyright (C) 2001 Takuzo O'Hara (takuzo@sm.sony.co.jp).
+ *
  * This file contains exception handler for address error exception with the
  * special capability to execute faulting instructions in software.  The
  * handler does not try to handle the case when the program counter points
@@ -78,6 +81,8 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 
+#include <linux/trace.h>
+
 #include <asm/asm.h>
 #include <asm/branch.h>
 #include <asm/byteorder.h>
@@ -400,6 +405,8 @@
 		return;
 	}
 
+//	TRACE_TRAP_ENTRY(EXC_CODE(regs->cp0_cause), regs->cp0_epc);
+
 	/*
 	 * Did we catch a fault trying to load an instruction?
 	 * This also catches attempts to activate MIPS16 code on
@@ -409,8 +416,10 @@
 		goto sigbus;
 
 	pc = regs->cp0_epc + ((regs->cp0_cause & CAUSEF_BD) ? 4 : 0);
-	if (compute_return_epc(regs))
+	if (compute_return_epc(regs)){
+	  //    TRACE_TRAP_EXIT();
 		return;
+	}
 	if ((current->thread.mflags & MF_FIXADE) == 0)
 		goto sigbus;
 
@@ -419,11 +428,13 @@
 	unaligned_instructions++;
 #endif
 
+//      TRACE_TRAP_EXIT();
 	return;
 
 sigbus:
 	die_if_kernel ("Kernel unaligned instruction access", regs);
 	force_sig(SIGBUS, current);
 
+//      TRACE_TRAP_EXIT();
 	return;
 }
diff -urN linux-2.5.34/arch/mips/mm/fault.c linux-2.5.34-ltt/arch/mips/mm/fault.c
--- linux-2.5.34/arch/mips/mm/fault.c	Mon Sep  9 13:35:06 2002
+++ linux-2.5.34-ltt/arch/mips/mm/fault.c	Mon Sep  9 19:06:34 2002
@@ -4,6 +4,10 @@
  * for more details.
  *
  * Copyright (C) 1995 - 2000 by Ralf Baechle
+ *
+ *  ---- for LTT patch ----
+ * Copyright (C) 2001 Takuzo O'Hara (takuzo@sm.sony.co.jp).
+ *
  */
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -19,12 +23,18 @@
 #include <linux/smp_lock.h>
 #include <linux/version.h>
 
+#include <linux/trace.h>
+
 #include <asm/hardirq.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/softirq.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/mipsregs.h>
+#include <asm/unistd.h>
+
+#define EXC_CODE(x)     ((CAUSEF_EXCCODE & (x)) >> CAUSEB_EXCCODE)
 
 #define development_version (LINUX_VERSION_CODE & 0x100)
 
@@ -87,6 +97,10 @@
  * we can handle it..
  */
 good_area:
+	// takuzo: 
+	// I only made this to log page faults for reasonable usermode context.
+	// page faults in kernel, fixups, sigbuses are siliently ignored...
+	TRACE_TRAP_ENTRY(EXC_CODE(regs->cp0_cause), regs->cp0_epc);
 	info.si_code = SEGV_ACCERR;
 
 	if (write) {
@@ -116,6 +130,7 @@
 	}
 
 	up_read(&mm->mmap_sem);
+//      TRACE_TRAP_EXIT();
 	return;
 
 /*
diff -urN linux-2.5.34/include/asm-mips/trace.h linux-2.5.34-ltt/include/asm-mips/trace.h
--- linux-2.5.34/include/asm-mips/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.34-ltt/include/asm-mips/trace.h	Mon Sep  9 19:06:35 2002
@@ -0,0 +1,15 @@
+/*
+ * linux/include/asm-mips/trace.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * MIPS definitions for tracing system
+ */
+
+#include <linux/trace.h>
+
+/* Current arch type */
+#define TRACE_ARCH_TYPE TRACE_ARCH_TYPE_MIPS
+
+/* Current variant type */
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_NONE
