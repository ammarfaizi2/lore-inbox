Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSFYOgL>; Tue, 25 Jun 2002 10:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSFYOgK>; Tue, 25 Jun 2002 10:36:10 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:47024 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315487AbSFYOgI>; Tue, 25 Jun 2002 10:36:08 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 25 Jun 2002 07:35:51 -0700
Message-Id: <200206251435.HAA06007@adam.yggdrasil.com>
To: davem@redhat.com
Subject: Re: RFC: turn scatterlist into a linked list, eliminate bio_vec
Cc: akpm@zip.com.au, axboe@suse.de, linux-kernel@vger.kernel.org,
       martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for the duplication, Dave.  I accidentally sent a reply to you only.]

>       1. It would help to document if pci_pool_alloc(pool,SLAB_KERNEL,&dma)
>          can ever return failure (as opposed to blocking forever).  That would
>          effect whether certain error legs have to be written in a device
>          driver.
>   
>Because a SLAB_KERNEL allocation can fail, thus can a pci_pool_alloc
>allocation.  These rules have everything to do with what SLAB_KERNEL
>means and there is nothing special about the fact that this flag is
>being passed to pci_pool_alloc instead of kmalloc or similar.

	Then we should mempool_alloc instead, which, according
to Jens Axboe never fails with GFP_KERNEL:

|> = Adam Richter
|  = Jens Axboe

|> 	Even so, if __GFP_WAIT never fails, then it can deadlock (for
|> example, some other device driver has a memory leak).  Under a
|> scheme like bio_chain (provided that it is changed not to call a
|> memory allocator that can deadlock), the only way you deadlock is
|> if there really is deadlock bug in the lower layers that process
|> the underlying request.
|
|This whole dead lock debate has been done to death before, I suggest you
|find the mempool discussions in the lkml archives from the earlier 2.5
|series. Basically we maintain deadlock free allocation although we never
|fail allocs by saying that a single bio allocation is short lived (or
|at least not held indefinetely). That plus a reserve of XX bios makes
|sure that someone will always return a bio to the pool sooner or later
|and at least the get_from_pool alloc above will succeed sooner or later
|even if vm pressure is ridicilous.



>       2. It sure would be nice if there were a couple of ifdef symbols
>          that controlled the expansion DECLARE_PCI_UNMAP_{ADDR,LEN}, so
>          that default usual implementations could be put in <linux/pci.h>,
>          and so that it would be possible to portbly write sg_dma_address()
>          that want to return sg.dma_addr if that field exists, and
>          sg.vaddr otherwise.  This is of practical use because I would like
>          to do the same thing for my proposed sglist.driver_priv{,_dma} fields.
>   
>Huh?  sg_dma_address() must return virt_to_bus() on non-IOMMU
>platforms.  If it returned the virtual address that would be
>a BUG().  Why do you want to change radically the semantics of
>sg_dma_address() in such a radical way?  It makes no sense.

	You don't understand what I'm asking.  On some platforms, such
as mips, there is no sglist->dma_address field.  Instead sg_dma_address(sg)
returns:

#define sg_dma_address(sg)	(virt_to_bus((sg)->address))

	What I want is:
	     1. To do the same thing with sg->driver_priv, and
	     2. To not have to repeat the implimentation in n different
	        architecture files.

	I would like something like this:

In include/asm-foo/pci.h.

/* Note that NEED_DMA_UNMAP_ADDR is different from NEED_SEPARATE_DMA_ADDR */ 
#define NEED_DMA_UNMAP_LEN	1
#define NEED_DMA_UNMAP_ADDR	1
#define NEED_SEPARATE_DMA_ADDR	1


In include/linux/pci.h:


#ifdef NEED_DMA_UNMAP_LEN
# define DECLARE_PCI_UNMAP_LEN(LEN_NAME)		size_t LEN_NAME
# define pci_unmap_len(PTR, LEN_NAME)		((PTR)->LEN_NAME)
# define pci_unmap_len_set(PTR, LEN_NAME, VAL)	(((PTR)->LEN_NAME) = (VAL))
#else
# define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
# define pci_unmap_len(PTR, LEN_NAME)		(0)
# define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
#endif

#ifdef NEED_DMA_UNMAP_ADDR
# define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)	dma_addr_t ADDR_NAME
# define pci_unmap_addr(PTR, ADDR_NAME)		((PTR)->ADDR_NAME)
# define pci_unmap_addr_set(PTR, ADDR_NAME, VAL) (((PTR)->ADDR_NAME) = (VAL))
#else
# define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
# define pci_unmap_addr(PTR, ADDR_NAME)		(0)
# define pci_unmap_addr_set(PTR, ADDR_NAME, VAL) do { } while (0)
#endif

#ifdef NEED_SEPARATE_DMA_ADDRESS
# define	DECLARE_PCI_DMA_ADDR(NAME)	dma_addr_t	name ## _dma
# define	PCI_DMA_ADDR(NAME)		name ## _dma
#else
# define	DECLARE_PCI_DMA_ADDR(NAME)
# define	PCI_DMA_ADDR(NAME)		virt_to_bus(name)
#endif


	

>       3. Isn't the stuff about scatterlist->address obselete.  I thought that
>          field was deleted in 2.5.
>   
>Yes, it should be killed, feel free to submit a patch.

	OK.  Will do when I get back from OLS.

>SLAB_KERNEL can fail for pci_pool_alloc as it can fail for
>kmalloc(...SLAB_KERNEL);  What makes you think that pci_pool_alloc
>changes the well defined semantics of the SLAB_KERNEL flag?

>   	Do you understand that scatterlist.driver_priv{,_dma} is just
>   a follow-on optimization of my proposal to turn struct scatterlist
>   into a linked list, so that pci_map_sg &co. can be consolidated into
>   the "mid-level" drivers (scsi.o, usb.o)?
>   
>To be honest I think this is a horrible idea while we still lack
>generic devices.  What about my SBUS scsi drivers, are they just sort
>of "left out" of your infrastructure because it is PCI based?

	Oh, I would love to get rid of the struct pci_dev usage.  In
fact, I had a version of that illustrative code that basically proposed
that (struct dma_device, dma_alloc_consistent, etc.).  I am just trying
to make these change incrementally.  Even without that change, moving
to an abstract dma_limits.

>Now is not the time for this, when we finally have the generic struct
>device stuff, then you can start doing DMA stuff at the generic layer.
>Until them you serve only to break things for non-PCI folks.

	How does my proposal change anything for the non-PCI folks or
make it harder to abstract away from PCI?

	I have to catch a plane to OLS now, so I may not be able to
respond for a while.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

