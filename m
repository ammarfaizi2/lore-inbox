Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWDLFG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWDLFG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 01:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWDLFGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 01:06:55 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:28573 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750791AbWDLFGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 01:06:55 -0400
Message-ID: <443C8AEC.9010309@bigpond.net.au>
Date: Wed, 12 Apr 2006 15:06:52 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: move enough load to balance average load per task
References: <4439FF0C.8030407@bigpond.net.au> <20060410181237.A26977@unix-os.sc.intel.com> <443C3FD8.2060906@bigpond.net.au> <20060411185709.A2401@unix-os.sc.intel.com>
In-Reply-To: <20060411185709.A2401@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 12 Apr 2006 05:06:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Wed, Apr 12, 2006 at 09:46:32AM +1000, Peter Williams wrote:
>> Siddha, Suresh B wrote:
>>> On Mon, Apr 10, 2006 at 04:45:32PM +1000, Peter Williams wrote:
>>>> Problem:
>>>>
>>>> The current implementation of find_busiest_group() recognizes that 
>>>> approximately equal average loads per task for each group/queue are 
>>>> desirable (e.g. this condition will increase the probability that the 
>>>> top N highest priority tasks on an N CPU system will be on different 
>>>> CPUs) by being slightly more aggressive when *imbalance is small but the 
>>>> average load per task in "busiest" group is more than that in "this" 
>>>> group.  Unfortunately, the amount moved from "busiest" to "this" is too 
>>>> small to reduce the average load per task on "busiest" (at best there 
>>>> will be no change and at worst it will get bigger).
>>> Peter, We don't need to reduce the average load per task on "busiest"
>>> always. By moving a "busiest_load_per_task", we will increase the 
>>> average load per task of lesser busy cpu (there by trying to achieve
>>> the equality with busiest...)
>> Well, first off, we don't always move busiest_load_per_task we move UP 
>> TO busiest_load_per_task so there is no way you can make definitive 
>> statements about what will happen to the value "this_load_per_task" as a 
>> result of setting *imbalance to busiest_load_per_task.  Load balancing 
>> is a probabilistic endeavour and we need to take steps that increase the 
>> probability that we get the desired result.
> 
> I agree with you. But the previous code was more conservative and may slowly
> (just from theory pt of view... I don't have an example to show this..)
> balance towards the desired state. With this code, I feel we are
> aggressive. for example, on a DP system: if I run one high priority
> and two low priority processes, they keep hopping from one processor
> to another... you may argue it is because of the "top" or some other
> process... I agree that it is the case.. But same thing doesn't happen
> with the previous version.. I like the conservative approach...
> 
>> Without this patch there is no chance that busiest_load_per_task will 
>> get smaller 
> 
> Is there an example for this?

Yes, we just take a slight variation of your scenario that prompted the 
first patch (to which this patch is a minor modification) by adding one 
normal priority task to each of the CPUs.  This gives us a 2 CPU system 
with CPU-0 having 2 high priority tasks plus 1 normal priority task and 
CPU-1 having two normal priority tasks.  Clearly, the desirable load 
balancing outcome would be for the two high priority tasks to be on 
different CPUs otherwise we have a high priority task stuck on a run 
queue while a normal priority is running on another (less heavily 
loaded) CPU.

In order to analyze what happens during load balancing, let's use W as 
the load weight for a normal task and suppose that the load weights of 
the two high priority tasks are (W + k) and that "this" == CPU-1 in 
find_busiest_queue().  This will result in "busiest" == CPU-0 and:

this_load = 2W
this_load_per_task = W
max_load = 3W + 2k
busiest_load_per_task = W + 2k / 3
avg_load = 5W / 2 + k
max_pull = W / 2 + k
*imbalance = W / 2 + k

Whenever k < (3W / 2) this will result in *imbalance < 
busiest_load_per_task and we end up in the small imbalance code.

(max_load - this_load) = W + 2k which is greater than 
busiest_load_per_task so we decide that we want to move some load from 
"busiest" to "this".

Without this patch we would set *imbalance to busiest_load_per_task and 
the only task on "busiest" that has a weighted load less than or equal 
to this value is the normal task so this is the one that will be moved 
resulting:

this_load = 3W
this_load_per_task = W
max_load = 2W + 2k
busiest_load_per_task = W + k

Even if you reverse the roles of "busiest" and "this", this will be 
considered balanced and the system will stabilize in this undesirable 
state.  NB, as predicted, the average load per task on "this" hasn't 
changed and the average load per task on "busiest" has increased.  We 
still have the situation where a high priority task is stuck on a run 
queue while a low priority task is running on another CPU -- we've 
failed :-(.

With this patch, *imbalance will be set to (W + 4k / 3) which is bigger 
than the weighted load of the high priority tasks so one of them will be 
moved resulting in:

this_load = 3W + k
this_load_per_task = W + k / 3
max_load = 2W + k
busiest_load_per_task = W + k / 2

> 
>> and whether this_load_per_task will get bigger is 
>> indeterminate.  With this patch there IS a chance that 
>> busiest_load_per_task will decrease and an INCREASED chance that 
>> this_load_per_task will get bigger.  Ergo we have increased the 
>> probability that the (absolute) difference between this_load_per_task 
>> and busiest_load_per_task will decrease.  This is a desirable outcome.
> 
> All I am saying is we are more aggressive.. I don't have any issue with
> the desired outcome..

We need to be more aggressive but not too aggressive and I think this 
patch achieves the required balance.

NB busiest_load_per_task < *imbalance < (max_load - this_load) is true 
for this path through the code.  To be precise, *imbalance will be half 
way between busiest_load_per_task and (max_load - this_load).

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
