Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWGELh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWGELh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 07:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWGELh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 07:37:26 -0400
Received: from mail.gmx.de ([213.165.64.21]:23471 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964818AbWGELh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 07:37:26 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 13:42:32 +0200
Message-Id: <1152099752.8684.198.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 09:35 +1000, Peter Williams wrote:

> @@ -3332,23 +3447,25 @@ need_resched_nonpreemptible:
>  	}
>  
>  	array = rq->active;
> -	if (unlikely(!array->nr_active)) {
> -		/*
> -		 * Switch the active and expired arrays.
> -		 */
> -		schedstat_inc(rq, sched_switch);
> -		rq->active = rq->expired;
> -		rq->expired = array;
> -		array = rq->active;
> -		rq->expired_timestamp = 0;
> -		rq->best_expired_prio = MAX_PRIO;
> -	}
> +	if (unlikely(!array->nr_active))
> +		array = switch_arrays(rq, MAX_PRIO);
>  
>  	idx = sched_find_first_bit(array->bitmap);
> +get_next:
>  	queue = array->queue + idx;
>  	next = list_entry(queue->next, struct task_struct, run_list);
> +	/* very strict backgrounding */
> +	if (unlikely(task_in_background(next) && rq->expired->nr_active)) {
> +		int tmp = sched_find_first_bit(rq->expired->bitmap);
> +
> +		if (likely(tmp < idx)) {
> +			array = switch_arrays(rq, idx);
> +			idx = tmp;
> +			goto get_next;

Won't this potentially expire the mutex holder which you specifically
protect in scheduler_tick() if it was preempted before being ticked?
The task in the expired array could also be a !safe_to_background() task
who already had a chance to run, and who's slice expired.

If it's worth protecting higher priority tasks from mutex holders ending
up in the expired array, then there's a case that should be examined.
There's little difference between a background task acquiring a mutex,
and a normal task with one tick left on it's slice.  Best for sleepers
is of course to just say no to expiring mutex holders period.

	-Mike

