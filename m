Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbWD1Cvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbWD1Cvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 22:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWD1Cvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 22:51:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:49901 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965192AbWD1Cvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 22:51:44 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Apr 2006 12:51:39 +1000
Message-Id: <1060428025139.30758@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 5] md: Fixed refcounting/locking when attempting read error correction in raid10
References: <20060428124313.29510.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We need to hold a reference to rdevs while reading
and writing to attempt to correct read errors.  This
reference must be taken under an rcu lock.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid10.c |   44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff ./drivers/md/raid10.c~current~ ./drivers/md/raid10.c
--- ./drivers/md/raid10.c~current~	2006-04-28 12:13:20.000000000 +1000
+++ ./drivers/md/raid10.c	2006-04-28 12:16:54.000000000 +1000
@@ -1407,36 +1407,45 @@ static void raid10d(mddev_t *mddev)
 				if (s > (PAGE_SIZE>>9))
 					s = PAGE_SIZE >> 9;
 
+				rcu_read_lock();
 				do {
 					int d = r10_bio->devs[sl].devnum;
-					rdev = conf->mirrors[d].rdev;
+					rdev = rcu_dereference(conf->mirrors[d].rdev);
 					if (rdev &&
-					    test_bit(In_sync, &rdev->flags) &&
-					    sync_page_io(rdev->bdev,
-							 r10_bio->devs[sl].addr +
-							 sect + rdev->data_offset,
-							 s<<9,
-							 conf->tmppage, READ))
-						success = 1;
-					else {
-						sl++;
-						if (sl == conf->copies)
-							sl = 0;
+					    test_bit(In_sync, &rdev->flags)) {
+						atomic_inc(&rdev->nr_pending);
+						rcu_read_unlock();
+						success = sync_page_io(rdev->bdev,
+								       r10_bio->devs[sl].addr +
+								       sect + rdev->data_offset,
+								       s<<9,
+								       conf->tmppage, READ);
+						rdev_dec_pending(rdev, mddev);
+						rcu_read_lock();
+						if (success)
+							break;
 					}
+					sl++;
+					if (sl == conf->copies)
+						sl = 0;
 				} while (!success && sl != r10_bio->read_slot);
+				rcu_read_unlock();
 
 				if (success) {
 					int start = sl;
 					/* write it back and re-read */
+					rcu_read_lock();
 					while (sl != r10_bio->read_slot) {
 						int d;
 						if (sl==0)
 							sl = conf->copies;
 						sl--;
 						d = r10_bio->devs[sl].devnum;
-						rdev = conf->mirrors[d].rdev;
+						rdev = rcu_dereference(conf->mirrors[d].rdev);
 						if (rdev &&
 						    test_bit(In_sync, &rdev->flags)) {
+							atomic_inc(&rdev->nr_pending);
+							rcu_read_unlock();
 							atomic_add(s, &rdev->corrected_errors);
 							if (sync_page_io(rdev->bdev,
 									 r10_bio->devs[sl].addr +
@@ -1444,6 +1453,8 @@ static void raid10d(mddev_t *mddev)
 									 s<<9, conf->tmppage, WRITE) == 0)
 								/* Well, this device is dead */
 								md_error(mddev, rdev);
+							rdev_dec_pending(rdev, mddev);
+							rcu_read_lock();
 						}
 					}
 					sl = start;
@@ -1453,17 +1464,22 @@ static void raid10d(mddev_t *mddev)
 							sl = conf->copies;
 						sl--;
 						d = r10_bio->devs[sl].devnum;
-						rdev = conf->mirrors[d].rdev;
+						rdev = rcu_dereference(conf->mirrors[d].rdev);
 						if (rdev &&
 						    test_bit(In_sync, &rdev->flags)) {
+							atomic_inc(&rdev->nr_pending);
+							rcu_read_unlock();
 							if (sync_page_io(rdev->bdev,
 									 r10_bio->devs[sl].addr +
 									 sect + rdev->data_offset,
 									 s<<9, conf->tmppage, READ) == 0)
 								/* Well, this device is dead */
 								md_error(mddev, rdev);
+							rdev_dec_pending(rdev, mddev);
+							rcu_read_lock();
 						}
 					}
+					rcu_read_unlock();
 				} else {
 					/* Cannot read from anywhere -- bye bye array */
 					md_error(mddev, conf->mirrors[r10_bio->devs[r10_bio->read_slot].devnum].rdev);
