Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSEXVIW>; Fri, 24 May 2002 17:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310835AbSEXVIW>; Fri, 24 May 2002 17:08:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56706 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310206AbSEXVIT>;
	Fri, 24 May 2002 17:08:19 -0400
Date: Fri, 24 May 2002 13:53:52 -0700 (PDT)
Message-Id: <20020524.135352.131897757.davem@redhat.com>
To: wjhun@ayrnetworks.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible discrepancy regarding streaming DMA mappings in
 DMA-mapping.txt?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020524135842.L7205@ayrnetworks.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Jhun <wjhun@ayrnetworks.com>
   Date: Fri, 24 May 2002 13:58:42 -0700

   Sorry, I'm not clear on this one. I was first proposing (for the short
   term, at least) to not change anything at all: all the existing
   implementations of pci_dma_sync_*(..., PCIDMA_TO_DEVICE) already do what
   is required: prepare the buffer to be DMAed from by the controller. Most
   drivers won't have to deal with this; most network drivers, for example,
   do a pci_map_*() on an skb passed down from the stack and subsequently
   pci_unmap_*() those buffers once transmitted, thus having no need for
   pci_dma_sync_*()... So I don't see how this makes anything else less
   efficient...
   
The network drivers use PCI_DMA_FROM_DEVICE because they are working
on receive packets, which get DMA'd 'from' the device to memory.

This is also the same case the SCSI drivers use.

   > Please, add a new call to handle your case.  Thanks.
   
   Such a call would do what pci_dma_sync_*(..., PCIDMA_TO_DEVICE) already
   does (unless that is what you want - to have a new call just for the
   sake of clarity...).
   
A call with PCI_DMA_TO_DEVICE means nearly the same thing
as PCI_DMA_FROM_DEVICE.  Namely "revoke PCI ownership of memory"
which means "take the memory out of the PCI domain".

Implementation wise this means:

1) If PCI_DMA_TO_DEVICE, purge any data cached in PCI controller
   prefetch caches that require SW flushing.

2) If PCI_DMA_FROM_DEVICE, do the actions in #1 plus if CPU
   is not cache coherent flush caches so that PCI written
   data is visible to the CPU.

That is what the interface does.

Now that we've established that, you want a new operation.
That operation is "Re-prepare DMA memory so that PCI realm
will see it".  And the semantics of this would be to, on
CPUs which are no cache coherent with PCI, to flush the cache
to prevent inconsistencies between PCI and the CPU.

The CPU cache flush is needed in both cases to/from cases.

So do you finally understand why you must create a new interface
to accomplish what you want?
