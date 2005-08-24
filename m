Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVHXUgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVHXUgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVHXUgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:36:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28927 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932156AbVHXUgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:36:12 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: george@mvista.com
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <430BBF82.2010209@mvista.com>
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
	 <1124838847.20617.11.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508240134050.3743@scrub.home> <430BBF82.2010209@mvista.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 13:36:06 -0700
Message-Id: <1124915766.20820.67.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 17:29 -0700, George Anzinger wrote:
> Roman Zippel wrote:
> > Hi,
> > 
> > On Tue, 23 Aug 2005, john stultz wrote:
> > 
> > 
> >>I'm assuming gettimeofday()/clock_gettime() looks something like:
> >>   xtime + (get_cycles()-last_update)*(mult+ntp_adj)>>shift
> > 
> > 
> > Where did you get the ntp_adj from? It's not in my example.
> > gettimeofday() was in the previous mail: "xtime + (cycle_offset * mult +
> > error) >> shift". The difference between system time and reference 
> > time is really important. gettimeofday() returns the system time, NTP 
> > controls the reference time and these two are synchronized regularly.
> > I didn't see that anywhere in your example.
> > 

> If I read your example right, the problem is when the NTP adjustment 
> changes while the two clocks are out of sync (because of a late tick). 

Not quite. The issue that I'm trying to describe is that if, we
inconsistently calculate time intervals in gettimeofday and the timer
interrupt, we have the possibility for time inconsistencies.

The trivial example using the current code would be something like:

Again with my 2 cyc per tick clock, HZ=1000.

gettimeofday():
	xtime + offset_ns

timer_interrupt:
	xtime += tick_length + ntp_adj
	offset_ns = 0

0:  gettimeofday:  0 + 0 = 0 ns
1:  gettimeofday:  0 + 500k ns = 500k ns
2:  gettimeofday:  0 + 1M ns = 1M ns
2:  timer_interrupt:  
2:  gettimeofday:  1M ns + 0 ns = 1M ns
3:  gettimeofday:  1M ns + 500k ns = 1.5M ns
4:  gettimeofday:  1M ns + 1M ns = 2 ns
4:  timer_interrupt (using -500ppm adjustment)
4:  gettimeofday:  1,999,500 ns + 0 ns = 1,999,500 ns



> It would appear that gettimeofday would need to know that the NTP 
> adjustment is changing  (and to what).  It would also appear that this 
> is known by the ntp code and could be made available to gettimeofday. 
> If it is changing due to an NTP call, that system call, itself, 
> should/must force synchronization.  So the only case gettimeofday needs 
> to worry/know about is that an adjustment is to change at time X to 
> value Y.  Also, me thinks there is only one such change that can be 
> present at any given time.

Well, in many arches gettimeofday() works around the above issue by
capping the offset_ns value as such:

gettimeofday:
	xtime + min(offset_ns, tick_len + ntp_adj)

The problem with this is that when we have lost or late ticks, or if we
are using dynamic ticks you have granularity problems.


thanks
-john




