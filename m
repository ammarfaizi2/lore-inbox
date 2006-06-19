Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWFSC1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWFSC1A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 22:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWFSC1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 22:27:00 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:2226 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750750AbWFSC07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 22:26:59 -0400
Message-ID: <449609E4.1030908@in.ibm.com>
Date: Mon, 19 Jun 2006 07:50:20 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
Cc: Andrew Morton <akpm@osdl.org>, dev@openvz.org, vatsa@in.ibm.com,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       bsingharora@gmail.com, efault@gmx.de,
       Peter Williams <pwil3058@bigpond.net.au>, kernel@kolivas.org,
       sam@vilain.net, kingsley@aurema.com, mingo@elte.hu,
       rene.herman@keyaccess.nl
Subject: Re: [ckrm-tech] [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>	<20060618025046.77b0cecf.akpm@osdl.org>	<449529FE.1040008@bigpond.net.au>	<4495EC40.70301@in.ibm.com> <4495F7FE.9030601@aurema.com>
In-Reply-To: <4495F7FE.9030601@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Balbir Singh wrote:
> 
>>Peter Williams wrote:
>>
>>>Andrew Morton wrote:
>>>
>>>
>>>>On Sun, 18 Jun 2006 18:26:38 +1000
>>>>Peter Williams <pwil3058@bigpond.net.au> wrote:
>>>>
>>>>People are going to want to extend this to capping a *group* of tasks, 
>>>>with
>>>>some yet-to-be-determined means of tying those tasks together.  How well
>>>>suited is this code to that extension?
>>>
>>>Quite good.  It can be used from outside the scheduler to impose caps on 
>>>arbitrary groups of tasks.  Were the PAGG interface available I could 
>>>knock up a module to demonstrate this.  When/if the "task watchers" 
>>>patch is included I will try and implement a higher level mechanism 
>>>using that.  The general technique is to get an estimate of the 
>>>"effective number" of tasks in the group (similar to load) and give each 
>>>task in the group a cap which is the group's cap divided by the 
>>>effective number of tasks (or the group cap whichever is smaller -- i.e. 
>>>the effective number of tasks could be less than one).
>>>)
>>
>>
>>There is one possible issue with this approach. Lets assume that we desire
>>a cap of 10 for a set of two tasks. As discussed earlier, each task
>>would get a limit of 5% if they are equally busy.
>>
>>Lets call the group as G1 and the tasks as T1 and T2.
>>
>>If we have another group called G2 with tasks T3, T4 and T5 and a soft
>>cap of 90. Then each of T3, T4 and T5 would get a soft cap of
>>30% (assuming that they are equally busy). Now if T5 stops using its limit
>>for a while let say its cpu utilization is 10% - how do we divide the saved
>>20% between T1, T2, T3 and T4.
>>
>>In a group scenario, the balance 20% should be shared between T3 and T4.
> 
> 
> You're mixing up the method described above with the other one we 
> discussed where the group's cap is divided among its tasks in proportion 
> to their demand.  With the model I describe above reduced demand by any 
> tasks in a group would be reflected in a reduced value for the 
> "effective number of tasks" in the group with a consequent increase in 
> the cap applied to all group members.
>

Thanks for clarifying. How frequently is the reduction in effective number
of tasks calculated and how frequently is the cap updated? Does it require
setting the cap values of all the tasks in the group again (O(N), N is the
number of tasks in the group)? Is it possible that the effective tasks
is greater than the limit of the group? How do we handle this scenario?

 
> I think both methods will work and the main difference would be in their 
> complexity.

An implementation or prototype when available will be interesting to play
around and experiment with. I think it will help clarify if the task mechanism
will indeed work for groups or may expose some limitations of the mechanism.

> 
> 
>>Also mathematically
>>
>>A group is a superset of task
>>
>>It is hard to implement things for a task and make it work for groups,
> 
> 
> I disagree.  If the low level control is there at the task level or (if 
> we were managing memory) the address space level then it is relatively 
> simple (even if boring) to do arbitrary resource control for groups from 
> the outside.
> 
> One of the key advantages of doing it from the outside is that any 
> locking that is required at the group level is unlikely to get tangled 
> up with the existing locking mechanisms such as the run queue lock. 
> This is not true if group management is done on the inside e.g. in the 
> scheduling code.
> 

The f-series controller from ckrm does so without changing or getting
tangled with the existing locking system.

> 
>>but if we had something for groups, we could easily adapt it to tasks
>>by making each group equal to a task
> 
> 
> You seem to have a flair for adding unnecessary overhead for those who 
> won't use this functionality. :-)
> 
> 
>>>Doing it inside the scheduler is also doable but would have some locking 
>>>issues.  The run queue lock could no longer be used to protect the data 
>>>as there's no guarantee that all the tasks in the group are associated 
>>>with the same queue.
> 
> 
> I should have elaborated here that (conceptually) modifying this code to 
> apply caps to groups of tasks instead of individual tasks is simple.  It 
> mainly involves moving most the data (statistics plus cap values) to a 
> group structure and then modifying the code to update statistics for the 
> group instead of the task and then make the decisions about whether a 
> task should have a cap enforced (i.e. moved to one of the soft cap 
> priorities or sin binned) based on the group statistics.
> 
> However, maintaining and accessing the group statistics will require 
> additional locking as the run queue lock will no longer be able to 
> protect the data as not all tasks in the group will be associated with 
> the same CPU.  Care will be needed to ensure that this new locking 
> doesn't lead to dead locks with the run queue locks.
> 
> In addition to the extra overhead caused by these locking requirements, 
> the code for gathering the statistics will need to be more complex also 
> adding to the overhead.  There is also the issue of increased 
> serialization (there is already some due to load balancing) of task 
> scheduling to be considered although, to be fair, this increased 
> serialization will be within groups.
> 
> 

The f-series CPU controller does all of what you say in 403 lines (including
comments and copyright). I think the biggest advantage of maintaining the
group statistics in the kernel is that certain scheduling decisions can be
made based on group statistics rather than task statistics, which makes the
mechanism independent of the number of tasks in the group (isolates the
groups from changes in number of tasks).

If we can achieve something similar with low overhead in user space, I would
certainly love to see it.

>>>>If the task can exceed its cap without impacting any other tasks (ie: 
>>>>there
>>>>is spare idle capacity), what happens?
>>>
>>>That's the difference between soft and hard caps.  If it's a soft cap 
>>>then the task is allowed to exceed it if there's spare capacity.  If 
>>>it's a hard cap it's not.
>>>
>>
>>By how much is the task allowed to exceed if there is spare capacity?
> 
> 
> Up to the amount of spare capacity.
> 
> 
>>Will the spare capacity allocation require resetting of caps to implement
>>the new caps?
> 
> 
> No.  It's part of the soft cap mechanism.
> 
> 
>>>> I trust that spare capacity gets
>>>>used?  (Is this termed "work conserving"?)
>>>
>>>Soft caps, yes.  Hard caps, no.
>>>
>>
> 
> In summary, these patches are a good basis for doing capping for groups 
> of tasks by at least two means:
> 
> 1. modification to do group capping in the scheduler, or
> 2. implementing group capping from outside the scheduler.
> 
> I intend spending more effort looking at the second of these options 
> than looking at the first.
> 
> Peter


-- 
	Double the cheers,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
