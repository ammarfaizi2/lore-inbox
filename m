Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUJEIIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUJEIIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 04:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268959AbUJEIIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 04:08:19 -0400
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:29393 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S268955AbUJEIID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 04:08:03 -0400
Message-ID: <4162565F.60007@bigpond.net.au>
Date: Tue, 05 Oct 2004 18:07:59 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in sched.c:task_hot()
References: <200410050237.i952bx620740@unix-os.sc.intel.com> <41624E42.8030105@bigpond.net.au> <416250F0.5010008@yahoo.com.au>
In-Reply-To: <416250F0.5010008@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Peter Williams wrote:
> 
>> Chen, Kenneth W wrote:
>>
>>> Current implementation of task_hot() has a performance bug in it
>>> that it will cause integer underflow.
>>>
>>> Variable "now" (typically passed in as rq->timestamp_last_tick)
>>> and p->timestamp are all defined as unsigned long long.  However,
>>> If former is smaller than the latter, integer under flow occurs
>>> which make the result of subtraction a huge positive number. Then
>>> it is compared to sd->cache_hot_time and it will wrongly identify
>>> a cache hot task as cache cold.
>>>
>>> This bug causes large amount of incorrect process migration across
>>> cpus (at stunning 10,000 per second) and we lost cache affinity very
>>> quickly and almost took double digit performance regression on a db
>>> transaction processing workload.  Patch to fix the bug.  Diff'ed against
>>> 2.6.9-rc3.
>>>
>>> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
>>>
>>>
>>> --- linux-2.6.9-rc3/kernel/sched.c.orig    2004-10-04 
>>> 19:11:21.000000000 -0700
>>> +++ linux-2.6.9-rc3/kernel/sched.c    2004-10-04 19:19:27.000000000 
>>> -0700
>>> @@ -180,7 +180,8 @@ static unsigned int task_timeslice(task_
>>>      else
>>>          return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
>>>  }
>>> -#define task_hot(p, now, sd) ((now) - (p)->timestamp < 
>>> (sd)->cache_hot_time)
>>> +#define task_hot(p, now, sd) ((long long) ((now) - (p)->timestamp)    \
>>> +                < (long long) (sd)->cache_hot_time)
>>>
>>>  enum idle_type
>>>  {
>>
>>
>>
>> The interesting question is: How does now get to be less than 
>> timestamp?  This probably means that timestamp_last_tick is not a good 
>> way of getting a value for "now".
> 
> 
> It is the best we can do.

You could use sched_clock() which will do better.  The setting of 
timestamp in schedule() gives you a pretty good chance that it's value 
will be greater than timestamp_last_tick.

> 
>>  By the way, neither is sched_clock() when measuring small time 
>> differences as it is not monotonic (something that I had to allow for 
>> in my scheduling code).
> 
> 
> I'm pretty sure it is monotonic, actually. I know some CPUs can execute
> rdtsc speculatively, but I don't think it would ever be sane to execute
> two rdtsc's in the wrong order.

I have experienced it going backwards and I assumed that it was due to 
the timing code applying corrections.  (You've got two choices if your 
clock is running fast: one is to mark time until the real world catches 
up with you and the other is to set your clock back to the correct time 
when you notice a discrepancy.  I assumed that the second strategy had 
been followed by the time code and didn't bother checking further 
because it was an easy problem to sidestep.) Admittedly, this behaviour 
was only observed when measuring very short times such as the time spent 
on the runqueue waiting for CPU access when the system was idle BUT it 
was definitely occurring.  And it only occurred on a system where the 
lower bits of the values returned by sched_clock() were not zero i.e. a 
reasonably modern one.  It was observed on a single CPU machine as well 
and was not, therefore, a result of drift between CPUs.

> 
>>  I applied no such safeguards to the timing used by the load balancing 
>> code as I assumed that it already worked.
> 
> 
> It should (modulo this bug).

I'm reasonably confident that ZAPHOD doesn't change the values of 
timestamp or timestamp_last_tick to something that they would not have 
been without ZAPHOD and there are other scheduler changes (than 
ZAPHOD's) in -mm2 which may bear examination.

ZAPHOD also did not introduce the declaration of these values as 
unsigned long long as that is present in rc3.  BTW a quick to the 
problem is to change their declarations to just long long as we don't 
need the 64th bit for a few hundred years.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
