Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130509AbQLFUJz>; Wed, 6 Dec 2000 15:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130562AbQLFUJq>; Wed, 6 Dec 2000 15:09:46 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:54793 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130509AbQLFUJk>; Wed, 6 Dec 2000 15:09:40 -0500
Date: Wed, 6 Dec 2000 11:38:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, jerdfelt@valinux.com,
        usb@in.tum.de
Subject: Re: test12-pre6
In-Reply-To: <20001206200803.C847@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.10.10012061131320.1873-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Erik Mouw wrote:
> > 
> > Can you tell me what device it is that doesn't work for you? 
> 
> The USB controller. That's device 00:07.2:
> 
> 00:07.2 USB Controller: Intel Corporation 82440MX USB Universal Host Controller (prog-if 00 [UHCI])
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-  ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin D routed to IRQ 11
>         Region 4: I/O ports at fcc0 [size=32]

Now, this is with a bog-standard PIIX irq router, so we definitely know
that we have the pirq table parsing right. I even have unofficial
confirmation from intel engineers on this.

But I see something obviously wrong there: you have busmaster disabled.

Looking into the UHCI controller code, I notice that neither UHCI driver
actually does the (required)

	pci_set_master(dev);

Please add that to just after a successful "pci_enable_device(dev)", and I
just bet your USB will start working.

Johannes, Georg, the above is a fairly embarrassing bug, and is likely to
explain a _lot_ of USB failures (the OHCI driver does do this, btw).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
