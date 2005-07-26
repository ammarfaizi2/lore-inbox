Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVG0P6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVG0P6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVG0PzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:55:10 -0400
Received: from [151.97.230.9] ([151.97.230.9]:17794 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S262431AbVG0PxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:53:09 -0400
Subject: [patch 4/4] SYSEMU: fix sysaudit / singlestep interaction
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       bstroesser@fujitsu-siemens.com, roland@redhat.com
From: blaisorblade@yahoo.it
Date: Tue, 26 Jul 2005 20:43:54 +0200
Message-Id: <20050726184354.D584D21DC20@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Roland McGrath <roland@redhat.com>

This is simply an adjustment for "Ptrace - i386: fix Syscall Audit interaction
with singlestep" to work on top of SYSEMU patches, too. On this patch, I have
some doubts: I wonder why we need to alter that way ptrace_disable().

I left the patch this way because it has been extensively tested, but I don't
understand the reason.

The current PTRACE_DETACH handling simply clears child->ptrace; actually this
is not enough because entry.S just looks at the thread_flags; actually,
do_syscall_trace checks current->ptrace but I don't think depending on that is
good, at least for performance, so I think the clearing is done elsewhere. For
instance, on PTRACE_CONT it's done, but doing PTRACE_DETACH without
PTRACE_CONT is possible (and happens when gdb crashes and one kills it
manually).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/kernel/ptrace.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/ptrace.c~sysaudit-singlestep-umlhost arch/i386/kernel/ptrace.c
--- linux-2.6.git/arch/i386/kernel/ptrace.c~sysaudit-singlestep-umlhost	2005-07-26 20:27:56.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/ptrace.c	2005-07-26 20:27:56.000000000 +0200
@@ -271,6 +271,8 @@ static void clear_singlestep(struct task
 void ptrace_disable(struct task_struct *child)
 { 
 	clear_singlestep(child);
+	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 }
 
 /*
@@ -693,14 +695,29 @@ __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
 	int is_sysemu = test_thread_flag(TIF_SYSCALL_EMU), ret = 0;
-	/* With TIF_SYSCALL_EMU set we want to ignore TIF_SINGLESTEP */
+	/* With TIF_SYSCALL_EMU set we want to ignore TIF_SINGLESTEP for syscall
+	 * interception. */
 	int is_singlestep = !is_sysemu && test_thread_flag(TIF_SINGLESTEP);
 
 	/* do the secure computing check first */
 	secure_computing(regs->orig_eax);
 
-	if (unlikely(current->audit_context) && entryexit)
-		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
+	if (unlikely(current->audit_context)) {
+		if (entryexit)
+			audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
+		/* Debug traps, when using PTRACE_SINGLESTEP, must be sent only
+		 * on the syscall exit path. Normally, when TIF_SYSCALL_AUDIT is
+		 * not used, entry.S will call us only on syscall exit, not
+		 * entry; so when TIF_SYSCALL_AUDIT is used we must avoid
+		 * calling send_sigtrap() on syscall entry.
+		 *
+		 * Note that when PTRACE_SYSEMU_SINGLESTEP is used,
+		 * is_singlestep is false, despite his name, so we will still do
+		 * the correct thing.
+		 */
+		else if (is_singlestep)
+			goto out;
+	}
 
 	if (!(current->ptrace & PT_PTRACED))
 		goto out;
_
