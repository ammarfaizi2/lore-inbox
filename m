Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268060AbRGVVA3>; Sun, 22 Jul 2001 17:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbRGVVAS>; Sun, 22 Jul 2001 17:00:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:15626 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268060AbRGVVAK>; Sun, 22 Jul 2001 17:00:10 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Sun, 22 Jul 2001 13:59:02 -0700
Message-Id: <200107222059.f6MKx2212465@penguin.transmeta.com>
To: greearb@candelatech.com, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [BUG REPORT]  Sony VAIO, 2.4.7:  CardBus failures with Tulip & 3c575 
 cards.
Newsgroups: linux.dev.kernel
In-Reply-To: <3B5B1F77.D8B45FFA@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <3B5B1F77.D8B45FFA@candelatech.com> you write:
>
>This report contains information about my failure to get my
>CardBus NICs working correctly.  Hardware involved is:
>
>Sony VAIO PCG-FX210 laptop (800Mhz Duron...)
>DFE-650 16-bit PCMCIA NIC x2
>3Com Megahertz 32-bit 3CCFE575BT NIC x2
>AmbiCom 32-bit 8100 NIC  (tulip) x2

This looks suspiciously like your slot #1 gets the PCI interrupt routing
wrong.

Note especially the kernel reports:

	Linux Kernel Card Services 3.1.22
	  options:  [pci] [cardbus] [pm]
	PCI: Assigned IRQ 9 for device 00:0a.0
	PCI: Assigned IRQ 10 for device 00:0a.1
	IRQ routing conflict for 00:07.5, have irq 5, want irq 10
	IRQ routing conflict for 00:07.6, have irq 5, want irq 10
	PCI: Sharing IRQ 10 with 00:10.0

it really looks like your slot 1 controller (00:0a.1) really wants irq5,
based on the fact that other devices are reported to have irq5.

However, if they _really_ have irq5 already routed, I'm surprised that
the PCI irq router "r->get()" function didn't pick up on that fact, and
that the "set" function apparently didn't work correctly.

So I'd guess that when you insert a card in slot #1, you get a constant
stream of interrupts on irq5, which is not where the kernel is expecting
them, so your machine locks up. 

Can you do the following:
 - run dump_pirq on your machine (attached)
 - run "lspci -vvxxx" as root

send me and Jeff the output. Jeff also suggested enabling debugging in
yenta.c and that might be useful too.

		Linus
