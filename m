Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVARXlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVARXlB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 18:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVARXlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 18:41:00 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50136 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261487AbVARXj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 18:39:56 -0500
Date: Tue, 18 Jan 2005 17:39:53 -0600 (CST)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] tpm: fix cause of SMP stack traces -- updated version
In-Reply-To: <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com>
 <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were misplaced spinlock acquires and releases in the probe, close and release 
paths which were causing might_sleep and schedule while atomic error messages accompanied 
by stack traces when the kernel was compiled with SMP support. Bug reported by Reben Jenster 
<ruben@hotheads.de>

Thanks,
Kylie
 
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.c linux-2.6.10-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.10/drivers/char/tpm/tpm.c	2005-01-18 18:10:16.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.c	2005-01-18 18:13:59.000000000 -0600
@@ -422,21 +421,24 @@ EXPORT_SYMBOL_GPL(tpm_open);
 int tpm_release(struct inode *inode, struct file *file)
 {
 	struct tpm_chip *chip = file->private_data;
+	
+	file->private_data = NULL;
 
 	spin_lock(&driver_lock);
 	chip->num_opens--;
+	spin_unlock(&driver_lock);
+
 	down(&chip->timer_manipulation_mutex);
 	if (timer_pending(&chip->user_read_timer))
 		del_singleshot_timer_sync(&chip->user_read_timer);
 	else if (timer_pending(&chip->device_timer))
 		del_singleshot_timer_sync(&chip->device_timer);
 	up(&chip->timer_manipulation_mutex);
+
 	kfree(chip->data_buffer);
 	atomic_set(&chip->data_pending, 0);
 
 	pci_dev_put(chip->pci_dev);
-	file->private_data = NULL;
-	spin_unlock(&driver_lock);
 	return 0;
 }
 
@@ -534,6 +536,8 @@ void __devexit tpm_remove(struct pci_dev
 
 	list_del(&chip->list);
 
+	spin_unlock(&driver_lock);
+
 	pci_set_drvdata(pci_dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
 
@@ -541,8 +545,6 @@ void __devexit tpm_remove(struct pci_dev
 	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
 	device_remove_file(&pci_dev->dev, &dev_attr_caps);
 
-	spin_unlock(&driver_lock);
-
 	pci_disable_device(pci_dev);
 
 	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
@@ -583,6 +585,7 @@ EXPORT_SYMBOL_GPL(tpm_pm_suspend);
 int tpm_pm_resume(struct pci_dev *pci_dev)
 {
 	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -650,15 +653,12 @@ dev_num_search_complete:
 	chip->vendor->miscdev.dev = &(pci_dev->dev);
 	chip->pci_dev = pci_dev_get(pci_dev);
 
-	spin_lock(&driver_lock);
-
 	if (misc_register(&chip->vendor->miscdev)) {
 		dev_err(&chip->pci_dev->dev,
 			"unable to misc_register %s, minor %d\n",
 			chip->vendor->miscdev.name,
 			chip->vendor->miscdev.minor);
 		pci_dev_put(pci_dev);
-		spin_unlock(&driver_lock);
 		kfree(chip);
 		dev_mask[i] &= !(1 << j);
 		return -ENODEV;
@@ -672,7 +672,6 @@ dev_num_search_complete:
 	device_create_file(&pci_dev->dev, &dev_attr_pcrs);
 	device_create_file(&pci_dev->dev, &dev_attr_caps);
 
-	spin_unlock(&driver_lock);
 	return 0;
 }
 
