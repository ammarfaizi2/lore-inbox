Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbTLGU6u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTLGU5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:57:16 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:65352 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S264512AbTLGUze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:34 -0500
Date: Sun, 7 Dec 2003 21:51:18 +0100
Message-Id: <200312072051.hB7KpI0e000704@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.rutgers.edu, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 129] Mac89x0 Ethernet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Macintosh CS89x0 Ethernet: Netif updates (from Matthias Urlichs in 2.6.0)

--- linux-2.4.23/drivers/net/mac89x0.c	Fri Sep 13 10:16:20 2002
+++ linux-m68k-2.4.23/drivers/net/mac89x0.c	Mon Oct 20 21:35:57 2003
@@ -128,7 +128,7 @@
 extern void reset_chip(struct net_device *dev);
 #endif
 static int net_open(struct net_device *dev);
-static int	net_send_packet(struct sk_buff *skb, struct net_device *dev);
+static int net_send_packet(struct sk_buff *skb, struct net_device *dev);
 static void net_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static void set_multicast_list(struct net_device *dev);
 static void net_rx(struct net_device *dev);
@@ -368,57 +368,38 @@
 static int
 net_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
-	if (dev->tbusy) {
-		/* If we get here, some higher level has decided we are broken.
-		   There should really be a "kick me" function call instead. */
-		int tickssofar = jiffies - dev->trans_start;
-		if (tickssofar < 5)
-			return 1;
-		if (net_debug > 0) printk("%s: transmit timed out, %s?\n", dev->name,
-			   tx_done(dev) ? "IRQ conflict" : "network cable problem");
-		/* Try to restart the adaptor. */
-		dev->tbusy=0;
-		dev->trans_start = jiffies;
-	}
-
-	/* Block a timer-based transmit from overlapping.  This could better be
-	   done with atomic_swap(1, dev->tbusy), but set_bit() works as well. */
-	if (test_and_set_bit(0, (void*)&dev->tbusy) != 0)
-		printk("%s: Transmitter access conflict.\n", dev->name);
-	else {
-		struct net_local *lp = (struct net_local *)dev->priv;
-		unsigned long flags;
-
-		if (net_debug > 3)
-			printk("%s: sent %d byte packet of type %x\n",
-			       dev->name, skb->len,
-			       (skb->data[ETH_ALEN+ETH_ALEN] << 8)
-			       | skb->data[ETH_ALEN+ETH_ALEN+1]);
-
-		/* keep the upload from being interrupted, since we
-                   ask the chip to start transmitting before the
-                   whole packet has been completely uploaded. */
-		save_flags(flags);
-		cli();
-
-		/* initiate a transmit sequence */
-		writereg(dev, PP_TxCMD, lp->send_cmd);
-		writereg(dev, PP_TxLength, skb->len);
-
-		/* Test to see if the chip has allocated memory for the packet */
-		if ((readreg(dev, PP_BusST) & READY_FOR_TX_NOW) == 0) {
-			/* Gasp!  It hasn't.  But that shouldn't happen since
-			   we're waiting for TxOk, so return 1 and requeue this packet. */
-			restore_flags(flags);
-			return 1;
-		}
+	struct net_local *lp = (struct net_local *)dev->priv;
+	unsigned long flags;
 
-		/* Write the contents of the packet */
-		memcpy_toio(dev->mem_start + PP_TxFrame, skb->data, skb->len+1);
+	if (net_debug > 3)
+		printk("%s: sent %d byte packet of type %x\n",
+		       dev->name, skb->len,
+		       (skb->data[ETH_ALEN+ETH_ALEN] << 8)
+		       | skb->data[ETH_ALEN+ETH_ALEN+1]);
+
+	/* keep the upload from being interrupted, since we
+	   ask the chip to start transmitting before the
+	   whole packet has been completely uploaded. */
+	save_flags(flags);
+	cli();
 
+	/* initiate a transmit sequence */
+	writereg(dev, PP_TxCMD, lp->send_cmd);
+	writereg(dev, PP_TxLength, skb->len);
+
+	/* Test to see if the chip has allocated memory for the packet */
+	if ((readreg(dev, PP_BusST) & READY_FOR_TX_NOW) == 0) {
+		/* Gasp!  It hasn't.  But that shouldn't happen since
+		   we're waiting for TxOk, so return 1 and requeue this packet. */
 		restore_flags(flags);
-		dev->trans_start = jiffies;
+		return 1;
 	}
+
+	/* Write the contents of the packet */
+	memcpy((void *)(dev->mem_start + PP_TxFrame), skb->data, skb->len+1);
+
+	restore_flags(flags);
+	dev->trans_start = jiffies;
 	dev_kfree_skb (skb);
 
 	return 0;
@@ -436,9 +417,6 @@
 		printk ("net_interrupt(): irq %d for unknown device.\n", irq);
 		return;
 	}
-	if (dev->interrupt)
-		printk("%s: Re-entering the interrupt handler.\n", dev->name);
-	dev->interrupt = 1;
 
 	ioaddr = dev->base_addr;
 	lp = (struct net_local *)dev->priv;
@@ -459,8 +437,7 @@
 			break;
 		case ISQ_TRANSMITTER_EVENT:
 			lp->stats.tx_packets++;
-			dev->tbusy = 0;
-			mark_bh(NET_BH);	/* Inform upper layers. */
+			netif_wake_queue(dev);
 			if ((status & TX_OK) == 0) lp->stats.tx_errors++;
 			if (status & TX_LOST_CRS) lp->stats.tx_carrier_errors++;
 			if (status & TX_SQE_ERROR) lp->stats.tx_heartbeat_errors++;
@@ -474,8 +451,7 @@
                                    That shouldn't happen since we only ever
                                    load one packet.  Shrug.  Do the right
                                    thing anyway. */
-				dev->tbusy = 0;
-				mark_bh(NET_BH);	/* Inform upper layers. */
+				netif_wake_queue(dev);
 			}
 			if (status & TX_UNDERRUN) {
 				if (net_debug > 0) printk("%s: transmit underrun\n", dev->name);
@@ -492,7 +468,6 @@
 			break;
 		}
 	}
-	dev->interrupt = 0;
 	return;
 }
 
@@ -527,7 +502,7 @@
 	skb_put(skb, length);
 	skb->dev = dev;
 
-	memcpy_fromio(skb->data, dev->mem_start + PP_RxFrame, length);
+	memcpy(skb->data, (void *)(dev->mem_start + PP_RxFrame), length);
 
 	if (net_debug > 3)printk("%s: received %d byte packet of type %x\n",
                                  dev->name, length,
@@ -607,8 +582,6 @@
 static int set_mac_address(struct net_device *dev, void *addr)
 {
 	int i;
-	if (dev->start)
-		return -EBUSY;
 	printk("%s: Setting MAC address to ", dev->name);
 	for (i = 0; i < 6; i++)
 		printk(" %2.2x", dev->dev_addr[i] = ((unsigned char *)addr)[i]);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
