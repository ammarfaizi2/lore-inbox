Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTEBGI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 02:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTEBGID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 02:08:03 -0400
Received: from dp.samba.org ([66.70.73.150]:60066 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261844AbTEBGGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 02:06:35 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16050.1862.939337.334619@argo.ozlabs.ibm.com>
Date: Fri, 2 May 2003 15:51:02 +1000
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Update mac ethernet drivers
X-Mailer: VM 7.14 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the bmac and mace ethernet drivers so that their
interrupt routines return an irqreturn_t, and updates the bmac driver
to use a spinlock rather than global cli/sti.

Jeff, please send this on Linus.

Thanks,
Paul.

diff -urN linux-2.5/drivers/net/bmac.c pmac-2.5/drivers/net/bmac.c
--- linux-2.5/drivers/net/bmac.c	2003-02-14 17:18:41.000000000 +1100
+++ pmac-2.5/drivers/net/bmac.c	2003-04-23 22:03:30.000000000 +1000
@@ -17,6 +17,7 @@
 #include <linux/timer.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include <linux/crc32.h>
 #include <asm/prom.h>
 #include <asm/dbdma.h>
@@ -82,6 +83,7 @@
 	int opened;
 	unsigned short hash_use_count[64];
 	unsigned short hash_table_mask[4];
+	spinlock_t lock;
 	struct net_device *next_bmac;
 };
 
@@ -159,9 +161,9 @@
 static void bmac_init_registers(struct net_device *dev);
 static void bmac_enable_and_reset_chip(struct net_device *dev);
 static int bmac_set_address(struct net_device *dev, void *addr);
-static void bmac_misc_intr(int irq, void *dev_id, struct pt_regs *regs);
-static void bmac_txdma_intr(int irq, void *dev_id, struct pt_regs *regs);
-static void bmac_rxdma_intr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t bmac_misc_intr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t bmac_txdma_intr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t bmac_rxdma_intr(int irq, void *dev_id, struct pt_regs *regs);
 static void bmac_set_timeout(struct net_device *dev);
 static void bmac_tx_timeout(unsigned long data);
 static int bmac_proc_info ( char *buffer, char **start, off_t offset, int length);
@@ -485,7 +487,7 @@
 	case PBOOK_SLEEP_NOW:
 		netif_device_detach(dev);
 		/* prolly should wait for dma to finish & turn off the chip */
-		save_flags(flags); cli();
+		spin_lock_irqsave(&bp->lock, flags);
 		if (bp->timeout_active) {
 			del_timer(&bp->tx_timeout);
 			bp->timeout_active = 0;
@@ -494,7 +496,7 @@
 		disable_irq(bp->tx_dma_intr);
 		disable_irq(bp->rx_dma_intr);
 		bp->sleeping = 1;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&bp->lock, flags);
 		if (bp->opened) {
 			volatile struct dbdma_regs *rd = bp->rx_dma;
 			volatile struct dbdma_regs *td = bp->tx_dma;
@@ -539,13 +541,14 @@
 
 static int bmac_set_address(struct net_device *dev, void *addr)
 {
+	struct bmac_data *bp = (struct bmac_data *) dev->priv;
 	unsigned char *p = addr;
 	unsigned short *pWord16;
 	unsigned long flags;
 	int i;
 
 	XXDEBUG(("bmac: enter set_address\n"));
-	save_flags(flags); cli();
+	spin_lock_irqsave(&bp->lock, flags);
 
 	for (i = 0; i < 6; ++i) {
 		dev->dev_addr[i] = p[i];
@@ -556,7 +559,7 @@
 	bmwrite(dev, MADD1, *pWord16++);
 	bmwrite(dev, MADD2, *pWord16);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
 	XXDEBUG(("bmac: exit set_address\n"));
 	return 0;
 }
@@ -566,8 +569,7 @@
 	struct bmac_data *bp = (struct bmac_data *) dev->priv;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&bp->lock, flags);
 	if (bp->timeout_active)
 		del_timer(&bp->tx_timeout);
 	bp->tx_timeout.expires = jiffies + TX_TIMEOUT;
@@ -575,7 +577,7 @@
 	bp->tx_timeout.data = (unsigned long) dev;
 	add_timer(&bp->tx_timeout);
 	bp->timeout_active = 1;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
 static void
@@ -703,7 +705,7 @@
 
 static int rxintcount;
 
-static void bmac_rxdma_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t bmac_rxdma_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct bmac_data *bp = (struct bmac_data *) dev->priv;
@@ -715,7 +717,7 @@
 	int last;
 	unsigned long flags;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&bp->lock, flags);
 
 	if (++rxintcount < 10) {
 		XXDEBUG(("bmac_rxdma_intr\n"));
@@ -769,18 +771,18 @@
 		bp->rx_empty = i;
 	}
 
-	restore_flags(flags);
-
 	dbdma_continue(rd);
+	spin_unlock_irqrestore(&bp->lock, flags);
 
 	if (rxintcount < 10) {
 		XXDEBUG(("bmac_rxdma_intr done\n"));
 	}
+	return IRQ_HANDLED;
 }
 
 static int txintcount;
 
-static void bmac_txdma_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t bmac_txdma_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct bmac_data *bp = (struct bmac_data *) dev->priv;
@@ -788,7 +790,7 @@
 	int stat;
 	unsigned long flags;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&bp->lock, flags);
 
 	if (txintcount++ < 10) {
 		XXDEBUG(("bmac_txdma_intr\n"));
@@ -824,13 +826,14 @@
 			break;
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
 
 	if (txintcount < 10) {
 		XXDEBUG(("bmac_txdma_intr done->bmac_start\n"));
 	}
 
 	bmac_start(dev);
+	return IRQ_HANDLED;
 }
 
 static struct net_device_stats *bmac_stats(struct net_device *dev)
@@ -1096,7 +1099,7 @@
 
 static int miscintcount;
 
-static void bmac_misc_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t bmac_misc_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct bmac_data *bp = (struct bmac_data *)dev->priv;
@@ -1117,6 +1120,7 @@
 	if (status & TxErrorMask) bp->stats.tx_errors++;
 	if (status & TxUnderrun) bp->stats.tx_fifo_errors++;
 	if (status & TxNormalCollExp) bp->stats.collisions++;
+	return IRQ_HANDLED;
 }
 
 /*
@@ -1249,7 +1253,7 @@
 	struct sk_buff *skb;
 	unsigned char *data;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&bp->lock, flags);
 	bmac_enable_and_reset_chip(dev);
 	bmac_init_tx_ring(bp);
 	bmac_init_rx_ring(bp);
@@ -1270,7 +1274,7 @@
 		memcpy(data+6, dev->dev_addr, 6);
 		bmac_transmit_packet(skb, dev);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
 static int __init bmac_probe(void)
@@ -1336,6 +1340,7 @@
 	bp = (struct bmac_data *) dev->priv;
 	SET_MODULE_OWNER(dev);
 	bp->node = bmac;
+	spin_lock_init(&bp->lock);
 
 	if (!request_OF_resource(bmac, 0, " (bmac)")) {
 		printk(KERN_ERR "BMAC: can't request IO resource !\n");
@@ -1522,7 +1527,7 @@
 	if (bp->sleeping)
 		return;
 		
-	save_flags(flags); cli();
+	spin_lock_irqsave(&bp->lock, flags);
 	while (1) {
 		i = bp->tx_fill + 1;
 		if (i >= N_TX_RING)
@@ -1534,7 +1539,7 @@
 			break;
 		bmac_transmit_packet(skb, dev);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
 static int
@@ -1558,7 +1563,7 @@
 	int i;
 
 	XXDEBUG(("bmac: tx_timeout called\n"));
-	save_flags(flags); cli();
+	spin_lock_irqsave(&bp->lock, flags);
 	bp->timeout_active = 0;
 
 	/* update various counters */
@@ -1614,7 +1619,7 @@
 	oldConfig = bmread(dev, TXCFG);		
 	bmwrite(dev, TXCFG, oldConfig | TxMACEnable );
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
 #if 0
diff -urN linux-2.5/drivers/net/mace.c pmac-2.5/drivers/net/mace.c
--- linux-2.5/drivers/net/mace.c	2003-03-31 09:22:18.000000000 +1000
+++ pmac-2.5/drivers/net/mace.c	2003-04-24 08:42:58.000000000 +1000
@@ -86,9 +86,9 @@
 static void mace_set_multicast(struct net_device *dev);
 static void mace_reset(struct net_device *dev);
 static int mace_set_address(struct net_device *dev, void *addr);
-static void mace_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-static void mace_txdma_intr(int irq, void *dev_id, struct pt_regs *regs);
-static void mace_rxdma_intr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t mace_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t mace_txdma_intr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t mace_rxdma_intr(int irq, void *dev_id, struct pt_regs *regs);
 static void mace_set_timeout(struct net_device *dev);
 static void mace_tx_timeout(unsigned long data);
 static inline void dbdma_reset(volatile struct dbdma_regs *dma);
@@ -622,7 +622,7 @@
 	    printk(KERN_DEBUG "mace: jabbering transceiver\n");
 }
 
-static void mace_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mace_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
     struct net_device *dev = (struct net_device *) dev_id;
     struct mace_data *mp = (struct mace_data *) dev->priv;
@@ -765,6 +765,7 @@
 	mace_set_timeout(dev);
     }
     spin_unlock_irqrestore(&mp->lock, flags);
+    return IRQ_HANDLED;
 }
 
 static void mace_tx_timeout(unsigned long data)
@@ -833,11 +834,12 @@
     spin_unlock_irqrestore(&mp->lock, flags);
 }
 
-static void mace_txdma_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mace_txdma_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
+	return IRQ_HANDLED;
 }
 
-static void mace_rxdma_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mace_rxdma_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
     struct net_device *dev = (struct net_device *) dev_id;
     struct mace_data *mp = (struct mace_data *) dev->priv;
@@ -947,6 +949,7 @@
 	mp->rx_fill = i;
     }
     spin_unlock_irqrestore(&mp->lock, flags);
+    return IRQ_HANDLED;
 }
 
 MODULE_AUTHOR("Paul Mackerras");
