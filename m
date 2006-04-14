Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWDNBuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWDNBuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 21:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWDNBuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 21:50:14 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:12916 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965066AbWDNBuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 21:50:12 -0400
Message-ID: <443EFFD2.4080400@bigpond.net.au>
Date: Fri, 14 Apr 2006 11:50:10 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: modify move_tasks() to improve load balancing
 outcomes
References: <443DF64B.5060305@bigpond.net.au> <20060413165117.A15723@unix-os.sc.intel.com>
In-Reply-To: <20060413165117.A15723@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 14 Apr 2006 01:50:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Thu, Apr 13, 2006 at 04:57:15PM +1000, Peter Williams wrote:
>> Problem:
>>
>> The move_tasks() function is designed to move UP TO the amount of load 
>> it is asked to move and in doing this it skips over tasks looking for 
>> ones whose load weights are less than or equal to the remaining load to 
>> be moved.  This is (in general) a good thing but it has the unfortunate 
>> result of breaking one of the original load balancer's good points: 
> 
> with previous load balancer code it was a good point.. because all tasks
> were weighted the same from load balancer perspective.. but now the
> imbalance represents what task to move (atleast in the working
> cases :)

That's the option 4 case in my original mail.  Are you suggesting that 
it would have been the better option to adopt?  If so, why?

I don't like it because (leaving aside the active/expired array issues) 
it would move the X top priority tasks across where X is the number of 
tasks required to meet the requirement.  If we could arrange for it to 
skip every second one without making the code too complicated (i.e. 
there'd be a possible need for multiple passes until the required load 
was moved).

> 
>> namely, that (within the limits imposed by the active/expired array 
>> model and the fact the expired is processed first) it moves high 
>> priority tasks before low priority ones and this means there's a good 
>> chance (see active/expired problem for why it's only a chance) that the 
>> highest priority task on the queue but not actually on the CPU will be 
>> moved to the other CPU where (as a high priority task) it may preempt 
>> the current task.
>>
>> Solution:
>>
>> Modify move_tasks() so that high priority tasks are not skipped when 
>> moving them will make them the highest priority task on their new run queue.
> 
> you mean the highest priority task on the current active list of the new 
> run queue, right?

Good point.  this_min_prio should probably be initialized to the minimum 
of this_rq->curr->prio and this_rq->best_expired_prio rather just using 
this_rq->curr->prio.

> 
> There will be some unnecessary movements of high priority tasks because of
> this...

How so.  At most one task per move_tasks() will be moved as a result of 
this code that wouldn't have been moved otherwise.  That task will be a 
high priority task stuck behind a higher priority task on its current 
queue that will be the highest priority on its new queue causing a 
preempt and access to the CPU.  I wouldn't call this unnecessary.

> Peter, Are you sure that this is a converging solution? If we want to

Yes, I think we're getting there.

I think we need changes to try_to_wake_up() to help high priority tasks 
find idle CPUs or CPUs where they would preempt when they wake up. 
Leaving this to the load balancer is bad for these tasks latencies.  I 
think that this change needs to be done independently of smpnice as it 
would be useful even without smpnice.  I'm hoping Ingo or Nick will 
comment on this proposal.

It would also help if you fixed the active load balance code so that 
it's not necessary to distort normal load balancing to accommodate it. 
I haven't had time to look at it myself (other than a quick glance) yet.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
