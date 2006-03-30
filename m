Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWC3OWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWC3OWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWC3OWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:22:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:20418 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932224AbWC3OWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:22:20 -0500
X-Authenticated: #14349625
Subject: Re: [rfc][patch] improved interactive starvation patch against
	2.6.16
From: Mike Galbraith <efault@gmx.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <20060330115540.GA4914@w.ods.org>
References: <1143713997.9381.28.camel@homer>
	 <20060330115540.GA4914@w.ods.org>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 16:22:38 +0200
Message-Id: <1143728558.7840.11.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 13:55 +0200, Willy Tarreau wrote:
> On Thu, Mar 30, 2006 at 12:19:57PM +0200, Mike Galbraith wrote:

> > For the one or two folks on the planet testing my anti-starvation
> > patches, I've attached an incremental to my 2.6.16 test release.
> 
> Hmmm does not apply here :
> 
> willy@wtap:linux-2.6.16-sched25$ cat /data/src/tmp/sched_*|patch -Nsp1
> willy@wtap:linux-2.6.16-sched25$ patch -p1 < /data/src/tmp/patch-2.6.16-sched-2.txt 
> patching file kernel/sched.c
> Hunk #1 succeeded at 71 with fuzz 2 (offset -6 lines).
> Hunk #2 succeeded at 391 (offset 157 lines).
> Hunk #3 FAILED at 833.
> Hunk #4 FAILED at 2681.
> Hunk #5 succeeded at 2770 (offset 149 lines).
> Hunk #6 FAILED at 2806.
> Hunk #7 succeeded at 2866 (offset 162 lines).
> 3 out of 7 hunks FAILED -- saving rejects to file kernel/sched.c.rej
> 
> However, it applies to plain 2.6.16 with sched_[1-6] applied (but with fuzz).
> Parts of the patches are already applied by your previous patches (eg: chunk1).
> I suspect that you accidentely rediffed sched.c against an intermediate
> working tree instead.
> 
> For instance, this part is already provided by patch 4 :
> @@ -77,6 +77,21 @@
>  #define NS_TO_JIFFIES(TIME)    ((TIME) / (1000000000 / HZ))
>  #define JIFFIES_TO_NS(TIME)    ((TIME) * (1000000000 / HZ))
>  
> +#if (BITS_PER_LONG < 64)
> +#define JIFFIES_TO_NS64(TIME) \
>  .../...
> 
> And this part overlaps with a previous chunk in patch 7 :
> 
> -                       rq->expired_timestamp = jiffies;
> -               if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
> +                       rq->expired_timestamp = now;
> +               if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {

You applied the wrong patch.  The inlined one was against virgin 2.6.16,
for folks to comment on, and the attached was the incremental against
the 2.6.16 anti-starvation tree.

Ah, your mailer probably showed both as attached.  Anyway, here's the
incremental again inlined.

(note to self:  never include patches for two trees in same message)

	-Mike

--- linux-2.6.16/kernel/sched.c-7.interactive_starvation	2006-03-27 06:11:01.000000000 +0200
+++ linux-2.6.16/kernel/sched.c	2006-03-30 10:50:46.000000000 +0200
@@ -371,7 +371,7 @@
 	 */
 	unsigned long nr_uninterruptible;
 
-	unsigned long expired_timestamp;
+	unsigned long long expired_timestamp;
 	unsigned long long timestamp_last_tick;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
@@ -839,7 +839,7 @@
 	/*
 	 * It's time to switch arrays.
 	 */
-	if (jiffies - rq->expired_timestamp >= limit)
+	if (jiffies - NS64_TO_JIFFIES(rq->expired_timestamp) >= limit)
 		return 1;
 
 	/*
@@ -860,8 +860,12 @@
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	prio_array_t *array = rq->active;
-	if (unlikely(expired_starving(rq)))
+	if (unlikely(expired_starving(rq) && !rt_task(p) &&
+			p->last_ran > rq->expired_timestamp)) {
 		array = rq->expired;
+		if (p->prio < rq->best_expired_prio)
+			rq->best_expired_prio = p->prio;
+	}
 	enqueue_task(p, array);
 	rq->nr_running++;
 }
@@ -2880,12 +2884,12 @@
 		return;
 	}
 
+	spin_lock(&rq->lock);
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
 		set_tsk_need_resched(p);
-		goto out;
+		goto out_unlock;
 	}
-	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
 	 * time slice counter. Note: we do not update a thread's
@@ -2921,15 +2925,38 @@
 		p->prio = effective_prio(p);
 
 		if (!rq->expired_timestamp)
-			rq->expired_timestamp = jiffies;
+			rq->expired_timestamp = now;
 		if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {
 			enqueue_task(p, rq->expired);
-			if (p->static_prio < rq->best_expired_prio)
-				rq->best_expired_prio = p->static_prio;
+			if (p->prio < rq->best_expired_prio)
+				rq->best_expired_prio = p->prio;
 		} else
 			enqueue_task(p, rq->active);
 	} else {
 		/*
+		 * If tasks in the expired array are starving, increase the
+		 * speed of the array switch.  If we do not, tasks which are
+		 * awakened on the expired array may suffer severe latency
+		 * due to cpu hogs using their full slice.  We don't want to
+		 * switch too fast however, because it may well be these very
+		 * tasks which were causing starvation to begin with.
+		 */
+		if (expired_starving(rq)) {
+			int limit = MIN_TIMESLICE + CURRENT_BONUS(p);
+			int runtime = now - p->timestamp;
+
+			runtime = NS_TO_JIFFIES(runtime);
+			if (runtime >= limit && p->time_slice >= limit) {
+
+				dequeue_task(p, rq->active);
+				enqueue_task(p, rq->expired);
+				set_tsk_need_resched(p);
+				if (p->prio < rq->best_expired_prio)
+					rq->best_expired_prio = p->prio;
+			}
+		}
+
+		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
 		 * the CPU. We do this by splitting up the timeslice into
 		 * smaller pieces.
@@ -2945,10 +2972,9 @@
 		 * This only applies to tasks in the interactive
 		 * delta range with at least TIMESLICE_GRANULARITY to requeue.
 		 */
-		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
+		else if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
 			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
-			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
-			(p->array == rq->active)) {
+			(p->time_slice >= TIMESLICE_GRANULARITY(p))) {
 
 			requeue_task(p, rq->active);
 			set_tsk_need_resched(p);


