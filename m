Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTKEHqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 02:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTKEHqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 02:46:52 -0500
Received: from mail.oktet.ru ([193.125.193.3]:38410 "EHLO mail.oktet.ru")
	by vger.kernel.org with ESMTP id S262652AbTKEHqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 02:46:44 -0500
Date: Wed, 5 Nov 2003 10:46:26 +0300
From: "Alexandra N. Kossovsky" <sasha@oktet.ru>
To: linux-kernel@vger.kernel.org
Cc: ShuChen <shuchen@realtek.com.tw>
Subject: r8169 with big-endian (patch)
Message-ID: <20031105104625.D26209@oktet.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

Here is the patch to make RTL-8169 PCI Gbit ethernet card to work with
big-endian host. The patch is against 2.4.22 kernel.

It was tested with i386 and mips64-be.

I've added KERNEL_LICENSE("GPL") because I'd like to have my work under
this license. If Realtek does not want it, it is necessary to discuss this
problem.

Please, CC to me -- I'm not subscribed.

Regards,
    Alexandra.

-- 
Alexandra N. Kossovsky
OKTET Ltd.
http://www.oktet.ru/
1 Ulianovskaya st., Petergof, St.Petersburg, 198904 Russia
Phones: +7(812)428-43-84(work) +7(812)184-52-58(home) +7(812)956-42-86(mobile)
mailto:sasha@oktet.ru


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r8169.diff"

--- drivers/net/r8169.c.orig	Tue Nov  4 17:04:10 2003
+++ drivers/net/r8169.c	Wed Nov  5 10:32:21 2003
@@ -33,6 +33,11 @@
 	- Copy mc_filter setup code from 8139cp
 	  (includes an optimization, and avoids set_bit use)
 
+VERSION 1.3	2003/11/04
+	(C) OKTET Ltd. (www.oktet.ru)
+	Author Alexandra N. Kossovsky <Alexandra.Kossovsky@oktet.ru>
+	- Replace bus_to_virt/virt_to_bus by pci_alloc_consistent.
+	- Insert cpu_to_le/le_to_cpu where it is necessary. 
 */
 
 #include <linux/module.h>
@@ -45,7 +50,7 @@
 
 #include <asm/io.h>
 
-#define RTL8169_VERSION "1.2"
+#define RTL8169_VERSION "1.3"
 #define MODULENAME "r8169"
 #define RTL8169_DRIVER_NAME   MODULENAME " Gigabit Ethernet driver " RTL8169_VERSION
 #define PFX MODULENAME ": "
@@ -165,12 +170,6 @@
 	RxErr = 0x02,
 	RxOK = 0x01,
 
-	/*RxStatusDesc */
-	RxRES = 0x00200000,
-	RxCRC = 0x00080000,
-	RxRUNT = 0x00100000,
-	RxRWT = 0x00400000,
-
 	/*ChipCmdBits */
 	CmdReset = 0x10,
 	CmdRxEnb = 0x08,
@@ -251,10 +250,16 @@
 "RTL-8169", 0x00, 0xff7e1880,},};
 
 enum _DescStatusBit {
-	OWNbit = 0x80000000,
-	EORbit = 0x40000000,
-	FSbit = 0x20000000,
-	LSbit = 0x10000000,
+	OWNbit = __constant_cpu_to_le32(0x80000000),
+	EORbit = __constant_cpu_to_le32(0x40000000),
+	FSbit = __constant_cpu_to_le32(0x20000000),
+	LSbit = __constant_cpu_to_le32(0x10000000),
+
+	/*RxStatusDesc */
+	RxRES = __constant_cpu_to_le32(0x00200000),
+	RxCRC = __constant_cpu_to_le32(0x00080000),
+	RxRUNT = __constant_cpu_to_le32(0x00100000),
+	RxRWT = __constant_cpu_to_le32(0x00400000),
 };
 
 struct TxDesc {
@@ -284,13 +289,20 @@
 	unsigned char *RxDescArrays;	/* Index of Rx Descriptor buffer */
 	struct TxDesc *TxDescArray;	/* Index of 256-alignment Tx Descriptor buffer */
 	struct RxDesc *RxDescArray;	/* Index of 256-alignment Rx Descriptor buffer */
+	dma_addr_t     TxDescDmaAddrs;	/* DMA address of TxDescArrays */
+	dma_addr_t     RxDescDmaAddrs;	/* DMA address of RxDescArrays */
+	dma_addr_t     TxDescDmaAddr;	/* DMA address of TxDescArray */
+	dma_addr_t     RxDescDmaAddr;	/* DMA address of RxDescArray */
 	unsigned char *RxBufferRings;	/* Index of Rx Buffer  */
 	unsigned char *RxBufferRing[NUM_RX_DESC];	/* Index of Rx Buffer array */
+	dma_addr_t     RxBufferDmas;	/* DMA address of RxBufferRings */
+	dma_addr_t     RxBufferDma[NUM_RX_DESC];	/* DMA addresses of RxBufferRing */
 	struct sk_buff *Tx_skbuff[NUM_TX_DESC];	/* Index of Transmit data buffer */
 };
 
 MODULE_AUTHOR("Realtek");
 MODULE_DESCRIPTION("RealTek RTL-8169 Gigabit Ethernet driver");
+MODULE_LICENSE("GPL");
 MODULE_PARM(media, "1-" __MODULE_STRING(MAX_UNITS) "i");
 
 static int rtl8169_open(struct net_device *dev);
@@ -655,7 +667,6 @@
 	struct rtl8169_private *tp = dev->priv;
 	int retval;
 	u8 diff;
-	u32 TxPhyAddr, RxPhyAddr;
 
 	retval =
 	    request_irq(dev->irq, rtl8169_interrupt, SA_SHIRQ, dev->name, dev);
@@ -664,19 +675,21 @@
 	}
 
 	tp->TxDescArrays =
-	    kmalloc(NUM_TX_DESC * sizeof (struct TxDesc) + 256, GFP_KERNEL);
+	    pci_alloc_consistent(tp->pci_dev,
+				 NUM_TX_DESC * sizeof (struct TxDesc) + 256, 
+				 &tp->TxDescDmaAddrs);
 	// Tx Desscriptor needs 256 bytes alignment;
-	TxPhyAddr = virt_to_bus(tp->TxDescArrays);
-	diff = 256 - (TxPhyAddr - ((TxPhyAddr >> 8) << 8));
-	TxPhyAddr += diff;
+	diff = 256 - (tp->TxDescDmaAddrs - ((tp->TxDescDmaAddrs >> 8) << 8));
+	tp->TxDescDmaAddr = tp->TxDescDmaAddrs + diff;
 	tp->TxDescArray = (struct TxDesc *) (tp->TxDescArrays + diff);
 
 	tp->RxDescArrays =
-	    kmalloc(NUM_RX_DESC * sizeof (struct RxDesc) + 256, GFP_KERNEL);
+	    pci_alloc_consistent(tp->pci_dev,
+				 NUM_RX_DESC * sizeof (struct RxDesc) + 256, 
+				 &tp->RxDescDmaAddrs);
 	// Rx Desscriptor needs 256 bytes alignment;
-	RxPhyAddr = virt_to_bus(tp->RxDescArrays);
-	diff = 256 - (RxPhyAddr - ((RxPhyAddr >> 8) << 8));
-	RxPhyAddr += diff;
+	diff = 256 - (tp->RxDescDmaAddrs - ((tp->RxDescDmaAddrs >> 8) << 8));
+	tp->RxDescDmaAddr = tp->RxDescDmaAddrs + diff;
 	tp->RxDescArray = (struct RxDesc *) (tp->RxDescArrays + diff);
 
 	if (tp->TxDescArrays == NULL || tp->RxDescArrays == NULL) {
@@ -684,12 +697,18 @@
 		       "Allocate RxDescArray or TxDescArray failed\n");
 		free_irq(dev->irq, dev);
 		if (tp->TxDescArrays)
-			kfree(tp->TxDescArrays);
+			pci_free_consistent(tp->pci_dev, 
+				NUM_TX_DESC * sizeof (struct TxDesc) + 256,
+				tp->TxDescArrays, tp->TxDescDmaAddrs);
 		if (tp->RxDescArrays)
-			kfree(tp->RxDescArrays);
+			pci_free_consistent(tp->pci_dev, 
+				NUM_RX_DESC * sizeof (struct RxDesc) + 256,
+				tp->RxDescArrays, tp->RxDescDmaAddrs);
 		return -ENOMEM;
 	}
-	tp->RxBufferRings = kmalloc(RX_BUF_SIZE * NUM_RX_DESC, GFP_KERNEL);
+	tp->RxBufferRings = pci_alloc_consistent(tp->pci_dev,
+						 RX_BUF_SIZE * NUM_RX_DESC, 
+						 &tp->RxBufferDmas);
 	if (tp->RxBufferRings == NULL) {
 		printk(KERN_INFO "Allocate RxBufferRing failed\n");
 	}
@@ -733,13 +752,13 @@
 
 	/* Set DMA burst size and Interframe Gap Time */
 	RTL_W32(TxConfig,
-		(TX_DMA_BURST << TxDMAShift) | (InterFrameGap <<
-						TxInterFrameGapShift));
+		(TX_DMA_BURST << TxDMAShift) | 
+			    (InterFrameGap << TxInterFrameGapShift));
 
 	tp->cur_rx = 0;
 
-	RTL_W32(TxDescStartAddr, virt_to_bus(tp->TxDescArray));
-	RTL_W32(RxDescStartAddr, virt_to_bus(tp->RxDescArray));
+	RTL_W32(TxDescStartAddr, tp->TxDescDmaAddr);
+	RTL_W32(RxDescStartAddr, tp->RxDescDmaAddr);
 	RTL_W8(Cfg9346, Cfg9346_Lock);
 	udelay(10);
 
@@ -775,12 +794,17 @@
 	for (i = 0; i < NUM_RX_DESC; i++) {
 		if (i == (NUM_RX_DESC - 1))
 			tp->RxDescArray[i].status =
-			    (OWNbit | EORbit) + RX_BUF_SIZE;
+			    (OWNbit | EORbit) | 
+			    __constant_cpu_to_le32(RX_BUF_SIZE);
 		else
-			tp->RxDescArray[i].status = OWNbit + RX_BUF_SIZE;
+			tp->RxDescArray[i].status = OWNbit | 
+				__constant_cpu_to_le32(RX_BUF_SIZE);
 
 		tp->RxBufferRing[i] = &(tp->RxBufferRings[i * RX_BUF_SIZE]);
-		tp->RxDescArray[i].buf_addr = virt_to_bus(tp->RxBufferRing[i]);
+		tp->RxBufferDma[i] = 
+			(dma_addr_t)((unsigned int)tp->RxBufferDmas + 
+				     i * RX_BUF_SIZE);
+		tp->RxDescArray[i].buf_addr = cpu_to_le32(tp->RxBufferDma[i]);
 	}
 }
 
@@ -842,15 +866,19 @@
 
 	if ((tp->TxDescArray[entry].status & OWNbit) == 0) {
 		tp->Tx_skbuff[entry] = skb;
-		tp->TxDescArray[entry].buf_addr = virt_to_bus(skb->data);
+		tp->TxDescArray[entry].buf_addr = 
+			cpu_to_le32(pci_map_single(tp->pci_dev, skb->data,
+						   skb->len, PCI_DMA_TODEVICE));
 		if (entry != (NUM_TX_DESC - 1))
 			tp->TxDescArray[entry].status =
-			    (OWNbit | FSbit | LSbit) | ((skb->len > ETH_ZLEN) ?
-							skb->len : ETH_ZLEN);
+			    (OWNbit | FSbit | LSbit) | 
+			    cpu_to_le32((skb->len > ETH_ZLEN) ?
+					skb->len : ETH_ZLEN);
 		else
 			tp->TxDescArray[entry].status =
 			    (OWNbit | EORbit | FSbit | LSbit) |
-			    ((skb->len > ETH_ZLEN) ? skb->len : ETH_ZLEN);
+			    cpu_to_le32(((skb->len > ETH_ZLEN) ? 
+					 skb->len : ETH_ZLEN));
 
 		RTL_W8(TxPoll, 0x40);	//set polling bit
 
@@ -884,8 +912,14 @@
 
 	while (tx_left > 0) {
 		if ((tp->TxDescArray[entry].status & OWNbit) == 0) {
-			dev_kfree_skb_irq(tp->
-					  Tx_skbuff[dirty_tx % NUM_TX_DESC]);
+			struct sk_buff *skb = 
+				tp->Tx_skbuff[dirty_tx % NUM_TX_DESC];
+
+			pci_unmap_single(tp->pci_dev, 
+					 le32_to_cpu(tp->TxDescArray[entry].
+						     buf_addr), 
+					 skb->len, PCI_DMA_TODEVICE);
+			dev_kfree_skb_irq(skb);
 			tp->Tx_skbuff[dirty_tx % NUM_TX_DESC] = NULL;
 			tp->stats.tx_packets++;
 			dirty_tx++;
@@ -926,8 +960,8 @@
 				tp->stats.rx_crc_errors++;
 		} else {
 			pkt_size =
-			    (int) (tp->RxDescArray[cur_rx].
-				   status & 0x00001FFF) - 4;
+			    (int) (le32_to_cpu(tp->RxDescArray[cur_rx].
+				   status) & 0x00001FFF) - 4;
 			skb = dev_alloc_skb(pkt_size + 2);
 			if (skb != NULL) {
 				skb->dev = dev;
@@ -940,13 +974,15 @@
 
 				if (cur_rx == (NUM_RX_DESC - 1))
 					tp->RxDescArray[cur_rx].status =
-					    (OWNbit | EORbit) + RX_BUF_SIZE;
+					    (OWNbit | EORbit) | 
+					    __constant_cpu_to_le32(RX_BUF_SIZE);
 				else
 					tp->RxDescArray[cur_rx].status =
-					    OWNbit + RX_BUF_SIZE;
+					    OWNbit | 
+					    __constant_cpu_to_le32(RX_BUF_SIZE);
 
 				tp->RxDescArray[cur_rx].buf_addr =
-				    virt_to_bus(tp->RxBufferRing[cur_rx]);
+				    cpu_to_le32(tp->RxBufferDma[cur_rx]);
 				dev->last_rx = jiffies;
 				tp->stats.rx_bytes += pkt_size;
 				tp->stats.rx_packets++;
@@ -1045,13 +1081,18 @@
 	free_irq(dev->irq, dev);
 
 	rtl8169_tx_clear(tp);
-	kfree(tp->TxDescArrays);
-	kfree(tp->RxDescArrays);
+	pci_free_consistent(tp->pci_dev, 
+		NUM_TX_DESC * sizeof (struct TxDesc) + 256,
+		tp->TxDescArrays, tp->TxDescDmaAddrs);
+	pci_free_consistent(tp->pci_dev, 
+		NUM_RX_DESC * sizeof (struct RxDesc) + 256,
+		tp->RxDescArrays, tp->RxDescDmaAddrs);
 	tp->TxDescArrays = NULL;
 	tp->RxDescArrays = NULL;
 	tp->TxDescArray = NULL;
 	tp->RxDescArray = NULL;
-	kfree(tp->RxBufferRings);
+	pci_free_consistent(tp->pci_dev, RX_BUF_SIZE * NUM_RX_DESC,
+			    tp->RxBufferRings, tp->RxBufferDmas);
 	for (i = 0; i < NUM_RX_DESC; i++) {
 		tp->RxBufferRing[i] = NULL;
 	}

--VS++wcV0S1rZb1Fb--
