Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266906AbRGMAk1>; Thu, 12 Jul 2001 20:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbRGMAkR>; Thu, 12 Jul 2001 20:40:17 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:62736 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266906AbRGMAkM>; Thu, 12 Jul 2001 20:40:12 -0400
Date: Thu, 12 Jul 2001 17:38:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Murray <mmurray@deepthought.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6
In-Reply-To: <Pine.LNX.4.21.0107121802310.17665-100000@cobalt.deepthought.org>
Message-ID: <Pine.LNX.4.33.0107121706280.4604-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, I think I've found the reason for your hang.

Your video card is also on irq11.

And I bet you don't have a driver that knows about it.

So let's run a thought experiment:
 - enabling yenta enables the irq routing for "link 0x01", which is the
   first IRQ input into the southbridge.
 - some time later a vertical refresh happens
 - the video card, that is also routed to link 0x01, raises the vertical
   refresh irq.
 - Linux has a irq handler for irq11, but no yenta state changes, so the
   irq handler returns immediately without doing anything.
 - the video card (being a PCI card) still raises the irq. Forever. Repeat.

Ho humm.. I'd love to test this out some way, but the video card does seem
to be physically routed to the same southbridge interupt pin, so while I
can move that interrupt around, the video card will always move with it.
So it wouldn't help, for example, to try to make pci-irq.c try to select
another irq line.

So you can try two things:
 - if you have a BIOS setting for VGA interrupts, turn it OFF.
 - if you don't (or you just think you're too manly to resort to BIOS
   settings), you could try to add something like this as a hack to
   yenta.c (somewhere in the init routines)

	struct pci_dev * video;

	video = pci_find_class(PCI_CLASS_DISPLAY_VGA, NULL);
	if (video) {
		char * base = ioremap(pci_resource_start(dev, 2), 4096);

		/* Turn off interrupts for ATI Rage graphics card */
		writel(0, base + 0x40);
	}

Note, that "writel()" may or may not work. It's a guess from some rather
limited documentation, namely the header #defines of the XFree86 driver.

The above is a complete hack, and assumes that the only VGA-compatible
controller in the system is an ATI card. But if you can't find a VGA irq
enable thing in the BIOS setup, it might be worth trying.

		Linus

