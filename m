Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266058AbSKFTZi>; Wed, 6 Nov 2002 14:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266060AbSKFTZi>; Wed, 6 Nov 2002 14:25:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:27385 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266058AbSKFTZg>; Wed, 6 Nov 2002 14:25:36 -0500
Subject: Re: Voyager subarchitecture for 2.5.46
From: john stultz <johnstul@us.ibm.com>
To: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200211061503.gA6F3DW02053@localhost.localdomain>
References: <200211061503.gA6F3DW02053@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Nov 2002 11:30:38 -0800
Message-Id: <1036611039.6098.126.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 07:03, J.E.J. Bottomley wrote:
> There are certain architectures (voyager is the only one currently supported, 
> but I suspect the Numa machines will have this too) where the TSC cannot be 
> used for cross CPU timings because the processors are driven by separate 
> clocks and may even have different clock speeds.

Yes, I'll confirm your suspicions for some NUMA boxes ;)  The timer_opts
structure was largely created to make it easier to remedy this
situation, allowing alternate time sources to be easily added. 
 
> What I need is an option simply not to compile in the TSC code and use the PIT 
> instead.  What I'm trying to do with the TSC and PIT options is give three 
> choices:
> 
> 1. Don't use TSC (don't compile TSC code): X86_TSC=n, X86_PIT=y
> 
> 2. May use TSC but check first (blacklist, notsc kernel option).  X86_TSC=y, 
> X86_PIT=y
> 
> 3. TSC is always OK so don't need PIT.  X86_TSC=y, X86_PIT=n

Almost all systems are going to want #3. For those that need an
alternate time source (NUMAQ, Voyager, x440, etc) do we really need the
PIT only option(#1)? It can easily be dynamically detected in #2, and
the resulting kernel will run correctly on more machines which makes for
one less special kernel distros have to create/manage.


> Theres also another problem in that the timer_init is called too early in the 
> boot sequence to get a message out to the user, so the panic in timers.c about 
> not finding a suitable timer will never be seen (the system will just lock up 
> on boot).
> 
> Do we have an option for a deferred panic that will trip just after we init 
> the console and clean out the printk buffer?

Yea, I'm actually working on exactly what Alan suggested (timer_none),
to solve this. Thanks for bringing it up though, I occasionally need a
kick in the pants for motivation :) 


> > Then make the arch/i386/timers/Makefile change to be something like:
> > 
> > obj-y := timer.o timer_tsc.o timer_pit.o
> > obj-$(CONFIG_X86_TSC)		-= timer_pit.o #does this(-=) work?
> > obj-$(CONFIG_X86_CYCYLONE)	+= timer_cyclone.o
> 
> Even if it works, the config option style is confusing.  It's easier just to 
> have a positive option (CONFIG_X86_PIT) for this.

I realize that the negative-option that _X86_TSC has become is a bit
confusing, but it is an optimization option, not a feature option. I've
been thinking of something similar to _X86_PIT, but I want to avoid the
PIT only case that you had in your patch, and try to come up with
something that isn't more confusing then what we started with. 

thanks
-john

