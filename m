Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293448AbSCEQkK>; Tue, 5 Mar 2002 11:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293453AbSCEQkB>; Tue, 5 Mar 2002 11:40:01 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:63444 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S293448AbSCEQjm>; Tue, 5 Mar 2002 11:39:42 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 5 Mar 2002 08:39:29 -0800
Message-Id: <200203051639.IAA05629@adam.yggdrasil.com>
To: davem@redhat.com
Subject: Re: Does kmalloc always return address below 4GB?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   From: "Adam J. Richter" <adam@yggdrasil.com>
>   Date: Tue, 5 Mar 2002 06:43:35 -0800
>   
>   	Just to be clear, I assume that you mean that you cannot
>   simply cast these virtual addresses to dma_addr_t and that the
>   underlying physical memory is not guaranteed to be below 4GB,
>   but that you can use that memory with pci_map_single if your
>   PCI device can handle 64 bit addresses.
>   
>   	If I got it right, then here is some proposed replacement
>   text, to possibly save you a little effort:

>You haven't got it right.  Physical address > 4GB does not mean
>your 32-bit device cannot DMA to it.  Stop thinking about
>implementation, that's the whole point of the abstraction :-)

>On 64-bit platforms that don't set CONFIG_HIGHMEM, they have MMU's on
>the PCI bus that can map arbitrary 64-bit physical addresses to 32-bit
>PCI bus addresses.  So on these platforms you may pass any pointer
>from kmalloc()/alloc_page() whatsoever into the pci_map_foo()
>routines.

	I think you're confusing a "there exists one x" with "for every
x".  In your statement, you've reduced your universe to "platforms
that don't set CONFIG_HIGHMEM", but that is not all systems.

	While there exists one (or more) computers that have this
reverse mapping hardware, I believe that it is not true of *all*
platforms with >4GB of RAM.  I infer from your statement that
all 64-bit platforms that lack this hardware should define CONFIG_HIGHMEM.

>In order to handle highmem pages, you have to set your DMA mask
>appropriately (to indicate 64-bit addressing capability) and
>use pci_map_page() instead of pci_map_single().

	Let's say I have some random Pentium3 or Pentium4
machine with >4GB of memory, the PCI card in question only does 32 bit
addressing.  This is a CONFIG_HIGMEM platform and it lacks the
MMU that you discuss in the first paragraph of DMA-mapping.txt, right?

	Now imagine that a vmalloc in this driver returns a page
above 4GB (include/linux/vmalloc.h defines vmalloc() to pass __GFP_HIGHMEM).
What will pci_map_single return?   I think, under x86, pci_map_single
will call __pa, which will return the underlying physical address,
which, in this case, would be above 4GB, which would not be accessible
by the PCI card.

>Look at other drivers using the DMA interfaces like the two aic7xxx
>and all of the sym53c8xx drivers, they get it right.

	Grepping for vmalloc and kmap in them turns up no hits.

	I understand that your pci_alloc_consistent abstration allows
one to write a driver for a 32-bit PCI card that, on 64-bit systems
with the MMU that you describe, that will be able to use memory above 4GB
for IO transfers, like so:

		pci_set_dma_mask(pcidev, 0xffffffff);
		addr = pci_alloc_consistent(pcidev, nbytes, direction,
					    &dma_addr);
		/* __pa(addr) may be >4GB, but only on systems with
		   PCI address mapping hardware.  dma_address will
		   be <4GB on all systems. */
		TELL_DEVICE_TO_DO_TRANSFER(dma_addr, nbytes);
		pci_free_consistent(...);

	Maybe I need to rephrase my proposed text for greater
clarity.  The point of my proposed text was that, in the absense of
"#ifndef CONFIG_HIGMEM", the following code will not work on a 32-bit
computer with >4GB of RAM (CONFIG_HIGHEM) talking to a PCI card
that only does 32-bit addressing:

		pci_set_dma_mask(pcidev, 0xffffffff);
		addr = vmalloc(nbytes);
		/* On an x86 with >4GB of RAM, addr will be <4GB, but
	           __pa(addr) might be >4GB, and the system lacks
	           PCI address mapping harware. */

		dma_addr = pci_map_single(pcidev, addr, nbytes, direction);
		/* Uh oh!  dma_addr may be >4GB and I might not have	
		   PCI address mapping hardware! */
		TELL_DEVICE_TO_DO_TRANSFER(dma_addr, nbytes);
		pci_unmap_single(...);

	Was this unclear in my proposed text or do I still misunderstand
some fact that you're trying to convey (if so, sorry if for apparently
being so dense about it)?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
