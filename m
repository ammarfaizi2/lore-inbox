Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTKYQbD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTKYQbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:31:03 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:54290 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S262098AbTKYQa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:30:58 -0500
Date: Tue, 25 Nov 2003 16:30:05 +0000
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: [Patch 1/5] dm: fix block device resizing
Message-ID: <20031125163005.GB524@reti>
References: <20031125162451.GA524@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125162451.GA524@reti>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When setting the size of a Device-Mapper device in the gendisk entry,
also try to set the size of the corresponding block_device entry's
inode. This is necessary to allow online device/filesystem resizing to
work correctly.  [Kevin Corry]
--- diff/drivers/md/dm.c	2003-09-30 15:46:14.000000000 +0100
+++ source/drivers/md/dm.c	2003-11-25 15:36:59.000000000 +0000
@@ -666,6 +666,20 @@
 	up_write(&md->lock);
 }
 
+static void __set_size(struct gendisk *disk, sector_t size)
+{
+	struct block_device *bdev;
+
+	set_capacity(disk, size);
+	bdev = bdget_disk(disk, 0);
+	if (bdev) {
+		down(&bdev->bd_inode->i_sem);
+		i_size_write(bdev->bd_inode, size << SECTOR_SHIFT);
+		up(&bdev->bd_inode->i_sem);
+		bdput(bdev);
+	}
+}
+
 static int __bind(struct mapped_device *md, struct dm_table *t)
 {
 	request_queue_t *q = md->queue;
@@ -673,7 +687,7 @@
 	md->map = t;
 
 	size = dm_table_get_size(t);
-	set_capacity(md->disk, size);
+	__set_size(md->disk, size);
 	if (size == 0)
 		return 0;
 
@@ -692,7 +706,6 @@
 	dm_table_event_callback(md->map, NULL, NULL);
 	dm_table_put(md->map);
 	md->map = NULL;
-	set_capacity(md->disk, 0);
 }
 
 /*
