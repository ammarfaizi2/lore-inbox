Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTELJzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTELJru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:47:50 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:31315 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262038AbTELJpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:12 -0400
Date: Mon, 12 May 2003 11:54:43 +0200
Message-Id: <200305120954.h4C9shoT001051@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [17/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k net drivers: Update to the new irq API (from Roman Zippel and me) [17/20]

--- linux-2.5.69/drivers/net/82596.c	Mon May  5 10:31:25 2003
+++ linux-m68k-2.5.69/drivers/net/82596.c	Fri May  9 10:21:32 2003
@@ -501,7 +501,7 @@
 
 
 #if defined(ENABLE_MVME16x_NET) || defined(ENABLE_BVME6000_NET)
-static void i596_error(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t i596_error(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_id;
 #ifdef ENABLE_MVME16x_NET
@@ -522,6 +522,7 @@
 #endif
 	printk(KERN_ERR "%s: Error interrupt\n", dev->name);
 	i596_display_data(dev);
+	return IRQ_HANDLED;
 }
 #endif
 
@@ -1004,13 +1005,13 @@
 
 	DEB(DEB_OPEN,printk(KERN_DEBUG "%s: i596_open() irq %d.\n", dev->name, dev->irq));
 
-	if (request_irq(dev->irq, &i596_interrupt, 0, "i82596", dev)) {
+	if (request_irq(dev->irq, i596_interrupt, 0, "i82596", dev)) {
 		printk(KERN_ERR "%s: IRQ %d not free\n", dev->name, dev->irq);
 		return -EAGAIN;
 	}
 #ifdef ENABLE_MVME16x_NET
 	if (MACH_IS_MVME16x) {
-		if (request_irq(0x56, &i596_error, 0, "i82596_error", dev))
+		if (request_irq(0x56, i596_error, 0, "i82596_error", dev))
 			return -EAGAIN;
 	}
 #endif
--- linux-2.5.69/drivers/net/apne.c	Tue Mar 25 10:06:42 2003
+++ linux-m68k-2.5.69/drivers/net/apne.c	Fri May  9 10:21:32 2003
@@ -85,7 +85,7 @@
 								struct sk_buff *skb, int ring_offset);
 static void apne_block_output(struct net_device *dev, const int count,
 							const unsigned char *buf, const int start_page);
-static void apne_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t apne_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 static int init_pcmcia(void);
 
@@ -511,18 +511,18 @@
     return;
 }
 
-static void apne_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t apne_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
     unsigned char pcmcia_intreq;
 
     if (!(gayle.inten & GAYLE_IRQ_IRQ))
-        return;
+        return IRQ_NONE;
 
     pcmcia_intreq = pcmcia_get_intreq();
 
     if (!(pcmcia_intreq & GAYLE_IRQ_IRQ)) {
         pcmcia_ack_int(pcmcia_intreq);
-        return;
+        return IRQ_NONE;
     }
     if (ei_debug > 3)
         printk("pcmcia intreq = %x\n", pcmcia_intreq);
@@ -530,6 +530,7 @@
     ei_interrupt(irq, dev_id, regs);
     pcmcia_ack_int(pcmcia_get_intreq());
     pcmcia_enable_irq();
+    return IRQ_HANDLED;
 }
 
 #ifdef MODULE
--- linux-2.5.69/drivers/net/atari_bionet.c	Thu Jan  9 10:20:00 2003
+++ linux-m68k-2.5.69/drivers/net/atari_bionet.c	Fri May  9 10:21:32 2003
@@ -221,9 +221,9 @@
 	return c;
 }
 
-static void
+static irqreturn_t
 bionet_intr(int irq, void *data, struct pt_regs *fp) {
-	return;
+	return IRQ_HANDLED;
 }
 
 
--- linux-2.5.69/drivers/net/atari_pamsnet.c	Thu Jan  2 12:54:31 2003
+++ linux-m68k-2.5.69/drivers/net/atari_pamsnet.c	Fri May  9 10:21:32 2003
@@ -167,7 +167,7 @@
 static struct net_device_stats *net_get_stats(struct net_device *dev);
 static void pamsnet_tick(unsigned long);
 
-static void pamsnet_intr(int irq, void *data, struct pt_regs *fp);
+static irqreturn_t pamsnet_intr(int irq, void *data, struct pt_regs *fp);
 
 static struct timer_list pamsnet_timer = TIMER_INITIALIZER(amsnet_tick, 0, 0);
 
@@ -494,13 +494,13 @@
 	return (ret);
 }
 
-static void
+static irqreturn_t
 pamsnet_intr(irq, data, fp)
 	int irq;
 	void *data;
 	struct pt_regs *fp;
 {
-	return;
+	return IRQ_HANDLED;
 }
 
 /* receivepkt() loads a packet to a given buffer and returns its length */
--- linux-2.5.69/drivers/net/mace.c	Tue Apr  8 10:05:14 2003
+++ linux-m68k-2.5.69/drivers/net/mace.c	Fri May  9 10:21:32 2003
@@ -86,7 +86,7 @@
 static void mace_set_multicast(struct net_device *dev);
 static void mace_reset(struct net_device *dev);
 static int mace_set_address(struct net_device *dev, void *addr);
-static void mace_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t mace_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static void mace_txdma_intr(int irq, void *dev_id, struct pt_regs *regs);
 static void mace_rxdma_intr(int irq, void *dev_id, struct pt_regs *regs);
 static void mace_set_timeout(struct net_device *dev);
@@ -622,7 +622,7 @@
 	    printk(KERN_DEBUG "mace: jabbering transceiver\n");
 }
 
-static void mace_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mace_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
     struct net_device *dev = (struct net_device *) dev_id;
     struct mace_data *mp = (struct mace_data *) dev->priv;
@@ -833,11 +833,11 @@
     spin_unlock_irqrestore(&mp->lock, flags);
 }
 
-static void mace_txdma_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mace_txdma_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 }
 
-static void mace_rxdma_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mace_rxdma_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
     struct net_device *dev = (struct net_device *) dev_id;
     struct mace_data *mp = (struct mace_data *) dev->priv;
--- linux-2.5.69/drivers/net/macmace.c	Sun Apr 20 12:28:38 2003
+++ linux-m68k-2.5.69/drivers/net/macmace.c	Fri May  9 10:21:32 2003
@@ -77,8 +77,8 @@
 static struct net_device_stats *mace_stats(struct net_device *dev);
 static void mace_set_multicast(struct net_device *dev);
 static int mace_set_address(struct net_device *dev, void *addr);
-static void mace_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-static void mace_dma_intr(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t mace_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t mace_dma_intr(int irq, void *dev_id, struct pt_regs *regs);
 static void mace_tx_timeout(struct net_device *dev);
 
 /* Bit-reverse one byte of an ethernet hardware address. */
@@ -561,7 +561,7 @@
  * Process the chip interrupt
  */
  
-static void mace_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mace_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct mace_data *mp = (struct mace_data *) dev->priv;
@@ -577,6 +577,7 @@
 	if (ir & RCVINT) {
 		mace_recv_interrupt(dev);
 	}
+	return IRQ_HANDLED;
 }
 
 static void mace_tx_timeout(struct net_device *dev)
@@ -632,7 +633,7 @@
  * The PSC has passed us a DMA interrupt event.
  */
  
-static void mace_dma_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mace_dma_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *) dev_id;
 	struct mace_data *mp = (struct mace_data *) dev->priv;
@@ -643,7 +644,7 @@
 	/* Not sure what this does */
 
 	while ((baka = psc_read_long(PSC_MYSTERY)) != psc_read_long(PSC_MYSTERY));
-	if (!(baka & 0x60000000)) return;
+	if (!(baka & 0x60000000)) return IRQ_NONE;
 
 	/*
 	 * Process the read queue
@@ -691,6 +692,7 @@
 		mp->tx_count++;
 		netif_wake_queue(dev);
 	}
+	return IRQ_HANDLED;
 }
 
 MODULE_LICENSE("GPL");
--- linux-2.5.69/drivers/net/sun3lance.c	Tue Jan 14 10:09:30 2003
+++ linux-m68k-2.5.69/drivers/net/sun3lance.c	Fri May  9 10:21:33 2003
@@ -238,7 +238,7 @@
 static int lance_open( struct net_device *dev );
 static void lance_init_ring( struct net_device *dev );
 static int lance_start_xmit( struct sk_buff *skb, struct net_device *dev );
-static void lance_interrupt( int irq, void *dev_id, struct pt_regs *fp );
+static irqreturn_t lance_interrupt( int irq, void *dev_id, struct pt_regs *fp );
 static int lance_rx( struct net_device *dev );
 static int lance_close( struct net_device *dev );
 static struct net_device_stats *lance_get_stats( struct net_device *dev );
@@ -620,7 +620,7 @@
 
 /* The LANCE interrupt handler. */
 
-static void lance_interrupt( int irq, void *dev_id, struct pt_regs *fp)
+static irqreturn_t lance_interrupt( int irq, void *dev_id, struct pt_regs *fp)
 {
 	struct net_device *dev = dev_id;
 	struct lance_private *lp = dev->priv;
@@ -629,7 +629,7 @@
 
 	if (dev == NULL) {
 		DPRINTK( 1, ( "lance_interrupt(): invalid dev_id\n" ));
-		return;
+		return IRQ_NONE;
 	}
 
 	if (in_interrupt)
@@ -688,7 +688,7 @@
 					REGA(CSR3) = CSR3_BSWP;
 					lance_init_ring(dev);
 					REGA(CSR0) = CSR0_STRT | CSR0_INEA;
-					return;
+					return IRQ_HANDLED;
 				}
 			} else if(head->flag & (TMD1_ENP | TMD1_STP)) {
 				
@@ -743,7 +743,7 @@
 	DPRINTK( 2, ( "%s: exiting interrupt, csr0=%#04x.\n",
 				  dev->name, DREG ));
 	in_interrupt = 0;
-	return;
+	return IRQ_HANDLED;
 }
 
 /* get packet, toss into skbuff */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
