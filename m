Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWDYChi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWDYChi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWDYChh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:37:37 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:51440 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750939AbWDYChh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:37:37 -0400
Message-ID: <444D8B6F.7050601@bigpond.net.au>
Date: Tue, 25 Apr 2006 12:37:35 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kernel@kolivas.org, mingo@elte.hu, suresh.b.siddha@intel.com,
       efault@gmx.de, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH] sched: Fix boolean expression in move_tasks()
References: <444D637F.5040702@bigpond.net.au> <20060424191358.08c73e31.akpm@osdl.org>
In-Reply-To: <20060424191358.08c73e31.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 25 Apr 2006 02:37:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Peter Williams <pwil3058@bigpond.net.au> wrote:
>> Negate the expression and apply de Marcos rule to simplify it.  This 
>>  patch is on top of 
>>  sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks.patch
>>
>>  Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
>>
>>  -- 
>>  Peter Williams                                   pwil3058@bigpond.net.au
>>
>>  "Learning, n. The kind of ignorance distinguishing the studious."
>>    -- Ambrose Bierce
>>
>>
>> [smpnice-fix-boolean-expression  text/plain (824 bytes)]
>>  Index: MM-2.6.17-rc1-mm3/kernel/sched.c
>>  ===================================================================
>>  --- MM-2.6.17-rc1-mm3.orig/kernel/sched.c	2006-04-21 12:26:54.000000000 +1000
>>  +++ MM-2.6.17-rc1-mm3/kernel/sched.c	2006-04-25 09:09:54.000000000 +1000
>>  @@ -2108,7 +2108,7 @@ skip_queue:
>>   	 */
>>   	skip_for_load = tmp->load_weight > rem_load_move;
>>   	if (skip_for_load && idx < this_best_prio)
>>  -		skip_for_load = busiest_best_prio_seen || idx != busiest_best_prio;
>>  +		skip_for_load = !busiest_best_prio_seen && idx == busiest_best_prio;
> 
> But Suresh's
> sched-avoid-unnecessarily-moving-highest-priority-task-move_tasks-fix.patch
> changed all this code:
> 
> 	/*
> 	 * To help distribute high priority tasks accross CPUs we don't
> 	 * skip a task if it will be the highest priority task (i.e. smallest
> 	 * prio value) on its new queue regardless of its load weight
> 	 */
> 	skip_for_load = tmp->load_weight > rem_load_move;
> 	if (skip_for_load && idx < this_best_prio && idx == busiest_best_prio)
> 		skip_for_load = !busiest_best_prio_seen &&
> 				head->next == head->prev;
> 	if (skip_for_load ||
> 	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
> 		if (curr != head)
> 			goto skip_queue;
> 		idx++;
> 		goto skip_bitmap;
> 	}
> 
> 
> What to do?

Suresh's patch was wrong and this was intended as an alternative. 
Unfortunately, it is also in adequate and the setting of 
busiest_best_prio_seen needs to be moved to just after skip_for_load is 
set.  I have another patch that does that (and adds to the comments). 
Should I send that separately or roll the two patches together?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
