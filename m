Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265677AbSKFO4l>; Wed, 6 Nov 2002 09:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265679AbSKFO4l>; Wed, 6 Nov 2002 09:56:41 -0500
Received: from host194.steeleye.com ([66.206.164.34]:58375 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265677AbSKFO4k>; Wed, 6 Nov 2002 09:56:40 -0500
Message-Id: <200211061503.gA6F3DW02053@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: john stultz <johnstul@us.ibm.com>
cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46 
In-Reply-To: Message from john stultz <johnstul@us.ibm.com> 
   of "05 Nov 2002 18:31:04 PST." <1036549864.6098.76.camel@cog> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Nov 2002 10:03:12 -0500
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

johnstul@us.ibm.com said:
> I'm fine w/ the X86_TSC change, but I'd drop the X86_PIT for now.  

> Then when you boot, boot w/ notsc and you should be fine. 
> I do want to add some sort of TSC blacklisting so one doesn't always
> have to boot w/ notsc if your machine is detectable/
> compiled-exclusively= for. But I've got a few other issues in the
> queue first.  

There are certain architectures (voyager is the only one currently supported, 
but I suspect the Numa machines will have this too) where the TSC cannot be 
used for cross CPU timings because the processors are driven by separate 
clocks and may even have different clock speeds.

What I need is an option simply not to compile in the TSC code and use the PIT 
instead.  What I'm trying to do with the TSC and PIT options is give three 
choices:

1. Don't use TSC (don't compile TSC code): X86_TSC=n, X86_PIT=y

2. May use TSC but check first (blacklist, notsc kernel option).  X86_TSC=y, 
X86_PIT=y

3. TSC is always OK so don't need PIT.  X86_TSC=y, X86_PIT=n

We probably need to make the notsc and dodgy tsc check contingent on X86_PIT 
(or a config option that says we have some other timer mechanism compiled in). 
 Really, the options should probably be handled in timer.c.

Theres also another problem in that the timer_init is called too early in the 
boot sequence to get a message out to the user, so the panic in timers.c about 
not finding a suitable timer will never be seen (the system will just lock up 
on boot).

Do we have an option for a deferred panic that will trip just after we init 
the console and clean out the printk buffer?

> Then make the arch/i386/timers/Makefile change to be something like:
> 
> obj-y := timer.o timer_tsc.o timer_pit.o
> obj-$(CONFIG_X86_TSC)		-= timer_pit.o #does this(-=) work?
> obj-$(CONFIG_X86_CYCYLONE)	+= timer_cyclone.o

Even if it works, the config option style is confusing.  It's easier just to 
have a positive option (CONFIG_X86_PIT) for this.

James



