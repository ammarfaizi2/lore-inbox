Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbULCTnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbULCTnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbULCTbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:31:48 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:16388
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262474AbULCT2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:28:17 -0500
Message-Id: <200412032144.iB3LiHZW004693@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - system call restart fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:44:17 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser:

The implementation of sys_sigreturn() and sys_rt_sigreturn() in UML
must be changed.
This is necessary, since the return value of sys_*_sigreturn()
is the value of eax in the thread, that was interrupted by the
signal handler. If accidentaly eax contains -ERESTART_*, orig_eax
*must* be -1 to avoid syscall restart processing in kern_do_signal().
If orig_eax is >=0, eip might be lowered by 2, the process will fail.
In UML PT_REGS_SYSCALL_NR() or UPT_SYSCALL_NR() have to be used
instead of orig_eax.

While writing and testing an exploit for this, I saw that for most
interrupts, the syscall number is undefined. So even on a return from
interrupt a wrong syscall restart handling could happen.

And also: UML resumes a process with ptrace(PTRACE_SYSCALL/SYSEMU/SINGLESTEP
when a syscall in UML in SKAS mode has been processed. But since there
is a valid syscall number in the host's orig_eax, the host could do
a wrong syscall restarting if the syscall in UML was a sigreturn() returning
-ERESTART* To avoid this, in SKAS -1 should be written to regs.orig_eax
before restore_registers().

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/process.c	2004-12-01 23:47:11.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/process.c	2004-12-01 23:51:51.000000000 -0500
@@ -63,7 +63,8 @@
 {
 	int err, status;
 
-	UPT_SYSCALL_NR(regs) = PT_SYSCALL_NR(regs->skas.regs);
+	/* Mark this as a syscall */
+	UPT_SYSCALL_NR(regs) = PT_SYSCALL_NR(regs->skas.regs); 
 
 	if (!local_using_sysemu)
 	{
@@ -160,6 +161,7 @@
 
 		regs->skas.is_user = 1;
 		save_registers(regs);
+		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
 
 		if(WIFSTOPPED(status)){
 		  	switch(WSTOPSIG(status)){
@@ -170,7 +172,6 @@
 			        handle_trap(pid, regs, local_using_sysemu);
 				break;
 			case SIGTRAP:
-				UPT_SYSCALL_NR(regs) = -1;
 				relay_signal(SIGTRAP, regs);
 				break;
 			case SIGIO:
@@ -186,6 +187,9 @@
 				       "%d\n", WSTOPSIG(status));
 			}
 			interrupt_end();
+
+			/* Avoid -ERESTARTSYS handling in host */
+			PT_SYSCALL_NR(regs->skas.regs) = -1;
 		}
 
 		restore_registers(regs);
Index: 2.6.9/arch/um/kernel/tt/tracer.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/tracer.c	2004-12-01 23:47:37.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/tracer.c	2004-12-01 23:51:02.000000000 -0500
@@ -303,6 +303,10 @@
 			tracing = is_tracing(task);
 			old_tracing = tracing;
 
+			/* Assume: no syscall, when coming from user */
+			if ( tracing )
+				do_sigtrap(task);
+
 			local_using_sysemu = get_using_sysemu();
 			pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
 
@@ -354,7 +358,6 @@
 					continue;
 				}
 				tracing = 0;
-				do_sigtrap(task);
 				break;
 			case SIGPROF:
 				if(tracing) sig = 0;
Index: 2.6.9/arch/um/sys-i386/signal.c
===================================================================
--- 2.6.9.orig/arch/um/sys-i386/signal.c	2004-12-01 23:42:59.000000000 -0500
+++ 2.6.9/arch/um/sys-i386/signal.c	2004-12-01 23:51:02.000000000 -0500
@@ -324,6 +324,8 @@
 	if(copy_sc_from_user(&current->thread.regs, sc))
 		goto segfault;
 
+	/* Avoid ERESTART handling */
+	PT_REGS_SYSCALL_NR(&current->thread.regs) = -1;
 	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
 
  segfault:
@@ -352,6 +354,8 @@
 	if(copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext))
 		goto segfault;
 
+	/* Avoid ERESTART handling */
+	PT_REGS_SYSCALL_NR(&current->thread.regs) = -1;
 	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
 
  segfault:

