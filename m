Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269886AbUIDND2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269886AbUIDND2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 09:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269916AbUIDND2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 09:03:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:58771 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269886AbUIDNDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 09:03:19 -0400
Date: Sat, 4 Sep 2004 15:00:22 +0200
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       tim@physik3.uni-rostock.de, george anzinger <george@mvista.com>,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
Message-ID: <20040904130022.GB21912@wotan.suse.de>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> <20040903151710.GB12956@wotan.suse.de> <1094242317.14662.556.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094242317.14662.556.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 01:11:58PM -0700, john stultz wrote:
> The timeofday_hook (should be timeofday_interrupt_hook, my bad) is
> called by the semi-periodic-irregular-interval(also known as "timer")
> interrupt. Its what does the housekeeping for all the timeofday code so
> we don't run into a counter overflow. 
> 
> monotonic_clock() is an accessor that returns the amount of time that
> has been accumulated since boot in nanoseconds. 

Ok, but you need different low level drivers for those.  The TSC is not
stable enough as a long term time source, but it is best&fastest for
the offset calculation between timer interrupts.

Or you would need to make the single driver handle both TSC
and HPET/PIT, which would probably defeat the extensibility of
the new architecture. Even in that case you would need different
read() calls.


> > 
> > Hmm, I am missing something here, but how do you handle
> > the case where the timer interrupt uses HPET, but the offset
> > from last timer interrupt is determined using TSC.  But
> > some machines don't have a reliable TSC, so it may need
> > to use a different "offset" source.
> > 
> > I guess you would need two different drivers here? 
> 
> Not really, this is very doable. Time of day is now completely isolated
> from the timer interrupt code, so it doesn't care who calls the
> timeofday_interrupt_hook (HPET's interrupt or the i8253's interrupt
> could do it). Also it doesn't have to be regular or exact, just frequent
> enough that the timesource doesn't overflow.

I am not talking about the interrupt source here, just from which
time source xtime is refreshed.

> 
> > > o vsyscalls/userspace gettimeofday()
> > > 	- Mark functions and data w/  __vsyscall attribute
> > > 	- Use linker to put all __vsyscall data in the same set of pages
> > 
> > That won't work because the kernel needs to write to 
> > these variables (e.g. to update the wall time from the interrupt
> > handler). So in general you need two different mappings, one
> > read only for user space and another writable one for the kernel.
> 
> Well, I was thinking about this and I don't see why the kernel and
> userspace can't share the same data and functions for read only access?

For reading only kernel & user could probably share, although
you may run into some interesting problems on architecturs
that use truly different "segments" for user and kernel space
(like sparc64 or m68k or possibly s390) 

> Why exactly does it need to be mapped twice? We only write to the data
> from kernel mode using different functions, so the same symbols should
> be usable. 

The kernel needs to write too. And at least on x86 there
is no way to make a page read only for user space and writable
for kernel space on the same mapping.

> the simplest way to use ANY time source, no matter how strange.
> cycle_t's are basically magic cookies given by the timesource that can
> be manipulated generically and converted into nanoseconds. It is likely
> an over-virtualization, but I'd prefer to keep things general and
> flexible until more arch maintainers tell me its unnecessary.

Sounds like a redundancy with the cputime type the s390 people did.
I don't think we should have two ADTs who do such similar things.

-Andi
