Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135622AbRDSNci>; Thu, 19 Apr 2001 09:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135672AbRDSNc3>; Thu, 19 Apr 2001 09:32:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6157 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135671AbRDSNcM>; Thu, 19 Apr 2001 09:32:12 -0400
Subject: Re: PCI power management
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 19 Apr 2001 14:33:06 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-pm-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        jgarzik@mandrakesoft.com (Jeff Garzik)
In-Reply-To: <20010419131453.12448@mailhost.mipsys.com> from "Benjamin Herrenschmidt" at Apr 19, 2001 03:14:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qEYX-0007Cl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >	pci_power_on_generic
> >	pci_power_off_generic
> >	pci_power_on_null
> >	pci_power_off_null
> >
> >At which point most driver writers are having to do no thinking at all about
> >their device. The PCI layer just requires they pick a function and stick it
> >in the struct pci_device. 
> 
> Could you elaborate about the difference between generic and null
> functions ? I'm not sure I understand what you mean...

null = 'do absolutely nothing'
generic = 'do D3 as per the specification'

The idea being the PM layer would go around calling

	dev->power_off(dev);

as a default notifier for PCI devices.

> one to know if it will be able to bring back the card from a power off
> state or not. It's the only one to know if it can reconfigure the card
> completely without having a BIOS run before it.

And in the case of the cards like that you would need a custom mask. So you'd
do
	pci_set_power_handler(dev, atyfb_power_on, atyfb_power_off)

to get a custom function. For most authors however they can call the power
handler setup just using prerolled functions that do the right thing and know
about any architecture horrors they dont.

> pci_power_off(uint mask);
> 
> where mask is
> 
>   PCI_POWER_MASK_D1 = 0x00000001
>   PCI_POWER_MASK_D2 = 0x00000002
>   PCI_POWER_MASK_D3 = 0x00000004
>   PCI_POWER_MASK_NOCLOCK = 0x00000008
>   PCI_POWER_MASK_NOPOWER = 0x00000010

I'd rather

	pci_dev->powerstate

or similar as a set of flags in the device.

Alan

