Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSKMRRQ>; Wed, 13 Nov 2002 12:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSKMRRP>; Wed, 13 Nov 2002 12:17:15 -0500
Received: from host194.steeleye.com ([66.206.164.34]:14097 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262266AbSKMRRO>; Wed, 13 Nov 2002 12:17:14 -0500
Message-Id: <200211131723.gADHNmp02426@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Bjorn Helgaas <bjorn_helgaas@hp.com>
cc: Greg KH <greg@kroah.com>, Miles Bader <miles@gnu.org>,
       "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device 
 interface
In-Reply-To: Message from Bjorn Helgaas <bjorn_helgaas@hp.com> 
   of "Wed, 13 Nov 2002 09:32:00 MST." <200211130932.00864.bjorn_helgaas@hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Nov 2002 12:23:48 -0500
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Absolutely.  Boxes with multiple IOMMUs (at least ia64, sparc64,
> parisc) need to look up the correct IOMMU with which to map the
> allocated buffer. Typically this is in the pci_dev sysdata. 

Actually, I think all of the DMA mapping api needs to become bus independent 
and take a struct device * instead of a pci_dev.  How this lookup/mapping is 
done could be abstracted per architecture inside the DMA api internals.

We should also allow devices to do all the setup through bus generic 
functions, but leave open the possibility that the driver may (once it knows 
the bus type) obtain the pci_dev (or whatever) from the struct device if it 
really, really has to muck with bus specific registers.

As far as the SCSI mid layer goes, all we really need from struct device is 
the dma_mask for setting up the I/O bounce buffers.

The simplest way to do all of this is probably to add a pointer to the 
dma_mask in struct device and make it point to the same thing in pci_dev.  If 
we find we need more than this per device, it could become a pointer to a 
generic dma information structure later on.

Drivers need to advertise DMA conformance (at the moment, requires consistent 
allocation, or fully writeback/invalidate compliant)

We should also adopt Adam's pointer approach to the sync/invalidate points so 
we can treat a dma_alloc_consistent failure as a real failure and not clutter 
the code with writeback/invalidate fallbacks.

The above changes would allow me to yank all of the pci_dev specific code out 
of the scsi mid layer, and also introduce a mca_dev type, convert the 53c700 
driver to using the generic dma API and *finally* get us to the point where I 
don't have to use bounce buffers for highmem access on the MCA bus.

Since the 53c700 is also used by parisc (including some machines with 
IOMMUs---which, unfortunately, I don't have access to), it probably makes an 
ideal conversion test case.

This can probably all be wrappered so the current SCSI pci drivers don't 
notice anything wrong.

James


