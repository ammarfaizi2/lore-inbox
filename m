Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269242AbUIIARc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbUIIARc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 20:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUIIARc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 20:17:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10230 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269242AbUIIAMo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 20:12:44 -0400
Message-ID: <413F9F17.5010904@mvista.com>
Date: Wed, 08 Sep 2004 17:08:55 -0700
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
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>	 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>	 <41381C2D.7080207@mvista.com>	 <1094239673.14662.510.camel@cog.beaverton.ibm.com>	 <4138EBE5.2080205@mvista.com>	 <1094254342.29408.64.camel@cog.beaverton.ibm.com>	 <41390622.2010602@mvista.com> <1094666844.29408.67.camel@cog.beaverton.ibm.com>
In-Reply-To: <1094666844.29408.67.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Fri, 2004-09-03 at 17:02, George Anzinger wrote:
> 
>>>Again, monotonic_clock() and friends are NTP adjusted, so drift caused
>>>by inaccurate calibration shouldn't be a problem the interval timer code
>>>should need to worry about (outside of maybe adjusting its interval time
>>>if its always arriving late/early). If possible the timesource
>>>calibration code should be improved, but that's icing on the cake and
>>>isn't critical.
>>>
>>
>>Are you providing a way to predict what clock count provide a given time offset 
>>INCLUDING ntp?  If so, cool.  If not we need to get this conversion right.  We 
>>will go into this more on your return.
> 
> 
> Sorry, I'm not sure what you mean. Mind expanding on the idea while my
> brain warms back up?

The issue is this:  A user wants a timer to fire at exactly time B which is 
several hours later than now (time A).  We need to know how to measure this time 
with the timer resources (not the clock as you are talking about it).  Currently 
we do something like delta_jiffies = timespec_to_jiffies(B - A) and set up a 
jiffies timer to expire in delta_jiffies.  At this time we "assume" in 
timespec_to_jiffies() that we _know_ how long a jiffie is in terms of wall clock 
nanoseconds.  We also assume (possibly incorrectly) that this number is "good 
enough" even with ntp messing things up.  I think this means that we assume 
that, on the average, we have the right conversion and that any drift will be a) 
small and b) on the average 0 (or real close to it).

To my mind this is a few too many assumptions, but this is what we do today.  If 
you are proposing that ntp corrections take care of systemic constant drift 
(which by the way, linux use to do WRT HZ=1024 division errors), we will need a 
way of working this back into the timesepec_to_jiffies() code or we will not be 
able to do timers with any real accuracy.

An alternative, and one that I prefer, but, I think, runs counter to your 
proposal, is to derive the timer interrupts from the clock after the ntp 
correction.  Some hardware will have a problem with this (x86) but other 
hardware is rather constrained to do things this way.  The PPC counter interrupt 
generator, for example, counts the same pulses as the clock counter.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

