Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWATVNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWATVNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWATVNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:13:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25052 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932194AbWATVNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:13:18 -0500
Date: Fri, 20 Jan 2006 21:13:00 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] device-mapper log bitset: fix endian
Message-ID: <20060120211300.GC4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Caulfield <pcaulfie@redhat.com>

Clean up the code responsible for the on-disk mirror logs by using the
set_le_bit test_le_bit functions of ext2.  That makes the BE machines
keep the bitmap internally in LE order - it does mean you can't use
any other type of operations on the bitmap words but that looks to be
OK in this instance. The efficiency tradeoff is very minimal as you
would expect for something that ext2 uses.

This allows us to remove bits_to_core(), bits_to_disk() and log->disk_bits.

Also increment the mirror log disk version transparently to avoid
sharing with older kernels that suffered from the 64-bit BE bug.

Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc1/drivers/md/dm-log.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm-log.c	2006-01-20 20:06:00.000000000 +0000
+++ linux-2.6.16-rc1/drivers/md/dm-log.c	2006-01-20 20:07:01.000000000 +0000
@@ -112,7 +112,7 @@ void dm_destroy_dirty_log(struct dirty_l
 /*
  * The on-disk version of the metadata.
  */
-#define MIRROR_DISK_VERSION 1
+#define MIRROR_DISK_VERSION 2
 #define LOG_OFFSET 2
 
 struct log_header {
@@ -157,7 +157,6 @@ struct log_c {
 	struct log_header *disk_header;
 
 	struct io_region bits_location;
-	uint32_t *disk_bits;
 };
 
 /*
@@ -166,20 +165,20 @@ struct log_c {
  */
 static  inline int log_test_bit(uint32_t *bs, unsigned bit)
 {
-	return test_bit(bit, (unsigned long *) bs) ? 1 : 0;
+	return ext2_test_bit(bit, (unsigned long *) bs) ? 1 : 0;
 }
 
 static inline void log_set_bit(struct log_c *l,
 			       uint32_t *bs, unsigned bit)
 {
-	set_bit(bit, (unsigned long *) bs);
+	ext2_set_bit(bit, (unsigned long *) bs);
 	l->touched = 1;
 }
 
 static inline void log_clear_bit(struct log_c *l,
 				 uint32_t *bs, unsigned bit)
 {
-	clear_bit(bit, (unsigned long *) bs);
+	ext2_clear_bit(bit, (unsigned long *) bs);
 	l->touched = 1;
 }
 
@@ -219,6 +218,11 @@ static int read_header(struct log_c *log
 		log->header.nr_regions = 0;
 	}
 
+#ifdef __LITTLE_ENDIAN
+	if (log->header.version == 1)
+		log->header.version = 2;
+#endif
+
 	if (log->header.version != MIRROR_DISK_VERSION) {
 		DMWARN("incompatible disk log version");
 		return -EINVAL;
@@ -239,45 +243,24 @@ static inline int write_header(struct lo
 /*----------------------------------------------------------------
  * Bits IO
  *--------------------------------------------------------------*/
-static inline void bits_to_core(uint32_t *core, uint32_t *disk, unsigned count)
-{
-	unsigned i;
-
-	for (i = 0; i < count; i++)
-		core[i] = le32_to_cpu(disk[i]);
-}
-
-static inline void bits_to_disk(uint32_t *core, uint32_t *disk, unsigned count)
-{
-	unsigned i;
-
-	/* copy across the clean/dirty bitset */
-	for (i = 0; i < count; i++)
-		disk[i] = cpu_to_le32(core[i]);
-}
-
 static int read_bits(struct log_c *log)
 {
 	int r;
 	unsigned long ebits;
 
 	r = dm_io_sync_vm(1, &log->bits_location, READ,
-			  log->disk_bits, &ebits);
+			  log->clean_bits, &ebits);
 	if (r)
 		return r;
 
-	bits_to_core(log->clean_bits, log->disk_bits,
-		     log->bitset_uint32_count);
 	return 0;
 }
 
 static int write_bits(struct log_c *log)
 {
 	unsigned long ebits;
-	bits_to_disk(log->clean_bits, log->disk_bits,
-		     log->bitset_uint32_count);
 	return dm_io_sync_vm(1, &log->bits_location, WRITE,
-			     log->disk_bits, &ebits);
+			     log->clean_bits, &ebits);
 }
 
 /*----------------------------------------------------------------
@@ -433,11 +416,6 @@ static int disk_ctr(struct dirty_log *lo
 	size = dm_round_up(lc->bitset_uint32_count * sizeof(uint32_t),
 			   1 << SECTOR_SHIFT);
 	lc->bits_location.count = size >> SECTOR_SHIFT;
-	lc->disk_bits = vmalloc(size);
-	if (!lc->disk_bits) {
-		vfree(lc->disk_header);
-		goto bad;
-	}
 	return 0;
 
  bad:
@@ -451,7 +429,6 @@ static void disk_dtr(struct dirty_log *l
 	struct log_c *lc = (struct log_c *) log->context;
 	dm_put_device(lc->ti, lc->log_dev);
 	vfree(lc->disk_header);
-	vfree(lc->disk_bits);
 	core_dtr(log);
 }
 
