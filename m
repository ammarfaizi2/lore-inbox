Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268688AbTCCSJg>; Mon, 3 Mar 2003 13:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268694AbTCCSJG>; Mon, 3 Mar 2003 13:09:06 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:55974 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP
	id <S268688AbTCCSId>; Mon, 3 Mar 2003 13:08:33 -0500
Date: Mon, 3 Mar 2003 11:18:48 -0700
From: Matt Porter <porter@cox.net>
To: linux-kernel@vger.kernel.org
Subject: *dma_sync_single API change to support non-coherent cpus
Message-ID: <20030303111848.A31278@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA API currently defines the *dma_sync_single call as:

   void dma_sync_single(struct device *, dma_addr_t, size_t,
		        enum dma_data_direction);
   void pci_dma_sync_single(struct pci_dev *, dma_addr_t, size_t, int);

On non cache coherent processors, it is necessary to perform
cache operations on the virtual address associated with the
buffer to ensure consistency.  There is one problem, however,
the current API does not provide the virtual address for the
buffer.  It only provides the bus address in the dma_addr_t.
On arm and mips, this is dealt with by simply doing bus_to_virt().
However, bus_to_virt() isn't valid for all addresses that could
have been passed into *map_single().

Consider a system, where the virtual address passed to *map_single()
is in vmalloc space.  It could be a resource on a PCI device (memory)
or an on-chip SRAM packet buffer, for example.  The API does not
(and should not) make any claims as to the type of kernel virtual
addresses it can digest.  However, translating from a bus address
to original virtual address to perform cache operations is only
reliable on a non cache coherent processor if the buffer is assumed
to be system memory allocated through kmalloc or the zone allocator.
In other words, the "bus_to_virt() method" generates bogus virtual
addresses unless the original virtual address was located within
our permanently mapped lowmem.

On PPC, we are currently forced to do a full cache flush to work
around this limitation and support all possible values passed through
the API.  Obviously this has some performance implications.  On
the well-known eepro100 driver it incurs a 30% performance hit on
a PPC440GP processor.

I believe the API should be changed to pass a virtual address, since
all callers should have the virtual address available since it is
used in the *dma_map_single()/unmap() calls.  I looked through
all the architectures, and most would be minimally affected by
this change since the dma handle is unused in the implementation.
For the ones that use it (usually 64-bit platforms with an iommu), they
can perform the same virt->bus transformation that they already perform
in their *dma_map_single() implementation.  Proposed API follows:

   void dma_sync_single(struct device *, void *, size_t,
		        enum dma_data_direction);
   void pci_dma_sync_single(struct pci_dev *, void *, size_t, int);

There are, of course, a number of drivers to change to reflect the
API difference.  However, it's a relative limited number since most
drivers use map/unmap with no sync_single.

A sample patch for i386/ppc and eepro100 example mods is below.  If
we agree to make the change I can generate a patch for everything
else if necessary.  Also, the same change should also apply to the
pci_dac_dma_sync_single() variant.

-Matt

===== drivers/net/eepro100.c 1.57 vs edited =====
--- 1.57/drivers/net/eepro100.c	Mon Feb 24 11:34:28 2003
+++ edited/drivers/net/eepro100.c	Mon Mar  3 11:11:57 2003
@@ -1292,7 +1292,7 @@
 		skb_reserve(skb, sizeof(struct RxFD));
 		if (last_rxf) {
 			last_rxf->link = cpu_to_le32(sp->rx_ring_dma[i]);
-			pci_dma_sync_single(sp->pdev, last_rxf_dma,
+			pci_dma_sync_single(sp->pdev, last_rxf,
 					sizeof(struct RxFD), PCI_DMA_TODEVICE);
 		}
 		last_rxf = rxf;
@@ -1302,13 +1302,13 @@
 		/* This field unused by i82557. */
 		rxf->rx_buf_addr = 0xffffffff;
 		rxf->count = cpu_to_le32(PKT_BUF_SZ << 16);
-		pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[i],
+		pci_dma_sync_single(sp->pdev, rxf,
 				sizeof(struct RxFD), PCI_DMA_TODEVICE);
 	}
 	sp->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
 	/* Mark the last entry as end-of-list. */
 	last_rxf->status = cpu_to_le32(0xC0000002);	/* '2' is flag value only. */
-	pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[RX_RING_SIZE-1],
+	pci_dma_sync_single(sp->pdev, rxf,
 			sizeof(struct RxFD), PCI_DMA_TODEVICE);
 	sp->last_rxf = last_rxf;
 	sp->last_rxf_dma = last_rxf_dma;
@@ -1680,7 +1680,7 @@
 	skb->dev = dev;
 	skb_reserve(skb, sizeof(struct RxFD));
 	rxf->rx_buf_addr = 0xffffffff;
-	pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[entry],
+	pci_dma_sync_single(sp->pdev, rxf,
 			sizeof(struct RxFD), PCI_DMA_TODEVICE);
 	return rxf;
 }
@@ -1694,7 +1694,7 @@
 	rxf->count = cpu_to_le32(PKT_BUF_SZ << 16);
 	sp->last_rxf->link = cpu_to_le32(rxf_dma);
 	sp->last_rxf->status &= cpu_to_le32(~0xC0000000);
-	pci_dma_sync_single(sp->pdev, sp->last_rxf_dma,
+	pci_dma_sync_single(sp->pdev, sp->last_rxf,
 			sizeof(struct RxFD), PCI_DMA_TODEVICE);
 	sp->last_rxf = rxf;
 	sp->last_rxf_dma = rxf_dma;
@@ -1767,7 +1767,7 @@
 		int status;
 		int pkt_len;
 
-		pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[entry],
+		pci_dma_sync_single(sp->pdev, sp->rx_ringp[entry],
 			sizeof(struct RxFD), PCI_DMA_FROMDEVICE);
 		status = le32_to_cpu(sp->rx_ringp[entry]->status);
 		pkt_len = le32_to_cpu(sp->rx_ringp[entry]->count) & 0x3fff;
@@ -1814,7 +1814,7 @@
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
 				/* 'skb_put()' points to the start of sk_buff data area. */
-				pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[entry],
+				pci_dma_sync_single(sp->pdev, sp->rx_ringp[entry],
 					sizeof(struct RxFD) + pkt_len, PCI_DMA_FROMDEVICE);
 
 #if 1 || USE_IP_CSUM
@@ -2271,7 +2271,7 @@
 		mc_setup_frm->link =
 			cpu_to_le32(TX_RING_ELEM_DMA(sp, (entry + 1) % TX_RING_SIZE));
 
-		pci_dma_sync_single(sp->pdev, mc_blk->frame_dma,
+		pci_dma_sync_single(sp->pdev, &mc_blk->frame,
 				mc_blk->len, PCI_DMA_TODEVICE);
 
 		wait_for_cmd_done(dev);
===== include/asm-generic/dma-mapping.h 1.4 vs edited =====
--- 1.4/include/asm-generic/dma-mapping.h	Mon Jan 13 15:37:47 2003
+++ edited/include/asm-generic/dma-mapping.h	Mon Mar  3 10:59:57 2003
@@ -103,12 +103,12 @@
 }
 
 static inline void
-dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+dma_sync_single(struct device *dev, void *ptr, size_t size,
 		enum dma_data_direction direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 
-	pci_dma_sync_single(to_pci_dev(dev), dma_handle, size, (int)direction);
+	pci_dma_sync_single(to_pci_dev(dev), ptr, size, (int)direction);
 }
 
 static inline void
@@ -135,12 +135,12 @@
 }
 
 static inline void
-dma_sync_single_range(struct device *dev, dma_addr_t dma_handle,
+dma_sync_single_range(struct device *dev, void *ptr,
 		      unsigned long offset, size_t size,
 		      enum dma_data_direction direction)
 {
 	/* just sync everything, that's all the pci API can do */
-	dma_sync_single(dev, dma_handle, offset+size, direction);
+	dma_sync_single(dev, ptr, offset+size, direction);
 }
 
 static inline void
===== include/asm-i386/dma-mapping.h 1.2 vs edited =====
--- 1.2/include/asm-i386/dma-mapping.h	Mon Jan 13 09:28:47 2003
+++ edited/include/asm-i386/dma-mapping.h	Mon Mar  3 10:57:51 2003
@@ -70,14 +70,14 @@
 }
 
 static inline void
-dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+dma_sync_single(struct device *dev, void *ptr, size_t size,
 		enum dma_data_direction direction)
 {
 	flush_write_buffers();
 }
 
 static inline void
-dma_sync_single_range(struct device *dev, dma_addr_t dma_handle,
+dma_sync_single_range(struct device *dev, void *ptr,
 		      unsigned long offset, size_t size,
 		      enum dma_data_direction direction)
 {
===== include/asm-ppc/pci.h 1.13 vs edited =====
--- 1.13/include/asm-ppc/pci.h	Sun Sep 15 21:52:05 2002
+++ edited/include/asm-ppc/pci.h	Mon Mar  3 11:03:29 2003
@@ -198,12 +198,19 @@
  * device again owns the buffer.
  */
 static inline void pci_dma_sync_single(struct pci_dev *hwdev,
-				       dma_addr_t dma_handle,
+				       void *ptr,
 				       size_t size, int direction)
 {
 	if (direction == PCI_DMA_NONE)
 		BUG();
-	/* nothing to do */
+
+	/*
+	 * In PPC development tree, there is code to do
+	 * cache coherency work here on the appropriate
+	 * processors.  As yet unmerged to Linus' tree.
+	 * We would now pass the void *ptr directly
+	 * to our local consistent_sync() call.
+	 */
 }
 
 /* Make physical memory consistent for a set of streaming
@@ -256,7 +263,7 @@
 }
 
 static __inline__ void
-pci_dac_dma_sync_single(struct pci_dev *pdev, dma64_addr_t dma_addr, size_t len, int direction)
+pci_dac_dma_sync_single(struct pci_dev *pdev, void *ptr, size_t len, int direction)
 {
 	/* Nothing to do. */
 }
