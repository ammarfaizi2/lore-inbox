Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWDYXXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWDYXXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 19:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWDYXXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 19:23:35 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:51346 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932226AbWDYXXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 19:23:34 -0400
Message-ID: <444EAF74.8090705@bigpond.net.au>
Date: Wed, 26 Apr 2006 09:23:32 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] sched: fix evaluation of skip_for_load in move_tasks()
References: <444D9290.6070706@bigpond.net.au> <20060425092840.A23188@unix-os.sc.intel.com>
In-Reply-To: <20060425092840.A23188@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 25 Apr 2006 23:23:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Tue, Apr 25, 2006 at 01:08:00PM +1000, Peter Williams wrote:
>> Problem:
>>
>> In the patch 
>> sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
>> I got a the sense of a boolean expression wrong when assigning a value 
>> to skip_for_load.  The expression should have been negated before being 
>> assigned.
>>
>> Additionally, busiest_best_prio_seen is being set when tasks are moved 
>> instead of when they are skipped which will cause problems when the 
>> current task does not have prio=busiest_best_prio.
>>
>> Solution:
>>
>> Negate the expression and apply de Marcos rule to simplify it and move 
>> the setting of busiest_best_prio_seen.
>>
>> This patch is on top of 
>> sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
>>
>> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
>>
>> -- 
>> Peter Williams                                   pwil3058@bigpond.net.au
>>
>> "Learning, n. The kind of ignorance distinguishing the studious."
>>   -- Ambrose Bierce
> 
>> Index: MM-2.6.17-rc1-mm3/kernel/sched.c
>> ===================================================================
>> --- MM-2.6.17-rc1-mm3.orig/kernel/sched.c	2006-04-25 12:53:39.000000000 +1000
>> +++ MM-2.6.17-rc1-mm3/kernel/sched.c	2006-04-25 12:56:14.000000000 +1000
>> @@ -2059,7 +2059,10 @@ static int move_tasks(runqueue_t *this_r
>>  	busiest_best_prio = rq_best_prio(busiest);
>>  	/*
>>  	 * Enable handling of the case where there is more than one task
>> -	 * with the best priority.
>> +	 * with the best priority.   If the current running task is one
>> +	 * of those with prio==busiest_best_prio we know it won't be moved
>> +	 * and therefore it's safe to override the skip (based on load) of
>> +	 * any task we find with that prio.
>>  	 */
>>  	busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;
>>  
>> @@ -2108,9 +2111,10 @@ skip_queue:
>>  	 */
>>  	skip_for_load = tmp->load_weight > rem_load_move;
>>  	if (skip_for_load && idx < this_best_prio)
>> -		skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;
>> +		skip_for_load = !busiest_best_prio_seen && idx == busiest_best_prio;
> 
> I think we need to change this to
> 	if (skip_for_load && idx < this_best_prio && idx == busiest_best_prio)
> 		skip_for_load = !busiest_best_prio_seen;
> 
> Otherwise we will reset skip_for_load to '0' even for the tasks whose prio is 
> less than this_best_prio but not equal to busiest_best_prio.

And why is that a problem?  The intention of this code is to make sure 
at least one busiest_best_prio task doesn't get moved as a result of the 
"skip for reasons of load weight" mechanism being overridden by the "idx 
< this_best_prio" exception.  I can't see how this intention is being 
subverted.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
