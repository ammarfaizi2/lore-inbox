Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbWFUTfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWFUTfb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWFUTf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:35:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29604 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932694AbWFUTfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:35:13 -0400
Date: Wed, 21 Jun 2006 20:34:58 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Kevin Corry <kevcorry@us.ibm.com>
Subject: [PATCH 06/15] dm mirror log: refactor context
Message-ID: <20060621193458.GU4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Kevin Corry <kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code that creates the core and disk log contexts to avoid
the repeated allocation of clean_bits introduced by the last patch.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm-log.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-log.c	2006-06-21 17:17:49.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-log.c	2006-06-21 17:17:55.000000000 +0100
@@ -244,15 +244,16 @@ static inline int write_header(struct lo
  * argv contains region_size followed optionally by [no]sync
  *--------------------------------------------------------------*/
 #define BYTE_SHIFT 3
-static int core_ctr(struct dirty_log *log, struct dm_target *ti,
-		    unsigned int argc, char **argv)
+static int create_log_context(struct dirty_log *log, struct dm_target *ti,
+			      unsigned int argc, char **argv,
+			      struct dm_dev *dev)
 {
 	enum sync sync = DEFAULTSYNC;
 
 	struct log_c *lc;
 	uint32_t region_size;
 	unsigned int region_count;
-	size_t bitset_size;
+	size_t bitset_size, buf_size;
 
 	if (argc < 1 || argc > 2) {
 		DMWARN("wrong number of arguments to mirror log");
@@ -298,18 +299,49 @@ static int core_ctr(struct dirty_log *lo
 	bitset_size >>= BYTE_SHIFT;
 
 	lc->bitset_uint32_count = bitset_size / 4;
-	lc->clean_bits = vmalloc(bitset_size);
-	if (!lc->clean_bits) {
-		DMWARN("couldn't allocate clean bitset");
-		kfree(lc);
-		return -ENOMEM;
+
+	/*
+	 * Disk log?
+	 */
+	if (!dev) {
+		lc->clean_bits = vmalloc(bitset_size);
+		if (!lc->clean_bits) {
+			DMWARN("couldn't allocate clean bitset");
+			kfree(lc);
+			return -ENOMEM;
+		}
+		lc->disk_header = NULL;
+	} else {
+		lc->log_dev = dev;
+		lc->header_location.bdev = lc->log_dev->bdev;
+		lc->header_location.sector = 0;
+
+		/*
+		 * Buffer holds both header and bitset.
+		 */
+		buf_size = dm_round_up((LOG_OFFSET << SECTOR_SHIFT) +
+				       bitset_size, ti->limits.hardsect_size);
+		lc->header_location.count = buf_size >> SECTOR_SHIFT;
+
+		lc->disk_header = vmalloc(buf_size);
+		if (!lc->disk_header) {
+			DMWARN("couldn't allocate disk log buffer");
+			kfree(lc);
+			return -ENOMEM;
+		}
+
+		lc->clean_bits = (void *)lc->disk_header +
+				 (LOG_OFFSET << SECTOR_SHIFT);
 	}
+
 	memset(lc->clean_bits, -1, bitset_size);
 
 	lc->sync_bits = vmalloc(bitset_size);
 	if (!lc->sync_bits) {
 		DMWARN("couldn't allocate sync bitset");
-		vfree(lc->clean_bits);
+		if (!dev)
+			vfree(lc->clean_bits);
+		vfree(lc->disk_header);
 		kfree(lc);
 		return -ENOMEM;
 	}
@@ -320,25 +352,40 @@ static int core_ctr(struct dirty_log *lo
 	if (!lc->recovering_bits) {
 		DMWARN("couldn't allocate sync bitset");
 		vfree(lc->sync_bits);
-		vfree(lc->clean_bits);
+		if (!dev)
+			vfree(lc->clean_bits);
+		vfree(lc->disk_header);
 		kfree(lc);
 		return -ENOMEM;
 	}
 	memset(lc->recovering_bits, 0, bitset_size);
 	lc->sync_search = 0;
 	log->context = lc;
+
 	return 0;
 }
 
-static void core_dtr(struct dirty_log *log)
+static int core_ctr(struct dirty_log *log, struct dm_target *ti,
+		    unsigned int argc, char **argv)
+{
+	return create_log_context(log, ti, argc, argv, NULL);
+}
+
+static void destroy_log_context(struct log_c *lc)
 {
-	struct log_c *lc = (struct log_c *) log->context;
-	vfree(lc->clean_bits);
 	vfree(lc->sync_bits);
 	vfree(lc->recovering_bits);
 	kfree(lc);
 }
 
+static void core_dtr(struct dirty_log *log)
+{
+	struct log_c *lc = (struct log_c *) log->context;
+
+	vfree(lc->clean_bits);
+	destroy_log_context(lc);
+}
+
 /*----------------------------------------------------------------
  * disk log constructor/destructor
  *
@@ -348,10 +395,7 @@ static int disk_ctr(struct dirty_log *lo
 		    unsigned int argc, char **argv)
 {
 	int r;
-	size_t size, bitset_size;
-	struct log_c *lc;
 	struct dm_dev *dev;
-	uint32_t *clean_bits;
 
 	if (argc < 2 || argc > 3) {
 		DMWARN("wrong number of arguments to disk mirror log");
@@ -363,53 +407,22 @@ static int disk_ctr(struct dirty_log *lo
 	if (r)
 		return r;
 
-	r = core_ctr(log, ti, argc - 1, argv + 1);
+	r = create_log_context(log, ti, argc - 1, argv + 1, dev);
 	if (r) {
 		dm_put_device(ti, dev);
 		return r;
 	}
 
-	lc = (struct log_c *) log->context;
-	lc->log_dev = dev;
-
-	/* setup the disk header fields */
-	lc->header_location.bdev = lc->log_dev->bdev;
-	lc->header_location.sector = 0;
-
-	/* Include both the header and the bitset in one buffer. */
-	bitset_size = lc->bitset_uint32_count * sizeof(uint32_t);
-	size = dm_round_up((LOG_OFFSET << SECTOR_SHIFT) + bitset_size,
-			   ti->limits.hardsect_size);
-	lc->header_location.count = size >> SECTOR_SHIFT;
-
-	lc->disk_header = vmalloc(size);
-	if (!lc->disk_header)
-		goto bad;
-
-	/*
-	 * Deallocate the clean_bits buffer that was allocated in core_ctr()
-	 * and point it at the appropriate place in the disk_header buffer.
-	 */
-	clean_bits = lc->clean_bits;
-	lc->clean_bits = (void *)lc->disk_header + (LOG_OFFSET << SECTOR_SHIFT);
-	memcpy(lc->clean_bits, clean_bits, bitset_size);
-	vfree(clean_bits);
-
 	return 0;
-
- bad:
-	dm_put_device(ti, lc->log_dev);
-	core_dtr(log);
-	return -ENOMEM;
 }
 
 static void disk_dtr(struct dirty_log *log)
 {
 	struct log_c *lc = (struct log_c *) log->context;
+
 	dm_put_device(lc->ti, lc->log_dev);
 	vfree(lc->disk_header);
-	lc->clean_bits = NULL;
-	core_dtr(log);
+	destroy_log_context(lc);
 }
 
 static int count_bits32(uint32_t *addr, unsigned size)
