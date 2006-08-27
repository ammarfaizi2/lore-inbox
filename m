Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWH0Xu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWH0Xu3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWH0Xto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:49:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:3712 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932130AbWH0XtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:49:24 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 28 Aug 2006 09:49:22 +1000
Message-Id: <1060827234922.32479@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 4] md: Factor out part of raid1d into a separate function
References: <20060828092849.21292.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.de>

raid1d has toooo many nested block, so take the fix_read_error functionality
out into a separate function.

Signed-off-by: Neil Brown <neilb@suse.de>
---

 drivers/md/raid1.c |  161 +++++++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 72 deletions(-)

Index: mm-quilt/drivers/md/raid1.c
===================================================================
--- mm-quilt.orig/drivers/md/raid1.c	2006-08-28 09:06:32.000000000 +1000
+++ mm-quilt/drivers/md/raid1.c	2006-08-28 09:42:51.000000000 +1000
@@ -1368,6 +1368,95 @@ static void sync_request_write(mddev_t *
  *	3.	Performs writes following reads for array syncronising.
  */
 
+static void fix_read_error(conf_t *conf, int read_disk,
+			   sector_t sect, int sectors)
+{
+	mddev_t *mddev = conf->mddev;
+	while(sectors) {
+		int s = sectors;
+		int d = read_disk;
+		int success = 0;
+		int start;
+		mdk_rdev_t *rdev;
+
+		if (s > (PAGE_SIZE>>9))
+			s = PAGE_SIZE >> 9;
+
+		do {
+			/* Note: no rcu protection needed here
+			 * as this is synchronous in the raid1d thread
+			 * which is the thread that might remove
+			 * a device.  If raid1d ever becomes multi-threaded....
+			 */
+			rdev = conf->mirrors[d].rdev;
+			if (rdev &&
+			    test_bit(In_sync, &rdev->flags) &&
+			    sync_page_io(rdev->bdev,
+					 sect + rdev->data_offset,
+					 s<<9,
+					 conf->tmppage, READ))
+				success = 1;
+			else {
+				d++;
+				if (d == conf->raid_disks)
+					d = 0;
+			}
+		} while (!success && d != read_disk);
+
+		if (!success) {
+			/* Cannot read from anywhere -- bye bye array */
+			md_error(mddev, conf->mirrors[read_disk].rdev);
+			break;
+		}
+		/* write it back and re-read */
+		start = d;
+		while (d != read_disk) {
+			if (d==0)
+				d = conf->raid_disks;
+			d--;
+			rdev = conf->mirrors[d].rdev;
+			if (rdev &&
+			    test_bit(In_sync, &rdev->flags)) {
+				if (sync_page_io(rdev->bdev,
+						 sect + rdev->data_offset,
+						 s<<9, conf->tmppage, WRITE)
+				    == 0)
+					/* Well, this device is dead */
+					md_error(mddev, rdev);
+			}
+		}
+		d = start;
+		while (d != read_disk) {
+			char b[BDEVNAME_SIZE];
+			if (d==0)
+				d = conf->raid_disks;
+			d--;
+			rdev = conf->mirrors[d].rdev;
+			if (rdev &&
+			    test_bit(In_sync, &rdev->flags)) {
+				if (sync_page_io(rdev->bdev,
+						 sect + rdev->data_offset,
+						 s<<9, conf->tmppage, READ)
+				    == 0)
+					/* Well, this device is dead */
+					md_error(mddev, rdev);
+				else {
+					atomic_add(s, &rdev->corrected_errors);
+					printk(KERN_INFO
+					       "raid1:%s: read error corrected "
+					       "(%d sectors at %llu on %s)\n",
+					       mdname(mddev), s,
+					       (unsigned long long)sect +
+					           rdev->data_offset,
+					       bdevname(rdev->bdev, b));
+				}
+			}
+		}
+		sectors -= s;
+		sect += s;
+	}
+}
+
 static void raid1d(mddev_t *mddev)
 {
 	r1bio_t *r1_bio;
@@ -1460,86 +1549,14 @@ static void raid1d(mddev_t *mddev)
 			 * This is all done synchronously while the array is
 			 * frozen
 			 */
-			sector_t sect = r1_bio->sector;
-			int sectors = r1_bio->sectors;
-			freeze_array(conf);
-			if (mddev->ro == 0) while(sectors) {
-				int s = sectors;
-				int d = r1_bio->read_disk;
-				int success = 0;
-
-				if (s > (PAGE_SIZE>>9))
-					s = PAGE_SIZE >> 9;
-
-				do {
-					/* Note: no rcu protection needed here
-					 * as this is synchronous in the raid1d thread
-					 * which is the thread that might remove
-					 * a device.  If raid1d ever becomes multi-threaded....
-					 */
-					rdev = conf->mirrors[d].rdev;
-					if (rdev &&
-					    test_bit(In_sync, &rdev->flags) &&
-					    sync_page_io(rdev->bdev,
-							 sect + rdev->data_offset,
-							 s<<9,
-							 conf->tmppage, READ))
-						success = 1;
-					else {
-						d++;
-						if (d == conf->raid_disks)
-							d = 0;
-					}
-				} while (!success && d != r1_bio->read_disk);
-
-				if (success) {
-					/* write it back and re-read */
-					int start = d;
-					while (d != r1_bio->read_disk) {
-						if (d==0)
-							d = conf->raid_disks;
-						d--;
-						rdev = conf->mirrors[d].rdev;
-						if (rdev &&
-						    test_bit(In_sync, &rdev->flags)) {
-							if (sync_page_io(rdev->bdev,
-									 sect + rdev->data_offset,
-									 s<<9, conf->tmppage, WRITE) == 0)
-								/* Well, this device is dead */
-								md_error(mddev, rdev);
-						}
-					}
-					d = start;
-					while (d != r1_bio->read_disk) {
-						if (d==0)
-							d = conf->raid_disks;
-						d--;
-						rdev = conf->mirrors[d].rdev;
-						if (rdev &&
-						    test_bit(In_sync, &rdev->flags)) {
-							if (sync_page_io(rdev->bdev,
-									 sect + rdev->data_offset,
-									 s<<9, conf->tmppage, READ) == 0)
-								/* Well, this device is dead */
-								md_error(mddev, rdev);
-							else {
-								atomic_add(s, &rdev->corrected_errors);
-								printk(KERN_INFO "raid1:%s: read error corrected (%d sectors at %llu on %s)\n",
-								       mdname(mddev), s, (unsigned long long)(sect + rdev->data_offset), bdevname(rdev->bdev, b));
-							}
-						}
-					}
-				} else {
-					/* Cannot read from anywhere -- bye bye array */
-					md_error(mddev, conf->mirrors[r1_bio->read_disk].rdev);
-					break;
-				}
-				sectors -= s;
-				sect += s;
+			if (mddev->ro == 0) {
+				freeze_array(conf);
+				fix_read_error(conf, r1_bio->read_disk,
+					       r1_bio->sector,
+					       r1_bio->sectors);
+				unfreeze_array(conf);
 			}
 
-			unfreeze_array(conf);
-
 			bio = r1_bio->bios[r1_bio->read_disk];
 			if ((disk=read_balance(conf, r1_bio)) == -1) {
 				printk(KERN_ALERT "raid1: %s: unrecoverable I/O"
