Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319460AbSH3HSh>; Fri, 30 Aug 2002 03:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319466AbSH3HSh>; Fri, 30 Aug 2002 03:18:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36995 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319460AbSH3HSf>;
	Fri, 30 Aug 2002 03:18:35 -0400
Date: Fri, 30 Aug 2002 09:26:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] clone-cleanup 2.5.32-BK
Message-ID: <Pine.LNX.4.44.0208300922020.7785-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch moves CLONE_SETTID and CLONE_CLEARTID handling into
kernel/fork.c, where it belongs. [the CLONE_SETTLS is x86-specific and
thus remains in the per-arch process.c] This makes support for these two
new flags much easier: architectures only have to pass in the user_tid
pointer. (I tested the patch with userspace threading code and it works
just fine.)

	Ingo

--- linux/arch/i386/kernel/smpboot.c.orig	Fri Aug 30 09:20:52 2002
+++ linux/arch/i386/kernel/smpboot.c	Fri Aug 30 09:20:59 2002
@@ -495,7 +495,7 @@
 	 * don't care about the eip and regs settings since
 	 * we'll never reschedule the forked task.
 	 */
-	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
 }
 
 /* which physical APIC ID maps to which logical CPU number */
--- linux/arch/i386/kernel/process.c.orig	Fri Aug 30 09:14:27 2002
+++ linux/arch/i386/kernel/process.c	Fri Aug 30 09:20:32 2002
@@ -504,7 +504,7 @@
 	regs.eflags = 0x286;
 
 	/* Ok, create the new process.. */
-	p = do_fork(flags | CLONE_VM, 0, &regs, 0);
+	p = do_fork(flags | CLONE_VM, 0, &regs, 0, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -588,11 +588,6 @@
 	}
 
 	/*
-	 * The common fastpath:
-	 */
-	if (!(clone_flags & (CLONE_SETTLS | CLONE_SETTID | CLONE_CLEARTID)))
-		return 0;
-	/*
 	 * Set a new TLS for the child thread?
 	 */
 	if (clone_flags & CLONE_SETTLS) {
@@ -613,19 +608,6 @@
 		desc->a = LDT_entry_a(&info);
 		desc->b = LDT_entry_b(&info);
 	}
-
-	/*
-	 * Notify the child of the TID?
-	 */
-	if (clone_flags & CLONE_SETTID)
-		if (put_user(p->pid, (pid_t *)childregs->edx))
-			return -EFAULT;
-
-	/*
-	 * Does the userspace VM want the TID cleared on mm_release()?
-	 */
-	if (clone_flags & CLONE_CLEARTID)
-		p->user_tid = (int *) childregs->edx;
 	return 0;
 }
 
@@ -779,7 +761,7 @@
 {
 	struct task_struct *p;
 
-	p = do_fork(SIGCHLD, regs.esp, &regs, 0);
+	p = do_fork(SIGCHLD, regs.esp, &regs, 0, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -788,12 +770,14 @@
 	struct task_struct *p;
 	unsigned long clone_flags;
 	unsigned long newsp;
+	int *user_tid;
 
 	clone_flags = regs.ebx;
 	newsp = regs.ecx;
+	user_tid = (int *)regs.edx;
 	if (!newsp)
 		newsp = regs.esp;
-	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0);
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0, user_tid);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
@@ -811,7 +795,7 @@
 {
 	struct task_struct *p;
 
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0);
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
--- linux/include/linux/sched.h.orig	Fri Aug 30 09:14:48 2002
+++ linux/include/linux/sched.h	Fri Aug 30 09:17:44 2002
@@ -659,7 +659,7 @@
 extern task_t *child_reaper;
 
 extern int do_execve(char *, char **, char **, struct pt_regs *);
-extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long);
+extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int *);
 
 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
--- linux/kernel/fork.c.orig	Fri Aug 30 09:12:13 2002
+++ linux/kernel/fork.c	Fri Aug 30 09:18:58 2002
@@ -649,7 +649,8 @@
 static struct task_struct *copy_process(unsigned long clone_flags,
 			    unsigned long stack_start,
 			    struct pt_regs *regs,
-			    unsigned long stack_size)
+			    unsigned long stack_size,
+			    int *user_tid)
 {
 	int retval;
 	struct task_struct *p = NULL;
@@ -760,7 +761,20 @@
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
-	
+	/*
+	 * Notify the child of the TID?
+	 */
+	retval = -EFAULT;
+	if (clone_flags & CLONE_SETTID)
+		if (put_user(p->pid, user_tid))
+			goto bad_fork_cleanup_namespace;
+
+	/*
+	 * Does the userspace VM want the TID cleared on mm_release()?
+	 */
+	if (clone_flags & CLONE_CLEARTID)
+		p->user_tid = user_tid;
+
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
 	   
@@ -876,11 +890,12 @@
 struct task_struct *do_fork(unsigned long clone_flags,
 			    unsigned long stack_start,
 			    struct pt_regs *regs,
-			    unsigned long stack_size)
+			    unsigned long stack_size,
+			    int *user_tid)
 {
 	struct task_struct *p;
 
-	p = copy_process(clone_flags, stack_start, regs, stack_size);
+	p = copy_process(clone_flags, stack_start, regs, stack_size, user_tid);
 	if (!IS_ERR(p)) {
 		struct completion vfork;
 

