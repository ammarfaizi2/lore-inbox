Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263094AbSJBKWJ>; Wed, 2 Oct 2002 06:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263095AbSJBKWJ>; Wed, 2 Oct 2002 06:22:09 -0400
Received: from gate.in-addr.de ([212.8.193.158]:47370 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S263094AbSJBKVs>;
	Wed, 2 Oct 2002 06:21:48 -0400
Date: Wed, 2 Oct 2002 12:28:46 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: md multipathing extensions in 2.4
Message-ID: <20021002102846.GD3304@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Neil,

please find the revised version of the multipath extensions attached. They
have undergone some testing as part of the United Linux stuff and seem
stable.

They still implement the same features as last time, just fix a bug where t=
hey
broke raid0 accidentially. The new changes should be even more contained and
only change behaviour for multipathing in any way.

I've also attached the mdadm patches, so that it is obvious how they affect
userspace. (Because it was so small I've also added a tiny fix to make mdadm
work on 64bit archs in there)

Please consider submitting it to 2.4 and comment on whether you'd like the
changes to go in 2.5 too.


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
Principal Squirrel
Research and Development, SuSE Linux AG
=20
``Immortality is an adequate definition of high availability for me.''
	--- Gregory F. Pfister


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=md-mp
Content-Transfer-Encoding: quoted-printable

diff -ur linux.orig/drivers/md/md.c linux/drivers/md/md.c
--- linux.orig/drivers/md/md.c	Sat Aug  3 02:39:44 2002
+++ linux/drivers/md/md.c	Thu Sep 12 19:31:46 2002
@@ -782,7 +782,7 @@
=20
 static void print_rdev(mdk_rdev_t *rdev)
 {
-	printk(KERN_INFO "md: rdev %s: O:%s, SZ:%08ld F:%d DN:%d ",
+	printk(KERN_INFO "md: rdev %s: O:%s, SZ:%08ld F:%d DN:%d\n",
 		partition_name(rdev->dev), partition_name(rdev->old_dev),
 		rdev->size, rdev->faulty, rdev->desc_nr);
 	if (rdev->sb) {
@@ -984,7 +984,7 @@
 	struct md_list_head *tmp;
=20
 	ITERATE_RDEV(mddev,rdev,tmp) {
-		if (rdev->faulty || rdev->alias_device)
+		if (rdev->faulty || rdev_is_alias(rdev))
 			continue;
 		sb =3D rdev->sb;
 		*sb =3D *mddev->sb;
@@ -1036,11 +1036,11 @@
 		printk(KERN_INFO "md: ");
 		if (rdev->faulty)
 			printk("(skipping faulty ");
-		if (rdev->alias_device)
+		if (rdev_is_alias(rdev))
 			printk("(skipping alias ");
=20
 		printk("%s ", partition_name(rdev->dev));
-		if (!rdev->faulty && !rdev->alias_device) {
+		if (!rdev->faulty && !rdev_is_alias(rdev)) {
 			printk("[events: %08lx]",
 				(unsigned long)rdev->sb->events_lo);
 			err +=3D write_disk_sb(rdev);
@@ -1220,8 +1220,10 @@
 		if (alloc_array_sb(mddev))
 			goto abort;
 	sb =3D mddev->sb;
+=09
+	/* Find the freshest superblock */
 	freshest =3D NULL;
-
+=09
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		__u64 ev1, ev2;
 		/*
@@ -1258,154 +1260,170 @@
 		printk(KERN_INFO "md: freshest: %s\n", partition_name(freshest->dev));
 	}
 	memcpy (sb, freshest->sb, sizeof(*sb));
-
-	/*
-	 * at this point we have picked the 'best' superblock
-	 * from all available superblocks.
-	 * now we validate this superblock and kick out possibly
-	 * failed disks.
-	 */
-	ITERATE_RDEV(mddev,rdev,tmp) {
-		/*
-		 * Kick all non-fresh devices
-		 */
-		__u64 ev1, ev2;
-		ev1 =3D md_event(rdev->sb);
-		ev2 =3D md_event(sb);
-		++ev1;
-		if (ev1 < ev2) {
-			printk(KERN_WARNING "md: kicking non-fresh %s from array!\n",
-						partition_name(rdev->dev));
-			kick_rdev_from_array(rdev);
-			continue;
-		}
-	}
-
-	/*
-	 * Fix up changed device names ... but only if this disk has a
-	 * recent update time. Use faulty checksum ones too.
-	 */
-	if (mddev->sb->level !=3D -4)
-	ITERATE_RDEV(mddev,rdev,tmp) {
-		__u64 ev1, ev2, ev3;
-		if (rdev->faulty || rdev->alias_device) {
-			MD_BUG();
-			goto abort;
-		}
-		ev1 =3D md_event(rdev->sb);
-		ev2 =3D md_event(sb);
-		ev3 =3D ev2;
-		--ev3;
-		if ((rdev->dev !=3D rdev->old_dev) &&
-			((ev1 =3D=3D ev2) || (ev1 =3D=3D ev3))) {
+=09
+	/* For multipathing, lots of things are different from "true"
+	 * RAIDs.
+	 * All rdev's could be read, so they are no longer faulty.
+	 * As there is just one sb, trying to find changed devices via the
+	 * this_disk pointer is useless too.
+	 *=20
+	 * lmb@suse.de, 2002-09-12
+	 */
+	if (sb->level =3D=3D -4) {
+		int desc_nr =3D 0;
+	=09
+		/* ... and initialize from the current rdevs instead */
+		ITERATE_RDEV(mddev,rdev,tmp) {
 			mdp_disk_t *desc;
-
-			printk(KERN_WARNING "md: device name has changed from %s to %s since la=
st import!\n",
-			       partition_name(rdev->old_dev), partition_name(rdev->dev));
-			if (rdev->desc_nr =3D=3D -1) {
-				MD_BUG();
-				goto abort;
-			}
+		=09
+			rdev->desc_nr=3Ddesc_nr;
+		=09
 			desc =3D &sb->disks[rdev->desc_nr];
-			if (rdev->old_dev !=3D MKDEV(desc->major, desc->minor)) {
-				MD_BUG();
-				goto abort;
-			}
+		=09
+			desc->raid_disk =3D desc_nr;
+			desc->number =3D desc_nr;
 			desc->major =3D MAJOR(rdev->dev);
 			desc->minor =3D MINOR(rdev->dev);
 			desc =3D &rdev->sb->this_disk;
 			desc->major =3D MAJOR(rdev->dev);
 			desc->minor =3D MINOR(rdev->dev);
-		}
-	}
=20
-	/*
-	 * Remove unavailable and faulty devices ...
-	 *
-	 * note that if an array becomes completely unrunnable due to
-	 * missing devices, we do not write the superblock back, so the
-	 * administrator has a chance to fix things up. The removal thus
-	 * only happens if it's nonfatal to the contents of the array.
-	 */
-	for (i =3D 0; i < MD_SB_DISKS; i++) {
-		int found;
-		mdp_disk_t *desc;
-		kdev_t dev;
+			/* We could read from it, so it isn't faulty
+			 * any longer */
+			if (disk_faulty(desc))
+				mark_disk_spare(desc);
+		=09
+			desc_nr++;
+		}
=20
-		desc =3D sb->disks + i;
-		dev =3D MKDEV(desc->major, desc->minor);
+		/* Kick out all old info about disks we used to have,
+		 * if any */
+		for (i =3D desc_nr; i < MD_SB_DISKS; i++)
+			memset(&(sb->disks[i]),0,sizeof(mdp_disk_t));
=20
+	} else {
 		/*
-		 * We kick faulty devices/descriptors immediately.
+		 * at this point we have picked the 'best' superblock
+		 * from all available superblocks.
 		 *
-		 * Note: multipath devices are a special case.  Since we
-		 * were able to read the superblock on the path, we don't
-		 * care if it was previously marked as faulty, it's up now
-		 * so enable it.
+		 * now we validate this superblock and kick out possibly
+		 * failed disks.
 		 */
-		if (disk_faulty(desc) && mddev->sb->level !=3D -4) {
-			found =3D 0;
-			ITERATE_RDEV(mddev,rdev,tmp) {
-				if (rdev->desc_nr !=3D desc->number)
-					continue;
-				printk(KERN_WARNING "md%d: kicking faulty %s!\n",
-					mdidx(mddev),partition_name(rdev->dev));
-				kick_rdev_from_array(rdev);
-				found =3D 1;
-				break;
-			}
-			if (!found) {
-				if (dev =3D=3D MKDEV(0,0))
-					continue;
-				printk(KERN_WARNING "md%d: removing former faulty %s!\n",
-					mdidx(mddev), partition_name(dev));
-			}
-			remove_descriptor(desc, sb);
-			continue;
-		} else if (disk_faulty(desc)) {
+		ITERATE_RDEV(mddev,rdev,tmp) {
 			/*
-			 * multipath entry marked as faulty, unfaulty it
+			 * Kick all non-fresh devices
 			 */
-			rdev =3D find_rdev(mddev, dev);
-			if(rdev)
-				mark_disk_spare(desc);
-			else
-				remove_descriptor(desc, sb);
+			__u64 ev1, ev2;
+			ev1 =3D md_event(rdev->sb);
+			ev2 =3D md_event(sb);
+			++ev1;
+			if (ev1 < ev2) {
+				printk(KERN_WARNING "md: kicking non-fresh %s from array!\n",
+						partition_name(rdev->dev));
+				kick_rdev_from_array(rdev);
+				continue;
+			}
 		}
=20
-		if (dev =3D=3D MKDEV(0,0))
-			continue;
 		/*
-		 * Is this device present in the rdev ring?
+		 * Fix up changed device names ... but only if this disk has a
+		 * recent update time. Use faulty checksum ones too.
 		 */
-		found =3D 0;
 		ITERATE_RDEV(mddev,rdev,tmp) {
+			__u64 ev1, ev2, ev3;
+			ev1 =3D md_event(rdev->sb);
+			ev2 =3D md_event(sb);
+			ev3 =3D ev2;
+			--ev3;
+			if ((rdev->dev !=3D rdev->old_dev) &&
+				((ev1 =3D=3D ev2) || (ev1 =3D=3D ev3))) {
+				mdp_disk_t *desc;
+
+				printk(KERN_WARNING "md: device name has changed from %s to %s since l=
ast import!\n",
+				       partition_name(rdev->old_dev), partition_name(rdev->dev));
+				if (rdev->desc_nr =3D=3D -1) {
+					MD_BUG();
+					goto abort;
+				}
+			=09
+				desc =3D &sb->disks[rdev->desc_nr];
+				if (rdev->old_dev !=3D MKDEV(desc->major, desc->minor)) {
+						MD_BUG();
+						goto abort;
+				}
+			=09
+				desc->major =3D MAJOR(rdev->dev);
+				desc->minor =3D MINOR(rdev->dev);
+				desc =3D &rdev->sb->this_disk;
+				desc->major =3D MAJOR(rdev->dev);
+				desc->minor =3D MINOR(rdev->dev);
+			}
+		}
+	=09
+		/*
+		 * Remove unavailable and faulty devices ...
+		 *
+		 * note that if an array becomes completely unrunnable due to
+		 * missing devices, we do not write the superblock back, so the
+		 * administrator has a chance to fix things up. The removal thus
+		 * only happens if it's nonfatal to the contents of the array.
+		 */
+		for (i =3D 0; i < MD_SB_DISKS; i++) {
+			int found;
+			mdp_disk_t *desc;
+			kdev_t dev;
+
+			desc =3D sb->disks + i;
+			dev =3D MKDEV(desc->major, desc->minor);
+
 			/*
-			 * Multi-path IO special-case: since we have no
-			 * this_disk descriptor at auto-detect time,
-			 * we cannot check rdev->number.
-			 * We can check the device though.
+			 * We kick faulty devices/descriptors immediately.
 			 */
-			if ((sb->level =3D=3D -4) && (rdev->dev =3D=3D
-					MKDEV(desc->major,desc->minor))) {
-				found =3D 1;
-				break;
+			if (disk_faulty(desc)) {
+				found =3D 0;
+				ITERATE_RDEV(mddev,rdev,tmp) {
+					if (rdev->desc_nr !=3D desc->number)
+						continue;
+					printk(KERN_WARNING "md%d: kicking faulty %s!\n",
+						mdidx(mddev),partition_name(rdev->dev));
+					kick_rdev_from_array(rdev);
+					found =3D 1;
+					break;
+				}
+				if (!found) {
+					if (dev =3D=3D MKDEV(0,0))
+						continue;
+					printk(KERN_WARNING "md%d: removing former faulty %s!\n",
+						mdidx(mddev), partition_name(dev));
+				}
+				remove_descriptor(desc, sb);
+				continue;
 			}
-			if (rdev->desc_nr =3D=3D desc->number) {
-				found =3D 1;
-				break;
+
+			if (dev =3D=3D MKDEV(0,0))
+				continue;
+			/*
+			 * Is this device present in the rdev ring?
+			 */
+			found =3D 0;
+			ITERATE_RDEV(mddev,rdev,tmp) {
+				if (rdev->desc_nr =3D=3D desc->number) {
+					found =3D 1;
+					break;
+				}
 			}
+			if (found)
+				continue;
+
+			printk(KERN_WARNING "md%d: former device %s is unavailable, removing fr=
om array!\n",
+			       mdidx(mddev), partition_name(dev));
+			remove_descriptor(desc, sb);
 		}
-		if (found)
-			continue;
=20
-		printk(KERN_WARNING "md%d: former device %s is unavailable, removing fro=
m array!\n",
-		       mdidx(mddev), partition_name(dev));
-		remove_descriptor(desc, sb);
 	}
=20
 	/*
-	 * Double check wether all devices mentioned in the
+	 * Double check whether all devices mentioned in the
 	 * superblock are in the rdev ring.
 	 */
 	first =3D 1;
@@ -1429,23 +1447,6 @@
 			MD_BUG();
 			goto abort;
 		}
-		/*
-		 * In the case of Multipath-IO, we have no
-		 * other information source to find out which
-		 * disk is which, only the position of the device
-		 * in the superblock:
-		 */
-		if (mddev->sb->level =3D=3D -4) {
-			if ((rdev->desc_nr !=3D -1) && (rdev->desc_nr !=3D i)) {
-				MD_BUG();
-				goto abort;
-			}
-			rdev->desc_nr =3D i;
-			if (!first)
-				rdev->alias_device =3D 1;
-			else
-				first =3D 0;
-		}
 	}
=20
 	/*
@@ -1460,31 +1461,25 @@
 	/*
 	 * Do a final reality check.
 	 */
-	if (mddev->sb->level !=3D -4) {
-		ITERATE_RDEV(mddev,rdev,tmp) {
-			if (rdev->desc_nr =3D=3D -1) {
+	ITERATE_RDEV(mddev,rdev,tmp) {
+		if (rdev->desc_nr =3D=3D -1) {
+			MD_BUG();
+			goto abort;
+		}
+		ITERATE_RDEV(mddev,rdev2,tmp2) {
+			/* is the desc_nr unique?  */
+			if (rdev2 =3D=3D rdev)
+				continue;
+
+			if (rdev2->desc_nr =3D=3D rdev->desc_nr) {
 				MD_BUG();
 				goto abort;
 			}
-			/*
-			 * is the desc_nr unique?
-			 */
-			ITERATE_RDEV(mddev,rdev2,tmp2) {
-				if ((rdev2 !=3D rdev) &&
-						(rdev2->desc_nr =3D=3D rdev->desc_nr)) {
-					MD_BUG();
-					goto abort;
-				}
-			}
-			/*
-			 * is the device unique?
-			 */
-			ITERATE_RDEV(mddev,rdev2,tmp2) {
-				if ((rdev2 !=3D rdev) &&
-						(rdev2->dev =3D=3D rdev->dev)) {
-					MD_BUG();
-					goto abort;
-				}
+
+			/* is the device unique? */
+			if (rdev2->dev =3D=3D rdev->dev) {
+				MD_BUG();
+				goto abort;
 			}
 		}
 	}
@@ -1909,6 +1904,28 @@
 		 */
 		mddev->sb_dirty =3D 0;
 		do_md_stop (mddev, 0);
+	} else {
+		/* Create an rdev for the freshly started md device
+		 * and add to the end of the list */
+		kdev_t dev =3D MKDEV(MD_MAJOR,mddev->__minor);
+		if (md_import_device(dev,1)) {
+			printk("md: no nested md device found\n");
+		} else {
+			rdev =3D find_rdev_all(dev);
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
=20
@@ -2337,10 +2354,9 @@
 		return -EINVAL;
 	}
 	disk =3D &mddev->sb->disks[rdev->desc_nr];
-	if (disk_active(disk)) {
-		MD_BUG();
+	if (disk_active(disk))
 		goto busy;
-	}
+
 	if (disk_removed(disk)) {
 		MD_BUG();
 		return -EINVAL;
@@ -2368,6 +2384,50 @@
 	return -EBUSY;
 }
=20
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
+	rdev =3D find_rdev(mddev, dev);
+	if (!rdev)
+		return -ENXIO;
+
+	if (rdev->desc_nr =3D=3D -1) {
+		MD_BUG();
+		return -EINVAL;
+	}
+
+	disk =3D &mddev->sb->disks[rdev->desc_nr];
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
@@ -2859,6 +2919,12 @@
 			goto done_unlock;
 		}
=20
+		case SET_DISK_CLEAN:
+		case SET_DISK_ACTIVE:
+		case SET_DISK_INACTIVE:
+			err =3D set_mp_params(mddev, (kdev_t) arg, cmd);
+			goto done_unlock;
+
 		default:
 			printk(KERN_WARNING "md: %s(pid %d) used obsolete MD ioctl, "
 			       "upgrade your software to use new ictls.\n",
@@ -3274,6 +3340,7 @@
 		}
 		disk =3D &sb->disks[rdev->desc_nr];
 		if (disk_faulty(disk)) {
+			print_desc(disk);
 			MD_BUG();
 			continue;
 		}
@@ -3521,6 +3588,8 @@
 		sb =3D mddev->sb;
 		if (!sb)
 			continue;
+		if (sb->level =3D=3D -4)
+			continue;
 		if (mddev->recovery_running)
 			continue;
 		if (sb->active_disks =3D=3D sb->raid_disks)
@@ -4047,6 +4116,7 @@
 MD_EXPORT_SYMBOL(md_wakeup_thread);
 MD_EXPORT_SYMBOL(md_print_devices);
 MD_EXPORT_SYMBOL(find_rdev_nr);
+MD_EXPORT_SYMBOL(find_rdev);
 MD_EXPORT_SYMBOL(md_interrupt_thread);
 MD_EXPORT_SYMBOL(mddev_map);
 MD_EXPORT_SYMBOL(md_check_ordering);
diff -ur linux.orig/drivers/md/multipath.c linux/drivers/md/multipath.c
--- linux.orig/drivers/md/multipath.c	Mon Feb 25 20:37:58 2002
+++ linux/drivers/md/multipath.c	Thu Sep 12 19:02:04 2002
@@ -52,6 +52,7 @@
 struct multipath_bh *multipath_retry_list =3D NULL, **multipath_retry_tail;
=20
 static int multipath_diskop(mddev_t *mddev, mdp_disk_t **d, int state);
+static void print_multipath_conf (multipath_conf_t *conf);
=20
=20
=20
@@ -190,6 +191,9 @@
 void multipath_end_request (struct buffer_head *bh, int uptodate)
 {
 	struct multipath_bh * mp_bh =3D (struct multipath_bh *)(bh->b_private);
+	struct multipath_info * multipath =3D mp_bh->multipath;
+
+	atomic_dec(&multipath->nr_pending_buffers);
=20
 	/*
 	 * this branch is our 'one multipath IO has finished' event handler:
@@ -224,18 +228,66 @@
=20
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
+	int disk, best_so_far =3D -1, nr_pending =3D 0, tmp, first =3D 1;
=20
-	for (disk =3D 0; disk < conf->raid_disks; disk++)=09
-		if (conf->multipaths[disk].operational)
-			return disk;
-	BUG();
-	return 0;
+	for (disk =3D 0; disk < conf->raid_disks; disk++) {
+		struct multipath_info *mpi =3D &conf->multipaths[disk];
+
+		if (!mpi->operational)
+			continue;
+
+		if (first) {
+			best_so_far =3D disk;
+
+#if 1
+			/*
+			 * WRITEs, choose first operational path always
+			 */
+			if (rw =3D=3D WRITE)
+				break;
+#endif
+
+			nr_pending =3D atomic_read(&mpi->nr_pending_buffers);
+		}
+
+		/*
+		 * check for possible front- or back merge
+		 */
+		if (rw =3D=3D mpi->last_rw) {
+		=09
+			if (bh->b_rsector =3D=3D mpi->last_end_sector
+			    || bh->b_rsector + (bh->b_size >> 9) =3D=3D mpi->last_start_sector)=
 {
+				best_so_far =3D disk;
+				break;
+			}
+		}
+
+		/*
+		 * don't check pending for first disk, already did
+		 */
+		if (first) {
+			first =3D 0;
+			continue;
+		}
+
+		/*
+		 * just a ball park number, good enough for balancing
+		 */
+		tmp =3D atomic_read(&mpi->nr_pending_buffers);
+		if (tmp < nr_pending) {
+			nr_pending =3D tmp;
+			best_so_far =3D disk;
+		}
+	}
+
+	return best_so_far;
 }
=20
 static int multipath_make_request (mddev_t *mddev, int rw,
@@ -245,6 +297,7 @@
 	struct buffer_head *bh_req;
 	struct multipath_bh * mp_bh;
 	struct multipath_info *multipath;
+	int ret;
=20
 	if (!buffer_locked(bh))
 		BUG();
@@ -265,16 +318,28 @@
 	mp_bh->cmd =3D rw;
=20
 	/*
-	 * read balancing logic:
+	 * read/write balancing logic:
 	 */
-	multipath =3D conf->multipaths + multipath_read_balance(conf);
+	if ((ret =3D multipath_rw_balance(conf, rw, bh)) =3D=3D -1) {
+		print_multipath_conf(conf);
+		MD_BUG();
+		buffer_IO_error(bh);
+		return 0;
+	}
+
+	multipath =3D conf->multipaths + ret;
+
+	multipath->last_end_sector =3D bh->b_rsector + (bh->b_size >> 9);
+	multipath->last_start_sector =3D bh->b_rsector;
+	multipath->last_rw =3D rw;
+
+	atomic_inc(&multipath->nr_pending_buffers);
+	mp_bh->multipath =3D multipath;
=20
 	bh_req =3D &mp_bh->bh_req;
 	memcpy(bh_req, bh, sizeof(*bh));
-	bh_req->b_blocknr =3D bh->b_rsector;
 	bh_req->b_dev =3D multipath->dev;
 	bh_req->b_rdev =3D multipath->dev;
-/*	bh_req->b_rsector =3D bh->n_rsector; */
 	bh_req->b_end_io =3D multipath_end_request;
 	bh_req->b_private =3D mp_bh;
 	generic_make_request (rw, bh_req);
@@ -305,24 +370,123 @@
 "multipath: IO failure on %s, disabling IO path. \n" \
 "	Operation continuing on %d IO paths.\n"
=20
+static inline void clear_disk_faulty(mdp_disk_t *d)
+{
+	d->state &=3D ~(1 << MD_DISK_FAULTY);
+}
+
+static void verify_positions(mddev_t *mddev, const char *string)
+{
+	mdp_super_t *sb =3D mddev->sb;
+	mdp_disk_t *desc;
+	int i;
+
+	printk("verify_positions: %s\n", string);
+=09
+	for (i =3D 0; i < sb->raid_disks; i++) {
+		desc =3D &sb->disks[i];
+		if (desc->number !=3D i)
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
+	disk =3D conf->multipaths + desc->raid_disk;
+	disk2 =3D conf->multipaths + desc2->raid_disk;
+
+	xchg_values(*desc2,*desc);
+	xchg_values(*disk2,*disk);
+	xchg_values(desc2->number, desc->number);
+	xchg_values(disk2->number, disk->number);
+	xchg_values(desc2->raid_disk, desc->raid_disk);
+	xchg_values(disk2->raid_disk, disk->raid_disk);
+
+	rdev1 =3D find_rdev_nr(conf->mddev, desc->raid_disk);
+	rdev2 =3D find_rdev_nr(conf->mddev, desc2->raid_disk);
+
+	if (rdev1 && rdev2)
+		xchg_values(rdev1->desc_nr, rdev2->desc_nr);
+=09
+	verify_positions(conf->mddev, "switch_pos_end");
+}
+
+static void mark_disk_good (mddev_t *mddev, int disk)
+{
+	multipath_conf_t *conf =3D mddev_to_conf(mddev);
+	struct multipath_info *multipath =3D conf->multipaths + disk;
+	mdp_super_t *sb =3D mddev->sb;
+	mdk_rdev_t *rdev;
+
+	rdev =3D find_rdev_nr(mddev, disk);
+	rdev->faulty =3D 0;
+
+	multipath->spare =3D 1;
+	if (!disk_faulty(sb->disks+multipath->number)) {
+		printk("mark_disk_good: disk %d already good\n",disk);
+		return;
+	}
+=09
+	clear_disk_faulty(sb->disks+multipath->number);
+	sb->failed_disks--;
+
+	sb->working_disks++;
+	sb->spare_disks++;
+	mddev->sb_dirty =3D 1;
+	md_wakeup_thread(conf->thread);
+	conf->working_disks++;
+=09
+}
+
 static void mark_disk_bad (mddev_t *mddev, int failed)
 {
 	multipath_conf_t *conf =3D mddev_to_conf(mddev);
 	struct multipath_info *multipath =3D conf->multipaths+failed;
 	mdp_super_t *sb =3D mddev->sb;
+	int last_drive =3D conf->working_disks - 1;
+
+	printk("md: mark_disk_bad: disk %d\n", failed);
=20
 	multipath->operational =3D 0;
+	if (disk_faulty(sb->disks+multipath->number)) {
+		printk("md: Disk already marked bad. Doing nothing!\n");
+		return;	=09
+	}
+=09
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
 	mddev->sb_dirty =3D 1;
-	md_wakeup_thread(conf->thread);
-	conf->working_disks--;
+
 	printk (DISK_FAILED, partition_name (multipath->dev),
 				 conf->working_disks);
+=09
+	/*
+	 * switch the faulty drive with the last one, so the working ones
+	 * are always at the front of the array
+	 */
+	if (failed !=3D last_drive)
+		multipath_switch_pos(conf, &sb->disks[failed], &sb->disks[last_drive]);
+
+	md_wakeup_thread(conf->thread);
 }
=20
 /*
@@ -334,6 +498,7 @@
 	struct multipath_info * multipaths =3D conf->multipaths;
 	int disks =3D MD_SB_DISKS;
 	int other_paths =3D 1;
+	mdk_rdev_t *rrdev;
 	int i;
=20
 	if (conf->working_disks =3D=3D 1) {
@@ -354,7 +519,7 @@
 		 */
 		for (i =3D 0; i < disks; i++) {
 			if (multipaths[i].dev=3D=3Ddev && !multipaths[i].operational)
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
-			int err =3D 1;
+		rrdev =3D find_rdev(mddev, dev);
+		if (rrdev)
+			rrdev->faulty =3D 1;
+	=09
+		if (conf->working_disks > 0) {
 			mdp_disk_t *spare;
-			mdp_super_t *sb =3D mddev->sb;
-
+=09
 			spare =3D get_spare(mddev);
 			if (spare) {
-				err =3D multipath_diskop(mddev, &spare, DISKOP_SPARE_WRITE);
-				printk("got DISKOP_SPARE_WRITE err: %d. (spare_faulty(): %d)\n", err, =
disk_faulty(spare));
-			}
-			if (!err && !disk_faulty(spare)) {
-				multipath_diskop(mddev, &spare, DISKOP_SPARE_ACTIVE);
-				mark_disk_sync(spare);
-				mark_disk_active(spare);
-				sb->active_disks++;
-				sb->spare_disks--;
+				if (!disk_faulty(spare)) {
+					multipath_diskop(mddev,=20
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
=20
 #undef LAST_DISK
 #undef NO_SPARE_DISK
 #undef DISK_FAILED
=20
-
 static void print_multipath_conf (multipath_conf_t *conf)
 {
 	int i;
@@ -426,59 +596,82 @@
 	struct multipath_info *tmp, *sdisk, *fdisk, *rdisk, *adisk;
 	mdp_super_t *sb =3D mddev->sb;
 	mdp_disk_t *failed_desc, *spare_desc, *added_desc;
-	mdk_rdev_t *spare_rdev, *failed_rdev;
=20
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
+		for (i =3D 0; i < conf->nr_disks; i++) {
+			tmp =3D conf->multipaths + i;
+			if (tmp->spare && tmp->number =3D=3D (*d)->number) {
+				spare_disk =3D i;
+				break;
+			}
+		}
+		if (spare_disk =3D=3D -1) {
+			err =3D -EBUSY;
+			goto abort;
+		}
+
+		failed_disk =3D conf->working_disks;
+		break;
+
+	case DISKOP_DISABLE_PATH:
+
+		if (conf->raid_disks =3D=3D 1) {
+			printk("multipath: can't disable last path\n");
+			err =3D -EBUSY;
+			goto abort;
+		}
=20
-		/*
-		 * Find the failed disk within the MULTIPATH configuration ...
-		 * (this can only be in the first conf->working_disks part)
-		 */
 		for (i =3D 0; i < conf->raid_disks; i++) {
 			tmp =3D conf->multipaths + i;
-			if ((!tmp->operational && !tmp->spare) ||
-					!tmp->used_slot) {
-				failed_disk =3D i;
+			if (tmp->operational && tmp->number =3D=3D (*d)->number) {
+				removed_disk =3D i;
 				break;
 			}
 		}
-		/*
-		 * When we activate a spare disk we _must_ have a disk in
-		 * the lower (active) part of the array to replace.=20
-		 */
-		if ((failed_disk =3D=3D -1) || (failed_disk >=3D conf->raid_disks)) {
-			MD_BUG();
-			err =3D 1;
+
+		if (removed_disk =3D=3D -1) {
+			err =3D -EINVAL;
 			goto abort;
 		}
-		/* fall through */
=20
-	case DISKOP_SPARE_WRITE:
-	case DISKOP_SPARE_INACTIVE:
+		failed_disk =3D conf->raid_disks - 1;
+		break;
=20
+	case DISKOP_CLEAN_PATH:
 		/*
-		 * Find the spare disk ... (can only be in the 'high'
-		 * area of the array)
+		 * find faulty drive
 		 */
-		for (i =3D conf->raid_disks; i < MD_SB_DISKS; i++) {
+		for (i =3D 0; i < conf->nr_disks; i++) {
 			tmp =3D conf->multipaths + i;
-			if (tmp->spare && tmp->number =3D=3D (*d)->number) {
-				spare_disk =3D i;
+			if (!tmp->operational && !tmp->spare
+			    && tmp->number =3D=3D (*d)->number) {
+				failed_disk =3D i;
 				break;
 			}
 		}
-		if (spare_disk =3D=3D -1) {
-			MD_BUG();
-			err =3D 1;
+
+		if (failed_disk =3D=3D -1) {
+			err =3D -EINVAL;
 			goto abort;
 		}
+
+		spare_disk =3D conf->working_disks;
 		break;
=20
 	case DISKOP_HOT_REMOVE_DISK:
@@ -520,31 +713,60 @@
 	}
=20
 	switch (state) {
-	/*
-	 * Switch the spare disk to write-only mode:
-	 */
-	case DISKOP_SPARE_WRITE:
-		sdisk =3D conf->multipaths + spare_disk;
-		sdisk->operational =3D 1;
+	case DISKOP_HOT_REMOVE_DISK:
+		rdisk =3D conf->multipaths + removed_disk;
+
+		if (rdisk->spare && (removed_disk < conf->raid_disks)) {
+			MD_BUG();=09
+			err =3D 1;
+			goto abort;
+		}
+		rdisk->dev =3D MKDEV(0,0);
+		rdisk->used_slot =3D 0;
+		rdisk->number =3D 0;
+		mddev->sb_dirty =3D 1;
+		md_wakeup_thread(conf->thread);
+		conf->nr_disks--;
 		break;
-	/*
-	 * Deactivate a spare disk:
-	 */
-	case DISKOP_SPARE_INACTIVE:
-		sdisk =3D conf->multipaths + spare_disk;
-		sdisk->operational =3D 0;
+	case DISKOP_HOT_ADD_DISK:
+		adisk =3D conf->multipaths + added_disk;
+		added_desc =3D *d;
+
+		if (added_disk !=3D added_desc->number) {
+			printk("DISKOP_HOT_ADD_DISK: we want slot %d !=3D md wants %d\n",
+					added_disk, added_desc->number);
+			err =3D 1;
+			goto abort;
+		}
+
+		adisk->number =3D added_desc->number;
+		adisk->raid_disk =3D added_desc->raid_disk;
+		adisk->dev =3D MKDEV(added_desc->major,added_desc->minor);
+
+		adisk->operational =3D 0;
+		adisk->spare =3D 1;
+		adisk->used_slot =3D 1;
+		conf->nr_disks++;
+		/* Believing it to be good until proven otherwise ;-) */
+		conf->working_disks++;
+
+		mddev->sb_dirty =3D 1;
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
 		sdisk =3D conf->multipaths + spare_disk;
 		fdisk =3D conf->multipaths + failed_disk;
=20
+		printk("md: activate: %s\n",
+				partition_name(sdisk->dev));
+
+		if (!sdisk->spare) {
+			printk("md: activate: not spare\n");
+			goto abort;
+		}
+
 		spare_desc =3D &sb->disks[sdisk->number];
 		failed_desc =3D &sb->disks[fdisk->number];
=20
@@ -572,90 +794,117 @@
 			goto abort;
 		}
=20
+#if 0
 		if (fdisk->raid_disk !=3D failed_disk) {
 			MD_BUG();
 			err =3D 1;
 			goto abort;
 		}
+#endif
+
+		sdisk->spare =3D 0;
+		sdisk->operational =3D 1;
=20
 		/*
 		 * do the switch finally
 		 */
-		spare_rdev =3D find_rdev_nr(mddev, spare_desc->number);
-		failed_rdev =3D find_rdev_nr(mddev, failed_desc->number);
-		xchg_values(spare_rdev->desc_nr, failed_rdev->desc_nr);
-		spare_rdev->alias_device =3D 0;
-		failed_rdev->alias_device =3D 1;
-
-		xchg_values(*spare_desc, *failed_desc);
-		xchg_values(*fdisk, *sdisk);
+		if (failed_disk < spare_disk) {
+			multipath_switch_pos(conf, spare_desc, failed_desc);
=20
-		/*
-		 * (careful, 'failed' and 'spare' are switched from now on)
-		 *
-		 * we want to preserve linear numbering and we want to
-		 * give the proper raid_disk number to the now activated
-		 * disk. (this means we switch back these values)
-		 */
-=09
-		xchg_values(spare_desc->raid_disk, failed_desc->raid_disk);
-		xchg_values(sdisk->raid_disk, fdisk->raid_disk);
-		xchg_values(spare_desc->number, failed_desc->number);
-		xchg_values(sdisk->number, fdisk->number);
+			*d =3D failed_desc;
=20
-		*d =3D failed_desc;
+			if (sdisk->dev =3D=3D MKDEV(0,0))
+				MD_BUG();
+		}
=20
-		if (sdisk->dev =3D=3D MKDEV(0,0))
-			sdisk->used_slot =3D 0;
 		/*
 		 * this really activates the spare.
 		 */
-		fdisk->spare =3D 0;
+		mark_disk_active(*d);
+		conf->raid_disks++;
+		sb->raid_disks++;
+		sb->active_disks++;
+		mddev->sb->spare_disks--;
+		mddev->sb_dirty =3D 1;
+		md_wakeup_thread(conf->thread);
+		break;
+
+	case DISKOP_DISABLE_PATH:
+		sdisk =3D conf->multipaths + removed_disk;
+		fdisk =3D conf->multipaths + failed_disk;
+
+		printk("md: deactivate: %s\n",
+				partition_name(sdisk->dev));
+
+		spare_desc =3D &sb->disks[sdisk->number];
+		failed_desc =3D &sb->disks[fdisk->number];
+
+		if (spare_desc !=3D *d) {
+			printk("diskop_disable_path: we want %s (%d), md said %s (%d)\n",
+					partition_name(MKDEV(spare_desc->major,spare_desc->minor)),
+					removed_disk,
+					partition_name(MKDEV((*d)->major,(*d)->minor)),
+					(*d)->number);
+			MD_BUG();
+			err =3D 1;
+			goto abort;
+		}
=20
 		/*
-		 * if we activate a spare, we definitely replace a
-		 * non-operational disk slot in the 'low' area of
-		 * the disk array.
+		 * do the switch finally
 		 */
+		if (removed_disk !=3D failed_disk) {
+			multipath_switch_pos(conf, spare_desc, failed_desc);
=20
-		conf->working_disks++;
+			*d =3D failed_desc;
+
+			if (sdisk->dev =3D=3D MKDEV(0,0))
+				MD_BUG();
+		}
=20
+		mark_disk_spare(*d);
+		mark_disk_inactive(*d);
+		fdisk->spare =3D 1;
+		fdisk->operational =3D 0;
+		conf->raid_disks--;
+		sb->raid_disks--;
+		sb->active_disks--;
+		mddev->sb->spare_disks++;
+		mddev->sb_dirty =3D 1;
+		md_wakeup_thread(conf->thread);
 		break;
=20
-	case DISKOP_HOT_REMOVE_DISK:
-		rdisk =3D conf->multipaths + removed_disk;
+	case DISKOP_CLEAN_PATH:
+		fdisk =3D conf->multipaths + failed_disk;
=20
-		if (rdisk->spare && (removed_disk < conf->raid_disks)) {
-			MD_BUG();=09
+		failed_desc =3D &sb->disks[fdisk->number];
+
+		if (failed_desc->raid_disk !=3D fdisk->raid_disk) {
+			MD_BUG();
 			err =3D 1;
 			goto abort;
 		}
-		rdisk->dev =3D MKDEV(0,0);
-		rdisk->used_slot =3D 0;
-		conf->nr_disks--;
-		break;
-
-	case DISKOP_HOT_ADD_DISK:
-		adisk =3D conf->multipaths + added_disk;
-		added_desc =3D *d;
=20
-		if (added_disk !=3D added_desc->number) {
-			MD_BUG();=09
+		if (fdisk->raid_disk !=3D failed_disk) {
+			MD_BUG();
 			err =3D 1;
 			goto abort;
 		}
=20
-		adisk->number =3D added_desc->number;
-		adisk->raid_disk =3D added_desc->raid_disk;
-		adisk->dev =3D MKDEV(added_desc->major,added_desc->minor);
+		/*
+		 * this really activates the spare.
+		 */
+		fdisk->spare =3D 0;
+		mark_disk_good(mddev, failed_disk);
=20
-		adisk->operational =3D 0;
-		adisk->spare =3D 1;
-		adisk->used_slot =3D 1;
-		conf->nr_disks++;
+		if (failed_disk !=3D spare_disk) {
+			spare_desc =3D &sb->disks[spare_disk];
+			multipath_switch_pos(conf, failed_desc, spare_desc);
+		}
=20
 		break;
=20
+
 	default:
 		MD_BUG();=09
 		err =3D 1;
@@ -833,7 +1082,7 @@
 	mdp_disk_t *desc, *desc2;
 	mdk_rdev_t *rdev, *def_rdev =3D NULL;
 	struct md_list_head *tmp;
-	int num_rdevs =3D 0;
+	int num_rdevs =3D 0, nr_spares =3D 0;
=20
 	MOD_INC_USE_COUNT;
=20
@@ -854,6 +1103,7 @@
 		goto out;
 	}
 	memset(conf, 0, sizeof(*conf));
+	conf->mddev =3D mddev;
=20
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		if (rdev->faulty) {
@@ -878,9 +1128,6 @@
 		disk_idx =3D desc->raid_disk;
 		disk =3D conf->multipaths + disk_idx;
=20
-		if (!disk_sync(desc))
-			printk(NOT_IN_SYNC, partition_name(rdev->dev));
-
 		/*
 		 * Mark all disks as spare to start with, then pick our
 		 * active disk.  If we have a disk that is marked active
@@ -892,24 +1139,34 @@
 		disk->operational =3D 0;
 		disk->spare =3D 1;
 		disk->used_slot =3D 1;
-		mark_disk_sync(desc);
=20
+		/*
+		 * bring paths online and spare. online paths will be
+		 * read balanced automatically
+		 */
 		if (disk_active(desc)) {
-			if(!conf->working_disks) {
-				printk(OPERATIONAL, partition_name(rdev->dev),
- 					desc->raid_disk);
-				disk->operational =3D 1;
-				disk->spare =3D 0;
-				conf->working_disks++;
+			printk(OPERATIONAL, partition_name(rdev->dev), desc->raid_disk);
+			disk->operational =3D 1;
+			disk->spare =3D 0;
+
+			if (!conf->working_disks++)
 				def_rdev =3D rdev;
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
=20
-		if(!num_rdevs++) def_rdev =3D rdev;
+		if (!num_rdevs++)
+			def_rdev =3D rdev;
 	}
+
+	/* Make the first path active if no active path was found before */
 	if(!conf->working_disks && num_rdevs) {
 		desc =3D &sb->disks[def_rdev->desc_nr];
 		disk =3D conf->multipaths + desc->raid_disk;
@@ -917,16 +1174,18 @@
 			disk->raid_disk);
 		disk->operational =3D 1;
 		disk->spare =3D 0;
+		nr_spares--;
 		conf->working_disks++;
+		conf->raid_disks++;
 		mark_disk_active(desc);
 	}
 	/*
 	 * Make sure our active path is in desc spot 0
 	 */
-	if(def_rdev->desc_nr !=3D 0) {
-		rdev =3D find_rdev_nr(mddev, 0);
+	if (def_rdev && def_rdev->desc_nr !=3D 0) {
 		desc =3D &sb->disks[def_rdev->desc_nr];
 		desc2 =3D sb->disks;
+
 		disk =3D conf->multipaths + desc->raid_disk;
 		disk2 =3D conf->multipaths + desc2->raid_disk;
 		xchg_values(*desc2,*desc);
@@ -935,18 +1194,20 @@
 		xchg_values(disk2->number, disk->number);
 		xchg_values(desc2->raid_disk, desc->raid_disk);
 		xchg_values(disk2->raid_disk, disk->raid_disk);
+
+		rdev =3D find_rdev_nr(mddev, 0);
 		if(rdev) {
 			xchg_values(def_rdev->desc_nr,rdev->desc_nr);
 		} else {
 			def_rdev->desc_nr =3D 0;
 		}
 	}
-	conf->raid_disks =3D sb->raid_disks =3D sb->active_disks =3D 1;
 	conf->nr_disks =3D sb->nr_disks =3D sb->working_disks =3D num_rdevs;
 	sb->failed_disks =3D 0;
-	sb->spare_disks =3D num_rdevs - 1;
+	sb->spare_disks =3D nr_spares;
+	sb->active_disks =3D num_rdevs - nr_spares;
+	sb->raid_disks =3D sb->active_disks;
 	mddev->sb_dirty =3D 1;
-	conf->mddev =3D mddev;
 	conf->device_lock =3D MD_SPIN_LOCK_UNLOCKED;
=20
 	init_waitqueue_head(&conf->wait_buffer);
@@ -997,11 +1258,8 @@
 	 * each device.
 	 */
 	for (i =3D 0; i < MD_SB_DISKS; i++) {
-		mark_disk_nonsync(sb->disks+i);
-		for (j =3D 0; j < sb->raid_disks; j++) {
-			if (sb->disks[i].number =3D=3D conf->multipaths[j].number)
-				mark_disk_sync(sb->disks+i);
-		}
+		for (j =3D 0; j < sb->raid_disks; j++)
+			atomic_set(&conf->multipaths[j].nr_pending_buffers, 0);
 	}
=20
 	printk(ARRAY_IS_ACTIVE, mdidx(mddev), sb->active_disks,
diff -ur linux.orig/include/linux/raid/md_k.h linux/include/linux/raid/md_k=
.h
--- linux.orig/include/linux/raid/md_k.h	Mon Nov 26 14:29:17 2001
+++ linux/include/linux/raid/md_k.h	Thu Sep 12 14:27:18 2002
@@ -173,12 +173,16 @@
 	mdp_super_t *sb;
 	unsigned long sb_offset;
=20
-	int alias_device;		/* device alias to the same disk */
 	int faulty;			/* if faulty do not issue IO requests */
 	int desc_nr;			/* descriptor index in the superblock */
 };
=20
=20
+static inline int rdev_is_alias(mdk_rdev_t * rdev)
+{
+	return ((rdev->sb->level =3D=3D -4) && (rdev->desc_nr !=3D 0));
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
=20
 typedef struct mdk_personality_s mdk_personality_t;
=20
diff -ur linux.orig/include/linux/raid/md_u.h linux/include/linux/raid/md_u=
.h
--- linux.orig/include/linux/raid/md_u.h	Fri Sep 14 23:21:51 2001
+++ linux/include/linux/raid/md_u.h	Thu Sep 12 14:27:18 2002
@@ -44,6 +44,11 @@
 #define STOP_ARRAY_RO		_IO (MD_MAJOR, 0x33)
 #define RESTART_ARRAY_RW	_IO (MD_MAJOR, 0x34)
=20
+/* multi-path extensions */
+#define SET_DISK_CLEAN		_IO (MD_MAJOR, 0x35)
+#define SET_DISK_ACTIVE		_IO (MD_MAJOR, 0x36)
+#define SET_DISK_INACTIVE	_IO (MD_MAJOR, 0x37)
+
 typedef struct mdu_version_s {
 	int major;
 	int minor;
diff -ur linux.orig/include/linux/raid/multipath.h linux/include/linux/raid=
/multipath.h
--- linux.orig/include/linux/raid/multipath.h	Wed Sep 11 07:40:45 2002
+++ linux/include/linux/raid/multipath.h	Thu Sep 12 14:29:10 2002
@@ -15,6 +15,11 @@
 	int		spare;
=20
 	int		used_slot;
+
+	atomic_t	nr_pending_buffers;
+	unsigned long	last_start_sector;
+	unsigned long	last_end_sector;
+	int		last_rw;
 };
=20
 struct multipath_private_data {
@@ -63,6 +68,7 @@
 	struct buffer_head	*master_bh;
 	struct buffer_head	bh_req;
 	struct multipath_bh	*next_mp; /* next for retry or in free list */
+	struct multipath_info *multipath;
 };
 /* bits for multipath_bh.state */
 #define	MPBH_Uptodate	1

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Description: mdadm 64bit fix
Content-Disposition: attachment; filename="mdadm-64bit.patch"
Content-Transfer-Encoding: quoted-printable

--- mdadm-1.0.1.orig/Create.c	Mon Sep 30 15:01:34 2002
+++ mdadm-1.0.1.lmb/Create.c	Tue Oct  1 20:48:54 2002
@@ -52,7 +52,7 @@
 	 * if runstop=3D=3Drun, or raiddisks diskswere used,
 	 * RUN_ARRAY
 	 */
-	int minsize=3D0, maxsize=3D0;
+	unsigned long minsize=3D0, maxsize=3D0;
 	char *mindisc =3D NULL;
 	char *maxdisc =3D NULL;
 	int dnum;
@@ -127,7 +127,7 @@
 	dnum =3D 0;
 	for (dv=3Ddevlist; dv; dv=3Ddv->next, dnum++) {
 		char *dname =3D dv->devname;
-		int dsize, freesize;
+		unsigned long dsize, freesize;
 		int fd;
 		if (strcasecmp(dname, "missing")=3D=3D0) {
 			if (first_missing > dnum)
@@ -153,7 +153,7 @@
 			continue;
 		}
 		if (dsize < MD_RESERVED_SECTORS*2) {
-			fprintf(stderr, Name ": %s is too small: %dK\n",
+			fprintf(stderr, Name ": %s is too small: %ldK\n",
 				dname, dsize/2);
 			fail =3D 1;
 			close(fd);
@@ -164,7 +164,7 @@
=20
 		if (size && freesize < size) {
 			fprintf(stderr, Name ": %s is smaller that given size."
-				" %dK < %dK + superblock\n", dname, freesize, size);
+				" %ldK < %dK + superblock\n", dname, freesize, size);
 			fail =3D 1;
 			close(fd);
 			continue;

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mdadm-multipath.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur mdadm-1.0.1.orig/Assemble.c mdadm-1.0.1.lmb/Assemble.c
--- mdadm-1.0.1.orig/Assemble.c	Thu Mar 28 02:23:24 2002
+++ mdadm-1.0.1.lmb/Assemble.c	Wed Aug 21 23:52:40 2002
@@ -250,9 +250,6 @@
 			    devname);
 		    continue;
 		}
-		if (verbose)
-			fprintf(stderr, Name ": %s is identified as a member of %s, slot %d.\n",
-				devname, mddev, super.this_disk.raid_disk);
 		devices[devcnt].devname =3D devname;
 		devices[devcnt].major =3D MAJOR(stb.st_rdev);
 		devices[devcnt].minor =3D MINOR(stb.st_rdev);
@@ -260,7 +257,19 @@
 		devices[devcnt].oldminor =3D super.this_disk.minor;
 		devices[devcnt].events =3D md_event(&super);
 		devices[devcnt].utime =3D super.utime;
-		devices[devcnt].raid_disk =3D super.this_disk.raid_disk;
+
+		if (super.level =3D=3D -4) {
+			/* Workaround: In a multipath setup, all superblocks
+			 * are identical (obviously); so they would all be
+			 * assigned the same slot. */
+			devices[devcnt].raid_disk =3D devcnt;=09
+		} else {
+			devices[devcnt].raid_disk =3D super.this_disk.raid_disk;
+		}
+		if (verbose)
+			fprintf(stderr, Name ": %s is identified as a member of %s, slot %d.\n",
+				devname, mddev, devices[devcnt].raid_disk);
+
 		devices[devcnt].uptodate =3D 0;
 		if (most_recent < devcnt) {
 			if (devices[devcnt].events
diff -ur mdadm-1.0.1.orig/Manage.c mdadm-1.0.1.lmb/Manage.c
--- mdadm-1.0.1.orig/Manage.c	Mon Apr  8 01:48:36 2002
+++ mdadm-1.0.1.lmb/Manage.c	Wed Aug  7 10:23:48 2002
@@ -218,6 +218,39 @@
 			fprintf(stderr, Name ": set %s faulty in %s\n",
 				dv->devname, devname);
 			break;
+	=09
+		case 'c': /* set clean */
+			/* FIXME check current member */
+			if (ioctl(fd, SET_DISK_CLEAN, (unsigned long) stb.st_rdev)) {
+				fprintf(stderr, Name ": set device clean failed for %s:  %s\n",
+					dv->devname, strerror(errno));
+				return 1;
+			}
+			fprintf(stderr, Name ": set %s clean in %s\n",
+				dv->devname, devname);
+			break;
+
+		case 'A': /* activate path */
+			/* FIXME check current member */
+			if (ioctl(fd, SET_DISK_ACTIVE, (unsigned long) stb.st_rdev)) {
+				fprintf(stderr, Name ": set device active failed for %s:  %s\n",
+					dv->devname, strerror(errno));
+				return 1;
+			}
+			fprintf(stderr, Name ": set %s active in %s\n",
+				dv->devname, devname);
+			break;
+
+		case 'I': /* deactivate path */
+			/* FIXME check current member */
+			if (ioctl(fd, SET_DISK_INACTIVE, (unsigned long) stb.st_rdev)) {
+				fprintf(stderr, Name ": set device inactive failed for %s:  %s\n",
+					dv->devname, strerror(errno));
+				return 1;
+			}
+			fprintf(stderr, Name ": set %s inactive in %s\n",
+				dv->devname, devname);
+			break;
 		}
 	}
 	return 0;
diff -ur mdadm-1.0.1.orig/ReadMe.c mdadm-1.0.1.lmb/ReadMe.c
--- mdadm-1.0.1.orig/ReadMe.c	Mon May 20 13:15:30 2002
+++ mdadm-1.0.1.lmb/ReadMe.c	Wed Aug  7 10:52:58 2002
@@ -135,6 +135,9 @@
     {"stop",      0, 0, 'S'},
     {"readonly",  0, 0, 'o'},
     {"readwrite", 0, 0, 'w'},
+    {"clean",     0, 0, 24},
+    {"active",    0, 0, 25},
+    {"inactive",  0, 0, 26},
=20
     /* For Detail/Examine */
     {"brief",	  0, 0, 'b'},
@@ -349,12 +352,16 @@
 "Options that are valid with management mode are:\n"
 "  --add         -a   : hotadd subsequent devices to the array\n"
 "  --remove      -r   : remove subsequent devices, which must not be activ=
e\n"
-"  --fail        -f   : mark subsequent devices a faulty\n"
+"  --fail        -f   : mark subsequent devices as faulty\n"
 "  --set-faulty       : same as --fail\n"
 "  --run         -R   : start a partially built array\n"
 "  --stop        -S   : deactive array, releasing all resources\n"
 "  --readonly    -o   : mark array as readonly\n"
 "  --readwrite   -w   : mark array as readwrite\n"
+"For multipath:\n"
+"  --clean       -c   : mark subsequent devices as clean\n"
+"  --active           : mark subsequent devices as active\n"
+"  --inactive         : mark subsequent devices as inactive\n"
 ;
=20
 char Help_misc[] =3D
diff -ur mdadm-1.0.1.orig/md_u.h mdadm-1.0.1.lmb/md_u.h
--- mdadm-1.0.1.orig/md_u.h	Fri Jun  1 07:45:50 2001
+++ mdadm-1.0.1.lmb/md_u.h	Wed Aug  7 10:25:30 2002
@@ -43,6 +43,11 @@
 #define STOP_ARRAY_RO		_IO (MD_MAJOR, 0x33)
 #define RESTART_ARRAY_RW	_IO (MD_MAJOR, 0x34)
=20
+/* multi-path extensions */
+#define SET_DISK_CLEAN		_IO (MD_MAJOR, 0x35)
+#define SET_DISK_ACTIVE		_IO (MD_MAJOR, 0x36)
+#define SET_DISK_INACTIVE	_IO (MD_MAJOR, 0x37)
+
 typedef struct mdu_version_s {
 	int major;
 	int minor;
diff -ur mdadm-1.0.1.orig/mdadm.8 mdadm-1.0.1.lmb/mdadm.8
--- mdadm-1.0.1.orig/mdadm.8	Mon May 20 12:39:40 2002
+++ mdadm-1.0.1.lmb/mdadm.8	Wed Aug  7 10:52:38 2002
@@ -275,12 +275,20 @@
 be failed or spare devices.
=20
 .TP
-.BR -f ", " --fail
+.BR -f ", " --fail ", " --set-faulty
 mark listed devices as faulty.
=20
 .TP
-.BR --set-faulty
-same as --fail.
+.BR --clean
+mark listed devices as clean. (Only supported by multipath)
+
+.TP
+.BR --active
+mark listed devices as active. (Only supported by multipath)
+
+.TP
+.BR --inactive
+mark listed devices as inactive. (Only supported by multipath)
=20
 .SH For Misc mode:
=20
diff -ur mdadm-1.0.1.orig/mdadm.c mdadm-1.0.1.lmb/mdadm.c
--- mdadm-1.0.1.orig/mdadm.c	Mon May 20 13:14:58 2002
+++ mdadm-1.0.1.lmb/mdadm.c	Wed Aug 14 12:39:43 2002
@@ -262,7 +262,8 @@
 					optarg);
 				exit(2);
 			}
-			if (level !=3D 0 && level !=3D -1 && mode =3D=3D BUILD) {
+			if (level !=3D 0 && level !=3D -1 && level !=3D -4
+					&& mode =3D=3D BUILD) {
 				fprintf(stderr, Name ": Raid level %s not permitted with --build.\n",
 					optarg);
 				exit(2);
@@ -432,6 +433,16 @@
 		case O(MANAGE,'f'): /* set faulty */
 			devmode =3D 'f';
 			continue;
+		case O(MANAGE,24): /* set clean */
+			devmode =3D 'c';
+			continue;
+		case O(MANAGE,25): /* set active */
+			devmode =3D 'A';
+			continue;
+		case O(MANAGE,26): /* set inactive */
+			devmode =3D 'I';
+			continue;
+
 		case O(MANAGE,'R'):
 		case O(ASSEMBLE,'R'):
 		case O(BUILD,'R'):

--7JfCtLOvnd9MIVvH--

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEUEARECAAYFAj2ayl0ACgkQudf3XQV4S2ebVwCY5vJWGUa7A24RtXUXd3a80iML
tACcCq07cjHM1ApZfMlSipwRO0ou/E8=
=bt89
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
