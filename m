Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268957AbUJEIS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268957AbUJEIS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 04:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268959AbUJEIS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 04:18:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24010 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268957AbUJEISY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 04:18:24 -0400
Date: Tue, 5 Oct 2004 10:19:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: bug in sched.c:activate_task()
Message-ID: <20041005081923.GA11258@elte.hu>
References: <200410050216.i952Gb620657@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410050216.i952Gb620657@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> Update p->timestamp to "now" in activate_task() doesn't look right to
> me at all.  p->timestamp records last time it was running on a cpu. 
> activate_task shouldn't update that variable when it queues a task on
> the runqueue.

it is being used for multiple purposes: measuring on-CPU time, measuring
on-runqueue time (for interactivity) and measuring off-runqueue time
(for interactivity). It is also used to measure cache-hotness, by the 
balancing code.

now, this particular update of p->timestamp:

> @@ -888,7 +888,6 @@ static void activate_task(task_t *p, run

> -	p->timestamp = now;

is important for the interactivity code that runs in schedule() - it
wants to know how much time we spent on the runqueue without having run.

but you are right that the task_hot() use of p->timestamp is incorrect
for freshly woken up tasks - we want the balancer to be able to re-route
tasks to another CPU, as long as the task has not hit the runqueue yet
(which it hasnt where we consider it in the balancer).

the clean solution is to separate the multiple uses of p->timestamp:
with the patch below p->timestamp is purely used for the interactivity
code, and p->last_ran is for the rebalancer. The patch is ontop of your
task_hot() fix-patch. Does this work for your workload?

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -185,7 +185,8 @@ static unsigned int task_timeslice(task_
 	else
 		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
 }
-#define task_hot(p, now, sd) ((now) - (p)->timestamp < (sd)->cache_hot_time)
+#define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
+				< (long long) (sd)->cache_hot_time)
 
 /*
  * These are the runqueue data structures:
@@ -2833,7 +2834,7 @@ switch_tasks:
 		if (!(HIGH_CREDIT(prev) || LOW_CREDIT(prev)))
 			prev->interactive_credit--;
 	}
-	prev->timestamp = now;
+	prev->timestamp = prev->last_ran = now;
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -527,7 +527,7 @@ struct task_struct {
 
 	unsigned long sleep_avg;
 	long interactive_credit;
-	unsigned long long timestamp;
+	unsigned long long timestamp, last_ran;
 	int activated;
 
 	unsigned long policy;
