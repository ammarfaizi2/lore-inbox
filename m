Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263251AbVFXUn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263251AbVFXUn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263247AbVFXUn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:43:26 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:19378 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263220AbVFXUmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:42:12 -0400
Subject: [PATCH] tpm: fix misc name memory problem
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 24 Jun 2005 15:42:09 -0500
Message-Id: <1119645729.31799.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was using invalid memory for the miscdevice.name.  This patch fixes
the problem which was manifested by an ugly entry in /proc/misc.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
Index: drivers/char/tpm/tpm.c
===================================================================
RCS file: /cvsroot/tpmdd/tpmdd/drivers/char/tpm/tpm.c,v
retrieving revision 1.28
diff -u -p -r1.28 tpm.c
--- ./drivers/char/tpm/tpm.c	15 Jun 2005 17:15:18 -0000	1.28
+++ ./drivers/char/tpm/tpm.c	23 Jun 2005 21:37:46 -0000
@@ -488,6 +497,7 @@ void __devexit tpm_remove(struct pci_dev
 
 	pci_set_drvdata(pci_dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
+	kfree(&chip->vendor->miscdev.name);
 
 	sysfs_remove_group(&pci_dev->dev.kobj, chip->vendor->attr_group);
 
@@ -551,7 +561,9 @@ EXPORT_SYMBOL_GPL(tpm_pm_resume);
 int tpm_register_hardware(struct pci_dev *pci_dev,
 			  struct tpm_vendor_specific *entry)
 {
-	char devname[7];
+#define DEVNAME_SIZE 7
+	
+	char *devname;
 	struct tpm_chip *chip;
 	int i, j;
 
@@ -594,7 +606,8 @@ dev_num_search_complete:
 	else
 		chip->vendor->miscdev.minor = MISC_DYNAMIC_MINOR;
 
-	snprintf(devname, sizeof(devname), "%s%d", "tpm", chip->dev_num);
+	devname = kmalloc(DEVNAME_SIZE, GFP_KERNEL);
+	scnprintf(devname, DEVNAME_SIZE, "%s%d", "tpm", chip->dev_num);
 	chip->vendor->miscdev.name = devname;
 
 	chip->vendor->miscdev.dev = &(pci_dev->dev);


