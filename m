Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262385AbSJ2VxA>; Tue, 29 Oct 2002 16:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSJ2Vwg>; Tue, 29 Oct 2002 16:52:36 -0500
Received: from nameservices.net ([208.234.25.16]:64812 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S262385AbSJ2Vsu>;
	Tue, 29 Oct 2002 16:48:50 -0500
Message-ID: <3DBF04C9.7B1074B7@opersys.com>
Date: Tue, 29 Oct 2002 16:59:37 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.44-bk2 8/10: SuperH trace support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


D: This patch adds the bare-minimum SuperH-specific low-level trace
D: statements.

diffstat:
 arch/sh/kernel/entry.S   |   43 ++++++++++++++++++++++++
 arch/sh/kernel/irq.c     |   14 ++++++++
 arch/sh/kernel/process.c |   13 ++++++-
 arch/sh/kernel/sys_sh.c  |    4 ++
 arch/sh/kernel/traps.c   |   82 +++++++++++++++++++++++++++++++++++++++++++++--
 arch/sh/mm/fault.c       |   15 ++++++++
 include/asm-sh/trace.h   |   16 +++++++++
 7 files changed, 184 insertions(+), 3 deletions(-)

diff -urpN linux-2.5.44-bk2/arch/sh/kernel/entry.S linux-2.5.44-bk2-ltt/arch/sh/kernel/entry.S
--- linux-2.5.44-bk2/arch/sh/kernel/entry.S	Sat Oct 19 00:01:48 2002
+++ linux-2.5.44-bk2-ltt/arch/sh/kernel/entry.S	Tue Oct 29 15:24:18 2002
@@ -370,6 +370,20 @@ system_call:
 	mov.l	r10, @r14		! set syscall_nr
 	STI()
 	!
+#if (CONFIG_TRACE)
+	! TODO: for i386 this code only happens when not ptrace'd
+	mov 	r15, r4     	    	! pass pt_regs* as first arg
+	mov.l	__trsen, r11 	    	! Call trace_real_syscall_entry()
+	jsr	@r11	    	    	! (will chomp R[0-7])
+	 nop
+	!   	    	    	    	Reload R4-R7 from kernel stack
+	mov.l	@(OFF_R4,r15), r4   ! arg0
+	mov.l	@(OFF_R5,r15), r5
+	mov.l	@(OFF_R6,r15), r6
+	mov.l	@(OFF_R7,r15), r7   ! arg3
+	mov.l	@(OFF_R3,r15), r3   ! syscall_nr
+#endif
+
 	stc	k_current, r11
 #error	mov.l	@(tsk_ptrace,r11), r10	! Is current PTRACE_SYSCALL'd?
 #error	mov	#PT_TRACESYS, r11
@@ -421,6 +435,14 @@ system_call:
 	! In case of trace
 syscall_ret_trace:
 	mov.l	r0, @(OFF_R0,r15)		! save the return value
+
+#if (CONFIG_TRACE)
+    	! TODO: for i386 this code only happens when not ptrace'd
+	mov.l	__trsex, r1 	    	! Call trace_real_syscall_exit()
+	jsr	@r1
+	 nop
+#endif
+
 	mov.l	__syscall_trace, r1
 	mova	ret_from_syscall, r0
 	jmp	@r1    	! Call syscall_trace() which notifies superior
@@ -504,6 +526,14 @@ __syscall_ret_trace:
 	.long	syscall_ret_trace
 __syscall_ret:
 	.long	syscall_ret
+	
+#if (CONFIG_TRACE)
+__trsen:
+	.long	trace_real_syscall_entry
+__trsex:
+	.long	trace_real_syscall_exit
+#endif
+
 __INV_IMASK:
 	.long	0xffffff0f	! ~(IMASK)
 
@@ -536,6 +566,14 @@ old_abi_syscall_ret:
 #endif
 syscall_ret:
 	mov.l	r0, @(OFF_R0,r15)	! save the return value
+
+#if (CONFIG_TRACE)
+	! TODO: for i386 this code only happens when not ptrace'd
+	mov.l	__trsex2, r1 	    	! Call trace_real_syscall_exit()
+	jsr	@r1
+	 nop
+#endif
+
 	/* fall through */
 
 ENTRY(ret_from_syscall)
@@ -563,6 +601,11 @@ __do_signal:
 #error	.long	do_signal
 __irq_stat:
 	.long	irq_stat
+#if (CONFIG_TRACE)
+__trsex2:
+ 	.long	trace_real_syscall_exit
+#endif
+
 
 	.align 2
 restore_all:
diff -urpN linux-2.5.44-bk2/arch/sh/kernel/irq.c linux-2.5.44-bk2-ltt/arch/sh/kernel/irq.c
--- linux-2.5.44-bk2/arch/sh/kernel/irq.c	Sat Oct 19 00:01:23 2002
+++ linux-2.5.44-bk2-ltt/arch/sh/kernel/irq.c	Tue Oct 29 15:24:18 2002
@@ -30,6 +30,8 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 
+#include <linux/trace.h>
+
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -127,6 +129,12 @@ int handle_IRQ_event(unsigned int irq, s
 
 	irq_enter(cpu, irq);
 
+#if (CONFIG_TRACE)
+    	if (irq != TIMER_IRQ) { /* avoid double-reporting the timer IRQ */
+		TRACE_IRQ_ENTRY(irq, !(user_mode(regs)));
+	}
+#endif
+
 	status = 1;	/* Force the "do bottom halves" bit */
 
 	if (!(action->flags & SA_INTERRUPT))
@@ -143,6 +151,12 @@ int handle_IRQ_event(unsigned int irq, s
 
 	irq_exit(cpu, irq);
 
+#if (CONFIG_TRACE)
+    	if (irq != TIMER_IRQ) { /* avoid double-reporting the timer IRQ */
+		TRACE_IRQ_EXIT();
+	}
+#endif
+
 	return status;
 }
 
diff -urpN linux-2.5.44-bk2/arch/sh/kernel/process.c linux-2.5.44-bk2-ltt/arch/sh/kernel/process.c
--- linux-2.5.44-bk2/arch/sh/kernel/process.c	Sat Oct 19 00:02:27 2002
+++ linux-2.5.44-bk2-ltt/arch/sh/kernel/process.c	Tue Oct 29 15:24:18 2002
@@ -16,6 +16,8 @@
 #include <linux/slab.h>
 #include <linux/a.out.h>
 
+#include <linux/trace.h>
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -138,7 +140,16 @@ int kernel_thread(int (*fn)(void *), voi
 		: "i" (__NR_exit), "r" (__sc3), "r" (__sc4), "r" (__sc5), 
 		  "r" (__sc8), "r" (__sc9)
 		: "memory", "t");
-	return __sc0;
+#if (CONFIG_TRACE)
+	{
+		volatile unsigned long retval = __sc0;
+		if (retval > 0)
+			TRACE_PROCESS(TRACE_EV_PROCESS_KTHREAD, retval, (int) fn);
+		return retval;
+	}
+#else
+ 	return __sc0;
+#endif
 }
 
 /*
diff -urpN linux-2.5.44-bk2/arch/sh/kernel/sys_sh.c linux-2.5.44-bk2-ltt/arch/sh/kernel/sys_sh.c
--- linux-2.5.44-bk2/arch/sh/kernel/sys_sh.c	Sat Oct 19 00:03:00 2002
+++ linux-2.5.44-bk2-ltt/arch/sh/kernel/sys_sh.c	Tue Oct 29 15:24:18 2002
@@ -21,6 +21,8 @@
 #include <linux/file.h>
 #include <linux/utsname.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
 
@@ -139,6 +141,8 @@ asmlinkage int sys_ipc(uint call, int fi
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
+	TRACE_IPC(TRACE_EV_IPC_CALL, call, first);
+
 	if (call <= SEMCTL)
 		switch (call) {
 		case SEMOP:
diff -urpN linux-2.5.44-bk2/arch/sh/kernel/traps.c linux-2.5.44-bk2-ltt/arch/sh/kernel/traps.c
--- linux-2.5.44-bk2/arch/sh/kernel/traps.c	Sat Oct 19 00:01:08 2002
+++ linux-2.5.44-bk2-ltt/arch/sh/kernel/traps.c	Tue Oct 29 15:24:18 2002
@@ -25,6 +25,8 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 
+#include <linux/trace.h>
+
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -42,7 +44,9 @@ asmlinkage void do_##name(unsigned long 
 	sti(); \
 	tsk->thread.error_code = error_code; \
 	tsk->thread.trap_no = trapnr; \
+	TRACE_TRAP_ENTRY(trapnr, regs.pc); \
 	force_sig(signr, tsk); \
+	TRACE_TRAP_EXIT(); \
 	die_if_no_fixup(str,&regs,error_code); \
 }
 
@@ -464,6 +468,8 @@ asmlinkage void do_address_error(struct 
 
 	asm volatile("stc       r2_bank,%0": "=r" (error_code));
 
+	TRACE_TRAP_ENTRY(error_code >> 5, regs->pc);
+
 	oldfs = get_fs();
 
 	if (user_mode(regs)) {
@@ -487,8 +493,10 @@ asmlinkage void do_address_error(struct 
 		tmp = handle_unaligned_access(instruction, regs);
 		set_fs(oldfs);
 
-		if (tmp==0)
-			return; /* sorted */
+		if (tmp==0) {
+			TRACE_TRAP_EXIT();
+ 			return; /* sorted */
+		}
 
 	uspace_segv:
 		printk(KERN_NOTICE "Killing process \"%s\" due to unaligned access\n", current->comm);
@@ -509,6 +517,7 @@ asmlinkage void do_address_error(struct 
 		handle_unaligned_access(instruction, regs);
 		set_fs(oldfs);
 	}
+	TRACE_TRAP_EXIT();
 }
 
 DO_ERROR(12, SIGILL,  "reserved instruction", reserved_inst, current)
@@ -586,3 +595,72 @@ void show_trace_task(struct task_struct 
 {
 	printk("Backtrace not yet implemented for SH.\n");
 }
+
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
+	trace_syscall_event.syscall_id = (uint8_t) regs->regs[REG_REG0 + 3];
+
+	/* Set the address in any case */
+	trace_syscall_event.address = regs->pc;
+
+	/* Are we in the kernel (This is a kernel thread)? */
+	if (!user_mode(regs))
+		/* Don't go digining anywhere */
+		goto trace_syscall_end;
+
+	/* Get the trace configuration */
+	if (trace_get_config(&use_depth, &use_bounds, &seek_depth,
+		       (void *) &lower_bound, (void *) &upper_bound) < 0)
+		goto trace_syscall_end;
+
+	/* Do we have to search for an eip address range */
+	if ((use_depth == 1) || (use_bounds == 1)) {
+		/* Start at the top of the stack (bottom address since stacks grow downward) */
+		stack = (unsigned long *) regs->regs[REG_REG15];
+
+		/* Keep on going until we reach the end of the process' stack limit (wherever it may be) */
+		while (!get_user(addr, stack)) {
+			/* Does this LOOK LIKE an address in the program */
+			/* TODO: does this work with shared libraries?? - Greg Banks */
+			if ((addr > current->mm->start_code) && (addr < current->mm->end_code)) {
+				/* Does this address fit the description */
+				if (((use_depth == 1) && (depth == seek_depth))
+				    || ((use_bounds == 1) && (addr > lower_bound)
+					&& (addr < upper_bound))) {
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
diff -urpN linux-2.5.44-bk2/arch/sh/mm/fault.c linux-2.5.44-bk2-ltt/arch/sh/mm/fault.c
--- linux-2.5.44-bk2/arch/sh/mm/fault.c	Sat Oct 19 00:01:19 2002
+++ linux-2.5.44-bk2-ltt/arch/sh/mm/fault.c	Tue Oct 29 15:24:18 2002
@@ -20,6 +20,8 @@
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 
+#include <linux/trace.h>
+
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -98,6 +100,14 @@ asmlinkage void do_page_fault(struct pt_
 	tsk = current;
 	mm = tsk->mm;
 
+#if (CONFIG_TRACE)
+	{
+		unsigned long trapnr;
+		asm volatile("stc       r2_bank,%0": "=r" (trapnr));
+		TRACE_TRAP_ENTRY(trapnr >> 5, regs->pc);  /* trap 4,5 or 6 */
+	}
+#endif
+
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
@@ -149,6 +159,7 @@ survive:
 	}
 
 	up_read(&mm->mmap_sem);
+	TRACE_TRAP_EXIT();
 	return;
 
 /*
@@ -162,6 +173,7 @@ bad_area:
 		tsk->thread.address = address;
 		tsk->thread.error_code = writeaccess;
 		force_sig(SIGSEGV, tsk);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
@@ -170,6 +182,7 @@ no_context:
 	fixup = search_exception_table(regs->pc);
 	if (fixup != 0) {
 		regs->pc = fixup;
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
@@ -231,6 +244,8 @@ do_sigbus:
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
 		goto no_context;
+
+	TRACE_TRAP_EXIT();
 }
 
 /*
diff -urpN linux-2.5.44-bk2/include/asm-sh/trace.h linux-2.5.44-bk2-ltt/include/asm-sh/trace.h
--- linux-2.5.44-bk2/include/asm-sh/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.44-bk2-ltt/include/asm-sh/trace.h	Tue Oct 29 15:24:18 2002
@@ -0,0 +1,16 @@
+/*
+ * linux/include/asm-sh/trace.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * SuperH definitions for tracing system
+ */
+
+#include <linux/trace.h>
+#include <asm-generic/trace.h>
+
+/* Current arch type */
+#define TRACE_ARCH_TYPE TRACE_ARCH_TYPE_SH
+
+/* Current variant type */
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_NONE
