Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270520AbTGNDtM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270522AbTGNDtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:49:12 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:33997 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S270520AbTGNDsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:48:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Guillaume Chazarain <gfc@altern.org>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Mon, 14 Jul 2003 14:05:35 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, phillips@arcor.de, smiler@lanil.mine.nu
References: <ZTEANKTPFA5YUR93JFQE096KF85YA8.3f1172b0@monpc>
In-Reply-To: <ZTEANKTPFA5YUR93JFQE096KF85YA8.3f1172b0@monpc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307141405.35573.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 00:54, Guillaume Chazarain wrote:
> 13/07/03 14:53:12, Con Kolivas <kernel@kolivas.org> wrote:
> >On Sun, 13 Jul 2003 20:41, Guillaume Chazarain wrote:
> Good, with ISO_PENALTY == 2, I can smoothly move big windows (with
> ISO_PENALTY == 5 it was smooth only with very small windows), but it lets
> me move them smoothly during less time than stock :(

I think I know what you mean now. Expiring X hurts. With a penalty of only 2
it should be unecessary to expire iso tasks. Addressed below.

> >The logical conclusion of this idea where there is a dynamic policy
> > assigned to interactive tasks is a dynamic policy assigned to non
> > interactive tasks that get treated in the opposite way. I'll code
> > something for that soon, now that I've had more feedback on the first
> > part.
>
> Interesting, let's see :)
> But as the interactive bonus can already be negative I wonder what use
> will have another variable.

The added feature of expiring them every time they use up their timeslice
should help.

An updated patch-SI-0307141335 against 2.5.75-mm1 incorporating these
changes and more tweaks is here:
http://kernel.kolivas.org/2.5/

and here:
patch-SI-0307141335
--------------------------------
diff -Naurp linux-2.5.75-mm1/include/linux/sched.h linux-2.5.75-test/include/linux/sched.h
--- linux-2.5.75-mm1/include/linux/sched.h	2003-07-13 00:21:30.000000000 +1000
+++ linux-2.5.75-test/include/linux/sched.h	2003-07-14 13:50:01.000000000 +1000
@@ -125,6 +125,8 @@ extern unsigned long nr_iowait(void);
 #define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+#define SCHED_BATCH		3
+#define SCHED_ISO		4
 
 struct sched_param {
 	int sched_priority;
diff -Naurp linux-2.5.75-mm1/kernel/exit.c linux-2.5.75-test/kernel/exit.c
--- linux-2.5.75-mm1/kernel/exit.c	2003-07-13 00:21:30.000000000 +1000
+++ linux-2.5.75-test/kernel/exit.c	2003-07-14 13:33:42.000000000 +1000
@@ -223,7 +223,7 @@ void reparent_to_init(void)
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
 	current->exit_signal = SIGCHLD;
 
-	if ((current->policy == SCHED_NORMAL) && (task_nice(current) < 0))
+	if ((current->policy == SCHED_NORMAL || current->policy == SCHED_ISO || current->policy == SCHED_BATCH) && (task_nice(current) < 0))
 		set_user_nice(current, 0);
 	/* cpus_allowed? */
 	/* rt_priority? */
diff -Naurp linux-2.5.75-mm1/kernel/sched.c linux-2.5.75-test/kernel/sched.c
--- linux-2.5.75-mm1/kernel/sched.c	2003-07-13 00:21:30.000000000 +1000
+++ linux-2.5.75-test/kernel/sched.c	2003-07-14 13:41:55.000000000 +1000
@@ -74,12 +74,12 @@
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
 #define MIN_SLEEP_AVG		(HZ)
-#define MAX_SLEEP_AVG		(10*HZ)
-#define STARVATION_LIMIT	(10*HZ)
-#define SLEEP_BUFFER		(HZ/20)
+#define MAX_SLEEP_AVG		(5*HZ)
+#define STARVATION_LIMIT	(5*HZ)
+#define ISO_PENALTY		(2)
 #define NODE_THRESHOLD		125
 #define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO / 100)
-
+#define JUST_INTERACTIVE	(MAX_BONUS - INTERACTIVE_DELTA) / MAX_BONUS
 /*
  * If a task is 'interactive' then we reinsert it in the active
  * array after it has expired its current timeslice. (it will not
@@ -118,6 +118,10 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
+#define normal_task(p)		((p)->policy == SCHED_NORMAL)
+#define iso_task(p)		((p)->policy == SCHED_ISO)
+#define batch_task(p)		((p)->policy == SCHED_BATCH)
+
 /*
  * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
  * to time slice values.
@@ -134,7 +138,16 @@
 
 static inline unsigned int task_timeslice(task_t *p)
 {
-	return BASE_TIMESLICE(p);
+	if (!iso_task(p))
+		return (BASE_TIMESLICE(p));
+	else {
+		int timeslice = BASE_TIMESLICE(p) / ISO_PENALTY;
+
+		if (timeslice < MIN_TIMESLICE)
+			timeslice = MIN_TIMESLICE;
+
+		return timeslice;
+	}
 }
 
 /*
@@ -319,6 +332,14 @@ static inline void normalise_sleep(task_
 
 	p->sleep_avg = p->sleep_avg * MIN_SLEEP_AVG / old_avg_time;
 	p->avg_start = jiffies - MIN_SLEEP_AVG;
+
+	/*
+	 * New children and their parents are not allowed to
+	 * be SCHED_ISO or SCHED_BATCH.
+	 */
+	if (iso_task(p) || batch_task(p))
+		p->policy = SCHED_NORMAL;
+
 }
 
 /*
@@ -343,26 +364,38 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
-	sleep_period = jiffies - p->avg_start;
+	/*
+	 * SCHED_BATCH tasks end up getting the maximum penalty
+	 */
+	bonus = - MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
-	if (unlikely(!sleep_period))
-		return p->static_prio;
+	if (normal_task(p)){
+		sleep_period = jiffies - p->avg_start;
 
-	if (sleep_period > MAX_SLEEP_AVG)
-		sleep_period = MAX_SLEEP_AVG;
+		if (unlikely(!sleep_period))
+			return p->static_prio;
 
-	if (p->sleep_avg > sleep_period)
-		sleep_period = p->sleep_avg;
+		if (sleep_period > MAX_SLEEP_AVG)
+			sleep_period = MAX_SLEEP_AVG;
 
-	/*
-	 * The bonus is determined according to the accumulated
-	 * sleep avg over the duration the task has been running
-	 * until it reaches MAX_SLEEP_AVG. -ck
-	 */
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
-			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+		if (p->sleep_avg > sleep_period)
+			sleep_period = p->sleep_avg;
+
+		/*
+		 * The bonus is determined according to the accumulated
+		 * sleep avg over the duration the task has been running
+		 * until it reaches MAX_SLEEP_AVG. -ck
+		 */
+		bonus += MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100;
+
+	} else if (iso_task(p))
+		/*
+		 * SCHED_ISO tasks get the maximum possible bonus
+		 */
+		bonus += MAX_USER_PRIO*PRIO_BONUS_RATIO/100;
 
 	prio = p->static_prio - bonus;
+
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
@@ -398,6 +431,11 @@ static inline void activate_task(task_t 
 		 * to allow them to become interactive or non-interactive rapidly
 		 */
 		if (sleep_time > MIN_SLEEP_AVG){
+			/*
+			 * Idle tasks can not be SCHED_ISO or SCHED_BATCH
+			 */
+			if (iso_task(p) || batch_task(p))
+				p->policy = SCHED_NORMAL;
 			p->avg_start = jiffies - MIN_SLEEP_AVG;
 			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 1) /
 				MAX_BONUS;
@@ -417,25 +455,45 @@ static inline void activate_task(task_t 
 			 * the problem of the denominator in the bonus equation
 			 * from continually getting larger.
 			 */
-			if ((runtime - MIN_SLEEP_AVG) < MAX_SLEEP_AVG)
-				p->sleep_avg += (runtime - p->sleep_avg) *
-					(MAX_SLEEP_AVG + MIN_SLEEP_AVG - runtime) *
-					(MAX_BONUS - INTERACTIVE_DELTA) / MAX_BONUS / MAX_SLEEP_AVG;
+
+			if ((runtime - MIN_SLEEP_AVG < MAX_SLEEP_AVG) && (runtime * JUST_INTERACTIVE > p->sleep_avg))
+				p->sleep_avg += (runtime * JUST_INTERACTIVE - p->sleep_avg) *
+					(MAX_SLEEP_AVG + MIN_SLEEP_AVG - runtime) / MAX_SLEEP_AVG;
+
+			if (p->sleep_avg > MAX_SLEEP_AVG){
+				/*
+				 * Tasks that have slept more than MAX_SLEEP_AVG
+				 * become SCHED_ISO tasks.
+				 */
+				if (normal_task(p))
+					p->policy = SCHED_ISO;
+				else if (unlikely(batch_task(p)))
+					p->policy = SCHED_NORMAL;
+
+				p->sleep_avg = MAX_SLEEP_AVG;
+			}
 
 			/*
-			 * Keep a small buffer of SLEEP_BUFFER sleep_avg to
-			 * prevent fully interactive tasks from becoming
-			 * lower priority with small bursts of cpu usage.
+			 * Just in case a SCHED_ISO task has become a complete
+			 * cpu hog revert it to SCHED_NORMAL
 			 */
-			if (p->sleep_avg > (MAX_SLEEP_AVG + SLEEP_BUFFER))
-				p->sleep_avg = MAX_SLEEP_AVG + SLEEP_BUFFER;
+			if (unlikely(!p->sleep_avg && iso_task(p))){
+				p->policy = SCHED_NORMAL;
+				p->avg_start = jiffies;
+			}
 		}
 
 		if (unlikely(p->avg_start > jiffies)){
 			p->avg_start = jiffies;
 			p->sleep_avg = 0;
 		}
-	}
+	/*
+	 * SCHED_NORMAL tasks that have used up all their sleep avg
+	 * get demoted to SCHED_BATCH
+	 */
+	} else if (!p->sleep_avg && normal_task(p))
+			p->policy = SCHED_BATCH;
+
 	p->prio = effective_prio(p);
 	__activate_task(p, rq);
 }
@@ -1309,13 +1367,20 @@ void scheduler_tick(int user_ticks, int 
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+		/*
+		 * SCHED_BATCH tasks always get expired if they use up their
+		 * timeslice.
+		 * If SCHED_ISO tasks are using too much cpu time they
+		 * enter the expired array.
+		 */
+		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq) || batch_task(p)) {
 			if (!rq->expired_timestamp)
 				rq->expired_timestamp = jiffies;
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
 	}
+
 out_unlock:
 	spin_unlock(&rq->lock);
 out:
@@ -1818,8 +1883,8 @@ static int setscheduler(pid_t pid, int p
 		policy = p->policy;
 	else {
 		retval = -EINVAL;
-		if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_NORMAL)
+		if (policy != SCHED_FIFO && policy != SCHED_RR && policy != SCHED_BATCH &&
+				policy != SCHED_NORMAL && policy != SCHED_ISO)
 			goto out_unlock;
 	}
 
@@ -1830,7 +1895,7 @@ static int setscheduler(pid_t pid, int p
 	retval = -EINVAL;
 	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
-	if ((policy == SCHED_NORMAL) != (lp.sched_priority == 0))
+	if ((policy == SCHED_NORMAL || policy == SCHED_ISO || policy == SCHED_BATCH) != (lp.sched_priority == 0))
 		goto out_unlock;
 
 	retval = -EPERM;
@@ -1852,7 +1917,7 @@ static int setscheduler(pid_t pid, int p
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
 	oldprio = p->prio;
-	if (policy != SCHED_NORMAL)
+	if (policy == SCHED_FIFO || policy == SCHED_RR)
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
@@ -2151,6 +2216,8 @@ asmlinkage long sys_sched_get_priority_m
 		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_ISO:
+	case SCHED_BATCH:
 		ret = 0;
 		break;
 	}
@@ -2174,6 +2241,8 @@ asmlinkage long sys_sched_get_priority_m
 		ret = 1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_ISO:
+	case SCHED_BATCH:
 		ret = 0;
 	}
 	return ret;



