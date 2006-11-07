Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753583AbWKGWLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbWKGWLc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbWKGWJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:09:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:42185 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753529AbWKGWJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:09:43 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 8 Nov 2006 09:09:46 +1100
Message-Id: <1061107220946.12536@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 9] md: Change lifetime rules for 'md' devices.
References: <20061108085917.12064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently md devices are created when first opened and remain in existence
until the module is unloaded.
This isn't a major problem, but it somewhat ugly.

This patch changes the lifetime rules so that an md device will
disappear on the last close if it has no state.

Locking rules depend on bd_mutex being held in do_open and
__blkdev_put, and on setting bd_disk->private_data to 'mddev'.

There is room for a race because md_probe is called early in do_open
(get_gendisk) to create the mddev.  As this isn't protected by
bd_mutex, a concurrent call to md_close can destroy that mddev before
do_open calls md_open to get a reference on it.
md_open and md_close are serialised by md_mutex so the worst that
can happen is that md_open finds that the mddev structure doesn't
exist after all.  In this case bd_disk->private_data will be NULL,
and md_open chooses to exit with -EBUSY in this case, which is
arguable and appropriate result.

The new 'dead' field in mddev is used to track whether it is time
to destroy the mddev (if a last-close happens).  It is cleared when
any state is create (set_array_info) and set when the array is stopped
(do_md_stop).

mddev_put becomes simpler. It just destroys the mddev when the
refcount hits zero.  This will normally be the reference held in
bd_disk->private_data.
  

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c           |   35 +++++++++++++++++++++++++----------
 ./include/linux/raid/md_k.h |    3 +++
 2 files changed, 28 insertions(+), 10 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-11-06 11:29:12.000000000 +1100
+++ ./drivers/md/md.c	2006-11-06 11:29:13.000000000 +1100
@@ -226,13 +226,14 @@ static void mddev_put(mddev_t *mddev)
 {
 	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
 		return;
-	if (!mddev->raid_disks && list_empty(&mddev->disks)) {
-		list_del(&mddev->all_mddevs);
-		spin_unlock(&all_mddevs_lock);
-		blk_cleanup_queue(mddev->queue);
-		kobject_unregister(&mddev->kobj);
-	} else
-		spin_unlock(&all_mddevs_lock);
+	list_del(&mddev->all_mddevs);
+	spin_unlock(&all_mddevs_lock);
+
+	del_gendisk(mddev->gendisk);
+	mddev->gendisk = NULL;
+	blk_cleanup_queue(mddev->queue);
+	mddev->queue = NULL;
+	kobject_unregister(&mddev->kobj);
 }
 
 static mddev_t * mddev_find(dev_t unit)
@@ -273,6 +274,7 @@ static mddev_t * mddev_find(dev_t unit)
 	atomic_set(&new->active, 1);
 	spin_lock_init(&new->write_lock);
 	init_waitqueue_head(&new->sb_wait);
+	new->dead = 1;
 
 	new->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!new->queue) {
@@ -3360,6 +3362,8 @@ static int do_md_stop(mddev_t * mddev, i
 		mddev->array_size = 0;
 		mddev->size = 0;
 		mddev->raid_disks = 0;
+		mddev->dead = 1;
+
 		mddev->recovery_cp = 0;
 
 	} else if (mddev->pers)
@@ -4292,7 +4296,8 @@ static int md_ioctl(struct inode *inode,
 					printk(KERN_WARNING "md: couldn't set"
 					       " array info. %d\n", err);
 					goto abort_unlock;
-				}
+				} else
+					mddev->dead = 0;
 			}
 			goto done_unlock;
 
@@ -4376,6 +4381,8 @@ static int md_ioctl(struct inode *inode,
 				err = -EFAULT;
 			else
 				err = add_new_disk(mddev, &info);
+			if (!err)
+				mddev->dead = 0;
 			goto done_unlock;
 		}
 
@@ -4422,8 +4429,12 @@ static int md_open(struct inode *inode, 
 	 * Succeed if we can lock the mddev, which confirms that
 	 * it isn't being stopped right now.
 	 */
-	mddev_t *mddev = inode->i_bdev->bd_disk->private_data;
-	int err;
+	mddev_t *mddev;
+	int err = -EBUSY;
+
+	mddev = inode->i_bdev->bd_disk->private_data;
+	if (!mddev)
+		goto out;
 
 	if ((err = mutex_lock_interruptible_nested(&mddev->reconfig_mutex, 1)))
 		goto out;
@@ -4442,6 +4453,10 @@ static int md_release(struct inode *inod
  	mddev_t *mddev = inode->i_bdev->bd_disk->private_data;
 
 	BUG_ON(!mddev);
+	if (inode->i_bdev->bd_openers == 0 && mddev->dead) {
+		inode->i_bdev->bd_disk->private_data = NULL;
+		mddev_put(mddev);
+	}
 	mddev_put(mddev);
 
 	return 0;

diff .prev/include/linux/raid/md_k.h ./include/linux/raid/md_k.h
--- .prev/include/linux/raid/md_k.h	2006-11-06 11:21:24.000000000 +1100
+++ ./include/linux/raid/md_k.h	2006-11-06 11:29:13.000000000 +1100
@@ -119,6 +119,9 @@ struct mddev_s
 #define MD_CHANGE_PENDING 2	/* superblock update in progress */
 
 	int				ro;
+	int				dead; /* array should be discarded on
+					       * last close
+					       */
 
 	struct gendisk			*gendisk;
 
