Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUIOIG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUIOIG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 04:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUIOIGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 04:06:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42992 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263743AbUIOIGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 04:06:44 -0400
Message-ID: <4147F774.6000800@mvista.com>
Date: Wed, 15 Sep 2004 01:04:04 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: john stultz <johnstul@us.ibm.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>  <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>  <41381C2D.7080207@mvista.com>  <1094239673.14662.510.camel@cog.beaverton.ibm.com>  <4138EBE5.2080205@mvista.com>  <1094254342.29408.64.camel@cog.beaverton.ibm.com>  <41390622.2010602@mvista.com>  <1094666844.29408.67.camel@cog.beaverton.ibm.com>  <413F9F17.5010904@mvista.com>  <1094691118.29408.102.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com>  <1094700768.29408.124.camel@cog.beaverton.ibm.com>  <413FDC9F.1030409@mvista.com>  <1094756870.29408.157.camel@cog.beaverton.ibm.com>  <4140C1ED.4040505@mvista.com>  <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com> <1095114307.29408.285.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0409141045370.6963@schroedinger.engr.sgi.com> <41479369.6020506@mvista.com> <Pine.LNX.4.58.0409142024270.10739@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409142024270.10739@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 14 Sep 2004, George Anzinger wrote:
> 
> 
>>>u64 time_source_to_ns(u64 x) {
>>>	return (((x-time_source_at_base) & time_source->mask)*time_source->multiply) >> time_source->shift;
>>>}
>>
>>This seems to assume that the time souce is incrementing.  On some archs, I
>>think, it decrements...
> 
> 
> This could be handled by a function that transforms the value read from
> the counter into an incrementing value. I.e.
> 
> u64 get_rev_timerval(void) {
> 	return  1<< 55 - readq(TIMER_PORT);
> }
> 
> 
>>So we would do "time_adjust_skip(0);" to update time_source_at_base?
> 
> 
> There is no reason to update time_source_at_base unless adjustments need
> to be done or a danger exists of the counter wrapping around (16 bit
> counter?)

Yes, for example the pm counter is 24 bits.  A lot of platforms have 32 bit 
counters...
> 
> 
>>If we do a "good" job of choosing <multiply> and <shift> this will be a "very"
>>small change.  Might be better to pass in a "delta" to change it by.  Then you
>>would only need one function.
> 
> 
> These are the raw routines. Higher level function could translate a delta
> into the appropriate adjustments.
> 
> 
>>The mask and the shift value are not really related.  The mask is a function of
>>the number of bits the hardware provides.  The shift is related to the value of
>>freq.  Me thinks they should not be tied together here.
> 
> 
> They are related because the maximum shift for a 64 bit value without
> loosing bits is 64 - number of significant bits. This basically insures
> maximum precision when scaling the counter.

Lets assume the pm counter which has 24 bits.  This means your shift is 40 bits. 
  In "s->multiply = (NSEC_PER_SEC << s->shift) / freq;" you will have an overflow.
Here you need to keep (NSEC_PER_SEC << s->shift) in 64 bits AND multiply must 
also be 32 bits or less.  I really don't think you can choose the scale so easily.
> 
> 
> 
>>>/* Values in use in the kernel and how they may be derived from xtime */
>>>#define jiffies (now()/1000000)
>>
>>This assumes HZ=1000.  (Assuming there is an HZ any more, that is.)  Not all
>>archs will want this value.  Possibly:
>>#define jiffies ((now() * HZ) / 1000000000)
> 
> 
> Right. I just thought of the standard case HZ=1000.
> 
> 
>>>u64 get_cpu_time_filtered() {
>>>	u64 x;
>>>	u64 l;
>>
>>This will need to be "static";
> 
> 
> Nope. time_source_last is the global. l is just a copy of
> time_source_last.

Right, I miss read the function.  cycles() should be now() if I am reading this 
right.
> 
> 
>>Ok, so now lets hook this up with interval timers:
>>
>>#define ns_per_jiffie (NSEC_PER_SEC / HZ)
>>#define jiffies_to_ns(jiff) (jiff * ns_per_jiffie)
>>
>>This function is a request to interrupt at the next jiffie after the passed
>>reference jiffie.  If that time is passed return true, else false.
> 
> 
> One could do this but we want to have a tickless system. The tick is only
> necessary if the time needs to be adjusted.

I really think a tickless system, for other than UML systems, is a loosing 
thing.  The accounting overhead on context switch (which increases as the number 
of switchs per second) will cause more overhead than a periodic accounting tick 
once a respectable load appears.  The periodic accounting tick has a flat 
overhead that does not depend on load.
> 
> But you are right there is the need for timer event scheduling that is
> not included yet. This should be a method of the time source.
> 
I am not sure that is the right thing to do here.  For example, on SMP systems 
today we have a timer event interrupt per cpu.  This is much more scaleable and 
not so easy to do if we tie it to the time source.  All we need is a reasonably 
accurate short term counter.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

