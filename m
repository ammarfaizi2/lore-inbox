Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUJEWq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUJEWq2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUJEWq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:46:28 -0400
Received: from gizmo05ps.bigpond.com ([144.140.71.40]:59271 "HELO
	gizmo05ps.bigpond.com") by vger.kernel.org with SMTP
	id S266250AbUJEWqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:46:02 -0400
Message-ID: <41632422.5000208@bigpond.net.au>
Date: Wed, 06 Oct 2004 08:45:54 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH, ZAPHOD] Fix load balancing problem due to timestamp
Content-Type: multipart/mixed;
 boundary="------------050507020806040400090701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050507020806040400090701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please find attached a patch (against 2.6.9-rc3-mm2) that fixes the load 
balancing problems caused by timestamp being larger than 
timestamp_last_tick.

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------050507020806040400090701
Content-Type: text/x-patch;
 name="loadbalance.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="loadbalance.patch"

--- linux-2.6.9-rc3-mm2/kernel/sched.c	2004-10-05 15:17:09.000000000 +1000
+++ linux-2.6.9-rc3-mm2-mod/kernel/sched.c	2004-10-06 08:30:26.538386290 +1000
@@ -327,7 +327,7 @@ static inline unsigned int task_timeslic
 	return time_slice_ticks;
 }
 
-#define task_hot(p, sd) ((p)->rq->timestamp_last_tick - (p)->timestamp < (sd)->cache_hot_time)
+#define task_hot(p, sd) ((long long)((p)->rq->timestamp_last_tick - (p)->timestamp) < (long long)(sd)->cache_hot_time)
 
 /*
  * These are the runqueue data structures:
@@ -1196,7 +1196,6 @@ static void activate_task(task_t *p)
 	unsigned long long now = adjusted_sched_clock(p);
 
 	recalc_task_prio(p, now);
-	p->timestamp = now;
 	p->time_slice = task_timeslice(p);
 	p->flags &= ~PF_UISLEEP;
 
@@ -1712,7 +1711,7 @@ void fastcall sched_fork(task_t *p)
 	 * Give the child a new timeslice
 	 */
 	p->time_slice = task_timeslice(p);
-	p->timestamp = sched_clock();
+	p->timestamp = 0;
 	/*
 	 * Initialize the scheduling statistics and bonus counters
 	 */
@@ -4750,10 +4749,7 @@ static void __migrate_task(struct task_s
 		deactivate_task(p);
 		delta_delay_stats(p, adjusted_sched_clock(p));
 		set_task_cpu(p, dest_cpu);
-		/*
-		 *  activate_task() will set the timestamp correctly so there's
-		 *  no need to adjust it here
-		 */
+		adjust_timestamp(p, rq_src);
 		activate_task(p);
 		preempt_curr_if_warranted(p);
 	} else {

--------------050507020806040400090701--
