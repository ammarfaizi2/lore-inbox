Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBFG0q>; Tue, 6 Feb 2001 01:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129177AbRBFG0g>; Tue, 6 Feb 2001 01:26:36 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23050 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129075AbRBFG00>; Tue, 6 Feb 2001 01:26:26 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux interrupt latency
Date: 5 Feb 2001 22:26:20 -0800
Organization: Transmeta Corporation
Message-ID: <95o5ec$cc$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0102052304170.13906-100000@hoochie.linux-support.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0102052304170.13906-100000@hoochie.linux-support.net>,
Mark Spencer  <markster@linux-support.net> wrote:
>I'm working on the Linux driver for the Tormenta public domain dual T1
>card (see http://www.bsdtelephony.com.mx).

Hmm.. Sounds like somebody has designed a truly crappy card. Everything
is allowable in the name of being cheap, I guess ;)

>						 Further, because the
>buffers are constantly being overwritten by the card, the actual interrupt
>handler must run within 4-28 microseconds from when the card issues the
>interrupt.

You do know that doing even just _one_ ISA IO access takes about a
microsecond? The above sounds like somebody designed the card a bit too
close to the specs - things like interrupt ACK overhead etc is taking up
an uncomfortably big slice of your available latency. 

>On my primary test machine, a Pentium II, 450Mhz, with Intel 430BX
>chipset, the board runs fine with both IDE and SCSI drives (note: DMA must
>be turned on for the IDE drives).  However, on other chipsets, like VIA,
>the card misses 2-3 interrupts every 7989-7991 samples (almost exactly*
>one second).  Further, even with DMA turned on, the IDE disk definitely
>kills the interrupt latency entirely.  

If you can tell when it misses the interrupt (ie if the card has some
"overrun" bit or something), a simple profile might be useful.  Just
make the interrupt handler save away an array of eip's when the overrun
happens, and they'll almost certainly point to something interesting (or
rather, they shoul dpoint to just _after_ something interesting).  You
can get the eip by just looking it up from the pt_regs->eip that you get
in your interrupt handler. 

>Can anyone suggest what might be causing the problem on non-Intel
>chipsets, particularly what event might be occuring once per second and
>disabling interrupts for a couple of hundred microseconds?  Thanks!

Hmm..  The only thing that I can think of happening once a second is the
second overflow thing and the associated NTP maintenance, but that's
very lightweight.  There might be some user-mode interaction, of course,
with people waking up or something - does it also happen in single-user
mode?

The non-intel chipset issue might just be due to timing being marginal
together with slow interrupt controllers - if you compile for an
old-style interrupt controller, interrupt handling will dp a _minimum_
of 5 IO cycles to th einterrupt controller. If the interrupt controller
has ISA timings, that will take 5 usecs rigth there. I _think_ the Intel
chipsets actually have the irq controller on the PCI side.

You can lower interrupt latency by either using the APIC, or if you are
using the i8259 you can edit arch/i386/kernel/i8259.c and search for
DUMMY and remove those two lines.  It should avoid _one_ expensive IO
cycle, and considering your constraints it might be worth it.

It would not be hard to make "fast" ISA interrupts (that only ACK after
the fact and thus do not need to mask themselves off - instead of using
5 IO cycles you could do it with one or two depending on whether it's
from the primary or secondary controller) these days with the current
interrupt controller layer, but quite frankly nobody has bothered. It
sounds like you might want to look into this, though.

But try to see if you can get a profile of what it is that leads up to
the problem first..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
