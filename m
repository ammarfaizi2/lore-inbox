Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269813AbUICUWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269813AbUICUWB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269782AbUICUSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:18:00 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:62394 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269770AbUICUQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:16:28 -0400
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, paulus@samba.org,
       schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <20040903151710.GB12956@wotan.suse.de>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <20040903151710.GB12956@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1094242317.14662.556.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 03 Sep 2004 13:11:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 08:17, Andi Kleen wrote:
> On Thu, Sep 02, 2004 at 02:07:19PM -0700, john stultz wrote:
> > timeofday_hook()
> > 	now = read();			/* read the timesource */
> > 	ns = cyc2ns(now - offset_base); /* calc nsecs since last call */
> > 	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
> > 	system_time += ntp_ns;		/* add scaled value to system_time */
> > 	ntp_advance(ns);		/* advance ntp state machine by ns */
> > 	offset_base = now;		/* set new offset_base */
> > 
> > monotonic_clock()
> > 	now = read();			/* read the timesource */
> > 	ns = cyc2ns(now - offset_base);	/* calculate nsecs since last hook */
> > 	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
> > 	return system_time + ntp_ns; 	/* return system_time and scaled value
> 
> 
> I am not sure why you have different hooks for timeofday and monotic.
> It may be better to read the timeonly once and then convert to monotonic
> or TOD.

You might be a bit confused:
The timeofday_hook (should be timeofday_interrupt_hook, my bad) is
called by the semi-periodic-irregular-interval(also known as "timer")
interrupt. Its what does the housekeeping for all the timeofday code so
we don't run into a counter overflow. 

monotonic_clock() is an accessor that returns the amount of time that
has been accumulated since boot in nanoseconds. 

do_timeofday() is also an accessor which uses monotonic_clock +
wall_time_offset to calculate wall time.


> > 					 */
> > 
> > settimeofday(desired)
> > 	wall_offset = desired - monotonic_clock(); /* set wall offset */
> > 
> > gettimeofday()
> > 	return wall_offset + monotonic_clock();	/* return current timeofday */
> 
> 
> Hmm, I am missing something here, but how do you handle
> the case where the timer interrupt uses HPET, but the offset
> from last timer interrupt is determined using TSC.  But
> some machines don't have a reliable TSC, so it may need
> to use a different "offset" source.
> 
> I guess you would need two different drivers here? 

Not really, this is very doable. Time of day is now completely isolated
from the timer interrupt code, so it doesn't care who calls the
timeofday_interrupt_hook (HPET's interrupt or the i8253's interrupt
could do it). Also it doesn't have to be regular or exact, just frequent
enough that the timesource doesn't overflow.

> > o vsyscalls/userspace gettimeofday()
> > 	- Mark functions and data w/  __vsyscall attribute
> > 	- Use linker to put all __vsyscall data in the same set of pages
> 
> That won't work because the kernel needs to write to 
> these variables (e.g. to update the wall time from the interrupt
> handler). So in general you need two different mappings, one
> read only for user space and another writable one for the kernel.

Well, I was thinking about this and I don't see why the kernel and
userspace can't share the same data and functions for read only access?
Why exactly does it need to be mapped twice? We only write to the data
from kernel mode using different functions, so the same symbols should
be usable. 

I could be missing something, and my userspace implementation plans
weigh fairly heavily on this, so do please correct me. 

> Regarding your patch, putting the delta in a virtual call
> seems a bit of overkill. Is that really needed? That was
> just from a quick grep, i haven't read it in detail.

Yep. Christoph point is starting to get to me. I'll probably swap out
delta() for a mask variable do the masking in the generic code. However,
I do feel its a micro-optimization which hurts readability, so I'll put
off that change until later when the code has been thoroughly reviewed. 

I came up with the read/delta/cyc2ns interface after trying to think of
the simplest way to use ANY time source, no matter how strange.
cycle_t's are basically magic cookies given by the timesource that can
be manipulated generically and converted into nanoseconds. It is likely
an over-virtualization, but I'd prefer to keep things general and
flexible until more arch maintainers tell me its unnecessary.

thanks
-john

