Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262372AbSJ2VwX>; Tue, 29 Oct 2002 16:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262365AbSJ2VvL>; Tue, 29 Oct 2002 16:51:11 -0500
Received: from nameservices.net ([208.234.25.16]:60460 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S262372AbSJ2Vs0>;
	Tue, 29 Oct 2002 16:48:26 -0500
Message-ID: <3DBF04B1.E31383D@opersys.com>
Date: Tue, 29 Oct 2002 16:59:13 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.44-bk2 5/10: i386 trace support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


D: This patch adds the bare-minimum i386-specific low-level trace
D: statements.

diffstat:
 arch/i386/kernel/entry.S    |   23 +++++++
 arch/i386/kernel/irq.c      |    6 ++
 arch/i386/kernel/process.c  |    5 +
 arch/i386/kernel/sys_i386.c |    4 +
 arch/i386/kernel/traps.c    |  104 ++++++++++++++++++++++++++++++++++
 arch/i386/mm/fault.c        |   11 +++
 include/asm-i386/trace.h    |  131 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/unistd.h   |    1 
 8 files changed, 284 insertions(+), 1 deletion(-)

diff -urpN linux-2.5.44-bk2/arch/i386/kernel/entry.S linux-2.5.44-bk2-ltt/arch/i386/kernel/entry.S
--- linux-2.5.44-bk2/arch/i386/kernel/entry.S	Sat Oct 19 00:01:19 2002
+++ linux-2.5.44-bk2-ltt/arch/i386/kernel/entry.S	Tue Oct 29 15:24:18 2002
@@ -233,9 +233,27 @@ ENTRY(system_call)
 	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebx)
 	jnz syscall_trace_entry
 syscall_call:
+#if (CONFIG_TRACE)
+	movl syscall_entry_trace_active, %eax
+	cmpl $1, %eax                   # are we tracing system call entries
+	jne no_syscall_entry_trace
+	movl %esp, %eax                 # copy the stack pointer
+	pushl %eax                      # pass the stack pointer copy
+	call trace_real_syscall_entry
+	addl $4,%esp                    # return stack to state before pass
+no_syscall_entry_trace:
+	movl ORIG_EAX(%esp),%eax	# restore eax to it's original content
+#endif
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
+#if (CONFIG_TRACE)
+	movl syscall_exit_trace_active, %eax
+	cmpl $1, %eax                   # are we tracing system call exits
+	jne no_syscall_exit_trace
+	call trace_real_syscall_exit
+no_syscall_exit_trace:	
+#endif
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
@@ -737,6 +755,11 @@ ENTRY(sys_call_table)
 	.long sys_free_hugepages
 	.long sys_exit_group
 	.long sys_lookup_dcookie
+#if CONFIG_TRACE
+	.long sys_trace
+#else
+	.long sys_ni_syscall
+#endif
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -urpN linux-2.5.44-bk2/arch/i386/kernel/irq.c linux-2.5.44-bk2-ltt/arch/i386/kernel/irq.c
--- linux-2.5.44-bk2/arch/i386/kernel/irq.c	Tue Oct 29 15:54:54 2002
+++ linux-2.5.44-bk2-ltt/arch/i386/kernel/irq.c	Tue Oct 29 15:24:18 2002
@@ -33,6 +33,8 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
+#include <linux/trace.h>
+
 #include <asm/atomic.h>
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -202,6 +204,8 @@ int handle_IRQ_event(unsigned int irq, s
 {
 	int status = 1;	/* Force the "do bottom halves" bit */
 
+ 	TRACE_IRQ_ENTRY(irq, !(user_mode(regs)));
+
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
@@ -214,6 +218,8 @@ int handle_IRQ_event(unsigned int irq, s
 		add_interrupt_randomness(irq);
 	local_irq_disable();
 
+ 	TRACE_IRQ_EXIT();
+
 	return status;
 }
 
diff -urpN linux-2.5.44-bk2/arch/i386/kernel/process.c linux-2.5.44-bk2-ltt/arch/i386/kernel/process.c
--- linux-2.5.44-bk2/arch/i386/kernel/process.c	Sat Oct 19 00:00:42 2002
+++ linux-2.5.44-bk2-ltt/arch/i386/kernel/process.c	Tue Oct 29 15:24:18 2002
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/mc146818rtc.h>
 #include <linux/module.h>
+#include <linux/trace.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -225,6 +226,10 @@ int kernel_thread(int (*fn)(void *), voi
 
 	/* Ok, create the new process.. */
 	p = do_fork(flags | CLONE_VM, 0, &regs, 0, NULL);
+#if (CONFIG_TRACE)
+	if(!IS_ERR(p))
+		TRACE_PROCESS(TRACE_EV_PROCESS_KTHREAD, p->pid, (int) fn);
+#endif
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
diff -urpN linux-2.5.44-bk2/arch/i386/kernel/sys_i386.c linux-2.5.44-bk2-ltt/arch/i386/kernel/sys_i386.c
--- linux-2.5.44-bk2/arch/i386/kernel/sys_i386.c	Sat Oct 19 00:01:52 2002
+++ linux-2.5.44-bk2-ltt/arch/i386/kernel/sys_i386.c	Tue Oct 29 15:24:18 2002
@@ -19,6 +19,8 @@
 #include <linux/file.h>
 #include <linux/utsname.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
 
@@ -137,6 +139,8 @@ asmlinkage int sys_ipc (uint call, int f
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
+	TRACE_IPC(TRACE_EV_IPC_CALL, call, first);
+
 	switch (call) {
 	case SEMOP:
 		return sys_semop (first, (struct sembuf *)ptr, second);
diff -urpN linux-2.5.44-bk2/arch/i386/kernel/traps.c linux-2.5.44-bk2-ltt/arch/i386/kernel/traps.c
--- linux-2.5.44-bk2/arch/i386/kernel/traps.c	Sat Oct 19 00:01:16 2002
+++ linux-2.5.44-bk2-ltt/arch/i386/kernel/traps.c	Tue Oct 29 15:24:18 2002
@@ -28,6 +28,8 @@
 #include <linux/ioport.h>
 #endif
 
+#include <linux/trace.h>
+
 #ifdef CONFIG_MCA
 #include <linux/mca.h>
 #include <asm/processor.h>
@@ -285,6 +287,76 @@ bug:
 	printk("Kernel BUG\n");
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
+	trace_syscall_event.syscall_id = (uint8_t) regs->orig_eax;
+
+	/* Set the address in any case */
+	trace_syscall_event.address = regs->eip;
+
+	/* Are we in the kernel (This is a kernel thread)? */
+	if (!(regs->xcs & 3))
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
+trace_syscall_end:
+	/* Trace the event */
+	trace_event(TRACE_EV_SYSCALL_ENTRY, &trace_syscall_event);
+}
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+	trace_event(TRACE_EV_SYSCALL_EXIT, NULL);
+}
+#endif				/* (CONFIG_TRACE) */
+
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
 
 void die(const char * str, struct pt_regs * regs, long err)
@@ -318,6 +390,8 @@ static inline unsigned long get_cr2(void
 static void inline do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
+        TRACE_TRAP_ENTRY(trapnr, regs->eip);
+
 	if (vm86 && regs->eflags & VM_MASK)
 		goto vm86_trap;
 
@@ -332,6 +406,7 @@ static void inline do_trap(int trapnr, i
 			force_sig_info(signr, info, tsk);
 		else
 			force_sig(signr, tsk);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
@@ -357,14 +432,17 @@ static void inline do_trap(int trapnr, i
 			regs->eip = fixup;
 		else	
 			die(str, regs, error_code);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
 	vm86_trap: {
 		int ret = handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, trapnr);
 		if (ret) goto trap_signal;
+		TRACE_TRAP_EXIT();
 		return;
 	}
+	TRACE_TRAP_EXIT();
 }
 
 #define DO_ERROR(trapnr, signr, str, name) \
@@ -424,11 +502,15 @@ asmlinkage void do_general_protection(st
 
 	current->thread.error_code = error_code;
 	current->thread.trap_no = 13;
+        TRACE_TRAP_ENTRY(13, regs->eip);
 	force_sig(SIGSEGV, current);
+        TRACE_TRAP_EXIT();
 	return;
 
 gp_in_vm86:
+        TRACE_TRAP_ENTRY(13, regs->eip);
 	handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
+        TRACE_TRAP_EXIT();
 	return;
 
 gp_in_kernel:
@@ -489,6 +571,12 @@ static void default_do_nmi(struct pt_reg
 {
 	unsigned char reason = inb(0x61);
  
+#ifndef CONFIG_X86_LOCAL_APIC
+/* On an machines with APIC enabled, NMIs are used to implement a watchdog
+and will hang the machine if traced. */
+	TRACE_TRAP_ENTRY(2, regs->eip);
+#endif
+
 	if (!(reason & 0xc0)) {
 #if CONFIG_X86_LOCAL_APIC
 		/*
@@ -501,6 +589,9 @@ static void default_do_nmi(struct pt_reg
 		}
 #endif
 		unknown_nmi_error(reason, regs);
+#ifndef CONFIG_X86_LOCAL_APIC
+	        TRACE_TRAP_EXIT();
+#endif
 		return;
 	}
 	if (reason & 0x80)
@@ -515,6 +606,10 @@ static void default_do_nmi(struct pt_reg
 	inb(0x71);		/* dummy */
 	outb(0x0f, 0x70);
 	inb(0x71);		/* dummy */
+
+#ifndef CONFIG_X86_LOCAL_APIC
+        TRACE_TRAP_EXIT();
+#endif
 }
 
 static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
@@ -615,7 +710,9 @@ asmlinkage void do_debug(struct pt_regs 
 	 */
 	info.si_addr = ((regs->xcs & 3) == 0) ? (void *)tsk->thread.eip : 
 	                                        (void *)regs->eip;
+        TRACE_TRAP_ENTRY(1, regs->eip);
 	force_sig_info(SIGTRAP, &info, tsk);
+        TRACE_TRAP_EXIT();
 
 	/* Disable additional traps. They'll be re-enabled when
 	 * the signal is delivered.
@@ -627,7 +724,9 @@ clear_dr7:
 	return;
 
 debug_vm86:
+        TRACE_TRAP_ENTRY(1, regs->eip);
 	handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, 1);
+        TRACE_TRAP_EXIT();
 	return;
 
 clear_TF:
@@ -776,10 +875,12 @@ asmlinkage void do_simd_coprocessor_erro
 asmlinkage void do_spurious_interrupt_bug(struct pt_regs * regs,
 					  long error_code)
 {
+        TRACE_TRAP_ENTRY(16, regs->eip);
 #if 0
 	/* No need to warn about this any longer. */
 	printk("Ignoring P6 Local APIC Spurious Interrupt Bug...\n");
 #endif
+        TRACE_TRAP_EXIT();	
 }
 
 /*
@@ -808,8 +909,10 @@ asmlinkage void math_emulate(long arg)
 {
 	printk("math-emulation not enabled and no coprocessor found.\n");
 	printk("killing %s.\n",current->comm);
+        TRACE_TRAP_ENTRY(7, 0);
 	force_sig(SIGFPE,current);
 	schedule();
+        TRACE_TRAP_EXIT();
 }
 
 #endif /* CONFIG_MATH_EMULATION */
@@ -841,7 +944,6 @@ do { \
 	 "3" ((char *) (addr)),"2" (__KERNEL_CS << 16)); \
 } while (0)
 
-
 /*
  * This needs to use 'idt_table' rather than 'idt', and
  * thus use the _nonmapped_ version of the IDT, as the
diff -urpN linux-2.5.44-bk2/arch/i386/mm/fault.c linux-2.5.44-bk2-ltt/arch/i386/mm/fault.c
--- linux-2.5.44-bk2/arch/i386/mm/fault.c	Sat Oct 19 00:00:42 2002
+++ linux-2.5.44-bk2-ltt/arch/i386/mm/fault.c	Tue Oct 29 15:24:18 2002
@@ -20,6 +20,8 @@
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 
+#include <linux/trace.h>
+
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -176,6 +178,8 @@ asmlinkage void do_page_fault(struct pt_
 	mm = tsk->mm;
 	info.si_code = SEGV_MAPERR;
 
+	TRACE_TRAP_ENTRY(14, regs->eip);
+
 	/*
 	 * If we're in an interrupt, have no user context or are running in an
 	 * atomic region then we must not take the fault..
@@ -260,6 +264,7 @@ good_area:
 			tsk->thread.screen_bitmap |= 1 << bit;
 	}
 	up_read(&mm->mmap_sem);
+        TRACE_TRAP_EXIT();
 	return;
 
 /*
@@ -279,6 +284,7 @@ bad_area:
 		/* info.si_code has been set above */
 		info.si_addr = (void *)address;
 		force_sig_info(SIGSEGV, &info, tsk);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
@@ -293,6 +299,7 @@ bad_area:
 
 		if (nr == 6) {
 			do_invalid_op(regs, 0);
+			TRACE_TRAP_EXIT();
 			return;
 		}
 	}
@@ -302,6 +309,7 @@ no_context:
 	/* Are we prepared to handle this kernel fault?  */
 	if ((fixup = search_exception_table(regs->eip)) != 0) {
 		regs->eip = fixup;
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
@@ -375,6 +383,7 @@ do_sigbus:
 	/* Kernel mode? Handle exceptions or die */
 	if (!(error_code & 4))
 		goto no_context;
+        TRACE_TRAP_EXIT();
 	return;
 
 vmalloc_fault:
@@ -408,6 +417,8 @@ vmalloc_fault:
 		pte_k = pte_offset_kernel(pmd_k, address);
 		if (!pte_present(*pte_k))
 			goto no_context;
+		TRACE_TRAP_EXIT();
 		return;
 	}
+	TRACE_TRAP_EXIT();
 }
diff -urpN linux-2.5.44-bk2/include/asm-i386/trace.h linux-2.5.44-bk2-ltt/include/asm-i386/trace.h
--- linux-2.5.44-bk2/include/asm-i386/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.44-bk2-ltt/include/asm-i386/trace.h	Tue Oct 29 15:24:18 2002
@@ -0,0 +1,131 @@
+/*
+ * linux/include/asm-i386/trace.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * i386 definitions for tracing system
+ */
+
+#include <linux/trace.h>
+
+/* Current arch type */
+#define TRACE_ARCH_TYPE TRACE_ARCH_TYPE_I386
+
+/* Current variant type */
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_NONE
+
+#ifdef CONFIG_X86_TSC /* Is there x86 TSC support? */ 
+#include <asm/msr.h>
+
+/**
+ *	get_time_delta: - Utility function for getting time delta.
+ *	@now: pointer to a timeval struct that may be given current time
+ *	@cpu: the associated CPU id
+ *
+ *	Returns either the TSC if TSCs are being used, or the time and the
+ *	time difference between the current time and the buffer start time 
+ *	if TSCs are not being used.  The time is returned so that callers
+ *	can use the do_gettimeofday() result if they need to.
+ */
+static inline trace_time_delta get_time_delta(struct timeval *now, u8 cpu)
+{
+	trace_time_delta time_delta;
+
+	if((using_tsc == 1) && cpu_has_tsc)
+		rdtscl(time_delta);
+	else {
+		do_gettimeofday(now);
+		time_delta = calc_time_delta(now, &buffer_start_time(cpu));
+	}
+
+	return time_delta;
+}
+
+/**
+ *	get_timestamp: - Utility function for getting a time and TSC pair.
+ *	@now: current time
+ *	@tsc: the TSC associated with now
+ *
+ *	Sets the value pointed to by now to the current time and the value
+ *	pointed to by tsc to the tsc associated with that time, if the 
+ *	platform supports TSC.
+ */
+static inline void get_timestamp(struct timeval *now, 
+				 trace_time_delta *tsc)
+{
+	do_gettimeofday(now);
+
+	if((using_tsc == 1) && cpu_has_tsc)
+		rdtscl(*tsc);
+}
+
+/**
+ *	get_time_or_tsc: - Utility function for getting a time or a TSC.
+ *	@now: current time
+ *	@tsc: current TSC
+ *
+ *	Sets the value pointed to by now to the current time or the value
+ *	pointed to by tsc to the current tsc, depending on whether we're
+ *	using TSCs or not.
+ */
+static inline void get_time_or_tsc(struct timeval *now, 
+				   trace_time_delta *tsc)
+{
+	if((using_tsc == 1) && cpu_has_tsc)
+		rdtscl(*tsc);
+	else
+		do_gettimeofday(now);
+}
+
+/**
+ *	switch_time_delta: - Utility function getting buffer switch time delta.
+ *	@time_delta: previously calculated or retrieved time delta 
+ *
+ *	Returns the time_delta passed in if we're using TSC or 0 otherwise.
+ *	This function is used only for start/end buffer events.
+ */
+static inline trace_time_delta switch_time_delta(trace_time_delta time_delta)
+{
+	if((using_tsc == 1) && cpu_has_tsc)
+		return time_delta;
+	else
+		return 0;
+}
+
+/**
+ *	have_tsc: - Does this platform have a useable TSC?
+ *
+ *	Returns 1 if this platform has a useable TSC counter for
+ *	timestamping purposes, 0 otherwise.
+ */
+static inline int have_tsc(void)
+{
+	if(cpu_has_tsc)
+		return 1;
+	else
+		return 0;
+}
+
+extern void init_ltt_percpu_timer(void * dummy);
+
+/**
+ *	init_percpu_timers: - Initialize per-cpu timers (only if using TSC)
+ *
+ *	Sets up the timers needed on each CPU for checking asynchronous 
+ *	tasks needing attention.  This is only the case when TSC timestamping 
+ *	is being used (TSCs need to be read on the current CPU).
+ */
+static inline void init_percpu_timers(void)
+{
+	if((using_tsc == 1) && cpu_has_tsc) {
+		/* Initialize the timer on this (or the only) CPU */
+		init_ltt_percpu_timer(NULL);
+		/* Initialize the timers on all other CPUs */
+		if(smp_call_function(init_ltt_percpu_timer, NULL, 1, 1) != 0)
+			printk(KERN_ALERT "Tracer: Couldn't initialize all per-CPU timers\n");
+	}
+}
+
+#else /* No TSC support (#ifdef CONFIG_X86_TSC) */
+#include <asm-generic/trace.h>
+#endif /* #ifdef CONFIG_X86_TSC */
diff -urpN linux-2.5.44-bk2/include/asm-i386/unistd.h linux-2.5.44-bk2-ltt/include/asm-i386/unistd.h
--- linux-2.5.44-bk2/include/asm-i386/unistd.h	Sat Oct 19 00:02:00 2002
+++ linux-2.5.44-bk2-ltt/include/asm-i386/unistd.h	Tue Oct 29 15:24:18 2002
@@ -258,6 +258,7 @@
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
+#define __NR_trace		254
   
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
