Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbULBX6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbULBX6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 18:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbULBX6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 18:58:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19133 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261807AbULBX4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 18:56:49 -0500
Date: Thu, 2 Dec 2004 15:56:39 -0800
Message-Id: <200412022356.iB2Nudl2001302@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] fix stop signal race
X-Fcc: ~/Mail/linus
X-Zippy-Says: Is this the line for the latest whimsical YUGOSLAVIAN drama which
   also makes you want to CRY and reconsider the VIETNAM WAR?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The `sig_avoid_stop_race' checks fail to catch a related race scenario that
can happen.  I don't think this has been seen in nature, but it could
happen in the same sorts of situations where the observed problems come up
that those checks work around.  This patch takes a different approach to
catching this race condition.  The new approach plugs the hole, and I think
is also cleaner.

The issue is a race between one CPU processing a stop signal while another
CPU processes a SIGCONT or SIGKILL.  There is a window in stop-signal
processing where the siglock must be released.  If a SIGCONT or SIGKILL
comes along here on another CPU, then the stop signal in the midst of being
processed needs to be discarded rather than having the stop take place
after the SIGCONT or SIGKILL has been generated.  The existing workaround
checks for this case explicitly by looking for a pending SIGCONT or SIGKILL
after reacquiring the lock.

However, there is another problem related to the same race issue.  In the
window where the processing of the stop signal has released the siglock,
the stop signal is not represented in the pending set any more, but it is
still "pending" and not "delivered" in POSIX terms.  The SIGCONT coming in
this window is required to clear all pending stop signals.  But, if a stop
signal has been dequeued but not yet processed, the SIGCONT generation will
fail to clear it (in handle_stop_signal).  Likewise, a SIGKILL coming here
should prevent the stop processing and make the thread die immediately
instead.  The `sig_avoid_stop_race' code checks for this by examining the
pending set to see if SIGCONT or SIGKILL is in it.  But this fails to
handle the case where another CPU running another thread in the same
process has already dequeued the signal (so it no longer can be found in
the pending set).  We must catch this as well, so that the same problems do
not arise when another thread on another CPU acted real fast.

I've fixed this dumping the `sig_avoid_stop_race' kludge in favor of a
little explicit bookkeeping.  Now, dequeuing any stop signal sets a flag
saying that a pending stop signal has been taken on by some CPU since the
last time all pending stop signals were cleared due to SIGCONT/SIGKILL.
The processing of stop signals checks the flag after the window where it
released the lock, and abandons the signal the flag has been cleared.  The
code that clears pending stop signals on SIGCONT generation also clears
this flag.  The various places that are trying to ensure the process dies
quickly (SIGKILL or other unhandled signals) also clear the flag.  
I've made this a general flags word in signal_struct, and replaced the
stop_state field with flag bits in this word.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -288,8 +288,7 @@ struct signal_struct {
 
 	/* thread group stop support, overloads group_exit_code too */
 	int			group_stop_count;
-	/* 1 if group stopped since last SIGCONT, -1 if SIGCONT since report */
-  	int			stop_state;
+	unsigned int		flags; /* see SIGNAL_* flags below */
 
 	/* POSIX.1b Interval Timers */
 	struct list_head posix_timers;
@@ -326,6 +325,14 @@ struct signal_struct {
 };
 
 /*
+ * Bits in flags field of signal_struct.
+ */
+#define SIGNAL_STOP_STOPPED	0x00000001 /* job control stop in effect */
+#define SIGNAL_STOP_DEQUEUED	0x00000002 /* stop signal dequeued */
+#define SIGNAL_STOP_CONTINUED	0x00000004 /* SIGCONT since WCONTINUED reap */
+
+
+/*
  * Priority of a process goes from 0..MAX_PRIO-1, valid RT
  * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL tasks are
  * in the range MAX_RT_PRIO..MAX_PRIO-1. Priority values
--- linux-2.6/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -1260,16 +1260,17 @@ static int wait_task_continued(task_t *p
 	if (unlikely(!p->signal))
 		return 0;
 
-	if (p->signal->stop_state >= 0)
+	if (!(p->signal->flags & SIGNAL_STOP_CONTINUED))
 		return 0;
 
 	spin_lock_irq(&p->sighand->siglock);
-	if (p->signal->stop_state >= 0) { /* Re-check with the lock held.  */
+	/* Re-check with the lock held.  */
+	if (!(p->signal->flags & SIGNAL_STOP_CONTINUED)) {
 		spin_unlock_irq(&p->sighand->siglock);
 		return 0;
 	}
 	if (!noreap)
-		p->signal->stop_state = 0;
+		p->signal->flags &= ~SIGNAL_STOP_CONTINUED;
 	spin_unlock_irq(&p->sighand->siglock);
 
 	pid = p->pid;
--- linux-2.6/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -729,6 +729,7 @@ static inline int copy_signal(unsigned l
 		return -ENOMEM;
 	atomic_set(&sig->count, 1);
 	atomic_set(&sig->live, 1);
+	sig->flags = 0;
 	sig->group_exit = 0;
 	sig->group_exit_code = 0;
 	sig->group_exit_task = NULL;
--- linux-2.6/kernel/signal.c
+++ linux-2.6/kernel/signal.c
@@ -153,11 +153,6 @@ static kmem_cache_t *sigqueue_cachep;
 	(!T(signr, SIG_KERNEL_IGNORE_MASK|SIG_KERNEL_STOP_MASK) && \
 	 (t)->sighand->action[(signr)-1].sa.sa_handler == SIG_DFL)
 
-#define sig_avoid_stop_race() \
-	(sigtestsetmask(&current->pending.signal, M(SIGCONT) | M(SIGKILL)) || \
-	 sigtestsetmask(&current->signal->shared_pending.signal, \
-						  M(SIGCONT) | M(SIGKILL)))
-
 static int sig_ignored(struct task_struct *t, int sig)
 {
 	void __user * handler;
@@ -551,6 +546,21 @@ int dequeue_signal(struct task_struct *t
 	if (!signr)
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
 					 mask, info);
+ 	if (signr && unlikely(sig_kernel_stop(signr))) {
+ 		/*
+ 		 * Set a marker that we have dequeued a stop signal.  Our
+ 		 * caller might release the siglock and then the pending
+ 		 * stop signal it is about to process is no longer in the
+ 		 * pending bitmasks, but must still be cleared by a SIGCONT
+ 		 * (and overruled by a SIGKILL).  So those cases clear this
+ 		 * shared flag after we've set it.  Note that this flag may
+ 		 * remain set after the signal we return is ignored or
+ 		 * handled.  That doesn't matter because its only purpose
+ 		 * is to alert stop-signal processing code when another
+ 		 * processor has come along and cleared the flag.
+ 		 */
+ 		tsk->signal->flags |= SIGNAL_STOP_DEQUEUED;
+ 	}
 	if ( signr &&
 	     ((info->si_code & __SI_MASK) == __SI_TIMER) &&
 	     info->si_sys_private){
@@ -680,7 +690,7 @@ static void handle_stop_signal(int sig, 
 			 * the SIGCHLD was pending on entry to this kill.
 			 */
 			p->signal->group_stop_count = 0;
-			p->signal->stop_state = 1;
+			p->signal->flags = SIGNAL_STOP_CONTINUED;
 			spin_unlock(&p->sighand->siglock);
 			if (p->ptrace & PT_PTRACED)
 				do_notify_parent_cldstop(p, p->parent,
@@ -722,12 +732,12 @@ static void handle_stop_signal(int sig, 
 			t = next_thread(t);
 		} while (t != p);
 
-		if (p->signal->stop_state > 0) {
+		if (p->signal->flags & SIGNAL_STOP_STOPPED) {
 			/*
 			 * We were in fact stopped, and are now continued.
 			 * Notify the parent with CLD_CONTINUED.
 			 */
-			p->signal->stop_state = -1;
+			p->signal->flags = SIGNAL_STOP_CONTINUED;
 			p->signal->group_exit_code = 0;
 			spin_unlock(&p->sighand->siglock);
 			if (p->ptrace & PT_PTRACED)
@@ -739,7 +749,20 @@ static void handle_stop_signal(int sig, 
 					p->group_leader->real_parent,
 							 CLD_CONTINUED);
 			spin_lock(&p->sighand->siglock);
+		} else {
+			/*
+			 * We are not stopped, but there could be a stop
+			 * signal in the middle of being processed after
+			 * being removed from the queue.  Clear that too.
+			 */
+			p->signal->flags = 0;
 		}
+	} else if (sig == SIGKILL) {
+		/*
+		 * Make sure that any pending stop signal already dequeued
+		 * is undone by the wakeup for SIGKILL.
+		 */
+		p->signal->flags = 0;
 	}
 }
 
@@ -969,6 +992,7 @@ __group_complete_signal(int sig, struct 
 			p->signal->group_exit = 1;
 			p->signal->group_exit_code = sig;
 			p->signal->group_stop_count = 0;
+			p->signal->flags = 0;
 			t = p;
 			do {
 				sigaddset(&t->pending.signal, SIGKILL);
@@ -1056,6 +1080,7 @@ void zap_other_threads(struct task_struc
 	struct task_struct *t;
 
 	p->signal->group_stop_count = 0;
+	p->signal->flags = 0;
 
 	if (thread_group_empty(p))
 		return;
@@ -1641,15 +1666,18 @@ finish_stop(int stop_count)
 /*
  * This performs the stopping for SIGSTOP and other stop signals.
  * We have to stop all threads in the thread group.
+ * Returns nonzero if we've actually stopped and released the siglock.
+ * Returns zero if we didn't stop and still hold the siglock.
  */
-static void
+static int
 do_signal_stop(int signr)
 {
 	struct signal_struct *sig = current->signal;
 	struct sighand_struct *sighand = current->sighand;
 	int stop_count = -1;
 
-	/* spin_lock_irq(&sighand->siglock) is now done in caller */
+	if (!likely(sig->flags & SIGNAL_STOP_DEQUEUED))
+		return 0;
 
 	if (sig->group_stop_count > 0) {
 		/*
@@ -1661,7 +1689,7 @@ do_signal_stop(int signr)
 		current->exit_code = signr;
 		set_current_state(TASK_STOPPED);
 		if (stop_count == 0)
-			sig->stop_state = 1;
+			sig->flags = SIGNAL_STOP_STOPPED;
 		spin_unlock_irq(&sighand->siglock);
 	}
 	else if (thread_group_empty(current)) {
@@ -1670,7 +1698,7 @@ do_signal_stop(int signr)
 		 */
 		current->exit_code = current->signal->group_exit_code = signr;
 		set_current_state(TASK_STOPPED);
-		sig->stop_state = 1;
+		sig->flags = SIGNAL_STOP_STOPPED;
 		spin_unlock_irq(&sighand->siglock);
 	}
 	else {
@@ -1691,25 +1719,16 @@ do_signal_stop(int signr)
 		read_lock(&tasklist_lock);
 		spin_lock_irq(&sighand->siglock);
 
-		if (unlikely(sig->group_exit)) {
+		if (!likely(sig->flags & SIGNAL_STOP_DEQUEUED)) {
 			/*
-			 * There is a group exit in progress now.
-			 * We'll just ignore the stop and process the
-			 * associated fatal signal.
+			 * Another stop or continue happened while we
+			 * didn't have the lock.  We can just swallow this
+			 * signal now.  If we raced with a SIGCONT, that
+			 * should have just cleared it now.  If we raced
+			 * with another processor delivering a stop signal,
+			 * then the SIGCONT that wakes us up should clear it.
 			 */
-			spin_unlock_irq(&sighand->siglock);
-			read_unlock(&tasklist_lock);
-			return;
-		}
-
-		if (unlikely(sig_avoid_stop_race())) {
-			/*
-			 * Either a SIGCONT or a SIGKILL signal was
-			 * posted in the siglock-not-held window.
-			 */
-			spin_unlock_irq(&sighand->siglock);
-			read_unlock(&tasklist_lock);
-			return;
+			return 0;
 		}
 
 		if (sig->group_stop_count == 0) {
@@ -1737,13 +1756,14 @@ do_signal_stop(int signr)
 		current->exit_code = signr;
 		set_current_state(TASK_STOPPED);
 		if (stop_count == 0)
-			sig->stop_state = 1;
+			sig->flags = SIGNAL_STOP_STOPPED;
 
 		spin_unlock_irq(&sighand->siglock);
 		read_unlock(&tasklist_lock);
 	}
 
 	finish_stop(stop_count);
+	return 1;
 }
 
 /*
@@ -1779,7 +1799,7 @@ static inline int handle_group_stop(void
 	 */
 	stop_count = --current->signal->group_stop_count;
 	if (stop_count == 0)
-		current->signal->stop_state = 1;
+		current->signal->flags = SIGNAL_STOP_STOPPED;
 	current->exit_code = current->signal->group_exit_code;
 	set_current_state(TASK_STOPPED);
 	spin_unlock_irq(&current->sighand->siglock);
@@ -1873,28 +1893,27 @@ relock:
 			 * This allows an intervening SIGCONT to be posted.
 			 * We need to check for that and bail out if necessary.
 			 */
-			if (signr == SIGSTOP) {
-				do_signal_stop(signr); /* releases siglock */
-				goto relock;
-			}
-			spin_unlock_irq(&current->sighand->siglock);
+			if (signr != SIGSTOP) {
+				spin_unlock_irq(&current->sighand->siglock);
 
-			/* signals can be posted during this window */
+				/* signals can be posted during this window */
 
-			if (is_orphaned_pgrp(process_group(current)))
-				goto relock;
+				if (is_orphaned_pgrp(process_group(current)))
+					goto relock;
 
-			spin_lock_irq(&current->sighand->siglock);
-			if (unlikely(sig_avoid_stop_race())) {
-				/*
-				 * Either a SIGCONT or a SIGKILL signal was
-				 * posted in the siglock-not-held window.
-				 */
-				continue;
+				spin_lock_irq(&current->sighand->siglock);
 			}
 
-			do_signal_stop(signr); /* releases siglock */
-			goto relock;
+			if (likely(do_signal_stop(signr))) {
+				/* It released the siglock.  */
+				goto relock;
+			}
+
+			/*
+			 * We didn't actually stop, due to a race
+			 * with SIGCONT or something like that.
+			 */
+			continue;
 		}
 
 		spin_unlock_irq(&current->sighand->siglock);
