Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269419AbUICCSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269419AbUICCSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 22:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269138AbUICCRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 22:17:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22705 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269564AbUICCLN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 22:11:13 -0400
Subject: Re: [RFC][PATCH] new timeofday i386 hooks (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <4137CC85.4040802@mvista.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <1094159492.14662.325.camel@cog.beaverton.ibm.com>
	 <4137CC85.4040802@mvista.com>
Content-Type: text/plain
Message-Id: <1094177215.14662.462.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 19:06:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 18:44, George Anzinger wrote:
> john stultz wrote:
> > +void sync_persistant_clock(struct timespec ts)
> > +{
> > +	/*
> > +	 * If we have an externally synchronized Linux clock, then update
> > +	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
> > +	 * called as close as possible to 500 ms before the new second starts.
> > +	 */
> > +	if (ts.tv_sec > last_rtc_update + 660 &&
> > +	    (ts.tv_nsec / 1000)
> > +			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
> > +	    (ts.tv_nsec / 1000)
> > +			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
> > +		/* horrible...FIXME */
> > +		if (efi_enabled) {
> > +	 		if (efi_set_rtc_mmss(ts.tv_sec) == 0)
> > +				last_rtc_update = ts.tv_sec;
> > +			else
> > +				last_rtc_update = ts.tv_sec - 600;
> > +		} else if (set_rtc_mmss(ts.tv_sec) == 0)
> > +			last_rtc_update = ts.tv_sec;
> > +		else
> > +			last_rtc_update = ts.tv_sec - 600; /* do it again in 60 s */
> > +	}
> > +
> I have wondered, and continue to do so, why this is not a timer driven function. 
>   It just seems silly to check this every interrupt when we have low overhead 
> timers for just this sort of thing.
> 
> I wonder about the load calc in the same way...

The really cool thing is: with the new infrastructure separating the
timeofday code and the timer code, we can make timeofday_interrupt_hook
be called from a soft-timer! We don't have to do the accounting every
interrupt, but just frequently enough that the time sources don't
overflow!

> Now, the question is how do you hook up the timer list.  We MUST be able to 
> start a timer that will run for several min to hours and have it expire such 
> that the wall time difference is "really" close to what was requested.  This 
> requires some "lock up" between the wall clock and the timer subsystem.
> 
> What are your thoughts here?

Well, looking way down the road, once timeofday is independent from the
soft-timer code, we can invert the dependency so the soft-timer code
uses the high-res timeofday code instead of jiffies for determining if a
timer has expired. That would allow for more precise timer intervals to
be set, without worry of how it might affect timekeeping.

Easier said then done, I agree, but this change does allow for these
sorts of thing to be attempted. 

My favorite benefit is that lost-ticks caused by bad drivers become a
timer/scheduler latency issue rather then a timeofday is broken issue :)

Yay!

Thanks again, George!
-john


