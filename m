Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131973AbRDGVeq>; Sat, 7 Apr 2001 17:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRDGVeg>; Sat, 7 Apr 2001 17:34:36 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:6156 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131973AbRDGVed>; Sat, 7 Apr 2001 17:34:33 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Multi-function PCI devices
Date: 7 Apr 2001 14:34:26 -0700
Organization: Transmeta Corporation
Message-ID: <9ao152$b13$1@penguin.transmeta.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3ACECA8F.FEC9439@eunet.at>,
Michael Reinelt  <reinelt@eunet.at> wrote:
>
>The card shows up on the PCI bus as one device. For the card provides
>both serial and parallel ports, it will be driven by two subsystems, the
>serial and the parallel driver.

Tough.  The PCI specification has a perfectly good way to handle this,
namely by having subfunctions on the same chip.  The particular chip
designer was lazy or something, and didn't do it the proper way.  Which
means that you cannot, and should not, use a generic PCI driver for the
chip.  Because it doesn't show up as separate devices for the separate
functions. 

Now, that doesn't mean that you can't use the card, or the existing
drivers. It only means that you should fix up the total braindamage of
the hardware.

It only means that you should probably approach it as being a special
"invisible PCI bridge", and basically have a specific driver for that
chip that acts as a _bridge_ driver.

Writing a bridge driver is not that hard: your init routine will
instantiate the devices behind the bridge (ie you would allocate two
"struct pci_device" structures and you would add them to behind the
"bridge", and you would make _those_ look like real serial and parallell
devices. 

See for example drivers/pcmcia/cardbus.c: cb_alloc() for how to create a
new "pci_dev" (see the "for i = 0; i < fn ; i++)" loop: it creates the
devices for each subfunction found behind the cardbus bridge.  It really
boils down to "dev = kmalloc(); initialize_dev(dev); pci_insert_dev(dev,
bus);"). 

At which point you can happily use the current drivers without any
modifications. 

		Linus
