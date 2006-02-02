Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWBBXxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWBBXxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWBBXxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:53:44 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:29703 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S932489AbWBBXxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:53:41 -0500
Message-Id: <20060202235157.257341000@lorien.sirena.org.uk>
References: <20060202233909.426660000@lorien.sirena.org.uk>
Date: Thu, 02 Feb 2006 00:00:02 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>, Tim Hockin <thockin@hockin.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 2/2] natsemi: NAPI and a bugfix
Content-Disposition: inline; filename=natsemi-an-1287
X-Spam-Score: -2.1 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  As documented in National application note 1287 the RX
	state machine on the natsemi chip can lock up under some conditions
	(mostly related to heavy load). When this happens a series of bogus
	packets are reported by the chip including some oversized frames prior
	to the final lockup. [...] 
	Content analysis details:   (-2.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.7 DATE_IN_PAST_12_24     Date: is 12 to 24 hours before Received: date
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As documented in National application note 1287 the RX state machine on
the natsemi chip can lock up under some conditions (mostly related to
heavy load).  When this happens a series of bogus packets are reported
by the chip including some oversized frames prior to the final lockup.

This patch implements the fix from the application note: when an
oversized packet is reported it resets the RX state machine, dropping
any currently pending packets.

Signed-off-by: Mark Brown <broonie@sirena.org.uk>

Index: linux-2.6.15.2/drivers/net/natsemi.c
===================================================================
--- linux-2.6.15.2.orig/drivers/net/natsemi.c	2006-02-01 22:59:29.000000000 +0000
+++ linux-2.6.15.2/drivers/net/natsemi.c	2006-02-02 00:05:23.000000000 +0000
@@ -1498,6 +1498,31 @@ static void natsemi_reset(struct net_dev
 	writel(rfcr, ioaddr + RxFilterAddr);
 }
 
+static void reset_rx(struct net_device *dev)
+{
+	int i;
+	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = ns_ioaddr(dev);
+
+	np->intr_status &= ~RxResetDone;
+
+	writel(RxReset, ioaddr + ChipCmd);
+
+	for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
+		np->intr_status |= readl(ioaddr + IntrStatus);
+		if (np->intr_status & RxResetDone)
+			break;
+		udelay(15);
+	}
+	if (i==NATSEMI_HW_TIMEOUT) {
+		printk(KERN_WARNING "%s: RX reset did not complete in %d usec.\n",
+		       dev->name, i*15);
+	} else if (netif_msg_hw(np)) {
+		printk(KERN_WARNING "%s: RX reset took %d usec.\n",
+		       dev->name, i*15);
+	}
+}
+
 static void natsemi_reload_eeprom(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
@@ -2292,6 +2317,23 @@ static void netdev_rx(struct net_device 
 						"status %#08x.\n", dev->name,
 						np->cur_rx, desc_status);
 				np->stats.rx_length_errors++;
+
+				/* The RX state machine has probably
+				 * locked up beneath us.  Follow the
+				 * reset procedure documented in
+				 * AN-1287. */
+
+				spin_lock_irq(&np->lock);
+				reset_rx(dev);
+				reinit_rx(dev);
+				writel(np->ring_dma, ioaddr + RxRingPtr);
+				check_link(dev);
+				spin_unlock_irq(&np->lock);
+
+				/* We'll enable RX on exit from this
+				 * function. */
+				break;
+
 			} else {
 				/* There was an error. */
 				np->stats.rx_errors++;

--
"You grabbed my hand and we fell into it, like a daydream - or a fever."
