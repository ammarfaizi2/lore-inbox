Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWDXXEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWDXXEp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWDXXEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:04:45 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:16098 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932093AbWDXXEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:04:45 -0400
Message-ID: <444D5989.3060002@bigpond.net.au>
Date: Tue, 25 Apr 2006 09:04:41 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] sched: Avoid unnecessarily moving highest priority task
 move_tasks()
References: <44485E21.6070801@bigpond.net.au> <20060421173416.C17932@unix-os.sc.intel.com> <44498771.1030409@bigpond.net.au> <20060424120014.A16716@unix-os.sc.intel.com>
In-Reply-To: <20060424120014.A16716@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 24 Apr 2006 23:04:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Sat, Apr 22, 2006 at 11:31:29AM +1000, Peter Williams wrote:
>> If there are more than one task with the highest priority then it is 
>> desirable to move one of them by overriding the skip mechanism as it can 
>> be considered the second highest priority task.  
> 
> I think your patch is not doing what you intend to do.
> 
>> This initialization 
>> just checks to see if the currently running task is one of the highest 
>> priority tasks.  If it is then it's OK to move the first task we find 
>> that also has the same priority otherwise we wait until we've skipped 
>> one before we move one.
> 
> If this currently running task is of the highest priority, we set
> busiest_best_prio_seen to '1' and looking at the code, because of this
> we never consider any other busiest task which we come across on the expired
> list.. This is coming from this piece of code.
> 
> 	skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;
> 
> skip_for_load is always set to '1'(because of busiest_best_prio_seen)
> and we will never be able to move any busiest task to the new queue.

Looks like there's a NOT missing doesn't it.  So there is an error but I 
don't think that your patch is the right way to fix it.  We just need to 
negate the above assignment.  E.g.

skip_for_load = !(busiest_best_prio_seen || idx != busiest_best_prio);

or

skip_for_load = !busiest_best_prio_seen && idx == busiest_best_prio;

whichever is more efficient.

> 
>>> This patch doesn't address the issue where we can skip the highest priority 
>>> task movement if there is only one such task on the busy runqueue
>>> (and is on the expired list..)
>> I think that it does.
> 
> No. It doesn't. In this case busiest_best_prio_seen will be set to '0', when
> we traverse the only highest priority task on this queue(which happens to
> be on expired list), we set skip_for_load to '0' And we will try
> pulling the only highest priority task on this queue to the new queue..
> 
> Appended patch(ontop of 
> sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch)
> fixes these issues.
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> 
> --- linux-2.6.17-rc1/kernel/sched.c~	2006-04-21 13:12:01.749853640 -0700
> +++ linux-2.6.17-rc1/kernel/sched.c	2006-04-24 10:07:39.624162896 -0700
> @@ -2045,7 +2045,7 @@ static int move_tasks(runqueue_t *this_r
>  	prio_array_t *array, *dst_array;
>  	struct list_head *head, *curr;
>  	int idx, pulled = 0, pinned = 0, this_best_prio, busiest_best_prio;
> -	int busiest_best_prio_seen;
> +	int busiest_best_prio_seen = 0;
>  	int skip_for_load; /* skip the task based on weighted load issues */
>  	long rem_load_move;
>  	task_t *tmp;
> @@ -2057,11 +2057,6 @@ static int move_tasks(runqueue_t *this_r
>  	pinned = 1;
>  	this_best_prio = rq_best_prio(this_rq);
>  	busiest_best_prio = rq_best_prio(busiest);
> -	/*
> -	 * Enable handling of the case where there is more than one task
> -	 * with the best priority.
> -	 */
> -	busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;
>  
>  	/*
>  	 * We first consider expired tasks. Those will likely not be
> @@ -2072,6 +2067,13 @@ static int move_tasks(runqueue_t *this_r
>  	if (busiest->expired->nr_active) {
>  		array = busiest->expired;
>  		dst_array = this_rq->expired;
> +		/*
> +		 * We already have one or more busiest best prio tasks on
> +		 * active list.

This is a pretty bold assertion.  How do we know that this is true.

> So if we encounter any busiest best prio task
> +		 * on expired list, consider it for the move, if it becomes
> +		 * the best prio on new queue.
> +		 */
> +		busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;
>  	} else {
>  		array = busiest->active;
>  		dst_array = this_rq->active;
> @@ -2089,6 +2091,7 @@ skip_bitmap:
>  		if (array == busiest->expired && busiest->active->nr_active) {
>  			array = busiest->active;
>  			dst_array = this_rq->active;
> +			busiest_best_prio_seen = 0;
>  			goto new_array;
>  		}
>  		goto out;
> @@ -2107,8 +2110,9 @@ skip_queue:
>  	 * prio value) on its new queue regardless of its load weight
>  	 */
>  	skip_for_load = tmp->load_weight > rem_load_move;
> -	if (skip_for_load && idx < this_best_prio)
> -		skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;
> +	if (skip_for_load && idx < this_best_prio && idx == busiest_best_prio)
> +		skip_for_load = !busiest_best_prio_seen &&
> +				head->next == head->prev;
>  	if (skip_for_load ||
>  	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
>  		if (curr != head)
> @@ -2133,8 +2137,6 @@ skip_queue:
>  	if (pulled < max_nr_move && rem_load_move > 0) {
>  		if (idx < this_best_prio)
>  			this_best_prio = idx;
> -		if (idx == busiest_best_prio)
> -			busiest_best_prio_seen = 1;
>  		if (curr != head)
>  			goto skip_queue;
>  		idx++;


Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
