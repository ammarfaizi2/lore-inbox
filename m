Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbSIWSHE>; Mon, 23 Sep 2002 14:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSIWSHE>; Mon, 23 Sep 2002 14:07:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58063 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261287AbSIWSGb>;
	Mon, 23 Sep 2002 14:06:31 -0400
Date: Mon, 23 Sep 2002 20:19:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] pidhash cleanups, tgid-2.5.38-F3
Message-ID: <Pine.LNX.4.44.0209232013470.28617-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch, against BK-curr, does the following things:

 - removes the ->thread_group list and uses a new PIDTYPE_TGID pid class 
   to handle thread groups. This cleans up lots of code in signal.c and 
   elsewhere.

 - fixes sys_execve() if a non-leader thread calls it. (2.5.38 crashed in
   this case.)

 - renames list_for_each_noprefetch to __list_for_each.

 - cleans up delayed-leader parent notification.

 - introduces link_pid() to optimize PIDTYPE_TGID installation in the
   thread-group case.

i've tested the patch with a number of threaded and non-threaded
workloads, and it works just fine. Compiles & boots on UP and SMP x86.

the session/pgrp bugs reported to lkml are probably still open, they are
the next on my todo - now that we have a clean pidhash architecture they
should be easier to fix.

	Ingo

--- linux/fs/exec.c.orig	Mon Sep 23 17:53:23 2002
+++ linux/fs/exec.c	Mon Sep 23 19:22:07 2002
@@ -537,7 +537,7 @@
 	if (!newsig)
 		return -ENOMEM;
 
-	if (list_empty(&current->thread_group))
+	if (thread_group_empty(current))
 		goto out;
 	/*
 	 * Kill all other threads in the thread group:
@@ -607,21 +607,17 @@
 		ptrace = leader->ptrace;
 		parent = leader->parent;
 
-		ptrace_unlink(leader);
 		ptrace_unlink(current);
+		ptrace_unlink(leader);
 		remove_parent(current);
 		remove_parent(leader);
-		/*
-		 * Split up the last two remaining members of the
-		 * thread group:
-		 */
-		list_del_init(&leader->thread_group);
 
-		leader->pid = leader->tgid = current->pid;
-		current->pid = current->tgid;
+		switch_exec_pids(leader, current);
+
 		current->parent = current->real_parent = leader->real_parent;
 		leader->parent = leader->real_parent = child_reaper;
-		current->exit_signal = SIGCHLD;
+		current->group_leader = current;
+		leader->group_leader = leader;
 
 		add_parent(current, current->parent);
 		add_parent(leader, leader->parent);
@@ -631,15 +627,17 @@
 		}
 		
 		list_add_tail(&current->tasks, &init_task.tasks);
+		current->exit_signal = SIGCHLD;
 		state = leader->state;
+
 		write_unlock_irq(&tasklist_lock);
 
+		put_proc_dentry(proc_dentry1);
+		put_proc_dentry(proc_dentry2);
+
 		if (state != TASK_ZOMBIE)
 			BUG();
 		release_task(leader);
-
-		put_proc_dentry(proc_dentry1);
-		put_proc_dentry(proc_dentry2);
         }
 
 out:
@@ -661,7 +659,7 @@
 	if (atomic_dec_and_test(&oldsig->count))
 		kmem_cache_free(sigact_cachep, oldsig);
 
-	if (!list_empty(&current->thread_group))
+	if (!thread_group_empty(current))
 		BUG();
 	if (current->tgid != current->pid)
 		BUG();
--- linux/include/linux/pid.h.orig	Fri Sep 20 17:20:20 2002
+++ linux/include/linux/pid.h	Mon Sep 23 19:45:48 2002
@@ -4,6 +4,7 @@
 enum pid_type
 {
 	PIDTYPE_PID,
+	PIDTYPE_TGID,
 	PIDTYPE_PGID,
 	PIDTYPE_SID,
 	PIDTYPE_MAX
@@ -29,13 +30,12 @@
 	list_entry(elem, struct task_struct, pids[type].pid_chain)
 
 /*
- * attach_pid() must be called with the tasklist_lock write-held.
- *
- * It might unlock the tasklist_lock for allocation, so this
- * function must be called after installing all other links of
- * a new task.
+ * attach_pid() and link_pid() must be called with the tasklist_lock
+ * write-held.
  */
-extern int FASTCALL(attach_pid(struct task_struct *, enum pid_type, int));
+extern int FASTCALL(attach_pid(struct task_struct *task, enum pid_type type, int nr));
+
+extern void FASTCALL(link_pid(struct task_struct *task, struct pid_link *link, struct pid *pid));
 
 /*
  * detach_pid() must be called with the tasklist_lock write-held.
@@ -50,6 +50,7 @@
 
 extern int alloc_pidmap(void);
 extern void FASTCALL(free_pidmap(int));
+extern void switch_exec_pids(struct task_struct *leader, struct task_struct *thread);
 
 #define for_each_task_pid(who, type, task, elem, pid)		\
 	if ((pid = find_pid(type, who)))			\
--- linux/include/linux/sched.h.orig	Mon Sep 23 17:03:39 2002
+++ linux/include/linux/sched.h	Mon Sep 23 17:55:27 2002
@@ -337,7 +337,6 @@
 	struct list_head children;	/* list of my children */
 	struct list_head sibling;	/* linkage in my parent's children list */
 	struct task_struct *group_leader;
-	struct list_head thread_group;
 
 	/* PID/PID hash table linkage. */
 	struct pid_link pids[PIDTYPE_MAX];
@@ -806,34 +805,19 @@
 #define while_each_thread(g, t) \
 	while ((t = next_thread(t)) != g)
 
-static inline task_t *next_thread(task_t *p)
-{
-	if (!p->sig)
-		BUG();
-#if CONFIG_SMP
-	if (!spin_is_locked(&p->sig->siglock) &&
-				!rwlock_is_locked(&tasklist_lock))
-		BUG();
-#endif
-	return list_entry((p)->thread_group.next, task_t, thread_group);
-}
+extern task_t * FASTCALL(next_thread(task_t *p));
+
+#define thread_group_leader(p)	(p->pid == p->tgid)
 
-static inline task_t *prev_thread(task_t *p)
+static inline int thread_group_empty(task_t *p)
 {
-	if (!p->sig)
-		BUG();
-#if CONFIG_SMP
-	if (!spin_is_locked(&p->sig->siglock) &&
-				!rwlock_is_locked(&tasklist_lock))
-		BUG();
-#endif
-	return list_entry((p)->thread_group.prev, task_t, thread_group);
-}
+	struct pid *pid = p->pids[PIDTYPE_TGID].pidptr;
 
-#define thread_group_leader(p)	(p->pid == p->tgid)
+	return pid->task_list.next->next == &pid->task_list;
+}
 
 #define delay_group_leader(p) \
-	(p->tgid == p->pid && !list_empty(&p->thread_group))
+		(thread_group_leader(p) && !thread_group_empty(p))
 
 extern void unhash_process(struct task_struct *p);
 
--- linux/include/linux/list.h.orig	Fri Sep 20 17:20:14 2002
+++ linux/include/linux/list.h	Mon Sep 23 17:03:52 2002
@@ -196,7 +196,17 @@
 	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
         	pos = pos->next, prefetch(pos->next))
 
-#define list_for_each_noprefetch(pos, head) \
+/**
+ * __list_for_each	-	iterate over a list
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @head:	the head for your list.
+ *
+ * This variant differs from list_for_each() in that it's the
+ * simplest possible list iteration code, no prefetching is done.
+ * Use this for code that knows the list to be very short (empty
+ * or 1 entry) most of the time.
+ */
+#define __list_for_each(pos, head) \
 	for (pos = (head)->next; pos != (head); pos = pos->next)
 
 /**
--- linux/include/linux/init_task.h.orig	Mon Sep 23 17:55:34 2002
+++ linux/include/linux/init_task.h	Mon Sep 23 17:55:38 2002
@@ -76,7 +76,6 @@
 	.children	= LIST_HEAD_INIT(tsk.children),			\
 	.sibling	= LIST_HEAD_INIT(tsk.sibling),			\
 	.group_leader	= &tsk,						\
-	.thread_group	= LIST_HEAD_INIT(tsk.thread_group),		\
 	.wait_chldexit	= __WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
 	.real_timer	= {						\
 		.function	= it_real_fn				\
--- linux/kernel/fork.c.orig	Fri Sep 20 17:20:16 2002
+++ linux/kernel/fork.c	Mon Sep 23 19:45:18 2002
@@ -802,7 +802,6 @@
 	 */
 	p->tgid = p->pid;
 	p->group_leader = p;
-	INIT_LIST_HEAD(&p->thread_group);
 	INIT_LIST_HEAD(&p->ptrace_children);
 	INIT_LIST_HEAD(&p->ptrace_list);
 
@@ -830,7 +829,6 @@
 		}
 		p->tgid = current->tgid;
 		p->group_leader = current->group_leader;
-		list_add(&p->thread_group, &current->thread_group);
 		spin_unlock(&current->sig->siglock);
 	}
 
@@ -840,9 +838,11 @@
 
 	attach_pid(p, PIDTYPE_PID, p->pid);
 	if (thread_group_leader(p)) {
+		attach_pid(p, PIDTYPE_TGID, p->tgid);
 		attach_pid(p, PIDTYPE_PGID, p->pgrp);
 		attach_pid(p, PIDTYPE_SID, p->session);
-	}
+	} else
+		link_pid(p, p->pids + PIDTYPE_TGID, &p->group_leader->pids[PIDTYPE_TGID].pid);
 
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
--- linux/kernel/exit.c.orig	Fri Sep 20 17:20:22 2002
+++ linux/kernel/exit.c	Mon Sep 23 19:01:48 2002
@@ -34,13 +34,13 @@
 	struct dentry *proc_dentry;
 	nr_threads--;
 	detach_pid(p, PIDTYPE_PID);
+	detach_pid(p, PIDTYPE_TGID);
 	if (thread_group_leader(p)) {
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
 	}
 
 	REMOVE_LINKS(p);
-	p->pid = 0;
 	proc_dentry = p->proc_dentry;
 	if (unlikely(proc_dentry != NULL)) {
 		spin_lock(&dcache_lock);
@@ -74,6 +74,15 @@
 	write_lock_irq(&tasklist_lock);
 	__exit_sighand(p);
 	proc_dentry = __unhash_process(p);
+
+	/*
+	 * If we are the last non-leader member of the thread
+	 * group, and the leader is zombie, then notify the
+	 * group leader's parent process.
+	 */
+	if (p->group_leader != p && thread_group_empty(p))
+		do_notify_parent(p->group_leader, p->group_leader->exit_signal);
+
 	p->parent->cutime += p->utime + p->cutime;
 	p->parent->cstime += p->stime + p->cstime;
 	p->parent->cmin_flt += p->min_flt + p->cmin_flt;
@@ -670,6 +679,25 @@
 	do_exit((error_code&0xff)<<8);
 }
 
+task_t *next_thread(task_t *p)
+{
+	struct pid_link *link = p->pids + PIDTYPE_TGID;
+	struct list_head *tmp, *head = &link->pidptr->task_list;
+
+#if CONFIG_SMP
+	if (!p->sig)
+		BUG();
+	if (!spin_is_locked(&p->sig->siglock) &&
+				!rwlock_is_locked(&tasklist_lock))
+		BUG();
+#endif
+	tmp = link->pid_chain.next;
+	if (tmp == head)
+		tmp = head->next;
+
+	return pid_task(tmp, PIDTYPE_TGID);
+}
+
 /*
  * this kills every thread in the thread group. Note that any externally
  * wait4()-ing process will get the correct exit code - even if this 
@@ -679,7 +707,7 @@
 {
 	unsigned int exit_code = (error_code & 0xff) << 8;
 
-	if (!list_empty(&current->thread_group)) {
+	if (!thread_group_empty(current)) {
 		struct signal_struct *sig = current->sig;
 
 		spin_lock_irq(&sig->siglock);
--- linux/kernel/signal.c.orig	Fri Sep 20 17:20:24 2002
+++ linux/kernel/signal.c	Mon Sep 23 17:57:54 2002
@@ -254,7 +254,6 @@
 {
 	if (tsk == sig->curr_target)
 		sig->curr_target = next_thread(tsk);
-	list_del_init(&tsk->thread_group);
 }
 
 void remove_thread_group(struct task_struct *tsk, struct signal_struct *sig)
@@ -281,15 +280,13 @@
 		BUG();
 	spin_lock(&sig->siglock);
 	spin_lock(&tsk->sigmask_lock);
-	tsk->sig = NULL;
 	if (atomic_dec_and_test(&sig->count)) {
 		__remove_thread_group(tsk, sig);
+		tsk->sig = NULL;
 		spin_unlock(&sig->siglock);
 		flush_sigqueue(&sig->shared_pending);
 		kmem_cache_free(sigact_cachep, sig);
 	} else {
-		struct task_struct *leader = tsk->group_leader;
-
 		/*
 		 * If there is any task waiting for the group exit
 		 * then notify it:
@@ -298,24 +295,9 @@
 			wake_up_process(sig->group_exit_task);
 			sig->group_exit_task = NULL;
 		}
-		/*
-		 * If we are the last non-leader member of the thread
-		 * group, and the leader is zombie, then notify the
-		 * group leader's parent process.
-		 *
-		 * (subtle: here we also rely on the fact that if we are the
-		 *  thread group leader then we are not zombied yet.)
-		 */
-		if (atomic_read(&sig->count) == 1 &&
-					leader->state == TASK_ZOMBIE) {
-
-			__remove_thread_group(tsk, sig);
-			spin_unlock(&sig->siglock);
-			do_notify_parent(leader, leader->exit_signal);
-		} else {
-			__remove_thread_group(tsk, sig);
-			spin_unlock(&sig->siglock);
-		}
+		__remove_thread_group(tsk, sig);
+		tsk->sig = NULL;
+		spin_unlock(&sig->siglock);
 	}
 	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
 	flush_sigqueue(&tsk->pending);
@@ -853,7 +835,7 @@
 		p->sig->curr_target = p;
 
 	else for (;;) {
-		if (list_empty(&p->thread_group))
+		if (thread_group_empty(p))
 			BUG();
 		if (!tmp || tmp->tgid != p->tgid)
 			BUG();
@@ -882,17 +864,13 @@
 int __broadcast_thread_group(struct task_struct *p, int sig)
 {
 	struct task_struct *tmp;
-	struct list_head *entry;
+	struct list_head *l;
+	struct pid *pid;
 	int err = 0;
 
-	/* send a signal to the head of the list */
-	err = __force_sig_info(sig, p);
-
-	/* send a signal to all members of the list */
-	list_for_each(entry, &p->thread_group) {
-		tmp = list_entry(entry, task_t, thread_group);
+	for_each_task_pid(p->tgid, PIDTYPE_TGID, tmp, l, pid)
 		err = __force_sig_info(sig, tmp);
-	}
+
 	return err;
 }
 
@@ -909,7 +887,7 @@
 	spin_lock_irqsave(&p->sig->siglock, flags);
 
 	/* not a thread group - normal signal behavior */
-	if (list_empty(&p->thread_group) || !sig)
+	if (thread_group_empty(p) || !sig)
 		goto out_send;
 
 	if (sig_user_defined(p, sig)) {
--- linux/kernel/pid.c.orig	Fri Sep 20 17:20:30 2002
+++ linux/kernel/pid.c	Mon Sep 23 20:12:58 2002
@@ -142,7 +142,7 @@
 	struct list_head *elem, *bucket = &pid_hash[type][pid_hashfn(nr)];
 	struct pid *pid;
 
-	list_for_each_noprefetch(elem, bucket) {
+	__list_for_each(elem, bucket) {
 		pid = list_entry(elem, struct pid, hash_chain);
 		if (pid->nr == nr)
 			return pid;
@@ -150,6 +150,13 @@
 	return NULL;
 }
 
+void link_pid(task_t *task, struct pid_link *link, struct pid *pid)
+{
+	atomic_inc(&pid->count);
+	list_add_tail(&link->pid_chain, &pid->task_list);
+	link->pidptr = pid;
+}
+
 int attach_pid(task_t *task, enum pid_type type, int nr)
 {
 	struct pid *pid = find_pid(type, nr);
@@ -165,13 +172,13 @@
 		get_task_struct(task);
 		list_add(&pid->hash_chain, &pid_hash[type][pid_hashfn(nr)]);
 	}
-	list_add(&task->pids[type].pid_chain, &pid->task_list);
+	list_add_tail(&task->pids[type].pid_chain, &pid->task_list);
 	task->pids[type].pidptr = pid;
 
 	return 0;
 }
 
-void detach_pid(task_t *task, enum pid_type type)
+static inline int __detach_pid(task_t *task, enum pid_type type)
 {
 	struct pid_link *link = task->pids + type;
 	struct pid *pid = link->pidptr;
@@ -179,25 +186,69 @@
 
 	list_del(&link->pid_chain);
 	if (!atomic_dec_and_test(&pid->count))
-		return;
+		return 0;
 
 	nr = pid->nr;
 	list_del(&pid->hash_chain);
 	put_task_struct(pid->task);
 
+	return nr;
+}
+
+static void _detach_pid(task_t *task, enum pid_type type)
+{
+	__detach_pid(task, type);
+}
+
+void detach_pid(task_t *task, enum pid_type type)
+{
+	int nr = __detach_pid(task, type);
+
+	if (!nr)
+		return;
+
 	for (type = 0; type < PIDTYPE_MAX; ++type)
 		if (find_pid(type, nr))
 			return;
 	free_pidmap(nr);
 }
 
-extern task_t *find_task_by_pid(int nr)
+task_t *find_task_by_pid(int nr)
 {
 	struct pid *pid = find_pid(PIDTYPE_PID, nr);
 
 	if (!pid)
 		return NULL;
 	return pid_task(pid->task_list.next, PIDTYPE_PID);
+}
+
+/*
+ * This function switches the PIDs if a non-leader thread calls
+ * sys_execve() - this must be done without releasing the PID.
+ * (which a detach_pid() would eventually do.)
+ */
+void switch_exec_pids(task_t *leader, task_t *thread)
+{
+	_detach_pid(leader, PIDTYPE_PID);
+	_detach_pid(leader, PIDTYPE_TGID);
+	_detach_pid(leader, PIDTYPE_PGID);
+	_detach_pid(leader, PIDTYPE_SID);
+
+	_detach_pid(thread, PIDTYPE_PID);
+	_detach_pid(thread, PIDTYPE_TGID);
+
+	leader->pid = leader->tgid = thread->pid;
+	thread->pid = thread->tgid;
+
+	attach_pid(thread, PIDTYPE_PID, thread->pid);
+	attach_pid(thread, PIDTYPE_TGID, thread->tgid);
+	attach_pid(thread, PIDTYPE_PGID, thread->pgrp);
+	attach_pid(thread, PIDTYPE_SID, thread->session);
+
+	attach_pid(leader, PIDTYPE_PID, leader->pid);
+	attach_pid(leader, PIDTYPE_TGID, leader->tgid);
+	attach_pid(leader, PIDTYPE_PGID, leader->pgrp);
+	attach_pid(leader, PIDTYPE_SID, leader->session);
 }
 
 void __init pidhash_init(void)

