Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268073AbRGVV42>; Sun, 22 Jul 2001 17:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268074AbRGVV4S>; Sun, 22 Jul 2001 17:56:18 -0400
Received: from jdi.jdimedia.nl ([212.204.192.51]:11224 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S268073AbRGVV4Q>;
	Sun, 22 Jul 2001 17:56:16 -0400
Date: Sun, 22 Jul 2001 23:55:50 +0200 (CEST)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: New PCI device
In-Reply-To: <20010722180243.22142@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0107222344530.3082-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



> >I'm still thinking about what driver to create.. A driver that
> >emulates a PCMCIA controller is a knightmare, but so is an ethernet driver
> >for this setup.
>
> I didn't follow closely, but Imy understanding is that the prismII is
> not removable on the PCI card, that's it ? The PLX chip is probably
> used to bridge the 16 bits PIO prism device, It doesn't make much sense
> to emulate PCMCIA.

The PLX hardware the PCMCIA interface in the card. This means that it maps
IO and memory directly into PCI space.

> >The 2.4.x kernel has support for the wireless card itself, but in a PCMCIA
> >context. Creating a ethernet driver creates a lot of duplicate code.
>
> First, get a recent 2.4.x, 2.4.6 should you give you the latest version.
>
> The kernel driver for those chipsets is designed in a way that should allow
> you to easily add new interface types. Look at what's in drivers/net/wireless,
> more specifically the files hermes.c, orinoco.c, orinoco_cs.c and airport.c.
>
> The drivers's layout is basically;
>
>      - hermes    : low level routines for talking to the controller,
>                    you initialize this layer by passing it an IO base
>                    for use with inx/outx routines. You shouldn't have
>                    to modify it.
>
>      - orinoco   : core driver. Implements the interface to the kernel
>                    network stack, the wireless interface, etc...
>                    You shouldn't need to change it neither
>
> Now are the bus interfaces :
>
>      - orinoco_cs : PCMCIA interface
>      - airport    : Apple "Airport" interface
>
> What you have to do is basically add a module for your card. You should
> write a basic PCI driver that mostly does what airport does (except
> the powermac specific stuffs , mostly calls to feature_xxx() functions,
> just ignore them). That is get the card's IO base address and request
> an interrupt, implement open() and close() wrappers, and that's it.

I missed the bus interface when looking at the code.

> HOWEVER, the low-level hermes layer can only do PIO for now (inx/outx).
> If you card requires MMIO, then it will not be that simple. You'll probably
> have to work on the hermes layer to provide 2 implementations, a PIO one
> and an MMIO one.

Is far as I can tell, it does need the MMIO. I'm looking at how the old
driver does the mapping.

> For the Airport driver, which is MMIO based, we can "fake" this because
> the Airport interface exist only on PowerMacs, and on PPC, PIO is actually
> MMIO in a specific address range.
>
> I don't know if the PLX bridge provides anything like GPIOs and/or if
> there's a separate PLD on your card. In these cases, it's possible that
> some card-specific IO magic be needed to properly initialize the prism.
> That's the case with Apple airport on which you have to "emulate" some
> PCMCIA stuffs for powering it up and resetting the chip.

As far as I can tell, the PCICIA IO and memory space are simply mapped
into PCI space.

> So if you have problems getting the chip up, you may have to ask the
> card manufacturer for some specs.

I've got specs on the card. I'm figuring out now how the thing is wired.

> Ben.

	Igmar

-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

