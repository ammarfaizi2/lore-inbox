Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271001AbSKECF5>; Mon, 4 Nov 2002 21:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270898AbSKECEq>; Mon, 4 Nov 2002 21:04:46 -0500
Received: from nameservices.net ([208.234.25.16]:58280 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S266254AbSKEB6a>;
	Mon, 4 Nov 2002 20:58:30 -0500
Message-ID: <3DC72832.4DE4E852@opersys.com>
Date: Mon, 04 Nov 2002 21:08:50 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.46 9/10: MIPS trace support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


D: This patch adds the bare-minimum MIPS-specific low-level trace
D: statements.

diffstat:
 arch/mips/baget/irq.c        |    5 +
 arch/mips/ddb5476/irq.c      |   10 +++
 arch/mips/dec/irq.c          |    5 +
 arch/mips/kernel/i8259.c     |    4 +
 arch/mips/kernel/ipc.c       |    3 +
 arch/mips/kernel/irq.c       |    5 +
 arch/mips/kernel/scall_o32.S |   22 +++++++
 arch/mips/kernel/time.c      |    5 +
 arch/mips/kernel/traps.c     |  123 +++++++++++++++++++++++++++++++++++++++++--
 arch/mips/kernel/unaligned.c |   10 +++
 arch/mips/mm/fault.c         |    9 +++
 include/asm-mips/trace.h     |   16 +++++
 12 files changed, 211 insertions(+), 6 deletions(-)

diff -urpN linux-2.5.46/arch/mips/baget/irq.c linux-2.5.46-ltt/arch/mips/baget/irq.c
--- linux-2.5.46/arch/mips/baget/irq.c	Mon Nov  4 17:30:36 2002
+++ linux-2.5.46-ltt/arch/mips/baget/irq.c	Mon Nov  4 19:01:57 2002
@@ -18,6 +18,7 @@
 #include <linux/random.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
+#include <linux/trace.h>
 
 #include <asm/bitops.h>
 #include <asm/bootinfo.h>
@@ -178,6 +179,8 @@ static void do_IRQ(int irq, struct pt_re
 	struct irqaction *action;
 	int do_random, cpu;
 
+	TRACE_IRQ_ENTRY(irq, !user_mode(regs));
+
 	cpu = smp_processor_id();
 	irq_enter(cpu, irq);
 	kstat_cpu(cpu).irqs[irq]++;
@@ -203,6 +206,8 @@ static void do_IRQ(int irq, struct pt_re
 	unmask_irq(irq);
 	irq_exit(cpu, irq);
 
+	TRACE_IRQ_EXIT();
+
 	/* unmasking and bottom half handling is done magically for us. */
 }
 
diff -urpN linux-2.5.46/arch/mips/ddb5476/irq.c linux-2.5.46-ltt/arch/mips/ddb5476/irq.c
--- linux-2.5.46/arch/mips/ddb5476/irq.c	Mon Nov  4 17:30:47 2002
+++ linux-2.5.46-ltt/arch/mips/ddb5476/irq.c	Mon Nov  4 19:01:57 2002
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
@@ -184,6 +190,7 @@ void ddb_local0_irqdispatch(struct pt_re
 	/* Handle the timer interrupt first */
 	if (mask & (1 << NILE4_INT_GPT)) {
 		nile4_disable_irq(NILE4_INT_GPT);
+		TRACE_IRQ_ENTRY(nile4_to_irq(NILE4_INT_GPT), ((regs->cp0_status & ST0_KSU) == KSU_KERNEL));
 		do_IRQ(nile4_to_irq(NILE4_INT_GPT), regs);
 		nile4_enable_irq(NILE4_INT_GPT);
 		mask &= ~(1 << NILE4_INT_GPT);
@@ -193,8 +200,10 @@ void ddb_local0_irqdispatch(struct pt_re
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
@@ -204,6 +213,7 @@ void ddb_local0_irqdispatch(struct pt_re
 		ddb5476_led_d3(0);
 	ddb5476_led_hex(nesting < 16 ? nesting : 15);
 #endif
+        TRACE_IRQ_EXIT();
 }
 
 void ddb_local1_irqdispatch(void)
diff -urpN linux-2.5.46/arch/mips/dec/irq.c linux-2.5.46-ltt/arch/mips/dec/irq.c
--- linux-2.5.46/arch/mips/dec/irq.c	Mon Nov  4 17:30:31 2002
+++ linux-2.5.46-ltt/arch/mips/dec/irq.c	Mon Nov  4 19:01:57 2002
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/seq_file.h>
+#include <linux/trace.h>
 
 #include <asm/bitops.h>
 #include <asm/bootinfo.h>
@@ -128,6 +129,8 @@ asmlinkage void do_IRQ(int irq, struct p
     struct irqaction *action;
     int do_random, cpu;
 
+    TRACE_IRQ_ENTRY(irq, !user_mode(regs));
+
     cpu = smp_processor_id();
     irq_enter(cpu, irq);
     kstat_cpu(cpu).irqs[irq]++;
@@ -151,6 +154,8 @@ asmlinkage void do_IRQ(int irq, struct p
     }
     irq_exit(cpu, irq);
 
+    TRACE_IRQ_EXIT();
+
     /* unmasking and bottom half handling is done magically for us. */
 }
 
diff -urpN linux-2.5.46/arch/mips/kernel/i8259.c linux-2.5.46-ltt/arch/mips/kernel/i8259.c
--- linux-2.5.46/arch/mips/kernel/i8259.c	Mon Nov  4 17:30:09 2002
+++ linux-2.5.46-ltt/arch/mips/kernel/i8259.c	Mon Nov  4 19:01:57 2002
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
+#include <linux/trace.h>
 
 #include <asm/io.h>
 
@@ -267,6 +268,9 @@ void __init init_8259A(int auto_eoi)
 asmlinkage void i8259_do_irq(int irq, struct pt_regs regs)
 {
 	panic("i8259_do_irq: I want to be implemented");
+
+	TRACE_IRQ_ENTRY(irq, !user_mode(regs));
+	TRACE_IRQ_EXIT();
 }
 
 /*
diff -urpN linux-2.5.46/arch/mips/kernel/ipc.c linux-2.5.46-ltt/arch/mips/kernel/ipc.c
--- linux-2.5.46/arch/mips/kernel/ipc.c	Mon Nov  4 17:30:09 2002
+++ linux-2.5.46-ltt/arch/mips/kernel/ipc.c	Mon Nov  4 19:01:57 2002
@@ -13,6 +13,7 @@
 #include <linux/sem.h>
 #include <linux/msg.h>
 #include <linux/shm.h>
+#include <linux/trace.h>
 
 #include <asm/ipc.h>
 #include <asm/uaccess.h>
@@ -30,6 +31,8 @@ asmlinkage int sys_ipc (uint call, int f
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
+	TRACE_IPC(TRACE_EV_IPC_CALL, call, first);
+
 	switch (call) {
 	case SEMOP:
 		return sys_semop (first, (struct sembuf *)ptr, second);
diff -urpN linux-2.5.46/arch/mips/kernel/irq.c linux-2.5.46-ltt/arch/mips/kernel/irq.c
--- linux-2.5.46/arch/mips/kernel/irq.c	Mon Nov  4 17:30:07 2002
+++ linux-2.5.46-ltt/arch/mips/kernel/irq.c	Mon Nov  4 19:07:42 2002
@@ -18,6 +18,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/trace.h>
 
 #include <asm/system.h>
 
@@ -244,6 +245,8 @@ asmlinkage unsigned int do_IRQ(int irq, 
 	struct irqaction * action;
 	unsigned int status;
 
+	TRACE_IRQ_ENTRY(irq, !user_mode(regs));
+
 	kstat_cpu(cpu).irqs[irq]++;
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
@@ -303,6 +306,8 @@ out:
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
 
+	TRACE_IRQ_EXIT();
+
 	if (softirq_pending(cpu))
 		do_softirq();
 	return 1;
diff -urpN linux-2.5.46/arch/mips/kernel/scall_o32.S linux-2.5.46-ltt/arch/mips/kernel/scall_o32.S
--- linux-2.5.46/arch/mips/kernel/scall_o32.S	Mon Nov  4 17:30:46 2002
+++ linux-2.5.46-ltt/arch/mips/kernel/scall_o32.S	Mon Nov  4 19:01:57 2002
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 1997, 1998, 1999, 2000 by Ralf Baechle
  */
+	
 #include <asm/asm.h>
 #include <linux/errno.h>
 #include <asm/current.h>
@@ -49,6 +50,19 @@ NESTED(handle_sys, PT_SIZE, sp)
 
 stack_done:
         sw      a3, PT_R26(sp)          # save for syscall restart
+
+#if (CONFIG_TRACE)
+	sw	t2, PT_R1(sp)
+	move	a0, sp
+	jal	trace_real_syscall_entry
+	lw	t2, PT_R1(sp)
+
+	lw	a0, PT_R4(sp)		# Restore argument registers
+	lw	a1, PT_R5(sp)
+	lw	a2, PT_R6(sp)
+	lw	a3, PT_R7(sp)
+#endif /* (CONFIG_TRACE) */
+
 #error	lw	t0, TASK_PTRACE($28)	# syscall tracing enabled?
 	andi	t0, PT_TRACESYS
 	bnez	t0, trace_a_syscall
@@ -64,6 +78,10 @@ stack_done:
 	sw	v0, PT_R0(sp)		# set flag for syscall restarting
 1:	sw	v0, PT_R2(sp)		# result
 
+#if (CONFIG_TRACE)
+	jal	trace_real_syscall_exit
+#endif /* (CONFIG_TRACE) */
+
 EXPORT(o32_ret_from_sys_call)
 	mfc0	t0, CP0_STATUS		# need_resched and signals atomic test
 	ori	t0, t0, 1
@@ -119,6 +137,10 @@ trace_a_syscall:
 	sw	v0, PT_R0(sp)		# set flag for syscall restarting
 1:	sw	v0, PT_R2(sp)		# result
 
+#if (CONFIG_TRACE)
+	jal	trace_real_syscall_exit
+#endif /* (CONFIG_TRACE) */
+
 #error	jal	syscall_trace
 	j	ret_from_sys_call
 
diff -urpN linux-2.5.46/arch/mips/kernel/time.c linux-2.5.46-ltt/arch/mips/kernel/time.c
--- linux-2.5.46/arch/mips/kernel/time.c	Mon Nov  4 17:30:25 2002
+++ linux-2.5.46-ltt/arch/mips/kernel/time.c	Mon Nov  4 19:01:57 2002
@@ -21,6 +21,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/trace.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -368,6 +369,8 @@ asmlinkage void ll_timer_interrupt(int i
 {
 	int cpu = smp_processor_id();
 
+	TRACE_TRAP_ENTRY(irq, CAUSE_EPC(regs));
+
 	irq_enter(cpu, irq);
 	kstat_cpu(cpu).irqs[irq]++;
 
@@ -376,6 +379,8 @@ asmlinkage void ll_timer_interrupt(int i
 	
 	irq_exit(cpu, irq);
 
+	TRACE_IRQ_EXIT();
+
 	if (softirq_pending(cpu))
 		do_softirq();
 }
diff -urpN linux-2.5.46/arch/mips/kernel/traps.c linux-2.5.46-ltt/arch/mips/kernel/traps.c
--- linux-2.5.46/arch/mips/kernel/traps.c	Mon Nov  4 17:30:25 2002
+++ linux-2.5.46-ltt/arch/mips/kernel/traps.c	Mon Nov  4 19:01:57 2002
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
+#include <linux/trace.h>
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
@@ -34,6 +35,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
+#include <asm/unistd.h>
 
 /*
  * Machine specific interrupt handlers
@@ -312,20 +314,28 @@ static void default_be_board_handler(str
 
 asmlinkage void do_ibe(struct pt_regs *regs)
 {
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
 	ibe_board_handler(regs);
+	TRACE_TRAP_EXIT();
 }
 
 asmlinkage void do_dbe(struct pt_regs *regs)
 {
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
 	dbe_board_handler(regs);
+	TRACE_TRAP_EXIT();
 }
 
 asmlinkage void do_ov(struct pt_regs *regs)
 {
-	if (compute_return_epc(regs))
-		return;
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
+	if (compute_return_epc(regs)) {
+		TRACE_TRAP_EXIT();
+	        return;
+	}
 
 	force_sig(SIGFPE, current);
+	TRACE_TRAP_EXIT();
 }
 
 /*
@@ -333,6 +343,7 @@ asmlinkage void do_ov(struct pt_regs *re
  */
 asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 {
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
 	if (fcr31 & FPU_CSR_UNI_X) {
 		extern void save_fp(struct task_struct *);
 		extern void restore_fp(struct task_struct *);
@@ -366,14 +377,18 @@ asmlinkage void do_fpe(struct pt_regs *r
 		if (sig)
 			force_sig(sig, current);
 
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
-	if (compute_return_epc(regs))
+	if (compute_return_epc(regs)) {
+		TRACE_TRAP_EXIT();
 		return;
+	}
 
 	force_sig(SIGFPE, current);
 	printk(KERN_DEBUG "Sent send SIGFPE to %s\n", current->comm);
+	TRACE_TRAP_EXIT();
 }
 
 static inline int get_insn_opcode(struct pt_regs *regs, unsigned int *opcode)
@@ -395,6 +410,8 @@ asmlinkage void do_bp(struct pt_regs *re
 	unsigned int opcode, bcode;
 	unsigned int *epc;
 
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
+
 	epc = (unsigned int *) regs->cp0_epc +
 	      ((regs->cp0_cause & CAUSEF_BD) != 0);
 	if (get_user(opcode, epc))
@@ -428,10 +445,12 @@ asmlinkage void do_bp(struct pt_regs *re
 	default:
 		force_sig(SIGTRAP, current);
 	}
+	TRACE_TRAP_EXIT();
 	return;
 
 sigsegv:
 	force_sig(SIGSEGV, current);
+	TRACE_TRAP_EXIT();
 }
 
 asmlinkage void do_tr(struct pt_regs *regs)
@@ -440,6 +459,8 @@ asmlinkage void do_tr(struct pt_regs *re
 	unsigned int opcode, bcode;
 	unsigned *epc;
 
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
+
 	epc = (unsigned int *) regs->cp0_epc +
 	      ((regs->cp0_cause & CAUSEF_BD) != 0);
 	if (get_user(opcode, epc))
@@ -468,10 +489,12 @@ asmlinkage void do_tr(struct pt_regs *re
 	default:
 		force_sig(SIGTRAP, current);
 	}
+	TRACE_TRAP_EXIT();
 	return;
 
 sigsegv:
 	force_sig(SIGSEGV, current);
+	TRACE_TRAP_EXIT();
 }
 
 #ifndef CONFIG_CPU_HAS_LLSC
@@ -493,21 +516,27 @@ asmlinkage void do_ri(struct pt_regs *re
 
 	if (!user_mode(regs))
 		BUG();
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
 
 	if (!get_insn_opcode(regs, &opcode)) {
 		if ((opcode & OPCODE) == LL) {
 			simulate_ll(regs, opcode);
+			TRACE_TRAP_EXIT();
 			return;
 		}
 		if ((opcode & OPCODE) == SC) {
 			simulate_sc(regs, opcode);
+			TRACE_TRAP_EXIT();
 			return;
 		}
 	}
 
-	if (compute_return_epc(regs))
+	if (compute_return_epc(regs)) {
+		TRACE_TRAP_EXIT();
 		return;
+	}
 	force_sig(SIGILL, current);
+	TRACE_TRAP_EXIT();
 }
 
 /*
@@ -623,6 +652,8 @@ asmlinkage void do_cpu(struct pt_regs *r
 	void fpu_emulator_init_fpu(void);
 	int sig;
 
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
+
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 	if (cpid != 1)
 		goto bad_cid;
@@ -631,8 +662,10 @@ asmlinkage void do_cpu(struct pt_regs *r
 		goto fp_emul;
 
 	regs->cp0_status |= ST0_CU1;
-	if (last_task_used_math == current)
+	if (last_task_used_math == current) {
+		TRACE_TRAP_EXIT();
 		return;
+	}
 
 	if (current->used_math) {		/* Using the FPU again.  */
 		lazy_fpu_switch(last_task_used_math);
@@ -641,6 +674,8 @@ asmlinkage void do_cpu(struct pt_regs *r
 		current->used_math = 1;
 	}
 	last_task_used_math = current;
+
+	TRACE_TRAP_EXIT();
 	return;
 
 fp_emul:
@@ -654,10 +689,12 @@ fp_emul:
 	last_task_used_math = current;
 	if (sig)
 		force_sig(sig, current);
+	TRACE_TRAP_EXIT();
 	return;
 
 bad_cid:
 	force_sig(SIGILL, current);
+	TRACE_TRAP_EXIT();
 }
 
 asmlinkage void do_watch(struct pt_regs *regs)
@@ -666,13 +703,17 @@ asmlinkage void do_watch(struct pt_regs 
 	 * We use the watch exception where available to detect stack
 	 * overflows.
 	 */
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
 	show_regs(regs);
+	TRACE_TRAP_EXIT();
 	panic("Caught WATCH exception - probably caused by stack overflow.");
 }
 
 asmlinkage void do_mcheck(struct pt_regs *regs)
 {
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
 	show_regs(regs);
+	TRACE_TRAP_EXIT();
 	panic("Caught Machine Check exception - probably caused by multiple "
 	      "matching entries in the TLB.");
 }
@@ -947,3 +988,75 @@ void __init trap_init(void)
 	write_32bit_cp0_register(CP0_CONTEXT, smp_processor_id()<<23);
 	current_pgd[0] = init_mm.pgd;
 }
+
+#if (CONFIG_TRACE)
+asmlinkage void trace_real_syscall_entry(struct pt_regs * regs)
+{
+	unsigned long       addr;
+	int                 depth = 0;
+	unsigned long       end_code;
+	unsigned long       lower_bound;
+	int                 seek_depth;
+	unsigned long       *stack;
+	unsigned long       start_code;
+	unsigned long       *start_stack;
+	trace_syscall_entry trace_syscall_event;
+	unsigned long       upper_bound;
+	int                 use_bounds;
+	int                 use_depth;
+
+	/* syscall_id will be negative for SVR4, IRIX5, BSD43, and POSIX
+	 * syscalls -- these are not supported at this point by LTT
+	 */
+	trace_syscall_event.syscall_id = (uint8_t) (regs->regs[2] - __NR_Linux);
+
+	trace_syscall_event.address  = regs->cp0_epc;
+
+	if (!user_mode(regs))
+		goto trace_syscall_end;
+
+	if (trace_get_config(&use_depth,
+			     &use_bounds,
+			     &seek_depth,
+			     (void*)&lower_bound,
+			     (void*)&upper_bound) < 0)
+		goto trace_syscall_end;
+
+	/* Heuristic that might work:
+	 * (BUT DOESN'T WORK for any of the cases I tested...) zzz
+	 * Search through stack until a value is found that is within the
+	 * range start_code .. end_code.  (This is looking for a return
+	 * pointer to where a shared library was called from.)  If a stack
+	 * variable contains a valid code address then an incorrect
+	 * result will be generated.
+	 */
+	if ((use_depth == 1) || (use_bounds == 1)) {
+		stack       = (unsigned long*) regs->regs[29];
+		end_code    = current->mm->end_code;
+		start_code  = current->mm->start_code;
+		start_stack = (unsigned long *)current->mm->start_stack;
+
+		while ((stack <= start_stack) && (!__get_user(addr, stack))) {
+			if ((addr > start_code) && (addr < end_code)) {
+				if (((use_depth  == 1) && (depth == seek_depth)) ||
+				    ((use_bounds == 1) && (addr > lower_bound) && (addr < upper_bound))) {
+					trace_syscall_event.address = addr;
+					goto trace_syscall_end;
+				} else {
+					depth++;
+				}
+			}
+		stack++;
+		}
+	}
+
+trace_syscall_end:
+	trace_event(TRACE_EV_SYSCALL_ENTRY, &trace_syscall_event);
+}
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+        trace_event(TRACE_EV_SYSCALL_EXIT, NULL);
+}
+
+#endif /* (CONFIG_TRACE) */
diff -urpN linux-2.5.46/arch/mips/kernel/unaligned.c linux-2.5.46-ltt/arch/mips/kernel/unaligned.c
--- linux-2.5.46/arch/mips/kernel/unaligned.c	Mon Nov  4 17:30:32 2002
+++ linux-2.5.46-ltt/arch/mips/kernel/unaligned.c	Mon Nov  4 19:01:57 2002
@@ -77,6 +77,7 @@
 #include <linux/signal.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
+#include <linux/trace.h>
 
 #include <asm/asm.h>
 #include <asm/branch.h>
@@ -388,6 +389,8 @@ asmlinkage void do_ade(struct pt_regs *r
 	unsigned long pc;
 	extern int do_dsemulret(struct pt_regs *);
 
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
+
 	/* 
 	 * Address errors may be deliberately induced
 	 * by the FPU emulator to take retake control
@@ -397,6 +400,7 @@ asmlinkage void do_ade(struct pt_regs *r
 
 	if ((unsigned long)regs->cp0_epc == current->thread.dsemul_aerpc) {
 		do_dsemulret(regs);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
@@ -409,8 +413,10 @@ asmlinkage void do_ade(struct pt_regs *r
 		goto sigbus;
 
 	pc = regs->cp0_epc + ((regs->cp0_cause & CAUSEF_BD) ? 4 : 0);
-	if (compute_return_epc(regs))
+	if (compute_return_epc(regs)) {
+		TRACE_TRAP_EXIT();
 		return;
+	}
 	if ((current->thread.mflags & MF_FIXADE) == 0)
 		goto sigbus;
 
@@ -419,11 +425,13 @@ asmlinkage void do_ade(struct pt_regs *r
 	unaligned_instructions++;
 #endif
 
+	TRACE_TRAP_EXIT();
 	return;
 
 sigbus:
 	die_if_kernel ("Kernel unaligned instruction access", regs);
 	force_sig(SIGBUS, current);
 
+	TRACE_TRAP_EXIT();
 	return;
 }
diff -urpN linux-2.5.46/arch/mips/mm/fault.c linux-2.5.46-ltt/arch/mips/mm/fault.c
--- linux-2.5.46/arch/mips/mm/fault.c	Mon Nov  4 17:30:16 2002
+++ linux-2.5.46-ltt/arch/mips/mm/fault.c	Mon Nov  4 19:01:57 2002
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/version.h>
+#include <linux/trace.h>
 
 #include <asm/hardirq.h>
 #include <asm/pgalloc.h>
@@ -25,6 +26,7 @@
 #include <asm/softirq.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/mipsregs.h>
 
 #define development_version (LINUX_VERSION_CODE & 0x100)
 
@@ -49,6 +51,8 @@ asmlinkage void do_page_fault(struct pt_
 	unsigned long fixup;
 	siginfo_t info;
 
+	TRACE_TRAP_ENTRY(CAUSE_EXCCODE(regs), CAUSE_EPC(regs));
+
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
@@ -116,6 +120,7 @@ good_area:
 	}
 
 	up_read(&mm->mmap_sem);
+	TRACE_TRAP_EXIT();
 	return;
 
 /*
@@ -144,6 +149,7 @@ bad_area_nosemaphore:
 		/* info.si_code has been set above */
 		info.si_addr = (void *) address;
 		force_sig_info(SIGSEGV, &info, tsk);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
@@ -159,6 +165,7 @@ no_context:
 			printk(KERN_DEBUG "%s: Exception at [<%lx>] (%lx)\n",
 			       tsk->comm, regs->cp0_epc, new_epc);
 		regs->cp0_epc = new_epc;
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
@@ -201,6 +208,7 @@ do_sigbus:
 	if (!user_mode(regs))
 		goto no_context;
 
+	TRACE_TRAP_EXIT();
 	return;
 
 vmalloc_fault:
@@ -230,4 +238,5 @@ vmalloc_fault:
 			goto bad_area_nosemaphore;
 		set_pmd(pmd, *pmd_k);
 	}
+	TRACE_TRAP_EXIT();
 }
diff -urpN linux-2.5.46/include/asm-mips/trace.h linux-2.5.46-ltt/include/asm-mips/trace.h
--- linux-2.5.46/include/asm-mips/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.46-ltt/include/asm-mips/trace.h	Mon Nov  4 19:01:58 2002
@@ -0,0 +1,16 @@
+/*
+ * linux/include/asm-mips/trace.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * MIPS definitions for tracing system
+ */
+
+#include <linux/trace.h>
+#include <asm-generic/trace.h>
+
+/* Current arch type */
+#define TRACE_ARCH_TYPE TRACE_ARCH_TYPE_MIPS
+
+/* Current variant type */
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_NONE
