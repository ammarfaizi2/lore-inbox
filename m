Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWHXHld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWHXHld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWHXHld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:41:33 -0400
Received: from ns.suse.de ([195.135.220.2]:36308 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750772AbWHXHlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:41:07 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 17:41:08 +1000
Message-Id: <1060824074108.19147@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 4] md: Fix issues with referencing rdev in md/raid1.
References: <20060824173647.19026.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We need to be careful when referencing mirrors[i].rdev.
so it can disappear under us at various times.

So:
  fix a couple of problem places.
  comment a couple of non-problem places
  move an 'atomic_add' which deferences rdev down a little
    way to some where where it is sure to not be NULL.
  

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c |   55 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-08-24 17:21:35.000000000 +1000
+++ ./drivers/md/raid1.c	2006-08-24 17:23:58.000000000 +1000
@@ -930,10 +930,13 @@ static void status(struct seq_file *seq,
 
 	seq_printf(seq, " [%d/%d] [", conf->raid_disks,
 		   conf->raid_disks - mddev->degraded);
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
 
@@ -976,7 +979,6 @@ static void error(mddev_t *mddev, mdk_rd
 static void print_conf(conf_t *conf)
 {
 	int i;
-	mirror_info_t *tmp;
 
 	printk("RAID1 conf printout:\n");
 	if (!conf) {
@@ -986,14 +988,17 @@ static void print_conf(conf_t *conf)
 	printk(" --- wd:%d rd:%d\n", conf->raid_disks - conf->mddev->degraded,
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
@@ -1009,17 +1014,17 @@ static int raid1_spare_active(mddev_t *m
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
-		    && !test_and_set_bit(In_sync, &tmp->rdev->flags)) {
+		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		if (rdev
+		    && !test_bit(Faulty, &rdev->flags)
+		    && !test_and_set_bit(In_sync, &rdev->flags)) {
 			unsigned long flags;
 			spin_lock_irqsave(&conf->device_lock, flags);
 			mddev->degraded--;
@@ -1239,7 +1244,7 @@ static void sync_request_write(mddev_t *
 		/* ouch - failed to read all of that.
 		 * Try some synchronous reads of other devices to get
 		 * good data, much like with normal read errors.  Only
-		 * read into the pages we already have so they we don't
+		 * read into the pages we already have so we don't
 		 * need to re-issue the read request.
 		 * We don't need to freeze the array, because being in an
 		 * active sync request, there is no normal IO, and
@@ -1259,6 +1264,10 @@ static void sync_request_write(mddev_t *
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
@@ -1376,6 +1385,11 @@ static void fix_read_error(conf_t *conf,
 			s = PAGE_SIZE >> 9;
 
 		do {
+			/* Note: no rcu protection needed here
+			 * as this is synchronous in the raid1d thread
+			 * which is the thread that might remove
+			 * a device.  If raid1d ever becomes multi-threaded....
+			 */
 			rdev = conf->mirrors[d].rdev;
 			if (rdev &&
 			    test_bit(In_sync, &rdev->flags) &&
@@ -1403,7 +1417,6 @@ static void fix_read_error(conf_t *conf,
 				d = conf->raid_disks;
 			d--;
 			rdev = conf->mirrors[d].rdev;
-			atomic_add(s, &rdev->corrected_errors);
 			if (rdev &&
 			    test_bit(In_sync, &rdev->flags)) {
 				if (sync_page_io(rdev->bdev,
@@ -1429,7 +1442,8 @@ static void fix_read_error(conf_t *conf,
 				    == 0)
 					/* Well, this device is dead */
 					md_error(mddev, rdev);
-				else
+				else {
+					atomic_add(s, &rdev->corrected_errors);
 					printk(KERN_INFO
 					       "raid1:%s: read error corrected "
 					       "(%d sectors at %llu on %s)\n",
@@ -1437,6 +1451,7 @@ static void fix_read_error(conf_t *conf,
 					       (unsigned long long)sect +
 					           rdev->data_offset,
 					       bdevname(rdev->bdev, b));
+				}
 			}
 		}
 		sectors -= s;
@@ -1806,19 +1821,17 @@ static sector_t sync_request(mddev_t *md
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
 
