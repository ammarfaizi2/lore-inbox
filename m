Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313299AbSEYDnA>; Fri, 24 May 2002 23:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSEYDm7>; Fri, 24 May 2002 23:42:59 -0400
Received: from 64-166-72-142.ayrnetworks.com ([64.166.72.142]:36744 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S313299AbSEYDm6>;
	Fri, 24 May 2002 23:42:58 -0400
Date: Fri, 24 May 2002 20:41:30 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Functions to complement pci_dma_sync_{single,sg}(). (was: Re: Possible discrepancy regarding streaming DMA mappings in DMA-mapping.txt?)
Message-ID: <20020524204130.A17401@ayrnetworks.com>
In-Reply-To: <20020523162425.G7205@ayrnetworks.com> <20020523.225927.132611174.davem@redhat.com> <20020524104345.J7205@ayrnetworks.com> <20020524.104209.31440798.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 10:42:09AM -0700, David S. Miller wrote:
> I see what your problem is, the interfaces were designed such
> that the CPU could read the data.  It did not consider writes.
> 
> It was designed to handle a case like a networking driver where
> a receive packet is inspected before we decide whether we accept the
> packet or just give it back to the card.
> 
> Feel free to design the "cpu writes, back to device ownership"
> interfaces and submit a patch :-)

Here is a patch to demonstrate which calls I'd like added. I'll send a
similar one to linux-mips if this interface looks ok...

This patch adds two functions, pci_dma_prep_single() and
pci_dma_prep_sg(), for a driver to relinquish a buffer to a PCI device
after having gained "ownership" via pci_dma_sync_*().  Essentially,
they should do whatever pci_map_*() does to prepare the buffer for
being accessed by the device, except for the mapping itself (e.g.
flush cache lines, copy to a bounce buffer if direction is
PCIDMA_TO_DEVICE, etc).

This is useful if one wants to use a buffer for making repeated DMA
transfers into a device without having to unmap the buffer. In such a
case, a typical usage would be:

	1) Take a buffer that is "owned" by the PCI device
	2) pci_dma_sync_single(...., PCIDMA_TO_DEVICE); buffer is
	   now owned by the driver
	3) Write into the buffer
	4) pci_dma_prep_single(...., PCIDMA_TO_DEVICE);
	5) Perform DMA transfer
	6) goto 1)

Thanks,
William

--
Index: include/asm-i386/pci.h
===================================================================
RCS file: /vger/linux/include/asm-i386/pci.h,v
retrieving revision 1.16.2.2
diff -c -r1.16.2.2 pci.h
*** include/asm-i386/pci.h	24 Jan 2002 13:38:58 -0000	1.16.2.2
--- include/asm-i386/pci.h	25 May 2002 03:24:56 -0000
***************
*** 209,214 ****
--- 209,247 ----
  	flush_write_buffers();
  }
  
+ /*
+  * Prepare buffer for a DMA transfer after driver temporarily
+  * re-claimed it with pci_dma_sync_*().
+  *
+  * In essence, this "returns" the buffer to the PCI device.
+  */
+ static inline void pci_dma_prep_single(struct pci_dev *hwdev,
+ 				       dma_addr_t dma_handle,
+ 				       size_t size, int direction)
+ {
+ 	if (direction == PCI_DMA_NONE)
+ 		BUG();
+ 
+ 	flush_write_buffers();
+ }
+ 
+ /*
+  * Prepare buffer for a DMA transfer after driver temporarily
+  * re-claimed it with pci_dma_sync_*().
+  *
+  * The same as pci_dma_prep_single but for a scatter-gather list,
+  * same rules and usage.
+  */
+ static inline void pci_dma_prep_sg(struct pci_dev *hwdev,
+ 				   struct scatterlist *sg,
+ 				   int nelems, int direction)
+ {
+ 	if (direction == PCI_DMA_NONE)
+ 		BUG();
+ 
+ 	flush_write_buffers();
+ }
+ 
  /* Return whether the given PCI device DMA address mask can
   * be supported properly.  For example, if your device can
   * only drive the low 24-bits during PCI bus mastering, then

