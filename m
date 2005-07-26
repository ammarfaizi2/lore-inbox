Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVG0P6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVG0P6J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVG0PzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:55:16 -0400
Received: from [151.97.230.9] ([151.97.230.9]:17538 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S262429AbVG0PxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:53:08 -0400
Subject: [patch 3/4] Uml support: add PTRACE_SYSEMU_SINGLESTEP option to i386
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       bstroesser@fujitsu-siemens.com
From: blaisorblade@yahoo.it
Date: Tue, 26 Jul 2005 20:43:52 +0200
Message-Id: <20050726184352.2F0FD21DC1E@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch implements the new ptrace option PTRACE_SYSEMU_SINGLESTEP, which
can be used by UML to singlestep a process: it will receive SINGLESTEP
interceptions for normal instructions and syscalls, but syscall execution will
be skipped just like with PTRACE_SYSEMU.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/kernel/ptrace.c |   21 +++++++++++++++++----
 linux-2.6.git-paolo/include/linux/ptrace.h    |    1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/ptrace.c~sysemu-add-SYSEMU_SINGLESTEP arch/i386/kernel/ptrace.c
--- linux-2.6.git/arch/i386/kernel/ptrace.c~sysemu-add-SYSEMU_SINGLESTEP	2005-07-26 20:27:45.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/ptrace.c	2005-07-26 20:39:55.000000000 +0200
@@ -547,11 +547,17 @@ asmlinkage int sys_ptrace(long request, 
 		wake_up_process(child);
 		break;
 
+	case PTRACE_SYSEMU_SINGLESTEP: /* Same as SYSEMU, but singlestep if not syscall */
 	case PTRACE_SINGLESTEP:	/* set the trap flag. */
 		ret = -EIO;
 		if (!valid_signal(data))
 			break;
-		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+
+		if (request == PTRACE_SYSEMU_SINGLESTEP)
+			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		else
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		set_singlestep(child);
 		child->exit_code = data;
@@ -686,7 +692,10 @@ void send_sigtrap(struct task_struct *ts
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	int is_sysemu, is_singlestep, ret = 0;
+	int is_sysemu = test_thread_flag(TIF_SYSCALL_EMU), ret = 0;
+	/* With TIF_SYSCALL_EMU set we want to ignore TIF_SINGLESTEP */
+	int is_singlestep = !is_sysemu && test_thread_flag(TIF_SINGLESTEP);
+
 	/* do the secure computing check first */
 	secure_computing(regs->orig_eax);
 
@@ -696,8 +705,11 @@ int do_syscall_trace(struct pt_regs *reg
 	if (!(current->ptrace & PT_PTRACED))
 		goto out;
 
-	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
-	is_singlestep = test_thread_flag(TIF_SINGLESTEP);
+	/* If a process stops on the 1st tracepoint with SYSCALL_TRACE
+	 * and then is resumed with SYSEMU_SINGLESTEP, it will come in
+	 * here. We have to check this and return */
+	if (is_sysemu && entryexit)
+		return 0;
 
 	/* Fake a debug trap */
 	if (is_singlestep)
@@ -728,6 +740,7 @@ int do_syscall_trace(struct pt_regs *reg
 	if (ret == 0)
 		return 0;
 
+	regs->orig_eax = -1; /* force skip of syscall restarting */
 	if (unlikely(current->audit_context))
 		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
 	return 1;
diff -puN include/linux/ptrace.h~sysemu-add-SYSEMU_SINGLESTEP include/linux/ptrace.h
--- linux-2.6.git/include/linux/ptrace.h~sysemu-add-SYSEMU_SINGLESTEP	2005-07-26 20:27:45.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/ptrace.h	2005-07-26 20:27:45.000000000 +0200
@@ -21,6 +21,7 @@
 
 #define PTRACE_SYSCALL		  24
 #define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
_
