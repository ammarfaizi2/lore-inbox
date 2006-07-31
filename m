Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWGaHdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWGaHdy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWGaHcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:32:36 -0400
Received: from ns.suse.de ([195.135.220.2]:22987 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964817AbWGaHcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:32:18 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 17:32:08 +1000
Message-Id: <1060731073208.24470@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 9] md: Factor out part of raid10d into a separate function.
References: <20060731172842.24323.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


raid10d has toooo many nested block, so take the fix_read_error
functionality out into a separate function.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid10.c |  213 ++++++++++++++++++++++++++------------------------
 1 file changed, 115 insertions(+), 98 deletions(-)

diff .prev/drivers/md/raid10.c ./drivers/md/raid10.c
--- .prev/drivers/md/raid10.c	2006-07-31 17:23:57.000000000 +1000
+++ ./drivers/md/raid10.c	2006-07-31 17:24:34.000000000 +1000
@@ -1350,9 +1350,119 @@ static void recovery_request_write(mddev
  *
  *	1.	Retries failed read operations on working mirrors.
  *	2.	Updates the raid superblock when problems encounter.
- *	3.	Performs writes following reads for array syncronising.
+ *	3.	Performs writes following reads for array synchronising.
  */
 
+static void fix_read_error(conf_t *conf, mddev_t *mddev, r10bio_t *r10_bio)
+{
+	int sect = 0; /* Offset from r10_bio->sector */
+	int sectors = r10_bio->sectors;
+	mdk_rdev_t*rdev;
+	while(sectors) {
+		int s = sectors;
+		int sl = r10_bio->read_slot;
+		int success = 0;
+		int start;
+
+		if (s > (PAGE_SIZE>>9))
+			s = PAGE_SIZE >> 9;
+
+		rcu_read_lock();
+		do {
+			int d = r10_bio->devs[sl].devnum;
+			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			if (rdev &&
+			    test_bit(In_sync, &rdev->flags)) {
+				atomic_inc(&rdev->nr_pending);
+				rcu_read_unlock();
+				success = sync_page_io(rdev->bdev,
+						       r10_bio->devs[sl].addr +
+						       sect + rdev->data_offset,
+						       s<<9,
+						       conf->tmppage, READ);
+				rdev_dec_pending(rdev, mddev);
+				rcu_read_lock();
+				if (success)
+					break;
+			}
+			sl++;
+			if (sl == conf->copies)
+				sl = 0;
+		} while (!success && sl != r10_bio->read_slot);
+		rcu_read_unlock();
+
+		if (!success) {
+			/* Cannot read from anywhere -- bye bye array */
+			int dn = r10_bio->devs[r10_bio->read_slot].devnum;
+			md_error(mddev, conf->mirrors[dn].rdev);
+			break;
+		}
+
+		start = sl;
+		/* write it back and re-read */
+		rcu_read_lock();
+		while (sl != r10_bio->read_slot) {
+			int d;
+			if (sl==0)
+				sl = conf->copies;
+			sl--;
+			d = r10_bio->devs[sl].devnum;
+			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			if (rdev &&
+			    test_bit(In_sync, &rdev->flags)) {
+				atomic_inc(&rdev->nr_pending);
+				rcu_read_unlock();
+				atomic_add(s, &rdev->corrected_errors);
+				if (sync_page_io(rdev->bdev,
+						 r10_bio->devs[sl].addr +
+						 sect + rdev->data_offset,
+						 s<<9, conf->tmppage, WRITE)
+				    == 0)
+					/* Well, this device is dead */
+					md_error(mddev, rdev);
+				rdev_dec_pending(rdev, mddev);
+				rcu_read_lock();
+			}
+		}
+		sl = start;
+		while (sl != r10_bio->read_slot) {
+			int d;
+			if (sl==0)
+				sl = conf->copies;
+			sl--;
+			d = r10_bio->devs[sl].devnum;
+			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			if (rdev &&
+			    test_bit(In_sync, &rdev->flags)) {
+				char b[BDEVNAME_SIZE];
+				atomic_inc(&rdev->nr_pending);
+				rcu_read_unlock();
+				if (sync_page_io(rdev->bdev,
+						 r10_bio->devs[sl].addr +
+						 sect + rdev->data_offset,
+						 s<<9, conf->tmppage, READ) == 0)
+					/* Well, this device is dead */
+					md_error(mddev, rdev);
+				else
+					printk(KERN_INFO
+					       "raid10:%s: read error corrected"
+					       " (%d sectors at %llu on %s)\n",
+					       mdname(mddev), s,
+					       (unsigned long long)sect+
+					            rdev->data_offset,
+					       bdevname(rdev->bdev, b));
+
+				rdev_dec_pending(rdev, mddev);
+				rcu_read_lock();
+			}
+		}
+		rcu_read_unlock();
+
+		sectors -= s;
+		sect += s;
+	}
+}
+
 static void raid10d(mddev_t *mddev)
 {
 	r10bio_t *r10_bio;
@@ -1413,105 +1523,12 @@ static void raid10d(mddev_t *mddev)
 			 * This is all done synchronously while the array is
 			 * frozen.
 			 */
-			int sect = 0; /* Offset from r10_bio->sector */
-			int sectors = r10_bio->sectors;
-			freeze_array(conf);
-			if (mddev->ro == 0) while(sectors) {
-				int s = sectors;
-				int sl = r10_bio->read_slot;
-				int success = 0;
-
-				if (s > (PAGE_SIZE>>9))
-					s = PAGE_SIZE >> 9;
-
-				rcu_read_lock();
-				do {
-					int d = r10_bio->devs[sl].devnum;
-					rdev = rcu_dereference(conf->mirrors[d].rdev);
-					if (rdev &&
-					    test_bit(In_sync, &rdev->flags)) {
-						atomic_inc(&rdev->nr_pending);
-						rcu_read_unlock();
-						success = sync_page_io(rdev->bdev,
-								       r10_bio->devs[sl].addr +
-								       sect + rdev->data_offset,
-								       s<<9,
-								       conf->tmppage, READ);
-						rdev_dec_pending(rdev, mddev);
-						rcu_read_lock();
-						if (success)
-							break;
-					}
-					sl++;
-					if (sl == conf->copies)
-						sl = 0;
-				} while (!success && sl != r10_bio->read_slot);
-				rcu_read_unlock();
-
-				if (success) {
-					int start = sl;
-					/* write it back and re-read */
-					rcu_read_lock();
-					while (sl != r10_bio->read_slot) {
-						int d;
-						if (sl==0)
-							sl = conf->copies;
-						sl--;
-						d = r10_bio->devs[sl].devnum;
-						rdev = rcu_dereference(conf->mirrors[d].rdev);
-						if (rdev &&
-						    test_bit(In_sync, &rdev->flags)) {
-							atomic_inc(&rdev->nr_pending);
-							rcu_read_unlock();
-							atomic_add(s, &rdev->corrected_errors);
-							if (sync_page_io(rdev->bdev,
-									 r10_bio->devs[sl].addr +
-									 sect + rdev->data_offset,
-									 s<<9, conf->tmppage, WRITE) == 0)
-								/* Well, this device is dead */
-								md_error(mddev, rdev);
-							rdev_dec_pending(rdev, mddev);
-							rcu_read_lock();
-						}
-					}
-					sl = start;
-					while (sl != r10_bio->read_slot) {
-						int d;
-						if (sl==0)
-							sl = conf->copies;
-						sl--;
-						d = r10_bio->devs[sl].devnum;
-						rdev = rcu_dereference(conf->mirrors[d].rdev);
-						if (rdev &&
-						    test_bit(In_sync, &rdev->flags)) {
-							atomic_inc(&rdev->nr_pending);
-							rcu_read_unlock();
-							if (sync_page_io(rdev->bdev,
-									 r10_bio->devs[sl].addr +
-									 sect + rdev->data_offset,
-									 s<<9, conf->tmppage, READ) == 0)
-								/* Well, this device is dead */
-								md_error(mddev, rdev);
-							else
-								printk(KERN_INFO "raid10:%s: read error corrected (%d sectors at %llu on %s)\n",
-								       mdname(mddev), s, (unsigned long long)(sect+rdev->data_offset), bdevname(rdev->bdev, b));
-
-							rdev_dec_pending(rdev, mddev);
-							rcu_read_lock();
-						}
-					}
-					rcu_read_unlock();
-				} else {
-					/* Cannot read from anywhere -- bye bye array */
-					md_error(mddev, conf->mirrors[r10_bio->devs[r10_bio->read_slot].devnum].rdev);
-					break;
-				}
-				sectors -= s;
-				sect += s;
+			if (mddev->ro == 0) {
+				freeze_array(conf);
+				fix_read_error(conf, mddev, r10_bio);
+				unfreeze_array(conf);
 			}
 
-			unfreeze_array(conf);
-
 			bio = r10_bio->devs[r10_bio->read_slot].bio;
 			r10_bio->devs[r10_bio->read_slot].bio =
 				mddev->ro ? IO_BLOCKED : NULL;
