Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTESTPv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTESTPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:15:51 -0400
Received: from zero.aec.at ([193.170.194.10]:64520 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262930AbTESTPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:15:43 -0400
Date: Mon, 19 May 2003 21:28:14 +0200
From: Andi Kleen <ak@muc.de>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, plars@austin.ibm.com
Subject: [PATCH] Exception trace for i386
Message-ID: <20030519192814.GA975@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


x86-64 had printks for user level faults for a long time. This
proved to be very useful to trace otherwise hidden faults, e.g.
on a normal kernel there is no way to see a segfault in a process
that runs in a write protected directory, even when core dumps
are enabled. Also it's useful as an early warning that something
is wrong with your system.

There was a request to port this to i386. Done with this patch.

It is turned off by default because some programs do deliberate
segfaults (e.g. lmbench), but can be enabled with a sysctl.
int 3s are not logged because they are used gdb and debugging
becomes too noisy otherwise.

As a intended side effect this also exposes the hidden exception_trace 
variable that already exists in arch/x86_64 as sysctl.

Patch for 2.5.69-CVS

-Andi

Index: linux/arch/i386/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/traps.c,v
retrieving revision 1.54
diff -u -u -r1.54 traps.c
--- linux/arch/i386/kernel/traps.c	13 May 2003 02:56:54 -0000	1.54
+++ linux/arch/i386/kernel/traps.c	19 May 2003 18:19:33 -0000
@@ -53,6 +53,8 @@
 
 #include "mach_traps.h"
 
+extern int exception_trace;
+
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
@@ -303,6 +305,11 @@
 
 	trap_signal: {
 		struct task_struct *tsk = current;
+
+		if (exception_trace && trapnr != 3)
+			printk(KERN_INFO "%s[%d] trap %s at eip:%lx esp:%lx err:%lx\n",
+		       tsk->comm, tsk->pid, str, regs->eip, regs->esp, error_code);
+
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_no = trapnr;
 		if (info)
@@ -372,15 +379,20 @@
 
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
+	if (exception_trace)
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
retrieving revision 1.27
diff -u -u -r1.27 fault.c
--- linux/arch/i386/mm/fault.c	8 May 2003 05:19:20 -0000	1.27
+++ linux/arch/i386/mm/fault.c	19 May 2003 18:19:33 -0000
@@ -57,6 +57,8 @@
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 
+int exception_trace;
+
 /*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
@@ -200,6 +202,13 @@
 
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
+
+		if (exception_trace)
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
retrieving revision 1.43
diff -u -u -r1.43 sysctl.h
--- linux/include/linux/sysctl.h	12 May 2003 18:25:53 -0000	1.43
+++ linux/include/linux/sysctl.h	19 May 2003 18:19:38 -0000
@@ -130,6 +130,7 @@
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
+	KERN_EXCEPTION_TRACE=58, /* int: log user traps in kernel log */
 };
 
 
Index: linux/kernel/sysctl.c
===================================================================
RCS file: /home/cvs/linux-2.5/kernel/sysctl.c,v
retrieving revision 1.42
diff -u -u -r1.42 sysctl.c
--- linux/kernel/sysctl.c	12 May 2003 18:25:53 -0000	1.42
+++ linux/kernel/sysctl.c	19 May 2003 18:19:39 -0000
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
 
