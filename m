Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270326AbTGMVnx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 17:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270412AbTGMVnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 17:43:53 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:34951 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270326AbTGMVnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 17:43:49 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 14:51:11 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] SCHED_SOFTRR starve-free linux scheduling policy ...
Message-ID: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This should (hopefully) avoid other tasks starvation exploits :

http://www.xmailserver.org/linux-patches/softrr.html

Making SCHED_TS_KSOFTRR a proc tunable might be an option.



- Davide




diff -Nru linux-2.5.74.vanilla/include/linux/sched.h linux-2.5.74.mod/include/linux/sched.h
--- linux-2.5.74.vanilla/include/linux/sched.h	Mon Jul  7 16:57:33 2003
+++ linux-2.5.74.mod/include/linux/sched.h	Sun Jul 13 14:33:10 2003
@@ -124,6 +124,8 @@
 #define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+#define SCHED_SOFTRR		3
+

 struct sched_param {
 	int sched_priority;
diff -Nru linux-2.5.74.vanilla/kernel/sched.c linux-2.5.74.mod/kernel/sched.c
--- linux-2.5.74.vanilla/kernel/sched.c	Mon Jul  7 16:57:33 2003
+++ linux-2.5.74.mod/kernel/sched.c	Sun Jul 13 14:45:42 2003
@@ -76,6 +76,7 @@
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
+#define SCHED_TS_KSOFTRR	4

 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -158,7 +159,7 @@
 struct runqueue {
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches, expired_timestamp,
-			nr_uninterruptible;
+		nr_uninterruptible, ts_timestamp;
 	task_t *curr, *idle;
 	struct mm_struct *prev_mm;
 	prio_array_t *active, *expired, arrays[2];
@@ -1175,6 +1176,7 @@
 void scheduler_tick(int user_ticks, int sys_ticks)
 {
 	int cpu = smp_processor_id();
+	unsigned int time_slice;
 	runqueue_t *rq = this_rq();
 	task_t *p = current;

@@ -1216,17 +1218,32 @@
 		p->sleep_avg--;
 	if (unlikely(rt_task(p))) {
 		/*
-		 * RR tasks need a special form of timeslice management.
+		 * RR and SOFTRR tasks need a special form of timeslice management.
 		 * FIFO tasks have no timeslices.
 		 */
-		if ((p->policy == SCHED_RR) && !--p->time_slice) {
-			p->time_slice = task_timeslice(p);
+		if ((p->policy == SCHED_RR || p->policy == SCHED_SOFTRR) &&
+		    !--p->time_slice) {
+			p->time_slice = time_slice = task_timeslice(p);
 			p->first_time_slice = 0;
 			set_tsk_need_resched(p);

-			/* put it at the end of the queue: */
+			/*
+			 * We rotate SCHED_RR like POSIX states. On the
+			 * contrary, SCHED_SOFTRR are real-time tasks without
+			 * attitude and we do not want them to starve other
+			 * tasks while we want them to be able to preempt
+			 * SCHED_NORMAL tasks. The rule is that SCHED_SOFTRR
+			 * will be expired if they require roughly more then
+			 * 1/SCHED_TS_KSOFTRR percent of CPU time.
+			 */
 			dequeue_task(p, rq->active);
-			enqueue_task(p, rq->active);
+			if (p->policy == SCHED_RR ||
+			    (jiffies - rq->ts_timestamp) > SCHED_TS_KSOFTRR * time_slice)
+				enqueue_task(p, rq->active);
+			else
+				enqueue_task(p, rq->expired);
+
+			rq->ts_timestamp = jiffies;
 		}
 		goto out_unlock;
 	}
@@ -1243,6 +1260,8 @@
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
+
+		rq->ts_timestamp = jiffies;
 	}
 out_unlock:
 	spin_unlock(&rq->lock);
@@ -1740,12 +1759,22 @@
 	else {
 		retval = -EINVAL;
 		if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_NORMAL)
+				policy != SCHED_NORMAL && policy != SCHED_SOFTRR)
 			goto out_unlock;
 	}

 	/*
-	 * Valid priorities for SCHED_FIFO and SCHED_RR are
+	 * If the caller requested a SCHED_RR policy without having the
+	 * necessary rights, we downgrade the policy to SCHED_SOFTRR. This
+	 * is currrently here to enable to test the new SOFTRR realtime
+	 * policy with existing programs that try to ask for SCHED_RR. Not
+	 * sure if this should remain as permanent feature.
+	 */
+	if (policy == SCHED_RR && !capable(CAP_SYS_NICE))
+		policy = SCHED_SOFTRR;
+
+	/*
+	 * Valid priorities for SCHED_FIFO, SCHED_RR and SCHED_SOFTRR are
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
 	 */
 	retval = -EINVAL;
@@ -2069,6 +2098,7 @@
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
+	case SCHED_SOFTRR:
 		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_NORMAL:
@@ -2092,6 +2122,7 @@
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
+	case SCHED_SOFTRR:
 		ret = 1;
 		break;
 	case SCHED_NORMAL:
