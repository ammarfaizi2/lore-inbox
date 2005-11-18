Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVKRUTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVKRUTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVKRUTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:19:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7657 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932401AbVKRUTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:19:04 -0500
Date: Fri, 18 Nov 2005 20:18:42 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: rename frozen_bdev
Message-ID: <20051118201842.GT11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename frozen_bdev to suspended_bdev and move the bdget outside lockfs.
(This prepares for making lockfs optional.)

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14/drivers/md/dm.c
===================================================================
--- linux-2.6.14.orig/drivers/md/dm.c	2005-11-18 14:40:52.000000000 +0000
+++ linux-2.6.14/drivers/md/dm.c	2005-11-18 20:10:22.000000000 +0000
@@ -98,7 +98,7 @@ struct mapped_device {
 	 * freeze/thaw support require holding onto a super block
 	 */
 	struct super_block *frozen_sb;
-	struct block_device *frozen_bdev;
+	struct block_device *suspended_bdev;
 };
 
 #define MIN_IOS 256
@@ -847,9 +847,9 @@ static void __set_size(struct mapped_dev
 {
 	set_capacity(md->disk, size);
 
-	down(&md->frozen_bdev->bd_inode->i_sem);
-	i_size_write(md->frozen_bdev->bd_inode, (loff_t)size << SECTOR_SHIFT);
-	up(&md->frozen_bdev->bd_inode->i_sem);
+	down(&md->suspended_bdev->bd_inode->i_sem);
+	i_size_write(md->suspended_bdev->bd_inode, (loff_t)size << SECTOR_SHIFT);
+	up(&md->suspended_bdev->bd_inode->i_sem);
 }
 
 static int __bind(struct mapped_device *md, struct dm_table *t)
@@ -1021,43 +1021,27 @@ out:
  */
 static int lock_fs(struct mapped_device *md)
 {
-	int r = -ENOMEM;
-
-	md->frozen_bdev = bdget_disk(md->disk, 0);
-	if (!md->frozen_bdev) {
-		DMWARN("bdget failed in lock_fs");
-		goto out;
-	}
+	int r;
 
 	WARN_ON(md->frozen_sb);
 
-	md->frozen_sb = freeze_bdev(md->frozen_bdev);
+	md->frozen_sb = freeze_bdev(md->suspended_bdev);
 	if (IS_ERR(md->frozen_sb)) {
 		r = PTR_ERR(md->frozen_sb);
-		goto out_bdput;
+		md->frozen_sb = NULL;
+		return r;
 	}
 
 	/* don't bdput right now, we don't want the bdev
-	 * to go away while it is locked.  We'll bdput
-	 * in unlock_fs
+	 * to go away while it is locked.
 	 */
 	return 0;
-
-out_bdput:
-	bdput(md->frozen_bdev);
-	md->frozen_sb = NULL;
-	md->frozen_bdev = NULL;
-out:
-	return r;
 }
 
 static void unlock_fs(struct mapped_device *md)
 {
-	thaw_bdev(md->frozen_bdev, md->frozen_sb);
-	bdput(md->frozen_bdev);
-
+	thaw_bdev(md->suspended_bdev, md->frozen_sb);
 	md->frozen_sb = NULL;
-	md->frozen_bdev = NULL;
 }
 
 /*
@@ -1083,6 +1067,13 @@ int dm_suspend(struct mapped_device *md)
 	/* This does not get reverted if there's an error later. */
 	dm_table_presuspend_targets(map);
 
+	md->suspended_bdev = bdget_disk(md->disk, 0);
+	if (!md->suspended_bdev) {
+		DMWARN("bdget failed in dm_suspend");
+		r = -ENOMEM;
+		goto out;
+	}
+
 	/* Flush I/O to the device. */
 	r = lock_fs(md);
 	if (r)
@@ -1135,6 +1126,11 @@ int dm_suspend(struct mapped_device *md)
 	r = 0;
 
 out:
+	if (r && md->suspended_bdev) {
+		bdput(md->suspended_bdev);
+		md->suspended_bdev = NULL;
+	}
+
 	dm_table_put(map);
 	up(&md->suspend_lock);
 	return r;
@@ -1165,6 +1161,9 @@ int dm_resume(struct mapped_device *md)
 
 	unlock_fs(md);
 
+	bdput(md->suspended_bdev);
+	md->suspended_bdev = NULL;
+
 	clear_bit(DMF_SUSPENDED, &md->flags);
 
 	dm_table_unplug_all(map);
