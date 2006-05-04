Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWEDISX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWEDISX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 04:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWEDISX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 04:18:23 -0400
Received: from www.osadl.org ([213.239.205.134]:1424 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751437AbWEDISW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 04:18:22 -0400
Subject: [PATCH -mm] futex-pi: fix possible pi_lock deadlock
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Thu, 04 May 2006 10:20:54 +0200
Message-Id: <1146730854.27820.157.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

The lock validator detected a possible deadlock between tasklist lock and
task->pi_lock.
Prevent the deadlock by disabling interrupts across pi_lock operations.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 kernel/futex.c   |   28 ++++++++++++------------
 kernel/rtmutex.c |   63 ++++++++++++++++++++++++++++++-------------------------
 kernel/sched.c   |   45 ++++++++++++++++++++++++++++++---------
 3 files changed, 84 insertions(+), 52 deletions(-)

Index: linux-2.6.17-rc3-mm1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc3-mm1.orig/kernel/sched.c
+++ linux-2.6.17-rc3-mm1/kernel/sched.c
@@ -360,6 +360,25 @@ static inline void finish_lock_switch(ru
 #endif /* __ARCH_WANT_UNLOCKED_CTXSW */
 
 /*
+ * __task_rq_lock - lock the runqueue a given task resides on.
+ * Must be called interrupts disabled.
+ */
+static inline runqueue_t *__task_rq_lock(task_t *p)
+	__acquires(rq->lock)
+{
+	struct runqueue *rq;
+
+repeat_lock_task:
+	rq = task_rq(p);
+	spin_lock(&rq->lock);
+	if (unlikely(rq != task_rq(p))) {
+		spin_unlock(&rq->lock);
+		goto repeat_lock_task;
+	}
+	return rq;
+}
+
+/*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
@@ -380,6 +399,12 @@ repeat_lock_task:
 	return rq;
 }
 
+static inline void __task_rq_unlock(runqueue_t *rq)
+	__releases(rq->lock)
+{
+	spin_unlock(&rq->lock);
+}
+
 static inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
 	__releases(rq->lock)
 {
@@ -4016,17 +4041,17 @@ recheck:
 	 * make sure no PI-waiters arrive (or leave) while we are
 	 * changing the priority of the task:
 	 */
-	spin_lock(&p->pi_lock);
+	spin_lock_irqsave(&p->pi_lock, flags);
 	/*
 	 * To be able to change p->policy safely, the apropriate
 	 * runqueue lock must be held.
 	 */
-	rq = task_rq_lock(p, &flags);
+	rq = __task_rq_lock(p);
 	/* recheck policy now with rq lock held */
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
-		task_rq_unlock(rq, &flags);
-		spin_unlock(&p->pi_lock);
+		__task_rq_unlock(rq);
+		spin_unlock_irqrestore(&p->pi_lock, flags);
 		goto recheck;
 	}
 	array = p->array;
@@ -4047,8 +4072,8 @@ recheck:
 		} else if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
 	}
-	task_rq_unlock(rq, &flags);
-	spin_unlock(&p->pi_lock);
+	__task_rq_unlock(rq);
+	spin_unlock_irqrestore(&p->pi_lock, flags);
 
 	return 0;
 }
@@ -6680,8 +6705,8 @@ void normalize_rt_tasks(void)
 		if (!rt_task(p))
 			continue;
 
-		spin_lock(&p->pi_lock);
-		rq = task_rq_lock(p, &flags);
+		spin_lock_irqsave(&p->pi_lock, flags);
+		rq = __task_rq_lock(p);
 
 		array = p->array;
 		if (array)
@@ -6692,8 +6717,8 @@ void normalize_rt_tasks(void)
 			resched_task(rq->curr);
 		}
 
-		task_rq_unlock(rq, &flags);
-		spin_unlock(&p->pi_lock);
+		__task_rq_unlock(rq);
+		spin_unlock_irqrestore(&p->pi_lock, flags);
 	}
 	read_unlock_irq(&tasklist_lock);
 }
Index: linux-2.6.17-rc3-mm1/kernel/futex.c
===================================================================
--- linux-2.6.17-rc3-mm1.orig/kernel/futex.c
+++ linux-2.6.17-rc3-mm1/kernel/futex.c
@@ -358,9 +358,9 @@ static void free_pi_state(struct futex_p
 	WARN_ON(!pi_state->owner);
 	WARN_ON(!rt_mutex_is_locked(&pi_state->pi_mutex));
 
-	spin_lock(&pi_state->owner->pi_lock);
+	spin_lock_irq(&pi_state->owner->pi_lock);
 	list_del_init(&pi_state->list);
-	spin_unlock(&pi_state->owner->pi_lock);
+	spin_unlock_irq(&pi_state->owner->pi_lock);
 
 	rt_mutex_proxy_unlock(&pi_state->pi_mutex, pi_state->owner);
 
@@ -422,18 +422,18 @@ void exit_pi_state_list(struct task_stru
 	 * pi_state_list anymore, but we have to be careful
 	 * versus waiters unqueueing themselfs
 	 */
-	spin_lock(&curr->pi_lock);
+	spin_lock_irq(&curr->pi_lock);
 	while (!list_empty(head)) {
 
 		next = head->next;
 		pi_state = list_entry(next, struct futex_pi_state, list);
 		key = pi_state->key;
-		spin_unlock(&curr->pi_lock);
+		spin_unlock_irq(&curr->pi_lock);
 
 		hb = hash_futex(&key);
 		spin_lock(&hb->lock);
 
-		spin_lock(&curr->pi_lock);
+		spin_lock_irq(&curr->pi_lock);
 		if (head->next != next) {
 			spin_unlock(&hb->lock);
 			continue;
@@ -444,15 +444,15 @@ void exit_pi_state_list(struct task_stru
 		WARN_ON(pi_state->owner != curr);
 
 		pi_state->owner = NULL;
-		spin_unlock(&curr->pi_lock);
+		spin_unlock_irq(&curr->pi_lock);
 
 		rt_mutex_unlock(&pi_state->pi_mutex);
 
 		spin_unlock(&hb->lock);
 
-		spin_lock(&curr->pi_lock);
+		spin_lock_irq(&curr->pi_lock);
 	}
-	spin_unlock(&curr->pi_lock);
+	spin_unlock_irq(&curr->pi_lock);
 }
 
 static int
@@ -500,10 +500,10 @@ lookup_pi_state(u32 uval, struct futex_h
 	/* Store the key for possible exit cleanups: */
 	pi_state->key = me->key;
 
-	spin_lock(&p->pi_lock);
+	spin_lock_irq(&p->pi_lock);
 	list_add(&pi_state->list, &p->pi_state_list);
 	pi_state->owner = p;
-	spin_unlock(&p->pi_lock);
+	spin_unlock_irq(&p->pi_lock);
 
 	put_task_struct(p);
 
@@ -1213,17 +1213,17 @@ static int do_futex_lock_pi(u32 __user *
 
 		/* Owner died? */
 		if (q.pi_state->owner != NULL) {
-			spin_lock(&q.pi_state->owner->pi_lock);
+			spin_lock_irq(&q.pi_state->owner->pi_lock);
 			list_del_init(&q.pi_state->list);
-			spin_unlock(&q.pi_state->owner->pi_lock);
+			spin_unlock_irq(&q.pi_state->owner->pi_lock);
 		} else
 			newtid |= FUTEX_OWNER_DIED;
 
 		q.pi_state->owner = current;
 
-		spin_lock(&current->pi_lock);
+		spin_lock_irq(&current->pi_lock);
 		list_add(&q.pi_state->list, &current->pi_state_list);
-		spin_unlock(&current->pi_lock);
+		spin_unlock_irq(&current->pi_lock);
 
 		/* Unqueue and drop the lock */
 		unqueue_me_pi(&q, hb);
Index: linux-2.6.17-rc3-mm1/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-rc3-mm1.orig/kernel/rtmutex.c
+++ linux-2.6.17-rc3-mm1/kernel/rtmutex.c
@@ -134,9 +134,11 @@ static void __rt_mutex_adjust_prio(struc
  */
 static void rt_mutex_adjust_prio(struct task_struct *task)
 {
-	spin_lock(&task->pi_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&task->pi_lock, flags);
 	__rt_mutex_adjust_prio(task);
-	spin_unlock(&task->pi_lock);
+	spin_unlock_irqrestore(&task->pi_lock, flags);
 }
 
 /*
@@ -158,6 +160,7 @@ static int rt_mutex_adjust_prio_chain(ta
 	struct rt_mutex *lock;
 	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
 	int detect_deadlock, ret = 0, depth = 0;
+	unsigned long flags;
 
 	detect_deadlock = debug_rt_mutex_detect_deadlock(orig_waiter,
 							 deadlock_detect);
@@ -190,7 +193,7 @@ static int rt_mutex_adjust_prio_chain(ta
 	/*
 	 * Task can not go away as we did a get_task() before !
 	 */
-	spin_lock(&task->pi_lock);
+	spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
 	/*
@@ -214,7 +217,7 @@ static int rt_mutex_adjust_prio_chain(ta
 
 	lock = waiter->lock;
 	if (!spin_trylock(&lock->wait_lock)) {
-		spin_unlock(&task->pi_lock);
+		spin_unlock_irqrestore(&task->pi_lock, flags);
 		cpu_relax();
 		goto retry;
 	}
@@ -235,12 +238,12 @@ static int rt_mutex_adjust_prio_chain(ta
 	plist_add(&waiter->list_entry, &lock->wait_list);
 
 	/* Release the task */
-	spin_unlock(&task->pi_lock);
+	spin_unlock_irqrestore(&task->pi_lock, flags);
 	put_task_struct(task);
 
 	/* Grab the next task */
 	task = rt_mutex_owner(lock);
-	spin_lock(&task->pi_lock);
+	spin_lock_irqsave(&task->pi_lock, flags);
 
 	if (waiter == rt_mutex_top_waiter(lock)) {
 		/* Boost the owner */
@@ -259,7 +262,7 @@ static int rt_mutex_adjust_prio_chain(ta
 	}
 
 	get_task_struct(task);
-	spin_unlock(&task->pi_lock);
+	spin_unlock_irqrestore(&task->pi_lock, flags);
 
 	top_waiter = rt_mutex_top_waiter(lock);
 	spin_unlock(&lock->wait_lock);
@@ -270,7 +273,7 @@ static int rt_mutex_adjust_prio_chain(ta
 	goto again;
 
  out_unlock_pi:
-	spin_unlock(&task->pi_lock);
+	spin_unlock_irqrestore(&task->pi_lock, flags);
  out_put_task:
 	put_task_struct(task);
 	return ret;
@@ -285,6 +288,7 @@ static inline int try_to_steal_lock(stru
 {
 	struct task_struct *pendowner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *next;
+	unsigned long flags;
 
 	if (!rt_mutex_owner_pending(lock))
 		return 0;
@@ -292,9 +296,9 @@ static inline int try_to_steal_lock(stru
 	if (pendowner == current)
 		return 1;
 
-	spin_lock(&pendowner->pi_lock);
+	spin_lock_irqsave(&pendowner->pi_lock, flags);
 	if (current->prio >= pendowner->prio) {
-		spin_unlock(&pendowner->pi_lock);
+		spin_unlock_irqrestore(&pendowner->pi_lock, flags);
 		return 0;
 	}
 
@@ -304,7 +308,7 @@ static inline int try_to_steal_lock(stru
 	 * priority.
 	 */
 	if (likely(!rt_mutex_has_waiters(lock))) {
-		spin_unlock(&pendowner->pi_lock);
+		spin_unlock_irqrestore(&pendowner->pi_lock, flags);
 		return 1;
 	}
 
@@ -312,7 +316,7 @@ static inline int try_to_steal_lock(stru
 	next = rt_mutex_top_waiter(lock);
 	plist_del(&next->pi_list_entry, &pendowner->pi_waiters);
 	__rt_mutex_adjust_prio(pendowner);
-	spin_unlock(&pendowner->pi_lock);
+	spin_unlock_irqrestore(&pendowner->pi_lock, flags);
 
 	/*
 	 * We are going to steal the lock and a waiter was
@@ -329,10 +333,10 @@ static inline int try_to_steal_lock(stru
 	 * might be current:
 	 */
 	if (likely(next->task != current)) {
-		spin_lock(&current->pi_lock);
+		spin_lock_irqsave(&current->pi_lock, flags);
 		plist_add(&next->pi_list_entry, &current->pi_waiters);
 		__rt_mutex_adjust_prio(current);
-		spin_unlock(&current->pi_lock);
+		spin_unlock_irqrestore(&current->pi_lock, flags);
 	}
 	return 1;
 }
@@ -396,8 +400,9 @@ static int task_blocks_on_rt_mutex(struc
 	struct rt_mutex_waiter *top_waiter = waiter;
 	task_t *owner = rt_mutex_owner(lock);
 	int boost = 0, res;
+	unsigned long flags;
 
-	spin_lock(&current->pi_lock);
+	spin_lock_irqsave(&current->pi_lock, flags);
 	__rt_mutex_adjust_prio(current);
 	waiter->task = current;
 	waiter->lock = lock;
@@ -411,10 +416,10 @@ static int task_blocks_on_rt_mutex(struc
 
 	current->pi_blocked_on = waiter;
 
-	spin_unlock(&current->pi_lock);
+	spin_unlock_irqrestore(&current->pi_lock, flags);
 
 	if (waiter == rt_mutex_top_waiter(lock)) {
-		spin_lock(&owner->pi_lock);
+		spin_lock_irqsave(&owner->pi_lock, flags);
 		plist_del(&top_waiter->pi_list_entry, &owner->pi_waiters);
 		plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
 
@@ -423,15 +428,15 @@ static int task_blocks_on_rt_mutex(struc
 			boost = 1;
 			get_task_struct(owner);
 		}
-		spin_unlock(&owner->pi_lock);
+		spin_unlock_irqrestore(&owner->pi_lock, flags);
 	}
 	else if (debug_rt_mutex_detect_deadlock(waiter, detect_deadlock)) {
-		spin_lock(&owner->pi_lock);
+		spin_lock_irqsave(&owner->pi_lock, flags);
 		if (owner->pi_blocked_on) {
 			boost = 1;
 			get_task_struct(owner);
 		}
-		spin_unlock(&owner->pi_lock);
+		spin_unlock_irqrestore(&owner->pi_lock, flags);
 	}
 	if (!boost)
 		return 0;
@@ -458,8 +463,9 @@ static void wakeup_next_waiter(struct rt
 {
 	struct rt_mutex_waiter *waiter;
 	struct task_struct *pendowner;
+	unsigned long flags;
 
-	spin_lock(&current->pi_lock);
+	spin_lock_irqsave(&current->pi_lock, flags);
 
 	waiter = rt_mutex_top_waiter(lock);
 	plist_del(&waiter->list_entry, &lock->wait_list);
@@ -476,7 +482,7 @@ static void wakeup_next_waiter(struct rt
 
 	rt_mutex_set_owner(lock, pendowner, RT_MUTEX_OWNER_PENDING);
 
-	spin_unlock(&current->pi_lock);
+	spin_unlock_irqrestore(&current->pi_lock, flags);
 
 	/*
 	 * Clear the pi_blocked_on variable and enqueue a possible
@@ -485,7 +491,7 @@ static void wakeup_next_waiter(struct rt
 	 * waiter with higher priority than pending-owner->normal_prio
 	 * is blocked on the unboosted (pending) owner.
 	 */
-	spin_lock(&pendowner->pi_lock);
+	spin_lock_irqsave(&pendowner->pi_lock, flags);
 
 	WARN_ON(!pendowner->pi_blocked_on);
 	WARN_ON(pendowner->pi_blocked_on != waiter);
@@ -499,7 +505,7 @@ static void wakeup_next_waiter(struct rt
 		next = rt_mutex_top_waiter(lock);
 		plist_add(&next->pi_list_entry, &pendowner->pi_waiters);
 	}
-	spin_unlock(&pendowner->pi_lock);
+	spin_unlock_irqrestore(&pendowner->pi_lock, flags);
 
 	wake_up_process(pendowner);
 }
@@ -515,16 +521,17 @@ static void remove_waiter(struct rt_mute
 	int first = (waiter == rt_mutex_top_waiter(lock));
 	int boost = 0;
 	task_t *owner = rt_mutex_owner(lock);
+	unsigned long flags;
 
-	spin_lock(&current->pi_lock);
+	spin_lock_irqsave(&current->pi_lock, flags);
 	plist_del(&waiter->list_entry, &lock->wait_list);
 	waiter->task = NULL;
 	current->pi_blocked_on = NULL;
-	spin_unlock(&current->pi_lock);
+	spin_unlock_irqrestore(&current->pi_lock, flags);
 
 	if (first && owner != current) {
 
-		spin_lock(&owner->pi_lock);
+		spin_lock_irqsave(&owner->pi_lock, flags);
 
 		plist_del(&waiter->pi_list_entry, &owner->pi_waiters);
 
@@ -540,7 +547,7 @@ static void remove_waiter(struct rt_mute
 			boost = 1;
 			get_task_struct(owner);
 		}
-		spin_unlock(&owner->pi_lock);
+		spin_unlock_irqrestore(&owner->pi_lock, flags);
 	}
 
 	WARN_ON(!plist_node_empty(&waiter->pi_list_entry));


