Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbULCAXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbULCAXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 19:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbULCAXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 19:23:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:719 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261812AbULCAXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 19:23:22 -0500
Date: Thu, 2 Dec 2004 16:23:16 -0800
Message-Id: <200412030023.iB30NGpR001421@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix ptracer death race yielding bogus BUG_ON
X-Windows: warn your friends about it.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a BUG_ON in ptrace_stop that hits if the thread is not ptraced.
However, there is no synchronization between a thread deciding to do a
ptrace stop and so going here, and its ptracer dying and so detaching from
it and clearing its ->ptrace field.  

The RHEL3 2.4-based kernel has a backport of a slightly older version of
the 2.6 signals code, which has a different but equivalent BUG_ON.  This
actually bit users in practice (when the debugger dies), but was
exceedingly difficult to reproduce in contrived circumstances.  We moved
forward in RHEL3 just by removing the BUG_ON, and that fixed the real user
problems even though I was never able to reproduce the scenario myself.
So, to my knowledge this scenario has never actually been seen in practice
under 2.6.  But it's plain to see from the code that it is indeed possible.

This patch removes that BUG_ON, but also goes further and tries to handle
this case more gracefully than simply avoiding the crash.  By removing the
BUG_ON alone, it becomes possible for the real parent of a process to see
spurious SIGCHLD notifications intended for the debugger that has just
died, and have its child wind up stopped unexpectedly.  This patch avoids
that possibility by detecting the case when we are about to do the ptrace
stop but our ptracer has gone away, and simply eliding that ptrace stop
altogether as if we hadn't been ptraced when we hit the interesting event
(signal or ptrace_notify call for syscall tracing or something like that).


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

Index: linux-2.6/kernel/signal.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/signal.c,v
retrieving revision 1.139
diff -B -p -u -r1.139 signal.c
--- linux-2.6/kernel/signal.c 16 Sep 2004 14:12:54 -0000 1.139
+++ linux-2.6/kernel/signal.c 28 Sep 2004 01:19:09 -0000
@@ -1592,11 +1592,12 @@ do_notify_parent_cldstop(struct task_str
  * We always set current->last_siginfo while stopped here.
  * That makes it a way to test a stopped process for
  * being ptrace-stopped vs being job-control-stopped.
+ *
+ * If we actually decide not to stop at all because the tracer is gone,
+ * we leave nostop_code in current->exit_code.
  */
-static void ptrace_stop(int exit_code, siginfo_t *info)
+static void ptrace_stop(int exit_code, int nostop_code, siginfo_t *info)
 {
-	BUG_ON(!(current->ptrace & PT_PTRACED));
-
 	/*
 	 * If there is a group stop in progress,
 	 * we must participate in the bookkeeping.
@@ -1611,9 +1612,22 @@ static void ptrace_stop(int exit_code, s
 	set_current_state(TASK_TRACED);
 	spin_unlock_irq(&current->sighand->siglock);
 	read_lock(&tasklist_lock);
-	do_notify_parent_cldstop(current, current->parent, CLD_TRAPPED);
-	read_unlock(&tasklist_lock);
-	schedule();
+	if (likely(current->ptrace & PT_PTRACED) &&
+	    likely(current->parent != current->real_parent ||
+		   !(current->ptrace & PT_ATTACHED))) {
+		do_notify_parent_cldstop(current, current->parent,
+					 CLD_TRAPPED);
+		read_unlock(&tasklist_lock);
+		schedule();
+	} else {
+		/*
+		 * By the time we got the lock, our tracer went away.
+		 * Don't stop here.
+		 */
+		read_unlock(&tasklist_lock);
+		set_current_state(TASK_RUNNING);
+		current->exit_code = nostop_code;
+	}
 
 	/*
 	 * We are back.  Now reacquire the siglock before touching
@@ -1644,7 +1658,7 @@ void ptrace_notify(int exit_code)
 
 	/* Let the debugger run.  */
 	spin_lock_irq(&current->sighand->siglock);
-	ptrace_stop(exit_code, &info);
+	ptrace_stop(exit_code, 0, &info);
 	spin_unlock_irq(&current->sighand->siglock);
 }
 
@@ -1852,7 +1866,7 @@ relock:
 			ptrace_signal_deliver(regs, cookie);
 
 			/* Let the debugger run.  */
-			ptrace_stop(signr, info);
+			ptrace_stop(signr, signr, info);
 
 			/* We're back.  Did the debugger cancel the sig?  */
 			signr = current->exit_code;
