Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbVJRAH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbVJRAH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 20:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVJRAH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 20:07:57 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:51108 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751416AbVJRAH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 20:07:57 -0400
Date: Tue, 18 Oct 2005 02:07:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       george@mvista.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       paulmck@us.ibm.com, hch@infradead.org, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <1129582512.19559.136.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0510180032420.1386@scrub.home>
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0510100213480.3728@scrub.home>  <1129016558.1728.285.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
  <Pine.LNX.4.61.0510150143500.1386@scrub.home>  <1129490809.1728.874.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510170021050.1386@scrub.home>  <20051017075917.GA4827@elte.hu>
  <Pine.LNX.4.61.0510171054430.1386@scrub.home>  <20051017094153.GA9091@elte.hu>
 <20051017025657.0d2d09cc.akpm@osdl.org>  <Pine.LNX.4.61.0510171511010.1386@scrub.home>
 <1129582512.19559.136.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Oct 2005, Thomas Gleixner wrote:

> On Mon, 2005-10-17 at 18:25 +0200, Roman Zippel wrote:
> > It's rather simple:
> > - "timer API" vs "timeout API": I got absolutely no acknowlegement that 
> > this might be a little confusing and in consequence "process timer" may be 
> > a better name.
> 
> Not only me, also a lot of other people do _not_ find it confusing and I
> explained why it is a clear technical distcinction. I also explained why
> I think that process_timers is too restrictive IMO.

People don't find it confusing, exactly because it gives them the wrong 
idea about it, neither "API" is restricted to just timeouts or timer.
I don't insist on the term "process timer", but I'd really like to find 
something better than ktimer. We already have kernel timer API, which is 
the primary API for kernel usage (for both timer and timeouts).

> list: 
> allows fast access to the time sorted list without walking the rbtree
> and is a preliminary for the extension to high resolution timers.

Only access to first element is needed, which can be cached in the base.
Please explain the second part.

> expired:
> The field was added for simplification of some delta calculations in the
> return path. e.g. nanosleep in the expired case to avoid the extra call
> to get the current time. Also quite useful for debugging.

The return path can also get it from the base.

> status:
> A simple field, which stores at the moment 2 states and is necessary for
> extensions to high resolution timers too, as we have more states there. 
> The suggested usage of the rbnode.parent pointer is wrong IMO as the
> overloading of arbitrary pointers for status information is a kind of
> pseudo optimization which is reducing in fact maintainability and
> clarity for a the win of a 32bit variable.

Testing a pointer is not "arbitrary", we do it all the time in the kernel.

> interval, overrun:
> Interval holds the converted interval value for itimers. The overrun
> member is used by the rearm code so the caller can figure out the number
> of missed events. 
> 
> The cleanup I pointed out for the posix timer interval timers is pretty
> obvious. It makes use of interval and overrun and removes two members of
> the posix timer structure.

Where I think it's possible to separate the timer from the interval 
functionality to get a simpler timer base implementation.

> The size of the ktimer structure is a matter of micro optimizations in
> the same way as the macros/inlines are. 

Not really, these fields have to be initialized and maintained, which 
quickly goes beyond "micro optimizations".

> Calling the pure existence of some struct members complexity is an
> exaggeration and contradicts your own request for a simple and clear
> design. 

That's not all what I had it in mind regarding complexity, I just started 
with the more simpler parts and never got to the more complex part.

> Doing a design with the final goal in mind is much cleaner than doing
> micro optimizations in the first place and afterwards working around
> them when you apply extensions.

This is fine, but then you should explain them, I'm not a mind reader, so 
that I can guess what you're planning.

> > - resolution handling: at what resolution should/does the kernel work and 
> > what do we report to user space. The spec allows multiple interpretations 
> > and I have a hard time to get at least one coherent interpretation out of 
> > Thomas.
> 
> I interpret the spec in the way I do for following reasons:
> 
> 1. It is _usual practice_ to return the "timer" resolution for
> clock_res() and to return clock values with as much resolution as
> possible. In no case should the actual clock resolution be less than
> what clock_res() returns.
> - George Anzinger in this thread. Similar opinions can be found via
> Google. I came to the same conclusion and saw no reason to repeat
> Georges statement. I thought a simple pointer would be sufficient.

In this case you don't interpret the spec, you ignore the spec. (I'll 
leave it open whether that's a good or bad thing.)

> 2. The rounding to the resolution value is explicitly required by the
> standard.

It doesn't explicitly specify which resolution (see the previous mail).
It doesn't explicitly specify how this rounding has to be implemented.

> 3. It makes a lot of sense to do what (1.) describes, due to the fact
> that we actually want to restrict the timer resolution to avoid
> interrupt and reprogramming floods in very short intervals. This in fact
> is the default behaviour in a jiffy driven environment. Pretending a
> real nsec resolution and doing no rounding at all is violating (2.).
> >From an application programmers view it makes sense to return the timer
> resolution so he actually can adjust the program behaviour on the
> provided resolution and not rely on wild guess assumptions about what
> might be there. Applications need to be able to verify whether the
> system can handle the required intervals or not.

A portable application simply cannot make this assumption.

Anyway, it's rather confusing how you ignore the spec, when "it makes a 
lot of sense" and OTOH how you can stick to the spec. I honestly don't 
know how to argue on this basis, where the spec can be arbitrarily 
redefined based on undocumented assumptions.

bye, Roman
