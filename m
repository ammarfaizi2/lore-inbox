Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWBQAo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWBQAo6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWBQAo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:44:58 -0500
Received: from ozlabs.org ([203.10.76.45]:135 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161145AbWBQAo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:44:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17397.7198.893154.620097@cargo.ozlabs.ibm.com>
Date: Fri, 17 Feb 2006 11:43:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Provide an interface for getting the current tick
	length
In-Reply-To: <1140135082.7028.45.camel@cog.beaverton.ibm.com>
References: <17397.2831.48980.367714@cargo.ozlabs.ibm.com>
	<1140135082.7028.45.camel@cog.beaverton.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz writes:

> > +	if (time_adjust_step)
> >  		/* Reduce by this step the amount of time left  */
> >  		time_adjust -= time_adjust_step;
> 
> Does the if statement really buy you anything here? 

Well, just avoiding dirtying a cache line in the common case where
time_adjust and time_adjust_step are zero, that's all.  It's a very
minor thing.  In fact if time_adjust is zero we could avoid the
procedure call, the subtraction and the multiplication by 1000, like
this:

	delta_nsec = tick_nsec;
	if (time_adjust) {
		time_adjust_step = adjtime_adjustment();
		/* Reduce by this step the amount of time left  */
		time_adjust -= time_adjust_step;
		delta_nsec += time_adjust_step * 1000;
	}

> > +u64 current_tick_length(void)
> > +{
> > +	long delta_nsec;
> > +
> > +	delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
> > +	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
> > +}
> 
> You've got time_adj here, but you're not using what's been accumulated
> in time_phase, is that really ok?

Yes.

What's been accumulated in time_phase is always less than a
nanosecond's worth.  I took the approach of delivering the full
precision of time_adj to the arch code (i.e. including the 12 bits to
the right of the binary point), rather than truncating it to whole
nanoseconds and then having to vary it by +/- 1 nanosecond each tick.

Basically time_phase is just accumulating the fraction of a nanosecond
that we haven't been able to add onto xtime yet.  The effect of that
is that some ticks are 1 nanosecond longer or shorter than others,
depending on the fractional part of time_adj.  I set the factor and
offset that I use in the lockless gettimeofday to take into account
the whole time_adj value, including the fractional part.  That way I
don't have to change the factor and offset every tick, but only when
time_adj changes (or when the adjtime adjustment changes, of course).
The possible +/- 1 nanosecond difference is smaller than the
resolution of the timebase register, and way smaller than the time it
takes to do a gettimeofday and compare it with xtime, so it can be
ignored.

Paul.
