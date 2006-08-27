Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWH0XtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWH0XtV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWH0XtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:49:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:9618 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932118AbWH0XtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:49:19 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 28 Aug 2006 09:49:17 +1000
Message-Id: <1060827234917.32466@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 4] md: Fix issues with referencing rdev in md/raid1
References: <20060828092849.21292.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We need to be careful when referencing mirrors[i].rdev.  so it can
disappear under us at various times.

So:
  fix a couple of problem places.
  comment a couple of non-problem places
  move an 'atomic_add' which deferences rdev down a little
    way to some where where it is sure to not be NULL.


Signed-off-by: Neil Brown <neilb@suse.de>
---

Index: mm-quilt/drivers/md/raid1.c
===================================================================
--- mm-quilt.orig/drivers/md/raid1.c	2006-08-28 08:57:30.000000000 +1000
+++ mm-quilt/drivers/md/raid1.c	2006-08-28 09:06:32.000000000 +1000
@@ -930,10 +930,13 @@ static void status(struct seq_file *seq,
 
 	seq_printf(seq, " [%d/%d] [", conf->raid_disks,
 						conf->working_disks);
-	for (i = 0; i < conf->raid_disks; i++)
+	rcu_read_lock();
+	for (i = 0; i < conf->raid_disks; i++) {
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
 		seq_printf(seq, "%s",
-			      conf->mirrors[i].rdev &&
-			      test_bit(In_sync, &conf->mirrors[i].rdev->flags) ? "U" : "_");
+			   rdev && test_bit(In_sync, &rdev->flags) ? "U" : "_");
+	}
+	rcu_read_unlock();
 	seq_printf(seq, "]");
 }
 
@@ -975,7 +978,6 @@ static void error(mddev_t *mddev, mdk_rd
 static void print_conf(conf_t *conf)
 {
 	int i;
-	mirror_info_t *tmp;
 
 	printk("RAID1 conf printout:\n");
 	if (!conf) {
@@ -985,14 +987,17 @@ static void print_conf(conf_t *conf)
 	printk(" --- wd:%d rd:%d\n", conf->working_disks,
 		conf->raid_disks);
 
+	rcu_read_lock();
 	for (i = 0; i < conf->raid_disks; i++) {
 		char b[BDEVNAME_SIZE];
-		tmp = conf->mirrors + i;
-		if (tmp->rdev)
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
+		if (rdev)
 			printk(" disk %d, wo:%d, o:%d, dev:%s\n",
-				i, !test_bit(In_sync, &tmp->rdev->flags), !test_bit(Faulty, &tmp->rdev->flags),
-				bdevname(tmp->rdev->bdev,b));
+			       i, !test_bit(In_sync, &rdev->flags),
+			       !test_bit(Faulty, &rdev->flags),
+			       bdevname(rdev->bdev,b));
 	}
+	rcu_read_unlock();
 }
 
 static void close_sync(conf_t *conf)
@@ -1008,20 +1013,20 @@ static int raid1_spare_active(mddev_t *m
 {
 	int i;
 	conf_t *conf = mddev->private;
-	mirror_info_t *tmp;
 
 	/*
 	 * Find all failed disks within the RAID1 configuration 
-	 * and mark them readable
+	 * and mark them readable.
+	 * Called under mddev lock, so rcu protection not needed.
 	 */
 	for (i = 0; i < conf->raid_disks; i++) {
-		tmp = conf->mirrors + i;
-		if (tmp->rdev 
-		    && !test_bit(Faulty, &tmp->rdev->flags)
-		    && !test_bit(In_sync, &tmp->rdev->flags)) {
+		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		if (rdev
+		    && !test_bit(Faulty, &rdev->flags)
+		    && !test_bit(In_sync, &rdev->flags)) {
 			conf->working_disks++;
 			mddev->degraded--;
-			set_bit(In_sync, &tmp->rdev->flags);
+			set_bit(In_sync, &rdev->flags);
 		}
 	}
 
@@ -1237,7 +1242,7 @@ static void sync_request_write(mddev_t *
 		/* ouch - failed to read all of that.
 		 * Try some synchronous reads of other devices to get
 		 * good data, much like with normal read errors.  Only
-		 * read into the pages we already have so they we don't
+		 * read into the pages we already have so we don't
 		 * need to re-issue the read request.
 		 * We don't need to freeze the array, because being in an
 		 * active sync request, there is no normal IO, and
@@ -1257,6 +1262,10 @@ static void sync_request_write(mddev_t *
 				s = PAGE_SIZE >> 9;
 			do {
 				if (r1_bio->bios[d]->bi_end_io == end_sync_read) {
+					/* No rcu protection needed here devices
+					 * can only be removed when no resync is
+					 * active, and resync is currently active
+					 */
 					rdev = conf->mirrors[d].rdev;
 					if (sync_page_io(rdev->bdev,
 							 sect + rdev->data_offset,
@@ -1463,6 +1472,11 @@ static void raid1d(mddev_t *mddev)
 					s = PAGE_SIZE >> 9;
 
 				do {
+					/* Note: no rcu protection needed here
+					 * as this is synchronous in the raid1d thread
+					 * which is the thread that might remove
+					 * a device.  If raid1d ever becomes multi-threaded....
+					 */
 					rdev = conf->mirrors[d].rdev;
 					if (rdev &&
 					    test_bit(In_sync, &rdev->flags) &&
@@ -1486,7 +1500,6 @@ static void raid1d(mddev_t *mddev)
 							d = conf->raid_disks;
 						d--;
 						rdev = conf->mirrors[d].rdev;
-						atomic_add(s, &rdev->corrected_errors);
 						if (rdev &&
 						    test_bit(In_sync, &rdev->flags)) {
 							if (sync_page_io(rdev->bdev,
@@ -1509,9 +1522,11 @@ static void raid1d(mddev_t *mddev)
 									 s<<9, conf->tmppage, READ) == 0)
 								/* Well, this device is dead */
 								md_error(mddev, rdev);
-							else
+							else {
+								atomic_add(s, &rdev->corrected_errors);
 								printk(KERN_INFO "raid1:%s: read error corrected (%d sectors at %llu on %s)\n",
 								       mdname(mddev), s, (unsigned long long)(sect + rdev->data_offset), bdevname(rdev->bdev, b));
+							}
 						}
 					}
 				} else {
@@ -1787,19 +1802,17 @@ static sector_t sync_request(mddev_t *md
 		for (i=0; i<conf->raid_disks; i++) {
 			bio = r1_bio->bios[i];
 			if (bio->bi_end_io == end_sync_read) {
-				md_sync_acct(conf->mirrors[i].rdev->bdev, nr_sectors);
+				md_sync_acct(bio->bi_bdev, nr_sectors);
 				generic_make_request(bio);
 			}
 		}
 	} else {
 		atomic_set(&r1_bio->remaining, 1);
 		bio = r1_bio->bios[r1_bio->read_disk];
-		md_sync_acct(conf->mirrors[r1_bio->read_disk].rdev->bdev,
-			     nr_sectors);
+		md_sync_acct(bio->bi_bdev, nr_sectors);
 		generic_make_request(bio);
 
 	}
-
 	return nr_sectors;
 }
 
