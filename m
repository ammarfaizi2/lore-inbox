Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVBHQud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVBHQud (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVBHQud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:50:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29355 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261559AbVBHQtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:49:06 -0500
Date: Tue, 8 Feb 2005 16:48:54 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lmb@suse.de
Subject: [PATCH] device-mapper: Store name directly against device
Message-ID: <20050208164854.GS10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	lmb@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a name field to struct dm_dev so we don't have to use 
format_dev_t() all over the place for informative error messages.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
From: Lars Marowsky-Bree <lmb@suse.de>
--- diff/drivers/md/dm-crypt.c	2005-02-08 16:38:49.000000000 +0000
+++ source/drivers/md/dm-crypt.c	2005-02-08 16:39:46.000000000 +0000
@@ -869,7 +869,6 @@
 			char *result, unsigned int maxlen)
 {
 	struct crypt_config *cc = (struct crypt_config *) ti->private;
-	char buffer[32];
 	const char *cipher;
 	const char *chainmode = NULL;
 	unsigned int sz = 0;
@@ -910,9 +909,8 @@
 			result[sz++] = '-';
 		}
 
-		format_dev_t(buffer, cc->dev->bdev->bd_dev);
 		DMEMIT(" " SECTOR_FORMAT " %s " SECTOR_FORMAT,
-		       cc->iv_offset, buffer, cc->start);
+		       cc->iv_offset, cc->dev->name, cc->start);
 		break;
 	}
 	return 0;
--- diff/drivers/md/dm-linear.c	2005-02-07 15:30:59.000000000 +0000
+++ source/drivers/md/dm-linear.c	2005-02-08 16:39:46.000000000 +0000
@@ -80,7 +80,6 @@
 			 char *result, unsigned int maxlen)
 {
 	struct linear_c *lc = (struct linear_c *) ti->private;
-	char buffer[32];
 
 	switch (type) {
 	case STATUSTYPE_INFO:
@@ -88,8 +87,8 @@
 		break;
 
 	case STATUSTYPE_TABLE:
-		format_dev_t(buffer, lc->dev->bdev->bd_dev);
-		snprintf(result, maxlen, "%s " SECTOR_FORMAT, buffer, lc->start);
+		snprintf(result, maxlen, "%s " SECTOR_FORMAT, lc->dev->name,
+			 lc->start);
 		break;
 	}
 	return 0;
--- diff/drivers/md/dm-raid1.c	2005-02-08 16:38:49.000000000 +0000
+++ source/drivers/md/dm-raid1.c	2005-02-08 16:39:46.000000000 +0000
@@ -1182,7 +1182,6 @@
 static int mirror_status(struct dm_target *ti, status_type_t type,
 			 char *result, unsigned int maxlen)
 {
-	char buffer[32];
 	unsigned int m, sz;
 	struct mirror_set *ms = (struct mirror_set *) ti->private;
 
@@ -1191,10 +1190,8 @@
 	switch (type) {
 	case STATUSTYPE_INFO:
 		DMEMIT("%d ", ms->nr_mirrors);
-		for (m = 0; m < ms->nr_mirrors; m++) {
-			format_dev_t(buffer, ms->mirror[m].dev->bdev->bd_dev);
-			DMEMIT("%s ", buffer);
-		}
+		for (m = 0; m < ms->nr_mirrors; m++)
+			DMEMIT("%s ", ms->mirror[m].dev->name);
 
 		DMEMIT(SECTOR_FORMAT "/" SECTOR_FORMAT,
 		       ms->rh.log->type->get_sync_count(ms->rh.log),
@@ -1203,11 +1200,9 @@
 
 	case STATUSTYPE_TABLE:
 		DMEMIT("%d ", ms->nr_mirrors);
-		for (m = 0; m < ms->nr_mirrors; m++) {
-			format_dev_t(buffer, ms->mirror[m].dev->bdev->bd_dev);
+		for (m = 0; m < ms->nr_mirrors; m++)
 			DMEMIT("%s " SECTOR_FORMAT " ",
-			       buffer, ms->mirror[m].offset);
-		}
+			       ms->mirror[m].dev->name, ms->mirror[m].offset);
 	}
 
 	return 0;
--- diff/drivers/md/dm-snap.c	2005-02-07 15:30:59.000000000 +0000
+++ source/drivers/md/dm-snap.c	2005-02-08 16:39:46.000000000 +0000
@@ -864,8 +864,6 @@
 			   char *result, unsigned int maxlen)
 {
 	struct dm_snapshot *snap = (struct dm_snapshot *) ti->private;
-	char cow[32];
-	char org[32];
 
 	switch (type) {
 	case STATUSTYPE_INFO:
@@ -892,9 +890,8 @@
 		 * to make private copies if the output is to
 		 * make sense.
 		 */
-		format_dev_t(cow, snap->cow->bdev->bd_dev);
-		format_dev_t(org, snap->origin->bdev->bd_dev);
-		snprintf(result, maxlen, "%s %s %c " SECTOR_FORMAT, org, cow,
+		snprintf(result, maxlen, "%s %s %c " SECTOR_FORMAT,
+			 snap->origin->name, snap->cow->name,
 			 snap->type, snap->chunk_size);
 		break;
 	}
@@ -1082,7 +1079,6 @@
 			 unsigned int maxlen)
 {
 	struct dm_dev *dev = (struct dm_dev *) ti->private;
-	char buffer[32];
 
 	switch (type) {
 	case STATUSTYPE_INFO:
@@ -1090,8 +1086,7 @@
 		break;
 
 	case STATUSTYPE_TABLE:
-		format_dev_t(buffer, dev->bdev->bd_dev);
-		snprintf(result, maxlen, "%s", buffer);
+		snprintf(result, maxlen, "%s", dev->name);
 		break;
 	}
 
--- diff/drivers/md/dm-stripe.c	2005-02-08 16:37:51.000000000 +0000
+++ source/drivers/md/dm-stripe.c	2005-02-08 16:39:46.000000000 +0000
@@ -188,7 +188,6 @@
 	struct stripe_c *sc = (struct stripe_c *) ti->private;
 	unsigned int sz = 0;
 	unsigned int i;
-	char buffer[32];
 
 	switch (type) {
 	case STATUSTYPE_INFO:
@@ -197,11 +196,9 @@
 
 	case STATUSTYPE_TABLE:
 		DMEMIT("%d " SECTOR_FORMAT, sc->stripes, sc->chunk_mask + 1);
-		for (i = 0; i < sc->stripes; i++) {
-			format_dev_t(buffer, sc->stripe[i].dev->bdev->bd_dev);
-			DMEMIT(" %s " SECTOR_FORMAT, buffer,
+		for (i = 0; i < sc->stripes; i++)
+			DMEMIT(" %s " SECTOR_FORMAT, sc->stripe[i].dev->name,
 			       sc->stripe[i].physical_start);
-		}
 		break;
 	}
 	return 0;
--- diff/drivers/md/dm-table.c	2005-02-08 16:38:49.000000000 +0000
+++ source/drivers/md/dm-table.c	2005-02-08 16:39:46.000000000 +0000
@@ -455,6 +455,8 @@
 			return r;
 		}
 
+		format_dev_t(dd->name, dev);
+
 		atomic_set(&dd->count, 0);
 		list_add(&dd->list, &t->devices);
 
--- diff/drivers/md/dm.h	2005-02-08 16:39:17.000000000 +0000
+++ source/drivers/md/dm.h	2005-02-08 16:39:46.000000000 +0000
@@ -44,6 +44,7 @@
 	atomic_t count;
 	int mode;
 	struct block_device *bdev;
+	char name[16];
 };
 
 struct dm_table;
