Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268533AbUHRAkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268533AbUHRAkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 20:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268534AbUHRAkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 20:40:41 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:47085 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S268533AbUHRAkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 20:40:25 -0400
Date: Tue, 17 Aug 2004 17:40:22 -0700
Message-Id: <200408180040.i7I0eM4l011117@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] notify_parent cleanup
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Stupendous riot caves
   (2) Corpulent trout sofas
   (3) Sulfurous baskets
   (4) Recalcitrant jungle scenarios
   (5) Allergic whimsical rice
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All extant uses of `notify_parent' are for ptrace stops, unless it is used
by external modules that I have not seen.  This patch tightens up some of
the signal code by making notify_parent only work for the stopped case.
That means that do_notify_parent is exclusively used for the dead case and
doesn't need to check for the stopped case.  The only outward effect of
this is to make ptrace stops (i.e. notify_parent calls) obey the
SA_NOCLDSTOP behavior instead of incorrectly checking SA_NOCLDWAIT.  I'm
sure no ptrace user actually sets SA_NOCLDSTOP, so it won't be noticed in
reality at all.  

I don't know why notify_parent is an exported symbol at all.  My
inclination would be to remove it as an exported symbol, and then probably
remove it entirely by cleaning up the callers to use ptrace_notify and
change the ptrace_notify calling convention so that works well.
Also, why is ptrace_notify exported?

This patch is relative to 2.6.8.1 + the waitid patches in -mm1.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6.8.1-waitid/kernel/signal.c.~1~	2004-08-16 04:24:36.000000000 -0700
+++ linux-2.6.8.1-waitid/kernel/signal.c	2004-08-17 17:19:07.012301380 -0700
@@ -1441,19 +1441,22 @@ static void __wake_up_parent(struct task
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
 
@@ -1467,34 +1470,19 @@ void do_notify_parent(struct task_struct
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
@@ -1525,19 +1513,20 @@ void do_notify_parent(struct task_struct
 
 /*
  * We need the tasklist lock because it's the only
- * thing that protects out "parent" pointer.
+ * thing that protects our "parent" pointer.
  *
- * exit.c calls "do_notify_parent()" directly, because
- * it already has the tasklist lock.
+ * This entrypoint was once used in other ways, but now it is
+ * only ever called as "notify_parent(current, SIGCHLD)" after
+ * entering TASK_STOPPED state.
  */
 void
 notify_parent(struct task_struct *tsk, int sig)
 {
-	if (sig != -1) {
-		read_lock(&tasklist_lock);
-		do_notify_parent(tsk, sig);
-		read_unlock(&tasklist_lock);
-	}
+	BUG_ON(sig != SIGCHLD);
+	BUG_ON(tsk->state != TASK_STOPPED);
+	read_lock(&tasklist_lock);
+	do_notify_parent_cldstop(tsk, tsk->parent);
+	read_unlock(&tasklist_lock);
 }
 
 static void
@@ -1562,6 +1551,8 @@ do_notify_parent_cldstop(struct task_str
 	if (info.si_status == 0) {
 		info.si_status = SIGCONT;
 		info.si_code = CLD_CONTINUED;
+	} else if (tsk->ptrace & PT_PTRACED) {
+		info.si_code = CLD_TRAPPED;
 	} else {
 		info.si_code = CLD_STOPPED;
 	}
