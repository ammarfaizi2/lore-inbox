Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWAEW1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWAEW1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWAEW1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:27:30 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:47279 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751452AbWAEW13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:27:29 -0500
Subject: Re: + time-generic-timekeeping-infrastructure.patch added to -mm
	tree
From: john stultz <johnstul@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1136363161.2839.4.camel@laptopd505.fenrus.org>
References: <200601040036.k040aOS1001312@shell0.pdx.osdl.net>
	 <1136363161.2839.4.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 14:27:25 -0800
Message-Id: <1136500046.7849.14.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 09:25 +0100, Arjan van de Ven wrote:
> On Tue, 2006-01-03 at 16:36 -0800, akpm@osdl.org wrote:
> > +static inline void normalize_timespec(struct timespec *ts)
> > +{
> > +	while (unlikely((unsigned long)ts->tv_nsec >= NSEC_PER_SEC)) {
> > +		ts->tv_nsec -= NSEC_PER_SEC;
> > +		ts->tv_sec++;
> > +	}
> > +}
> > +
> > +static inline void timespec_add_ns(struct timespec *a, nsec_t ns)
> > +{
> > +	while(unlikely(ns >= NSEC_PER_SEC)) {
> > +		ns -= NSEC_PER_SEC;
> > +		a->tv_sec++;
> > +	}
> > +	a->tv_nsec += ns;
> > +	normalize_timespec(a);
> > +}
> > +
> >  #endif /* __KERNEL__ */
> >  
> 
> are you sure you want this one inlined? that's 2 while loops already....
> (and afaics the ns argument isn't a constant really so the first one
> doesn't optimize out)

Good point. I'm mainly concerned w/ gettimeofday/clock_gettime()
performance here since those calls tend to be somewhat micro-optimized. 

For now I've left timespec_add_ns inlined, but it still could use some
work, so I just dropped the normalize_timespec() since no one else uses
it and rewrote timespec_add_ns() to be:

	ns += a->tv_nsec;
	while (unlikely(ns >= NSEC_PER_SEC)) {
		ns -= NSEC_PER_SEC;
		a->tv_sec++;
	}
	a->tv_nsec = ns;


Which should simplify it.

> 
> > +/**
> > + * __get_nsec_offset - Returns nanoseconds since last call to periodic_hook
> > + *
> > + * private function, must hold system_time_lock lock when being
> > + * called. Returns the number of nanoseconds since the
> > + * last call to timeofday_periodic_hook() (adjusted by NTP scaling)
> > + */
> > +static inline nsec_t __get_nsec_offset(void)
> > +{
> > +	cycle_t cycle_now, cycle_delta;
> > +	nsec_t ns_offset;
> > +
> > +	/* read clocksource: */
> > +	cycle_now = read_clocksource(clock);
> > +
> > +	/* calculate the delta since the last timeofday_periodic_hook: */
> > +	cycle_delta = (cycle_now - cycle_last) & clock->mask;
> > +
> > +	/* convert to nanoseconds: */
> > +	ns_offset = cyc2ns(clock, ntp_adj, cycle_delta);
> > +
> > +	/*
> > +	 * special case for jiffies tick/offset based systems,
> > +	 * add arch-specific offset:
> > +	 */
> > +	ns_offset += arch_getoffset();
> > +
> > +	return ns_offset;
> > +}
> 
> likewise here.. 

I left this one inlined as well, since it is in the gettimeofday() call
path and it was originally inlined because the numbers were compelling
enough at the time. However, the concern is valid, so I did just remove
a number of inlines in timeofday.c where performance isn't quite so
critical.

I'll do some further analysis for code size vs performance when I have a
spare moment and maybe go further removing more inlines.

I appreciate you pointing this out, though. Looking at it now, it seems
I was a bit reckless w/ inlines.

Thanks again,
-john

