Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269822AbUICWIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269822AbUICWIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 18:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269828AbUICWIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 18:08:18 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:45003 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269822AbUICWHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 18:07:16 -0400
Date: Fri, 3 Sep 2004 15:04:26 -0700 (PDT)
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
In-Reply-To: <1094245233.14662.602.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409031444580.13729@schroedinger.engr.sgi.com>
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
 <1094245233.14662.602.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, john stultz wrote:

> > The raw values in user space can be used for specialized purposes
> > (somewhat like a generalized form of HPET) by applicationbs. This is not
> > intended for real system time.
>
> I worry these specialized interfaces would become troubling to maintain.
> The kernel (via regular syscall, fsyscall, or vsyscall) should provide
> accurate time and should be the final authority for that.
>
> If specialized applications want to read the cycle counter (TSC, ITC),
> /dev/HPET or /dev/mem or whatever, and try to infer time that's fine but
> its at their own risk. When those specialized assumptions break (TSC
> being fixed freq, for example) its the applications' problem. The kernel
> shouldn't codify or encourage those sorts of risky interfaces by
> exporting frequency information in a standardized interface.

How can a timer have a variable frequency and being used for
timing purposes. Maybe I just do not understand the point on TSC having a
fixed frequency (I certainly hope so but is that true in the power save
modes?).

True it is the applications problem if it breaks but we have applications
for SGI systems that demand access to a time source with the least
operating system interference possible.

> > > cyc2ns(): In this conversion we can optimize the math depending on the
> > > timesource. If the timesource freq is a power of 2, we can just use
> > > shift! However if its a weird value and we have to be very precise, we
> > > do a full 64bit divide. We're not stuck with one equation given a freq
> > > value.
> >
> > I have never seeen a timesource freq with the power of 2. Division is not
> > necessary since one can realize this by multiplying with a certain factor
> > and then shifting the result right instead of dividing.
>
> Well, it was a theoretical example, but I agree with your point. The
> math tricks you suggest are usable depending on the frequency of the
> timesource. Attaching that sort of logic to the timesource
> implementation gives us more flexibility. It could be that the
> flexibility is unnecessary, and if so I'm fine w/ changing the design,
> but I'm not confident of that just yet.

s/depending on/independent of/ ???

Are there any examples where the flexibility is needed?

> > > delta(): Some counters don't fill 32 or 64 bits. ACPI PM time source is
> > > 24 bits, and the cyclone is 40. Thus to do proper twos complement
> > > subtraction without overflow worries you need to mask the subtraction.
> > > This can be done by exporting a mask value w/ the freq value, but was
> > > cleaner when moved into the timesource.
> >
> > I would suggest it is better to add this mask and avoid another call to
> > a tiny function that does simply mask and subtract. Note that compilers
> > are more efficient if they get a sufficiently large chunk of code. This is
> > in particular necessary on IA64 and other processors given the inherent
> > parallelism in their internal CPU. A function call is typically much
> > slower than a subtract and and operation.
>
> Yep. As I said before, you've got very good points. The delta() function
> is the one I'm least attached to, but for now I'm going to hang on to it
> for readability reasons. It will be simple to change to a mask value
> later after everyone has reviewed the code and is confident of its
> correctness.

Are you sure about that readability argument? A single
statement to calculate the delta is much more readable and verifyable
to be correct than a gazillion of small functions that (one  hopes and
prays) all do the same correctly.

> > > read(): Rather then just giving the address of the register, the read
> > > call allows for timesource specific logic. This lets us use jiffies as a
> > > timesource, or in cases like the ACPI PM timesource, where the register
> > > must be read 3 times in order to ensure a correct value is latched, we
> > > can avoid having to include that logic into the generic code, so it does
> > > not affect systems that do not use or have that timesource.
> >
> > I think it is essential to have the capability to use a function. But
> > nevertheless it is quite inefficient to have yet another small function
> > that simply reads a value from a memory location. What I proposed is to be
> > able to specify a memory location in the time source structure. That way
> > this function call can be avoided for most timer source. Any specialized
> > time source will be able to use a function call but will then not be as
> > fast as the time sources that can simply setup a memory address.
>
> I really do like the time_interpolator changes you've submitted in
> earlier threads. The core generalizing of timesources changes are very
> similar between our two implementations, so your comments are very
> important to me. I am open to adding these direct memory accessors to
> the time counters, but again its a performance optimization, and right
> now clarity is king.

Clarity is gained by centralizing these things. The design results in
numerous functions that are defined and which all mostly do the same. For
clarities sake please change the spec....

> Yep, performance and scalability is *very* important. However
> correctness is even more important, and right now we have enough trouble
> with just that. All of the arch specific performance hacks have
> complicated the current code such that minor changes in other subsystems
> (sometimes not so) subtly break things. Untangling these quirks have
> been a large part of what I and many others have worked on for the last
> few years. So for correctness sake we do have to balance clarity and
> performance. Minimizing trade-offs is my goal right now.

Performance as well as clarify as well as arch independence really
demand that these small functions be given up.

> > Of course I am skimming by some additional detail like the mask. But this
> > would cut down significantly on the code piece to be maintained. From what
> > I can see my approach saves a lot of duplicated code. The duplication that
> > may exist comes about because of architecture specific time access
> > optimizations.
>
> Well, I realize this is just a simple sketch, but how do you then handle
> cpu freq changes? Suddenly generic code has to deal with that as well?
> And then there's those buggy time sources that have to be read multiple
> times, or drifty ITCs that (may or maynot) need cmpxchgs to ensure they
> do not go backwards. Making the generic code have to deal with all of
> these cases will be ugly (and may even hurt performance).

The reading from memory only works for well behaved time sources. If
something unusual comes along then a function needs to be called and thus
a performance hit is taken. If its important enough (like the drifty
logic on IA64) then one may consider putting that logic into the
generic code. I did not not say not to have functions at all. I think a
function call must be possible at least to retrieve the timer value for
special cases.

If the CPU freq cases is to be handled by the generic code or a special
function is a design decision that you probably have to make. Over time
other logic will develop that may first show up as new time retrieval
function but that is then recognized to be of universal importance so that
it will then be moved into the generic code.

> Clearly, you've said that function calls should be available in those
> cases, so I don't want to miss-characterize you comments. However I do
> want to point it out so that others keep in mind that you can't always
> just give a pointer and a freq value.

Exactly.
