Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSFYV1b>; Tue, 25 Jun 2002 17:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSFYV1a>; Tue, 25 Jun 2002 17:27:30 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:36313 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315921AbSFYV13>; Tue, 25 Jun 2002 17:27:29 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 25 Jun 2002 14:27:18 -0700
Message-Id: <200206252127.OAA00819@adam.yggdrasil.com>
To: davem@redhat.com
Subject: Re: RFC: turn scatterlist into a linked list, eliminate bio_vec
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   	I believe that my proposal would make it much easier for
>   reduce the dependency on struct pci_device, because it should
>   greatly reduce the amount of code that would have to be changed.

>Fine but do it when we have the abstration to actually
>make it work, not before. [...]

	How can I help?  Who is working on this?  Is this just an idea
right now?  Are there patches floating around?

	If you want this to work through drivers/base, I could rename
struct bus_type to struct device_type (it really quite misnamed), and
create a new struct bus.  Here is roughly what I have in mind.  I am
cc'ing linux-kenrel in case anyone else wants to point out problems
or indicate that they are working on this.

struct bus_type {
#ifdef CONFIG_DEVICEFS	/* I really want to be able to config driverfs out */
	const char *name;	/* "pci", "isa", "sbus"... */
#endif
	(void *)(*alloc_consistent)(struct device *dev, size_t size,
				    dma_addr_t *dma_addr);
	void (*free_conistent)(struct device *dev, size_t size,
			       void *addr, dma_addr_t dma_handle);
	map_single...
	unmap_single...
	sync_single...
};

struct device {
	...
	struct bus_type *bus_type;
	struct device_type *dev_type;	/* Formerly device.bus */
	u64 dma_mask;			/* less than device.parent.dma_mask
					   Individual DMA channels on this
					   device might have tighter masks
					   than this, but will never have
					   looser ones. */
			
}

static inline void*
dma_alloc_consistent(struct device *dev, size_t size, dma_addr_t *dma_addr)
{
	return (*dev->bus_type->alloc_consistent)(dev, size, dma_addr);
}

static inline dma_addr_t
dma_map_single(struct device *dev, void *vaddr, size_t size, int direction)
{
#ifdef NEED_SEPARATE_DMA_ADDR
	return (*dev->bus_type->map_single)(dev, vaddr, size, directio);
#else
	return virt_to_bus(vaddr);
#endif
}

static inline void pci_unmap_single(struct device *dev, dma_addr_t dma_addr,
                                    size_t size, int direction)
{
        if (direction == PCI_DMA_NONE)
                BUG();
#ifdef NEED_SEPARATE_DMA_ADDR
	(*dev->bus_type->unmap_single)(dev, dma_addr, size, direction);
#endif
}


...in include/pci.h:...

/* Implemented in each arch subdirectory */
static void *__pci_alloc_consistent(struct device *dev, size_t size,
				    dma_addr_t *dma_addr);

/* Legacy interface */
static inline void *pci_alloc_consistent(struct device *pcidev, size_t size,
			   dma_addr_t *dma_addr)
{
	return __pci_alloc_consistent(&pcidev->dev, size, dma_addr);
}


....Somewhere in drivers/pci:....

struct bus_type pci_bus_type = {
	.name =			"pci",
	.alloc_consistent =	__pci_alloc_consistent,
	...
};

...Somewhere in drivers/?....

/* ISA uses the PCI routines. */
struct bus_type isa_bus_type = {
	.name =			"isa",
	.alloc_consistent =	__pci_alloc_consistent,
	...
};

...Somewhere in drivers/sbus... */
struct bus_type isa_bus_type = {
	.name =			"isa",
	.alloc_consistent =	__sbus_alloc_consistent,
	...
};


...In each arch/xxxx/pci.c...

void *__pci_alloc_consistent(struct device *dev, size_t size,
			     dma_addr_t *dma_addr)
{
	struct pci_dev *pci_dev = list_entry(dev, struct pci_dev, dev);
	...guts of existing pci_alloc_consistent implementation...
}


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
