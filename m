Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVCaCBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVCaCBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 21:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVCaCBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 21:01:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7133 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262474AbVCaB7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:59:41 -0500
Message-ID: <424B597D.80106@pobox.com>
Date: Wed, 30 Mar 2005 20:59:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.6.x net driver fixes
Content-Type: multipart/mixed;
 boundary="------------040205050900060205050307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040205050900060205050307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------040205050900060205050307
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/net-drivers-2.6

This will update the following files:

 drivers/net/b44.c              |   36 +++---
 drivers/net/b44.h              |    3 
 drivers/net/e1000/e1000.h      |    1 
 drivers/net/e1000/e1000_main.c |   21 +++
 drivers/net/macsonic.c         |    1 
 drivers/net/pcnet32.c          |    3 
 drivers/net/s2io-regs.h        |    2 
 drivers/net/s2io.c             |  245 +++++++++++++++++++----------------------
 drivers/net/s2io.h             |  119 -------------------
 include/linux/pci_ids.h        |    2 
 10 files changed, 167 insertions(+), 266 deletions(-)

through these ChangeSets:

<fthain:telegraphics.com.au>:
  o fix Jazzsonic driver build on m68k

John W. Linville:
  o e1000: add MODULE_VERSION
  o b44: allocate tx bounce bufs as needed
  o e1000: flush work queues on remove
  o e1000: avoid sleeping in watchdog timer context

Ravinandan Arakali:
  o S2io: Changed copyright and added support for Xframe II
  o S2io: h/w initialization fixes
  o S2io: Statistics fix

Steven HARDY:
  o pcnet32: 79C975 fiber fix


--------------040205050900060205050307
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c	2005-03-30 20:58:14 -05:00
+++ b/drivers/net/b44.c	2005-03-30 20:58:14 -05:00
@@ -907,6 +907,7 @@
 static int b44_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct b44 *bp = netdev_priv(dev);
+	struct sk_buff *bounce_skb;
 	dma_addr_t mapping;
 	u32 len, entry, ctrl;
 
@@ -922,15 +923,31 @@
 		return 1;
 	}
 
-	entry = bp->tx_prod;
 	mapping = pci_map_single(bp->pdev, skb->data, len, PCI_DMA_TODEVICE);
 	if(mapping+len > B44_DMA_MASK) {
 		/* Chip can't handle DMA to/from >1GB, use bounce buffer */
-		pci_unmap_single(bp->pdev, mapping, len,PCI_DMA_TODEVICE);
-		memcpy(bp->tx_bufs+entry*TX_PKT_BUF_SZ,skb->data,skb->len);
-		mapping = pci_map_single(bp->pdev, bp->tx_bufs+entry*TX_PKT_BUF_SZ, len, PCI_DMA_TODEVICE);
+		pci_unmap_single(bp->pdev, mapping, len, PCI_DMA_TODEVICE);
+
+		bounce_skb = __dev_alloc_skb(TX_PKT_BUF_SZ,
+					     GFP_ATOMIC|GFP_DMA);
+		if (!bounce_skb)
+			return NETDEV_TX_BUSY;
+
+		mapping = pci_map_single(bp->pdev, bounce_skb->data,
+					 len, PCI_DMA_TODEVICE);
+		if(mapping+len > B44_DMA_MASK) {
+			pci_unmap_single(bp->pdev, mapping,
+					 len, PCI_DMA_TODEVICE);
+			dev_kfree_skb_any(bounce_skb);
+			return NETDEV_TX_BUSY;
+		}
+
+		memcpy(skb_put(bounce_skb, len), skb->data, skb->len);
+		dev_kfree_skb_any(skb);
+		skb = bounce_skb;
 	}
 
+	entry = bp->tx_prod;
 	bp->tx_buffers[entry].skb = skb;
 	pci_unmap_addr_set(&bp->tx_buffers[entry], mapping, mapping);
 
@@ -1077,11 +1094,6 @@
 				    bp->tx_ring, bp->tx_ring_dma);
 		bp->tx_ring = NULL;
 	}
-	if (bp->tx_bufs) {
-		pci_free_consistent(bp->pdev, B44_TX_RING_SIZE * TX_PKT_BUF_SZ,
-				    bp->tx_bufs, bp->tx_bufs_dma);
-		bp->tx_bufs = NULL;
-	}
 }
 
 /*
@@ -1103,12 +1115,6 @@
 	if (!bp->tx_buffers)
 		goto out_err;
 	memset(bp->tx_buffers, 0, size);
-
-	size = B44_TX_RING_SIZE * TX_PKT_BUF_SZ;
-	bp->tx_bufs = pci_alloc_consistent(bp->pdev, size, &bp->tx_bufs_dma);
-	if (!bp->tx_bufs)
-		goto out_err;
-	memset(bp->tx_bufs, 0, size);
 
 	size = DMA_TABLE_BYTES;
 	bp->rx_ring = pci_alloc_consistent(bp->pdev, size, &bp->rx_ring_dma);
diff -Nru a/drivers/net/b44.h b/drivers/net/b44.h
--- a/drivers/net/b44.h	2005-03-30 20:58:14 -05:00
+++ b/drivers/net/b44.h	2005-03-30 20:58:14 -05:00
@@ -383,7 +383,6 @@
 
 	struct ring_info	*rx_buffers;
 	struct ring_info	*tx_buffers;
-	unsigned char		*tx_bufs; 
 
 	u32			dma_offset;
 	u32			flags;
@@ -415,7 +414,7 @@
 	struct pci_dev		*pdev;
 	struct net_device	*dev;
 
-	dma_addr_t		rx_ring_dma, tx_ring_dma,tx_bufs_dma;
+	dma_addr_t		rx_ring_dma, tx_ring_dma;
 
 	u32			rx_pending;
 	u32			tx_pending;
diff -Nru a/drivers/net/e1000/e1000.h b/drivers/net/e1000/e1000.h
--- a/drivers/net/e1000/e1000.h	2005-03-30 20:58:14 -05:00
+++ b/drivers/net/e1000/e1000.h	2005-03-30 20:58:14 -05:00
@@ -203,6 +203,7 @@
 	spinlock_t stats_lock;
 	atomic_t irq_sem;
 	struct work_struct tx_timeout_task;
+	struct work_struct watchdog_task;
 	uint8_t fc_autoneg;
 
 	struct timer_list blink_timer;
diff -Nru a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	2005-03-30 20:58:14 -05:00
+++ b/drivers/net/e1000/e1000_main.c	2005-03-30 20:58:14 -05:00
@@ -65,7 +65,8 @@
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
-char e1000_driver_version[] = "5.7.6-k2"DRIVERNAPI;
+#define DRV_VERSION "5.7.6-k2"DRIVERNAPI
+char e1000_driver_version[] = DRV_VERSION;
 char e1000_copyright[] = "Copyright (c) 1999-2004 Intel Corporation.";
 
 /* e1000_pci_tbl - PCI Device ID Table
@@ -142,6 +143,7 @@
 static void e1000_set_multi(struct net_device *netdev);
 static void e1000_update_phy_info(unsigned long data);
 static void e1000_watchdog(unsigned long data);
+static void e1000_watchdog_task(struct e1000_adapter *adapter);
 static void e1000_82547_tx_fifo_stall(unsigned long data);
 static int e1000_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
 static struct net_device_stats * e1000_get_stats(struct net_device *netdev);
@@ -210,6 +212,7 @@
 MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 static int debug = NETIF_MSG_DRV | NETIF_MSG_PROBE;
 module_param(debug, int, 0);
@@ -574,6 +577,9 @@
 	adapter->watchdog_timer.function = &e1000_watchdog;
 	adapter->watchdog_timer.data = (unsigned long) adapter;
 
+	INIT_WORK(&adapter->watchdog_task,
+		(void (*)(void *))e1000_watchdog_task, adapter);
+
 	init_timer(&adapter->phy_info_timer);
 	adapter->phy_info_timer.function = &e1000_update_phy_info;
 	adapter->phy_info_timer.data = (unsigned long) adapter;
@@ -660,6 +666,8 @@
 	struct e1000_adapter *adapter = netdev->priv;
 	uint32_t manc;
 
+	flush_scheduled_work();
+
 	if(adapter->hw.mac_type >= e1000_82540 &&
 	   adapter->hw.media_type == e1000_media_type_copper) {
 		manc = E1000_READ_REG(&adapter->hw, MANC);
@@ -1529,13 +1537,20 @@
 
 /**
  * e1000_watchdog - Timer Call-back
- * @data: pointer to netdev cast into an unsigned long
+ * @data: pointer to adapter cast into an unsigned long
  **/
-
 static void
 e1000_watchdog(unsigned long data)
 {
 	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
+
+	/* Do the rest outside of interrupt context */
+	schedule_work(&adapter->watchdog_task);
+}
+
+static void
+e1000_watchdog_task(struct e1000_adapter *adapter)
+{
 	struct net_device *netdev = adapter->netdev;
 	struct e1000_desc_ring *txdr = &adapter->tx_ring;
 	uint32_t link;
diff -Nru a/drivers/net/macsonic.c b/drivers/net/macsonic.c
--- a/drivers/net/macsonic.c	2005-03-30 20:58:14 -05:00
+++ b/drivers/net/macsonic.c	2005-03-30 20:58:14 -05:00
@@ -638,6 +638,7 @@
 #define vdma_free(baz)
 #define sonic_chiptomem(bat) (bat)
 #define PHYSADDR(quux) (quux)
+#define CPHYSADDR(quux) (quux)
 
 #define sonic_request_irq       request_irq
 #define sonic_free_irq          free_irq
diff -Nru a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
--- a/drivers/net/pcnet32.c	2005-03-30 20:58:14 -05:00
+++ b/drivers/net/pcnet32.c	2005-03-30 20:58:14 -05:00
@@ -1351,7 +1351,8 @@
 	printk(KERN_INFO "%s: registered as %s\n", dev->name, lp->name);
     cards_found++;
 
-    a->write_bcr(ioaddr, 2, 0x1002);	/* enable LED writes */
+    /* enable LED writes */
+    a->write_bcr(ioaddr, 2, a->read_bcr(ioaddr, 2) | 0x1000);
 
     return 0;
 
diff -Nru a/drivers/net/s2io-regs.h b/drivers/net/s2io-regs.h
--- a/drivers/net/s2io-regs.h	2005-03-30 20:58:14 -05:00
+++ b/drivers/net/s2io-regs.h	2005-03-30 20:58:14 -05:00
@@ -1,6 +1,6 @@
 /************************************************************************
  * regs.h: A Linux PCI-X Ethernet driver for S2IO 10GbE Server NIC
- * Copyright 2002 Raghavendra Koushik (raghavendra.koushik@s2io.com)
+ * Copyright(c) 2002-2005 Neterion Inc.
 
  * This software may be used and distributed according to the terms of
  * the GNU General Public License (GPL), incorporated herein by reference.
diff -Nru a/drivers/net/s2io.c b/drivers/net/s2io.c
--- a/drivers/net/s2io.c	2005-03-30 20:58:14 -05:00
+++ b/drivers/net/s2io.c	2005-03-30 20:58:14 -05:00
@@ -1,6 +1,6 @@
 /************************************************************************
  * s2io.c: A Linux PCI-X Ethernet driver for S2IO 10GbE Server NIC
- * Copyright(c) 2002-2005 S2IO Technologies
+ * Copyright(c) 2002-2005 Neterion Inc.
 
  * This software may be used and distributed according to the terms of
  * the GNU General Public License (GPL), incorporated herein by reference.
@@ -66,7 +66,7 @@
 
 /* S2io Driver name & version. */
 static char s2io_driver_name[] = "s2io";
-static char s2io_driver_version[] = "Version 1.7.5.1";
+static char s2io_driver_version[] = "Version 1.7.7.1";
 
 /* 
  * Cards with following subsystem_id have a link state indication
@@ -245,6 +245,10 @@
 	 PCI_ANY_ID, PCI_ANY_ID},
 	{PCI_VENDOR_ID_S2IO, PCI_DEVICE_ID_S2IO_UNI,
 	 PCI_ANY_ID, PCI_ANY_ID},
+	{PCI_VENDOR_ID_S2IO, PCI_DEVICE_ID_HERC_WIN,
+	 PCI_ANY_ID, PCI_ANY_ID},
+	{PCI_VENDOR_ID_S2IO, PCI_DEVICE_ID_HERC_UNI,
+	 PCI_ANY_ID, PCI_ANY_ID},
 	{0,}
 };
 
@@ -620,79 +624,15 @@
 	mac_info_t *mac_control;
 	struct config_param *config;
 	int mdio_cnt = 0, dtx_cnt = 0;
-	unsigned long long print_var, mem_share;
+	unsigned long long mem_share;
 
 	mac_control = &nic->mac_control;
 	config = &nic->config;
 
-	/* 
-	 * Set proper endian settings and verify the same by 
-	 * reading the PIF Feed-back register.
-	 */
-#ifdef  __BIG_ENDIAN
-	/*
-	 * The device by default set to a big endian format, so 
-	 * a big endian driver need not set anything.
-	 */
-	writeq(0xffffffffffffffffULL, &bar0->swapper_ctrl);
-	val64 = (SWAPPER_CTRL_PIF_R_FE |
-		 SWAPPER_CTRL_PIF_R_SE |
-		 SWAPPER_CTRL_PIF_W_FE |
-		 SWAPPER_CTRL_PIF_W_SE |
-		 SWAPPER_CTRL_TXP_FE |
-		 SWAPPER_CTRL_TXP_SE |
-		 SWAPPER_CTRL_TXD_R_FE |
-		 SWAPPER_CTRL_TXD_W_FE |
-		 SWAPPER_CTRL_TXF_R_FE |
-		 SWAPPER_CTRL_RXD_R_FE |
-		 SWAPPER_CTRL_RXD_W_FE |
-		 SWAPPER_CTRL_RXF_W_FE |
-		 SWAPPER_CTRL_XMSI_FE |
-		 SWAPPER_CTRL_XMSI_SE |
-		 SWAPPER_CTRL_STATS_FE | SWAPPER_CTRL_STATS_SE);
-	writeq(val64, &bar0->swapper_ctrl);
-#else
-	/* 
-	 * Initially we enable all bits to make it accessible by 
-	 * the driver, then we selectively enable only those bits 
-	 * that we want to set.
-	 */
-	writeq(0xffffffffffffffffULL, &bar0->swapper_ctrl);
-	val64 = (SWAPPER_CTRL_PIF_R_FE |
-		 SWAPPER_CTRL_PIF_R_SE |
-		 SWAPPER_CTRL_PIF_W_FE |
-		 SWAPPER_CTRL_PIF_W_SE |
-		 SWAPPER_CTRL_TXP_FE |
-		 SWAPPER_CTRL_TXP_SE |
-		 SWAPPER_CTRL_TXD_R_FE |
-		 SWAPPER_CTRL_TXD_R_SE |
-		 SWAPPER_CTRL_TXD_W_FE |
-		 SWAPPER_CTRL_TXD_W_SE |
-		 SWAPPER_CTRL_TXF_R_FE |
-		 SWAPPER_CTRL_RXD_R_FE |
-		 SWAPPER_CTRL_RXD_R_SE |
-		 SWAPPER_CTRL_RXD_W_FE |
-		 SWAPPER_CTRL_RXD_W_SE |
-		 SWAPPER_CTRL_RXF_W_FE |
-		 SWAPPER_CTRL_XMSI_FE |
-		 SWAPPER_CTRL_XMSI_SE |
-		 SWAPPER_CTRL_STATS_FE | SWAPPER_CTRL_STATS_SE);
-	writeq(val64, &bar0->swapper_ctrl);
-#endif
-
-	/* 
-	 * Verifying if endian settings are accurate by 
-	 * reading a feedback register.
-	 */
-	val64 = readq(&bar0->pif_rd_swapper_fb);
-	if (val64 != 0x0123456789ABCDEFULL) {
-		/* Endian settings are incorrect, calls for another dekko. */
-		print_var = (unsigned long long) val64;
-		DBG_PRINT(INIT_DBG, "%s: Endian settings are wrong",
-			  dev->name);
-		DBG_PRINT(ERR_DBG, ", feedback read %llx\n", print_var);
-
-		return FAILURE;
+	/* Initialize swapper control register */
+	if (s2io_set_swapper(nic)) {
+		DBG_PRINT(ERR_DBG,"ERROR: Setting Swapper failed\n");
+		return -1;
 	}
 
 	/* Remove XGXS from reset state */
@@ -920,11 +860,15 @@
 	 * Initializing the Transmit and Receive Traffic Interrupt 
 	 * Scheme.
 	 */
-	/* TTI Initialization */
-	val64 = TTI_DATA1_MEM_TX_TIMER_VAL(0xFFF) |
+	/* TTI Initialization. Default Tx timer gets us about
+	 * 250 interrupts per sec. Continuous interrupts are enabled
+	 * by default.
+	 */
+	val64 = TTI_DATA1_MEM_TX_TIMER_VAL(0x2078) |
 	    TTI_DATA1_MEM_TX_URNG_A(0xA) |
 	    TTI_DATA1_MEM_TX_URNG_B(0x10) |
-	    TTI_DATA1_MEM_TX_URNG_C(0x30) | TTI_DATA1_MEM_TX_TIMER_AC_EN;
+	    TTI_DATA1_MEM_TX_URNG_C(0x30) | TTI_DATA1_MEM_TX_TIMER_AC_EN |
+		TTI_DATA1_MEM_TX_TIMER_CI_EN;
 	writeq(val64, &bar0->tti_data1_mem);
 
 	val64 = TTI_DATA2_MEM_TX_UFC_A(0x10) |
@@ -2508,23 +2452,74 @@
 {
 	struct net_device *dev = sp->dev;
 	XENA_dev_config_t __iomem *bar0 = sp->bar0;
-	u64 val64;
+	u64 val64, valt, valr;
 
 	/* 
 	 * Set proper endian settings and verify the same by reading
 	 * the PIF Feed-back register.
 	 */
+
+	val64 = readq(&bar0->pif_rd_swapper_fb);
+	if (val64 != 0x0123456789ABCDEFULL) {
+		int i = 0;
+		u64 value[] = { 0xC30000C3C30000C3ULL,   /* FE=1, SE=1 */
+				0x8100008181000081ULL,  /* FE=1, SE=0 */
+				0x4200004242000042ULL,  /* FE=0, SE=1 */
+				0};                     /* FE=0, SE=0 */
+
+		while(i<4) {
+			writeq(value[i], &bar0->swapper_ctrl);
+			val64 = readq(&bar0->pif_rd_swapper_fb);
+			if (val64 == 0x0123456789ABCDEFULL)
+				break;
+			i++;
+		}
+		if (i == 4) {
+			DBG_PRINT(ERR_DBG, "%s: Endian settings are wrong, ",
+				dev->name);
+			DBG_PRINT(ERR_DBG, "feedback read %llx\n",
+				(unsigned long long) val64);
+			return FAILURE;
+		}
+		valr = value[i];
+	} else {
+		valr = readq(&bar0->swapper_ctrl);
+	}
+
+	valt = 0x0123456789ABCDEFULL;
+	writeq(valt, &bar0->xmsi_address);
+	val64 = readq(&bar0->xmsi_address);
+
+	if(val64 != valt) {
+		int i = 0;
+		u64 value[] = { 0x00C3C30000C3C300ULL,  /* FE=1, SE=1 */
+				0x0081810000818100ULL,  /* FE=1, SE=0 */
+				0x0042420000424200ULL,  /* FE=0, SE=1 */
+				0};                     /* FE=0, SE=0 */
+
+		while(i<4) {
+			writeq((value[i] | valr), &bar0->swapper_ctrl);
+			writeq(valt, &bar0->xmsi_address);
+			val64 = readq(&bar0->xmsi_address);
+			if(val64 == valt)
+				break;
+			i++;
+		}
+		if(i == 4) {
+			DBG_PRINT(ERR_DBG, "Write failed, Xmsi_addr ");
+			DBG_PRINT(ERR_DBG, "reads:0x%llx\n",val64);
+			return FAILURE;
+		}
+	}
+	val64 = readq(&bar0->swapper_ctrl);
+	val64 &= 0xFFFF000000000000ULL;
+
 #ifdef  __BIG_ENDIAN
 	/* 
 	 * The device by default set to a big endian format, so a 
 	 * big endian driver need not set anything.
 	 */
-	writeq(0xffffffffffffffffULL, &bar0->swapper_ctrl);
-	val64 = (SWAPPER_CTRL_PIF_R_FE |
-		 SWAPPER_CTRL_PIF_R_SE |
-		 SWAPPER_CTRL_PIF_W_FE |
-		 SWAPPER_CTRL_PIF_W_SE |
-		 SWAPPER_CTRL_TXP_FE |
+	val64 |= (SWAPPER_CTRL_TXP_FE |
 		 SWAPPER_CTRL_TXP_SE |
 		 SWAPPER_CTRL_TXD_R_FE |
 		 SWAPPER_CTRL_TXD_W_FE |
@@ -2542,12 +2537,7 @@
 	 * driver, then we selectively enable only those bits that 
 	 * we want to set.
 	 */
-	writeq(0xffffffffffffffffULL, &bar0->swapper_ctrl);
-	val64 = (SWAPPER_CTRL_PIF_R_FE |
-		 SWAPPER_CTRL_PIF_R_SE |
-		 SWAPPER_CTRL_PIF_W_FE |
-		 SWAPPER_CTRL_PIF_W_SE |
-		 SWAPPER_CTRL_TXP_FE |
+	val64 |= (SWAPPER_CTRL_TXP_FE |
 		 SWAPPER_CTRL_TXP_SE |
 		 SWAPPER_CTRL_TXD_R_FE |
 		 SWAPPER_CTRL_TXD_R_SE |
@@ -2564,6 +2554,7 @@
 		 SWAPPER_CTRL_STATS_FE | SWAPPER_CTRL_STATS_SE);
 	writeq(val64, &bar0->swapper_ctrl);
 #endif
+	val64 = readq(&bar0->swapper_ctrl);
 
 	/* 
 	 * Verifying if endian settings are accurate by reading a 
@@ -3920,45 +3911,45 @@
 	nic_t *sp = dev->priv;
 	StatInfo_t *stat_info = sp->mac_control.stats_info;
 
-	tmp_stats[i++] = stat_info->tmac_frms;
-	tmp_stats[i++] = stat_info->tmac_data_octets;
-	tmp_stats[i++] = stat_info->tmac_drop_frms;
-	tmp_stats[i++] = stat_info->tmac_mcst_frms;
-	tmp_stats[i++] = stat_info->tmac_bcst_frms;
-	tmp_stats[i++] = stat_info->tmac_pause_ctrl_frms;
-	tmp_stats[i++] = stat_info->tmac_any_err_frms;
-	tmp_stats[i++] = stat_info->tmac_vld_ip_octets;
-	tmp_stats[i++] = stat_info->tmac_vld_ip;
-	tmp_stats[i++] = stat_info->tmac_drop_ip;
-	tmp_stats[i++] = stat_info->tmac_icmp;
-	tmp_stats[i++] = stat_info->tmac_rst_tcp;
-	tmp_stats[i++] = stat_info->tmac_tcp;
-	tmp_stats[i++] = stat_info->tmac_udp;
-	tmp_stats[i++] = stat_info->rmac_vld_frms;
-	tmp_stats[i++] = stat_info->rmac_data_octets;
-	tmp_stats[i++] = stat_info->rmac_fcs_err_frms;
-	tmp_stats[i++] = stat_info->rmac_drop_frms;
-	tmp_stats[i++] = stat_info->rmac_vld_mcst_frms;
-	tmp_stats[i++] = stat_info->rmac_vld_bcst_frms;
-	tmp_stats[i++] = stat_info->rmac_in_rng_len_err_frms;
-	tmp_stats[i++] = stat_info->rmac_long_frms;
-	tmp_stats[i++] = stat_info->rmac_pause_ctrl_frms;
-	tmp_stats[i++] = stat_info->rmac_discarded_frms;
-	tmp_stats[i++] = stat_info->rmac_usized_frms;
-	tmp_stats[i++] = stat_info->rmac_osized_frms;
-	tmp_stats[i++] = stat_info->rmac_frag_frms;
-	tmp_stats[i++] = stat_info->rmac_jabber_frms;
-	tmp_stats[i++] = stat_info->rmac_ip;
-	tmp_stats[i++] = stat_info->rmac_ip_octets;
-	tmp_stats[i++] = stat_info->rmac_hdr_err_ip;
-	tmp_stats[i++] = stat_info->rmac_drop_ip;
-	tmp_stats[i++] = stat_info->rmac_icmp;
-	tmp_stats[i++] = stat_info->rmac_tcp;
-	tmp_stats[i++] = stat_info->rmac_udp;
-	tmp_stats[i++] = stat_info->rmac_err_drp_udp;
-	tmp_stats[i++] = stat_info->rmac_pause_cnt;
-	tmp_stats[i++] = stat_info->rmac_accepted_ip;
-	tmp_stats[i++] = stat_info->rmac_err_tcp;
+	tmp_stats[i++] = le32_to_cpu(stat_info->tmac_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->tmac_data_octets);
+	tmp_stats[i++] = le64_to_cpu(stat_info->tmac_drop_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->tmac_mcst_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->tmac_bcst_frms);
+	tmp_stats[i++] = le64_to_cpu(stat_info->tmac_pause_ctrl_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->tmac_any_err_frms);
+	tmp_stats[i++] = le64_to_cpu(stat_info->tmac_vld_ip_octets);
+	tmp_stats[i++] = le32_to_cpu(stat_info->tmac_vld_ip);
+	tmp_stats[i++] = le32_to_cpu(stat_info->tmac_drop_ip);
+	tmp_stats[i++] = le32_to_cpu(stat_info->tmac_icmp);
+	tmp_stats[i++] = le32_to_cpu(stat_info->tmac_rst_tcp);
+	tmp_stats[i++] = le64_to_cpu(stat_info->tmac_tcp);
+	tmp_stats[i++] = le32_to_cpu(stat_info->tmac_udp);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_vld_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_data_octets);
+	tmp_stats[i++] = le64_to_cpu(stat_info->rmac_fcs_err_frms);
+	tmp_stats[i++] = le64_to_cpu(stat_info->rmac_drop_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_vld_mcst_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_vld_bcst_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_in_rng_len_err_frms);
+	tmp_stats[i++] = le64_to_cpu(stat_info->rmac_long_frms);
+	tmp_stats[i++] = le64_to_cpu(stat_info->rmac_pause_ctrl_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_discarded_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_usized_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_osized_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_frag_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_jabber_frms);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_ip);
+	tmp_stats[i++] = le64_to_cpu(stat_info->rmac_ip_octets);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_hdr_err_ip);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_drop_ip);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_icmp);
+	tmp_stats[i++] = le64_to_cpu(stat_info->rmac_tcp);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_udp);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_err_drp_udp);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_pause_cnt);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_accepted_ip);
+	tmp_stats[i++] = le32_to_cpu(stat_info->rmac_err_tcp);
 }
 
 static int s2io_ethtool_get_regs_len(struct net_device *dev)
@@ -4547,7 +4538,7 @@
 			     &(sp->pcix_cmd));
 }
 
-MODULE_AUTHOR("Raghavendra Koushik <raghavendra.koushik@s2io.com>");
+MODULE_AUTHOR("Raghavendra Koushik <raghavendra.koushik@neterion.com>");
 MODULE_LICENSE("GPL");
 module_param(tx_fifo_num, int, 0);
 module_param_array(tx_fifo_len, int, NULL, 0);
diff -Nru a/drivers/net/s2io.h b/drivers/net/s2io.h
--- a/drivers/net/s2io.h	2005-03-30 20:58:14 -05:00
+++ b/drivers/net/s2io.h	2005-03-30 20:58:14 -05:00
@@ -1,6 +1,6 @@
 /************************************************************************
  * s2io.h: A Linux PCI-X Ethernet driver for S2IO 10GbE Server NIC
- * Copyright 2002 Raghavendra Koushik (raghavendra.koushik@s2io.com)
+ * Copyright(c) 2002-2005 Neterion Inc.
 
  * This software may be used and distributed according to the terms of
  * the GNU General Public License (GPL), incorporated herein by reference.
@@ -73,121 +73,6 @@
 
 /* The statistics block of Xena */
 typedef struct stat_block {
-#ifdef  __BIG_ENDIAN
-/* Tx MAC statistics counters. */
-	u32 tmac_frms;
-	u32 tmac_data_octets;
-	u64 tmac_drop_frms;
-	u32 tmac_mcst_frms;
-	u32 tmac_bcst_frms;
-	u64 tmac_pause_ctrl_frms;
-	u32 tmac_ttl_octets;
-	u32 tmac_ucst_frms;
-	u32 tmac_nucst_frms;
-	u32 tmac_any_err_frms;
-	u64 tmac_ttl_less_fb_octets;
-	u64 tmac_vld_ip_octets;
-	u32 tmac_vld_ip;
-	u32 tmac_drop_ip;
-	u32 tmac_icmp;
-	u32 tmac_rst_tcp;
-	u64 tmac_tcp;
-	u32 tmac_udp;
-	u32 reserved_0;
-
-/* Rx MAC Statistics counters. */
-	u32 rmac_vld_frms;
-	u32 rmac_data_octets;
-	u64 rmac_fcs_err_frms;
-	u64 rmac_drop_frms;
-	u32 rmac_vld_mcst_frms;
-	u32 rmac_vld_bcst_frms;
-	u32 rmac_in_rng_len_err_frms;
-	u32 rmac_out_rng_len_err_frms;
-	u64 rmac_long_frms;
-	u64 rmac_pause_ctrl_frms;
-	u64 rmac_unsup_ctrl_frms;
-	u32 rmac_ttl_octets;
-	u32 rmac_accepted_ucst_frms;
-	u32 rmac_accepted_nucst_frms;
-	u32 rmac_discarded_frms;
-	u32 rmac_drop_events;
-	u32 reserved_1;
-	u64 rmac_ttl_less_fb_octets;
-	u64 rmac_ttl_frms;
-	u64 reserved_2;
-	u32 reserved_3;
-	u32 rmac_usized_frms;
-	u32 rmac_osized_frms;
-	u32 rmac_frag_frms;
-	u32 rmac_jabber_frms;
-	u32 reserved_4;
-	u64 rmac_ttl_64_frms;
-	u64 rmac_ttl_65_127_frms;
-	u64 reserved_5;
-	u64 rmac_ttl_128_255_frms;
-	u64 rmac_ttl_256_511_frms;
-	u64 reserved_6;
-	u64 rmac_ttl_512_1023_frms;
-	u64 rmac_ttl_1024_1518_frms;
-	u32 reserved_7;
-	u32 rmac_ip;
-	u64 rmac_ip_octets;
-	u32 rmac_hdr_err_ip;
-	u32 rmac_drop_ip;
-	u32 rmac_icmp;
-	u32 reserved_8;
-	u64 rmac_tcp;
-	u32 rmac_udp;
-	u32 rmac_err_drp_udp;
-	u64 rmac_xgmii_err_sym;
-	u64 rmac_frms_q0;
-	u64 rmac_frms_q1;
-	u64 rmac_frms_q2;
-	u64 rmac_frms_q3;
-	u64 rmac_frms_q4;
-	u64 rmac_frms_q5;
-	u64 rmac_frms_q6;
-	u64 rmac_frms_q7;
-	u16 rmac_full_q0;
-	u16 rmac_full_q1;
-	u16 rmac_full_q2;
-	u16 rmac_full_q3;
-	u16 rmac_full_q4;
-	u16 rmac_full_q5;
-	u16 rmac_full_q6;
-	u16 rmac_full_q7;
-	u32 rmac_pause_cnt;
-	u32 reserved_9;
-	u64 rmac_xgmii_data_err_cnt;
-	u64 rmac_xgmii_ctrl_err_cnt;
-	u32 rmac_accepted_ip;
-	u32 rmac_err_tcp;
-
-/* PCI/PCI-X Read transaction statistics. */
-	u32 rd_req_cnt;
-	u32 new_rd_req_cnt;
-	u32 new_rd_req_rtry_cnt;
-	u32 rd_rtry_cnt;
-	u32 wr_rtry_rd_ack_cnt;
-
-/* PCI/PCI-X write transaction statistics. */
-	u32 wr_req_cnt;
-	u32 new_wr_req_cnt;
-	u32 new_wr_req_rtry_cnt;
-	u32 wr_rtry_cnt;
-	u32 wr_disc_cnt;
-	u32 rd_rtry_wr_ack_cnt;
-
-/*	DMA Transaction statistics. */
-	u32 txp_wr_cnt;
-	u32 txd_rd_cnt;
-	u32 txd_wr_cnt;
-	u32 rxd_rd_cnt;
-	u32 rxd_wr_cnt;
-	u32 txf_rd_cnt;
-	u32 rxf_wr_cnt;
-#else
 /* Tx MAC statistics counters. */
 	u32 tmac_data_octets;
 	u32 tmac_frms;
@@ -301,7 +186,6 @@
 	u32 rxd_rd_cnt;
 	u32 rxf_wr_cnt;
 	u32 txf_rd_cnt;
-#endif
 } StatInfo_t;
 
 /* Structures representing different init time configuration
@@ -869,6 +753,7 @@
 static int verify_xena_quiescence(u64 val64, int flag);
 static struct ethtool_ops netdev_ethtool_ops;
 static void s2io_set_link(unsigned long data);
+static int s2io_set_swapper(nic_t * sp);
 static void s2io_card_down(nic_t * nic);
 static int s2io_card_up(nic_t * nic);
 
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-03-30 20:58:14 -05:00
+++ b/include/linux/pci_ids.h	2005-03-30 20:58:14 -05:00
@@ -2159,6 +2159,8 @@
 #define PCI_VENDOR_ID_S2IO		0x17d5
 #define	PCI_DEVICE_ID_S2IO_WIN		0x5731
 #define	PCI_DEVICE_ID_S2IO_UNI		0x5831
+#define PCI_DEVICE_ID_HERC_WIN		0x5732
+#define PCI_DEVICE_ID_HERC_UNI		0x5832
 
 #define PCI_VENDOR_ID_INFINICON		0x1820
 

--------------040205050900060205050307--
