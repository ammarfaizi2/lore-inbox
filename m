Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318079AbSHZMCz>; Mon, 26 Aug 2002 08:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318097AbSHZMCz>; Mon, 26 Aug 2002 08:02:55 -0400
Received: from gate.in-addr.de ([212.8.193.158]:33029 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S318079AbSHZMCW>;
	Mon, 26 Aug 2002 08:02:22 -0400
Date: Mon, 26 Aug 2002 14:06:07 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Enhancement to md multipath in 2.4
Message-ID: <20020826120607.GO7119@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Morning all,

Jens Axboe did most of the work on this; I only stressed it a bit and fixed
some bugs in it. As he is currently on vacation, I would still like to present
it to you and solicit comments on it.

It compiles and passes my test script, so it can't be all wrong, I hope ;-) It
certainly isn't worse than the current code.

I've also done a small patch to mdadm to allow access to the new functionality
provided.

The enhancements include:

- Read & write balancing with front and tail merging of requests, otherwise
  picks least used path. (Done by Jens)

- Paths can be set to either active or spare; a spare path will be used in
  place of a failed active path but otherwise be disabled.
  
- A path can be manually "cleared" (marked non-faulty). This is explicitly
  only implemented for multipathing because it makes no sense for the other
  RAID levels where this is definetely the job of the recovery process.

  Automatic reprobing of failed paths was deliberately not implemented; this
  can be done in user space, and the kernel shouldn't use live requests to do
  so.

- Some special cases in md.c for multipath were removed / fixed.

- md will now enable all paths it finds during autorun. This leads to "funny"
  messages ("Device changed to [07:04] from [00:00]" etc), but they can be
  safely ignored.
  
- Nested md devices are now also auto-detected; important for RAID1 on top of
  multipath for example, required for a true disaster resilient configuration.
  However, this isn't yet working perfectly and is subject to ongoing work
  ;-)

  (If anyone has hints here, I would be grateful)
  
- Killed some code which made no sense for the multipath module; ie, code
  related to the md recovery.

- The downside: We needed to add 3 additional ioctl()s for this.

Patch attached.

Of course, this is still subject to the general comments about the block
device error handling in 2.4.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=md-mp

diff -urN linux-2.4.19/drivers/md/md.c linux-2.4.19.SuSE/drivers/md/md.c
--- linux-2.4.19/drivers/md/md.c	Sat Aug 24 20:47:45 2002
+++ linux-2.4.19.SuSE/drivers/md/md.c	Sat Aug 24 20:48:19 2002
@@ -608,6 +608,7 @@
 
 	md_list_add(&rdev->same_set, &mddev->disks);
 	rdev->mddev = mddev;
+	rdev->desc_nr = mddev->nb_dev;
 	mddev->nb_dev++;
 	printk(KERN_INFO "md: bind<%s,%d>\n", partition_name(rdev->dev), mddev->nb_dev);
 }
@@ -782,7 +783,7 @@
 
 static void print_rdev(mdk_rdev_t *rdev)
 {
-	printk(KERN_INFO "md: rdev %s: O:%s, SZ:%08ld F:%d DN:%d ",
+	printk(KERN_INFO "md: rdev %s: O:%s, SZ:%08ld F:%d DN:%d\n",
 		partition_name(rdev->dev), partition_name(rdev->old_dev),
 		rdev->size, rdev->faulty, rdev->desc_nr);
 	if (rdev->sb) {
@@ -984,7 +985,7 @@
 	struct md_list_head *tmp;
 
 	ITERATE_RDEV(mddev,rdev,tmp) {
-		if (rdev->faulty || rdev->alias_device)
+		if (rdev->faulty || rdev_is_alias(rdev))
 			continue;
 		sb = rdev->sb;
 		*sb = *mddev->sb;
@@ -1036,11 +1037,11 @@
 		printk(KERN_INFO "md: ");
 		if (rdev->faulty)
 			printk("(skipping faulty ");
-		if (rdev->alias_device)
+		if (rdev_is_alias(rdev))
 			printk("(skipping alias ");
 
 		printk("%s ", partition_name(rdev->dev));
-		if (!rdev->faulty && !rdev->alias_device) {
+		if (!rdev->faulty && !rdev_is_alias(rdev)) {
 			printk("[events: %08lx]",
 				(unsigned long)rdev->sb->events_lo);
 			err += write_disk_sb(rdev);
@@ -1221,7 +1222,7 @@
 			goto abort;
 	sb = mddev->sb;
 	freshest = NULL;
-
+	
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		__u64 ev1, ev2;
 		/*
@@ -1285,10 +1286,9 @@
 	 * Fix up changed device names ... but only if this disk has a
 	 * recent update time. Use faulty checksum ones too.
 	 */
-	if (mddev->sb->level != -4)
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		__u64 ev1, ev2, ev3;
-		if (rdev->faulty || rdev->alias_device) {
+		if (rdev->faulty) {
 			MD_BUG();
 			goto abort;
 		}
@@ -1306,11 +1306,14 @@
 				MD_BUG();
 				goto abort;
 			}
+			
 			desc = &sb->disks[rdev->desc_nr];
-			if (rdev->old_dev != MKDEV(desc->major, desc->minor)) {
-				MD_BUG();
-				goto abort;
+			if ((mddev->sb->level != -4) && (rdev->old_dev 
+				!= MKDEV(desc->major, desc->minor))) {
+					MD_BUG();
+					goto abort;
 			}
+			
 			desc->major = MAJOR(rdev->dev);
 			desc->minor = MINOR(rdev->dev);
 			desc = &rdev->sb->this_disk;
@@ -1386,12 +1389,11 @@
 			 * we cannot check rdev->number.
 			 * We can check the device though.
 			 */
-			if ((sb->level == -4) && (rdev->dev ==
-					MKDEV(desc->major,desc->minor))) {
+			if ((sb->level == -4) &&
+					(rdev->dev == dev)) {
 				found = 1;
 				break;
-			}
-			if (rdev->desc_nr == desc->number) {
+			} else if (rdev->desc_nr == desc->number) {
 				found = 1;
 				break;
 			}
@@ -1426,6 +1428,8 @@
 
 		rdev = find_rdev(mddev, dev);
 		if (!rdev) {
+			if (mddev->sb->level == -4)
+				continue;
 			MD_BUG();
 			goto abort;
 		}
@@ -1436,15 +1440,7 @@
 		 * in the superblock:
 		 */
 		if (mddev->sb->level == -4) {
-			if ((rdev->desc_nr != -1) && (rdev->desc_nr != i)) {
-				MD_BUG();
-				goto abort;
-			}
 			rdev->desc_nr = i;
-			if (!first)
-				rdev->alias_device = 1;
-			else
-				first = 0;
 		}
 	}
 
@@ -1460,31 +1456,29 @@
 	/*
 	 * Do a final reality check.
 	 */
-	if (mddev->sb->level != -4) {
-		ITERATE_RDEV(mddev,rdev,tmp) {
-			if (rdev->desc_nr == -1) {
+	ITERATE_RDEV(mddev,rdev,tmp) {
+		if (rdev->desc_nr == -1) {
+			MD_BUG();
+			goto abort;
+		}
+		/*
+		 * is the desc_nr unique?
+		 */
+		ITERATE_RDEV(mddev,rdev2,tmp2) {
+			if ((rdev2 != rdev) &&
+					(rdev2->desc_nr == rdev->desc_nr)) {
 				MD_BUG();
 				goto abort;
 			}
-			/*
-			 * is the desc_nr unique?
-			 */
-			ITERATE_RDEV(mddev,rdev2,tmp2) {
-				if ((rdev2 != rdev) &&
-						(rdev2->desc_nr == rdev->desc_nr)) {
-					MD_BUG();
-					goto abort;
-				}
-			}
-			/*
-			 * is the device unique?
-			 */
-			ITERATE_RDEV(mddev,rdev2,tmp2) {
-				if ((rdev2 != rdev) &&
-						(rdev2->dev == rdev->dev)) {
-					MD_BUG();
-					goto abort;
-				}
+		}
+		/*
+		 * is the device unique?
+		 */
+		ITERATE_RDEV(mddev,rdev2,tmp2) {
+			if ((rdev2 != rdev) &&
+					(rdev2->dev == rdev->dev)) {
+				MD_BUG();
+				goto abort;
 			}
 		}
 	}
@@ -1909,6 +1903,28 @@
 		 */
 		mddev->sb_dirty = 0;
 		do_md_stop (mddev, 0);
+	} else {
+		/* Create an rdev for the freshly started md device
+		 * and add to the end of the list */
+		kdev_t dev = MKDEV(MD_MAJOR,mddev->__minor);
+		if (md_import_device(dev,1)) {
+			printk("md: no nested md device found\n");
+		} else {
+			rdev = find_rdev_all(dev);
+			/* This should all be impossible because we _just_
+			 * imported the device! */
+			if (!rdev) {
+				MD_BUG();
+				return;
+			}
+			if (rdev->faulty) {
+				MD_BUG();
+				return;
+			}
+			printk("md: added md%d to the autodetection\n",
+				mdidx(mddev));
+			md_list_add(&rdev->pending, pending_raid_disks.prev);
+		}
 	}
 }
 
@@ -2337,10 +2353,9 @@
 		return -EINVAL;
 	}
 	disk = &mddev->sb->disks[rdev->desc_nr];
-	if (disk_active(disk)) {
-		MD_BUG();
+	if (disk_active(disk))
 		goto busy;
-	}
+
 	if (disk_removed(disk)) {
 		MD_BUG();
 		return -EINVAL;
@@ -2368,6 +2383,50 @@
 	return -EBUSY;
 }
 
+/*
+ * find the maching mdk_disk_t and pass to diskops
+ */
+static int set_mp_params(mddev_t * mddev, kdev_t dev, int state)
+{
+	mdp_disk_t *disk;
+	mdk_rdev_t *rdev;
+
+	if (!mddev->pers)
+		return -ENODEV;
+	if (!mddev->pers->diskop)
+		return -ENXIO;
+
+	rdev = find_rdev(mddev, dev);
+	if (!rdev)
+		return -ENXIO;
+
+	if (rdev->desc_nr == -1) {
+		MD_BUG();
+		return -EINVAL;
+	}
+
+	disk = &mddev->sb->disks[rdev->desc_nr];
+
+#if 0
+	printk("set_mp_params: state: %d dev: %s disk: %s (%d)\n",
+			state,
+			partition_name(dev),
+			partition_name(MKDEV(disk->major,disk->minor)),
+			disk->number);
+	print_rdev(rdev);
+#endif
+	switch (state) {
+	case SET_DISK_ACTIVE:
+		return mddev->pers->diskop(mddev, &disk, DISKOP_ACTIVATE_PATH);
+	case SET_DISK_INACTIVE:
+		return mddev->pers->diskop(mddev, &disk, DISKOP_DISABLE_PATH);
+	case SET_DISK_CLEAN:
+		return mddev->pers->diskop(mddev, &disk, DISKOP_CLEAN_PATH);
+	}
+
+	return -EINVAL;
+}
+
 static int hot_add_disk(mddev_t * mddev, kdev_t dev)
 {
 	int i, err, persistent;
@@ -2859,6 +2918,12 @@
 			goto done_unlock;
 		}
 
+		case SET_DISK_CLEAN:
+		case SET_DISK_ACTIVE:
+		case SET_DISK_INACTIVE:
+			err = set_mp_params(mddev, (kdev_t) arg, cmd);
+			goto done_unlock;
+
 		default:
 			printk(KERN_WARNING "md: %s(pid %d) used obsolete MD ioctl, "
 			       "upgrade your software to use new ictls.\n",
@@ -3272,6 +3337,7 @@
 		}
 		disk = &sb->disks[rdev->desc_nr];
 		if (disk_faulty(disk)) {
+			print_desc(disk);
 			MD_BUG();
 			continue;
 		}
@@ -3511,6 +3577,8 @@
 		sb = mddev->sb;
 		if (!sb)
 			continue;
+		if (sb->level == -4)
+			continue;
 		if (mddev->recovery_running)
 			continue;
 		if (sb->active_disks == sb->raid_disks)
@@ -4037,6 +4105,7 @@
 MD_EXPORT_SYMBOL(md_wakeup_thread);
 MD_EXPORT_SYMBOL(md_print_devices);
 MD_EXPORT_SYMBOL(find_rdev_nr);
+MD_EXPORT_SYMBOL(find_rdev);
 MD_EXPORT_SYMBOL(md_interrupt_thread);
 MD_EXPORT_SYMBOL(mddev_map);
 MD_EXPORT_SYMBOL(md_check_ordering);
diff -urN linux-2.4.19/drivers/md/multipath.c linux-2.4.19.SuSE/drivers/md/multipath.c
--- linux-2.4.19/drivers/md/multipath.c	Mon Feb 25 20:37:58 2002
+++ linux-2.4.19.SuSE/drivers/md/multipath.c	Sat Aug 24 20:48:19 2002
@@ -52,6 +52,7 @@
 struct multipath_bh *multipath_retry_list = NULL, **multipath_retry_tail;
 
 static int multipath_diskop(mddev_t *mddev, mdp_disk_t **d, int state);
+static void print_multipath_conf (multipath_conf_t *conf);
 
 
 
@@ -190,6 +191,9 @@
 void multipath_end_request (struct buffer_head *bh, int uptodate)
 {
 	struct multipath_bh * mp_bh = (struct multipath_bh *)(bh->b_private);
+	struct multipath_info * multipath = mp_bh->multipath;
+
+	atomic_dec(&multipath->nr_pending_buffers);
 
 	/*
 	 * this branch is our 'one multipath IO has finished' event handler:
@@ -224,18 +228,66 @@
 
 /*
  * This routine returns the disk from which the requested read should
- * be done.
+ * be done. If possible, select the path where we can be lucky enough that
+ * the buffer will merge with the previous request. If no matches found
+ * there, just select the least busy path
  */
-
-static int multipath_read_balance (multipath_conf_t *conf)
+static int multipath_rw_balance (multipath_conf_t *conf, int rw,
+				 struct buffer_head *bh)
 {
-	int disk;
+	int disk, best_so_far = -1, nr_pending = 0, tmp, first = 1;
 
-	for (disk = 0; disk < conf->raid_disks; disk++)	
-		if (conf->multipaths[disk].operational)
-			return disk;
-	BUG();
-	return 0;
+	for (disk = 0; disk < conf->raid_disks; disk++) {
+		struct multipath_info *mpi = &conf->multipaths[disk];
+
+		if (!mpi->operational)
+			continue;
+
+		if (first) {
+			best_so_far = disk;
+
+#if 1
+			/*
+			 * WRITEs, choose first operational path always
+			 */
+			if (rw == WRITE)
+				break;
+#endif
+
+			nr_pending = atomic_read(&mpi->nr_pending_buffers);
+		}
+
+		/*
+		 * check for possible front- or back merge
+		 */
+		if (rw == mpi->last_rw) {
+			
+			if (bh->b_rsector == mpi->last_end_sector
+			    || bh->b_rsector + (bh->b_size >> 9) == mpi->last_start_sector) {
+				best_so_far = disk;
+				break;
+			}
+		}
+
+		/*
+		 * don't check pending for first disk, already did
+		 */
+		if (first) {
+			first = 0;
+			continue;
+		}
+
+		/*
+		 * just a ball park number, good enough for balancing
+		 */
+		tmp = atomic_read(&mpi->nr_pending_buffers);
+		if (tmp < nr_pending) {
+			nr_pending = tmp;
+			best_so_far = disk;
+		}
+	}
+
+	return best_so_far;
 }
 
 static int multipath_make_request (mddev_t *mddev, int rw,
@@ -245,6 +297,7 @@
 	struct buffer_head *bh_req;
 	struct multipath_bh * mp_bh;
 	struct multipath_info *multipath;
+	int ret;
 
 	if (!buffer_locked(bh))
 		BUG();
@@ -265,16 +318,28 @@
 	mp_bh->cmd = rw;
 
 	/*
-	 * read balancing logic:
+	 * read/write balancing logic:
 	 */
-	multipath = conf->multipaths + multipath_read_balance(conf);
+	if ((ret = multipath_rw_balance(conf, rw, bh)) == -1) {
+		print_multipath_conf(conf);
+		MD_BUG();
+		buffer_IO_error(bh);
+		return 0;
+	}
+
+	multipath = conf->multipaths + ret;
+
+	multipath->last_end_sector = bh->b_rsector + (bh->b_size >> 9);
+	multipath->last_start_sector = bh->b_rsector;
+	multipath->last_rw = rw;
+
+	atomic_inc(&multipath->nr_pending_buffers);
+	mp_bh->multipath = multipath;
 
 	bh_req = &mp_bh->bh_req;
 	memcpy(bh_req, bh, sizeof(*bh));
-	bh_req->b_blocknr = bh->b_rsector;
 	bh_req->b_dev = multipath->dev;
 	bh_req->b_rdev = multipath->dev;
-/*	bh_req->b_rsector = bh->n_rsector; */
 	bh_req->b_end_io = multipath_end_request;
 	bh_req->b_private = mp_bh;
 	generic_make_request (rw, bh_req);
@@ -305,24 +370,123 @@
 "multipath: IO failure on %s, disabling IO path. \n" \
 "	Operation continuing on %d IO paths.\n"
 
+static inline void clear_disk_faulty(mdp_disk_t *d)
+{
+	d->state &= ~(1 << MD_DISK_FAULTY);
+}
+
+static void verify_positions(mddev_t *mddev, const char *string)
+{
+	mdp_super_t *sb = mddev->sb;
+	mdp_disk_t *desc;
+	int i;
+
+	printk("verify_positions: %s\n", string);
+	
+	for (i = 0; i < sb->raid_disks; i++) {
+		desc = &sb->disks[i];
+		if (desc->number != i)
+			printk("desc %p is in spot %d, but names %d\n", desc, i, desc->number);
+	}
+}
+
+/*
+ * switch positions 1 and 2 in the array list
+ */
+static void multipath_switch_pos(multipath_conf_t *conf, mdp_disk_t *desc,
+				 mdp_disk_t *desc2)
+{
+	struct multipath_info *disk, *disk2;
+	mdk_rdev_t *rdev1, *rdev2;
+
+	verify_positions(conf->mddev, "switch_pos_begin");
+
+	disk = conf->multipaths + desc->raid_disk;
+	disk2 = conf->multipaths + desc2->raid_disk;
+
+	xchg_values(*desc2,*desc);
+	xchg_values(*disk2,*disk);
+	xchg_values(desc2->number, desc->number);
+	xchg_values(disk2->number, disk->number);
+	xchg_values(desc2->raid_disk, desc->raid_disk);
+	xchg_values(disk2->raid_disk, disk->raid_disk);
+
+	rdev1 = find_rdev_nr(conf->mddev, desc->raid_disk);
+	rdev2 = find_rdev_nr(conf->mddev, desc2->raid_disk);
+
+	if (rdev1 && rdev2)
+		xchg_values(rdev1->desc_nr, rdev2->desc_nr);
+	
+	verify_positions(conf->mddev, "switch_pos_end");
+}
+
+static void mark_disk_good (mddev_t *mddev, int disk)
+{
+	multipath_conf_t *conf = mddev_to_conf(mddev);
+	struct multipath_info *multipath = conf->multipaths + disk;
+	mdp_super_t *sb = mddev->sb;
+	mdk_rdev_t *rdev;
+
+	rdev = find_rdev_nr(mddev, disk);
+	rdev->faulty = 0;
+
+	multipath->spare = 1;
+	if (!disk_faulty(sb->disks+multipath->number)) {
+		printk("mark_disk_good: disk %d already good\n",disk);
+		return;
+	}
+	
+	clear_disk_faulty(sb->disks+multipath->number);
+	sb->failed_disks--;
+
+	sb->working_disks++;
+	sb->spare_disks++;
+	mddev->sb_dirty = 1;
+	md_wakeup_thread(conf->thread);
+	conf->working_disks++;
+	
+}
+
 static void mark_disk_bad (mddev_t *mddev, int failed)
 {
 	multipath_conf_t *conf = mddev_to_conf(mddev);
 	struct multipath_info *multipath = conf->multipaths+failed;
 	mdp_super_t *sb = mddev->sb;
+	int last_drive = conf->working_disks - 1;
+
+	printk("md: mark_disk_bad: disk %d\n", failed);
 
 	multipath->operational = 0;
+	if (disk_faulty(sb->disks+multipath->number)) {
+		printk("md: Disk already marked bad. Doing nothing!\n");
+		return;		
+	}
+	
 	mark_disk_faulty(sb->disks+multipath->number);
 	mark_disk_nonsync(sb->disks+multipath->number);
-	mark_disk_inactive(sb->disks+multipath->number);
-	sb->active_disks--;
+	if (disk_active(sb->disks+multipath->number)) {
+		printk("Deactivating disk\n");
+		mark_disk_inactive(sb->disks+multipath->number);
+		sb->active_disks--;
+		conf->raid_disks--;
+		sb->raid_disks--;
+	}
+	conf->working_disks--;
 	sb->working_disks--;
 	sb->failed_disks++;
 	mddev->sb_dirty = 1;
-	md_wakeup_thread(conf->thread);
-	conf->working_disks--;
+
 	printk (DISK_FAILED, partition_name (multipath->dev),
 				 conf->working_disks);
+	
+	/*
+	 * switch the faulty drive with the last one, so the working ones
+	 * are always at the front of the array
+	 */
+	if (failed != last_drive)
+		multipath_switch_pos(conf, &sb->disks[failed], &sb->disks[last_drive]);
+
+	md_wakeup_thread(conf->thread);
 }
 
 /*
@@ -334,6 +498,7 @@
 	struct multipath_info * multipaths = conf->multipaths;
 	int disks = MD_SB_DISKS;
 	int other_paths = 1;
+	mdk_rdev_t *rrdev;
 	int i;
 
 	if (conf->working_disks == 1) {
@@ -354,7 +519,7 @@
 		 */
 		for (i = 0; i < disks; i++) {
 			if (multipaths[i].dev==dev && !multipaths[i].operational)
-				return 0;
+				goto out;
 		}
 		printk (LAST_DISK);
 	} else {
@@ -367,33 +532,38 @@
 				break;
 			}
 		}
-		if (!conf->working_disks) {
-			int err = 1;
+		rrdev = find_rdev(mddev, dev);
+		if (rrdev)
+			rrdev->faulty = 1;
+		
+		if (conf->working_disks > 0) {
 			mdp_disk_t *spare;
-			mdp_super_t *sb = mddev->sb;
-
+	
 			spare = get_spare(mddev);
 			if (spare) {
-				err = multipath_diskop(mddev, &spare, DISKOP_SPARE_WRITE);
-				printk("got DISKOP_SPARE_WRITE err: %d. (spare_faulty(): %d)\n", err, disk_faulty(spare));
-			}
-			if (!err && !disk_faulty(spare)) {
-				multipath_diskop(mddev, &spare, DISKOP_SPARE_ACTIVE);
-				mark_disk_sync(spare);
-				mark_disk_active(spare);
-				sb->active_disks++;
-				sb->spare_disks--;
+				if (!disk_faulty(spare)) {
+					multipath_diskop(mddev, 
+						&spare, DISKOP_ACTIVATE_PATH);
+				} else {
+					printk("md: Our spare is faulty!\n");
+					print_multipath_conf(conf);
+					MD_BUG();
+				}
 			}
+		} else {
+			printk(NO_SPARE_DISK);
 		}
 	}
-	return 0;
+
+out:
+
+	return 2;
 }
 
 #undef LAST_DISK
 #undef NO_SPARE_DISK
 #undef DISK_FAILED
 
-
 static void print_multipath_conf (multipath_conf_t *conf)
 {
 	int i;
@@ -428,57 +598,81 @@
 	mdp_disk_t *failed_desc, *spare_desc, *added_desc;
 	mdk_rdev_t *spare_rdev, *failed_rdev;
 
+#if 0
 	print_multipath_conf(conf);
+#endif
 	md_spin_lock_irq(&conf->device_lock);
 	/*
 	 * find the disk ...
 	 */
 	switch (state) {
-
 	case DISKOP_SPARE_ACTIVE:
+	case DISKOP_SPARE_WRITE:
+	case DISKOP_SPARE_INACTIVE:
+		printk(KERN_ERR "md: multipath does not support recovery operations\n");
+		goto abort;
+		break;
+
+	case DISKOP_ACTIVATE_PATH:
+
+		for (i = 0; i < conf->nr_disks; i++) {
+			tmp = conf->multipaths + i;
+			if (tmp->spare && tmp->number == (*d)->number) {
+				spare_disk = i;
+				break;
+			}
+		}
+		if (spare_disk == -1) {
+			err = -EBUSY;
+			goto abort;
+		}
+
+		failed_disk = conf->working_disks;
+		break;
+
+	case DISKOP_DISABLE_PATH:
+
+		if (conf->raid_disks == 1) {
+			printk("multipath: can't disable last path\n");
+			err = -EBUSY;
+			goto abort;
+		}
 
-		/*
-		 * Find the failed disk within the MULTIPATH configuration ...
-		 * (this can only be in the first conf->working_disks part)
-		 */
 		for (i = 0; i < conf->raid_disks; i++) {
 			tmp = conf->multipaths + i;
-			if ((!tmp->operational && !tmp->spare) ||
-					!tmp->used_slot) {
-				failed_disk = i;
+			if (tmp->operational && tmp->number == (*d)->number) {
+				removed_disk = i;
 				break;
 			}
 		}
-		/*
-		 * When we activate a spare disk we _must_ have a disk in
-		 * the lower (active) part of the array to replace. 
-		 */
-		if ((failed_disk == -1) || (failed_disk >= conf->raid_disks)) {
-			MD_BUG();
-			err = 1;
+
+		if (removed_disk == -1) {
+			err = -EINVAL;
 			goto abort;
 		}
-		/* fall through */
 
-	case DISKOP_SPARE_WRITE:
-	case DISKOP_SPARE_INACTIVE:
+		failed_disk = conf->raid_disks - 1;
+		break;
 
+	case DISKOP_CLEAN_PATH:
 		/*
-		 * Find the spare disk ... (can only be in the 'high'
-		 * area of the array)
+		 * find faulty drive
 		 */
-		for (i = conf->raid_disks; i < MD_SB_DISKS; i++) {
+		for (i = 0; i < conf->nr_disks; i++) {
 			tmp = conf->multipaths + i;
-			if (tmp->spare && tmp->number == (*d)->number) {
-				spare_disk = i;
+			if (!tmp->operational && !tmp->spare
+			    && tmp->number == (*d)->number) {
+				failed_disk = i;
 				break;
 			}
 		}
-		if (spare_disk == -1) {
-			MD_BUG();
-			err = 1;
+
+		if (failed_disk == -1) {
+			err = -EINVAL;
 			goto abort;
 		}
+
+		spare_disk = conf->working_disks;
 		break;
 
 	case DISKOP_HOT_REMOVE_DISK:
@@ -520,31 +714,60 @@
 	}
 
 	switch (state) {
-	/*
-	 * Switch the spare disk to write-only mode:
-	 */
-	case DISKOP_SPARE_WRITE:
-		sdisk = conf->multipaths + spare_disk;
-		sdisk->operational = 1;
+	case DISKOP_HOT_REMOVE_DISK:
+		rdisk = conf->multipaths + removed_disk;
+
+		if (rdisk->spare && (removed_disk < conf->raid_disks)) {
+			MD_BUG();	
+			err = 1;
+			goto abort;
+		}
+		rdisk->dev = MKDEV(0,0);
+		rdisk->used_slot = 0;
+		rdisk->number = 0;
+		mddev->sb_dirty = 1;
+		md_wakeup_thread(conf->thread);
+		conf->nr_disks--;
 		break;
-	/*
-	 * Deactivate a spare disk:
-	 */
-	case DISKOP_SPARE_INACTIVE:
-		sdisk = conf->multipaths + spare_disk;
-		sdisk->operational = 0;
+	case DISKOP_HOT_ADD_DISK:
+		adisk = conf->multipaths + added_disk;
+		added_desc = *d;
+
+		if (added_disk != added_desc->number) {
+			printk("DISKOP_HOT_ADD_DISK: we want slot %d != md wants %d\n",
+					added_disk, added_desc->number);
+			err = 1;
+			goto abort;
+		}
+
+		adisk->number = added_desc->number;
+		adisk->raid_disk = added_desc->raid_disk;
+		adisk->dev = MKDEV(added_desc->major,added_desc->minor);
+
+		adisk->operational = 0;
+		adisk->spare = 1;
+		adisk->used_slot = 1;
+		conf->nr_disks++;
+		/* Believing it to be good until proven otherwise ;-) */
+		conf->working_disks++;
+
+		mddev->sb_dirty = 1;
+		md_wakeup_thread(conf->thread);
+
 		break;
-	/*
-	 * Activate (mark read-write) the (now sync) spare disk,
-	 * which means we switch it's 'raid position' (->raid_disk)
-	 * with the failed disk. (only the first 'conf->nr_disks'
-	 * slots are used for 'real' disks and we must preserve this
-	 * property)
-	 */
-	case DISKOP_SPARE_ACTIVE:
+
+	case DISKOP_ACTIVATE_PATH:
 		sdisk = conf->multipaths + spare_disk;
 		fdisk = conf->multipaths + failed_disk;
 
+		printk("md: activate: %s\n",
+				partition_name(sdisk->dev));
+
+		if (!sdisk->spare) {
+			printk("md: activate: not spare\n");
+			goto abort;
+		}
+
 		spare_desc = &sb->disks[sdisk->number];
 		failed_desc = &sb->disks[fdisk->number];
 
@@ -572,90 +795,117 @@
 			goto abort;
 		}
 
+#if 0
 		if (fdisk->raid_disk != failed_disk) {
 			MD_BUG();
 			err = 1;
 			goto abort;
 		}
+#endif
+
+		sdisk->spare = 0;
+		sdisk->operational = 1;
 
 		/*
 		 * do the switch finally
 		 */
-		spare_rdev = find_rdev_nr(mddev, spare_desc->number);
-		failed_rdev = find_rdev_nr(mddev, failed_desc->number);
-		xchg_values(spare_rdev->desc_nr, failed_rdev->desc_nr);
-		spare_rdev->alias_device = 0;
-		failed_rdev->alias_device = 1;
+		if (failed_disk < spare_disk) {
+			multipath_switch_pos(conf, spare_desc, failed_desc);
 
-		xchg_values(*spare_desc, *failed_desc);
-		xchg_values(*fdisk, *sdisk);
-
-		/*
-		 * (careful, 'failed' and 'spare' are switched from now on)
-		 *
-		 * we want to preserve linear numbering and we want to
-		 * give the proper raid_disk number to the now activated
-		 * disk. (this means we switch back these values)
-		 */
-	
-		xchg_values(spare_desc->raid_disk, failed_desc->raid_disk);
-		xchg_values(sdisk->raid_disk, fdisk->raid_disk);
-		xchg_values(spare_desc->number, failed_desc->number);
-		xchg_values(sdisk->number, fdisk->number);
+			*d = failed_desc;
 
-		*d = failed_desc;
+			if (sdisk->dev == MKDEV(0,0))
+				MD_BUG();
+		}
 
-		if (sdisk->dev == MKDEV(0,0))
-			sdisk->used_slot = 0;
 		/*
 		 * this really activates the spare.
 		 */
-		fdisk->spare = 0;
+		mark_disk_active(*d);
+		conf->raid_disks++;
+		sb->raid_disks++;
+		sb->active_disks++;
+		mddev->sb->spare_disks--;
+		mddev->sb_dirty = 1;
+		md_wakeup_thread(conf->thread);
+		break;
+
+	case DISKOP_DISABLE_PATH:
+		sdisk = conf->multipaths + removed_disk;
+		fdisk = conf->multipaths + failed_disk;
+
+		printk("md: deactivate: %s\n",
+				partition_name(sdisk->dev));
+
+		spare_desc = &sb->disks[sdisk->number];
+		failed_desc = &sb->disks[fdisk->number];
+
+		if (spare_desc != *d) {
+			printk("diskop_disable_path: we want %s (%d), md said %s (%d)\n",
+					partition_name(MKDEV(spare_desc->major,spare_desc->minor)),
+					removed_disk,
+					partition_name(MKDEV((*d)->major,(*d)->minor)),
+					(*d)->number);
+			MD_BUG();
+			err = 1;
+			goto abort;
+		}
 
 		/*
-		 * if we activate a spare, we definitely replace a
-		 * non-operational disk slot in the 'low' area of
-		 * the disk array.
+		 * do the switch finally
 		 */
+		if (removed_disk != failed_disk) {
+			multipath_switch_pos(conf, spare_desc, failed_desc);
 
-		conf->working_disks++;
+			*d = failed_desc;
 
+			if (sdisk->dev == MKDEV(0,0))
+				MD_BUG();
+		}
+
+		mark_disk_spare(*d);
+		mark_disk_inactive(*d);
+		fdisk->spare = 1;
+		fdisk->operational = 0;
+		conf->raid_disks--;
+		sb->raid_disks--;
+		sb->active_disks--;
+		mddev->sb->spare_disks++;
+		mddev->sb_dirty = 1;
+		md_wakeup_thread(conf->thread);
 		break;
 
-	case DISKOP_HOT_REMOVE_DISK:
-		rdisk = conf->multipaths + removed_disk;
+	case DISKOP_CLEAN_PATH:
+		fdisk = conf->multipaths + failed_disk;
 
-		if (rdisk->spare && (removed_disk < conf->raid_disks)) {
-			MD_BUG();	
+		failed_desc = &sb->disks[fdisk->number];
+
+		if (failed_desc->raid_disk != fdisk->raid_disk) {
+			MD_BUG();
 			err = 1;
 			goto abort;
 		}
-		rdisk->dev = MKDEV(0,0);
-		rdisk->used_slot = 0;
-		conf->nr_disks--;
-		break;
-
-	case DISKOP_HOT_ADD_DISK:
-		adisk = conf->multipaths + added_disk;
-		added_desc = *d;
 
-		if (added_disk != added_desc->number) {
-			MD_BUG();	
+		if (fdisk->raid_disk != failed_disk) {
+			MD_BUG();
 			err = 1;
 			goto abort;
 		}
 
-		adisk->number = added_desc->number;
-		adisk->raid_disk = added_desc->raid_disk;
-		adisk->dev = MKDEV(added_desc->major,added_desc->minor);
+		/*
+		 * this really activates the spare.
+		 */
+		fdisk->spare = 0;
+		mark_disk_good(mddev, failed_disk);
 
-		adisk->operational = 0;
-		adisk->spare = 1;
-		adisk->used_slot = 1;
-		conf->nr_disks++;
+		if (failed_disk != spare_disk) {
+			spare_desc = &sb->disks[spare_disk];
+			multipath_switch_pos(conf, failed_desc, spare_desc);
+		}
 
 		break;
 
+
 	default:
 		MD_BUG();	
 		err = 1;
@@ -833,7 +1083,7 @@
 	mdp_disk_t *desc, *desc2;
 	mdk_rdev_t *rdev, *def_rdev = NULL;
 	struct md_list_head *tmp;
-	int num_rdevs = 0;
+	int num_rdevs = 0, nr_spares = 0;
 
 	MOD_INC_USE_COUNT;
 
@@ -854,6 +1104,7 @@
 		goto out;
 	}
 	memset(conf, 0, sizeof(*conf));
+	conf->mddev = mddev;
 
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		if (rdev->faulty) {
@@ -878,9 +1129,6 @@
 		disk_idx = desc->raid_disk;
 		disk = conf->multipaths + disk_idx;
 
-		if (!disk_sync(desc))
-			printk(NOT_IN_SYNC, partition_name(rdev->dev));
-
 		/*
 		 * Mark all disks as spare to start with, then pick our
 		 * active disk.  If we have a disk that is marked active
@@ -892,23 +1140,31 @@
 		disk->operational = 0;
 		disk->spare = 1;
 		disk->used_slot = 1;
-		mark_disk_sync(desc);
 
+		/*
+		 * bring paths online and spare. online paths will be
+		 * read balanced automatically
+		 */
 		if (disk_active(desc)) {
-			if(!conf->working_disks) {
-				printk(OPERATIONAL, partition_name(rdev->dev),
- 					desc->raid_disk);
-				disk->operational = 1;
-				disk->spare = 0;
-				conf->working_disks++;
+			printk(OPERATIONAL, partition_name(rdev->dev), desc->raid_disk);
+			disk->operational = 1;
+			disk->spare = 0;
+
+			if (!conf->working_disks++)
 				def_rdev = rdev;
-			} else {
-				mark_disk_spare(desc);
-			}
-		} else
+
+			conf->raid_disks++;
+#if 0
+			sb->raid_disks++;
+			sb->active_disks++;
+#endif
+		} else {
+			nr_spares++;
 			mark_disk_spare(desc);
+		}
 
-		if(!num_rdevs++) def_rdev = rdev;
+		if (!num_rdevs++)
+			def_rdev = rdev;
 	}
 	if(!conf->working_disks && num_rdevs) {
 		desc = &sb->disks[def_rdev->desc_nr];
@@ -923,10 +1179,10 @@
 	/*
 	 * Make sure our active path is in desc spot 0
 	 */
-	if(def_rdev->desc_nr != 0) {
-		rdev = find_rdev_nr(mddev, 0);
+	if (def_rdev && def_rdev->desc_nr != 0) {
 		desc = &sb->disks[def_rdev->desc_nr];
 		desc2 = sb->disks;
+
 		disk = conf->multipaths + desc->raid_disk;
 		disk2 = conf->multipaths + desc2->raid_disk;
 		xchg_values(*desc2,*desc);
@@ -935,18 +1191,20 @@
 		xchg_values(disk2->number, disk->number);
 		xchg_values(desc2->raid_disk, desc->raid_disk);
 		xchg_values(disk2->raid_disk, disk->raid_disk);
+
+		rdev = find_rdev_nr(mddev, 0);
 		if(rdev) {
 			xchg_values(def_rdev->desc_nr,rdev->desc_nr);
 		} else {
 			def_rdev->desc_nr = 0;
 		}
 	}
-	conf->raid_disks = sb->raid_disks = sb->active_disks = 1;
 	conf->nr_disks = sb->nr_disks = sb->working_disks = num_rdevs;
 	sb->failed_disks = 0;
-	sb->spare_disks = num_rdevs - 1;
+	sb->spare_disks = nr_spares;
+	sb->active_disks = num_rdevs - nr_spares;
+	sb->raid_disks = sb->active_disks;
 	mddev->sb_dirty = 1;
-	conf->mddev = mddev;
 	conf->device_lock = MD_SPIN_LOCK_UNLOCKED;
 
 	init_waitqueue_head(&conf->wait_buffer);
@@ -997,11 +1255,8 @@
 	 * each device.
 	 */
 	for (i = 0; i < MD_SB_DISKS; i++) {
-		mark_disk_nonsync(sb->disks+i);
-		for (j = 0; j < sb->raid_disks; j++) {
-			if (sb->disks[i].number == conf->multipaths[j].number)
-				mark_disk_sync(sb->disks+i);
-		}
+		for (j = 0; j < sb->raid_disks; j++)
+			atomic_set(&conf->multipaths[j].nr_pending_buffers, 0);
 	}
 
 	printk(ARRAY_IS_ACTIVE, mdidx(mddev), sb->active_disks,
diff -urN linux-2.4.19/include/linux/raid/md_k.h linux-2.4.19.SuSE/include/linux/raid/md_k.h
--- linux-2.4.19/include/linux/raid/md_k.h	Mon Nov 26 14:29:17 2001
+++ linux-2.4.19.SuSE/include/linux/raid/md_k.h	Sat Aug 24 20:48:19 2002
@@ -173,12 +173,16 @@
 	mdp_super_t *sb;
 	unsigned long sb_offset;
 
-	int alias_device;		/* device alias to the same disk */
 	int faulty;			/* if faulty do not issue IO requests */
 	int desc_nr;			/* descriptor index in the superblock */
 };
 
 
+static inline int rdev_is_alias(mdk_rdev_t * rdev)
+{
+	return ((rdev->sb->level == -4) && (rdev->desc_nr != 0));
+}
+
 /*
  * disk operations in a working array:
  */
@@ -187,6 +191,9 @@
 #define DISKOP_SPARE_ACTIVE	2
 #define DISKOP_HOT_REMOVE_DISK	3
 #define DISKOP_HOT_ADD_DISK	4
+#define DISKOP_ACTIVATE_PATH	5
+#define DISKOP_DISABLE_PATH	6
+#define DISKOP_CLEAN_PATH	7
 
 typedef struct mdk_personality_s mdk_personality_t;
 
diff -urN linux-2.4.19/include/linux/raid/md_u.h linux-2.4.19.SuSE/include/linux/raid/md_u.h
--- linux-2.4.19/include/linux/raid/md_u.h	Fri Sep 14 23:21:51 2001
+++ linux-2.4.19.SuSE/include/linux/raid/md_u.h	Sat Aug 24 20:48:19 2002
@@ -44,6 +44,11 @@
 #define STOP_ARRAY_RO		_IO (MD_MAJOR, 0x33)
 #define RESTART_ARRAY_RW	_IO (MD_MAJOR, 0x34)
 
+/* multi-path extensions */
+#define SET_DISK_CLEAN		_IO (MD_MAJOR, 0x35)
+#define SET_DISK_ACTIVE		_IO (MD_MAJOR, 0x36)
+#define SET_DISK_INACTIVE	_IO (MD_MAJOR, 0x37)
+
 typedef struct mdu_version_s {
 	int major;
 	int minor;
diff -urN linux-2.4.19/include/linux/raid/multipath.h linux-2.4.19.SuSE/include/linux/raid/multipath.h
--- linux-2.4.19/include/linux/raid/multipath.h	Mon Nov 12 18:51:56 2001
+++ linux-2.4.19.SuSE/include/linux/raid/multipath.h	Sat Aug 24 20:48:19 2002
@@ -15,6 +15,11 @@
 	int		spare;
 
 	int		used_slot;
+
+	atomic_t	nr_pending_buffers;
+	unsigned long	last_start_sector;
+	unsigned long	last_end_sector;
+	int		last_rw;
 };
 
 struct multipath_private_data {
@@ -63,6 +68,7 @@
 	struct buffer_head	*master_bh;
 	struct buffer_head	bh_req;
 	struct multipath_bh	*next_mp; /* next for retry or in free list */
+	struct multipath_info *multipath;
 };
 /* bits for multipath_bh.state */
 #define	MPBH_Uptodate	1

--9UV9rz0O2dU/yYYn--
