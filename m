Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVHWUvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVHWUvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVHWUvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:51:14 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:65197 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750772AbVHWUvN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:51:13 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0508230134210.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508162337130.3728@scrub.home>
	 <1124241449.8630.137.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508182213100.3728@scrub.home>
	 <1124505151.22195.78.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508202204240.3728@scrub.home>
	 <1124737075.22195.114.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508230134210.3728@scrub.home>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 13:51:02 -0700
Message-Id: <1124830262.20464.26.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 13:30 +0200, Roman Zippel wrote:
> On Mon, 22 Aug 2005, john stultz wrote:
> 
> > The reason why we calculate the interval_length in the continuous
> > timesource case is because we are not assuming anything about the
> > frequency that the timekeeping_periodic_hook() is called.
> 
> The problem with your patch is that it doesn't allow making such 
> assumptions.
> Anyway, it's rather simple, if you want to update the time asynchronously:
> 
> 	cycle_offset = get_cycles() - last_update;
> 
> 	while (cycle_offset >= update_cycles) {
> 		cycle_offset -= update_cycles;
> 		last_update += update_cycles;
> 		// at init: system_update = update_cycles * mult;
> 		system_time += system_update;
> 		xtime += [tick_nsec, time_adj];
> 	}

Hmm. An issue cropped up when I started working on this: It seems its
prone to time inconsistencies. 

One of the bug issues with my work is that we consistently accumulate
time in the exact same manner that we use it when calculating
gettimeofday.

That is:
	gettimeofday():
		xtime + cyc2ns(timesource, ntp_adj, cycle_delta)

	periodic_hook():
		interval = cyc2ns(timesource, ntp_adj, cycle_delta)
		xtime += interval
		...

Since we accumulate the entire interval using the same ntp_adjustment,
we ensure that time will not go briefly backwards around a call to
periodic_hook().

In the case above, you're accumulating in fixed cycle intervals. This
does avoid having to do the mult/shift combo each interrupt, however
since you do not accumulate the entire interval, and there is some
sub-tick remainder in cycle_offset. We have to ensure that that sub-tick
remainder is accumulated at the next interrupt using the same ntp
adjustment it would use in a call to gettimeofday() just prior to this
interrupt.


Not yet sure how to get around that issue. I'll keep working on it, and
maybe you might be able to shed some light on it?

thanks
-john


