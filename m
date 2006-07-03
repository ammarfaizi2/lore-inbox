Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWGCIOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWGCIOn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 04:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWGCIOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 04:14:43 -0400
Received: from srv1.iportent.com ([62.90.210.153]:19881 "EHLO iportent.com")
	by vger.kernel.org with ESMTP id S1750853AbWGCIOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 04:14:40 -0400
Subject: [PATCH 2.6.17.1 1/2] dllink driver: porting v1.19 to linux 2.6.17
From: Hayim Shaul <hayim@iportent.com>
To: linux-kernel@vger.kernel.org, edward_peng@dlink.com.tw
Cc: netdev@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Jul 2006 11:19:39 +0300
Message-Id: <1151914780.2859.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
For DLink Fiber NIC, Linux 2.4.22 ships with driver version 1.19,
whereas, Linux 2.6.x ship with driver version 1.17.

The following patch upgrades the 2.6.x driver to include changes (and
bug fixes done until 1.19b).

These fixes are (copied from the driver):
    1.18    2002/11/07  New tx scheme, adaptive tx_coalesce.
                    Remove tx_coalesce option.
    1.19    2003/12/16  Fix problem parsing the eeprom on big endian
                    systems. (philt@4bridgeworks.com)

Disclaimer:
Since I returned my DLink NIC to the store I couldn't test it
thoroughly. It seemed to work just as well as v1.17. However, both
version made the NIC hang after a few minutes.

Signed-off-by: Hayim Shaul <hayim@iportent.com>

--- linux-2.6.17.1/drivers/net/dl2k.c.orig	2006-07-03 10:28:43.000000000 +0300
+++ linux-2.6.17.1/drivers/net/dl2k.c	2006-07-03 10:31:31.000000000 +0300
@@ -1,7 +1,8 @@
 /*  D-Link DL2000-based Gigabit Ethernet Adapter Linux driver */
 /*
     Copyright (c) 2001, 2002 by D-Link Corporation
-    Written by Edward Peng.<edward_peng@dlink.com.tw>
+    Copyright (c) 2003 by Alpha Networks
+    Written by Edward Peng.<edward_peng@alphanetworks.com.tw>
     Created 03-May-2001, base on Linux' sundance.c.
 
     This program is free software; you can redistribute it and/or modify
@@ -47,11 +48,16 @@
     1.17	2002/10/03	Fix RMON statistics overflow. 
 			     	Always use I/O mapping to access eeprom, 
 				avoid system freezing with some chipsets.
+    1.18	2002/11/07	New tx scheme, adaptive tx_coalesce.
+    				Remove tx_coalesce option.
+    1.19	2003/12/16	Fix problem parsing the eeprom on big endian
+    				systems. (philt@4bridgeworks.com)
+    1.19a	2006/07/01	made compile on kernel 2.6.15. (hayim@iportent.com)
 
 */
 #define DRV_NAME	"D-Link DL2000-based linux driver"
-#define DRV_VERSION	"v1.17b"
-#define DRV_RELDATE	"2006/03/10"
+#define DRV_VERSION	"v1.19a"
+#define DRV_RELDATE	"2006/07/01"
 #include "dl2k.h"
 #include <linux/dma-mapping.h>
 
@@ -65,9 +71,8 @@ static char *media[MAX_UNITS];
 static int tx_flow=-1;
 static int rx_flow=-1;
 static int copy_thresh;
-static int rx_coalesce=10;	/* Rx frame count each interrupt */
+static int rx_coalesce=0;	/* Rx frame count each interrupt */
 static int rx_timeout=200;	/* Rx DMA wait time in 640ns increments */
-static int tx_coalesce=16;	/* HW xmit count each TxDMAComplete */
 
 
 MODULE_AUTHOR ("Edward Peng");
@@ -82,12 +87,11 @@ module_param(rx_flow, int, 0);
 module_param(copy_thresh, int, 0);
 module_param(rx_coalesce, int, 0);	/* Rx frame count each interrupt */
 module_param(rx_timeout, int, 0);	/* Rx DMA wait time in 64ns increments */
-module_param(tx_coalesce, int, 0); /* HW xmit count each TxDMAComplete */
 
 
 /* Enable the default interrupts */
 #define DEFAULT_INTR (RxDMAComplete | HostError | IntRequested | TxDMAComplete| \
-       UpdateStats | LinkEvent)
+       UpdateStats | LinkEvent|TxComplete)
 #define EnableInt() \
 writew(DEFAULT_INTR, ioaddr + IntEnable)
 
@@ -98,11 +102,13 @@ static int rio_open (struct net_device *
 static void rio_timer (unsigned long data);
 static void rio_tx_timeout (struct net_device *dev);
 static void alloc_list (struct net_device *dev);
+static void tx_poll (unsigned long data);
 static int start_xmit (struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t rio_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
-static void rio_free_tx (struct net_device *dev, int irq);
+static void rio_free_tx (struct net_device *dev);
 static void tx_error (struct net_device *dev, int tx_status);
-static int receive_packet (struct net_device *dev);
+static void rx_poll (unsigned long data);
+static void refill_rx (struct net_device *dev);
 static void rio_error (struct net_device *dev, int int_status);
 static int change_mtu (struct net_device *dev, int new_mtu);
 static void set_multicast (struct net_device *dev);
@@ -175,10 +181,11 @@ rio_probe1 (struct pci_dev *pdev, const 
 	np->pdev = pdev;
 	spin_lock_init (&np->tx_lock);
 	spin_lock_init (&np->rx_lock);
+	tasklet_init(&np->tx_tasklet, tx_poll, (unsigned long) dev);
+	tasklet_init(&np->rx_tasklet, rx_poll, (unsigned long) dev);
 
 	/* Parse manual configuration */
 	np->an_enable = 1;
-	np->tx_coalesce = 1;
 	if (card_idx < MAX_UNITS) {
 		if (media[card_idx] != NULL) {
 			np->an_enable = 0;
@@ -232,10 +239,6 @@ rio_probe1 (struct pci_dev *pdev, const 
 		np->tx_flow = (tx_flow == 0) ? 0 : 1;
 		np->rx_flow = (rx_flow == 0) ? 0 : 1;
 
-		if (tx_coalesce < 1)
-			tx_coalesce = 1;
-		else if (tx_coalesce > TX_RING_SIZE-1)
-			tx_coalesce = TX_RING_SIZE - 1;
 	}
 	dev->open = &rio_open;
 	dev->hard_start_xmit = &start_xmit;
@@ -301,9 +304,6 @@ rio_probe1 (struct pci_dev *pdev, const 
 		dev->name, np->name,
 		dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
 		dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5], irq);
-	if (tx_coalesce > 1)
-		printk(KERN_INFO "tx_coalesce:\t%d packets\n", 
-				tx_coalesce);
 	if (np->coalesce)
 		printk(KERN_INFO "rx_coalesce:\t%d packets\n"
 		       KERN_INFO "rx_timeout: \t%d ns\n", 
@@ -374,8 +374,9 @@ parse_eeprom (struct net_device *dev)
 #endif
 	/* Read eeprom */
 	for (i = 0; i < 128; i++) {
-		((u16 *) sromdata)[i] = le16_to_cpu (read_eeprom (ioaddr, i));
+		((u16 *) sromdata)[i] = cpu_to_le16 (read_eeprom (ioaddr, i));
 	}
+	psrom->crc = le32_to_cpu(psrom->crc);
 #ifdef	MEM_MAPPING
 	ioaddr = dev->base_addr;
 #endif	
@@ -473,9 +474,12 @@ rio_open (struct net_device *dev)
 	writeb (0x30, ioaddr + RxDMABurstThresh);
 	writeb (0x30, ioaddr + RxDMAUrgentThresh);
 	writel (0x0007ffff, ioaddr + RmonStatMask);
+
 	/* clear statistics */
 	clear_stats (dev);
 
+	atomic_set(&np->tx_desc_lock, 0);
+
 	/* VLAN supported */
 	if (np->vlan) {
 		/* priority field in RxDMAIntCtrl  */
@@ -560,17 +564,31 @@ rio_timer (unsigned long data)
 	np->timer.expires = jiffies + next_tick;
 	add_timer(&np->timer);
 }
-	
+
 static void
 rio_tx_timeout (struct net_device *dev)
 {
+	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 
-	printk (KERN_INFO "%s: Tx timed out (%4.4x), is buffer full?\n",
+	printk (KERN_INFO "%s: Tx timed out (%4.4x), "
+			"clean up tx queue to restart..\n",
 		dev->name, readl (ioaddr + TxStatus));
-	rio_free_tx(dev, 0);
+	printk (KERN_INFO "%s: cur_tx=%lx cur_task=%lx old_tx=%lx "
+			"TFDListPtr=%08x tx_full=%d",
+			dev->name, np->cur_tx, np->cur_task, np->old_tx,
+			readl(ioaddr + TFDListPtr0),
+			netif_queue_stopped(dev));
+	writew(0, ioaddr + IntEnable);
+	writew(0, ioaddr + TFDListPtr0);
+	writew(0, ioaddr + TFDListPtr1);
+	tasklet_disable(&np->tx_tasklet);
+	rio_free_tx(dev);
 	dev->if_port = 0;
 	dev->trans_start = jiffies;
+	tasklet_enable(&np->tx_tasklet);
+	writew(DEFAULT_INTR, ioaddr + IntEnable);
+	return;
 }
 
  /* allocate and initialize Tx and Rx descriptors */
@@ -582,6 +600,7 @@ alloc_list (struct net_device *dev)
 
 	np->cur_rx = np->cur_tx = 0;
 	np->old_rx = np->old_tx = 0;
+	np->cur_task = 0;
 	np->rx_buf_sz = (dev->mtu <= 1500 ? PACKET_SIZE : dev->mtu + 32);
 
 	/* Initialize Tx descriptors, TFDListPtr leaves in start_xmit(). */
@@ -631,6 +650,31 @@ alloc_list (struct net_device *dev)
 	return;
 }
 
+static void tx_poll (unsigned long data)
+{
+	struct net_device *dev = (struct net_device*) data;
+	struct netdev_private *np = dev->priv;
+	unsigned head = np->cur_task % TX_RING_SIZE;
+	struct netdev_desc *txdesc = 
+		&np->tx_ring[(np->cur_tx + TX_RING_SIZE - 1) % TX_RING_SIZE];
+
+	/* Indicate the latest descriptor of tx ring */
+	txdesc->status |= cpu_to_le64 (TxDMAIndicate);
+	
+	while ((np->cur_task + TX_RING_SIZE - np->cur_tx) % TX_RING_SIZE > 0) {
+		txdesc = &np->tx_ring[np->cur_task];
+		txdesc->status &= cpu_to_le64 (~TFDDone);
+		np->cur_task = (np->cur_task + 1) % TX_RING_SIZE;
+	}
+
+	if (readl (dev->base_addr + TFDListPtr0) == 0) {
+		writel (np->tx_ring_dma + head * sizeof (struct netdev_desc),
+			dev->base_addr + TFDListPtr0);
+		writel (0, dev->base_addr + TFDListPtr1);
+	}
+
+	return;
+}
 static int
 start_xmit (struct sk_buff *skb, struct net_device *dev)
 {
@@ -669,35 +713,40 @@ start_xmit (struct sk_buff *skb, struct 
 
 	/* DL2K bug: DMA fails to get next descriptor ptr in 10Mbps mode
 	 * Work around: Always use 1 descriptor in 10Mbps mode */
-	if (entry % np->tx_coalesce == 0 || np->speed == 10)
-		txdesc->status = cpu_to_le64 (entry | tfc_vlan_tag |
+	if (np->speed == 10) {
+		/* Note the order! Stop queue before hardware processing
+		 * this descriptor */
+		netif_stop_queue (dev);
+		txdesc->status = cpu_to_le64 (entry | tfc_vlan_tag | 
 					      WordAlignDisable | 
-					      TxDMAIndicate |
+					      TxDMAIndicate | TxComplete |
 					      (1 << FragCountShift));
-	else
-		txdesc->status = cpu_to_le64 (entry | tfc_vlan_tag |
+		/* TxDMAPollNow */
+		writel(readl(ioaddr + DMACtrl) | 0x00001000, ioaddr + DMACtrl);
+		if (readl (dev->base_addr + TFDListPtr0) == 0) {
+			writel (np->tx_ring_dma + 
+				entry * sizeof (struct netdev_desc),
+				dev->base_addr + TFDListPtr0);
+			writel (0, dev->base_addr + TFDListPtr1);
+		}
+		np->cur_tx = np->cur_task = (np->cur_tx + 1) % TX_RING_SIZE;
+	} else {
+		np->cur_tx = (np->cur_tx + 1) % TX_RING_SIZE;
+		mb();
+		txdesc->status = cpu_to_le64 (entry | tfc_vlan_tag | TFDDone |
 					      WordAlignDisable | 
 					      (1 << FragCountShift));
-
-	/* TxDMAPollNow */
-	writel (readl (ioaddr + DMACtrl) | 0x00001000, ioaddr + DMACtrl);
-	/* Schedule ISR */
-	writel(10000, ioaddr + CountDown);
-	np->cur_tx = (np->cur_tx + 1) % TX_RING_SIZE;
-	if ((np->cur_tx - np->old_tx + TX_RING_SIZE) % TX_RING_SIZE
-			< TX_QUEUE_LEN - 1 && np->speed != 10) {
-		/* do nothing */
-	} else if (!netif_queue_stopped(dev)) {
-		netif_stop_queue (dev);
+		tasklet_schedule (&np->tx_tasklet);
+		/* Schedule ISR */
+		if ((np->cur_tx - np->old_tx + TX_RING_SIZE) % TX_RING_SIZE
+				< TX_QUEUE_LEN - 1) {
+			/* do nothing */
+		} else if (!netif_queue_stopped(dev)) {
+			netif_stop_queue (dev);
+		}
 	}
 
-	/* The first TFDListPtr */
-	if (readl (dev->base_addr + TFDListPtr0) == 0) {
-		writel (np->tx_ring_dma + entry * sizeof (struct netdev_desc),
-			dev->base_addr + TFDListPtr0);
-		writel (0, dev->base_addr + TFDListPtr1);
-	}
-	
+
 	/* NETDEV WATCHDOG timer */
 	dev->trans_start = jiffies;
 	return 0;
@@ -723,16 +772,22 @@ rio_interrupt (int irq, void *dev_instan
 			break;
 		handled = 1;
 		/* Processing received packets */
-		if (int_status & RxDMAComplete)
-			receive_packet (dev);
+		if (int_status & RxDMAComplete) {
+			writew(DEFAULT_INTR & ~(RxDMAComplete | RxComplete), 
+					ioaddr + IntEnable);
+			if (np->budget < 0) {
+				np->budget = RX_BUDGET;
+			}
+			tasklet_schedule (&np->rx_tasklet);
+		}
 		/* TxDMAComplete interrupt */
-		if ((int_status & (TxDMAComplete|IntRequested))) {
+		if ((int_status & (TxDMAComplete|IntRequested|TxComplete))) {
 			int tx_status;
 			tx_status = readl (ioaddr + TxStatus);
 			if (tx_status & 0x01)
 				tx_error (dev, tx_status);
 			/* Free used tx skbuffs */
-			rio_free_tx (dev, 1);		
+			rio_free_tx (dev);		
 		}
 
 		/* Handle uncommon events */
@@ -740,26 +795,28 @@ rio_interrupt (int irq, void *dev_instan
 		    (HostError | LinkEvent | UpdateStats))
 			rio_error (dev, int_status);
 	}
-	if (np->cur_tx != np->old_tx)
-		writel (100, ioaddr + CountDown);
+	writel(5000, ioaddr + CountDown);
 	return IRQ_RETVAL(handled);
 }
 
 static void 
-rio_free_tx (struct net_device *dev, int irq) 
+rio_free_tx (struct net_device *dev) 
 {
 	struct netdev_private *np = netdev_priv(dev);
 	int entry = np->old_tx % TX_RING_SIZE;
-	int tx_use = 0;
 	unsigned long flag = 0;
+	int irq = in_interrupt();
+
+	if (atomic_read(&np->tx_desc_lock))
+		return;
+	atomic_inc(&np->tx_desc_lock);
 	
 	if (irq)
 		spin_lock(&np->tx_lock);
 	else
 		spin_lock_irqsave(&np->tx_lock, flag);
-			
 	/* Free used tx skbuffs */
-	while (entry != np->cur_tx) {
+	while (entry != np->cur_task) {
 		struct sk_buff *skb;
 
 		if (!(np->tx_ring[entry].status & TFDDone))
@@ -775,8 +832,8 @@ rio_free_tx (struct net_device *dev, int
 
 		np->tx_skbuff[entry] = NULL;
 		entry = (entry + 1) % TX_RING_SIZE;
-		tx_use++;
 	}
+
 	if (irq)
 		spin_unlock(&np->tx_lock);
 	else
@@ -785,12 +842,19 @@ rio_free_tx (struct net_device *dev, int
 
 	/* If the ring is no longer full, clear tx_full and 
 	   call netif_wake_queue() */
-
-	if (netif_queue_stopped(dev) &&
+	if (np->speed != 10) {
+		if (netif_queue_stopped(dev) &&
 	    ((np->cur_tx - np->old_tx + TX_RING_SIZE) % TX_RING_SIZE 
-	    < TX_QUEUE_LEN - 1 || np->speed == 10)) {
+	    < TX_QUEUE_LEN - 1)) {
 		netif_wake_queue (dev);
+		}
 	}
+	else {
+		if (netif_queue_stopped(dev) && 
+	    		np->cur_tx == np->old_tx) 
+		netif_wake_queue(dev);
+	}
+	atomic_dec(&np->tx_desc_lock);
 }
 
 static void
@@ -821,7 +885,7 @@ tx_error (struct net_device *dev, int tx
 				break;
 			mdelay (1);
 		}
-		rio_free_tx (dev, 1);
+		rio_free_tx (dev);
 		/* Reset TFDListPtr */
 		writel (np->tx_ring_dma +
 			np->old_tx * sizeof (struct netdev_desc),
@@ -855,28 +919,36 @@ tx_error (struct net_device *dev, int tx
 	writel (readw (dev->base_addr + MACCtrl) | TxEnable, ioaddr + MACCtrl);
 }
 
-static int
-receive_packet (struct net_device *dev)
+static void rx_poll (unsigned long data)
 {
-	struct netdev_private *np = netdev_priv(dev);
+	struct net_device *dev = (struct net_device*) data;
+	struct netdev_private *np = (struct netdev_private *) dev->priv;
 	int entry = np->cur_rx % RX_RING_SIZE;
-	int cnt = 30;
-
+	int cnt = np->budget;
+	long ioaddr = dev->base_addr;
+	int received = 0;
 	/* If RFDDone, FrameStart and FrameEnd set, there is a new packet in. */
 	while (1) {
 		struct netdev_desc *desc = &np->rx_ring[entry];
 		int pkt_len;
 		u64 frame_status;
 
-		if (!(desc->status & RFDDone) ||
-		    !(desc->status & FrameStart) || !(desc->status & FrameEnd))
-			break;
+		if (--cnt < 0) {
+			np->cur_rx = entry;
+			goto not_done;
+		}
 
 		/* Chip omits the CRC. */
 		pkt_len = le64_to_cpu (desc->status & 0xffff);
 		frame_status = le64_to_cpu (desc->status);
-		if (--cnt < 0)
+
+		if (!(desc->status & RFDDone) ||
+		    !(desc->status & FrameStart) || !(desc->status & FrameEnd))
 			break;
+		
+
+		pci_dma_sync_single_for_device (np->pdev, desc->fraginfo, np->rx_buf_sz,
+				     PCI_DMA_FROMDEVICE);
 		/* Update rx error statistics, drop packet. */
 		if (frame_status & RFS_Errors) {
 			np->stats.rx_errors++;
@@ -930,9 +1002,37 @@ receive_packet (struct net_device *dev)
 			dev->last_rx = jiffies;
 		}
 		entry = (entry + 1) % RX_RING_SIZE;
+		received++;
 	}
-	spin_lock(&np->rx_lock);
 	np->cur_rx = entry;
+	refill_rx (dev);
+	np->budget -= received;
+	writew (DEFAULT_INTR, ioaddr + IntEnable);
+	return;
+	
+not_done:
+	refill_rx (dev);
+	if (!received)
+		received = 1;
+	np->budget -= received;
+	if (np->budget <= 0)
+		np->budget = RX_BUDGET;
+	tasklet_schedule (&np->rx_tasklet);
+	return;
+}
+
+static void refill_rx (struct net_device *dev) 
+{
+	struct netdev_private *np = dev->priv;
+	int entry;
+	int irq = in_interrupt();
+	unsigned long flag = 0;
+
+	if (irq)
+		spin_lock(&np->rx_lock);
+	else
+		spin_lock_irqsave(&np->rx_lock, flag);
+
 	/* Re-allocate skbuffs to fill the descriptor ring */
 	entry = np->old_rx;
 	while (entry != np->cur_rx) {
@@ -963,8 +1063,12 @@ receive_packet (struct net_device *dev)
 		entry = (entry + 1) % RX_RING_SIZE;
 	}
 	np->old_rx = entry;
-	spin_unlock(&np->rx_lock);
-	return 0;
+
+	if (irq)
+		spin_unlock(&np->rx_lock);
+	else
+		spin_unlock_irqrestore(&np->rx_lock, flag);
+	return;
 }
 
 static void
@@ -982,10 +1086,6 @@ rio_error (struct net_device *dev, int i
 				mii_get_media_pcs (dev);
 			else
 				mii_get_media (dev);
-			if (np->speed == 1000)
-				np->tx_coalesce = tx_coalesce;
-			else 
-				np->tx_coalesce = 1;
 			macctrl = 0;
 			macctrl |= (np->vlan) ? AutoVLANuntagging : 0;
 			macctrl |= (np->full_duplex) ? DuplexSelect : 0;
@@ -1023,10 +1123,10 @@ get_stats (struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
 	struct netdev_private *np = netdev_priv(dev);
+	unsigned int stat_reg;
 #ifdef MEM_MAPPING
 	int i;
 #endif
-	unsigned int stat_reg;
 
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
@@ -1067,7 +1167,6 @@ get_stats (struct net_device *dev)
 	readw (ioaddr + BcstFramesXmtdOk);
 	readw (ioaddr + MacControlFramesXmtd);
 	readw (ioaddr + FramesWEXDeferal);
-
 #ifdef MEM_MAPPING
 	for (i = 0x100; i <= 0x150; i += 4)
 		readl (ioaddr + i);
@@ -1086,7 +1185,7 @@ clear_stats (struct net_device *dev)
 	long ioaddr = dev->base_addr;
 #ifdef MEM_MAPPING
 	int i;
-#endif 
+#endif
 
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
@@ -1125,7 +1224,7 @@ clear_stats (struct net_device *dev)
 #ifdef MEM_MAPPING
 	for (i = 0x100; i <= 0x150; i += 4)
 		readl (ioaddr + i);
-#endif 
+#endif
 	readw (ioaddr + TxJumboFrames);
 	readw (ioaddr + RxJumboFrames);
 	readw (ioaddr + TCPCheckSumErrors);
@@ -1791,6 +1890,8 @@ rio_close (struct net_device *dev)
 	/* Stop Tx and Rx logics */
 	writel (TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl);
 	synchronize_irq (dev->irq);
+	tasklet_kill (&np->tx_tasklet);
+	tasklet_kill (&np->rx_tasklet);
 	free_irq (dev->irq, dev);
 	del_timer_sync (&np->timer);
 	

