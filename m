Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269558AbUICBjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269558AbUICBjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269557AbUICBjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:39:14 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:57049 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269532AbUICBe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:34:59 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0409021737310.6412@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021512360.28532@schroedinger.engr.sgi.com>
	 <1094164096.14662.345.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021536450.28532@schroedinger.engr.sgi.com>
	 <1094166858.14662.367.camel@cog.beaverton.ibm.com>
	 <B6E8046E1E28D34EB815A11AC8CA312902CF6059@mtv-atc-605e--n.corp.sgi.com>
	 <1094170054.14662.391.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021737310.6412@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1094175004.14662.440.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 18:30:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 17:47, Christoph Lameter wrote:
> On Thu, 2 Sep 2004, john stultz wrote:
> 
> > > Of course but its not a generic way of timer acccess and
> > > requires a fastcall for each timer. You still have the problem of
> > > exporting the frequency and the time offsets to user space (those also
> > > need to be kept current in order for one to be able to calculate a timer
> > > value!). The syscall/fastcall API then needs to be extended to allow for a
> > > system call to access each of the individual timers supported.
> >
> > Indeed, it would require a fastcall accessor for each timesource, but
> > maybe fastcall is the wrong way to describe it. Could it just be a
> > function that uses the epc to escalate its privileges? As for freq and
> > offsets, those would already be user-visible (see below for more
> > details)
> 
> The only way curent way to enter the kernel from glibc with a fastcall is
> the EPC.

Hmm. I must be explaining myself poorly, or not understanding you. I
apologize for not understanding this EPC/fastcall business well enough.
I'd like to use EPC from a user-executable kernel page to escalate
privileges to access the hardware counter. I don't care if I have to use
the the current fastcall (fsys.S) interface or not. However you're
making sounds like this isn't possible, so I'll need to do some
research. 

> > The plan at the moment is that the timeofday core gettimeofday code path
> > as well as any timesource that supports it adds a _vsyscall linker
> > attribute. Then the linker will place all the code on a special page or
> > set of pages. Those pages would then be mapped in as user-readable. Then
> > just like the x86-64's vsyscall gettimeofday, glibc would re-direct
> > gettimeofday calls to the user-mapped kernel pages, where it would
> > execute in user mode (with maybe the epc privilege escalation for ia64
> > time sources that required it).
> 
> The EPC call already does do a *secure* transfer like this on IA64 and
> will execute kernel code without user space mapping. This idea raises all sorts
> of concerns....

Yes, but its not portable. Reducing duplicate code so timeofday
maintenance isn't a nightmare is the first goal here. It may not be
completely achievable, and when I hit that point I'll have to rework the
design, but at this point I'm not convinced that it cannot be done.

As for security concerns, all your mapping out to userspace are the time
variables and the functions needed to convert those to a accurate time
of day. This is almost what you suggest below, but with the additional
math from the kernel. The method I'm suggesting is very similar to
x86-64's arch/x86-64/kernel/vsyscall.c.


> > I had to do most of this for the i386 vsyscall-gettimeofday port, but I
> > was unhappy with the duplication of code (and bugs), as well as the fact
> > that I was then being pushed to re-do it for each architecture. While
> > its not currently implemented (I was hoping to keep the discussion
> > focused on the correctness of what's been implemented), I feel the plan
> > for user-mode access won't be too complex. I'm still open for further
> > discussion if you'd like, obviously performance is quite important, and
> > I want to calm any fears you have, but I'm sure the new ntp code plenty
> > of performance issues to look at before we start digging into usermode
> > access, so maybe we can come back to this discussion later?
> 
> The functions in the timer source structure is a central problem for IA64. We
> cannot take that out right now.

Don't worry I'm not submitting this code just yet. :) I'll need all (or
at least most of the important) architecture maintainers to sign on
before I try to push this code in.

Right now I'm trying to shake out possible problems with the design and
the first pass implementation of the code. You're helping me do that,
and I thank you for it. Concessions will be made, but for now I'm going
to try to preserve the current design and work around the problems as
they arise. 


> The full parameterization of timer access as I have suggested also allows
> user page access to timers with simply mapping a page to access the timer.
> No other gimmicks are needed since the timer source structure contains all
> information to calculate a timer offset.
> 
> > Yes, but x86-64 has one way, and ia64 does it another, and i know ppc
> > folks have talked about their own user mode time access. Chasing down a
> > time bug across arches gets to be fairly hairy, so I'm trying to
> > simplify that.
> 
> The simplest thins is to provide a data structure without any functions
> attached that can simply be copied into userspace if wanted. If an arch
> needs special time access then that is depending on the arch specific
> methods available and such a data structure as I have proposed will
> include all the info necessary to implement such user mode time access.

Ehhh.. I really don't like the idea of giving all the raw values to
userspace and letting user-code do the timeofday calculation. Fixing
bugs in each arches timeofday code is hard enough. Imagine if we have to
go through and fix userspace too! It would also make a user/kernel data
interface that we'd have to preserve. I'd like to avoid that and instead
use the vsyscall method to give us greater flexibility. Plus I doubt
anyone would want to implement the NTP adjustments in userspace? eek!

> A requirement to call functions in the kernel to determine time makes
> these solution impossible. And its getting extremely complex if one has to
> invoke different functions for each timer supported.

The struct timesource interface of read()/delta()/cyc2ns() was the best
generalization I could come up with. I feel they're necessary for the
following reasons:
	
cyc2ns(): In this conversion we can optimize the math depending on the
timesource. If the timesource freq is a power of 2, we can just use
shift! However if its a weird value and we have to be very precise, we
do a full 64bit divide. We're not stuck with one equation given a freq
value.

delta(): Some counters don't fill 32 or 64 bits. ACPI PM time source is
24 bits, and the cyclone is 40. Thus to do proper twos complement
subtraction without overflow worries you need to mask the subtraction.
This can be done by exporting a mask value w/ the freq value, but was
cleaner when moved into the timesource. 

read(): Rather then just giving the address of the register, the read
call allows for timesource specific logic. This lets us use jiffies as a
timesource, or in cases like the ACPI PM timesource, where the register
must be read 3 times in order to ensure a correct value is latched, we
can avoid having to include that logic into the generic code, so it does
not affect systems that do not use or have that timesource.

But I doubt I'll convince you with words, so let me work on it a bit and
see if I can code around your concerns and put you at ease. You've
brought up some good issues, and I'll definitely work to resolve them! 

Thanks again!
-john


