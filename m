Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbULCAC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbULCAC0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 19:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbULCAC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 19:02:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22464 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261809AbULCACJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 19:02:09 -0500
Date: Thu, 2 Dec 2004 16:01:59 -0800
Message-Id: <200412030001.iB301xXh001328@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] move group_exit flag into signal_struct.flags word
X-Shopping-List: (1) Deviant malignant salmon skis
   (2) Eloquent birds
   (3) Simultaneous parasitic exclamations
   (4) Runcible laser horsie
   (5) Tremulous inhibition pistons
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After my last change, there are plenty of unused bits available in the new
flags word in signal_struct.  This patch moves the `group_exit' flag into
one of those bits, saving a word in signal_struct.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/include/linux/sched.h 17 Nov 2004 23:33:04 -0000
+++ linux-2.6/include/linux/sched.h 17 Nov 2004 23:44:51 -0000
@@ -276,7 +276,6 @@
 	struct sigpending	shared_pending;
 
 	/* thread group exit support */
-	int			group_exit;
 	int			group_exit_code;
 	/* overloaded:
 	 * - notify group_exit_task when ->count is equal to notify_count
@@ -330,6 +329,7 @@
 #define SIGNAL_STOP_STOPPED	0x00000001 /* job control stop in effect */
 #define SIGNAL_STOP_DEQUEUED	0x00000002 /* stop signal dequeued */
 #define SIGNAL_STOP_CONTINUED	0x00000004 /* SIGCONT since WCONTINUED reap */
+#define SIGNAL_GROUP_EXIT	0x00000008 /* group exit in progress */
 
 
 /*
--- linux-2.6/kernel/exit.c 17 Nov 2004 23:33:04 -0000
+++ linux-2.6/kernel/exit.c 17 Nov 2004 23:44:51 -0000
@@ -658,7 +658,7 @@
 	struct task_struct *t;
 	struct list_head ptrace_dead, *_p, *_n;
 
-	if (signal_pending(tsk) && !tsk->signal->group_exit
+	if (signal_pending(tsk) && !(tsk->signal->flags & SIGNAL_GROUP_EXIT)
 	    && !thread_group_empty(tsk)) {
 		/*
 		 * This occurs when there was a race between our exit
@@ -879,18 +879,18 @@
 {
 	BUG_ON(exit_code & 0x80); /* core dumps don't get here */
 
-	if (current->signal->group_exit)
+	if (current->signal->flags & SIGNAL_GROUP_EXIT)
 		exit_code = current->signal->group_exit_code;
 	else if (!thread_group_empty(current)) {
 		struct signal_struct *const sig = current->signal;
 		struct sighand_struct *const sighand = current->sighand;
 		read_lock(&tasklist_lock);
 		spin_lock_irq(&sighand->siglock);
-		if (sig->group_exit)
+		if (sig->flags & SIGNAL_GROUP_EXIT)
 			/* Another thread got here before we took the lock.  */
 			exit_code = sig->group_exit_code;
 		else {
-			sig->group_exit = 1;
+			sig->flags = SIGNAL_GROUP_EXIT;
 			sig->group_exit_code = exit_code;
 			zap_other_threads(current);
 		}
@@ -1070,7 +1070,7 @@
 	read_unlock(&tasklist_lock);
 
 	retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
-	status = p->signal->group_exit
+	status = (p->signal->flags & SIGNAL_GROUP_EXIT)
 		? p->signal->group_exit_code : p->exit_code;
 	if (!retval && stat_addr)
 		retval = put_user(status, stat_addr);
--- linux-2.6/kernel/fork.c 17 Nov 2004 23:34:45 -0000
+++ linux-2.6/kernel/fork.c 17 Nov 2004 23:44:51 -0000
@@ -730,7 +730,6 @@
 	atomic_set(&sig->count, 1);
 	atomic_set(&sig->live, 1);
 	sig->flags = 0;
-	sig->group_exit = 0;
 	sig->group_exit_code = 0;
 	sig->group_exit_task = NULL;
 	sig->group_stop_count = 0;
@@ -985,7 +984,7 @@
 		 * do not create this new thread - the whole thread
 		 * group is supposed to exit anyway.
 		 */
-		if (current->signal->group_exit) {
+		if (current->signal->flags & SIGNAL_GROUP_EXIT) {
 			spin_unlock(&current->sighand->siglock);
 			write_unlock_irq(&tasklist_lock);
 			retval = -EAGAIN;
--- linux-2.6/kernel/signal.c 17 Nov 2004 23:42:16 -0000
+++ linux-2.6/kernel/signal.c 17 Nov 2004 23:44:51 -0000
@@ -669,6 +669,12 @@
 {
 	struct task_struct *t;
 
+	if (p->flags & SIGNAL_GROUP_EXIT)
+		/*
+		 * The process is in the middle of dying already.
+		 */
+		return;
+
 	if (sig_kernel_stop(sig)) {
 		/*
 		 * This is a stop signal.  Remove SIGCONT from all queues.
@@ -984,7 +990,7 @@
 	 * Found a killable thread.  If the signal will be fatal,
 	 * then start taking the whole group down immediately.
 	 */
-	if (sig_fatal(p, sig) && !p->signal->group_exit &&
+	if (sig_fatal(p, sig) && !(p->signal->flags & SIGNAL_GROUP_EXIT) &&
 	    !sigismember(&t->real_blocked, sig) &&
 	    (sig == SIGKILL || !(t->ptrace & PT_PTRACED))) {
 		/*
@@ -997,10 +1003,9 @@
 			 * running and doing things after a slower
 			 * thread has the fatal signal pending.
 			 */
-			p->signal->group_exit = 1;
+			p->signal->flags = SIGNAL_GROUP_EXIT;
 			p->signal->group_exit_code = sig;
 			p->signal->group_stop_count = 0;
-			p->signal->flags = 0;
 			t = p;
 			do {
 				sigaddset(&t->pending.signal, SIGKILL);
@@ -1087,8 +1092,8 @@
 {
 	struct task_struct *t;
 
+	p->signal->flags = SIGNAL_GROUP_EXIT;
 	p->signal->group_stop_count = 0;
-	p->signal->flags = 0;
 
 	if (thread_group_empty(p))
 		return;
@@ -1793,7 +1798,7 @@
 		return 0;
 	}
 
-	if (current->signal->group_exit)
+	if (current->signal->flags & SIGNAL_GROUP_EXIT)
 		/*
 		 * Group stop is so another thread can do a core dump,
 		 * or else we are racing against a death signal.
--- linux-2.6/fs/exec.c 17 Nov 2004 01:38:48 -0000 1.150
+++ linux-2.6/fs/exec.c 17 Nov 2004 23:46:57 -0000
@@ -596,3 +596,3 @@
 	spin_lock_irq(lock);
-	if (sig->group_exit) {
+	if (sig->flags & SIGNAL_GROUP_EXIT) {
 		/*
@@ -606,3 +606,2 @@
 	}
-	sig->group_exit = 1;
 	zap_other_threads(current);
@@ -704,3 +703,3 @@
 	 */
-	sig->group_exit = 0;
+	sig->flags = 0;
 
@@ -1387,3 +1386,3 @@
 	init_completion(&mm->core_done);
-	current->signal->group_exit = 1;
+	current->signal->flags = SIGNAL_GROUP_EXIT;
 	current->signal->group_exit_code = exit_code;
