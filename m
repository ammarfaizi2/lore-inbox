Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUH3GKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUH3GKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 02:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUH3GKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 02:10:41 -0400
Received: from ee.oulu.fi ([130.231.61.23]:5251 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S267338AbUH3GKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 02:10:33 -0400
Date: Mon, 30 Aug 2004 09:10:20 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Florian Schirmer <jolt@tuxbox.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH][1/4] b44: Ignore carrier lost errors
Message-ID: <20040830061020.GA21270@ee.oulu.fi>
References: <200408292218.00756.jolt@tuxbox.org> <200408292233.03879.jolt@tuxbox.org> <41324158.4020709@pobox.com> <200408292304.25447.jolt@tuxbox.org> <20040829164528.220424e5.davem@davemloft.net> <20040829234928.GA10060@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040829234928.GA10060@havoc.gtf.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 07:49:28PM -0400, Jeff Garzik wrote:
> > BTW, can someone fixup something for me?  Update MODULE_AUTHOR()
> > please :-)  3/4 of this driver have been rewritten since I last
> > touched it, heh.
> 
> hehe.  I'll take care of it tonight when I queue Florian's stuff
> to netdev-2.6 (and thus -mm, and thus eventually mainline).
And here's a resend of the bounce buffer patch, which should still
apply on top of Florians (or without) just fine.

Signed-off-by: Pekka Pietikainen <pp@ee.oulu.fi>
--- linux-2.6.8-rc3/drivers/net/b44.h.4g4g	2004-08-08 10:54:03.979353080 +0300
+++ linux-2.6.8-rc3/drivers/net/b44.h	2004-08-08 10:54:17.928232528 +0300
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
--- linux-2.6.8-rc3/drivers/net/b44.c.4g4g	2004-08-08 10:53:58.724151992 +0300
+++ linux-2.6.8-rc3/drivers/net/b44.c	2004-08-08 10:54:17.657273720 +0300
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
@@ -912,6 +934,12 @@
 
 	entry = bp->tx_prod;
 	mapping = pci_map_single(bp->pdev, skb->data, len, PCI_DMA_TODEVICE);
+	if(mapping+len > B44_DMA_MASK) {
+		/* Chip can't handle DMA to/from >1GB, use bounce buffer */
+		pci_unmap_single(bp->pdev, mapping, len,PCI_DMA_TODEVICE);
+		memcpy(bp->tx_bufs+entry*TX_PKT_BUF_SZ,skb->data,skb->len);
+		mapping = pci_map_single(bp->pdev, bp->tx_bufs+entry*TX_PKT_BUF_SZ, len, PCI_DMA_TODEVICE);
+	}
 
 	bp->tx_buffers[entry].skb = skb;
 	pci_unmap_addr_set(&bp->tx_buffers[entry], mapping, mapping);
@@ -1059,6 +1087,11 @@
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
@@ -1081,6 +1114,12 @@
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
@@ -1746,12 +1785,19 @@
 
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
