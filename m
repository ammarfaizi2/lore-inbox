Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264071AbUDQWIN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 18:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbUDQWHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 18:07:40 -0400
Received: from verein.lst.de ([212.34.189.10]:39871 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264063AbUDQWGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 18:06:52 -0400
Date: Sun, 18 Apr 2004 00:06:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] lockfs - dm bits
Message-ID: <20040417220647.GC2573@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the device mapper use the new freeze_bdev/thaw_bdev
interface.  Extracted from Chris Mason's patch.


--- 1.42/drivers/md/dm.c	Mon Apr 12 19:55:18 2004
+++ edited/drivers/md/dm.c	Sat Apr 17 19:38:36 2004
@@ -12,6 +12,7 @@
 #include <linux/moduleparam.h>
 #include <linux/blkpg.h>
 #include <linux/bio.h>
+#include <linux/buffer_head.h>
 #include <linux/mempool.h>
 #include <linux/slab.h>
 
@@ -46,6 +47,7 @@
  */
 #define DMF_BLOCK_IO 0
 #define DMF_SUSPENDED 1
+#define DMF_FS_LOCKED 2
 
 struct mapped_device {
 	struct rw_semaphore lock;
@@ -80,6 +82,11 @@
 	 */
 	uint32_t event_nr;
 	wait_queue_head_t eventq;
+
+	/*
+	 * freeze/thaw support require holding onto a super block
+	 */
+	struct super_block *frozen_sb;
 };
 
 #define MIN_IOS 256
@@ -882,6 +889,52 @@
 }
 
 /*
+ * Functions to lock and unlock any filesystem running on the
+ * device.
+ */
+static int __lock_fs(struct mapped_device *md)
+{
+	struct block_device *bdev;
+
+	if (test_and_set_bit(DMF_FS_LOCKED, &md->flags))
+		return 0;
+
+	bdev = bdget_disk(md->disk, 0);
+	if (!bdev) {
+		DMWARN("bdget failed in __lock_fs");
+		return -ENOMEM;
+	}
+
+	WARN_ON(md->frozen_sb);
+	md->frozen_sb = freeze_bdev(bdev);
+	/* don't bdput right now, we don't want the bdev
+	 * to go away while it is locked.  We'll bdput
+	 * in __unlock_fs
+	 */
+	return 0;
+}
+
+static int __unlock_fs(struct mapped_device *md)
+{
+	struct block_device *bdev;
+
+	if (!test_and_clear_bit(DMF_FS_LOCKED, &md->flags))
+		return 0;
+
+	bdev = bdget_disk(md->disk, 0);
+	if (!bdev) {
+		DMWARN("bdget failed in __unlock_fs");
+		return -ENOMEM;
+	}
+
+	thaw_bdev(bdev, md->frozen_sb);
+	md->frozen_sb = NULL;
+	bdput(bdev);
+	bdput(bdev);
+	return 0;
+}
+
+/*
  * We need to be able to change a mapping table under a mounted
  * filesystem.  For example we might want to move some data in
  * the background.  Before the table can be swapped with
@@ -893,13 +946,27 @@
 	struct dm_table *map;
 	DECLARE_WAITQUEUE(wait, current);
 
-	down_write(&md->lock);
+	/* Flush I/O to the device. */
+	down_read(&md->lock);
+	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
+		up_read(&md->lock);
+		return -EINVAL;
+	}
+
+	__lock_fs(md);
+	up_read(&md->lock);
 
 	/*
 	 * First we set the BLOCK_IO flag so no more ios will be
 	 * mapped.
 	 */
+	down_write(&md->lock);
 	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
+		/*
+		 * If we get here we know another thread is
+		 * trying to suspend as well, so we leave the fs
+		 * locked for this thread.
+		 */
 		up_write(&md->lock);
 		return -EINVAL;
 	}
@@ -963,6 +1030,7 @@
 	def = bio_list_get(&md->deferred);
 	__flush_deferred_io(md, def);
 	up_write(&md->lock);
+	__unlock_fs(md);
 	dm_table_unplug_all(map);
 	dm_table_put(map);
 
