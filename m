Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTEBBcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 21:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbTEBBcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 21:32:09 -0400
Received: from palrel12.hp.com ([156.153.255.237]:18834 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262855AbTEBBcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 21:32:05 -0400
Date: Thu, 1 May 2003 18:44:14 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] irq fixes for wavelan_cs/netwave_cs
Message-ID: <20030502014414.GA8753@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

        This patch for 2.5.68-bk11 will fix the irq handler of some
obsolete wireless drivers (wavelan, wavelan_cs and netwave_cs) plus
assorted fixes. All those drivers have been tested on a SMP box.

	Have fun...

	Jean


diff -u -p linux/drivers/net/wireless-badirq/netwave_cs.c linux/drivers/net/wireless/netwave_cs.c
--- linux/drivers/net/wireless-badirq/netwave_cs.c	Thu May  1 15:55:19 2003
+++ linux/drivers/net/wireless/netwave_cs.c	Thu May  1 16:49:47 2003
@@ -227,7 +227,7 @@ static int netwave_start_xmit( struct sk
 static int netwave_rx( struct net_device *dev);
 
 /* Interrupt routines */
-static void netwave_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t netwave_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static void netwave_watchdog(struct net_device *);
 
 /* Statistics */
@@ -1456,7 +1456,7 @@ static int netwave_start_xmit(struct sk_
  *	     ready to transmit another packet.
  *	  3. A command has completed execution.
  */
-static void netwave_interrupt(int irq, void* dev_id, struct pt_regs *regs) {
+static irqreturn_t netwave_interrupt(int irq, void* dev_id, struct pt_regs *regs) {
     ioaddr_t iobase;
     u_char *ramBase;
     struct net_device *dev = (struct net_device *)dev_id;
@@ -1465,7 +1465,7 @@ static void netwave_interrupt(int irq, v
     int i;
     
     if (!netif_device_present(dev))
-	return;
+	return IRQ_NONE;
     
     iobase = dev->base_addr;
     ramBase = priv->ramBase;
@@ -1476,7 +1476,7 @@ static void netwave_interrupt(int irq, v
 		
 	wait_WOC(iobase);	
 	if (!(inb(iobase+NETWAVE_REG_CCSR) & 0x02))
-	    break; /* None of the interrupt sources asserted */
+	    break; /* None of the interrupt sources asserted (normal exit) */
 	
         status = inb(iobase + NETWAVE_REG_ASR);
 		
@@ -1569,6 +1569,8 @@ static void netwave_interrupt(int irq, v
 	   }
 	   */
     }
+    /* Handled if we looped at least one time - Jean II */
+    return IRQ_RETVAL(i);
 } /* netwave_interrupt */
 
 /*
diff -u -p linux/drivers/net/wireless-badirq/wavelan.c linux/drivers/net/wireless/wavelan.c
--- linux/drivers/net/wireless-badirq/wavelan.c	Thu May  1 15:55:19 2003
+++ linux/drivers/net/wireless/wavelan.c	Thu May  1 18:21:04 2003
@@ -2884,10 +2884,6 @@ static inline int wv_packet_write(device
 	       length);
 #endif
 
-	/* Do we need some padding? */
-	if (clen < ETH_ZLEN)
-		clen = ETH_ZLEN;
-
 	spin_lock_irqsave(&lp->spinlock, flags);
 
 	/* Check nothing bad has happened */
@@ -3008,12 +3004,6 @@ static int wavelan_packet_xmit(struct sk
 	       (unsigned) skb);
 #endif
 
-	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
-			return 0;
-	}
-
 	/*
 	 * Block a timer-based transmit from overlapping.
 	 * In other words, prevent reentering this routine.
@@ -3035,6 +3025,17 @@ static int wavelan_packet_xmit(struct sk
 	if (skb->next)
 		printk(KERN_INFO "skb has next\n");
 #endif
+
+	/* Do we need some padding? */
+	/* Note : on wireless the propagation time is in the order of 1us,
+	 * and we don't have the Ethernet specific requirement of beeing
+	 * able to detect collisions, therefore in theory we don't really
+	 * need to pad. Jean II */
+	if (skb->len < ETH_ZLEN) {
+		skb = skb_padto(skb, ETH_ZLEN);
+		if (skb == NULL)
+			return 0;
+	}
 
 	/* Write packet on the card */
 	if(wv_packet_write(dev, skb->data, skb->len))
diff -u -p linux/drivers/net/wireless-badirq/wavelan_cs.c linux/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net/wireless-badirq/wavelan_cs.c	Thu May  1 15:55:19 2003
+++ linux/drivers/net/wireless/wavelan_cs.c	Thu May  1 18:08:17 2003
@@ -3581,10 +3581,6 @@ wv_packet_write(device *	dev,
 
   spin_lock_irqsave(&lp->spinlock, flags);
 
-  /* Check if we need some padding */
-  if(clen < ETH_ZLEN)
-    clen = ETH_ZLEN;
-
   /* Write the length of data buffer followed by the buffer */
   outb(xmtdata_base & 0xff, PIORL(base));
   outb(((xmtdata_base >> 8) & PIORH_MASK) | PIORH_SEL_TX, PIORH(base));
@@ -3664,6 +3660,17 @@ wavelan_packet_xmit(struct sk_buff *	skb
 		printk(KERN_INFO "skb has next\n");
 #endif
 
+	/* Check if we need some padding */
+	/* Note : on wireless the propagation time is in the order of 1us,
+	 * and we don't have the Ethernet specific requirement of beeing
+	 * able to detect collisions, therefore in theory we don't really
+	 * need to pad. Jean II */
+	if (skb->len < ETH_ZLEN) {
+		skb = skb_padto(skb, ETH_ZLEN);
+		if (skb == NULL)
+			return 0;
+	}
+
   wv_packet_write(dev, skb->data, skb->len);
 
   dev_kfree_skb(skb);
@@ -4644,7 +4651,7 @@ wv_flush_stale_links(void)
  *	   ready to transmit another packet.
  *	3. A command has completed execution.
  */
-static void
+static irqreturn_t
 wavelan_interrupt(int		irq,
 		  void *	dev_id,
 		  struct pt_regs * regs)
@@ -4661,7 +4668,7 @@ wavelan_interrupt(int		irq,
       printk(KERN_WARNING "wavelan_interrupt(): irq %d for unknown device.\n",
 	     irq);
 #endif
-      return;
+      return IRQ_NONE;
     }
 
 #ifdef DEBUG_INTERRUPT_TRACE
@@ -4883,6 +4890,24 @@ wavelan_interrupt(int		irq,
 #ifdef DEBUG_INTERRUPT_TRACE
   printk(KERN_DEBUG "%s: <-wavelan_interrupt()\n", dev->name);
 #endif
+
+  /* We always return IRQ_HANDLED, because we will receive empty
+   * interrupts under normal operations. Anyway, it doesn't matter
+   * as we are dealing with an ISA interrupt that can't be shared.
+   *
+   * Explanation : under heavy receive, the following happens :
+   * ->wavelan_interrupt()
+   *    (status0 & SR0_INTERRUPT) != 0
+   *       ->wv_packet_rcv()
+   *    (status0 & SR0_INTERRUPT) != 0
+   *       ->wv_packet_rcv()
+   *    (status0 & SR0_INTERRUPT) == 0	// i.e. no more event
+   * <-wavelan_interrupt()
+   * ->wavelan_interrupt()
+   *    (status0 & SR0_INTERRUPT) == 0	// i.e. empty interrupt
+   * <-wavelan_interrupt()
+   * Jean II */
+  return IRQ_HANDLED;
 } /* wv_interrupt */
 
 /*------------------------------------------------------------------*/
diff -u -p linux/drivers/net/wireless-badirq/wavelan_cs.p.h linux/drivers/net/wireless/wavelan_cs.p.h
--- linux/drivers/net/wireless-badirq/wavelan_cs.p.h	Mon Mar 24 14:01:18 2003
+++ linux/drivers/net/wireless/wavelan_cs.p.h	Thu May  1 17:55:25 2003
@@ -686,11 +686,6 @@ void wv_roam_init(struct net_device *dev
 void wv_roam_cleanup(struct net_device *dev);
 #endif	/* WAVELAN_ROAMING */
 
-/* ----------------------- MISC SUBROUTINES ------------------------ */
-static void
-	cs_error(client_handle_t,	/* Report error to cardmgr */
-		 int,
-		 int);
 /* ----------------- MODEM MANAGEMENT SUBROUTINES ----------------- */
 static inline u_char		/* data */
 	hasr_read(u_long);	/* Read the host interface : base address */
@@ -791,7 +786,7 @@ static void
 	wv_pcmcia_release(u_long),	/* Remove a device */
 	wv_flush_stale_links(void);	/* "detach" all possible devices */
 /* ---------------------- INTERRUPT HANDLING ---------------------- */
-static void
+static irqreturn_t
 	wavelan_interrupt(int,	/* Interrupt handler */
 			  void *,
 			  struct pt_regs *);

