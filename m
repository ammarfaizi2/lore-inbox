Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268966AbUJEKEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbUJEKEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 06:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbUJEKEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 06:04:05 -0400
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:20175 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S268947AbUJEKDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 06:03:20 -0400
Message-ID: <41627163.5020602@bigpond.net.au>
Date: Tue, 05 Oct 2004 20:03:15 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in sched.c:task_hot()
References: <200410050237.i952bx620740@unix-os.sc.intel.com> <41624E42.8030105@bigpond.net.au> <416250F0.5010008@yahoo.com.au> <4162565F.60007@bigpond.net.au> <41625E8D.2070101@yahoo.com.au>
In-Reply-To: <41625E8D.2070101@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Peter Williams wrote:
> 
>> Nick Piggin wrote:
>>
>>> Peter Williams wrote:
>>>
>>>>
>>>> The interesting question is: How does now get to be less than 
>>>> timestamp?  This probably means that timestamp_last_tick is not a 
>>>> good way of getting a value for "now".
>>>
>>>
>>>
>>>
>>> It is the best we can do.
>>
>>
>>
>> You could use sched_clock() which will do better.  The setting of 
>> timestamp in schedule() gives you a pretty good chance that it's value 
>> will be greater than timestamp_last_tick.
>>
> 
> sched_clock is not guaranteed to be synchronised across CPUs though.
> It may be completely different. So even if you did use sched_clock,
> you'd still have to apply the timestamp_last_tick adjustment.

I assumed that was why all the "timestamp correction on changing CPU" 
code was added recently.

> 
> Considering that we really don't need sched_clock resolution here,
> it just isn't needed.
> 
> Kenneth's overflow fix is definitely required though, even if you
> were to use sched_clock.

Yes.  Or, if the accuracy is sufficient, you could just use 
timestamp_last_tick to set timestamp which would save the cost of 
calling sched_clock() for that purpose.

> 
>>>
>>>>  By the way, neither is sched_clock() when measuring small time 
>>>> differences as it is not monotonic (something that I had to allow 
>>>> for in my scheduling code).
>>>
>>>
>>>
>>>
>>> I'm pretty sure it is monotonic, actually. I know some CPUs can execute
>>> rdtsc speculatively, but I don't think it would ever be sane to execute
>>> two rdtsc's in the wrong order.
>>
>>
> 
> Hmm, there may be some jitter when waking a process from a remote
> CPU - because in that case, we do have to apply the timestamp_last_tick
> correction.
> 
>>
>> I have experienced it going backwards and I assumed that it was due to 
>> the timing code applying corrections.  (You've got two choices if your 
>> clock is running fast: one is to mark time until the real world 
>> catches up with you and the other is to set your clock back to the 
>> correct time when you notice a discrepancy.  I assumed that the second 
>> strategy had been followed by the time code and didn't bother checking 
>> further because it was an easy problem to sidestep.) Admittedly, this 
>> behaviour 
> 
> 
> We don't really care what real time is doing here, just so long as the
> numbers returned are roughly the same for everyone (all processes).

I agree which is why I didn't chase it.  As far as I'm concerned when 
sched_clock() appears to go backwards the time interval that I'm 
measuring is so small that using zero is close enough.

> 
>> was only observed when measuring very short times such as the time 
>> spent on the runqueue waiting for CPU access when the system was idle 
>> BUT it was definitely occurring.  And it only occurred on a system 
>> where the lower bits of the values returned by sched_clock() were not 
>> zero i.e. a reasonably modern one.  It was observed on a single CPU 
>> machine as well and was not, therefore, a result of drift between CPUs.
> 
> 
> I don't see how this could happen on a single CPU system. I can
> believe you saw it though.

When I suspected it as the source of a problem that I was experiencing I 
put some test code in to detect it.  The time between occurrences was of 
the order of hours and only happened when the interval was very small.

As I said, I assumed that it was due to "corrections" but didn't bother 
chasing it as it only happened when the time intervals were very small 
and using zero when it occurred was adequate for my purposes.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
