Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933246AbWKNAXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933246AbWKNAXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933245AbWKNAWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:22:52 -0500
Received: from ns2.suse.de ([195.135.220.15]:44486 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933243AbWKNAWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:22:41 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 14 Nov 2006 11:22:36 +1100
Message-Id: <1061114002236.31168@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 4] md: Fix newly introduced read-corruption with raid6.
References: <20061114111600.31061.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


chunk_aligned_read and retry_aligned_read assume that
    data_disks == raid_disks - 1
which is not true for raid6.
So when an aligned read request bypasses the cache, we can get the wrong data.

Also change the calculate of raid_disks in compute_blocknr to make it
more obviously correct.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-11-14 10:33:41.000000000 +1100
+++ ./drivers/md/raid5.c	2006-11-14 10:34:17.000000000 +1100
@@ -823,7 +823,8 @@ static sector_t raid5_compute_sector(sec
 static sector_t compute_blocknr(struct stripe_head *sh, int i)
 {
 	raid5_conf_t *conf = sh->raid_conf;
-	int raid_disks = sh->disks, data_disks = raid_disks - 1;
+	int raid_disks = sh->disks;
+	int data_disks = raid_disks - conf->max_degraded;
 	sector_t new_sector = sh->sector, check;
 	int sectors_per_chunk = conf->chunk_size >> 9;
 	sector_t stripe;
@@ -859,7 +860,6 @@ static sector_t compute_blocknr(struct s
 		}
 		break;
 	case 6:
-		data_disks = raid_disks - 2;
 		if (i == raid6_next_disk(sh->pd_idx, raid_disks))
 			return 0; /* It is the Q disk */
 		switch (conf->algorithm) {
@@ -2725,7 +2725,7 @@ static int chunk_aligned_read(request_qu
 	mddev_t *mddev = q->queuedata;
 	raid5_conf_t *conf = mddev_to_conf(mddev);
 	const unsigned int raid_disks = conf->raid_disks;
-	const unsigned int data_disks = raid_disks - 1;
+	const unsigned int data_disks = raid_disks - conf->max_degraded;
 	unsigned int dd_idx, pd_idx;
 	struct bio* align_bi;
 	mdk_rdev_t *rdev;
@@ -3145,7 +3145,7 @@ static int  retry_aligned_read(raid5_con
 	logical_sector = raid_bio->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
 	sector = raid5_compute_sector(	logical_sector,
 					conf->raid_disks,
-					conf->raid_disks-1,
+					conf->raid_disks - conf->max_degraded,
 					&dd_idx,
 					&pd_idx,
 					conf);
