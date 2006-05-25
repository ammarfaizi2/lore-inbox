Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWEYT3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWEYT3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWEYT3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:29:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10133 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030363AbWEYT3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:29:36 -0400
Date: Thu, 25 May 2006 20:29:31 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] dm: mirror sector offset fix
Message-ID: <20060525192931.GB4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Brown <neilb@suse.de>

The device-mapper core does not perform any remapping of bios before 
passing them to the targets.  If a particular mapping begins part-way
into a device, targets obtain the sector relative to the start of the
mapping by subtracting ti->begin.

The dm-raid1 target didn't do this everywhere: this patch fixes it, taking
care to subtract ti->begin exactly once for each bio.

Signed-off-by: Neil Brown <neilb@suse.de>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17-rc4/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/md/dm-raid1.c	2006-05-23 17:05:30.000000000 +0100
+++ linux-2.6.17-rc4/drivers/md/dm-raid1.c	2006-05-23 21:53:42.000000000 +0100
@@ -106,12 +106,42 @@ struct region {
 	struct bio_list delayed_bios;
 };
 
+
+/*-----------------------------------------------------------------
+ * Mirror set structures.
+ *---------------------------------------------------------------*/
+struct mirror {
+	atomic_t error_count;
+	struct dm_dev *dev;
+	sector_t offset;
+};
+
+struct mirror_set {
+	struct dm_target *ti;
+	struct list_head list;
+	struct region_hash rh;
+	struct kcopyd_client *kcopyd_client;
+
+	spinlock_t lock;	/* protects the next two lists */
+	struct bio_list reads;
+	struct bio_list writes;
+
+	/* recovery */
+	region_t nr_regions;
+	int in_sync;
+
+	struct mirror *default_mirror;	/* Default mirror */
+
+	unsigned int nr_mirrors;
+	struct mirror mirror[0];
+};
+
 /*
  * Conversion fns
  */
 static inline region_t bio_to_region(struct region_hash *rh, struct bio *bio)
 {
-	return bio->bi_sector >> rh->region_shift;
+	return (bio->bi_sector - rh->ms->ti->begin) >> rh->region_shift;
 }
 
 static inline sector_t region_to_sector(struct region_hash *rh, region_t region)
@@ -541,35 +571,6 @@ static void rh_start_recovery(struct reg
 	wake();
 }
 
-/*-----------------------------------------------------------------
- * Mirror set structures.
- *---------------------------------------------------------------*/
-struct mirror {
-	atomic_t error_count;
-	struct dm_dev *dev;
-	sector_t offset;
-};
-
-struct mirror_set {
-	struct dm_target *ti;
-	struct list_head list;
-	struct region_hash rh;
-	struct kcopyd_client *kcopyd_client;
-
-	spinlock_t lock;	/* protects the next two lists */
-	struct bio_list reads;
-	struct bio_list writes;
-
-	/* recovery */
-	region_t nr_regions;
-	int in_sync;
-
-	struct mirror *default_mirror;	/* Default mirror */
-
-	unsigned int nr_mirrors;
-	struct mirror mirror[0];
-};
-
 /*
  * Every mirror should look like this one.
  */
@@ -1115,7 +1116,7 @@ static int mirror_map(struct dm_target *
 	struct mirror *m;
 	struct mirror_set *ms = ti->private;
 
-	map_context->ll = bio->bi_sector >> ms->rh.region_shift;
+	map_context->ll = bio_to_region(&ms->rh, bio);
 
 	if (rw == WRITE) {
 		queue_bio(ms, bio, rw);
