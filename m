Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWFUViw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWFUViw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWFUViw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:38:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18364 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751469AbWFUViu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:38:50 -0400
Date: Wed, 21 Jun 2006 23:38:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix and optimize clock source update
In-Reply-To: <1150923519.2690.14.camel@leatherman>
Message-ID: <Pine.LNX.4.64.0606212320450.12900@scrub.home>
References: <Pine.LNX.4.64.0606211434020.904@scrub.home>
 <1150923519.2690.14.camel@leatherman>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 21 Jun 2006, john stultz wrote:

> >   * @is_continuous:	defines if clocksource is free-running.
> > - * @interval_cycles:	Used internally by timekeeping core, please ignore.
> > - * @interval_snsecs:	Used internally by timekeeping core, please ignore.
> > + * @cycle_interval:	Used internally by timekeeping core, please ignore.
> > + * @xtime_interval:	Used internally by timekeeping core, please ignore.
> >   */
> 
> Where the variable name changes really necessary (I find them less
> clear)? You also forgot to add error here as it is added below.

I actually find them more clear this way, cycle values start with cycle_, 
xtime related variables start with xtime_ and update intervals end with 
_interval, this makes everything quite consistent.
In the middle term I also want to document them properly, so I didn't 
update these comments.

> > +#define clocksource_adjustcheck(sign, error, interval, offset) ({	\
> > +	int adj = sign;							\
> > +	error >>= 2;							\
> > +	if (unlikely(sign > 0 ? error > interval : error < interval)) {	\
> > +		adj = clocksource_bigadjust(sign, error,		\
> > +					    interval, offset);		\
> > +		interval <<= adj;					\
> > +		offset <<= adj;						\
> > +		adj = sign << adj;					\
> > +	}								\
> > +	adj;								\
> > +})
> 
> That's still a #define with side effects. Yuck.

The alternative is duplicating the code and an inline function which takes 
the address of these variables would likely generate worse code.

> > +	clock->mult += adj;
> > +	clock->xtime_interval += interval;
> > +	clock->xtime_nsec -= offset;
> > +	clock->error -= (interval - offset) << (TICK_LENGTH_SHIFT - clock->shift);
> > +done:
> > +	/* store full nanoseconds into xtime */
> > +	xtime.tv_nsec = clock->xtime_nsec >> clock->shift;
> > +}
> 
> Why are you setting xtime.tv_nsec in clocksource_adjust()?
> That should be kept in update_wall_time. 

clock->xtime_nsec and xtime.tv_nsec are closely related, in the long term 
xtime.tv_nsec should be unused.

> > -	now = clocksource_read(clock);
> > -	offset = (now - last_clock_cycle)&clock->mask;
> > +#ifdef CONFIG_GENERIC_TIME
> > +	offset = (clocksource_read(clock) - clock->cycle_last) & clock->mask;
> > +#else
> > +	offset = clock->cycle_interval;
> > +#endif
> 
> This looks ok, but I'd prefer the GENERIC_TIME case to be less dense
> (not doing the read in the same line).

The "now" definition would then require another #ifdef to avoid a warning.

> >  	/* normally this loop will run just once, however in the
> >  	 * case of lost or late ticks, it will accumulate correctly.
> >  	 */
> > -	while (offset > clock->interval_cycles) {
> > -		/* get the ntp interval in clock shifted nanoseconds */
> > -		s64 ntp_snsecs	= current_tick_length(clock->shift);
> > -
> > +	while (offset > clock->cycle_interval) {
> 
> Shouldn't that be >= ? That was one of the fixes I made in my other
> patch.

Sorry, I indeed missed this, I was only looking at my patches.

> >  	/* check to see if there is a new clocksource to use */
> >  	if (change_clocksource()) {
> > -		error = 0;
> > -		remainder_snsecs = 0;
> > +		clock->error = 0;
> > +		clock->xtime_nsec = 0;
> > +		xtime.tv_nsec = 0;
> >  		clocksource_calculate_interval(clock, tick_nsec);
> >  	}
> 
> Setting xtime.tv_nsec to zero in the above is incorrect and causes the
> inconsistencies I mentioned at the top.

Indeed, but luckily it's not a common event.

bye, Roman
