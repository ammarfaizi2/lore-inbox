Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUEGAfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUEGAfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 20:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUEGAfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 20:35:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5361 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261497AbUEGAfC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 20:35:02 -0400
Message-ID: <409AD95F.8080502@mvista.com>
Date: Thu, 06 May 2004 17:33:35 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>, Andrew Morton <akpm@osdl.org>,
       kaukasoi@elektroni.ee.tut.fi, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
References: <403D0F63.3050101@mvista.com>	 <1077760348.2857.129.camel@cog.beaverton.ibm.com>	 <403E7BEE.9040203@mvista.com>	 <1077837016.2857.171.camel@cog.beaverton.ibm.com>	 <403E8D5B.9040707@mvista.com>	 <1081895880.4705.57.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de>	 <1081967295.4705.96.camel@cog.beaverton.ibm.com>	 <20040415103711.GA320@elektroni.ee.tut.fi>	 <Pine.LNX.4.53.0404151302140.28278@gockel.physik3.uni-rostock.de>	 <20040415161436.GA21613@elektroni.ee.tut.fi>	 <Pine.LNX.4.53.0405011540390.25435@gockel.physik3.uni-rostock.de>	 <20040501184105.2cd1c784.akpm@osdl.org>	 <Pine.LNX.4.53.0405020352480.26994@gockel.physik3.uni-rostock.de>	 <1083638458.9664.134.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.53.0405040804180.2215@gockel.physik3.uni-rostock.de> <1083682764.4324.33.camel@leatherman>
In-Reply-To: <1083682764.4324.33.camel@leatherman>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Mon, 2004-05-03 at 23:12, Tim Schmielau wrote:
> 
>>On Mon, 3 May 2004, john stultz wrote:
>>
>>>	This patch polishes up Tim Schmielau's (tim@physik3.uni-rostock.de) fix
>>>for jiffies_to_clock_t() and jiffies_64_to_clock_t(). The issues
>>>observed was w/ /proc output not matching up to wall time due to
>>>accumulated error caused by HZ not being exactly 1000 on i386 systems.
>>>The solution is to correct that error by using the more accurate
>>>TICK_NSEC in our calculation. 
>>
>>I wonder whether it's conceptually correct to use jiffies for accurate 
>>long-time measurements at all. ntpd is there for a reason. Using both
>>corrected, accurate and freely running clocks IMHO is calling for trouble. 
>>This might be something to think about for 2.7.
> 
> 
> Indeed. Moving away from jiffies as a time counter and more of an
> interrupt counter is important. That allows for implementations of
> variable HZ and other things the high-res timer folks want without
> affecting the time keeping code. 
> 
> Roughly, I'd like to see the time code for all arches in 2.7 to look
> like:
> 
> u64 system_time 	/* NTP adjusted nanosecs since boot */
> u64 wall_time_offset	/* offset to system_time for time of day */
> u64 offset_base		/* last read raw hw value */

Hm.  In 2.6 we use an NTP adjusted wall time and a wall_to_monotonic offset.  I 
don't really see the advantage here.  Does this change buy us something?

For what its worth, I introduced the wall_to_monotonic offset just because it 
was easier to do (and understand, I think) in the current kernel.
> 
> ts_read(): 
>         returns the raw cycle value from the hardware timesource
>         (TSC/ACPI PM/HPET)
> ts_delta(now, then):
>         returns the difference between two raw cycle values
> ts_cyc2ns(cycles):
>         converts a cycle value to ns
> 
> monotonic_clock(): 
>         returns NTP adjusted nanoseconds since boot
>         ie: system_time +
>         	NTP_GUNK(ts_cyc2ns(ts_delta(ts_read(),offset_base)))
> gettimeofday(): 
>         returns monotonic_clock() + sys_time_offset
> settimeofday(): 
>         adjusts only sys_time_offset
> time_interrupt_hook(): 
>         updates system_time. called by timer interrupt atleast once
>         every hardware cycle (ie: before the hardware counter
>         overflows), but otherwise unaffected by lost interrupts, etc.
>         ie: 
>                 then = offset_base
>                 now = ts_read()
>                 system_time += NTP_GUNK(ts_cyc2ns(ts_delta(now, then)));
>                 DO_MORE_NTP_GUNK()
> 
> And ignoring the magic NTP_GUNK macros, that's all there is to it
> (Although don't kid your self, the NTP_GUNK is nasty). 

Right, and it needs to be recast to use secs and nanosecs...  But you forget the 
accounting code which needs the periodic interrupt to charge time to whom ever.
> 
> Of course, with this approach, we actually have to be able to trust the
> hardware 100%. With the current state of i386 hw having serious problems
> w/ reliable timesources, this may be difficult. 

Yes, and there is also a problem getting a stable, reliable, and correct 
calibration of TSC to PIT even with a constant TSC rate.  In the HRT patch I 
finally resorted to correcting the TSC last read value on a regular basis.  With 
out this it drifts (or maybe, more correctly, the calibration was wrong) enough 
to mess up the high res timers.

I suspect that while we use two different timers (PIT & TSC or PIT & pm-timer or 
...) that don't use the same source clock we will continue to have such 
problems.  Other archs have a much easier time of it.
> 
> I've got a bigger proposal (with proper credits to Keith Mannthey and
> George Anzinger for reviews and corrections) that I wrote up awhile
> back, and I'll likely send it out if this sketch gathers any interest.  
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

