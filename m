Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWEBVfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWEBVfz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWEBVfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:35:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7692 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964973AbWEBVfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:35:54 -0400
Date: Tue, 2 May 2006 22:35:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nicolas Pitre <nico@cam.org>, Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
Message-ID: <20060502213547.GA19804@flint.arm.linux.org.uk>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>, Ingo Molnar <mingo@elte.hu>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <p73slns5qda.fsf@bragg.suse.de> <20060502165009.GA4223@flint.arm.linux.org.uk> <200605021901.13882.ak@suse.de> <Pine.LNX.4.64.0605021316380.28543@localhost.localdomain> <20060502185555.GB4223@flint.arm.linux.org.uk> <Pine.LNX.4.64.0605021503230.28543@localhost.localdomain> <20060502190814.GC4223@flint.arm.linux.org.uk> <Pine.LNX.4.64.0605021521390.28543@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605021521390.28543@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 03:23:01PM -0400, Nicolas Pitre wrote:
> On Tue, 2 May 2006, Russell King wrote:
> 
> > On Tue, May 02, 2006 at 03:05:22PM -0400, Nicolas Pitre wrote:
> > > If we're discussing the addition of a sched_clock_diff(), why whouldn't 
> > > shed_clock() return anything it wants in that context?  It could be 
> > > redefined to have a return value meaningful only to shed_clock_diff()?
> > 
> > If we're talking about doing that, we need to replace sched_clock()
> > to ensure that we all users are aware that it has changed.
> > 
> > I did think about that for my original fix proposal, but stepped back
> > because that's a bigger change - and is something for post-2.6.17.
> > The smallest fix (suitable for -rc kernels) is as I detailed.
> 
> Oh agreed.

(Added Ingo - don't know if you saw my original message.)

Actually, I'm not entirely convinced that the smallest fix is going to
be the best solution - it looks too complex.

Note the code change in update_cpu_clock and sched_current_time - arguably
both are buggy as they stand today when the values wrap.

Comments anyone?

diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -988,6 +988,11 @@ static inline int set_cpus_allowed(task_
 extern unsigned long long sched_clock(void);
 extern unsigned long long current_sched_time(const task_t *current_task);
 
+static inline unsigned long long sched_clock_diff(unsigned long long t1, unsigned long long t0)
+{
+	return t1 - t0;
+}
+
 /* sched_exec is called by processes performing an exec */
 #ifdef CONFIG_SMP
 extern void sched_exec(void);
diff --git a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -731,7 +731,7 @@ static inline void __activate_idle_task(
 static int recalc_task_prio(task_t *p, unsigned long long now)
 {
 	/* Caller must always ensure 'now >= p->timestamp' */
-	unsigned long long __sleep_time = now - p->timestamp;
+	unsigned long long __sleep_time = sched_clock_diff(now, p->timestamp);
 	unsigned long sleep_time;
 
 	if (batch_task(p))
@@ -807,7 +807,7 @@ static void activate_task(task_t *p, run
 	if (!local) {
 		/* Compensate for drifting sched_clock */
 		runqueue_t *this_rq = this_rq();
-		now = (now - this_rq->timestamp_last_tick)
+		now = sched_clock_diff(now, this_rq->timestamp_last_tick)
 			+ rq->timestamp_last_tick;
 	}
 #endif
@@ -2512,8 +2512,10 @@ EXPORT_PER_CPU_SYMBOL(kstat);
 static inline void update_cpu_clock(task_t *p, runqueue_t *rq,
 				    unsigned long long now)
 {
-	unsigned long long last = max(p->timestamp, rq->timestamp_last_tick);
-	p->sched_time += now - last;
+	unsigned long long d1, d2;
+	d1 = sched_clock_diff(now, p->timestamp);
+	d2 = sched_clock_diff(now, rq->timestamp_last_tick);
+	p->sched_time += min(d1, d2);
 }
 
 /*
@@ -2522,11 +2524,13 @@ static inline void update_cpu_clock(task
  */
 unsigned long long current_sched_time(const task_t *tsk)
 {
-	unsigned long long ns;
+	unsigned long long now, d1, d2, ns;
 	unsigned long flags;
 	local_irq_save(flags);
-	ns = max(tsk->timestamp, task_rq(tsk)->timestamp_last_tick);
-	ns = tsk->sched_time + (sched_clock() - ns);
+	now = sched_clock();
+	d1 = sched_clock_diff(now, tsk->timestamp);
+	d2 = sched_clock_diff(now, task_rq(tsk)->timestamp_last_tick);
+	ns = tsk->sched_time + min(d1, d2);
 	local_irq_restore(flags);
 	return ns;
 }
@@ -2925,7 +2929,7 @@ asmlinkage void __sched schedule(void)
 	runqueue_t *rq;
 	prio_array_t *array;
 	struct list_head *queue;
-	unsigned long long now;
+	unsigned long long now, sleep;
 	unsigned long run_time;
 	int cpu, idx, new_prio;
 
@@ -2960,11 +2964,10 @@ need_resched_nonpreemptible:
 
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
-	if (likely((long long)(now - prev->timestamp) < NS_MAX_SLEEP_AVG)) {
-		run_time = now - prev->timestamp;
-		if (unlikely((long long)(now - prev->timestamp) < 0))
-			run_time = 0;
-	} else
+	sleep = sched_clock_diff(now, prev->timestamp);
+	if (likely(sleep < NS_MAX_SLEEP_AVG))
+		run_time = sleep;
+	else
 		run_time = NS_MAX_SLEEP_AVG;
 
 	/*
@@ -3039,8 +3042,8 @@ go_idle:
 	next = list_entry(queue->next, task_t, run_list);
 
 	if (!rt_task(next) && interactive_sleep(next->sleep_type)) {
-		unsigned long long delta = now - next->timestamp;
-		if (unlikely((long long)(now - next->timestamp) < 0))
+		unsigned long long delta = sched_clock_diff(now, next->timestamp);
+		if (unlikely((long long)delta < 0))
 			delta = 0;
 
 		if (next->sleep_type == SLEEP_INTERACTIVE)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
