Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310325AbSCAKma>; Fri, 1 Mar 2002 05:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310370AbSCAKkd>; Fri, 1 Mar 2002 05:40:33 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:16848 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310434AbSCAKjA>; Fri, 1 Mar 2002 05:39:00 -0500
Date: Fri, 1 Mar 2002 12:24:54 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 3c509 Power Management (take 2)
In-Reply-To: <Pine.LNX.4.44.0203010826180.26745-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0203011222010.31530-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Device activation order was a bit wrong.

	Zwane

--- linux-2.4-test/drivers/net/3c509.c.orig	Fri Mar  1 08:21:29 2002
+++ linux-2.4-test/drivers/net/3c509.c	Fri Mar  1 12:21:36 2002
@@ -45,11 +45,13 @@
 			- Reviewed against 1.18 from scyld.com
 		v1.18a 17Nov2001 Jeff Garzik <jgarzik@mandrakesoft.com>
 			- ethtool support
+		v1.18b 1Mar2002 Zwane Mwaikambo <zwane@commfireservices.com>
+			- Power Management support
 */
 
 #define DRV_NAME	"3c509"
-#define DRV_VERSION	"1.18a"
-#define DRV_RELDATE	"17Nov2001"
+#define DRV_VERSION	"1.18b"
+#define DRV_RELDATE	"1Mar2002"
 
 /* A few values that may be tweaked. */
 
@@ -82,8 +84,9 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <linux/pm.h>
 
-static char versionA[] __initdata = DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE "becker@scyld.com\n";
+static char versionA[] __initdata = DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE " becker@scyld.com\n";
 static char versionB[] __initdata = "http://www.scyld.com/network/3c509.html\n";
 
 #ifdef EL3_DEBUG
@@ -116,7 +119,8 @@
 	FakeIntr = 12<<11, AckIntr = 13<<11, SetIntrEnb = 14<<11,
 	SetStatusEnb = 15<<11, SetRxFilter = 16<<11, SetRxThreshold = 17<<11,
 	SetTxThreshold = 18<<11, SetTxStart = 19<<11, StatsEnable = 21<<11,
-	StatsDisable = 22<<11, StopCoax = 23<<11,};
+	StatsDisable = 22<<11, StopCoax = 23<<11, PowerUp = 27<<11,
+	PowerDown = 28<<11, PowerAuto = 29<<11};
 
 enum c509status {
 	IntLatch = 0x0001, AdapterFailure = 0x0002, TxComplete = 0x0004,
@@ -152,6 +156,9 @@
 	int head, size;
 	struct sk_buff *queue[SKB_QUEUE_SIZE];
 	char mca_slot;
+#ifdef CONFIG_PM
+	struct pm_dev *pmdev;
+#endif
 };
 static int id_port __initdata = 0x110;	/* Start with 0x110 to avoid new sound cards.*/
 static struct net_device *el3_root_dev;
@@ -168,6 +175,13 @@
 static void set_multicast_list(struct net_device *dev);
 static void el3_tx_timeout (struct net_device *dev);
 static int netdev_ioctl (struct net_device *dev, struct ifreq *rq, int cmd);
+static void el3_down(struct net_device *dev);
+static void el3_up(struct net_device *dev);
+#ifdef CONFIG_PM
+static int el3_suspend(struct pm_dev *pdev);
+static int el3_resume(struct pm_dev *pdev);
+static int el3_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data);
+#endif
 
 #ifdef CONFIG_MCA
 struct el3_mca_adapters_struct {
@@ -219,7 +233,7 @@
 #endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 static int nopnp;
 
-int __init el3_probe(struct net_device *dev)
+int __init el3_probe(struct net_device *dev, int card_idx)
 {
 	struct el3_private *lp;
 	short lrs_state = 0xff, i;
@@ -525,6 +539,16 @@
 	dev->watchdog_timeo = TX_TIMEOUT;
 	dev->do_ioctl = netdev_ioctl;
 
+#ifdef CONFIG_PM
+	/* register power management */
+	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
+	if (lp->pmdev) {
+		struct pm_dev *p;
+		p = lp->pmdev;
+		p->data = (struct net_device *)dev;
+	}
+#endif
+
 	/* Fill in the generic fields of the device structure. */
 	ether_setup(dev);
 	return 0;
@@ -581,53 +605,7 @@
 		printk("%s: Opening, IRQ %d	 status@%x %4.4x.\n", dev->name,
 			   dev->irq, ioaddr + EL3_STATUS, inw(ioaddr + EL3_STATUS));
 
-	/* Activate board: this is probably unnecessary. */
-	outw(0x0001, ioaddr + 4);
-
-	/* Set the IRQ line. */
-	outw((dev->irq << 12) | 0x0f00, ioaddr + WN0_IRQ);
-
-	/* Set the station address in window 2 each time opened. */
-	EL3WINDOW(2);
-
-	for (i = 0; i < 6; i++)
-		outb(dev->dev_addr[i], ioaddr + i);
-
-	if (dev->if_port == 3)
-		/* Start the thinnet transceiver. We should really wait 50ms...*/
-		outw(StartCoax, ioaddr + EL3_CMD);
-	else if (dev->if_port == 0) {
-		/* 10baseT interface, enabled link beat and jabber check. */
-		EL3WINDOW(4);
-		outw(inw(ioaddr + WN4_MEDIA) | MEDIA_TP, ioaddr + WN4_MEDIA);
-	}
-
-	/* Switch to the stats window, and clear all stats by reading. */
-	outw(StatsDisable, ioaddr + EL3_CMD);
-	EL3WINDOW(6);
-	for (i = 0; i < 9; i++)
-		inb(ioaddr + i);
-	inw(ioaddr + 10);
-	inw(ioaddr + 12);
-
-	/* Switch to register set 1 for normal use. */
-	EL3WINDOW(1);
-
-	/* Accept b-case and phys addr only. */
-	outw(SetRxFilter | RxStation | RxBroadcast, ioaddr + EL3_CMD);
-	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
-
-	netif_start_queue(dev);
-
-	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
-	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
-	/* Allow status bits to be seen. */
-	outw(SetStatusEnb | 0xff, ioaddr + EL3_CMD);
-	/* Ack all pending events, and set active indicator mask. */
-	outw(AckIntr | IntLatch | TxAvailable | RxEarly | IntReq,
-		 ioaddr + EL3_CMD);
-	outw(SetIntrEnb | IntLatch|TxAvailable|TxComplete|RxComplete|StatsFull,
-		 ioaddr + EL3_CMD);
+	el3_up(dev);
 
 	if (el3_debug > 3)
 		printk("%s: Opened 3c509  IRQ %d  status %4.4x.\n",
@@ -986,23 +964,7 @@
 	if (el3_debug > 2)
 		printk("%s: Shutting down ethercard.\n", dev->name);
 
-	netif_stop_queue(dev);
-
-	/* Turn off statistics ASAP.  We update lp->stats below. */
-	outw(StatsDisable, ioaddr + EL3_CMD);
-
-	/* Disable the receiver and transmitter. */
-	outw(RxDisable, ioaddr + EL3_CMD);
-	outw(TxDisable, ioaddr + EL3_CMD);
-
-	if (dev->if_port == 3)
-		/* Turn off thinnet power.  Green! */
-		outw(StopCoax, ioaddr + EL3_CMD);
-	else if (dev->if_port == 0) {
-		/* Disable link beat and jabber, if_port may change ere next open(). */
-		EL3WINDOW(4);
-		outw(inw(ioaddr + WN4_MEDIA) & ~MEDIA_TP, ioaddr + WN4_MEDIA);
-	}
+	el3_down(dev);
 
 	free_irq(dev->irq, dev);
 	/* Switching back to window 0 disables the IRQ. */
@@ -1010,7 +972,6 @@
 	/* But we explicitly zero the IRQ line select anyway. */
 	outw(0x0f00, ioaddr + WN0_IRQ);
 
-	update_stats(dev);
 	return 0;
 }
 
@@ -1092,7 +1053,157 @@
 
 	return rc;
 }
- 
+
+static void el3_down(struct net_device *dev)
+{
+	int ioaddr = dev->base_addr;
+
+	netif_stop_queue(dev);
+
+	/* Turn off statistics ASAP.  We update lp->stats below. */
+	outw(StatsDisable, ioaddr + EL3_CMD);
+
+	/* Disable the receiver and transmitter. */
+	outw(RxDisable, ioaddr + EL3_CMD);
+	outw(TxDisable, ioaddr + EL3_CMD);
+
+	if (dev->if_port == 3)
+		/* Turn off thinnet power.  Green! */
+		outw(StopCoax, ioaddr + EL3_CMD);
+	else if (dev->if_port == 0) {
+		/* Disable link beat and jabber, if_port may change ere next open(). */
+		EL3WINDOW(4);
+		outw(inw(ioaddr + WN4_MEDIA) & ~MEDIA_TP, ioaddr + WN4_MEDIA);
+	}
+
+	outw(SetIntrEnb | 0x0000, ioaddr + EL3_CMD);
+
+	update_stats(dev);
+}
+
+static void el3_up(struct net_device *dev)
+{
+	int i;
+	int ioaddr = dev->base_addr;
+	
+	/* Activating the board required and does no harm otherwise */
+	outw(0x0001, ioaddr + 4);
+
+	/* Set the IRQ line. */
+	outw((dev->irq << 12) | 0x0f00, ioaddr + WN0_IRQ);
+
+	/* Set the station address in window 2 each time opened. */
+	EL3WINDOW(2);
+
+	for (i = 0; i < 6; i++)
+		outb(dev->dev_addr[i], ioaddr + i);
+
+	if (dev->if_port == 3)
+		/* Start the thinnet transceiver. We should really wait 50ms...*/
+		outw(StartCoax, ioaddr + EL3_CMD);
+	else if (dev->if_port == 0) {
+		/* 10baseT interface, enabled link beat and jabber check. */
+		EL3WINDOW(4);
+		outw(inw(ioaddr + WN4_MEDIA) | MEDIA_TP, ioaddr + WN4_MEDIA);
+	}
+
+	/* Switch to the stats window, and clear all stats by reading. */
+	outw(StatsDisable, ioaddr + EL3_CMD);
+	EL3WINDOW(6);
+	for (i = 0; i < 9; i++)
+		inb(ioaddr + i);
+	inw(ioaddr + 10);
+	inw(ioaddr + 12);
+
+	/* Switch to register set 1 for normal use. */
+	EL3WINDOW(1);
+
+	/* Accept b-case and phys addr only. */
+	outw(SetRxFilter | RxStation | RxBroadcast, ioaddr + EL3_CMD);
+	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
+
+	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
+	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
+	/* Allow status bits to be seen. */
+	outw(SetStatusEnb | 0xff, ioaddr + EL3_CMD);
+	/* Ack all pending events, and set active indicator mask. */
+	outw(AckIntr | IntLatch | TxAvailable | RxEarly | IntReq,
+		 ioaddr + EL3_CMD);
+	outw(SetIntrEnb | IntLatch|TxAvailable|TxComplete|RxComplete|StatsFull,
+		 ioaddr + EL3_CMD);
+
+	netif_start_queue(dev);
+}
+
+/* Power Management support functions */
+#ifdef CONFIG_PM
+
+static int el3_suspend(struct pm_dev *pdev)
+{
+	unsigned long flags;
+	struct net_device *dev;
+	struct el3_private *lp;
+	int ioaddr;
+	
+	if (!pdev && !pdev->data)
+		return -EINVAL;
+
+	dev = (struct net_device *)pdev->data;
+	lp = (struct el3_private *)dev->priv;
+	ioaddr = dev->base_addr;
+
+	spin_lock_irqsave(&lp->lock, flags);
+
+	if (netif_running(dev))
+		netif_device_detach(dev);
+
+	el3_down(dev);
+	outw(PowerDown, ioaddr + EL3_CMD);
+
+	spin_unlock_irqrestore(&lp->lock, flags);
+	return 0;
+}
+
+static int el3_resume(struct pm_dev *pdev)
+{
+	unsigned long flags;
+	struct net_device *dev;
+	struct el3_private *lp;
+	int ioaddr;
+	
+	if (!pdev && !pdev->data)
+		return -EINVAL;
+
+	dev = (struct net_device *)pdev->data;
+	lp = (struct el3_private *)dev->priv;
+	ioaddr = dev->base_addr;
+
+	spin_lock_irqsave(&lp->lock, flags);
+
+	outw(PowerUp, ioaddr + EL3_CMD);
+	el3_up(dev);
+
+	if (netif_running(dev))
+		netif_device_attach(dev);
+		
+	spin_unlock_irqrestore(&lp->lock, flags);
+	return 0;
+}
+
+static int el3_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data)
+{
+	switch (rqst) {
+		case PM_SUSPEND:
+			return el3_suspend(pdev);
+
+		case PM_RESUME:
+			return el3_resume(pdev);
+	}
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 #ifdef MODULE
 /* Parameters that may be passed into the module. */
 static int debug = -1;
@@ -1121,7 +1232,7 @@
 		el3_debug = debug;
 
 	el3_root_dev = NULL;
-	while (el3_probe(0) == 0) {
+	while (el3_probe(0, el3_cards) == 0) {
 		if (irq[el3_cards] > 1)
 			el3_root_dev->irq = irq[el3_cards];
 		if (xcvr[el3_cards] >= 0)
@@ -1143,7 +1254,12 @@
 #ifdef CONFIG_MCA		
 		if(lp->mca_slot!=-1)
 			mca_mark_as_unused(lp->mca_slot);
-#endif			
+#endif
+
+#ifdef CONFIG_PM
+		if (lp->pmdev)
+			pm_unregister(lp->pmdev);
+#endif
 		next_dev = lp->next_dev;
 		unregister_netdev(el3_root_dev);
 		release_region(el3_root_dev->base_addr, EL3_IO_EXTENT);

