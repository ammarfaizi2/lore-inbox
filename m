Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVGJPKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVGJPKv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 11:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVGJPKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 11:10:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26581 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261952AbVGJPKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 11:10:48 -0400
Date: Sun, 10 Jul 2005 17:10:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
Message-ID: <20050710151008.GA28194@elte.hu>
References: <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org> <20050707104859.GD22422@elte.hu> <Pine.LNX.4.58.0507071257320.25321@echo.lysdexia.org> <20050708080359.GA32001@elte.hu> <Pine.LNX.4.58.0507081246340.30549@echo.lysdexia.org> <1120944243.12169.3.camel@twins> <1120994288.14680.0.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120994288.14680.0.camel@twins>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> > I can reproduce priority leakage on my SMP system; any userspace process
> > chrt'ed up and a lot will follow. This makes the system very
> > unresponsive when doing a make -j5. Verified on 51-{6,18,23}.
> > 
> 
> The following patch seems to fix it for me, YMMV.
> 
> --- kernel/sched.c~     2005-07-08 10:27:59.000000000 +0200
> +++ kernel/sched.c      2005-07-10 13:00:42.000000000 +0200
> @@ -780,7 +780,8 @@ static void recalc_task_prio(task_t *p,
>                 }
>         }
> 
> -       p->prio = p->normal_prio = effective_prio(p);
> +       p->prio = effective_prio(p);
> +       p->normal_prio = unlikely(rt_prio(p->normal_prio)) ? p->prio : __effective_prio(p);
>  }

ahh, indeed, this code did not take boosting into account. Good catch!  
I'm wondering why this only showed up on SMP. I've fixed it a bit 
differently in my tree, by making the roles of the various priority 
fields and functions more obvious, see the delta patch below.  I've also 
released the -51-23 patch with these changes included. Does this fix 
priority leakage on your SMP system?

	Ingo

Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -1035,7 +1035,7 @@ extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
 extern task_t *idle_task(int cpu);
 extern void mutex_setprio(task_t *p, int prio);
-extern int mutex_getprio(task_t *p);
+extern int normal_prio(task_t *p);
 
 void yield(void);
 void __yield(void);
Index: linux/kernel/rt.c
===================================================================
--- linux.orig/kernel/rt.c
+++ linux/kernel/rt.c
@@ -720,7 +720,7 @@ static void pi_setprio(struct rt_mutex *
 
 #ifdef CONFIG_RT_DEADLOCK_DETECT
 	pi_prio++;
-	if (p->policy != SCHED_NORMAL && prio > mutex_getprio(p)) {
+	if (p->policy != SCHED_NORMAL && prio > normal_prio(p)) {
 		TRACE_OFF();
 
 		printk("huh? (%d->%d??)\n", p->prio, prio);
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -645,7 +645,7 @@ static inline void enqueue_task_head(str
 }
 
 /*
- * effective_prio - return the priority that is based on the static
+ * __normal_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
  *
  * We scale the actual sleep average [0 .... MAX_SLEEP_AVG]
@@ -659,7 +659,7 @@ static inline void enqueue_task_head(str
  * Both properties are important to certain workloads.
  */
 
-static inline int __effective_prio(task_t *p)
+static inline int __normal_prio(task_t *p)
 {
 	int bonus, prio;
 
@@ -670,57 +670,53 @@ static inline int __effective_prio(task_
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
 		prio = MAX_PRIO-1;
-	return prio;
-}
 
-static int effective_prio(task_t *p)
-{
-	if (rt_task(p))
-		return p->prio;
-	return __effective_prio(p);
-}
-
-static inline void trace_start_sched_wakeup(task_t *p, runqueue_t *rq)
-{
-	if (TASK_PREEMPTS_CURR(p, rq) && (p != rq->curr))
-		__trace_start_sched_wakeup(p);
+	return prio;
 }
 
 /*
- * __activate_task - move a task to the runqueue.
+ * Calculate the expected normal priority: i.e. priority
+ * without taking RT-inheritance into account. Might be
+ * boosted by interactivity modifiers. Changes upon fork,
+ * setprio syscalls, and whenever the interactivity
+ * estimator recalculates.
  */
-static inline void __activate_task(task_t *p, runqueue_t *rq)
+inline int normal_prio(task_t *p)
 {
-	trace_special_pid(p->pid, p->prio, rq->nr_running);
-	enqueue_task(p, rq->active);
-	rq->nr_running++;
+	int prio;
+
+	if (p->policy != SCHED_NORMAL)
+		prio = MAX_RT_PRIO-1 - p->rt_priority;
+	else
+		prio = __normal_prio(p);
+
+	trace_special_pid(p->pid, p->prio, prio);
+	return prio;
 }
 
 /*
- * __activate_task_after - move a task to the runqueue,
- *                         to execute after a specific task.
+ * Calculate the current priority, i.e. the priority
+ * taken into account by the scheduler. This value might
+ * be boosted by RT tasks, or might be boosted by
+ * interactivity modifiers. Will be RT if the task got
+ * RT-boosted. If not then it returns p->normal_prio.
  */
-static inline
-void __activate_task_after(task_t *p, task_t *parent, runqueue_t *rq)
+static void __recalc_task_prio(task_t *p)
 {
-	// FIXME: to head rather?
-	list_add_tail(&p->run_list, &parent->run_list);
-	p->array = parent->array;
-	p->array->nr_active++;
-	rq->nr_running++;
-	inc_rt_tasks(p, rq);
+	p->normal_prio = normal_prio(p);
+	/*
+	 * If we are RT tasks or we were boosted to RT priority,
+	 * keep the priority unchanged. Otherwise, update priority
+	 * to the normal priority:
+	 */
+	if (!rt_prio(p->prio))
+		p->prio = p->normal_prio;
 }
 
 /*
- * __activate_idle_task - move idle task to the _front_ of runqueue.
+ * Recalculate p->normal_prio and p->prio after having slept,
+ * updating the sleep-average too:
  */
-static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
-{
-	enqueue_task_head(p, rq->active);
-	rq->nr_running++;
-	WARN_ON(rt_task(p));
-}
-
 static void recalc_task_prio(task_t *p, unsigned long long now)
 {
 	/* Caller must always ensure 'now >= p->timestamp' */
@@ -780,7 +776,48 @@ static void recalc_task_prio(task_t *p, 
 		}
 	}
 
-	p->prio = p->normal_prio = effective_prio(p);
+	__recalc_task_prio(p);
+}
+
+static inline void trace_start_sched_wakeup(task_t *p, runqueue_t *rq)
+{
+	if (TASK_PREEMPTS_CURR(p, rq) && (p != rq->curr))
+		__trace_start_sched_wakeup(p);
+}
+
+/*
+ * __activate_task - move a task to the runqueue.
+ */
+static inline void __activate_task(task_t *p, runqueue_t *rq)
+{
+	trace_special_pid(p->pid, p->prio, rq->nr_running);
+	enqueue_task(p, rq->active);
+	rq->nr_running++;
+}
+
+/*
+ * __activate_task_after - move a task to the runqueue,
+ *                         to execute after a specific task.
+ */
+static inline
+void __activate_task_after(task_t *p, task_t *parent, runqueue_t *rq)
+{
+	// FIXME: to head rather?
+	list_add_tail(&p->run_list, &parent->run_list);
+	p->array = parent->array;
+	p->array->nr_active++;
+	rq->nr_running++;
+	inc_rt_tasks(p, rq);
+}
+
+/*
+ * __activate_idle_task - move idle task to the _front_ of runqueue.
+ */
+static inline void __activate_idle_task(task_t *p, runqueue_t *rq)
+{
+	enqueue_task_head(p, rq->active);
+	rq->nr_running++;
+	WARN_ON(rt_task(p));
 }
 
 /*
@@ -1415,7 +1452,7 @@ void fastcall wake_up_new_task(task_t * 
 	p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
 		CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);
 
-	p->prio = p->normal_prio = effective_prio(p);
+	__recalc_task_prio(p);
 
 	if (likely(cpu == this_cpu)) {
 		if (!(clone_flags & CLONE_VM)) {
@@ -1427,7 +1464,8 @@ void fastcall wake_up_new_task(task_t * 
 			if (unlikely(!current->array))
 				__activate_task(p, rq);
 			else {
-				p->prio = p->normal_prio = current->prio;
+				p->prio = current->prio;
+				p->normal_prio = current->normal_prio;
 				__activate_task_after(p, current, rq);
 			}
 			set_need_resched();
@@ -2730,6 +2768,10 @@ void scheduler_tick(void)
 		/*
 		 * RR tasks need a special form of timeslice management.
 		 * FIFO tasks have no timeslices.
+		 *
+		 * On PREEMPT_RT, boosted tasks will also get into this
+		 * branch and wont get their timeslice decreased until
+		 * they have done their work.
 		 */
 		if ((p->policy == SCHED_RR) && !--p->time_slice) {
 			p->time_slice = task_timeslice(p);
@@ -2744,7 +2786,7 @@ void scheduler_tick(void)
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
-		p->prio = p->normal_prio = effective_prio(p);
+		__recalc_task_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
@@ -3682,7 +3724,7 @@ void set_user_nice(task_t *p, long nice)
 	new_prio = NICE_TO_PRIO(nice);
 	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
-	p->prio += delta;
+	__recalc_task_prio(p);
 
 	if (array) {
 		enqueue_task(p, array);
@@ -3712,18 +3754,6 @@ int can_nice(const task_t *p, const int 
 		capable(CAP_SYS_NICE));
 }
 
-int mutex_getprio(task_t *p)
-{
-	int prio;
-
-	if (p->policy != SCHED_NORMAL)
-		prio = MAX_RT_PRIO-1 - p->rt_priority;
-	else
-		prio = __effective_prio(p);
-	trace_special_pid(p->pid, p->prio, prio);
-	return prio;
-}
-
 /*
  * Used by the PREEMPT_RT code to implement
  * priority inheritance logic:
@@ -3880,10 +3910,7 @@ static void __setscheduler(struct task_s
 	BUG_ON(p->array);
 	p->policy = policy;
 	p->rt_priority = prio;
-	if (policy != SCHED_NORMAL)
-		p->prio = p->normal_prio = MAX_RT_PRIO-1 - p->rt_priority;
-	else
-		p->prio = p->normal_prio = p->static_prio;
+	__recalc_task_prio(p);
 }
 
 /**
