Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTF3NWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 09:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTF3NWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 09:22:20 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:7401 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263705AbTF3NWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 09:22:16 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Date: Mon, 30 Jun 2003 23:38:14 +1000
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@digeo.com>
References: <200306301535.49732.kernel@kolivas.org> <5.2.0.9.2.20030630133424.00cfe800@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030630133424.00cfe800@pop.gmx.net>
MIME-Version: 1.0
Message-Id: <200306302337.51171.kernel@kolivas.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_G1DA/jIS2PR2M1e"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_G1DA/jIS2PR2M1e
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


>At 11:39 AM 6/30/2003 +0200, Marc-Christian Petersen wrote:
>>Please, can we invite Ingo to this thread? I think it is now _really_ the
>>time
>>to get this fixed up :)
>
>The giants all seem to be busy... are munchkins stackable? ;-)

Ok this munchkin has some more to contribute.

Here is the next patch which shows a large improvement. Gone is the 
unnecessary exponential function (sorry Pat it was fun), and now the patch 
will start calculating interactivity from the first time an application is 
activated.

This takes away the X jerkiness evident in the previous patches (yes I do 
believe you MCP). No granularity patch is needed either.

Please test the bejeesus out of this one; MCP your test case is the most 
valuable.

Con



--Boundary-00=_G1DA/jIS2PR2M1e
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-O1int-0306302317"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-O1int-0306302317"

--- linux-2.5.73/kernel/sched.c	2003-06-30 10:06:40.000000000 +1000
+++ linux-2.5.73-test/kernel/sched.c	2003-06-30 23:16:42.000000000 +1000
@@ -314,11 +314,23 @@ static inline void enqueue_task(struct t
 static int effective_prio(task_t *p)
 {
 	int bonus, prio;
+	long sleep_period;

 	if (rt_task(p))
 		return p->prio;

-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
+	sleep_period = jiffies - p->avg_start;
+
+	if (!sleep_period)
+		return p->static_prio;
+
+	if (sleep_period > MAX_SLEEP_AVG)
+		sleep_period = MAX_SLEEP_AVG;
+
+	if (p->sleep_avg > sleep_period)
+		sleep_period = p->sleep_avg;
+
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/sleep_period/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;

 	prio = p->static_prio - bonus;
@@ -348,9 +360,19 @@ static inline void activate_task(task_t
 {
 	long sleep_time = jiffies - p->last_run - 1;

-	if (sleep_time > 0) {
-		int sleep_avg;
+	if (p->avg_start == 0){
+			p->avg_start = jiffies;
+			p->sleep_avg = 0;
+			sleep_time = 0;
+	}

+	if (sleep_time >= 0) {
+
+		if (sleep_time > HZ){
+			p->avg_start = jiffies;
+			p->sleep_avg = 0;
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
+			if (p->sleep_avg > MAX_SLEEP_AVG * 12/10)
+				p->sleep_avg = MAX_SLEEP_AVG * 11/10;
+		}
+		if (unlikely(p->avg_start > jiffies)){
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
--- linux-2.5.73/kernel/fork.c	2003-06-30 10:06:40.000000000 +1000
+++ linux-2.5.73-test/kernel/fork.c	2003-06-30 23:06:26.000000000 +1000
@@ -863,6 +863,7 @@ struct task_struct *copy_process(unsigne
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
+	p->avg_start = 0;
 	p->security = NULL;

 	retval = -ENOMEM;
--- linux-2.5.73/include/linux/sched.h	2003-06-30 10:06:40.000000000 +1000
+++ linux-2.5.73-test/include/linux/sched.h	2003-06-30 13:23:46.000000000 +1000
@@ -336,6 +336,7 @@ struct task_struct {
 	prio_array_t *array;

 	unsigned long sleep_avg;
+	unsigned long avg_start;
 	unsigned long last_run;

 	unsigned long policy;

--Boundary-00=_G1DA/jIS2PR2M1e--

