Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289566AbSBFJga>; Wed, 6 Feb 2002 04:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289363AbSBFJgT>; Wed, 6 Feb 2002 04:36:19 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:21007 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S288967AbSBFJgL>;
	Wed, 6 Feb 2002 04:36:11 -0500
Message-ID: <3C60F4EE.40BF2769@yahoo.com>
Date: Wed, 06 Feb 2002 04:18:38 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] kdev_t changes for ide/hd.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that 2.5.3 needs these additional changes for drivers/ide/hd.c to work:

	MINOR -> minor
	MKDEV -> mk_kdev
	!(...) -> kdev_none(...)

The bio changes must be okay as it now passes the "yep, it boots" test.  :)

Paul.


--- drivers/ide/hd.c~	Tue Feb  5 02:39:46 2002
+++ drivers/ide/hd.c	Wed Feb  6 02:14:58 2002
@@ -558,7 +558,7 @@
 		reset_hd();
 		return;
 	}
-	dev = MINOR(CURRENT->rq_dev);
+	dev = minor(CURRENT->rq_dev);
 	block = CURRENT->sector;
 	nsect = CURRENT->nr_sectors;
 	if (dev >= (NR_HD<<6) || (dev & 0x3f) ||
@@ -568,7 +568,7 @@
 			       kdevname(CURRENT->rq_dev));
 		else
 			printk("hd%c: bad access: block=%d, count=%d\n",
-				(MINOR(CURRENT->rq_dev)>>6)+'a', block, nsect);
+				(minor(CURRENT->rq_dev)>>6)+'a', block, nsect);
 		end_request(0);
 		goto repeat;
 	}
@@ -626,7 +626,7 @@
 	struct hd_geometry *loc = (struct hd_geometry *) arg;
 	int dev;
 
-	if ((!inode) || !(inode->i_rdev))
+	if ((!inode) || kdev_none(inode->i_rdev))
 		return -EINVAL;
 	dev = DEVICE_NR(inode->i_rdev);
 	if (dev >= NR_HD)
@@ -824,7 +824,7 @@
 	hd_gendisk.nr_real = NR_HD;
 
 	for(drive=0; drive < NR_HD; drive++)
-		register_disk(&hd_gendisk, MKDEV(MAJOR_NR,drive<<6), 1<<6,
+		register_disk(&hd_gendisk, mk_kdev(MAJOR_NR,drive<<6), 1<<6,
 			&hd_fops, hd_info[drive].head * hd_info[drive].sect *
 			hd_info[drive].cyl);
 }



