Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268018AbRGVSEX>; Sun, 22 Jul 2001 14:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268017AbRGVSEN>; Sun, 22 Jul 2001 14:04:13 -0400
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:29840 "EHLO
	bassia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268016AbRGVSEJ>; Sun, 22 Jul 2001 14:04:09 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: New PCI device
Date: Sun, 22 Jul 2001 20:02:43 +0200
Message-Id: <20010722180243.22142@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0107221342140.1363-100000@jdi.jdimedia.nl>
In-Reply-To: <Pine.LNX.4.33.0107221342140.1363-100000@jdi.jdimedia.nl>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>
>I'm still thinking about what driver to create.. A driver that
>emulates a PCMCIA controller is a knightmare, but so is an ethernet driver
>for this setup.

I didn't follow closely, but Imy understanding is that the prismII is
not removable on the PCI card, that's it ? The PLX chip is probably 
used to bridge the 16 bits PIO prism device, It doesn't make much sense
to emulate PCMCIA.

>The 2.4.x kernel has support for the wireless card itself, but in a PCMCIA
>context. Creating a ethernet driver creates a lot of duplicate code.

First, get a recent 2.4.x, 2.4.6 should you give you the latest version.

The kernel driver for those chipsets is designed in a way that should allow
you to easily add new interface types. Look at what's in drivers/net/wireless,
more specifically the files hermes.c, orinoco.c, orinoco_cs.c and airport.c.

The drivers's layout is basically;

     - hermes    : low level routines for talking to the controller,
                   you initialize this layer by passing it an IO base
                   for use with inx/outx routines. You shouldn't have
                   to modify it.
 
     - orinoco   : core driver. Implements the interface to the kernel
                   network stack, the wireless interface, etc...
                   You shouldn't need to change it neither

Now are the bus interfaces :

     - orinoco_cs : PCMCIA interface
     - airport    : Apple "Airport" interface

What you have to do is basically add a module for your card. You should
write a basic PCI driver that mostly does what airport does (except
the powermac specific stuffs , mostly calls to feature_xxx() functions,
just ignore them). That is get the card's IO base address and request
an interrupt, implement open() and close() wrappers, and that's it.

HOWEVER, the low-level hermes layer can only do PIO for now (inx/outx).
If you card requires MMIO, then it will not be that simple. You'll probably
have to work on the hermes layer to provide 2 implementations, a PIO one
and an MMIO one.
For the Airport driver, which is MMIO based, we can "fake" this because
the Airport interface exist only on PowerMacs, and on PPC, PIO is actually
MMIO in a specific address range.

I don't know if the PLX bridge provides anything like GPIOs and/or if
there's a separate PLD on your card. In these cases, it's possible that
some card-specific IO magic be needed to properly initialize the prism.
That's the case with Apple airport on which you have to "emulate" some
PCMCIA stuffs for powering it up and resetting the chip.

So if you have problems getting the chip up, you may have to ask the
card manufacturer for some specs.

Ben.


