Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVIZWAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVIZWAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVIZWAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:00:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932338AbVIZWAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:00:21 -0400
Date: Mon, 26 Sep 2005 14:59:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olh@suse.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Stian Jordet <liste@jordet.nu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bogus VIA IRQ fixup in drivers/pci/quirks.c
In-Reply-To: <20050926184451.GB11752@suse.de>
Message-ID: <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org>
References: <20050926184451.GB11752@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Sep 2005, Olaf Hering wrote:
> 
> Why is the irq changed from 24 to 0, and why does uhci use irq 24
> anyway? I dont have the /proc/interrupts output from this box, maybe no
> interrupt is handled for the controller? None of the attached usb
> devices is recognized with 2.6.13.

Did that USB controller use to work in older kernels?

> <6>USB Universal Host Controller Interface driver v2.3
> <4>PCI: Enabling device 0000:00:0e.0 (0094 ->0095)
> <6>PCI:Via IRQ fixup for 0000:00:0e.0, from 24 to 0

That does seem to be seriously broken.

The old code wouldn't do that IRQ fixup for IO-APIC users, and I think 
that's correct.

The commit (93cffffa19960464a52f9c78d9a6150270d23785) says:

    [PATCH] PCI: do VIA IRQ fixup always, not just in PIC mode

    At least some VIA chipsets require the fixup even in IO-APIC mode.

    This was found and debugged with the patient assistance of Stian
    Jordet <liste@jordet.nu> on an Asus CUV266-DLS motherboard.

and I've cc'd the guilty parties. 

Bjorn: there's no way that "& 15" can be correct. There is no reason to
believe that the APIC interrupt number bears any relation to the legacy 
number or the low four bits.

Others (Mathieu Berard) have reported problems with that patch too, I
think we should revert it.

What are the numbers for Stian Jordet? It might make more sense to instead 
of comparing for ACPI/IO-APIC, just compare the irq against 16. Ie just do

	if (dev->irq > 15)
		return;

in quirk_via_irq(), since if it's not a legacy mode interrupt, we simply
don't know what to do. That "&15" is just a total guess, and makes little 
or no sense at all.

		Linus
