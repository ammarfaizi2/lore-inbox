Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289606AbSCEWAN>; Tue, 5 Mar 2002 17:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291013AbSCEWAI>; Tue, 5 Mar 2002 17:00:08 -0500
Received: from elin.scali.no ([62.70.89.10]:49677 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S289606AbSCEV7u>;
	Tue, 5 Mar 2002 16:59:50 -0500
Message-ID: <3C853F5B.60B57A37@scali.com>
Date: Tue, 05 Mar 2002 22:57:47 +0100
From: Steffen Persvold <sp@scali.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
In-Reply-To: <200203051639.IAA05629@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
[snip]
> 
>         I understand that your pci_alloc_consistent abstration allows
> one to write a driver for a 32-bit PCI card that, on 64-bit systems
> with the MMU that you describe, that will be able to use memory above 4GB
> for IO transfers, like so:
> 
>                 pci_set_dma_mask(pcidev, 0xffffffff);
>                 addr = pci_alloc_consistent(pcidev, nbytes, direction,
>                                             &dma_addr);
>                 /* __pa(addr) may be >4GB, but only on systems with
>                    PCI address mapping hardware.  dma_address will
>                    be <4GB on all systems. */
>                 TELL_DEVICE_TO_DO_TRANSFER(dma_addr, nbytes);
>                 pci_free_consistent(...);
> 
>         Maybe I need to rephrase my proposed text for greater
> clarity.  The point of my proposed text was that, in the absense of
> "#ifndef CONFIG_HIGMEM", the following code will not work on a 32-bit
> computer with >4GB of RAM (CONFIG_HIGHEM) talking to a PCI card
> that only does 32-bit addressing:
> 
>                 pci_set_dma_mask(pcidev, 0xffffffff);
>                 addr = vmalloc(nbytes);
>                 /* On an x86 with >4GB of RAM, addr will be <4GB, but
>                    __pa(addr) might be >4GB, and the system lacks
>                    PCI address mapping harware. */
> 
>                 dma_addr = pci_map_single(pcidev, addr, nbytes, direction);
>                 /* Uh oh!  dma_addr may be >4GB and I might not have
>                    PCI address mapping hardware! */
>                 TELL_DEVICE_TO_DO_TRANSFER(dma_addr, nbytes);
>                 pci_unmap_single(...);
> 
>         Was this unclear in my proposed text or do I still misunderstand
> some fact that you're trying to convey (if so, sorry if for apparently
> being so dense about it)?
> 


This is sort of the same question I have, the only problem you will have here is that vmalloc() will
return only _virtual_ contiguous pages, not physical, so you would actually have to use pci_map_sg()
instead of pci_map_single(). The problem is that vmalloc() itself is not restricted to allocate
pages which is guaranteed to be directly DMA capable for the PCI device so the pci_map_xxx function
will have to allocate bounce buffers for the data if the physical address is not within the device's
limits. I'm proposing a new interface, something in the line of :

First set the DMA boundaries for our device:
pci_set_dma_mask(pcidev, 0xffffffff);

Then use this API to allocate DMA capable memory (this API also does the mapping to PCI so the
pci_map_xx calls is not needed when using it) :

dmamem = pci_alloc_dmamem(pcidev, nbytes, &vaddr, CONSISTENT);

to get consistent memory (a memory region where caching and so on would be turned off for certain
platforms). This memory is of course physical contiguous (this is the equivalent to the existing
pci_alloc_consistent() function).

dmamem = pci_dmamem_alloc(pcidev, nbytes, &vaddr, BIDIRECTIONAL);

to get a streaming memory region which should be accessible from kernel space, but isn't needed to
be physical contiguous (i.e. using a scatter-gather table for all the physical pages when mapping it
to PCI). vmalloc() could be used to get the pages here.

dmamem = pci_dmamem_alloc(pcidev, nbytes, &vaddr, BIDIRECTIONAL | CONTIGUOUS);

to get a streaming memory region which should be accessible from kernel space and also physical
contiguous (i.e. using get_free_pages() or kmalloc() to get the pages).

dmamem = pci_dmamem_alloc(pcidev, nbytes, NULL, BIDIRECTIONAL);

to get a streaming memory region which is not accessed by the kernel at all (i.e a frame grabber
buffer or a SCI shared memory segment only used in user space).

Feeding the I/O addresss and length to the actual PCI adapter should be done sort of the same way as
before :

nents = pci_dmamem_nents(dmamem);
for (i = 0; i < nents; i++) {
   hw_address[i] = pci_dmamem_address(dmamem, i);
   hw_len[i] = pci_dmamem_len(dmamem, i);
}

On contigous and consistent memory regions, nents should be one and therefore no looping should be
neccessary :

hw_address = pci_dmamem_address(dmamem, 0);
hw_len = pci_dmamem_len(dmamem, 0);

hw_len here should of course correspond to the nbytes argument given to the pci_alloc_dmamem()
function.

So, what do you think ? Is this something we should think of for 2.5, or am I on the wrong side of
the road here ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
