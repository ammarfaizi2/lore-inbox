Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVIUWlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVIUWlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 18:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVIUWlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 18:41:12 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:15852
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S965044AbVIUWlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 18:41:11 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com
In-Reply-To: <Pine.LNX.4.61.0509201247190.3743@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509201247190.3743@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 22 Sep 2005 00:41:25 +0200
Message-Id: <1127342485.24044.600.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-09-21 at 21:50 +0200, Roman Zippel wrote:
> First a quick question:
> 
> > This revealed a reasonable explanation for this behaviour. Both 
> > networking and disk I/O arm a lot of timeout timers (the maximum number 
> > of armed timers during the tests observed was ~400000).
> 
> This triggers the obvious question: where are these timers coming from? 
> You don't think that having that much timers in first place is little 
> insane (especially if these are kernel timers)?

Quick answer: Networking and disk I/O. Insane load on a 4 way SMP
machine. Check yourself. :)

FYI. I'm not the only one who observed this.

> Ok, now to the long part:
> 
> > The conclusions of my recent work on Linux time(rs) related problems and 
> > the analysis of related patches are:
> > 
> > 1. The HZ/jiffy based usage of time in the kernel code has to be
> >    converted to human time units.
> > 
> > 2. A clean seperation of all related APIs and subsystems is necessary 
> >    even if they have interdependencies and shared functionality
> 
> How you get to these conclusions is still rather unclear, I don't even 
> really know what the problem is from just reading the pretext. You talk 
> about previous efforts, you talk about users abusing the timer system, but 
> what is actually the problem of the timer system itself?

Actually there are several problems in the timer system:

1. HZ/jiffie boundness in the current implementation is problematic vs.
the conversion of human time units, which is the way programmers think
and the way time values are defined in data sheets, to HZ/jiffies. There
are dozens of places which get this completely wrong - either due to the
missunderstanding or dumbness of programmers or due to the fact that HZ
is not longer =100 and nobody cared to change that affected piece of
code. Using human time units in the API solves this in a clear way.
There is no problem to have conversion functions which convert those to
jiffies/HZ or whatever internal representation during compile or if
necessary run time, but relying on non constant units of time in an API
is utterly wrong and error prone.


2. The all in one solution for "timeouts" and "timers".

I think I made this point rather clear, but nevertheless:

Timeouts are coarse grained functions to catch error conditions. The
vast majority of those never expire. The implementation emphasis is fast
insertion/removal.

Timers are (possibly/desirably) fine grained functions to control
program flow in a time ordered way. The vast majority of those  expire.
The implementation emphasis is time accuracy. Don't confuse accuracy
with high resolution! 

Intermingling those types (1.) /(2.) leads to an obvious conflict in
interests and to restrictions of extensibility / flexibility especially
when (3.) applies.

3. There _are_ provable abuses of the current timer ("timeout") system.
Functions which run longer than the next timer tick have to be
considered insane. I just pointed this out for reference and I sent a
note to the subsystem maintainer(s) to make them aware of that before
writing this. If you read the writeup without being biased in front you
might notice that there are explicit examples of those insane abuses of
timers. If you consider those as legitimate we can stop the discussion
right now. I also pointed out that the HZ=1000->HZ=250 change just hides
this rather than solving the underlying problem.

> Later it becomes clear that you want high resolution timers, what doesn't 
> become clear is why it's such an essential feature that everyone has to 
> pay the price for it (this does not only include changes in runtime 
> behaviour, but also the proposed API changes).

1. Yes, the final goal are high resolution timers. I never denied that.

2. The integration of high resolution timers is a long standing issue,
which was rejected mostly due to the intrusiveness of the proposed
patches.

3. ktimers itself are designed to be aware of a possible extension for
HRT, but they provide a benefit without high resolution timers and
nobody has to pay a price for them when they are not
configured/implemented. The removal of the abstime list reprogramming in
posix-timers.c is definitely a worthwhile cleanup and totaly unrelated
to HRT.

> What is seriously missing here is the big picture. First off how does it 
> currently look like? Y

Point taken. The writeup was intended for people who are familiar with
the current situation.

> You rather shortly mention scheduler ticks and your 
> analysis basically says only that it's "a bunch of ugliness". 

Wrong. I did not say there is a "bunch of ugliness" in general. Even not
between the lines. Period. 

The only places where "ugl*" is used in the whole writeup are:
"ticks introduce a bunch of ugliness especially when it comes to time
synchronizing with high resolution time 
sources."

"The combination of both patches provides the grounds and leads the way
to the cleanup of the timeout API and the implementation of
dyntick/tickless support without introducing additional ugliness."

I'm sure that both assertions are true, especially in the context they
were made.

Roman, please keep this at a serious level. I dont have the intention to
participate on another "UFT-8, Reiser4, sizeof(*p)" lkml debate club.

> There is no mention why they are needed in first place and there is no real 
> explanation why they are such a big problem for hich resolution timers.

Maybe above does shed more light on it ?

> Second, an API cleanup is all nice, but the more interesting part is still 
> what is behind this API and this part you pretty much leave in the dark. 

Whats in the dark ?

> Basically how does the new big picture look like and how do high 
> resolution timer fit into it? (You are more busy defending the 64bit math, 
> than actually explaining why and where it's needed in the first place.)

I also explained why I wanted to seperate "timeout" and "timers" APIs. I
explained why I choose rbtree and I explained why I used 64bit math and
at least why 64 bit math is not that evil as commonly seen. 

There is also code and if you need more details, call my sales
departent....

> Sorry, if this sounds harsh, but your announcement is more a random 
> collection of information about timers than an explanation of why ktimers 
> are desirable.

First of all, this is volunteer work and I _did_ take the time to write
up a detailed explanation at all rather than throwing a random patch
with a 10 line bla into the arena. Do you expect that I write a PhD
thesis on that ?

Second this writeup was not targeted for John User. ....

>  I'm not against high resolution timers per se, but this 
> doesn't explain why it has to be high resolution all the way. 

Where is high resolution all the way. Care to read the patch ? It's high
resolution aware and it does take out odd areas of code by design.

> It also doesn't explain how it will interact with Johns work,

"The following add on patches are not provided for ad hoc inclusion as
they contain third party patches. The reason for providing this series
is to demonstrate the future use of ktimers and the simple extensibility
for the impelemtation of high resolution timers. Especially John Stultz
timeofday patch is a complete seperate issue
and just used due to the ability to provide high resolution timers in a
simple and non intrusive way."

Isn't this clear enough ?

>  e.g. I'm only scared 
> if I see this in the ktimer_hres patch:
> 
> +extern int arch_hrtimer_init(int highres);
> +extern int arch_hrtimer_reprogram(nsec_t expires);
> +extern void arch_hrtimer_trigger_ints(void);

Whats scary ? This is proof of concept. See above !

Have you a simpler solution and did you care to read the comment in
arch/i386/kernel/hrtimer.c ?

> Ok, so what's missing? From a basic design overview I would expect some 
> information about types of time within the kernel and their relationship. 
> We basically have three types:
> - scheduler time
> - wallclock time
> - process time

What about monotonic time ?

> The scheduler time (aka jiffies) is not just used for timeouts, it's the 
> basic time unit to schedule cpu time. It's major requirement is simplicity 
> - a 32bit value can always be read without locking and calculations based 
> on it are simple.
> I exclude posix clocks here as it can be used with both wallclock and 
> process time. 

What about monotonic time ?

> The main difference between them is that the latter is user 
> programmable. 

wallclock is reprogrammable too and it introduces a bunch of horrible
functions in posix-timers.c. grep for abs_list. I explained why its
horrible already.

> Here we get to the core problem of timer ticks: the current 
> timer system is designed around a simple timer model, which is not 
> reprogrammable, so the timer resolution available to user space is 
> limited to the timer tick resolution.
> 
> Johns patches now introduce two major new concepts as a generic mechanism 
> (and not just hidden somewhere in arch code): 1) a timer source 
> abstraction, 2) making wallclock updates independent of the timer tick. 

1. I'm well aware of the addressed problems in Johns patches.

2.I dont see any hidden arch code in the ktimers patch. Do you ?

fs/exec.c                    |    9
 fs/proc/array.c              |    6
 include/asm-generic/div64.h  |   18
 include/linux/ktimer.h       |  142 +++++++
 include/linux/posix-timers.h |   87 ++--
 include/linux/sched.h        |    4
 include/linux/time.h         |   65 ++-
 include/linux/timer.h        |    2
 init/main.c                  |    1
 kernel/Makefile              |    3
 kernel/exit.c                |    2
 kernel/fork.c                |    5
 kernel/itimer.c              |   83 +---
 kernel/ktimers.c             |  826 ++++++++++++++++++++++++++++++++++++++++++
 kernel/posix-cpu-timers.c    |   23 -
 kernel/posix-timers.c        |  832 ++++++++-----------------------------------
 kernel/timer.c               |   59 ---


May I politely remind you, that I provided the complete patch series
just to show the future use and clearly stated that it is just a proof
of concept implemetation on top of ktimers.

> BTW here you completely miss the "main point of criticizm", the 64bit math 
> is a problem, but the main problem is that he completely changed the NTP 
> kernel model. I don't deny that the NTP code could use some updates 
> itself, but that's a completely separate problem. Regarding the timer 
> system it's only important how to synchronize NTP time with the kernel 
> wallclock time, as soon as you get that right, the whole 64bit math 
> problematic becomes irrelevant.

Roman, what are you trying to achieve ? Finding a playground for
rabulistic discussions ?

> The existence of the timer source abstraction is a major requirement for 
> further improvements (in this regard it's already suspicious, that you put 
> major changes before Johns patch). 

Whats suspicious on that ? Seperating the "timeout" API and the "timer"
API has nothing to do with Johns patches.

> The next major change would be to add the possibility to reprogram a 
> timer source, the scheduler can use this to 
> skip timer ticks and e.g. itimer can offer higher resolution timers. The 
> main point here is before we get to any API decisions, we need to develop 
> a model how a single time source can drive multiple users. Your split 
> between user timers and kernel timeouts leaves this question completely 
> open.

Did I claim, that ktimers solve this problem?

No. 

The patches are related but address different aspects of the overall
problem without conflicting with each other. Quite the contrary: they
complement each other.

I clearly stated that the reprogramming of timer events, which are not
addressed by ktimers and I never claimed ktimers does, is a completely
different problem.

> The next step (_after_ reprogrammable timer sources) would be increasing 
> the timer resolution.

Please let me correct you here. Adding reprogrammable timer events
before you have the core timer system ready is wrong by design.
Providing reprogrammable timer events is simple, but when the timer core
system which depends on timer events is not ready for that you implement
useless things and implement likely stuff which is not matching the
requirements of the generic system.

>  Here I'm not at all convinced, that we need to 
> change everything to nanosecond resolution, we can easily make this a 
> config option which either ties process time resolution to scheduler time 
> or makes it independent. The first would make process time a 32bit ms 
> value (basically current behaviour), the latter can make it to a 64bit ns 
> value. Anyone trying to introduce nsec_t in common code really needs to 
> come up with some better arguments why calculations in ns are necessary 
> unconditionally, instead of making the resolution configurable.

Please provide a whatever time unit based and configurable / flexible
solution for that instead of making unprovable claims !

> In summary please provide a larger picture for your changes, it's 
> especially important to desribe the relationship between the various 
> systems. The API definition is only the last step and is derived from 
> these relationships.

Sorry. When you are not able to get the larger picture in your mind, I
doubt that you are the right person to discuss this topic. This kind of
argument is not working with me, especially not when repeated all over
the place. 

Please provide an alternative solution (i.e. code to review) yourself.

tglx



