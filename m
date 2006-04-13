Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWDMUgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWDMUgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWDMUfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:35:55 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:37398 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964972AbWDMUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:35:49 -0400
Date: Thu, 13 Apr 2006 16:35:46 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 05/08] dm: add DMF_FREEING flag to indicate that a mapped_device is no longer legal to use
Message-ID: <20060413203546.GA3235@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 The previous patch serialized reference counting with respect to users with
 valid references, but there is a chicken-egg problem between the block layer
 and dm that causes the gendisk associated with a mapping to keep a reference-
 less pointer to the mapped_device. 

 Without major reconstruction, the pointer must be referenceless or we run
 into a chicken-egg problem with freeing the disk or the mapped_device. When
 the block layer is actually using the mapped_device, a reference is taken.

 This patch adds a flag to indicate that the mapped_device is no longer valid.
 In free_dev(), we reset the ->private_data pointer, but prior to that, the
 block layer can still attempt to open the device. The flag is used to 
 check the validity of the pointer, and return -ENXIO if it is invalid.
 Otherwise, an appropriate reference is taken.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
--
 drivers/md/dm.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff -ruNpX ../dontdiff linux-2.6.16-staging1/drivers/md/dm.c linux-2.6.16-staging2/drivers/md/dm.c
--- linux-2.6.16-staging1/drivers/md/dm.c	2006-04-13 16:18:20.000000000 -0400
+++ linux-2.6.16-staging2/drivers/md/dm.c	2006-04-13 16:18:20.000000000 -0400
@@ -60,6 +60,7 @@ union map_info *dm_get_mapinfo(struct bi
 #define DMF_BLOCK_IO 0
 #define DMF_SUSPENDED 1
 #define DMF_FROZEN 2
+#define DMF_FREEING 3
 
 struct mapped_device {
 	struct rw_semaphore io_lock;
@@ -216,9 +217,16 @@ static int dm_blk_open(struct inode *ino
 {
 	struct mapped_device *md;
 
+	spin_lock(&_minor_lock);
 	md = inode->i_bdev->bd_disk->private_data;
-	dm_get(md);
-	return 0;
+	if (md) {
+		if (test_bit(DMF_FREEING, &md->flags) == 0)
+			dm_get(md);
+		else
+			md = NULL;
+	}
+	spin_unlock(&_minor_lock);
+	return md ? 0 : -ENXIO;
 }
 
 static int dm_blk_close(struct inode *inode, struct file *file)
@@ -870,6 +878,11 @@ static void free_dev(struct mapped_devic
 	mempool_destroy(md->io_pool);
 	del_gendisk(md->disk);
 	free_minor(minor);
+
+	spin_lock(&_minor_lock);
+	md->disk->private_data = NULL;
+	spin_unlock(&_minor_lock);
+
 	put_disk(md->disk);
 	blk_put_queue(md->queue);
 	kfree(md);
@@ -970,6 +983,11 @@ static struct mapped_device *dm_find_md(
 	if (md && (md == MINOR_ALLOCED || (dm_disk(md)->first_minor != minor)))
 		md = NULL;
 
+	if (md) {
+		if (test_bit(DMF_FREEING, &md->flags))
+			md = NULL;
+	}
+
 	spin_unlock(&_minor_lock);
 
 	return md;
@@ -1010,8 +1028,11 @@ void dm_put(struct mapped_device *md)
 {
 	struct dm_table *map = dm_get_table(md);
 
+	BUG_ON(test_bit(DMF_FREEING, &md->flags));
+
 	if (atomic_dec_and_lock(&md->holders, &_minor_lock)) {
 		idr_replace(&_minor_idr, MINOR_ALLOCED, md->disk->first_minor);
+		set_bit(DMF_FREEING, &md->flags);
 		spin_unlock(&_minor_lock);
 		if (!dm_suspended(md)) {
 			dm_table_presuspend_targets(map);
