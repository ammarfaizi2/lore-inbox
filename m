Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWDXTDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWDXTDT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWDXTDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:03:19 -0400
Received: from mga06.intel.com ([134.134.136.21]:11688 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751129AbWDXTDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:03:16 -0400
X-IronPort-AV: i="4.04,152,1144047600"; 
   d="scan'208"; a="27081913:sNHT69389712"
X-IronPort-AV: i="4.04,152,1144047600"; 
   d="scan'208"; a="27081903:sNHT361949539"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,152,1144047600"; 
   d="scan'208"; a="27130514:sNHT63773234"
Date: Mon, 24 Apr 2006 12:00:14 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] sched: Avoid unnecessarily moving highest priority task move_tasks()
Message-ID: <20060424120014.A16716@unix-os.sc.intel.com>
References: <44485E21.6070801@bigpond.net.au> <20060421173416.C17932@unix-os.sc.intel.com> <44498771.1030409@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <44498771.1030409@bigpond.net.au>; from pwil3058@bigpond.net.au on Sat, Apr 22, 2006 at 11:31:29AM +1000
X-OriginalArrivalTime: 24 Apr 2006 19:03:14.0844 (UTC) FILETIME=[BD4D8DC0:01C667D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 11:31:29AM +1000, Peter Williams wrote:
> If there are more than one task with the highest priority then it is 
> desirable to move one of them by overriding the skip mechanism as it can 
> be considered the second highest priority task.  

I think your patch is not doing what you intend to do.

> This initialization 
> just checks to see if the currently running task is one of the highest 
> priority tasks.  If it is then it's OK to move the first task we find 
> that also has the same priority otherwise we wait until we've skipped 
> one before we move one.

If this currently running task is of the highest priority, we set
busiest_best_prio_seen to '1' and looking at the code, because of this
we never consider any other busiest task which we come across on the expired
list.. This is coming from this piece of code.

	skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;

skip_for_load is always set to '1'(because of busiest_best_prio_seen)
and we will never be able to move any busiest task to the new queue.

> > This patch doesn't address the issue where we can skip the highest priority 
> > task movement if there is only one such task on the busy runqueue
> > (and is on the expired list..)
> 
> I think that it does.

No. It doesn't. In this case busiest_best_prio_seen will be set to '0', when
we traverse the only highest priority task on this queue(which happens to
be on expired list), we set skip_for_load to '0' And we will try
pulling the only highest priority task on this queue to the new queue..

Appended patch(ontop of 
sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch)
fixes these issues.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.17-rc1/kernel/sched.c~	2006-04-21 13:12:01.749853640 -0700
+++ linux-2.6.17-rc1/kernel/sched.c	2006-04-24 10:07:39.624162896 -0700
@@ -2045,7 +2045,7 @@ static int move_tasks(runqueue_t *this_r
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled = 0, pinned = 0, this_best_prio, busiest_best_prio;
-	int busiest_best_prio_seen;
+	int busiest_best_prio_seen = 0;
 	int skip_for_load; /* skip the task based on weighted load issues */
 	long rem_load_move;
 	task_t *tmp;
@@ -2057,11 +2057,6 @@ static int move_tasks(runqueue_t *this_r
 	pinned = 1;
 	this_best_prio = rq_best_prio(this_rq);
 	busiest_best_prio = rq_best_prio(busiest);
-	/*
-	 * Enable handling of the case where there is more than one task
-	 * with the best priority.
-	 */
-	busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;
 
 	/*
 	 * We first consider expired tasks. Those will likely not be
@@ -2072,6 +2067,13 @@ static int move_tasks(runqueue_t *this_r
 	if (busiest->expired->nr_active) {
 		array = busiest->expired;
 		dst_array = this_rq->expired;
+		/*
+		 * We already have one or more busiest best prio tasks on
+		 * active list. So if we encounter any busiest best prio task
+		 * on expired list, consider it for the move, if it becomes
+		 * the best prio on new queue.
+		 */
+		busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;
 	} else {
 		array = busiest->active;
 		dst_array = this_rq->active;
@@ -2089,6 +2091,7 @@ skip_bitmap:
 		if (array == busiest->expired && busiest->active->nr_active) {
 			array = busiest->active;
 			dst_array = this_rq->active;
+			busiest_best_prio_seen = 0;
 			goto new_array;
 		}
 		goto out;
@@ -2107,8 +2110,9 @@ skip_queue:
 	 * prio value) on its new queue regardless of its load weight
 	 */
 	skip_for_load = tmp->load_weight > rem_load_move;
-	if (skip_for_load && idx < this_best_prio)
-		skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;
+	if (skip_for_load && idx < this_best_prio && idx == busiest_best_prio)
+		skip_for_load = !busiest_best_prio_seen &&
+				head->next == head->prev;
 	if (skip_for_load ||
 	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
@@ -2133,8 +2137,6 @@ skip_queue:
 	if (pulled < max_nr_move && rem_load_move > 0) {
 		if (idx < this_best_prio)
 			this_best_prio = idx;
-		if (idx == busiest_best_prio)
-			busiest_best_prio_seen = 1;
 		if (curr != head)
 			goto skip_queue;
 		idx++;
