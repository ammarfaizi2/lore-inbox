Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269285AbUIHSe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269285AbUIHSe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUIHSe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:34:29 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:45446 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269285AbUIHSbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:31:03 -0400
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
In-Reply-To: <20040904130022.GB21912@wotan.suse.de>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <20040903151710.GB12956@wotan.suse.de>
	 <1094242317.14662.556.camel@cog.beaverton.ibm.com>
	 <20040904130022.GB21912@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1094667956.29408.86.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 08 Sep 2004 11:25:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-04 at 06:00, Andi Kleen wrote:
> On Fri, Sep 03, 2004 at 01:11:58PM -0700, john stultz wrote:
> > The timeofday_hook (should be timeofday_interrupt_hook, my bad) is
> > called by the semi-periodic-irregular-interval(also known as "timer")
> > interrupt. Its what does the housekeeping for all the timeofday code so
> > we don't run into a counter overflow. 
> > 
> > monotonic_clock() is an accessor that returns the amount of time that
> > has been accumulated since boot in nanoseconds. 
> 
> Ok, but you need different low level drivers for those.  The TSC is not
> stable enough as a long term time source, but it is best&fastest for
> the offset calculation between timer interrupts.
> 
> Or you would need to make the single driver handle both TSC
> and HPET/PIT, which would probably defeat the extensibility of
> the new architecture. Even in that case you would need different
> read() calls.

Well, actually with this design the TSC, when used, would be the long
term timesource. Interpolating between two timesources (timer ticks and
TSC) is what causes a great deal of the time trouble on i386. You get
into the issue of: "which one do you trust?" (some laptops change freq
w/o notification, while other desktops have buggy interval timers) which
takes us then into the problems lost-tick detection brought up. 

Instead, I'm suggesting we make our best guess, and then select a
timesource to trust. Make it trivial for folks to work around bad
selections (say a buggy HPET shows up, have the user echo "acpi-pm" >
/sysfs/something/timesource, or use the "clock=" boot option), and make
it easy to add blacklist/sanity checking code to the timesource init
functions (so it does the right thing automatically in the next
release). 

So basically, rather then confuse the core code, my plan is to leave it
up to the timesource code to ensure they provide good time. 


> > > Hmm, I am missing something here, but how do you handle
> > > the case where the timer interrupt uses HPET, but the offset
> > > from last timer interrupt is determined using TSC.  But
> > > some machines don't have a reliable TSC, so it may need
> > > to use a different "offset" source.
> > > 
> > > I guess you would need two different drivers here? 
> > 
> > Not really, this is very doable. Time of day is now completely isolated
> > from the timer interrupt code, so it doesn't care who calls the
> > timeofday_interrupt_hook (HPET's interrupt or the i8253's interrupt
> > could do it). Also it doesn't have to be regular or exact, just frequent
> > enough that the timesource doesn't overflow.
> 
> I am not talking about the interrupt source here, just from which
> time source xtime is refreshed.

Well, at the end of the day, the hope is xtime is removed completely and
replaced w/ get_lowres_timestamp()/get_lowres_timeofday().  However,
right now instead of making a patch with thousands of single line
replacements, I'm just updating xtime in timer_interrupt_hook().

I'm not sure if that answers your question, so let me know if I need to
clarify myself further. 

> > > > o vsyscalls/userspace gettimeofday()
> > > > 	- Mark functions and data w/  __vsyscall attribute
> > > > 	- Use linker to put all __vsyscall data in the same set of pages
> > > 
> > > That won't work because the kernel needs to write to 
> > > these variables (e.g. to update the wall time from the interrupt
> > > handler). So in general you need two different mappings, one
> > > read only for user space and another writable one for the kernel.
> > 
> > Well, I was thinking about this and I don't see why the kernel and
> > userspace can't share the same data and functions for read only access?
> 
> For reading only kernel & user could probably share, although
> you may run into some interesting problems on architecturs
> that use truly different "segments" for user and kernel space
> (like sparc64 or m68k or possibly s390) 
> 
> > Why exactly does it need to be mapped twice? We only write to the data
> > from kernel mode using different functions, so the same symbols should
> > be usable. 
> 
> The kernel needs to write too. And at least on x86 there
> is no way to make a page read only for user space and writable
> for kernel space on the same mapping.

Ah! You're right. I was confusing page permission semantics w/ file
permissions (ie: permissions don't affect kernel mode, just user mode). 

That does throw a wrench in the simplicity of my design. I *really*
would like to avoid the extended linker trickery that x86-64 has, but it
may be necessary in the end.

> > the simplest way to use ANY time source, no matter how strange.
> > cycle_t's are basically magic cookies given by the timesource that can
> > be manipulated generically and converted into nanoseconds. It is likely
> > an over-virtualization, but I'd prefer to keep things general and
> > flexible until more arch maintainers tell me its unnecessary.
> 
> Sounds like a redundancy with the cputime type the s390 people did.
> I don't think we should have two ADTs who do such similar things.

Hmm. I should look into that. Thanks for the heads up.

And once again, thanks for the feedback.
-john

