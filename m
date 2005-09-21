Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVIUTvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVIUTvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVIUTvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:51:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:47535 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932163AbVIUTu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:50:58 -0400
Date: Wed, 21 Sep 2005 21:50:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: tglx@linutronix.de
cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0509201247190.3743@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Sep 2005 tglx@linutronix.de wrote:

First a quick question:

> This revealed a reasonable explanation for this behaviour. Both 
> networking and disk I/O arm a lot of timeout timers (the maximum number 
> of armed timers during the tests observed was ~400000).

This triggers the obvious question: where are these timers coming from? 
You don't think that having that much timers in first place is little 
insane (especially if these are kernel timers)?

Ok, now to the long part:

> The conclusions of my recent work on Linux time(rs) related problems and 
> the analysis of related patches are:
> 
> 1. The HZ/jiffy based usage of time in the kernel code has to be
>    converted to human time units.
> 
> 2. A clean seperation of all related APIs and subsystems is necessary 
>    even if they have interdependencies and shared functionality

How you get to these conclusions is still rather unclear, I don't even 
really know what the problem is from just reading the pretext. You talk 
about previous efforts, you talk about users abusing the timer system, but 
what is actually the problem of the timer system itself?

Later it becomes clear that you want high resolution timers, what doesn't 
become clear is why it's such an essential feature that everyone has to 
pay the price for it (this does not only include changes in runtime 
behaviour, but also the proposed API changes).

What is seriously missing here is the big picture. First off how does it 
currently look like? You rather shortly mention scheduler ticks and your 
analysis basically says only that it's "a bunch of ugliness". There is no 
mention why they are needed in first place and there is no real 
explanation why they are such a big problem for high resolution timers.

Second, an API cleanup is all nice, but the more interesting part is still 
what is behind this API and this part you pretty much leave in the dark. 
Basically how does the new big picture look like and how do high 
resolution timer fit into it? (You are more busy defending the 64bit math, 
than actually explaining why and where it's needed in the first place.)

Sorry, if this sounds harsh, but your announcement is more a random 
collection of information about timers than an explanation of why ktimers 
are desirable. I'm not against high resolution timers per se, but this 
doesn't explain why it has to be high resolution all the way. It also 
doesn't explain how it will interact with Johns work, e.g. I'm only scared 
if I see this in the ktimer_hres patch:

+extern int arch_hrtimer_init(int highres);
+extern int arch_hrtimer_reprogram(nsec_t expires);
+extern void arch_hrtimer_trigger_ints(void);


Ok, so what's missing? From a basic design overview I would expect some 
information about types of time within the kernel and their relationship. 
We basically have three types:
- scheduler time
- wallclock time
- process time

The scheduler time (aka jiffies) is not just used for timeouts, it's the 
basic time unit to schedule cpu time. It's major requirement is simplicity 
- a 32bit value can always be read without locking and calculations based 
on it are simple.
I exclude posix clocks here as it can be used with both wallclock and 
process time. The main difference between them is that the latter is user 
programmable. Here we get to the core problem of timer ticks: the current 
timer system is designed around a simple timer model, which is not 
reprogrammable, so the timer resolution available to user space is 
limited to the timer tick resolution.

Johns patches now introduce two major new concepts as a generic mechanism 
(and not just hidden somewhere in arch code): 1) a timer source 
abstraction, 2) making wallclock updates independent of the timer tick. 
BTW here you completely miss the "main point of criticizm", the 64bit math 
is a problem, but the main problem is that he completely changed the NTP 
kernel model. I don't deny that the NTP code could use some updates 
itself, but that's a completely separate problem. Regarding the timer 
system it's only important how to synchronize NTP time with the kernel 
wallclock time, as soon as you get that right, the whole 64bit math 
problematic becomes irrelevant.

The existence of the timer source abstraction is a major requirement for 
further improvements (in this regard it's already suspicious, that you put 
major changes before Johns patch). The next major change would be to add 
the possibility to reprogram a timer source, the scheduler can use this to 
skip timer ticks and e.g. itimer can offer higher resolution timers. The 
main point here is before we get to any API decisions, we need to develop 
a model how a single time source can drive multiple users. Your split 
between user timers and kernel timeouts leaves this question completely 
open.

The next step (_after_ reprogrammable timer sources) would be increasing 
the timer resolution. Here I'm not at all convinced, that we need to 
change everything to nanosecond resolution, we can easily make this a 
config option which either ties process time resolution to scheduler time 
or makes it independent. The first would make process time a 32bit ms 
value (basically current behaviour), the latter can make it to a 64bit ns 
value. Anyone trying to introduce nsec_t in common code really needs to 
come up with some better arguments why calculations in ns are necessary 
unconditionally, instead of making the resolution configurable.

In summary please provide a larger picture for your changes, it's 
especially important to desribe the relationship between the various 
systems. The API definition is only the last step and is derived from 
these relationships.

bye, Roman
