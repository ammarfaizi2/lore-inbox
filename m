Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSLIEPN>; Sun, 8 Dec 2002 23:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbSLIEPN>; Sun, 8 Dec 2002 23:15:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:20105 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262648AbSLIEPM>;
	Sun, 8 Dec 2002 23:15:12 -0500
Date: Sun, 8 Dec 2002 21:59:27 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Richard Henderson <rth@twiddle.net>, Willy Tarreau <willy@w.ods.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>,
       <jgarzik@pobox.com>
Subject: Re: /proc/pci deprecation?
In-Reply-To: <Pine.LNX.4.44.0212081747590.1209-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0212082154480.913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > It just reports what's in the PCI_INTERRUPT_LINE register.
> 
> That's wrong, then.

Actually, it doesn't. IIUC, it gets it from /proc/bus/pci/devices. That 
info is formatted in drivers/pci/proc.c::show_device().

> > At least on Alpha, we wrote into this register during pci
> > configuration, so the value matches what's in /proc/interrupts.
> > I guess I always assumed we did the same on x86, but I've
> > never checked.
> 
> It _shouldn't_ be done. The PCI_INTERRUPT_LINE register is just a byte,
> which isn't even _enough_ to identify the irq "for real" on many
> architectures. It's also a totally different namespace at least on x86
> machines: the PCI_INTERRUPT_LINE register should contain the "legacy
> interrupt", while the remapped interrupt will depend on whether the
> io-apic is enabled or not.
> 
> Writing it back is actively _bad_, since it will make it very hard to
> re-boot the machine without the BIOS re-enumarating the PCI bus and
> filling it in again (ie it would definitely screw up using things like
> kexec() on PC's, if the kernel we boot _from_ is an APIC kernel, but the
> kernel we boot _into_ is not).

I couldn't find any place that ia32 writes the PCI_INTERRUPT_LINE register 
during boot. And, manually reading in various places (before, during, and 
after enabling a device) always returned the same info. 

> So the rule should be:
>  - the PCI config space is _not_ the same as "pci->irq"
>  - we should _never_ update the PCI_INTERRUPT_LINE register, because it
>    destroys boot loader information (the same way we need to not overwrite
>    BIOS extended areas and ACPI areas etc in order to be able to reboot
>    cleanly)
>  - we need _some_ way of getting the "kernel irq line" from /sys or /proc.
> 
> Sounds like /proc/pci still does something for us. Or is the info
> available in /proc/bus/pci/devices?

AFAICT, lspci is getting it from /proc/bus/pci/devices. I'm getting the 
source now to sift through and verify. Alternatively, the data is also 
available in the 'irq' file in each PCI device's sysfs directory. 

	-pat

