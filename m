Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWDLXNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWDLXNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 19:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDLXNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 19:13:20 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:30575 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932393AbWDLXNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 19:13:19 -0400
Message-ID: <443D898C.5080806@bigpond.net.au>
Date: Thu, 13 Apr 2006 09:13:16 +1000
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
References: <4439FF0C.8030407@bigpond.net.au> <20060410181237.A26977@unix-os.sc.intel.com> <443C3FD8.2060906@bigpond.net.au> <20060411185709.A2401@unix-os.sc.intel.com> <443C8AEC.9010309@bigpond.net.au> <20060412095534.A7293@unix-os.sc.intel.com>
In-Reply-To: <20060412095534.A7293@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 12 Apr 2006 23:13:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Wed, Apr 12, 2006 at 03:06:52PM +1000, Peter Williams wrote:
>> Siddha, Suresh B wrote:
>>> Is there an example for this?
>> Yes, we just take a slight variation of your scenario that prompted the 
>> first patch (to which this patch is a minor modification) by adding one 
>> normal priority task to each of the CPUs.  This gives us a 2 CPU system 
>> with CPU-0 having 2 high priority tasks plus 1 normal priority task and 
>> CPU-1 having two normal priority tasks.  Clearly, the desirable load 
>> balancing outcome would be for the two high priority tasks to be on 
>> different CPUs otherwise we have a high priority task stuck on a run 
>> queue while a normal priority is running on another (less heavily 
>> loaded) CPU.
>>
>> In order to analyze what happens during load balancing, let's use W as 
>> the load weight for a normal task and suppose that the load weights of 
>> the two high priority tasks are (W + k) and that "this" == CPU-1 in 
>> find_busiest_queue().  This will result in "busiest" == CPU-0 and:
>>
>> this_load = 2W
>> this_load_per_task = W
>> max_load = 3W + 2k
>> busiest_load_per_task = W + 2k / 3
>> avg_load = 5W / 2 + k
>> max_pull = W / 2 + k
>> *imbalance = W / 2 + k
>>
>> Whenever k < (3W / 2) this will result in *imbalance < 
>> busiest_load_per_task and we end up in the small imbalance code.
>>
>> (max_load - this_load) = W + 2k which is greater than 
>> busiest_load_per_task so we decide that we want to move some load from 
>> "busiest" to "this".
>>
>> Without this patch we would set *imbalance to busiest_load_per_task and 
>> the only task on "busiest" that has a weighted load less than or equal 
>> to this value is the normal task so this is the one that will be moved 
>> resulting:
>>
>> this_load = 3W
>> this_load_per_task = W
>> max_load = 2W + 2k
>> busiest_load_per_task = W + k
>>
>> Even if you reverse the roles of "busiest" and "this", this will be 
>> considered balanced and the system will stabilize in this undesirable 
>> state.  NB, as predicted, the average load per task on "this" hasn't 
>> changed and the average load per task on "busiest" has increased.  We 
>> still have the situation where a high priority task is stuck on a run 
>> queue while a low priority task is running on another CPU -- we've 
>> failed :-(.
> 
> for such a 'k' value, we fail anyhow. For example, how does the normal
> load balance detect an imbalance in this below situation?
> 
> this_load = 3W
> this_load_per_task = W
> max_load = 2W + 2k
> busiest_load_per_task = W + k

Yes, it's hard to get out of such a situation if you get into one so 
that's why changes to try_to_wake_up() may be needed.  We certainly have 
to stop the load balancing code from creating these situations as well.

> 
> if we really want to distribute 'N' higher priority tasks(however small or
> big is the priority difference between low and high priority tasks) on to 
> 'N' different cpus, we will need really different approach for load 
> balancing..

Yes, I've said similar in another thread but I agreed with Ingo when he 
said that this wasn't really a problem for the load balancer to solve. 
I expressed the same opinion as above, namely that this problem needs to 
be addressed in try_to_wake_up() (which isn't really load balancing) and 
suggested that (for high priority tasks) try_to_wake_up() should be 
modified to find either an idle CPU or (if it can't find an idle one) 
the CPU with the lowest priority current task.

However, it should be noted that Ingo is working on something for 
ensuring the distribution of RT tasks across CPUs and this is likely to 
overlap with this idea so consultation is necessary.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
