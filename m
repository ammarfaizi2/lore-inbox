Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131720AbQLLBqo>; Mon, 11 Dec 2000 20:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131719AbQLLBqe>; Mon, 11 Dec 2000 20:46:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:32529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131714AbQLLBqV>; Mon, 11 Dec 2000 20:46:21 -0500
Date: Mon, 11 Dec 2000 17:15:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Mares <mj@ucw.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI irq routing..
In-Reply-To: <20001130093428.A6326@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.10.10012111710290.1107-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin,
 I finally got access to a machine that truly has multiple PCI buses and
bridges in between them, and at least for that machine the x86 IRQ lookup
does not work at all.

The problem seems to be the "pci_get_interrupt_pin()" call. We should not
do that. The pirq table has the unmodified device information - and when
we try to swizzle the pins and find the bridge that the device is behind,
we're trying to be way too clever.

Instead of doing

	pin = pci_get_interrupt_pin(dev, &d);
	if (pin < 0) {
		DBG(" -> no interrupt pin\n");
		return 0;
	}

I think we should be doing:

	u8 pin;
	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
	if (!pin) {
		DBG(" -> no interrupt pin\n");
		return 0;
	}
	pin--;
	d = dev;

and be done with it. No swizzling, no nothing.

On the machine I just saw, this would have given the right end result.

On machines with just one bus, we'd never see the difference.

Comments?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
