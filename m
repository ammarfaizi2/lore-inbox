Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTJIHHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 03:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbTJIHHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 03:07:10 -0400
Received: from ozlabs.org ([203.10.76.45]:26057 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261903AbTJIHHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 03:07:06 -0400
Date: Thu, 9 Oct 2003 17:06:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Miller <davem@redhat.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [TRIVIAL] Fix initialization sequence in SunGEM driver
Message-ID: <20031009070649.GA830@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	David Miller <davem@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below alters the SunGEM driver so that the net_device
callback pointers are initialized before calling register_netdev(),
rather than after.

I think that would always have been a bug, but its effects have become
worse in recent kernels:  the fact that get_stats is NULL when
register_netdev() is called means that the netstat_group sysfs
attributes are not registered.  That in turn means that we get an oops
on module remove as it attempts to deregister those attributes
(dir->d_inode is NULL in sysfs_hash_and_remove()).

diff -urN linuxppc-2.5-benh/drivers/net/sungem.c linux-zax/drivers/net/sungem.c
--- linuxppc-2.5-benh/drivers/net/sungem.c	2003-09-29 18:30:43.000000000 +1000
+++ linux-zax/drivers/net/sungem.c	2003-10-09 16:18:19.024186984 +1000
@@ -2757,6 +2757,19 @@
 	if (gem_get_device_address(gp))
 		goto err_out_free_consistent;
 
+	dev->open = gem_open;
+	dev->stop = gem_close;
+	dev->hard_start_xmit = gem_start_xmit;
+	dev->get_stats = gem_get_stats;
+	dev->set_multicast_list = gem_set_multicast;
+	dev->do_ioctl = gem_ioctl;
+	dev->ethtool_ops = &gem_ethtool_ops;
+	dev->tx_timeout = gem_tx_timeout;
+	dev->watchdog_timeo = 5 * HZ;
+	dev->change_mtu = gem_change_mtu;
+	dev->irq = pdev->irq;
+	dev->dma = 0;
+
 	if (register_netdev(dev)) {
 		printk(KERN_ERR PFX "Cannot register net device, "
 		       "aborting.\n");
@@ -2785,19 +2798,6 @@
 
 	pci_set_drvdata(pdev, dev);
 
-	dev->open = gem_open;
-	dev->stop = gem_close;
-	dev->hard_start_xmit = gem_start_xmit;
-	dev->get_stats = gem_get_stats;
-	dev->set_multicast_list = gem_set_multicast;
-	dev->do_ioctl = gem_ioctl;
-	dev->ethtool_ops = &gem_ethtool_ops;
-	dev->tx_timeout = gem_tx_timeout;
-	dev->watchdog_timeo = 5 * HZ;
-	dev->change_mtu = gem_change_mtu;
-	dev->irq = pdev->irq;
-	dev->dma = 0;
-
 	/* GEM can do it all... */
 	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
 	if (pci_using_dac)


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
