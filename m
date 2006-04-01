Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWDAI7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWDAI7I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 03:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWDAI7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 03:59:08 -0500
Received: from mail.gmx.de ([213.165.64.20]:11924 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751505AbWDAI7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 03:59:07 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-mm2 5/9] sched throttle tree extract - correct
	idle sleep logic
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143881494.7617.32.camel@homer>
References: <1143880124.7617.5.camel@homer> <1143880397.7617.10.camel@homer>
	 <1143880683.7617.16.camel@homer>  <1143881058.7617.24.camel@homer>
	 <1143881494.7617.32.camel@homer>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 10:59:43 +0200
Message-Id: <1143881983.7617.41.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the idle sleep logic to place a long sleeping task
into the runqueue at a barely interactive priority such that it can not
destroy interactivity should it immediately begin consuming massive cpu.

It further ensures that no task will cross the boundary from normal task
to interactive task without first stopping at the border before moving
on.  Note, that this in no way hinders a long sleeping task from waking
at max priority.  They stop on the way up, but are not truncated.  This
only prevents long sleeping tasks from slamming straight to max
interactive with one sleep, and causing trouble.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm2/kernel/sched.c-4.remove_kthread_barrier	2006-04-01 09:01:54.000000000 +0200
+++ linux-2.6.16-mm2/kernel/sched.c	2006-04-01 09:12:51.000000000 +0200
@@ -99,6 +99,9 @@
 #define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
 #define STARVATION_LIMIT	(MAX_SLEEP_AVG)
 #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
+#define NS_MAX_SLEEP_AVG_PCNT	(NS_MAX_SLEEP_AVG / 100)
+#define PCNT_PER_DYNPRIO	(100 / MAX_BONUS)
+#define NS_PER_DYNPRIO		(PCNT_PER_DYNPRIO * NS_MAX_SLEEP_AVG_PCNT)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -153,9 +156,23 @@
 #define TASK_INTERACTIVE(p) \
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
-#define INTERACTIVE_SLEEP(p) \
-	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
-		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
+#define INTERACTIVE_SLEEP_AVG(p) \
+	(min(JIFFIES_TO_NS(MAX_SLEEP_AVG * (MAX_BONUS / 2 + DELTA(p)) / \
+	MAX_BONUS), NS_MAX_SLEEP_AVG))
+
+/*
+ * Returns whether a task has been asleep long enough to be considered idle.
+ * The metric is whether this quantity of sleep would promote the task more
+ * than one priority beyond marginally interactive.
+ */
+static int task_interactive_idle(task_t *p, unsigned long sleep_time)
+{
+	unsigned long ceiling = (CURRENT_BONUS(p) + 2) * NS_PER_DYNPRIO;
+
+	if (p->sleep_avg + sleep_time < ceiling)
+		return 0;
+	return p->sleep_avg + sleep_time >= INTERACTIVE_SLEEP_AVG(p);
+}
 
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
@@ -871,13 +888,25 @@ static int recalc_task_prio(task_t *p, u
 		 * active yet prevent them suddenly becoming cpu hogs and
 		 * starving other processes.
 		 */
-		if (sleep_time > INTERACTIVE_SLEEP(p)) {
-				unsigned long ceiling;
+		if (task_interactive_idle(p, sleep_time)) {
+			unsigned long ceiling = INTERACTIVE_SLEEP_AVG(p);
+
+			/*
+			 * Promote previously interactive task.
+			 */
+			if (p->sleep_avg > ceiling) {
+				ceiling = p->sleep_avg / NS_PER_DYNPRIO;
+				if (ceiling < MAX_BONUS)
+					ceiling++;
+				ceiling *= NS_PER_DYNPRIO;
+			} else {
+				ceiling += p->slice_time_ns >> 2;
+				if (ceiling > NS_MAX_SLEEP_AVG)
+					ceiling = NS_MAX_SLEEP_AVG;
+			}
 
-				ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-					DEF_TIMESLICE);
-				if (p->sleep_avg < ceiling)
-					p->sleep_avg = ceiling;
+			if (p->sleep_avg < ceiling)
+				p->sleep_avg = ceiling;
 		} else {
 			/*
 			 * This code gives a bonus to interactive tasks.


