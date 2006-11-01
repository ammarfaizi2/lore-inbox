Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946551AbWKAFqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946551AbWKAFqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946553AbWKAFqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:46:45 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:9181 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946551AbWKAFqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:46:24 -0500
Message-Id: <20061101054615.053379000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:40 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Andrew Morton <akpm@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, NeilBrown <neilb@suse.de>,
       Jens Axboe <jens.axboe@oracle.com>
Subject: [PATCH 60/61] md: check bio address after mapping through partitions.
Content-Disposition: inline; filename=check-bio-address-after-mapping-through-partitions.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: NeilBrown <neilb@suse.de>

Partitions are not limited to live within a device.  So
we should range check after partition mapping.

Note that 'maxsector' was being used for two different things.  I have
split off the second usage into 'old_sector' so that maxsector can be
still be used for it's primary usage later in the function.

Cc: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 block/ll_rw_blk.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- linux-2.6.18.1.orig/block/ll_rw_blk.c
+++ linux-2.6.18.1/block/ll_rw_blk.c
@@ -3021,6 +3021,7 @@ void generic_make_request(struct bio *bi
 {
 	request_queue_t *q;
 	sector_t maxsector;
+	sector_t old_sector;
 	int ret, nr_sectors = bio_sectors(bio);
 	dev_t old_dev;
 
@@ -3049,7 +3050,7 @@ void generic_make_request(struct bio *bi
 	 * NOTE: we don't repeat the blk_size check for each new device.
 	 * Stacking drivers are expected to know what they are doing.
 	 */
-	maxsector = -1;
+	old_sector = -1;
 	old_dev = 0;
 	do {
 		char b[BDEVNAME_SIZE];
@@ -3083,15 +3084,30 @@ end_io:
 		 */
 		blk_partition_remap(bio);
 
-		if (maxsector != -1)
+		if (old_sector != -1)
 			blk_add_trace_remap(q, bio, old_dev, bio->bi_sector, 
-					    maxsector);
+					    old_sector);
 
 		blk_add_trace_bio(q, bio, BLK_TA_QUEUE);
 
-		maxsector = bio->bi_sector;
+		old_sector = bio->bi_sector;
 		old_dev = bio->bi_bdev->bd_dev;
 
+		maxsector = bio->bi_bdev->bd_inode->i_size >> 9;
+		if (maxsector) {
+			sector_t sector = bio->bi_sector;
+
+			if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
+				/*
+				 * This may well happen - partitions are not checked
+				 * to make sure they are within the size of the
+				 * whole device.
+				 */
+				handle_bad_sector(bio);
+				goto end_io;
+			}
+		}
+
 		ret = q->make_request_fn(q, bio);
 	} while (ret);
 }

--
