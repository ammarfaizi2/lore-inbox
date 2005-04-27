Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVD0Wvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVD0Wvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVD0Wvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:51:36 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:13797 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262067AbVD0WTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:19:39 -0400
Date: Wed, 27 Apr 2005 17:19:25 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH 12 of 12] Fix Tpm driver -- locks
Message-ID: <Pine.LNX.4.61.0504271705220.3929@jo.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lock in the register hardware is missing and the one in release is 
misplaced. This patch fixes these issues.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-27 14:19:17.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-27 14:25:04.000000000 -0500
@@ -445,15 +445,15 @@ EXPORT_SYMBOL_GPL(tpm_open);
 int tpm_release(struct inode *inode, struct file *file)
 {
 	struct tpm_chip *chip = file->private_data;
-	
-	file->private_data = NULL;
 
 	spin_lock(&driver_lock);
+	file->private_data = NULL;
 	chip->num_opens--;
 	del_singleshot_timer_sync(&chip->user_read_timer);
 	atomic_set(&chip->data_pending, 0);
-
 	pci_dev_put(chip->pci_dev);
+	kfree(chip->data_buffer);
+	spin_unlock(&driver_lock);
 	return 0;
 }
 
@@ -665,10 +665,14 @@ dev_num_search_complete:
 		return -ENODEV;
 	}
 
+	spin_lock(&driver_lock);
+
 	pci_set_drvdata(pci_dev, chip);
 
 	list_add(&chip->list, &tpm_chip_list);
 
+	spin_unlock(&driver_lock);
+
 	for (i = 0; i < TPM_NUM_ATTR; i++)
 		device_create_file(&pci_dev->dev, &chip->vendor->attr[i]);
 
