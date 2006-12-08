Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164316AbWLHBGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164316AbWLHBGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164323AbWLHBFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:05:49 -0500
Received: from ns2.suse.de ([195.135.220.15]:46645 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164316AbWLHBFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:05:30 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:05:42 +1100
Message-Id: <1061208010542.21319@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 5] md: Assorted md and raid1 one-liners
References: <20061208120132.21203.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix few bugs that meant that:
  - superblocks weren't alway written at exactly the right time (this
    could show up if the array was not written to - writting to the array
    causes lots of superblock updates and so hides these errors).

  - restarting device recovery after a clean shutdown (version-1 metadata
    only) didn't work as intended (or at all).

1/ Ensure superblock is updated when a new device is added.
2/ Remove an inappropriate test on MD_RECOVERY_SYNC in md_do_sync.
   The body of this if takes one of two branches depending on whether
   MD_RECOVERY_SYNC is set, so testing it in the clause of the if
   is wrong.
3/ Flag superblock for updating after a resync/recovery finishes.
4/ If we find the neeed to restart a recovery in the middle (version-1
   metadata only) make sure a full recovery (not just as guided by
   bitmaps) does get done.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c    |    3 ++-
 ./drivers/md/raid1.c |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-12-07 15:33:40.000000000 +1100
+++ ./drivers/md/md.c	2006-12-07 15:44:53.000000000 +1100
@@ -3729,6 +3729,7 @@ static int add_new_disk(mddev_t * mddev,
 		if (err)
 			export_rdev(rdev);
 
+		md_update_sb(mddev, 1);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		md_wakeup_thread(mddev->thread);
 		return err;
@@ -5289,7 +5290,6 @@ void md_do_sync(mddev_t *mddev)
 	mddev->pers->sync_request(mddev, max_sectors, &skipped, 1);
 
 	if (!test_bit(MD_RECOVERY_ERR, &mddev->recovery) &&
-	    test_bit(MD_RECOVERY_SYNC, &mddev->recovery) &&
 	    !test_bit(MD_RECOVERY_CHECK, &mddev->recovery) &&
 	    mddev->curr_resync > 2) {
 		if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
@@ -5313,6 +5313,7 @@ void md_do_sync(mddev_t *mddev)
 					rdev->recovery_offset = mddev->curr_resync;
 		}
 	}
+	set_bit(MD_CHANGE_DEVS, &mddev->flags);
 
  skip:
 	mddev->curr_resync = 0;

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-12-07 15:33:40.000000000 +1100
+++ ./drivers/md/raid1.c	2006-12-07 15:44:53.000000000 +1100
@@ -1951,6 +1951,7 @@ static int run(mddev_t *mddev)
 		    !test_bit(In_sync, &disk->rdev->flags)) {
 			disk->head_position = 0;
 			mddev->degraded++;
+			conf->fullsync = 1;
 		}
 	}
 	if (mddev->degraded == conf->raid_disks) {
