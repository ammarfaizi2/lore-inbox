Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUBVQUC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbUBVQUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:20:01 -0500
Received: from gprs148-229.eurotel.cz ([160.218.148.229]:49024 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261606AbUBVQLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:11:50 -0500
Date: Sun, 22 Feb 2004 17:07:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>
Subject: [2/3] kgdb for 2.6.3
Message-ID: <20040222160704.GA9551@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds some more intrusive features to kgdb (thread display,
kgdb-over-netconsole), and support for non-i386 architectures (core +
i386 + x86_64 + ppc). Probably good enough for -mm but not for
vanilla.

							Pavel

Index: linux-2.6.3-kgdb-lite/include/linux/sched.h
===================================================================
--- linux-2.6.3-kgdb-lite.orig/include/linux/sched.h	2004-02-21 16:52:43.000000000 +0530
+++ linux-2.6.3-kgdb-lite/include/linux/sched.h	2004-02-21 17:31:47.947696392 +0530
@@ -173,7 +173,9 @@
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
-asmlinkage void schedule(void);
+asmlinkage void do_schedule(void);
+asmlinkage void kern_schedule(void);
+asmlinkage void kern_do_schedule(struct pt_regs);
 
 struct namespace;
 
@@ -907,6 +909,15 @@
 
 #endif /* CONFIG_SMP */
 
+static inline void schedule(void)
+{
+#ifdef CONFIG_KGDB_THREAD
+	kern_schedule();
+#else
+	do_schedule();
+#endif
+}
+
 #endif /* __KERNEL__ */
 
 #endif
Index: linux-2.6.3-kgdb-lite/kernel/module.c
===================================================================
--- linux-2.6.3-kgdb-lite.orig/kernel/module.c	2004-02-21 16:52:53.000000000 +0530
+++ linux-2.6.3-kgdb-lite/kernel/module.c	2004-02-21 17:31:47.955695176 +0530
@@ -727,6 +727,11 @@
 	mod->state = MODULE_STATE_GOING;
 	restart_refcounts();
 
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
+				mod);
+	up(&notify_mutex);
+
 	/* Never wait if forced. */
 	if (!forced && module_refcount(mod) != 0)
 		wait_for_zero_refcount(mod);
@@ -1758,7 +1763,12 @@
 	if (ret < 0) {
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
+
 		mod->state = MODULE_STATE_GOING;
+		down(&notify_mutex);
+		notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
+					mod);
+		up(&notify_mutex);
 		synchronize_kernel();
 		if (mod->unsafe)
 			printk(KERN_ERR "%s: module is now stuck!\n",
Index: linux-2.6.3-kgdb-lite/kernel/sched.c
===================================================================
--- linux-2.6.3-kgdb-lite.orig/kernel/sched.c	2004-02-21 16:56:46.000000000 +0530
+++ linux-2.6.3-kgdb-lite/kernel/sched.c	2004-02-21 17:31:47.957694872 +0530
@@ -1592,7 +1592,7 @@
 /*
  * schedule() is the main scheduler function.
  */
-asmlinkage void schedule(void)
+asmlinkage void do_schedule(void)
 {
 	long *switch_count;
 	task_t *prev, *next;
@@ -1764,6 +1764,23 @@
 
 EXPORT_SYMBOL(default_wake_function);
 
+asmlinkage void user_schedule(void)
+{
+#ifdef CONFIG_KGDB_THREAD
+	current->thread.debuggerinfo = NULL;
+#endif
+	do_schedule();
+}
+
+#ifdef CONFIG_KGDB_THREAD
+asmlinkage void kern_do_schedule(struct pt_regs regs)
+{
+	current->thread.debuggerinfo = &regs;
+	do_schedule();
+	current->thread.debuggerinfo = NULL;
+}
+#endif
+
 /*
  * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just
  * wake everything up.  If it's an exclusive wakeup (nr_exclusive == small +ve

Index: linux-2.6.3-kgdb/arch/i386/Kconfig
===================================================================
--- linux-2.6.3-kgdb.orig/arch/i386/Kconfig	2004-02-21 17:59:03.979981680 +0530
+++ linux-2.6.3-kgdb/arch/i386/Kconfig	2004-02-21 17:59:05.001826336 +0530
@@ -1267,6 +1267,23 @@
 	  http://kgdb.sourceforge.net
 	  This is only useful for kernel hackers. If unsure, say N.
 
+config KGDB_THREAD
+	bool "KGDB: Thread analysis"
+	depends on KGDB
+	help
+	  With thread analysis enabled, gdb can talk to kgdb stub to list
+	  threads and to get stack trace for a thread. This option also enables
+	  some code which helps gdb get exact status of thread. Thread analysis
+	  adds some overhead to schedule and down functions. You can disable
+	  this option if you do not want to compromise on speed.
+
+config KGDB_CONSOLE
+	bool "KGDB: Console messages through gdb"
+	depends on KGDB
+	help
+	  If you say Y here, console messages will appear through gdb.
+	  Other consoles such as tty or ttyS will continue to work as usual.
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	help
Index: linux-2.6.3-kgdb/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.3-kgdb.orig/arch/i386/kernel/entry.S	2004-02-21 17:58:44.266978512 +0530
+++ linux-2.6.3-kgdb/arch/i386/kernel/entry.S	2004-02-21 17:59:13.400549536 +0530
@@ -226,7 +226,7 @@
 	jz restore_all
 	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebp)
 	sti
-	call schedule
+	call user_schedule
 	movl $0,TI_PRE_COUNT(%ebp)
 	cli
 	jmp need_resched
@@ -308,7 +308,7 @@
 	testb $_TIF_NEED_RESCHED, %cl
 	jz work_notifysig
 work_resched:
-	call schedule
+	call user_schedule
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
@@ -606,6 +606,31 @@
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
+#ifdef CONFIG_KGDB_THREAD
+ENTRY(kern_schedule)
+	pushl	%ebp
+	movl	%esp, %ebp
+	pushl	%ss		
+	pushl	%ebp
+	pushfl
+	pushl	%cs
+	pushl	4(%ebp)
+	pushl	%eax		
+	pushl	%es
+	pushl	%ds
+	pushl	%eax
+	pushl	(%ebp)
+	pushl	%edi
+	pushl	%esi
+	pushl	%edx
+	pushl	%ecx
+	pushl	%ebx
+	call	kern_do_schedule
+	movl	%ebp, %esp
+	pop	%ebp
+	ret
+#endif
+
 .data
 ENTRY(sys_call_table)
 	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */

Index: linux-2.6.3-kgdb/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.3-kgdb.orig/arch/x86_64/Kconfig	2004-02-19 13:36:04.000000000 +0530
+++ linux-2.6.3-kgdb/arch/x86_64/Kconfig	2004-02-19 14:09:24.211746736 +0530
@@ -465,8 +465,36 @@
          Add a simple leak tracer to the IOMMU code. This is useful when you
 	 are debugging a buggy device driver that leaks IOMMU mappings.
        
-#config X86_REMOTE_DEBUG
-#       bool "kgdb debugging stub"
+config KGDB
+	bool "KGDB: kernel debugging with remote gdb"
+	depends on DEBUG_KERNEL
+	select DEBUG_INFO
+	select FRAME_POINTER
+	help
+	  If you say Y here, it will be possible to remotely debug the
+	  kernel using gdb. This enlarges your kernel image disk size by
+	  several megabytes and requires a machine with more than 128 MB
+	  RAM to avoid excessive linking time. 
+	  Documentation of kernel debugger available at
+	  http://kgdb.sourceforge.net
+	  This is only useful for kernel hackers. If unsure, say N.
+
+config KGDB_THREAD
+	bool "KGDB: Thread analysis"
+	depends on KGDB
+	help
+	  With thread analysis enabled, gdb can talk to kgdb stub to list
+	  threads and to get stack trace for a thread. This option also enables
+	  some code which helps gdb get exact status of thread. Thread analysis
+	  adds some overhead to schedule and down functions. You can disable
+	  this option if you do not want to compromise on speed.
+
+config KGDB_CONSOLE
+	bool "KGDB: Console messages through gdb"
+	depends on KGDB
+	help
+	  If you say Y here, console messages will appear through gdb.
+	  Other consoles such as tty or ttyS will continue to work as usual.
 
 endmenu
 
Index: linux-2.6.3-kgdb/arch/x86_64/kernel/entry.S
===================================================================
--- linux-2.6.3-kgdb.orig/arch/x86_64/kernel/entry.S	2004-02-19 13:36:04.000000000 +0530
+++ linux-2.6.3-kgdb/arch/x86_64/kernel/entry.S	2004-02-19 14:09:24.224744760 +0530
@@ -219,7 +219,7 @@
 	jnc sysret_signal
 	sti
 	pushq %rdi
-	call schedule
+	call user_schedule
 	popq  %rdi
 	jmp sysret_check
 
@@ -288,7 +288,7 @@
 	jnc  int_very_careful
 	sti
 	pushq %rdi
-	call schedule
+	call user_schedule
 	popq %rdi
 	jmp int_with_check
 
@@ -482,7 +482,7 @@
 	jnc   retint_signal
 	sti
 	pushq %rdi
-	call  schedule
+	call  user_schedule
 	popq %rdi		
 	GET_THREAD_INFO(%rcx)
 	cli
@@ -868,3 +868,38 @@
 ENTRY(call_debug)
        zeroentry do_call_debug
 
+#ifdef CONFIG_KGDB_THREAD
+ENTRY(kern_schedule)
+	subq $21*8,%rsp
+	movq %rax,10*8(%rsp)
+
+	movq %rsp,%rax
+	addq $21*8,%rax
+	movq %rax, 19*8(%rsp)
+
+	pushfq
+	popq 18*8(%rsp)
+
+	movq 21*8(%rsp),%rax
+	movq %rax,16*8(%rsp)
+
+	movq %rdi,14*8(%rsp)
+	movq %rsi,13*8(%rsp)
+	movq %rdx,12*8(%rsp)
+	movq %rcx,11*8(%rsp)
+
+	movq %r8, 9*8(%rsp)
+	movq %r9, 8*8(%rsp)
+	movq %r10,7*8(%rsp)
+	movq %r11,6*8(%rsp)
+	movq %rbx,5*8(%rsp) 
+	movq %rbp,4*8(%rsp) 
+	movq %r12,3*8(%rsp) 
+	movq %r13,2*8(%rsp) 
+	movq %r14,1*8(%rsp) 
+	movq %r15,(%rsp) 
+	call kern_do_schedule
+	movq 10*8(%rsp), %rax
+	addq $21*8,%rsp
+	ret
+#endif
Index: linux-2.6.3-kgdb/arch/x86_64/kernel/Makefile
===================================================================
--- linux-2.6.3-kgdb.orig/arch/x86_64/kernel/Makefile	2004-02-19 13:36:04.000000000 +0530
+++ linux-2.6.3-kgdb/arch/x86_64/kernel/Makefile	2004-02-19 14:09:24.231743696 +0530
@@ -24,6 +24,7 @@
 obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 
 obj-$(CONFIG_MODULES)		+= module.o
+obj-$(CONFIG_KGDB)		+= x86_64-stub.o
 
 obj-y				+= topology.o
 
Index: linux-2.6.3-kgdb/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.3-kgdb.orig/arch/x86_64/kernel/nmi.c	2004-02-19 13:36:04.000000000 +0530
+++ linux-2.6.3-kgdb/arch/x86_64/kernel/nmi.c	2004-02-19 14:09:24.231743696 +0530
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/sysdev.h>
 #include <linux/nmi.h>
+#include <linux/debugger.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -317,13 +318,26 @@
 		return;
 
 	sum = read_pda(apic_timer_irqs);
-	if (last_irq_sums[cpu] == sum) {
+	if (atomic_read(&debugger_active)) {
+
+		/*
+		 * The machine is in debugger, hold this cpu if already
+		 * not held.
+		 */
+		debugger_nmihook(cpu, regs);
+		alert_counter[cpu] = 0;
+
+	} else if (last_irq_sums[cpu] == sum) {
+
 		/*
 		 * Ayiee, looks like this CPU is stuck ...
 		 * wait a few IRQs (5 seconds) before doing the oops ...
 		 */
 		alert_counter[cpu]++;
 		if (alert_counter[cpu] == 5*nmi_hz) {
+
+			CHK_DEBUGGER(2,SIGSEGV,0,regs,)
+
 			if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_BAD) { 
 				alert_counter[cpu] = 0; 
 				return;
Index: linux-2.6.3-kgdb/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.3-kgdb.orig/arch/x86_64/kernel/traps.c	2004-02-19 13:36:04.000000000 +0530
+++ linux-2.6.3-kgdb/arch/x86_64/kernel/traps.c	2004-02-19 14:09:24.232743544 +0530
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/debugger.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -363,6 +364,7 @@
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
+	CHK_DEBUGGER(1,SIGTRAP,err,regs,)
 	oops_begin();
 	handle_BUG(regs);
 	__die(str, regs, err);
@@ -436,6 +438,7 @@
 #define DO_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
+	CHK_DEBUGGER(1,SIGTRAP,error_code,regs,return) \
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == NOTIFY_BAD) \
 		return; \
 	do_trap(trapnr, signr, str, regs, error_code, NULL); \
@@ -614,7 +617,7 @@
 	tsk->thread.debugreg6 = condition;
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
-	if (condition & DR_STEP) {
+	if (condition & DR_STEP && !debugger_step) {
 		/*
 		 * The TF error should be masked out only if the current
 		 * process is not traced and if the TRAP flag has been set
@@ -643,6 +646,7 @@
 	force_sig_info(SIGTRAP, &info, tsk);	
 clear_dr7:
 	asm volatile("movq %0,%%db7"::"r"(0UL));
+	CHK_DEBUGGER(1,SIGTRAP,error_code,regs,return)
 	notify_die(DIE_DEBUG, "debug", regs, error_code, 1, SIGTRAP);
 	return;
 
Index: linux-2.6.3-kgdb/arch/x86_64/kernel/x86_64-stub.c
===================================================================
--- linux-2.6.3-kgdb.orig/arch/x86_64/kernel/x86_64-stub.c	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.3-kgdb/arch/x86_64/kernel/x86_64-stub.c	2004-02-19 14:09:24.234743240 +0530
@@ -0,0 +1,454 @@
+/*
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+/*
+ * Copyright (C) 2004 Amit S. Kale
+ * Copyright (C) 2000-2001 VERITAS Software Corporation.
+ * Copyright (C) 2002 Andi Kleen, SuSE Labs
+ */
+/****************************************************************************
+ *  Contributor:     Lake Stevens Instrument Division$
+ *  Written by:      Glenn Engel $
+ *  Updated by:	     Amit Kale<akale@veritas.com>
+ *  Modified for 386 by Jim Kingdon, Cygnus Support.
+ *  Origianl kgdb, compatibility with 2.1.xx kernel by David Grothe <dave@gcom.com>
+ *  Integrated into 2.2.5 kernel by Tigran Aivazian <tigran@sco.com>
+ *  X86_64 changes from Andi Kleen's patch merged by Jim Houston
+ */
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <asm/system.h>
+#include <asm/ptrace.h>			/* for linux pt_regs struct */
+#include <linux/kgdb.h>
+#ifdef CONFIG_GDB_CONSOLE
+#include <linux/console.h>
+#endif
+#include <linux/init.h>
+#include <linux/debugger.h>
+
+/* Put the error code here just in case the user cares.  */
+int gdb_x86_64errcode;
+/* Likewise, the vector number here (since GDB only gets the signal
+   number through the usual means, and that's not very specific).  */
+int gdb_x86_64vector = -1;
+
+#if KGDB_MAX_NO_CPUS != 8
+#error change the definition of slavecpulocks
+#endif
+
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	gdb_regs[_RAX] =  regs->rax;
+	gdb_regs[_RBX] =  regs->rbx;
+	gdb_regs[_RCX] =  regs->rcx;
+	gdb_regs[_RDX] =  regs->rdx;
+	gdb_regs[_RSI] =  regs->rsi;
+	gdb_regs[_RDI] =  regs->rdi;
+	gdb_regs[_RBP] =  regs->rbp;
+	gdb_regs[ _PS] =  regs->eflags;
+	gdb_regs[ _PC] =  regs->rip;
+	gdb_regs[ _R8] =  regs->r8;
+	gdb_regs[ _R9] =  regs->r9;
+	gdb_regs[_R10] = regs->r10;
+	gdb_regs[_R11] = regs->r11;
+	gdb_regs[_R12] = regs->r12;
+	gdb_regs[_R13] = regs->r13;
+	gdb_regs[_R14] = regs->r14;
+	gdb_regs[_R15] = regs->r15;
+	gdb_regs[_RSP] =  regs->rsp;
+}
+
+struct task_struct *__switch_to(struct task_struct *prev_p,
+				struct task_struct *next_p);
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+	gdb_regs[_RAX] = 0;
+	gdb_regs[_RBX] = 0;
+	gdb_regs[_RCX] = 0;
+	gdb_regs[_RDX] = 0;
+	gdb_regs[_RSI] = 0;
+	gdb_regs[_RDI] = 0;
+	gdb_regs[_RBP] = 0;
+	gdb_regs[ _PS] = 0;
+	gdb_regs[ _PC] = (unsigned long) __switch_to;
+	gdb_regs[ _R8] = 0;
+	gdb_regs[ _R9] = 0;
+	gdb_regs[_R10] = 0;
+	gdb_regs[_R11] = 0;
+	gdb_regs[_R12] = 0;
+	gdb_regs[_R13] = 0;
+	gdb_regs[_R14] = 0;
+	gdb_regs[_R15] = 0;
+	gdb_regs[_RSP] = p->thread.rsp;
+}
+
+void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	regs->rax	=     gdb_regs[_RAX] ;
+	regs->rbx	=     gdb_regs[_RBX] ;
+	regs->rcx	=     gdb_regs[_RCX] ;
+	regs->rdx	=     gdb_regs[_RDX] ;
+	regs->rsi	=     gdb_regs[_RSI] ;
+	regs->rdi	=     gdb_regs[_RDI] ;
+	regs->rbp	=     gdb_regs[_RBP] ;
+	regs->eflags=     gdb_regs[ _PS] ;
+	regs->rip	=     gdb_regs[ _PC] ;
+	regs->r8	=     gdb_regs[ _R8] ;
+	regs->r9	=     gdb_regs[ _R9] ;
+	regs->r10	=     gdb_regs[ _R10] ;
+	regs->r11    =     gdb_regs[ _R11] ;
+	regs->r12	=     gdb_regs[ _R12] ;
+	regs->r13	=     gdb_regs[ _R13] ;
+	regs->r14	=     gdb_regs[ _R14] ;
+	regs->r15	=     gdb_regs[ _R15] ;
+#if 0					/* can't change these */
+	regs->rsp	=     gdb_regs[_RSP] ;
+	regs->ss	=     gdb_regs[ _SS] ;
+	regs->fs	=     gdb_regs[ _FS] ;
+	regs->gs	=     gdb_regs[ _GS] ;
+#endif
+
+} /* gdb_regs_to_regs */
+
+
+struct hw_breakpoint {
+	unsigned enabled;
+	unsigned type;
+	unsigned len;
+	unsigned long addr;
+} breakinfo[4] = { {
+enabled:0}, {
+enabled:0}, {
+enabled:0}, {
+enabled:0}};
+
+void kgdb_correct_hw_break(void)
+{
+	int breakno;
+	int correctit;
+	int breakbit;
+	unsigned long dr7;
+
+	asm volatile ("movq %%db7, %0\n":"=r" (dr7) :);
+	do {
+		unsigned long addr0, addr1, addr2, addr3;
+		asm volatile ("movq %%db0, %0\n"
+			      "movq %%db1, %1\n"
+			      "movq %%db2, %2\n"
+			      "movq %%db3, %3\n":"=r" (addr0), "=r"(addr1),
+			      "=r"(addr2), "=r"(addr3):);
+	} while (0);
+	correctit = 0;
+	for (breakno = 0; breakno < 3; breakno++) {
+		breakbit = 2 << (breakno << 1);
+		if (!(dr7 & breakbit) && breakinfo[breakno].enabled) {
+			correctit = 1;
+			dr7 |= breakbit;
+			dr7 &= ~(0xf0000 << (breakno << 2));
+			dr7 |= (((breakinfo[breakno].len << 2) |
+				 breakinfo[breakno].type) << 16) <<
+			    (breakno << 2);
+			switch (breakno) {
+			case 0:
+				asm volatile ("movq %0, %%dr0\n"::"r"
+					      (breakinfo[breakno].addr));
+				break;
+
+			case 1:
+				asm volatile ("movq %0, %%dr1\n"::"r"
+					      (breakinfo[breakno].addr));
+				break;
+
+			case 2:
+				asm volatile ("movq %0, %%dr2\n"::"r"
+					      (breakinfo[breakno].addr));
+				break;
+
+			case 3:
+				asm volatile ("movq %0, %%dr3\n"::"r"
+					      (breakinfo[breakno].addr));
+				break;
+			}
+		} else if ((dr7 & breakbit) && !breakinfo[breakno].enabled) {
+			correctit = 1;
+			dr7 &= ~breakbit;
+			dr7 &= ~(0xf0000 << (breakno << 2));
+		}
+	}
+	if (correctit) {
+		asm volatile ("movq %0, %%db7\n"::"r" (dr7));
+	}
+}
+
+int kgdb_remove_hw_break(unsigned long addr, int type)
+{
+	int i, idx = -1;
+	for (i = 0; i < 4; i ++) {
+		if (breakinfo[i].addr == addr && breakinfo[i].enabled) {
+			idx = i;
+			break;
+		}
+	}
+	if (idx == -1)
+		return -1;
+
+	breakinfo[idx].enabled = 0;
+	return 0;
+}
+
+int kgdb_set_hw_break(unsigned long addr, int type)
+{
+	int i, idx = -1;
+	for (i = 0; i < 4; i ++) {
+		if (!breakinfo[i].enabled) {
+			idx = i;
+			break;
+		}
+	}
+	if (idx == -1)
+		return -1;
+
+	breakinfo[idx].enabled = 1;
+	breakinfo[idx].type = type;
+	breakinfo[idx].len = 1;
+	breakinfo[idx].addr = addr;
+	return 0;
+}
+
+int remove_hw_break(unsigned breakno)
+{
+	if (!breakinfo[breakno].enabled) {
+		return -1;
+	}
+	breakinfo[breakno].enabled = 0;
+	return 0;
+}
+
+int set_hw_break(unsigned breakno,
+		 unsigned type, unsigned len, unsigned addr)
+{
+	if (breakinfo[breakno].enabled) {
+		return -1;
+	}
+	breakinfo[breakno].enabled = 1;
+	breakinfo[breakno].type = type;
+	breakinfo[breakno].len = len;
+	breakinfo[breakno].addr = addr;
+	return 0;
+}
+
+void kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
+{
+	unsigned long	dr6;
+	int		i;
+	switch (exceptionNo) {
+	case 1:		/* debug exception */
+		break;
+	case 3:		/* breakpoint */
+		sprintf(buffer, "Software breakpoint");
+		return;
+	default:
+		sprintf(buffer, "Details not available");
+		return;
+	}
+	asm volatile ("movq %%db6, %0\n":"=r" (dr6)
+		      :);
+	if (dr6 & 0x4000) {
+		sprintf(buffer, "Single step");
+		return;
+	}
+	for (i = 0; i < 4; ++i) {
+		if (dr6 & (1 << i)) {
+			sprintf(buffer, "Hardware breakpoint %d", i);
+			return;
+		}
+	}
+	sprintf(buffer, "Unknown trap");
+	return;
+}
+
+void kgdb_disable_hw_debug(struct pt_regs *regs) 
+{
+	/* Disable hardware debugging while we are in kgdb */
+	asm volatile("movq %0,%%db7": /* no output */ : "r"(0UL));
+}
+
+void kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
+{
+	/* Master processor is completely in the debugger */
+	gdb_x86_64vector = eVector;
+	gdb_x86_64errcode = err_code;
+}
+
+int kgdb_arch_handle_exception(int exceptionVector, int signo, int err_code,
+                                 char *remcomInBuffer, char *remcomOutBuffer,
+                                 struct pt_regs *linux_regs)
+{
+	unsigned long addr, length;
+	unsigned long breakno, breaktype;
+	char *ptr;
+	int newPC;
+	unsigned long dr6;
+	
+	switch (remcomInBuffer[0]) {
+	case 'c':
+	case 's':
+		if (kgdb_contthread && kgdb_contthread != current) {
+			strcpy(remcomOutBuffer, "E00");
+			break;
+		}
+
+		kgdb_contthread = NULL;
+
+		/* try to read optional parameter, pc unchanged if no parm */
+		ptr = &remcomInBuffer[1];
+		if (kgdb_hexToLong(&ptr, &addr)) {
+			linux_regs->rip = addr;
+		} 
+		newPC = linux_regs->rip;
+		
+		/* clear the trace bit */
+		linux_regs->eflags &= 0xfffffeff;
+
+		/* set the trace bit if we're stepping */
+		if (remcomInBuffer[0] == 's') {
+			linux_regs->eflags |= 0x100;
+			debugger_step = 1;
+		}
+
+		asm volatile ("movq %%db6, %0\n" : "=r" (dr6));
+		if (!(dr6 & 0x4000)) {
+			for (breakno = 0; breakno < 4; ++breakno) {
+				if (dr6 & (1 << breakno)) {
+					if (breakinfo[breakno].type == 0) {
+						/* Set restore flag */
+						linux_regs->eflags |= 0x10000;
+						break;
+					}
+				}
+			}
+		}
+		kgdb_correct_hw_break();
+		asm volatile ("movq %0, %%db6\n"::"r" (0UL));
+
+		return (0);
+
+	case 'Y':
+		ptr = &remcomInBuffer[1];
+		kgdb_hexToLong(&ptr, &breakno);
+		ptr++;
+		kgdb_hexToLong(&ptr, &breaktype);
+		ptr++;
+		kgdb_hexToLong(&ptr, &length);
+		ptr++;
+		kgdb_hexToLong(&ptr, &addr);
+		if (set_hw_break(breakno & 0x3, breaktype & 0x3, 
+				 length & 0x3, addr) == 0) {
+			strcpy(remcomOutBuffer, "OK");
+		} else {
+			strcpy(remcomOutBuffer, "ERROR");
+		}
+		break;
+
+		/* Remove hardware breakpoint */
+	case 'y':
+		ptr = &remcomInBuffer[1];
+		kgdb_hexToLong(&ptr, &breakno);
+		if (remove_hw_break(breakno & 0x3) == 0) {
+			strcpy(remcomOutBuffer, "OK");
+		} else {
+			strcpy(remcomOutBuffer, "ERROR");
+		}
+		break;
+
+	}		/* switch */
+	return -1; /* this means that we do not want to exit from the handler */
+}
+
+static struct pt_regs *in_interrupt_stack(unsigned long rsp, int cpu) 
+{ 
+	struct pt_regs *regs;
+	unsigned long end = (unsigned long) cpu_pda[cpu].irqstackptr; 
+	if (rsp <= end  && 
+	    rsp >= end - IRQSTACKSIZE + 8) { 
+		regs = *(((struct pt_regs **)end) -1);
+		return regs;
+	} 
+	return NULL; 
+} 
+
+static struct pt_regs *in_exception_stack(unsigned long rsp, int cpu)
+{ 
+	int i;
+	for (i = 0; i < N_EXCEPTION_STACKS; i++) 
+	       if (rsp >= init_tss[cpu].ist[i] && 
+		   rsp <= init_tss[cpu].ist[i] + EXCEPTION_STKSZ) {
+		       struct pt_regs *r = (void *)init_tss[cpu].ist[i] + EXCEPTION_STKSZ;
+		       return r-1; 
+	       } 
+	return NULL;
+} 
+
+void kgdb_shadowinfo(struct pt_regs *regs, char *buffer,
+		unsigned threadid)
+{
+	static char intr_desc[] = "Stack at interrupt entrypoint";
+	static char exc_desc[] = "Stack at exception entrypoint";
+	struct pt_regs *stregs;
+	int cpu = hard_smp_processor_id();
+
+	if ((stregs = in_interrupt_stack(regs->rsp, cpu))) {
+		kgdb_mem2hex(intr_desc, buffer, strlen(intr_desc));
+	} else if ((stregs = in_exception_stack(regs->rsp, cpu))) {
+		kgdb_mem2hex(exc_desc, buffer, strlen(exc_desc));
+	}
+}
+
+struct task_struct *kgdb_get_shadow_thread(struct pt_regs *regs,
+		int threadid)
+{
+	struct pt_regs *stregs;
+	int cpu = hard_smp_processor_id();
+
+	if ((stregs = in_interrupt_stack(regs->rsp, cpu))) {
+		return current;
+	} else if ((stregs = in_exception_stack(regs->rsp, cpu))) {
+		return current;
+	}
+	return NULL;
+}
+
+struct pt_regs *kgdb_shadow_regs(struct pt_regs *regs, int threadid)
+{
+	struct pt_regs *stregs;
+	int cpu = hard_smp_processor_id();
+
+	if ((stregs = in_interrupt_stack(regs->rsp, cpu))) {
+		return stregs;
+	} else if ((stregs = in_exception_stack(regs->rsp, cpu))) {
+		return stregs;
+	}
+	return NULL;
+}
+
+struct kgdb_arch arch_kgdb_ops =  {
+	.gdb_bpt_instr = {0xcc},
+	.flags = KGDB_HW_BREAKPOINT,
+	.shadowth = 1,
+};
Index: linux-2.6.3-kgdb/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6.3-kgdb.orig/arch/x86_64/mm/fault.c	2004-02-19 13:36:04.000000000 +0530
+++ linux-2.6.3-kgdb/arch/x86_64/mm/fault.c	2004-02-19 14:09:24.242742024 +0530
@@ -23,6 +23,7 @@
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/compiler.h>
 #include <linux/module.h>
+#include <linux/debugger.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -407,6 +408,7 @@
 
  	if (is_prefetch(regs, address))
  		return;
+	CHK_DEBUGGER(14, SIGSEGV,error_code, regs,)
 
 	if (is_errata93(regs, address))
 		return; 
Index: linux-2.6.3-kgdb/include/asm-x86_64/calling.h
===================================================================
--- linux-2.6.3-kgdb.orig/include/asm-x86_64/calling.h	2004-02-19 13:36:04.000000000 +0530
+++ linux-2.6.3-kgdb/include/asm-x86_64/calling.h	2004-02-19 14:09:24.245741568 +0530
@@ -12,7 +12,7 @@
 #define RBX 40
 /* arguments: interrupts/non tracing syscalls only save upto here*/
 #define R11 48
-#define R10 56	
+#define R10 56
 #define R9 64
 #define R8 72
 #define RAX 80
Index: linux-2.6.3-kgdb/include/asm-x86_64/kgdb.h
===================================================================
--- linux-2.6.3-kgdb.orig/include/asm-x86_64/kgdb.h	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.3-kgdb/include/asm-x86_64/kgdb.h	2004-02-19 14:09:24.245741568 +0530
@@ -0,0 +1,53 @@
+#ifndef _ASM_KGDB_H_
+#define _ASM_KGDB_H_
+
+/*
+ * Copyright (C) 2001-2004 Amit S. Kale
+ */
+
+#include <linux/ptrace.h>
+
+/* gdb locks */
+#define KGDB_MAX_NO_CPUS 8
+
+/************************************************************************/
+/* BUFMAX defines the maximum number of characters in inbound/outbound buffers*/
+/* at least NUMREGBYTES*2 are needed for register packets */
+/* Longer buffer is needed to list all threads */
+#define BUFMAX 1024
+
+/*
+ *  Note that this register image is in a different order than
+ *  the register image that Linux produces at interrupt time.
+ *  
+ *  Linux's register image is defined by struct pt_regs in ptrace.h.
+ *  Just why GDB uses a different order is a historical mystery.
+ */
+
+enum regnames {_RAX,	
+	       _RDX,
+	       _RCX,
+	       _RBX,
+	       _RSI,		
+	       _RDI,		
+	       _RBP,	       
+	       _RSP,		
+	       _R8,
+	       _R9,
+	       _R10,
+	       _R11,
+	       _R12,
+	       _R13,
+	       _R14,
+	       _R15,
+	       _PC, 		
+	       _PS,
+	       _LASTREG=_PS }; 
+
+/* Number of bytes of registers.  */
+#define NUMREGBYTES (_LASTREG*8)
+
+#define BREAKPOINT() asm("   int $3");
+#define BREAK_INSTR_SIZE       1
+
+#endif /* _ASM_KGDB_H_ */
Index: linux-2.6.3-kgdb/include/asm-x86_64/processor.h
===================================================================
--- linux-2.6.3-kgdb.orig/include/asm-x86_64/processor.h	2004-02-19 13:36:04.000000000 +0530
+++ linux-2.6.3-kgdb/include/asm-x86_64/processor.h	2004-02-19 14:09:24.253740352 +0530
@@ -252,6 +252,7 @@
 	unsigned long	*io_bitmap_ptr;
 /* cached TLS descriptors. */
 	u64 tls_array[GDT_ENTRY_TLS_ENTRIES];
+	void		*debuggerinfo;
 };
 
 #define INIT_THREAD  {}

Index: linux-2.6.3-kgdb/arch/ppc/8260_io/uart.c
===================================================================
--- linux-2.6.3-kgdb.orig/arch/ppc/8260_io/uart.c	2004-02-19 13:36:00.000000000 +0530
+++ linux-2.6.3-kgdb/arch/ppc/8260_io/uart.c	2004-02-19 14:09:29.820894016 +0530
@@ -43,6 +43,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/kgdb.h>
 #include <asm/uaccess.h>
 #include <asm/immap_8260.h>
 #include <asm/mpc8260.h>
@@ -394,8 +395,21 @@
 		status = bdp->cbd_sc;
 #ifdef CONFIG_KGDB
 		if (info->state->smc_scc_num == KGDB_SER_IDX) {
-			if (*cp == 0x03 || *cp == '$')
-				breakpoint();
+			while (i-- > 0) {
+				if (*cp == 0x03) {
+					breakpoint();
+					return;
+				}
+				if (*cp == '$') {
+					atomic_set(&kgdb_might_be_resumed, 1);
+					breakpoint();
+					atomic_set(&kgdb_might_be_resumed, 0);
+					return;
+				}
+				cp++;
+			}
+			bdp->cbd_sc |= BD_SC_EMPTY;
+			bdp->cbd_sc &= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV);
 			return;
 		}
 #endif
@@ -2275,9 +2289,8 @@
 static void serial_console_write(struct console *c, const char *s,
 				unsigned count)
 {
-#if defined(CONFIG_KGDB_CONSOLE) && !defined(CONFIG_USE_SERIAL2_KGDB)
-	/* Try to let stub handle output. Returns true if it did. */
-	if (kgdb_output_string(s, count))
+#ifdef CONFIG_KGDB
+	if (kgdb_initialized)
 		return;
 #endif
 	my_console_write(c->index, s, count);
Index: linux-2.6.3-kgdb/arch/ppc/Kconfig
===================================================================
--- linux-2.6.3-kgdb.orig/arch/ppc/Kconfig	2004-02-19 13:36:00.000000000 +0530
+++ linux-2.6.3-kgdb/arch/ppc/Kconfig	2004-02-19 14:09:29.834891888 +0530
@@ -1174,6 +1174,7 @@
 	bool "Include kgdb kernel debugger"
 	depends on DEBUG_KERNEL
 	select DEBUG_INFO
+	select FRAME_POINTER
 	help
 	  Include in-kernel hooks for kgdb, the Linux kernel source level
 	  debugger.  See <http://kgdb.sourceforge.net/> for more information.
@@ -1198,6 +1199,16 @@
 
 endchoice
 
+config KGDB_THREAD
+	bool "KGDB: Thread analysis"
+	depends on KGDB
+	help
+	  With thread analysis enabled, gdb can talk to kgdb stub to list
+	  threads and to get stack trace for a thread. This option also enables
+	  some code which helps gdb get exact status of thread. Thread analysis
+	  adds some overhead to schedule and down functions. You can disable
+	  this option if you do not want to compromise on speed.
+
 config KGDB_CONSOLE
 	bool "Enable serial console thru kgdb port"
 	depends on KGDB && 8xx || 8260
Index: linux-2.6.3-kgdb/arch/ppc/kernel/entry.S
===================================================================
--- linux-2.6.3-kgdb.orig/arch/ppc/kernel/entry.S	2004-02-19 13:36:00.000000000 +0530
+++ linux-2.6.3-kgdb/arch/ppc/kernel/entry.S	2004-02-19 14:09:29.844890368 +0530
@@ -296,7 +296,11 @@
 	ori	r10,r10,MSR_EE
 	SYNC
 	MTMSRD(r10)		/* re-enable interrupts */
-	bl	schedule
+#ifdef CONFIG_KGDB_THREAD
+	bl	user_schedule
+#else
+	bl	do_schedule
+#endif
 	b	2b
 
 #ifdef SHOW_SYSCALLS
@@ -547,7 +551,11 @@
 	ori	r10,r10,MSR_EE
 	SYNC
 	MTMSRD(r10)		/* hard-enable interrupts */
-	bl	schedule
+#ifdef CONFIG_KGDB_THREAD
+	bl	user_schedule
+#else
+	bl	do_schedule
+#endif
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
@@ -751,7 +759,11 @@
 	ori	r10,r10,MSR_EE
 	SYNC
 	MTMSRD(r10)		/* hard-enable interrupts */
-	bl	schedule
+#ifdef CONFIG_KGDB_THREAD
+	bl	user_schedule
+#else
+	bl	do_schedule
+#endif
 recheck:
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
@@ -815,6 +827,57 @@
 	/* shouldn't return */
 	b	4b
 
+#ifdef CONFIG_KGDB_THREAD
+/*
+ * These are hooks used by KGDB because switch_to does not save registers
+ * in pt_regs.  The registers are saved on the stack on behalf of the caller
+ * of these funtions.
+ */
+
+_GLOBAL(kern_schedule)
+	stwu	r1,-INT_FRAME_SIZE(r1)	/* Allocate exception frame */
+	SAVE_8GPRS( 0, r1)
+	SAVE_8GPRS( 8, r1)
+	SAVE_8GPRS(16, r1)
+	SAVE_8GPRS(24, r1)
+	addi	r3,r1,INT_FRAME_SIZE
+	stw		r3,GPR1(r1)
+	mfcr	r3
+	stw		r3,_CCR(r1)
+	mflr	r3
+	stw		r3,_NIP(r1)
+	mfctr	r3
+	stw		r3,_CTR(r1)
+	mfxer	r3
+	stw		r3,_XER(r1)
+	mfmsr	r3
+	stw		r3,_MSR(r1)
+	lwz		r3,INT_FRAME_SIZE+4(r1)
+	stw		r3,_LINK(r1)
+
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl		kern_do_schedule
+
+	lwz		r3,_CCR(r1)
+	mtcr	r3
+	lwz		r3,_XER(r1)
+	mtxer	r3
+	lwz		r3,_NIP(r1)
+	mtlr	r3
+	lwz		r3,_CTR(r1)
+	mtctr	r3
+	lwz		r3,_MSR(r1)
+	mtmsr	r3
+	lwz		r0,GPR0(r1)
+	REST_2GPRS ( 2, r1)
+	REST_4GPRS ( 4, r1)
+	REST_8GPRS ( 8, r1)
+	REST_8GPRS (16, r1)
+	REST_8GPRS (24, r1)
+	addi	r1,r1,INT_FRAME_SIZE
+	blr
+#endif
+
 	.comm	ee_restarts,4
 
 /*
Index: linux-2.6.3-kgdb/arch/ppc/kernel/irq.c
===================================================================
--- linux-2.6.3-kgdb.orig/arch/ppc/kernel/irq.c	2004-02-19 13:36:00.000000000 +0530
+++ linux-2.6.3-kgdb/arch/ppc/kernel/irq.c	2004-02-19 14:09:29.845890216 +0530
@@ -513,6 +513,12 @@
 void do_IRQ(struct pt_regs *regs)
 {
 	int irq, first = 1;
+	unsigned long *lrptr;
+	if (!(regs->msr & MSR_PR)) {
+		/* Came in from the kernel. Save call link. */
+		lrptr = (unsigned long *)(regs->gpr[1] + 4);
+		*lrptr = regs->nip;
+	}
         irq_enter();
 
 	/*
Index: linux-2.6.3-kgdb/arch/ppc/kernel/ppc-stub.c
===================================================================
--- linux-2.6.3-kgdb.orig/arch/ppc/kernel/ppc-stub.c	2004-02-19 13:36:00.000000000 +0530
+++ linux-2.6.3-kgdb/arch/ppc/kernel/ppc-stub.c	2004-02-19 14:09:29.848889760 +0530
@@ -1,857 +1,310 @@
 /*
- * ppc-stub.c:  KGDB support for the Linux kernel.
  *
- * adapted from arch/sparc/kernel/sparc-stub.c for the PowerPC
- * some stuff borrowed from Paul Mackerras' xmon
- * Copyright (C) 1998 Michael AK Tesch (tesch@cs.wisc.edu)
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
  *
- * Modifications to run under Linux
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- *
- * This file originally came from the gdb sources, and the
- * copyright notices have been retained below.
  */
 
-/****************************************************************************
-
-		THIS SOFTWARE IS NOT COPYRIGHTED
-
-   HP offers the following for use in the public domain.  HP makes no
-   warranty with regard to the software or its performance and the
-   user accepts the software "AS IS" with all faults.
-
-   HP DISCLAIMS ANY WARRANTIES, EXPRESS OR IMPLIED, WITH REGARD
-   TO THIS SOFTWARE INCLUDING BUT NOT LIMITED TO THE WARRANTIES
-   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
-
-****************************************************************************/
-
-/****************************************************************************
- *  Header: remcom.c,v 1.34 91/03/09 12:29:49 glenne Exp $
- *
- *  Module name: remcom.c $
- *  Revision: 1.34 $
- *  Date: 91/03/09 12:29:49 $
- *  Contributor:     Lake Stevens Instrument Division$
- *
- *  Description:     low level support for gdb debugger. $
- *
- *  Considerations:  only works on target hardware $
- *
- *  Written by:      Glenn Engel $
- *  ModuleState:     Experimental $
- *
- *  NOTES:           See Below $
- *
- *  Modified for SPARC by Stu Grossman, Cygnus Support.
- *
- *  This code has been extensively tested on the Fujitsu SPARClite demo board.
- *
- *  To enable debugger support, two things need to happen.  One, a
- *  call to set_debug_traps() is necessary in order to allow any breakpoints
- *  or error conditions to be properly intercepted and reported to gdb.
- *  Two, a breakpoint needs to be generated to begin communication.  This
- *  is most easily accomplished by a call to breakpoint().  Breakpoint()
- *  simulates a breakpoint by executing a trap #1.
- *
- *************
- *
- *    The following gdb commands are supported:
- *
- * command          function		          Return value
- *
- *    g             return the value of the CPU registers  hex data or ENN
- *    G             set the value of the CPU registers     OK or ENN
- *    qOffsets      Get section offsets.  Reply is Text=xxx;Data=yyy;Bss=zzz
- *
- *    mAA..AA,LLLL  Read LLLL bytes at address AA..AA      hex data or ENN
- *    MAA..AA,LLLL: Write LLLL bytes at address AA.AA      OK or ENN
- *
- *    c             Resume at current address              SNN   ( signal NN)
- *    cAA..AA       Continue at address AA..AA             SNN
- *
- *    s             Step one instruction                   SNN
- *    sAA..AA       Step one instruction from AA..AA       SNN
- *
- *    k             kill
- *
- *    ?             What was the last sigval ?             SNN   (signal NN)
- *
- *    bBB..BB	    Set baud rate to BB..BB		   OK or BNN, then sets
- *							   baud rate
- *
- * All commands and responses are sent with a packet which includes a
- * checksum.  A packet consists of
- *
- * $<packet info>#<checksum>.
- *
- * where
- * <packet info> :: <characters representing the command or response>
- * <checksum>    :: <two hex digits computed as modulo 256 sum of <packetinfo>>
- *
- * When a packet is received, it is first acknowledged with either '+' or '-'.
- * '+' indicates a successful transfer.  '-' indicates a failed transfer.
- *
- * Example:
- *
- * Host:                  Reply:
- * $m0,10#2a               +$00010203040506070809101112131415#42
- *
- ****************************************************************************/
+/*
+ * 1998 (c) Michael AK Tesch (tesch@cs.wisc.edu)
+ * Copyright (C) 2003 Timesys Corporation.
+ * KGDB for the PowerPC processor
+ */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/smp_lock.h>
-
-#include <asm/cacheflush.h>
-#include <asm/system.h>
-#include <asm/signal.h>
-#include <asm/kgdb.h>
-#include <asm/pgtable.h>
+#include <linux/config.h>
+#include <linux/kgdb.h>
+#include <asm/current.h>
 #include <asm/ptrace.h>
+#include <asm/processor.h>
 
-void breakinst(void);
-
+/* Convert the hardware trap type code to a unix signal number. */
 /*
- * BUFMAX defines the maximum number of characters in inbound/outbound buffers
- * at least NUMREGBYTES*2 are needed for register packets
+ * This table contains the mapping between PowerPC hardware trap types, and
+ * signals, which are primarily what GDB understands.
  */
-#define BUFMAX 2048
-static char remcomInBuffer[BUFMAX];
-static char remcomOutBuffer[BUFMAX];
-
-static int initialized;
-static int kgdb_active;
-static int kgdb_started;
-static u_int fault_jmp_buf[100];
-static int kdebug;
-
-
-static const char hexchars[]="0123456789abcdef";
-
-/* Place where we save old trap entries for restoration - sparc*/
-/* struct tt_entry kgdb_savettable[256]; */
-/* typedef void (*trapfunc_t)(void); */
-
-static void kgdb_fault_handler(struct pt_regs *regs);
-static int handle_exception (struct pt_regs *regs);
-
-#if 0
-/* Install an exception handler for kgdb */
-static void exceptionHandler(int tnum, unsigned int *tfunc)
+static struct hard_trap_info
 {
-	/* We are dorking with a live trap table, all irqs off */
-}
+	unsigned int tt;		/* Trap type code for powerpc */
+	unsigned char signo;		/* Signal that we map this trap into */
+} hard_trap_info[] = {
+#if defined(CONFIG_40x)
+	{ 0x0100, 0x02 /* SIGINT */  },		/* critical input interrupt */
+	{ 0x0200, 0x0b /* SIGSEGV */ },		/* machine check */
+	{ 0x0300, 0x0b /* SIGSEGV */ },		/* data storage */
+	{ 0x0400, 0x0a /* SIGBUS */  },		/* instruction storage */
+	{ 0x0500, 0x02 /* SIGINT */  },		/* interrupt */
+	{ 0x0600, 0x0a /* SIGBUS */  },		/* alignment */
+	{ 0x0700, 0x04 /* SIGILL */  },		/* program */
+	{ 0x0800, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0900, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0a00, 0x04 /* SIGILL */  },		/* reserved */
+ 	{ 0x0b00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0c00, 0x14 /* SIGCHLD */ },		/* syscall */
+	{ 0x0d00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0e00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0f00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x2000, 0x05 /* SIGTRAP */},		/* debug */
+#else
+	{ 0x0200, 0x0b /* SIGSEGV */ },		/* machine check */
+	{ 0x0300, 0x0b /* SIGSEGV */ },		/* address error (store) */
+	{ 0x0400, 0x0a /* SIGBUS */ },		/* instruction bus error */
+	{ 0x0500, 0x02 /* SIGINT */ },		/* interrupt */
+	{ 0x0600, 0x0a /* SIGBUS */ },		/* alingment */
+	{ 0x0700, 0x05 /* SIGTRAP */ },		/* breakpoint trap */
+	{ 0x0800, 0x08 /* SIGFPE */},		/* fpu unavail */
+	{ 0x0900, 0x0e /* SIGALRM */ },		/* decrementer */
+	{ 0x0a00, 0x04 /* SIGILL */ },		/* reserved */
+	{ 0x0b00, 0x04 /* SIGILL */ },		/* reserved */
+	{ 0x0c00, 0x14 /* SIGCHLD */ },		/* syscall */
+	{ 0x0d00, 0x05 /* SIGTRAP */ },		/* single-step/watch */
+	{ 0x0e00, 0x08 /* SIGFPE */ },		/* fp assist */
 #endif
+	{ 0x0000, 0x000 }			/* Must be last */
+};
 
-int
-kgdb_setjmp(long *buf)
-{
-	asm ("mflr 0; stw 0,0(%0);"
-	     "stw 1,4(%0); stw 2,8(%0);"
-	     "mfcr 0; stw 0,12(%0);"
-	     "stmw 13,16(%0)"
-	     : : "r" (buf));
-	/* XXX should save fp regs as well */
-	return 0;
-}
-void
-kgdb_longjmp(long *buf, int val)
-{
-	if (val == 0)
-		val = 1;
-	asm ("lmw 13,16(%0);"
-	     "lwz 0,12(%0); mtcrf 0x38,0;"
-	     "lwz 0,0(%0); lwz 1,4(%0); lwz 2,8(%0);"
-	     "mtlr 0; mr 3,%1"
-	     : : "r" (buf), "r" (val));
-}
-/* Convert ch from a hex digit to an int */
-static int
-hex(unsigned char ch)
-{
-	if (ch >= 'a' && ch <= 'f')
-		return ch-'a'+10;
-	if (ch >= '0' && ch <= '9')
-		return ch-'0';
-	if (ch >= 'A' && ch <= 'F')
-		return ch-'A'+10;
-	return -1;
-}
-
-/* Convert the memory pointed to by mem into hex, placing result in buf.
- * Return a pointer to the last char put in buf (null), in case of mem fault,
- * return 0.
+/*
+ * Forward prototypes
  */
-static unsigned char *
-mem2hex(const char *mem, char *buf, int count)
-{
-	unsigned char ch;
-	unsigned short tmp_s;
-	unsigned long tmp_l;
-
-	if (kgdb_setjmp((long*)fault_jmp_buf) == 0) {
-		debugger_fault_handler = kgdb_fault_handler;
-
-		/* Accessing 16 bit and 32 bit objects in a single
-		** load instruction is required to avoid bad side
-		** effects for some IO registers.
-		*/
-
-		if ((count == 2) && (((long)mem & 1) == 0)) {
-			tmp_s = *(unsigned short *)mem;
-			mem += 2;
-			*buf++ = hexchars[(tmp_s >> 12) & 0xf];
-			*buf++ = hexchars[(tmp_s >> 8) & 0xf];
-			*buf++ = hexchars[(tmp_s >> 4) & 0xf];
-			*buf++ = hexchars[tmp_s & 0xf];
-
-		} else if ((count == 4) && (((long)mem & 3) == 0)) {
-			tmp_l = *(unsigned int *)mem;
-			mem += 4;
-			*buf++ = hexchars[(tmp_l >> 28) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 24) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 20) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 16) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 12) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 8) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 4) & 0xf];
-			*buf++ = hexchars[tmp_l & 0xf];
-
-		} else {
-			while (count-- > 0) {
-				ch = *mem++;
-				*buf++ = hexchars[ch >> 4];
-				*buf++ = hexchars[ch & 0xf];
-			}
-		}
-
-	} else {
-		/* error condition */
-	}
-	debugger_fault_handler = 0;
-	*buf = 0;
-	return buf;
-}
-
-/* convert the hex array pointed to by buf into binary to be placed in mem
- * return a pointer to the character AFTER the last byte written.
-*/
-static char *
-hex2mem(char *buf, char *mem, int count)
-{
-	unsigned char ch;
-	int i;
-	char *orig_mem;
-	unsigned short tmp_s;
-	unsigned long tmp_l;
-
-	orig_mem = mem;
-
-	if (kgdb_setjmp((long*)fault_jmp_buf) == 0) {
-		debugger_fault_handler = kgdb_fault_handler;
-
-		/* Accessing 16 bit and 32 bit objects in a single
-		** store instruction is required to avoid bad side
-		** effects for some IO registers.
-		*/
-
-		if ((count == 2) && (((long)mem & 1) == 0)) {
-			tmp_s = hex(*buf++) << 12;
-			tmp_s |= hex(*buf++) << 8;
-			tmp_s |= hex(*buf++) << 4;
-			tmp_s |= hex(*buf++);
-
-			*(unsigned short *)mem = tmp_s;
-			mem += 2;
-
-		} else if ((count == 4) && (((long)mem & 3) == 0)) {
-			tmp_l = hex(*buf++) << 28;
-			tmp_l |= hex(*buf++) << 24;
-			tmp_l |= hex(*buf++) << 20;
-			tmp_l |= hex(*buf++) << 16;
-			tmp_l |= hex(*buf++) << 12;
-			tmp_l |= hex(*buf++) << 8;
-			tmp_l |= hex(*buf++) << 4;
-			tmp_l |= hex(*buf++);
-
-			*(unsigned long *)mem = tmp_l;
-			mem += 4;
-
-		} else {
-			for (i=0; i<count; i++) {
-				ch = hex(*buf++) << 4;
-				ch |= hex(*buf++);
-				*mem++ = ch;
-			}
-		}
+static void kgdb_debugger (struct pt_regs *regs);
+static int kgdb_breakpoint (struct pt_regs *regs);
+static int kgdb_singlestep (struct pt_regs *regs);
+static int ppc_kgdb_init (void);
+void ppc_handler_exit (void);
 
+static int computeSignal(unsigned int tt)
+{
+	struct hard_trap_info *ht;
 
-		/*
-		** Flush the data cache, invalidate the instruction cache.
-		*/
-		flush_icache_range((int)orig_mem, (int)orig_mem + count - 1);
+	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
+		if (ht->tt == tt)
+			return ht->signo;
 
-	} else {
-		/* error condition */
-	}
-	debugger_fault_handler = 0;
-	return mem;
+	return SIGHUP; /* default for things we don't know about */
 }
 
 /*
- * While we find nice hex chars, build an int.
- * Return number of chars processed.
+ * Routines
  */
-static int
-hexToInt(char **ptr, int *intValue)
+static void kgdb_debugger (struct pt_regs *regs)
 {
-	int numChars = 0;
-	int hexValue;
-
-	*intValue = 0;
-
-	if (kgdb_setjmp((long*)fault_jmp_buf) == 0) {
-		debugger_fault_handler = kgdb_fault_handler;
-		while (**ptr) {
-			hexValue = hex(**ptr);
-			if (hexValue < 0)
-				break;
-
-			*intValue = (*intValue << 4) | hexValue;
-			numChars ++;
-
-			(*ptr)++;
-		}
-	} else {
-		/* error condition */
-	}
-	debugger_fault_handler = 0;
-
-	return (numChars);
+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
+	return;
 }
 
-/* scan for the sequence $<data>#<checksum> */
-static void
-getpacket(char *buffer)
+static int kgdb_breakpoint (struct pt_regs *regs)
 {
-	unsigned char checksum;
-	unsigned char xmitcsum;
-	int i;
-	int count;
-	unsigned char ch;
+	extern atomic_t kgdb_setting_breakpoint;
 
-	do {
-		/* wait around for the start character, ignore all other
-		 * characters */
-		while ((ch = (getDebugChar() & 0x7f)) != '$') ;
+	(*linux_debug_hook) (0, SIGTRAP, 0, regs);
 
-		checksum = 0;
-		xmitcsum = -1;
-
-		count = 0;
+	if (atomic_read (&kgdb_setting_breakpoint))
+		regs->nip += 4;
 
-		/* now, read until a # or end of buffer is found */
-		while (count < BUFMAX) {
-			ch = getDebugChar() & 0x7f;
-			if (ch == '#')
-				break;
-			checksum = checksum + ch;
-			buffer[count] = ch;
-			count = count + 1;
-		}
-
-		if (count >= BUFMAX)
-			continue;
-
-		buffer[count] = 0;
-
-		if (ch == '#') {
-			xmitcsum = hex(getDebugChar() & 0x7f) << 4;
-			xmitcsum |= hex(getDebugChar() & 0x7f);
-			if (checksum != xmitcsum)
-				putDebugChar('-');	/* failed checksum */
-			else {
-				putDebugChar('+'); /* successful transfer */
-				/* if a sequence char is present, reply the ID */
-				if (buffer[2] == ':') {
-					putDebugChar(buffer[0]);
-					putDebugChar(buffer[1]);
-					/* remove sequence chars from buffer */
-					count = strlen(buffer);
-					for (i=3; i <= count; i++)
-						buffer[i-3] = buffer[i];
-				}
-			}
-		}
-	} while (checksum != xmitcsum);
+	return 1;
 }
 
-/* send the packet in buffer. */
-static void putpacket(unsigned char *buffer)
+static int kgdb_singlestep (struct pt_regs *regs)
 {
-	unsigned char checksum;
-	int count;
-	unsigned char ch, recv;
-
-	/* $<packet info>#<checksum>. */
-	do {
-		putDebugChar('$');
-		checksum = 0;
-		count = 0;
-
-		while ((ch = buffer[count])) {
-			putDebugChar(ch);
-			checksum += ch;
-			count += 1;
-		}
-
-		putDebugChar('#');
-		putDebugChar(hexchars[checksum >> 4]);
-		putDebugChar(hexchars[checksum & 0xf]);
-		recv = getDebugChar();
-	} while ((recv & 0x7f) != '+');
+	(*linux_debug_hook) (0, SIGTRAP, 0, regs);
+	return 1;
 }
 
-static void kgdb_flush_cache_all(void)
+int kgdb_iabr_match(struct pt_regs *regs)
 {
-	flush_instruction_cache();
+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
+	return 1;
 }
 
-/* Set up exception handlers for tracing and breakpoints
- * [could be called kgdb_init()]
- */
-void set_debug_traps(void)
+int kgdb_dabr_match(struct pt_regs *regs)
 {
-#if 0
-	unsigned char c;
-
-	save_and_cli(flags);
-
-	/* In case GDB is started before us, ack any packets (presumably
-	 * "$?#xx") sitting there.
-	 *
-	 * I've found this code causes more problems than it solves,
-	 * so that's why it's commented out.  GDB seems to work fine
-	 * now starting either before or after the kernel   -bwb
-	 */
-
-	while((c = getDebugChar()) != '$');
-	while((c = getDebugChar()) != '#');
-	c = getDebugChar(); /* eat first csum byte */
-	c = getDebugChar(); /* eat second csum byte */
-	putDebugChar('+'); /* ack it */
-#endif
-	debugger = kgdb;
-	debugger_bpt = kgdb_bpt;
-	debugger_sstep = kgdb_sstep;
-	debugger_iabr_match = kgdb_iabr_match;
-	debugger_dabr_match = kgdb_dabr_match;
-
-	initialized = 1;
+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
+	return 1;
 }
 
-static void kgdb_fault_handler(struct pt_regs *regs)
+int kgdb_arch_init (void)
 {
-	kgdb_longjmp((long*)fault_jmp_buf, 1);
-}
+	debugger = kgdb_debugger;
+	debugger_bpt = kgdb_breakpoint;
+	debugger_sstep = kgdb_singlestep;
+	debugger_iabr_match = kgdb_iabr_match;
+	debugger_dabr_match = kgdb_dabr_match;
 
-int kgdb_bpt(struct pt_regs *regs)
-{
-	return handle_exception(regs);
+	return 0;
+	
 }
 
-int kgdb_sstep(struct pt_regs *regs)
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 {
-	return handle_exception(regs);
-}
+	int reg;
+	unsigned long *ptr = gdb_regs;
 
-void kgdb(struct pt_regs *regs)
-{
-	handle_exception(regs);
-}
+	memset(gdb_regs, 0, MAXREG*4);
 
-int kgdb_iabr_match(struct pt_regs *regs)
-{
-	printk(KERN_ERR "kgdb doesn't support iabr, what?!?\n");
-	return handle_exception(regs);
-}
+	for (reg = 0; reg < 32; reg++)
+		*(ptr++) = regs->gpr[reg];
 
-int kgdb_dabr_match(struct pt_regs *regs)
-{
-	printk(KERN_ERR "kgdb doesn't support dabr, what?!?\n");
-	return handle_exception(regs);
-}
+	for (reg = 0; reg < 64; reg++)
+		*(ptr++) = 0;
 
-/* Convert the hardware trap type code to a unix signal number. */
-/*
- * This table contains the mapping between PowerPC hardware trap types, and
- * signals, which are primarily what GDB understands.
- */
-static struct hard_trap_info
-{
-	unsigned int tt;		/* Trap type code for powerpc */
-	unsigned char signo;		/* Signal that we map this trap into */
-} hard_trap_info[] = {
-#if defined(CONFIG_40x)
-	{ 0x100, SIGINT  },		/* critical input interrupt */
-	{ 0x200, SIGSEGV },		/* machine check */
-	{ 0x300, SIGSEGV },		/* data storage */
-	{ 0x400, SIGBUS  },		/* instruction storage */
-	{ 0x500, SIGINT  },		/* interrupt */
-	{ 0x600, SIGBUS  },		/* alignment */
-	{ 0x700, SIGILL  },		/* program */
-	{ 0x800, SIGILL  },		/* reserved */
-	{ 0x900, SIGILL  },		/* reserved */
-	{ 0xa00, SIGILL  },		/* reserved */
-	{ 0xb00, SIGILL  },		/* reserved */
-	{ 0xc00, SIGCHLD },		/* syscall */
-	{ 0xd00, SIGILL  },		/* reserved */
-	{ 0xe00, SIGILL  },		/* reserved */
-	{ 0xf00, SIGILL  },		/* reserved */
-	/*
-	** 0x1000  PIT
-	** 0x1010  FIT
-	** 0x1020  watchdog
-	** 0x1100  data TLB miss
-	** 0x1200  instruction TLB miss
-	*/
-	{ 0x2000, SIGTRAP},		/* debug */
-#else
-	{ 0x200, SIGSEGV },		/* machine check */
-	{ 0x300, SIGSEGV },		/* address error (store) */
-	{ 0x400, SIGBUS },		/* instruction bus error */
-	{ 0x500, SIGINT },		/* interrupt */
-	{ 0x600, SIGBUS },		/* alingment */
-	{ 0x700, SIGTRAP },		/* breakpoint trap */
-	{ 0x800, SIGFPE },		/* fpu unavail */
-	{ 0x900, SIGALRM },		/* decrementer */
-	{ 0xa00, SIGILL },		/* reserved */
-	{ 0xb00, SIGILL },		/* reserved */
-	{ 0xc00, SIGCHLD },		/* syscall */
-	{ 0xd00, SIGTRAP },		/* single-step/watch */
-	{ 0xe00, SIGFPE },		/* fp assist */
-#endif
-	{ 0, 0}				/* Must be last */
+	*(ptr++) = regs->nip;
+	*(ptr++) = regs->msr;
+	*(ptr++) = regs->ccr;
+	*(ptr++) = regs->link;
+	*(ptr++) = regs->ctr;
+	*(ptr++) = regs->xer;
 
-};
+	return;
+}	/* regs_to_gdb_regs */
 
-static int computeSignal(unsigned int tt)
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
 {
-	struct hard_trap_info *ht;
+	struct pt_regs *regs = (struct pt_regs *) (p->thread.ksp +
+	                                           STACK_FRAME_OVERHEAD);
+	int reg;
+	unsigned long *ptr = gdb_regs;
 
-	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
-		if (ht->tt == tt)
-			return ht->signo;
+	memset(gdb_regs, 0, MAXREG*4);
 
-	return SIGHUP; /* default for things we don't know about */
-}
+	/* Regs GPR0-2 */
+	for (reg = 0; reg < 3; reg++)
+		*(ptr++) = regs->gpr[reg];
 
-#define PC_REGNUM 64
-#define SP_REGNUM 1
+	/* Regs GPR3-13 are not saved */
+	for (reg = 3; reg < 14; reg++)
+		*(ptr++) = 0;
 
-/*
- * This function does all command processing for interfacing to gdb.
- */
-static int
-handle_exception (struct pt_regs *regs)
-{
-	int sigval;
-	int addr;
-	int length;
-	char *ptr;
-	unsigned int msr;
+	/* Regs GPR14-31 */
+	for (reg = 14; reg < 32; reg++)
+		*(ptr++) = regs->gpr[reg];
 
-	/* We don't handle user-mode breakpoints. */
-	if (user_mode(regs))
-		return 0;
-
-	if (debugger_fault_handler) {
-		debugger_fault_handler(regs);
-		panic("kgdb longjump failed!\n");
-	}
-	if (kgdb_active) {
-		printk(KERN_ERR "interrupt while in kgdb, returning\n");
-		return 0;
-	}
+	for (reg = 0; reg < 64; reg++)
+		*(ptr++) = 0;
 
-	kgdb_active = 1;
-	kgdb_started = 1;
+	*(ptr++) = regs->nip;
+	*(ptr++) = regs->msr;
+	*(ptr++) = regs->ccr;
+	*(ptr++) = regs->link;
+	*(ptr++) = regs->ctr;
+	*(ptr++) = regs->xer;
 
-#ifdef KGDB_DEBUG
-	printk("kgdb: entering handle_exception; trap [0x%x]\n",
-			(unsigned int)regs->trap);
-#endif
+	return;
+}
 
-	kgdb_interruptible(0);
-	lock_kernel();
-	msr = mfmsr();
-	mtmsr(msr & ~MSR_EE);	/* disable interrupts */
+void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	int reg;
+	unsigned long *ptr = gdb_regs;
 
-	if (regs->nip == (unsigned long)breakinst) {
-		/* Skip over breakpoint trap insn */
-		regs->nip += 4;
-	}
+	for (reg = 0; reg < 32; reg++)
+		regs->gpr[reg] = *(ptr++);
 
-	/* reply to host that an exception has occurred */
-	sigval = computeSignal(regs->trap);
-	ptr = remcomOutBuffer;
+	for (reg = 0; reg < 64; reg++)
+		ptr++;
 
-#if defined(CONFIG_40x)
-	*ptr++ = 'S';
-	*ptr++ = hexchars[sigval >> 4];
-	*ptr++ = hexchars[sigval & 0xf];
-#else
-	*ptr++ = 'T';
-	*ptr++ = hexchars[sigval >> 4];
-	*ptr++ = hexchars[sigval & 0xf];
-	*ptr++ = hexchars[PC_REGNUM >> 4];
-	*ptr++ = hexchars[PC_REGNUM & 0xf];
-	*ptr++ = ':';
-	ptr = mem2hex((char *)&regs->nip, ptr, 4);
-	*ptr++ = ';';
-	*ptr++ = hexchars[SP_REGNUM >> 4];
-	*ptr++ = hexchars[SP_REGNUM & 0xf];
-	*ptr++ = ':';
-	ptr = mem2hex(((char *)regs) + SP_REGNUM*4, ptr, 4);
-	*ptr++ = ';';
-#endif
+	regs->nip = *(ptr++);
+	regs->msr = *(ptr++);
+	regs->ccr = *(ptr++);
+	regs->link = *(ptr++);
+	regs->ctr = *(ptr++);
+	regs->xer = *(ptr++);
 
-	*ptr++ = 0;
+	return;
+}	/* gdb_regs_to_regs */
 
-	putpacket(remcomOutBuffer);
-	if (kdebug)
-		printk("remcomOutBuffer: %s\n", remcomOutBuffer);
-
-	/* XXX We may want to add some features dealing with poking the
-	 * XXX page tables, ... (look at sparc-stub.c for more info)
-	 * XXX also required hacking to the gdb sources directly...
-	 */
-
-	while (1) {
-		remcomOutBuffer[0] = 0;
-
-		getpacket(remcomInBuffer);
-		switch (remcomInBuffer[0]) {
-		case '?': /* report most recent signal */
-			remcomOutBuffer[0] = 'S';
-			remcomOutBuffer[1] = hexchars[sigval >> 4];
-			remcomOutBuffer[2] = hexchars[sigval & 0xf];
-			remcomOutBuffer[3] = 0;
-			break;
-#if 0
-		case 'q': /* this screws up gdb for some reason...*/
+/*
+ * This function does PoerPC specific procesing for interfacing to gdb.
+ */
+int kgdb_arch_handle_exception (int vector, int signo, int err_code,
+		char *remcomInBuffer, char *remcomOutBuffer,
+		struct pt_regs *linux_regs)
+{
+	char *ptr;
+	unsigned long addr;
+	
+	switch (remcomInBuffer[0])
 		{
-			extern long _start, sdata, __bss_start;
-
-			ptr = &remcomInBuffer[1];
-			if (strncmp(ptr, "Offsets", 7) != 0)
+		/*
+		 * sAA..AA   Step one instruction from AA..AA 
+		 * This will return an error to gdb ..
+		 */
+		case 's':
+		case 'c':
+			if (kgdb_contthread && kgdb_contthread != current)
+			{
+				strcpy(remcomOutBuffer, "E00");
 				break;
-
-			ptr = remcomOutBuffer;
-			sprintf(ptr, "Text=%8.8x;Data=%8.8x;Bss=%8.8x",
-				&_start, &sdata, &__bss_start);
-			break;
-		}
-#endif
-		case 'd':
-			/* toggle debug flag */
-			kdebug ^= 1;
-			break;
-
-		case 'g':	/* return the value of the CPU registers.
-				 * some of them are non-PowerPC names :(
-				 * they are stored in gdb like:
-				 * struct {
-				 *     u32 gpr[32];
-				 *     f64 fpr[32];
-				 *     u32 pc, ps, cnd, lr; (ps=msr)
-				 *     u32 cnt, xer, mq;
-				 * }
-				 */
-		{
-			int i;
-			ptr = remcomOutBuffer;
-			/* General Purpose Regs */
-			ptr = mem2hex((char *)regs, ptr, 32 * 4);
-			/* Floating Point Regs - FIXME */
-			/*ptr = mem2hex((char *), ptr, 32 * 8);*/
-			for(i=0; i<(32*8*2); i++) { /* 2chars/byte */
-				ptr[i] = '0';
 			}
-			ptr += 32*8*2;
-			/* pc, msr, cr, lr, ctr, xer, (mq is unused) */
-			ptr = mem2hex((char *)&regs->nip, ptr, 4);
-			ptr = mem2hex((char *)&regs->msr, ptr, 4);
-			ptr = mem2hex((char *)&regs->ccr, ptr, 4);
-			ptr = mem2hex((char *)&regs->link, ptr, 4);
-			ptr = mem2hex((char *)&regs->ctr, ptr, 4);
-			ptr = mem2hex((char *)&regs->xer, ptr, 4);
-		}
-			break;
 
-		case 'G': /* set the value of the CPU registers */
-		{
-			ptr = &remcomInBuffer[1];
-
-			/*
-			 * If the stack pointer has moved, you should pray.
-			 * (cause only god can help you).
-			 */
-
-			/* General Purpose Regs */
-			hex2mem(ptr, (char *)regs, 32 * 4);
-
-			/* Floating Point Regs - FIXME?? */
-			/*ptr = hex2mem(ptr, ??, 32 * 8);*/
-			ptr += 32*8*2;
-
-			/* pc, msr, cr, lr, ctr, xer, (mq is unused) */
-			ptr = hex2mem(ptr, (char *)&regs->nip, 4);
-			ptr = hex2mem(ptr, (char *)&regs->msr, 4);
-			ptr = hex2mem(ptr, (char *)&regs->ccr, 4);
-			ptr = hex2mem(ptr, (char *)&regs->link, 4);
-			ptr = hex2mem(ptr, (char *)&regs->ctr, 4);
-			ptr = hex2mem(ptr, (char *)&regs->xer, 4);
-
-			strcpy(remcomOutBuffer,"OK");
-		}
-			break;
-		case 'H':
-			/* don't do anything, yet, just acknowledge */
-			hexToInt(&ptr, &addr);
-			strcpy(remcomOutBuffer,"OK");
-			break;
-
-		case 'm':	/* mAA..AA,LLLL  Read LLLL bytes at address AA..AA */
-				/* Try to read %x,%x.  */
-
-			ptr = &remcomInBuffer[1];
-
-			if (hexToInt(&ptr, &addr) && *ptr++ == ','
-					&& hexToInt(&ptr, &length)) {
-				if (mem2hex((char *)addr, remcomOutBuffer,
-							length))
-					break;
-				strcpy(remcomOutBuffer, "E03");
-			} else
-				strcpy(remcomOutBuffer, "E01");
-			break;
-
-		case 'M': /* MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK */
-			/* Try to read '%x,%x:'.  */
-
-			ptr = &remcomInBuffer[1];
-
-			if (hexToInt(&ptr, &addr) && *ptr++ == ','
-					&& hexToInt(&ptr, &length)
-					&& *ptr++ == ':') {
-				if (hex2mem(ptr, (char *)addr, length))
-					strcpy(remcomOutBuffer, "OK");
-				else
-					strcpy(remcomOutBuffer, "E03");
-				flush_icache_range(addr, addr+length);
-			} else
-				strcpy(remcomOutBuffer, "E02");
-			break;
-
-
-		case 'k': /* kill the program, actually just continue */
-		case 'c': /* cAA..AA  Continue; address AA..AA optional */
-			/* try to read optional parameter, pc unchanged if no parm */
+			kgdb_contthread = NULL;
 
+			/* handle the optional parameter */
 			ptr = &remcomInBuffer[1];
-			if (hexToInt(&ptr, &addr))
-				regs->nip = addr;
-
-/* Need to flush the instruction cache here, as we may have deposited a
- * breakpoint, and the icache probably has no way of knowing that a data ref to
- * some location may have changed something that is in the instruction cache.
- */
-			kgdb_flush_cache_all();
-#if defined(CONFIG_40x)
-			strcpy(remcomOutBuffer, "OK");
-			putpacket(remcomOutBuffer);
-#endif
-			mtmsr(msr);
-
-			kgdb_interruptible(1);
-			unlock_kernel();
-			kgdb_active = 0;
-			if (kdebug) {
-				printk("remcomInBuffer: %s\n", remcomInBuffer);
-				printk("remcomOutBuffer: %s\n", remcomOutBuffer);
-			}
-			return 1;
+			if (kgdb_hexToLong (&ptr, &addr))
+				linux_regs->nip = addr;
 
-		case 's':
-			kgdb_flush_cache_all();
-#if defined(CONFIG_40x)
-			regs->msr |= MSR_DE;
-			regs->dbcr0 |= (DBCR0_IDM | DBCR0_IC);
-			mtmsr(msr);
+			/* set the trace bit if we're stepping */
+			if (remcomInBuffer[0] == 's')
+			{
+#if defined (CONFIG_4xx)
+				linux_regs->msr |= MSR_DE;
+				current->thread.dbcr0 |= (DBCR_IDM | DBCR_IC);
 #else
-			regs->msr |= MSR_SE;
+				linux_regs->msr |= MSR_SE;
 #endif
-			unlock_kernel();
-			kgdb_active = 0;
-			if (kdebug) {
-				printk("remcomInBuffer: %s\n", remcomInBuffer);
-				printk("remcomOutBuffer: %s\n", remcomOutBuffer);
 			}
-			return 1;
-
-		case 'r':		/* Reset (if user process..exit ???)*/
-			panic("kgdb reset.");
-			break;
-		}			/* switch */
-		if (remcomOutBuffer[0] && kdebug) {
-			printk("remcomInBuffer: %s\n", remcomInBuffer);
-			printk("remcomOutBuffer: %s\n", remcomOutBuffer);
-		}
-		/* reply to the request */
-		putpacket(remcomOutBuffer);
-	} /* while(1) */
-}
-
-/* This function will generate a breakpoint exception.  It is used at the
-   beginning of a program to sync up with a debugger and can be used
-   otherwise as a quick means to stop program execution and "break" into
-   the debugger. */
-
-void
-breakpoint(void)
-{
-	if (!initialized) {
-		printk("breakpoint() called b4 kgdb init\n");
-		return;
+			return 0;
 	}
 
-	asm("	.globl breakinst	\n\
-	     breakinst: .long 0x7d821008");
+	return -1;
 }
 
-#ifdef CONFIG_KGDB_CONSOLE
-/* Output string in GDB O-packet format if GDB has connected. If nothing
-   output, returns 0 (caller must then handle output). */
-int
-kgdb_output_string (const char* s, unsigned int count)
+/*
+ * Global data
+ */
+struct kgdb_arch arch_kgdb_ops =
 {
-	char buffer[512];
-
-	if (!kgdb_started)
-		return 0;
+	.gdb_bpt_instr = { 0x7d, 0x82, 0x10, 0x08 },
+};
 
-	count = (count <= (sizeof(buffer) / 2 - 2))
-		? count : (sizeof(buffer) / 2 - 2);
+static void kgdbppc_write_char(int chr)
+{
+	putDebugChar(chr);
+}
 
-	buffer[0] = 'O';
-	mem2hex (s, &buffer[1], count);
-	putpacket(buffer);
+static int kgdbppc_read_char(void)
+{
+	return getDebugChar();
+}
 
-	return 1;
+int     kgdbppc_hook(void)
+{
+	kgdb_map_scc();
+	return 0;
 }
+
+struct kgdb_serial kgdbppc_serial = {
+	.read_char = kgdbppc_read_char,
+	.write_char = kgdbppc_write_char,
+	.hook = kgdbppc_hook
+};
+
+void kgdbppc_init(void)
+{
+	/* If we have the bigger 8250 serial driver, set that to be
+	 * the output now. */
+#ifdef CONFIG_KGDB_8250
+        extern struct kgdb_serial kgdb8250_serial_driver;
+        kgdb_serial = &kgdb8250_serial_driver;
+#else
+	/* Take our serial driver. */
+	kgdb_serial = &kgdbppc_serial;
 #endif
+}
Index: linux-2.6.3-kgdb/arch/ppc/kernel/setup.c
===================================================================
--- linux-2.6.3-kgdb.orig/arch/ppc/kernel/setup.c	2004-02-19 13:36:00.000000000 +0530
+++ linux-2.6.3-kgdb/arch/ppc/kernel/setup.c	2004-02-19 14:09:29.849889608 +0530
@@ -643,15 +643,7 @@
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: enter", 0x3eab);
 
 #if defined(CONFIG_KGDB)
-	if (ppc_md.kgdb_map_scc)
-		ppc_md.kgdb_map_scc();
-	set_debug_traps();
-	if (strstr(cmd_line, "gdb")) {
-		if (ppc_md.progress)
-			ppc_md.progress("setup_arch: kgdb breakpoint", 0x4000);
-		printk("kgdb breakpoint activated\n");
-		breakpoint();
-	}
+	kgdbppc_init();
 #endif
 
 	/*
Index: linux-2.6.3-kgdb/arch/ppc/mm/fault.c
===================================================================
--- linux-2.6.3-kgdb.orig/arch/ppc/mm/fault.c	2004-02-19 13:36:00.000000000 +0530
+++ linux-2.6.3-kgdb/arch/ppc/mm/fault.c	2004-02-19 14:09:29.858888240 +0530
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
+#include <linux/debugger.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -139,6 +140,13 @@
 		bad_page_fault(regs, address, SIGSEGV);
 		return;
 	}
+
+	if (debugger_memerr_expected) {
+		/* This fault was caused by memory access through a debugger.
+		 * Don't handle it like user accesses */
+		goto no_context;
+	}
+
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -293,6 +301,7 @@
 		return;
 	}
 
+no_context:
 	bad_page_fault(regs, address, SIGSEGV);
 	return;
 
@@ -342,10 +351,13 @@
 	}
 
 	/* kernel has accessed a bad area */
-#if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
+#if defined(CONFIG_XMON)
 	if (debugger_kernel_faults)
 		debugger(regs);
 #endif
+
+	CHK_DEBUGGER(14, sig,0, regs,)
+
 	die("kernel access of bad area", regs, sig);
 }
 
Index: linux-2.6.3-kgdb/arch/ppc/platforms/sandpoint.c
===================================================================
--- linux-2.6.3-kgdb.orig/arch/ppc/platforms/sandpoint.c	2004-02-19 13:36:00.000000000 +0530
+++ linux-2.6.3-kgdb/arch/ppc/platforms/sandpoint.c	2004-02-19 14:09:29.867886872 +0530
@@ -252,38 +252,6 @@
 	return;
 }
 
-#if defined(CONFIG_SERIAL_8250) && \
-	(defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG))
-static void __init
-sandpoint_early_serial_map(void)
-{
-	struct uart_port serial_req;
-
-	/* Setup serial port access */
-	memset(&serial_req, 0, sizeof(serial_req));
-	serial_req.uartclk = UART_CLK;
-	serial_req.irq = 4;
-	serial_req.flags = STD_COM_FLAGS;
-	serial_req.iotype = SERIAL_IO_MEM;
-	serial_req.membase = (u_char *)SANDPOINT_SERIAL_0;
-
-	gen550_init(0, &serial_req);
-
-	if (early_serial_setup(&serial_req) != 0)
-		printk(KERN_ERR "Early serial init of port 0 failed\n");
-
-	/* Assume early_serial_setup() doesn't modify serial_req */
-	serial_req.line = 1;
-	serial_req.irq = 3; /* XXXX */
-	serial_req.membase = (u_char *)SANDPOINT_SERIAL_1;
-
-	gen550_init(1, &serial_req);
-
-	if (early_serial_setup(&serial_req) != 0)
-		printk(KERN_ERR "Early serial init of port 1 failed\n");
-}
-#endif
-
 static void __init
 sandpoint_setup_arch(void)
 {

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
