Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161372AbWI2SbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161372AbWI2SbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161370AbWI2SbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:31:06 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:21738 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161381AbWI2SbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:31:03 -0400
Subject: Re: [PATCH 2/2] new bd_mutex lockdep annotation
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Neil Brown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>,
       Andrew Morton <akpm@osdl.org>, Jason Baron <jbaron@redhat.com>
In-Reply-To: <1158223815.30737.86.camel@taijtu>
References: <20060913174312.528491000@chello.nl>
	 <20060913174650.432175000@chello.nl>
	 <17673.153.361371.49294@cse.unsw.edu.au> <1158223815.30737.86.camel@taijtu>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 20:30:55 +0200
Message-Id: <1159554656.13651.15.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please hold on this, Al Viro doesn't agree with it.

Calling get_gendisk() from bdget() changes the bdget() semantics too
much. For one it enables bdget() to load modules.

Al proposed the following approach. Neil can you agree with this too?

---
Avoid the nesting of bd_mutex by serializing the locks. This is made
easier by changing the ->bd_part_count rules, its now only changed for
the first openers/closers.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 92de28d..0ffc4f0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -898,12 +889,15 @@ void bd_set_size(struct block_device *bd
 }
 EXPORT_SYMBOL(bd_set_size);
 
+static int __blkdev_put(struct block_device *bdev, int part);
+
 static int do_open(struct block_device *bdev, struct file *file)
 {
 	struct module *owner = NULL;
 	struct gendisk *disk;
 	int ret = -ENXIO;
 	int part;
+	struct block_device *whole = NULL;
 
 	file->f_mapping = bdev->bd_inode->i_mapping;
 	lock_kernel();
@@ -937,30 +931,42 @@ static int do_open(struct block_device *
 				rescan_partitions(disk, bdev);
 		} else {
 			struct hd_struct *p;
-			struct block_device *whole;
+
+			mutex_unlock(&bdev->bd_mutex);
+
 			whole = bdget_disk(disk, 0);
 			ret = -ENOMEM;
 			if (!whole)
-				goto out_first;
+				goto out_first_lock;
 			ret = blkdev_get(whole, file->f_mode, file->f_flags);
 			if (ret)
-				goto out_first;
-			bdev->bd_contains = whole;
+				goto out_first_lock;
+
 			mutex_lock(&whole->bd_mutex);
 			whole->bd_part_count++;
 			p = disk->part[part - 1];
-			bdev->bd_inode->i_data.backing_dev_info =
-			   whole->bd_inode->i_data.backing_dev_info;
 			if (!(disk->flags & GENHD_FL_UP) || !p || !p->nr_sects) {
-				whole->bd_part_count--;
 				mutex_unlock(&whole->bd_mutex);
 				ret = -ENXIO;
-				goto out_first;
+				goto out_first_lock;
 			}
 			kobject_get(&p->kobj);
-			bdev->bd_part = p;
-			bd_set_size(bdev, (loff_t) p->nr_sects << 9);
 			mutex_unlock(&whole->bd_mutex);
+
+			mutex_lock(&bdev->bd_mutex);
+			if (bdev->bd_contains != whole) {
+				bdev->bd_contains = whole;
+				bdev->bd_inode->i_data.backing_dev_info =
+				  whole->bd_inode->i_data.backing_dev_info;
+				bdev->bd_part = p;
+				bd_set_size(bdev, (loff_t) p->nr_sects << 9);
+				whole = NULL;
+			} else {
+				mutex_unlock(&bdev->bd_mutex);
+				kobject_put(&p->kobj);
+				__blkdev_put(whole, 1);
+				mutex_lock(&bdev->bd_mutex);
+			}
 		}
 	} else {
 		put_disk(disk);
@@ -973,10 +979,6 @@ static int do_open(struct block_device *
 			}
 			if (bdev->bd_invalidated)
 				rescan_partitions(bdev->bd_disk, bdev);
-		} else {
-			mutex_lock(&bdev->bd_contains->bd_mutex);
-			bdev->bd_contains->bd_part_count++;
-			mutex_unlock(&bdev->bd_contains->bd_mutex);
 		}
 	}
 	bdev->bd_openers++;
@@ -984,11 +986,12 @@ static int do_open(struct block_device *
 	unlock_kernel();
 	return 0;
 
+out_first_lock:
+	if (whole)
+		__blkdev_put(whole, 1);
+	mutex_lock(&bdev->bd_mutex);
 out_first:
 	bdev->bd_disk = NULL;
-	bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
-	if (bdev != bdev->bd_contains)
-		blkdev_put(bdev->bd_contains);
 	bdev->bd_contains = NULL;
 	put_disk(disk);
 	module_put(owner);
@@ -1049,14 +1052,17 @@ static int blkdev_open(struct inode * in
 	return res;
 }
 
-int blkdev_put(struct block_device *bdev)
+static int __blkdev_put(struct block_device *bdev, int part)
 {
 	int ret = 0;
 	struct inode *bd_inode = bdev->bd_inode;
 	struct gendisk *disk = bdev->bd_disk;
+	struct block_device *victim = NULL;
 
 	mutex_lock(&bdev->bd_mutex);
 	lock_kernel();
+	if (part)
+		bdev->bd_part_count--;
 	if (!--bdev->bd_openers) {
 		sync_blockdev(bdev);
 		kill_bdev(bdev);
@@ -1064,10 +1070,6 @@ int blkdev_put(struct block_device *bdev
 	if (bdev->bd_contains == bdev) {
 		if (disk->fops->release)
 			ret = disk->fops->release(bd_inode, NULL);
-	} else {
-		mutex_lock(&bdev->bd_contains->bd_mutex);
-		bdev->bd_contains->bd_part_count--;
-		mutex_unlock(&bdev->bd_contains->bd_mutex);
 	}
 	if (!bdev->bd_openers) {
 		struct module *owner = disk->fops->owner;
@@ -1081,17 +1083,23 @@ int blkdev_put(struct block_device *bdev
 		}
 		bdev->bd_disk = NULL;
 		bdev->bd_inode->i_data.backing_dev_info = &default_backing_dev_info;
-		if (bdev != bdev->bd_contains) {
-			blkdev_put(bdev->bd_contains);
-		}
+		if (bdev != bdev->bd_contains)
+			victim = bdev->bd_contains;
 		bdev->bd_contains = NULL;
 	}
 	unlock_kernel();
 	mutex_unlock(&bdev->bd_mutex);
+	if (victim)
+		__blkdev_put(victim, 1);
 	bdput(bdev);
 	return ret;
 }
 
+int blkdev_put(struct block_device *bdev)
+{
+	return __blkdev_put(bdev, 0);
+}
+
 EXPORT_SYMBOL(blkdev_put);
 
 static int blkdev_close(struct inode * inode, struct file * filp)


