Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269334AbUIIEhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269334AbUIIEhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 00:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUIIEhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 00:37:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9726 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269334AbUIIEhm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 00:37:42 -0400
Message-ID: <413FDC9F.1030409@mvista.com>
Date: Wed, 08 Sep 2004 21:31:27 -0700
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
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>	 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>	 <41381C2D.7080207@mvista.com>	 <1094239673.14662.510.camel@cog.beaverton.ibm.com>	 <4138EBE5.2080205@mvista.com>	 <1094254342.29408.64.camel@cog.beaverton.ibm.com>	 <41390622.2010602@mvista.com>	 <1094666844.29408.67.camel@cog.beaverton.ibm.com>	 <413F9F17.5010904@mvista.com>	 <1094691118.29408.102.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com> <1094700768.29408.124.camel@cog.beaverton.ibm.com>
In-Reply-To: <1094700768.29408.124.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2004-09-08 at 20:14, Christoph Lameter wrote:
> 
>>On Wed, 8 Sep 2004, john stultz wrote:
>>
>>
>>>Why must we use jiffies to tell when a timer expires? Honestly I'd like
>>>to see xtime and jiffies both disappear, but I'm not very familiar w/
>>>the soft-timer code, so forgive me if I'm misunderstanding.
>>>
>>>So instead of calculating delta_jiffies, just mark the timer to expire
>>>at B. Then each interrupt, you use get_fast_timestamp() to decide if now
>>>is greater then B. If so, expire it.
>>>
>>>Then we can look at being able to program timer interrupts to occur as
>>>close as possible to the next soft-timer's expiration time.
>>
>>Would it not be best to have some means to determine the time in
>>nanoseconds since the epoch and then use that for long waits? 
> 
> 
> The proposal has get_lowres_timeofday() which does just that, although
> for timer stuff, I would guess monotonic_clock() or
> get_lowres_timestamp(), which returns the number of (ntp adjusted)
> nanoseconds the system has been running, would be better.  
> 
> 
> 
>>One can then calculate the wait time in nanoseconds which may then be
>>passed to another timer routine which may take the appropriate action
>>depending on the time frame involved. I.e. for a few hundred nsecs do busy
>>wait. If longer reschedule and if even longer queue the task on some
>>event queue that is handled by the timer tick or something else.
> 
> 
> I'm not sure about the busy wait bit, but yes, at some point I'd like to
> see the timer subsystem use the timeofday subsystem instead of jiffies
> for its timekeeping. 
> 
Yes, I think this is the way we want to go.  Here are the "rubs" I see:

a.) resolution.  If you don't put a limit on this you will invite timer storms. 
  Currently, by useing 1/HZ resolution, all timer "line up" on ticks and reduce 
the interrupt overhead that would occure if we actually tried to give "exactly" 
what was asked for.  This is a matter of math and can be handled (assuming we 
resist the urge to go shopping :))

b.) For those platforms with repeating timers that can not "hit" our desired 
resolution (i.e. 1/HZ) there is an additional overhead to program the timer each 
interrupt.   In principle we do this in the HRT patch, but there we only do it 
for high resolution timers, which we assume are rather rare.  It is good to have 
a low res timer that is also accurate.  Even better if we can keep the overhead 
low by not having to reprogram a timer each tick.

In the ideal world we would have a hardware repeating timer that is reasonably 
accurate (we might want to correct it every second or so) to generate the low 
res timing interrupts and a high res timer that we can program quickly for high 
resolution interrupts.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

