Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262323AbSI3QR3>; Mon, 30 Sep 2002 12:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262329AbSI3QR3>; Mon, 30 Sep 2002 12:17:29 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:64424 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262323AbSI3QR0>; Mon, 30 Sep 2002 12:17:26 -0400
Date: Mon, 30 Sep 2002 11:20:26 -0500 (CDT)
From: Kent Yoder <key@austin.ibm.com>
To: jgarzik@mandrakesoft.com
cc: linux-kernel@vger.kernel.org, <linux-tr@linuxtr.net>
Subject: [PATCH] lanstreamer PCI update
Message-ID: <Pine.LNX.4.44.0209301101150.13670-100000@ennui.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

Name: Lanstreamer token-ring driver update
Author: Kent Yoder
Status: Tested on 2.4.20-pre7 and 2.5.7

D: Patch gets rid of virt_to_bus calls using the newer pci_map/unmap calls,
D: as well as fixing 1 bug in the init code.

Please apply to 2.4 and 2.5,

Thanks,
Kent

--- linux-2.5.7/drivers/net/tokenring/lanstreamer.c	Mon Mar 18 14:37:14 2002
+++ linux-2.5.7.fantasgreat/drivers/net/tokenring/lanstreamer.c	Fri Sep 27 11:15:39 2002
@@ -65,6 +65,7 @@
  *  11/05/01 - Restructured the interrupt function, added delays, reduced the 
  *             the number of TX descriptors to 1, which together can prevent 
  *             the card from locking up the box - <yoder1@us.ibm.com>
+ *  09/27/02 - New PCI interface + bug fix. - <yoder1@us.ibm.com>
  *  
  *  To Do:
  *
@@ -136,7 +137,7 @@
  */
 
 static char version[] = "LanStreamer.c v0.4.0 03/08/01 - Mike Sullivan\n"
-                        "              v0.5.1 03/04/02 - Kent Yoder";
+                        "              v0.5.2 09/30/02 - Kent Yoder";
 
 static struct pci_device_id streamer_pci_tbl[] __initdata = {
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_TR, PCI_ANY_ID, PCI_ANY_ID,},
@@ -250,6 +251,12 @@
   dev_streamer=streamer_priv;
 #endif
 #endif
+ 
+  if(pci_set_dma_mask(pdev, 0xFFFFFFFF)) {
+    printk(KERN_ERR "%s: No suitable PCI mapping available.\n", dev->name);
+    rc = -ENODEV;
+    goto err_out;
+  }
   
   if (pci_enable_device(pdev)) {
     printk(KERN_ERR "lanstreamer: unable to enable pci device\n");
@@ -481,9 +488,11 @@
 		data=((u8 *)skb->data)+sizeof(struct streamer_rx_desc);
 		rx_ring->forward=0;
 		rx_ring->status=0;
-		rx_ring->buffer=virt_to_bus(data);
+		rx_ring->buffer=cpu_to_le32(pci_map_single(streamer_priv->pci_dev, data, 
+							512, PCI_DMA_FROMDEVICE));
 		rx_ring->framelen_buflen=512; 
-		writel(virt_to_bus(rx_ring),streamer_mmio+RXBDA);
+		writel(cpu_to_le32(pci_map_single(streamer_priv->pci_dev, rx_ring, 512, PCI_DMA_FROMDEVICE)),
+			streamer_mmio+RXBDA);
 	}
 
 #if STREAMER_DEBUG
@@ -499,6 +508,8 @@
 			printk(KERN_ERR
 			       "IBM PCI tokenring card not responding\n");
 			release_region(dev->base_addr, STREAMER_IO_SPACE);
+			if (skb)
+				dev_kfree_skb(skb);
 			return -1;
 		}
 	}
@@ -773,14 +784,19 @@
 
 		skb->dev = dev;
 
-		streamer_priv->streamer_rx_ring[i].forward = virt_to_bus(&streamer_priv->streamer_rx_ring[i + 1]);
+		streamer_priv->streamer_rx_ring[i].forward = 
+			cpu_to_le32(pci_map_single(streamer_priv->pci_dev, &streamer_priv->streamer_rx_ring[i + 1],
+					sizeof(struct streamer_rx_desc), PCI_DMA_FROMDEVICE));
 		streamer_priv->streamer_rx_ring[i].status = 0;
-		streamer_priv->streamer_rx_ring[i].buffer = virt_to_bus(skb->data);
+		streamer_priv->streamer_rx_ring[i].buffer = 
+			cpu_to_le32(pci_map_single(streamer_priv->pci_dev, skb->data,
+					      streamer_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE));
 		streamer_priv->streamer_rx_ring[i].framelen_buflen = streamer_priv->pkt_buf_sz;
 		streamer_priv->rx_ring_skb[i] = skb;
 	}
 	streamer_priv->streamer_rx_ring[STREAMER_RX_RING_SIZE - 1].forward =
-				virt_to_bus(&streamer_priv->streamer_rx_ring[0]);
+				cpu_to_le32(pci_map_single(streamer_priv->pci_dev, &streamer_priv->streamer_rx_ring[0],
+						sizeof(struct streamer_rx_desc), PCI_DMA_FROMDEVICE));
 
 	if (i == 0) {
 		printk(KERN_WARNING "%s: Not enough memory to allocate rx buffers. Adapter disabled\n", dev->name);
@@ -790,8 +806,12 @@
 
 	streamer_priv->rx_ring_last_received = STREAMER_RX_RING_SIZE - 1;	/* last processed rx status */
 
-	writel(virt_to_bus(&streamer_priv->streamer_rx_ring[0]), streamer_mmio + RXBDA);
-	writel(virt_to_bus(&streamer_priv->streamer_rx_ring[STREAMER_RX_RING_SIZE - 1]), streamer_mmio + RXLBDA);
+	writel(cpu_to_le32(pci_map_single(streamer_priv->pci_dev, &streamer_priv->streamer_rx_ring[0],
+				sizeof(struct streamer_rx_desc), PCI_DMA_TODEVICE)), 
+		streamer_mmio + RXBDA);
+	writel(cpu_to_le32(pci_map_single(streamer_priv->pci_dev, &streamer_priv->streamer_rx_ring[STREAMER_RX_RING_SIZE - 1],
+				sizeof(struct streamer_rx_desc), PCI_DMA_TODEVICE)), 
+		streamer_mmio + RXLBDA);
 
 	/* set bus master interrupt event mask */
 	writew(MISR_RX_NOBUF | MISR_RX_EOF, streamer_mmio + MISR_MASK);
@@ -807,7 +827,10 @@
 
 	writew(~BMCTL_TX2_DIS, streamer_mmio + BMCTL_RUM);	/* Enables TX channel 2 */
 	for (i = 0; i < STREAMER_TX_RING_SIZE; i++) {
-		streamer_priv->streamer_tx_ring[i].forward = virt_to_bus(&streamer_priv->streamer_tx_ring[i + 1]);
+		streamer_priv->streamer_tx_ring[i].forward = cpu_to_le32(pci_map_single(streamer_priv->pci_dev, 
+										&streamer_priv->streamer_tx_ring[i + 1],
+										sizeof(struct streamer_tx_desc),
+										PCI_DMA_TODEVICE));
 		streamer_priv->streamer_tx_ring[i].status = 0;
 		streamer_priv->streamer_tx_ring[i].bufcnt_framelen = 0;
 		streamer_priv->streamer_tx_ring[i].buffer = 0;
@@ -817,7 +840,8 @@
 		streamer_priv->streamer_tx_ring[i].rsvd3 = 0;
 	}
 	streamer_priv->streamer_tx_ring[STREAMER_TX_RING_SIZE - 1].forward =
-					virt_to_bus(&streamer_priv->streamer_tx_ring[0]);
+					cpu_to_le32(pci_map_single(streamer_priv->pci_dev, &streamer_priv->streamer_tx_ring[0],
+							sizeof(struct streamer_tx_desc), PCI_DMA_TODEVICE));
 
 	streamer_priv->free_tx_ring_entries = STREAMER_TX_RING_SIZE;
 	streamer_priv->tx_ring_free = 0;	/* next entry in tx ring to use */
@@ -915,6 +939,11 @@
 				skb->dev = dev;
 
 				if (buffer_cnt == 1) {
+					/* release the DMA mapping */
+					pci_unmap_single(streamer_priv->pci_dev, 
+						le32_to_cpu(streamer_priv->streamer_rx_ring[rx_ring_last_received].buffer),
+						streamer_priv->pkt_buf_sz, 
+						PCI_DMA_FROMDEVICE);
 					skb2 = streamer_priv->rx_ring_skb[rx_ring_last_received];
 #if STREAMER_DEBUG_PACKETS
 					{
@@ -934,20 +963,29 @@
 					/* recycle this descriptor */
 					streamer_priv->streamer_rx_ring[rx_ring_last_received].status = 0;
 					streamer_priv->streamer_rx_ring[rx_ring_last_received].framelen_buflen = streamer_priv->pkt_buf_sz;
-					streamer_priv->streamer_rx_ring[rx_ring_last_received].buffer = virt_to_bus(skb->data);
-					streamer_priv-> rx_ring_skb[rx_ring_last_received] = skb;
+					streamer_priv->streamer_rx_ring[rx_ring_last_received].buffer = 
+						cpu_to_le32(pci_map_single(streamer_priv->pci_dev, skb->data, streamer_priv->pkt_buf_sz,
+								PCI_DMA_FROMDEVICE));
+					streamer_priv->rx_ring_skb[rx_ring_last_received] = skb;
 					/* place recycled descriptor back on the adapter */
-					writel(virt_to_bus(&streamer_priv->streamer_rx_ring[rx_ring_last_received]),streamer_mmio + RXLBDA);
+					writel(cpu_to_le32(pci_map_single(streamer_priv->pci_dev, 
+									&streamer_priv->streamer_rx_ring[rx_ring_last_received],
+									sizeof(struct streamer_rx_desc), PCI_DMA_FROMDEVICE)),
+						streamer_mmio + RXLBDA);
 					/* pass the received skb up to the protocol */
 					netif_rx(skb2);
 				} else {
 					do {	/* Walk the buffers */
-						memcpy(skb_put(skb, length),bus_to_virt(rx_desc->buffer), length);	/* copy this fragment */
+						pci_unmap_single(streamer_priv->pci_dev, le32_to_cpu(rx_desc->buffer), length, PCI_DMA_FROMDEVICE), 
+						memcpy(skb_put(skb, length), (void *)rx_desc->buffer, length);	/* copy this fragment */
 						streamer_priv->streamer_rx_ring[rx_ring_last_received].status = 0;
 						streamer_priv->streamer_rx_ring[rx_ring_last_received].framelen_buflen = streamer_priv->pkt_buf_sz;
 						
 						/* give descriptor back to the adapter */
-						writel(virt_to_bus(&streamer_priv->streamer_rx_ring[rx_ring_last_received]), streamer_mmio + RXLBDA);
+						writel(cpu_to_le32(pci_map_single(streamer_priv->pci_dev, 
+									&streamer_priv->streamer_rx_ring[rx_ring_last_received],
+									length, PCI_DMA_FROMDEVICE)), 
+							streamer_mmio + RXLBDA);
 
 						if (rx_desc->status & 0x80000000)
 							break;	/* this descriptor completes the frame */
@@ -1114,7 +1152,8 @@
 	if (streamer_priv->free_tx_ring_entries) {
 		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].status = 0;
 		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].bufcnt_framelen = 0x00020000 | skb->len;
-		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].buffer = virt_to_bus(skb->data);
+		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].buffer = 
+			cpu_to_le32(pci_map_single(streamer_priv->pci_dev, skb->data, skb->len, PCI_DMA_TODEVICE));
 		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].rsvd1 = skb->len;
 		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].rsvd2 = 0;
 		streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free].rsvd3 = 0;
@@ -1135,7 +1174,10 @@
 		}
 #endif
 
-		writel(virt_to_bus (&streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free]),streamer_mmio + TX2LFDA);
+		writel(cpu_to_le32(pci_map_single(streamer_priv->pci_dev, 
+					&streamer_priv->streamer_tx_ring[streamer_priv->tx_ring_free],
+					sizeof(struct streamer_tx_desc), PCI_DMA_TODEVICE)),
+			streamer_mmio + TX2LFDA);
 		(void)readl(streamer_mmio + TX2LFDA);
 
 		streamer_priv->tx_ring_free = (streamer_priv->tx_ring_free + 1) & (STREAMER_TX_RING_SIZE - 1);

