Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWDGJhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWDGJhp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 05:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWDGJhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 05:37:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:45776 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932399AbWDGJho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 05:37:44 -0400
X-Authenticated: #14349625
Subject: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Con Kolivas <kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 11:38:10 +0200
Message-Id: <1144402690.7857.31.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Problem:  Wake-up -> cpu latency increases with the number of runnable
tasks, ergo adding this latency to sleep_avg becomes increasingly potent
as nr_running increases.  This turns into a very nasty problem with as
few as 10 httpd tasks doing round robin scheduling.  The result is that
you can only login with difficulty, and interactivity is nonexistent.

Solution:  Restrict the amount of boost a task can receive from this
mechanism, and disable the mechanism entirely when load is high.  As
always, there is a price for increasing fairness.  In this case, the
price seems worth it.  It bought me a usable 2.6 apache server.


Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.17-rc1/kernel/sched.c.org	2006-04-07 08:52:47.000000000 +0200
+++ linux-2.6.17-rc1/kernel/sched.c	2006-04-07 08:57:34.000000000 +0200
@@ -3012,14 +3012,20 @@ go_idle:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
-	if (!rt_task(next) && interactive_sleep(next->sleep_type)) {
+	if (!rt_task(next) && interactive_sleep(next->sleep_type) &&
+			rq->nr_running < 1 + MAX_BONUS - CURRENT_BONUS(next)) {
 		unsigned long long delta = now - next->timestamp;
+		unsigned long max_delta;
 		if (unlikely((long long)(now - next->timestamp) < 0))
 			delta = 0;
 
 		if (next->sleep_type == SLEEP_INTERACTIVE)
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
+		max_delta = (1 + MAX_BONUS - CURRENT_BONUS(next)) * GRANULARITY;
+		max_delta = JIFFIES_TO_NS(max_delta);
+		if (delta > max_delta)
+			delta = max_delta;
 		array = next->array;
 		new_prio = recalc_task_prio(next, next->timestamp + delta);
 


