Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbQLGSFh>; Thu, 7 Dec 2000 13:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLGSF1>; Thu, 7 Dec 2000 13:05:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:25093 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129772AbQLGSFQ>; Thu, 7 Dec 2000 13:05:16 -0500
Date: Thu, 7 Dec 2000 09:34:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test12-pre7
In-Reply-To: <200012071411.eB7EB4Y11843@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10012070923210.2370-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2000, Russell King wrote:
> 
> Is it intentional that pci_assign_unassigned_resources should:
> 1. enable all devices?
> 2. enable bus master on all devices?

Probably intentional, but probably for all the wrong reasons.

The device enabling is still required for all drivers that aren't PCI
aware of PCI PnP issues. And remember - that used to be pretty much every
single Linux driver out there. So a traditional Linux system pretty much
required that all the devices came up fully enabled, because most drivers
wouldn't know to enable them (as shown by the UHCI bug).

These days, we should probably remove all the logic to enable everything
in pci_assign_unassigned_resources(), because these days pretty much all
PCI drivers are supposed to know about enabling the device (otherwise they
wouldn't work in a PC PnP environment anyway).

The only special case to this rule is "legacy devices" - things like
serial ports in legacy regions, VGA consoles etc, where a driver can use
them without even being aware of the fact that the hardware may be PCI.
Those devices tend to need setup even just for booting, though, so they
tend to be enabled rather early for other reasons anyway.

So I would probably vote for getting rid of the device enables in
pci_assign_unassigned_resources() (for all the reasons already mentioned
by others - scribbling over memory due to not being quiescent etc). But
it's not worth breaking now. 2.5.x material. Most PCI drivers may already
do the right thing, but I bet that the USB driver wasn't the only one who
forgot..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
