Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131123AbQKUT6x>; Tue, 21 Nov 2000 14:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131197AbQKUT6n>; Tue, 21 Nov 2000 14:58:43 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54284 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131196AbQKUT6h>;
	Tue, 21 Nov 2000 14:58:37 -0500
Message-ID: <3A1ACCE0.42B93664@mandrakesoft.com>
Date: Tue, 21 Nov 2000 14:28:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, andrewm@uow.edu.au,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 3c59x: Using bad IRQ 0
In-Reply-To: <Pine.LNX.4.21.0011211959550.29915-100000@svea.tellus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:
> When saying yes to "Plug-and-play OS" in the BIOS, my 3Com 905C adapter
> stops working, since the driver tries to use IRQ 0, since the BIOS does
> not assign an IRQ to it. The driver seems to read the IRQ from the card
> before it calls pci_enable_device (and pci_set_master).

> eth0: 3Com PCI 3c905C Tornado at 0xa400, PCI: Enabling device 00:0a.0 (0014 -> 0017)
> PCI: Assigned IRQ 9 for device 00:0a.0
>  00:01:02:b4:18:e4, IRQ 0

Tobias, can you confirm that calling pci_enable_device before reading
dev->irq fixes the 3c59x.c problem for you?

It sounds like the 2.4 kernel can now support "plug-n-play OS" BIOS
setting, AFAICS.

If moving pci_enable_device above any dev->irq checks solves Tobias'
problem, we need to go through the PCI drivers and make sure we check
things in the correct order in all PCI drivers.  I wonder if we
shouldn't move pci_resource_xxx calls until after pci_enable_device too.

A caveat to this whole scheme is that usb-uhci -already- calls
pci_enable_device before checking dev->irq, and yet cannot get around
the "assign IRQ to USB: no" setting in BIOS.  I hope that is an
exception rather than the rule.

Regards,

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
