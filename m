Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbSJJSYl>; Thu, 10 Oct 2002 14:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbSJJSYl>; Thu, 10 Oct 2002 14:24:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:10960 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261625AbSJJSYj>; Thu, 10 Oct 2002 14:24:39 -0400
Subject: Re: Patch?: linux-2.5.41 multiprocessor vs. CONFIG_X86_TSC
From: john stultz <johnstul@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, mingo@redhat.com,
       James.Bottomley@HansenPartnership.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021010121757.GY12432@holomorphy.com>
References: <20021010050212.A383@baldur.yggdrasil.com> 
	<20021010121757.GY12432@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Oct 2002 11:22:38 -0700
Message-Id: <1034274158.19093.28.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 05:17, William Lee Irwin III wrote:
> On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> > 	1. Running on an x86 multiprocessor now requires a CPU with the
> > 	   Time Stamp Counter feature, apparently a feature of Pentium I
> > 	   and later.  Sequent made 386 and 486(?) multiprocessor systems,
> > 	   but I don't know if they or any other 386 or 486 multiprocessors
> > 	   can run Linux.  If they can, then this problem really should be
> > 	   nailed, which I have not yet done.

Actually, the TSC is only guaranteed to be a valid time source on
uniprocessor machines. Linux tries its best to synchronize the TSCs
across cpus at boot, however larger systems where all the cups are not
driven by the same crystal, the cpu frequency and thus the TSCs will
skew over time. 


> On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> > 	2. CONFIG_X86_TSC is used inconsistently.  In some cases it means
> > 	   "Assume TSC" and its absense means "check cpu_has_tsc at run
> > 	   time", but parts of arch/i386/time.c were treating its absense
> > 	   as meaning "assume TSC is not present."  The result was that when
> > 	   I tried to boot a kernel that could run on a 386, time.c assumed
> > 	   TSC was not present and did left fast_gettimeoffset_quotient as
> > 	   zero, resulting in the divide by zero in the APIC initialization.

Recently its use in 2.5 has changed, and I'll agree it is somewhat
inconsistent. Under 2.4 and earlier 2.5 releases, if CONFIG_X86_TSC was
defined (by compiling for >= Pentium systems), it optimized out the old
PIT based method for do_gettimeofday(). When compiling for i386 systems,
both methods (TSC & PIT) for timeofday calculation were compiled in, and
the TSC was autodetected via cpu_has_tsc(). 

I agree that the recent changes to CONFIG_X86_TSC are confusing,
resulting in an either/or situation. You'll find that in my
timer-changes cleanups (posted yesterday to lkml) to the i386 time.c I
try to preserve the old usage. 


> On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> > 	The following preliminary fixes arch/i386/time.c so that the
> > absense of CONFIG_X86_TSC just means "check cpu_has_tsc."  I have also
> > attached matching changes for a couple of other places where
> > CONFIG_X86_TSC was checked, but those changes are not necessary to
> > allow of a kernel that can boot on both 386's and multiprocessors.
> 
> I'd love to see the whole TSC sync fiasco dead on my boxen.

I'll take a closer look at your patch, but I believe my changes to
better brake up and separate the different time sources make this much
cleaner. And yes, I must concur with Bill, I can only dream of a world
where I'm no longer dealing w/ TSC issues. Someday.....


> On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> > 	I would appreciate feedback on the following questions:
> > 	1. Do we still want a CONFIG_X86_TSC compile-time option?
> > 	   We already have a boot time argument to tell the kernel to
> > 	   assume the TSC is bad.  The only quasi-critical paths that
> > 	   an "if (cpu_has_tsc)" would be in would be in the
> > 	   include/net/profile.h macros and some DRM drivers that call
> > 	   get_cycles().

If people still want to use it to optimize out the old PIT based
do_gettimeoffset, then it probably should stick around. However, I'm not
too attached to it. 

> On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> > 	2. Are there x86 multiprocessors that Linux runs on that lack the
> > 	   Time Stamp Counter feature?  If so, I would welcome any
> > 	   suggestions or requests on how best to fix arch/i386/smpboot.c.
> 
> It's useless on NUMA-Q. The assumption is that they're synchronized and
> it's infeasible to synchronize them without elaborate fixup machinery
> on the things, which can at best fake it.
> 
> wrt. Voyager et al. James Bottomley is the right person to ask.
> 
> As far as active development on NUMA-Q and x440 in the timer arena goes,
> John Stultz knows best.

Yea, NUMA-Q and the x440 both do not have synced TSCs. For the NUMA-Q,
the solution is to boot w/ "notsc" to avoid gettimeofday from talking
crazy. For the x440, I've developed a patch that uses a on-chipset
performance timer for do_gettimeofday, and __delay. Future systems that
implement HPET will probably need similar. 


> On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> > 	3. Is there anything else I should change in these patches?  I was
> > 	   thinking of doing "#define cpu_has_tsc 1" if CONFIG_X86_TSC
> > 	   is set.

ACK! no! cpu_has_tsc checks the TSD bit in CR4 to let us know if the CPU
has a TSC and if it is enabled. The is def. the wrong way to go. Instead
look at #defining tsc_disable instead. 


Alan has a good cleanup patch (included below) for 2.4. that folks might
consider to for 2.5. It helps remove the #ifdefs and lets the compiler
do the optimization. 


> On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> > 	4. I would like to first submit my changes to arch/i386/time.c,
> > 	   as they are sufficient to allow for a Linux kernel that can
> > 	   both on 386 and on virtually all real world multiprocessors,
> > 	   and would be included in every way that I can imaging addressing
> > 	   this problem.  Any objections this step?

Yes, reverting back to the old usage of CONFIG_X86_TSC would be a good
move. Its true that its usage has always been a bit unintuitive, but the
current usage I fear is broken. My timer-changes patch fixes this, but I
wouldn't oppose such a change should my timer-changes patch be delayed
for too long (which hopefully won't be the case). 


> Basically I just let the apps break when they're broken and the kernel
> doesn't seem to die too horribly when the TSC's are total garbage, but
> I'm very eager to see a real solution, and I'm not directly involved in
> providing it aside from having to run a box needing the stuff.

While likely not the core concern voiced in Adam's message, this is a
real problem. Applications that use the TSC directly as a system time
source, rather then a per-cpu counter, will have problems in the future.
Its fine to use with caution for statistical profiling, and whatnot as
Intel suggests. However, applications that go around the OS and try to
glean system time directly from hardware w/o going through the OS's
interfaces are likely to break when the hardware changes subtly. 

thanks
-john

