Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030652AbWJKGJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030652AbWJKGJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030647AbWJKGJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:09:29 -0400
Received: from mail.suse.de ([195.135.220.2]:35282 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030645AbWJKGJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:09:20 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 11 Oct 2006 16:09:14 +1000
Message-Id: <1061011060914.12448@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 002 of 4] Simplify some aspects of bd_mutex nesting.
References: <20061011155522.7915.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When we open (actually blkdev_get) a partition we need to also open
(get) the whole device that holds the partition.  The involves some
limited recursion.  This patch tries to simplify some aspects of this.

As well as opening the whole device, we need to increment
->bd_part_count when a partition is opened (this is used by
rescan_partitions to avoid a rescan if any partition is active, as
that would be confusing).

The main change this patch makes is to move the inc/dec of
bd_part_count into blkdev_{get,put} for the whole rather than doing it
in blkdev_{get,put} for the partition.

More specifically, we introduce __blkdev_get and __blkdev_put which do
exactly what blkdev_{get,put} did, only with an extra "for_part"
argument (blkget_{get,put} then call the __ version with a '0' for the
extra argument).

If for_part is 1, then the blkdev is being get(put) because a
partition is being opened(closed) for the first(last) time, and so
bd_part_count should be updated (on success).  The particular
advantage of pushing this function down is that the bd_mutex lock
(which is needed to update bd_part_count) is already held at the lower
level.

Note that this slightly changes the semantics of bd_part_count.
Instead of updating it whenever a partition is opened or released, it
is now only updated on the first open or last release.  This is an
adequate semantic as it is only ever tested for "== 0".

Having introduced these functions we remove the current bd_part_count
updates from do_open (which is really the body of blkdev_get) and call
__blkdev_get(... 1).
Similarly in blkget_put we remove the old bd_part_count updates and
call __blkget_put(..., 1).  This call is moved to the end of
__blkdev_put to avoid nested locks of bd_mutex.

Finally the mutex_lock on whole->bd_mutex in do_open can be removed.
It was only really needed to protect bd_part_count, and that is now
managed (and protected) within the recursive call.


The observation that bd_part_count is central to the locking issues,
and the modifications to create __blkdev_put are from Peter Zijlstra.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/block_dev.c |   51 +++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff .prev/fs/block_dev.c ./fs/block_dev.c
--- .prev/fs/block_dev.c	2006-10-11 15:37:10.000000000 +1000
+++ ./fs/block_dev.c	2006-10-11 15:38:31.000000000 +1000
@@ -889,7 +889,10 @@ void bd_set_size(struct block_device *bd
 }
 EXPORT_SYMBOL(bd_set_size);
 
-static int do_open(struct block_device *bdev, struct file *file)
+static int __blkdev_get(struct block_device *bdev, mode_t mode, unsigned flags,
+			int for_part);
+
+static int do_open(struct block_device *bdev, struct file *file, int for_part)
 {
 	struct module *owner = NULL;
 	struct gendisk *disk;
@@ -933,25 +936,21 @@ static int do_open(struct block_device *
 			ret = -ENOMEM;
 			if (!whole)
 				goto out_first;
-			ret = blkdev_get(whole, file->f_mode, file->f_flags);
+			BUG_ON(for_part);
+			ret = __blkdev_get(whole, file->f_mode, file->f_flags, 1);
 			if (ret)
 				goto out_first;
 			bdev->bd_contains = whole;
-			mutex_lock(&whole->bd_mutex);
-			whole->bd_part_count++;
 			p = disk->part[part - 1];
 			bdev->bd_inode->i_data.backing_dev_info =
 			   whole->bd_inode->i_data.backing_dev_info;
 			if (!(disk->flags & GENHD_FL_UP) || !p || !p->nr_sects) {
-				whole->bd_part_count--;
-				mutex_unlock(&whole->bd_mutex);
 				ret = -ENXIO;
 				goto out_first;
 			}
 			kobject_get(&p->kobj);
 			bdev->bd_part = p;
 			bd_set_size(bdev, (loff_t) p->nr_sects << 9);
-			mutex_unlock(&whole->bd_mutex);
 		}
 	} else {
 		put_disk(disk);
@@ -964,13 +963,11 @@ static int do_open(struct block_device *
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
+	if (for_part)
+		bdev->bd_part_count++;
 	mutex_unlock(&bdev->bd_mutex);
 	unlock_kernel();
 	return 0;
@@ -991,7 +988,8 @@ out:
 	return ret;
 }
 
-int blkdev_get(struct block_device *bdev, mode_t mode, unsigned flags)
+static int __blkdev_get(struct block_device *bdev, mode_t mode, unsigned flags,
+			int for_part)
 {
 	/*
 	 * This crockload is due to bad choice of ->open() type.
@@ -1006,9 +1004,13 @@ int blkdev_get(struct block_device *bdev
 	fake_file.f_dentry = &fake_dentry;
 	fake_dentry.d_inode = bdev->bd_inode;
 
-	return do_open(bdev, &fake_file);
+	return do_open(bdev, &fake_file, for_part);
 }
 
+int blkdev_get(struct block_device *bdev, mode_t mode, unsigned flags)
+{
+	return __blkdev_get(bdev, mode, flags, 0);
+}
 EXPORT_SYMBOL(blkdev_get);
 
 static int blkdev_open(struct inode * inode, struct file * filp)
@@ -1026,7 +1028,7 @@ static int blkdev_open(struct inode * in
 
 	bdev = bd_acquire(inode);
 
-	res = do_open(bdev, filp);
+	res = do_open(bdev, filp, 0);
 	if (res)
 		return res;
 
@@ -1040,14 +1042,18 @@ static int blkdev_open(struct inode * in
 	return res;
 }
 
-int blkdev_put(struct block_device *bdev)
+static int __blkdev_put(struct block_device *bdev, int for_part)
 {
 	int ret = 0;
 	struct inode *bd_inode = bdev->bd_inode;
 	struct gendisk *disk = bdev->bd_disk;
+	struct block_device *victim = NULL;
 
 	mutex_lock(&bdev->bd_mutex);
 	lock_kernel();
+	if (for_part)
+		bdev->bd_part_count--;
+
 	if (!--bdev->bd_openers) {
 		sync_blockdev(bdev);
 		kill_bdev(bdev);
@@ -1055,10 +1061,6 @@ int blkdev_put(struct block_device *bdev
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
@@ -1072,17 +1074,22 @@ int blkdev_put(struct block_device *bdev
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
 	bdput(bdev);
+	if (victim)
+		__blkdev_put(victim, 1);
 	return ret;
 }
 
+int blkdev_put(struct block_device *bdev)
+{
+	return __blkdev_put(bdev, 0);
+}
 EXPORT_SYMBOL(blkdev_put);
 
 static int blkdev_close(struct inode * inode, struct file * filp)
