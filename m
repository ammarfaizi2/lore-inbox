Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVDLTsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVDLTsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVDLTqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:46:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:63688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262175AbVDLKcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:02 -0400
Message-Id: <200504121031.j3CAVpMH005427@shell0.pdx.osdl.net>
Subject: [patch 075/198] x86_64: Some fixes for single step handling
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Ported from i386/Linus

Be more careful with TF handling to fix some copy protection codes in Wine

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/signal.c |   18 ++++--------------
 25-akpm/arch/x86_64/kernel/traps.c  |   10 ++++++++--
 2 files changed, 12 insertions(+), 16 deletions(-)

diff -puN arch/x86_64/kernel/signal.c~x86_64-some-fixes-for-single-step-handling arch/x86_64/kernel/signal.c
--- 25/arch/x86_64/kernel/signal.c~x86_64-some-fixes-for-single-step-handling	2005-04-12 03:21:21.347891528 -0700
+++ 25-akpm/arch/x86_64/kernel/signal.c	2005-04-12 03:21:21.352890768 -0700
@@ -185,7 +185,6 @@ static inline int
 setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs, unsigned long mask, struct task_struct *me)
 {
 	int err = 0;
-	unsigned long eflags;
 
 	err |= __put_user(0, &sc->gs);
 	err |= __put_user(0, &sc->fs);
@@ -209,11 +208,7 @@ setup_sigcontext(struct sigcontext __use
 	err |= __put_user(me->thread.trap_no, &sc->trapno);
 	err |= __put_user(me->thread.error_code, &sc->err);
 	err |= __put_user(regs->rip, &sc->rip);
-	eflags = regs->eflags;
-	if (current->ptrace & PT_PTRACED) {
-		eflags &= ~TF_MASK;
-	}
-	err |= __put_user(eflags, &sc->eflags);
+	err |= __put_user(regs->eflags, &sc->eflags);
 	err |= __put_user(mask, &sc->oldmask);
 	err |= __put_user(me->thread.cr2, &sc->cr2);
 
@@ -323,14 +318,9 @@ static void setup_rt_frame(int sig, stru
 	regs->rsp = (unsigned long)frame;
 
 	set_fs(USER_DS);
-	if (regs->eflags & TF_MASK) {
-		if ((current->ptrace & (PT_PTRACED | PT_DTRACE)) == (PT_PTRACED | PT_DTRACE)) {
-			ptrace_notify(SIGTRAP);
-		} else {
-			regs->eflags &= ~TF_MASK;
-		}
-	}
-
+	regs->eflags &= ~TF_MASK;
+	if (test_thread_flag(TIF_SINGLESTEP))
+		ptrace_notify(SIGTRAP);
 #ifdef DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
 		current->comm, current->pid, frame, regs->rip, frame->pretcode);
diff -puN arch/x86_64/kernel/traps.c~x86_64-some-fixes-for-single-step-handling arch/x86_64/kernel/traps.c
--- 25/arch/x86_64/kernel/traps.c~x86_64-some-fixes-for-single-step-handling	2005-04-12 03:21:21.349891224 -0700
+++ 25-akpm/arch/x86_64/kernel/traps.c	2005-04-12 03:21:21.353890616 -0700
@@ -688,8 +688,14 @@ asmlinkage void *do_debug(struct pt_regs
 		 */
                 if ((regs->cs & 3) == 0)
                        goto clear_TF_reenable;
-		if ((tsk->ptrace & (PT_DTRACE|PT_PTRACED)) == PT_DTRACE)
-			goto clear_TF;
+		/*
+		 * Was the TF flag set by a debugger? If so, clear it now,
+		 * so that register information is correct.
+		 */
+		if (tsk->ptrace & PT_DTRACE) {
+			regs->eflags &= ~TF_MASK;
+			tsk->ptrace &= ~PT_DTRACE;
+		}
 	}
 
 	/* Ok, finally something we can handle */
_
