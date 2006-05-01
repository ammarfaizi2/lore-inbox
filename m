Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWEAFbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWEAFbQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWEAFbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:31:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:38320 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750897AbWEAFas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:30:48 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 1 May 2006 15:30:42 +1000
Message-Id: <1060501053042.22985@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 11] md: Allow checkpoint of recovery with version-1 superblock.
References: <20060501152229.18367.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For a while we have had checkpointing of resync.
The version-1 superblock allows recovery to be checkpointed
as well, and this patch implements that.

Due to early carelessness we need to add a feature flag
to signal that the recovery_offset field is in use, otherwise
older kernels would assume that a partially recovered array
is in fact fully recovered.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c           |  115 +++++++++++++++++++++++++++++++++++---------
 ./drivers/md/raid1.c        |    3 -
 ./drivers/md/raid10.c       |    3 -
 ./drivers/md/raid5.c        |    1 
 ./include/linux/raid/md_k.h |    6 ++
 ./include/linux/raid/md_p.h |    5 +
 6 files changed, 109 insertions(+), 24 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-05-01 15:10:18.000000000 +1000
+++ ./drivers/md/md.c	2006-05-01 15:12:34.000000000 +1000
@@ -1165,7 +1165,11 @@ static int super_1_validate(mddev_t *mdd
 			set_bit(Faulty, &rdev->flags);
 			break;
 		default:
-			set_bit(In_sync, &rdev->flags);
+			if ((le32_to_cpu(sb->feature_map) &
+			     MD_FEATURE_RECOVERY_OFFSET))
+				rdev->recovery_offset = le64_to_cpu(sb->recovery_offset);
+			else
+				set_bit(In_sync, &rdev->flags);
 			rdev->raid_disk = role;
 			break;
 		}
@@ -1189,6 +1193,7 @@ static void super_1_sync(mddev_t *mddev,
 
 	sb->feature_map = 0;
 	sb->pad0 = 0;
+	sb->recovery_offset = cpu_to_le64(0);
 	memset(sb->pad1, 0, sizeof(sb->pad1));
 	memset(sb->pad2, 0, sizeof(sb->pad2));
 	memset(sb->pad3, 0, sizeof(sb->pad3));
@@ -1209,6 +1214,14 @@ static void super_1_sync(mddev_t *mddev,
 		sb->bitmap_offset = cpu_to_le32((__u32)mddev->bitmap_offset);
 		sb->feature_map = cpu_to_le32(MD_FEATURE_BITMAP_OFFSET);
 	}
+
+	if (rdev->raid_disk >= 0 &&
+	    !test_bit(In_sync, &rdev->flags) &&
+	    rdev->recovery_offset > 0) {
+		sb->feature_map |= cpu_to_le32(MD_FEATURE_RECOVERY_OFFSET);
+		sb->recovery_offset = cpu_to_le64(rdev->recovery_offset);
+	}
+
 	if (mddev->reshape_position != MaxSector) {
 		sb->feature_map |= cpu_to_le32(MD_FEATURE_RESHAPE_ACTIVE);
 		sb->reshape_position = cpu_to_le64(mddev->reshape_position);
@@ -1233,11 +1246,12 @@ static void super_1_sync(mddev_t *mddev,
 			sb->dev_roles[i] = cpu_to_le16(0xfffe);
 		else if (test_bit(In_sync, &rdev2->flags))
 			sb->dev_roles[i] = cpu_to_le16(rdev2->raid_disk);
+		else if (rdev2->raid_disk >= 0 && rdev2->recovery_offset > 0)
+			sb->dev_roles[i] = cpu_to_le16(rdev2->raid_disk);
 		else
 			sb->dev_roles[i] = cpu_to_le16(0xffff);
 	}
 
-	sb->recovery_offset = cpu_to_le64(0); /* not supported yet */
 	sb->sb_csum = calc_sb_1_csum(sb);
 }
 
@@ -2590,8 +2604,6 @@ static struct kobject *md_probe(dev_t de
 	return NULL;
 }
 
-void md_wakeup_thread(mdk_thread_t *thread);
-
 static void md_safemode_timeout(unsigned long data)
 {
 	mddev_t *mddev = (mddev_t *) data;
@@ -2773,6 +2785,36 @@ static int do_md_run(mddev_t * mddev)
 	mddev->queue->queuedata = mddev;
 	mddev->queue->make_request_fn = mddev->pers->make_request;
 
+	/* If there is a partially-recovered drive we need to
+	 * start recovery here.  If we leave it to md_check_recovery,
+	 * it will remove the drives and not do the right thing
+	 */
+	if (mddev->degraded) {
+		struct list_head *rtmp;
+		int spares = 0;
+		ITERATE_RDEV(mddev,rdev,rtmp)
+			if (rdev->raid_disk >= 0 &&
+			    !test_bit(In_sync, &rdev->flags) &&
+			    !test_bit(Faulty, &rdev->flags))
+				/* complete an interrupted recovery */
+				spares++;
+		if (spares && mddev->pers->sync_request) {
+			mddev->recovery = 0;
+			set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
+			mddev->sync_thread = md_register_thread(md_do_sync,
+								mddev,
+								"%s_resync");
+			if (!mddev->sync_thread) {
+				printk(KERN_ERR "%s: could not start resync"
+				       " thread...\n",
+				       mdname(mddev));
+				/* leave the spares where they are, it shouldn't hurt */
+				mddev->recovery = 0;
+			} else
+				md_wakeup_thread(mddev->sync_thread);
+		}
+	}
+
 	mddev->changed = 1;
 	md_new_event(mddev);
 	return 0;
@@ -2806,6 +2848,7 @@ static int restart_array(mddev_t *mddev)
 		 */
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(mddev->sync_thread);
 		err = 0;
 	} else {
 		printk(KERN_ERR "md: %s has no personality assigned.\n",
@@ -2829,6 +2872,7 @@ static int do_md_stop(mddev_t * mddev, i
 		}
 
 		if (mddev->sync_thread) {
+			set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 			md_unregister_thread(mddev->sync_thread);
 			mddev->sync_thread = NULL;
@@ -2858,13 +2902,14 @@ static int do_md_stop(mddev_t * mddev, i
 			if (mddev->ro)
 				mddev->ro = 0;
 		}
-		if (!mddev->in_sync) {
+		if (!mddev->in_sync || mddev->sb_dirty) {
 			/* mark array as shutdown cleanly */
 			mddev->in_sync = 1;
 			md_update_sb(mddev);
 		}
 		if (ro)
 			set_disk_ro(disk, 1);
+		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	}
 
 	/*
@@ -4652,10 +4697,14 @@ void md_do_sync(mddev_t *mddev)
 	struct list_head *tmp;
 	sector_t last_check;
 	int skipped = 0;
+	struct list_head *rtmp;
+	mdk_rdev_t *rdev;
 
 	/* just incase thread restarts... */
 	if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
 		return;
+	if (mddev->ro) /* never try to sync a read-only array */
+		return;
 
 	/* we overload curr_resync somewhat here.
 	 * 0 == not engaged in resync at all
@@ -4714,17 +4763,30 @@ void md_do_sync(mddev_t *mddev)
 		}
 	} while (mddev->curr_resync < 2);
 
+	j = 0;
 	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
 		/* resync follows the size requested by the personality,
 		 * which defaults to physical size, but can be virtual size
 		 */
 		max_sectors = mddev->resync_max_sectors;
 		mddev->resync_mismatches = 0;
+		/* we don't use the checkpoint if there's a bitmap */
+		if (!mddev->bitmap &&
+		    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
+			j = mddev->recovery_cp;
 	} else if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
 		max_sectors = mddev->size << 1;
-	else
+	else {
 		/* recovery follows the physical size of devices */
 		max_sectors = mddev->size << 1;
+		j = MaxSector;
+		ITERATE_RDEV(mddev,rdev,rtmp)
+			if (rdev->raid_disk >= 0 &&
+			    !test_bit(Faulty, &rdev->flags) &&
+			    !test_bit(In_sync, &rdev->flags) &&
+			    rdev->recovery_offset < j)
+				j = rdev->recovery_offset;
+	}
 
 	printk(KERN_INFO "md: syncing RAID array %s\n", mdname(mddev));
 	printk(KERN_INFO "md: minimum _guaranteed_ reconstruction speed:"
@@ -4734,12 +4796,7 @@ void md_do_sync(mddev_t *mddev)
 	       speed_max(mddev));
 
 	is_mddev_idle(mddev); /* this also initializes IO event counters */
-	/* we don't use the checkpoint if there's a bitmap */
-	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) && !mddev->bitmap
-	    && ! test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
-		j = mddev->recovery_cp;
-	else
-		j = 0;
+
 	io_sectors = 0;
 	for (m = 0; m < SYNC_MARKS; m++) {
 		mark[m] = jiffies;
@@ -4860,15 +4917,28 @@ void md_do_sync(mddev_t *mddev)
 	if (!test_bit(MD_RECOVERY_ERR, &mddev->recovery) &&
 	    test_bit(MD_RECOVERY_SYNC, &mddev->recovery) &&
 	    !test_bit(MD_RECOVERY_CHECK, &mddev->recovery) &&
-	    mddev->curr_resync > 2 &&
-	    mddev->curr_resync >= mddev->recovery_cp) {
-		if (test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
-			printk(KERN_INFO 
-				"md: checkpointing recovery of %s.\n",
-				mdname(mddev));
-			mddev->recovery_cp = mddev->curr_resync;
-		} else
-			mddev->recovery_cp = MaxSector;
+	    mddev->curr_resync > 2) {
+		if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
+			if (test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
+				if (mddev->curr_resync >= mddev->recovery_cp) {
+					printk(KERN_INFO
+					       "md: checkpointing recovery of %s.\n",
+					       mdname(mddev));
+					mddev->recovery_cp = mddev->curr_resync;
+				}
+			} else
+				mddev->recovery_cp = MaxSector;
+		} else {
+			if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery))
+				mddev->curr_resync = MaxSector;
+			ITERATE_RDEV(mddev,rdev,rtmp)
+				if (rdev->raid_disk >= 0 &&
+				    !test_bit(Faulty, &rdev->flags) &&
+				    !test_bit(In_sync, &rdev->flags) &&
+				    rdev->recovery_offset < mddev->curr_resync)
+					rdev->recovery_offset = mddev->curr_resync;
+			mddev->sb_dirty = 1;
+		}
 	}
 
  skip:
@@ -4989,6 +5059,8 @@ void md_check_recovery(mddev_t *mddev)
 		clear_bit(MD_RECOVERY_INTR, &mddev->recovery);
 		clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
 
+		if (test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
+			goto unlock;
 		/* no recovery is running.
 		 * remove any failed drives, then
 		 * add spares if possible.
@@ -5011,6 +5083,7 @@ void md_check_recovery(mddev_t *mddev)
 			ITERATE_RDEV(mddev,rdev,rtmp)
 				if (rdev->raid_disk < 0
 				    && !test_bit(Faulty, &rdev->flags)) {
+					rdev->recovery_offset = 0;
 					if (mddev->pers->hot_add_disk(mddev,rdev)) {
 						char nm[20];
 						sprintf(nm, "rd%d", rdev->raid_disk);

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-05-01 15:10:00.000000000 +1000
+++ ./drivers/md/raid1.c	2006-05-01 15:12:34.000000000 +1000
@@ -1888,7 +1888,8 @@ static int run(mddev_t *mddev)
 
 		disk = conf->mirrors + i;
 
-		if (!disk->rdev) {
+		if (!disk->rdev ||
+		    !test_bit(In_sync, &rdev->flags)) {
 			disk->head_position = 0;
 			mddev->degraded++;
 		}

diff ./drivers/md/raid10.c~current~ ./drivers/md/raid10.c
--- ./drivers/md/raid10.c~current~	2006-05-01 15:10:17.000000000 +1000
+++ ./drivers/md/raid10.c	2006-05-01 15:12:34.000000000 +1000
@@ -2015,7 +2015,8 @@ static int run(mddev_t *mddev)
 
 		disk = conf->mirrors + i;
 
-		if (!disk->rdev) {
+		if (!disk->rdev ||
+		    !test_bit(In_sync, &rdev->flags)) {
 			disk->head_position = 0;
 			mddev->degraded++;
 		}

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-05-01 15:10:18.000000000 +1000
+++ ./drivers/md/raid5.c	2006-05-01 15:12:34.000000000 +1000
@@ -3555,6 +3555,7 @@ static int raid5_start_reshape(mddev_t *
 				set_bit(In_sync, &rdev->flags);
 				conf->working_disks++;
 				added_devices++;
+				rdev->recovery_offset = 0;
 				sprintf(nm, "rd%d", rdev->raid_disk);
 				sysfs_create_link(&mddev->kobj, &rdev->kobj, nm);
 			} else

diff ./include/linux/raid/md_k.h~current~ ./include/linux/raid/md_k.h
--- ./include/linux/raid/md_k.h~current~	2006-05-01 15:10:17.000000000 +1000
+++ ./include/linux/raid/md_k.h	2006-05-01 15:12:34.000000000 +1000
@@ -88,6 +88,10 @@ struct mdk_rdev_s
 					 * array and could again if we did a partial
 					 * resync from the bitmap
 					 */
+	sector_t	recovery_offset;/* If this device has been partially
+					 * recovered, this is where we were
+					 * up to.
+					 */
 
 	atomic_t	nr_pending;	/* number of pending requests.
 					 * only maintained for arrays that
@@ -183,6 +187,8 @@ struct mddev_s
 #define	MD_RECOVERY_REQUESTED	6
 #define	MD_RECOVERY_CHECK	7
 #define MD_RECOVERY_RESHAPE	8
+#define	MD_RECOVERY_FROZEN	9
+
 	unsigned long			recovery;
 
 	int				in_sync;	/* know to not need resync */

diff ./include/linux/raid/md_p.h~current~ ./include/linux/raid/md_p.h
--- ./include/linux/raid/md_p.h~current~	2006-05-01 15:09:20.000000000 +1000
+++ ./include/linux/raid/md_p.h	2006-05-01 15:12:34.000000000 +1000
@@ -265,9 +265,12 @@ struct mdp_superblock_1 {
 
 /* feature_map bits */
 #define MD_FEATURE_BITMAP_OFFSET	1
+#define	MD_FEATURE_RECOVERY_OFFSET	2 /* recovery_offset is present and
+					   * must be honoured
+					   */
 #define	MD_FEATURE_RESHAPE_ACTIVE	4
 
-#define	MD_FEATURE_ALL			5
+#define	MD_FEATURE_ALL			(1|2|4)
 
 #endif 
 
