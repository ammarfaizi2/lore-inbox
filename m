Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269994AbUIDANq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269994AbUIDANq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269995AbUIDANq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:13:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58535 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269994AbUIDANi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:13:38 -0400
Date: Fri, 3 Sep 2004 17:11:37 -0700 (PDT)
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
In-Reply-To: <1094252402.29408.35.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409031701260.14714@schroedinger.engr.sgi.com>
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
 <1094252402.29408.35.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, john stultz wrote:

> > True it is the applications problem if it breaks but we have applications
> > for SGI systems that demand access to a time source with the least
> > operating system interference possible.
>
> Yep, totally fine with that. If application developers will take the
> risk that's fine. Personally, I'd like the kernel's timeofday function
> to be fast enough that developers don't feel the need to attempt these
> special case hacks, but there will always be folks who need to live on
> the edge.

Yeah. I tuned the gettimeofday function on IA64 to be faster than the
glibc's use of the ITC but there are still some voices that demand a memory mapped
timer.

> > Are there any examples where the flexibility is needed?
>
> I'm a fan of Barbie's law: "Math is hard, let's go shopping!", so
> forgive my inability to immediately see through the details. In dealing
> with both high and low res timesources (some with microsecond
> frequencies, some run in picosecond frequencies), the math can be tuned
> for each case. Low res time sources are mainly a multiply, and possibly
> a divide only if it has a non-integer nanosecond per cycle value. For
> high-res timesources, we have to divide, so we would want to aproximate
> the frequency and use the multiply and shift as you suggested earlier.

A division can always be avoided. This is the equation

nanoseconds = x / y * timer_value

where x/y = scaling factor

and one can always set Y = 2^py to substitute a shift instead of
doing division. Just scale  x also appropriately by 2^px. This works to an
arbitrary accuracy if one has a long enough integer type. That is why I
suggested at least the intermediate use of 128bit. 64bit is fine for the
current cases but I would expect a need for 128bit to arise in the
future.

Math is sometimes simple and may simplify a lot of things.

> Maybe this is completely able to be generalized and I'm just not sharp
> enough to see it just yet, but it seems to me that having a timesource
> specific cyc2ns allows for further optimization then without.

I have not encountered a case that could not be handled by the above
mentioned transformation. Mathematically I would think I could say it is
impossible to find such a case.

> > Are you sure about that readability argument? A single
> > statement to calculate the delta is much more readable and verifyable
> > to be correct than a gazillion of small functions that (one  hopes and
> > prays) all do the same correctly.
>
> Your point is valid, and in moving the arch specific code into arch
> independent code, I'm largely trying to reduce the tangle of functions.
> Having 3 hardware specific functions isn't all that crazy.

I would rather have only one (the read timer function) and that function
would be optional for non-well-behaved timer sources.

> Worse case if we cannot come to some agreement on this, there's nothing
> stopping architectures from keeping their own timeofday subsystem. I'm
> just tired of implementing the same feature or fixing the same bug over
> and over and over for each arch.

These are all good reasons for centralizing the functionality instead of
dispersing it in many functions.
