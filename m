Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268803AbUHUBJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268803AbUHUBJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 21:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268805AbUHUBJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 21:09:49 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:60884 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S268803AbUHUBJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 21:09:25 -0400
Date: Fri, 20 Aug 2004 18:09:20 -0700
Message-Id: <200408210109.i7L19Kjf006151@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] notify_parent and ptrace cleanup
In-Reply-To: Andrew Morton's message of  Tuesday, 17 August 2004 23:44:09 -0700 <20040817234409.45009377.akpm@osdl.org>
X-Windows: there's got to be a better way.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces my earlier patch cleaning up notify_parent.  
Use interdiff if you already applied that one.

I have removed notify_parent entirely now.  The callers should use
either ptrace_notify or ptrace_notify_info.  The latter I've added to
consolidate the traced-signal and traced-event cases and be the main
entry point for reporting a ptrace stop; ptrace_notify now calls
ptrace_notify_info.  This changes the behavior of the event stops so
that they too set current->last_siginfo and PTRACE_GETSIGINFO at after
an event stop will return a siginfo_t whose si_code matches the extended
exit code returned by wait.  We can now test current->last_siginfo to
reliably distinguish a ptrace stop from a job-control signal stop, which
might be useful in the future.

I've removed the recalc_sigpending call that was done in ptrace_notify.
I don't know when or why this was added, probably it was before various
signal fixes.  This call should never be necessary.  I believe that all
paths of signal sending already do recalc_sigpending_tsk when needed.

This patch updates all the arch-specific syscall trace code so that it
uses ptrace_notify, though I only actually tried compiling on x86.  I did
this uniformly, and it makes a few arch's implement TRACESYSGOOD properly
that failed to before.

The h8300, m68k, and m68knommu implementations of do_signal call
notify_parent.  These will no longer compile and I didn't touch the code.
They all have broken signal semantics in a variety of ways because they
have not been updated in a long time.  Each needs to be rewritten to use
get_signal_to_deliver, and define the ptrace_signal_deliver macro as
appropriate.  This will bring those ports' signal behavior into line with
everything else.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6.8.1-waitid/kernel/signal.c	2004-08-17 17:19:07.012301380 -0700
+++ linux-2.6/kernel/signal.c	2004-08-20 17:09:04.306418759 -0700
@@ -1441,19 +1441,22 @@
 }
 
 /*
- * Let a parent know about a status change of a child.
+ * Let a parent know about the death of a child.
+ * For a stopped/continued status change, use do_notify_parent_cldstop instead.
  */
 
 void do_notify_parent(struct task_struct *tsk, int sig)
 {
 	struct siginfo info;
 	unsigned long flags;
-	int why, status;
 	struct sighand_struct *psig;
 
 	if (sig == -1)
 		BUG();
 
+	/* do_notify_parent_cldstop should have been called instead.  */
+	BUG_ON(tsk->state == TASK_STOPPED);
+
 	BUG_ON(tsk->group_leader != tsk && tsk->group_leader->state != TASK_ZOMBIE && !tsk->ptrace);
 	BUG_ON(tsk->group_leader == tsk && !thread_group_empty(tsk) && !tsk->ptrace);
 
@@ -1467,34 +1470,19 @@
 	info.si_stime = tsk->stime;
 	k_getrusage(tsk, RUSAGE_BOTH, &info.si_rusage);
 
-	status = tsk->exit_code & 0x7f;
-	why = SI_KERNEL;	/* shouldn't happen */
-	switch (tsk->state) {
-	case TASK_STOPPED:
-		/* FIXME -- can we deduce CLD_TRAPPED or CLD_CONTINUED? */
-		if (tsk->ptrace & PT_PTRACED)
-			why = CLD_TRAPPED;
-		else
-			why = CLD_STOPPED;
-		break;
-
-	default:
-		if (tsk->exit_code & 0x80)
-			why = CLD_DUMPED;
-		else if (tsk->exit_code & 0x7f)
-			why = CLD_KILLED;
-		else {
-			why = CLD_EXITED;
-			status = tsk->exit_code >> 8;
-		}
-		break;
+	info.si_status = tsk->exit_code & 0x7f;
+	if (tsk->exit_code & 0x80)
+		info.si_code = CLD_DUMPED;
+	else if (tsk->exit_code & 0x7f)
+		info.si_code = CLD_KILLED;
+	else {
+		info.si_code = CLD_EXITED;
+		info.si_status = tsk->exit_code >> 8;
 	}
-	info.si_code = why;
-	info.si_status = status;
 
 	psig = tsk->parent->sighand;
 	spin_lock_irqsave(&psig->siglock, flags);
-	if (sig == SIGCHLD && tsk->state != TASK_STOPPED &&
+	if (sig == SIGCHLD &&
 	    (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
 	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
 		/*
@@ -1542,24 +1530,6 @@
 	spin_unlock_irqrestore(&psig->siglock, flags);
 }
 
-
-/*
- * We need the tasklist lock because it's the only
- * thing that protects out "parent" pointer.
- *
- * exit.c calls "do_notify_parent()" directly, because
- * it already has the tasklist lock.
- */
-void
-notify_parent(struct task_struct *tsk, int sig)
-{
-	if (sig != -1) {
-		read_lock(&tasklist_lock);
-		do_notify_parent(tsk, sig);
-		read_unlock(&tasklist_lock);
-	}
-}
-
 static void
 do_notify_parent_cldstop(struct task_struct *tsk, struct task_struct *parent)
 {
@@ -1583,4 +1553,6 @@
 		info.si_status = SIGCONT;
 		info.si_code = CLD_CONTINUED;
+	} else if (tsk->last_siginfo) {
+		info.si_code = CLD_TRAPPED;
 	} else {
 		info.si_code = CLD_STOPPED;
@@ -1799,22 +1771,9 @@
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
 			ptrace_signal_deliver(regs, cookie);
 
-			/*
-			 * If there is a group stop in progress,
-			 * we must participate in the bookkeeping.
-			 */
-			if (current->signal->group_stop_count > 0)
-				--current->signal->group_stop_count;
-
 			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->last_siginfo = info;
-			set_current_state(TASK_STOPPED);
 			spin_unlock_irq(&current->sighand->siglock);
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			current->last_siginfo = NULL;
+			ptrace_notify_info(info);
 
 			/* We're back.  Did the debugger cancel the sig?  */
 			spin_lock_irq(&current->sighand->siglock);
@@ -1930,6 +1889,62 @@
 
 #endif
 
+/*
+ * This should be the path for all ptrace stops.
+ * We always set current->last_siginfo while stopped here.
+ * That makes it a way to test a stopped process for
+ * being ptrace-stopped vs being job-control-stopped.
v+ */
+void ptrace_notify_info(siginfo_t *info)
+{
+	BUG_ON (!(current->ptrace & PT_PTRACED));
+
+	/*
+	 * If there is a group stop in progress,
+	 * we must participate in the bookkeeping.
+	 */
+	if (current->signal->group_stop_count > 0)
+		--current->signal->group_stop_count;
+
+	current->last_siginfo = info;
+	if (info->si_signo == SIGTRAP &&
+	    info->si_code > 0 && !(info->si_code & __SI_MASK)) {
+		/*
+		 * This is an explicit notification with a special code,
+		 * not an intercepted signal with its own normal info.
+		 */
+		BUG_ON((info->si_code & 0x7f) != SIGTRAP);
+		current->exit_code = info->si_code;
+	} else {
+		current->exit_code = info->si_signo;
+	}
+
+	/* Let the debugger run.  */
+	set_current_state(TASK_STOPPED);
+	spin_unlock_irq(&current->sighand->siglock);
+	read_lock(&tasklist_lock);
+	do_notify_parent_cldstop(current, current->parent);
+	read_unlock(&tasklist_lock);
+	schedule();
+
+	/* We are back.  */
+	current->last_siginfo = NULL;
+}
+
+void ptrace_notify(int exit_code)
+{
+	siginfo_t info;
+
+	memset(&info, 0, sizeof info);
+	info.si_signo = SIGTRAP;
+	info.si_code = exit_code;
+	info.si_pid = current->pid;
+	info.si_uid = current->uid;
+
+	/* Let the debugger run.  */
+	ptrace_notify_info(&info);
+}
+
 EXPORT_SYMBOL(recalc_sigpending);
 EXPORT_SYMBOL_GPL(dequeue_signal);
 EXPORT_SYMBOL(flush_signals);
@@ -1941,7 +1956,8 @@
 EXPORT_SYMBOL(kill_proc_info);
 EXPORT_SYMBOL(kill_sl);
 EXPORT_SYMBOL(kill_sl_info);
-EXPORT_SYMBOL(notify_parent);
+EXPORT_SYMBOL(ptrace_notify);
+EXPORT_SYMBOL(ptrace_notify_info);
 EXPORT_SYMBOL(send_sig);
 EXPORT_SYMBOL(send_sig_info);
 EXPORT_SYMBOL(send_group_sig_info);
--- linux-2.6/include/linux/sched.h	2004-08-15 23:20:08.000000000 -0700
+++ linux-2.6/include/linux/sched.h	2004-08-20 13:53:28.000000000 -0700
@@ -806,7 +806,6 @@
 extern int kill_pg_info(int, struct siginfo *, pid_t);
 extern int kill_sl_info(int, struct siginfo *, pid_t);
 extern int kill_proc_info(int, struct siginfo *, pid_t);
-extern void notify_parent(struct task_struct *, int);
 extern void do_notify_parent(struct task_struct *, int);
 extern void force_sig(int, struct task_struct *);
 extern void force_sig_specific(int, struct task_struct *);
--- linux-2.6.8.1-waitid/arch/m68knommu/kernel/ptrace.c	2002-11-01 11:44:49.000000000 -0800
+++ linux-2.6/arch/m68knommu/kernel/ptrace.c	2004-08-20 14:02:01.000000000 -0700
@@ -376,10 +376,8 @@ asmlinkage void syscall_trace(void)
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
--- linux-2.6.8.1-waitid/arch/m68k/kernel/ptrace.c	2004-05-11 07:54:30.000000000 -0700
+++ linux-2.6/arch/m68k/kernel/ptrace.c	2004-08-20 14:00:23.000000000 -0700
@@ -379,11 +379,8 @@ asmlinkage void syscall_trace(void)
 	if (!current->thread.work.delayed_trace &&
 	    !current->thread.work.syscall_trace)
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
--- linux-2.6.8.1-waitid/arch/arm/kernel/ptrace.c	2004-07-30 22:48:39.000000000 -0700
+++ linux-2.6/arch/arm/kernel/ptrace.c	2004-08-20 13:58:34.000000000 -0700
@@ -792,11 +792,8 @@ asmlinkage void syscall_trace(int why, s
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
--- linux-2.6.8.1-waitid/arch/arm26/kernel/ptrace.c	2003-06-08 09:21:42.000000000 -0700
+++ linux-2.6/arch/arm26/kernel/ptrace.c	2004-08-20 14:01:43.000000000 -0700
@@ -729,11 +729,8 @@ asmlinkage void syscall_trace(int why, s
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
--- linux-2.6.8.1-waitid/arch/h8300/kernel/ptrace.c	2004-06-18 08:16:42.000000000 -0700
+++ linux-2.6/arch/h8300/kernel/ptrace.c	2004-08-20 13:59:35.000000000 -0700
@@ -270,10 +270,8 @@ asmlinkage void syscall_trace(void)
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
--- linux-2.6.8.1-waitid/arch/parisc/kernel/ptrace.c	2004-02-06 16:57:55.000000000 -0800
+++ linux-2.6/arch/parisc/kernel/ptrace.c	2004-08-20 14:01:38.000000000 -0700
@@ -404,11 +404,8 @@ void syscall_trace(void)
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
--- linux-2.6.8.1-waitid/arch/sh64/kernel/ptrace.c	2004-06-29 19:18:58.000000000 -0700
+++ linux-2.6/arch/sh64/kernel/ptrace.c	2004-08-20 13:58:55.000000000 -0700
@@ -311,11 +311,8 @@ asmlinkage void syscall_trace(void)
 	if (!(tsk->ptrace & PT_PTRACED))
 		return;
 
-	tsk->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-				    ? 0x80 : 0);
-	tsk->state = TASK_STOPPED;
-	notify_parent(tsk, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
--- linux-2.6.8.1-waitid/arch/sparc/kernel/ptrace.c	2004-05-31 19:08:20.000000000 -0700
+++ linux-2.6/arch/sparc/kernel/ptrace.c	2004-08-20 14:00:06.000000000 -0700
@@ -614,12 +614,9 @@ asmlinkage void syscall_trace(void)
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
 	current->thread.flags ^= MAGIC_CONSTANT;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
--- linux-2.6.8.1-waitid/arch/sparc64/kernel/ptrace.c	2004-05-31 16:36:41.000000000 -0700
+++ linux-2.6/arch/sparc64/kernel/ptrace.c	2004-08-20 13:59:49.000000000 -0700
@@ -627,11 +627,8 @@ asmlinkage void syscall_trace(void)
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
--- linux-2.6.8.1-waitid/arch/um/kernel/ptrace.c	2003-02-05 20:16:06.000000000 -0800
+++ linux-2.6/arch/um/kernel/ptrace.c	2004-08-20 14:01:51.000000000 -0700
@@ -311,11 +311,8 @@ void syscall_trace(void)
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
- 	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
- 					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
--- linux-2.6.8.1-waitid/arch/v850/kernel/ptrace.c	2004-02-19 21:41:44.000000000 -0800
+++ linux-2.6/arch/v850/kernel/ptrace.c	2004-08-20 14:01:25.000000000 -0700
@@ -269,11 +269,8 @@ asmlinkage void syscall_trace(void)
 		return;
 	/* The 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
--- linux-2.6.8.1-waitid/include/linux/ptrace.h	2004-02-06 19:45:05.000000000 -0800
+++ linux-2.6/include/linux/ptrace.h	2004-08-20 17:05:48.172948333 -0700
@@ -83,6 +83,7 @@ extern void ptrace_disable(struct task_s
 extern int ptrace_check_attach(struct task_struct *task, int kill);
 extern int ptrace_request(struct task_struct *child, long request, long addr, long data);
 extern void ptrace_notify(int exit_code);
+extern void ptrace_notify_info(siginfo_t *);
 extern void __ptrace_link(struct task_struct *child,
 			  struct task_struct *new_parent);
 extern void __ptrace_unlink(struct task_struct *child);
--- linux-2.6.8.1-waitid/kernel/ptrace.c	2004-03-29 14:50:19.000000000 -0800
+++ linux-2.6/kernel/ptrace.c	2004-08-20 13:54:17.000000000 -0700
@@ -322,24 +322,3 @@ int ptrace_request(struct task_struct *c
 
 	return ret;
 }
-
-void ptrace_notify(int exit_code)
-{
-	BUG_ON (!(current->ptrace & PT_PTRACED));
-
-	/* Let the debugger run.  */
-	current->exit_code = exit_code;
-	set_current_state(TASK_STOPPED);
-	notify_parent(current, SIGCHLD);
-	schedule();
-
-	/*
-	 * Signals sent while we were stopped might set TIF_SIGPENDING.
-	 */
-
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-}
-
-EXPORT_SYMBOL(ptrace_notify);
