Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTDGXNR (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTDGXMA (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:12:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61824
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263826AbTDGXHQ (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:07:16 -0400
Date: Tue, 8 Apr 2003 01:26:10 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080026.h380QADL009125@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: first cut at 3c574_cs for SMP safety etc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The old code was totally hosed for SMP, the windowing makes this
stuff tricky so it may need more work

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/net/pcmcia/3c574_cs.c linux-2.5.67-ac1/drivers/net/pcmcia/3c574_cs.c
--- linux-2.5.67/drivers/net/pcmcia/3c574_cs.c	2003-02-10 18:38:03.000000000 +0000
+++ linux-2.5.67-ac1/drivers/net/pcmcia/3c574_cs.c	2003-04-07 19:33:22.000000000 +0100
@@ -3,6 +3,7 @@
 	Written 1993-1998 by
 	Donald Becker, becker@scyld.com, (driver core) and
 	David Hinds, dahinds@users.sourceforge.net (from his PC card code).
+	Locking fixes (C) Copyright 2003 Red Hat Inc
 
 	This software may be used and distributed according to the terms of
 	the GNU General Public License, incorporated herein by reference.
@@ -11,6 +12,7 @@
 	following copyright:
 	Copyright 1993 United States Government as represented by the
 	Director, National Security Agency.
+	
 
 */
 
@@ -125,7 +127,7 @@
 INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 static char *version =
-"3c574_cs.c 1.65 2001/10/13 00:08:50 Donald Becker/David Hinds, becker@scyld.com.\n";
+"3c574_cs.c 1.65ac1 2003/04/07 Donald Becker/David Hinds, becker@scyld.com.\n";
 #else
 #define DEBUG(n, args...)
 #endif
@@ -212,15 +214,15 @@
 	struct net_device dev;
 	dev_node_t node;
 	struct net_device_stats stats;
-	u16 advertising, partner;			/* NWay media advertisement */
-	unsigned char phys;					/* MII device address */
-	unsigned int
-	  autoselect:1, default_media:3;	/* Read from the EEPROM/Wn3_Config. */
+	u16 advertising, partner;		/* NWay media advertisement */
+	unsigned char phys;			/* MII device address */
+	unsigned int autoselect:1, default_media:3;	/* Read from the EEPROM/Wn3_Config. */
 	/* for transceiver monitoring */
 	struct timer_list media;
-	u_short media_status;
-	u_short fast_poll;
-	u_long last_irq;
+	unsigned short media_status;
+	unsigned short fast_poll;
+	unsigned long last_irq;
+	spinlock_t window_lock;			/* Guards the Window selection */
 };
 
 /* Set iff a MII transceiver on any interface requires mdio preamble.
@@ -231,18 +233,18 @@
 /* Index of functions. */
 
 static void tc574_config(dev_link_t *link);
-static void tc574_release(u_long arg);
+static void tc574_release(unsigned long arg);
 static int tc574_event(event_t event, int priority,
 					   event_callback_args_t *args);
 
 static void mdio_sync(ioaddr_t ioaddr, int bits);
 static int mdio_read(ioaddr_t ioaddr, int phy_id, int location);
 static void mdio_write(ioaddr_t ioaddr, int phy_id, int location, int value);
-static u_short read_eeprom(ioaddr_t ioaddr, int index);
+static unsigned short read_eeprom(ioaddr_t ioaddr, int index);
 static void tc574_wait_for_completion(struct net_device *dev, int cmd);
 
 static void tc574_reset(struct net_device *dev);
-static void media_check(u_long arg);
+static void media_check(unsigned long arg);
 static int el3_open(struct net_device *dev);
 static int el3_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void el3_interrupt(int irq, void *dev_id, struct pt_regs *regs);
@@ -266,15 +268,15 @@
 	dev_link_t *link, *next;
 	for (link = dev_list; link; link = next) {
 		next = link->next;
-	    if (link->state & DEV_STALE_LINK)
+		if (link->state & DEV_STALE_LINK)
 			tc574_detach(link);
-    }
+	}
 }
 
 static void cs_error(client_handle_t handle, int func, int ret)
 {
 #if CS_RELEASE_CODE < 0x2911
-    CardServices(ReportError, dev_info, (void *)func, (void *)ret);
+	CardServices(ReportError, dev_info, (void *)func, (void *)ret);
 #else
 	error_info_t err = { func, ret };
 	CardServices(ReportError, handle, &err);
@@ -300,14 +302,16 @@
 
 	/* Create the PC card device object. */
 	lp = kmalloc(sizeof(*lp), GFP_KERNEL);
-	if (!lp) return NULL;
+	if (!lp)
+		return NULL;
+		
 	memset(lp, 0, sizeof(*lp));
 	link = &lp->link; dev = &lp->dev;
 	link->priv = dev->priv = link->irq.Instance = lp;
 	
 	init_timer(&link->release);
 	link->release.function = &tc574_release;
-	link->release.data = (u_long)link;
+	link->release.data = (unsigned long)link;
 	link->io.NumPorts1 = 32;
 	link->io.Attributes1 = IO_DATA_PATH_WIDTH_16;
 	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
@@ -381,9 +385,9 @@
 	if (*linkp == NULL)
 	return;
 
-	del_timer(&link->release);
+	del_timer_sync(&link->release);
 	if (link->state & DEV_CONFIG) {
-		tc574_release((u_long)link);
+		tc574_release((unsigned long)link);
 		if (link->state & DEV_STALE_CONFIG) {
 			link->state |= DEV_STALE_LINK;
 			return;
@@ -417,7 +421,7 @@
 	struct net_device *dev = &lp->dev;
 	tuple_t tuple;
 	cisparse_t parse;
-	u_short buf[32];
+	unsigned short buf[32];
 	int last_fn, last_ret, i, j;
 	ioaddr_t ioaddr;
 	u16 *phys_addr;
@@ -562,7 +566,7 @@
 cs_failed:
 	cs_error(link->handle, last_fn, last_ret);
 failed:
-	tc574_release((u_long)link);
+	tc574_release((unsigned long)link);
 	return;
 
 } /* tc574_config */
@@ -573,7 +577,7 @@
 	still open, this will be postponed until it is closed.
 */
 
-static void tc574_release(u_long arg)
+static void tc574_release(unsigned long arg)
 {
 	dev_link_t *link = (dev_link_t *)arg;
 
@@ -652,12 +656,12 @@
 {
 	ioaddr_t ioaddr = dev->base_addr;
 	EL3WINDOW(1);
-    printk(KERN_INFO "  irq status %04x, rx status %04x, tx status "
+	printk(KERN_INFO "  irq status %04x, rx status %04x, tx status "
 		   "%02x, tx free %04x\n", inw(ioaddr+EL3_STATUS),
 		   inw(ioaddr+RxStatus), inb(ioaddr+TxStatus),
 		   inw(ioaddr+TxFree));
 	EL3WINDOW(4);
-    printk(KERN_INFO "  diagnostics: fifo %04x net %04x ethernet %04x"
+	printk(KERN_INFO "  diagnostics: fifo %04x net %04x ethernet %04x"
 		   " media %04x\n", inw(ioaddr+0x04), inw(ioaddr+0x06),
 		   inw(ioaddr+0x08), inw(ioaddr+0x0a));
 	EL3WINDOW(1);
@@ -668,19 +672,18 @@
 */
 static void tc574_wait_for_completion(struct net_device *dev, int cmd)
 {
-    int i = 1500;
-    outw(cmd, dev->base_addr + EL3_CMD);
-    while (--i > 0)
+	int i = 1500;
+	outw(cmd, dev->base_addr + EL3_CMD);
+	while (--i > 0)
 		if (!(inw(dev->base_addr + EL3_STATUS) & 0x1000)) break;
-    if (i == 0)
-		printk(KERN_NOTICE "%s: command 0x%04x did not complete!\n",
-			   dev->name, cmd);
+	if (i == 0)
+		printk(KERN_NOTICE "%s: command 0x%04x did not complete!\n", dev->name, cmd);
 }
 
 /* Read a word from the EEPROM using the regular EEPROM access register.
    Assume that we are in register window zero.
  */
-static u_short read_eeprom(ioaddr_t ioaddr, int index)
+static unsigned short read_eeprom(ioaddr_t ioaddr, int index)
 {
 	int timer;
 	outw(EEPROM_Read + index, ioaddr + Wn0EepromCmd);
@@ -773,9 +776,11 @@
 {
 	struct el3_private *lp = (struct el3_private *)dev->priv;
 	int i, ioaddr = dev->base_addr;
+	unsigned long flags;
 
 	tc574_wait_for_completion(dev, TotalReset|0x10);
 
+	spin_lock_irqsave(&lp->window_lock, flags);
 	/* Clear any transactions in progress. */
 	outw(0, ioaddr + RunnerWrCtrl);
 	outw(0, ioaddr + RunnerRdCtrl);
@@ -792,14 +797,18 @@
 	outb((dev->mtu > 1500 ? 0x40 : 0), ioaddr + Wn3_MAC_Ctrl);
 	outl((lp->autoselect ? 0x01000000 : 0) | 0x0062001b,
 		 ioaddr + Wn3_Config);
-	
 	/* Roadrunner only: Turn on the MII transceiver. */
 	outw(0x8040, ioaddr + Wn3_Options);
 	mdelay(1);
 	outw(0xc040, ioaddr + Wn3_Options);
+	EL3WINDOW(1);
+	spin_unlock_irqrestore(&lp->window_lock, flags);
+	
 	tc574_wait_for_completion(dev, TxReset);
 	tc574_wait_for_completion(dev, RxReset);
 	mdelay(1);
+	spin_lock_irqsave(&lp->window_lock, flags);
+	EL3WINDOW(3);
 	outw(0x8040, ioaddr + Wn3_Options);
 
 	/* Switch to the stats window, and clear all stats by reading. */
@@ -815,6 +824,10 @@
 
 	/* .. enable any extra statistics bits.. */
 	outw(0x0040, ioaddr + Wn4_NetDiag);
+	
+	EL3WINDOW(1);
+	spin_unlock_irqrestore(&lp->window_lock, flags);
+	
 	/* .. re-sync MII and re-fill what NWay is advertising. */
 	mdio_sync(ioaddr, 32);
 	mdio_write(ioaddr, lp->phys, 4, lp->advertising);
@@ -824,10 +837,10 @@
 		mdio_write(ioaddr, lp->phys, 16, i);
 	}
 
+	spin_lock_irqsave(&lp->window_lock, flags);
 	/* Switch to register set 1 for normal use, just for TxFree. */
-	EL3WINDOW(1);
-
 	set_rx_mode(dev);
+	spin_unlock_irqrestore(&lp->window_lock, flags);
 	outw(StatsEnable, ioaddr + EL3_CMD); /* Turn on statistics. */
 	outw(RxEnable, ioaddr + EL3_CMD); /* Enable the receiver. */
 	outw(TxEnable, ioaddr + EL3_CMD); /* Enable transmitter. */
@@ -849,12 +862,11 @@
 		return -ENODEV;
 	
 	link->open++;
-	MOD_INC_USE_COUNT;
 	netif_start_queue(dev);
 	
 	tc574_reset(dev);
 	lp->media.function = &media_check;
-	lp->media.data = (u_long)lp;
+	lp->media.data = (unsigned long)lp;
 	lp->media.expires = jiffies + HZ;
 	add_timer(&lp->media);
 	
@@ -881,14 +893,15 @@
 
 static void pop_tx_status(struct net_device *dev)
 {
-    struct el3_private *lp = (struct el3_private *)dev->priv;
-    ioaddr_t ioaddr = dev->base_addr;
-    int i;
+	struct el3_private *lp = (struct el3_private *)dev->priv;
+	ioaddr_t ioaddr = dev->base_addr;
+	int i;
     
-    /* Clear the Tx status stack. */
-    for (i = 32; i > 0; i--) {
+	/* Clear the Tx status stack. */
+	for (i = 32; i > 0; i--) {
 		u_char tx_status = inb(ioaddr + TxStatus);
-		if (!(tx_status & 0x84)) break;
+		if (!(tx_status & 0x84))
+			break;
 		/* reset transmitter on jabber error or underrun */
 		if (tx_status & 0x30)
 			tc574_wait_for_completion(dev, TxReset);
@@ -899,17 +912,20 @@
 			lp->stats.tx_aborted_errors++;
 		}
 		outb(0x00, ioaddr + TxStatus); /* Pop the status stack. */
-    }
+	}
 }
 
 static int el3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	ioaddr_t ioaddr = dev->base_addr;
+	struct el3_private *lp = (struct el3_private *)dev->priv;
+	unsigned long flags;
 
 	DEBUG(3, "%s: el3_start_xmit(length = %ld) called, "
 		  "status %4.4x.\n", dev->name, (long)skb->len,
 		  inw(ioaddr + EL3_STATUS));
 
+	spin_lock_irqsave(&lp->window_lock, flags);
 	outw(skb->len, ioaddr + TX_FIFO);
 	outw(0, ioaddr + TX_FIFO);
 	outsl(ioaddr + TX_FIFO, skb->data, (skb->len+3)>>2);
@@ -927,6 +943,8 @@
 	dev_kfree_skb (skb);
 	pop_tx_status(dev);
 
+	spin_unlock(&lp->window_lock);
+	
 	return 0;
 }
 
@@ -945,6 +963,8 @@
 	DEBUG(3, "%s: interrupt, status %4.4x.\n",
 		  dev->name, inw(ioaddr + EL3_STATUS));
 
+	spin_lock(&lp->window_lock);
+	
 	while ((status = inw(ioaddr + EL3_STATUS)) &
 		   (IntLatch | RxComplete | RxEarly | StatsFull)) {
 		if (!netif_device_present(dev) ||
@@ -1009,6 +1029,8 @@
 
 	DEBUG(3, "%s: exiting interrupt, status %4.4x.\n",
 		  dev->name, inw(ioaddr + EL3_STATUS));
+		  
+	spin_unlock(&lp->window_lock);
 	return;
 }
 
@@ -1017,41 +1039,38 @@
 	(and as a last resort, poll the NIC for events), and to monitor
 	the MII, reporting changes in cable status.
 */
-static void media_check(u_long arg)
+static void media_check(unsigned long arg)
 {
-    struct el3_private *lp = (struct el3_private *)arg;
-    struct net_device *dev = &lp->dev;
-    ioaddr_t ioaddr = dev->base_addr;
-    u_long flags;
-	u_short /* cable, */ media, partner;
+	struct el3_private *lp = (struct el3_private *)arg;
+	struct net_device *dev = &lp->dev;
+	ioaddr_t ioaddr = dev->base_addr;
+	unsigned long flags;
+	unsigned short /* cable, */ media, partner;
 
 	if (!netif_device_present(dev))
 		goto reschedule;
 	
-    /* Check for pending interrupt with expired latency timer: with
-       this, we can limp along even if the interrupt is blocked */
-    if ((inw(ioaddr + EL3_STATUS) & IntLatch) &&
-		(inb(ioaddr + Timer) == 0xff)) {
+	/* Check for pending interrupt with expired latency timer: with
+	   this, we can limp along even if the interrupt is blocked */
+	if ((inw(ioaddr + EL3_STATUS) & IntLatch) && (inb(ioaddr + Timer) == 0xff)) {
 		if (!lp->fast_poll)
 			printk(KERN_INFO "%s: interrupt(s) dropped!\n", dev->name);
 		el3_interrupt(dev->irq, lp, NULL);
 		lp->fast_poll = HZ;
-    }
-    if (lp->fast_poll) {
+	}
+	if (lp->fast_poll) {
 		lp->fast_poll--;
 		lp->media.expires = jiffies + 2;
 		add_timer(&lp->media);
 		return;
-    }
+	}
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lp->window_lock, flags);
 	EL3WINDOW(4);
 	media = mdio_read(ioaddr, lp->phys, 1);
 	partner = mdio_read(ioaddr, lp->phys, 5);
 	EL3WINDOW(1);
-	restore_flags(flags);
-
+	
 	if (media != lp->media_status) {
 		if ((media ^ lp->media_status) & 0x0004)
 			printk(KERN_INFO "%s: %s link beat\n", dev->name,
@@ -1086,10 +1105,11 @@
 			printk(KERN_INFO "%s: jabber detected\n", dev->name);
 		lp->media_status = media;
 	}
+	spin_unlock_irqrestore(&lp->window_lock, flags);
 
 reschedule:
-    lp->media.expires = jiffies + HZ;
-    add_timer(&lp->media);
+	lp->media.expires = jiffies + HZ;
+	add_timer(&lp->media);
 }
 
 static struct net_device_stats *el3_get_stats(struct net_device *dev)
@@ -1109,37 +1129,41 @@
 {
 	struct el3_private *lp = (struct el3_private *)dev->priv;
 	ioaddr_t ioaddr = dev->base_addr;
+	unsigned long flags;
 	u8 rx, tx, up;
 
 	DEBUG(2, "%s: updating the statistics.\n", dev->name);
 
 	if (inw(ioaddr+EL3_STATUS) == 0xffff) /* No card. */
 		return;
+		
+	spin_lock_irqsave(&lp->window_lock, flags);
 
 	/* Unlike the 3c509 we need not turn off stats updates while reading. */
 	/* Switch to the stats window, and read everything. */
 	EL3WINDOW(6);
-	lp->stats.tx_carrier_errors 	+= inb(ioaddr + 0);
-	lp->stats.tx_heartbeat_errors	+= inb(ioaddr + 1);
+	lp->stats.tx_carrier_errors 		+= inb(ioaddr + 0);
+	lp->stats.tx_heartbeat_errors		+= inb(ioaddr + 1);
 	/* Multiple collisions. */	   	inb(ioaddr + 2);
 	lp->stats.collisions			+= inb(ioaddr + 3);
 	lp->stats.tx_window_errors		+= inb(ioaddr + 4);
 	lp->stats.rx_fifo_errors		+= inb(ioaddr + 5);
 	lp->stats.tx_packets			+= inb(ioaddr + 6);
-	up		 						 = inb(ioaddr + 9);
+	up		 			 = inb(ioaddr + 9);
 	lp->stats.tx_packets			+= (up&0x30) << 4;
-	/* Rx packets   */				   inb(ioaddr + 7);
-	/* Tx deferrals */				   inb(ioaddr + 8);
-	rx		 						 = inw(ioaddr + 10);
-	tx								 = inw(ioaddr + 12);
+	/* Rx packets   */			   inb(ioaddr + 7);
+	/* Tx deferrals */			   inb(ioaddr + 8);
+	rx		 			 = inw(ioaddr + 10);
+	tx					 = inw(ioaddr + 12);
 
 	EL3WINDOW(4);
-	/* BadSSD */					   inb(ioaddr + 12);
-	up								 = inb(ioaddr + 13);
+	/* BadSSD */				   inb(ioaddr + 12);
+	up					 = inb(ioaddr + 13);
 
-	lp->stats.tx_bytes += tx + ((up & 0xf0) << 12);
+	lp->stats.tx_bytes 			+= tx + ((up & 0xf0) << 12);
 
 	EL3WINDOW(1);
+	spin_unlock_irqrestore(&lp->window_lock, flags);
 }
 
 static int el3_rx(struct net_device *dev, int worklimit)
@@ -1150,7 +1174,7 @@
 	
 	DEBUG(3, "%s: in rx_packet(), status %4.4x, rx_status %4.4x.\n",
 		  dev->name, inw(ioaddr+EL3_STATUS), inw(ioaddr+RxStatus));
-    while (!((rx_status = inw(ioaddr + RxStatus)) & 0x8000) &&
+	while (!((rx_status = inw(ioaddr + RxStatus)) & 0x8000) &&
 		   (--worklimit >= 0)) {
 		if (rx_status & 0x4000) { /* Error, update stats. */
 			short error = rx_status & 0x3800;
@@ -1225,7 +1249,7 @@
 		  dev->name, rq->ifr_ifrn.ifrn_name, cmd,
 		  data[0], data[1], data[2], data[3]);
 
-    switch(cmd) {
+	switch(cmd) {
 	case SIOCETHTOOL:
 		return netdev_ethtool_ioctl(dev, (void *)rq->ifr_data);
 	case SIOCDEVPRIVATE:		/* Get the address of the PHY in use. */
@@ -1233,15 +1257,14 @@
 	case SIOCDEVPRIVATE+1:		/* Read the specified MII register. */
 		{
 			int saved_window;
-                       unsigned long flags;
+			unsigned long flags;
 
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lp->window_lock, flags);
 			saved_window = inw(ioaddr + EL3_CMD) >> 13;
 			EL3WINDOW(4);
 			data[3] = mdio_read(ioaddr, data[0] & 0x1f, data[1] & 0x1f);
 			EL3WINDOW(saved_window);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lp->window_lock, flags);
 			return 0;
 		}
 	case SIOCDEVPRIVATE+2:		/* Write the specified MII register */
@@ -1251,13 +1274,12 @@
 
 			if (!capable(CAP_NET_ADMIN))
 				return -EPERM;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lp->window_lock, flags);
 			saved_window = inw(ioaddr + EL3_CMD) >> 13;
 			EL3WINDOW(4);
 			mdio_write(ioaddr, data[0] & 0x1f, data[1] & 0x1f, data[2]);
 			EL3WINDOW(saved_window);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lp->window_lock, flags);
 			return 0;
 		}
 	default:
@@ -1310,12 +1332,9 @@
 
 	link->open--;
 	netif_stop_queue(dev);
-	del_timer(&lp->media);
+	del_timer_sync(&lp->media);
 	if (link->state & DEV_STALE_CONFIG)
 		mod_timer(&link->release, jiffies + HZ/20);
-
-	MOD_DEC_USE_COUNT;
-
 	return 0;
 }
 
