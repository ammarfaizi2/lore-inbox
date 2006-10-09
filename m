Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWJIUTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWJIUTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWJIUTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:19:41 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:22230 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964813AbWJIUTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:19:40 -0400
Subject: Re: [PATCH 05/10] -mm: clocksource: convert generic timeofday
From: Daniel Walker <dwalker@mvista.com>
To: john stultz <johnstul@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1160422785.5458.60.camel@localhost.localdomain>
References: <20061006185439.667702000@mvista.com>
	 <20061006185456.838445000@mvista.com>
	 <1160422785.5458.60.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 13:19:37 -0700
Message-Id: <1160425178.30532.41.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 12:39 -0700, john stultz wrote:
> On Fri, 2006-10-06 at 11:54 -0700, Daniel Walker wrote:
> > plain text document attachment (clocksource_more_generic.patch)
> > Delete alot of remaining code in kernel/time/clocksource.c that
> > is replaced with this patch. Removed the deprecated "clock" kernel
> > parameter. 
> 
> Hmmm. This patch is a bit more confusing. From first glance it looks
> like a lot of code churn for not a whole lot of benefit. And as Thomas
> already mentioned, you should probably leave the "clock" bit alone for
> now.

The benefits is more in the separation of the two. I'll explain the
rational below.

> > Shifts some of the code around so that the time of day override 
> > happens inside kernel/timer.c.
> 
> Maybe could you explain your rational for this a bit more. I personally
> prefer the current breakdown, where the clocksource selection and
> override bits are in the clocksource code.
> 
> Currently the layering is like this:
> [timekeeping core]
> [clocksource core]
> [clocksource drivers]



> Where timekeeping tries to have as little knowledge as possible of the
> details of the clocksource drivers (outside of basic knowledge of how to
> use them). To the timekeeping core, all clocksources are the same. It
> leaves the selection algorithm and its management up to the clocksource
> core.
> 
> Now if I understand your intent you seem to be splitting it up a bit:
> 
> [timekeeping core]                   [sched_clock code]
> [timekeeping clocksource selection]  [sched_clock clocksource selection]
> [                          clocksource core                            ]
> [                        clocksource drivers                           ]
> 

This is mostly how I see the layers, except after sched_clock I see
"..." 

> Where the selection code is moved from the clocksource core into the
> timekeeping code. I can understand some of the rational, as timekeeping
> and sched_clock have differing selection criteria, so why not have
> separate logic and share the clocksource core.
> 
> So, here's where I'm coming from on this issue: I feel sched_clock to be
> a unfortunately necessary hack. Ideally timekeeping reads should be fast
> enough to do from the scheduler, but that just is not the case (just on
> most arches, some don't have this problem). And since its just scheduler
> decisions, it does not need the correctness that timekeeping needs, so
> we have this arch specific hook that does whatever it needs. And since
> its sorta simple and stupid, the code duplication is pretty minor (no
> NTP adjustments, etc). 
> 
> In my mind this reduces the benefit gained from making a generic
> sched_clock. Currently the clocksource rating logic for timekeeping is
> pretty simple: "weigh correctness first, then consider performance". 
> 
> Now to have a generic sched_clock, we're going to have to introduce a
> new rating scale, which would select a more vague "speed over
> correctness, as long as its totally not insane" logic. To me, it seems a
> bit complicated for generic logic.
> 
> Thus I prefer having the clocksource core keep the an understanding of
> the "correctness first, then performance".
> 
> Now, I don't want to discourage your efforts here (BTW: I really
> appreciate them, and I think attempting new users for the clocksource
> infrastructure will make that infrastructure cleaner and better). It
> seems perfectly logical to use the clocksource infrastructure in
> sched_clock, but maybe, since sched_clock is the necessary hack that it
> is, we can do a more minor cleanup, with less impact to the clocksource
> infrastructure?

First, I've not done this clean up specifically for sched_clock. The
sched_clock changes are just there as an example of the interface
usage. 

> Maybe an idea just to start, would be to have the arch specific
> sched_clock() code use __get_clock(char* name), with its internal
> selection logic based on the clocksource names. This will then have
> minor impact on the current timekeeping/clocksource core code, but still
> allow for some reduction in code duplication. Then as hardware
> clocksources are tested for viability (for example, HPET may be a good
> bet here, but ACPI PM would not), we can add that logic to the arch
> specific sched_clock code.
> 
> Sound reasonable?

Yes. We could do this.. It keeps the performance level mostly flat while
removing all the cycles to nanosecond shift logic in every
architecture. 

> 
> Anyway, that was a bit long winded. I apologize. More specific comments
> below:
> 
ok.

> >  
> >  /**
> > - * __get_clock - Finds a specific clocksource
> > - * @name:		name of the clocksource to return
> > - *
> > - * Private function. Must hold clocksource_lock when called.
> > - *
> > - * Returns the clocksource if registered, zero otherwise.
> > - * If the @name is null the highest rated clock is returned.
> > - */
> > -static inline struct clocksource * __get_clock(char * name)
> > -{
> > -
> > -	if (unlikely(list_empty(&clocksource_list)))
> > -		return &clocksource_jiffies;
> > -
> > -	if (!name)
> > -		return list_entry(clocksource_list.next,
> > -				  struct clocksource, list);
> > -
> > -	return __is_registered(name);
> > -}
> > -
> 
> Errr.. Wasn't this function just added in the last patch? Can we reduce
> the churn here a bit?

I tried, but I also have to make each patch compile. So it gets a bit
tricky.

> 
> > @@ -952,10 +1061,26 @@ static void update_wall_time(void)
> >  	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
> >  
> >  	/* check to see if there is a new clocksource to use */
> > -	if (change_clocksource()) {
> > +	if (unlikely(atomic_read(&clock_check))) {
> > +
> > +		/*
> > +		 * Switch to the new override clock, or the highest
> > +		 * rated clock.
> > +		 */
> > +		if (*clock_override_name)
> > +			change_clocksource(clock_override_name);
> > +		else
> > +			change_clocksource(NULL);
> > +
> >  		clock->error = 0;
> >  		clock->xtime_nsec = 0;
> >  		clocksource_calculate_interval(clock, tick_nsec);
> > +
> > +		/*
> > +		 * Remove the change signal
> > +		 */
> > +		atomic_dec(&clock_check);
> > +
> >  	}
> >  }
> >  
> I think this last chunk (changing the clocksource switching logic) has
> some potential. Mind breaking it out into a separate patch?

Maybe, but part of this fell out of reorganizing the code. 

Daniel

