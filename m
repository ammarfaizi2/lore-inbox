Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132081AbQLHNY7>; Fri, 8 Dec 2000 08:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132086AbQLHNYt>; Fri, 8 Dec 2000 08:24:49 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:6917 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S132081AbQLHNYm>; Fri, 8 Dec 2000 08:24:42 -0500
Date: Fri, 8 Dec 2000 15:51:28 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI bridge setup weirdness
Message-ID: <20001208155128.A2926@jurassic.park.msu.ru>
In-Reply-To: <200012072246.eB7Mk9e13384@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200012072246.eB7Mk9e13384@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Dec 07, 2000 at 10:46:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 10:46:08PM +0000, Russell King wrote:
> It appears to be caused by the pci_read_bridge_bases code copying the
> pointer to the resources instead of making a copy of the resources
> themselves.

No, pci_read_bridge_bases() is obsoleted by new pci setup code. ;-)
You have to set up bus resources properly in pcibios_fixup_bus().
For a single root bus configuration, you don't need to do anything
with the root bus itself - its resources already point to ioport_resource
and iomem_resource, which should be ok. For pci-pci bridges you have
to add something like this:

	struct pci_dev *bridge = bus->self;

	if (bridge) {
		int i;

		for(i=0; i<3; i++) {
			bus->resource[i] =
				&bridge->resource[PCI_BRIDGE_RESOURCES+i];
			bus->resource[i]->name = bus->name;
		}
		bus->resource[0]->flags = pci_bridge_check_io(bridge);
		bus->resource[1]->flags = IORESOURCE_MEM;
		bus->resource[0]->end = ioport_resource.end;
		bus->resource[1]->end = iomem_resource.end;
		/* Turn off downstream PF memory address range by default */
		bus->resource[2]->start = 1024*1024;
		bus->resource[2]->end = bus->resource[2]->start - 1;
	}

Check arch/alpha/kernel/pci.c:pcibios_fixup_bus() for reference.

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
