Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319579AbSIMKDa>; Fri, 13 Sep 2002 06:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319592AbSIMKD3>; Fri, 13 Sep 2002 06:03:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65245 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319579AbSIMKD1>;
	Fri, 13 Sep 2002 06:03:27 -0400
Date: Fri, 13 Sep 2002 12:14:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sys_exit() threading improvements, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209121011290.5719-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209131207510.672-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch implements the 'keep the initial thread around until every
thread in the group exits' concept in a different, less intrusive way,
along your suggestions. There is no exit_done completion handling anymore,
freeing of the task is still done by wait4(). This has the following
side-effect: detached threads/processes can only be started within a
thread group, not in a standalone way.

(the patch also fixes the bugs introduced by the ->exit_done code, which
made it possible for a zombie task to be reactivated.)

i've introduced the p->group_leader pointer, which can/will be used for
other purposes in the future as well - since from now on the thread group
leader is always existent. Right now it's used to notify the parent of the
thread group leader from the last non-leader thread that exits [if the
thread group leader is a zombie already].

	Ingo

--- linux/include/linux/sched.h.orig	Fri Sep 13 11:32:03 2002
+++ linux/include/linux/sched.h	Fri Sep 13 11:38:02 2002
@@ -219,8 +219,6 @@
 	/* thread group exit support */
 	int			group_exit;
 	int			group_exit_code;
-
-	struct completion	group_exit_done;
 };
 
 /*
@@ -316,6 +314,7 @@
 	struct task_struct *parent;	/* parent process */
 	struct list_head children;	/* list of my children */
 	struct list_head sibling;	/* linkage in my parent's children list */
+	struct task_struct *group_leader;
 	struct list_head thread_group;
 
 	/* PID hash table linkage. */
@@ -826,6 +825,9 @@
 }
 
 #define thread_group_leader(p)	(p->pid == p->tgid)
+
+#define delay_group_leader(p) \
+	(p->tgid == p->pid && !list_empty(&p->thread_group))
 
 extern void unhash_process(struct task_struct *p);
 
--- linux/include/linux/init_task.h.orig	Fri Sep 13 11:35:03 2002
+++ linux/include/linux/init_task.h	Fri Sep 13 11:35:14 2002
@@ -61,6 +61,7 @@
 	.parent		= &tsk,						\
 	.children	= LIST_HEAD_INIT(tsk.children),			\
 	.sibling	= LIST_HEAD_INIT(tsk.sibling),			\
+	.group_leader	= &tsk,						\
 	.thread_group	= LIST_HEAD_INIT(tsk.thread_group),		\
 	.wait_chldexit	= __WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
 	.real_timer	= {						\
--- linux/fs/exec.c.orig	Fri Sep 13 11:38:12 2002
+++ linux/fs/exec.c	Fri Sep 13 11:38:17 2002
@@ -515,7 +515,6 @@
 	atomic_set(&newsig->count, 1);
 	newsig->group_exit = 0;
 	newsig->group_exit_code = 0;
-	init_completion(&newsig->group_exit_done);
 	memcpy(newsig->action, current->sig->action, sizeof(newsig->action));
 	init_sigpending(&newsig->shared_pending);
 
--- linux/kernel/exit.c.orig	Fri Sep 13 10:28:51 2002
+++ linux/kernel/exit.c	Fri Sep 13 12:07:25 2002
@@ -583,7 +583,6 @@
 	 *	jobs, send them a SIGHUP and then a SIGCONT.  (POSIX 3.2.2.2)
 	 */
 
-	current->state = TASK_ZOMBIE;
 	if (current->exit_signal != -1)
 		do_notify_parent(current, current->exit_signal);
 
@@ -592,6 +591,8 @@
 	while (!list_empty(&current->ptrace_children))
 		zap_thread(list_entry(current->ptrace_children.next,struct task_struct,ptrace_list), current, 1);
 	BUG_ON(!list_empty(&current->children));
+
+	current->state = TASK_ZOMBIE;
 	/*
 	 * No need to unlock IRQs, we'll schedule() immediately
 	 * anyway. In the preemption case this also makes it
@@ -697,9 +698,9 @@
 	do_exit(sig->group_exit_code);
 }
 
-static inline int eligible_child(pid_t pid, int options, task_t *p)
+static int eligible_child(pid_t pid, int options, task_t *p)
 {
-	if (pid>0) {
+	if (pid > 0) {
 		if (p->pid != pid)
 			return 0;
 	} else if (!pid) {
@@ -725,6 +726,12 @@
 	if (((p->exit_signal != SIGCHLD) ^ ((options & __WCLONE) != 0))
 	    && !(options & __WALL))
 		return 0;
+	/*
+	 * Do not consider thread group leaders that are
+	 * in a non-empty thread group:
+	 */
+	if (current->tgid != p->tgid && delay_group_leader(p))
+		return 0;
 
 	if (security_ops->task_wait(p))
 		return 0;
@@ -781,8 +788,12 @@
 				current->cstime += p->stime + p->cstime;
 				read_unlock(&tasklist_lock);
 				retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
-				if (!retval && stat_addr)
-					retval = put_user(p->exit_code, stat_addr);
+				if (!retval && stat_addr) {
+					if (p->sig->group_exit)
+						retval = put_user(p->sig->group_exit_code, stat_addr);
+					else
+						retval = put_user(p->exit_code, stat_addr);
+				}
 				if (retval)
 					goto end_wait4; 
 				retval = p->pid;
--- linux/kernel/signal.c.orig	Fri Sep 13 10:29:45 2002
+++ linux/kernel/signal.c	Fri Sep 13 11:59:24 2002
@@ -251,23 +251,6 @@
 	if (!atomic_read(&sig->count))
 		BUG();
 	spin_lock(&sig->siglock);
-	/*
-	 * Do not let the thread group leader exit until all other
-	 * threads are done:
-	 */
-	while (!list_empty(&current->thread_group) &&
-			current->tgid == current->pid &&
-			atomic_read(&sig->count) > 1) {
-
-		spin_unlock(&sig->siglock);
-		write_unlock_irq(&tasklist_lock);
-
-		wait_for_completion(&sig->group_exit_done);
-
-		write_lock_irq(&tasklist_lock);
-		spin_lock(&sig->siglock);
-	}
-
 	spin_lock(&tsk->sigmask_lock);
 	tsk->sig = NULL;
 	if (atomic_dec_and_test(&sig->count)) {
@@ -276,10 +259,21 @@
 		flush_sigqueue(&sig->shared_pending);
 		kmem_cache_free(sigact_cachep, sig);
 	} else {
-		if (!list_empty(&current->thread_group) &&
-					atomic_read(&sig->count) == 1)
-			complete(&sig->group_exit_done);
-		__remove_thread_group(tsk, sig);
+		struct task_struct *leader = tsk->group_leader;
+		/*
+		 * If we are the last non-leader member of the thread
+		 * group, and the leader is zombie, then notify the
+		 * group leader's parent process.
+		 *
+		 * (subtle: here we also rely on the fact that if we are the
+		 *  thread group leader then we are not zombied yet.)
+		 */
+		if (atomic_read(&sig->count) == 1 &&
+					leader->state == TASK_ZOMBIE) {
+			__remove_thread_group(tsk, sig);
+			do_notify_parent(leader, leader->exit_signal);
+		} else
+			__remove_thread_group(tsk, sig);
 		spin_unlock(&sig->siglock);
 	}
 	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
@@ -1096,6 +1090,8 @@
 	struct siginfo info;
 	int why, status;
 
+	if (delay_group_leader(tsk))
+		return;
 	if (sig == -1)
 		BUG();
 
--- linux/kernel/fork.c.orig	Fri Sep 13 11:38:28 2002
+++ linux/kernel/fork.c	Fri Sep 13 11:59:13 2002
@@ -628,7 +628,6 @@
 	atomic_set(&sig->count, 1);
 	sig->group_exit = 0;
 	sig->group_exit_code = 0;
-	init_completion(&sig->group_exit_done);
 	memcpy(sig->action, current->sig->action, sizeof(sig->action));
 	sig->curr_target = NULL;
 	init_sigpending(&sig->shared_pending);
@@ -672,6 +671,12 @@
 	 */
 	if (clone_flags & CLONE_THREAD)
 		clone_flags |= CLONE_SIGHAND;
+	/*
+	 * Detached threads can only be started up within the thread
+	 * group.
+	 */
+	if (clone_flags & CLONE_DETACHED)
+		clone_flags |= CLONE_THREAD;
 
 	retval = security_ops->task_create(clone_flags);
 	if (retval)
@@ -843,6 +848,7 @@
 	 * Let it rip!
 	 */
 	p->tgid = p->pid;
+	p->group_leader = p;
 	INIT_LIST_HEAD(&p->thread_group);
 	INIT_LIST_HEAD(&p->ptrace_children);
 	INIT_LIST_HEAD(&p->ptrace_list);
@@ -870,6 +876,7 @@
 			goto bad_fork_cleanup_namespace;
 		}
 		p->tgid = current->tgid;
+		p->group_leader = current->group_leader;
 		list_add(&p->thread_group, &current->thread_group);
 		spin_unlock(&current->sig->siglock);
 	}

