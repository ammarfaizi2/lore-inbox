Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVCOXGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVCOXGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVCOXGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:06:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:54776 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262065AbVCOXDq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:03:46 -0500
Message-ID: <4237693A.30300@mvista.com>
Date: Tue, 15 Mar 2005 15:01:14 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Matt Mackall <mpm@selenic.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [topic change] jiffies as a time value
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>	 <20050313004902.GD3163@waste.org>	 <1110825765.30498.370.camel@cog.beaverton.ibm.com>	 <423620EA.3040205@mvista.com> <1110849062.30498.450.camel@cog.beaverton.ibm.com>
In-Reply-To: <1110849062.30498.450.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Mon, 2005-03-14 at 15:40 -0800, George Anzinger wrote:
> 
>>john stultz wrote:
>>
>>>On Sat, 2005-03-12 at 16:49 -0800, Matt Mackall wrote:
>>>
>>>>>+	/* finally, update legacy time values */
>>>>>+	write_seqlock_irqsave(&xtime_lock, x_flags);
>>>>>+	xtime = ns2timespec(system_time + wall_time_offset);
>>>>>+	wall_to_monotonic = ns2timespec(wall_time_offset);
>>>>>+	wall_to_monotonic.tv_sec = -wall_to_monotonic.tv_sec;
>>>>>+	wall_to_monotonic.tv_nsec = -wall_to_monotonic.tv_nsec;
>>>>>+	/* XXX - should jiffies be updated here? */
>>>>
>>>>Excellent question. 
>>>
>>>Indeed.  Currently jiffies is used as both a interrupt counter and a
>>>time unit, and I'm trying make it just the former. If I emulate it then
>>>it stops functioning as a interrupt counter, and if I don't then I'll
>>>probably break assumptions about jiffies being a time unit. So I'm not
>>>sure which is the easiest path to go until all the users of jiffies are
>>>audited for intent. 
>>
>>Really?  Who counts interrupts???  The timer code treats jiffies as a unit of 
>>time.  You will need to rewrite that to make it otherwise.  
> 
> 
> Ug. I'm thin on time this week, so I was hoping to save this discussion
> for later, but I guess we can get into it now.
> 
> Well, assuming timer interrupts actually occur HZ times a second, yes
> one could (and current practice, one does) implicitly interpret jiffies
> as being a valid notion of time.  However with SMIs, bad drivers that
> disable interrupts for too long, and virtualization the reality is that
> that assumption doesn't hold. 
> 
> We do have the lost-ticks compensation code that tries to help this, but
> that conflicts with some virtualization implementations. Suspend/resume
> tries to compensate jiffies for ticks missed over time suspended, but
> I'm not sure how accurate it really is (additionally, looking at it now,
> it assumes jiffies is only 32bits).
> 
> Adding to that, the whole jiffies doesn't really increment at HZ, but
> ACTHZ confusion, or bad drivers that assume HZ=100, we get a fair amount
> of trouble stemming from folks using jiffies as a time value.  Because
> in reality, it is just a interrupt counter.

Well, currently, in x86 systems it causes wall clock to advance a very well 
defined amount.  That it is not exactly 1/HZ is something we need to live with...
> 
> So now, if new timeofday code emulates jiffies, we have to decide if it
> emulates jiffies at HZ or ACTHZ? Also there could be issues with jiffies
> possibly jittering from it being incremented every tick and then set to
> the proper time when the timekeeping code runs. 

I think your overlooking timers.  We have a given resolution for timers and some 
code, at least, expects timers to run with that resolution.  This REQUIRES 
interrupts at resolution frequency.  We can argue about what that interrupt 
event is called (currently a jiffies interrupt) and disparage the fact that 
hardware can not give us "nice" numbers for the resolution, but we do need the 
interrupts.  That there are bad places in the code where interrupts are delayed 
is not really important in this discussion.  For what it worth, the RT patch 
Ingo is working on is getting latencies down in the 10s of microseconds region.

We also need, IMNSHO to recognize that, at lest with some hardware, that 
interrupt IS in fact the clock and is the only reasonable way we have of reading 
it.  This is true, for example, on the x86.  The TSC we use as a fill in for 
between interrupts is not stable in the long term and should only be used to 
interpolate over 1 to 10 ticks or so.
> 
> I'm not sure which is the best way to go, but it sounds that emulating
> it is probably the easiest. I just deferred the question with a comment
> until now because its not completely obvious. Any suggestions on the
> above questions (I'm guessing the answers are: use ACTHZ, and the jitter
> won't hurt that bad). 
> 
> 
>>But then you have 
>>another problem.  To correctly function, times need to expire on time (hay how 
>>bout that) not some time later.  To do this we need an interrupt source.  To 
>>this point in time, the jiffies interrupt has been the indication that one or 
>>more timer may have expired.  While we don't need to "count" the interrupts, we 
>>DO need them to expire the timers AND they need to be on time.
> 
> 
> Well, something Nish Aravamudan has been working on is converting the
> common users of jiffies (drivers) to start using human time units. These
> very well understood units (which avoid HZ/ACTHZ/HZ=100 assumptions) can
> then be accurately changed to jiffies (or possibly some other time unit)
> internally. It would even be possible for soft-timers to expire based
> upon the actual high-res time value, rather then the low-res tick-
> counter(which is something else Nish has been playing with). When that
> occurs we can easily start doing other interesting things that I believe
> you've already been working on in your HRT code, such as changing the
> timer interrupt frequency dynamically, or working with multiple timer
> interrupt sources. 

This is also what is done in things like posix timers.  The fact remains that, 
at least in the posix timers case, the resolution is exported to the user and 
implies certain things.  I am not sure we are explicitly exporting the 
resolution in the kernel, but, down under the code, there is a resolution AND it 
impacts what one should expect of timers.
> 
> So basically, lots of interesting questions and possibilities and I very
> much look forward to your input and suggestions. 
> 
It may help to understand that MOST internal timers (i.e. timers the kernel 
sets) never expire.  They are canceled by the caller because they were really 
"dead man" timers, i.e. "it better happen be this time or we are hurting".

Users, on the other hand, for the most part set up timers to allow bits of code 
to run either periodically or at some specified time.  These are the folks who 
care about latency and being on time.

User also, of course, also use "dead man" timers such as, for example, the time 
out on select.  By their nature the "dead man" timer, usually, does not have 
strict on time requirements.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

