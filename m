Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVBXEPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVBXEPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVBXEOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:14:10 -0500
Received: from ozlabs.org ([203.10.76.45]:14006 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261777AbVBXENX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:13:23 -0500
Date: Thu, 24 Feb 2005 14:57:18 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [4/14] Orinoco driver updates - add free_orinocodev()
Message-ID: <20050224035718.GE32001@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035355.GA32001@localhost.localdomain> <20050224035445.GB32001@localhost.localdomain> <20050224035524.GC32001@localhost.localdomain> <20050224035650.GD32001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224035650.GD32001@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a free_orinocodev() function into the orinoco driver, used
by the hardware type/initialization modules to free the device
structure in preference to directly calling free_netdev().  At the
moment free_orinocodev() just calls free_netdev().  Future merges will
make it clean up internal scanning state, so merging this now will
reduce the diff noise.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.h	2005-02-18 12:04:03.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco.h	2005-02-18 12:04:03.000000000 +1100
@@ -107,6 +107,7 @@
 
 extern struct net_device *alloc_orinocodev(int sizeof_card,
 					   int (*hard_reset)(struct orinoco_private *));
+extern void free_orinocodev(struct net_device *dev);
 extern int __orinoco_up(struct net_device *dev);
 extern int __orinoco_down(struct net_device *dev);
 extern int orinoco_stop(struct net_device *dev);
Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-02-18 12:04:03.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2005-02-18 13:03:51.846593520 +1100
@@ -2398,6 +2398,11 @@
 
 }
 
+void free_orinocodev(struct net_device *dev)
+{
+	free_netdev(dev);
+}
+
 /********************************************************************/
 /* Wireless extensions                                              */
 /********************************************************************/
@@ -4131,6 +4136,7 @@
 /********************************************************************/
 
 EXPORT_SYMBOL(alloc_orinocodev);
+EXPORT_SYMBOL(free_orinocodev);
 
 EXPORT_SYMBOL(__orinoco_up);
 EXPORT_SYMBOL(__orinoco_down);
Index: working-2.6/drivers/net/wireless/orinoco_cs.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_cs.c	2005-02-18 12:04:03.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco_cs.c	2005-02-18 12:04:03.000000000 +1100
@@ -235,7 +235,7 @@
 		      dev);
 		unregister_netdev(dev);
 	}
-	free_netdev(dev);
+	free_orinocodev(dev);
 }				/* orinoco_cs_detach */
 
 /*
Index: working-2.6/drivers/net/wireless/orinoco_pci.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_pci.c	2005-02-18 12:04:03.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco_pci.c	2005-02-18 12:04:03.000000000 +1100
@@ -254,7 +254,7 @@
 		if (dev->irq)
 			free_irq(dev->irq, dev);
 
-		free_netdev(dev);
+		free_orinocodev(dev);
 	}
 
 	if (pci_ioaddr)
@@ -279,7 +279,7 @@
 		iounmap(priv->hw.iobase);
 
 	pci_set_drvdata(pdev, NULL);
-	free_netdev(dev);
+	free_orinocodev(dev);
 
 	pci_disable_device(pdev);
 }
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c	2005-02-18 12:04:03.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco_plx.c	2005-02-18 12:04:03.000000000 +1100
@@ -279,7 +279,7 @@
  fail:
 	free_irq(dev->irq, dev);
  fail_irq:
-	free_netdev(dev);
+	free_orinocodev(dev);
  fail_alloc:
 	pci_iounmap(pdev, mem);
  fail_map:
@@ -304,7 +304,7 @@
 		
 	pci_set_drvdata(pdev, NULL);
 
-	free_netdev(dev);
+	free_orinocodev(dev);
 
 	release_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3));
 
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c	2005-02-18 12:04:03.000000000 +1100
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c	2005-02-18 12:04:03.000000000 +1100
@@ -164,7 +164,7 @@
 out4:
 	pci_iounmap(pdev, mem);
 out3:
-	free_netdev(dev);
+	free_orinocodev(dev);
 out2:
 	release_region(pccard_ioaddr, pccard_iolen);
 out:
@@ -188,7 +188,7 @@
 
 	pci_set_drvdata(pdev, NULL);
 
-	free_netdev(dev);
+	free_orinocodev(dev);
 
 	release_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2));
 
Index: working-2.6/drivers/net/wireless/airport.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/airport.c	2005-02-18 12:04:03.000000000 +1100
+++ working-2.6/drivers/net/wireless/airport.c	2005-02-18 12:04:03.000000000 +1100
@@ -149,7 +149,7 @@
 	ssleep(1);
 
 	macio_set_drvdata(mdev, NULL);
-	free_netdev(dev);
+	free_orinocodev(dev);
 
 	return 0;
 }
@@ -211,7 +211,7 @@
 
 	if (macio_request_resource(mdev, 0, "airport")) {
 		printk(KERN_ERR PFX "can't request IO resource !\n");
-		free_netdev(dev);
+		free_orinocodev(dev);
 		return -EBUSY;
 	}
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
