Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVD0WYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVD0WYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVD0WW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:22:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:23782 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262065AbVD0WTS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:19:18 -0400
Date: Wed, 27 Apr 2005 17:19:03 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10 of 12] Fix Tpm driver -- sysfs owernship changes
Message-ID: <Pine.LNX.4.61.0504271645170.3929@jo.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the current driver all sysfs files end up owned by the base driver 
module rather than the module that actually owns the device this is a 
problem if the module is unloaded and the file is open.  This patch fixes 
all that.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN --exclude='*.orig' linux-2.6.12-rc2/drivers/char/tpm/tpm_atmel.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm_atmel.c	2005-04-20 18:58:48.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_atmel.c	2005-04-20 18:36:54.000000000 -0500
@@ -133,7 +133,8 @@ static struct tpm_vendor_specific tpm_at
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
 	.base = TPM_ATML_BASE,
-	.miscdev = { .fops = &atmel_ops, },
+	.attr = TPM_DEVICE_ATTRS,
+	.miscdev.fops = &atmel_ops,
 };
 
 static int __devinit tpm_atml_init(struct pci_dev *pci_dev,
diff -uprN --exclude='*.orig' linux-2.6.12-rc2/drivers/char/tpm/tpm.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-20 19:07:43.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-20 18:57:28.000000000 -0500
@@ -207,7 +207,7 @@ static const u8 pcrread[] = {
 	0, 0, 0, 0		/* PCR index */
 };
 
-static ssize_t show_pcrs(struct device *dev, char *buf)
+ssize_t tpm_show_pcrs(struct device *dev, char *buf)
 {
 	u8 data[READ_PCR_RESULT_SIZE];
 	ssize_t len;
@@ -242,7 +242,7 @@ static ssize_t show_pcrs(struct device *
 	return str - buf;
 }
 
-static DEVICE_ATTR(pcrs, S_IRUGO, show_pcrs, NULL);
+EXPORT_SYMBOL_GPL(tpm_show_pcrs);
 
 #define  READ_PUBEK_RESULT_SIZE 314
 static const u8 readpubek[] = {
@@ -251,7 +251,7 @@ static const u8 readpubek[] = {
 	0, 0, 0, 124,		/* TPM_ORD_ReadPubek */
 };
 
-static ssize_t show_pubek(struct device *dev, char *buf)
+ssize_t tpm_show_pubek(struct device *dev, char *buf)
 {
 	u8 data[READ_PUBEK_RESULT_SIZE];
 	ssize_t len;
@@ -301,7 +301,7 @@ static ssize_t show_pubek(struct device 
 	return str - buf;
 }
 
-static DEVICE_ATTR(pubek, S_IRUGO, show_pubek, NULL);
+EXPORT_SYMBOL_GPL(tpm_show_pubek);
 
 #define CAP_VER_RESULT_SIZE 18
 static const u8 cap_version[] = {
@@ -322,7 +322,7 @@ static const u8 cap_manufacturer[] = {
 	0, 0, 1, 3
 };
 
-static ssize_t show_caps(struct device *dev, char *buf)
+ssize_t tpm_show_caps(struct device *dev, char *buf)
 {
 	u8 data[READ_PUBEK_RESULT_SIZE];
 	ssize_t len;
@@ -356,7 +356,21 @@ static ssize_t show_caps(struct device *
 	return str - buf;
 }
 
-static DEVICE_ATTR(caps, S_IRUGO, show_caps, NULL);
+EXPORT_SYMBOL_GPL(tpm_show_caps);
+
+ssize_t tpm_store_cancel(struct device * dev, const char *buf,
+			 size_t count)
+{
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if (chip == NULL)
+		return 0;
+
+	chip->vendor->cancel(chip);
+	return count;
+}
+
+EXPORT_SYMBOL_GPL(tpm_store_cancel);
+
 
 /*
  * Device file system interface to the TPM
@@ -532,9 +546,8 @@ void __devexit tpm_remove(struct pci_dev
 	pci_set_drvdata(pci_dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
 
-	device_remove_file(&pci_dev->dev, &dev_attr_pubek);
-	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
-	device_remove_file(&pci_dev->dev, &dev_attr_caps);
+	for (i = 0; i < TPM_NUM_ATTR; i++)
+		device_remove_file(&pci_dev->dev, &chip->vendor->attr[i]);
 
 	pci_disable_device(pci_dev);
 
@@ -659,9 +672,8 @@ dev_num_search_complete:
 
 	list_add(&chip->list, &tpm_chip_list);
 
-	device_create_file(&pci_dev->dev, &dev_attr_pubek);
-	device_create_file(&pci_dev->dev, &dev_attr_pcrs);
-	device_create_file(&pci_dev->dev, &dev_attr_caps);
+	for (i = 0; i < TPM_NUM_ATTR; i++)
+		device_create_file(&pci_dev->dev, &chip->vendor->attr[i]);
 
 	return 0;
 }
 
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-21 16:54:56.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-21 17:05:21.000000000 -0500
@@ -531,6 +531,7 @@ EXPORT_SYMBOL_GPL(tpm_read);
 void __devexit tpm_remove(struct pci_dev *pci_dev)
 {
 	struct tpm_chip *chip = pci_get_drvdata(pci_dev);
+	int i;
 
 	if (chip == NULL) {
 		dev_err(&pci_dev->dev, "No device data found\n");
--- linux-2.6.12-rc3/drivers/char/tpm/tpm_nsc.c	2005-04-27 10:40:16.000000000 -0500
+++ linux-2.6.12-rc2/drivers/char/tpm/tpm_nsc.c	2005-04-25 18:49:08.000000000 -0500
@@ -223,8 +231,9 @@ static struct tpm_vendor_specific tpm_ns
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
 	.base = TPM_NSC_BASE,
-	.miscdev = { .fops = &nsc_ops, },
-	
+	.attr = TPM_DEVICE_ATTRS,
+	.miscdev.fops = &nsc_ops,
+
 };
 
 static int __devinit tpm_nsc_init(struct pci_dev *pci_dev,
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.h	2005-04-27 11:03:26.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/chat/tpm/tpm.h	2005-04-27 11:04:11.000000000 -0500
@@ -36,6 +36,16 @@ enum {
 	TPM_DATA = 0x4F
 };
 
+extern ssize_t tpm_show_pubek(struct device *, char *);
+extern ssize_t tpm_show_pcrs(struct device *, char *);
+extern ssize_t tpm_show_caps(struct device *, char *);
+extern ssize_t tpm_store_cancel(struct device *, const char *, size_t);
+
+#define TPM_DEVICE_ATTRS { \
+        __ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL), \
+        __ATTR(pcrs, S_IRUGO, tpm_show_pcrs, NULL), \
+        __ATTR(caps, S_IRUGO, tpm_show_caps, NULL), \
+        __ATTR(cancel, S_IWUSR | S_IWGRP, NULL, tpm_store_cancel) }
 
 struct tpm_chip;
 
@@ -48,6 +58,7 @@ struct tpm_vendor_specific {
 	int (*send) (struct tpm_chip *, u8 *, size_t);
 	void (*cancel) (struct tpm_chip *);
 	struct miscdevice miscdev;
+	struct device_attribute attr[TPM_NUM_ATTR];
 };
 
 struct tpm_chip {
