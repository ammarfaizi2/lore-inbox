Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWALOSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWALOSw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWALOSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:18:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61870 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030408AbWALOSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:18:51 -0500
Subject: Re: [PATCH] sem2mutex bdev->bd_sem
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Kedar Sovani <kedars@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060112141606.GO3945@suse.de>
References: <5edf7fc90601120610h70b824ccs9b1ac0fe955dd1b3@mail.gmail.com>
	 <20060112141606.GO3945@suse.de>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 15:18:47 +0100
Message-Id: <1137075527.2936.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 15:16 +0100, Jens Axboe wrote:
> On Thu, Jan 12 2006, Kedar Sovani wrote:
> > Here is an obvious sem2mutex patch for the bd_sem relative to 2.6.15.
> > 
> > 
> > Kedar.
> > 
> > 
> > Use mutex instead of semaphore.
> > 
> > Signed-Off-by: Kedar Sovani <ksovani@kernelcorp.com>
> 
> Please compile the patches you submit, there are far too many "sem to
> mutex" conversion patches being sent that aren't properly tested. And my
> eye spots that this is one of them.

yup

a more complete one in our queue is this one

 block/ioctl.c                   |   22 +++++++++++-----------
 drivers/block/rd.c              |    4 ++--
 drivers/s390/block/dasd_ioctl.c |    8 ++++----
 fs/block_dev.c                  |   28 ++++++++++++++--------------
 fs/buffer.c                     |    6 +++---
 fs/super.c                      |    4 ++--
 include/linux/fs.h              |    4 ++--
 7 files changed, 38 insertions(+), 38 deletions(-)

Index: linux-2.6.15/block/ioctl.c
===================================================================
--- linux-2.6.15.orig/block/ioctl.c
+++ linux-2.6.15/block/ioctl.c
@@ -42,9 +42,9 @@ static int blkpg_ioctl(struct block_devi
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
@@ -55,13 +55,13 @@ static int blkpg_ioctl(struct block_devi
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
@@ -71,9 +71,9 @@ static int blkpg_ioctl(struct block_devi
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
@@ -81,10 +81,10 @@ static int blkpg_ioctl(struct block_devi
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
@@ -102,10 +102,10 @@ static int blkdev_reread_part(struct blo
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (down_trylock(&bdev->bd_sem))
+	if (!mutex_trylock(&bdev->bd_mutex))
 		return -EBUSY;
 	res = rescan_partitions(disk, bdev);
-	up(&bdev->bd_sem);
+	mutex_unlock(&bdev->bd_mutex);
 	return res;
 }
 
Index: linux-2.6.15/drivers/block/rd.c
===================================================================
--- linux-2.6.15.orig/drivers/block/rd.c
+++ linux-2.6.15/drivers/block/rd.c
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
 
Index: linux-2.6.15/drivers/s390/block/dasd_ioctl.c
===================================================================
--- linux-2.6.15.orig/drivers/s390/block/dasd_ioctl.c
+++ linux-2.6.15/drivers/s390/block/dasd_ioctl.c
@@ -153,9 +153,9 @@ dasd_ioctl_enable(struct block_device *b
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
 
@@ -186,9 +186,9 @@ dasd_ioctl_disable(struct block_device *
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
 
Index: linux-2.6.15/fs/block_dev.c
===================================================================
--- linux-2.6.15.orig/fs/block_dev.c
+++ linux-2.6.15/fs/block_dev.c
@@ -265,8 +265,8 @@ static void init_once(void * foo, kmem_c
 	    SLAB_CTOR_CONSTRUCTOR)
 	{
 		memset(bdev, 0, sizeof(*bdev));
-		sema_init(&bdev->bd_sem, 1);
-		sema_init(&bdev->bd_mount_sem, 1);
+		mutex_init(&bdev->bd_mutex);
+		mutex_init(&bdev->bd_mount_mutex);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 		INIT_LIST_HEAD(&bdev->bd_list);
 		inode_init_once(&ei->vfs_inode);
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
Index: linux-2.6.15/fs/buffer.c
===================================================================
--- linux-2.6.15.orig/fs/buffer.c
+++ linux-2.6.15/fs/buffer.c
@@ -201,7 +201,7 @@ int fsync_bdev(struct block_device *bdev
  * freeze_bdev  --  lock a filesystem and force it into a consistent state
  * @bdev:	blockdevice to lock
  *
- * This takes the block device bd_mount_sem to make sure no new mounts
+ * This takes the block device bd_mount_mutex to make sure no new mounts
  * happen on bdev until thaw_bdev() is called.
  * If a superblock is found on this device, we take the s_umount semaphore
  * on it to make sure nobody unmounts until the snapshot creation is done.
@@ -210,7 +210,7 @@ struct super_block *freeze_bdev(struct b
 {
 	struct super_block *sb;
 
-	down(&bdev->bd_mount_sem);
+	mutex_lock(&bdev->bd_mount_mutex);
 	sb = get_super(bdev);
 	if (sb && !(sb->s_flags & MS_RDONLY)) {
 		sb->s_frozen = SB_FREEZE_WRITE;
@@ -264,7 +264,7 @@ void thaw_bdev(struct block_device *bdev
 		drop_super(sb);
 	}
 
-	up(&bdev->bd_mount_sem);
+	mutex_unlock(&bdev->bd_mount_mutex);
 }
 EXPORT_SYMBOL(thaw_bdev);
 
Index: linux-2.6.15/fs/super.c
===================================================================
--- linux-2.6.15.orig/fs/super.c
+++ linux-2.6.15/fs/super.c
@@ -683,9 +683,9 @@ struct super_block *get_sb_bdev(struct f
 	 * will protect the lockfs code from trying to start a snapshot
 	 * while we are mounting
 	 */
-	down(&bdev->bd_mount_sem);
+	mutex_lock(&bdev->bd_mount_mutex);
 	s = sget(fs_type, test_bdev_super, set_bdev_super, bdev);
-	up(&bdev->bd_mount_sem);
+	mutex_unlock(&bdev->bd_mount_mutex);
 	if (IS_ERR(s))
 		goto out;
 
Index: linux-2.6.15/include/linux/fs.h
===================================================================
--- linux-2.6.15.orig/include/linux/fs.h
+++ linux-2.6.15/include/linux/fs.h
@@ -394,8 +394,8 @@ struct block_device {
 	dev_t			bd_dev;  /* not a kdev_t - it's a search key */
 	struct inode *		bd_inode;	/* will die */
 	int			bd_openers;
-	struct semaphore	bd_sem;	/* open/close mutex */
-	struct semaphore	bd_mount_sem;	/* mount mutex */
+	struct mutex		bd_mutex;	/* open/close mutex */
+	struct mutex		bd_mount_mutex;	/* mount mutex */
 	struct list_head	bd_inodes;
 	void *			bd_holder;
 	int			bd_holders;


