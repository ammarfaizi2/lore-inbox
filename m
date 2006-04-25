Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWDYQdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWDYQdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWDYQdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:33:11 -0400
Received: from mga05.intel.com ([192.55.52.89]:13718 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751592AbWDYQdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:33:10 -0400
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="28368880:sNHT58400650"
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="28368864:sNHT53624291"
TrustInternalSourcedMail: True
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="28368845:sNHT61099675"
Date: Tue, 25 Apr 2006 09:28:40 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH] sched: fix evaluation of skip_for_load in move_tasks()
Message-ID: <20060425092840.A23188@unix-os.sc.intel.com>
References: <444D9290.6070706@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <444D9290.6070706@bigpond.net.au>; from pwil3058@bigpond.net.au on Tue, Apr 25, 2006 at 01:08:00PM +1000
X-OriginalArrivalTime: 25 Apr 2006 16:31:46.0701 (UTC) FILETIME=[BEC2BBD0:01C66885]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 01:08:00PM +1000, Peter Williams wrote:
> Problem:
> 
> In the patch 
> sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
> I got a the sense of a boolean expression wrong when assigning a value 
> to skip_for_load.  The expression should have been negated before being 
> assigned.
> 
> Additionally, busiest_best_prio_seen is being set when tasks are moved 
> instead of when they are skipped which will cause problems when the 
> current task does not have prio=busiest_best_prio.
> 
> Solution:
> 
> Negate the expression and apply de Marcos rule to simplify it and move 
> the setting of busiest_best_prio_seen.
> 
> This patch is on top of 
> sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
> 
> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
> 
> -- 
> Peter Williams                                   pwil3058@bigpond.net.au
> 
> "Learning, n. The kind of ignorance distinguishing the studious."
>   -- Ambrose Bierce

> Index: MM-2.6.17-rc1-mm3/kernel/sched.c
> ===================================================================
> --- MM-2.6.17-rc1-mm3.orig/kernel/sched.c	2006-04-25 12:53:39.000000000 +1000
> +++ MM-2.6.17-rc1-mm3/kernel/sched.c	2006-04-25 12:56:14.000000000 +1000
> @@ -2059,7 +2059,10 @@ static int move_tasks(runqueue_t *this_r
>  	busiest_best_prio = rq_best_prio(busiest);
>  	/*
>  	 * Enable handling of the case where there is more than one task
> -	 * with the best priority.
> +	 * with the best priority.   If the current running task is one
> +	 * of those with prio==busiest_best_prio we know it won't be moved
> +	 * and therefore it's safe to override the skip (based on load) of
> +	 * any task we find with that prio.
>  	 */
>  	busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;
>  
> @@ -2108,9 +2111,10 @@ skip_queue:
>  	 */
>  	skip_for_load = tmp->load_weight > rem_load_move;
>  	if (skip_for_load && idx < this_best_prio)
> -		skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;
> +		skip_for_load = !busiest_best_prio_seen && idx == busiest_best_prio;

I think we need to change this to
	if (skip_for_load && idx < this_best_prio && idx == busiest_best_prio)
		skip_for_load = !busiest_best_prio_seen;

Otherwise we will reset skip_for_load to '0' even for the tasks whose prio is 
less than this_best_prio but not equal to busiest_best_prio.

>  	if (skip_for_load ||
>  	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
> +		busiest_best_prio_seen |= idx == busiest_best_prio;
>  		if (curr != head)
>  			goto skip_queue;
>  		idx++;
> @@ -2133,8 +2137,6 @@ skip_queue:
>  	if (pulled < max_nr_move && rem_load_move > 0) {
>  		if (idx < this_best_prio)
>  			this_best_prio = idx;
> -		if (idx == busiest_best_prio)
> -			busiest_best_prio_seen = 1;
>  		if (curr != head)
>  			goto skip_queue;
>  		idx++;
