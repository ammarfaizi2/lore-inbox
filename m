Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbRGFPTp>; Fri, 6 Jul 2001 11:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266734AbRGFPTg>; Fri, 6 Jul 2001 11:19:36 -0400
Received: from elin.scali.no ([195.139.250.10]:26130 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S266731AbRGFPT0>;
	Fri, 6 Jul 2001 11:19:26 -0400
Message-ID: <3B45D656.440A34A9@scali.no>
Date: Fri, 06 Jul 2001 17:16:38 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Helge Hafting <helgehaf@idb.hist.no>,
        Vasu Varma P V <pvvvarma@techmas.hcltech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: DMA memory limitation?
In-Reply-To: <E15ITTf-0004Dz-00@the-village.bc.nu> <3B45A08D.408D56@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > GFP_DMA is ISA dma reachable, Forget the IA64, their setup is weird and 
> > should best be ignored until 2.5 as and when they sort it out.

Really ? I don't think I can ignore IA64, there are people who ask for it....

> > > bounce buffers are needed. On Alpha GFP_DMA is not limited at all (I think). Correct me if
> >
> > Alpha has various IOMMU facilities
> >
> > > I'm wrong, but I really think there should be a general way of allocating memory that is
> > > 32bit addressable (something like GFP_32BIT?) so you don't need a lot of #ifdef's in your
> > > code.
> > No ifdefs are needed
> >
> >         GFP_DMA - ISA dma reachable
> >         pci_alloc_* and friends - PCI usable memory
> 
> pci_alloc_* is designed to support ISA.
> 
> Pass pci_dev==NULL to pci_alloc_* for ISA devices, and it allocs GFP_DMA
> for you.
> 

Sure, but the IA64 platforms that are out now doesn't have an IOMMU, so bounce buffers are
used if you don't specify GFP_DMA in your get_free_page.

Now lets say you have a driver with a page allocator. Eventually you want to make some if
the allocated pages available to a 32bit PCI device. These pages has to be consistent (i.e
the driver doesn't have to wait for a PCI flush for the data to be valid, sort of like a
ethernet ring buffer). I could use the pci_alloc_consistent() function
(pci_alloc_consistent() allocates a buffer with GFP_DMA on IA64), but since I already have
the pages, I have to use pci_map_single (or pci_map_sg). Inside pci_map_single on IA64
something called swiotlb buffers (bounce buffers) are used if the device can't support
64bit addressing and the address of the memory to map is above the 4G limit. The swiotlb
buffers are below the 4G limit and therefore reachable by any PCI device. The problem
about these buffers are that the content are not copied to the original location before
you do a pci_sync_* or a pci_unmap_* (they are not consistent) and they are a limited
resource (allocated at boot time). My solution for now was to use :

#if defined(__ia64__)
  int flag = GFP_DMA;
#else
  int flag = 0;
#endif

Maybe IA64 could implement GFP_HIGHMEM (as on i386) so that if no flags were used you were
guaranteed to get 32bit memory ???


Regards
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
