Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSLIBpi>; Sun, 8 Dec 2002 20:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSLIBpi>; Sun, 8 Dec 2002 20:45:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18963 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261723AbSLIBph>; Sun, 8 Dec 2002 20:45:37 -0500
Date: Sun, 8 Dec 2002 17:54:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: Patrick Mochel <mochel@osdl.org>, Willy Tarreau <willy@w.ods.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>,
       <jgarzik@pobox.com>
Subject: Re: /proc/pci deprecation?
In-Reply-To: <20021208125642.A22545@twiddle.net>
Message-ID: <Pine.LNX.4.44.0212081747590.1209-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Dec 2002, Richard Henderson wrote:
>
> It just reports what's in the PCI_INTERRUPT_LINE register.

That's wrong, then.

> At least on Alpha, we wrote into this register during pci
> configuration, so the value matches what's in /proc/interrupts.
> I guess I always assumed we did the same on x86, but I've
> never checked.

It _shouldn't_ be done. The PCI_INTERRUPT_LINE register is just a byte,
which isn't even _enough_ to identify the irq "for real" on many
architectures. It's also a totally different namespace at least on x86
machines: the PCI_INTERRUPT_LINE register should contain the "legacy
interrupt", while the remapped interrupt will depend on whether the
io-apic is enabled or not.

Writing it back is actively _bad_, since it will make it very hard to
re-boot the machine without the BIOS re-enumarating the PCI bus and
filling it in again (ie it would definitely screw up using things like
kexec() on PC's, if the kernel we boot _from_ is an APIC kernel, but the
kernel we boot _into_ is not).

So the rule should be:
 - the PCI config space is _not_ the same as "pci->irq"
 - we should _never_ update the PCI_INTERRUPT_LINE register, because it
   destroys boot loader information (the same way we need to not overwrite
   BIOS extended areas and ACPI areas etc in order to be able to reboot
   cleanly)
 - we need _some_ way of getting the "kernel irq line" from /sys or /proc.

Sounds like /proc/pci still does something for us. Or is the info
available in /proc/bus/pci/devices?

		Linus

