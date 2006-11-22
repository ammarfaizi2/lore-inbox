Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756578AbWKVTBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578AbWKVTBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756580AbWKVTBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:01:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48288 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756578AbWKVTBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:01:34 -0500
Date: Wed, 22 Nov 2006 19:01:28 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Subject: [PATCH 04/11] dm: map and endio return code clarification
Message-ID: <20061122190128.GU6993@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com,
	Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>

This patch tightens the use of return values from the target map and end_io
functions.  Values of 2 and above are now explictly reserved for future use.
There are no existing targets using such values.

The patch has no effect on existing behaviour.


o Reserve return values of 2 and above from target map functions.
  Any positive value currently indicates "mapping complete", but all
  existing drivers use the value 1.  We now make that a requirement
  so we can assign new meaning to higher values in future.

  The new definition of return values from target map functions is:
      < 0 : error
      = 0 : The target will handle the io (DM_MAPIO_SUBMITTED).
      = 1 : Mapping completed (DM_MAPIO_REMAPPED).
      > 1 : Reserved (undefined).  Previously this was the same as '= 1'.

o Reserve return values of 2 and above from target end_io functions
  for similar reasons.
  DM_ENDIO_INCOMPLETE is introduced for a return value of 1.


Test results:

  I have tested by using the multipath target.

  I/Os succeed when valid paths exist.

  I/Os are queued in the multipath target when there are no valid paths and
queue_if_no_path is set.

  I/Os fail when there are no valid paths and queue_if_no_path is not set.


Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com

Index: linux-2.6.19-rc6/drivers/md/dm.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm.c	2006-11-22 17:26:57.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm.c	2006-11-22 17:26:58.000000000 +0000
@@ -482,9 +482,13 @@ static int clone_endio(struct bio *bio, 
 		r = endio(tio->ti, bio, error, &tio->info);
 		if (r < 0)
 			error = r;
-		else if (r > 0)
-			/* the target wants another shot at the io */
+		else if (r == DM_ENDIO_INCOMPLETE)
+			/* The target will handle the io */
 			return 1;
+		else if (r) {
+			DMWARN("unimplemented target endio return value: %d", r);
+			BUG();
+		}
 	}
 
 	dec_pending(tio->io, error);
@@ -542,7 +546,7 @@ static void __map_bio(struct dm_target *
 	atomic_inc(&tio->io->io_count);
 	sector = clone->bi_sector;
 	r = ti->type->map(ti, clone, &tio->info);
-	if (r > 0) {
+	if (r == DM_MAPIO_REMAPPED) {
 		/* the bio has been remapped so dispatch it */
 
 		blk_add_trace_remap(bdev_get_queue(clone->bi_bdev), clone,
@@ -560,6 +564,9 @@ static void __map_bio(struct dm_target *
 		clone->bi_private = md->bs;
 		bio_put(clone);
 		free_tio(md, tio);
+	} else if (r) {
+		DMWARN("unimplemented target map return value: %d", r);
+		BUG();
 	}
 }
 
Index: linux-2.6.19-rc6/drivers/md/dm.h
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm.h	2006-11-22 17:26:57.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm.h	2006-11-22 17:26:58.000000000 +0000
@@ -33,6 +33,17 @@
 #define SECTOR_SHIFT 9
 
 /*
+ * Definitions of return values from target end_io function.
+ */
+#define DM_ENDIO_INCOMPLETE	1
+
+/*
+ * Definitions of return values from target map function.
+ */
+#define DM_MAPIO_SUBMITTED	0
+#define DM_MAPIO_REMAPPED	1
+
+/*
  * Suspend feature flags
  */
 #define DM_SUSPEND_LOCKFS_FLAG		(1 << 0)
Index: linux-2.6.19-rc6/include/linux/device-mapper.h
===================================================================
--- linux-2.6.19-rc6.orig/include/linux/device-mapper.h	2006-11-22 17:26:57.000000000 +0000
+++ linux-2.6.19-rc6/include/linux/device-mapper.h	2006-11-22 17:26:58.000000000 +0000
@@ -39,7 +39,7 @@ typedef void (*dm_dtr_fn) (struct dm_tar
  * The map function must return:
  * < 0: error
  * = 0: The target will handle the io by resubmitting it later
- * > 0: simple remap complete
+ * = 1: simple remap complete
  */
 typedef int (*dm_map_fn) (struct dm_target *ti, struct bio *bio,
 			  union map_info *map_context);
