Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315718AbSFJSvC>; Mon, 10 Jun 2002 14:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSFJSvB>; Mon, 10 Jun 2002 14:51:01 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:30445 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315718AbSFJSu7>; Mon, 10 Jun 2002 14:50:59 -0400
Date: Mon, 10 Jun 2002 11:50:20 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Scheduler Bug (set_cpus_allowed)
Message-ID: <20020610115020.B1565@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020606162028.E3193@w-mikek2.des.beaverton.ibm.com> <1023475007.1137.62.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert,

It looks like you got the set_cpus_allowed() optimization removed
in the 2.5.21 release.  Thanks!

However, even with this code removed there are still some races in
the scheduler.  Specifically, load_balance() can race with schedule()
in the code around the call to context switch().  Below, is a patch
that addresses these races.  It may not be the most elegant solution,
but is seemed the most straight forward.  It also reintroduces the
set_cpus_allowed() optimization, but my main concern is with the
other races.  Whether or not the optimization goes in is no big deal.

-- 
Mike


diff -Naur linux-2.5.21/kernel/sched.c linux-2.5.21-fix/kernel/sched.c
--- linux-2.5.21/kernel/sched.c	Sun Jun  9 05:28:13 2002
+++ linux-2.5.21-fix/kernel/sched.c	Mon Jun 10 18:26:55 2002
@@ -138,7 +138,7 @@
 	spinlock_t frozen;
 	unsigned long nr_running, nr_switches, expired_timestamp;
 	signed long nr_uninterruptible;
-	task_t *curr, *idle;
+	task_t *prev, *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
 	task_t *migration_thread;
@@ -152,6 +152,7 @@
 #define task_rq(p)		cpu_rq((p)->thread_info->cpu)
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
+#define running_on_rq(p, rq)	(((p) == (rq)->curr) || ((p) == (rq)->prev))
 
 static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
@@ -284,12 +285,12 @@
 repeat:
 	preempt_disable();
 	rq = task_rq(p);
-	while (unlikely(rq->curr == p)) {
+	while (unlikely(running_on_rq(p, rq))) {
 		cpu_relax();
 		barrier();
 	}
 	rq = task_rq_lock(p, &flags);
-	if (unlikely(rq->curr == p)) {
+	if (unlikely(running_on_rq(p, rq))) {
 		task_rq_unlock(rq, &flags);
 		preempt_enable();
 		goto repeat;
@@ -604,7 +605,7 @@
 
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
-		((p) != (rq)->curr) &&					\
+		(!running_on_rq(p, rq)) &&				\
 			((p)->cpus_allowed & (1UL << (this_cpu))))
 
 	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
@@ -827,6 +828,7 @@
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
+		rq->prev = prev;
 		rq->curr = next;
 		spin_lock(&rq->frozen);
 		spin_unlock(&rq->lock);
@@ -840,6 +842,7 @@
 		 */
 		mb();
 		rq = this_rq();
+		rq->prev = NULL;
 		spin_unlock_irq(&rq->frozen);
 	} else {
 		spin_unlock_irq(&rq->lock);
@@ -1687,6 +1690,16 @@
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
+
+	/*
+	 * If the task is not on a runqueue (and not running), then
+	 * it is sufficient to simply update the task's cpu field.
+	 */
+	if (!p->array && !running_on_rq(p, rq)) {
+		p->thread_info->cpu = __ffs(p->cpus_allowed);
+		task_rq_unlock(rq, &flags);
+		goto out;
+	}
 
 	init_MUTEX_LOCKED(&req.sem);
 	req.task = p;
