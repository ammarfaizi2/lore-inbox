Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131464AbQKXApA>; Thu, 23 Nov 2000 19:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131493AbQKXAou>; Thu, 23 Nov 2000 19:44:50 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25350 "EHLO
        havoc.gtf.org") by vger.kernel.org with ESMTP id <S131464AbQKXAob>;
        Thu, 23 Nov 2000 19:44:31 -0500
Message-ID: <3A1DB2DC.366D1F8@mandrakesoft.com>
Date: Thu, 23 Nov 2000 19:14:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, andrewm@uow.edu.au,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 3c59x: Using bad IRQ 0
In-Reply-To: <Pine.LNX.4.10.10011231027440.928-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 23 Nov 2000, Tobias Ringstrom wrote:
> > >
> > >  - enable DEBUG in arch/i386/kernel/pci-i386.h. This should make the code
> > >    print out what the pirq table entries are etc.
> >
> > Done. When adding the call to eisa_set_level_irq, the line
> >
> > IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 03, mask 1eb8, excl 0000 -> newirq=9 -> assigning IRQ 9 ... OK
> >
> > was changed into
> >
> > IRQ for 00:0a.0(0) via 00:0a.0 -> PIRQ 03, mask 1eb8, excl 0000 -> newirq=9 -> assigning IRQ 9 -> edge ... OK
> 
> Ok.
> 
> The thing was marked as edge-triggered, which is basically always wrong
> for a PCI interrupt. The above printout just means that it now noticed
> that it was edge, and fixed it up in the ELCR.

FWIW Via's PCI to ISA bridge has a PIRQ edge/level register.

Vendor=1106h, Device=686h, PCI config offset 54h, RW
	Bits 7-4 reserved, zero.
	Bit 3: PIRQA# edge (clear bit for level)
	Bit 2: PIRQB# edge (clear bit for level)
	Bit 1: PIRQC# edge (clear bit for level)
	Bit 0: PIRQD# edge (clear bit for level)

The bits are all supposed to default to zero (level).


> > >  - add the line "eisa_set_level_irq(irq);" to pirq_via_set() just before
> > >    the "return 1;"
> >
> > You certainly know your kernel very well... :-)
> 
> That's why they pay me the big bucks. Good.
> 
> I'll make it do the eisa_set_level_irq() in the generic code: it should
> always be right (we don't do it now in the PIIX4 case, for example, but
> the PIIX documentation actually says that we _should_), and there is no
> need to do it separately for each interrupt router.

So calling eisa_set_level_irq() means nothing will scream if we do not
update [for example] the above register?

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
