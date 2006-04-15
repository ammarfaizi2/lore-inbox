Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWDOAyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWDOAyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 20:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWDOAyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 20:54:49 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:46521 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751453AbWDOAys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 20:54:48 -0400
Message-ID: <44404455.8090304@bigpond.net.au>
Date: Sat, 15 Apr 2006 10:54:45 +1000
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
References: <443DF64B.5060305@bigpond.net.au> <20060413165117.A15723@unix-os.sc.intel.com> <443EFFD2.4080400@bigpond.net.au> <20060414112750.A21908@unix-os.sc.intel.com>
In-Reply-To: <20060414112750.A21908@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 15 Apr 2006 00:54:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Fri, Apr 14, 2006 at 11:50:10AM +1000, Peter Williams wrote:
>> Siddha, Suresh B wrote:
>>> On Thu, Apr 13, 2006 at 04:57:15PM +1000, Peter Williams wrote:
>>>> Problem:
>>>>
>>>> The move_tasks() function is designed to move UP TO the amount of load 
>>>> it is asked to move and in doing this it skips over tasks looking for 
>>>> ones whose load weights are less than or equal to the remaining load to 
>>>> be moved.  This is (in general) a good thing but it has the unfortunate 
>>>> result of breaking one of the original load balancer's good points: 
>>> with previous load balancer code it was a good point.. because all tasks
>>> were weighted the same from load balancer perspective.. but now the
>>> imbalance represents what task to move (atleast in the working
>>> cases :)
>> That's the option 4 case in my original mail.  Are you suggesting that 
>> it would have been the better option to adopt?  If so, why?
> 
> No. I was not suggesting option-4. With this change in move_tasks, we will 
> be overriding the decision what ever we made while calculating imbalance.
> Lets see for example, we have a simple DP system. With proc-0 running
> one high priority and one low priority task, Proc-1 running one
> low priority task. Ideally we would like to move low priority task from
> P0 to P1. But with this patch, we may end up moving high priority task
> from P0 to P1. But slowly after sometime(depending on high priority task
> is on active/expired list), we will converge to the expected
> solution..

Yes, there are problems with the active/expired arrays but they're no 
worse with smpnice than they are without it.

Going to a single priority array would eliminate this problem not to 
mention other problems to do with when to excuse tasks from being put on 
the expired array at the end of their time slice (see Mike Galbraith's 
patches).  But I haven't had much luck pushing that barrow. :-)

> 
>>> you mean the highest priority task on the current active list of the new 
>>> run queue, right?
>> Good point.  this_min_prio should probably be initialized to the minimum 
>> of this_rq->curr->prio and this_rq->best_expired_prio rather just using 
>> this_rq->curr->prio.
> 
> yes.
> 
>>> There will be some unnecessary movements of high priority tasks because of
>>> this...
>> How so.  At most one task per move_tasks() will be moved as a result of 
>> this code that wouldn't have been moved otherwise.  That task will be a 
>> high priority task stuck behind a higher priority task on its current 
>> queue that will be the highest priority on its new queue causing a 
>> preempt and access to the CPU.  I wouldn't call this unnecessary.
> 
> highest priority task can be in the expired list with normal priority
> task running.. as in my above example.

Yes, but this will get it onto a CPU sooner so it's not all bad.  Once 
again it's no worse than without smpnice.

I said in the patch description that there are active/expired array 
issues that make load balancing less than perfect with and without 
smpnice.  How far we go trying to eliminate them is the question.

If you have a better suggestion for how move_tasks() does its job, how 
about providing a patch and with supporting arguments as to why its 
better.  If it is better then we can use it.

> 
>>> Peter, Are you sure that this is a converging solution? If we want to
>> Yes, I think we're getting there.
>>
>> I think we need changes to try_to_wake_up() to help high priority tasks 
>> find idle CPUs or CPUs where they would preempt when they wake up. 
>> Leaving this to the load balancer is bad for these tasks latencies.  I 
>> think that this change needs to be done independently of smpnice as it 
>> would be useful even without smpnice.  I'm hoping Ingo or Nick will 
>> comment on this proposal.
>>
>> It would also help if you fixed the active load balance code so that 
>> it's not necessary to distort normal load balancing to accommodate it. 
>> I haven't had time to look at it myself (other than a quick glance) yet.
> 
> The only special check in find_busiest_group() helping MT/MC balancing
> is pwr_now and pwr_move calculations..

What about the very messy code I had to put in so that 
find_busiest_group() would return a group even if there were no queues 
in the group with more than one task.  Similar for find_busiest_queue().

> These calculations will also help,
> in future when we are dealing with sched groups which are not symmetric.
> Asymmetries can be caused in scenarios like cpufreq, cpu logical hotplug..

I meant for you to move the (highly speculative) active load balancing 
trigger out of load_balance() so that we can stop returning busiest 
groups and queues that have no hope of participating in successful load 
balancing.

> 
> I think we are unnecessarily behind active load balance...

I'm not sure what you mean here.  I'm not behind it at all.  I can see 
the need for HT systems to be able to move the only running task of a 
CPU to another CPU in another package but I think the implementation is 
appalling.  I think it needs a complete rewrite.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
