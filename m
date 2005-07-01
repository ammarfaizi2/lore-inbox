Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVGAUTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVGAUTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVGAUTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:19:20 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:48142 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261237AbVGAUSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:18:49 -0400
Date: Fri, 1 Jul 2005 16:18:42 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@vger.kernel.org
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch 2.6.13-rc1] b44: attempt alternative rx/tx desc alloc if normal alloc fails
Message-ID: <20050701201839.GB12653@tuxdriver.com>
Mail-Followup-To: netdev@vger.kernel.org, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The b44 hardware can only handle DMA to physical addresses below 1GB.
In response to this fact, the x86 implementation of pci_alloc_consistent
allocates memory w/ the GFP_DMA flag set.  On the x86, this forces
allocations to come from the lowest 16MB of physical memory.

Since the low 16MB memory pool is easily exhausted, some users will
experience failures when attempting to open the b44 driver.  Since
any memory below 1GB is actually usable, this patch makes a second
allocation attempt and manually checks the results for acceptability.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
OK, so this seems a bit yucky...but it is not really any worse than
some existing hacks in the b44 driver to deal w/ essentially the same
issue.  Look for other references to B44_DMA_MASK to see for yourself.

 drivers/net/b44.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++------
 drivers/net/b44.h |    2 +
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -1085,13 +1085,25 @@ static void b44_free_consistent(struct b
 		bp->tx_buffers = NULL;
 	}
 	if (bp->rx_ring) {
-		pci_free_consistent(bp->pdev, DMA_TABLE_BYTES,
-				    bp->rx_ring, bp->rx_ring_dma);
+		if (bp->flags & B44_FLAG_RX_RING_HACK) {
+			pci_unmap_single(bp->pdev, (dma_addr_t)bp->rx_ring,
+				         DMA_TABLE_BYTES,
+				         PCI_DMA_FROMDEVICE);
+			kfree(bp->rx_ring);
+		} else
+			pci_free_consistent(bp->pdev, DMA_TABLE_BYTES,
+					    bp->rx_ring, bp->rx_ring_dma);
 		bp->rx_ring = NULL;
 	}
 	if (bp->tx_ring) {
-		pci_free_consistent(bp->pdev, DMA_TABLE_BYTES,
-				    bp->tx_ring, bp->tx_ring_dma);
+		if (bp->flags & B44_FLAG_TX_RING_HACK) {
+			pci_unmap_single(bp->pdev, (dma_addr_t)bp->tx_ring,
+				         DMA_TABLE_BYTES,
+				         PCI_DMA_TODEVICE);
+			kfree(bp->tx_ring);
+		} else
+			pci_free_consistent(bp->pdev, DMA_TABLE_BYTES,
+					    bp->tx_ring, bp->tx_ring_dma);
 		bp->tx_ring = NULL;
 	}
 }
@@ -1118,12 +1130,56 @@ static int b44_alloc_consistent(struct b
 
 	size = DMA_TABLE_BYTES;
 	bp->rx_ring = pci_alloc_consistent(bp->pdev, size, &bp->rx_ring_dma);
-	if (!bp->rx_ring)
-		goto out_err;
+	if (!bp->rx_ring) {
+		/* Allocation may have failed due to pci_alloc_consistent
+		   insisting on use of GFP_DMA, which is more restrictive
+		   than necessary...  */
+		struct dma_desc *rx_ring;
+		dma_addr_t rx_ring_dma;
+
+		if (!(rx_ring = (struct dma_desc *)kmalloc(size, GFP_KERNEL)))
+			goto out_err;
+
+		memset(rx_ring, 0, size);
+		rx_ring_dma = pci_map_single(bp->pdev, rx_ring,
+				 DMA_TABLE_BYTES,
+				 PCI_DMA_FROMDEVICE);
+
+		if (rx_ring_dma + size > B44_DMA_MASK) {
+			kfree(rx_ring);
+			goto out_err;
+		}
+
+		bp->rx_ring = rx_ring;
+		bp->rx_ring_dma = rx_ring_dma;
+		bp->flags |= B44_FLAG_RX_RING_HACK;
+	}
 
 	bp->tx_ring = pci_alloc_consistent(bp->pdev, size, &bp->tx_ring_dma);
-	if (!bp->tx_ring)
-		goto out_err;
+	if (!bp->tx_ring) {
+		/* Allocation may have failed due to pci_alloc_consistent
+		   insisting on use of GFP_DMA, which is more restrictive
+		   than necessary...  */
+		struct dma_desc *tx_ring;
+		dma_addr_t tx_ring_dma;
+
+		if (!(tx_ring = (struct dma_desc *)kmalloc(size, GFP_KERNEL)))
+			goto out_err;
+
+		memset(tx_ring, 0, size);
+		tx_ring_dma = pci_map_single(bp->pdev, tx_ring,
+				 DMA_TABLE_BYTES,
+				 PCI_DMA_TODEVICE);
+
+		if (tx_ring_dma + size > B44_DMA_MASK) {
+			kfree(tx_ring);
+			goto out_err;
+		}
+
+		bp->tx_ring = tx_ring;
+		bp->tx_ring_dma = tx_ring_dma;
+		bp->flags |= B44_FLAG_TX_RING_HACK;
+	}
 
 	return 0;
 
diff --git a/drivers/net/b44.h b/drivers/net/b44.h
--- a/drivers/net/b44.h
+++ b/drivers/net/b44.h
@@ -400,6 +400,8 @@ struct b44 {
 #define B44_FLAG_ADV_100HALF	0x04000000
 #define B44_FLAG_ADV_100FULL	0x08000000
 #define B44_FLAG_INTERNAL_PHY	0x10000000
+#define B44_FLAG_RX_RING_HACK	0x20000000
+#define B44_FLAG_TX_RING_HACK	0x40000000
 
 	u32			rx_offset;
 
-- 
John W. Linville
linville@tuxdriver.com
