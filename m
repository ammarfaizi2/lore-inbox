Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130281AbRA2Rfc>; Mon, 29 Jan 2001 12:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbRA2RfW>; Mon, 29 Jan 2001 12:35:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:22802 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129051AbRA2RfI>; Mon, 29 Jan 2001 12:35:08 -0500
Date: Mon, 29 Jan 2001 09:34:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Diehl <mdiehlcs@compuserve.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Robert Siemer <siemer@panorama.hadiko.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0
In-Reply-To: <Pine.LNX.4.21.0101291801580.29065-400000@notebook.diehl.home>
Message-ID: <Pine.LNX.4.10.10101290928060.9131-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jan 2001, Martin Diehl wrote:
> 
> Right, seems the 0x41/0x01 thing. I have the 0x01 case with SiS 85C503
> router rev. 01. Hopefully the 0x41 boards have a different revision. My
> fear however is, this is due to BIOS implementation of the routing table.
> 
> Using the docs of the 85C503 function from the SiS5595 southbridge
> datasheet I've written a patch to get things right - at least for the 0x01
> case. The mapping on my box appears as follows:
> 
> link/pirq value           config-reg               function
> 0x01/0x02/0x03/0x04       0x41/0x42/0x43/0x44    PCI INTA..D
> 0x61                      0x61                   5513 onboard IDE
> 0x62                      0x62                   onboard USB (OHCI)
> 0x6a                      0x6a                   onboard ACPI
> 0x7e                      0x7e                   onboard data acquisition

I bet that we can fix this up easily.

I bet the "translation" is just something like

	reg = pirq;
	if (reg < 5)
		reg += 0x40;

and that what happened was that SiS _originally_ only specified INTA-INTD,
and specified them as pirq link values 0x01-0x04, mapping to config
registers 0x41-0x44.

Later on they noticed that they wanted to do the other things too, and
they expanded the definition to be "for any other value, it's the config
space address".

> BTW: I was wondering, why we did not update the PCI_INTERRUPT_LINE in
> config space when we re-route dev->irq. Well, documentation/pci.txt says
> we should trust on dev->irq over config space, however stopping lspci
> and friends to confuse us would be too bad either. So I've included a
> one-liner to fix this.

I would prefer _not_ to see this.

Why? Because it's (a) real information what the PCI config space was, and
it might help debug things in the future. And (b) I've seen to many broken
BIOSes that do not re-initialize hardware fully over a soft boot, that I
worry that you'll get different behaviour after doing a "shutdown -r" with
this.

I'd rather not touch config space more than necessary.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
