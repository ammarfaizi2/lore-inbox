Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSFOTja>; Sat, 15 Jun 2002 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315480AbSFOTj3>; Sat, 15 Jun 2002 15:39:29 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:9930 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315479AbSFOTj3>; Sat, 15 Jun 2002 15:39:29 -0400
Date: Sat, 15 Jun 2002 14:39:11 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Peter Osterlund <petero2@telia.com>, Patrick Mochel <mochel@osdl.org>,
        Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206151148320.3479-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0206151411410.7247-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Linus Torvalds wrote:

> On Sat, 15 Jun 2002, Linus Torvalds wrote:
> >
> > Right now the solution to a screaming device can be something as nasty as
> >
> > 	cli();
> > 	pci_enable_device();
> > 	disable_irq(dev->irq);
> > 	sti();
> >
> > 	/* IRQ handling needs this ioremapped */
> > 	membase = ioremap(dev->resource[]);
> > 	request_irq(dev->irq);
> >
> > 	/* Now we can enable the irq, because we have a valid handler */
> > 	enable_irq(dev->irq);
> 
> Side note: the other approach to screaming devices is to pray that they
> don't happen.

I think there are situations where we don't have a choice but praying
anyway. Since there's no PCI_COMMAND_IRQ, the only way to suppress IRQs
AFAICS is to not route them (well, or ignore them, which is what we do if 
there's no handler installed), but that's just not possible when the IRQ 
line is shared with some other active device.

I still think it's probably a good idea to replace pci_enable_device()
by a more fine-grained API, which allows a driver author to specify 
which exact resources he needs.

In the normal case, a driver would only use a subset of the following 
three functions as needed:

	int pci_request_irq(pci_dev, handler, ...);
	unsigned long pci_request_io(pci_dev, nr);
	unsigned long pci_request_mmio(pci_dev, nr);

(plus appropriate s/request/release/ of course)

Internally, they'd do the right thing, i.e. assign and enable resources as 
needed.

At least for the _irq case an associated

	int pci_assign_irq(pci_dev);

is useful, since some drivers (e.g. net, serial) only request their irq 
when the device is opened (which make sense for performance reasons with 
shared irqs), but it'd still be nice to fail the ::probe() when no IRQ can 
be assigned.

So a complete API would be

	pci_request_{irq,io,mmio}
	pci_release_{irq,io,mmio}
	pci_enable_{irq,io,mmio}
	pci_assign_{irq,io,mmio}

but normally a driver would just use pci_request/release_*() + maybe
pci_assign_irq(), which will take care of the appropriate assign/enable
internally.

--Kai



