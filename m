Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTGKOPx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTGKOPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:15:53 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:32684 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261808AbTGKONr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:13:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: smiler@lanil.mine.nu
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Sat, 12 Jul 2003 00:30:31 +1000
User-Agent: KMail/1.5.2
Cc: <linux-kernel@vger.kernel.org>, <phillips@arcor.de>
References: <200307112053.55880.kernel@kolivas.org> <1068.::ffff:217.208.49.177.1057927722.squirrel@lanil.mine.nu>
In-Reply-To: <1068.::ffff:217.208.49.177.1057927722.squirrel@lanil.mine.nu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HosD/wF0qZfMiXn"
Message-Id: <200307120030.31958.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_HosD/wF0qZfMiXn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 11 Jul 2003 22:48, Christian Axelsson wrote:
> Ok complies and boot fine
>
> BUT... after loading X up and gnome-theme-manager I start clicking around
> abit.. then gnome-theme-manager starts eating 99.9% CPU (prolly a bug in
> the program). Problem here is that the machine stops responding to input,
> at first I can move mouse around (but Im stuck in the current focused
> X-client) and later it all stalls... Cant even get in via SSH.
> Ive put on a top before repeating this showing gnome-theme-manager eating
> all CPU-time (PRI 15/NICE 0) and load showing ~55% user ~45% system.
>
> Anything I can do to help debugging?

Can you try this patch instead which should stop the machine from getting into 
a deadlock? I dont think I have found the problem but at least it should be 
easier to diagnose without the machine locking up.

Con

--Boundary-00=_HosD/wF0qZfMiXn
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-SI-0307120014"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-SI-0307120014"

diff -Naurp linux-2.5.75-mm1/include/linux/sched.h linux-2.5.75-test/include/linux/sched.h
--- linux-2.5.75-mm1/include/linux/sched.h	2003-07-12 00:03:51.000000000 +1000
+++ linux-2.5.75-test/include/linux/sched.h	2003-07-12 00:05:00.000000000 +1000
@@ -125,6 +125,7 @@ extern unsigned long nr_iowait(void);
 #define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+#define SCHED_ISO		3
 
 struct sched_param {
 	int sched_priority;
diff -Naurp linux-2.5.75-mm1/kernel/exit.c linux-2.5.75-test/kernel/exit.c
--- linux-2.5.75-mm1/kernel/exit.c	2003-07-12 00:01:38.000000000 +1000
+++ linux-2.5.75-test/kernel/exit.c	2003-07-12 00:05:00.000000000 +1000
@@ -223,7 +223,7 @@ void reparent_to_init(void)
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
 	current->exit_signal = SIGCHLD;
 
-	if ((current->policy == SCHED_NORMAL) && (task_nice(current) < 0))
+	if ((current->policy == SCHED_NORMAL || current->policy == SCHED_ISO) && (task_nice(current) < 0))
 		set_user_nice(current, 0);
 	/* cpus_allowed? */
 	/* rt_priority? */
diff -Naurp linux-2.5.75-mm1/kernel/sched.c linux-2.5.75-test/kernel/sched.c
--- linux-2.5.75-mm1/kernel/sched.c	2003-07-12 00:03:51.000000000 +1000
+++ linux-2.5.75-test/kernel/sched.c	2003-07-12 00:13:21.000000000 +1000
@@ -76,9 +76,9 @@
 #define MIN_SLEEP_AVG		(HZ)
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
-#define SLEEP_BUFFER		(HZ/20)
 #define NODE_THRESHOLD		125
 #define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO / 100)
+#define ISO_PENALTY		(5)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -118,6 +118,8 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
+#define iso_task(p)		((p)->policy == SCHED_ISO)
+
 /*
  * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
  * to time slice values.
@@ -134,7 +136,16 @@
 
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
@@ -319,6 +330,10 @@ static inline void normalise_sleep(task_
 
 	p->sleep_avg = p->sleep_avg * MIN_SLEEP_AVG / old_avg_time;
 	p->avg_start = jiffies - MIN_SLEEP_AVG;
+
+	if (iso_task(p))
+		p->policy = SCHED_NORMAL;
+
 }
 
 /*
@@ -343,26 +358,32 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
-	sleep_period = jiffies - p->avg_start;
+	if (!iso_task(p)){
+		sleep_period = jiffies - p->avg_start;
 
-	if (unlikely(!sleep_period))
-		return p->static_prio;
+		if (unlikely(!sleep_period))
+			return p->static_prio;
 
-	if (sleep_period > MAX_SLEEP_AVG)
-		sleep_period = MAX_SLEEP_AVG;
+		if (sleep_period > MAX_SLEEP_AVG)
+			sleep_period = MAX_SLEEP_AVG;
 
-	if (p->sleep_avg > sleep_period)
-		sleep_period = p->sleep_avg;
+		if (p->sleep_avg > sleep_period)
+			sleep_period = p->sleep_avg;
 
-	/*
-	 * The bonus is determined according to the accumulated
-	 * sleep avg over the duration the task has been running
-	 * until it reaches MAX_SLEEP_AVG. -ck
-	 */
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
-			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+		/*
+		 * The bonus is determined according to the accumulated
+		 * sleep avg over the duration the task has been running
+		 * until it reaches MAX_SLEEP_AVG. -ck
+		 */
+		bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
+				MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
+
+	} else
+		bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO/100 -
+				MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;
 
 	prio = p->static_prio - bonus;
+
 	if (prio < MAX_RT_PRIO)
 		prio = MAX_RT_PRIO;
 	if (prio > MAX_PRIO-1)
@@ -401,6 +422,8 @@ static inline void activate_task(task_t 
 			p->avg_start = jiffies - MIN_SLEEP_AVG;
 			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 1) /
 				MAX_BONUS;
+			if (iso_task(p))
+				p->policy = SCHED_NORMAL;
 		} else {
 			/*
 			 * This code gives a bonus to interactive tasks.
@@ -422,13 +445,14 @@ static inline void activate_task(task_t 
 					(MAX_SLEEP_AVG + MIN_SLEEP_AVG - runtime) *
 					(MAX_BONUS - INTERACTIVE_DELTA) / MAX_BONUS / MAX_SLEEP_AVG;
 
-			/*
-			 * Keep a small buffer of SLEEP_BUFFER sleep_avg to
-			 * prevent fully interactive tasks from becoming
-			 * lower priority with small bursts of cpu usage.
-			 */
-			if (p->sleep_avg > (MAX_SLEEP_AVG + SLEEP_BUFFER))
-				p->sleep_avg = MAX_SLEEP_AVG + SLEEP_BUFFER;
+			if (p->sleep_avg > MAX_SLEEP_AVG){
+				if (p->policy == SCHED_NORMAL)
+					p->policy = SCHED_ISO;
+				p->sleep_avg = MAX_SLEEP_AVG;
+			}
+
+			if (unlikely(!p->sleep_avg && iso_task(p)))
+				p->policy = SCHED_NORMAL;
 		}
 
 		if (unlikely(p->avg_start > jiffies)){
@@ -1819,7 +1843,7 @@ static int setscheduler(pid_t pid, int p
 	else {
 		retval = -EINVAL;
 		if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_NORMAL)
+				policy != SCHED_NORMAL && policy != SCHED_ISO)
 			goto out_unlock;
 	}
 
@@ -1830,7 +1854,7 @@ static int setscheduler(pid_t pid, int p
 	retval = -EINVAL;
 	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
-	if ((policy == SCHED_NORMAL) != (lp.sched_priority == 0))
+	if ((policy == SCHED_NORMAL || policy == SCHED_ISO) != (lp.sched_priority == 0))
 		goto out_unlock;
 
 	retval = -EPERM;
@@ -1852,7 +1876,7 @@ static int setscheduler(pid_t pid, int p
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
 	oldprio = p->prio;
-	if (policy != SCHED_NORMAL)
+	if (policy == SCHED_FIFO || policy == SCHED_RR)
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
@@ -2153,6 +2177,9 @@ asmlinkage long sys_sched_get_priority_m
 	case SCHED_NORMAL:
 		ret = 0;
 		break;
+	case SCHED_ISO:
+		ret = 0;
+		break;
 	}
 	return ret;
 }
@@ -2175,6 +2202,8 @@ asmlinkage long sys_sched_get_priority_m
 		break;
 	case SCHED_NORMAL:
 		ret = 0;
+	case SCHED_ISO:
+		ret = 0;
 	}
 	return ret;
 }

--Boundary-00=_HosD/wF0qZfMiXn--

