Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269797AbUICXg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269797AbUICXg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269973AbUICXg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 19:36:56 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:12698 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269797AbUICXgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 19:36:52 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <4138EBE5.2080205@mvista.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>
	 <41381C2D.7080207@mvista.com>
	 <1094239673.14662.510.camel@cog.beaverton.ibm.com>
	 <4138EBE5.2080205@mvista.com>
Content-Type: text/plain
Message-Id: <1094254342.29408.64.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 03 Sep 2004 16:32:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Really quick: I'm off on vacation until Weds. Hopefully I've addressed
in some way everyone's comments and my email box won't be stuffed when I
return. I might peek in every once in awhile, though. 

Just one last response...

On Fri, 2004-09-03 at 15:10, George Anzinger wrote:
> john stultz wrote:
> > I feel trying to keep two notions of time, one in the timeofday code and
> > one in the timer code is the real issue. Trying to better keep them
> > synced will just lead to madness. Instead the timer subsystem needs to
> > move to using monotonic_clock(), or get_lowres_timestamp() instead of
> > using jiffies for its notion of time. Jiffies is just an interrupt
> > counter. 
> 
> Well, there may be a better way.  Suppose we change all the accounting code to 
> work with nanoseconds.  That way when we do an accounting pass we would just add 
> what has elapsed since the last pass.  

Yep, that'd work too. 

> Still need some way to do user timers that are tightly pegged to the clock.

I see that as just a problem of programming the timer interrupt
generator. If you have a nanosecond (or as high as the best timesource
on your system provides) resolution notion of time, then there is
nothing to peg or tie the timer with. You simply just program it to go
off every X nanoseconds. Should it be so inaccurate that it does not go
off right at X nanoseconds, then you've hit a limit of the hardware.
Pick a more accurate interval length, dynamically change your interval,
or live with it.  If the soft-timers use monotonic-clock() to determine
when they expire, then you won't get accumulating drift (as
monotonic-clock()is NTP frequency adjusted), only the minor jitter
caused latency caused by the interrupt programming.

> A thought I had along these lines was to program a timer for each tick.  The PIT 
> is much too slow for this, but the APIC timers seem to be rather easy to 
> program.  I am not sure how fast the access is but it can not be anything like 
> the PIT.  Under this scheme we would use the monotonic clock to figure out just 
> how far out the next tick should be and program that.

Yep, tickless systems also start being possible. We just have interrupts
for scheduled events. 

> This could be modified to use repeating hardware if it is available.  (What does 
> the HPET provide?  Does it interrupt?)  Since the APIC clock is not the 
> reference clock (the PIT & pm timer clock is) we would have to correct these 
> from time to time but that is rather easy (I do it today in HRT code).

Don't know the details of interrupt generation, so I can't tell ya. I'm
not sure I followed the correction bit?

> This brings up another issue.  We know what the PIT clock frequency is but not 
> what the TSC clock frequency.  Currently we do a calibration run at boot to 
> figure this but I can easily show that this run consistently gives the wrong 
> answer (I am sure this has to do with the I/O access delays).  If we are going 
> to use the TSC (or any other "clock" that is not derived from the PITs 
> 14.3181818MHZ ital) we need both a way to get the correct value AND a way to 
> adjust it for drift over time.  (Possibly this is the same thing.)  Of course 
> this is all just x86 stuff.  Other archs will have their own issues.

Again, monotonic_clock() and friends are NTP adjusted, so drift caused
by inaccurate calibration shouldn't be a problem the interval timer code
should need to worry about (outside of maybe adjusting its interval time
if its always arriving late/early). If possible the timesource
calibration code should be improved, but that's icing on the cake and
isn't critical.

Again, thanks to everyone for the great feedback and discussion!
-john

