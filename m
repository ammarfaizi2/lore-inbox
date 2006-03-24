Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWCXLCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWCXLCn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWCXLCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:02:43 -0500
Received: from mail.gmx.de ([213.165.64.20]:57058 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751497AbWCXLCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:02:42 -0500
X-Authenticated: #14349625
Subject: [2.6.16-mm1 patch] throttling tree patches
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Con Kolivas <kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 12:03:28 +0100
Message-Id: <1143198208.7741.8.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I've broken down my throttling tree into 6 patches, which I'll send as
replies to this start-point.

Patch 1/6

Ignore timewarps caused by SMP timestamp rounding.  Also, don't stamp a
task with a computed timestamp, stamp with the already called clock.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm1/kernel/sched.c.org	2006-03-23 15:01:41.000000000 +0100
+++ linux-2.6.16-mm1/kernel/sched.c	2006-03-23 15:02:25.000000000 +0100
@@ -805,6 +805,16 @@
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
+	/*
+	 * On SMP systems, a task can go to sleep on one CPU and
+	 * wake up on another.  When this happens, the timestamp
+	 * is rounded to the nearest tick, which can lead to now
+	 * being less than p->timestamp for short sleeps. Ignore
+	 * these, they're insignificant.
+	 */
+	if (unlikely(now < p->timestamp))
+		__sleep_time = 0ULL;
+
 	if (batch_task(p))
 		sleep_time = 0;
 	else {
@@ -871,20 +881,20 @@
  */
 static void activate_task(task_t *p, runqueue_t *rq, int local)
 {
-	unsigned long long now;
+	unsigned long long now, comp;
 
-	now = sched_clock();
+	now = comp = sched_clock();
 #ifdef CONFIG_SMP
 	if (!local) {
 		/* Compensate for drifting sched_clock */
 		runqueue_t *this_rq = this_rq();
-		now = (now - this_rq->timestamp_last_tick)
+		comp = (now - this_rq->timestamp_last_tick)
 			+ rq->timestamp_last_tick;
 	}
 #endif
 
 	if (!rt_task(p))
-		p->prio = recalc_task_prio(p, now);
+		p->prio = recalc_task_prio(p, comp);
 
 	/*
 	 * This checks to make sure it's not an uninterruptible task


