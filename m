Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275017AbSITExA>; Fri, 20 Sep 2002 00:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275039AbSITEw6>; Fri, 20 Sep 2002 00:52:58 -0400
Received: from sr1.terra.com.br ([200.176.3.16]:60874 "EHLO sr1.terra.com.br")
	by vger.kernel.org with ESMTP id <S275017AbSITEw4>;
	Fri, 20 Sep 2002 00:52:56 -0400
Subject: [PATCH] 8139cp: LinkChg support
From: Felipe W Damasio <felipewd@terra.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Sep 2002 02:00:54 +0000
Message-Id: <1032487254.247.7.camel@tank>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	This patch adds LinkChg support to the 8139cp ethernet driver.

	Patch against 2.5.36.

	Please consider pulling it from:

http://cscience.org/~felipewd/linux/patches-fwd/2.5/8139cp-linkchg.patch

Felipe

--- ./8139cp.c.orig	Fri Sep 20 01:21:20 2002
+++ ./8139cp.c	Fri Sep 20 01:35:05 2002
@@ -22,11 +22,11 @@
 	
 		Wake-on-LAN support - Felipe Damasio <felipewd@terra.com.br>
 		PCI suspend/resume  - Felipe Damasio <felipewd@terra.com.br>
+		LinkChg interrupt   - Felipe Damasio <felipewd@terra.com.br>
 			
 	TODO, in rough priority order:
 	* Test Tx checksumming thoroughly
 	* dev->tx_timeout
-	* LinkChg interrupt
 	* Support forcing media type with a module parameter,
 	  like dl2k.c/sundance.c
 	* Constants (module parms?) for Rx work limit
@@ -396,6 +396,8 @@
 static void __cp_set_rx_mode (struct net_device *dev);
 static void cp_tx (struct cp_private *cp);
 static void cp_clean_rings (struct cp_private *cp);
+static int mdio_read (struct net_device *dev, int phy_id, int location);
+static void mdio_write (struct net_device *dev, int phy_id, int location, int value);
 
 enum board_type {
 	RTL8139Cp,
@@ -655,6 +657,24 @@
 	cp->rx_tail = rx_tail;
 }
 
+static inline void cp_linkchg (struct net_device *dev)
+{
+	struct cp_private *cp = dev->priv;
+	
+	if (mii_link_ok (&cp->mii_if)) {
+		if (netif_msg_link (cp)) {
+			u16 bmcr = mdio_read (dev, cp->mii_if.phy_id, MII_BMCR);
+
+			printk (PFX "Link Changed: %dMbps, %s duplex\n",
+				bmcr & BMCR_SPEED100 ? 100 : 10,
+				bmcr & BMCR_FULLDPLX ? "full" : "half"
+			       );
+		}
+		netif_carrier_on (dev);
+	}
+	else netif_carrier_off (dev); /* Link is down */
+}
+
 static void cp_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_instance;
@@ -675,6 +695,8 @@
 		cp_rx(cp);
 	if (status & (TxOK | TxErr | TxEmpty | SWInt))
 		cp_tx(cp);
+	if (status & LinkChg)
+		cp_linkchg (dev);
 
 	cpw16_f(IntrStatus, status);
 
@@ -1190,6 +1212,9 @@
 	if (rc)
 		goto err_out_hw;
 
+	if (mii_link_ok (&cp->mii_if))
+		netif_carrier_on  (dev);
+	else    netif_carrier_off (dev);
 	netif_start_queue(dev);
 
 	return 0;
@@ -1208,6 +1233,7 @@
 		printk(KERN_DEBUG "%s: disabling interface\n", dev->name);
 
 	netif_stop_queue(dev);
+	netif_carrier_off (dev);
 	cp_stop_hw(cp);
 	free_irq(dev->irq, dev);
 	cp_free_rings(cp);

