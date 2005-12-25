Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVLYOmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVLYOmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 09:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVLYOmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 09:42:09 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:17594 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750828AbVLYOmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 09:42:07 -0500
Date: Sun, 25 Dec 2005 15:51:42 +0100
From: Manfred Spraul <manfred@dbl.q-ag.de>
Message-Id: <200512251451.jBPEpgNe018712@dbl.q-ag.de>
To: jgarzik@pobox.com
Subject: [PATCH] forcedeth: TSO fix for large buffers
Cc: aabdulla@nvidia.com, afu@fugmann.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains a bug fix for large buffers. Originally, if a tx 
buffer to be sent was larger then the maximum size of the tx descriptor,

it would overwrite other control bits. In this patch, the buffer is 
split over multiple descriptors. Also, the fragments are now setup in 
forward order.

Signed-off-by: Ayaz Abdulla <aabdulla@nvidia.com>

Rediffed against forcedeth 0.48
Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

--- 2.6/drivers/net/forcedeth.c	2005-12-24 14:22:04.000000000 +0100
+++ x64/drivers/net/forcedeth.c	2005-12-24 14:21:35.000000000 +0100
@@ -101,6 +101,7 @@
  *	0.46: 20 Oct 2005: Add irq optimization modes.
  *	0.47: 26 Oct 2005: Add phyaddr 0 in phy scan.
  *	0.48: 24 Dec 2005: Disable TSO, bugfix for pci_map_single
+ *	0.49: 10 Dec 2005: Fix tso for large buffers.
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -112,7 +113,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.48"
+#define FORCEDETH_VERSION		"0.49"
 #define DRV_NAME			"forcedeth"
 
 #include <linux/module.h>
@@ -349,6 +350,8 @@
 #define NV_TX2_VALID		(1<<31)
 #define NV_TX2_TSO		(1<<28)
 #define NV_TX2_TSO_SHIFT	14
+#define NV_TX2_TSO_MAX_SHIFT	14
+#define NV_TX2_TSO_MAX_SIZE	(1<<NV_TX2_TSO_MAX_SHIFT)
 #define NV_TX2_CHECKSUM_L3	(1<<27)
 #define NV_TX2_CHECKSUM_L4	(1<<26)
 
@@ -408,15 +411,15 @@
 #define NV_WATCHDOG_TIMEO	(5*HZ)
 
 #define RX_RING		128
-#define TX_RING		64
+#define TX_RING		256
 /* 
  * If your nic mysteriously hangs then try to reduce the limits
  * to 1/0: It might be required to set NV_TX_LASTPACKET in the
  * last valid ring entry. But this would be impossible to
  * implement - probably a disassembly error.
  */
-#define TX_LIMIT_STOP	63
-#define TX_LIMIT_START	62
+#define TX_LIMIT_STOP	255
+#define TX_LIMIT_START	254
 
 /* rx/tx mac addr + type + vlan + align + slack*/
 #define NV_RX_HEADERS		(64)
@@ -535,6 +538,7 @@
 	unsigned int next_tx, nic_tx;
 	struct sk_buff *tx_skbuff[TX_RING];
 	dma_addr_t tx_dma[TX_RING];
+	unsigned int tx_dma_len[TX_RING];
 	u32 tx_flags;
 };
 
@@ -935,6 +939,7 @@
 	        else
 			np->tx_ring.ex[i].FlagLen = 0;
 		np->tx_skbuff[i] = NULL;
+		np->tx_dma[i] = 0;
 	}
 }
 
@@ -945,30 +950,27 @@
 	return nv_alloc_rx(dev);
 }
 
-static void nv_release_txskb(struct net_device *dev, unsigned int skbnr)
+static int nv_release_txskb(struct net_device *dev, unsigned int skbnr)
 {
 	struct fe_priv *np = netdev_priv(dev);
-	struct sk_buff *skb = np->tx_skbuff[skbnr];
-	unsigned int j, entry, fragments;
-			
-	dprintk(KERN_INFO "%s: nv_release_txskb for skbnr %d, skb %p\n",
-		dev->name, skbnr, np->tx_skbuff[skbnr]);
-	
-	entry = skbnr;
-	if ((fragments = skb_shinfo(skb)->nr_frags) != 0) {
-		for (j = fragments; j >= 1; j--) {
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[j-1];
-			pci_unmap_page(np->pci_dev, np->tx_dma[entry],
-				       frag->size,
-				       PCI_DMA_TODEVICE);
-			entry = (entry - 1) % TX_RING;
-		}
+		
+	dprintk(KERN_INFO "%s: nv_release_txskb for skbnr %d\n",
+		dev->name, skbnr);
+
+	if (np->tx_dma[skbnr]) {
+		pci_unmap_page(np->pci_dev, np->tx_dma[skbnr],
+			       np->tx_dma_len[skbnr],
+			       PCI_DMA_TODEVICE);
+		np->tx_dma[skbnr] = 0;
+	}
+
+	if (np->tx_skbuff[skbnr]) {
+		dev_kfree_skb_irq(np->tx_skbuff[skbnr]);
+		np->tx_skbuff[skbnr] = NULL;
+		return 1;
+	} else {
+		return 0;
 	}
-	pci_unmap_single(np->pci_dev, np->tx_dma[entry],
-			 skb->len - skb->data_len,
-			 PCI_DMA_TODEVICE);
-	dev_kfree_skb_irq(skb);
-	np->tx_skbuff[skbnr] = NULL;
 }
 
 static void nv_drain_tx(struct net_device *dev)
@@ -981,10 +983,8 @@
 			np->tx_ring.orig[i].FlagLen = 0;
 		else
 			np->tx_ring.ex[i].FlagLen = 0;
-		if (np->tx_skbuff[i]) {
-			nv_release_txskb(dev, i);
+		if (nv_release_txskb(dev, i))
 			np->stats.tx_dropped++;
-		}
 	}
 }
 
@@ -1021,68 +1021,105 @@
 static int nv_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct fe_priv *np = netdev_priv(dev);
+	u32 tx_flags = 0;
 	u32 tx_flags_extra = (np->desc_ver == DESC_VER_1 ? NV_TX_LASTPACKET : NV_TX2_LASTPACKET);
 	unsigned int fragments = skb_shinfo(skb)->nr_frags;
-	unsigned int nr = (np->next_tx + fragments) % TX_RING;
+	unsigned int nr = (np->next_tx - 1) % TX_RING;
+	unsigned int start_nr = np->next_tx % TX_RING;
 	unsigned int i;
+	u32 offset = 0;
+	u32 bcnt;
+	u32 size = skb->len-skb->data_len;
+	u32 entries = (size >> NV_TX2_TSO_MAX_SHIFT) + ((size & (NV_TX2_TSO_MAX_SIZE-1)) ? 1 : 0);
+
+	/* add fragments to entries count */
+	for (i = 0; i < fragments; i++) {
+		entries += (skb_shinfo(skb)->frags[i].size >> NV_TX2_TSO_MAX_SHIFT) + 
+			   ((skb_shinfo(skb)->frags[i].size & (NV_TX2_TSO_MAX_SIZE-1)) ? 1 : 0);
+	}
 
 	spin_lock_irq(&np->lock);
 
-	if ((np->next_tx - np->nic_tx + fragments) > TX_LIMIT_STOP) {
+	if ((np->next_tx - np->nic_tx + entries - 1) > TX_LIMIT_STOP) {
 		spin_unlock_irq(&np->lock);
 		netif_stop_queue(dev);
 		return NETDEV_TX_BUSY;
 	}
 
-	np->tx_skbuff[nr] = skb;
-	
-	if (fragments) {
-		dprintk(KERN_DEBUG "%s: nv_start_xmit: buffer contains %d fragments\n", dev->name, fragments);
-		/* setup descriptors in reverse order */
-		for (i = fragments; i >= 1; i--) {
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[i-1];
-			np->tx_dma[nr] = pci_map_page(np->pci_dev, frag->page, frag->page_offset, frag->size,
-							PCI_DMA_TODEVICE);
+	/* setup the header buffer */
+	do {
+		bcnt = (size > NV_TX2_TSO_MAX_SIZE) ? NV_TX2_TSO_MAX_SIZE : size;
+		nr = (nr + 1) % TX_RING;
+
+		np->tx_dma[nr] = pci_map_single(np->pci_dev, skb->data + offset, bcnt,
+						PCI_DMA_TODEVICE);
+		np->tx_dma_len[nr] = bcnt;
+
+		if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+			np->tx_ring.orig[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
+			np->tx_ring.orig[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
+		} else {
+			np->tx_ring.ex[nr].PacketBufferHigh = cpu_to_le64(np->tx_dma[nr]) >> 32;
+			np->tx_ring.ex[nr].PacketBufferLow = cpu_to_le64(np->tx_dma[nr]) & 0x0FFFFFFFF;
+			np->tx_ring.ex[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
+		}
+		tx_flags = np->tx_flags;
+		offset += bcnt;
+		size -= bcnt;
+	} while(size);
+
+	/* setup the fragments */
+	for (i = 0; i < fragments; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		u32 size = frag->size;
+		offset = 0;
+
+		do {
+			bcnt = (size > NV_TX2_TSO_MAX_SIZE) ? NV_TX2_TSO_MAX_SIZE : size;
+			nr = (nr + 1) % TX_RING;
+
+			np->tx_dma[nr] = pci_map_page(np->pci_dev, frag->page, frag->page_offset+offset, bcnt,
+						      PCI_DMA_TODEVICE);
+			np->tx_dma_len[nr] = bcnt;
 
 			if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
 				np->tx_ring.orig[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
-				np->tx_ring.orig[nr].FlagLen = cpu_to_le32( (frag->size-1) | np->tx_flags | tx_flags_extra);
+				np->tx_ring.orig[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
 			} else {
 				np->tx_ring.ex[nr].PacketBufferHigh = cpu_to_le64(np->tx_dma[nr]) >> 32;
 				np->tx_ring.ex[nr].PacketBufferLow = cpu_to_le64(np->tx_dma[nr]) & 0x0FFFFFFFF;
-				np->tx_ring.ex[nr].FlagLen = cpu_to_le32( (frag->size-1) | np->tx_flags | tx_flags_extra);
+				np->tx_ring.ex[nr].FlagLen = cpu_to_le32((bcnt-1) | tx_flags);
 			}
-			
-			nr = (nr - 1) % TX_RING;
+			offset += bcnt;
+			size -= bcnt;
+		} while (size);
+	}
 
-			if (np->desc_ver == DESC_VER_1)
-				tx_flags_extra &= ~NV_TX_LASTPACKET;
-			else
-				tx_flags_extra &= ~NV_TX2_LASTPACKET;		
-		}
+	/* set last fragment flag  */
+	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
+		np->tx_ring.orig[nr].FlagLen |= cpu_to_le32(tx_flags_extra);
+	} else {
+		np->tx_ring.ex[nr].FlagLen |= cpu_to_le32(tx_flags_extra);
 	}
 
+	np->tx_skbuff[nr] = skb;
+
 #ifdef NETIF_F_TSO
 	if (skb_shinfo(skb)->tso_size)
-		tx_flags_extra |= NV_TX2_TSO | (skb_shinfo(skb)->tso_size << NV_TX2_TSO_SHIFT);
+		tx_flags_extra = NV_TX2_TSO | (skb_shinfo(skb)->tso_size << NV_TX2_TSO_SHIFT);
 	else
 #endif
-	tx_flags_extra |= (skb->ip_summed == CHECKSUM_HW ? (NV_TX2_CHECKSUM_L3|NV_TX2_CHECKSUM_L4) : 0);
+	tx_flags_extra = (skb->ip_summed == CHECKSUM_HW ? (NV_TX2_CHECKSUM_L3|NV_TX2_CHECKSUM_L4) : 0);
 
-	np->tx_dma[nr] = pci_map_single(np->pci_dev, skb->data, skb->len-skb->data_len,
-					PCI_DMA_TODEVICE);
-	
+	/* set tx flags */
 	if (np->desc_ver == DESC_VER_1 || np->desc_ver == DESC_VER_2) {
-		np->tx_ring.orig[nr].PacketBuffer = cpu_to_le32(np->tx_dma[nr]);
-		np->tx_ring.orig[nr].FlagLen = cpu_to_le32( (skb->len-skb->data_len-1) | np->tx_flags | tx_flags_extra);
+		np->tx_ring.orig[start_nr].FlagLen |= cpu_to_le32(tx_flags | tx_flags_extra);
 	} else {
-		np->tx_ring.ex[nr].PacketBufferHigh = cpu_to_le64(np->tx_dma[nr]) >> 32;
-		np->tx_ring.ex[nr].PacketBufferLow = cpu_to_le64(np->tx_dma[nr]) & 0x0FFFFFFFF;
-		np->tx_ring.ex[nr].FlagLen = cpu_to_le32( (skb->len-skb->data_len-1) | np->tx_flags | tx_flags_extra);
+		np->tx_ring.ex[start_nr].FlagLen |= cpu_to_le32(tx_flags | tx_flags_extra);
 	}	
 
-	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet packet %d queued for transmission. tx_flags_extra: %x\n",
-				dev->name, np->next_tx, tx_flags_extra);
+	dprintk(KERN_DEBUG "%s: nv_start_xmit: packet %d (entries %d) queued for transmission. tx_flags_extra: %x\n",
+		dev->name, np->next_tx, entries, tx_flags_extra);
 	{
 		int j;
 		for (j=0; j<64; j++) {
@@ -1093,7 +1130,7 @@
 		dprintk("\n");
 	}
 
-	np->next_tx += 1 + fragments;
+	np->next_tx += entries;
 
 	dev->trans_start = jiffies;
 	spin_unlock_irq(&np->lock);
@@ -1140,7 +1177,6 @@
 					np->stats.tx_packets++;
 					np->stats.tx_bytes += skb->len;
 				}
-				nv_release_txskb(dev, i);
 			}
 		} else {
 			if (Flags & NV_TX2_LASTPACKET) {
@@ -1156,9 +1192,9 @@
 					np->stats.tx_packets++;
 					np->stats.tx_bytes += skb->len;
 				}				
-				nv_release_txskb(dev, i);
 			}
 		}
+		nv_release_txskb(dev, i);
 		np->nic_tx++;
 	}
 	if (np->next_tx - np->nic_tx < TX_LIMIT_START)
@@ -2456,7 +2492,7 @@
 		np->txrxctl_bits |= NVREG_TXRXCTL_RXCHECK;
 		dev->features |= NETIF_F_HW_CSUM | NETIF_F_SG;
 #ifdef NETIF_F_TSO
-		/* disabled dev->features |= NETIF_F_TSO; */
+		dev->features |= NETIF_F_TSO;
 #endif
  	}
 
