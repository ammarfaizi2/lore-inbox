Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265709AbTIFJqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 05:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265715AbTIFJqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 05:46:42 -0400
Received: from law12-f124.law12.hotmail.com ([64.4.19.124]:13062 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265709AbTIFJqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 05:46:38 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "John Yau" <jyau_kernel_dev@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Sat, 06 Sep 2003 05:46:37 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law12-F124jgZ3Vxq7b00024eb1@hotmail.com>
X-OriginalArrivalTime: 06 Sep 2003 09:46:38.0070 (UTC) FILETIME=[C44C8160:01C3745B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm new to patch submission process, so bear with me.  This little patch I 
wrote seems to get rid of the annoying skipping in xmms except in the most 
extreme cases.  See comments inlined in code for details of the fix.

xmms still completely hangs every once in a while for me.  However I suspect 
it's due to a bug in xmms that deadlocks.  Anyone else experiencing hangs 
with xmms while tuning into Shoutcast???

Try out this patch and let me know if it fixes things for you.  Other than 
the hangs, xmms is behaving normally now for me.  Please CC me in all 
replies to this thread.


John Yau

--- linux-2.6.0-0.test4.1.32/kernel/sched.c	2003-08-22 19:58:43.000000000 
-0400
+++ linux-2.6.0-custom/kernel/sched.c	2003-09-06 04:20:09.000000000 -0400
@@ -1,4 +1,4 @@
-/*
+ /*
  *  kernel/sched.c
  *
  *  Kernel scheduler and related syscalls
@@ -14,6 +14,9 @@
  *		an array-switch method of distributing timeslices
  *		and per-CPU runqueues.  Cleanups and useful suggestions
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
+ *  2003-9-6    Changed recalculation of effective priority from being
+ *              calculated at exhaustion of time slices or sleep to
+ *              every use of 20 ms on the CPU by John Yau (jyau)
  */

#include <linux/mm.h>
@@ -1183,7 +1186,11 @@
		(STARVATION_LIMIT && ((rq)->expired_timestamp && \
		(jiffies - (rq)->expired_timestamp >= \
			STARVATION_LIMIT * ((rq)->nr_running) + 1)))
-
+/* jyau:
+ * Recalculate priorities every 20 ms that a task has
+ * used up in its time slice
+ */
+#define RECALCULATE_PRIORITY_TICK (HZ/50 ?: 1)
/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -1237,6 +1244,26 @@
	 * goes to sleep or uses up its timeslice. This makes
	 * it possible for interactive tasks to use up their
	 * timeslices at their highest priority levels.
+	 *
+	 * jyau:
+	 *   Updating priority later is a bad idea.  Tasks like
+	 *   xmms will occasionally not get rescheduled quickly enough
+	 *   because they are penalized for using CPU quite a bit
+	 *   more heavily than occassional clicks in e.g. Mozilla,
+	 *   which should be considered a CPU hog when rendering
+	 *   webpages after a click because it will tend to completely
+	 *   use up its time slice.
+	 *
+	 *   I suspect xmms gets booted out of interactive status
+	 *   quite easily and thus have to wait on the order of
+	 *   1000+ ms to get rescheduled in some circumstances,
+	 *   especially if a couple interactive tasks are in line
+	 *   before it.
+	 *
+	 *   We fix this by updating priorities periodically every
+	 *   RECALCULATE_PRIORITY_TICKs that the process has
+	 *   been on the CPU. RECALCULATE_PRIORITY_TICKs is currently
+	 *   set to 20 ms.
	 */
	if (p->sleep_avg)
		p->sleep_avg--;
@@ -1258,11 +1285,12 @@
	}
	if (!--p->time_slice) {
		dequeue_task(p, rq->active);
+
		set_tsk_need_resched(p);
		p->prio = effective_prio(p);
		p->time_slice = task_timeslice(p);
		p->first_time_slice = 0;
-
+
		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
			if (!rq->expired_timestamp)
				rq->expired_timestamp = jiffies;
@@ -1270,6 +1298,26 @@
		} else
			enqueue_task(p, rq->active);
	}
+	else if (!(p->time_slice % RECALCULATE_PRIORITY_TICK)) {
+	        int prio;
+                prio = effective_prio(p);
+		if (p->prio != prio)
+		  {
+		    /* jyau:
+		     * The priority changed, alter the queue
+		     * to reflect the change and ask the
+		     * scheduler to find the next appropriate
+		     * process if the priority was demoted.
+		     */
+		    dequeue_task(p, rq->active);
+		    if (prio > p->prio)
+		      {
+			set_tsk_need_resched(p);
+		      }
+		    p->prio = prio;
+		    enqueue_task(p, rq->active);
+		  }
+        }
out_unlock:
	spin_unlock(&rq->lock);
out:

_________________________________________________________________
Try MSN Messenger 6.0 with integrated webcam functionality! 
http://www.msnmessenger-download.com/tracking/reach_webcam

