Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTEHNJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTEHNJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:09:24 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:58383 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261367AbTEHNJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:09:17 -0400
Date: Thu, 8 May 2003 15:18:40 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [PATCH] unbalanced exit path in Forerunner HE he_init_one()
Message-ID: <20030508151840.C26472@electric-eye.fr.zoreil.com>
References: <20030508010146.A20715@electric-eye.fr.zoreil.com> <200305081220.h48CK9Gi002815@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305081220.h48CK9Gi002815@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Thu, May 08, 2003 at 08:20:09AM -0400
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams <chas@locutus.cmf.nrl.navy.mil> :
[...]
> actually pci_disable_device() should probably go into he_stop() or
> add it to he_remove_one() and he_cleanup()

Doh... This should be more accurate:

- pci_enable_device() balanced on error path in he_init_one();
- return of atm_dev_register() isn't lost any more if he_dev allocation fails
  in he_init_one();
- pci_disable_device() added to he_disable_one();
- he_cleanup() calls he_disable_one() instead of duplicating it;
- partial rework of code dedicated to kernel versions compatibility.


 drivers/atm/he.c |   67 +++++++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 37 insertions(+), 30 deletions(-)

diff -puN drivers/atm/he.c~drivers-atm-he-chas drivers/atm/he.c
--- linux-2.5.69-1.1042.92.10-to-1.1097/drivers/atm/he.c~drivers-atm-he-chas	Thu May  8 14:02:28 2003
+++ linux-2.5.69-1.1042.92.10-to-1.1097-fr/drivers/atm/he.c	Thu May  8 15:13:56 2003
@@ -98,9 +98,16 @@ void sn_delete_polled_interrupt(int irq)
 
 /* 2.2 kernel support */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
+#define pci_set_drvdata(pdev,p)		((pdev)->driver_data = p)
+#define pci_get_drvdata(pdev)		(pdev)->driver_data
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,43)
 #define dev_kfree_skb_irq(skb)		dev_kfree_skb(skb)
 #define dev_kfree_skb_any(skb)		dev_kfree_skb(skb)
+#define pci_disable_device(pdev)	do {} while(0)
+#define pci_enable_device(pdev)		0
 #undef USE_TASKLET
 #endif
 
@@ -354,29 +361,30 @@ he_init_one(struct pci_dev *pci_dev, con
 {
 	struct atm_dev *atm_dev;
 	struct he_dev *he_dev;
+	int ret = -EIO;
 
 	printk(KERN_INFO "he: %s\n", version);
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,43)
-	if (pci_enable_device(pci_dev)) return -EIO;
-#endif
+	if (pci_enable_device(pci_dev))
+		goto out;
 	if (pci_set_dma_mask(pci_dev, HE_DMA_MASK) != 0)
 	{
 		printk(KERN_WARNING "he: no suitable dma available\n");
-		return -EIO;
+		goto out_disable;
 	}
 
 	atm_dev = atm_dev_register(DEV_LABEL, &he_ops, -1, 0);
-	if (!atm_dev) return -ENODEV;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)
+	if (!atm_dev) {
+		ret = -ENODEV;
+		goto out_disable;
+	}
 	pci_set_drvdata(pci_dev, atm_dev);
-#else
-	pci_dev->driver_data = atm_dev;
-#endif
 
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
@@ -385,16 +393,25 @@ he_init_one(struct pci_dev *pci_dev, con
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
+	pci_disable_device(pci_dev);
+	goto out;
 }
 
 static void __devexit
@@ -403,11 +420,7 @@ he_remove_one (struct pci_dev *pci_dev)
 	struct atm_dev *atm_dev;
 	struct he_dev *he_dev;
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)
 	atm_dev = pci_get_drvdata(pci_dev);
-#else
-	atm_dev = pci_dev->driver_data;
-#endif
 	he_dev = HE_DEV(atm_dev);
 
 	/* need to remove from he_devs */
@@ -416,11 +429,8 @@ he_remove_one (struct pci_dev *pci_dev)
 	atm_dev_deregister(atm_dev);
 	kfree(he_dev);
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)
 	pci_set_drvdata(pci_dev, NULL);
-#else
-	pci_dev->driver_data = NULL;
-#endif
+	pci_disable_device(pci_dev);
 }
 
 
@@ -3384,13 +3394,10 @@ he_init()
 static void __devexit
 he_cleanup(void)
 {
-	while (he_devs)
-	{
+	while (he_devs) {
 		struct he_dev *next = he_devs->next;
-		he_stop(he_devs);
-		atm_dev_deregister(he_devs->atm_dev);
-		kfree(he_devs);
 
+		he_remove_one(he_dev->pci_dev);
 		he_devs = next;
 	}
 
