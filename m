Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTIVUFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbTIVUFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:05:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19262 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263271AbTIVUFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:05:30 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com>
	<1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk>
	<20030922162602.GB27209@mail.jlokier.co.uk>
	<1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk>
	<20030922190054.GC27209@mail.jlokier.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Sep 2003 14:05:15 -0600
In-Reply-To: <20030922190054.GC27209@mail.jlokier.co.uk>
Message-ID: <m1wuc0io78.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> A few architectures define in[bwl]_p & out[bwl]_p differently from
> in[bwl] and out[bwl].  These are:

> 	x86_64
> 		- four methods just like i386

At least until some new chipsets come out I can certify that x86_64
works just fine without the delay.

> Some of the architectures _call_ the _p operators even for some
> architecture-specific devices, even though those operators don't have
> a delay.
> 
> The m68k implementation is nice: it defines a function called
> isa_delay(), which contains the delay which is done after the I/O by
> _p operations.
> 
> IMHO, it would be nice if all architectures simply provided an
> appropriate isa_delay() function, and the _p I/O operators were simply
> removed.  That would make the intent of drivers using those operators
> a little clearer, too.

It certainly removes the magic coupling.


> Devices
> =======
> 
> I think they're all ISA devices, or emulations of them.
> 
> Unfortunately, a _lot_ of drivers in the kernel use the _p I/O
> operators so it's not possible to look for a few special quirky
> devices.  I suspect that in many cases, the _p operators are not
> required but have been used for safety.  There is no harm in this of
> course.
> 
> Alan mentioned the PIT timer chip and keyboard which appear on x86
> machines as being specifically quirky.
> 
> I find it interesting, but awfully difficult to know whether it's
> "correct", that the i386 PIT code uses inb/outb for some operations
> and inb_p/outb_p for some others.
> 

> I'm wondering if there's a way to detect how much udelay is needed on
> a particular board, and reduce or remove it on boards where it isn't
> needed.

Until the problem is more clearly defined I don't think we can
auto-detect.  The best we can do is to have drivers that replace
the legacy drivers when appropriate and don't do the delay.  If the
delay is done with udelay though it does not cause any bus traffic and
another device can be using the bus.

> udelay() is also unreliable nowadays, due to CPUs changing clock
> speeds according to the whims of the BIOS.  On laptops, even the rdtsc
> rate varies.  If the delay is critical to system reliability for
> unknown reasons, then switching to udelay() removes some of that "we
> always did this and it fixed the unknown problems" legacy driver safety

As long as udelay is calibrated at the fast system clock speed we are
ok.  When the clock slows down the delay just increases, which is fine.

> Unfortunately, there are a lot of drivers, and a lot of x86
> arch-specific code, which use the delay operaters.  There's no real
> way to verify that all the drivers are fine when the delay is reduced
> or removed.

We just need something sufficiently good.  If the delay is removed
on a system that needs it someone will complain.
 
> The delay should only be effective for ISA devices.  I wonder if it
> makes sense to separate the delay into an isa_delay() or io_delay()
> function, sprinkled into source where the _p operators currently
> appear, to make it clearer where the delays should appear.
>
> In the i386 floppy driver, for example, it's clear why the delay is
> there in one part of the virtual DMA loop and not the other: to allow
> a device time to propagate a state change.  That also explains the
> need for a delay after writing to port 0x42 of the PIT but not after
> writing port 0x43.  I think calls to isa_delay() would make the intent
> there a little clearer.

I would agree with that.  Although I wonder if we are not mixing up
various delays into one mechanism.  In any event it is a small safe step
forward to entangling this legacy confusion.

Eric
