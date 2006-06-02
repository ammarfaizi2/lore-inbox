Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWFBJhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWFBJhA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 05:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWFBJhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 05:37:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:19470 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751364AbWFBJg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 05:36:59 -0400
X-IronPort-AV: i="4.05,203,1146466800"; 
   d="scan'208"; a="45910025:sNHT20758850"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "Con Kolivas" <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>
Subject: RE: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 02:36:54 -0700
Message-ID: <000201c68628$16f64550$0c4ce984@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaGInBptJF7xR+mTtS/Qg4G8lEwOAABArSg
In-Reply-To: <447FFD35.9020909@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Friday, June 02, 2006 1:56 AM
> Chen, Kenneth W wrote:
> 
> > Ha, you beat me by one minute. It did cross my mind to use try lock there as
> > well, take a look at my version, I think I have a better inner loop.
> 
> Actually you *have* to use trylocks I think, because the current runqueue
> is already locked.
> 
> And why do we lock all siblings in the other case, for that matter? (not
> that it makes much difference except on niagara today).
> 
> Rolled up patch with everyone's changes attached.


OK, it's down to nit-picking now:

Remove this_rq argument from wake_sleeping_dependent() since it is not
used.  Nick, you had that in your earlier version, but it got lost in
the woods.

I don't like cpumask being declared on the stack.  Here is my version
to rid it out in wake_sleeping_dependent() and dependent_sleeper().

- Ken


--- ./kernel/sched.c.orig	2006-06-02 03:20:40.000000000 -0700
+++ ./kernel/sched.c	2006-06-02 03:20:59.000000000 -0700
@@ -2714,10 +2714,9 @@ static inline void wakeup_busy_runqueue(
 /*
  * Called with interrupts disabled and this_rq's runqueue locked.
  */
-static void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
+static void wake_sleeping_dependent(int this_cpu)
 {
 	struct sched_domain *tmp, *sd = NULL;
-	cpumask_t sibling_map;
 	int i;
 
 	for_each_domain(this_cpu, tmp)
@@ -2728,10 +2727,11 @@ static void wake_sleeping_dependent(int 
 	if (!sd)
 		return;
 
-	sibling_map = sd->span;
-	cpu_clear(this_cpu, sibling_map);
-	for_each_cpu_mask(i, sibling_map) {
+	for_each_cpu_mask(i, sd->span) {
 		runqueue_t *smt_rq = cpu_rq(i);
+
+		if (i == this_cpu)
+			continue;
 		if (unlikely(!spin_trylock(&smt_rq->lock)))
 			continue;
 
@@ -2761,7 +2761,6 @@ static int dependent_sleeper(int this_cp
 	struct task_struct *p)
 {
 	struct sched_domain *tmp, *sd = NULL;
-	cpumask_t sibling_map;
 	int ret = 0, i;
 
 	for_each_domain(this_cpu, tmp)
@@ -2772,12 +2771,13 @@ static int dependent_sleeper(int this_cp
 	if (!sd)
 		return 0;
 
-	sibling_map = sd->span;
-	cpu_clear(this_cpu, sibling_map);
-	for_each_cpu_mask(i, sibling_map) {
+	for_each_cpu_mask(i, sd->span) {
 		runqueue_t *smt_rq;
 		task_t *smt_curr;
 
+		if (i == this_cpu)
+			continue;
+
 		smt_rq = cpu_rq(i);
 		if (unlikely(!spin_trylock(&smt_rq->lock)))
 			continue;
@@ -2842,7 +2842,7 @@ check_smt_task:
 	return ret;
 }
 #else
-static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
+static inline void wake_sleeping_dependent(int this_cpu)
 {
 }
 
@@ -2973,7 +2973,7 @@ need_resched_nonpreemptible:
 		if (!rq->nr_running) {
 			next = rq->idle;
 			rq->expired_timestamp = 0;
-			wake_sleeping_dependent(cpu, rq);
+			wake_sleeping_dependent(cpu);
 			goto switch_tasks;
 		}
 	}
