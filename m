Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWDVBbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWDVBbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 21:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWDVBbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 21:31:32 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:2118 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750854AbWDVBbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 21:31:32 -0400
Message-ID: <44498771.1030409@bigpond.net.au>
Date: Sat, 22 Apr 2006 11:31:29 +1000
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
References: <44485E21.6070801@bigpond.net.au> <20060421173416.C17932@unix-os.sc.intel.com>
In-Reply-To: <20060421173416.C17932@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 22 Apr 2006 01:31:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Fri, Apr 21, 2006 at 02:22:57PM +1000, Peter Williams wrote:
>> @@ -2052,7 +2055,13 @@ static int move_tasks(runqueue_t *this_r
>>  
>>  	rem_load_move = max_load_move;
>>  	pinned = 1;
>> -	this_min_prio = this_rq->curr->prio;
>> +	this_best_prio = rq_best_prio(this_rq);
>> +	busiest_best_prio = rq_best_prio(busiest);
>> +	/*
>> +	 * Enable handling of the case where there is more than one task
>> +	 * with the best priority.
>> +	 */
>> +	busiest_best_prio_seen = busiest_best_prio == busiest->curr->prio;
> 
>>From this hunk, it seems like we don't want to override the skip of highest 
> priority task as long as there is one such task in active list(even though
> there may be few such tasks on expired list). Right?

No, but nearly.  We don't want to override the skip of a task with the 
highest priority until we've skipped one such task OR we're sure one 
such task will be skipped (e.g. because it's the currently running task).

> And why?

If there are more than one task with the highest priority then it is 
desirable to move one of them by overriding the skip mechanism as it can 
be considered the second highest priority task.  This initialization 
just checks to see if the currently running task is one of the highest 
priority tasks.  If it is then it's OK to move the first task we find 
that also has the same priority otherwise we wait until we've skipped 
one before we move one.

> 
> If we fix the above, we don't need busiest_best_prio_seen. Once we move one 
> highest priority task, we are changing this_best_prio anyhow right?

Yes, but this is recording the fact that we've skipped one and that it's 
now OK to move one.

> 
> This patch doesn't address the issue where we can skip the highest priority 
> task movement if there is only one such task on the busy runqueue
> (and is on the expired list..)

I think that it does.

> 
> I can send a fix if I understand your intention for the above hunk.

If you think that there's still a problem after the above explanation 
then sending a patch might help me understand why you think it's wrong.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
