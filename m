Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269868AbUICWPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269868AbUICWPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 18:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269873AbUICWPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 18:15:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:6137 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269868AbUICWOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 18:14:30 -0400
Message-ID: <4138EBE5.2080205@mvista.com>
Date: Fri, 03 Sep 2004 15:10:45 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>	 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>	 <41381C2D.7080207@mvista.com> <1094239673.14662.510.camel@cog.beaverton.ibm.com>
In-Reply-To: <1094239673.14662.510.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Fri, 2004-09-03 at 00:24, George Anzinger wrote:
> 
>>Albert Cahalan wrote:
>>
>>>On Thu, 2004-09-02 at 21:39, George Anzinger wrote:
>>>
>>>
>>>>john stultz wrote:
>>>
>>>
>>>>>+
>>>>>+static nsec_t jiffies_cyc2ns(cycle_t cyc, cycle_t* remainder)
>>>>>+{
>>>>>+
>>>>>+	cyc *= NSEC_PER_SEC/HZ;
>>>>
>>>>Hm... This assumes that 1/HZ is what is needed here.  Today this value is 
>>>>999898.  Not exactly reachable by NSEC_PER_SEC/HZ.  Or did I miss something, 
>>>>like the relationship of jiffie to 1/HZ and to real time.
>>>
>>>
>>>HZ not being HZ is the source of many foul problems.
>>>
>>>NTP should be able to correct for the error. For systems
>>>not running NTP, provide a fake NTP to make corrections
>>>based on the expected frequency error.
>>>
>>>Based on that, skip or double-up on the ticks to make
>>>them be exactly HZ over long periods of time.
>>
>>There are several problems here.  First, to make this possible, you will have to 
>>outlaw several values for HZ (1024 comes to mind).  Second, like it or not, 1/HZ 
>>or something close to it, is the timer resolution.  I think we need to try and 
>>keep this a power of 10, mostly because there are a lot of folks who just don't 
>>understand it if it is not.  And third, you need to get real close to it with 
>>the hardware timer.  If you introduce NTP or some such to fix things, well, 
>>things just break another place.  For example, we started 2.6 with HZ=1000 and 
>>had problems like:
>> > time sleep 10
>>sleeping for 9.9 seconds.  This will just not do.  Any corrections made to the 
>>wall clock really need to be made to the timer system as well.  As it is we 
>>assume that, by correctly choosing the tick value, the wall clock will be 
>>correct on average, even under NTP.  I.e. that the NTP correction will be, over 
>>time, very small.  We really do want code that is much more accurate than "time 
>>sleep 10" to be right, i.e. if we sleep for x nanoseconds, the wall clock will 
>>have changed by x nanoseconds while we did so.
> 
> 
> I feel trying to keep two notions of time, one in the timeofday code and
> one in the timer code is the real issue. Trying to better keep them
> synced will just lead to madness. Instead the timer subsystem needs to
> move to using monotonic_clock(), or get_lowres_timestamp() instead of
> using jiffies for its notion of time. Jiffies is just an interrupt
> counter. 

Well, there may be a better way.  Suppose we change all the accounting code to 
work with nanoseconds.  That way when we do an accounting pass we would just add 
what has elapsed since the last pass.  Still need some way to do user timers 
that are tightly pegged to the clock.

A thought I had along these lines was to program a timer for each tick.  The PIT 
is much too slow for this, but the APIC timers seem to be rather easy to 
program.  I am not sure how fast the access is but it can not be anything like 
the PIT.  Under this scheme we would use the monotonic clock to figure out just 
how far out the next tick should be and program that.

This could be modified to use repeating hardware if it is available.  (What does 
the HPET provide?  Does it interrupt?)  Since the APIC clock is not the 
reference clock (the PIT & pm timer clock is) we would have to correct these 
from time to time but that is rather easy (I do it today in HRT code).

This brings up another issue.  We know what the PIT clock frequency is but not 
what the TSC clock frequency.  Currently we do a calibration run at boot to 
figure this but I can easily show that this run consistently gives the wrong 
answer (I am sure this has to do with the I/O access delays).  If we are going 
to use the TSC (or any other "clock" that is not derived from the PITs 
14.3181818MHZ ital) we need both a way to get the correct value AND a way to 
adjust it for drift over time.  (Possibly this is the same thing.)  Of course 
this is all just x86 stuff.  Other archs will have their own issues.

For what its worth, the current 2.6 HRT patch uses the PIT as the 1/HZ time 
interrupt.  It uses the APIC, if present, for the high-res interrupt source.



-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

