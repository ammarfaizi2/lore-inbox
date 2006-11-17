Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755966AbWKQWRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966AbWKQWRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbWKQWRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:17:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:19913 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1755966AbWKQWRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:17:17 -0500
X-Authenticated: #14349625
Subject: Re: [rfc patch] Re: sched: incorrect argument used in task_hot()
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       nickpiggin@yahoo.com.au, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061117133951.ca22ca7b.akpm@osdl.org>
References: <000201c70840$a4902df0$d834030a@amr.corp.intel.com>
	 <1163782610.22574.59.camel@Homer.simpson.net>
	 <20061117192052.GA23272@elte.hu>
	 <1163799034.23357.2.camel@Homer.simpson.net>
	 <20061117133951.ca22ca7b.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 23:18:53 +0100
Message-Id: <1163801933.23357.33.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 13:39 -0800, Andrew Morton wrote:
> On Fri, 17 Nov 2006 22:30:34 +0100
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > On Fri, 2006-11-17 at 20:20 +0100, Ingo Molnar wrote:
> > > * Mike Galbraith <efault@gmx.de> wrote:
> > > 
> > > > One way to improve granularity, and eliminate the possibility of 
> > > > p->last_run being > rq->timestamp_tast_tick, and thereby short 
> > > > circuiting the evaluation of cache_hot_time, is to cache the last 
> > > > return of sched_clock() at both tick and sched times, and use that 
> > > > value as our reference instead of the absolute time of the tick.  It 
> > > > won't totally eliminate skew, but it moves the reference point closer 
> > > > to the current time on the remote cpu.
> > > > 
> > > > Looking for a good place to do this, I chose update_cpu_clock().
> > > 
> > > looks good to me - thus we will update the timestamp not only in the 
> > > timer tick, but also upon every context-switch (when we acquire 
> > > sched_clock() value anyway). Lets try this in -mm?
> > > 
> > > Acked-by: Ingo Molnar <mingo@elte.hu>
> > 
> > Then it needs a blame line.
> > 
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
> >
> 
> And a changelog, then we're all set!
> 
> Oh.  And a patch, too.

Co-opt rq->timestamp_last_tick to maintain a cache_hot_time evaluation
reference timestamp at both tick and sched times to prevent said
reference, formerly rq->timestamp_last_tick, from being behind
task->last_ran at evaluation time, and to move said reference closer to
current time on the remote processor, intent being to improve cache hot
evaluation and timestamp adjustment accuracy for task migration.

Fix minor sched_time double accounting error which occurs when a task
passing through schedule() does not schedule off, and takes the next
timer tick.

Signed-off-by: Mike Galbraith <efault@gmx.de>
Acked-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Ken Chen <kenneth.w.chen@intel.com>

--- linux-2.6.19-rc5-mm2/kernel/sched.c.org	2006-11-15 10:14:07.000000000 +0100
+++ linux-2.6.19-rc5-mm2/kernel/sched.c	2006-11-17 15:42:46.000000000 +0100
@@ -226,7 +226,8 @@ struct rq {
 	unsigned long nr_uninterruptible;
 
 	unsigned long expired_timestamp;
-	unsigned long long timestamp_last_tick;
+	/* Cached timestamp set by update_cpu_clock() */
+	unsigned long long most_recent_timestamp;
 	struct task_struct *curr, *idle;
 	struct mm_struct *prev_mm;
 	struct prio_array *active, *expired, arrays[2];
@@ -947,8 +948,8 @@ static void activate_task(struct task_st
 	if (!local) {
 		/* Compensate for drifting sched_clock */
 		struct rq *this_rq = this_rq();
-		now = (now - this_rq->timestamp_last_tick)
-			+ rq->timestamp_last_tick;
+		now = (now - this_rq->most_recent_timestamp)
+			+ rq->most_recent_timestamp;
 	}
 #endif
 
@@ -1694,8 +1695,8 @@ void fastcall wake_up_new_task(struct ta
 		 * Not the local CPU - must adjust timestamp. This should
 		 * get optimised away in the !CONFIG_SMP case.
 		 */
-		p->timestamp = (p->timestamp - this_rq->timestamp_last_tick)
-					+ rq->timestamp_last_tick;
+		p->timestamp = (p->timestamp - this_rq->most_recent_timestamp)
+					+ rq->most_recent_timestamp;
 		__activate_task(p, rq);
 		if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
@@ -2067,8 +2068,8 @@ static void pull_task(struct rq *src_rq,
 	set_task_cpu(p, this_cpu);
 	inc_nr_running(p, this_rq);
 	enqueue_task(p, this_array);
-	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
-				+ this_rq->timestamp_last_tick;
+	p->timestamp = (p->timestamp - src_rq->most_recent_timestamp)
+				+ this_rq->most_recent_timestamp;
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
@@ -2107,7 +2108,7 @@ int can_migrate_task(struct task_struct 
 	if (sd->nr_balance_failed > sd->cache_nice_tries)
 		return 1;
 
-	if (task_hot(p, rq->timestamp_last_tick, sd))
+	if (task_hot(p, rq->most_recent_timestamp, sd))
 		return 0;
 	return 1;
 }
@@ -2206,7 +2207,7 @@ skip_queue:
 	}
 
 #ifdef CONFIG_SCHEDSTATS
-	if (task_hot(tmp, busiest->timestamp_last_tick, sd))
+	if (task_hot(tmp, busiest->most_recent_timestamp, sd))
 		schedstat_inc(sd, lb_hot_gained[idle]);
 #endif
 
@@ -2943,7 +2944,8 @@ EXPORT_PER_CPU_SYMBOL(kstat);
 static inline void
 update_cpu_clock(struct task_struct *p, struct rq *rq, unsigned long long now)
 {
-	p->sched_time += now - max(p->timestamp, rq->timestamp_last_tick);
+	p->sched_time += now - p->timestamp;
+	p->timestamp = rq->most_recent_timestamp = now;
 }
 
 /*
@@ -2956,8 +2958,7 @@ unsigned long long current_sched_time(co
 	unsigned long flags;
 
 	local_irq_save(flags);
-	ns = max(p->timestamp, task_rq(p)->timestamp_last_tick);
-	ns = p->sched_time + sched_clock() - ns;
+	ns = p->sched_time + sched_clock() - p->timestamp;
 	local_irq_restore(flags);
 
 	return ns;
@@ -3073,8 +3074,6 @@ void scheduler_tick(void)
 
 	update_cpu_clock(p, rq, now);
 
-	rq->timestamp_last_tick = now;
-
 	if (p == rq->idle) {
 		if (wake_priority_sleeper(rq))
 			goto out;
@@ -3466,11 +3465,10 @@ switch_tasks:
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0)
 		prev->sleep_avg = 0;
-	prev->timestamp = prev->last_ran = now;
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
-		next->timestamp = now;
+		next->timestamp = prev->last_ran = now;
 		rq->nr_switches++;
 		rq->curr = next;
 		++*switch_count;
@@ -5000,8 +4998,8 @@ static int __migrate_task(struct task_st
 		 * afterwards, and pretending it was a local activate.
 		 * This way is cleaner and logically correct.
 		 */
-		p->timestamp = p->timestamp - rq_src->timestamp_last_tick
-				+ rq_dest->timestamp_last_tick;
+		p->timestamp = p->timestamp - rq_src->most_recent_timestamp
+				+ rq_dest->most_recent_timestamp;
 		deactivate_task(p, rq_src);
 		__activate_task(p, rq_dest);
 		if (TASK_PREEMPTS_CURR(p, rq_dest))


