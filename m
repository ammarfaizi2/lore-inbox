Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269851AbUICXEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269851AbUICXEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 19:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269938AbUICXEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 19:04:41 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:44223 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269851AbUICXEf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 19:04:35 -0400
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
In-Reply-To: <Pine.LNX.4.58.0409031444580.13729@schroedinger.engr.sgi.com>
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
	 <Pine.LNX.4.58.0409031444580.13729@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1094252402.29408.35.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 03 Sep 2004 16:00:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 15:04, Christoph Lameter wrote:
> On Fri, 3 Sep 2004, john stultz wrote:
> > > The raw values in user space can be used for specialized purposes
> > > (somewhat like a generalized form of HPET) by applicationbs. This is not
> > > intended for real system time.
> >
> > I worry these specialized interfaces would become troubling to maintain.
> > The kernel (via regular syscall, fsyscall, or vsyscall) should provide
> > accurate time and should be the final authority for that.
> >
> > If specialized applications want to read the cycle counter (TSC, ITC),
> > /dev/HPET or /dev/mem or whatever, and try to infer time that's fine but
> > its at their own risk. When those specialized assumptions break (TSC
> > being fixed freq, for example) its the applications' problem. The kernel
> > shouldn't codify or encourage those sorts of risky interfaces by
> > exporting frequency information in a standardized interface.
> 
> How can a timer have a variable frequency and being used for
> timing purposes. Maybe I just do not understand the point on TSC having a
> fixed frequency (I certainly hope so but is that true in the power save
> modes?).

TSC frequency changes are a reality i386 has been living with for awhile
now. In some cases, there isn't anything else that is performant enough
to use as a timesource, so people want to be able to generate time as
accurately as possible from a variable frequency counter. Me, I think
its somewhat crazy, but I've got to make it work.

> True it is the applications problem if it breaks but we have applications
> for SGI systems that demand access to a time source with the least
> operating system interference possible.

Yep, totally fine with that. If application developers will take the
risk that's fine. Personally, I'd like the kernel's timeofday function
to be fast enough that developers don't feel the need to attempt these
special case hacks, but there will always be folks who need to live on
the edge.


> > > > cyc2ns(): In this conversion we can optimize the math depending on the
> > > > timesource. If the timesource freq is a power of 2, we can just use
> > > > shift! However if its a weird value and we have to be very precise, we
> > > > do a full 64bit divide. We're not stuck with one equation given a freq
> > > > value.
> > >
> > > I have never seeen a timesource freq with the power of 2. Division is not
> > > necessary since one can realize this by multiplying with a certain factor
> > > and then shifting the result right instead of dividing.
> >
> > Well, it was a theoretical example, but I agree with your point. The
> > math tricks you suggest are usable depending on the frequency of the
> > timesource. Attaching that sort of logic to the timesource
> > implementation gives us more flexibility. It could be that the
> > flexibility is unnecessary, and if so I'm fine w/ changing the design,
> > but I'm not confident of that just yet.
> 
> s/depending on/independent of/ ???
> 
> Are there any examples where the flexibility is needed?

I'm a fan of Barbie's law: "Math is hard, let's go shopping!", so
forgive my inability to immediately see through the details. In dealing
with both high and low res timesources (some with microsecond
frequencies, some run in picosecond frequencies), the math can be tuned
for each case. Low res time sources are mainly a multiply, and possibly
a divide only if it has a non-integer nanosecond per cycle value. For
high-res timesources, we have to divide, so we would want to aproximate
the frequency and use the multiply and shift as you suggested earlier. 

Maybe this is completely able to be generalized and I'm just not sharp
enough to see it just yet, but it seems to me that having a timesource
specific cyc2ns allows for further optimization then without.

> > > > delta(): Some counters don't fill 32 or 64 bits. ACPI PM time source is
> > > > 24 bits, and the cyclone is 40. Thus to do proper twos complement
> > > > subtraction without overflow worries you need to mask the subtraction.
> > > > This can be done by exporting a mask value w/ the freq value, but was
> > > > cleaner when moved into the timesource.
> > >
> > > I would suggest it is better to add this mask and avoid another call to
> > > a tiny function that does simply mask and subtract. Note that compilers
> > > are more efficient if they get a sufficiently large chunk of code. This is
> > > in particular necessary on IA64 and other processors given the inherent
> > > parallelism in their internal CPU. A function call is typically much
> > > slower than a subtract and and operation.
> >
> > Yep. As I said before, you've got very good points. The delta() function
> > is the one I'm least attached to, but for now I'm going to hang on to it
> > for readability reasons. It will be simple to change to a mask value
> > later after everyone has reviewed the code and is confident of its
> > correctness.
> 
> Are you sure about that readability argument? A single
> statement to calculate the delta is much more readable and verifyable
> to be correct than a gazillion of small functions that (one  hopes and
> prays) all do the same correctly.

Your point is valid, and in moving the arch specific code into arch
independent code, I'm largely trying to reduce the tangle of functions.
Having 3 hardware specific functions isn't all that crazy.

> > > > read(): Rather then just giving the address of the register, the read
> > > > call allows for timesource specific logic. This lets us use jiffies as a
> > > > timesource, or in cases like the ACPI PM timesource, where the register
> > > > must be read 3 times in order to ensure a correct value is latched, we
> > > > can avoid having to include that logic into the generic code, so it does
> > > > not affect systems that do not use or have that timesource.
> > >
> > > I think it is essential to have the capability to use a function. But
> > > nevertheless it is quite inefficient to have yet another small function
> > > that simply reads a value from a memory location. What I proposed is to be
> > > able to specify a memory location in the time source structure. That way
> > > this function call can be avoided for most timer source. Any specialized
> > > time source will be able to use a function call but will then not be as
> > > fast as the time sources that can simply setup a memory address.
> >
> > I really do like the time_interpolator changes you've submitted in
> > earlier threads. The core generalizing of timesources changes are very
> > similar between our two implementations, so your comments are very
> > important to me. I am open to adding these direct memory accessors to
> > the time counters, but again its a performance optimization, and right
> > now clarity is king.
> 
> Clarity is gained by centralizing these things. The design results in
> numerous functions that are defined and which all mostly do the same. For
> clarities sake please change the spec....

I disagree, but that doesn't mean I'm right. If more people complain as
the patch develops, I'll rectify the code so it is less confusing.
There's no reason for such a hard line at this point. The code is in no
way close to finished, or entering the kernel, so give me a chance to
roll with it for a bit. I'm just wary of premature optimization traps. 

Worse case if we cannot come to some agreement on this, there's nothing
stopping architectures from keeping their own timeofday subsystem. I'm
just tired of implementing the same feature or fixing the same bug over
and over and over for each arch.

thanks
-john

