Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbVGKWUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbVGKWUh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVGKWUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:20:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62187 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262950AbVGKWUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:20:24 -0400
Date: Mon, 11 Jul 2005 23:20:13 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: [2/4] Fix deadlocks in core
Message-ID: <20050711222013.GD12355@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid another bdget_disk which can deadlock.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

--- diff/drivers/md/dm.c	2005-07-11 22:52:10.000000000 +0100
+++ source/drivers/md/dm.c	2005-07-11 22:57:58.000000000 +0100
@@ -825,18 +825,13 @@
 	wake_up(&md->eventq);
 }
 
-static void __set_size(struct gendisk *disk, sector_t size)
+static void __set_size(struct mapped_device *md, sector_t size)
 {
-	struct block_device *bdev;
+	set_capacity(md->disk, size);
 
-	set_capacity(disk, size);
-	bdev = bdget_disk(disk, 0);
-	if (bdev) {
-		down(&bdev->bd_inode->i_sem);
-		i_size_write(bdev->bd_inode, (loff_t)size << SECTOR_SHIFT);
-		up(&bdev->bd_inode->i_sem);
-		bdput(bdev);
-	}
+	down(&md->frozen_bdev->bd_inode->i_sem);
+	i_size_write(md->frozen_bdev->bd_inode, (loff_t)size << SECTOR_SHIFT);
+	up(&md->frozen_bdev->bd_inode->i_sem);
 }
 
 static int __bind(struct mapped_device *md, struct dm_table *t)
@@ -845,7 +840,7 @@
 	sector_t size;
 
 	size = dm_table_get_size(t);
-	__set_size(md->disk, size);
+	__set_size(md, size);
 	if (size == 0)
 		return 0;
 
