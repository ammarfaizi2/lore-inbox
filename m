Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbTEaLv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 07:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTEaLv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 07:51:57 -0400
Received: from ns.suse.de ([213.95.15.193]:45577 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264298AbTEaLvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 07:51:53 -0400
Date: Sat, 31 May 2003 14:05:14 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] Exception trace for i386, mark II
Message-ID: <20030531120514.GA11898@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a new implementation of exception trace for i386.

It adds a new exception-trace sysctl (default to off), which when enabled
triggers printk for unhandled fault signals (SIGSEGV etc.).  This is 
very useful to catch silent segfaults, e.g. from programs who run 
in unwritable directories and cannot coredump. It's also very useful
for running LTP. In general it gives you an early warning when something
is wrong with your system.

It won't trigger on intentional signal users who catch the signal or
when an debugger is active.  This also makes the similar facility which
has been in amd64 for a long time switchable using the sysctl. The default 
behaviour does not change.

-Andi


Index: linux/arch/i386/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/traps.c,v
retrieving revision 1.62
diff -u -u -r1.62 traps.c
--- linux/arch/i386/kernel/traps.c	30 May 2003 20:11:26 -0000	1.62
+++ linux/arch/i386/kernel/traps.c	31 May 2003 10:24:21 -0000
@@ -53,6 +53,8 @@
 
 #include "mach_traps.h"
 
+extern int exception_trace;
+
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
@@ -303,6 +305,13 @@
 
 	trap_signal: {
 		struct task_struct *tsk = current;
+
+		if (exception_trace && !(tsk->flags & PT_PTRACED) && 
+		    (tsk->sighand->action[signr-1].sa.sa_handler == SIG_IGN ||
+		     (tsk->sighand->action[signr-1].sa.sa_handler == SIG_DFL)))   
+			printk(KERN_INFO "%s[%d] trap %s at eip:%lx esp:%lx err:%lx\n",
+		       tsk->comm, tsk->pid, str, regs->eip, regs->esp, error_code);
+			
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_no = trapnr;
 		if (info)
@@ -372,15 +381,22 @@
 
 asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
 {
+	struct task_struct *tsk = current;
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
 
 	if (!(regs->xcs & 3))
 		goto gp_in_kernel;
 
-	current->thread.error_code = error_code;
-	current->thread.trap_no = 13;
-	force_sig(SIGSEGV, current);
+	if (exception_trace && !(tsk->flags & PT_PTRACED) && 
+	    (tsk->sighand->action[SIGSEGV-1].sa.sa_handler == SIG_IGN ||
+	     (tsk->sighand->action[SIGSEGV-1].sa.sa_handler == SIG_DFL)))
+		printk(KERN_INFO "%s[%d] gpf at eip:%lx esp:%lx err:%lx\n",
+		       tsk->comm, tsk->pid, regs->eip, regs->esp, error_code);
+	
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_no = 13;
+	force_sig(SIGSEGV, tsk);
 	return;
 
 gp_in_vm86:
Index: linux/arch/i386/mm/fault.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/mm/fault.c,v
retrieving revision 1.35
diff -u -u -r1.35 fault.c
--- linux/arch/i386/mm/fault.c	30 May 2003 20:10:34 -0000	1.35
+++ linux/arch/i386/mm/fault.c	31 May 2003 10:24:21 -0000
@@ -57,6 +57,8 @@
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 
+int exception_trace;
+
 /*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
@@ -200,6 +202,15 @@
 
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
+
+		if (exception_trace && !(tsk->flags & PT_PTRACED) && 
+		    (tsk->sighand->action[SIGSEGV-1].sa.sa_handler == SIG_IGN ||
+		    (tsk->sighand->action[SIGSEGV-1].sa.sa_handler == SIG_DFL)))
+			printk(KERN_INFO 
+		       "%s[%d] segfault at eip:%lx esp:%lx adr:%lx err:%lx\n",
+		       tsk->comm, tsk->pid, regs->eip, regs->esp, address, 
+		       error_code);
+
 		tsk->thread.cr2 = address;
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_no = 14;
Index: linux/include/linux/sysctl.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/linux/sysctl.h,v
retrieving revision 1.52
diff -u -u -r1.52 sysctl.h
--- linux/include/linux/sysctl.h	30 May 2003 20:12:50 -0000	1.52
+++ linux/include/linux/sysctl.h	31 May 2003 10:24:25 -0000
@@ -130,6 +130,7 @@
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
+	KERN_EXCEPTION_TRACE=58, /* int: log user traps in kernel log */
 };
 
 
Index: linux/kernel/sysctl.c
===================================================================
RCS file: /home/cvs/linux-2.5/kernel/sysctl.c,v
retrieving revision 1.50
diff -u -u -r1.50 sysctl.c
--- linux/kernel/sysctl.c	30 May 2003 20:11:11 -0000	1.50
+++ linux/kernel/sysctl.c	31 May 2003 10:24:26 -0000
@@ -57,6 +57,7 @@
 extern int cad_pid;
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
+extern int exception_trace;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -265,6 +266,10 @@
 	 0600, NULL, &proc_dointvec},
 	{KERN_PANIC_ON_OOPS,"panic_on_oops",
 	 &panic_on_oops,sizeof(int),0644,NULL,&proc_dointvec},
+#ifdef CONFIG_X86
+	{KERN_EXCEPTION_TRACE,"exception_trace",
+	 &exception_trace,sizeof(int),0644,NULL,&proc_dointvec},
+#endif
 	{0}
 };
 
