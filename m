Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSHOPyj>; Thu, 15 Aug 2002 11:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317176AbSHOPyj>; Thu, 15 Aug 2002 11:54:39 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:6341 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317170AbSHOPyi>; Thu, 15 Aug 2002 11:54:38 -0400
Date: Thu, 15 Aug 2002 10:58:17 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'colpatch@us.ibm.com'" <colpatch@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>, <jgarzik@mandrakesoft.com>,
       "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>
Subject: RE: [patch] PCI Cleanup
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DD92@orsmsx119.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0208151014210.849-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2002, Grover, Andrew wrote:

> ACPI needs access to PCI config space, and it doesn't have a struct pci_dev
> to pass to access functions. It doesn't look like your patch exposes an
> interface that 1) doesn't require a pci_dev and 2) abstracts the PCI config
> access method, does it?

I think drivers/hotplug/pci_hotplug_util.c implements something like you 
need, pci_read_config_byte_nodev().

Of course that's currently only available for PCI hotplug, and for all I 
can see the concept is somewhat messed up, but maybe that's an opportunity 
to clean things up?

Currently, pci_read_config_byte_nodev() will construct a fake struct 
pci_dev, and then use the normal pci_read_config_byte(). I think it 
makes more sense to actually do things the other way around.

For reading/writing config space, we need to know (dev, fn), and need the 
access method (struct pci_ops), which is a property of the bridge plus 
possibly some private data (the arch's sysdata). So the member

	struct pci_ops *ops;

of struct pci_dev is actually not necessary, it will always be
pdev->ops == pdev->bus->ops AFAICS.

So we could instead have

	pci_bus_read_config_byte(struct pci_bus *bus, u8 dev, u8 fn, ...)

and for common use

	static inline pci_read_config_byte(struct pci_dev, *pdev, ...)
	{
		return pci_bus_read_config_byte(pdev->bus,
						PCI_SLOT(pdev->devfn),
						PCI_FUNC(pdev->devfn));
	}

The PCI hotplug controllers / ACPI could then use the pci_bus_* variants, 
when they don't have a struct pci_dev available. They would need at least 
the root bridge's struct pci_bus, though.

--Kai


