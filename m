Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274171AbRJDPiU>; Thu, 4 Oct 2001 11:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274758AbRJDPiK>; Thu, 4 Oct 2001 11:38:10 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:47438
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S274171AbRJDPiB>; Thu, 4 Oct 2001 11:38:01 -0400
Message-Id: <200110041537.f94Fbbt01665@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "David S. Miller" <davem@redhat.com>
cc: James.Bottomley@HansenPartnership.com, jes@sunsite.dk,
        linuxopinion@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Wed, 03 Oct 2001 17:24:39 PDT." <20011003.172439.66056954.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Oct 2001 10:37:37 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davem@redhat.com said:
> I know of hardware where doing the reverse mapping would not even be
> possible, the page tables are in hardware registers and are "write
> only".  This means you can't even read the PTEs back, you'd have to
> keep track of them in software and that is totally unacceptable
> overhead when it won't even be used %99 of the time.

> The DMA API allows us to support such hardware cleanly and
> efficiently, but once we add this feature which "everyone absolutely
> needs" we have a problem with the above mentioned piece of hardware. 

Walking the iommu page tables was only a suggestion of how it should be done.  
I'm not advocating providing this as a generic feature of the iommu handling 
software, but as an API.

What's wrong with implementing a separate API, like

pci_register_mapping(struct pci_dev *dev, void *virtualAddress, dma_addr_t 
dmaAddress, size_t size);
void *pci_dma_to_virtual(struct pci_dev *dev, dma_addr_t dmaAddress);
pci_unregister_mapping(struct pci_dev *dev, void *virtualAddress, dma_addr_t 
dmaAddress, size_t size);

?

That way, the driver will only ask for translations of addresses it knows its 
going to have difficulty with, so there's no overhead in the general mapping 
case where you don't request registration for a mapping lookup.

For an IOMMU with readable page tables, you can chose to implement the 
register/unregister as nops and do the pci_dma_to_virtual as a PTE walk.  For 
the really recalcitrant iommu hardware, you only save the mapping tables (or 
more likely just the mappings in a hash lookup table) when requested to.

This has the dual benefits of being completely backwards convertible from the 
old bus_to_virt et al. scheme and requiring no overhead unless the driver 
actually asks for it.

James Bottomley


