Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUFIMcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUFIMcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUFIMbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:31:39 -0400
Received: from ee.oulu.fi ([130.231.61.23]:41627 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263850AbUFIM3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:29:11 -0400
Date: Wed, 9 Jun 2004 15:29:05 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Dealing with buggy hardware (was: b44 and 4g4g)
Message-ID: <20040609122905.GA12715@ee.oulu.fi>
References: <20040531202104.GA8301@ee.oulu.fi> <20040605200643.GA2210@ee.oulu.fi> <20040605131923.232f8950.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040605131923.232f8950.davem@redhat.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2004 at 01:19:23PM -0700, David S. Miller wrote:
> On Sat, 5 Jun 2004 23:06:44 +0300
> Pekka Pietikainen <pp@ee.oulu.fi> wrote:
> 
> > +	if(virt_to_bus(skb->data) + skb->len > B44_PCI_DMA_MAX) {
> 
> You can't use this non-portable interface, you have to:
> 
> 1) pci_map the data
> 2) test the dma_addr_t returned
Ok, fixed. Certainly not ideal, but should fix things for those with
problems (ie. running the 4G4G patch) and work as before for everyone else.

--- linux-2.6.6-1.422/drivers/net/b44.h.4g4g	2004-06-09 15:19:21.315565880 +0300
+++ linux-2.6.6-1.422/drivers/net/b44.h	2004-06-09 15:19:29.787277984 +0300
@@ -503,6 +503,7 @@
 
 	struct ring_info	*rx_buffers;
 	struct ring_info	*tx_buffers;
+	unsigned char		*tx_bufs; 
 
 	u32			dma_offset;
 	u32			flags;
@@ -534,7 +535,7 @@
 	struct pci_dev		*pdev;
 	struct net_device	*dev;
 
-	dma_addr_t		rx_ring_dma, tx_ring_dma;
+	dma_addr_t		rx_ring_dma, tx_ring_dma,tx_bufs_dma;
 
 	u32			rx_pending;
 	u32			tx_pending;
--- linux-2.6.6-1.422/drivers/net/b44.c.4g4g	2004-06-09 15:19:16.334323144 +0300
+++ linux-2.6.6-1.422/drivers/net/b44.c	2004-06-09 15:22:48.754030440 +0300
@@ -67,6 +67,7 @@
 #define NEXT_TX(N)		(((N) + 1) & (B44_TX_RING_SIZE - 1))
 
 #define RX_PKT_BUF_SZ		(1536 + bp->rx_offset + 64)
+#define TX_PKT_BUF_SZ		(B44_MAX_MTU + ETH_HLEN + 8)
 
 /* minimum number of free TX descriptors required to wake up TX process */
 #define B44_TX_WAKEUP_THRESH		(B44_TX_RING_SIZE / 4)
@@ -82,6 +83,12 @@
 
 static int b44_debug = -1;	/* -1 == use B44_DEF_MSG_ENABLE as value */
 
+/* Hardware bug work-around, the chip seems to be unable to do PCI DMA
+   to anything above 1GB :-( */
+
+#define B44_DMA_MASK 0x3fffffff
+static int b44_use_bounce_buffers = 0;
+
 static struct pci_device_id b44_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
@@ -634,7 +641,13 @@
 		src_map = &bp->rx_buffers[src_idx];
 	dest_idx = dest_idx_unmasked & (B44_RX_RING_SIZE - 1);
 	map = &bp->rx_buffers[dest_idx];
-	skb = dev_alloc_skb(RX_PKT_BUF_SZ);
+
+	if(!b44_use_bounce_buffers) {
+		skb = dev_alloc_skb(RX_PKT_BUF_SZ);
+	} else {
+		/* Sigh... */
+		skb = __dev_alloc_skb(RX_PKT_BUF_SZ,GFP_DMA);
+	}
 	if (skb == NULL)
 		return -ENOMEM;
 
@@ -919,7 +932,12 @@
 
 	entry = bp->tx_prod;
 	mapping = pci_map_single(bp->pdev, skb->data, len, PCI_DMA_TODEVICE);
-
+	if(b44_use_bounce_buffers && mapping+len > B44_DMA_MASK) {
+		pci_unmap_single(bp->pdev, mapping, len,PCI_DMA_TODEVICE);
+		memcpy(bp->tx_bufs+entry*TX_PKT_BUF_SZ,skb->data,skb->len);
+		skb->data=bp->tx_bufs+entry*TX_PKT_BUF_SZ;
+		mapping = pci_map_single(bp->pdev, skb->data, len, PCI_DMA_TODEVICE);
+	}
 	bp->tx_buffers[entry].skb = skb;
 	pci_unmap_addr_set(&bp->tx_buffers[entry], mapping, mapping);
 
@@ -1066,6 +1084,11 @@
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
@@ -1088,6 +1111,13 @@
 		goto out_err;
 	memset(bp->tx_buffers, 0, size);
 
+	if(b44_use_bounce_buffers) {
+		size = B44_TX_RING_SIZE * TX_PKT_BUF_SZ;
+		bp->tx_bufs = pci_alloc_consistent(bp->pdev, size, &bp->tx_bufs_dma);
+		if (!bp->tx_bufs)
+			goto out_err;
+		memset(bp->tx_bufs, 0, size);
+	}
 	size = DMA_TABLE_BYTES;
 	bp->rx_ring = pci_alloc_consistent(bp->pdev, size, &bp->rx_ring_dma);
 	if (!bp->rx_ring)
@@ -1727,12 +1757,26 @@
 
 	pci_set_master(pdev);
 
-	err = pci_set_dma_mask(pdev, (u64) 0xffffffff);
+#ifdef CONFIG_X86_4G
+	/* XXX Only needs to be set if > 1GB of physical memory, so
+           this check could be smarted */
+	b44_use_bounce_buffers=1;
+#endif
+	err = pci_set_dma_mask(pdev, (u64) B44_DMA_MASK);
 	if (err) {
 		printk(KERN_ERR PFX "No usable DMA configuration, "
 		       "aborting.\n");
 		goto err_out_free_res;
 	}
+	
+	if(b44_use_bounce_buffers) {
+		err = pci_set_consistent_dma_mask(pdev, (u64) B44_DMA_MASK);
+		if (err) {
+			printk(KERN_ERR PFX "No usable DMA configuration, "
+			       "aborting.\n");
+			goto err_out_free_res;
+		}
+	}
 
 	b44reg_base = pci_resource_start(pdev, 0);
 	b44reg_len = pci_resource_len(pdev, 0);

-- 
Pekka Pietikainen
