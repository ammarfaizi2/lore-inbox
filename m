Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319094AbSIJJwd>; Tue, 10 Sep 2002 05:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319095AbSIJJwd>; Tue, 10 Sep 2002 05:52:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37082 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319094AbSIJJwa>;
	Tue, 10 Sep 2002 05:52:30 -0400
Date: Tue, 10 Sep 2002 12:01:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Daniel Jacobowitz <dan@debian.org>
Subject: [patch] Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <Pine.LNX.4.33.0209091351590.1818-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209101150150.4896-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) fixes the lockup.

The bug happened because reparenting in the CLONE_THREAD case was done in
a fundamentally non-atomic way, which was asking for various races to
happen: eg. the target parent gets reparented to the currently exiting
thread ...

(the non-CLONE_THREAD case is safe because nothing reparents init.)

the solution is to make all of reparenting atomic (including the
forget_original_parent() bit) - this is possible with some reorganization
done in signal.c and exit.c. This also made some of the loops simpler.

(the kernel has now survived 30 minutes of an extreme-threading test,
which would produce a lockup within 1 minute formerly.)

(btw., the lockup is not unique to SMP, it could also have happen on UP
with preempt enabled.)

	Ingo

--- linux/include/linux/sched.h.orig	Mon Sep  9 23:14:26 2002
+++ linux/include/linux/sched.h	Tue Sep 10 11:44:40 2002
@@ -547,6 +547,7 @@
 extern void unblock_all_signals(void);
 extern int send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int force_sig_info(int, struct siginfo *, struct task_struct *);
+extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
 extern int kill_pg_info(int, struct siginfo *, pid_t);
 extern int kill_sl_info(int, struct siginfo *, pid_t);
 extern int kill_proc_info(int, struct siginfo *, pid_t);
--- linux/kernel/exit.c.orig	Mon Sep  9 21:59:24 2002
+++ linux/kernel/exit.c	Tue Sep 10 11:47:48 2002
@@ -125,11 +125,10 @@
  *
  * "I ask you, have you ever known what it is to be an orphan?"
  */
-static int will_become_orphaned_pgrp(int pgrp, struct task_struct * ignored_task)
+static int __will_become_orphaned_pgrp(int pgrp, struct task_struct * ignored_task)
 {
 	struct task_struct *p;
 
-	read_lock(&tasklist_lock);
 	for_each_task(p) {
 		if ((p == ignored_task) || (p->pgrp != pgrp) ||
 		    (p->state == TASK_ZOMBIE) ||
@@ -137,25 +136,33 @@
 			continue;
 		if ((p->parent->pgrp != pgrp) &&
 		    (p->parent->session == p->session)) {
-			read_unlock(&tasklist_lock);
  			return 0;
 		}
 	}
-	read_unlock(&tasklist_lock);
 	return 1;	/* (sighing) "Often!" */
 }
 
+static int will_become_orphaned_pgrp(int pgrp, struct task_struct * ignored_task)
+{
+	int retval;
+
+	read_lock(&tasklist_lock);
+	retval = __will_become_orphaned_pgrp(pgrp, ignored_task);
+	read_unlock(&tasklist_lock);
+
+	return retval;
+}
+
 int is_orphaned_pgrp(int pgrp)
 {
 	return will_become_orphaned_pgrp(pgrp, 0);
 }
 
-static inline int has_stopped_jobs(int pgrp)
+static inline int __has_stopped_jobs(int pgrp)
 {
 	int retval = 0;
 	struct task_struct * p;
 
-	read_lock(&tasklist_lock);
 	for_each_task(p) {
 		if (p->pgrp != pgrp)
 			continue;
@@ -164,7 +171,17 @@
 		retval = 1;
 		break;
 	}
+	return retval;
+}
+
+static inline int has_stopped_jobs(int pgrp)
+{
+	int retval;
+
+	read_lock(&tasklist_lock);
+	retval = __has_stopped_jobs(pgrp);
 	read_unlock(&tasklist_lock);
+
 	return retval;
 }
 
@@ -253,6 +270,8 @@
 		p->real_parent = child_reaper;
 	else
 		p->real_parent = reaper;
+	if (p->parent == p->real_parent)
+		BUG();
 
 	if (p->pdeath_signal)
 		send_sig(p->pdeath_signal, p, 0);
@@ -416,8 +435,6 @@
 	struct task_struct *p, *reaper = father;
 	struct list_head *_p;
 
-	write_lock_irq(&tasklist_lock);
-
 	if (father->exit_signal != -1)
 		reaper = prev_thread(reaper);
 	else
@@ -442,7 +459,6 @@
 		p = list_entry(_p,struct task_struct,ptrace_list);
 		reparent_thread(p, reaper, child_reaper);
 	}
-	write_unlock_irq(&tasklist_lock);
 }
 
 static inline void zap_thread(task_t *p, task_t *father, int traced)
@@ -477,12 +493,10 @@
 	    (p->session == current->session)) {
 		int pgrp = p->pgrp;
 
-		write_unlock_irq(&tasklist_lock);
-		if (is_orphaned_pgrp(pgrp) && has_stopped_jobs(pgrp)) {
-			kill_pg(pgrp,SIGHUP,1);
-			kill_pg(pgrp,SIGCONT,1);
+		if (__will_become_orphaned_pgrp(pgrp, 0) && __has_stopped_jobs(pgrp)) {
+			__kill_pg_info(SIGHUP, (void *)1, pgrp);
+			__kill_pg_info(SIGCONT, (void *)1, pgrp);
 		}
-		write_lock_irq(&tasklist_lock);
 	}
 }
 
@@ -493,7 +507,8 @@
 static void exit_notify(void)
 {
 	struct task_struct *t;
-	struct list_head *_p, *_n;
+
+	write_lock_irq(&tasklist_lock);
 
 	forget_original_parent(current);
 	/*
@@ -510,10 +525,10 @@
 	
 	if ((t->pgrp != current->pgrp) &&
 	    (t->session == current->session) &&
-	    will_become_orphaned_pgrp(current->pgrp, current) &&
-	    has_stopped_jobs(current->pgrp)) {
-		kill_pg(current->pgrp,SIGHUP,1);
-		kill_pg(current->pgrp,SIGCONT,1);
+	    __will_become_orphaned_pgrp(current->pgrp, current) &&
+	    __has_stopped_jobs(current->pgrp)) {
+		__kill_pg_info(SIGHUP, (void *)1, current->pgrp);
+		__kill_pg_info(SIGCONT, (void *)1, current->pgrp);
 	}
 
 	/* Let father know we died 
@@ -548,24 +563,16 @@
 	 *	jobs, send them a SIGHUP and then a SIGCONT.  (POSIX 3.2.2.2)
 	 */
 
-	write_lock_irq(&tasklist_lock);
 	current->state = TASK_ZOMBIE;
 	if (current->exit_signal != -1)
 		do_notify_parent(current, current->exit_signal);
 
 zap_again:
-	list_for_each_safe(_p, _n, &current->children)
-		zap_thread(list_entry(_p,struct task_struct,sibling), current, 0);
-	list_for_each_safe(_p, _n, &current->ptrace_children)
-		zap_thread(list_entry(_p,struct task_struct,ptrace_list), current, 1);
-	/*
-	 * zap_thread might drop the tasklist lock, thus we could
-	 * have new children queued back from the ptrace list into the
-	 * child list:
-	 */
-	if (unlikely(!list_empty(&current->children) ||
-			!list_empty(&current->ptrace_children)))
-		goto zap_again;
+	while (!list_empty(&current->children))
+		zap_thread(list_entry(current->children.next,struct task_struct,sibling), current, 0);
+	while (!list_empty(&current->ptrace_children))
+		zap_thread(list_entry(current->ptrace_children.next,struct task_struct,sibling), current, 1);
+	BUG_ON(!list_empty(&current->children));
 	/*
 	 * No need to unlock IRQs, we'll schedule() immediately
 	 * anyway. In the preemption case this also makes it
--- linux/kernel/signal.c.orig	Mon Sep  9 23:09:06 2002
+++ linux/kernel/signal.c	Mon Sep  9 23:14:12 2002
@@ -881,15 +881,13 @@
  * control characters do (^C, ^Z etc)
  */
 
-int
-kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
+int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
 {
 	int retval = -EINVAL;
 	if (pgrp > 0) {
 		struct task_struct *p;
 
 		retval = -ESRCH;
-		read_lock(&tasklist_lock);
 		for_each_task(p) {
 			if (p->pgrp == pgrp && thread_group_leader(p)) {
 				int err = send_sig_info(sig, info, p);
@@ -897,8 +895,19 @@
 					retval = err;
 			}
 		}
-		read_unlock(&tasklist_lock);
 	}
+	return retval;
+}
+
+int
+kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
+{
+	int retval;
+
+	read_lock(&tasklist_lock);
+	retval = __kill_pg_info(sig, info, pgrp);
+	read_unlock(&tasklist_lock);
+
 	return retval;
 }
 

