Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWCYStA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWCYStA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWCYStA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:49:00 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50305 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932235AbWCYSsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:48:45 -0500
Date: Sat, 25 Mar 2006 19:46:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: [patch 04/10] PI-futex: scheduler support for PI
Message-ID: <20060325184605.GE16724@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

add framework to boost/unboost the priority of RT tasks.

This consists of:

 - caching the 'normal' priority in ->normal_prio
 - providing a functions to set/get the priority of the task
 - make sched_setscheduler() aware of boosting

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

----

 include/linux/init_task.h |    1 
 include/linux/sched.h     |   19 +++++-
 kernel/sched.c            |  136 ++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 138 insertions(+), 18 deletions(-)

Index: linux-pi-futex.mm.q/include/linux/init_task.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/init_task.h
+++ linux-pi-futex.mm.q/include/linux/init_task.h
@@ -87,6 +87,7 @@ extern struct group_info init_groups;
 	.lock_depth	= -1,						\
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
+	.normal_prio	= MAX_PRIO-20,					\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
Index: linux-pi-futex.mm.q/include/linux/sched.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/sched.h
+++ linux-pi-futex.mm.q/include/linux/sched.h
@@ -486,7 +486,8 @@ struct signal_struct {
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
-#define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
+#define rt_prio(prio)		unlikely((prio) < MAX_RT_PRIO)
+#define rt_task(p)		rt_prio((p)->prio)
 #define batch_task(p)		(unlikely((p)->policy == SCHED_BATCH))
 
 /*
@@ -726,7 +727,7 @@ struct task_struct {
 #endif
 #endif
 	int load_weight;	/* for niceness load balancing purposes */
-	int prio, static_prio;
+	int prio, static_prio, normal_prio;
 	struct list_head run_list;
 	prio_array_t *array;
 
@@ -854,6 +855,9 @@ struct task_struct {
 /* Protection of (de-)allocation: mm, files, fs, tty, keyrings */
 	spinlock_t alloc_lock;
 
+	/* Protection of the PI data structures: */
+	spinlock_t pi_lock;
+
 #ifdef CONFIG_DEBUG_MUTEXES
 	/* mutex deadlock detection */
 	struct mutex_waiter *blocked_on;
@@ -1020,6 +1024,17 @@ static inline void idle_task_exit(void) 
 #endif
 
 extern void sched_idle_next(void);
+
+#ifdef CONFIG_RT_MUTEXES
+extern int rt_mutex_getprio(task_t *p);
+extern void rt_mutex_setprio(task_t *p, int prio);
+#else
+static inline int rt_mutex_getprio(task_t *p)
+{
+	return p->normal_prio;
+}
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
Index: linux-pi-futex.mm.q/kernel/sched.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/sched.c
+++ linux-pi-futex.mm.q/kernel/sched.c
@@ -643,7 +643,7 @@ static inline void enqueue_task_head(str
 }
 
 /*
- * effective_prio - return the priority that is based on the static
+ * __normal_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
  *
  * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
@@ -656,13 +656,11 @@ static inline void enqueue_task_head(str
  *
  * Both properties are important to certain workloads.
  */
-static int effective_prio(task_t *p)
+
+static inline int __normal_prio(task_t *p)
 {
 	int bonus, prio;
 
-	if (rt_task(p))
-		return p->prio;
-
 	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
 
 	prio = p->static_prio - bonus;
@@ -778,6 +776,44 @@ static inline int expired_starving(runqu
 }
 
 /*
+ * Calculate the expected normal priority: i.e. priority
+ * without taking RT-inheritance into account. Might be
+ * boosted by interactivity modifiers. Changes upon fork,
+ * setprio syscalls, and whenever the interactivity
+ * estimator recalculates.
+ */
+static inline int normal_prio(task_t *p)
+{
+	int prio;
+
+	if (p->policy != SCHED_NORMAL && p->policy != SCHED_BATCH)
+		prio = MAX_RT_PRIO-1 - p->rt_priority;
+	else
+		prio = __normal_prio(p);
+	return prio;
+}
+
+/*
+ * Calculate the current priority, i.e. the priority
+ * taken into account by the scheduler. This value might
+ * be boosted by RT tasks, or might be boosted by
+ * interactivity modifiers. Will be RT if the task got
+ * RT-boosted. If not then it returns p->normal_prio.
+ */
+static int effective_prio(task_t *p)
+{
+	p->normal_prio = normal_prio(p);
+	/*
+	 * If we are RT tasks or we were boosted to RT priority,
+	 * keep the priority unchanged. Otherwise, update priority
+	 * to the normal priority:
+	 */
+	if (!rt_prio(p->prio))
+		return p->normal_prio;
+	return p->prio;
+}
+
+/*
  * __activate_task - move a task to the runqueue.
  */
 static void __activate_task(task_t *p, runqueue_t *rq)
@@ -799,6 +835,10 @@ static inline void __activate_idle_task(
 	inc_nr_running(p, rq);
 }
 
+/*
+ * Recalculate p->normal_prio and p->prio after having slept,
+ * updating the sleep-average too:
+ */
 static int recalc_task_prio(task_t *p, unsigned long long now)
 {
 	/* Caller must always ensure 'now >= p->timestamp' */
@@ -1561,6 +1601,7 @@ void fastcall wake_up_new_task(task_t *p
 				__activate_task(p, rq);
 			else {
 				p->prio = current->prio;
+				p->normal_prio = current->normal_prio;
 				list_add_tail(&p->run_list, &current->run_list);
 				p->array = current->array;
 				p->array->nr_active++;
@@ -3629,6 +3670,59 @@ long fastcall __sched sleep_on_timeout(w
 
 EXPORT_SYMBOL(sleep_on_timeout);
 
+#ifdef CONFIG_RT_MUTEXES
+
+/*
+ * rt_mutex_setprio - set the current priority of a task
+ * @p: task
+ * @prio: prio value (kernel-internal form)
+ *
+ * This function changes the 'effective' priority of a task. It does
+ * not touch ->normal_prio like __setscheduler().
+ *
+ * Used by the rt_mutex code to implement priority inheritance logic.
+ */
+void rt_mutex_setprio(task_t *p, int prio)
+{
+	unsigned long flags;
+	prio_array_t *array;
+	runqueue_t *rq;
+	int oldprio;
+
+	BUG_ON(prio < 0 || prio > MAX_PRIO);
+
+	rq = task_rq_lock(p, &flags);
+
+	oldprio = p->prio;
+	array = p->array;
+	if (array)
+		dequeue_task(p, array);
+	p->prio = prio;
+
+	if (array) {
+		/*
+		 * If changing to an RT priority then queue it
+		 * in the active array!
+		 */
+		if (rt_task(p))
+			array = rq->active;
+		enqueue_task(p, array);
+		/*
+		 * Reschedule if we are currently running on this runqueue and
+		 * our priority decreased, or if we are not currently running on
+		 * this runqueue and our priority is higher than the current's
+		 */
+		if (task_running(rq, p)) {
+			if (p->prio > oldprio)
+				resched_task(rq->curr);
+		} else if (TASK_PREEMPTS_CURR(p, rq))
+			resched_task(rq->curr);
+	}
+	task_rq_unlock(rq, &flags);
+}
+
+#endif
+
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
@@ -3799,16 +3893,16 @@ static void __setscheduler(struct task_s
 	BUG_ON(p->array);
 	p->policy = policy;
 	p->rt_priority = prio;
-	if (policy != SCHED_NORMAL && policy != SCHED_BATCH) {
-		p->prio = MAX_RT_PRIO-1 - p->rt_priority;
-	} else {
-		p->prio = p->static_prio;
-		/*
-		 * SCHED_BATCH tasks are treated as perpetual CPU hogs:
-		 */
-		if (policy == SCHED_BATCH)
-			p->sleep_avg = 0;
-	}
+
+	p->normal_prio = normal_prio(p);
+	/* we are holding p->pi_list already */
+	p->prio = rt_mutex_getprio(p);
+	/*
+	 * SCHED_BATCH tasks are treated as perpetual CPU hogs:
+	 */
+	if (policy == SCHED_BATCH)
+		p->sleep_avg = 0;
+
 	set_load_weight(p);
 }
 
@@ -3876,6 +3970,11 @@ recheck:
 	if (retval)
 		return retval;
 	/*
+	 * make sure no PI-waiters arrive (or leave) while we are
+	 * changing the priority of the task:
+	 */
+	spin_lock(&p->pi_lock);
+	/*
 	 * To be able to change p->policy safely, the apropriate
 	 * runqueue lock must be held.
 	 */
@@ -3884,6 +3983,7 @@ recheck:
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, &flags);
+		spin_unlock(&p->pi_lock);
 		goto recheck;
 	}
 	array = p->array;
@@ -3905,6 +4005,8 @@ recheck:
 			resched_task(rq->curr);
 	}
 	task_rq_unlock(rq, &flags);
+	spin_unlock(&p->pi_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sched_setscheduler);
@@ -4529,7 +4631,7 @@ void __devinit init_idle(task_t *idle, i
 	idle->timestamp = sched_clock();
 	idle->sleep_avg = 0;
 	idle->array = NULL;
-	idle->prio = MAX_PRIO;
+	idle->prio = idle->normal_prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
 	idle->cpus_allowed = cpumask_of_cpu(cpu);
 	set_task_cpu(idle, cpu);
@@ -6473,6 +6575,7 @@ void normalize_rt_tasks(void)
 		if (!rt_task(p))
 			continue;
 
+		spin_lock(&p->pi_lock);
 		rq = task_rq_lock(p, &flags);
 
 		array = p->array;
@@ -6485,6 +6588,7 @@ void normalize_rt_tasks(void)
 		}
 
 		task_rq_unlock(rq, &flags);
+		spin_unlock(&p->pi_lock);
 	}
 	read_unlock_irq(&tasklist_lock);
 }
