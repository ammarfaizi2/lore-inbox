Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSFOWve>; Sat, 15 Jun 2002 18:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315718AbSFOWvd>; Sat, 15 Jun 2002 18:51:33 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:58826 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315717AbSFOWvd>; Sat, 15 Jun 2002 18:51:33 -0400
Date: Sat, 15 Jun 2002 17:51:22 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Peter Osterlund <petero2@telia.com>, Patrick Mochel <mochel@osdl.org>,
        Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <3D0B9E79.7010909@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0206151736080.7247-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Jeff Garzik wrote:

> That seems ok to me.  Note that we still want 
> pci_{enable,disable}_device to exist (as mentioned in the mail to 
> Kai)...  I'm fine with moving a lot of pci_enable_device's duties to 
> pci_{assign,request,release}_{irq,io,mem} as long as we don't kill it 
> completely.

I'm aware that something like pci_enable_device() still is necessary, but 
I moved this part of the functionality into pci_request_*.

pci_enable_device() does the equivalent of
{ pci_assign_irq(); pci_assign_mmio(); pci_assign_io() }
where these again internally do pci_set_power_state() (and could extended 
to do whatever else necessary).

The main reason against pci_enable_device() is that it makes a smooth 
transition impossible - We cannot change pci_enable_device()'s behavior in 
a way that relies on all drivers using pci_request_*() already. And 
introducing a new function under a new name seems pointless when it can be 
hidden inside the new API as well.

What's not so nice is that it destroys the symmetry between 
pci_enable_device() and pci_disable_device(). 

But I think I have an idea for that one as well: This new API will be used
in conjunction with the new-style pci_register_driver() etc interface,
where the PCI layer knows when we call ::probe() and ::remove(). So it'd
be actually even nicer to do the pci_set_power_state() etc before
::probe() is called, and pci_disable_device after::remove() has finished
(and on ::probe() error path)

How does that sound?

> When ia32 PCI irq routing messes up, or some other random reason why an 
> irq is not available for a PCI device, pdev->irq==0.  So I test for that 
> in my code.  Then DaveM bitches at me for my test (pdev->irq < 2) not 
> being cross-platform.
> 
> My suggested solution, if you like Kai's proposal, is to have 
> pci_assign_irq() or pci_request_irq() return an error if PCI IRQ routing 
> fails.

Yes, makes sense. Actually currently pci_enable_device() should return
an error when the IRQ routing fails - it does so when using ACPI routing, 
but not when doing PIRQ routing, so I think that's a bug to be fixed in
arch/i386/pci/irq.c.

I decided to return an int from pci_*_irq, where < 0 means error. The 
number returned otherwise shell only be used for printk("IRQ %d", ret), 
anyway - pci_dev->irq stays opaque to the driver.

Proposed patch to follow in a minute.


--Kai


