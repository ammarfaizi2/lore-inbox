Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTEIWAq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbTEIWAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:00:46 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:11268 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263528AbTEIWAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:00:44 -0400
Date: Sat, 10 May 2003 00:02:22 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: [ATM] [UPDATE] unbalanced exit path in Forerunner HE he_init_one()
Message-ID: <20030510000222.A10796@electric-eye.fr.zoreil.com>
References: <20030508194700.C13069@almesberger.net> <200305090058.h490wNGi006609@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305090058.h490wNGi006609@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Thu, May 08, 2003 at 08:58:23PM -0400
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update:

- pci_enable_device() balanced on error path in he_init_one();
- return of atm_dev_register() isn't lost any more if he_dev allocation fails
  in he_init_one();
- pci_disable_device() added to he_disable_one();


 drivers/atm/he.c |   43 ++++++++++++++++++++++++++++++-------------
 1 files changed, 30 insertions(+), 13 deletions(-)

diff -puN drivers/atm/he.c~drivers-atm-he-chas drivers/atm/he.c
--- linux-2.5.69-1.1042.101.10-to-1.1083/drivers/atm/he.c~drivers-atm-he-chas	Fri May  9 23:43:22 2003
+++ linux-2.5.69-1.1042.101.10-to-1.1083-fr/drivers/atm/he.c	Fri May  9 23:48:43 2003
@@ -364,23 +364,29 @@ he_init_one(struct pci_dev *pci_dev, con
 {
 	struct atm_dev *atm_dev;
 	struct he_dev *he_dev;
+	int ret = -EIO;
 
 	printk(KERN_INFO "he: %s\n", version);
 
-	if (pci_enable_device(pci_dev)) return -EIO;
-	if (pci_set_dma_mask(pci_dev, HE_DMA_MASK) != 0)
-	{
+	if (pci_enable_device(pci_dev))
+		goto out;
+	if (pci_set_dma_mask(pci_dev, HE_DMA_MASK) != 0) {
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
 	pci_set_drvdata(pci_dev, atm_dev);
 
-	he_dev = (struct he_dev *) kmalloc(sizeof(struct he_dev),
-							GFP_KERNEL);
-	if (!he_dev) return -ENOMEM;
+	he_dev = (struct he_dev *) kmalloc(sizeof(struct he_dev), GFP_KERNEL);
+	if (!he_dev) {
+		ret = -ENOMEM;
+		goto out_deregister;
+	}
 	memset(he_dev, 0, sizeof(struct he_dev));
 
 	he_dev->pci_dev = pci_dev;
@@ -389,16 +395,26 @@ he_init_one(struct pci_dev *pci_dev, con
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
+	pci_set_drvdata(pci_dev, NULL);
+	atm_dev_deregister(atm_dev);
+out_disable:
+	pci_disable_device(pci_dev);
+	goto out;
 }
 
 static void __devexit
@@ -417,6 +433,7 @@ he_remove_one (struct pci_dev *pci_dev)
 	kfree(he_dev);
 
 	pci_set_drvdata(pci_dev, NULL);
+	pci_disable_device(pci_dev);
 }
 
 
