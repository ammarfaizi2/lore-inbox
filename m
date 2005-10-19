Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbVJSBcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbVJSBcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVJSBcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:32:54 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:29459 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751516AbVJSBcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:32:53 -0400
Date: Tue, 18 Oct 2005 21:30:59 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, pp@ee.oulu.fi
Subject: [patch 2.6.14-rc4] b44: alternate allocation option for DMA descriptors
Message-ID: <10182005213059.12243@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a (final?) hack to support the odd DMA allocation requirements
of the b44 hardware.  The b44 hardware has a 30-bit DMA mask.  On x86,
anything less than a 32-bit DMA mask forces allocations into the 16MB
GFP_DMA range.  The memory there is somewhat limited, often resulting
in an inability to initialize the b44 driver.

This hack uses streaming DMA allocation APIs in order to provide an
alternative in case the GFP_DMA allocation fails.  It is somewhat ugly,
but not much worse than the similar existing hacks to support SKB
allocations in the same driver.  FWIW, I have received positive
feedback on this from several Fedora users.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/b44.c |  134 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/net/b44.h |    2 
 2 files changed, 128 insertions(+), 8 deletions(-)

diff --git a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -106,6 +106,29 @@ static int b44_poll(struct net_device *d
 static void b44_poll_controller(struct net_device *dev);
 #endif
 
+static int dma_desc_align_mask;
+static int dma_desc_sync_size;
+
+static inline void b44_sync_dma_desc_for_device(struct pci_dev *pdev,
+                                                dma_addr_t dma_base,
+                                                unsigned long offset,
+                                                enum dma_data_direction dir)
+{
+	dma_sync_single_range_for_device(&pdev->dev, dma_base,
+	                                 offset & dma_desc_align_mask,
+	                                 dma_desc_sync_size, dir);
+}
+
+static inline void b44_sync_dma_desc_for_cpu(struct pci_dev *pdev,
+                                             dma_addr_t dma_base,
+                                             unsigned long offset,
+                                             enum dma_data_direction dir)
+{
+	dma_sync_single_range_for_cpu(&pdev->dev, dma_base,
+	                              offset & dma_desc_align_mask,
+	                              dma_desc_sync_size, dir);
+}
+
 static inline unsigned long br32(const struct b44 *bp, unsigned long reg)
 {
 	return readl(bp->regs + reg);
@@ -668,6 +691,11 @@ static int b44_alloc_rx_skb(struct b44 *
 	dp->ctrl = cpu_to_le32(ctrl);
 	dp->addr = cpu_to_le32((u32) mapping + bp->rx_offset + bp->dma_offset);
 
+	if (bp->flags & B44_FLAG_RX_RING_HACK)
+		b44_sync_dma_desc_for_device(bp->pdev, bp->rx_ring_dma,
+		                             dest_idx * sizeof(dp),
+		                             DMA_BIDIRECTIONAL);
+
 	return RX_PKT_BUF_SZ;
 }
 
@@ -692,6 +720,11 @@ static void b44_recycle_rx(struct b44 *b
 	pci_unmap_addr_set(dest_map, mapping,
 			   pci_unmap_addr(src_map, mapping));
 
+	if (bp->flags & B44_FLAG_RX_RING_HACK)
+		b44_sync_dma_desc_for_cpu(bp->pdev, bp->rx_ring_dma,
+		                          src_idx * sizeof(src_desc),
+		                          DMA_BIDIRECTIONAL);
+
 	ctrl = src_desc->ctrl;
 	if (dest_idx == (B44_RX_RING_SIZE - 1))
 		ctrl |= cpu_to_le32(DESC_CTRL_EOT);
@@ -700,8 +733,14 @@ static void b44_recycle_rx(struct b44 *b
 
 	dest_desc->ctrl = ctrl;
 	dest_desc->addr = src_desc->addr;
+
 	src_map->skb = NULL;
 
+	if (bp->flags & B44_FLAG_RX_RING_HACK)
+		b44_sync_dma_desc_for_device(bp->pdev, bp->rx_ring_dma,
+		                             dest_idx * sizeof(dest_desc),
+		                             DMA_BIDIRECTIONAL);
+
 	pci_dma_sync_single_for_device(bp->pdev, src_desc->addr,
 				       RX_PKT_BUF_SZ,
 				       PCI_DMA_FROMDEVICE);
@@ -959,6 +998,11 @@ static int b44_start_xmit(struct sk_buff
 	bp->tx_ring[entry].ctrl = cpu_to_le32(ctrl);
 	bp->tx_ring[entry].addr = cpu_to_le32((u32) mapping+bp->dma_offset);
 
+	if (bp->flags & B44_FLAG_TX_RING_HACK)
+		b44_sync_dma_desc_for_device(bp->pdev, bp->tx_ring_dma,
+		                             entry * sizeof(bp->tx_ring[0]),
+		                             DMA_TO_DEVICE);
+
 	entry = NEXT_TX(entry);
 
 	bp->tx_prod = entry;
@@ -1064,6 +1108,16 @@ static void b44_init_rings(struct b44 *b
 	memset(bp->rx_ring, 0, B44_RX_RING_BYTES);
 	memset(bp->tx_ring, 0, B44_TX_RING_BYTES);
 
+	if (bp->flags & B44_FLAG_RX_RING_HACK)
+		dma_sync_single_for_device(&bp->pdev->dev, bp->rx_ring_dma,
+		                           DMA_TABLE_BYTES,
+		                           PCI_DMA_BIDIRECTIONAL);
+
+	if (bp->flags & B44_FLAG_TX_RING_HACK)
+		dma_sync_single_for_device(&bp->pdev->dev, bp->tx_ring_dma,
+		                           DMA_TABLE_BYTES,
+		                           PCI_DMA_TODEVICE);
+
 	for (i = 0; i < bp->rx_pending; i++) {
 		if (b44_alloc_rx_skb(bp, -1, i) < 0)
 			break;
@@ -1085,14 +1139,28 @@ static void b44_free_consistent(struct b
 		bp->tx_buffers = NULL;
 	}
 	if (bp->rx_ring) {
-		pci_free_consistent(bp->pdev, DMA_TABLE_BYTES,
-				    bp->rx_ring, bp->rx_ring_dma);
+		if (bp->flags & B44_FLAG_RX_RING_HACK) {
+			dma_unmap_single(&bp->pdev->dev, bp->rx_ring_dma,
+				         DMA_TABLE_BYTES,
+				         DMA_BIDIRECTIONAL);
+			kfree(bp->rx_ring);
+		} else
+			pci_free_consistent(bp->pdev, DMA_TABLE_BYTES,
+					    bp->rx_ring, bp->rx_ring_dma);
 		bp->rx_ring = NULL;
+		bp->flags &= ~B44_FLAG_RX_RING_HACK;
 	}
 	if (bp->tx_ring) {
-		pci_free_consistent(bp->pdev, DMA_TABLE_BYTES,
-				    bp->tx_ring, bp->tx_ring_dma);
+		if (bp->flags & B44_FLAG_TX_RING_HACK) {
+			dma_unmap_single(&bp->pdev->dev, bp->tx_ring_dma,
+				         DMA_TABLE_BYTES,
+				         DMA_TO_DEVICE);
+			kfree(bp->tx_ring);
+		} else
+			pci_free_consistent(bp->pdev, DMA_TABLE_BYTES,
+					    bp->tx_ring, bp->tx_ring_dma);
 		bp->tx_ring = NULL;
+		bp->flags &= ~B44_FLAG_TX_RING_HACK;
 	}
 }
 
@@ -1118,12 +1186,56 @@ static int b44_alloc_consistent(struct b
 
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
+		rx_ring_dma = dma_map_single(&bp->pdev->dev, rx_ring,
+		                             DMA_TABLE_BYTES,
+		                             DMA_BIDIRECTIONAL);
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
+		tx_ring_dma = dma_map_single(&bp->pdev->dev, tx_ring,
+		                             DMA_TABLE_BYTES,
+		                             DMA_TO_DEVICE);
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
 
@@ -1971,6 +2083,12 @@ static struct pci_driver b44_driver = {
 
 static int __init b44_init(void)
 {
+	unsigned int dma_desc_align_size = dma_get_cache_alignment();
+
+	/* Setup paramaters for syncing RX/TX DMA descriptors */
+	dma_desc_align_mask = ~(dma_desc_align_size - 1);
+	dma_desc_sync_size = max(dma_desc_align_size, sizeof(struct dma_desc));
+
 	return pci_module_init(&b44_driver);
 }
 
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
 
