Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275097AbTHGEBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 00:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275100AbTHGEBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 00:01:14 -0400
Received: from tribal.metalab.unc.edu ([152.2.210.122]:29152 "EHLO
	tribal.metalab.unc.edu") by vger.kernel.org with ESMTP
	id S275097AbTHGEBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 00:01:09 -0400
Date: Thu, 7 Aug 2003 00:01:06 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Tim Small <tim@buttersideup.com>
cc: rmk@arm.linux.org.uk, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: TI yenta-alikes (was: ToPIC specific init for yenta_socket)
In-Reply-To: <3F317FD7.6020209@buttersideup.com>
Message-ID: <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com>
References: <200308062025.08861.daniel.ritz@gmx.ch> <20030806194430.D16116@flint.arm.linux.org.uk>
 <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com>
 <20030806203217.F16116@flint.arm.linux.org.uk>
 <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com>
 <3F317FD7.6020209@buttersideup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, Tim Small wrote:

> I think that the chip used on my card at least (TI PCI1031), has an
> option of delivering ISA IRQs via the IRQSER (I think this is the same
> as PCI SERRn/SERIRQ signals).
>
>  From what I can gather (I might be totally wrong), I think this is
> likely to be used on some laptops, as the PCI SERRn/SERIRQ signal was a
> proposed standard, and never actually made it's way onto a standard PCI
> slot, however some pci host bridges implement this (e.g. Intel PIIX, I
> think), so I'd guess quite a few laptops may have their PCI1xxx chips
> wired to the PCI host bridge like this, as this would be the cheapest
> and most flexible option if it is available ("parallel" ISA IRQ delivery
> uses more PCB traces, and PCI interrupts pose driver compatibility
> problems).

Are you saying that you have a PCI card without any additional connectors,
but it can use "serial" ISA interrupts thanks to the chipset support?  Or
is it a laptop?

> The alternative way of using IRQSER interrupts appears to be to have an
> external TI PCI950 chip do the serial to parallel IRQ conversion,
> although I've no idea why you'd want to bother with this, when the
> PCI1xxx chips can do this already, with the caveat, that they can only
> deliver ISA IRQs 3,4,5,7,9,10,11,12,14,15.

As I understand it, "serial ISA" interrupts are available to PCI cards
only on some chipsets.  If the chipset support is missing, PCI950 would be
used on the motherboard.

> >I can write this code, but I only have a PCI card to test.
> >
> Sounds good...  However, one possible gotcha might be that the physical
> IRQ pins are shared, and operate differently in different modes so it
> may be possible to make a mess if you configure the chip wrong:
>
> e.g. PCI1031
>
> pin   function
> 154   IRQ3/PCI INTA
> 155   IRQ4/PCI INTB
> 157   IRQ7/PCDMAREQ
> 158   IRQ9/IRQSER
> 159   IRQ10/CLKRUN
> 160   IRQ11/PCDMAGNT
> 163   IRQ15/RI_OUT
>
> So maybe (not sure) if you put the chip in PCI interrupt mode first, it
> will spray the ISA interrupts pins, if the system is wired up this way
> (I know nearly nothing about ISA and PCI from an electrical point of
> view, so I've no idea if this would happen in practice, but it at least
> seems possible)?

I have no idea, but I think it's an important consideration.  I wonder how
it's possible to put IRQ3 and INTA on the same pin?  What if CSC uses INTA
and the PCMCIA card uses IRQ3?  How does it get routed to different
places?  I guess there should be some way to tell on the hardware level
what mode the chip uses.

> Maybe:
>
> - Probe for parallel ISA IRQs first (maybe on non shared pins if poss -
> on the PCI1031, IRQs 5,12,14 have their own dedicated pin)
> - Next, probe for serial ISA IRQs
> - Finally, probe for PCI IRQs

I think there are some questions we need to answer before we decide.

1) How important is it to provide the card with a non-shared ISA
interrupt?  Shouldn't we rather update the drivers to deal with shared
interrupts?  I can imagine that some old PCMCIA cards are designed without
interrupt sharing in mind, i.e. it's hard to say if the interrupt was
issued by that card or by some other device.  But how critical is that?
Do we want to support really old hardware, broken by design?  And what
exactly hardware is it?

2) There is a risk of taking an interrupt from an ISA device that
doesn't have its module loaded yet.  Do we care about it?

3) What is the risk of disabling the system by probing for parallel ISA
interrupts?

4) What is the risk of disabling the system by probing for serial ISA
interrupts, especially on the motherboards without support for them?

> If probing seems impossible or unsafe, I suppose the only way to do it
> would be module/kernel options.

I hope we can avoid it.

> Some evidence for IRQSER / PIIX possibility:
>
> http://groups.google.com/groups?threadm=SGTxgPhJ9GA.185%40newsgroups.intel.com

Yes, but note this:

"The serial interrupt interrupt register, SERIRQC, in section 4.1.11 of
the PIIX4 datasheet has to be initialized before any of the serial
interrupts to work. I believe this is done through BIOS if the BIOS
supports it."

SERIRQC is described here:
http://www.intel.com/design/intarch/techinfo/440bx/bridgreg.htm

I don't know if we should change this register.  It depends on how badly
we want to give ISA interrupt to the cards.

-- 
Regards,
Pavel Roskin
