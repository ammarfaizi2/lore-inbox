Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265162AbSJaD02>; Wed, 30 Oct 2002 22:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265161AbSJaDZk>; Wed, 30 Oct 2002 22:25:40 -0500
Received: from nameservices.net ([208.234.25.16]:5297 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S265162AbSJaDUf>;
	Wed, 30 Oct 2002 22:20:35 -0500
Message-ID: <3DC0A401.8D8A0E11@opersys.com>
Date: Wed, 30 Oct 2002 22:31:13 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.45 6/10: PPC trace support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


D: This patch adds the bare-minimum PPC-specific low-level trace
D: statements.

As with all the other non-i386 patches, these modifications will have
to be pushed through the arch maintainers once the core trace
functionality is in. Hence, I am posting them here for reference and
will resend them to the arch maintainers once the core is in.

diffstat:
 arch/ppc/kernel/entry.S    |   33 ++++++++++++++++++
 arch/ppc/kernel/irq.c      |    6 +++
 arch/ppc/kernel/misc.S     |    4 ++
 arch/ppc/kernel/process.c  |   15 ++++++++
 arch/ppc/kernel/syscalls.c |    4 ++
 arch/ppc/kernel/time.c     |    6 +++
 arch/ppc/kernel/traps.c    |   82 +++++++++++++++++++++++++++++++++++++++++++++
 arch/ppc/mm/fault.c        |   17 ++++++++-
 include/asm-ppc/trace.h    |   31 +++++++++++++++++
 9 files changed, 197 insertions(+), 1 deletion(-)

diff -urpN linux-2.5.45/arch/ppc/kernel/entry.S linux-2.5.45-ltt/arch/ppc/kernel/entry.S
--- linux-2.5.45/arch/ppc/kernel/entry.S	Wed Oct 30 19:43:39 2002
+++ linux-2.5.45-ltt/arch/ppc/kernel/entry.S	Wed Oct 30 20:51:10 2002
@@ -103,6 +103,32 @@ stack_ovf:
 	RFI
 #endif /* CONFIG_PPC_ISERIES */
 
+/* LTT stuff */
+#if (CONFIG_TRACE)
+#define TRACE_REAL_ASM_SYSCALL_ENTRY	\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;  	/* Put pointer to registers into r3 */	\
+	mflr	r29;				/* Save LR */ \
+	bl	trace_real_syscall_entry;	/* Call real trace function */ \
+	mtlr	r29;				/* Restore LR */ \
+	lwz	r0,GPR0(r1);			/* Restore original registers */ \
+	lwz	r3,GPR3(r1);	\
+	lwz	r4,GPR4(r1);	\
+	lwz	r5,GPR5(r1);	\
+	lwz	r6,GPR6(r1);	\
+	lwz	r7,GPR7(r1);	\
+	lwz	r8,GPR8(r1);
+#define TRACE_REAL_ASM_SYSCALL_EXIT \
+	bl	trace_real_syscall_exit;	/* Call real trace function */ \
+	lwz	r0,GPR0(r1);			/* Restore original registers */ \
+	lwz	r3,RESULT(r1); \
+	lwz	r4,GPR4(r1); \
+	lwz	r5,GPR5(r1); \
+	lwz	r6,GPR6(r1); \
+	lwz	r7,GPR7(r1); \
+	lwz	r8,GPR8(r1); \
+	addi	r9,r1,STACK_FRAME_OVERHEAD;
+#endif
+
 /*
  * Handle a system call.
  */
@@ -133,6 +159,9 @@ syscall_dotrace_cont:
 	slwi	r0,r0,2
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
 	mtlr	r10
+#if (CONFIG_TRACE)
+ 	TRACE_REAL_ASM_SYSCALL_ENTRY ;
+#endif
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	blrl			/* Call handler */
 	.globl	ret_from_syscall
@@ -140,6 +169,10 @@ ret_from_syscall:
 #ifdef SHOW_SYSCALLS
 	bl	do_show_syscall_exit
 #endif
+#if (CONFIG_TRACE)
+	stw	r3,RESULT(r1)	/* Save result */
+ 	TRACE_REAL_ASM_SYSCALL_EXIT ; 
+#endif
 	mr	r6,r3
 	li	r11,-_LAST_ERRNO
 	cmpl	0,r3,r11
diff -urpN linux-2.5.45/arch/ppc/kernel/irq.c linux-2.5.45-ltt/arch/ppc/kernel/irq.c
--- linux-2.5.45/arch/ppc/kernel/irq.c	Wed Oct 30 19:43:38 2002
+++ linux-2.5.45-ltt/arch/ppc/kernel/irq.c	Wed Oct 30 20:51:10 2002
@@ -45,6 +45,8 @@
 #include <linux/random.h>
 #include <linux/seq_file.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
 #include <asm/system.h>
@@ -423,6 +425,8 @@ void ppc_irq_dispatch_handler(struct pt_
 	int cpu = smp_processor_id();
 	irq_desc_t *desc = irq_desc + irq;
 
+	TRACE_IRQ_ENTRY(irq, !(user_mode(regs)));
+
 	kstat.irqs[cpu][irq]++;
 	spin_lock(&desc->lock);
 	ack_irq(irq);	
@@ -500,6 +504,8 @@ out:
 			irq_desc[irq].handler->enable(irq);
 	}
 	spin_unlock(&desc->lock);
+
+	TRACE_IRQ_EXIT();
 }
 
 #ifndef CONFIG_PPC_ISERIES	/* iSeries version is in iSeries_pic.c */
diff -urpN linux-2.5.45/arch/ppc/kernel/misc.S linux-2.5.45-ltt/arch/ppc/kernel/misc.S
--- linux-2.5.45/arch/ppc/kernel/misc.S	Wed Oct 30 19:43:41 2002
+++ linux-2.5.45-ltt/arch/ppc/kernel/misc.S	Wed Oct 30 20:51:10 2002
@@ -998,7 +998,11 @@ _GLOBAL(cvt_df)
  * Create a kernel thread
  *   kernel_thread(fn, arg, flags)
  */
+#if (CONFIG_TRACE)
+_GLOBAL(original_kernel_thread)
+#else
 _GLOBAL(kernel_thread)
+#endif /* (CONFIG_TRACE) */
 	stwu	r1,-16(r1)
 	stw	r30,8(r1)
 	stw	r31,12(r1)
diff -urpN linux-2.5.45/arch/ppc/kernel/process.c linux-2.5.45-ltt/arch/ppc/kernel/process.c
--- linux-2.5.45/arch/ppc/kernel/process.c	Wed Oct 30 19:42:55 2002
+++ linux-2.5.45-ltt/arch/ppc/kernel/process.c	Wed Oct 30 20:51:10 2002
@@ -35,6 +35,8 @@
 #include <linux/init_task.h>
 #include <linux/module.h>
 
+#include <linux/trace.h>
+
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -297,6 +299,19 @@ void show_regs(struct pt_regs * regs)
 	show_tsk_stack(current, regs->gpr[1]);
 }
 
+#if (CONFIG_TRACE)
+long original_kernel_thread(int (*fn) (void *), void* arg, unsigned long flags);
+long kernel_thread(int (*fn) (void *), void* arg, unsigned long flags)
+{
+        long   retval;
+
+	retval = original_kernel_thread(fn, arg, flags);
+	if (retval > 0)
+		TRACE_PROCESS(TRACE_EV_PROCESS_KTHREAD, retval, (int) fn);
+	return retval;
+}
+#endif /* (CONFIG_TRACE) */
+
 void exit_thread(void)
 {
 	if (last_task_used_math == current)
diff -urpN linux-2.5.45/arch/ppc/kernel/syscalls.c linux-2.5.45-ltt/arch/ppc/kernel/syscalls.c
--- linux-2.5.45/arch/ppc/kernel/syscalls.c	Wed Oct 30 19:43:43 2002
+++ linux-2.5.45-ltt/arch/ppc/kernel/syscalls.c	Wed Oct 30 20:51:10 2002
@@ -36,6 +36,8 @@
 #include <linux/utsname.h>
 #include <linux/file.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
 #include <asm/semaphore.h>
@@ -82,6 +84,8 @@ sys_ipc (uint call, int first, int secon
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
+	TRACE_IPC(TRACE_EV_IPC_CALL, call, first);
+
 	ret = -EINVAL;
 	switch (call) {
 	case SEMOP:
diff -urpN linux-2.5.45/arch/ppc/kernel/time.c linux-2.5.45-ltt/arch/ppc/kernel/time.c
--- linux-2.5.45/arch/ppc/kernel/time.c	Wed Oct 30 19:43:34 2002
+++ linux-2.5.45-ltt/arch/ppc/kernel/time.c	Wed Oct 30 20:51:10 2002
@@ -57,6 +57,8 @@
 #include <linux/time.h>
 #include <linux/init.h>
 
+#include <linux/trace.h>
+
 #include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -158,6 +160,8 @@ void timer_interrupt(struct pt_regs * re
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
 		do_IRQ(regs);
 
+ 	TRACE_TRAP_ENTRY(regs->trap, instruction_pointer(regs));
+
 	irq_enter();
 	
 	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
@@ -212,6 +216,8 @@ void timer_interrupt(struct pt_regs * re
 		ppc_md.heartbeat();
 
 	irq_exit();
+
+ 	TRACE_TRAP_EXIT();
 }
 #endif /* CONFIG_PPC_ISERIES */
 
diff -urpN linux-2.5.45/arch/ppc/kernel/traps.c linux-2.5.45-ltt/arch/ppc/kernel/traps.c
--- linux-2.5.45/arch/ppc/kernel/traps.c	Wed Oct 30 19:42:19 2002
+++ linux-2.5.45-ltt/arch/ppc/kernel/traps.c	Wed Oct 30 20:51:10 2002
@@ -30,6 +30,8 @@
 #include <linux/config.h>
 #include <linux/init.h>
 
+#include <linux/trace.h>
+
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -108,7 +110,9 @@ _exception(int signr, struct pt_regs *re
 		debugger(regs);
 		die("Exception in kernel mode", regs, signr);
 	}
+	TRACE_TRAP_ENTRY(regs->trap, instruction_pointer(regs));
 	force_sig(signr, current);
+	TRACE_TRAP_EXIT();
 }
 
 void
@@ -367,6 +371,84 @@ StackOverflow(struct pt_regs *regs)
 	panic("kernel stack overflow");
 }
 
+/* Trace related code */
+#if (CONFIG_TRACE)
+asmlinkage void trace_real_syscall_entry(struct pt_regs *regs)
+{
+	int use_depth;
+	int use_bounds;
+	int depth = 0;
+	int seek_depth;
+	unsigned long lower_bound;
+	unsigned long upper_bound;
+	unsigned long addr;
+	unsigned long *stack;
+	trace_syscall_entry trace_syscall_event;
+
+	/* Set the syscall ID */
+	trace_syscall_event.syscall_id = (uint8_t) regs->gpr[0];
+
+	/* Set the address in any case */
+	trace_syscall_event.address = instruction_pointer(regs);
+
+	/* Are we in the kernel (This is a kernel thread)? */
+	if (!user_mode(regs))
+		/* Don't go digining anywhere */
+		goto trace_syscall_end;
+
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
+		stack = (unsigned long *) regs->gpr[1];
+
+		/* Skip over first stack frame as the return address isn't valid */
+		if (get_user(addr, stack))
+			goto trace_syscall_end;
+		stack = (unsigned long *) addr;
+
+		/* Keep on going until we reach the end of the process' stack limit (wherever it may be) */
+		while (!get_user(addr, stack + 1)) {	/* "stack + 1", since this is where the IP is */
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
+			if (get_user(addr, stack))
+				goto trace_syscall_end;
+			stack = (unsigned long *) addr;
+		}
+	}
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
+#endif				/* (CONFIG_TRACE) */
+
 void nonrecoverable_exception(struct pt_regs *regs)
 {
 	printk(KERN_ERR "Non-recoverable exception at PC=%lx MSR=%lx\n",
diff -urpN linux-2.5.45/arch/ppc/mm/fault.c linux-2.5.45-ltt/arch/ppc/mm/fault.c
--- linux-2.5.45/arch/ppc/mm/fault.c	Wed Oct 30 19:42:22 2002
+++ linux-2.5.45-ltt/arch/ppc/mm/fault.c	Wed Oct 30 20:51:10 2002
@@ -28,6 +28,8 @@
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
 
+#include <linux/trace.h>
+
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
@@ -85,22 +87,29 @@ void do_page_fault(struct pt_regs *regs,
 		is_write = error_code & 0x02000000;
 #endif /* CONFIG_4xx */
 
+	TRACE_TRAP_ENTRY(regs->trap, instruction_pointer(regs));
+
+
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 	if (debugger_fault_handler && TRAP(regs) == 0x300) {
 		debugger_fault_handler(regs);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 #if !defined(CONFIG_4xx)
 	if (error_code & 0x00400000) {
 		/* DABR match */
-		if (debugger_dabr_match(regs))
+		if (debugger_dabr_match(regs)){
+			TRACE_TRAP_EXIT();
 			return;
+		}
 	}
 #endif /* !CONFIG_4xx */
 #endif /* CONFIG_XMON || CONFIG_KGDB */
 
 	if (in_atomic() || mm == NULL) {
 		bad_page_fault(regs, address, SIGSEGV);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 	down_read(&mm->mmap_sem);
@@ -165,6 +174,7 @@ good_area:
 			_tlbie(address);
 			pte_unmap(ptep);
 			up_read(&mm->mmap_sem);
+			TRACE_TRAP_EXIT();
 			return;
 		}
 		if (ptep != NULL)
@@ -207,6 +217,7 @@ good_area:
 	 * -- Cort
 	 */
 	pte_misses++;
+	TRACE_TRAP_EXIT();
 	return;
 
 bad_area:
@@ -220,10 +231,12 @@ bad_area:
 		info.si_code = code;
 		info.si_addr = (void *) address;
 		force_sig_info(SIGSEGV, &info, current);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
 	bad_page_fault(regs, address, SIGSEGV);
+	TRACE_TRAP_EXIT();
 	return;
 
 /*
@@ -241,6 +254,7 @@ out_of_memory:
 	if (user_mode(regs))
 		do_exit(SIGKILL);
 	bad_page_fault(regs, address, SIGKILL);
+	TRACE_TRAP_EXIT();
 	return;
 
 do_sigbus:
@@ -252,6 +266,7 @@ do_sigbus:
 	force_sig_info (SIGBUS, &info, current);
 	if (!user_mode(regs))
 		bad_page_fault(regs, address, SIGBUS);
+	TRACE_TRAP_EXIT();
 }
 
 /*
diff -urpN linux-2.5.45/include/asm-ppc/trace.h linux-2.5.45-ltt/include/asm-ppc/trace.h
--- linux-2.5.45/include/asm-ppc/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.45-ltt/include/asm-ppc/trace.h	Wed Oct 30 20:51:14 2002
@@ -0,0 +1,31 @@
+/*
+ * linux/include/asm-ppc/trace.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * PowerPC definitions for tracing system
+ */
+
+#include <linux/config.h>
+#include <linux/trace.h>
+#include <asm-generic/trace.h>
+
+/* Current arch type */
+#define TRACE_ARCH_TYPE TRACE_ARCH_TYPE_PPC
+
+/* PowerPC variants */
+#define TRACE_ARCH_VARIANT_PPC_4xx          1   /* 4xx systems (IBM embedded series) */
+#define TRACE_ARCH_VARIANT_PPC_6xx          2   /* 6xx/7xx/74xx/8260/POWER3 systems (desktop flavor) */
+#define TRACE_ARCH_VARIANT_PPC_8xx          3   /* 8xx system (Motoral embedded series) */
+#define TRACE_ARCH_VARIANT_PPC_ISERIES      4   /* 8xx system (iSeries) */
+
+/* Current variant type */
+#if defined(CONFIG_4xx)
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_PPC_4xx
+#elif defined(CONFIG_6xx)
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_PPC_6xx
+#elif defined(CONFIG_8xx)
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_PPC_8xx
+#elif defined(CONFIG_PPC_ISERIES)
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_PPC_ISERIES
+#endif
