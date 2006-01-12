Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbWALOQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWALOQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWALOQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:16:06 -0500
Received: from filer.packetgeneral.com ([204.52.248.2]:46755 "EHLO
	filer.packetgeneral.com") by vger.kernel.org with ESMTP
	id S1030404AbWALOQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:16:04 -0500
Subject: [PATCH] sem2mutex block_device : bd_sem
From: Kedar Sovani <ksovani@packetgeneral.com>
To: Ingo Molnar <mingo@elte.hu>, Jens Axboe <axboe@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 19:46:04 +0530
Message-Id: <1137075364.6815.5.camel@ashwamedha.india.kernelcorp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an obvious sem2mutex patch for the block device semaphore,
bd_sem, relative to 2.6.15.


Kedar.


bd_sem : Use mutex instead of semaphore.

Signed-Off-by: Kedar Sovani <ksovani@kernelcorp.com>

---

 Documentation/filesystems/Locking |    2 +-
 block/ioctl.c                     |   22 +++++++++++-----------
 drivers/block/rd.c                |    4 ++--
 drivers/s390/block/dasd_ioctl.c   |    8 ++++----
 fs/block_dev.c                    |   26 +++++++++++++-------------
 5 files changed, 31 insertions(+), 31 deletions(-)

diff -urp linux-2.6.15-orig/Documentation/filesystems/Locking
linux-2.6.15/Documentation/filesystems/Locking
--- linux-2.6.15-orig/Documentation/filesystems/Locking	2006-01-12
18:38:18.000000000 +0530
+++ linux-2.6.15/Documentation/filesystems/Locking	2006-01-12
19:26:32.000000000 +0530
@@ -342,7 +342,7 @@ prototypes:
 	int (*revalidate_disk) (struct gendisk *);
 
 locking rules:
-			BKL	bd_sem
+			BKL	bd_mutex
 open:			yes	yes
 release:		yes	yes
 ioctl:			yes	no

diff -urp  linux-2.6.15-orig/block/ioctl.c linux-2.6.15/block/ioctl.c
--- linux-2.6.15-orig/block/ioctl.c	2006-01-12 18:38:24.000000000 +0530
+++ linux-2.6.15/block/ioctl.c	2006-01-12 19:00:06.000000000 +0530
@@ -41,9 +41,9 @@ static int blkpg_ioctl(struct block_devi
 					return -EINVAL;
 			}
 			/* partition number in use? */
-			down(&bdev->bd_sem);
+			mutex_lock(&bdev->bd_mutex);
 			if (disk->part[part - 1]) {
-				up(&bdev->bd_sem);
+				mutex_unlock(&bdev->bd_mutex);
 				return -EBUSY;
 			}
 			/* overlap? */
@@ -54,13 +54,13 @@ static int blkpg_ioctl(struct block_devi
 					continue;
 				if (!(start+length <= s->start_sect ||
 				      start >= s->start_sect + s->nr_sects)) {
-					up(&bdev->bd_sem);
+					mutex_unlock(&bdev->bd_mutex);
 					return -EBUSY;
 				}
 			}
 			/* all seems OK */
 			add_partition(disk, part, start, length);
-			up(&bdev->bd_sem);
+			mutex_unlock(&bdev->bd_mutex);
 			return 0;
 		case BLKPG_DEL_PARTITION:
 			if (!disk->part[part-1])
@@ -70,9 +70,9 @@ static int blkpg_ioctl(struct block_devi
 			bdevp = bdget_disk(disk, part);
 			if (!bdevp)
 				return -ENOMEM;
-			down(&bdevp->bd_sem);
+			mutex_lock(&bdevp->bd_mutex);
 			if (bdevp->bd_openers) {
-				up(&bdevp->bd_sem);
+				mutex_unlock(&bdevp->bd_mutex);
 				bdput(bdevp);
 				return -EBUSY;
 			}
@@ -80,10 +80,10 @@ static int blkpg_ioctl(struct block_devi
 			fsync_bdev(bdevp);
 			invalidate_bdev(bdevp, 0);
 
-			down(&bdev->bd_sem);
+			mutex_lock(&bdev->bd_mutex);
 			delete_partition(disk, part);
-			up(&bdev->bd_sem);
-			up(&bdevp->bd_sem);
+			mutex_unlock(&bdev->bd_mutex);
+			mutex_unlock(&bdevp->bd_mutex);
 			bdput(bdevp);
 
 			return 0;
@@ -101,10 +101,10 @@ static int blkdev_reread_part(struct blo
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (down_trylock(&bdev->bd_sem))
+	if (mutex_trylock(&bdev->bd_mutex) == 0)
 		return -EBUSY;
 	res = rescan_partitions(disk, bdev);
-	up(&bdev->bd_sem);
+	mutex_unlock(&bdev->bd_mutex);
 	return res;
 }
 
diff -urp linux-2.6.15-orig/drivers/block/rd.c
linux-2.6.15/drivers/block/rd.c
--- linux-2.6.15-orig/drivers/block/rd.c	2006-01-12 18:38:29.000000000
+0530
+++ linux-2.6.15/drivers/block/rd.c	2006-01-12 19:04:07.000000000 +0530
@@ -310,12 +310,12 @@ static int rd_ioctl(struct inode *inode,
 	 * cache
 	 */
 	error = -EBUSY;
-	down(&bdev->bd_sem);
+	mutex_lock(&bdev->bd_mutex);
 	if (bdev->bd_openers <= 2) {
 		truncate_inode_pages(bdev->bd_inode->i_mapping, 0);
 		error = 0;
 	}
-	up(&bdev->bd_sem);
+	mutex_unlock(&bdev->bd_mutex);
 	return error;
 }
 
diff -urp  linux-2.6.15-orig/drivers/s390/block/dasd_ioctl.c
linux-2.6.15/drivers/s390/block/dasd_ioctl.c
--- linux-2.6.15-orig/drivers/s390/block/dasd_ioctl.c	2006-01-12
18:38:49.000000000 +0530
+++ linux-2.6.15/drivers/s390/block/dasd_ioctl.c	2006-01-12
19:16:29.000000000 +0530
@@ -141,9 +141,9 @@ dasd_ioctl_enable(struct block_device *b
 		return -ENODEV;
 	dasd_enable_device(device);
 	/* Formatting the dasd device can change the capacity. */
-	down(&bdev->bd_sem);
+	mutex_lock(&bdev->bd_mutex);
 	i_size_write(bdev->bd_inode, (loff_t)get_capacity(device->gdp) << 9);
-	up(&bdev->bd_sem);
+	mutex_unlock(&bdev->bd_mutex);
 	return 0;
 }
 
@@ -174,9 +174,9 @@ dasd_ioctl_disable(struct block_device *
 	 * Set i_size to zero, since read, write, etc. check against this
 	 * value.
 	 */
-	down(&bdev->bd_sem);
+	mutex_lock(&bdev->bd_mutex);
 	i_size_write(bdev->bd_inode, 0);
-	up(&bdev->bd_sem);
+	mutex_unlock(&bdev->bd_mutex);
 	return 0;
 }
 
diff -urp linux-2.6.15-orig/fs/block_dev.c linux-2.6.15/fs/block_dev.c
--- linux-2.6.15-orig/fs/block_dev.c	2006-01-12 18:42:47.000000000 +0530
+++ linux-2.6.15/fs/block_dev.c	2006-01-12 18:35:49.000000000 +0530
@@ -265,7 +265,7 @@ static void init_once(void * foo, kmem_c
 	    SLAB_CTOR_CONSTRUCTOR)
 	{
 		memset(bdev, 0, sizeof(*bdev));
-		sema_init(&bdev->bd_sem, 1);
+		mutex_init(&bdev->bd_mutex);
 		sema_init(&bdev->bd_mount_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
@@ -574,7 +574,7 @@ static int do_open(struct block_device *
 	}
 	owner = disk->fops->owner;
 
-	down(&bdev->bd_sem);
+	mutex_lock(&bdev->bd_mutex);
 	if (!bdev->bd_openers) {
 		bdev->bd_disk = disk;
 		bdev->bd_contains = bdev;
@@ -605,21 +605,21 @@ static int do_open(struct block_device *
 			if (ret)
 				goto out_first;
 			bdev->bd_contains = whole;
-			down(&whole->bd_sem);
+			mutex_lock(&whole->bd_mutex);
 			whole->bd_part_count++;
 			p = disk->part[part - 1];
 			bdev->bd_inode->i_data.backing_dev_info =
 			   whole->bd_inode->i_data.backing_dev_info;
 			if (!(disk->flags & GENHD_FL_UP) || !p || !p->nr_sects) {
 				whole->bd_part_count--;
-				up(&whole->bd_sem);
+				mutex_unlock(&whole->bd_mutex);
 				ret = -ENXIO;
 				goto out_first;
 			}
 			kobject_get(&p->kobj);
 			bdev->bd_part = p;
 			bd_set_size(bdev, (loff_t) p->nr_sects << 9);
-			up(&whole->bd_sem);
+			mutex_unlock(&whole->bd_mutex);
 		}
 	} else {
 		put_disk(disk);
@@ -633,13 +633,13 @@ static int do_open(struct block_device *
 			if (bdev->bd_invalidated)
 				rescan_partitions(bdev->bd_disk, bdev);
 		} else {
-			down(&bdev->bd_contains->bd_sem);
+			mutex_lock(&bdev->bd_contains->bd_mutex);
 			bdev->bd_contains->bd_part_count++;
-			up(&bdev->bd_contains->bd_sem);
+			mutex_unlock(&bdev->bd_contains->bd_mutex);
 		}
 	}
 	bdev->bd_openers++;
-	up(&bdev->bd_sem);
+	mutex_unlock(&bdev->bd_mutex);
 	unlock_kernel();
 	return 0;
 
@@ -652,7 +652,7 @@ out_first:
 	put_disk(disk);
 	module_put(owner);
 out:
-	up(&bdev->bd_sem);
+	mutex_unlock(&bdev->bd_mutex);
 	unlock_kernel();
 	if (ret)
 		bdput(bdev);
@@ -714,7 +714,7 @@ int blkdev_put(struct block_device *bdev
 	struct inode *bd_inode = bdev->bd_inode;
 	struct gendisk *disk = bdev->bd_disk;
 
-	down(&bdev->bd_sem);
+	mutex_lock(&bdev->bd_mutex);
 	lock_kernel();
 	if (!--bdev->bd_openers) {
 		sync_blockdev(bdev);
@@ -724,9 +724,9 @@ int blkdev_put(struct block_device *bdev
 		if (disk->fops->release)
 			ret = disk->fops->release(bd_inode, NULL);
 	} else {
-		down(&bdev->bd_contains->bd_sem);
+		mutex_lock(&bdev->bd_contains->bd_mutex);
 		bdev->bd_contains->bd_part_count--;
-		up(&bdev->bd_contains->bd_sem);
+		mutex_unlock(&bdev->bd_contains->bd_mutex);
 	}
 	if (!bdev->bd_openers) {
 		struct module *owner = disk->fops->owner;
@@ -746,7 +746,7 @@ int blkdev_put(struct block_device *bdev
 		bdev->bd_contains = NULL;
 	}
 	unlock_kernel();
-	up(&bdev->bd_sem);
+	mutex_unlock(&bdev->bd_mutex);
 	bdput(bdev);
 	return ret;
 }



