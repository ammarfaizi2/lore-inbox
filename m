Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVIQVpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVIQVpH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 17:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVIQVpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 17:45:06 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:5259 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751206AbVIQVpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 17:45:05 -0400
Date: Sat, 17 Sep 2005 16:44:44 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, axboe@suse.de, bjorn.helgaas@hp.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/1] cciss: busy_initializing bug fix
Message-ID: <20050917214444.GA21098@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com, mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 of 1 (9th in a series, if that makes sense)

This patch fixes the problem Bjorn reported. The busy_initializing flag
should have cleared before going into the for loop. 
I didn't see this because I wasn't booting cciss on my test system.
The other patches I submitted should be applied first, or reapplied
whatever the case may be...
Please include this patch.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2613-mm3/drivers/block/cciss.c lx2613-mm3-busy-bug/drivers/block/cciss.c
--- lx2613-mm3/drivers/block/cciss.c	2005-09-13 12:10:52.000000000 -0500
+++ lx2613-mm3-busy-bug/drivers/block/cciss.c	2005-09-17 15:13:05.596434712 -0500
@@ -483,9 +483,6 @@ static int cciss_open(struct inode *inod
 	printk(KERN_DEBUG "cciss_open %s\n", inode->i_bdev->bd_disk->disk_name);
 #endif /* CCISS_DEBUG */ 
 
-	if (host->busy_initializing)
-		return -EBUSY;
-
 	if (host->busy_initializing || drv->busy_configuring)
 		return -EBUSY;
 	/*
@@ -2991,6 +2988,7 @@ static int __devinit cciss_init_one(stru
 	hba[i]->access.set_intr_mask(hba[i], CCISS_INTR_ON);
 
 	cciss_procinit(i);
+	hba[i]->busy_initializing = 0;
 
 	for(j=0; j < NWD; j++) { /* mfm */
 		drive_info_struct *drv = &(hba[i]->drv[j]);
@@ -3033,7 +3031,6 @@ static int __devinit cciss_init_one(stru
 		add_disk(disk);
 	}
 
-	hba[i]->busy_initializing = 0;
 	return(1);
 
 clean4:
