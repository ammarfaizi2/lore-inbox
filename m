Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVAJVpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVAJVpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVAJVk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:40:57 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:41608 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262514AbVAJVjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:39:00 -0500
Subject: Re: dmesg: PCI interrupts are no longer routed
	automatically.........
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-os@analogic.com
Cc: bjorn.helgaas@hp.com, David Vrabel <dvrabel@cantab.net>,
       aryix <aryix@softhome.net>, lug-list@lugmen.org.ar,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501051251140.9762@chaos.analogic.com>
References: <20041229095559.5ebfc4d4@sophia>
	 <1104862721.1846.49.camel@eeyore>
	 <Pine.LNX.4.61.0501041342070.5445@chaos.analogic.com>
	 <1104867678.1846.80.camel@eeyore>
	 <Pine.LNX.4.61.0501041447420.5310@chaos.analogic.com>
	 <41DBB5F6.6070801@cantab.net>
	 <Pine.LNX.4.61.0501050640430.12879@chaos.analogic.com>
	 <1104945236.4046.25.camel@eeyore>
	 <Pine.LNX.4.61.0501051251140.9762@chaos.analogic.com>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 14:38:28 -0700
Message-Id: <1105393108.29910.60.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 13:15 -0500, linux-os wrote:
> The problem is that the PLX-9656BA INTCSR is not in configuration
> space, but runtime registers off a BAR. The interrupt source
> can be from a PLD that hasn't even had its microcode loaded
> yet!
> 
> FYI, the PLX or similar clone is the bus interface chip for many
> busmastering PCI boards.
> 
> > You wouldn't want your ISR mucking around with a half-initialized
> > device, so does it have to check a "device_configured" flag
> > or something?
> 
> Yes. If the device isn't configured, the ISR reads all the INTCSR
> bits, then writes 0 to the register to prevent anything else.

The PLX might be a common device, but it sounds like this
particular issue depends on the design of the rest of the
board.  And presumably, nobody who cared about performance
would design a board with this property, right?  I mean, to
add a test in the ISR for a condition that exists only for
a few milliseconds at driver startup-time seems sub-optimal.

> If the PLX had been reset, then the INTCSR bits would all
> be masked off. However, reset is really only guaranteed from
> power OFF on some motherboards, in particuar the ones with
> so-called "hot-swap" capabilites fail. There is a software
> reset that, in fact, even reloads its serial EEPROM. However,
> the BAR needs to be accessible for this to be used.
> 
> So it would be wonderful if the correct IRQ could be made
> available before the chip could generate an interrupt.

If we exposed a new pcibios_route_irq() (to hide the arch-
specific nature of IRQ routing via ACPI or other information),
could you do what you need in a pci_fixup_early quirk?


