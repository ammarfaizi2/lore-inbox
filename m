Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVG0P6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVG0P6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVG0PzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:55:25 -0400
Received: from [151.97.230.9] ([151.97.230.9]:17282 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S262422AbVG0PxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:53:08 -0400
Subject: [patch 2/4] Uml support: reorganize PTRACE_SYSEMU support
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       bstroesser@fujitsu-siemens.com
From: blaisorblade@yahoo.it
Date: Tue, 26 Jul 2005 20:43:49 +0200
Message-Id: <20050726184349.53E4D21DC1C@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

With this patch, we change the way we handle switching from PTRACE_SYSEMU to
PTRACE_{SINGLESTEP,SYSCALL}, to free TIF_SYSCALL_EMU from double use as a
preparation for PTRACE_SYSEMU_SINGLESTEP extension, without changing the
behavior of the host kernel.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/kernel/entry.S  |    8 ++++
 linux-2.6.git-paolo/arch/i386/kernel/ptrace.c |   43 ++++++++------------------
 2 files changed, 21 insertions(+), 30 deletions(-)

diff -puN arch/i386/kernel/entry.S~sysemu-reorganize arch/i386/kernel/entry.S
--- linux-2.6.git/arch/i386/kernel/entry.S~sysemu-reorganize	2005-07-26 20:25:58.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/entry.S	2005-07-26 20:25:58.000000000 +0200
@@ -339,12 +339,18 @@ syscall_trace_entry:
 	xorl %edx,%edx
 	call do_syscall_trace
 	cmpl $0, %eax
-	jne syscall_exit		# ret != 0 -> running under PTRACE_SYSEMU,
+	jne syscall_skip		# ret != 0 -> running under PTRACE_SYSEMU,
 					# so must skip actual syscall
 	movl ORIG_EAX(%esp), %eax
 	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
 	jmp syscall_exit
+syscall_skip:
+	cli				# make sure we don't miss an interrupt
+					# setting need_resched or sigpending
+					# between sampling and the iret
+	movl TI_flags(%ebp), %ecx
+	jmp work_pending
 
 	# perform syscall exit tracing
 	ALIGN
diff -puN arch/i386/kernel/ptrace.c~sysemu-reorganize arch/i386/kernel/ptrace.c
--- linux-2.6.git/arch/i386/kernel/ptrace.c~sysemu-reorganize	2005-07-26 20:25:58.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/ptrace.c	2005-07-26 20:39:57.000000000 +0200
@@ -515,21 +515,14 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if (!valid_signal(data))
 			break;
-		/* If we came here with PTRACE_SYSEMU and now continue with
-		 * PTRACE_SYSCALL, entry.S used to intercept the syscall return.
-		 * But it shouldn't!
-		 * So we don't clear TIF_SYSCALL_EMU, which is always unused in
-		 * this special case, to remember, we came from SYSEMU. That
-		 * flag will be cleared by do_syscall_trace().
-		 */
 		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-		} else if (request == PTRACE_CONT) {
-			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-		}
-		if (request == PTRACE_SYSCALL) {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		} else if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 		} else {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
 		child->exit_code = data;
@@ -558,8 +551,7 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if (!valid_signal(data))
 			break;
-		/*See do_syscall_trace to know why we don't clear
-		 * TIF_SYSCALL_EMU.*/
+		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		set_singlestep(child);
 		child->exit_code = data;
@@ -694,7 +686,7 @@ void send_sigtrap(struct task_struct *ts
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	int is_sysemu, is_systrace, is_singlestep, ret = 0;
+	int is_sysemu, is_singlestep, ret = 0;
 	/* do the secure computing check first */
 	secure_computing(regs->orig_eax);
 
@@ -705,25 +697,13 @@ int do_syscall_trace(struct pt_regs *reg
 		goto out;
 
 	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
-	is_systrace = test_thread_flag(TIF_SYSCALL_TRACE);
 	is_singlestep = test_thread_flag(TIF_SINGLESTEP);
 
-	/* We can detect the case of coming from PTRACE_SYSEMU and now running
-	 * with PTRACE_SYSCALL or PTRACE_SINGLESTEP, by TIF_SYSCALL_EMU being
-	 * set additionally.
-	 * If so let's reset the flag and return without action (no singlestep
-	 * nor syscall tracing, since no actual step has been executed).
-	 */
-	if (is_sysemu && (is_systrace || is_singlestep)) {
-		clear_thread_flag(TIF_SYSCALL_EMU);
-		goto out;
-	}
-
 	/* Fake a debug trap */
-	if (test_thread_flag(TIF_SINGLESTEP))
+	if (is_singlestep)
 		send_sigtrap(current, regs, 0);
 
-	if (!is_systrace && !is_sysemu)
+ 	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_sysemu)
 		goto out;
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
@@ -745,5 +725,10 @@ int do_syscall_trace(struct pt_regs *reg
 	if (unlikely(current->audit_context) && !entryexit)
 		audit_syscall_entry(current, AUDIT_ARCH_I386, regs->orig_eax,
 				    regs->ebx, regs->ecx, regs->edx, regs->esi);
-	return ret;
+	if (ret == 0)
+		return 0;
+
+	if (unlikely(current->audit_context))
+		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
+	return 1;
 }
_
