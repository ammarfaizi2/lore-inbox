Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVEETtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVEETtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVEETrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:47:11 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15327 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262204AbVEETMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 15:12:21 -0400
Date: Thu, 5 May 2005 14:12:10 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12 of 12] Fix Tpm driver -- locks
Message-ID: <Pine.LNX.4.62.0505051407310.5303@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply these fixes to the Tpm driver.  I am resubmitting the entire
patch set that was orginally sent to LKML on April 27 with the changes
that were requested fixed.

This patch was updated to reflect a change in a previous patch in this 
set so it will cleanly apply.

Thanks,
Kylie

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
 
@@ -665,9 +665,13 @@ dev_num_search_complete:
 		return -ENODEV;
 	}
 
+	spin_lock(&driver_lock);
+
 	pci_set_drvdata(pci_dev, chip);
 
 	list_add(&chip->list, &tpm_chip_list);
 
+	spin_unlock(&driver_lock);
+
	sysfs_create_group(&pci_dev->dev.kobj, chip->vendor->attr_group);

