Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVAEKb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVAEKb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 05:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVAEKb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 05:31:27 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:45514 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262284AbVAEKbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 05:31:19 -0500
Subject: [PATCH] sis900.c net poll support
From: Brancaleoni Matteo <mbrancaleoni@tiscali.it>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-wOoOx+UdN0gQ6NL5Mx1x"
Date: Wed, 05 Jan 2005 11:32:07 +0100
Message-Id: <1104921127.5729.17.camel@athlon64>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wOoOx+UdN0gQ6NL5Mx1x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

I was in need to use netconsole to trace some lock
of my sata disk, but my onboard network card (sis900)
seems doesn't support net poll.
So searching the web I found out an old patch for enabling
in under 2.4, and ported it to 2.6.10 (looking
also into 2.6.x device drivers already working)

Seems to be ok, netconsole works without issues.
Hope that's ok and can be useful.

Matteo Brancaleoni.

--=-wOoOx+UdN0gQ6NL5Mx1x
Content-Disposition: attachment; filename=sis900.patch
Content-Type: text/x-patch; name=sis900.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.6.10/drivers/net/sis900.orig	2005-01-05 09:55:46.000000000 +0100
+++ linux-2.6.10/drivers/net/sis900.c	2005-01-05 10:09:04.000000000 +0100
@@ -185,6 +185,7 @@ MODULE_PARM_DESC(multicast_filter_limit,
 MODULE_PARM_DESC(max_interrupt_work, "SiS 900/7016 maximum events handled per interrupt");
 MODULE_PARM_DESC(debug, "SiS 900/7016 debug level (2-4)");
 
+static void sis900_poll(struct net_device *dev);
 static int sis900_open(struct net_device *net_dev);
 static int sis900_mii_probe (struct net_device * net_dev);
 static void sis900_init_rxfilter (struct net_device * net_dev);
@@ -454,6 +455,9 @@ static int __devinit sis900_probe(struct
 	net_dev->tx_timeout = sis900_tx_timeout;
 	net_dev->watchdog_timeo = TX_TIMEOUT;
 	net_dev->ethtool_ops = &sis900_ethtool_ops;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+        net_dev->poll_controller = &sis900_poll;
+#endif
 	
 	ret = register_netdev(net_dev);
 	if (ret)
@@ -928,6 +932,20 @@ static u16 sis900_reset_phy(struct net_d
 	return status;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+*/
+static void sis900_poll(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	sis900_interrupt(dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
+
 /**
  *	sis900_open - open sis900 device
  *	@net_dev: the net device to open

--=-wOoOx+UdN0gQ6NL5Mx1x--

