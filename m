Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUAHLuC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 06:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbUAHLuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 06:50:02 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:26792 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264337AbUAHLtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 06:49:06 -0500
Date: Thu, 8 Jan 2004 17:19:58 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [patch] RCU for low latency [1/2]
Message-ID: <20040108114958.GB5128@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040108114851.GA5128@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108114851.GA5128@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Provide a rq_has_rt_task() interface to detect runqueues with
real time priority tasks. Useful for RCU optimizations.


 include/linux/sched.h |    1 +
 kernel/sched.c        |   31 ++++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff -puN include/linux/sched.h~rq-has-rt-task include/linux/sched.h
--- linux-2.6.0-test8-smprcu/include/linux/sched.h~rq-has-rt-task	2003-12-29 19:40:46.000000000 +0530
+++ linux-2.6.0-test8-smprcu-dipankar/include/linux/sched.h	2003-12-29 19:40:46.000000000 +0530
@@ -524,6 +524,7 @@ extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
 extern int task_curr(task_t *p);
 extern int idle_cpu(int cpu);
+extern int rq_has_rt_task(int cpu);
 
 void yield(void);
 
diff -puN kernel/sched.c~rq-has-rt-task kernel/sched.c
--- linux-2.6.0-test8-smprcu/kernel/sched.c~rq-has-rt-task	2003-12-29 19:40:46.000000000 +0530
+++ linux-2.6.0-test8-smprcu-dipankar/kernel/sched.c	2003-12-29 19:40:46.000000000 +0530
@@ -199,7 +199,7 @@ struct prio_array {
 struct runqueue {
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, expired_timestamp,
-			nr_uninterruptible;
+			nr_uninterruptible, nr_rt_running;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
@@ -275,6 +275,19 @@ __init void node_nr_running_init(void)
 
 #endif /* CONFIG_NUMA */
 
+static inline void nr_rt_running_inc(runqueue_t *rq, struct task_struct *p)
+{
+	if (rt_task(p))
+		rq->nr_rt_running++;
+}
+
+static inline void nr_rt_running_dec(runqueue_t *rq, struct task_struct *p)
+{
+	if (rt_task(p))
+		rq->nr_rt_running--;
+}
+
+
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
@@ -339,6 +352,17 @@ static inline void enqueue_task(struct t
 }
 
 /*
+ * rq_has_rt_task - return 1 if the runqueue has any RT task else return 0
+ * It does not lock the runqueue, the caller needs to explicitly lock
+ * the runqueue if it cares about that.
+ */
+int rq_has_rt_task(int cpu)
+{
+	struct runqueue *rq = cpu_rq(cpu);
+	return (rq->nr_rt_running != 0);
+}
+
+/*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
  *
@@ -376,6 +400,7 @@ static inline void __activate_task(task_
 {
 	enqueue_task(p, rq->active);
 	nr_running_inc(rq);
+	nr_rt_running_inc(rq, p);
 }
 
 static void recalc_task_prio(task_t *p, unsigned long long now)
@@ -498,6 +523,7 @@ static inline void activate_task(task_t 
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	nr_running_dec(rq);
+	nr_rt_running_dec(rq, p);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -691,6 +717,7 @@ void wake_up_forked_process(task_t * p)
 		p->array = current->array;
 		p->array->nr_active++;
 		nr_running_inc(rq);
+		nr_rt_running_inc(rq, p);
 	}
 	task_rq_unlock(rq, &flags);
 }
@@ -1117,8 +1144,10 @@ static inline void pull_task(runqueue_t 
 {
 	dequeue_task(p, src_array);
 	nr_running_dec(src_rq);
+	nr_rt_running_dec(src_rq, p);
 	set_task_cpu(p, this_cpu);
 	nr_running_inc(this_rq);
+	nr_rt_running_inc(this_rq, p);
 	enqueue_task(p, this_rq->active);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test

_
