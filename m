Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbVCJBLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbVCJBLx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVCJBLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:11:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:40095 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262602AbVCJAmV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:21 -0500
Cc: kjhall@us.ibm.com
Subject: [PATCH] tpm: fix cause of SMP stack traces
In-Reply-To: <1110415321526@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:42:01 -0800
Message-Id: <11104153213727@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2036, 2005/03/09 10:12:38-08:00, kjhall@us.ibm.com

[PATCH] tpm: fix cause of SMP stack traces

There were misplaced spinlock acquires and releases in the probe, close and release
paths which were causing might_sleep and schedule while atomic error messages accompanied
by stack traces when the kernel was compiled with SMP support. Bug reported by Reben Jenster
<ruben@hotheads.de>

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/tpm/tpm.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/char/tpm/tpm.c b/drivers/char/tpm/tpm.c
--- a/drivers/char/tpm/tpm.c	2005-03-09 16:40:19 -08:00
+++ b/drivers/char/tpm/tpm.c	2005-03-09 16:40:19 -08:00
@@ -422,21 +422,24 @@
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
 
@@ -534,6 +537,8 @@
 
 	list_del(&chip->list);
 
+	spin_unlock(&driver_lock);
+
 	pci_set_drvdata(pci_dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
 
@@ -541,8 +546,6 @@
 	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
 	device_remove_file(&pci_dev->dev, &dev_attr_caps);
 
-	spin_unlock(&driver_lock);
-
 	pci_disable_device(pci_dev);
 
 	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
@@ -583,6 +586,7 @@
 int tpm_pm_resume(struct pci_dev *pci_dev)
 {
 	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -650,15 +654,12 @@
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
@@ -672,7 +673,6 @@
 	device_create_file(&pci_dev->dev, &dev_attr_pcrs);
 	device_create_file(&pci_dev->dev, &dev_attr_caps);
 
-	spin_unlock(&driver_lock);
 	return 0;
 }
 

