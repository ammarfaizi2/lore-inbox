Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTIVTBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTIVTBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:01:10 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:34689 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263268AbTIVTA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:00:56 -0400
Date: Mon, 22 Sep 2003 20:00:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Message-ID: <20030922190054.GC27209@mail.jlokier.co.uk>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com> <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk> <20030922162602.GB27209@mail.jlokier.co.uk> <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few architectures define in[bwl]_p & out[bwl]_p differently from
in[bwl] and out[bwl].  These are:

	i386 (all machines)
		- four methods are offered; the normal one is 1 write to port
		  0x80.  The others are selected by manually editing a file.
		- The port 0x80 is hard-coded in assembly language in
		  <asm-i386/floppy.h>, although that code is no longer used.

	m68k
		- A delay is done for some machines.  It is a write
		  to port 0x80.

	MIPS
		- normally disabled, but can be enabled if CONF_SLOWDOWN_IO
		  is manually edited in a file.  It is a write to port
		  0x80.

	PPC64
		- the input operations don't have a delay
		- the output operations have a udelay(1), _before_ the I/O.
		- PPC (32 bit) doesn't have delays at all

	SH (all machines except ec3104)
		- only byte-size access has the delay method,
		  except on the "overdrive" where all sizes have it.
		- delay is done by a special I/O operation,
		  ctrl_inw(0xa0000000)
		- one SH board uses udelay(10) for the delay.
		- another SH board has a funky single delay after
		  insw/insl/outsw/outsl (but not insb/outsb), using a
		  different special I/O, ctrl_inb(0xba000000).

	x86_64
		- four methods just like i386

Some of the architectures _call_ the _p operators even for some
architecture-specific devices, even though those operators don't have
a delay.

The m68k implementation is nice: it defines a function called
isa_delay(), which contains the delay which is done after the I/O by
_p operations.

IMHO, it would be nice if all architectures simply provided an
appropriate isa_delay() function, and the _p I/O operators were simply
removed.  That would make the intent of drivers using those operators
a little clearer, too.


Devices
=======

I think they're all ISA devices, or emulations of them.

Unfortunately, a _lot_ of drivers in the kernel use the _p I/O
operators so it's not possible to look for a few special quirky
devices.  I suspect that in many cases, the _p operators are not
required but have been used for safety.  There is no harm in this of
course.

Alan mentioned the PIT timer chip and keyboard which appear on x86
machines as being specifically quirky.

I find it interesting, but awfully difficult to know whether it's
"correct", that the i386 PIT code uses inb/outb for some operations
and inb_p/outb_p for some others.

Alan Cox wrote:
> On Llu, 2003-09-22 at 17:26, Jamie Lokier wrote:
> > What sort of timer chip problems do you see?  Is it something that can
> > be auto-detected, so that timer chip accesses can be made faster on
> > boards where that is fine?
> 
> CS5520 is one example. Also VIA VP2 seems to care but only very very
> occasionally. On my 386 board its reliably borked without the delays
> (not sure what chipset and its ISA so harder to tell)

Yeah, but what's the problem and can it be detected? :)

> > I've also seen much DOS code that didn't have extra delays for
> > keyboard I/Os.  What sort of breakage did you observe with the
> > keyboard?
> 
> DEC laptops hang is the well known example of that one.
> 
> I'm *for* making this change to udelay, it just has to start up with a
> suitably pessimal udelay assumption until calibrated.

I'm wondering if there's a way to detect how much udelay is needed on
a particular board, and reduce or remove it on boards where it isn't
needed.

udelay() is also unreliable nowadays, due to CPUs changing clock
speeds according to the whims of the BIOS.  On laptops, even the rdtsc
rate varies.  If the delay is critical to system reliability for
unknown reasons, then switching to udelay() removes some of that "we
always did this and it fixed the unknown problems" legacy driver safety

Unfortunately, there are a lot of drivers, and a lot of x86
arch-specific code, which use the delay operaters.  There's no real
way to verify that all the drivers are fine when the delay is reduced
or removed.

The delay should only be effective for ISA devices.  I wonder if it
makes sense to separate the delay into an isa_delay() or io_delay()
function, sprinkled into source where the _p operators currently
appear, to make it clearer where the delays should appear.

In the i386 floppy driver, for example, it's clear why the delay is
there in one part of the virtual DMA loop and not the other: to allow
a device time to propagate a state change.  That also explains the
need for a delay after writing to port 0x42 of the PIT but not after
writing port 0x43.  I think calls to isa_delay() would make the intent
there a little clearer.

-- Jamie
