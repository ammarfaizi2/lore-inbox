Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWDMXwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWDMXwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWDMXwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:52:55 -0400
Received: from mga05.intel.com ([192.55.52.89]:3098 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S965045AbWDMXwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:52:54 -0400
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23764702:sNHT23751245"
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23764698:sNHT27614300"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23057440:sNHT19624948"
Date: Thu, 13 Apr 2006 16:51:17 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: modify move_tasks() to improve load balancing outcomes
Message-ID: <20060413165117.A15723@unix-os.sc.intel.com>
References: <443DF64B.5060305@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <443DF64B.5060305@bigpond.net.au>; from pwil3058@bigpond.net.au on Thu, Apr 13, 2006 at 04:57:15PM +1000
X-OriginalArrivalTime: 13 Apr 2006 23:52:52.0885 (UTC) FILETIME=[60E0EC50:01C65F55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 04:57:15PM +1000, Peter Williams wrote:
> Problem:
> 
> The move_tasks() function is designed to move UP TO the amount of load 
> it is asked to move and in doing this it skips over tasks looking for 
> ones whose load weights are less than or equal to the remaining load to 
> be moved.  This is (in general) a good thing but it has the unfortunate 
> result of breaking one of the original load balancer's good points: 

with previous load balancer code it was a good point.. because all tasks
were weighted the same from load balancer perspective.. but now the
imbalance represents what task to move (atleast in the working
cases :)

> namely, that (within the limits imposed by the active/expired array 
> model and the fact the expired is processed first) it moves high 
> priority tasks before low priority ones and this means there's a good 
> chance (see active/expired problem for why it's only a chance) that the 
> highest priority task on the queue but not actually on the CPU will be 
> moved to the other CPU where (as a high priority task) it may preempt 
> the current task.
> 
> Solution:
> 
> Modify move_tasks() so that high priority tasks are not skipped when 
> moving them will make them the highest priority task on their new run queue.

you mean the highest priority task on the current active list of the new 
run queue, right?

There will be some unnecessary movements of high priority tasks because of
this...

thanks,
suresh

> 
> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
> 
> -- 
> Peter Williams                                   pwil3058@bigpond.net.au
> 
> "Learning, n. The kind of ignorance distinguishing the studious."
>   -- Ambrose Bierce

> Index: MM-2.6.17-rc1-mm2/kernel/sched.c
> ===================================================================
> --- MM-2.6.17-rc1-mm2.orig/kernel/sched.c	2006-04-13 10:53:32.000000000 +1000
> +++ MM-2.6.17-rc1-mm2/kernel/sched.c	2006-04-13 11:08:45.000000000 +1000
> @@ -2043,7 +2043,7 @@ static int move_tasks(runqueue_t *this_r
>  {
>  	prio_array_t *array, *dst_array;
>  	struct list_head *head, *curr;
> -	int idx, pulled = 0, pinned = 0;
> +	int idx, pulled = 0, pinned = 0, this_min_prio;
>  	long rem_load_move;
>  	task_t *tmp;
>  
> @@ -2052,6 +2052,7 @@ static int move_tasks(runqueue_t *this_r
>  
>  	rem_load_move = max_load_move;
>  	pinned = 1;
> +	this_min_prio = this_rq->curr->prio;
>  
>  	/*
>  	 * We first consider expired tasks. Those will likely not be
> @@ -2091,7 +2092,12 @@ skip_queue:
>  
>  	curr = curr->prev;
>  
> -	if (tmp->load_weight > rem_load_move ||
> +	/*
> +	 * To help distribute high priority tasks accross CPUs we don't
> +	 * skip a task if it will be the highest priority task (i.e. smallest
> +	 * prio value) on its new queue regardless of its load weight
> +	 */
> +	if ((idx >= this_min_prio && tmp->load_weight > rem_load_move) ||
>  	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
>  		if (curr != head)
>  			goto skip_queue;
> @@ -2113,6 +2119,8 @@ skip_queue:
>  	 * and the prescribed amount of weighted load.
>  	 */
>  	if (pulled < max_nr_move && rem_load_move > 0) {
> +		if (idx < this_min_prio)
> +			this_min_prio = idx;
>  		if (curr != head)
>  			goto skip_queue;
>  		idx++;

Peter, Are you sure that this is a converging solution? If we want to
