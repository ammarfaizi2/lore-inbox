Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266903AbUHDAbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266903AbUHDAbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUHDAbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:31:39 -0400
Received: from ee.oulu.fi ([130.231.61.23]:42403 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S266903AbUHDAbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:31:32 -0400
Date: Wed, 4 Aug 2004 03:31:08 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: jgarzik@pobox.com
Cc: Florian Schirmer <jolt@tuxbox.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [PATCH] b44 1GB DMA workaround (was: b44: add 47xx support)
Message-ID: <20040804003108.GA10445@ee.oulu.fi>
References: <200407232335.37809.jolt@tuxbox.org> <20040726141128.GA5435@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040726141128.GA5435@ee.oulu.fi>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 05:11:28PM +0300, Pekka Pietikainen wrote:
> Looks good (well, won't be able to test that it doesn't break 4401 until
> next week :-) ).
The 47xx patch didn't break anything for 4401 so I'm all for merging.
> As for the 1GB patch going in, I sure hope they would (perhaps in a cleaned
> up state, it might be more pretty if I just unconditionally enabled the
> workaround and had a b44_alloc_skb() that tries a normal dev_alloc_skb and if
> that gives something over 1GB retry with GFP_DMA...
I just did that, apart from possibly reducing the default ring sizes to
reduce GFP_DMA usage from the ~= 1.6MB worst-case it is now, it's just about
as good as it'll ever get. Would be nice to get this merged, it seems to
be hitting quite a few people out there.

Signed-off-by: Pekka Pietikainen <pp@ee.oulu.fi>
--- linux-2.6.7-1.503/drivers/net/b44.h.bb	2004-08-04 00:34:37.850485784 +0300
+++ linux-2.6.7-1.503/drivers/net/b44.h	2004-08-04 00:34:48.711834608 +0300
@@ -493,6 +493,7 @@
 
 	struct ring_info	*rx_buffers;
 	struct ring_info	*tx_buffers;
+	unsigned char		*tx_bufs; 
 
 	u32			dma_offset;
 	u32			flags;
@@ -525,7 +526,7 @@
 	struct pci_dev		*pdev;
 	struct net_device	*dev;
 
-	dma_addr_t		rx_ring_dma, tx_ring_dma;
+	dma_addr_t		rx_ring_dma, tx_ring_dma,tx_bufs_dma;
 
 	u32			rx_pending;
 	u32			tx_pending;
--- linux-2.6.7-1.503/drivers/net/b44.c.bb	2004-08-04 00:34:30.653579880 +0300
+++ linux-2.6.7-1.503/drivers/net/b44.c	2004-08-04 02:54:12.756306576 +0300
@@ -27,8 +27,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.94"
-#define DRV_MODULE_RELDATE	"May 4, 2004"
+#define DRV_MODULE_VERSION	"0.95"
+#define DRV_MODULE_RELDATE	"Aug 3, 2004"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -57,6 +57,7 @@
 #define B44_DEF_TX_RING_PENDING		(B44_TX_RING_SIZE - 1)
 #define B44_TX_RING_BYTES	(sizeof(struct dma_desc) * \
 				 B44_TX_RING_SIZE)
+#define B44_DMA_MASK 0x3fffffff
 
 #define TX_RING_GAP(BP)	\
 	(B44_TX_RING_SIZE - (BP)->tx_pending)
@@ -67,6 +68,7 @@
 #define NEXT_TX(N)		(((N) + 1) & (B44_TX_RING_SIZE - 1))
 
 #define RX_PKT_BUF_SZ		(1536 + bp->rx_offset + 64)
+#define TX_PKT_BUF_SZ		(B44_MAX_MTU + ETH_HLEN + 8)
 
 /* minimum number of free TX descriptors required to wake up TX process */
 #define B44_TX_WAKEUP_THRESH		(B44_TX_RING_SIZE / 4)
@@ -631,10 +633,30 @@
 	if (skb == NULL)
 		return -ENOMEM;
 
-	skb->dev = bp->dev;
 	mapping = pci_map_single(bp->pdev, skb->data,
 				 RX_PKT_BUF_SZ,
 				 PCI_DMA_FROMDEVICE);
+
+	/* Hardware bug work-around, the chip is unable to do PCI DMA
+	   to/from anything above 1GB :-( */
+	if(mapping+RX_PKT_BUF_SZ > B44_DMA_MASK) {
+		/* Sigh... */
+		pci_unmap_single(bp->pdev, mapping, RX_PKT_BUF_SZ,PCI_DMA_FROMDEVICE);
+		dev_kfree_skb_any(skb);
+		skb = __dev_alloc_skb(RX_PKT_BUF_SZ,GFP_DMA);
+		if (skb == NULL)
+			return -ENOMEM;
+		mapping = pci_map_single(bp->pdev, skb->data,
+					 RX_PKT_BUF_SZ,
+					 PCI_DMA_FROMDEVICE);
+		if(mapping+RX_PKT_BUF_SZ > B44_DMA_MASK) {
+			pci_unmap_single(bp->pdev, mapping, RX_PKT_BUF_SZ,PCI_DMA_FROMDEVICE);
+			dev_kfree_skb_any(skb);
+			return -ENOMEM;
+		}
+	}
+
+	skb->dev = bp->dev;
 	skb_reserve(skb, bp->rx_offset);
 
 	rh = (struct rx_header *)
@@ -912,6 +934,13 @@
 
 	entry = bp->tx_prod;
 	mapping = pci_map_single(bp->pdev, skb->data, len, PCI_DMA_TODEVICE);
+	if(mapping+len > B44_DMA_MASK) {
+		/* Chip can't handle DMA to/from >1GB, use bounce buffer */
+		pci_unmap_single(bp->pdev, mapping, len,PCI_DMA_TODEVICE);
+		memcpy(bp->tx_bufs+entry*TX_PKT_BUF_SZ,skb->data,skb->len);
+		skb->data=bp->tx_bufs+entry*TX_PKT_BUF_SZ;
+		mapping = pci_map_single(bp->pdev, skb->data, len, PCI_DMA_TODEVICE);
+	}
 
 	bp->tx_buffers[entry].skb = skb;
 	pci_unmap_addr_set(&bp->tx_buffers[entry], mapping, mapping);
@@ -1059,6 +1088,11 @@
 				    bp->tx_ring, bp->tx_ring_dma);
 		bp->tx_ring = NULL;
 	}
+	if (bp->tx_bufs) {
+		pci_free_consistent(bp->pdev, B44_TX_RING_SIZE * TX_PKT_BUF_SZ,
+				    bp->tx_bufs, bp->tx_bufs_dma);
+		bp->tx_bufs = NULL;
+	}
 }
 
 /*
@@ -1081,6 +1115,12 @@
 		goto out_err;
 	memset(bp->tx_buffers, 0, size);
 
+	size = B44_TX_RING_SIZE * TX_PKT_BUF_SZ;
+	bp->tx_bufs = pci_alloc_consistent(bp->pdev, size, &bp->tx_bufs_dma);
+	if (!bp->tx_bufs)
+		goto out_err;
+	memset(bp->tx_bufs, 0, size);
+
 	size = DMA_TABLE_BYTES;
 	bp->rx_ring = pci_alloc_consistent(bp->pdev, size, &bp->rx_ring_dma);
 	if (!bp->rx_ring)
@@ -1746,12 +1786,19 @@
 
 	pci_set_master(pdev);
 
-	err = pci_set_dma_mask(pdev, (u64) 0xffffffff);
+	err = pci_set_dma_mask(pdev, (u64) B44_DMA_MASK);
 	if (err) {
 		printk(KERN_ERR PFX "No usable DMA configuration, "
 		       "aborting.\n");
 		goto err_out_free_res;
 	}
+	
+	err = pci_set_consistent_dma_mask(pdev, (u64) B44_DMA_MASK);
+	if (err) {
+	  printk(KERN_ERR PFX "No usable DMA configuration, "
+		 "aborting.\n");
+	  goto err_out_free_res;
+	}
 
 	b44reg_base = pci_resource_start(pdev, 0);
 	b44reg_len = pci_resource_len(pdev, 0);
