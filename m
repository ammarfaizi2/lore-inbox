Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTF1E7g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 00:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTF1E7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 00:59:35 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:54464 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264281AbTF1E7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 00:59:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: patch-O1int-0306281420 for 2.5.73 interactivity
Date: Sat, 28 Jun 2003 15:16:01 +1000
User-Agent: KMail/1.5.2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mike Galbraith <efault@gmx.de>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Martin Schlemmer <azarah@gentoo.org>,
       Roberto Orenstein <rstein@brturbo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RSS/+Jo5cJ1YFmv"
Message-Id: <200306281516.12975.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_RSS/+Jo5cJ1YFmv
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

=46or my sins I've included what I thought was necessary for this patch.=20

The interactivity for tasks is based on the sleep avg accumulated divided b=
y=20
the running time of the task. However since the accumulated time is not=20
linear with time it now works on the premise that running time is an=20
exponential function entirely. Pat Erley was the genius who implemented thi=
s=20
simple exponential function in surprisingly low overhead integer maths.

Also added was some jiffy wrap logic (as if anyone would still be running m=
y=20
patch in 50 days :P).

Long sleepers were reclassified as idle according to the new exponential=20
logic.

If you test, please note this works better at 1000Hz.

Attached also is my bastardised version of Ingo's timeslice granularity pat=
ch.=20
This round robins tasks on the active array every 10ms, which _might_ be=20
detrimental in throughput applications but has not been benchmarked. Howeve=
r=20
for desktops it does wonders to smoothing out the jerkiness of X and I high=
ly=20
recommend using this in combination with the O1int patch.

This is very close to all the logic I wanted to implement. It might need mo=
re=20
tuning... Note parent penalty, child penalty and exit weight (uppercase) no=
=20
longer do anything.

Please test and comment.

Con

P.S. In the words of Zwane - there is always a corner case. Corner case I=20
think I still need to tackle is the application that spins madly waiting fo=
r=20
it's child to start, and in the process it is the parent that is starving t=
he=20
child by being higher priority than it. This seems to be a coding style=20
anomaly brought out by the scheduler.
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/SSSF6dfvkL3i1gRArK1AJ93sHl+I8J0qaOesShdJLvU1YENPgCglJhv
mxFcs8sAun1QNw0gz2tLJ2Q=3D
=3DS5PH
=2D----END PGP SIGNATURE-----

--Boundary-00=_RSS/+Jo5cJ1YFmv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O1int-0306281420"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-O1int-0306281420"

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
+			if (p->sleep_avg > MAX_SLEEP_AVG)
+				p->sleep_avg = MAX_SLEEP_AVG;
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

--Boundary-00=_RSS/+Jo5cJ1YFmv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-granularity-0306271314"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-granularity-0306271314"

diff -Naurp linux-2.5.73/kernel/sched.c linux-2.5.73-test/kernel/sched.c
--- linux-2.5.73/kernel/sched.c	2003-06-26 01:30:42.000000000 +1000
+++ linux-2.5.73-test/kernel/sched.c	2003-06-27 23:14:31.000000000 +1000
@@ -1229,7 +1229,16 @@ void scheduler_tick(int user_ticks, int 
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
+	} else {
+		if (!(p->time_slice % MIN_TIMESLICE) &&
+			       		(p->array == rq->active)) {
+			dequeue_task(p, rq->active);
+			set_tsk_need_resched(p);
+			p->prio = effective_prio(p);
+			enqueue_task(p, rq->active);
+		}
 	}
+
 out_unlock:
 	spin_unlock(&rq->lock);
 out:

--Boundary-00=_RSS/+Jo5cJ1YFmv--

