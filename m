Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVARW3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVARW3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVARW3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:29:38 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:9419 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261449AbVARW3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:29:24 -0500
Date: Tue, 18 Jan 2005 16:29:23 -0600 (CST)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: [PATCH 1/1] tpm: fix cause of SMP stack traces
In-Reply-To: <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com>
 <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were misplaced spinlock acquires and releases in the probe, open, 
close and release paths which were causing might_sleep and schedule while 
atomic error messages accompanied by stack traces when the kernel was 
compiled with SMP support. Bug reported by Reben Jenster 
<ruben@hotheads.de>

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.c linux-2.6.10-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.10/drivers/char/tpm/tpm.c	2005-01-18 16:42:17.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.c	2005-01-18 12:52:53.000000000 -0600
@@ -373,8 +372,9 @@ int tpm_open(struct inode *inode, struct
 {
 	int rc = 0, minor = iminor(inode);
 	struct tpm_chip *chip = NULL, *pos;
+	unsigned long flags;
 
-	spin_lock(&driver_lock);
+	spin_lock_irqsave(&driver_lock, flags);
 
 	list_for_each_entry(pos, &tpm_chip_list, list) {
 		if (pos->vendor->miscdev.minor == minor) {
@@ -398,7 +398,7 @@ int tpm_open(struct inode *inode, struct
 	chip->num_opens++;
 	pci_dev_get(chip->pci_dev);
 
-	spin_unlock(&driver_lock);
+	spin_unlock_irqrestore(&driver_lock, flags);
 
 	chip->data_buffer = kmalloc(TPM_BUFSIZE * sizeof(u8), GFP_KERNEL);
 	if (chip->data_buffer == NULL) {
@@ -413,7 +413,7 @@ int tpm_open(struct inode *inode, struct
 	return 0;
 
 err_out:
-	spin_unlock(&driver_lock);
+	spin_unlock_irqrestore(&driver_lock, flags);
 	return rc;
 }
 
@@ -422,21 +422,25 @@ EXPORT_SYMBOL_GPL(tpm_open);
 int tpm_release(struct inode *inode, struct file *file)
 {
 	struct tpm_chip *chip = file->private_data;
+	unsigned long flags;
 
-	spin_lock(&driver_lock);
+	file->private_data = NULL;
+
+	spin_lock_irqsave(&driver_lock, flags);
 	chip->num_opens--;
+	spin_unlock_irqrestore(&driver_lock, flags);
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
 
@@ -524,16 +528,19 @@ EXPORT_SYMBOL_GPL(tpm_read);
 void __devexit tpm_remove(struct pci_dev *pci_dev)
 {
 	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+	unsigned long flags;
 
 	if (chip == NULL) {
 		dev_err(&pci_dev->dev, "No device data found\n");
 		return;
 	}
 
-	spin_lock(&driver_lock);
+	spin_lock_irqsave(&driver_lock, flags);
 
 	list_del(&chip->list);
 
+	spin_unlock_irqrestore(&driver_lock, flags);
+
 	pci_set_drvdata(pci_dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
 
@@ -541,8 +548,6 @@ void __devexit tpm_remove(struct pci_dev
 	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
 	device_remove_file(&pci_dev->dev, &dev_attr_caps);
 
-	spin_unlock(&driver_lock);
-
 	pci_disable_device(pci_dev);
 
 	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
@@ -583,12 +588,14 @@ EXPORT_SYMBOL_GPL(tpm_pm_suspend);
 int tpm_pm_resume(struct pci_dev *pci_dev)
 {
 	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+	unsigned long flags;
+
 	if (chip == NULL)
 		return -ENODEV;
 
-	spin_lock(&driver_lock);
+	spin_lock_irqsave(&driver_lock, flags);
 	tpm_lpc_bus_init(pci_dev, chip->vendor->base);
-	spin_unlock(&driver_lock);
+	spin_unlock_irqrestore(&driver_lock, flags);
 
 	return 0;
 }
@@ -650,15 +657,12 @@ dev_num_search_complete:
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
@@ -672,7 +676,6 @@ dev_num_search_complete:
 	device_create_file(&pci_dev->dev, &dev_attr_pcrs);
 	device_create_file(&pci_dev->dev, &dev_attr_caps);
 
-	spin_unlock(&driver_lock);
 	return 0;
 }
 
