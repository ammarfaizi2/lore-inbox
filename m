Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVAFOSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVAFOSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 09:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVAFOSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 09:18:13 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:10390 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S262838AbVAFOSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 09:18:04 -0500
Date: Thu, 6 Jan 2005 15:18:03 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APIC/LAPIC hanging problems on nForce2 system.
In-Reply-To: <41DCFEF0.5050105@gmx.de>
Message-ID: <Pine.LNX.4.60.0501061447420.30532@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
 <41DC1AD7.7000705@gmx.de> <Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>
 <41DC2113.8080604@gmx.de> <Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz>
 <41DC2353.7010206@gmx.de> <Pine.LNX.4.60.0501060046450.26952@kepler.fjfi.cvut.cz>
 <41DCFEF0.5050105@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jan 2005, Prakash K. Cheemplavam wrote:

> Martin Drab schrieb:
> > On Wed, 5 Jan 2005, Prakash K. Cheemplavam wrote:
> > 
> > ...
> > DEBUG: pci_fixup_nforce2() called.
> > DEBUG:   nForce2 revision byte = 0xC1.
> > DEBUG:   fixed value = 0x9F01FF01.
> > DEBUG:   current value = 0x8F0FFF01.  <---------------
> > ...
> > 
> > So that means, that the device doesn't have the "C1 Halt Disconnect"
> > enabled at that point, and, though, no fixup is done. However, if you take
> > a closer look at the result of "lspci -xxx" (attached as "lspci-xxx.log"),
> > 
> > 00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)
> > (rev c1)
> > ...
> > 60: 08 00 01 20 20 00 88 80 10 00 00 00 01 ff 0f 9f <-------
> > ...
> > 
> > you'll notice, that all of a sudden that bit 28 of PCI.0x6c *is set!! That
> > means, that sometimes later, after the pci_fixup_nforce2() is called,
> > something, smewhere, somehow has to set the bit to 1. But this part in the
> > arch/i386/pci/fixup.c prevents it.
> 
> You are not by chance using athcool or something to enable disconnect?

Yes, in fact I am. So that enables it then, OK.
 
> > 
> >         /*
> >          * Apply fixup only if C1 Halt Disconnect is enabled
> >          * (bit28) because it is not supported on some boards.
> >          */
> > 	    vvvvvvvvvvvvvvvvv
> >         if ((val & (1 << 28)) && val != fixed_val) {
> >                 printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect
> > fixup\n");
> >                 pci_write_config_dword(dev, 0x6c, fixed_val);
> >         }
> > 
> > So my question is: Is the condition necessary? If there really are boards,
> > that don't support this, then is would probably have to be a more
> > sophisticated test, or the fixup would have to be called again later, when
> > the flag is set. BTW.: Any clue on what could possibly set the flag?
> 
> Well, I also think it is quite stupid to only apply the fix if
> disconnect is enabled at boot time and don't apply it if it is not. The
> kernel dev responsible for it is rather pedantic: Fix only when needed,
> ie don't apply anything in a foreseeing way (prevent what could break),
> if change something in userspace, do it correctly. (not exact words of
> course, but the conclusion of it.) Ie if you enable disconnect outside
> of bios and kernel, you should also set the fix by hand...
> 
> Easy workaround: Enable disconnect in bios, if possible, then the kernel
> will fix it for you...

That assumes that the BIOS allows to enable it.

> I admit there is logic behind the dev's point of view, nevertheless it
> is not a very near-to-life-and-make-it-simpler-for-the-user logic. There
> is often a difference in point of view of kernel dev and average user...

Right. And how about to fix it, but leave the disconnect bit in its 
previous state. Would it help? Something like

	fixed_val = (val & (1<<28)) | (fixed_val & ~(1<<28));
	if (val != fixed_val) {
		printk(KERN_WARNING "PCI: nForce2 C1 Halt Disconnect fixup\n");
		pci_write_config_dword(dev, 0x6c, fixed_val);
	}

Martin

