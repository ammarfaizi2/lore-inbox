Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVG0P6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVG0P6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVG0PzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:55:03 -0400
Received: from [151.97.230.9] ([151.97.230.9]:18050 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S262432AbVG0PxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:53:09 -0400
Subject: [patch 1/1] Ptrace - i386: fix "syscall audit" interaction with singlestep
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       bstroesser@fujitsu-siemens.com, roland@redhat.com
From: blaisorblade@yahoo.it
Date: Tue, 26 Jul 2005 20:43:06 +0200
Message-Id: <20050726184306.A104421DC16@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Roland McGrath <roland@redhat.com>

Avoid giving two traps for singlestep instead of one, when syscall auditing is
enabled.

In fact no singlestep trap is sent on syscall entry, only on syscall exit, as
can be seen in entry.S:

# Note that in this mask _TIF_SINGLESTEP is not tested !!! <<<<<<<<<<<<<<
        testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_flags(%ebp)
        jnz syscall_trace_entry
	...
syscall_trace_entry:
	...
	call do_syscall_trace

But auditing a SINGLESTEP'ed process causes do_syscall_trace to be called, so
the tracer will get one more trap on the syscall entry path, which it
shouldn't.

This does not affect (to my knowledge) UML, nor is critical, so this shouldn't
IMHO go in 2.6.13.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/kernel/ptrace.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/ptrace.c~sysaudit-singlestep-non-umlhost arch/i386/kernel/ptrace.c
--- linux-2.6.git/arch/i386/kernel/ptrace.c~sysaudit-singlestep-non-umlhost	2005-07-26 20:22:40.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/ptrace.c	2005-07-26 20:23:44.000000000 +0200
@@ -683,8 +683,19 @@ void do_syscall_trace(struct pt_regs *re
 	/* do the secure computing check first */
 	secure_computing(regs->orig_eax);
 
-	if (unlikely(current->audit_context) && entryexit)
-		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
+	if (unlikely(current->audit_context)) {
+		if (entryexit)
+			audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
+
+		/* Debug traps, when using PTRACE_SINGLESTEP, must be sent only
+		 * on the syscall exit path. Normally, when TIF_SYSCALL_AUDIT is
+		 * not used, entry.S will call us only on syscall exit, not
+		 * entry ; so when TIF_SYSCALL_AUDIT is used we must avoid
+		 * calling send_sigtrap() on syscall entry.
+		 */
+		else if (is_singlestep)
+			goto out;
+	}
 
 	if (!(current->ptrace & PT_PTRACED))
 		goto out;
_
