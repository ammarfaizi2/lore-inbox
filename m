Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266799AbUG1HNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266799AbUG1HNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266792AbUG1HMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:12:50 -0400
Received: from ozlabs.org ([203.10.76.45]:2442 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266790AbUG1HLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:47 -0400
Date: Wed, 28 Jul 2004 16:54:18 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [3/15] orinoco merge preliminaries - use netdev_priv()
Message-ID: <20040728065418.GF16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com> <40F57D78.9080609@pobox.com> <20040715010137.GB3697@zax> <41068E4B.2040507@pobox.com> <20040728065128.GC16908@zax> <20040728065308.GD16908@zax> <20040728065345.GE16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065345.GE16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the netdev_priv() macro instead of directly accessing dev->priv.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2004-07-28 15:05:30.441018096 +1000
+++ working-2.6/drivers/net/wireless/orinoco.c	2004-07-28 15:05:31.213900600 +1000
@@ -2341,7 +2341,7 @@
 	priv = netdev_priv(dev);
 	priv->ndev = dev;
 	if (sizeof_card)
-		priv->card = (void *)((unsigned long)dev->priv + sizeof(struct orinoco_private));
+		priv->card = (void *)((unsigned long)netdev_priv(dev) + sizeof(struct orinoco_private));
 	else
 		priv->card = NULL;
 
Index: working-2.6/drivers/net/wireless/orinoco_pci.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_pci.c	2004-06-29 11:47:02.000000000 +1000
+++ working-2.6/drivers/net/wireless/orinoco_pci.c	2004-07-28 15:05:31.215900296 +1000
@@ -212,7 +212,7 @@
 		err = -ENOMEM;
 		goto fail;
 	}
-	priv = dev->priv;
+	priv = netdev_priv(dev);
 
 	dev->base_addr = (unsigned long) pci_ioaddr;
 	dev->mem_start = pci_iorange;
@@ -275,7 +275,7 @@
 static void __devexit orinoco_pci_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	struct orinoco_private *priv = dev->priv;
+	struct orinoco_private *priv = netdev_priv(dev);
 
 	unregister_netdev(dev);
 
@@ -294,7 +294,7 @@
 static int orinoco_pci_suspend(struct pci_dev *pdev, u32 state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	struct orinoco_private *priv = dev->priv;
+	struct orinoco_private *priv = netdev_priv(dev);
 	unsigned long flags;
 	int err;
 	
@@ -325,7 +325,7 @@
 static int orinoco_pci_resume(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	struct orinoco_private *priv = dev->priv;
+	struct orinoco_private *priv = netdev_priv(dev);
 	unsigned long flags;
 	int err;
 
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:26.394633240 +1000
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:31.216900144 +1000
@@ -121,7 +121,7 @@
 		goto fail;
 	}
 
-	priv = dev->priv;
+	priv = netdev_priv(dev);
 	dev->base_addr = pccard_ioaddr;
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
Index: working-2.6/drivers/net/wireless/orinoco_cs.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_cs.c	2004-07-28 15:05:26.396632936 +1000
+++ working-2.6/drivers/net/wireless/orinoco_cs.c	2004-07-28 15:05:31.218899840 +1000
@@ -163,7 +163,7 @@
 	dev = alloc_orinocodev(sizeof(*card), orinoco_cs_hard_reset);
 	if (! dev)
 		return NULL;
-	priv = dev->priv;
+	priv = netdev_priv(dev);
 	card = priv->card;
 
 	/* Link both structures together */
@@ -266,7 +266,7 @@
 {
 	struct net_device *dev = link->priv;
 	client_handle_t handle = link->handle;
-	struct orinoco_private *priv = dev->priv;
+	struct orinoco_private *priv = netdev_priv(dev);
 	struct orinoco_pccard *card = priv->card;
 	hermes_t *hw = &priv->hw;
 	int last_fn, last_ret;
@@ -499,7 +499,7 @@
 orinoco_cs_release(dev_link_t *link)
 {
 	struct net_device *dev = link->priv;
-	struct orinoco_private *priv = dev->priv;
+	struct orinoco_private *priv = netdev_priv(dev);
 	unsigned long flags;
 
 	/* We're committed to taking the device away now, so mark the
@@ -527,7 +527,7 @@
 {
 	dev_link_t *link = args->client_data;
 	struct net_device *dev = link->priv;
-	struct orinoco_private *priv = dev->priv;
+	struct orinoco_private *priv = netdev_priv(dev);
 	struct orinoco_pccard *card = priv->card;
 	int err = 0;
 	unsigned long flags;
Index: working-2.6/drivers/net/wireless/airport.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/airport.c	2004-07-27 17:02:56.000000000 +1000
+++ working-2.6/drivers/net/wireless/airport.c	2004-07-28 15:05:31.219899688 +1000
@@ -50,7 +50,7 @@
 airport_suspend(struct macio_dev *mdev, u32 state)
 {
 	struct net_device *dev = dev_get_drvdata(&mdev->ofdev.dev);
-	struct orinoco_private *priv = dev->priv;
+	struct orinoco_private *priv = netdev_priv(dev);
 	unsigned long flags;
 	int err;
 
@@ -84,7 +84,7 @@
 airport_resume(struct macio_dev *mdev)
 {
 	struct net_device *dev = dev_get_drvdata(&mdev->ofdev.dev);
-	struct orinoco_private *priv = dev->priv;
+	struct orinoco_private *priv = netdev_priv(dev);
 	unsigned long flags;
 	int err;
 
@@ -126,7 +126,7 @@
 airport_detach(struct macio_dev *mdev)
 {
 	struct net_device *dev = dev_get_drvdata(&mdev->ofdev.dev);
-	struct orinoco_private *priv = dev->priv;
+	struct orinoco_private *priv = netdev_priv(dev);
 	struct airport *card = priv->card;
 
 	if (card->ndev_registered)
@@ -204,7 +204,7 @@
 		printk(KERN_ERR "airport: can't allocate device datas\n");
 		return -ENODEV;
 	}
-	priv = dev->priv;
+	priv = netdev_priv(dev);
 	card = priv->card;
 
 	hw = &priv->hw;
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c	2004-07-28 15:05:26.397632784 +1000
+++ working-2.6/drivers/net/wireless/orinoco_plx.c	2004-07-28 15:05:31.220899536 +1000
@@ -229,7 +229,7 @@
 		goto fail;
 	}
 
-	priv = dev->priv;
+	priv = netdev_priv(dev);
 	dev->base_addr = pccard_ioaddr;
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
