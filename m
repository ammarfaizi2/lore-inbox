Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWFAFOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWFAFOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWFAFOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:14:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:12201 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751784AbWFAFN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:13:58 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 1 Jun 2006 15:13:42 +1000
Message-Id: <1060601051342.27589@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 10] md: Allow re-add to work on array without bitmaps.
References: <20060601150955.27444.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When an array has a bitmap, a device can be removed and re-added
and only blocks changes since the removal (as recorded in the bitmap)
will be resynced.

It should be possible to do a similar thing to arrays without bitmaps.
i.e. if a device is removed and re-added and *no* changes have been
made in the interim, then the add should not require a resync.

This patch allows that option. 
This means that when assembling an array one device at a time (e.g.
during device discovery) the array can be enabled read-only as soon
as enough devices are available, but extra devices can still be added
without causing a resync.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c    |   25 ++++++++++++++-----------
 ./drivers/md/raid1.c |    6 ++++++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-06-01 15:03:28.000000000 +1000
+++ ./drivers/md/md.c	2006-06-01 15:05:29.000000000 +1000
@@ -737,6 +737,7 @@ static int super_90_validate(mddev_t *md
 {
 	mdp_disk_t *desc;
 	mdp_super_t *sb = (mdp_super_t *)page_address(rdev->sb_page);
+	__u64 ev1 = md_event(sb);
 
 	rdev->raid_disk = -1;
 	rdev->flags = 0;
@@ -753,7 +754,7 @@ static int super_90_validate(mddev_t *md
 		mddev->layout = sb->layout;
 		mddev->raid_disks = sb->raid_disks;
 		mddev->size = sb->size;
-		mddev->events = md_event(sb);
+		mddev->events = ev1;
 		mddev->bitmap_offset = 0;
 		mddev->default_bitmap_offset = MD_SB_BYTES >> 9;
 
@@ -802,7 +803,6 @@ static int super_90_validate(mddev_t *md
 
 	} else if (mddev->pers == NULL) {
 		/* Insist on good event counter while assembling */
-		__u64 ev1 = md_event(sb);
 		++ev1;
 		if (ev1 < mddev->events) 
 			return -EINVAL;
@@ -810,11 +810,13 @@ static int super_90_validate(mddev_t *md
 		/* if adding to array with a bitmap, then we can accept an
 		 * older device ... but not too old.
 		 */
-		__u64 ev1 = md_event(sb);
 		if (ev1 < mddev->bitmap->events_cleared)
 			return 0;
-	} else /* just a hot-add of a new device, leave raid_disk at -1 */
-		return 0;
+	} else {
+		if (ev1 < mddev->events)
+			/* just a hot-add of a new device, leave raid_disk at -1 */
+			return 0;
+	}
 
 	if (mddev->level != LEVEL_MULTIPATH) {
 		desc = sb->disks + rdev->desc_nr;
@@ -1105,6 +1107,7 @@ static int super_1_load(mdk_rdev_t *rdev
 static int super_1_validate(mddev_t *mddev, mdk_rdev_t *rdev)
 {
 	struct mdp_superblock_1 *sb = (struct mdp_superblock_1*)page_address(rdev->sb_page);
+	__u64 ev1 = le64_to_cpu(sb->events);
 
 	rdev->raid_disk = -1;
 	rdev->flags = 0;
@@ -1120,7 +1123,7 @@ static int super_1_validate(mddev_t *mdd
 		mddev->layout = le32_to_cpu(sb->layout);
 		mddev->raid_disks = le32_to_cpu(sb->raid_disks);
 		mddev->size = le64_to_cpu(sb->size)/2;
-		mddev->events = le64_to_cpu(sb->events);
+		mddev->events = ev1;
 		mddev->bitmap_offset = 0;
 		mddev->default_bitmap_offset = 1024 >> 9;
 		
@@ -1154,7 +1157,6 @@ static int super_1_validate(mddev_t *mdd
 
 	} else if (mddev->pers == NULL) {
 		/* Insist of good event counter while assembling */
-		__u64 ev1 = le64_to_cpu(sb->events);
 		++ev1;
 		if (ev1 < mddev->events)
 			return -EINVAL;
@@ -1162,12 +1164,13 @@ static int super_1_validate(mddev_t *mdd
 		/* If adding to array with a bitmap, then we can accept an
 		 * older device, but not too old.
 		 */
-		__u64 ev1 = le64_to_cpu(sb->events);
 		if (ev1 < mddev->bitmap->events_cleared)
 			return 0;
-	} else /* just a hot-add of a new device, leave raid_disk at -1 */
-		return 0;
-
+	} else {
+		if (ev1 < mddev->events)
+			/* just a hot-add of a new device, leave raid_disk at -1 */
+			return 0;
+	}
 	if (mddev->level != LEVEL_MULTIPATH) {
 		int role;
 		rdev->desc_nr = le32_to_cpu(sb->dev_number);

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-06-01 15:03:28.000000000 +1000
+++ ./drivers/md/raid1.c	2006-06-01 15:05:29.000000000 +1000
@@ -1625,6 +1625,12 @@ static sector_t sync_request(mddev_t *md
 	/* before building a request, check if we can skip these blocks..
 	 * This call the bitmap_start_sync doesn't actually record anything
 	 */
+	if (mddev->bitmap == NULL &&
+	    mddev->recovery_cp == MaxSector &&
+	    conf->fullsync == 0) {
+		*skipped = 1;
+		return max_sector - sector_nr;
+	}
 	if (!bitmap_start_sync(mddev->bitmap, sector_nr, &sync_blocks, 1) &&
 	    !conf->fullsync && !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery)) {
 		/* We can skip this block, and probably several more */
