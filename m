Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVHVS7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVHVS7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 14:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVHVS7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 14:59:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20216 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750706AbVHVS7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 14:59:04 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0508202204240.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508162337130.3728@scrub.home>
	 <1124241449.8630.137.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508182213100.3728@scrub.home>
	 <1124505151.22195.78.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508202204240.3728@scrub.home>
Content-Type: text/plain
Date: Mon, 22 Aug 2005 11:57:55 -0700
Message-Id: <1124737075.22195.114.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 01:19 +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 19 Aug 2005, john stultz wrote:
> 
> > timekeeping_perioidic_hook():
> > 
> > 	/* get ntp adjusted interval length*/
> > 	interval_length = get_timesource_interval(ppm)
> 
> Here starts the problem, this requires more expensive math than necessary, 
> as every time you first have to scale the values.

Hmmm. I feel like we're mixing signals. See below for more on this. 


> Let's take a standard PIT timer as an example. With HZ=100 we program it 
> with 11932, for simplicity let's assume this corresponds to 10^7ns and 
> scale this by 2^8. This means the timer multiplier is initially 214549, 
> this updates the system time by 214549*11932 and the reference time by 
> 10^7*2^8 every tick. We can now just ignore the error or as soon as it 
> exceeds 11932/2 we increase/decrease the mutiplier. The error calculation 
> is rather simple, usually just adds and shifts, only if the error exceeds 
> 2*11932 it gets a little more complicated, but even here the possible 
> divide is avoidable.

I feel like we're talking about different problems. Which reference
clock (other then the system clock) are you wanting to increment at the
tick time? Do you mean the ntp time_offset value? A little bit of psudo
code might go a long way in helping me understand your solution.

Also I'm not sure how this is connects to the continuous timesource
situation where we do not assume timer ticks are not lost or late. 


> The gettimeofday would then basically be "xtime + (cycle_offset * mult + 
> error_offset) / 2^8". Depending on the update frequency and the required 
> precision it's even possible to keep this within 32bit. The ntp part stays 
> pretty much the same and the time source can add anything it wants on top 
> of that. The basic math is also pretty much the same so we can generate 
> most of the code depending on various parameters.


Again, I must not be understanding what you're suggesting.  Above where
you called get_timesource_interval(ppm) too expensive, what you're
suggesting here is almost exactly what get_timesource_interval(ppm)
would do.  In my timeofday patches, its called cyc2ns() and gettimeofday
looks like:
  xtime + cyc2ns(timesource, ntp_adjustment, cycle_delta)

Where cyc2ns does:
  (cycle_delta * (timesource->mult + ntp_adjustment))>>timesource->shift


The reason why we calculate the interval_length in the continuous
timesource case is because we are not assuming anything about the
frequency that the timekeeping_periodic_hook() is called.


Again, I'm really wanting to address your concerns, but I still do not
really understand the specific objections. 

thanks
-john



