Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbUAAUV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbUAAURD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:17:03 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:34381 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S265079AbUAAUKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:10:23 -0500
Date: Thu, 1 Jan 2004 21:01:57 +0100
Message-Id: <200401012001.i01K1vlY031781@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 357] Mac89x0 Ethernet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Macintosh CS89x0 Ethernet: Netif updates (from Matthias Urlichs)

--- linux-2.6.0/drivers/net/Kconfig	Sun Oct 19 10:45:04 2003
+++ linux-m68k-2.6.0/drivers/net/Kconfig	Mon Oct 20 21:39:36 2003
@@ -318,7 +318,7 @@
 
 config MAC89x0
 	tristate "Macintosh CS89x0 based ethernet cards"
-	depends on NETDEVICES && MAC && BROKEN
+	depends on NETDEVICES && MAC
 	---help---
 	  Support for CS89x0 chipset based Ethernet cards.  If you have a
 	  Nubus or LC-PDS network (Ethernet) card of this type, say Y and
--- linux-2.6.0/drivers/net/mac89x0.c	Mon May  5 10:31:32 2003
+++ linux-m68k-2.6.0/drivers/net/mac89x0.c	Mon Oct 20 21:34:24 2003
@@ -128,7 +128,7 @@
 extern void reset_chip(struct net_device *dev);
 #endif
 static int net_open(struct net_device *dev);
-static int	net_send_packet(struct sk_buff *skb, struct net_device *dev);
+static int net_send_packet(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t net_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static void set_multicast_list(struct net_device *dev);
 static void net_rx(struct net_device *dev);
@@ -367,56 +367,37 @@
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
-		local_irq_save(flags);
-
-		/* initiate a transmit sequence */
-		writereg(dev, PP_TxCMD, lp->send_cmd);
-		writereg(dev, PP_TxLength, skb->len);
-
-		/* Test to see if the chip has allocated memory for the packet */
-		if ((readreg(dev, PP_BusST) & READY_FOR_TX_NOW) == 0) {
-			/* Gasp!  It hasn't.  But that shouldn't happen since
-			   we're waiting for TxOk, so return 1 and requeue this packet. */
-			local_irq_restore(flags);
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
+	local_irq_save(flags);
 
+	/* initiate a transmit sequence */
+	writereg(dev, PP_TxCMD, lp->send_cmd);
+	writereg(dev, PP_TxLength, skb->len);
+
+	/* Test to see if the chip has allocated memory for the packet */
+	if ((readreg(dev, PP_BusST) & READY_FOR_TX_NOW) == 0) {
+		/* Gasp!  It hasn't.  But that shouldn't happen since
+		   we're waiting for TxOk, so return 1 and requeue this packet. */
 		local_irq_restore(flags);
-		dev->trans_start = jiffies;
+		return 1;
 	}
+
+	/* Write the contents of the packet */
+	memcpy((void *)(dev->mem_start + PP_TxFrame), skb->data, skb->len+1);
+
+	local_irq_restore(flags);
+	dev->trans_start = jiffies;
 	dev_kfree_skb (skb);
 
 	return 0;
@@ -434,9 +415,6 @@
 		printk ("net_interrupt(): irq %d for unknown device.\n", irq);
 		return IRQ_NONE;
 	}
-	if (dev->interrupt)
-		printk("%s: Re-entering the interrupt handler.\n", dev->name);
-	dev->interrupt = 1;
 
 	ioaddr = dev->base_addr;
 	lp = (struct net_local *)dev->priv;
@@ -457,8 +435,7 @@
 			break;
 		case ISQ_TRANSMITTER_EVENT:
 			lp->stats.tx_packets++;
-			dev->tbusy = 0;
-			mark_bh(NET_BH);	/* Inform upper layers. */
+			netif_wake_queue(dev);
 			if ((status & TX_OK) == 0) lp->stats.tx_errors++;
 			if (status & TX_LOST_CRS) lp->stats.tx_carrier_errors++;
 			if (status & TX_SQE_ERROR) lp->stats.tx_heartbeat_errors++;
@@ -472,8 +449,7 @@
                                    That shouldn't happen since we only ever
                                    load one packet.  Shrug.  Do the right
                                    thing anyway. */
-				dev->tbusy = 0;
-				mark_bh(NET_BH);	/* Inform upper layers. */
+				netif_wake_queue(dev);
 			}
 			if (status & TX_UNDERRUN) {
 				if (net_debug > 0) printk("%s: transmit underrun\n", dev->name);
@@ -490,7 +466,6 @@
 			break;
 		}
 	}
-	dev->interrupt = 0;
 	return IRQ_HANDLED;
 }
 
@@ -525,7 +500,7 @@
 	skb_put(skb, length);
 	skb->dev = dev;
 
-	memcpy_fromio(skb->data, dev->mem_start + PP_RxFrame, length);
+	memcpy(skb->data, (void *)(dev->mem_start + PP_RxFrame), length);
 
 	if (net_debug > 3)printk("%s: received %d byte packet of type %x\n",
                                  dev->name, length,
@@ -604,8 +579,6 @@
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
