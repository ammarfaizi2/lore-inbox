Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263250AbVBDUiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbVBDUiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbVBDUhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:37:48 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:6627 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265155AbVBDUM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:12:58 -0500
Date: Fri, 4 Feb 2005 14:12:50 -0600 (CST)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: [PATCH 1/1] tpm: implement use of sysfs classes
In-Reply-To: <Pine.LNX.4.58.0502031034290.18135@jo.austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0502041405230.22211@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com> 
 <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com>
 <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501281539340.6360@jo.austin.ibm.com>
 <Pine.LNX.4.58.0501311322380.9872@jo.austin.ibm.com>
 <Pine.LNX.4.58.0502031034290.18135@jo.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the enablement of being able to support chips on differnt buses  
(see patch sent 2/3/2005), the userspace library (TSS) needs to be able to 
find the corresponding sysfs files.  Added a new sysfs class "tpm" where 
the devices are now registered (tpm0, tpm1, ...) and links to the 
driver, device and tpm specific files (pcrs, etc) now live.  This patch 
also includes a new sysfs file for each tpm that is needed to support 
canceling an operation.

Thanks,
Kylie
 
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.c linux-2.6.10-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.10/drivers/char/tpm/tpm.c	2005-02-04 15:03:03.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.c	2005-02-04 15:02:14.000000000 -0600
@@ -213,14 +212,14 @@ static u8 pcrread[] = {
 	0, 0, 0, 0		/* PCR index */
 };
 
-static ssize_t show_pcrs(struct device *dev, char *buf)
+static ssize_t show_pcrs(struct class_device *cdev, char *buf)
 {
 	u8 data[READ_PCR_RESULT_SIZE];
 	ssize_t len;
 	int i, j, index, num_pcrs;
 	char *str = buf;
 
-	struct tpm_chip *chip = dev_get_drvdata(dev);
+	struct tpm_chip *chip = dev_get_drvdata(cdev->dev);
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -246,8 +245,6 @@ static ssize_t show_pcrs(struct device *
 	return str - buf;
 }
 
-static DEVICE_ATTR(pcrs, S_IRUGO, show_pcrs, NULL);
-
 #define  READ_PUBEK_RESULT_SIZE 314
 static u8 readpubek[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
@@ -255,7 +252,7 @@ static u8 readpubek[] = {
 	0, 0, 0, 124,		/* TPM_ORD_ReadPubek */
 };
 
-static ssize_t show_pubek(struct device *dev, char *buf)
+static ssize_t show_pubek(struct class_device *cdev, char *buf)
 {
 	u8 data[READ_PUBEK_RESULT_SIZE];
 	ssize_t len;
@@ -263,7 +260,7 @@ static ssize_t show_pubek(struct device 
 	int i;
 	char *str = buf;
 
-	struct tpm_chip *chip = dev_get_drvdata(dev);
+	struct tpm_chip *chip = dev_get_drvdata(cdev->dev);
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -308,8 +305,6 @@ static ssize_t show_pubek(struct device 
 	return str - buf;
 }
 
-static DEVICE_ATTR(pubek, S_IRUGO, show_pubek, NULL);
-
 #define CAP_VER_RESULT_SIZE 18
 static u8 cap_version[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
@@ -329,13 +324,13 @@ static u8 cap_manufacturer[] = {
 	0, 0, 1, 3
 };
 
-static ssize_t show_caps(struct device *dev, char *buf)
+static ssize_t show_caps(struct class_device *cdev, char *buf)
 {
 	u8 data[READ_PUBEK_RESULT_SIZE];
 	ssize_t len;
 	char *str = buf;
 
-	struct tpm_chip *chip = dev_get_drvdata(dev);
+	struct tpm_chip *chip = dev_get_drvdata(cdev->dev);
 	if (chip == NULL)
 		return -ENODEV;
 
@@ -362,7 +357,22 @@ static ssize_t show_caps(struct device *
 	return str - buf;
 }
 
-static DEVICE_ATTR(caps, S_IRUGO, show_caps, NULL);
+static ssize_t store_cancel(struct class_device *cdev, const char *buf,
+			    size_t count)
+{
+	struct tpm_chip *chip = dev_get_drvdata(cdev->dev);
+	if (chip == NULL)
+		return 0;
+
+	chip->vendor->cancel(chip);
+
+	down(&chip->timer_manipulation_mutex);
+	if (timer_pending(&chip->device_timer))
+		mod_timer(&chip->device_timer, jiffies);
+	up(&chip->timer_manipulation_mutex);
+
+	return count;
+}
 
 /*
  * Device file system interface to the TPM
@@ -539,9 +549,7 @@ void tpm_remove_hardware(struct device *
 	dev_set_drvdata(dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
 
-	device_remove_file(dev, &dev_attr_pubek);
-	device_remove_file(dev, &dev_attr_pcrs);
-	device_remove_file(dev, &dev_attr_caps);
+	class_device_unregister(&chip->cdev);
 
 	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
 
@@ -594,6 +602,19 @@ int tpm_pm_resume(struct pci_dev *pci_de
 
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
 
+static struct class_device_attribute tpm_attrs[] = {
+	__ATTR(pubek, S_IRUGO, show_pubek, NULL),
+	__ATTR(pcrs, S_IRUGO, show_pcrs, NULL),
+	__ATTR(caps, S_IRUGO, show_caps, NULL),
+	__ATTR(cancel, S_IWUSR | S_IWGRP, NULL, store_cancel),
+	__ATTR_NULL
+};
+
+static struct class tpm_class = {
+	.name = "tpm",
+	.class_dev_attrs = tpm_attrs,
+};
+
 /*
  * Called from tpm_<specific>.c probe function only for devices 
  * the driver has determined it should claim.  Prior to calling
@@ -663,9 +684,10 @@ dev_num_search_complete:
 
 	list_add(&chip->list, &tpm_chip_list);
 
-	device_create_file(dev, &dev_attr_pubek);
-	device_create_file(dev, &dev_attr_pcrs);
-	device_create_file(dev, &dev_attr_caps);
+	chip->cdev.dev = dev;
+	chip->cdev.class = &tpm_class;
+	sprintf(chip->cdev.class_id, "%s%d", "tpm", chip->dev_num);
+	class_device_register(&chip->cdev);
 
 	return 0;
 }
@@ -674,12 +696,14 @@ EXPORT_SYMBOL_GPL(tpm_register_hardware)
 
 static int __init init_tpm(void)
 {
+	class_register(&tpm_class);
+
 	return 0;
 }
 
 static void __exit cleanup_tpm(void)
 {
-
+	class_unregister(&tpm_class);
 }
 
 module_init(init_tpm);
diff -uprN linux-2.6.10/drivers/char/tpm/tpm.h linux-2.6.10-tpm/drivers/char/tpm/tpm.h
--- linux-2.6.10/drivers/char/tpm/tpm.h	2005-02-04 15:03:03.000000000 -0600
+++ linux-2.6.10-tpm/drivers/char/tpm/tpm.h	2005-02-04 15:09:24.898152744 -0600
@@ -46,6 +46,7 @@ struct tpm_vendor_specific {
 
 struct tpm_chip {
 	struct device *dev;	/* PCI device stuff */
+	struct class_device cdev;	/* TPM class device */
 
 	int dev_num;		/* /dev/tpm# */
 	int num_opens;		/* only one allowed */
