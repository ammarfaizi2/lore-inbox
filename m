Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbTHYEFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 00:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbTHYEFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 00:05:18 -0400
Received: from [208.49.116.17] ([208.49.116.17]:52386 "EHLO diesel.grid4.com")
	by vger.kernel.org with ESMTP id S261451AbTHYEFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 00:05:00 -0400
Date: Sun, 24 Aug 2003 23:30:04 -0400
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <akpm@digeo.com>
Subject: [patch 2.6] 3c509.c Fix printed dev id. with patch;(
Message-ID: <20030825033004.GB2062@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Andrew Morton <akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	This time with the patch attached...

Paul
set@pobox.com

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="3c509.c.patch"

--- drivers/net/3c509.c.orig	2003-08-24 18:16:28.000000000 -0400
+++ drivers/net/3c509.c	2003-08-24 22:33:32.000000000 -0400
@@ -300,10 +300,11 @@
  *
  * Both call el3_common_init/el3_common_remove. */
 
-static void __init el3_common_init(struct net_device *dev)
+static int __init el3_common_init(struct net_device *dev)
 {
 	struct el3_private *lp = dev->priv;
 	short i;
+	int err;
 
 	spin_lock_init(&lp->lock);
 
@@ -314,10 +315,29 @@
 		dev->if_port |= (dev->mem_start & 0x08);
 	}
 
+	/* The EL3-specific entries in the device structure. */
+	dev->open = &el3_open;
+	dev->hard_start_xmit = &el3_start_xmit;
+	dev->stop = &el3_close;
+	dev->get_stats = &el3_get_stats;
+	dev->set_multicast_list = &set_multicast_list;
+	dev->tx_timeout = el3_tx_timeout;
+	dev->watchdog_timeo = TX_TIMEOUT;
+	dev->do_ioctl = netdev_ioctl;
+
+	err = register_netdev(dev);
+	if (err) {
+		printk(KERN_ERR "Failed to register 3c5x9 at %#3.3lx, IRQ %d.\n",
+			dev->base_addr, dev->irq);
+		release_region(dev->base_addr, EL3_IO_EXTENT);
+		return err;
+	}
+
 	{
 		const char *if_names[] = {"10baseT", "AUI", "undefined", "BNC"};
-		printk("%s: 3c5x9 at %#3.3lx, %s port, address ",
-			dev->name, dev->base_addr, if_names[(dev->if_port & 0x03)]);
+		printk("%s: 3c5x9 found at %#3.3lx, %s port, address ",
+			dev->name, dev->base_addr, 
+			if_names[(dev->if_port & 0x03)]);
 	}
 
 	/* Read in the station address. */
@@ -327,16 +347,8 @@
 
 	if (el3_debug > 0)
 		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
+	return 0;
 
-	/* The EL3-specific entries in the device structure. */
-	dev->open = &el3_open;
-	dev->hard_start_xmit = &el3_start_xmit;
-	dev->stop = &el3_close;
-	dev->get_stats = &el3_get_stats;
-	dev->set_multicast_list = &set_multicast_list;
-	dev->tx_timeout = el3_tx_timeout;
-	dev->watchdog_timeo = TX_TIMEOUT;
-	dev->do_ioctl = netdev_ioctl;
 }
 
 static void el3_common_remove (struct net_device *dev)
@@ -564,9 +576,8 @@
 #if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
 	lp->dev = &idev->dev;
 #endif
-	el3_common_init(dev);
+	err = el3_common_init(dev);
 
-	err = register_netdev(dev);
 	if (err)
 		goto out1;
 
@@ -588,7 +599,6 @@
 	return 0;
 
 out1:
-	release_region(ioaddr, EL3_IO_EXTENT);
 #if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
 	if (idev)
 		pnp_device_detach(idev);
@@ -662,11 +672,9 @@
 		lp->dev = device;
 		lp->type = EL3_MCA;
 		device->driver_data = dev;
-		el3_common_init(dev);
+		err = el3_common_init(dev);
 
-		err = register_netdev(dev);
 		if (err) {
-			release_region(ioaddr, EL3_IO_EXTENT);
 			return -ENOMEM;
 		}
 
@@ -723,11 +731,9 @@
 	lp->dev = device;
 	lp->type = EL3_EISA;
 	eisa_set_drvdata (edev, dev);
-	el3_common_init(dev);
+	err = el3_common_init(dev);
 
-	err = register_netdev(dev);
 	if (err) {
-		release_region(ioaddr, EL3_IO_EXTENT);
 		return err;
 	}
 

--HlL+5n6rz5pIUxbD--
