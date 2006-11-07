Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753710AbWKGWML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbWKGWML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbWKGWJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:09:56 -0500
Received: from ns2.suse.de ([195.135.220.15]:42953 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753532AbWKGWJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:09:48 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 8 Nov 2006 09:09:51 +1100
Message-Id: <1061107220951.12549@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: [PATCH 006 of 9] md: Define raid5_mergeable_bvec
References: <20061108085917.12064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>

This will encourage read request to be on only one device,
so we will often be able to bypass the cache for read
requests.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-11-06 11:28:51.000000000 +1100
+++ ./drivers/md/raid5.c	2006-11-06 11:29:13.000000000 +1100
@@ -2611,6 +2611,28 @@ static int raid5_congested(void *data, i
 	return 0;
 }
 
+/* We want read requests to align with chunks where possible,
+ * but write requests don't need to.
+ */
+static int raid5_mergeable_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *biovec)
+{
+	mddev_t *mddev = q->queuedata;
+	sector_t sector = bio->bi_sector + get_start_sect(bio->bi_bdev);
+	int max;
+	unsigned int chunk_sectors = mddev->chunk_size >> 9;
+	unsigned int bio_sectors = bio->bi_size >> 9;
+
+	if (bio_data_dir(bio))
+		return biovec->bv_len; /* always allow writes to be mergeable */
+
+	max =  (chunk_sectors - ((sector & (chunk_sectors - 1)) + bio_sectors)) << 9;
+	if (max < 0) max = 0;
+	if (max <= biovec->bv_len && bio_sectors == 0)
+		return biovec->bv_len;
+	else
+		return max;
+}
+
 static int make_request(request_queue_t *q, struct bio * bi)
 {
 	mddev_t *mddev = q->queuedata;
@@ -3320,6 +3342,8 @@ static int run(mddev_t *mddev)
 	mddev->array_size =  mddev->size * (conf->previous_raid_disks -
 					    conf->max_degraded);
 
+	blk_queue_merge_bvec(mddev->queue, raid5_mergeable_bvec);
+
 	return 0;
 abort:
 	if (conf) {
