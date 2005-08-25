Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVHYBon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVHYBon (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 21:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVHYBon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 21:44:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25077 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932479AbVHYBon
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 21:44:43 -0400
Message-ID: <430D227D.2070001@mvista.com>
Date: Wed, 24 Aug 2005 18:44:29 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.61.0508162337130.3728@scrub.home>	 <1124241449.8630.137.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.61.0508182213100.3728@scrub.home>	 <1124505151.22195.78.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.61.0508202204240.3728@scrub.home>	 <1124737075.22195.114.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.61.0508230134210.3728@scrub.home>	 <1124830262.20464.26.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.61.0508232321530.3728@scrub.home>	 <1124838847.20617.11.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.61.0508240134050.3743@scrub.home> <430BBF82.2010209@mvista.com>	 <1124915766.20820.67.camel@cog.beaverton.ibm.com>	 <430D06D0.4080904@mvista.com> <1124930555.20820.132.camel@cog.beaverton.ibm.com>
In-Reply-To: <1124930555.20820.132.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2005-08-24 at 16:46 -0700, George Anzinger wrote:
> 
>>john stultz wrote:
>>
>>>On Tue, 2005-08-23 at 17:29 -0700, George Anzinger wrote:
>>>
>>>
>>>>Roman Zippel wrote:
>>>>
>>>>
>>>>>Hi,
>>>>>
>>>>>On Tue, 23 Aug 2005, john stultz wrote:
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>I'm assuming gettimeofday()/clock_gettime() looks something like:
>>>>>> xtime + (get_cycles()-last_update)*(mult+ntp_adj)>>shift
>>>>>
>>>>>
>>>>>Where did you get the ntp_adj from? It's not in my example.
>>>>>gettimeofday() was in the previous mail: "xtime + (cycle_offset * mult +
>>>>>error) >> shift". The difference between system time and reference 
>>>>>time is really important. gettimeofday() returns the system time, NTP 
>>>>>controls the reference time and these two are synchronized regularly.
>>>>>I didn't see that anywhere in your example.
>>>>>
>>>
>>>
>>>>If I read your example right, the problem is when the NTP adjustment 
>>>>changes while the two clocks are out of sync (because of a late tick). 
>>>
>>>
>>>Not quite. The issue that I'm trying to describe is that if, we
>>>inconsistently calculate time intervals in gettimeofday and the timer
>>>interrupt, we have the possibility for time inconsistencies.
>>>
>>>The trivial example using the current code would be something like:
>>>
>>>Again with my 2 cyc per tick clock, HZ=1000.
>>>
>>>gettimeofday():
>>>	xtime + offset_ns
>>>
>>>timer_interrupt:
>>>	xtime += tick_length + ntp_adj
>>>	offset_ns = 0
>>>
>>>0:  gettimeofday:  0 + 0 = 0 ns
>>>1:  gettimeofday:  0 + 500k ns = 500k ns
>>>2:  gettimeofday:  0 + 1M ns = 1M ns
>>>2:  timer_interrupt:  
>>>2:  gettimeofday:  1M ns + 0 ns = 1M ns
>>>3:  gettimeofday:  1M ns + 500k ns = 1.5M ns
>>>4:  gettimeofday:  1M ns + 1M ns = 2 ns
>>>4:  timer_interrupt (using -500ppm adjustment)
>>>4:  gettimeofday:  1,999,500 ns + 0 ns = 1,999,500 ns
>>>
>>
>>At point 4 you are introducing a NEW ntp adjustment.  This, I submit, 
>>needs to actually have been introduced to the system prior to the 
>>interrupt at point 2 with the first xtime change at point 4.  However, 
>>gettimeofday() should be aware of it from the interrupt at point 2 and 
>>be doing corrections from that time forward.  Thus when the point 4 
>>interrutp happens xtime will be the same at the gettimeofday a ns earlier.
> 
> 
> Yes, clearly a forward knowledge of the NTP adjustment is necessary for
> gettimeofday(), because after the NTP adjustment has been accumulated
> into xtime, there's nothing left for gettimeofday to adjust (its already
> been applied). :)
> 
> 
> 
>>Likewise, gettimeofday() needs to know when to stop apply the correction 
>>so that if a tick is late, it will apply the correction only for those 
>>times that it was needed.  This, could be done by figuring the offset 
>>thusly:
>>
>>offset = (offset from last tick to end of ntp period * ntp_adj1) + 
>>(offset from end of ntp period to now)
> 
> 
> Well, in my example, the ntp_adjustment is a fixed nanosecond offset, so
> it would be added to the nanosecond offset from the last tick (which is
> how the current code works). If you are doing scaling (as you have in
> the equation above), then the problem goes away, since you can apply the
> adjustment consistently through any interval.

Until the end of the correction time...
> 
> 
>>I suppose it is possible that the latter part of the offset is also 
>>under a different ntp correction which would mean a "* ntp_adj2" is 
>>needed.  
> 
> 
> Ok, so your forcing gettimeofday to be interval aware, so its applying
> different fixed NTP adjustments to different chunks of the current
> interval. The issue of course is if you're using fixed adjustments, is
> that you have to have n ntp adjustments for n intervals, or you have to
> apply the same ntp adjustment to multiple intervals. 

Uh, are you saying that one ntpd call can set up several different 
adjustments?  I was assuming that any given call would set up either a 
fixed adjustment for ever or a fixed adjustment to be applied for a 
fixed number of ticks (or until so much correcting was done, which, in 
the end is the same thing at this point in the code).

If ntpd has to come back to change the adjustment, I am assuming that 
some kernel action can be taken at that time to sync the xtime clock and 
the gettimeofday reading of it.  I.e. we would only have to keep track 
of one adjustment with a possible pre specified end time.
> 
> 
> 
>>I would argue that only two terms are needed here regardless of 
>>how late a tick is.  This is because, I would expect the ntp system call 
>>to sync the two clocks.  This means in your example, the ntp call would 
>>have been made at, or prior to the timer interrupt at 2 and this is the 
>>same edge that gettimeofday is to used to start applying the correction.
> 
> 
> If you argue that we only need two adjustments, why not argue for only
> one? You're saying have one adjustment that you apply for the first
> tick's worth of time, and a second adjustment that you apply for the
> following N ticks' worth of time in the interval. Why the odd base
> case? 

Correct me if I am wrong here, but I am assuming that ntpd can ask for 
an adjustment of X amount which the kernel changes into N adjustments of 
X/N amount spread over the next N ticks.  This means that, once we have 
done N ticks, we MUST stop doing the correction.  Life would be easier 
if ntpd only asked for rate changes which are to be applied until the 
next ntpd call (which, as I understand it, it can ALSO do).  Of course, 
the issue of missed ticks kicks in here and is the ONLY reason we need 
to do two corrections, i.e. we need only one ntp correction if we have 
not missed a tick.
> 
> 
> 
>>>>It would appear that gettimeofday would need to know that the NTP 
>>>>adjustment is changing  (and to what).  It would also appear that this 
>>>>is known by the ntp code and could be made available to gettimeofday. 
>>>>If it is changing due to an NTP call, that system call, itself, 
>>>>should/must force synchronization.  So the only case gettimeofday needs 
>>>>to worry/know about is that an adjustment is to change at time X to 
>>>>value Y.  Also, me thinks there is only one such change that can be 
>>>>present at any given time.
>>>
>>>
>>>Well, in many arches gettimeofday() works around the above issue by
>>>capping the offset_ns value as such:
>>
>>I think this may have been done with only usec gettimeofday.  Now that 
>>we have clock_gettime() returning nsec, we need to be a bit more careful.
> 
> 
> Indeed.
> 
> thanks
> -john
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
