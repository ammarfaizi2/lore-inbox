Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbSKKQ67>; Mon, 11 Nov 2002 11:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbSKKQ67>; Mon, 11 Nov 2002 11:58:59 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:43780 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265806AbSKKQ65>; Mon, 11 Nov 2002 11:58:57 -0500
Date: Mon, 11 Nov 2002 20:05:39 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: CFT/RFC: New cardbus resource allocation
Message-ID: <20021111200539.A846@jurassic.park.msu.ru>
References: <20021106194126.B7495@flint.arm.linux.org.uk> <20021107132540.A2612@jurassic.park.msu.ru> <20021107103712.C7579@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021107103712.C7579@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Nov 07, 2002 at 10:37:12AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 10:37:12AM +0000, Russell King wrote:
> On Thu, Nov 07, 2002 at 01:25:40PM +0300, Ivan Kokshaysky wrote:
> > Looks quite reasonable.
> > Note that we don't need 2 similar functions in setup-res.c -
> > pci_assign_resource() can be easily converted to use your
> > pci_alloc_parent_resource(), and pci_assign_bus_resource() can
> > be killed then.
> 
> I looked at that and decided it wasn't practical.  pci_assign_resource()
> needs the parent resource to pass it down to the architecture specific
> layers.  Unfortunately, trying to get that out of
> pci_alloc_parent_resource() makes the API rather disgusting IMHO.

Sigh. The API is already broken - passing parent resource to
pcibios_update_resource() is not only pointless (since we have
res->parent), but extremely misleading.
Almost all architectures declare
void
pcibios_update_resource(struct pci_dev *dev, struct resource *root,
							      ^^^^
			struct resource *res, int resource)

Obviously root != parent.
Vast majority of archs do not use `root' arg, but some do:

mips64/mips-boards/generic/pci.c
mips64/sgi-ip27/ip27-pci.c
mips/ite-boards/generic/it8172_pci.c
mips/mips-boards/generic/pci.c
ia64/pci/pci.c

All of these use exactly the same code:

pcibios_update_resource(struct pci_dev *dev, struct resource *root,
                        struct resource *res, int resource)
{
	unsigned long where, size;
	u32 reg;

	where = PCI_BASE_ADDRESS_0 + (resource * 4);
	size = res->end - res->start;
	pci_read_config_dword(dev, where, &reg);
	reg = (reg & size) | (((u32)(res->start - root->start)) & ~size);
	pci_write_config_dword(dev, where, reg);
}

Which is wrong if the `root' is a pointer to the PCI or CardBus bridge
resource.

The arg 2 to pcibios_update_resource() must be removed...

Ivan.
