Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268049AbUICQVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268049AbUICQVD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUICQVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:21:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54468 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268049AbUICQUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:20:24 -0400
Date: Fri, 3 Sep 2004 09:18:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <1094175004.14662.440.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409030854480.10947@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> 
 <1094159379.14662.322.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409021512360.28532@schroedinger.engr.sgi.com> 
 <1094164096.14662.345.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409021536450.28532@schroedinger.engr.sgi.com> 
 <1094166858.14662.367.camel@cog.beaverton.ibm.com> 
 <B6E8046E1E28D34EB815A11AC8CA312902CF6059@mtv-atc-605e--n.corp.sgi.com> 
 <1094170054.14662.391.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409021737310.6412@schroedinger.engr.sgi.com>
 <1094175004.14662.440.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, john stultz wrote:

> > The only way curent way to enter the kernel from glibc with a fastcall is
> > the EPC.
>
> Hmm. I must be explaining myself poorly, or not understanding you. I
> apologize for not understanding this EPC/fastcall business well enough.
> I'd like to use EPC from a user-executable kernel page to escalate
> privileges to access the hardware counter. I don't care if I have to use
> the the current fastcall (fsys.S) interface or not. However you're
> making sounds like this isn't possible, so I'll need to do some
> research.

The mechanism you envision could probably be created on IA64. Its
certainly not available on all platforms and potentially cannot be available.

Also if you want to pursue the approach with functions you need to enter
the kernel at least 3 times(!) in order to call the 3 different functions
you defined in order to determine time. You need to retrieve time, then do
the time diff call then the nanosecond conversion.

> > The EPC call already does do a *secure* transfer like this on IA64 and
> > will execute kernel code without user space mapping. This idea raises all sorts
> > of concerns....
>
> Yes, but its not portable. Reducing duplicate code so timeofday
> maintenance isn't a nightmare is the first goal here. It may not be
> completely achievable, and when I hit that point I'll have to rework the
> design, but at this point I'm not convinced that it cannot be done.

It does not need to be portable since it is an architecture specific
optimization which could be accomplished in variety of ways on other
platforms. The time source information structure could be platform
independent. The architectures can optimize the way they interpret the
timer source information structure without additional calls to kernel
functions.

I would expect the logic for time retrieval not to be subject to much
change. The current ASM for IA64 f.e. would probalby work without change
for your new approach if the time source information would not require
function calls.

However, the proposal makes these optimizations impossible.

> > The simplest thins is to provide a data structure without any functions
> > attached that can simply be copied into userspace if wanted. If an arch
> > needs special time access then that is depending on the arch specific
> > methods available and such a data structure as I have proposed will
> > include all the info necessary to implement such user mode time access.
>
> Ehhh.. I really don't like the idea of giving all the raw values to
> userspace and letting user-code do the timeofday calculation. Fixing
> bugs in each arches timeofday code is hard enough. Imagine if we have to
> go through and fix userspace too! It would also make a user/kernel data
> interface that we'd have to preserve. I'd like to avoid that and instead
> use the vsyscall method to give us greater flexibility. Plus I doubt
> anyone would want to implement the NTP adjustments in userspace? eek!

The raw values in user space can be used for specialized purposes
(somewhat like a generalized form of HPET) by applicationbs. This is not
intended for real system time.

> cyc2ns(): In this conversion we can optimize the math depending on the
> timesource. If the timesource freq is a power of 2, we can just use
> shift! However if its a weird value and we have to be very precise, we
> do a full 64bit divide. We're not stuck with one equation given a freq
> value.

I have never seeen a timesource freq with the power of 2. Division is not
necessary since one can realize this by multiplying with a certain factor
and then shifting the result right instead of dividing.

> delta(): Some counters don't fill 32 or 64 bits. ACPI PM time source is
> 24 bits, and the cyclone is 40. Thus to do proper twos complement
> subtraction without overflow worries you need to mask the subtraction.
> This can be done by exporting a mask value w/ the freq value, but was
> cleaner when moved into the timesource.

I would suggest it is better to add this mask and avoid another call to
a tiny function that does simply mask and subtract. Note that compilers
are more efficient if they get a sufficiently large chunk of code. This is
in particular necessary on IA64 and other processors given the inherent
parallelism in their internal CPU. A function call is typically much
slower than a subtract and and operation.

> read(): Rather then just giving the address of the register, the read
> call allows for timesource specific logic. This lets us use jiffies as a
> timesource, or in cases like the ACPI PM timesource, where the register
> must be read 3 times in order to ensure a correct value is latched, we
> can avoid having to include that logic into the generic code, so it does
> not affect systems that do not use or have that timesource.

I think it is essential to have the capability to use a function. But
nevertheless it is quite inefficient to have yet another small function
that simply reads a value from a memory location. What I proposed is to be
able to specify a memory location in the time source structure. That way
this function call can be avoided for most timer source. Any specialized
time source will be able to use a function call but will then not be as
fast as the time sources that can simply setup a memory address.

> But I doubt I'll convince you with words, so let me work on it a bit and
> see if I can code around your concerns and put you at ease. You've
> brought up some good issues, and I'll definitely work to resolve them!

Oh. I think this is good in terms of clarifying the issues. I did not
realize that these capabilities that you proposed to use existed. My main
concern here is efficient and scalable access to time. The ideal solution
is one routine that can run straight through with minimal locking and
simply do it all for most cases. The seqlock approach takes care of the
locking.

Also with the ability to specify parameter instead of functions, one could
easily setup a timer with a single function call like f.e.


setup_timer(TIME_SOURCE_CPU,NULL, 1500000)

or

setup_timer(TIME_SOURCE_MMIO64, &timer, 4000000)

Of course I am skimming by some additional detail like the mask. But this
would cut down significantly on the code piece to be maintained. From what
I can see my approach saves a lot of duplicated code. The duplication that
may exist comes about because of architecture specific time access
optimizations.

