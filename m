Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290361AbSAPFtP>; Wed, 16 Jan 2002 00:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290366AbSAPFtG>; Wed, 16 Jan 2002 00:49:06 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:52234 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S290361AbSAPFtA>; Wed, 16 Jan 2002 00:49:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] I3 sched tweaks...
Date: Wed, 16 Jan 2002 16:49:09 +1100
Message-Id: <E16Qiwf-0008Fd-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one actually compiles(!!):

1) Comment about RT event id removed (no longer relevent).
2) Order by address, delete rq_cpu().
3) lock_task_rq returns the rq, rather than assigning it, for clarity.
4) scheduler_tick needs no args (p is always equal to current).
5) Unused max_rq_len() function deleted.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre1-mingoI3/include/linux/sched.h working-2.5.3-pre1-mingoI3-fix/include/linux/sched.h
--- linux-2.5.3-pre1-mingoI3/include/linux/sched.h	Wed Jan 16 15:58:58 2002
+++ working-2.5.3-pre1-mingoI3-fix/include/linux/sched.h	Wed Jan 16 16:30:54 2002
@@ -146,7 +146,7 @@
 extern void update_process_times(int user);
 extern void update_one_process(task_t *p, unsigned long user,
 			       unsigned long system, int cpu);
-extern void scheduler_tick(task_t *p);
+extern void scheduler_tick(void);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre1-mingoI3/kernel/fork.c working-2.5.3-pre1-mingoI3-fix/kernel/fork.c
--- linux-2.5.3-pre1-mingoI3/kernel/fork.c	Wed Jan 16 15:17:14 2002
+++ working-2.5.3-pre1-mingoI3-fix/kernel/fork.c	Wed Jan 16 16:45:21 2002
@@ -704,7 +704,7 @@
 		 * runqueue lock is not a problem.
 		 */
 		current->time_slice = 1;
-		scheduler_tick(current);
+		scheduler_tick();
 	}
 	p->sleep_timestamp = jiffies;
 	__restore_flags(flags);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre1-mingoI3/kernel/sched.c working-2.5.3-pre1-mingoI3-fix/kernel/sched.c
--- linux-2.5.3-pre1-mingoI3/kernel/sched.c	Wed Jan 16 15:17:14 2002
+++ working-2.5.3-pre1-mingoI3-fix/kernel/sched.c	Wed Jan 16 16:10:57 2002
@@ -37,11 +37,7 @@
  *
  * Locking rule: those places that want to lock multiple runqueues
  * (such as the load balancing or the process migration code), lock
- * acquire operations must be ordered by the runqueue's cpu id.
- *
- * The RT event id is used to avoid calling into the the RT scheduler
- * if there is a RT task active in an SMP system but there is no
- * RT scheduling activity otherwise.
+ * acquire operations must be ordered by ascending &runqueue.
  */
 struct runqueue {
 	spinlock_t lock;
@@ -57,22 +53,24 @@
 #define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq((p)->cpu)
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
-#define rq_cpu(rq)		((rq) - runqueues)
 #define rt_task(p)		((p)->policy != SCHED_OTHER)
 
-
-#define lock_task_rq(rq,p,flags)				\
-do {								\
+#define lock_task_rq(p,flags)					\
+({								\
+	__label__ repeat_lock_task;				\
+	struct runqueue *__rq;					\
+								\
 repeat_lock_task:						\
-	rq = task_rq(p);					\
-	spin_lock_irqsave(&rq->lock, flags);			\
-	if (unlikely(rq_cpu(rq) != (p)->cpu)) {			\
-		spin_unlock_irqrestore(&rq->lock, flags);	\
+	__rq = task_rq(p);					\
+	spin_lock_irqsave(&__rq->lock, (flags));		\
+	if (unlikely(__rq != task_rq(p))) {			\
+		spin_unlock_irqrestore(&__rq->lock, flags);	\
 		goto repeat_lock_task;				\
 	}							\
-} while (0)
+	__rq;							\
+})
 
-#define unlock_task_rq(rq,p,flags)				\
+#define unlock_task_rq(rq,p,flags)			\
 	spin_unlock_irqrestore(&rq->lock, flags)
 
 /*
@@ -185,7 +183,7 @@
 		cpu_relax();
 		barrier();
 	}
-	lock_task_rq(rq, p, flags);
+	rq = lock_task_rq(p, flags);
 	if (unlikely(rq->curr == p)) {
 		unlock_task_rq(rq, p, flags);
 		goto repeat;
@@ -223,7 +221,7 @@
 	int success = 0;
 	runqueue_t *rq;
 
-	lock_task_rq(rq, p, flags);
+	rq = lock_task_rq(p, flags);
 	p->state = TASK_RUNNING;
 	if (!p->array) {
 		activate_task(p, rq);
@@ -312,18 +310,6 @@
 	return sum;
 }
 
-static inline unsigned long max_rq_len(void)
-{
-	unsigned long i, curr, max = 0;
-
-	for (i = 0; i < smp_num_cpus; i++) {
-		curr = cpu_rq(i)->nr_running;
-		if (curr > max)
-			max = curr;
-	}
-	return max;
-}
-
 /*
  * Current runqueue is empty, or rebalance tick: if there is an
  * inbalance (current runqueue is too short) then pull from
@@ -406,7 +392,7 @@
 	 * Ok, lets do some actual balancing:
 	 */
 
-	if (rq_cpu(busiest) < this_cpu) {
+	if (busiest < this_rq) {
 		spin_unlock(&this_rq->lock);
 		spin_lock(&busiest->lock);
 		spin_lock(&this_rq->lock);
@@ -504,10 +490,11 @@
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
-void scheduler_tick(task_t *p)
+void scheduler_tick(void)
 {
 	unsigned long now = jiffies;
 	runqueue_t *rq = this_rq();
+	task_t *p = current;
 
 	if (p == rq->idle || !rq->idle)
 		return idle_tick();
@@ -839,7 +826,7 @@
 	 * We have to be careful, if called from sys_setpriority(),
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
-	lock_task_rq(rq, p, flags);
+	rq = lock_task_rq(p, flags);
 	if (rt_task(p)) {
 		p->__nice = nice;
 		goto out_unlock;
@@ -853,7 +840,7 @@
 	if (array) {
 		enqueue_task(p, array);
 		/*
-		 * If the task is runnable and lowered its priority,
+		 * If the task is running and lowered its priority,
 		 * or increased its priority then reschedule its CPU:
 		 */
 		if ((nice < p->__nice) ||
@@ -938,7 +925,7 @@
 	 * To be able to change p->policy safely, the apropriate
 	 * runqueue lock must be held.
 	 */
-	lock_task_rq(rq,p,flags);
+	rq = lock_task_rq(p, flags);
 
 	if (policy < 0)
 		policy = p->policy;
@@ -1231,7 +1218,7 @@
 	if (rq1 == rq2)
 		spin_lock(&rq1->lock);
 	else {
-		if (rq_cpu(rq1) < rq_cpu(rq2)) {
+		if (rq1 < rq2) {
 			spin_lock(&rq1->lock);
 			spin_lock(&rq2->lock);
 		} else {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre1-mingoI3/kernel/timer.c working-2.5.3-pre1-mingoI3-fix/kernel/timer.c
--- linux-2.5.3-pre1-mingoI3/kernel/timer.c	Wed Jan 16 15:17:14 2002
+++ working-2.5.3-pre1-mingoI3-fix/kernel/timer.c	Wed Jan 16 15:55:13 2002
@@ -594,7 +594,7 @@
 		if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
 			kstat.per_cpu_system[cpu] += system;
 	}
-	scheduler_tick(p);
+	scheduler_tick();
 }
 
 /*

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
