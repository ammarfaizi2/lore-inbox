Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWILP4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWILP4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWILPu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:50:59 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:63382 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751419AbWILPuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:50:55 -0400
Message-Id: <20060912144904.104909000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Mike Christie <michaelc@cs.wisc.edu>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 10/20] mm: block device swap notification
Content-Disposition: inline; filename=swapdev.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some block devices need to do some extra work when used as swap device.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: James E.J. Bottomley <James.Bottomley@SteelEye.com>
CC: Mike Christie <michaelc@cs.wisc.edu>
CC: Pavel Machek <pavel@ucw.cz>
---
 include/linux/fs.h |    1 +
 mm/swapfile.c      |    7 +++++++
 2 files changed, 8 insertions(+)

Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h
+++ linux-2.6/include/linux/fs.h
@@ -1017,6 +1017,7 @@ struct block_device_operations {
 	int (*media_changed) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
+	int (*swapdev)(struct gendisk *, int enable);
 	struct module *owner;
 };
 
Index: linux-2.6/mm/swapfile.c
===================================================================
--- linux-2.6.orig/mm/swapfile.c
+++ linux-2.6/mm/swapfile.c
@@ -1273,6 +1273,8 @@ asmlinkage long sys_swapoff(const char _
 	inode = mapping->host;
 	if (S_ISBLK(inode->i_mode)) {
 		struct block_device *bdev = I_BDEV(inode);
+		if (bdev->bd_disk->fops->swapdev)
+			bdev->bd_disk->fops->swapdev(bdev->bd_disk, 0);
 		set_blocksize(bdev, p->old_block_size);
 		bd_release(bdev);
 	} else {
@@ -1481,6 +1483,11 @@ asmlinkage long sys_swapdev(const char __
 		if (error < 0)
 			goto bad_swap;
 		p->bdev = bdev;
+		if (bdev->bd_disk->fops->swapdev) {
+			error = bdev->bd_disk->fops->swapdev(bdev->bd_disk, 1);
+			if (error < 0)
+				goto bad_swap;
+		}
 	} else if (S_ISREG(inode->i_mode)) {
 		p->bdev = inode->i_sb->s_bdev;
 		mutex_lock(&inode->i_mutex);

--

