Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268255AbUICVGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbUICVGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUICVGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:06:48 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44935 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262279AbUICVE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:04:59 -0400
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
In-Reply-To: <Pine.LNX.4.58.0409030854480.10947@schroedinger.engr.sgi.com>
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
	 <Pine.LNX.4.58.0409030854480.10947@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1094245233.14662.602.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 03 Sep 2004 14:00:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 09:18, Christoph Lameter wrote:
> On Thu, 2 Sep 2004, john stultz wrote:
> > > The simplest thins is to provide a data structure without any functions
> > > attached that can simply be copied into userspace if wanted. If an arch
> > > needs special time access then that is depending on the arch specific
> > > methods available and such a data structure as I have proposed will
> > > include all the info necessary to implement such user mode time access.
> >
> > Ehhh.. I really don't like the idea of giving all the raw values to
> > userspace and letting user-code do the timeofday calculation. Fixing
> > bugs in each arches timeofday code is hard enough. Imagine if we have to
> > go through and fix userspace too! It would also make a user/kernel data
> > interface that we'd have to preserve. I'd like to avoid that and instead
> > use the vsyscall method to give us greater flexibility. Plus I doubt
> > anyone would want to implement the NTP adjustments in userspace? eek!
> 
> The raw values in user space can be used for specialized purposes
> (somewhat like a generalized form of HPET) by applicationbs. This is not
> intended for real system time.

I worry these specialized interfaces would become troubling to maintain.
The kernel (via regular syscall, fsyscall, or vsyscall) should provide
accurate time and should be the final authority for that. 

If specialized applications want to read the cycle counter (TSC, ITC),
/dev/HPET or /dev/mem or whatever, and try to infer time that's fine but
its at their own risk. When those specialized assumptions break (TSC
being fixed freq, for example) its the applications' problem. The kernel
shouldn't codify or encourage those sorts of risky interfaces by
exporting frequency information in a standardized interface.


> > cyc2ns(): In this conversion we can optimize the math depending on the
> > timesource. If the timesource freq is a power of 2, we can just use
> > shift! However if its a weird value and we have to be very precise, we
> > do a full 64bit divide. We're not stuck with one equation given a freq
> > value.
> 
> I have never seeen a timesource freq with the power of 2. Division is not
> necessary since one can realize this by multiplying with a certain factor
> and then shifting the result right instead of dividing.

Well, it was a theoretical example, but I agree with your point. The
math tricks you suggest are usable depending on the frequency of the
timesource. Attaching that sort of logic to the timesource
implementation gives us more flexibility. It could be that the
flexibility is unnecessary, and if so I'm fine w/ changing the design,
but I'm not confident of that just yet.

> > delta(): Some counters don't fill 32 or 64 bits. ACPI PM time source is
> > 24 bits, and the cyclone is 40. Thus to do proper twos complement
> > subtraction without overflow worries you need to mask the subtraction.
> > This can be done by exporting a mask value w/ the freq value, but was
> > cleaner when moved into the timesource.
> 
> I would suggest it is better to add this mask and avoid another call to
> a tiny function that does simply mask and subtract. Note that compilers
> are more efficient if they get a sufficiently large chunk of code. This is
> in particular necessary on IA64 and other processors given the inherent
> parallelism in their internal CPU. A function call is typically much
> slower than a subtract and and operation.

Yep. As I said before, you've got very good points. The delta() function
is the one I'm least attached to, but for now I'm going to hang on to it
for readability reasons. It will be simple to change to a mask value
later after everyone has reviewed the code and is confident of its
correctness. 

> > read(): Rather then just giving the address of the register, the read
> > call allows for timesource specific logic. This lets us use jiffies as a
> > timesource, or in cases like the ACPI PM timesource, where the register
> > must be read 3 times in order to ensure a correct value is latched, we
> > can avoid having to include that logic into the generic code, so it does
> > not affect systems that do not use or have that timesource.
> 
> I think it is essential to have the capability to use a function. But
> nevertheless it is quite inefficient to have yet another small function
> that simply reads a value from a memory location. What I proposed is to be
> able to specify a memory location in the time source structure. That way
> this function call can be avoided for most timer source. Any specialized
> time source will be able to use a function call but will then not be as
> fast as the time sources that can simply setup a memory address.

I really do like the time_interpolator changes you've submitted in
earlier threads. The core generalizing of timesources changes are very
similar between our two implementations, so your comments are very
important to me. I am open to adding these direct memory accessors to
the time counters, but again its a performance optimization, and right
now clarity is king.

> > But I doubt I'll convince you with words, so let me work on it a bit and
> > see if I can code around your concerns and put you at ease. You've
> > brought up some good issues, and I'll definitely work to resolve them!
> 
> Oh. I think this is good in terms of clarifying the issues. I did not
> realize that these capabilities that you proposed to use existed. My main
> concern here is efficient and scalable access to time. The ideal solution
> is one routine that can run straight through with minimal locking and
> simply do it all for most cases. The seqlock approach takes care of the
> locking.

Yep, performance and scalability is *very* important. However
correctness is even more important, and right now we have enough trouble
with just that. All of the arch specific performance hacks have
complicated the current code such that minor changes in other subsystems
(sometimes not so) subtly break things. Untangling these quirks have
been a large part of what I and many others have worked on for the last
few years. So for correctness sake we do have to balance clarity and
performance. Minimizing trade-offs is my goal right now. 

I'm starting to feel like I'm just being repetitious, so I'll try to
move on now. Sorry for the long-winded emails.

> Also with the ability to specify parameter instead of functions, one could
> easily setup a timer with a single function call like f.e.
> 
> 
> setup_timer(TIME_SOURCE_CPU,NULL, 1500000)
> 
> or
> 
> setup_timer(TIME_SOURCE_MMIO64, &timer, 4000000)
>
> Of course I am skimming by some additional detail like the mask. But this
> would cut down significantly on the code piece to be maintained. From what
> I can see my approach saves a lot of duplicated code. The duplication that
> may exist comes about because of architecture specific time access
> optimizations.

Well, I realize this is just a simple sketch, but how do you then handle
cpu freq changes? Suddenly generic code has to deal with that as well?
And then there's those buggy time sources that have to be read multiple
times, or drifty ITCs that (may or maynot) need cmpxchgs to ensure they
do not go backwards. Making the generic code have to deal with all of
these cases will be ugly (and may even hurt performance). 

Clearly, you've said that function calls should be available in those
cases, so I don't want to miss-characterize you comments. However I do
want to point it out so that others keep in mind that you can't always
just give a pointer and a freq value.

Once again, I thank you and everyone else for the great comments!
Hopefully I'll get more arch hooks in soon so you and others can
actually start playing with (and hopefully improving) the code. 

thanks
-john

