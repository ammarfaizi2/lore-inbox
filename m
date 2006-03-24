Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWCXQQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWCXQQv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWCXQQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:16:51 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:60841 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932412AbWCXQQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:16:49 -0500
Message-ID: <44241ABF.FC55B76C@tv-sign.ru>
Date: Fri, 24 Mar 2006 19:13:51 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>
Subject: [PATCH 2.6.16-mm1 3/3] do_notify_parent_cldstop: remove 'to_self' param
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch has changed callsites of do_notify_parent_cldstop()
so that to_self == (->ptrace & PT_PTRACED) always (as it should be). We
can remove this parameter now.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/signal.c~4_DNPS	2006-03-24 20:48:12.000000000 +0300
+++ MM/kernel/signal.c	2006-03-24 21:24:33.000000000 +0300
@@ -591,9 +591,7 @@ static int check_kill_permission(int sig
 }
 
 /* forward decl */
-static void do_notify_parent_cldstop(struct task_struct *tsk,
-				     int to_self,
-				     int why);
+static void do_notify_parent_cldstop(struct task_struct *tsk, int why);
 
 /*
  * Handle magic process-wide effects of stop/continue signals.
@@ -643,7 +641,7 @@ static void handle_stop_signal(int sig, 
 			p->signal->group_stop_count = 0;
 			p->signal->flags = SIGNAL_STOP_CONTINUED;
 			spin_unlock(&p->sighand->siglock);
-			do_notify_parent_cldstop(p, (p->ptrace & PT_PTRACED), CLD_STOPPED);
+			do_notify_parent_cldstop(p, CLD_STOPPED);
 			spin_lock(&p->sighand->siglock);
 		}
 		rm_from_queue(SIG_KERNEL_STOP_MASK, &p->signal->shared_pending);
@@ -684,7 +682,7 @@ static void handle_stop_signal(int sig, 
 			p->signal->flags = SIGNAL_STOP_CONTINUED;
 			p->signal->group_exit_code = 0;
 			spin_unlock(&p->sighand->siglock);
-			do_notify_parent_cldstop(p, (p->ptrace & PT_PTRACED), CLD_CONTINUED);
+			do_notify_parent_cldstop(p, CLD_CONTINUED);
 			spin_lock(&p->sighand->siglock);
 		} else {
 			/*
@@ -1519,14 +1517,14 @@ void do_notify_parent(struct task_struct
 	spin_unlock_irqrestore(&psig->siglock, flags);
 }
 
-static void do_notify_parent_cldstop(struct task_struct *tsk, int to_self, int why)
+static void do_notify_parent_cldstop(struct task_struct *tsk, int why)
 {
 	struct siginfo info;
 	unsigned long flags;
 	struct task_struct *parent;
 	struct sighand_struct *sighand;
 
-	if (to_self)
+	if (tsk->ptrace & PT_PTRACED)
 		parent = tsk->parent;
 	else {
 		tsk = tsk->group_leader;
@@ -1601,7 +1599,7 @@ static void ptrace_stop(int exit_code, i
 		   !(current->ptrace & PT_ATTACHED)) &&
 	    (likely(current->parent->signal != current->signal) ||
 	     !unlikely(current->signal->flags & SIGNAL_GROUP_EXIT))) {
-		do_notify_parent_cldstop(current, 1, CLD_TRAPPED);
+		do_notify_parent_cldstop(current, CLD_TRAPPED);
 		read_unlock(&tasklist_lock);
 		schedule();
 	} else {
@@ -1650,25 +1648,17 @@ void ptrace_notify(int exit_code)
 static void
 finish_stop(int stop_count)
 {
-	int to_self;
-
 	/*
 	 * If there are no other threads in the group, or if there is
 	 * a group stop in progress and we are the last to stop,
 	 * report to the parent.  When ptraced, every thread reports itself.
 	 */
-	if (current->ptrace & PT_PTRACED)
-		to_self = 1;
-	else if (stop_count == 0)
-		to_self = 0;
-	else
-		goto out;
-
-	read_lock(&tasklist_lock);
-	do_notify_parent_cldstop(current, to_self, CLD_STOPPED);
-	read_unlock(&tasklist_lock);
+	if (stop_count == 0 || (current->ptrace & PT_PTRACED)) {
+		read_lock(&tasklist_lock);
+		do_notify_parent_cldstop(current, CLD_STOPPED);
+		read_unlock(&tasklist_lock);
+	}
 
-out:
 	schedule();
 	/*
 	 * Now we don't run again until continued.
