Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWALMXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWALMXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWALMXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:23:40 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:2694 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030339AbWALMXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:23:40 -0500
Date: Thu, 12 Jan 2006 13:23:33 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/10] NTP: normalize time_adj
In-Reply-To: <1136946077.2890.44.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0601121302050.30994@scrub.home>
References: <Pine.LNX.4.61.0512220020250.30897@scrub.home>
 <1136946077.2890.44.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 10 Jan 2006, john stultz wrote:

> > Index: linux-2.6-mm/include/linux/timex.h
> > ===================================================================
> > --- linux-2.6-mm.orig/include/linux/timex.h	2005-12-21 12:11:48.000000000 +0100
> > +++ linux-2.6-mm/include/linux/timex.h	2005-12-21 12:11:56.000000000 +0100
> > @@ -93,7 +93,7 @@
> >  #define SHIFT_SCALE 22		/* phase scale (shift) */
> >  #define SHIFT_UPDATE (SHIFT_KG + MAXTC) /* time offset scale (shift) */
> >  #define SHIFT_USEC 16		/* frequency offset scale (shift) */
> > -#define FINENSEC (1L << (SHIFT_SCALE - 10)) /* ~1 ns in phase units */
> > +#define FINENSEC (1L << SHIFT_SCALE) /* ~1 ns in phase units */
> 
> So this effectively increases the granularity of the phase units, right?

Basically yes, but it's part of a small cleanup I forgot to comment. (See 
below)

> > @@ -675,36 +677,38 @@ static void second_overflow(void)
> >  	ltemp = min(ltemp, (MAXPHASE / MINSEC) << SHIFT_UPDATE);
> >  	ltemp = max(ltemp, -(MAXPHASE / MINSEC) << SHIFT_UPDATE);
> >  	time_offset -= ltemp;
> > -	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
> > +	adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
> 
> 	That could maybe use a better comment. The larger comment makes it
> clear we're converting the usec offset to phase adjustment units, but
> maybe something further to explain how usecs -> phase is connected to
> multiplying by 2^(SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE) would help?

I agree that this could use better comments, although some changes are 
only temporary, so some things I'll probably only comment better in the 
changelog.

> >  	 * 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
> >  	 */
> > -	time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
> > +	adj += shift_right(adj, 6) + shift_right(adj, 7);
> >  #endif
> > +	tick_nsec_curr += adj >> (SHIFT_SCALE - 10);
> > +	time_adj = (adj << 10) & (FINENSEC - 1);
> 
> Again, a comment here would help. 
> 
> We use time_adj to increment the phase which will adjust the per-tick
> nsec interval in update_wall_time_one_tick, so why are we adjusting
> tick_nsec_curr which is used there as well?

This is the part which normalizes time_adj, so it's always positive and 
saves two checks in update_wall_time_one_tick().
(BTW in the long term I want to merge these two into a single 64 bit 
variable, but it requires a few more changes.)

> Also why SHIFT_SCALE - 10?  And (adj<<10)&(FINSEC -1) looks like magic
> to me. :)

It's connected to the removed "- 10" above and below, it moves the crude 
usec to nsec conversion (it divides by 1024 instead of 1000) to a single 
spot, so it's easier to remove in a later patch.
I initially wanted to mention this in the changelog, but forgot about it, 
I'll update it.

> >  	time_phase += time_adj;
> > -	if ((time_phase >= FINENSEC) || (time_phase <= -FINENSEC)) {
> > -		long ltemp = shift_right(time_phase, (SHIFT_SCALE - 10));
> > -		time_phase -= ltemp << (SHIFT_SCALE - 10);
> > +	if (time_phase >= FINENSEC) {
> > +		long ltemp = time_phase >> SHIFT_SCALE;
> > +		time_phase -= ltemp << SHIFT_SCALE;
> >  		delta_nsec += ltemp;
> >  	}
> >  	xtime.tv_nsec += delta_nsec;
> 
> Again, same point as the last comment.

See above.

> I'll try to provide similar comments for the other patches tomorrow.

Thanks. :)

bye, Roman
