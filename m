Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbTF1QNp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTF1QNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 12:13:45 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:59082 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265276AbTF1QNl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 12:13:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Date: Sun, 29 Jun 2003 02:30:40 +1000
User-Agent: KMail/1.5.2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mike Galbraith <efault@gmx.de>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Martin Schlemmer <azarah@gentoo.org>,
       Roberto Orenstein <rstein@brturbo.com>
References: <200306281516.12975.kernel@kolivas.org>
In-Reply-To: <200306281516.12975.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wKc/+nWPW032OPm"
Message-Id: <200306290230.40059.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_wKc/+nWPW032OPm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 28 Jun 2003 15:16, Con Kolivas wrote:
> For my sins I've included what I thought was necessary for this patch.
>
> The interactivity for tasks is based on the sleep avg accumulated divided
> by the running time of the task. However since the accumulated time is not
> linear with time it now works on the premise that running time is an
> exponential function entirely. Pat Erley was the genius who implemented
> this simple exponential function in surprisingly low overhead integer
> maths.
>
> Also added was some jiffy wrap logic (as if anyone would still be running
> my patch in 50 days :P).
>
> Long sleepers were reclassified as idle according to the new exponential
> logic.
>
> If you test, please note this works better at 1000Hz.
>
> Attached also is my bastardised version of Ingo's timeslice granularity
> patch. This round robins tasks on the active array every 10ms, which
> _might_ be detrimental in throughput applications but has not been
> benchmarked. However for desktops it does wonders to smoothing out the
> jerkiness of X and I highly recommend using this in combination with the
> O1int patch.
>
> This is very close to all the logic I wanted to implement. It might need
> more tuning... Note parent penalty, child penalty and exit weight
> (uppercase) no longer do anything.
>
> Please test and comment.
>
> Con
>
> P.S. In the words of Zwane - there is always a corner case. Corner case I
> think I still need to tackle is the application that spins madly waiting
> for it's child to start, and in the process it is the parent that is
> starving the child by being higher priority than it. This seems to be a
> coding style anomaly brought out by the scheduler.

And just for good measure here is the latest with a slight addition that helps 
X smoothness over time. It gives the sleep_avg a little headroom so it 
doesn't drop from interactive as easily with bursts of cpu activity.

Con

--Boundary-00=_wKc/+nWPW032OPm
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-O1int-0306290223"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-O1int-0306290223"

diff -Naurp linux-2.5.73/include/linux/sched.h linux-2.5.73-test/include/linux/sched.h
--- linux-2.5.73/include/linux/sched.h	2003-06-26 01:30:42.000000000 +1000
+++ linux-2.5.73-test/include/linux/sched.h	2003-06-28 14:09:08.000000000 +1000
@@ -336,6 +336,7 @@ struct task_struct {
 	prio_array_t *array;
 
 	unsigned long sleep_avg;
+	unsigned long avg_start;
 	unsigned long last_run;
 
 	unsigned long policy;
diff -Naurp linux-2.5.73/kernel/fork.c linux-2.5.73-test/kernel/fork.c
--- linux-2.5.73/kernel/fork.c	2003-06-26 01:30:42.000000000 +1000
+++ linux-2.5.73-test/kernel/fork.c	2003-06-28 14:09:08.000000000 +1000
@@ -863,6 +863,7 @@ struct task_struct *copy_process(unsigne
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
+	p->avg_start = jiffies;
 	p->security = NULL;
 
 	retval = -ENOMEM;
diff -Naurp linux-2.5.73/kernel/sched.c linux-2.5.73-test/kernel/sched.c
--- linux-2.5.73/kernel/sched.c	2003-06-26 01:30:42.000000000 +1000
+++ linux-2.5.73-test/kernel/sched.c	2003-06-28 14:19:03.000000000 +1000
@@ -314,11 +314,29 @@ static inline void enqueue_task(struct t
 static int effective_prio(task_t *p)
 {
 	int bonus, prio;
+	long sleep_period, tau;
 
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
+	tau = MAX_SLEEP_AVG;
+
+	sleep_period = jiffies - p->avg_start;
+	if (sleep_period > MAX_SLEEP_AVG)
+		sleep_period = MAX_SLEEP_AVG;
+	else if (!sleep_period)
+		return p->static_prio;
+	else {
+		sleep_period = (sleep_period *
+			17 * sleep_period / ((17 * sleep_period / (5 * tau) + 2) * 5 * tau));
+		if (!sleep_period)
+			return p->static_prio;
+	}
+
+	if (p->sleep_avg > sleep_period)
+		sleep_period = p->sleep_avg;
+
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
@@ -349,8 +367,12 @@ static inline void activate_task(task_t 
 	long sleep_time = jiffies - p->last_run - 1;
 
 	if (sleep_time > 0) {
-		int sleep_avg;
 
+		if (sleep_time > HZ){
+			p->avg_start = jiffies - HZ;
+			p->sleep_avg = HZ / 13;
+		}
+		else {
 		/*
 		 * This code gives a bonus to interactive tasks.
 		 *
@@ -359,7 +381,7 @@ static inline void activate_task(task_t 
 		 * spends sleeping, the higher the average gets - and the
 		 * higher the priority boost gets as well.
 		 */
-		sleep_avg = p->sleep_avg + sleep_time;
+			p->sleep_avg += sleep_time;
 
 		/*
 		 * 'Overflow' bonus ticks go to the waker as well, so the
@@ -367,12 +389,14 @@ static inline void activate_task(task_t 
 		 * boosting tasks that are related to maximum-interactive
 		 * tasks.
 		 */
-		if (sleep_avg > MAX_SLEEP_AVG)
-			sleep_avg = MAX_SLEEP_AVG;
-		if (p->sleep_avg != sleep_avg) {
-			p->sleep_avg = sleep_avg;
-			p->prio = effective_prio(p);
+			if (p->sleep_avg > MAX_SLEEP_AVG * 12 / 10)
+				p->sleep_avg = MAX_SLEEP_AVG * 11 / 10;
+		}
+		if (unlikely((jiffies - MAX_SLEEP_AVG) < p->avg_start)){
+			p->avg_start = jiffies;
+			p->sleep_avg = 0;
 		}
+		p->prio = effective_prio(p);
 	}
 	__activate_task(p, rq);
 }
@@ -549,8 +573,6 @@ void wake_up_forked_process(task_t * p)
 	 * and children as well, to keep max-interactive tasks
 	 * from forking tasks that are max-interactive.
 	 */
-	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
 
@@ -586,13 +608,6 @@ void sched_exit(task_t * p)
 			p->parent->time_slice = MAX_TIMESLICE;
 	}
 	local_irq_restore(flags);
-	/*
-	 * If the child was a (relative-) CPU hog then decrease
-	 * the sleep_avg of the parent as well.
-	 */
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
-			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
 
 /**

--Boundary-00=_wKc/+nWPW032OPm--

