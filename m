Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265671AbTGDCZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbTGDCYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:24:46 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.17]:9580 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265662AbTGDCRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:17:47 -0400
Date: Thu, 03 Jul 2003 22:31:57 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH - RFC] [2/5] 64-bit network statistics - drivers
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Message-id: <200307032232.07409.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_ECMZzh6OK+iu3ddWfFE1TQ)"
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_ECMZzh6OK+iu3ddWfFE1TQ)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

64-bit network statistics:
	Part 2 of 5 - drivers

- -- 
Don't drink and derive. Alcohol and algebra don't mix.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BOciwFP0+seVj/4RAk6zAJ0db2Hc02GsOSPkWpklLGf6LYSyYwCg1qHY
xllKUhFZogSgQQZyaSF4ARg=
=3/AN
-----END PGP SIGNATURE-----

--Boundary_(ID_ECMZzh6OK+iu3ddWfFE1TQ)
Content-type: text/x-diff; charset=us-ascii; name=drivers.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=drivers.diff

diff -X dontdiff -Naur linux-2.5.74-vanilla/drivers/net/8139too.c linux-2.5.74-nx/drivers/net/8139too.c
--- linux-2.5.74-vanilla/drivers/net/8139too.c	2003-07-02 16:38:41.000000000 -0400
+++ linux-2.5.74-nx/drivers/net/8139too.c	2003-07-03 15:11:00.000000000 -0400
@@ -82,6 +82,8 @@
 
 		Robert Kuebel - Save kernel thread from dying on any signal.
 
+		Josef "Jeff" Sipek - new network statistics API support
+
 	Submitting bug reports:
 
 		"rtl8139-diag -mmmaaavvveefN" output
@@ -962,6 +964,9 @@
 		((u16 *) (dev->dev_addr))[i] =
 		    le16_to_cpu (read_eeprom (ioaddr, i + 7, addr_len));
 
+	/* Init net_device_stats struct */
+	net_stats_init(&((struct rtl8139_private*) dev->priv)->stats);
+
 	/* The Rtl8139-specific entries in the device structure. */
 	dev->open = rtl8139_open;
 	dev->hard_start_xmit = rtl8139_start_xmit;
@@ -1686,7 +1691,7 @@
 		dev_kfree_skb(skb);
 	} else {
 		dev_kfree_skb(skb);
-		tp->stats.tx_dropped++;
+		net_stats_inc(tx_dropped,&tp->stats);
 		return 0;
 	}
 
@@ -1737,27 +1742,27 @@
 			/* There was an major error, log it. */
 			DPRINTK ("%s: Transmit error, Tx status %8.8x.\n",
 				 dev->name, txstatus);
-			tp->stats.tx_errors++;
+			net_stats_inc(tx_errors,&tp->stats);
 			if (txstatus & TxAborted) {
-				tp->stats.tx_aborted_errors++;
+				net_stats_inc(tx_aborted_errors,&tp->stats);
 				RTL_W32 (TxConfig, TxClearAbt);
 				RTL_W16 (IntrStatus, TxErr);
 				wmb();
 			}
 			if (txstatus & TxCarrierLost)
-				tp->stats.tx_carrier_errors++;
+				net_stats_inc(tx_carrier_errors,&tp->stats);
 			if (txstatus & TxOutOfWindow)
-				tp->stats.tx_window_errors++;
+				net_stats_inc(tx_window_errors,&tp->stats);
 		} else {
 			if (txstatus & TxUnderrun) {
 				/* Add 64 to the Tx FIFO threshold. */
 				if (tp->tx_flag < 0x00300000)
 					tp->tx_flag += 0x00020000;
-				tp->stats.tx_fifo_errors++;
+				net_stats_inc(tx_fifo_errors,&tp->stats);
 			}
-			tp->stats.collisions += (txstatus >> 24) & 15;
-			tp->stats.tx_bytes += txstatus & 0x7ff;
-			tp->stats.tx_packets++;
+			net_stats_add(collisions,&tp->stats,(txstatus >> 24) & 15);
+			net_stats_add(tx_bytes,&tp->stats,txstatus & 0x7ff);
+			net_stats_inc(tx_packets,&tp->stats);
 		}
 
 		dirty_tx++;
@@ -1793,7 +1798,7 @@
 
 	DPRINTK ("%s: Ethernet frame had errors, status %8.8x.\n",
 	         dev->name, rx_status);
-	tp->stats.rx_errors++;
+	net_stats_inc(rx_errors,&tp->stats);
 	if (!(rx_status & RxStatusOK)) {
 		if (rx_status & RxTooLong) {
 			DPRINTK ("%s: Oversized Ethernet frame, status %4.4x!\n",
@@ -1801,11 +1806,11 @@
 			/* A.C.: The chip hangs here. */
 		}
 		if (rx_status & (RxBadSymbol | RxBadAlign))
-			tp->stats.rx_frame_errors++;
+			net_stats_inc(rx_frame_errors,&tp->stats);
 		if (rx_status & (RxRunt | RxTooLong))
-			tp->stats.rx_length_errors++;
+			net_stats_inc(rx_length_errors,&tp->stats);
 		if (rx_status & RxCRCErr)
-			tp->stats.rx_crc_errors++;
+			net_stats_inc(rx_crc_errors,&tp->stats);
 	} else {
 		tp->xstats.rx_lost_in_ring++;
 	}
@@ -1951,13 +1956,13 @@
 			skb->protocol = eth_type_trans (skb, dev);
 			netif_rx (skb);
 			dev->last_rx = jiffies;
-			tp->stats.rx_bytes += pkt_size;
-			tp->stats.rx_packets++;
+			net_stats_add(rx_bytes,&tp->stats,pkt_size);
+			net_stats_inc(rx_packets,&tp->stats);
 		} else {
 			printk (KERN_WARNING
 				"%s: Memory squeeze, dropping packet.\n",
 				dev->name);
-			tp->stats.rx_dropped++;
+			net_stats_inc(rx_dropped,&tp->stats);
 		}
 
 		cur_rx = (cur_rx + rx_size + 4 + 3) & ~3;
@@ -1989,7 +1994,7 @@
 	assert (ioaddr != NULL);
 
 	/* Update the error count. */
-	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
+	net_stats_add(rx_missed_errors,&tp->stats,RTL_R32 (RxMissed));
 	RTL_W32 (RxMissed, 0);
 
 	if ((status & RxUnderrun) && link_changed &&
@@ -2012,12 +2017,12 @@
 	/* XXX along with rtl8139_rx_err, are we double-counting errors? */
 	if (status &
 	    (RxUnderrun | RxOverflow | RxErr | RxFIFOOver))
-		tp->stats.rx_errors++;
+		net_stats_inc(rx_errors,&tp->stats);
 
 	if (status & PCSTimeout)
-		tp->stats.rx_length_errors++;
+		net_stats_inc(rx_length_errors,&tp->stats);
 	if (status & (RxUnderrun | RxFIFOOver))
-		tp->stats.rx_fifo_errors++;
+		net_stats_inc(rx_fifo_errors,&tp->stats);
 	if (status & PCIErr) {
 		u16 pci_cmd_status;
 		pci_read_config_word (tp->pci_dev, PCI_STATUS, &pci_cmd_status);
@@ -2138,7 +2143,7 @@
 	RTL_W16 (IntrMask, 0);
 
 	/* Update the error counts. */
-	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
+	net_stats_add(rx_missed_errors,&tp->stats,RTL_R32 (RxMissed));
 	RTL_W32 (RxMissed, 0);
 
 	spin_unlock_irqrestore (&tp->lock, flags);
@@ -2473,7 +2478,7 @@
 
 	if (netif_running(dev)) {
 		spin_lock_irqsave (&tp->lock, flags);
-		tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
+		net_stats_add(rx_missed_errors,&tp->stats,RTL_R32 (RxMissed));
 		RTL_W32 (RxMissed, 0);
 		spin_unlock_irqrestore (&tp->lock, flags);
 	}
diff -X dontdiff -Naur linux-2.5.74-vanilla/drivers/net/8390.c linux-2.5.74-nx/drivers/net/8390.c
--- linux-2.5.74-vanilla/drivers/net/8390.c	2003-07-02 16:41:16.000000000 -0400
+++ linux-2.5.74-nx/drivers/net/8390.c	2003-07-03 15:11:00.000000000 -0400
@@ -41,6 +41,7 @@
 			  module by all drivers that require it.
   Alan Cox		: Spinlocking work, added 'BUG_83C690'
   Paul Gortmaker	: Separate out Tx timeout code from Tx path.
+  Josef "Jeff" Sipek	: Added support for new network statistics API
 
   Sources:
   The National Semiconductor LAN Databook, and the 3Com 3c503 databook.
@@ -225,7 +226,7 @@
 	int txsr, isr, tickssofar = jiffies - dev->trans_start;
 	unsigned long flags;
 
-	ei_local->stat.tx_errors++;
+	net_stats_inc(tx_errors,&ei_local->stat);
 
 	spin_lock_irqsave(&ei_local->page_lock, flags);
 	txsr = inb(e8390_base+EN0_TSR);
@@ -236,7 +237,7 @@
 		dev->name, (txsr & ENTSR_ABT) ? "excess collisions." :
 		(isr) ? "lost interrupt?" : "cable problem?", txsr, isr, tickssofar);
 
-	if (!isr && !ei_local->stat.tx_packets) 
+	if (!isr && !net_stats_get(tx_packets,&ei_local->stat)) 
 	{
 		/* The 8390 probably hasn't gotten on the cable yet. */
 		ei_local->interface_num ^= 1;   /* Try a different xcvr.  */
@@ -332,7 +333,7 @@
 		outb_p(ENISR_ALL, e8390_base + EN0_IMR);
 		spin_unlock(&ei_local->page_lock);
 		enable_irq(dev->irq);
-		ei_local->stat.tx_errors++;
+		net_stats_inc(tx_errors,&ei_local->stat);
 		return 1;
 	}
 
@@ -403,7 +404,7 @@
 	enable_irq(dev->irq);
 
 	dev_kfree_skb (skb);
-	ei_local->stat.tx_bytes += send_length;
+	net_stats_add(tx_bytes,&ei_local->stat,send_length);
     
 	return 0;
 }
@@ -489,9 +490,9 @@
 
 		if (interrupts & ENISR_COUNTERS) 
 		{
-			ei_local->stat.rx_frame_errors += inb_p(e8390_base + EN0_COUNTER0);
-			ei_local->stat.rx_crc_errors   += inb_p(e8390_base + EN0_COUNTER1);
-			ei_local->stat.rx_missed_errors+= inb_p(e8390_base + EN0_COUNTER2);
+			net_stats_add(rx_frame_errors,&ei_local->stat,inb_p(e8390_base + EN0_COUNTER0));
+			net_stats_add(rx_crc_errors,&ei_local->stat,inb_p(e8390_base + EN0_COUNTER1));
+			net_stats_add(rx_missed_errors,&ei_local->stat,inb_p(e8390_base + EN0_COUNTER2));
 			outb_p(ENISR_COUNTERS, e8390_base + EN0_ISR); /* Ack intr. */
 		}
 		
@@ -565,10 +566,10 @@
 		ei_tx_intr(dev);
 	else 
 	{
-		ei_local->stat.tx_errors++;
-		if (txsr & ENTSR_CRS) ei_local->stat.tx_carrier_errors++;
-		if (txsr & ENTSR_CDH) ei_local->stat.tx_heartbeat_errors++;
-		if (txsr & ENTSR_OWC) ei_local->stat.tx_window_errors++;
+		net_stats_inc(tx_errors,&ei_local->stat);
+		if (txsr & ENTSR_CRS) net_stats_inc(tx_carrier_errors,&ei_local->stat);
+		if (txsr & ENTSR_CDH) net_stats_inc(tx_heartbeat_errors,&ei_local->stat);
+		if (txsr & ENTSR_OWC) net_stats_inc(tx_window_errors,&ei_local->stat);
 	}
 }
 
@@ -641,25 +642,25 @@
 
 	/* Minimize Tx latency: update the statistics after we restart TXing. */
 	if (status & ENTSR_COL)
-		ei_local->stat.collisions++;
+		net_stats_inc(collisions,&ei_local->stat);
 	if (status & ENTSR_PTX)
-		ei_local->stat.tx_packets++;
+		net_stats_inc(tx_packets,&ei_local->stat);
 	else 
 	{
-		ei_local->stat.tx_errors++;
+		net_stats_inc(tx_errors,&ei_local->stat);
 		if (status & ENTSR_ABT) 
 		{
-			ei_local->stat.tx_aborted_errors++;
-			ei_local->stat.collisions += 16;
+			net_stats_inc(tx_aborted_errors,&ei_local->stat);
+			net_stats_add(collisions,&ei_local->stat,16);
 		}
 		if (status & ENTSR_CRS) 
-			ei_local->stat.tx_carrier_errors++;
+			net_stats_inc(tx_carrier_errors,&ei_local->stat);
 		if (status & ENTSR_FU) 
-			ei_local->stat.tx_fifo_errors++;
+			net_stats_inc(tx_fifo_errors,&ei_local->stat);
 		if (status & ENTSR_CDH)
-			ei_local->stat.tx_heartbeat_errors++;
+			net_stats_inc(tx_heartbeat_errors,&ei_local->stat);
 		if (status & ENTSR_OWC)
-			ei_local->stat.tx_window_errors++;
+			net_stats_inc(tx_window_errors,&ei_local->stat);
 	}
 	netif_wake_queue(dev);
 }
@@ -726,7 +727,7 @@
 			&& rx_frame.next != next_frame + 1 - num_rx_pages) {
 			ei_local->current_page = rxing_page;
 			outb(ei_local->current_page-1, e8390_base+EN0_BOUNDARY);
-			ei_local->stat.rx_errors++;
+			net_stats_inc(rx_errors,&ei_local->stat);
 			continue;
 		}
 
@@ -736,8 +737,8 @@
 				printk(KERN_DEBUG "%s: bogus packet size: %d, status=%#2x nxpg=%#2x.\n",
 					   dev->name, rx_frame.count, rx_frame.status,
 					   rx_frame.next);
-			ei_local->stat.rx_errors++;
-			ei_local->stat.rx_length_errors++;
+			net_stats_inc(rx_errors,&ei_local->stat);
+			net_stats_inc(rx_length_errors,&ei_local->stat);
 		}
 		 else if ((pkt_stat & 0x0F) == ENRSR_RXOK) 
 		{
@@ -749,7 +750,7 @@
 				if (ei_debug > 1)
 					printk(KERN_DEBUG "%s: Couldn't allocate a sk_buff of size %d.\n",
 						   dev->name, pkt_len);
-				ei_local->stat.rx_dropped++;
+				net_stats_inc(rx_dropped,&ei_local->stat);
 				break;
 			}
 			else
@@ -761,10 +762,10 @@
 				skb->protocol=eth_type_trans(skb,dev);
 				netif_rx(skb);
 				dev->last_rx = jiffies;
-				ei_local->stat.rx_packets++;
-				ei_local->stat.rx_bytes += pkt_len;
+				net_stats_inc(rx_packets,&ei_local->stat);
+				net_stats_add(rx_bytes,&ei_local->stat,pkt_len);
 				if (pkt_stat & ENRSR_PHY)
-					ei_local->stat.multicast++;
+					net_stats_inc(multicast,&ei_local->stat);
 			}
 		} 
 		else 
@@ -773,10 +774,10 @@
 				printk(KERN_DEBUG "%s: bogus packet: status=%#2x nxpg=%#2x size=%d\n",
 					   dev->name, rx_frame.status, rx_frame.next,
 					   rx_frame.count);
-			ei_local->stat.rx_errors++;
+			net_stats_inc(rx_errors,&ei_local->stat);
 			/* NB: The NIC counts CRC, frame and missed errors. */
 			if (pkt_stat & ENRSR_FO)
-				ei_local->stat.rx_fifo_errors++;
+				net_stats_inc(rx_fifo_errors,&ei_local->stat);
 		}
 		next_frame = rx_frame.next;
 		
@@ -824,7 +825,7 @@
     
 	if (ei_debug > 1)
 		printk(KERN_DEBUG "%s: Receiver overrun.\n", dev->name);
-	ei_local->stat.rx_over_errors++;
+	net_stats_inc(rx_over_errors,&ei_local->stat);
     
 	/* 
 	 * Wait a full Tx time (1.2ms) + some guard time, NS says 1.6ms total.
@@ -890,9 +891,9 @@
 
 	spin_lock_irqsave(&ei_local->page_lock,flags);
 	/* Read the counter registers, assuming we are in page 0. */
-	ei_local->stat.rx_frame_errors += inb_p(ioaddr + EN0_COUNTER0);
-	ei_local->stat.rx_crc_errors   += inb_p(ioaddr + EN0_COUNTER1);
-	ei_local->stat.rx_missed_errors+= inb_p(ioaddr + EN0_COUNTER2);
+	net_stats_add(rx_frame_errors, &ei_local->stat,inb_p(ioaddr + EN0_COUNTER0));
+	net_stats_add(rx_crc_errors,   &ei_local->stat,inb_p(ioaddr + EN0_COUNTER1));
+	net_stats_add(rx_missed_errors,&ei_local->stat,inb_p(ioaddr + EN0_COUNTER2));
 	spin_unlock_irqrestore(&ei_local->page_lock, flags);
     
 	return &ei_local->stat;
@@ -1022,6 +1023,9 @@
 		spin_lock_init(&ei_local->page_lock);
 	}
     
+	/* Init net_device_stats struct */
+	net_stats_init(&((struct ei_device *) dev->priv)->stat);
+
 	dev->hard_start_xmit = &ei_start_xmit;
 	dev->get_stats	= get_stats;
 	dev->set_multicast_list = &set_multicast_list;
diff -X dontdiff -Naur linux-2.5.74-vanilla/drivers/net/dummy.c linux-2.5.74-nx/drivers/net/dummy.c
--- linux-2.5.74-vanilla/drivers/net/dummy.c	2003-07-02 16:46:50.000000000 -0400
+++ linux-2.5.74-nx/drivers/net/dummy.c	2003-07-03 15:11:00.000000000 -0400
@@ -26,6 +26,8 @@
 			Nick Holloway, 27th May 1994
 	[I tweaked this explanation a little but that's all]
 			Alan Cox, 30th May 1994
+			Josef "Jeff" Sipek, 2nd July 2003
+				added new network statistics API support
 */
 
 /* To have statistics (just packets sent) define this */
@@ -53,6 +55,9 @@
 
 static void __init dummy_setup(struct net_device *dev)
 {
+	/* Init net_device_stats struct */
+	net_stats_init((struct net_device_stats *) dev->priv);
+	
 	/* Initialize the device structure. */
 	dev->get_stats = dummy_get_stats;
 	dev->hard_start_xmit = dummy_xmit;
@@ -73,8 +78,8 @@
 {
 	struct net_device_stats *stats = dev->priv;
 
-	stats->tx_packets++;
-	stats->tx_bytes+=skb->len;
+	net_stats_inc(tx_packets,stats);
+	net_stats_add(tx_bytes,stats,skb->len);
 
 	dev_kfree_skb(skb);
 	return 0;
@@ -101,6 +106,7 @@
 		kfree(dev_dummy);
 		dev_dummy = NULL;
 	}
+
 	return err;
 }
 
diff -X dontdiff -Naur linux-2.5.74-vanilla/drivers/net/eepro100.c linux-2.5.74-nx/drivers/net/eepro100.c
--- linux-2.5.74-vanilla/drivers/net/eepro100.c	2003-07-02 16:50:17.000000000 -0400
+++ linux-2.5.74-nx/drivers/net/eepro100.c	2003-07-03 15:11:00.000000000 -0400
@@ -25,6 +25,8 @@
 		PCI DMA API fixes, adding pci_dma_sync_single calls where neccesary
 	2000 Aug 31 David Mosberger <davidm@hpl.hp.com>
 		rx_align support: enables rx DMA without causing unaligned accesses.
+	2003 Jul 2 Josef "Jeff" Sipek <jeffpc@optonline.net>
+		new network statistics API support added
 */
 
 static const char *version =
@@ -877,6 +879,9 @@
 	if (sp->rx_bug)
 		printk(KERN_INFO "  Receiver lock-up workaround activated.\n");
 
+	/* Init net_device_stats struct */
+	net_stats_init(&sp->stats);
+
 	/* The Speedo-specific entries in the device structure. */
 	dev->open = &speedo_open;
 	dev->hard_start_xmit = &speedo_start_xmit;
@@ -1336,7 +1341,7 @@
 	while ((int)(sp->cur_tx - sp->dirty_tx) > 0) {
 		entry = sp->dirty_tx % TX_RING_SIZE;
 		if (sp->tx_skbuff[entry]) {
-			sp->stats.tx_errors++;
+			net_stats_inc(tx_errors,&sp->stats);
 			pci_unmap_single(sp->pdev,
 					le32_to_cpu(sp->tx_ring[entry].tx_buf_addr0),
 					sp->tx_skbuff[entry]->len, PCI_DMA_TODEVICE);
@@ -1539,8 +1544,8 @@
 			}
 		/* Free the original skb. */
 		if (sp->tx_skbuff[entry]) {
-			sp->stats.tx_packets++;	/* Count only user packets. */
-			sp->stats.tx_bytes += sp->tx_skbuff[entry]->len;
+			net_stats_inc(tx_packets,&sp->stats);	/* Count only user packets. */
+			net_stats_add(tx_bytes,&sp->stats,sp->tx_skbuff[entry]->len);
 			pci_unmap_single(sp->pdev,
 					le32_to_cpu(sp->tx_ring[entry].tx_buf_addr0),
 					sp->tx_skbuff[entry]->len, PCI_DMA_TODEVICE);
@@ -1815,7 +1820,7 @@
 					   "status %8.8x!\n", dev->name, status);
 			else if (! (status & RxOK)) {
 				/* There was a fatal error.  This *should* be impossible. */
-				sp->stats.rx_errors++;
+				net_stats_inc(rx_errors,&sp->stats);
 				printk(KERN_ERR "%s: Anomalous event in speedo_rx(), "
 					   "status %8.8x.\n",
 					   dev->name, status);
@@ -1860,8 +1865,8 @@
 			skb->protocol = eth_type_trans(skb, dev);
 			netif_rx(skb);
 			dev->last_rx = jiffies;
-			sp->stats.rx_packets++;
-			sp->stats.rx_bytes += pkt_len;
+			net_stats_inc(rx_packets,&sp->stats);
+			net_stats_add(rx_bytes,&sp->stats,pkt_len);
 		}
 		entry = (++sp->cur_rx) % RX_RING_SIZE;
 		sp->rx_ring_state &= ~RrPostponed;
@@ -1967,17 +1972,17 @@
 
 	/* Update only if the previous dump finished. */
 	if (sp->lstats->done_marker == le32_to_cpu(0xA007)) {
-		sp->stats.tx_aborted_errors += le32_to_cpu(sp->lstats->tx_coll16_errs);
-		sp->stats.tx_window_errors += le32_to_cpu(sp->lstats->tx_late_colls);
-		sp->stats.tx_fifo_errors += le32_to_cpu(sp->lstats->tx_underruns);
-		sp->stats.tx_fifo_errors += le32_to_cpu(sp->lstats->tx_lost_carrier);
-		/*sp->stats.tx_deferred += le32_to_cpu(sp->lstats->tx_deferred);*/
-		sp->stats.collisions += le32_to_cpu(sp->lstats->tx_total_colls);
-		sp->stats.rx_crc_errors += le32_to_cpu(sp->lstats->rx_crc_errs);
-		sp->stats.rx_frame_errors += le32_to_cpu(sp->lstats->rx_align_errs);
-		sp->stats.rx_over_errors += le32_to_cpu(sp->lstats->rx_resource_errs);
-		sp->stats.rx_fifo_errors += le32_to_cpu(sp->lstats->rx_overrun_errs);
-		sp->stats.rx_length_errors += le32_to_cpu(sp->lstats->rx_runt_errs);
+		net_stats_add(tx_aborted_errors,&sp->stats,le32_to_cpu(sp->lstats->tx_coll16_errs));
+		net_stats_add(tx_window_errors,&sp->stats,le32_to_cpu(sp->lstats->tx_late_colls));
+		net_stats_add(tx_fifo_errors,&sp->stats,le32_to_cpu(sp->lstats->tx_underruns));
+		net_stats_add(tx_fifo_errors,&sp->stats,le32_to_cpu(sp->lstats->tx_lost_carrier));
+		/*net_stats_add(tx_defered,&sp->stats,le32_to_cpu(sp->lstats->tx_deferred));*/
+		net_stats_add(collisions,&sp->stats,le32_to_cpu(sp->lstats->tx_total_colls));
+		net_stats_add(rx_crc_errors,&sp->stats,le32_to_cpu(sp->lstats->rx_crc_errs));
+		net_stats_add(rx_frame_errors,&sp->stats,le32_to_cpu(sp->lstats->rx_align_errs));
+		net_stats_add(rx_over_errors,&sp->stats,le32_to_cpu(sp->lstats->rx_resource_errs));
+		net_stats_add(rx_fifo_errors,&sp->stats,le32_to_cpu(sp->lstats->rx_overrun_errs));
+		net_stats_add(rx_length_errors,&sp->stats,le32_to_cpu(sp->lstats->rx_runt_errs));
 		sp->lstats->done_marker = 0x0000;
 		if (netif_running(dev)) {
 			unsigned long flags;
diff -X dontdiff -Naur linux-2.5.74-vanilla/drivers/net/loopback.c linux-2.5.74-nx/drivers/net/loopback.c
--- linux-2.5.74-vanilla/drivers/net/loopback.c	2003-07-02 16:41:54.000000000 -0400
+++ linux-2.5.74-nx/drivers/net/loopback.c	2003-07-03 15:11:00.000000000 -0400
@@ -10,6 +10,7 @@
  * Authors:	Ross Biro, <bir7@leland.Stanford.Edu>
  *		Fred N. van Kempen, <waltje@uWalt.NL.Mugnet.ORG>
  *		Donald Becker, <becker@scyld.com>
+ *		Josef "Jeff" Sipek, <jeffpc@optonline.net>
  *
  *		Alan Cox	:	Fixed oddments for NET3.014
  *		Alan Cox	:	Rejig for NET3.029 snap #3
@@ -22,6 +23,8 @@
  *                                      interface.
  *		Alexey Kuznetsov:	Potential hang under some extreme
  *					cases removed.
+ *		Josef "Jeff" Sipek:	Added support for net network
+ 					statistics API
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -160,10 +163,10 @@
 	}
 
 	dev->last_rx = jiffies;
-	stats->rx_bytes+=skb->len;
-	stats->tx_bytes+=skb->len;
-	stats->rx_packets++;
-	stats->tx_packets++;
+	net_stats_add(rx_bytes,stats,skb->len);
+	net_stats_add(tx_bytes,stats,skb->len);
+	net_stats_inc(rx_packets,stats);
+	net_stats_inc(tx_packets,stats);
 
 	netif_rx(skb);
 
@@ -200,6 +203,10 @@
 	if (dev->priv == NULL)
 			return -ENOMEM;
 	memset(dev->priv, 0, sizeof(struct net_device_stats));
+	
+	/* Init net_device_stats struct */
+	net_stats_init((struct net_device_stats*) dev->priv);
+	
 	dev->get_stats = get_stats;
 
 	/*
diff -X dontdiff -Naur linux-2.5.74-vanilla/drivers/net/pcnet32.c linux-2.5.74-nx/drivers/net/pcnet32.c
--- linux-2.5.74-vanilla/drivers/net/pcnet32.c	2003-07-02 16:43:55.000000000 -0400
+++ linux-2.5.74-nx/drivers/net/pcnet32.c	2003-07-03 15:11:00.000000000 -0400
@@ -20,6 +20,13 @@
  *  Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
  *
  *************************************************************************/
+/**************************************************************************
+ *  2 Jul, 2003.
+ *  Added support for new network statistics API
+ *
+ *  Copyright (C) 2003 Josef "Jeff" Sipek <jeffpc@optonline.net>
+ *
+ *************************************************************************/
 
 #define DRV_NAME	"pcnet32"
 #define DRV_VERSION	"1.27b"
@@ -803,6 +810,9 @@
     lp->watchdog_timer.data = (unsigned long) dev;
     lp->watchdog_timer.function = (void *) &pcnet32_watchdog;
     
+    /* Init net_device_stats struct */
+    net_stats_init(&lp->stats);
+
     /* The PCNET32-specific entries in the device structure. */
     dev->open = &pcnet32_open;
     dev->hard_start_xmit = &pcnet32_start_xmit;
@@ -1058,7 +1068,7 @@
 	printk(KERN_ERR "%s: transmit timed out, status %4.4x, resetting.\n",
 	       dev->name, lp->a.read_csr(ioaddr, 0));
 	lp->a.write_csr (ioaddr, 0, 0x0004);
-	lp->stats.tx_errors++;
+	net_stats_inc(tx_errors,&lp->stats);
 	if (pcnet32_debug > 2) {
 	    int i;
 	    printk(KERN_DEBUG " Ring data dump: dirty_tx %d cur_tx %d%s cur_rx %d.",
@@ -1134,7 +1144,7 @@
     lp->tx_ring[entry].status = le16_to_cpu(status);
 
     lp->cur_tx++;
-    lp->stats.tx_bytes += skb->len;
+    net_stats_add(tx_bytes,&lp->stats,skb->len);
 
     /* Trigger an immediate send poll. */
     lp->a.write_csr (ioaddr, 0, 0x0048);
@@ -1202,13 +1212,13 @@
 		if (status & 0x4000) {
 		    /* There was an major error, log it. */
 		    int err_status = le32_to_cpu(lp->tx_ring[entry].misc);
-		    lp->stats.tx_errors++;
-		    if (err_status & 0x04000000) lp->stats.tx_aborted_errors++;
-		    if (err_status & 0x08000000) lp->stats.tx_carrier_errors++;
-		    if (err_status & 0x10000000) lp->stats.tx_window_errors++;
+		    net_stats_inc(tx_errors,&lp->stats);
+		    if (err_status & 0x04000000) net_stats_inc(tx_aborted_errors,&lp->stats);
+		    if (err_status & 0x08000000) net_stats_inc(tx_carrier_errors,&lp->stats);
+		    if (err_status & 0x10000000) net_stats_inc(tx_window_errors,&lp->stats);
 #ifndef DO_DXSUFLO
 		    if (err_status & 0x40000000) {
-			lp->stats.tx_fifo_errors++;
+			net_stats_inc(tx_fifo_errors,&lp->stats);
 			/* Ackk!  On FIFO errors the Tx unit is turned off! */
 			/* Remove this verbosity later! */
 			printk(KERN_ERR "%s: Tx FIFO error! CSR0=%4.4x\n",
@@ -1217,7 +1227,7 @@
 		    }
 #else
 		    if (err_status & 0x40000000) {
-			lp->stats.tx_fifo_errors++;
+			net_stats_inc(tx_fifo_errors,&lp->stats);
 			if (! lp->dxsuflo) {  /* If controller doesn't recover ... */
 			    /* Ackk!  On FIFO errors the Tx unit is turned off! */
 			    /* Remove this verbosity later! */
@@ -1229,8 +1239,8 @@
 #endif
 		} else {
 		    if (status & 0x1800)
-			lp->stats.collisions++;
-		    lp->stats.tx_packets++;
+			net_stats_inc(collisions,&lp->stats);
+		    net_stats_inc(tx_packets,&lp->stats);
 		}
 
 		/* We must free the original skb */
@@ -1261,7 +1271,7 @@
 	}
 
 	/* Log misc errors. */
-	if (csr0 & 0x4000) lp->stats.tx_errors++; /* Tx babble. */
+	if (csr0 & 0x4000) net_stats_inc(tx_errors,&lp->stats); /* Tx babble. */
 	if (csr0 & 0x1000) {
 	    /*
 	     * this happens when our receive ring is full. This shouldn't
@@ -1273,7 +1283,7 @@
 	     * or later. So we try to clean up our receive ring here.
 	     */
 	    pcnet32_rx(dev);
-	    lp->stats.rx_errors++; /* Missed a Rx frame. */
+	    net_stats_inc(rx_errors,&lp->stats); /* Missed a Rx frame. */
 	}
 	if (csr0 & 0x0800) {
 	    printk(KERN_ERR "%s: Bus master arbitration failure, status %4.4x.\n",
@@ -1319,11 +1329,11 @@
 	     * buffers, with only the last correctly noting the error.
 	     */
 	    if (status & 0x01)	/* Only count a general error at the */
-		lp->stats.rx_errors++; /* end of a packet.*/
-	    if (status & 0x20) lp->stats.rx_frame_errors++;
-	    if (status & 0x10) lp->stats.rx_over_errors++;
-	    if (status & 0x08) lp->stats.rx_crc_errors++;
-	    if (status & 0x04) lp->stats.rx_fifo_errors++;
+		net_stats_inc(rx_errors,&lp->stats); /* end of a packet.*/
+	    if (status & 0x20) net_stats_inc(rx_frame_errors,&lp->stats);
+	    if (status & 0x10) net_stats_inc(rx_over_errors,&lp->stats);
+	    if (status & 0x08) net_stats_inc(rx_crc_errors,&lp->stats);
+	    if (status & 0x04) net_stats_inc(rx_fifo_errors,&lp->stats);
 	    lp->rx_ring[entry].status &= le16_to_cpu(0x03ff);
 	} else {
 	    /* Malloc up new buffer, compatible with net-2e. */
@@ -1332,7 +1342,7 @@
 			
 	    if(pkt_len < 60) {
 		printk(KERN_ERR "%s: Runt packet!\n",dev->name);
-		lp->stats.rx_errors++;
+		net_stats_inc(rx_errors,&lp->stats);
 	    } else {
 		int rx_in_place = 0;
 
@@ -1365,7 +1375,7 @@
 			    break;
 
 		    if (i > RX_RING_SIZE -2) {
-			lp->stats.rx_dropped++;
+			net_stats_inc(rx_dropped,&lp->stats);
 			lp->rx_ring[entry].status |= le16_to_cpu(0x8000);
 			lp->cur_rx++;
 		    }
@@ -1379,11 +1389,11 @@
 				     (unsigned char *)(lp->rx_skbuff[entry]->tail),
 				     pkt_len,0);
 		}
-		lp->stats.rx_bytes += skb->len;
+		net_stats_add(rx_bytes,&lp->stats,skb->len);
 		skb->protocol=eth_type_trans(skb,dev);
 		netif_rx(skb);
 		dev->last_rx = jiffies;
-		lp->stats.rx_packets++;
+		net_stats_inc(rx_packets,&lp->stats);
 	    }
 	}
 	/*
@@ -1409,7 +1419,7 @@
 
     netif_stop_queue(dev);
 
-    lp->stats.rx_missed_errors = lp->a.read_csr (ioaddr, 112);
+    net_stats_set(rx_missed_errors,&lp->stats,lp->a.read_csr (ioaddr, 112));
 
     if (pcnet32_debug > 1)
 	printk(KERN_DEBUG "%s: Shutting down ethercard, status was %2.2x.\n",
@@ -1459,7 +1469,7 @@
 
     spin_lock_irqsave(&lp->lock, flags);
     saved_addr = lp->a.read_rap(ioaddr);
-    lp->stats.rx_missed_errors = lp->a.read_csr (ioaddr, 112);
+    net_stats_set(rx_missed_errors,&lp->stats,lp->a.read_csr (ioaddr, 112));
     lp->a.write_rap(ioaddr, saved_addr);
     spin_unlock_irqrestore(&lp->lock, flags);
 

--Boundary_(ID_ECMZzh6OK+iu3ddWfFE1TQ)--
