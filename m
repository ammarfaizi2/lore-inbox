Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSFYOEx>; Tue, 25 Jun 2002 10:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSFYOEw>; Tue, 25 Jun 2002 10:04:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43239 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315485AbSFYOEv>;
	Tue, 25 Jun 2002 10:04:51 -0400
Date: Tue, 25 Jun 2002 06:58:32 -0700 (PDT)
Message-Id: <20020625.065832.105409446.davem@redhat.com>
To: adam@yggdrasil.com
Cc: akpm@zip.com.au, axboe@suse.de, linux-kernel@vger.kernel.org,
       martin@dalecki.de
Subject: Re: RFC: turn scatterlist into a linked list, eliminate bio_vec
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206242044.NAA04851@adam.yggdrasil.com>
References: <200206242044.NAA04851@adam.yggdrasil.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Mon, 24 Jun 2002 13:44:25 -0700

       1. It would help to document if pci_pool_alloc(pool,SLAB_KERNEL,&dma)
          can ever return failure (as opposed to blocking forever).  That would
          effect whether certain error legs have to be written in a device
          driver.
   
Because a SLAB_KERNEL allocation can fail, thus can a pci_pool_alloc
allocation.  These rules have everything to do with what SLAB_KERNEL
means and there is nothing special about the fact that this flag is
being passed to pci_pool_alloc instead of kmalloc or similar.

       2. It sure would be nice if there were a couple of ifdef symbols
          that controlled the expansion DECLARE_PCI_UNMAP_{ADDR,LEN}, so
          that default usual implementations could be put in <linux/pci.h>,
          and so that it would be possible to portbly write sg_dma_address()
          that want to return sg.dma_addr if that field exists, and
          sg.vaddr otherwise.  This is of practical use because I would like
          to do the same thing for my proposed sglist.driver_priv{,_dma} fields.
   
Huh?  sg_dma_address() must return virt_to_bus() on non-IOMMU
platforms.  If it returned the virtual address that would be
a BUG().  Why do you want to change radically the semantics of
sg_dma_address() in such a radical way?  It makes no sense.

       3. Isn't the stuff about scatterlist->address obselete.  I thought that
          field was deleted in 2.5.
   
Yes, it should be killed, feel free to submit a patch.
   
   	Thanks for reminding me of them.  Although I had explored using
   them in another situation, I forgot about them for this situation, where
   they make sense, especially if pci_pool_alloc(...,SLAB_KERNEL,...) can
   never fail for lack of memory (although they could block indefinitely).
   I have updated my sample code accordingly.
   
SLAB_KERNEL can fail for pci_pool_alloc as it can fail for
kmalloc(...SLAB_KERNEL);  What makes you think that pci_pool_alloc
changes the well defined semantics of the SLAB_KERNEL flag?

   	Do you understand that scatterlist.driver_priv{,_dma} is just
   a follow-on optimization of my proposal to turn struct scatterlist
   into a linked list, so that pci_map_sg &co. can be consolidated into
   the "mid-level" drivers (scsi.o, usb.o)?
   
To be honest I think this is a horrible idea while we still lack
generic devices.  What about my SBUS scsi drivers, are they just sort
of "left out" of your infrastructure because it is PCI based?

Now is not the time for this, when we finally have the generic struct
device stuff, then you can start doing DMA stuff at the generic layer.
Until them you serve only to break things for non-PCI folks.
