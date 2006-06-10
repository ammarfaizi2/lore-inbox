Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWFJHWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWFJHWN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 03:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWFJHWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 03:22:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59857 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932414AbWFJHWN (ORCPT
	<rfc822;linux-kerneL@vger.kernel.org>);
	Sat, 10 Jun 2006 03:22:13 -0400
Date: Sat, 10 Jun 2006 09:21:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: linux-kerneL@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Message-ID: <20060610072129.GA14567@elte.hu>
References: <200606091701.55185.dvhltc@us.ibm.com> <20060610064850.GA11002@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610064850.GA11002@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5995]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> could you try the (untested) patch below, does it solve your testcase 
> too?

find updated patch below:

 - fix small race: use this_rq->curr not 'current'.

 - optimize the case where current CPU could be preempted and do not 
   send IPIs.

 - integrate the RT-overload global statistics counters into schedstats. 
   This should make things more scalable.

	Ingo

Index: linux-rt.q/kernel/sched.c
===================================================================
--- linux-rt.q.orig/kernel/sched.c
+++ linux-rt.q/kernel/sched.c
@@ -292,6 +292,11 @@ struct runqueue {
 	/* try_to_wake_up() stats */
 	unsigned long ttwu_cnt;
 	unsigned long ttwu_local;
+
+	/* RT-overload stats: */
+	unsigned long rto_schedule;
+	unsigned long rto_wakeup;
+	unsigned long rto_pulled;
 #endif
 };
 
@@ -426,7 +431,7 @@ static inline void task_rq_unlock(runque
  * bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 12
+#define SCHEDSTAT_VERSION 13
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -443,13 +448,14 @@ static int show_schedstat(struct seq_fil
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
+		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
 		    cpu, rq->yld_both_empty,
 		    rq->yld_act_empty, rq->yld_exp_empty, rq->yld_cnt,
 		    rq->sched_switch, rq->sched_cnt, rq->sched_goidle,
 		    rq->ttwu_cnt, rq->ttwu_local,
 		    rq->rq_sched_info.cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcnt);
+		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcnt,
+		    rq->rto_schedule, rq->rto_wakeup, rq->rto_pulled);
 
 		seq_printf(seq, "\n");
 
@@ -640,9 +646,7 @@ static inline void sched_info_switch(tas
 #define sched_info_switch(t, next)	do { } while (0)
 #endif /* CONFIG_SCHEDSTATS */
 
-int rt_overload_schedule, rt_overload_wakeup, rt_overload_pulled;
-
-__cacheline_aligned_in_smp atomic_t rt_overload;
+static __cacheline_aligned_in_smp atomic_t rt_overload;
 
 static inline void inc_rt_tasks(task_t *p, runqueue_t *rq)
 {
@@ -1312,7 +1316,7 @@ static void balance_rt_tasks(runqueue_t 
 		if (p && (p->prio < next->prio)) {
 			WARN_ON(p == src_rq->curr);
 			WARN_ON(!p->array);
-			rt_overload_pulled++;
+			schedstat_inc(this_rq, rto_pulled);
 
 			set_task_cpu(p, this_cpu);
 
@@ -1469,9 +1473,9 @@ static inline int wake_idle(int cpu, tas
 static int try_to_wake_up(task_t *p, unsigned int state, int sync, int mutex)
 {
 	int cpu, this_cpu, success = 0;
+	runqueue_t *this_rq, *rq;
 	unsigned long flags;
 	long old_state;
-	runqueue_t *rq;
 #ifdef CONFIG_SMP
 	unsigned long load, this_load;
 	struct sched_domain *sd, *this_sd = NULL;
@@ -1587,12 +1591,34 @@ out_set_cpu:
 	} else {
 		/*
 		 * If a newly woken up RT task cannot preempt the
-		 * current (RT) task then try to find another
-		 * CPU it can preempt:
+		 * current (RT) task (on a target runqueue) then try
+		 * to find another CPU it can preempt:
 		 */
 		if (rt_task(p) && !TASK_PREEMPTS_CURR(p, rq)) {
-			smp_send_reschedule_allbutself();
-			rt_overload_wakeup++;
+			this_rq = cpu_rq(this_cpu);
+			/*
+			 * Special-case: the task on this CPU can be
+			 * preempted. In that case there's no need to
+			 * trigger reschedules on other CPUs, we can
+			 * mark the current task for reschedule.
+			 *
+			 * (Note that it's safe to access this_rq without
+			 * extra locking in this particular case, because
+			 * we are on the current CPU.)
+			 */
+			if (TASK_PREEMPTS_CURR(p, this_rq))
+				set_tsk_need_resched(this_rq->curr);
+			else
+				/*
+				 * Neither the intended target runqueue
+				 * nor the current CPU can take this task.
+				 * Trigger a reschedule on all other CPUs
+				 * nevertheless, maybe one of them can take
+				 * this task:
+				 */
+				smp_send_reschedule_allbutself();
+
+			schedstat_inc(this_rq, rto_wakeup);
 		}
 	}
 
@@ -1951,7 +1977,7 @@ static inline void finish_task_switch(ru
 	 * then kick other CPUs, they might run it:
 	 */
 	if (unlikely(rt_task(current) && prev->array && rt_task(prev))) {
-		rt_overload_schedule++;
+		schedstat_inc(rq, rto_schedule);
 		smp_send_reschedule_allbutself();
 	}
 #endif
