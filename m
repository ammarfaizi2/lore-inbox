Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVHWXOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVHWXOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVHWXOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:14:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59522 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932487AbVHWXON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:14:13 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508232321530.3728@scrub.home>
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
	 <1124830262.20464.26.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508232321530.3728@scrub.home>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 16:14:07 -0700
Message-Id: <1124838847.20617.11.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 23:34 +0200, Roman Zippel wrote: 
> Hi,
> 
> On Tue, 23 Aug 2005, john stultz wrote:
> 
> > In the case above, you're accumulating in fixed cycle intervals. This
> > does avoid having to do the mult/shift combo each interrupt, however
> > since you do not accumulate the entire interval, and there is some
> > sub-tick remainder in cycle_offset. We have to ensure that that sub-tick
> > remainder is accumulated at the next interrupt using the same ntp
> > adjustment it would use in a call to gettimeofday() just prior to this
> > interrupt.
> 
> Look closer and you'll notice that the cycle_offset remainder isn't lost. :)

I'm not saying its lost, but that it is accumulated differently then how
it would be used in gettimeofday().

So a somewhat lengthy and exaggerated example with a clock that has 2
cycles per milisecond, HZ=1000 and a 0ppm adjustment to begin with.

I'm assuming gettimeofday()/clock_gettime() looks something like:
   xtime + (get_cycles()-last_update)*(mult+ntp_adj)>>shift

Using (1,000,000, 1) for the (mult,shift) pair.

So first, the easy case:

time(0): gettimeofday: 0 + (0 - 0)*(1M+0)>>1 = 0 ns
time(1): gettimeofday: 0 + (1 - 0)*(1M+0)>>1 = 0.5M ns
time(2): gettimeofday: 0 + (2 - 0)*(1M+0)>>1 = 1M ns
time(2): interrupt
time(2): gettimeofday: 1M + (2 - 2)*(1M+0)>>1 = 1M ns
time(3): gettimeofday: 1M + (3 - 2)*(1M+0)>>1 = 1.5M ns


Now, lets look at how we deal with ticks that arrive late:
time(6): gettimeofday: 2M + (6 - 4)*(1M+0)>>1 = 3M ns
time(7): gettimeofday: 2M + (7 - 4)*(1M+0)>>1 = 3.5M ns
time(7): interrupt
time(7): gettimeofday: 3M + (7 - 6)*(1M+0)>>1 = 3.5M ns
time(8): gettimeofday: 3M + (8 - 6)*(1M+0)>>1 = 4M ns

So everything looks ducky. Now on to when we make NTP adjustments.

time(11): gettimeofday: 5M + (11 - 10)*(1M+0)>>1 = 5.5M ns
time(12): gettimeofday: 5M + (12 - 10)*(1M+0)>>1 = 6M ns
time(12): interrupt (set ntp_adj = 1000 ~= 500ppm)
time(12): gettimeofday: 6M + (12 - 12)*(1M+ 1000)>>1 = 6M ns
time(13): gettimeofday: 6M + (13 - 12)*(1M+ 1000)>>1 = 6,500,500 ns
time(14): gettimeofday: 6M + (14 - 12)*(1M+ 1000)>>1 = 7,001,000 ns

Still doing fine. Now lets look at doing NTP adjustments while ticks
arrive late:

time(15): gettimeofday: 7,001k + (15 - 14)*(1M+ 1000)>>1 = 7,501,500 ns
time(16): gettimeofday: 7,001k + (16 - 14)*(1M+ 1000)>>1 = 8,002,000 ns
time(17): gettimeofday: 7,001k + (17 - 14)*(1M+ 1000)>>1 = 8,502,500 ns
time(17): interrupt, (set ntp_adj = 0ppm)
time(17): gettimeofday: 8,002k + (17 - 16)*(1M+ 0)>>1 = 8,502,000 ns


And bang, we have a 500 ns time inconsistency!

And that was only with a tick arriving 1/2 a tick late. I've dealt with
systems that on occasion miss 30ms worth of ticks due to SMI crazyness.

This is why I accumulate the entire interval with NTP adjustments
consistently between the timer tick and gettimeofday. 

Right now I'm not sure how to work around this issue with your proposal,
but let me know if you have an idea or I'm missing some other subtlety.

thanks
-john




