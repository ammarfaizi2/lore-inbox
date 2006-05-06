Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWEFC1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWEFC1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 22:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWEFC1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 22:27:09 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47048 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750702AbWEFC1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 22:27:08 -0400
Subject: Re: [PATCH 1/5] generic clocksource updates
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604272103010.32445@scrub.home>
References: <Pine.LNX.4.64.0604032155070.4707@scrub.home>
	 <1144435123.2745.88.camel@leatherman>
	 <Pine.LNX.4.64.0604272103010.32445@scrub.home>
Content-Type: text/plain
Date: Fri, 05 May 2006 19:27:02 -0700
Message-Id: <1146882422.12414.46.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 22:41 +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 7 Apr 2006, john stultz wrote:
> 
> > On Mon, 2006-04-03 at 21:55 +0200, Roman Zippel wrote:
> > > A number of changes to the clocksource infrastructur:
> > > - use xtime_lock instead of clocksource_lock, so it's easier to
> > >   synchronize the clocksource switch for gettimeofday.
> > 
> > I'm not sure I understand the benefit of this. Could you explain?
> 
> Switching the system clock requires synchronizing using xtime_lock, since 
> the other uses of clocksource_lock were not critical, it's easier to use 
> there xtime_lock as well. This makes the clock switch code simpler.

Here I disagree, as it makes the code less understandable. But this is a
minor issue.

> > > - add a few clock state variables (instead of making them global).
> > 
> > This goes against some of my goals for keeping the clocksource stupid
> > and simple (just a method for hardware access), so I don't know if I
> > view this as a good change. Most of the global variables it replaces
> > were static to a single function. Could you explain the rational a bit?
> 
> There is one practical reason: Accessing the variables via a pointer 
> allows the compiler to produce smaller code.

Ok, that's a good reason, however can we keep the clocksource
abstraction clean by adding a middle layer for the timekeeping values?

ie:
	struct timekeeping_data {
		struct clocksource clock;
		cycle_t last_cycle
		cycle_t interval_cycle
		s64 interval_snsec
		s64 snsec_remainder
	} time_data;

That way the abstraction is cleaner. It would pull the
interval_snsecs/interval_cycles values out and clocksources would simply
export counter/frequency data. Then the timkeeping core would
clocksources as well as its own data to export time. 


> From a design point of view there is no practical reason to not have 
> multiple clocks. These variables belong to the clock and they can be used 
> for more than just synchronizing with the NTP system, e.g. the same basic 
> idea can be used to lock a fast but unstable TSC clock to a slower but 
> more stable clock.

Well, TSCs are mostly junk, so I don't know if that is really doable.
I'm also not so sure of the utility of multiple clocks, but I'm
interested in hearing more.  However I disagree those variables belong
to the clocksource driver. Since clocksources just export a cycle
counter and frequency data, they can be used for more then just
timekeeping. Delay loops come to mind as one possibility.


> > > - * @is_continuous:	defines if clocksource is free-running.
> > > - * @interval_cycles:	Used internally by timekeeping core, please ignore.
> > > - * @interval_snsecs:	Used internally by timekeeping core, please ignore.
> > > + * @cycle_update:	Used internally by timekeeping core, please ignore.
> > > + * @xtime_update:	Used internally by timekeeping core, please ignore.
> > 
> > I don't think cycle_update/xtime_update are very clear variable names.
> > The interval_cycles/snsecs are the per-interval cycle and shifted
> > nanosecond components. Could you explain what you feel makes yours more
> > clear?
> 
> The names should be more clear in the context of the design document I've 
> sent. As there are derived from it, I would prefer comments regarding to 
> this in the context of this document.
> Anyway, using interval instead of update sounds good, but many variables 
> in this area are fixed point values, so I don't see much value in 
> explicitely stating that there are "shifted" (or do you do the same with 
> floating point values?). 


Well, I don't call floating point values integers. Just because we're
dealing with time doesn't mean the unit has no meaning. 

The unit described in the name is what people expect to get when they
print the value. This is important for people to be able to read the
code and quickly understand it without reading pages of design
documentation.

> > Again, why is it necessary to switch the clocksources here? It is what
> > forces all of the timekeeping code to be mingled in the clocksource
> > management. I think the way I did it was pretty clean, limiting
> > clocksource.c to only registration and selection of a clocksource. Now
> > we have timekeeping code in clocksource.c too? What is the gain here?
> 
> It's IMO better than the alternative to make the code clock switching 
> in timer.c even more complex. A clock switch is a rare event, I don't see 
> a good reason to check for it every single timer interrupt.
> We can try to clean this up later, but in this case I prefer the 
> simplicity.

Ok, I think I can agree w/ this if we use something like the struct
timekeeping_data layer above.

Thanks for the feedback.
-john

