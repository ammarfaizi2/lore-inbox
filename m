Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWIFXLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWIFXLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWIFXCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:02:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:56012 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964990AbWIFXCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:02:10 -0400
Date: Wed, 6 Sep 2006 15:56:41 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, neilb@suse.de, agk@redhat.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 16/37] dm: mirror sector offset fix
Message-ID: <20060906225641.GQ15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-mirror-sector-offset-fix.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Neil Brown <neilb@suse.de>

The device-mapper core does not perform any remapping of bios before passing
them to the targets.  If a particular mapping begins part-way into a device,
targets obtain the sector relative to the start of the mapping by subtracting
ti->begin.

The dm-raid1 target didn't do this everywhere: this patch fixes it, taking
care to subtract ti->begin exactly once for each bio.

[akpm: too late for 2.6.17 - suitable for 2.6.17.x after it has settled]

Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/md/dm-raid1.c |   63 +++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

--- linux-2.6.17.11.orig/drivers/md/dm-raid1.c
+++ linux-2.6.17.11/drivers/md/dm-raid1.c
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

--
