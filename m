Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWFAFQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWFAFQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWFAFOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:14:11 -0400
Received: from ns1.suse.de ([195.135.220.2]:23767 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751790AbWFAFOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:14:03 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 1 Jun 2006 15:13:52 +1000
Message-Id: <1060601051352.27601@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 10] md: Don't write dirty/clean update to spares - leave them alone
References: <20060601150955.27444.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- record the 'event' count on each individual device (they
  might sometimes be slightly different now)
- add a new value for 'sb_dirty': '3' means that the super
  block only needs to be updated to record a clean<->dirty
  transition.
- Prefer odd event numbers for dirty states and even numbers
  for clean states
- Using all the above, don't update the superblock on
  a spare device if the update is just doing a clean-dirty
  transition.  To accomodate this, a transition from
  dirty back to clean might now decrement the events counter
  if nothing else has changed.

The net effect of this is that spare drives will not see any IO
requests during normal running of the array, so they can go to sleep
if that is what they want to do.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c           |   65 ++++++++++++++++++++++++++++++++++++++------
 ./include/linux/raid/md_k.h |    1 
 2 files changed, 58 insertions(+), 8 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-06-01 15:05:29.000000000 +1000
+++ ./drivers/md/md.c	2006-06-01 15:05:29.000000000 +1000
@@ -1558,15 +1558,30 @@ static void md_print_devices(void)
 }
 
 
-static void sync_sbs(mddev_t * mddev)
+static void sync_sbs(mddev_t * mddev, int nospares)
 {
+	/* Update each superblock (in-memory image), but
+	 * if we are allowed to, skip spares which already
+	 * have the right event counter, or have one earlier
+	 * (which would mean they aren't being marked as dirty
+	 * with the rest of the array)
+	 */
 	mdk_rdev_t *rdev;
 	struct list_head *tmp;
 
 	ITERATE_RDEV(mddev,rdev,tmp) {
-		super_types[mddev->major_version].
-			sync_super(mddev, rdev);
-		rdev->sb_loaded = 1;
+		if (rdev->sb_events == mddev->events ||
+		    (nospares &&
+		     rdev->raid_disk < 0 &&
+		     (rdev->sb_events&1)==0 &&
+		     rdev->sb_events+1 == mddev->events)) {
+			/* Don't update this superblock */
+			rdev->sb_loaded = 2;
+		} else {
+			super_types[mddev->major_version].
+				sync_super(mddev, rdev);
+			rdev->sb_loaded = 1;
+		}
 	}
 }
 
@@ -1576,12 +1591,42 @@ void md_update_sb(mddev_t * mddev)
 	struct list_head *tmp;
 	mdk_rdev_t *rdev;
 	int sync_req;
+	int nospares = 0;
 
 repeat:
 	spin_lock_irq(&mddev->write_lock);
 	sync_req = mddev->in_sync;
 	mddev->utime = get_seconds();
-	mddev->events ++;
+	if (mddev->sb_dirty == 3)
+		/* just a clean<-> dirty transition, possibly leave spares alone,
+		 * though if events isn't the right even/odd, we will have to do
+		 * spares after all
+		 */
+		nospares = 1;
+
+	/* If this is just a dirty<->clean transition, and the array is clean
+	 * and 'events' is odd, we can roll back to the previous clean state */
+	if (mddev->sb_dirty == 3
+	    && (mddev->in_sync && mddev->recovery_cp == MaxSector)
+	    && (mddev->events & 1))
+		mddev->events--;
+	else {
+		/* otherwise we have to go forward and ... */
+		mddev->events ++;
+		if (!mddev->in_sync || mddev->recovery_cp != MaxSector) { /* not clean */
+			/* .. if the array isn't clean, insist on an odd 'events' */
+			if ((mddev->events&1)==0) {
+				mddev->events++;
+				nospares = 0;
+			}
+		} else {
+			/* otherwise insist on an even 'events' (for clean states) */
+			if ((mddev->events&1)) {
+				mddev->events++;
+				nospares = 0;
+			}
+		}
+	}
 
 	if (!mddev->events) {
 		/*
@@ -1593,7 +1638,7 @@ repeat:
 		mddev->events --;
 	}
 	mddev->sb_dirty = 2;
-	sync_sbs(mddev);
+	sync_sbs(mddev, nospares);
 
 	/*
 	 * do not write anything to disk if using
@@ -1615,6 +1660,8 @@ repeat:
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		char b[BDEVNAME_SIZE];
 		dprintk(KERN_INFO "md: ");
+		if (rdev->sb_loaded != 1)
+			continue; /* no noise on spare devices */
 		if (test_bit(Faulty, &rdev->flags))
 			dprintk("(skipping faulty ");
 
@@ -1626,6 +1673,7 @@ repeat:
 			dprintk(KERN_INFO "(write) %s's sb offset: %llu\n",
 				bdevname(rdev->bdev,b),
 				(unsigned long long)rdev->sb_offset);
+			rdev->sb_events = mddev->events;
 
 		} else
 			dprintk(")\n");
@@ -1895,6 +1943,7 @@ static mdk_rdev_t *md_import_device(dev_
 	rdev->desc_nr = -1;
 	rdev->flags = 0;
 	rdev->data_offset = 0;
+	rdev->sb_events = 0;
 	atomic_set(&rdev->nr_pending, 0);
 	atomic_set(&rdev->read_errors, 0);
 	atomic_set(&rdev->corrected_errors, 0);
@@ -4708,7 +4757,7 @@ void md_write_start(mddev_t *mddev, stru
 		spin_lock_irq(&mddev->write_lock);
 		if (mddev->in_sync) {
 			mddev->in_sync = 0;
-			mddev->sb_dirty = 1;
+			mddev->sb_dirty = 3;
 			md_wakeup_thread(mddev->thread);
 		}
 		spin_unlock_irq(&mddev->write_lock);
@@ -5055,7 +5104,7 @@ void md_check_recovery(mddev_t *mddev)
 		if (mddev->safemode && !atomic_read(&mddev->writes_pending) &&
 		    !mddev->in_sync && mddev->recovery_cp == MaxSector) {
 			mddev->in_sync = 1;
-			mddev->sb_dirty = 1;
+			mddev->sb_dirty = 3;
 		}
 		if (mddev->safemode == 1)
 			mddev->safemode = 0;

diff ./include/linux/raid/md_k.h~current~ ./include/linux/raid/md_k.h
--- ./include/linux/raid/md_k.h~current~	2006-06-01 15:03:28.000000000 +1000
+++ ./include/linux/raid/md_k.h	2006-06-01 15:05:29.000000000 +1000
@@ -58,6 +58,7 @@ struct mdk_rdev_s
 
 	struct page	*sb_page;
 	int		sb_loaded;
+	__u64		sb_events;
 	sector_t	data_offset;	/* start of data in array */
 	sector_t	sb_offset;
 	int		sb_size;	/* bytes in the superblock */
