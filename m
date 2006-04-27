Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbWD0Vk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWD0Vk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbWD0Vk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:40:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13790 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751706AbWD0Vkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:40:55 -0400
Date: Thu, 27 Apr 2006 23:40:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] periodic clocksource update
In-Reply-To: <1144437489.2745.114.camel@leatherman>
Message-ID: <Pine.LNX.4.64.0604272159400.32445@scrub.home>
References: <Pine.LNX.4.64.0604032156430.4714@scrub.home>
 <1144437489.2745.114.camel@leatherman>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Apr 2006, john stultz wrote:

> > +/*
> > + * Periodically update the clocksource
> > + */
> > +static inline void clocksource_update_tick(void)
> > +{
> > +	curr_clocksource->cycles_last += curr_clocksource->cycle_update;
> > +	curr_clocksource->xtime_nsec += curr_clocksource->xtime_update;
> > +	if (curr_clocksource->xtime_nsec >= (u64)NSEC_PER_SEC << curr_clocksource->shift) {
> > +		curr_clocksource->xtime_nsec -= (u64)NSEC_PER_SEC << curr_clocksource->shift;
> > +		xtime.tv_sec++;
> > +		second_overflow();
> > +	}
> > +	jiffies_64++;
> > +	curr_clocksource->ntp_error += current_tick_length();
> > +	curr_clocksource->ntp_error -= curr_clocksource->xtime_update << (32 - curr_clocksource->shift);
> > +
> > +	if (time_next_adjust) {
> > +		time_adjust = time_next_adjust;
> > +		time_next_adjust = 0;
> > +	} else if (time_adjust)
> > +		time_adjust -= adjtime_adjustment();
> > +}
> 
> I worry about mixing the jiffies_64 update here in this function, mainly
> because it conflicts with the jiffies clocksource.  I understand the
> desire to combine these, as this insures when using some alternate
> clocksource (say the HPET) that we don't see drift between jiffies and
> time in the case of lost ticks.

It's just the functional equivalent to the old update code, we can still 
move it later, but right now it's simpler to just keep it there.

> > +/*
> > + * If the error is already larger, we look ahead another tick,
> > + * to compensate for late or lost adjustments.
> > + */
> > +static int __always_inline clocksource_bigadjust(int sign, s64 error, s64 update)
> > +{
> > +	int adj = 0;
> > +
> > +	error += current_tick_length() >> (33 - curr_clocksource->shift);
> > +	error -= curr_clocksource->xtime_update >> 1;
> > +
> > +	while (1) {
> > +		error >>= 1;
> > +		if (likely(sign > 0 ? error <= update : error >= update))
> > +			return adj;
> > +		adj++;
> > +	}
> > +}
> > +
> > +#define clocksource_adjustcheck(sign, error, update, offset) ({		\
> > +	int adj = sign;							\
> > +	error >>= 2;							\
> > +	if (unlikely(sign > 0 ? error > update : error < update)) {	\
> > +		adj = clocksource_bigadjust(sign, error, update);	\
> > +		update <<= adj;						\
> > +		offset <<= adj;						\
> > +		adj = sign << adj;					\
> > +	}								\
> > +	adj;								\
> > +})
> 
> Yuck, why is this a #define? Maybe could you provide some pros/cons for
> this against my implementation?

The main reason I used a macro here is that it modifies some of the values 
and I want to avoid to duplicate this part of the code.
I'm not entirely happy with it either, but the most important aspect of 
this is the generated code, so I had to make some compromises regarding 
esthetics. OTOH I'm open to ideas as long as it generates similiar code.

> > +/*
> > + * adjust the multiplier to reduce the error value,
> > + * this is optimized for the most common adjustments of -1,0,1,
> > + * for other values we can do a bit more work.
> > + */
> > +static void clocksource_adjust(s64 offset)
> > +{
> > +	s64 error = curr_clocksource->ntp_error >> (31 - curr_clocksource->shift);
> > +	s64 update = curr_clocksource->cycle_update;
> > +	int adj;
> > +
> > +	if (error > update) {
> > +		adj = clocksource_adjustcheck(1, error, update, offset);
> > +	} else if (error < -update) {
> > +		update = -update;
> > +		offset = -offset;
> > +		adj = clocksource_adjustcheck(-1, error, update, offset);
> > +	} else
> > +		goto done;
> > +
> > +	curr_clocksource->mult += adj;
> > +	curr_clocksource->xtime_update += update;
> > +	curr_clocksource->xtime_nsec -= offset;
> > +	curr_clocksource->ntp_error -= (update - offset) << (32 - curr_clocksource->shift);
> > +done:
> > +	xtime.tv_nsec = curr_clocksource->xtime_nsec >> curr_clocksource->shift;
> > +}
> > +
> > +void clocksource_update(struct pt_regs *regs)
> > +{
> > +	unsigned long ticks;
> > +	u64 cycles, cycle_offset;
> > +
> > +	cycles = curr_clocksource->read();
> > +	while (1) {
> > +		cycle_offset = cycles - curr_clocksource->cycles_last;
> > +		cycle_offset &= curr_clocksource->mask;
> > +		if (cycle_offset < curr_clocksource->cycle_update)
> > +			break;
> > +		clocksource_update_tick();
> > +	}
> > +
> > +	clocksource_adjust(cycle_offset);
> > +
> > +	/* prevent loading jiffies before storing new jiffies_64 value. */
> > +	barrier();
> > +	ticks = jiffies - wall_jiffies;
> > +	if (ticks) {
> > +		wall_jiffies += ticks;
> > +		calc_load(ticks);
> > +	}
> > +	softlockup_tick();
> > +}
> > +
> 
> So from my brief look at this, it looks almost exactly like my
> implementation, with the exception of the jiffies update bit already
> mentioned. The other difference is that it doesn't integrate into the
> update_wall_time() function, providing two functions that do almost the
> same thing.

There are big differences. :)
As I already mentioned it produces smaller code and I tried to make the 
fast path as small as possible.
I also updated the algorithm to be more robust, the subtle changes are in 
the clocksource_bigadjust(), which does a bit more work to keep the clock 
from oscillating.
Integrating it into update_wall_time() would just create a big inefficient 
mess. You should really see this as library code. I actually want to 
create another version, which is mostly in 32bits and is even more 
efficient.

bye, Roman
