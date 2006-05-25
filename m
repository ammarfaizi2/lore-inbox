Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWEYTQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWEYTQk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWEYTQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:16:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15500 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030357AbWEYTQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:16:39 -0400
Date: Thu, 25 May 2006 20:16:35 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/10] dm: add DMF_FREEING
Message-ID: <20060525191635.GX4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

There is a chicken and egg problem between the block layer and dm in
which the gendisk associated with a mapping keeps a reference-less 
pointer to the mapped_device. 

This patch uses a new flag DMF_FREEING to indicate when the
mapped_device is no longer valid.  This is checked to prevent any
attempt to open the device from succeeding while the device is being
destroyed.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17-rc4/drivers/md/dm.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/md/dm.c	2006-05-23 18:17:21.000000000 +0100
+++ linux-2.6.17-rc4/drivers/md/dm.c	2006-05-23 18:18:25.000000000 +0100
@@ -63,6 +63,7 @@ union map_info *dm_get_mapinfo(struct bi
 #define DMF_BLOCK_IO 0
 #define DMF_SUSPENDED 1
 #define DMF_FROZEN 2
+#define DMF_FREEING 3
 
 struct mapped_device {
 	struct rw_semaphore io_lock;
@@ -221,9 +222,23 @@ static int dm_blk_open(struct inode *ino
 {
 	struct mapped_device *md;
 
+	spin_lock(&_minor_lock);
+
 	md = inode->i_bdev->bd_disk->private_data;
+	if (!md)
+		goto out;
+
+	if (test_bit(DMF_FREEING, &md->flags)) {
+		md = NULL;
+		goto out;
+	}
+
 	dm_get(md);
-	return 0;
+
+out:
+	spin_unlock(&_minor_lock);
+
+	return md ? 0 : -ENXIO;
 }
 
 static int dm_blk_close(struct inode *inode, struct file *file)
@@ -919,6 +934,11 @@ static void free_dev(struct mapped_devic
 	mempool_destroy(md->io_pool);
 	del_gendisk(md->disk);
 	free_minor(minor);
+
+	spin_lock(&_minor_lock);
+	md->disk->private_data = NULL;
+	spin_unlock(&_minor_lock);
+
 	put_disk(md->disk);
 	blk_cleanup_queue(md->queue);
 	kfree(md);
@@ -1023,9 +1043,14 @@ static struct mapped_device *dm_find_md(
 	spin_lock(&_minor_lock);
 
 	md = idr_find(&_minor_idr, minor);
-	if (md && (md == MINOR_ALLOCED || (dm_disk(md)->first_minor != minor)))
+	if (md && (md == MINOR_ALLOCED ||
+		   (dm_disk(md)->first_minor != minor) ||
+	           test_bit(DMF_FREEING, &md->flags))) {
 		md = NULL;
+		goto out;
+	}
 
+out:
 	spin_unlock(&_minor_lock);
 
 	return md;
@@ -1060,9 +1085,12 @@ void dm_put(struct mapped_device *md)
 {
 	struct dm_table *map;
 
+	BUG_ON(test_bit(DMF_FREEING, &md->flags));
+
 	if (atomic_dec_and_lock(&md->holders, &_minor_lock)) {
 		map = dm_get_table(md);
 		idr_replace(&_minor_idr, MINOR_ALLOCED, dm_disk(md)->first_minor);
+		set_bit(DMF_FREEING, &md->flags);
 		spin_unlock(&_minor_lock);
 		if (!dm_suspended(md)) {
 			dm_table_presuspend_targets(map);
