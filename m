Return-Path: <linux-kernel-owner+w=401wt.eu-S932961AbWLSWOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932961AbWLSWOF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933044AbWLSWOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:14:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44940 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933047AbWLSWOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:14:03 -0500
Date: Tue, 19 Dec 2006 17:13:43 -0500 (EST)
Message-Id: <20061219.171343.45747830.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, agk@redhat.com, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com
Cc: j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH 6/8] rqbased-dm: add new target functions
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines new methods for targets which uses
request-based device-mapper:
  - prep_map        : Decide a destination device for the request
                      and return the information to dm core.
                      Also, allocate target internal data if needed.
  - free_context    : Free target internal data.
                      Called when error occurs before dispatching.
  - map_rq          : Map the clone to the device decided in prep_map
  - rq_end_io_first : Check errors of the clone and store internal
                      information in target internal data to pass
                      rq_end_io if needed.
  - rq_end_io       : Free target internal data.

Also, struct dm_map_info is added to pass information between
dm_prep_map_fn() and dm_map_request_fn().


Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

diff -rupN 5-core-init/drivers/md/dm.h 6-add-target-func/drivers/md/dm.h
--- 5-core-init/drivers/md/dm.h	2006-12-15 10:26:43.000000000 -0500
+++ 6-add-target-func/drivers/md/dm.h	2006-12-15 10:42:49.000000000 -0500
@@ -49,6 +49,16 @@ struct dm_dev {
 	char name[16];
 };
 
+/*
+ * Device vector to specify mapping destinations.
+ * Target make this vector in prep_map function.
+ */
+struct dm_map_info {
+//	unsigned num_devs;
+	struct block_device *devs;
+	union map_info map_context;
+};
+
 struct dm_table;
 
 /*-----------------------------------------------------------------
diff -rupN 5-core-init/include/linux/device-mapper.h 6-add-target-func/include/linux/device-mapper.h
--- 5-core-init/include/linux/device-mapper.h	2006-12-15 10:24:52.000000000 -0500
+++ 6-add-target-func/include/linux/device-mapper.h	2006-12-15 10:42:49.000000000 -0500
@@ -10,6 +10,9 @@
 
 #ifdef __KERNEL__
 
+struct request;
+struct request_queue;
+struct dm_map_info;
 struct dm_target;
 struct dm_table;
 struct dm_dev;
@@ -44,6 +47,15 @@ typedef void (*dm_dtr_fn) (struct dm_tar
 typedef int (*dm_map_fn) (struct dm_target *ti, struct bio *bio,
 			  union map_info *map_context);
 
+typedef int (*dm_prep_map_fn) (struct dm_target *ti, struct request *rq,
+			       struct request_queue *q);
+
+typedef int (*dm_map_request_fn) (struct dm_target *ti, struct request *clone,
+				  union map_info *map_context,
+				  struct dm_map_info *mi);
+
+typedef void (*dm_free_context_fn) (struct dm_target *ti, struct request *rq);
+
 /*
  * Returns:
  * < 0 : error (currently ignored)
@@ -55,6 +67,14 @@ typedef int (*dm_endio_fn) (struct dm_ta
 			    struct bio *bio, int error,
 			    union map_info *map_context);
 
+typedef int (*dm_request_endio_first_fn) (struct dm_target *ti,
+					  struct request *clone, int uptodate,
+					  union map_info *map_context);
+
+typedef int (*dm_request_endio_fn) (struct dm_target *ti,
+				    struct request *clone, int error,
+				    union map_info *map_context);
+
 typedef void (*dm_flush_fn) (struct dm_target *ti);
 typedef void (*dm_presuspend_fn) (struct dm_target *ti);
 typedef void (*dm_postsuspend_fn) (struct dm_target *ti);
@@ -96,7 +116,12 @@ struct target_type {
 	dm_ctr_fn ctr;
 	dm_dtr_fn dtr;
 	dm_map_fn map;
+	dm_prep_map_fn prep_map;
+	dm_map_request_fn map_rq;
+	dm_free_context_fn free_context;
 	dm_endio_fn end_io;
+	dm_request_endio_first_fn rq_end_io_first;
+	dm_request_endio_fn rq_end_io;
 	dm_flush_fn flush;
 	dm_presuspend_fn presuspend;
 	dm_postsuspend_fn postsuspend;

