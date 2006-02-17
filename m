Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbWBQAxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbWBQAxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbWBQAxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:53:06 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:21216 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161144AbWBQAxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:53:05 -0500
Subject: Re: [PATCH v2] Provide an interface for getting the current tick
	length
From: john stultz <johnstul@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <17397.7198.893154.620097@cargo.ozlabs.ibm.com>
References: <17397.2831.48980.367714@cargo.ozlabs.ibm.com>
	 <1140135082.7028.45.camel@cog.beaverton.ibm.com>
	 <17397.7198.893154.620097@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 16:53:02 -0800
Message-Id: <1140137582.7028.69.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 11:43 +1100, Paul Mackerras wrote:
> john stultz writes:
> 
> > > +	if (time_adjust_step)
> > >  		/* Reduce by this step the amount of time left  */
> > >  		time_adjust -= time_adjust_step;
> > 
> > Does the if statement really buy you anything here? 
> 
> Well, just avoiding dirtying a cache line in the common case where
> time_adjust and time_adjust_step are zero, that's all.  It's a very
> minor thing.  In fact if time_adjust is zero we could avoid the
> procedure call, the subtraction and the multiplication by 1000, like
> this:
> 
> 	delta_nsec = tick_nsec;
> 	if (time_adjust) {
> 		time_adjust_step = adjtime_adjustment();
> 		/* Reduce by this step the amount of time left  */
> 		time_adjust -= time_adjust_step;
> 		delta_nsec += time_adjust_step * 1000;
> 	}

Yea, I was thinking if you weren't going to do it for the mult, why
bother on the subtract. Either way, I'm not too picky, it should just be
consistent.

> > > +u64 current_tick_length(void)
> > > +{
> > > +	long delta_nsec;
> > > +
> > > +	delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
> > > +	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
> > > +}
> > 
> > You've got time_adj here, but you're not using what's been accumulated
> > in time_phase, is that really ok?
> 
> Yes.
> 
> What's been accumulated in time_phase is always less than a
> nanosecond's worth.  I took the approach of delivering the full
> precision of time_adj to the arch code (i.e. including the 12 bits to
> the right of the binary point), rather than truncating it to whole
> nanoseconds and then having to vary it by +/- 1 nanosecond each tick.

So you're accumulating it yourself in the arch code? That's fine, I just
wanted to be sure.

Acked-by: john stultz <johnstul@us.ibm.com>

thanks
-john

