Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUHYCno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUHYCno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 22:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268413AbUHYCno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 22:43:44 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:19595 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S268088AbUHYCnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 22:43:13 -0400
Date: Tue, 24 Aug 2004 19:43:07 -0700
Message-Id: <200408250243.i7P2h7hq014081@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent and ptrace cleanup
In-Reply-To: OGAWA Hirofumi's message of  Saturday, 21 August 2004 20:47:55 +0900 <87n00o3e6s.fsf@devron.myhome.or.jp>
X-Shopping-List: (1) Polygynous whip socks
   (2) Barometric dubious bracelet winters
   (3) Presidential soft-serve
   (4) Chaotic colliders
   (5) Stimulating ointments
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roland McGrath <roland@redhat.com> writes:
> 
> > +	spin_unlock_irq(&current->sighand->siglock);
> 
> This unlock is odd. lock is missing?

Indeed, that is a stray unlock from copying code around.

> ->last_siginfo is racy. Please, really please don't extend it until
> the race condition is fixed.
> 
> SIGCONT restart the stopped task. Any lock doesn't prevent it.

I believe I understand the case you are referring to now that I've looked
at it.  But I think this is the first I've heard about this issue.

While ptrace_getsiginfo is examining child->last_siginfo, another processor
could be resuming that child via SIGCONT so that it clears last_siginfo and
reuses the stack space it was pointing to.  With the right timing of the
race, the ptrace_getsiginfo call could crash with an unexpected kernel-mode
null pointer reference.  This is what you are talking about, right?  I can
see how this is possible, but I have had no luck getting this race to
strike with a straightforward reproducer program.

The race in ptrace_getsiginfo itself is not so hard to fix directly with
some locking.  But you make me wonder about the safety of ptrace altogether
under SMP or preemption.  The ptrace_check_attach code verifies that the
target is in TASK_STOPPED state.  But once it's checked this, there is no
synchronization preventing it from being resumed at any time during the
processing of the actual ptrace request.  Off hand, I can't see any
seriously bad effects from some thread resuming it via SIGCONT or SIGKILL
while ptrace is diddling it.  What I mean by "seriously bad" is anything
other than giving randomly scrambled results to a ptrace call, or randomly
clobbering the target thread's register state.  This level of ptrace stuff
has never been worried about all that much because we figure that anyone
who ptraces a process and then sends it SIGCONTs or whatnot deserves
whatever they get.  But it does matter to make sure that they cannot elicit
kernel crashes or clobber anything other than their own processes involved
in the stupid action.  I am not 100% confident that this is the case (and I
have not even looked at the ptrace code for most architectures, just i386
and x86-64.)

Following is a replacement for my last patch.  It is now more about ptrace
cleanup than it is about removing notify_parent, which it still does.
(Like the previous ones, this expects to go on top of the waitid patches.)
This again reorganizes the ptrace stopping code similarly to the last
attempt, though this time I am not adding any new exported function.  The
stops for ptrace are now done in the function ptrace_stop, which always
holds the siglock when touching current->last_siginfo.  SIGCONT generation
now checks last_siginfo (with the siglock held) and does not wake up traced
threads stopped in ptrace_stop.  This means that a thread stopped by ptrace
can only be restarted by ptrace (or by SIGKILL), not by SIGCONT (unless
ptrace is detached first).

I have changed the ptrace_check_attach code to close a race window in its
checking, and to check last_siginfo so that it refuses to operate on a
thread that is not stopped in ptrace_stop.  This means that after
PTRACE_ATTACH'ing to a thread stopped by job control, you won't be able to
do any ptrace operations until you send it a SIGCONT (at which point it
will wake up and then stop in ptrace_stop reporting the SIGCONT signal).
The reason for this new restriction is that it then lets all ptrace
operationg code be sure that there is no way it can be looking at a thread
that suddenly wakes up and changes its state because of SIGCONT.  However,
threads can still wake up in this race situation due to SIGKILL.  We don't
want to do anything to constrain the efficacy of SIGKILL just because
ptrace might be in use.  So I don't see a good way around that right now.
For that reason, I've also changed the ptrace_getsiginfo and
ptrace_setsiginfo calls to use locking to prevent SIGKILL races clearing
last_siginfo.  I hope that the race of SIGKILL vs other ptrace operations
cannot have any other crashing failure modes--I cannot see any off hand.


Thanks,
Roland


Signed-off-by:  Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/signal.c	2004-08-17 18:22:36.000000000 -0700
+++ linux-2.6/kernel/signal.c	2004-08-24 01:49:59.000000000 -0700
@@ -636,7 +636,8 @@
 
 /* forward decl */
 static void do_notify_parent_cldstop(struct task_struct *tsk,
-				     struct task_struct *parent);
+				     struct task_struct *parent,
+				     int why);
 
 /*
  * Handle magic process-wide effects of stop/continue signals.
@@ -681,11 +682,13 @@
 			p->signal->stop_state = 1;
 			spin_unlock(&p->sighand->siglock);
 			if (p->ptrace & PT_PTRACED)
-				do_notify_parent_cldstop(p, p->parent);
+				do_notify_parent_cldstop(p, p->parent,
+							 CLD_STOPPED);
 			else
 				do_notify_parent_cldstop(
 					p->group_leader,
-					p->group_leader->real_parent);
+					p->group_leader->real_parent,
+					CLD_STOPPED);
 			spin_lock(&p->sighand->siglock);
 		}
 		rm_from_queue(SIG_KERNEL_STOP_MASK, &p->signal->shared_pending);
@@ -713,7 +716,19 @@
 				set_tsk_thread_flag(t, TIF_SIGPENDING);
 				state |= TASK_INTERRUPTIBLE;
 			}
-			wake_up_state(t, state);
+
+			/*
+			 * Don't wake this thread if it's stopped in
+			 * ptrace_stop rather than a job-control stop.
+			 * When a ptrace-stopped thread resumes, it
+			 * reacquires the siglock before clearing
+			 * last_siginfo, so if this thread is resuming
+			 * on another CPU it will wait for us and then
+			 * see TIF_SIGPENDING and handle this SIGCONT.
+			 */
+			if (likely(t->last_siginfo == NULL) ||
+			    unlikely(!(t->ptrace & PT_PTRACED)))
+				wake_up_state(t, state);
 
 			t = next_thread(t);
 		} while (t != p);
@@ -727,11 +742,13 @@
 			p->signal->group_exit_code = 0;
 			spin_unlock(&p->sighand->siglock);
 			if (p->ptrace & PT_PTRACED)
-				do_notify_parent_cldstop(p, p->parent);
+				do_notify_parent_cldstop(p, p->parent,
+							 CLD_CONTINUED);
 			else
 				do_notify_parent_cldstop(
 					p->group_leader,
-					p->group_leader->real_parent);
+					p->group_leader->real_parent,
+					CLD_CONTINUED);
 			spin_lock(&p->sighand->siglock);
 		}
 	}
@@ -1461,19 +1478,22 @@
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
 	BUG_ON(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
@@ -1487,34 +1507,19 @@
 	info.si_stime = tsk->stime + tsk->signal->stime;
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
@@ -1542,26 +1547,9 @@
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
-do_notify_parent_cldstop(struct task_struct *tsk, struct task_struct *parent)
+do_notify_parent_cldstop(struct task_struct *tsk, struct task_struct *parent,
+			 int why)
 {
 	struct siginfo info;
 	unsigned long flags;
@@ -1577,13 +1565,12 @@
 	info.si_stime = tsk->stime;
 	k_getrusage(tsk, RUSAGE_BOTH, &info.si_rusage);
 
-	info.si_status = (tsk->signal ? tsk->signal->group_exit_code :
-			  tsk->exit_code) & 0x7f;
-	if (info.si_status == 0) {
+	info.si_code = why;
+	if (info.si_code == CLD_CONTINUED) {
 		info.si_status = SIGCONT;
-		info.si_code = CLD_CONTINUED;
 	} else {
-		info.si_code = CLD_STOPPED;
+		info.si_status = (tsk->signal ? tsk->signal->group_exit_code :
+				  tsk->exit_code) & 0x7f;
 	}
 
 	sighand = parent->sighand;
@@ -1598,6 +1585,62 @@
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
+/*
+ * This must be called with current->sighand->siglock held.
+ *
+ * This should be the path for all ptrace stops.
+ * We always set current->last_siginfo while stopped here.
+ * That makes it a way to test a stopped process for
+ * being ptrace-stopped vs being job-control-stopped.
+ */
+static void ptrace_stop(int exit_code, siginfo_t *info)
+{
+	BUG_ON(!(current->ptrace & PT_PTRACED));
+
+	/*
+	 * If there is a group stop in progress,
+	 * we must participate in the bookkeeping.
+	 */
+	if (current->signal->group_stop_count > 0)
+		--current->signal->group_stop_count;
+
+	current->last_siginfo = info;
+	current->exit_code = exit_code;
+
+	/* Let the debugger run.  */
+	set_current_state(TASK_STOPPED);
+	spin_unlock_irq(&current->sighand->siglock);
+	read_lock(&tasklist_lock);
+	do_notify_parent_cldstop(current, current->parent, CLD_TRAPPED);
+	read_unlock(&tasklist_lock);
+	schedule();
+
+	/*
+	 * We are back.  Now reacquire the siglock before touching
+	 * last_siginfo, so that we are sure to have synchronized with
+	 * any signal-sending on another CPU that wants to examine it.
+	 */
+	spin_lock_irq(&current->sighand->siglock);
+	current->last_siginfo = NULL;
+}
+
+void ptrace_notify(int exit_code)
+{
+	siginfo_t info;
+
+	BUG_ON((exit_code & (0x7f | ~0xffff)) != SIGTRAP);
+
+	memset(&info, 0, sizeof info);
+	info.si_signo = SIGTRAP;
+	info.si_code = exit_code;
+	info.si_pid = current->pid;
+	info.si_uid = current->uid;
+
+	/* Let the debugger run.  */
+	spin_lock_irq(&current->sighand->siglock);
+	ptrace_stop(exit_code, &info);
+	spin_unlock_irq(&current->sighand->siglock);
+}
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 
@@ -1611,13 +1654,15 @@
 	 */
 	if (stop_count < 0 || (current->ptrace & PT_PTRACED)) {
 		read_lock(&tasklist_lock);
-		do_notify_parent_cldstop(current, current->parent);
+		do_notify_parent_cldstop(current, current->parent,
+					 CLD_STOPPED);
 		read_unlock(&tasklist_lock);
 	}
 	else if (stop_count == 0) {
 		read_lock(&tasklist_lock);
 		do_notify_parent_cldstop(current->group_leader,
-					 current->group_leader->real_parent);
+					 current->group_leader->real_parent,
+					 CLD_STOPPED);
 		read_unlock(&tasklist_lock);
 	}
 
@@ -1799,25 +1844,10 @@
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
-			spin_unlock_irq(&current->sighand->siglock);
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			current->last_siginfo = NULL;
+			ptrace_stop(signr, info);
 
 			/* We're back.  Did the debugger cancel the sig?  */
-			spin_lock_irq(&current->sighand->siglock);
 			signr = current->exit_code;
 			if (signr == 0)
 				continue;
@@ -1941,7 +1971,7 @@
 EXPORT_SYMBOL(kill_proc_info);
 EXPORT_SYMBOL(kill_sl);
 EXPORT_SYMBOL(kill_sl_info);
-EXPORT_SYMBOL(notify_parent);
+EXPORT_SYMBOL(ptrace_notify);
 EXPORT_SYMBOL(send_sig);
 EXPORT_SYMBOL(send_sig_info);
 EXPORT_SYMBOL(send_group_sig_info);
--- linux-2.6/include/linux/sched.h	2004-08-15 23:20:08.000000000 -0700
+++ linux-2.6/include/linux/sched.h	2004-08-23 18:28:08.000000000 -0700
@@ -806,8 +806,7 @@
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
--- linux-2.6.8.1-waitid/kernel/ptrace.c	2004-03-29 14:50:19.000000000 -0800
+++ linux-2.6/kernel/ptrace.c	2004-08-24 17:30:33.000000000 -0700
@@ -62,20 +62,37 @@ void __ptrace_unlink(task_t *child)
  */
 int ptrace_check_attach(struct task_struct *child, int kill)
 {
-	if (!(child->ptrace & PT_PTRACED))
-		return -ESRCH;
+	int ret = -ESRCH;
 
-	if (child->parent != current)
-		return -ESRCH;
-
-	if (!kill) {
-		if (child->state != TASK_STOPPED)
+	/*
+	 * We take the read lock around doing both checks to close a
+	 * possible race where someone else was tracing our child and
+	 * detached between these two checks.  After this locked check,
+	 * we are sure that this is our traced child and that can only
+	 * be changed by us so it's not changing right after this.
+	 */
+	read_lock(&tasklist_lock);
+	if ((child->ptrace & PT_PTRACED) && child->parent == current)
+		ret = 0;
+	read_unlock(&tasklist_lock);
+
+	if (!ret && !kill) {
+		/*
+		 * ptrace_stop (signal.c) always sets last_siginfo when
+		 * going to TASK_STOPPED state.  When stopped that way,
+		 * SIGCONT will not wake it up and so the only things that
+		 * can resume it are ptrace operations and SIGKILL.
+		 * Only current can do ptrace operations since we have
+		 * the parent check.  There is still the race with SIGKILL,
+		 * so the ptrace operation code must be aware of that case.
+		 */
+		if (!child->last_siginfo)
 			return -ESRCH;
 		wait_task_inactive(child);
 	}
 
 	/* All systems go.. */
-	return 0;
+	return ret;
 }
 
 int ptrace_attach(struct task_struct *task)
@@ -281,18 +298,59 @@ static int ptrace_setoptions(struct task
 
 static int ptrace_getsiginfo(struct task_struct *child, siginfo_t __user * data)
 {
-	if (child->last_siginfo == NULL)
-		return -EINVAL;
-	return copy_siginfo_to_user(data, child->last_siginfo);
+	/*
+	 * Because of the ptrace_check_attach checks, this locking
+	 * is only required to protect against a race with SIGKILL.
+	 * But that case is still there, so we need to use the siglock here.
+	 */
+	siginfo_t info;
+	int ret = 0;
+	read_lock_irq(&tasklist_lock);
+	/*
+	 * The tasklist_lock protects clearing of child->sighand
+	 * if it suddenly woke up and is exitting (e.g. SIGKILL).
+	 */
+	if (unlikely(child->sighand == NULL))
+		ret = -EINVAL;
+	else {
+		/*
+		 * The siglock protects against the child waking up and
+		 * clearing last_siginfo.
+		 */
+		spin_lock_irq(&child->sighand->siglock);
+		if (child->last_siginfo == NULL)
+			ret = -EINVAL;
+		else
+			info = *child->last_siginfo;
+		spin_unlock_irq(&child->sighand->siglock);
+	}
+	read_unlock_irq(&tasklist_lock);
+	return ret == 0 ? copy_siginfo_to_user(data, &info) : ret;
 }
 
 static int ptrace_setsiginfo(struct task_struct *child, siginfo_t __user * data)
 {
-	if (child->last_siginfo == NULL)
-		return -EINVAL;
-	if (copy_from_user(child->last_siginfo, data, sizeof (siginfo_t)) != 0)
+	siginfo_t info;
+	int ret;
+
+	if (copy_from_user(&info, data, sizeof (siginfo_t)) != 0)
 		return -EFAULT;
-	return 0;
+
+	ret = 0;
+	read_lock_irq(&tasklist_lock); /* Protects child->sighand.  */
+	if (unlikely(child->sighand == NULL))
+		ret = -EINVAL;
+	else {
+		spin_lock_irq(&child->sighand->siglock);
+		if (child->last_siginfo == NULL)
+			ret = -EINVAL;
+		else
+			*child->last_siginfo = info;
+		spin_unlock_irq(&child->sighand->siglock);
+	}
+	read_unlock_irq(&tasklist_lock);
+
+	return ret;
 }
 
 int ptrace_request(struct task_struct *child, long request,
@@ -322,24 +380,3 @@ int ptrace_request(struct task_struct *c
 
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
