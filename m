Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263931AbRFHJAr>; Fri, 8 Jun 2001 05:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263932AbRFHJAh>; Fri, 8 Jun 2001 05:00:37 -0400
Received: from elin.scali.no ([195.139.250.10]:10761 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S263931AbRFHJA0>;
	Fri, 8 Jun 2001 05:00:26 -0400
Message-ID: <3B2093C7.E209C6A@scali.no>
Date: Fri, 08 Jun 2001 10:58:47 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Richard Henderson <rth@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Patrick Mochel <mochel@transmeta.com>, Alan Cox <alan@redhat.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>,
        Kanoj Sarcar <kanoj@google.engr.sgi.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 32-bit dma memory zone
In-Reply-To: <20010607153119.H1522@suse.de>
		<Pine.LNX.4.21.0106071402480.6604-100000@penguin.transmeta.com>
		<20010607145912.B2286@redhat.com> <15136.10909.941916.674145@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Richard Henderson writes:
>  > On most alphas we use only one zone -- ZONE_DMA.  The iommu makes it
>  > possible to do 32-bit pci to the entire memory space.
>  >
>  > For those alphas without an iommu, we also set up ZONE_NORMAL.
> 
> And on sparc64 since all machines have an iommu, we use just ZONE_DMA
> for everything.
> 

And on IA64 they use both ZONE_NORMAL and ZONE_DMA. ZONE_DMA is up to 4GB.

This setup actually makes a PCI device driver I'm writing kind of broken. It allocates
buffers (with get_free_page) for streaming DMA and pass them on to pci_map_sg(). These
buffers can be really large because this is a shared memory adapter where you basically
make large portions (>100MByte) of your memory available to other machines over the PCI
bus. Unfortunately this adapter is not able to do DAC (64bit addressing) so I have to be
sure that the physical memory is within a 32bit range. Bounce buffers is really out of the
question because it will kill my performance. On Alpha (atleast for the Tsunami and
Nautilus models I've looked at) this guaranteed by using either the direct mapped windows
(which limits you to 2GB of physical memory) or the IOMMU scatter-gather windows. On i386
I can't use GFP_DMA because this will only give me memory below 16MByte and that is not
enough for these buffers, but just using the ZONE_NORMAL (no special GFP flag to
get_free_page) memory is fine (BTW, I have not yet understood how a 32bit machine can
access more than 4GB physical memory..). The problem child here is IA64. These machines
may or may not have an IOMMU. If the machine doesn't have an IOMMU (like the 460GX
chipset) and you have a lot of memory (like 2GB) you might get a physical address above
the 4GB boundary which is no good for my 32bit device. The IA64 code fixes this by using
something called Sofwtare I/O TLB, which copies your data to a memory below the 4GB
boundary when you do pci_map_xxx (if direction is DMA_TO_DEVICE), and copies it back when
you do pci_unmap_ (if direction is DMA_FROM_DEVICE). I guess this is what you call bounce
buffers, but since this I/O TLB area is so small by default (4MByte I think) it is no good
either because I will soon run out of Software IO TLB Entries resulting in a kernel panic.
My solution here was to use the GFP_DMA flag to get_free_page to ensure that the page was
below the 4GB boundary.

Now, because of this I need a #ifdef __ia64__ (or maybe I could use #ifndef __i386__ ?) in
my driver but I would really not like to have that there. My suggestion is therefore to
have a ZONE_32BIT (and a corresponding GFP_32BIT flag) to have a common way of ensuring
that the memory you get is guaranteed to be below the 4GB boundary. Actually this is
already mentioned in the IA64 swiotlb_alloc_consistent() code :

if (!hwdev || hwdev->dma_mask <= 0xffffffff)
	gfp |= GFP_DMA; /* XXX fix me: should change this to GFP_32BIT or ZONE_32BIT */
ret = (void *)__get_free_pages(gfp, get_order(size));


Regards,
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
