Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVEIOkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVEIOkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVEIOiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:38:12 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:36271 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261410AbVEIOcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:32:41 -0400
Message-ID: <427F7640.81941460@tv-sign.ru>
Date: Mon, 09 May 2005 18:40:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [PATCH 3/4] rt_mutex: convert the code to use new plists
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the code, mainly in kernel/rt.c, to use new plists.

This patch incomplete (rt.c can't be compiled), because I suspect the
bugs in rt.c, which are "fixed" in the next patch.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- V0.7.47-01/include/linux/sched.h~2_PORT	2005-05-09 16:46:06.000000000 +0400
+++ V0.7.47-01/include/linux/sched.h	2005-05-09 17:18:00.000000000 +0400
@@ -840,7 +840,7 @@ struct task_struct {
 
 	/* realtime bits */
 	struct list_head delayed_put;
-	struct plist pi_waiters;
+	struct pl_head pi_waiters;
 
 	/* RT deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *blocked_on;
--- V0.7.47-01/include/linux/rt_lock.h~2_PORT	2005-05-09 16:46:06.000000000 +0400
+++ V0.7.47-01/include/linux/rt_lock.h	2005-05-09 18:22:11.000000000 +0400
@@ -67,7 +67,7 @@ typedef struct {
  */
 struct rt_mutex {
 	raw_spinlock_t		wait_lock;
-	struct plist		wait_list;
+	struct pl_head		wait_list;
 	struct task_struct	*owner;
 	int			owner_prio;
 # ifdef CONFIG_RT_DEADLOCK_DETECT
@@ -85,8 +85,8 @@ struct rt_mutex {
  */
 struct rt_mutex_waiter {
 	struct rt_mutex *lock;
-	struct plist	 list;
-	struct plist	 pi_list;
+	struct pl_node	 list;
+	struct pl_node	 pi_list;
 	struct task_struct *task;
 
 	unsigned long eip;	// for debugging
@@ -95,12 +95,12 @@ struct rt_mutex_waiter {
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 # define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED, \
-	.wait_list = PLIST_INIT((lockname).wait_list, MAX_PRIO),  \
+	.wait_list = PL_HEAD_INIT((lockname).wait_list),  \
 	.name = #lockname, .file = __FILE__, .line = __LINE__ }
 #else
 # define __RT_MUTEX_INITIALIZER(lockname) \
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED, \
-	PLIST_INIT((lockname).wait_list, MAX_PRIO) }
+	PL_HEAD_INIT((lockname).wait_list) }
 #endif
 /*
  * RW-semaphores are an RT mutex plus a reader-depth count.
--- V0.7.47-01/include/linux/init_task.h~2_PORT	2005-05-09 16:46:06.000000000 +0400
+++ V0.7.47-01/include/linux/init_task.h	2005-05-09 18:26:02.000000000 +0400
@@ -110,8 +110,7 @@ extern struct group_info init_groups;
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= RAW_SPIN_LOCK_UNLOCKED,			\
 	.delayed_put	= LIST_HEAD_INIT(tsk.delayed_put),		\
-	.pi_waiters.dp_node = LIST_HEAD_INIT(tsk.pi_waiters.dp_node),	\
-	.pi_waiters.sp_node = LIST_HEAD_INIT(tsk.pi_waiters.sp_node),	\
+	.pi_waiters	= PL_HEAD_INIT(tsk.pi_waiters),			\
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 }
--- V0.7.47-01/kernel/fork.c~2_PORT	2005-05-09 16:46:06.000000000 +0400
+++ V0.7.47-01/kernel/fork.c	2005-05-09 17:34:39.000000000 +0400
@@ -990,7 +990,7 @@ static task_t *copy_process(unsigned lon
  	}
 #endif
 	INIT_LIST_HEAD(&p->delayed_put);
-	plist_init(&p->pi_waiters, 0);
+	pl_head_init(&p->pi_waiters);
 	p->blocked_on = NULL; /* not blocked yet */
 
 	p->tgid = p->pid;
--- V0.7.47-01/kernel/rt.c~2_PORT	2005-05-09 16:46:06.000000000 +0400
+++ V0.7.47-01/kernel/rt.c	2005-05-09 20:14:19.000000000 +0400
@@ -418,7 +418,6 @@ print_it:
 void check_no_held_locks(struct task_struct *task)
 {
 	struct list_head *curr, *next, *cursor = NULL;
-	struct plist *curr1, *curr2;
 	struct rt_mutex *lock;
 	struct rt_mutex_waiter *w;
 	struct task_struct *p;
@@ -454,8 +453,7 @@ restart:
 		goto restart;
 	}
 	spin_lock(&pi_lock);
-	plist_for_each(curr1, curr2, &task->pi_waiters) {
-		w = plist_entry(curr2, struct rt_mutex_waiter, pi_list);
+	plist_for_each_entry(w, &task->pi_waiters, pi_list) {
 		TRACE_OFF();
 		spin_unlock(&pi_lock);
 		trace_unlock_irqrestore(&trace_lock, flags);
@@ -516,13 +514,11 @@ check_pi_list_present(struct rt_mutex *l
 		      struct task_struct *old_owner)
 {
 	struct rt_mutex_waiter *w;
-	struct plist *curr1, *curr2;
 
 	TRACE_WARN_ON(plist_empty(&waiter->pi_list));
 	TRACE_WARN_ON(lock->owner);
 
-	plist_for_each(curr1, curr2, &old_owner->pi_waiters) {
-		w = plist_entry(curr2, struct rt_mutex_waiter, pi_list);
+	plist_for_each_entry(w, &old_owner->pi_waiters, pi_list) {
 		if (w == waiter)
 			goto ok;
 	}
@@ -534,10 +530,8 @@ static void
 check_pi_list_empty(struct rt_mutex *lock, struct task_struct *old_owner)
 {
 	struct rt_mutex_waiter *w;
-	struct plist *curr1, curr2;
 
-	plist_for_each(curr1, curr2, &old_owner->pi_waiters) {
-		w = plist_entry(curr2, struct rt_mutex_waiter, pi_list);
+	plist_for_each_entry(w, &old_owner->pi_waiters, pi_list) {
 		if (w->lock == lock) {
 			TRACE_OFF();
 			printk("hm, PI interest but no waiter? Old owner:\n");
@@ -571,18 +565,16 @@ static void
 change_owner(struct rt_mutex *lock, struct task_struct *old_owner,
 		   struct task_struct *new_owner)
 {
-	struct plist *next1, *next2, *curr1, *curr2;
-	struct rt_mutex_waiter *w;
+	struct rt_mutex_waiter *w, *tmp;
 	int requeued = 0, sum = 0;
 
 	if (old_owner == new_owner)
 		return;
 
-	plist_for_each_safe(curr1, curr2, next1, next2, &old_owner->pi_waiters) {
-		w = plist_entry(curr2, struct rt_mutex_waiter, pi_list);
+	plist_for_each_entry_safe(w, tmp, &old_owner->pi_waiters, pi_list) {
 		if (w->lock == lock) {
-			plist_del(&w->pi_list, &old_owner->pi_waiters);
-			plist_init(&w->pi_list, w->task->prio);
+			plist_del(&w->pi_list);
+			w->pi_list.prio = w->task->prio;
 			plist_add(&w->pi_list, &new_owner->pi_waiters);
 			requeued++;
 		}
@@ -637,11 +629,11 @@ static void pi_setprio(struct rt_mutex *
 		TRACE_BUG_ON(!lock->owner);
 		if (rt_task(p) && plist_empty(&w->pi_list)) {
 			TRACE_BUG_ON(was_rt);
-			plist_init(&w->pi_list, prio);
+			w->pi_list.prio = prio;
 			plist_add(&w->pi_list, &lock->owner->pi_waiters);
 
-			plist_del(&w->list, &lock->wait_list);
-			plist_init(&w->list, prio);
+			plist_del(&w->list);
+			w->list.prio = prio;
 			plist_add(&w->list, &lock->wait_list);
 
 		}
@@ -655,11 +647,10 @@ static void pi_setprio(struct rt_mutex *
 		 */
 		if (!rt_task(p) && !plist_empty(&w->pi_list)) {
 			TRACE_BUG_ON(!was_rt);
-			plist_del(&w->pi_list, &lock->owner->pi_waiters);
-			plist_del(&w->list, &lock->wait_list);
-			plist_init(&w->list, prio);
+			plist_del(&w->pi_list);
+			plist_del(&w->list);
+			w->list.prio = prio;
 			plist_add(&w->list, &lock->wait_list);
-
 		}
 
 		pi_walk++;
@@ -688,7 +679,7 @@ task_blocks_on_lock(struct rt_mutex_wait
 	task->blocked_on = waiter;
 	waiter->lock = lock;
 	waiter->task = task;
-	plist_init(&waiter->pi_list, task->prio);
+	pl_node_init(&waiter->pi_list, task->prio);
 	/*
 	 * Add SCHED_NORMAL tasks to the end of the waitqueue (FIFO):
 	 */
@@ -721,7 +712,7 @@ static void __init_rt_mutex(struct rt_mu
 {
 	lock->owner = NULL;
 	spin_lock_init(&lock->wait_lock);
-	plist_init(&lock->wait_list, 0);
+	pl_head_init(&lock->wait_list);
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	lock->save_state = save_state;
 	INIT_LIST_HEAD(&lock->held_list);
@@ -771,7 +762,7 @@ static inline struct task_struct * pick_
 	 *
 	 * (same-prio RT tasks go FIFO)
 	 */
-	waiter = plist_entry(&lock->wait_list, struct rt_mutex_waiter, list);
+	waiter = plist_next_entry(&lock->wait_list, struct rt_mutex_waiter, list);
 
 	trace_special_pid(waiter->task->pid, waiter->task->prio, 0);
 
@@ -779,10 +770,10 @@ static inline struct task_struct * pick_
 	check_pi_list_present(lock, waiter, old_owner);
 #endif
 	new_owner = waiter->task;
-	plist_del_init(&waiter->list, &lock->wait_list);
+	plist_del(&waiter->list);
 
-	plist_del(&waiter->pi_list, &old_owner->pi_waiters);
-	plist_init(&waiter->pi_list, waiter->task->prio);
+	plist_del(&waiter->pi_list);
+	pl_node_init(&waiter->pi_list, waiter->task->prio);
 
 	set_new_owner(lock, old_owner, new_owner, waiter->eip);
 	/* Don't touch waiter after ->task has been NULLed */
@@ -798,7 +789,7 @@ static inline void init_lists(struct rt_
 {
 	// we have to do this until the static initializers get fixed:
 	if (!lock->wait_list.dp_node.prev && !lock->wait_list.dp_node.next)
-		plist_init(&lock->wait_list, 0);
+		pl_head_init(&lock->wait_list);
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	if (!lock->held_list.prev && !lock->held_list.next)
 		INIT_LIST_HEAD(&lock->held_list);
@@ -939,7 +930,7 @@ static void __sched __down(struct rt_mut
 
 	set_task_state(task, TASK_UNINTERRUPTIBLE);
 
-	plist_init(&waiter.list, task->prio);
+	pl_node_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
 	TRACE_BUG_ON(!irqs_disabled());
@@ -1034,7 +1025,7 @@ static void __sched __down_mutex(struct 
 		return;
 	}
 
-	plist_init (&waiter.list, task->prio);
+	pl_node_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
 	TRACE_BUG_ON(!irqs_disabled());
@@ -1176,7 +1167,7 @@ static int __sched __down_interruptible(
 
 	set_task_state(task, TASK_INTERRUPTIBLE);
 
-	plist_init (&waiter.list, task->prio);
+	pl_node_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
 	TRACE_BUG_ON(!irqs_disabled());
@@ -1201,15 +1192,15 @@ wait_again:
 			trace_lock_irq(&trace_lock);
 			spin_lock(&lock->wait_lock);
 			if (waiter.task) {
-				plist_del_init(&waiter.list, &lock->wait_list);
+				plist_del(&waiter.list);
 				/*
 				 * Just remove ourselves from the PI list.
 				 * (No big problem if our PI effect lingers
 				 *  a bit - owner will restore prio.)
 				 */
 				spin_lock(&pi_lock);
-				plist_del(&waiter.pi_list, &lock->owner->pi_waiters);
-				plist_init(&waiter.pi_list, waiter.task->prio);
+				plist_del(&waiter.pi_list);
+				pl_node_init(&waiter.pi_list, waiter.task->prio);
 				spin_unlock(&pi_lock);
 				ret = -EINTR;
 			}
@@ -1349,7 +1340,7 @@ static void __up_mutex(struct rt_mutex *
 	 */
 	prio = mutex_getprio(old_owner);
 	if (!plist_empty(&old_owner->pi_waiters)) {
-		w = plist_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
+		w = plist_next_entry(&old_owner->pi_waiters, struct rt_mutex_waiter, pi_list);
 		if (w->task->prio < prio)
 			prio = w->task->prio;
 	}
@@ -1879,4 +1870,3 @@ int _write_can_lock(rwlock_t *rwlock)
 	return !rt_rwsem_is_locked(&rwlock->lock);
 }
 EXPORT_SYMBOL(_write_can_lock);
-
