Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTEGW7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 18:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTEGW7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 18:59:23 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:32526 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264143AbTEGW7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 18:59:20 -0400
Date: Thu, 8 May 2003 01:01:46 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: [ATM] [PATCH] unbalanced exit path in Forerunner HE he_init_one()
Message-ID: <20030508010146.A20715@electric-eye.fr.zoreil.com>
References: <200305071813.h47IDpc9010906@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305071813.h47IDpc9010906@hera.kernel.org>; from linux-kernel@vger.kernel.org on Wed, May 07, 2003 at 08:47:45AM +0000
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- pci_enable_device() isn't balanced on error path;
- result of atm_dev_register() is lost if he_dev allocation fails.


 drivers/atm/he.c |   40 +++++++++++++++++++++++++++++-----------
 1 files changed, 29 insertions(+), 11 deletions(-)


diff -puN drivers/atm/he.c~drivers-atm-he-chas drivers/atm/he.c
--- linux-2.5.69-1.1042.92.10-to-1.1097/drivers/atm/he.c~drivers-atm-he-chas	Thu May  8 00:59:44 2003
+++ linux-2.5.69-1.1042.92.10-to-1.1097-fr/drivers/atm/he.c	Thu May  8 00:59:44 2003
@@ -354,29 +354,36 @@ he_init_one(struct pci_dev *pci_dev, con
 {
 	struct atm_dev *atm_dev;
 	struct he_dev *he_dev;
+	int ret = -EIO;
 
 	printk(KERN_INFO "he: %s\n", version);
 
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,43)
-	if (pci_enable_device(pci_dev)) return -EIO;
+	if (pci_enable_device(pci_dev))
+		goto out;
 #endif
 	if (pci_set_dma_mask(pci_dev, HE_DMA_MASK) != 0)
 	{
 		printk(KERN_WARNING "he: no suitable dma available\n");
-		return -EIO;
+		goto out_disable;
 	}
 
 	atm_dev = atm_dev_register(DEV_LABEL, &he_ops, -1, 0);
-	if (!atm_dev) return -ENODEV;
+	if (!atm_dev) {
+		ret = -ENODEV;
+		goto out_disable;
+	}
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)
 	pci_set_drvdata(pci_dev, atm_dev);
 #else
 	pci_dev->driver_data = atm_dev;
 #endif
 
-	he_dev = (struct he_dev *) kmalloc(sizeof(struct he_dev),
-							GFP_KERNEL);
-	if (!he_dev) return -ENOMEM;
+	he_dev = (struct he_dev *) kmalloc(sizeof(*he_dev), GFP_KERNEL);
+	if (!he_dev) {
+		ret = -ENOMEM;
+		goto out_deregister;
+	}
 	memset(he_dev, 0, sizeof(struct he_dev));
 
 	he_dev->pci_dev = pci_dev;
@@ -385,16 +392,27 @@ he_init_one(struct pci_dev *pci_dev, con
 	HE_DEV(atm_dev) = he_dev;
 	he_dev->number = atm_dev->number;	/* was devs */
 	if (he_start(atm_dev)) {
-		atm_dev_deregister(atm_dev);
-		he_stop(he_dev);
-		kfree(he_dev);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_stop;
 	}
 	he_dev->next = NULL;
 	if (he_devs) he_dev->next = he_devs;
 	he_devs = he_dev;
 
-	return 0;
+	ret = 0;
+out:
+	return ret;
+
+out_stop:
+	he_stop(he_dev);
+	kfree(he_dev);
+out_deregister:
+	atm_dev_deregister(atm_dev);
+out_disable:
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,43)
+	pci_disable_device(pci_dev);
+#endif
+	goto out;
 }
 
 static void __devexit
