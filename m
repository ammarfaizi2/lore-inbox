Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbVIIWDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbVIIWDB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbVIIWDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:03:00 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:41683 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1030426AbVIIWC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:02:58 -0400
Date: Fri, 9 Sep 2005 17:02:34 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/8] cciss:busy_initializing flag
Message-ID: <20050909220234.GB4616@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 8
This patch adds a flag called busy_initializing. If there are multiple
controllers in a server AND the HP agents are running it's possible
the agents may try to poll a card that is still initializing if the 
driver is removed and then added again.
Please consider this for inclusion.

Signed-off-by: Don Brace <dab@hp.com>
Signed-of-by: Mike Miller <mike.miller@hp.com>

 cciss.c |    8 ++++++++
 cciss.h |    1 +
 2 files changed, 9 insertions(+)
--------------------------------------------------------------------------------
diff -burNp lx2613-p001/drivers/block/cciss.c lx2613/drivers/block/cciss.c
--- lx2613-p001/drivers/block/cciss.c	2005-09-07 13:27:05.390086000 -0500
+++ lx2613/drivers/block/cciss.c	2005-09-07 14:27:13.573559656 -0500
@@ -468,6 +468,9 @@ static int cciss_open(struct inode *inod
 	printk(KERN_DEBUG "cciss_open %s\n", inode->i_bdev->bd_disk->disk_name);
 #endif /* CCISS_DEBUG */ 
 
+	if (host->busy_initializing)
+		return -EBUSY;
+
 	/*
 	 * Root is allowed to open raw volume zero even if it's not configured
 	 * so array config can still work. Root is also allowed to open any
@@ -2743,6 +2746,9 @@ static int __devinit cciss_init_one(stru
 	i = alloc_cciss_hba();
 	if(i < 0)
 		return (-1);
+
+	hba[i]->busy_initializing = 1;
+
 	if (cciss_pci_init(hba[i], pdev) != 0)
 		goto clean1;
 
@@ -2865,6 +2871,7 @@ static int __devinit cciss_init_one(stru
 		add_disk(disk);
 	}
 
+	hba[i]->busy_initializing = 0;
 	return(1);
 
 clean4:
@@ -2885,6 +2892,7 @@ clean2:
 clean1:
 	release_io_mem(hba[i]);
 	free_hba(i);
+	hba[i]->busy_initializing = 0;
 	return(-1);
 }
 
diff -burNp lx2613-p001/drivers/block/cciss.h lx2613/drivers/block/cciss.h
--- lx2613-p001/drivers/block/cciss.h	2005-08-28 18:41:01.000000000 -0500
+++ lx2613/drivers/block/cciss.h	2005-09-07 14:24:55.174599496 -0500
@@ -83,6 +83,7 @@ struct ctlr_info 
 	int			nr_allocs;
 	int			nr_frees; 
 	int			busy_configuring;
+	int			busy_initializing;
 
 	/* This element holds the zero based queue number of the last
 	 * queue to be started.  It is used for fairness.
