Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUCPSHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUCPSHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:07:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19157 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261161AbUCPSGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:06:47 -0500
Message-ID: <40574227.8020302@pobox.com>
Date: Tue, 16 Mar 2004 13:06:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>, Tim Hockin <thockin@sun.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
       sjhill@realitydiluted.com
Subject: [PATCH] fix natsemi PCI mapping
Content-Type: multipart/mixed;
 boundary="------------030201040708020304090607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030201040708020304090607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Somebody wanna review and/or test?

Changes:
* Define RX_OFFSET constant (value==2) for uses related to SKB 
allocation and skb_reserve() calls

* RX skb's are always allocated maximally-sized, since we don't know the 
size of an RX packet in advance.  This means that we always alloc and 
map RX skbs based on "np->rx_buf_sz + RX_OFFSET".  natsemi got this 
really wrong in refill_rx(), where it mapped skb->len just after 
dev_alloc_skb(), which was very incorrect.

* call skb_reserve() in refill_rx(), our main skb allocation function, 
just after dev_alloc_skb() returns successfully



--------------030201040708020304090607
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/net/natsemi.c 1.58 vs edited =====
--- 1.58/drivers/net/natsemi.c	Sun Mar 14 01:54:58 2004
+++ edited/drivers/net/natsemi.c	Tue Mar 16 13:02:04 2004
@@ -175,6 +175,8 @@
 #define DRV_VERSION	"1.07+LK1.0.17"
 #define DRV_RELDATE	"Sep 27, 2002"
 
+#define RX_OFFSET	2
+
 /* Updated to recommendations in pci-skeleton v2.03. */
 
 /* The user-configurable values.
@@ -1467,13 +1469,16 @@
 		struct sk_buff *skb;
 		int entry = np->dirty_rx % RX_RING_SIZE;
 		if (np->rx_skbuff[entry] == NULL) {
-			skb = dev_alloc_skb(np->rx_buf_sz);
+			unsigned int buflen = np->rx_buf_sz + RX_OFFSET;
+			skb = dev_alloc_skb(buflen);
 			np->rx_skbuff[entry] = skb;
 			if (skb == NULL)
 				break; /* Better luck next round. */
 			skb->dev = dev; /* Mark as being used by this device. */
+			/* 16 byte align the IP header */
+			skb_reserve(skb, RX_OFFSET);
 			np->rx_dma[entry] = pci_map_single(np->pci_dev,
-				skb->data, skb->len, PCI_DMA_FROMDEVICE);
+				skb->tail, buflen, PCI_DMA_FROMDEVICE);
 			np->rx_ring[entry].addr = cpu_to_le32(np->rx_dma[entry]);
 		}
 		np->rx_ring[entry].cmd_status = cpu_to_le32(np->rx_buf_sz);
@@ -1543,6 +1548,7 @@
 static void drain_ring(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
+	unsigned int buflen = np->rx_buf_sz + RX_OFFSET;
 	int i;
 
 	/* Free all the skbuffs in the Rx queue. */
@@ -1551,7 +1557,7 @@
 		np->rx_ring[i].addr = 0xBADF00D0; /* An invalid address. */
 		if (np->rx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev,
-				np->rx_dma[i], np->rx_skbuff[i]->len,
+				np->rx_dma[i], buflen,
 				PCI_DMA_FROMDEVICE);
 			dev_kfree_skb(np->rx_skbuff[i]);
 		}
@@ -1747,6 +1753,7 @@
 	int entry = np->cur_rx % RX_RING_SIZE;
 	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 	s32 desc_status = le32_to_cpu(np->rx_head_desc->cmd_status);
+	unsigned int buflen = np->rx_buf_sz + RX_OFFSET;
 
 	/* If the driver owns the next entry it's a new packet. Send it up. */
 	while (desc_status < 0) { /* e.g. & DescOwn */
@@ -1785,13 +1792,13 @@
 			/* Check if the packet is long enough to accept
 			 * without copying to a minimally-sized skbuff. */
 			if (pkt_len < rx_copybreak
-			    && (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
+			    && (skb = dev_alloc_skb(pkt_len + RX_OFFSET)) != NULL) {
 				skb->dev = dev;
 				/* 16 byte align the IP header */
-				skb_reserve(skb, 2);
+				skb_reserve(skb, RX_OFFSET);
 				pci_dma_sync_single_for_cpu(np->pci_dev,
 					np->rx_dma[entry],
-					np->rx_skbuff[entry]->len,
+					buflen,
 					PCI_DMA_FROMDEVICE);
 #if HAS_IP_COPYSUM
 				eth_copy_and_sum(skb,
@@ -1803,12 +1810,11 @@
 #endif
 				pci_dma_sync_single_for_device(np->pci_dev,
 					np->rx_dma[entry],
-					np->rx_skbuff[entry]->len,
+					buflen,
 					PCI_DMA_FROMDEVICE);
 			} else {
 				pci_unmap_single(np->pci_dev, np->rx_dma[entry],
-					np->rx_skbuff[entry]->len,
-					PCI_DMA_FROMDEVICE);
+					buflen, PCI_DMA_FROMDEVICE);
 				skb_put(skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
 			}

--------------030201040708020304090607--

