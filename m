Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVHRPY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVHRPY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 11:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVHRPY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 11:24:26 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:30625 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932253AbVHRPYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 11:24:25 -0400
Message-ID: <4304AA98.70CEA83B@tv-sign.ru>
Date: Thu, 18 Aug 2005 19:34:48 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] do_notify_parent_cldstop() cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] do_notify_parent_cldstop() cleanup

This patch simplifies the usage of do_notify_parent_cldstop(),
it lessens the source and .text size slightly, and makes the
code (in my opinion) a bit more readable.

I am sending this patch now because I'm afraid Paul will touch
do_notify_parent_cldstop() really soon, It's better to cleanup
first.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.13-rc6/kernel/signal.c~1_cldstop	2005-08-18 22:02:26.000000000 +0400
+++ 2.6.13-rc6/kernel/signal.c	2005-08-18 23:10:28.000000000 +0400
@@ -678,7 +678,7 @@ static int check_kill_permission(int sig
 
 /* forward decl */
 static void do_notify_parent_cldstop(struct task_struct *tsk,
-				     struct task_struct *parent,
+				     int to_self,
 				     int why);
 
 /*
@@ -729,14 +729,7 @@ static void handle_stop_signal(int sig, 
 			p->signal->group_stop_count = 0;
 			p->signal->flags = SIGNAL_STOP_CONTINUED;
 			spin_unlock(&p->sighand->siglock);
-			if (p->ptrace & PT_PTRACED)
-				do_notify_parent_cldstop(p, p->parent,
-							 CLD_STOPPED);
-			else
-				do_notify_parent_cldstop(
-					p->group_leader,
-					p->group_leader->real_parent,
-							 CLD_STOPPED);
+			do_notify_parent_cldstop(p, (p->ptrace & PT_PTRACED), CLD_STOPPED);
 			spin_lock(&p->sighand->siglock);
 		}
 		rm_from_queue(SIG_KERNEL_STOP_MASK, &p->signal->shared_pending);
@@ -777,14 +770,7 @@ static void handle_stop_signal(int sig, 
 			p->signal->flags = SIGNAL_STOP_CONTINUED;
 			p->signal->group_exit_code = 0;
 			spin_unlock(&p->sighand->siglock);
-			if (p->ptrace & PT_PTRACED)
-				do_notify_parent_cldstop(p, p->parent,
-							 CLD_CONTINUED);
-			else
-				do_notify_parent_cldstop(
-					p->group_leader,
-					p->group_leader->real_parent,
-							 CLD_CONTINUED);
+			do_notify_parent_cldstop(p, (p->ptrace & PT_PTRACED), CLD_CONTINUED);
 			spin_lock(&p->sighand->siglock);
 		} else {
 			/*
@@ -1542,14 +1528,20 @@ void do_notify_parent(struct task_struct
 	spin_unlock_irqrestore(&psig->siglock, flags);
 }
 
-static void
-do_notify_parent_cldstop(struct task_struct *tsk, struct task_struct *parent,
-			 int why)
+static void do_notify_parent_cldstop(struct task_struct *tsk, int to_self, int why)
 {
 	struct siginfo info;
 	unsigned long flags;
+	struct task_struct *parent;
 	struct sighand_struct *sighand;
 
+	if (to_self)
+		parent = tsk->parent;
+	else {
+		tsk = tsk->group_leader;
+		parent = tsk->real_parent;
+	}
+
 	info.si_signo = SIGCHLD;
 	info.si_errno = 0;
 	info.si_pid = tsk->pid;
@@ -1618,8 +1610,7 @@ static void ptrace_stop(int exit_code, i
 		   !(current->ptrace & PT_ATTACHED)) &&
 	    (likely(current->parent->signal != current->signal) ||
 	     !unlikely(current->signal->flags & SIGNAL_GROUP_EXIT))) {
-		do_notify_parent_cldstop(current, current->parent,
-					 CLD_TRAPPED);
+		do_notify_parent_cldstop(current, 1, CLD_TRAPPED);
 		read_unlock(&tasklist_lock);
 		schedule();
 	} else {
@@ -1668,25 +1659,25 @@ void ptrace_notify(int exit_code)
 static void
 finish_stop(int stop_count)
 {
+	int to_self;
+
 	/*
 	 * If there are no other threads in the group, or if there is
 	 * a group stop in progress and we are the last to stop,
 	 * report to the parent.  When ptraced, every thread reports itself.
 	 */
-	if (stop_count < 0 || (current->ptrace & PT_PTRACED)) {
-		read_lock(&tasklist_lock);
-		do_notify_parent_cldstop(current, current->parent,
-					 CLD_STOPPED);
-		read_unlock(&tasklist_lock);
-	}
-	else if (stop_count == 0) {
-		read_lock(&tasklist_lock);
-		do_notify_parent_cldstop(current->group_leader,
-					 current->group_leader->real_parent,
-					 CLD_STOPPED);
-		read_unlock(&tasklist_lock);
-	}
+	if (stop_count < 0 || (current->ptrace & PT_PTRACED))
+		to_self = 1;
+	else if (stop_count == 0)
+		to_self = 0;
+	else
+		goto out;
 
+	read_lock(&tasklist_lock);
+	do_notify_parent_cldstop(current, to_self, CLD_STOPPED);
+	read_unlock(&tasklist_lock);
+
+out:
 	schedule();
 	/*
 	 * Now we don't run again until continued.
