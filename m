Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUIUQ27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUIUQ27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 12:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUIUQ27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 12:28:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39307 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267818AbUIUQ12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 12:27:28 -0400
Date: Tue, 21 Sep 2004 17:27:17 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2/2: device-mapper: mirror log sync optional
Message-ID: <20040921162717.GF11810@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make mirror log synchronization optional.

From: Heinz Mauelshagen <mauelshagen@redhat.com>

--- diff/drivers/md/dm-log.c	2004-09-20 20:41:10.000000000 +0100
+++ source/drivers/md/dm-log.c	2004-09-21 16:37:00.000000000 +0100
@@ -140,6 +140,13 @@
 
 	int sync_search;
 
+	/* Resync flag */
+	enum sync {
+		DEFAULTSYNC,	/* Synchronize if necessary */
+		NOSYNC,		/* Devices known to be already in sync */
+		FORCESYNC,	/* Force a sync to happen */
+	} sync;
+
 	/*
 	 * Disk log fields
 	 */
@@ -205,7 +212,8 @@
 
 	header_from_disk(&log->header, log->disk_header);
 
-	if (log->header.magic != MIRROR_MAGIC) {
+	/* New log required? */
+	if (log->sync != DEFAULTSYNC || log->header.magic != MIRROR_MAGIC) {
 		log->header.magic = MIRROR_MAGIC;
 		log->header.version = MIRROR_DISK_VERSION;
 		log->header.nr_regions = 0;
@@ -273,22 +281,38 @@
 }
 
 /*----------------------------------------------------------------
- * constructor/destructor
+ * core log constructor/destructor
+ *
+ * argv contains region_size followed optionally by [no]sync
  *--------------------------------------------------------------*/
 #define BYTE_SHIFT 3
 static int core_ctr(struct dirty_log *log, struct dm_target *ti,
 		    unsigned int argc, char **argv)
 {
+	enum sync sync = DEFAULTSYNC;
+
 	struct log_c *lc;
 	sector_t region_size;
 	unsigned int region_count;
 	size_t bitset_size;
 
-	if (argc != 1) {
-		DMWARN("wrong number of arguments to log_c");
+	if (argc < 1 || argc > 2) {
+		DMWARN("wrong number of arguments to mirror log");
 		return -EINVAL;
 	}
 
+	if (argc > 1) {
+		if (!strcmp(argv[1], "sync"))
+			sync = FORCESYNC;
+		else if (!strcmp(argv[1], "nosync"))
+			sync = NOSYNC;
+		else {
+			DMWARN("unrecognised sync argument to mirror log: %s",
+			       argv[1]);
+			return -EINVAL;
+		}
+	}
+
 	if (sscanf(argv[0], SECTOR_FORMAT, &region_size) != 1) {
 		DMWARN("invalid region size string");
 		return -EINVAL;
@@ -306,6 +330,7 @@
 	lc->touched = 0;
 	lc->region_size = region_size;
 	lc->region_count = region_count;
+	lc->sync = sync;
 
 	/*
 	 * Work out how many words we need to hold the bitset.
@@ -330,8 +355,8 @@
 		kfree(lc);
 		return -ENOMEM;
 	}
-	memset(lc->sync_bits, 0, bitset_size);
-        lc->sync_count = 0;
+	memset(lc->sync_bits, (sync == NOSYNC) ? -1 : 0, bitset_size);
+	lc->sync_count = (sync == NOSYNC) ? region_count : 0;
 
 	lc->recovering_bits = vmalloc(bitset_size);
 	if (!lc->recovering_bits) {
@@ -356,6 +381,11 @@
 	kfree(lc);
 }
 
+/*----------------------------------------------------------------
+ * disk log constructor/destructor
+ *
+ * argv contains log_device region_size followed optionally by [no]sync
+ *--------------------------------------------------------------*/
 static int disk_ctr(struct dirty_log *log, struct dm_target *ti,
 		    unsigned int argc, char **argv)
 {
@@ -364,8 +394,8 @@
 	struct log_c *lc;
 	struct dm_dev *dev;
 
-	if (argc != 2) {
-		DMWARN("wrong number of arguments to log_d");
+	if (argc < 2 || argc > 3) {
+		DMWARN("wrong number of arguments to disk mirror log");
 		return -EINVAL;
 	}
 
@@ -452,10 +482,15 @@
 	if (r)
 		return r;
 
-	/* zero any new bits if the mirror has grown */
-	for (i = lc->header.nr_regions; i < lc->region_count; i++)
-		/* FIXME: amazingly inefficient */
-		log_clear_bit(lc, lc->clean_bits, i);
+	/* set or clear any new bits */
+	if (lc->sync == NOSYNC)
+		for (i = lc->header.nr_regions; i < lc->region_count; i++)
+			/* FIXME: amazingly inefficient */
+			log_set_bit(lc, lc->clean_bits, i);
+	else
+		for (i = lc->header.nr_regions; i < lc->region_count; i++)
+			/* FIXME: amazingly inefficient */
+			log_clear_bit(lc, lc->clean_bits, i);
 
 	/* copy clean across to sync */
 	memcpy(lc->sync_bits, lc->clean_bits, size);
@@ -566,6 +601,51 @@
         return lc->sync_count;
 }
 
+#define	DMEMIT_SYNC \
+	if (lc->sync != DEFAULTSYNC) \
+		DMEMIT("%ssync ", lc->sync == NOSYNC ? "no" : "")
+
+static int core_status(struct dirty_log *log, status_type_t status,
+		       char *result, unsigned int maxlen)
+{
+	int sz = 0;
+	struct log_c *lc = log->context;
+
+	switch(status) {
+	case STATUSTYPE_INFO:
+		break;
+
+	case STATUSTYPE_TABLE:
+		DMEMIT("%s %u " SECTOR_FORMAT " ", log->type->name,
+		       lc->sync == DEFAULTSYNC ? 1 : 2, lc->region_size);
+		DMEMIT_SYNC;
+	}
+
+	return sz;
+}
+
+static int disk_status(struct dirty_log *log, status_type_t status,
+		       char *result, unsigned int maxlen)
+{
+	int sz = 0;
+	char buffer[16];
+	struct log_c *lc = log->context;
+	
+	switch(status) {
+	case STATUSTYPE_INFO:
+		break;
+
+	case STATUSTYPE_TABLE:
+		format_dev_t(buffer, lc->log_dev->bdev->bd_dev);
+		DMEMIT("%s %u %s " SECTOR_FORMAT " ", log->type->name,
+		       lc->sync == DEFAULTSYNC ? 2 : 3, buffer,
+		       lc->region_size);
+		DMEMIT_SYNC;
+	}
+
+	return sz;
+}
+
 static struct dirty_log_type _core_type = {
 	.name = "core",
 	.module = THIS_MODULE,
@@ -579,7 +659,8 @@
 	.clear_region = core_clear_region,
 	.get_resync_work = core_get_resync_work,
 	.complete_resync_work = core_complete_resync_work,
-        .get_sync_count = core_get_sync_count
+	.get_sync_count = core_get_sync_count,
+	.status = core_status,
 };
 
 static struct dirty_log_type _disk_type = {
@@ -597,7 +678,8 @@
 	.clear_region = core_clear_region,
 	.get_resync_work = core_get_resync_work,
 	.complete_resync_work = core_complete_resync_work,
-        .get_sync_count = core_get_sync_count
+	.get_sync_count = core_get_sync_count,
+	.status = disk_status,
 };
 
 int __init dm_dirty_log_init(void)
--- diff/drivers/md/dm-log.h	2004-09-20 20:41:10.000000000 +0100
+++ source/drivers/md/dm-log.h	2004-09-21 16:37:00.000000000 +0100
@@ -101,6 +101,12 @@
 	 * Returns the number of regions that are in sync.
          */
         region_t (*get_sync_count)(struct dirty_log *log);
+
+	/*
+	 * Support function for mirror status requests.
+	 */
+	int (*status)(struct dirty_log *log, status_type_t status_type,
+		      char *result, unsigned int maxlen);
 };
 
 int dm_register_dirty_log_type(struct dirty_log_type *type);
--- diff/drivers/md/dm-raid1.c	2004-09-21 16:35:39.000000000 +0100
+++ source/drivers/md/dm-raid1.c	2004-09-21 16:37:00.000000000 +0100
@@ -1009,8 +1009,8 @@
  * log_type #log_params <log_params>
  * #mirrors [mirror_path offset]{2,}
  *
- * For now, #log_params = 1, log_type = "core"
- *
+ * log_type is "core" or "disk"
+ * #log_params is between 1 and 3
  */
 #define DM_IO_PAGES 64
 static int mirror_ctr(struct dm_target *ti, unsigned int argc, char **argv)
@@ -1182,13 +1182,14 @@
 			 char *result, unsigned int maxlen)
 {
 	char buffer[32];
-	unsigned int m, sz = 0;
+	unsigned int m, sz;
 	struct mirror_set *ms = (struct mirror_set *) ti->private;
 
+	sz = ms->rh.log->type->status(ms->rh.log, type, result, maxlen);
+
 	switch (type) {
 	case STATUSTYPE_INFO:
 		DMEMIT("%d ", ms->nr_mirrors);
-
 		for (m = 0; m < ms->nr_mirrors; m++) {
 			format_dev_t(buffer, ms->mirror[m].dev->bdev->bd_dev);
 			DMEMIT("%s ", buffer);
@@ -1200,10 +1201,7 @@
 		break;
 
 	case STATUSTYPE_TABLE:
-		DMEMIT("%s 1 " SECTOR_FORMAT " %d ",
-		       ms->rh.log->type->name, ms->rh.region_size,
-		       ms->nr_mirrors);
-
+		DMEMIT("%d ", ms->nr_mirrors);
 		for (m = 0; m < ms->nr_mirrors; m++) {
 			format_dev_t(buffer, ms->mirror[m].dev->bdev->bd_dev);
 			DMEMIT("%s " SECTOR_FORMAT " ",
