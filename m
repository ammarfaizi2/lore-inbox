Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWGEN7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWGEN7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWGEN7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:59:22 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:61525 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932421AbWGEN7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:59:22 -0400
Message-ID: <44ABC5B7.2090707@bigpond.net.au>
Date: Wed, 05 Jul 2006 23:59:19 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest> <1152099752.8684.198.camel@Homer.TheSimpsons.net>
In-Reply-To: <1152099752.8684.198.camel@Homer.TheSimpsons.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 5 Jul 2006 13:59:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Wed, 2006-07-05 at 09:35 +1000, Peter Williams wrote:
> 
>> @@ -3332,23 +3447,25 @@ need_resched_nonpreemptible:
>>  	}
>>  
>>  	array = rq->active;
>> -	if (unlikely(!array->nr_active)) {
>> -		/*
>> -		 * Switch the active and expired arrays.
>> -		 */
>> -		schedstat_inc(rq, sched_switch);
>> -		rq->active = rq->expired;
>> -		rq->expired = array;
>> -		array = rq->active;
>> -		rq->expired_timestamp = 0;
>> -		rq->best_expired_prio = MAX_PRIO;
>> -	}
>> +	if (unlikely(!array->nr_active))
>> +		array = switch_arrays(rq, MAX_PRIO);
>>  
>>  	idx = sched_find_first_bit(array->bitmap);
>> +get_next:
>>  	queue = array->queue + idx;
>>  	next = list_entry(queue->next, struct task_struct, run_list);
>> +	/* very strict backgrounding */
>> +	if (unlikely(task_in_background(next) && rq->expired->nr_active)) {
>> +		int tmp = sched_find_first_bit(rq->expired->bitmap);
>> +
>> +		if (likely(tmp < idx)) {
>> +			array = switch_arrays(rq, idx);
>> +			idx = tmp;
>> +			goto get_next;
> 
> Won't this potentially expire the mutex holder which you specifically
> protect in scheduler_tick() if it was preempted before being ticked?

I don't think so as its prio value should cause task_in_background() to 
fail.

> The task in the expired array could also be a !safe_to_background() task
> who already had a chance to run, and who's slice expired.

If it's !safe_to_background() it's in our interest to let it run in 
order to free up the resource that it's holding.

> 
> If it's worth protecting higher priority tasks from mutex holders ending
> up in the expired array, then there's a case that should be examined.

It's more than just stopping them end up in the expired array.  It's 
stopping them being permanently in the expired array.

> There's little difference between a background task acquiring a mutex,
> and a normal task with one tick left on it's slice.

The difference is that the background task could stay there forever.

>  Best for sleepers
> is of course to just say no to expiring mutex holders period.

In spite of my comments above, I agree that not expiring mutex holders 
might (emphasis on the "might") be good for overall system performance 
by reducing the time for which locks are held.  Giving them a whole new 
time slice on the active array might be too generous though.  It could 
become quite complex.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
