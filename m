Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbTCKXGY>; Tue, 11 Mar 2003 18:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261681AbTCKXGY>; Tue, 11 Mar 2003 18:06:24 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:6858 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S261665AbTCKXGS>; Tue, 11 Mar 2003 18:06:18 -0500
Subject: Re: [patch] oprofile for ppc
From: Albert Cahalan <albert@users.sf.net>
To: Andrew Fleming <afleming@motorola.com>
Cc: Segher Boessenkool <segher@koffie.nl>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       o.oppitz@web.de, linux-kernel@vger.kernel.org
In-Reply-To: <FEB94991-540B-11D7-BAD1-000393C30512@motorola.com>
References: <FEB94991-540B-11D7-BAD1-000393C30512@motorola.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 11 Mar 2003 18:13:20 -0500
Message-Id: <1047424400.5972.44.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-11 at 16:54, Andrew Fleming wrote:
> On Monday, Mar 10, 2003, at 20:14 US/Central, Segher Boessenkool wrote:
>> Albert Cahalan wrote:
>>> On Sun, 2003-03-09 at 22:50, Segher Boessenkool wrote:
>>>> Benjamin Herrenschmidt wrote:

>>>>> Beware though that some G4s have a nasty bug that
>>>>> prevents using the performance counter interrupt
>>>>> (and the thermal interrupt as well).
>>>>
>>>> MPC7400 version 1.2 and lower have this problem.
>>>
>>> MPC7410 you mean, right? Are those early revisions
>>> even popular?
>>
>> 7400 and 7410 core versions are identical, afaik.  I don't
>> think any 7410 core lower than version 2.0 was ever used
>> in any consumer machines.  ymmv.
>
> I've been looking into this, and all versions of the 7410
> before 1.3 (where it was fixed) have this errata.  And
> there is no version of the 7410 above 1.4.  Some of the
> machines with 7410s, and all of the machines with 7400s
> have this problem, I believe.  If nothing else, it is a
> security issue if user processes are allowed to configure
> the counters (something that would be nice, in terms of
> useability).

It would be nice if this bug were added to the notes
for the MPC7400 processor, if indeed it is present.

Even without this bug, I suspect oprofile is a major
security hazard. It lets you time things in the kernel.
Just set BAMR (to choose a kernel address) as desired,
and you can follow the jumps taken in crypto code, etc.

>>> I'm wondering if the MPC7400 is also affected.
>>> The MPC7400 has some significant differences.
>>> The pipeline length changed.
>>
>> Between 7400 and 7410?  That's news to me...
>
> There are no significant changes between the 7400
> and 7410 pipelines, the primary difference was the
> process in which it was fabricated.  You are probably
> thinking of the 7450 and its successors--the pipeline 
> changed in that model from 4 to 7 stages (depending
> on how one defines "stage").

That's right. I keep thinking the MPC7410 got the
7-stage pipeline.

There's more than just a process difference though.
The version number is seriously different. It's not
just one bit changing to indicate a different process.
Here I am, with a version 2.9 chip:

cpu             : 7400, altivec supported
temperature     : 35-40 C (uncalibrated)
clock           : 450MHz
revision        : 2.9 (pvr 000c 0209)

>>> So the use of oprofile comes down to a choice:
>>> a. Ignore the problem.
>>>    rare crashes
>>
>> As long as its rare, that's not _too_ big of
>> a problem, really.  Just document it ;)
>
> I suggest a modification of this behavior, which
> I'll describe at the end of this email.
>
>>> b. The decrementer goes much faster for profiling.
>>>    high overhead, awkwardness in non-time measurement
>>
>> Bad idea, I think.
>>
>>> c. The performance monitor is used for clock ticks.
>>>    hard choices about sharing or frequency
>>
>> I'd go for this option.
>
> I don't think either of these are ideal.  On most
> systems the decrementer is used for generating timer
> interrupts used for preemption, and other such fun.
> Messing around with this facility to work around
> errata in the 7400 seems excessive.

I have a 7400. I care deeply about this issue. :-)

If I could get a fanless (like the G4 Cube) system
with a newer processor, I might not care so much.

> And locking down one of the counters to only count
> cycles is undesireable:  you would lose the ability
> to count some events in most implementations of the 
> counters.

Any one of the counters would do; the event can be
moved around as needed. Also note the TBSEL bits in
MMCR0. TBSEL gives another way to get an interrupt,
without giving up any of the counters.

> As I see it, the problem is:
>
> 1) If the decrementer and perfmon interrupts occur
> one after the other while a process is being profiled
> on some 7400/7410 processors, that process's state
> (in terms of where it is in execution) will be lost.
>
> This can be acceptable, since the PMI handler could
> detect such a condition (a return address of 0x900
> would be a good hint), and terminate the offending
> program.  Since nothing is harmed, you just try again.
> As long as this behavior, and its cause, is documented
> (it could even be detected by the module), this should
> be acceptable to people with these processors.

I'd really like to profile the kernel.

> 2)  If the same happens while in the kernel on one
> of those processors, we have a kernel panic.
>
> This is not, I think, acceptable behavior.  Linux
> shouldn't crash.  However, this should only be a
> problem if the counters are on in privileged space.
> If they don't increment when an interrupt occurs,
> they can't cause a PMI.

Pardon me for being a pessimist. I have to imagine
that the counters don't turn off fast enough too.


