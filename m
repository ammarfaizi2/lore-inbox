Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268878AbUJEInE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268878AbUJEInE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 04:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268890AbUJEInD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 04:43:03 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:28571 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268878AbUJEIm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 04:42:58 -0400
Message-ID: <41625E8D.2070101@yahoo.com.au>
Date: Tue, 05 Oct 2004 18:42:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in sched.c:task_hot()
References: <200410050237.i952bx620740@unix-os.sc.intel.com> <41624E42.8030105@bigpond.net.au> <416250F0.5010008@yahoo.com.au> <4162565F.60007@bigpond.net.au>
In-Reply-To: <4162565F.60007@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Nick Piggin wrote:
> 
>> Peter Williams wrote:
>>
>>>
>>> The interesting question is: How does now get to be less than 
>>> timestamp?  This probably means that timestamp_last_tick is not a 
>>> good way of getting a value for "now".
>>
>>
>>
>> It is the best we can do.
> 
> 
> You could use sched_clock() which will do better.  The setting of 
> timestamp in schedule() gives you a pretty good chance that it's value 
> will be greater than timestamp_last_tick.
> 

sched_clock is not guaranteed to be synchronised across CPUs though.
It may be completely different. So even if you did use sched_clock,
you'd still have to apply the timestamp_last_tick adjustment.

Considering that we really don't need sched_clock resolution here,
it just isn't needed.

Kenneth's overflow fix is definitely required though, even if you
were to use sched_clock.

>>
>>>  By the way, neither is sched_clock() when measuring small time 
>>> differences as it is not monotonic (something that I had to allow for 
>>> in my scheduling code).
>>
>>
>>
>> I'm pretty sure it is monotonic, actually. I know some CPUs can execute
>> rdtsc speculatively, but I don't think it would ever be sane to execute
>> two rdtsc's in the wrong order.
> 

Hmm, there may be some jitter when waking a process from a remote
CPU - because in that case, we do have to apply the timestamp_last_tick
correction.

> 
> I have experienced it going backwards and I assumed that it was due to 
> the timing code applying corrections.  (You've got two choices if your 
> clock is running fast: one is to mark time until the real world catches 
> up with you and the other is to set your clock back to the correct time 
> when you notice a discrepancy.  I assumed that the second strategy had 
> been followed by the time code and didn't bother checking further 
> because it was an easy problem to sidestep.) Admittedly, this behaviour 

We don't really care what real time is doing here, just so long as the
numbers returned are roughly the same for everyone (all processes).

> was only observed when measuring very short times such as the time spent 
> on the runqueue waiting for CPU access when the system was idle BUT it 
> was definitely occurring.  And it only occurred on a system where the 
> lower bits of the values returned by sched_clock() were not zero i.e. a 
> reasonably modern one.  It was observed on a single CPU machine as well 
> and was not, therefore, a result of drift between CPUs.

I don't see how this could happen on a single CPU system. I can
believe you saw it though.
