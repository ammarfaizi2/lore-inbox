Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWAQG5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWAQG5j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 01:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWAQG5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 01:57:37 -0500
Received: from cantor2.suse.de ([195.135.220.15]:21415 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751252AbWAQG4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 01:56:42 -0500
From: NeilBrown <neilb@suse.de>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Jan 2006 17:56:35 +1100
Message-Id: <1060117065635.27881@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [PATCH 005 of 5] md: Final stages of raid5 expand code.
References: <20060117174531.27739.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds raid5_reshape and end_reshape which will
start and finish the reshape processes.

raid5_reshape is only enabled in CONFIG_MD_RAID5_RESHAPE is set,
to discourage accidental use.

Don't use this on valuable data.

Read the 'help' for the CONFIG_MD_RAID5_RESHAPE entry.

and Make sure to avoid use on valuable data.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/Kconfig      |   24 +++++++++++
 ./drivers/md/md.c         |    7 +--
 ./drivers/md/raid5.c      |  100 ++++++++++++++++++++++++++++++++++++++++++++++
 ./include/linux/raid/md.h |    3 -
 4 files changed, 130 insertions(+), 4 deletions(-)

diff ./drivers/md/Kconfig~current~ ./drivers/md/Kconfig
--- ./drivers/md/Kconfig~current~	2006-01-17 17:45:08.000000000 +1100
+++ ./drivers/md/Kconfig	2006-01-17 17:42:31.000000000 +1100
@@ -127,6 +127,30 @@ config MD_RAID5
 
 	  If unsure, say Y.
 
+config MD_RAID5_RESHAPE
+	bool "Support adding drives to a raid-5 array (highly experimental)"
+	depends on MD_RAID5 && EXPERIMENTAL
+	---help---
+	  A RAID-5 set can be expanded by adding extra drives. This
+	  requires "restriping" the array which means (almost) every
+	  block must be written to a different place.
+
+          This option allows this restiping to be done while the array
+	  is online.  However it is VERY EARLY EXPERIMENTAL code.
+	  In particular, if anything goes wrong while the restriping
+	  is happening, such as a power failure or a crash, all the
+	  data on the array will be LOST beyond any reasonable hope
+	  of recovery.
+
+	  This option is provided for experimentation and testing.
+	  Please to NOT use it on valuable data with good, tested, backups.
+
+	  Any reasonable current version of 'mdadm' can start an expansion
+	  with e.g.  mdadm --grow /dev/md0 --raid-disks=6
+	  Note: The array can only be expanded, not contracted.
+	  There should be enough spares already present to make the new
+	  array workable.
+
 config MD_RAID6
 	tristate "RAID-6 mode"
 	depends on BLK_DEV_MD

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-01-17 17:45:08.000000000 +1100
+++ ./drivers/md/md.c	2006-01-17 17:42:31.000000000 +1100
@@ -158,12 +158,12 @@ static int start_readonly;
  */
 static DECLARE_WAIT_QUEUE_HEAD(md_event_waiters);
 static atomic_t md_event_count;
-static void md_new_event(mddev_t *mddev)
+void md_new_event(mddev_t *mddev)
 {
 	atomic_inc(&md_event_count);
 	wake_up(&md_event_waiters);
 }
-
+EXPORT_SYMBOL_GPL(md_new_event);
 /*
  * Enables to iterate over all existing md arrays
  * all_mddevs_lock protects this list.
@@ -4440,7 +4440,7 @@ static DECLARE_WAIT_QUEUE_HEAD(resync_wa
 
 #define SYNC_MARKS	10
 #define	SYNC_MARK_STEP	(3*HZ)
-static void md_do_sync(mddev_t *mddev)
+void md_do_sync(mddev_t *mddev)
 {
 	mddev_t *mddev2;
 	unsigned int currspeed = 0,
@@ -4673,6 +4673,7 @@ static void md_do_sync(mddev_t *mddev)
 	set_bit(MD_RECOVERY_DONE, &mddev->recovery);
 	md_wakeup_thread(mddev->thread);
 }
+EXPORT_SYMBOL_GPL(md_do_sync);
 
 
 /*

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-01-17 17:45:08.000000000 +1100
+++ ./drivers/md/raid5.c	2006-01-17 17:42:31.000000000 +1100
@@ -1020,6 +1020,8 @@ static int add_stripe_bio(struct stripe_
 	return 0;
 }
 
+static void end_reshape(raid5_conf_t *conf);
+
 int stripe_to_pdidx(sector_t stripe, raid5_conf_t *conf, int disks)
 {
 	int sectors_per_chunk = conf->chunk_size >> 9;
@@ -1813,6 +1815,10 @@ static sector_t sync_request(mddev_t *md
 	if (sector_nr >= max_sector) {
 		/* just being told to finish up .. nothing much to do */
 		unplug_slaves(mddev);
+		if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery)) {
+			end_reshape(conf);
+			return 0;
+		}
 
 		if (mddev->curr_resync < max_sector) /* aborted */
 			bitmap_end_sync(mddev->bitmap, mddev->curr_resync,
@@ -2433,6 +2439,97 @@ static int raid5_resize(mddev_t *mddev, 
 	return 0;
 }
 
+static int raid5_reshape(mddev_t *mddev, int raid_disks)
+{
+	raid5_conf_t *conf = mddev_to_conf(mddev);
+	int err;
+	mdk_rdev_t *rdev;
+	struct list_head *rtmp;
+	int spares = 0;
+
+	if (mddev->degraded ||
+	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+		return -EBUSY;
+	if (conf->raid_disks > raid_disks)
+		return -EINVAL; /* Cannot shrink array yet */
+	if (conf->raid_disks == raid_disks)
+		return 0; /* nothing to do */
+
+	ITERATE_RDEV(mddev, rdev, rtmp)
+		if (rdev->raid_disk < 0 &&
+		    !test_bit(Faulty, &rdev->flags))
+			spares++;
+	if (conf->raid_disks + spares < raid_disks-1)
+		/* Not enough devices even to make a degraded array
+		 * of that size
+		 */
+		return -EINVAL;
+
+	err = resize_stripes(conf, raid_disks);
+	if (err)
+		return err;
+
+	spin_lock_irq(&conf->device_lock);
+	conf->previous_raid_disks = conf->raid_disks;
+	mddev->raid_disks = conf->raid_disks = raid_disks;
+	conf->expand_progress = 0;
+	spin_unlock_irq(&conf->device_lock);
+
+	/* Add some new drives, as many as will fit.
+	 * We know there are enough to make the newly sized array work.
+	 */
+	ITERATE_RDEV(mddev, rdev, rtmp)
+		if (rdev->raid_disk < 0 &&
+		    !test_bit(Faulty, &rdev->flags)) {
+			if (raid5_add_disk(mddev, rdev)) {
+				char nm[20];
+				set_bit(In_sync, &rdev->flags);
+				conf->working_disks++;
+				sprintf(nm, "rd%d", rdev->raid_disk);
+				sysfs_create_link(&mddev->kobj, &rdev->kobj, nm);
+			} else
+				break;
+		}
+
+	clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
+	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
+	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
+	set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
+	mddev->sync_thread = md_register_thread(md_do_sync, mddev,
+						"%s_reshape");
+	if (!mddev->sync_thread) {
+		mddev->recovery = 0;
+		spin_lock_irq(&conf->device_lock);
+		mddev->raid_disks = conf->raid_disks = conf->previous_raid_disks;
+		conf->expand_progress = MaxSector;
+		spin_unlock_irq(&conf->device_lock);
+		return -EAGAIN;
+	}
+	md_wakeup_thread(mddev->sync_thread);
+	md_new_event(mddev);
+	return 0;
+}
+
+static void end_reshape(raid5_conf_t *conf)
+{
+	struct block_device *bdev;
+
+	conf->mddev->array_size = conf->mddev->size * (conf->mddev->raid_disks-1);
+	set_capacity(conf->mddev->gendisk, conf->mddev->array_size << 1);
+	conf->mddev->changed = 1;
+
+	bdev = bdget_disk(conf->mddev->gendisk, 0);
+	if (bdev) {
+		mutex_lock(&bdev->bd_inode->i_mutex);
+		i_size_write(bdev->bd_inode, conf->mddev->array_size << 10);
+		mutex_unlock(&bdev->bd_inode->i_mutex);
+		bdput(bdev);
+	}
+	spin_lock_irq(&conf->device_lock);
+	conf->expand_progress = MaxSector;
+	spin_unlock_irq(&conf->device_lock);
+}
+
 static void raid5_quiesce(mddev_t *mddev, int state)
 {
 	raid5_conf_t *conf = mddev_to_conf(mddev);
@@ -2471,6 +2568,9 @@ static struct mdk_personality raid5_pers
 	.spare_active	= raid5_spare_active,
 	.sync_request	= sync_request,
 	.resize		= raid5_resize,
+#if CONFIG_MD_RAID5_RESHAPE
+	.reshape	= raid5_reshape,
+#endif
 	.quiesce	= raid5_quiesce,
 };
 

diff ./include/linux/raid/md.h~current~ ./include/linux/raid/md.h
--- ./include/linux/raid/md.h~current~	2006-01-17 17:45:08.000000000 +1100
+++ ./include/linux/raid/md.h	2006-01-17 17:42:31.000000000 +1100
@@ -92,7 +92,8 @@ extern void md_super_write(mddev_t *mdde
 extern void md_super_wait(mddev_t *mddev);
 extern int sync_page_io(struct block_device *bdev, sector_t sector, int size,
 			struct page *page, int rw);
-
+extern void md_do_sync(mddev_t *mddev);
+extern void md_new_event(mddev_t *mddev);
 
 #define MD_BUG(x...) { printk("md: bug in file %s, line %d\n", __FILE__, __LINE__); md_print_devices(); }
 
