Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUCPTTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUCPTTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:19:21 -0500
Received: from mail.timesys.com ([65.117.135.102]:38155 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261421AbUCPTPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:15:43 -0500
Message-ID: <4057525E.6020205@timesys.com>
Date: Tue, 16 Mar 2004 14:15:42 -0500
From: "Steven J. Hill" <Steve.Hill@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Netdev <netdev@oss.sgi.com>, Tim Hockin <thockin@sun.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, ralf@linux-mips.org
Subject: Re: [PATCH] fix natsemi PCI mapping
References: <40574227.8020302@pobox.com>
In-Reply-To: <40574227.8020302@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------060301070001030109080002"
X-OriginalArrivalTime: 16 Mar 2004 19:07:27.0890 (UTC) FILETIME=[EC778F20:01C40B89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060301070001030109080002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> 
> Somebody wanna review and/or test?
>
Hey Jeff.

I have tested this on 2.4 and it works great on MIPS with one
minor change below. Remove the 16 byte alignment of the IP
header. I discovered this when trying to do a BOOTP and mount
my NFS root filesystem. The BOOTP never succeeds. Patch against
latest 2.4.25 attached.

-Steve

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

--------------060301070001030109080002
Content-Type: text/x-patch;
 name="natsemi-pci-mapping.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="natsemi-pci-mapping.patch"

diff -urN -X /home/sjhill/diff-exc linux-2.4.25/drivers/net/natsemi.c linux-2.4.25-patched/drivers/net/natsemi.c
--- linux-2.4.25/drivers/net/natsemi.c	Tue Mar 16 14:05:21 2004
+++ linux-2.4.25-patched/drivers/net/natsemi.c	Tue Mar 16 13:58:15 2004
@@ -175,6 +175,8 @@
 #define DRV_VERSION	"1.07+LK1.0.17"
 #define DRV_RELDATE	"Sep 27, 2002"
 
+#define RX_OFFSET	2
+
 /* Updated to recommendations in pci-skeleton v2.03. */
 
 /* The user-configurable values.
@@ -1466,13 +1467,14 @@
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
 			np->rx_dma[entry] = pci_map_single(np->pci_dev,
-				skb->data, skb->len, PCI_DMA_FROMDEVICE);
+				skb->tail, buflen, PCI_DMA_FROMDEVICE);
 			np->rx_ring[entry].addr = cpu_to_le32(np->rx_dma[entry]);
 		}
 		np->rx_ring[entry].cmd_status = cpu_to_le32(np->rx_buf_sz);
@@ -1542,6 +1544,7 @@
 static void drain_ring(struct net_device *dev)
 {
 	struct netdev_private *np = dev->priv;
+	unsigned int buflen = np->rx_buf_sz + RX_OFFSET;
 	int i;
 
 	/* Free all the skbuffs in the Rx queue. */
@@ -1550,7 +1553,7 @@
 		np->rx_ring[i].addr = 0xBADF00D0; /* An invalid address. */
 		if (np->rx_skbuff[i]) {
 			pci_unmap_single(np->pci_dev,
-				np->rx_dma[i], np->rx_skbuff[i]->len,
+				np->rx_dma[i], buflen,
 				PCI_DMA_FROMDEVICE);
 			dev_kfree_skb(np->rx_skbuff[i]);
 		}
@@ -1746,6 +1745,7 @@
 	int entry = np->cur_rx % RX_RING_SIZE;
 	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 	s32 desc_status = le32_to_cpu(np->rx_head_desc->cmd_status);
+	unsigned int buflen = np->rx_buf_sz + RX_OFFSET;
 
 	/* If the driver owns the next entry it's a new packet. Send it up. */
 	while (desc_status < 0) { /* e.g. & DescOwn */
@@ -1784,13 +1784,13 @@
 			/* Check if the packet is long enough to accept
 			 * without copying to a minimally-sized skbuff. */
 			if (pkt_len < rx_copybreak
-			    && (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
+			    && (skb = dev_alloc_skb(pkt_len + RX_OFFSET)) != NULL) {
 				skb->dev = dev;
 				/* 16 byte align the IP header */
-				skb_reserve(skb, 2);
+				skb_reserve(skb, RX_OFFSET);
 				pci_dma_sync_single(np->pci_dev,
 					np->rx_dma[entry],
-					np->rx_skbuff[entry]->len,
+					buflen,
 					PCI_DMA_FROMDEVICE);
 #if HAS_IP_COPYSUM
 				eth_copy_and_sum(skb,
@@ -1802,8 +1802,7 @@
 #endif
 			} else {
 				pci_unmap_single(np->pci_dev, np->rx_dma[entry],
-					np->rx_skbuff[entry]->len,
-					PCI_DMA_FROMDEVICE);
+					buflen, PCI_DMA_FROMDEVICE);
 				skb_put(skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
 			}

--------------060301070001030109080002--
