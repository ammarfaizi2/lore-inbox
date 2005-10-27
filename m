Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVJ0UYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVJ0UYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVJ0UYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:24:41 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21134 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932217AbVJ0UYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:24:40 -0400
Date: Thu, 27 Oct 2005 22:23:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: George Anzinger <george@mvista.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <435BD3C2.9070705@mvista.com>
Message-ID: <Pine.LNX.4.61.0510250114100.1386@scrub.home>
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0510100213480.3728@scrub.home>  <1129016558.1728.285.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
  <Pine.LNX.4.61.0510150143500.1386@scrub.home>  <1129490809.1728.874.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510170021050.1386@scrub.home>  <20051017075917.GA4827@elte.hu>
  <Pine.LNX.4.61.0510171054430.1386@scrub.home>  <20051017094153.GA9091@elte.hu>
 <20051017025657.0d2d09cc.akpm@osdl.org>  <Pine.LNX.4.61.0510171511010.1386@scrub.home>
 <1129582512.19559.136.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510180032420.1386@scrub.home> <435449DC.8070109@mvista.com>
 <Pine.LNX.4.61.0510181823560.1386@scrub.home> <4355B4EB.2080307@mvista.com>
 <Pine.LNX.4.61.0510211326400.1386@scrub.home> <435BD3C2.9070705@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 23 Oct 2005, George Anzinger wrote:

> > > > Above says IOW if we have a clock with a frequency f and a resolution with
> > > > r=10^9/f, we have to round time t up so that it becomes a integer multiple i
> > > > of r, so that once the counter reaches the value i all timer with up to a
> > > > time value of i*r are expired.
> >
> >
> > You don't specifically disagree, so I can assume you agree that this a valid
> > interpretation of the spec?
> > (I'm asking because it's important for the design of the timer system.)
>
> I agree with the proviso that we can define such a clock as an abstraction of
> a clock with a better resolution.  I.e. we can provide clocks with lesser
> resolution than the physical clock has.

I had a different aspect in mind: at what resolution are we doing the 
calculations?
Let's say we have a clock with a frequency of 300Hz, now we could programm 
the timer like this:

	tmp = time * 300;
	clock = tmp / 10^9 + (tmp % 10^9 != 0);

This rounds the time to the next clock count and as soon as the clock 
reaches this count the timer is expired.
OTOH We could also do this at the timer interrupt:

	tmp = clock * 10^9;
	time = tmp / 300 + (tmp % 300 != 0);

and use time to expire all timer upto this time. In either case the 
behaviour is exactly the same.

The problem is now that we can export the real resolution only as integer 
value. What consequences has this to the kernel timer implementation? 
Something like above must be done anyway, so what's the point in doing an 
extra rounding step?
For example if we set a timer to expire at 999999990ns, so the next 
interrupt is at 1000000000ns, but rounding it to 3333333ns means the 
expiry time changes to 1003333233ns and the timer expires one clock tick 
later.
Which application seriously expects this kind of behaviour?

> I admit I have not looked, in detail, at this part of ktimers, however,
> assuming that the clock ticks at HZ then the normal error to be expected is
> and average of 1/2 the resolution with a max of 1 resolution.  This is AFTER
> the rounding to the next resolution, so we can expect the expiry to be any
> where from 0 to 2*resolution-1.  (up to resolution-1 from rounding, and up to
> one resolution from clock skew).  This the way I and every one I have worked
> with understand the standard.

For relative timer I agree that the error can be twice the resolution. 
First the value read from the clock must be rounded up and then we still 
have to wait till the next clock tick.
OTOH for absolute timer we don't need the first step, we just have to wait 
until the clock reaches this time. Why should we add an extra error to it, 
if we can avoid it? The spec actually says "a timer expiration signal is 
requested when the associated clock reaches or exceeds the specified 
time." The clock resolution causes the actual expiration time 
automatically to be a rounded value of the requested value.

Next question would be what happens if timer and clock resolution differs? 
For example if the clock has a resolution of 1us and the timer runs every 
1ms. For relative timer this would mean we can keep the error within 
1.001ms and for absolute timer within 1ms. Do we really have to force an 
error larger than really necessary?

Interesting is now that Thomas doesn't take the clock resolution into 
account at all. Let's say clock and timer resolution are 1ms (or HZ=1000). 
If we program a normal kernel timer, we do something like this:

	timer->expires = jiffies + 1 + usecs_to_jiffies(timeout);

Thomas does now basically this:

	timer->expires = jiffies * res + round(timeout, res);

IOW if the clock resolution is larger than the interrupt delay, the timer 
may expire early.

> We have had good acceptance of the HRT patch in our customer base.  As far as
> I know we have not gotten any feed back on just what resolution they want or
> use.  We allow them to define it (within reason) at configure time.  I have
> been recommending, for the x86, nothing better than about 100usec but this is
> based on my machine being able to handle an interrupt in about that amount of
> time.
> 
> We don't require alignment of the resolution with the actual hardware
> resolution as at these levels the interrupt jitter smooths over any issues in
> this area.

I expected as much, so users who do care make sure the timer resolution is 
good enough. In this case I would also expect that they are interested in 
keeping the error as small as possible.

>  A comment here, in some of your math examples you seem to be
> implying that we are going to use a particular resolution from the begining of
> time to compute expiry time.  In fact, we start from "now" as defined by a,
> possibly corrected, system clock.  Once we have the rounded expiry time we use
> full resolution math to figure how to fit that into the timing services.  So,
> infact, the resolution comes into play only over 1 to 2 resolutions of the
> requested time.  In other words, errors do not accumulate since we always mark
> to the corrected clock.

I didn't imply that, I tried to keep focus on the model as described in 
the spec. I think we should keep the focus on the behaviour this model 
describes, no user cares how the kernel implements the spec, just that the 
visible behaviour matches the spec.
SUS rationale specifically says "The interfaces also allow flexibility in 
the implementation of the functions. For example, ..." (in "Relationship 
of Timers to Clocks"), i.e. there is not one true implementation and so I 
think it's very well worth it to explore our options. Reducing the whole 
design to a single number (the resolution returned by clock_getres()) 
would be IMO very shortsighted. We could very well allow the user to 
define his own timer based on various parameters, so he can adjust the 
timer to his needs.

bye, Roman
