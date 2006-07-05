Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWGEOSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWGEOSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWGEOSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:18:48 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:34680 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964879AbWGEOSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:18:48 -0400
Message-ID: <44ABCA46.2070605@bigpond.net.au>
Date: Thu, 06 Jul 2006 00:18:46 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest> <1152099752.8684.198.camel@Homer.TheSimpsons.net> <44ABC5B7.2090707@bigpond.net.au>
In-Reply-To: <44ABC5B7.2090707@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 5 Jul 2006 14:18:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Mike Galbraith wrote:
>> On Wed, 2006-07-05 at 09:35 +1000, Peter Williams wrote:
>>
>>> @@ -3332,23 +3447,25 @@ need_resched_nonpreemptible:
>>>      }
>>>  
>>>      array = rq->active;
>>> -    if (unlikely(!array->nr_active)) {
>>> -        /*
>>> -         * Switch the active and expired arrays.
>>> -         */
>>> -        schedstat_inc(rq, sched_switch);
>>> -        rq->active = rq->expired;
>>> -        rq->expired = array;
>>> -        array = rq->active;
>>> -        rq->expired_timestamp = 0;
>>> -        rq->best_expired_prio = MAX_PRIO;
>>> -    }
>>> +    if (unlikely(!array->nr_active))
>>> +        array = switch_arrays(rq, MAX_PRIO);
>>>  
>>>      idx = sched_find_first_bit(array->bitmap);
>>> +get_next:
>>>      queue = array->queue + idx;
>>>      next = list_entry(queue->next, struct task_struct, run_list);
>>> +    /* very strict backgrounding */
>>> +    if (unlikely(task_in_background(next) && rq->expired->nr_active)) {
>>> +        int tmp = sched_find_first_bit(rq->expired->bitmap);
>>> +
>>> +        if (likely(tmp < idx)) {
>>> +            array = switch_arrays(rq, idx);
>>> +            idx = tmp;
>>> +            goto get_next;
>>
>> Won't this potentially expire the mutex holder which you specifically
>> protect in scheduler_tick() if it was preempted before being ticked?
> 
> I don't think so as its prio value should cause task_in_background() to 
> fail.

Actually, you're right, a pre-emption at the wrong time could cause the 
prio value not to have been changed.  There needs to be a 
safe_to_background(next) in there somewhere.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
