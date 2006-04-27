Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWD0Ulj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWD0Ulj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbWD0Ulj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:41:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29405 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751516AbWD0Uli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:41:38 -0400
Date: Thu, 27 Apr 2006 22:41:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] generic clocksource updates
In-Reply-To: <1144435123.2745.88.camel@leatherman>
Message-ID: <Pine.LNX.4.64.0604272103010.32445@scrub.home>
References: <Pine.LNX.4.64.0604032155070.4707@scrub.home>
 <1144435123.2745.88.camel@leatherman>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Apr 2006, john stultz wrote:

> On Mon, 2006-04-03 at 21:55 +0200, Roman Zippel wrote:
> > A number of changes to the clocksource infrastructur:
> > - use xtime_lock instead of clocksource_lock, so it's easier to
> >   synchronize the clocksource switch for gettimeofday.
> 
> I'm not sure I understand the benefit of this. Could you explain?

Switching the system clock requires synchronizing using xtime_lock, since 
the other uses of clocksource_lock were not critical, it's easier to use 
there xtime_lock as well. This makes the clock switch code simpler.

> > - add a few clock state variables (instead of making them global).
> 
> This goes against some of my goals for keeping the clocksource stupid
> and simple (just a method for hardware access), so I don't know if I
> view this as a good change. Most of the global variables it replaces
> were static to a single function. Could you explain the rational a bit?

There is one practical reason: Accessing the variables via a pointer 
allows the compiler to produce smaller code.
>From a design point of view there is no practical reason to not have 
multiple clocks. These variables belong to the clock and they can be used 
for more than just synchronizing with the NTP system, e.g. the same basic 
idea can be used to lock a fast but unstable TSC clock to a slower but 
more stable clock.

> > - * @is_continuous:	defines if clocksource is free-running.
> > - * @interval_cycles:	Used internally by timekeeping core, please ignore.
> > - * @interval_snsecs:	Used internally by timekeeping core, please ignore.
> > + * @cycle_update:	Used internally by timekeeping core, please ignore.
> > + * @xtime_update:	Used internally by timekeeping core, please ignore.
> 
> I don't think cycle_update/xtime_update are very clear variable names.
> The interval_cycles/snsecs are the per-interval cycle and shifted
> nanosecond components. Could you explain what you feel makes yours more
> clear?

The names should be more clear in the context of the design document I've 
sent. As there are derived from it, I would prefer comments regarding to 
this in the context of this document.
Anyway, using interval instead of update sounds good, but many variables 
in this area are fixed point values, so I don't see much value in 
explicitely stating that there are "shifted" (or do you do the same with 
floating point values?). 

> >  struct clocksource {
> >  	char *name;
> > @@ -58,11 +57,11 @@ struct clocksource {
> >  	u32 mult;
> >  	u32 shift;
> >  	int (*update_callback)(void);
> > -	int is_continuous;
> >  
> >  	/* timekeeping specific data, ignore */
> > -	cycle_t interval_cycles;
> > -	u64 interval_snsecs;
> > +	u64 cycles_last, cycle_update;
> > +	u64 xtime_nsec, xtime_update;
> > +	s64 ntp_error;
> 
> My opinion: These add very timekeeping specific state values to the
> clocksource structure. In my initial design, the clocksource structures
> have no idea what they might be used for, so they only provide
> information about the hardware. In my mind, this avoids mixing
> functionality between files and makes the code easier to read. So I'd
> prefer to keep it more limited (even going as far as removing the
> interval_xxx units) to keep the clocksource structure from having any
> timekeeping data in it.
> 
> Could you maybe provide more info why this information should be stored
> in the clocksource structure instead of keeping it in the timekeeping
> code?

Well, in other programming languages there other ways to keep this 
separate, but this is C and these variables belong to the clock if it's to 
be used as system clock.

> Also again, the names are not clear and there isn't much documentation
> as to what these values are.

You did get the separate document, which describes the clock updates?

> For example, xtime_nsec: it isn't even a
> nsec value (its a shifted nanosecond value), so it doesn't make much
> sense at all.

Actually your sentence doesn't make much sense. :)
A shifted nsec value is also a nsec value, i.e the shifted value is just a 
special case (aka a fixed pointed value).

> Again, why is it necessary to switch the clocksources here? It is what
> forces all of the timekeeping code to be mingled in the clocksource
> management. I think the way I did it was pretty clean, limiting
> clocksource.c to only registration and selection of a clocksource. Now
> we have timekeeping code in clocksource.c too? What is the gain here?

It's IMO better than the alternative to make the code clock switching 
in timer.c even more complex. A clock switch is a rare event, I don't see 
a good reason to check for it every single timer interrupt.
We can try to clean this up later, but in this case I prefer the 
simplicity.

bye, Roman
