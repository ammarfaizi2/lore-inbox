Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbRBFOEE>; Tue, 6 Feb 2001 09:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbRBFODo>; Tue, 6 Feb 2001 09:03:44 -0500
Received: from [203.169.151.222] ([203.169.151.222]:24595 "EHLO
	main.coppice.org") by vger.kernel.org with ESMTP id <S129245AbRBFODd>;
	Tue, 6 Feb 2001 09:03:33 -0500
Message-ID: <3A800476.46F0555E@coppice.org>
Date: Tue, 06 Feb 2001 22:04:38 +0800
From: Steve Underwood <steveu@coppice.org>
Organization: Me? Organised?
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en, zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux interrupt latency
In-Reply-To: <Pine.LNX.4.21.0102052304170.13906-100000@hoochie.linux-support.net> <95o5ec$cc$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <Pine.LNX.4.21.0102052304170.13906-100000@hoochie.linux-support.net>,
> Mark Spencer  <markster@linux-support.net> wrote:
> >I'm working on the Linux driver for the Tormenta public domain dual T1
> >card (see http://www.bsdtelephony.com.mx).
> 
> Hmm.. Sounds like somebody has designed a truly crappy card. Everything
> is allowable in the name of being cheap, I guess ;)

Harsh words. Although it has some limitations, there is rhyme and reason
in the design of this card. It is fairly cheap to assemble. It uses all
through hole parts, so anyone can assemble it. It is a form of
open-source hardware, so anyone is welcome to assemble it. These days
the desire for low volume hand assembly can really tie your hands, so to
speak. Since the interrupt service needs to read a set of audio samples,
conference between them, and output the result within one sample period
interrupt latency is a critical issue. All the grunt takes place in the
interrupt routine, to avoid imposing significant real-time constraints
on the user space code.
 
> >                                                Further, because the
> >buffers are constantly being overwritten by the card, the actual interrupt
> >handler must run within 4-28 microseconds from when the card issues the
> >interrupt.

Where does the 4-28 come from? The critical issue with interrupt timing
on this card is that a write from the ISA bus concurrent to a read
within the Mitel chip that does serial/parallel conversion causes
conflict. This is probably where the problem lies - see later.
 
> You do know that doing even just _one_ ISA IO access takes about a
> microsecond? The above sounds like somebody designed the card a bit too
> close to the specs - things like interrupt ACK overhead etc is taking up
> an uncomfortably big slice of your available latency.
> 
> >On my primary test machine, a Pentium II, 450Mhz, with Intel 430BX
> >chipset, the board runs fine with both IDE and SCSI drives (note: DMA must
> >be turned on for the IDE drives).  However, on other chipsets, like VIA,
> >the card misses 2-3 interrupts every 7989-7991 samples (almost exactly*
> >one second).  Further, even with DMA turned on, the IDE disk definitely
> >kills the interrupt latency entirely.

A 450MHz PII processor isn't really up to the task. Jim Dixon, who
designed the card, recommends at least a 733MHz PIII, based on his
experience with the original BSD driver. I am able to run one as a dual
E1 card (therefore with 1/3 more workload that T1 mode), with Linux
2.2.16, on a 700MHz Athlon + VIA KX133 chip set, without slips - even
when I do some significant disk I/O. The large number of I/O cycles on
the ISA bus stalls the processor for about 1/3 of the time for a dual T1
card, and about 1/2 the time for a dual E1 card. This really sucks, and
needs to be addressed when the more serious long term PCI version of the
card goes through.

The FreeBSD and Linux drivers can both keep up, in suitable computers.
However, the write/read conflict issue I mentioned above requires some
very dirty dealings within the driver - look for a nasty little sequence
jumbling table in the driver source. You will see it only really just
about works, and seriously needs a comprehensive fix in the PCI version
of the card.

A brand new ISA card design, demanding a high speed CPU should tell you
this isn't a long term solution, regardless of performance. Treat this
card more as a proof of concept. 
 
> If you can tell when it misses the interrupt (ie if the card has some
> "overrun" bit or something), a simple profile might be useful.  Just
> make the interrupt handler save away an array of eip's when the overrun
> happens, and they'll almost certainly point to something interesting (or
> rather, they shoul dpoint to just _after_ something interesting).  You
> can get the eip by just looking it up from the pt_regs->eip that you get
> in your interrupt handler.
> 
> >Can anyone suggest what might be causing the problem on non-Intel
> >chipsets, particularly what event might be occuring once per second and
> >disabling interrupts for a couple of hundred microseconds?  Thanks!

I think you are trying one board that is close to the limit, and one
just beyond. Simple as that.
 
> Hmm..  The only thing that I can think of happening once a second is the
> second overflow thing and the associated NTP maintenance, but that's
> very lightweight.  There might be some user-mode interaction, of course,
> with people waking up or something - does it also happen in single-user
> mode?

There is some once per second activity in the driver, but not much. Its
unlikely to be the cause of the trouble. If things are really close to
the limit, I guess it might just be the straw that breaks the taxman's
back (OK, I like camels more than taxmen).

> The non-intel chipset issue might just be due to timing being marginal
> together with slow interrupt controllers - if you compile for an
> old-style interrupt controller, interrupt handling will dp a _minimum_
> of 5 IO cycles to th einterrupt controller. If the interrupt controller
> has ISA timings, that will take 5 usecs rigth there. I _think_ the Intel
> chipsets actually have the irq controller on the PCI side.

Most likely.
 
> You can lower interrupt latency by either using the APIC, or if you are
> using the i8259 you can edit arch/i386/kernel/i8259.c and search for
> DUMMY and remove those two lines.  It should avoid _one_ expensive IO
> cycle, and considering your constraints it might be worth it.

Good idea. I'll have to try that. There always seem to be lots of
problem reports about IOAPIC, though. Should I trust it?

> It would not be hard to make "fast" ISA interrupts (that only ACK after
> the fact and thus do not need to mask themselves off - instead of using
> 5 IO cycles you could do it with one or two depending on whether it's
> from the primary or secondary controller) these days with the current
> interrupt controller layer, but quite frankly nobody has bothered. It
> sounds like you might want to look into this, though.
> 
> But try to see if you can get a profile of what it is that leads up to
> the problem first..
> 
>                 Linus

Regards,
Steve
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
