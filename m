Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbSJJMPe>; Thu, 10 Oct 2002 08:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSJJMPe>; Thu, 10 Oct 2002 08:15:34 -0400
Received: from holomorphy.com ([66.224.33.161]:37865 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262295AbSJJMPc>;
	Thu, 10 Oct 2002 08:15:32 -0400
Date: Thu, 10 Oct 2002 05:17:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: mingo@redhat.com, johnstul@us.ibm.com,
       James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.41 multiprocessor vs. CONFIG_X86_TSC
Message-ID: <20021010121757.GY12432@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Adam J. Richter" <adam@yggdrasil.com>, mingo@redhat.com,
	johnstul@us.ibm.com, James.Bottomley@HansenPartnership.com,
	linux-kernel@vger.kernel.org
References: <20021010050212.A383@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010050212.A383@baldur.yggdrasil.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	When I attempted to boot 2.5.40 and 2.5.41 on an x86
> multiprocessor that booted 2.5.34 , I got an infinite loop
> "APIC error on CPU1: 08(08)".
> 
On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> 	The cause of this loop was that syncrhonize_tsc_bp in
> arch/i386/kernel/smpboot.c would attempt a calculation that involved
> dividing by fast_gettimeoffset_quotient, a value that was only set if
> CONFIG_X86_TSC was defined.  This resulted in a divide by zero trap,
> which left some interrupt handling in a funky a state, which resulted
> in the repeating error message.
> 	There are two bugs that this problem exposed:

Division by zero also occurs in simulators with slow enough simulated
clock rates.


On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> 	1. Running on an x86 multiprocessor now requires a CPU with the
> 	   Time Stamp Counter feature, apparently a feature of Pentium I
> 	   and later.  Sequent made 386 and 486(?) multiprocessor systems,
> 	   but I don't know if they or any other 386 or 486 multiprocessors
> 	   can run Linux.  If they can, then this problem really should be
> 	   nailed, which I have not yet done.

IIRC Unisys made some of these as well, and I'm not sure which processor
revisions the Voyager did its stuff on but I'm not entirely sure they had
TSC's. I'm not aware of any directly supported by Linux aside from
perhaps Voyager.


On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> 	2. CONFIG_X86_TSC is used inconsistently.  In some cases it means
> 	   "Assume TSC" and its absense means "check cpu_has_tsc at run
> 	   time", but parts of arch/i386/time.c were treating its absense
> 	   as meaning "assume TSC is not present."  The result was that when
> 	   I tried to boot a kernel that could run on a 386, time.c assumed
> 	   TSC was not present and did left fast_gettimeoffset_quotient as
> 	   zero, resulting in the divide by zero in the APIC initialization.

I get nightmarish TSC drift over here but not that blatant of a failure.
nm that.

On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> 	The following preliminary fixes arch/i386/time.c so that the
> absense of CONFIG_X86_TSC just means "check cpu_has_tsc."  I have also
> attached matching changes for a couple of other places where
> CONFIG_X86_TSC was checked, but those changes are not necessary to
> allow of a kernel that can boot on both 386's and multiprocessors.

I'd love to see the whole TSC sync fiasco dead on my boxen.


On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> 	I would appreciate feedback on the following questions:
> 	1. Do we still want a CONFIG_X86_TSC compile-time option?
> 	   We already have a boot time argument to tell the kernel to
> 	   assume the TSC is bad.  The only quasi-critical paths that
> 	   an "if (cpu_has_tsc)" would be in would be in the
> 	   include/net/profile.h macros and some DRM drivers that call
> 	   get_cycles().

No comment. I don't know about this stuff.


On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> 	2. Are there x86 multiprocessors that Linux runs on that lack the
> 	   Time Stamp Counter feature?  If so, I would welcome any
> 	   suggestions or requests on how best to fix arch/i386/smpboot.c.

It's useless on NUMA-Q. The assumption is that they're synchronized and
it's infeasible to synchronize them without elaborate fixup machinery
on the things, which can at best fake it.

wrt. Voyager et al. James Bottomley is the right person to ask.

As far as active development on NUMA-Q and x440 in the timer arena goes,
John Stultz knows best.


On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> 	3. Is there anything else I should change in these patches?  I was
> 	   thinking of doing "#define cpu_has_tsc 1" if CONFIG_X86_TSC
> 	   is set.

Ask John Stultz. He's itching to get something changed here, though I
must confess I don't understand all the issues myself.


On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> 	4. I would like to first submit my changes to arch/i386/time.c,
> 	   as they are sufficient to allow for a Linux kernel that can
> 	   both on 386 and on virtually all real world multiprocessors,
> 	   and would be included in every way that I can imaging addressing
> 	   this problem.  Any objections this step?

I would love to see -something- done here. Coordinating with John Stultz
would help a lot here, he is very in tune with the issues I (and my
cohorts) have to deal with on NUMA-Q and x440, the former of which has
various field installations to support, and the latter of which, while
it is already distributed, has some progress yet to be made wrt. Linux
support in mainline kernels. I would even go so far to say as that he
is much more knowledgable wrt. timer issues overall here.

Basically I just let the apps break when they're broken and the kernel
doesn't seem to die too horribly when the TSC's are total garbage, but
I'm very eager to see a real solution, and I'm not directly involved in
providing it aside from having to run a box needing the stuff.


Thanks,
Bill
