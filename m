Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWGaHcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWGaHcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWGaHcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:32:13 -0400
Received: from mail.suse.de ([195.135.220.2]:21963 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964817AbWGaHcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:32:08 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 17:32:01 +1000
Message-Id: <1060731073201.24455@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 9] md: Factor out part of raid1d into a separate function.
References: <20060731172842.24323.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


raid1d has toooo many nested block, so take the fix_read_error
functionality out into a separate function.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c |  161 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 89 insertions(+), 72 deletions(-)

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-07-31 17:23:57.000000000 +1000
+++ ./drivers/md/raid1.c	2006-07-31 17:24:24.000000000 +1000
@@ -1359,6 +1359,89 @@ static void sync_request_write(mddev_t *
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
+			atomic_add(s, &rdev->corrected_errors);
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
+				else
+					printk(KERN_INFO
+					       "raid1:%s: read error corrected "
+					       "(%d sectors at %llu on %s)\n",
+					       mdname(mddev), s,
+					       (unsigned long long)sect +
+					           rdev->data_offset,
+					       bdevname(rdev->bdev, b));
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
@@ -1451,80 +1534,14 @@ static void raid1d(mddev_t *mddev)
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
-						atomic_add(s, &rdev->corrected_errors);
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
-							else
-								printk(KERN_INFO "raid1:%s: read error corrected (%d sectors at %llu on %s)\n",
-								       mdname(mddev), s, (unsigned long long)(sect + rdev->data_offset), bdevname(rdev->bdev, b));
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
