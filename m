Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270346AbTGXCJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 22:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTGXCJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 22:09:20 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:45466 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S270346AbTGXCJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 22:09:13 -0400
Message-Id: <200307240228.h6O2SdCJ006290@pasta.boston.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] signal handling race condition causing reboot hangs
Date: Wed, 23 Jul 2003 22:28:39 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a long-standing locking hole in the kernel's handling of the
signals related to stopping and resuming processes.  When a process
handles SIGSTOP, SIGTSTP, SIGTTIN, or SIGTTOU, the "sighand" lock is
held while the signal is dequeued and appropriate masks are updated.
But the "sighand" lock is dropped in several cases before the task's
state is changed to TASK_STOPPED (or before a group-stop is initiated).

If a process running on another cpu posts a SIGCONT or SIGKILL just after
the "victim" process releases the lock but before its state is set to
TASK_STOPPED, the corresponding wakeup will be lost and the victim will
remain stopped despite the successive SIGCONT or SIGKILL.  In this case,
a repeated posting of SIGCONT or SIGKILL will have no effect, since the
original one is already pending (and so causes a repeated posting to be
discarded).  The occurrence of a SIGSTOP/SIGKILL race where the victim
has blocked all other signals will result in an unkillable process.

Although a fabricated test program can reproduce a SIGSTOP/SIGCONT race
hang in less than a minute (on a 2-cpu Dell Precision 450), the scenario
that has been most frequently encountered is a hang during reboot or
shutdown.  This occurs because /sbin/killall5 brackets the scanning of
/proc/* and associated signal posting to (most) of the processes still
running with kill(-1, SIGSTOP) and kill(-1, SIGCONT) calls to temporarily
freeze every process except for "init".  Occasionally, its parent (running
the /etc/rc6.d/S01reboot shell script) gets stuck in TASK_STOPPED state
with pending SIGCONT and SIGCLD signals, but with no other process left
to wake it up.

In order to fix the race condition, the locking in do_signal_stop()
and get_signal_to_deliver() needed reworking to close the hole.  Due
to lock ordering issues between the "sighand" lock and tasklist_lock,
there are two cases where the former lock needs to be released and
then reacquired, thus allowing a tiny hole for a SIGCONT/SIGKILL to
be posted.  These two cases are resolved by rechecking for a pending
SIGCONT/SIGKILL after the locks are (re)acquired in the proper order.

Anyone wanting a copy of the test program may e-mail me off-list.

Cheers.  -ernie



--- linux-2.6.0-test1/kernel/signal.c.orig
+++ linux-2.6.0-test1/kernel/signal.c
@@ -155,6 +155,11 @@ int max_queued_signals = 1024;
 	(!T(signr, SIG_KERNEL_IGNORE_MASK|SIG_KERNEL_STOP_MASK) && \
 	 (t)->sighand->action[(signr)-1].sa.sa_handler == SIG_DFL)
 
+#define sig_avoid_stop_race() \
+	(sigtestsetmask(&current->pending.signal, M(SIGCONT) | M(SIGKILL)) || \
+	 sigtestsetmask(&current->signal->shared_pending.signal, \
+						  M(SIGCONT) | M(SIGKILL)))
+
 static inline int sig_ignored(struct task_struct *t, int sig)
 {
 	void * handler;
@@ -1541,17 +1546,13 @@ do_signal_stop(int signr)
 	struct sighand_struct *sighand = current->sighand;
 	int stop_count = -1;
 
+	/* spin_lock_irq(&sighand->siglock) is now done in caller */
+
 	if (sig->group_stop_count > 0) {
 		/*
 		 * There is a group stop in progress.  We don't need to
 		 * start another one.
 		 */
-		spin_lock_irq(&sighand->siglock);
-		if (unlikely(sig->group_stop_count == 0)) {
-			BUG_ON(!sig->group_exit);
-			spin_unlock_irq(&sighand->siglock);
-			return;
-		}
 		signr = sig->group_exit_code;
 		stop_count = --sig->group_stop_count;
 		current->exit_code = signr;
@@ -1560,17 +1561,27 @@ do_signal_stop(int signr)
 	}
 	else if (thread_group_empty(current)) {
 		/*
-		 * No locks needed in this case.
+		 * Lock must be held through transition to stopped state.
 		 */
 		current->exit_code = signr;
 		set_current_state(TASK_STOPPED);
+		spin_unlock_irq(&sighand->siglock);
 	}
 	else {
 		/*
 		 * There is no group stop already in progress.
-		 * We must initiate one now.
+		 * We must initiate one now, but that requires
+		 * dropping siglock to get both the tasklist lock
+		 * and siglock again in the proper order.  Note that
+		 * this allows an intervening SIGCONT to be posted.
+		 * We need to check for that and bail out if necessary.
 		 */
 		struct task_struct *t;
+
+		spin_unlock_irq(&sighand->siglock);
+
+		/* signals can be posted during this window */
+
 		read_lock(&tasklist_lock);
 		spin_lock_irq(&sighand->siglock);
 
@@ -1585,6 +1596,16 @@ do_signal_stop(int signr)
 			return;
 		}
 
+		if (unlikely(sig_avoid_stop_race())) {
+			/*
+			 * Either a SIGCONT or a SIGKILL signal was
+			 * posted in the siglock-not-held window.
+			 */
+			spin_unlock_irq(&sighand->siglock);
+			read_unlock(&tasklist_lock);
+			return;
+		}
+
 		if (sig->group_stop_count == 0) {
 			sig->group_exit_code = signr;
 			stop_count = 0;
@@ -1659,20 +1680,21 @@ static inline int handle_group_stop(void
 int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie)
 {
 	sigset_t *mask = &current->blocked;
+	int signr = 0;
 
+relock:
+	spin_lock_irq(&current->sighand->siglock);
 	for (;;) {
-		unsigned long signr = 0;
 		struct k_sigaction *ka;
 
-		spin_lock_irq(&current->sighand->siglock);
 		if (unlikely(current->signal->group_stop_count > 0) &&
 		    handle_group_stop())
-			continue;
+			goto relock;
+
 		signr = dequeue_signal(current, mask, info);
-		spin_unlock_irq(&current->sighand->siglock);
 
 		if (!signr)
-			break;
+			break; /* will return 0 */
 
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
 			ptrace_signal_deliver(regs, cookie);
@@ -1681,25 +1703,25 @@ int get_signal_to_deliver(siginfo_t *inf
 			 * If there is a group stop in progress,
 			 * we must participate in the bookkeeping.
 			 */
-			if (current->signal->group_stop_count > 0) {
-				spin_lock_irq(&current->sighand->siglock);
+			if (current->signal->group_stop_count > 0)
 				--current->signal->group_stop_count;
-				spin_unlock_irq(&current->sighand->siglock);
-			}
 
 			/* Let the debugger run.  */
 			current->exit_code = signr;
 			current->last_siginfo = info;
 			set_current_state(TASK_STOPPED);
+			spin_unlock_irq(&current->sighand->siglock);
 			notify_parent(current, SIGCHLD);
 			schedule();
 
 			current->last_siginfo = NULL;
 
 			/* We're back.  Did the debugger cancel the sig?  */
+			spin_lock_irq(&current->sighand->siglock);
 			signr = current->exit_code;
 			if (signr == 0)
 				continue;
+
 			current->exit_code = 0;
 
 			/* Update the siginfo structure if the signal has
@@ -1716,9 +1738,7 @@ int get_signal_to_deliver(siginfo_t *inf
 
 			/* If the (new) signal is now blocked, requeue it.  */
 			if (sigismember(&current->blocked, signr)) {
-				spin_lock_irq(&current->sighand->siglock);
 				specific_send_sig_info(signr, info, current);
-				spin_unlock_irq(&current->sighand->siglock);
 				continue;
 			}
 		}
@@ -1727,7 +1747,7 @@ int get_signal_to_deliver(siginfo_t *inf
 		if (ka->sa.sa_handler == SIG_IGN) /* Do nothing.  */
 			continue;
 		if (ka->sa.sa_handler != SIG_DFL) /* Run the handler.  */
-			return signr;
+			break; /* will return non-zero "signr" value */
 
 		/*
 		 * Now we are doing the default action for this signal.
@@ -1744,20 +1764,44 @@ int get_signal_to_deliver(siginfo_t *inf
 			 * The default action is to stop all threads in
 			 * the thread group.  The job control signals
 			 * do nothing in an orphaned pgrp, but SIGSTOP
-			 * always works.
+			 * always works.  Note that siglock needs to be
+			 * dropped during the call to is_orphaned_pgrp()
+			 * because of lock ordering with tasklist_lock.
+			 * This allows an intervening SIGCONT to be posted.
+			 * We need to check for that and bail out if necessary.
 			 */
-			if (signr == SIGSTOP ||
-			    !is_orphaned_pgrp(current->pgrp))
-				do_signal_stop(signr);
-			continue;
+			if (signr == SIGSTOP) {
+				do_signal_stop(signr); /* releases siglock */
+				goto relock;
+			}
+			spin_unlock_irq(&current->sighand->siglock);
+
+			/* signals can be posted during this window */
+
+			if (is_orphaned_pgrp(current->pgrp))
+				goto relock;
+
+			spin_lock_irq(&current->sighand->siglock);
+			if (unlikely(sig_avoid_stop_race())) {
+				/*
+				 * Either a SIGCONT or a SIGKILL signal was
+				 * posted in the siglock-not-held window.
+				 */
+				continue;
+			}
+
+			do_signal_stop(signr); /* releases siglock */
+			goto relock;
 		}
 
+		spin_unlock_irq(&current->sighand->siglock);
+
 		/*
 		 * Anything else is fatal, maybe with a core dump.
 		 */
 		current->flags |= PF_SIGNALED;
 		if (sig_kernel_coredump(signr) &&
-		    do_coredump(signr, signr, regs)) {
+		    do_coredump((long)signr, signr, regs)) {
 			/*
 			 * That killed all other threads in the group and
 			 * synchronized with their demise, so there can't
@@ -1771,8 +1815,8 @@ int get_signal_to_deliver(siginfo_t *inf
 			BUG_ON(!current->signal->group_exit);
 			BUG_ON(current->signal->group_exit_code != code);
 			do_exit(code);
-				/* NOTREACHED */
-			}
+			/* NOTREACHED */
+		}
 
 		/*
 		 * Death signals, no core dump.
@@ -1780,7 +1824,8 @@ int get_signal_to_deliver(siginfo_t *inf
 		do_group_exit(signr);
 		/* NOTREACHED */
 	}
-	return 0;
+	spin_unlock_irq(&current->sighand->siglock);
+	return signr;
 }
 
 #endif
