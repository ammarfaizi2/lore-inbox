Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUIIUyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUIIUyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUIIUyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:54:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2034 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266139AbUIIUxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:53:35 -0400
Message-ID: <4140C1ED.4040505@mvista.com>
Date: Thu, 09 Sep 2004 13:49:49 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Christoph Lameter <clameter@sgi.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>	 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>	 <41381C2D.7080207@mvista.com>	 <1094239673.14662.510.camel@cog.beaverton.ibm.com>	 <4138EBE5.2080205@mvista.com>	 <1094254342.29408.64.camel@cog.beaverton.ibm.com>	 <41390622.2010602@mvista.com>	 <1094666844.29408.67.camel@cog.beaverton.ibm.com>	 <413F9F17.5010904@mvista.com>	 <1094691118.29408.102.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com>	 <1094700768.29408.124.camel@cog.beaverton.ibm.com>	 <413FDC9F.1030409@mvista.com> <1094756870.29408.157.camel@cog.beaverton.ibm.com>
In-Reply-To: <1094756870.29408.157.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2004-09-08 at 21:31, George Anzinger wrote:
> 
>>john stultz wrote:
>>
>>>I'm not sure about the busy wait bit, but yes, at some point I'd like to
>>>see the timer subsystem use the timeofday subsystem instead of jiffies
>>>for its timekeeping. 
>>>
>>
>>Yes, I think this is the way we want to go.  Here are the "rubs" I see:
>>
>>a.) resolution.  If you don't put a limit on this you will invite timer storms. 
>>  Currently, by using 1/HZ resolution, all timer "line up" on ticks and reduce 
>>the interrupt overhead that would occur if we actually tried to give "exactly" 
>>what was asked for.  This is a matter of math and can be handled (assuming we 
>>resist the urge to go shopping :))
> 
> 
> Well, basically we have the same resolution as we do today. Right now
> you specify the time in jiffies which has different resolutions
> depending on configuration, so I'm not sure I see the problem. I mean, I
> guess someone could be off put when they ask for a 1 ns expiration time
> and it returns in 1 ms, but I thought timers followed sleep() semantics,
> so it shouldn't be that much of an issue.  

What we get down to here is setting up a tick source that depends on the clock. 
  This issue of resolution, as I said, is easy to solve.
> 
> 
>>b.) For those platforms with repeating timers that can not "hit" our desired 
>>resolution (i.e. 1/HZ) there is an additional overhead to program the timer each 
>>interrupt.   In principle we do this in the HRT patch, but there we only do it 
>>for high resolution timers, which we assume are rather rare.  It is good to have 
>>a low res timer that is also accurate.  Even better if we can keep the overhead 
>>low by not having to reprogram a timer each tick.
>>
>>In the ideal world we would have a hardware repeating timer that is reasonably 
>>accurate (we might want to correct it every second or so) to generate the low 
>>res timing interrupts and a high res timer that we can program quickly for high 
>>resolution interrupts.
> 
> 
> Even in this case, inaccurate hardware timers can only cause a single
> tick jitter. The current problem we're seeing is that the timer
> inaccuracy accumulates, so if we're 1% off, a sleep(600) returns 6
> seconds late. Using the time source instead of jiffies for expiration
> would avoid the accumulation, so we'd be at most a single tick late.
> 
> Or is the problem more subtle?

No, I think you have it.  The x86 problem, in this regard, is that the "clock" 
xtal is only connected to the pm timer and the PIT, both of which are slow to 
access (not to mention all the hardware errors).  The x86 TSC is driven by 
another xtal which, to the best of my knowledge, is not a "clock" grade xtal. 
We also don't know what the actual TSC frequency is, thus the calibration loop.

What we get down to, and what others have said, is that the TSC is great for 
interpolation but bad as a long term clock.

I suspect that a time solution that required us to reprogram the PIT each tick 
would not fly, just because of the access overhead.  One that required 
reprogramming the PIT every second or so _might_ be ok.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

