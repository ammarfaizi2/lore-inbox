Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWAaX21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWAaX21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWAaX20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:28:26 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:11211 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932126AbWAaX2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:28:25 -0500
Subject: Re: [PATCH] timer tsc ensure we allow for initial tsc and tsc sync
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060131152113.14781abf.akpm@osdl.org>
References: <20060120125342.GA7632@shadowen.org>
	 <1138399887.14289.107.camel@cog.beaverton.ibm.com>
	 <43DE14F0.5070208@shadowen.org>  <20060131152113.14781abf.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 15:28:23 -0800
Message-Id: <1138750103.10057.67.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 15:21 -0800, Andrew Morton wrote:
> Andy Whitcroft <apw@shadowen.org> wrote:
> >
> > From: John Stultz <johnstul@us.ibm.com>
> > 
> > Suppress lost tick detection until we are fully initialised.
> > This prevents any modifications to the high resolution timers
> > from causing non-linearities in the flow of time.  For example on
> > an SMP system we resyncronise the TSC values for all processors.
> > This results in a TSC reset which will be seen as a huge apparent
> > tick loss.  This can cause premature expiry of timers and in extreme
> > cases can cause the soft lockup detection to fire.
> > 
> > Acked-by: Andy Whitcroft <apw@shadowen.org>
> > 
> > diff --git a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
> > --- a/arch/i386/kernel/timers/timer_tsc.c
> > +++ b/arch/i386/kernel/timers/timer_tsc.c
> > @@ -45,6 +45,15 @@ static unsigned long last_tsc_high; /* m
> >  static unsigned long long monotonic_base;
> >  static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
> >  
> > +/* Avoid compensating for lost ticks before TSCs are synched */
> > +static int detect_lost_ticks;
> > +static int __init start_lost_tick_compensation(void)
> > +{
> > +	detect_lost_ticks = 1;
> > +	return 0;
> > +}
> > +late_initcall(start_lost_tick_compensation);
> > +
> >  /* convert from cycles(64bits) => nanoseconds (64bits)
> >   *  basic equation:
> >   *		ns = cycles / (freq / ns_per_sec)
> > @@ -196,7 +205,8 @@ static void mark_offset_tsc_hpet(void)
> >  
> >  	/* lost tick compensation */
> >  	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
> > -	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
> > +	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))
> > +					&& detect_lost_ticks) {
> 
> Simple enough.  John, so you feel that this is 2.6.16 material?

Yep.  There's a signed off version somewhere in your inbox.

> Note that the time changes in -mm will blow this change away, so I'd be
> needing a fresh version of this patch against next-mm, please.

Uh, not sure I followed that. Do mean you'd want a new set of the
generic timefoday patches to apply ontop of this fix?

thanks
-john

