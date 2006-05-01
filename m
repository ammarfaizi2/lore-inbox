Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWEAFb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWEAFb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWEAFbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:31:11 -0400
Received: from ns1.suse.de ([195.135.220.2]:19882 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751054AbWEAFax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:30:53 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 1 May 2006 15:30:48 +1000
Message-Id: <1060501053048.22997@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 008 of 11] md: Allow a linear array to have drives added while active.
References: <20060501152229.18367.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/linear.c         |   74 ++++++++++++++++++++++++++++++++++--------
 ./drivers/md/md.c             |   15 +++++++-
 ./include/linux/raid/linear.h |    2 +
 3 files changed, 76 insertions(+), 15 deletions(-)

diff ./drivers/md/linear.c~current~ ./drivers/md/linear.c
--- ./drivers/md/linear.c~current~	2006-05-01 15:09:20.000000000 +1000
+++ ./drivers/md/linear.c	2006-05-01 15:13:14.000000000 +1000
@@ -111,7 +111,7 @@ static int linear_issue_flush(request_qu
 	return ret;
 }
 
-static int linear_run (mddev_t *mddev)
+static linear_conf_t *linear_conf(mddev_t *mddev, int raid_disks)
 {
 	linear_conf_t *conf;
 	dev_info_t **table;
@@ -121,20 +121,21 @@ static int linear_run (mddev_t *mddev)
 	sector_t curr_offset;
 	struct list_head *tmp;
 
-	conf = kzalloc (sizeof (*conf) + mddev->raid_disks*sizeof(dev_info_t),
+	conf = kzalloc (sizeof (*conf) + raid_disks*sizeof(dev_info_t),
 			GFP_KERNEL);
 	if (!conf)
-		goto out;
+		return NULL;
+
 	mddev->private = conf;
 
 	cnt = 0;
-	mddev->array_size = 0;
+	conf->array_size = 0;
 
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		int j = rdev->raid_disk;
 		dev_info_t *disk = conf->disks + j;
 
-		if (j < 0 || j > mddev->raid_disks || disk->rdev) {
+		if (j < 0 || j > raid_disks || disk->rdev) {
 			printk("linear: disk numbering problem. Aborting!\n");
 			goto out;
 		}
@@ -152,11 +153,11 @@ static int linear_run (mddev_t *mddev)
 			blk_queue_max_sectors(mddev->queue, PAGE_SIZE>>9);
 
 		disk->size = rdev->size;
-		mddev->array_size += rdev->size;
+		conf->array_size += rdev->size;
 
 		cnt++;
 	}
-	if (cnt != mddev->raid_disks) {
+	if (cnt != raid_disks) {
 		printk("linear: not enough drives present. Aborting!\n");
 		goto out;
 	}
@@ -200,7 +201,7 @@ static int linear_run (mddev_t *mddev)
 		unsigned round;
 		unsigned long base;
 
-		sz = mddev->array_size >> conf->preshift;
+		sz = conf->array_size >> conf->preshift;
 		sz += 1; /* force round-up */
 		base = conf->hash_spacing >> conf->preshift;
 		round = sector_div(sz, base);
@@ -247,14 +248,56 @@ static int linear_run (mddev_t *mddev)
 
 	BUG_ON(table - conf->hash_table > nb_zone);
 
+	return conf;
+
+out:
+	kfree(conf);
+	return NULL;
+}
+
+static int linear_run (mddev_t *mddev)
+{
+	linear_conf_t *conf;
+
+	conf = linear_conf(mddev, mddev->raid_disks);
+
+	if (!conf)
+		return 1;
+	mddev->private = conf;
+	mddev->array_size = conf->array_size;
+
 	blk_queue_merge_bvec(mddev->queue, linear_mergeable_bvec);
 	mddev->queue->unplug_fn = linear_unplug;
 	mddev->queue->issue_flush_fn = linear_issue_flush;
 	return 0;
+}
 
-out:
-	kfree(conf);
-	return 1;
+static int linear_add(mddev_t *mddev, mdk_rdev_t *rdev)
+{
+	/* Adding a drive to a linear array allows the array to grow.
+	 * It is permitted if the new drive has a matching superblock
+	 * already on it, with raid_disk equal to raid_disks.
+	 * It is achieved by creating a new linear_private_data structure
+	 * and swapping it in in-place of the current one.
+	 * The current one is never freed until the array is stopped.
+	 * This avoids races.
+	 */
+	linear_conf_t *newconf;
+
+	if (rdev->raid_disk != mddev->raid_disks)
+		return -EINVAL;
+
+	newconf = linear_conf(mddev,mddev->raid_disks+1);
+
+	if (!newconf)
+		return -ENOMEM;
+
+	newconf->prev = mddev_to_conf(mddev);
+	mddev->private = newconf;
+	mddev->raid_disks++;
+	mddev->array_size = newconf->array_size;
+	set_capacity(mddev->gendisk, mddev->array_size << 1);
+	return 0;
 }
 
 static int linear_stop (mddev_t *mddev)
@@ -262,8 +305,12 @@ static int linear_stop (mddev_t *mddev)
 	linear_conf_t *conf = mddev_to_conf(mddev);
   
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
-	kfree(conf->hash_table);
-	kfree(conf);
+	do {
+		linear_conf_t *t = conf->prev;
+		kfree(conf->hash_table);
+		kfree(conf);
+		conf = t;
+	} while (conf);
 
 	return 0;
 }
@@ -360,6 +407,7 @@ static struct mdk_personality linear_per
 	.run		= linear_run,
 	.stop		= linear_stop,
 	.status		= linear_status,
+	.hot_add_disk	= linear_add,
 };
 
 static int __init linear_init (void)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-05-01 15:12:34.000000000 +1000
+++ ./drivers/md/md.c	2006-05-01 15:13:14.000000000 +1000
@@ -807,8 +807,8 @@ static int super_90_validate(mddev_t *md
 
 		if (desc->state & (1<<MD_DISK_FAULTY))
 			set_bit(Faulty, &rdev->flags);
-		else if (desc->state & (1<<MD_DISK_SYNC) &&
-			 desc->raid_disk < mddev->raid_disks) {
+		else if (desc->state & (1<<MD_DISK_SYNC) /* &&
+			    desc->raid_disk < mddev->raid_disks */) {
 			set_bit(In_sync, &rdev->flags);
 			rdev->raid_disk = desc->raid_disk;
 		}
@@ -3346,6 +3346,17 @@ static int add_new_disk(mddev_t * mddev,
 
 		rdev->raid_disk = -1;
 		err = bind_rdev_to_array(rdev, mddev);
+		if (!err && !mddev->pers->hot_remove_disk) {
+			/* If there is hot_add_disk but no hot_remove_disk
+			 * then added disks for geometry changes,
+			 * and should be added immediately.
+			 */
+			super_types[mddev->major_version].
+				validate_super(mddev, rdev);
+			err = mddev->pers->hot_add_disk(mddev, rdev);
+			if (err)
+				unbind_rdev_from_array(rdev);
+		}
 		if (err)
 			export_rdev(rdev);
 

diff ./include/linux/raid/linear.h~current~ ./include/linux/raid/linear.h
--- ./include/linux/raid/linear.h~current~	2006-05-01 15:09:20.000000000 +1000
+++ ./include/linux/raid/linear.h	2006-05-01 15:13:14.000000000 +1000
@@ -13,8 +13,10 @@ typedef struct dev_info dev_info_t;
 
 struct linear_private_data
 {
+	struct linear_private_data *prev;	/* earlier version */
 	dev_info_t		**hash_table;
 	sector_t		hash_spacing;
+	sector_t		array_size;
 	int			preshift; /* shift before dividing by hash_spacing */
 	dev_info_t		disks[0];
 };
