Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293206AbSCEOoq>; Tue, 5 Mar 2002 09:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293212AbSCEOoD>; Tue, 5 Mar 2002 09:44:03 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:16849 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S293206AbSCEOnj>; Tue, 5 Mar 2002 09:43:39 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 5 Mar 2002 06:43:35 -0800
Message-Id: <200203051443.GAA05242@adam.yggdrasil.com>
To: davem@redhat.com
Subject: Re: Does kmalloc always return address below 4GB?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   | If you acquired your memory via the page allocator
>   | (i.e. __get_free_page*()) or the generic memory allocators
>   | (i.e. kmalloc() or kmem_cache_alloc()) then you may DMA to/from
>   | that memory using the addresses returned from those routines.
[...]
>Probably it should qualify what it means with "and you used
>GFP_KERNEL".  Because that was the intention.

	That change alone would result in a setence that
I still would not understand.  Does GFP_KERNEL guarantee address
below 4GB on all architectures?  The GFP_KERNEL mask that currently
includes __GFP_IO, but I'm not sure that that even means "below 4GB"
on all architectures.  If __GFP_IO really does guarantee "below 4GB
and physical = virtual" on all architectures, then it sounds like
I am back to not having to use pci_{,un}map_single in a number of
places in advansys.c, because the Scsi_Request structurs are allocated
with GFP_ATOMIC, which also includes __GFP_IO.

>I'll fix that.

>However, you can use GFP_HIGH memory with pci_map_page _iff_
>you set your DMA mask to allow 64-bits.

>The original impetus for that quoted bit of DMA-mapping.txt
>was to make sure nobody used vmalloc() or kmap() pointers.

	Just to be clear, I assume that you mean that you cannot
simply cast these virtual addresses to dma_addr_t and that the
underlying physical memory is not guaranteed to be below 4GB,
but that you can use that memory with pci_map_single if your
PCI device can handle 64 bit addresses.

	If I got it right, then here is some proposed replacement
text, to possibly save you a little effort:

| 	You cannot directly use an address in an area returned by
| vmalloc() or kmap(), because these routines are *not* guaranteed to
| return addresses where virtual == cpu memory bus == pci.  You
| cannot even use those addresses with PCI device that only have
| 32 bit addressing, because the underlying physical memory may be
| above 4GB.
|
| 	However, a PCI card that does 64-bit addressing can
| access memory returned by vmalloc or kmap via the dma_addr_t
| address returned by pci_map_single or pci_map_page.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
