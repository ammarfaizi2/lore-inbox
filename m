Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVDLTsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVDLTsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVDLTr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:47:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:63176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262174AbVDLKcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:02 -0400
Message-Id: <200504121031.j3CAVpeD005423@shell0.pdx.osdl.net>
Subject: [patch 074/198] x86_64: clean up ptrace single-stepping
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Ported from i386 (originally from Linus)

clean up ptrace single-stepping, make PT_DTRACE exact.
  
  (This makes the naming of "DTRACE" purely historical, since
  on x86 it now means "single step in progress").

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/ptrace.c |   79 ++++++++++++++++++++++--------------
 1 files changed, 50 insertions(+), 29 deletions(-)

diff -puN arch/x86_64/kernel/ptrace.c~x86_64-from-i386-originally-from-linus arch/x86_64/kernel/ptrace.c
--- 25/arch/x86_64/kernel/ptrace.c~x86_64-from-i386-originally-from-linus	2005-04-12 03:21:21.137923448 -0700
+++ 25-akpm/arch/x86_64/kernel/ptrace.c	2005-04-12 03:21:21.141922840 -0700
@@ -63,6 +63,12 @@ static inline unsigned long get_stack_lo
 	return (*((unsigned long *)stack));
 }
 
+static inline struct pt_regs *get_child_regs(struct task_struct *task)
+{
+	struct pt_regs *regs = (void *)task->thread.rsp0;
+	return regs - 1;
+}
+
 /*
  * this routine will put a word on the processes privileged stack. 
  * the offset is how far from the base addr as stored in the TSS.  
@@ -80,6 +86,42 @@ static inline long put_stack_long(struct
 	return 0;
 }
 
+static void set_singlestep(struct task_struct *child)
+{
+	struct pt_regs *regs = get_child_regs(child);
+
+	/*
+	 * Always set TIF_SINGLESTEP - this guarantees that
+	 * we single-step system calls etc..  This will also
+	 * cause us to set TF when returning to user mode.
+	 */
+	set_tsk_thread_flag(child, TIF_SINGLESTEP);
+
+	/*
+	 * If TF was already set, don't do anything else
+	 */
+	if (regs->eflags & TRAP_FLAG)
+		return;
+
+	/* Set TF on the kernel stack.. */
+	regs->eflags |= TRAP_FLAG;
+
+	child->ptrace |= PT_DTRACE;
+}
+
+static void clear_singlestep(struct task_struct *child)
+{
+	/* Always clear TIF_SINGLESTEP... */
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+
+	/* But touch TF only if it was set by us.. */
+	if (child->ptrace & PT_DTRACE) {
+		struct pt_regs *regs = get_child_regs(child);
+		regs->eflags &= ~TRAP_FLAG;
+		child->ptrace &= ~PT_DTRACE;
+	}
+}
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
@@ -87,11 +129,7 @@ static inline long put_stack_long(struct
  */
 void ptrace_disable(struct task_struct *child)
 { 
-	long tmp;
-
-	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
-	tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
-	put_stack_long(child, EFL_OFFSET, tmp);
+	clear_singlestep(child);
 }
 
 static int putreg(struct task_struct *child,
@@ -338,8 +376,7 @@ asmlinkage long sys_ptrace(long request,
 		}
 		break;
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
-	case PTRACE_CONT: { /* restart after signal. */
-		long tmp;
+	case PTRACE_CONT:    /* restart after signal. */
 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
@@ -350,14 +387,11 @@ asmlinkage long sys_ptrace(long request,
 			clear_tsk_thread_flag(child,TIF_SYSCALL_TRACE);
 		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
-	/* make sure the single step bit is not set. */
-		tmp = get_stack_long(child, EFL_OFFSET);
-		tmp &= ~TRAP_FLAG;
-		put_stack_long(child, EFL_OFFSET,tmp);
+		/* make sure the single step bit is not set. */
+		clear_singlestep(child);
 		wake_up_process(child);
 		ret = 0;
 		break;
-	}
 
 #ifdef CONFIG_IA32_EMULATION
 		/* This makes only sense with 32bit programs. Allow a
@@ -394,41 +428,28 @@ asmlinkage long sys_ptrace(long request,
  * perhaps it should be put in the status that it wants to 
  * exit.
  */
-	case PTRACE_KILL: {
-		long tmp;
-
+	case PTRACE_KILL:
 		ret = 0;
 		if (child->exit_state == EXIT_ZOMBIE)	/* already dead */
 			break;
 		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = SIGKILL;
 		/* make sure the single step bit is not set. */
-		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
-		put_stack_long(child, EFL_OFFSET, tmp);
+		clear_singlestep(child);
 		wake_up_process(child);
 		break;
-	}
-
-	case PTRACE_SINGLESTEP: {  /* set the trap flag. */
-		long tmp;
 
+	case PTRACE_SINGLESTEP:    /* set the trap flag. */
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
 		clear_tsk_thread_flag(child,TIF_SYSCALL_TRACE);
-		if ((child->ptrace & PT_DTRACE) == 0) {
-			/* Spurious delayed TF traps may occur */
-			child->ptrace |= PT_DTRACE;
-		}
-		tmp = get_stack_long(child, EFL_OFFSET) | TRAP_FLAG;
-		put_stack_long(child, EFL_OFFSET, tmp);
-		set_tsk_thread_flag(child, TIF_SINGLESTEP);
+		set_singlestep(child);
 		child->exit_code = data;
 		/* give it a chance to run. */
 		wake_up_process(child);
 		ret = 0;
 		break;
-	}
 
 	case PTRACE_DETACH:
 		/* detach a process that was attached. */
_
