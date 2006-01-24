Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWAXAnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWAXAnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWAXAnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:43:40 -0500
Received: from cantor2.suse.de ([195.135.220.15]:22952 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030253AbWAXAlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:41:24 -0500
From: NeilBrown <neilb@suse.de>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Jan 2006 11:41:17 +1100
Message-Id: <1060124004117.5094@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Subject: [PATCH 006 of 7] md: Checkpoint and allow restart of raid5 reshape
References: <20060124112626.4447.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We allow the superblock to record an 'old' and a 'new'
geometry, and a position where any conversion is up to.
The geometry allows for changing chunksize, layout and
level as well as number of devices.

When using verion-0.90 superblock, we convert the version
to 0.91 while the conversion is happening so that an old
kernel will refuse the assemble the array.
For version-1, we use a feature bit for the same effect.

When starting an array we check for an incomplete reshape
and restart the reshape process if needed.
If the reshape stopped at an awkward time (like when updating
the first stripe) we refuse to assemble the array, and
let user-space worry about it.




Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c            |   54 +++++++++++++++-
 ./drivers/md/raid1.c         |    5 +
 ./drivers/md/raid5.c         |  144 +++++++++++++++++++++++++++++++++++++------
 ./include/linux/raid/md.h    |    2 
 ./include/linux/raid/md_k.h  |    8 ++
 ./include/linux/raid/md_p.h  |   32 ++++++++-
 ./include/linux/raid/raid5.h |    1 
 7 files changed, 220 insertions(+), 26 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-01-24 11:19:25.000000000 +1100
+++ ./drivers/md/md.c	2006-01-24 11:24:34.000000000 +1100
@@ -657,7 +657,8 @@ static int super_90_load(mdk_rdev_t *rde
 	}
 
 	if (sb->major_version != 0 ||
-	    sb->minor_version != 90) {
+	    sb->minor_version < 90 ||
+	    sb->minor_version > 91) {
 		printk(KERN_WARNING "Bad version number %d.%d on %s\n",
 			sb->major_version, sb->minor_version,
 			b);
@@ -742,6 +743,15 @@ static int super_90_validate(mddev_t *md
 		mddev->bitmap_offset = 0;
 		mddev->default_bitmap_offset = MD_SB_BYTES >> 9;
 
+		if (mddev->minor_version >= 91) {
+			mddev->reshape_position = sb->reshape_position;
+			mddev->delta_disks = sb->delta_disks;
+			mddev->new_level = sb->new_level;
+			mddev->new_layout = sb->new_layout;
+			mddev->new_chunk = sb->new_chunk;
+		} else
+			mddev->reshape_position = MaxSector;
+
 		if (sb->state & (1<<MD_SB_CLEAN))
 			mddev->recovery_cp = MaxSector;
 		else {
@@ -835,7 +845,6 @@ static void super_90_sync(mddev_t *mddev
 
 	sb->md_magic = MD_SB_MAGIC;
 	sb->major_version = mddev->major_version;
-	sb->minor_version = mddev->minor_version;
 	sb->patch_version = mddev->patch_version;
 	sb->gvalid_words  = 0; /* ignored */
 	memcpy(&sb->set_uuid0, mddev->uuid+0, 4);
@@ -854,6 +863,17 @@ static void super_90_sync(mddev_t *mddev
 	sb->events_hi = (mddev->events>>32);
 	sb->events_lo = (u32)mddev->events;
 
+	if (mddev->reshape_position == MaxSector)
+		sb->minor_version = 90;
+	else {
+		sb->minor_version = 91;
+		sb->reshape_position = mddev->reshape_position;
+		sb->new_level = mddev->new_level;
+		sb->delta_disks = mddev->delta_disks;
+		sb->new_layout = mddev->new_layout;
+		sb->new_chunk = mddev->new_chunk;
+	}
+	mddev->minor_version = sb->minor_version;
 	if (mddev->in_sync)
 	{
 		sb->recovery_cp = mddev->recovery_cp;
@@ -1097,6 +1117,15 @@ static int super_1_validate(mddev_t *mdd
 			}
 			mddev->bitmap_offset = (__s32)le32_to_cpu(sb->bitmap_offset);
 		}
+		if ((le32_to_cpu(sb->feature_map) & MD_FEATURE_RESHAPE_ACTIVE)) {
+			mddev->reshape_position = le64_to_cpu(sb->reshape_position);
+			mddev->delta_disks = le32_to_cpu(sb->delta_disks);
+			mddev->new_level = le32_to_cpu(sb->new_level);
+			mddev->new_layout = le32_to_cpu(sb->new_layout);
+			mddev->new_chunk = le32_to_cpu(sb->new_chunk);
+		} else
+			mddev->reshape_position = MaxSector;
+
 	} else if (mddev->pers == NULL) {
 		/* Insist of good event counter while assembling */
 		__u64 ev1 = le64_to_cpu(sb->events);
@@ -1165,6 +1194,14 @@ static void super_1_sync(mddev_t *mddev,
 		sb->bitmap_offset = cpu_to_le32((__u32)mddev->bitmap_offset);
 		sb->feature_map = cpu_to_le32(MD_FEATURE_BITMAP_OFFSET);
 	}
+	if (mddev->reshape_position != MaxSector) {
+		sb->feature_map |= cpu_to_le32(MD_FEATURE_RESHAPE_ACTIVE);
+		sb->reshape_position = le64_to_cpu(mddev->reshape_position);
+		sb->new_layout = le32_to_cpu(mddev->new_level);
+		sb->delta_disks = le32_to_cpu(mddev->delta_disks);
+		sb->new_level = le32_to_cpu(mddev->new_layout);
+		sb->new_chunk = le32_to_cpu(mddev->new_chunk);
+	}
 
 	max_dev = 0;
 	ITERATE_RDEV(mddev,rdev2,tmp)
@@ -1482,7 +1519,7 @@ static void sync_sbs(mddev_t * mddev)
 	}
 }
 
-static void md_update_sb(mddev_t * mddev)
+void md_update_sb(mddev_t * mddev)
 {
 	int err;
 	struct list_head *tmp;
@@ -1559,6 +1596,7 @@ repeat:
 	wake_up(&mddev->sb_wait);
 
 }
+EXPORT_SYMBOL_GPL(md_update_sb);
 
 /* words written to sysfs files may, or my not, be \n terminated.
  * We want to accept with case. For this we use cmd_match.
@@ -2530,6 +2568,14 @@ static int do_md_run(mddev_t * mddev)
 	mddev->level = pers->level;
 	strlcpy(mddev->clevel, pers->name, sizeof(mddev->clevel));
 
+	if (mddev->reshape_position != MaxSector &&
+	    pers->reshape == NULL) {
+		/* This personality cannot handle reshaping... */
+		mddev->pers = NULL;
+		module_put(pers->owner);
+		return -EINVAL;
+	}
+
 	mddev->recovery = 0;
 	mddev->resync_max_sectors = mddev->size << 1; /* may be over-ridden by personality */
 	mddev->barriers_work = 1;
@@ -3416,6 +3462,8 @@ static int set_array_info(mddev_t * mdde
 	mddev->default_bitmap_offset = MD_SB_BYTES >> 9;
 	mddev->bitmap_offset = 0;
 
+	mddev->reshape_position = MaxSector;
+
 	/*
 	 * Generate a 128 bit UUID
 	 */

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-01-24 11:19:25.000000000 +1100
+++ ./drivers/md/raid1.c	2006-01-24 11:14:40.000000000 +1100
@@ -1786,6 +1786,11 @@ static int run(mddev_t *mddev)
 		       mdname(mddev), mddev->level);
 		goto out;
 	}
+	if (mddev->reshape_position != MaxSector) {
+		printk("raid1: %s: reshape_position set but not supported\n",
+		       mdname(mddev));
+		goto out;
+	}
 	/*
 	 * copy the already verified devices into our private RAID1
 	 * bookkeeping area. [whatever we allocate in run(),

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-01-24 11:19:25.000000000 +1100
+++ ./drivers/md/raid5.c	2006-01-24 11:19:21.000000000 +1100
@@ -22,6 +22,7 @@
 #include <linux/raid/raid5.h>
 #include <linux/highmem.h>
 #include <linux/bitops.h>
+#include <linux/kthread.h>
 #include <asm/atomic.h>
 
 #include <linux/raid/bitmap.h>
@@ -1490,6 +1491,7 @@ static void handle_stripe(struct stripe_
 		clear_bit(STRIPE_EXPANDING, &sh->state);
 	} else if (expanded) {
 		clear_bit(STRIPE_EXPAND_READY, &sh->state);
+		atomic_dec(&conf->reshape_stripes);
 		wake_up(&conf->wait_for_overlap);
 		md_done_sync(conf->mddev, STRIPE_SECTORS, 1);
 	}
@@ -1861,6 +1863,26 @@ static sector_t sync_request(mddev_t *md
 		 */
 		int i;
 		int dd_idx;
+
+		if (sector_nr == 0 &&
+		    conf->expand_progress != 0) {
+			/* restarting in the middle, skip the initial sectors */
+			sector_nr = conf->expand_progress;
+			sector_div(sector_nr, conf->raid_disks-1);
+			*skipped = 1;
+			return sector_nr;
+		}
+
+		/* Cannot proceed until we've updated the superblock... */
+		wait_event(conf->wait_for_overlap,
+			   atomic_read(&conf->reshape_stripes)==0);
+		mddev->reshape_position = conf->expand_progress;
+
+		mddev->sb_dirty = 1;
+		md_wakeup_thread(mddev->thread);
+		wait_event(mddev->sb_wait, mddev->sb_dirty == 0 ||
+			kthread_should_stop());
+
 		for (i=0; i < conf->chunk_size/512; i+= STRIPE_SECTORS) {
 			int j;
 			int skipped = 0;
@@ -1868,6 +1890,7 @@ static sector_t sync_request(mddev_t *md
 			sh = get_active_stripe(conf, sector_nr+i,
 					       conf->raid_disks, pd_idx, 0);
 			set_bit(STRIPE_EXPANDING, &sh->state);
+			atomic_inc(&conf->reshape_stripes);
 			/* If any of this stripe is beyond the end of the old
 			 * array, then we need to zero those blocks
 			 */
@@ -2107,10 +2130,65 @@ static int run(mddev_t *mddev)
 		return -EIO;
 	}
 
+	if (mddev->reshape_position != MaxSector) {
+		/* Check that we can continue the reshape.
+		 * Currently only disks can change, it must
+		 * increase, and we must be passed the point where
+		 * a stripe over-writes itself
+		 */
+		sector_t here_new, here_old, there_new;
+		int old_disks;
+
+		if (mddev->new_level != mddev->level ||
+		    mddev->new_layout != mddev->layout ||
+		    mddev->new_chunk != mddev->chunk_size) {
+			printk(KERN_ERR "raid5: %s: unsupported reshape required - aborting.\n",
+			       mdname(mddev));
+			return -EINVAL;
+		}
+		if (mddev->delta_disks <= 0) {
+			printk(KERN_ERR "raid5: %s: unsupported reshape (reduce disks) required - aborting.\n",
+			       mdname(mddev));
+			return -EINVAL;
+		}
+		old_disks = mddev->raid_disks - mddev->delta_disks;
+		/* reshape_position must be on a new-stripe boundary, and one
+		 * further up in new geometry must map before here in old geometry.
+		 */
+		here_new = mddev->reshape_position;
+		if (sector_div(here_new, (mddev->chunk_size>>9)*(mddev->raid_disks-1))) {
+			printk(KERN_ERR "raid5: reshape_position not on a stripe boundary\n");
+			return -EINVAL;
+		}
+		here_old = mddev->reshape_position;
+		sector_div(here_old, (mddev->chunk_size>>9)*(old_disks-1));
+		/* here_old is the first sector that we might need to read from
+		 * for the next movement
+		 */
+		there_new = here_new + (mddev->chunk_size>>9);
+		/* there_new is the last sector that the next movement will be
+		 * written to.
+		 */
+		if (there_new >= here_old) {
+			printk(KERN_ERR "raid5: reshape_position too early for auto-recovery - aborting.\n");
+			return -EINVAL;
+		}
+		printk("raid5: reshape will continue\n");
+		/* OK, we should be able to continue; */
+	}
+
+
 	mddev->private = kzalloc(sizeof (raid5_conf_t), GFP_KERNEL);
 	if ((conf = mddev->private) == NULL)
 		goto abort;
-	conf->disks = kzalloc(mddev->raid_disks * sizeof(struct disk_info),
+	if (mddev->reshape_position == MaxSector) {
+		conf->previous_raid_disks = conf->raid_disks = mddev->raid_disks;
+	} else {
+		conf->raid_disks = mddev->raid_disks;
+		conf->previous_raid_disks = mddev->raid_disks - mddev->delta_disks;
+	}
+
+	conf->disks = kzalloc(conf->raid_disks * sizeof(struct disk_info),
 			      GFP_KERNEL);
 	if (!conf->disks)
 		goto abort;
@@ -2134,7 +2212,7 @@ static int run(mddev_t *mddev)
 
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		raid_disk = rdev->raid_disk;
-		if (raid_disk >= mddev->raid_disks
+		if (raid_disk >= conf->raid_disks
 		    || raid_disk < 0)
 			continue;
 		disk = conf->disks + raid_disk;
@@ -2150,7 +2228,6 @@ static int run(mddev_t *mddev)
 		}
 	}
 
-	conf->raid_disks = mddev->raid_disks;
 	/*
 	 * 0 for a fully functional array, 1 for a degraded array.
 	 */
@@ -2160,7 +2237,7 @@ static int run(mddev_t *mddev)
 	conf->level = mddev->level;
 	conf->algorithm = mddev->layout;
 	conf->max_nr_stripes = NR_STRIPES;
-	conf->expand_progress = MaxSector;
+	conf->expand_progress = mddev->reshape_position;
 
 	/* device size must be a multiple of chunk size */
 	mddev->size &= ~(mddev->chunk_size/1024 -1);
@@ -2233,6 +2310,20 @@ static int run(mddev_t *mddev)
 
 	print_raid5_conf(conf);
 
+	if (conf->expand_progress != MaxSector) {
+		printk("...ok start reshape thread\n");
+		atomic_set(&conf->reshape_stripes, 0);
+		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
+		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
+		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
+		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
+		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
+							"%s_reshape");
+		/* FIXME if md_register_thread fails?? */
+		md_wakeup_thread(mddev->sync_thread);
+
+	}
+
 	/* read-ahead size must cover two whole stripes, which is
 	 * 2 * (n-1) * chunksize where 'n' is the number of raid devices
 	 */
@@ -2248,8 +2339,8 @@ static int run(mddev_t *mddev)
 
 	mddev->queue->unplug_fn = raid5_unplug_device;
 	mddev->queue->issue_flush_fn = raid5_issue_flush;
+	mddev->array_size =  mddev->size * (conf->previous_raid_disks - 1);
 
-	mddev->array_size =  mddev->size * (mddev->raid_disks - 1);
 	return 0;
 abort:
 	if (conf) {
@@ -2422,7 +2513,7 @@ static int raid5_add_disk(mddev_t *mddev
 	/*
 	 * find the disk ...
 	 */
-	for (disk=0; disk < mddev->raid_disks; disk++)
+	for (disk=0; disk < conf->raid_disks; disk++)
 		if ((p=conf->disks + disk)->rdev == NULL) {
 			clear_bit(In_sync, &rdev->flags);
 			rdev->raid_disk = disk;
@@ -2503,9 +2594,10 @@ static int raid5_reshape(mddev_t *mddev,
 	if (err)
 		return err;
 
+	atomic_set(&conf->reshape_stripes, 0);
 	spin_lock_irq(&conf->device_lock);
 	conf->previous_raid_disks = conf->raid_disks;
-	mddev->raid_disks = conf->raid_disks = raid_disks;
+	conf->raid_disks = raid_disks;
 	conf->expand_progress = 0;
 	spin_unlock_irq(&conf->device_lock);
 
@@ -2527,6 +2619,14 @@ static int raid5_reshape(mddev_t *mddev,
 		}
 
 	mddev->degraded = (raid_disks - conf->previous_raid_disks) - added_devices;
+	mddev->new_chunk = mddev->chunk_size;
+	mddev->new_layout = mddev->layout;
+	mddev->new_level = mddev->level;
+	mddev->raid_disks = raid_disks;
+	mddev->delta_disks = raid_disks - conf->previous_raid_disks;
+	mddev->reshape_position = 0;
+	mddev->sb_dirty = 1;
+
 	clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
@@ -2537,6 +2637,7 @@ static int raid5_reshape(mddev_t *mddev,
 		mddev->recovery = 0;
 		spin_lock_irq(&conf->device_lock);
 		mddev->raid_disks = conf->raid_disks = conf->previous_raid_disks;
+		mddev->delta_disks = 0;
 		conf->expand_progress = MaxSector;
 		spin_unlock_irq(&conf->device_lock);
 		return -EAGAIN;
@@ -2550,20 +2651,23 @@ static void end_reshape(raid5_conf_t *co
 {
 	struct block_device *bdev;
 
-	conf->mddev->array_size = conf->mddev->size * (conf->mddev->raid_disks-1);
-	set_capacity(conf->mddev->gendisk, conf->mddev->array_size << 1);
-	conf->mddev->changed = 1;
-
-	bdev = bdget_disk(conf->mddev->gendisk, 0);
-	if (bdev) {
-		mutex_lock(&bdev->bd_inode->i_mutex);
-		i_size_write(bdev->bd_inode, conf->mddev->array_size << 10);
-		mutex_unlock(&bdev->bd_inode->i_mutex);
-		bdput(bdev);
+	if (!test_bit(MD_RECOVERY_INTR, &conf->mddev->recovery)) {
+		conf->mddev->array_size = conf->mddev->size * (conf->raid_disks-1);
+		set_capacity(conf->mddev->gendisk, conf->mddev->array_size << 1);
+		conf->mddev->changed = 1;
+
+		bdev = bdget_disk(conf->mddev->gendisk, 0);
+		if (bdev) {
+			mutex_lock(&bdev->bd_inode->i_mutex);
+			i_size_write(bdev->bd_inode, conf->mddev->array_size << 10);
+			mutex_unlock(&bdev->bd_inode->i_mutex);
+			bdput(bdev);
+		}
+		spin_lock_irq(&conf->device_lock);
+		conf->expand_progress = MaxSector;
+		spin_unlock_irq(&conf->device_lock);
+		conf->mddev->reshape_position = MaxSector;
 	}
-	spin_lock_irq(&conf->device_lock);
-	conf->expand_progress = MaxSector;
-	spin_unlock_irq(&conf->device_lock);
 }
 
 static void raid5_quiesce(mddev_t *mddev, int state)

diff ./include/linux/raid/md.h~current~ ./include/linux/raid/md.h
--- ./include/linux/raid/md.h~current~	2006-01-24 11:19:25.000000000 +1100
+++ ./include/linux/raid/md.h	2006-01-24 11:14:40.000000000 +1100
@@ -95,6 +95,8 @@ extern int sync_page_io(struct block_dev
 extern void md_do_sync(mddev_t *mddev);
 extern void md_new_event(mddev_t *mddev);
 
+extern void md_update_sb(mddev_t * mddev);
+
 #define MD_BUG(x...) { printk("md: bug in file %s, line %d\n", __FILE__, __LINE__); md_print_devices(); }
 
 #endif 

diff ./include/linux/raid/md_k.h~current~ ./include/linux/raid/md_k.h
--- ./include/linux/raid/md_k.h~current~	2006-01-24 11:19:25.000000000 +1100
+++ ./include/linux/raid/md_k.h	2006-01-24 11:14:40.000000000 +1100
@@ -132,6 +132,14 @@ struct mddev_s
 
 	char				uuid[16];
 
+	/* If the array is being reshaped, we need to record the
+	 * new shape and an indication of where we are up to.
+	 * This is written to the superblock.
+	 * If reshape_position is MaxSector, then no reshape is happening (yet).
+	 */
+	sector_t			reshape_position;
+	int				delta_disks, new_level, new_layout, new_chunk;
+
 	struct mdk_thread_s		*thread;	/* management thread */
 	struct mdk_thread_s		*sync_thread;	/* doing resync or reconstruct */
 	sector_t			curr_resync;	/* blocks scheduled */

diff ./include/linux/raid/md_p.h~current~ ./include/linux/raid/md_p.h
--- ./include/linux/raid/md_p.h~current~	2006-01-24 11:19:25.000000000 +1100
+++ ./include/linux/raid/md_p.h	2006-01-24 11:14:40.000000000 +1100
@@ -102,6 +102,18 @@ typedef struct mdp_device_descriptor_s {
 #define MD_SB_ERRORS		1
 
 #define	MD_SB_BITMAP_PRESENT	8 /* bitmap may be present nearby */
+
+/*
+ * Notes:
+ * - if an array is being reshaped (restriped) in order to change the
+ *   the number of active devices in the array, 'raid_disks' will be
+ *   the larger of the old and new numbers.  'delta_disks' will
+ *   be the "new - old".  So if +ve, raid_disks is the new value, and
+ *   "raid_disks-delta_disks" is the old.  If -ve, raid_disks is the
+ *   old value and "raid_disks+delta_disks" is the new (smaller) value.
+ */
+
+
 typedef struct mdp_superblock_s {
 	/*
 	 * Constant generic information
@@ -146,7 +158,13 @@ typedef struct mdp_superblock_s {
 	__u32 cp_events_hi;	/* 10 high-order of checkpoint update count   */
 #endif
 	__u32 recovery_cp;	/* 11 recovery checkpoint sector count	      */
-	__u32 gstate_sreserved[MD_SB_GENERIC_STATE_WORDS - 12];
+	/* There are only valid for minor_version > 90 */
+	__u64 reshape_position;	/* 12,13 next address in array-space for reshape */
+	__u32 new_level;	/* 14 new level we are reshaping to	      */
+	__u32 delta_disks;	/* 15 change in number of raid_disks	      */
+	__u32 new_layout;	/* 16 new layout			      */
+	__u32 new_chunk;	/* 17 new chunk size (bytes)		      */
+	__u32 gstate_sreserved[MD_SB_GENERIC_STATE_WORDS - 18];
 
 	/*
 	 * Personality information
@@ -207,7 +225,14 @@ struct mdp_superblock_1 {
 				 * NOTE: signed, so bitmap can be before superblock
 				 * only meaningful of feature_map[0] is set.
 				 */
-	__u8	pad1[128-100];	/* set to 0 when written */
+
+	/* These are only valid with feature bit '4' */
+	__u64	reshape_position;	/* next address in array-space for reshape */
+	__u32	new_level;	/* new level we are reshaping to		*/
+	__u32	delta_disks;	/* change in number of raid_disks		*/
+	__u32	new_layout;	/* new layout					*/
+	__u32	new_chunk;	/* new chunk size (bytes)			*/
+	__u8	pad1[128-124];	/* set to 0 when written */
 
 	/* constant this-device information - 64 bytes */
 	__u64	data_offset;	/* sector start of data, often 0 */
@@ -240,8 +265,9 @@ struct mdp_superblock_1 {
 
 /* feature_map bits */
 #define MD_FEATURE_BITMAP_OFFSET	1
+#define	MD_FEATURE_RESHAPE_ACTIVE	4
 
-#define	MD_FEATURE_ALL			1
+#define	MD_FEATURE_ALL			5
 
 #endif 
 

diff ./include/linux/raid/raid5.h~current~ ./include/linux/raid/raid5.h
--- ./include/linux/raid/raid5.h~current~	2006-01-24 11:19:25.000000000 +1100
+++ ./include/linux/raid/raid5.h	2006-01-24 11:19:21.000000000 +1100
@@ -224,6 +224,7 @@ struct raid5_private_data {
 	struct list_head	bitmap_list; /* stripes delaying awaiting bitmap update */
 	atomic_t		preread_active_stripes; /* stripes with scheduled io */
 
+	atomic_t		reshape_stripes; /* stripes with pending writes for reshape */
 	/* unfortunately we need two cache names as we temporarily have
 	 * two caches.
 	 */
