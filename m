Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261626AbTCKVoN>; Tue, 11 Mar 2003 16:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbTCKVoN>; Tue, 11 Mar 2003 16:44:13 -0500
Received: from ftpbox.mot.com ([129.188.136.101]:46746 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id <S261626AbTCKVoI>;
	Tue, 11 Mar 2003 16:44:08 -0500
Date: Tue, 11 Mar 2003 15:54:12 -0600
Subject: Re: [patch] oprofile for ppc
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v551)
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       <oprofile-list@lists.sourceforge.net>,
       <linuxppc-dev@lists.linuxppc.org>, <o.oppitz@web.de>,
       <linux-kernel@vger.kernel.org>
To: Segher Boessenkool <segher@koffie.nl>
From: Andrew Fleming <afleming@motorola.com>
In-Reply-To: <3E6D469C.8060209@koffie.nl>
Message-Id: <FEB94991-540B-11D7-BAD1-000393C30512@motorola.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday, Mar 10, 2003, at 20:14 US/Central, Segher Boessenkool wrote:

> Albert Cahalan wrote:
>> On Sun, 2003-03-09 at 22:50, Segher Boessenkool wrote:
>>> Benjamin Herrenschmidt wrote:
>>>> Beware though that some G4s have a nasty bug that
>>>> prevents using the performance counter interrupt
>>>> (and the thermal interrupt as well).
>>>
>>> MPC7400 version 1.2 and lower have this problem.
>> MPC7410 you mean, right? Are those early revisions
>> even popular?
>
> 7400 and 7410 core versions are identical, afaik.  I don't
> think any 7410 core lower than version 2.0 was ever used
> in any consumer machines.  ymmv.

I've been looking into this, and all versions of the 7410 before 1.3 
(where it was fixed) have this errata.  And there is no version of the 
7410 above 1.4.  Some of the machines with 7410s, and all of the 
machines with 7400s have this problem, I believe.  If nothing else, it 
is a security issue if user processes are allowed to configure the 
counters (something that would be nice, in terms of useability).

>
>> I'm wondering if the MPC7400 is also affected.
>> The MPC7400 has some significant differences.
>> The pipeline length changed.
>
> Between 7400 and 7410?  That's news to me...

There are no significant changes between the 7400 and 7410 pipelines, 
the primary difference was the process in which it was fabricated.  You 
are probably thinking of the 7450 and its successors--the pipeline 
changed in that model from 4 to 7 stages (depending on how one defines 
"stage").

>
>>>> The problem is that if any of those fall at the same
>>>> time as the DEC interrupt, the CPU messes up it's
>>>> internal state and you lose SRR0/SRR1, which means
>>>> you can't recover from the exception.
>>>
>>> But the worst that happens is that you lose that
>>> process, isn't it?  Not all that big a problem,
>>> esp. since the window in which this can happen is
>>> very small.
>> I think you'd get an infinite loop of either
>> the decrementer or performance monitor. That's
>> mostly fixable by checking for the condition and
>> killing the affected process, but that process
>> could be one of the ones built into the kernel.
>
> That would be a problem, yes :-(
>
>> So the use of oprofile comes down to a choice:
>> a. Ignore the problem.
>>    rare crashes
>
> As long as its rare, that's not _too_ big of a problem,
> really.  Just document it ;)

I suggest a modification of this behavior, which I'll describe at the 
end of this email.

>
>> b. The decrementer goes much faster for profiling.
>>    high overhead, awkwardness in non-time measurement
>
> Bad idea, I think.
>
>> c. The performance monitor is used for clock ticks.
>>    hard choices about sharing or frequency
>
> I'd go for this option.

I don't think either of these are ideal.  On most systems the 
decrementer is used for generating timer interrupts used for 
preemption, and other such fun.  Messing around with this facility to 
work around errata in the 7400 seems excessive.  And locking down one 
of the counters to only count cycles is undesireable:  you would lose 
the ability to count some events in most implementations of the 
counters.  As time goes on, the number of people wanting to tune 
performance on 300-500MHz 7400/7410 processors will dwindle, but the 
complications created by this workaround would haunt us forever.

As I see it, the problem is:
1) If the decrementer and perfmon interrupts occur one after the other 
while a process is being profiled on some 7400/7410 processors, that 
process's state (in terms of where it is in execution) will be lost.

This can be acceptable, since the PMI handler could detect such a 
condition (a return address of 0x900 would be a good hint), and 
terminate the offending program.  Since nothing is harmed, you just try 
again.  As long as this behavior, and its cause, is documented (it 
could even be detected by the module), this should be acceptable to 
people with these processors.

2)  If the same happens while in the kernel on one of those processors, 
we have a kernel panic.

This is not, I think, acceptable behavior.  Linux shouldn't crash.  
However, this should only be a problem if the counters are on in 
privileged space.  If they don't increment when an interrupt occurs, 
they can't cause a PMI.  So the solution would be to disallow profiling 
the kernel.  However, some people want to profile the kernel, and those 
processors should not be left out, if possible.  What we can do, 
though, is use timer based profiling for the kernel for only those 
processors.  The processors should be easy to detect.  We just need to 
make sure not to enable the PMI in the one condition (kernel is being 
profiled one 7400/7410 processors before 7410 version 1.3).

Any thoughts on this solution?



Andy Fleming

PowerPC Software Enablement
Motorola, Inc

Note that my opinions are not Motorola's, even the good ones!

