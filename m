Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWINVwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWINVwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWINVwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:52:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63194 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751247AbWINVwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:52:54 -0400
Date: Thu, 14 Sep 2006 22:52:43 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Bryn Reeves <breeves@redhat.com>
Subject: [PATCH 24/25] dm: extract device limit setting
Message-ID: <20060914215243.GE3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Bryn Reeves <breeves@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryn Reeves <breeves@redhat.com>

Separate the setting of device I/O limits from dm_get_device().
dm-loop will use this.

Signed-off-by: Bryn Reeves <breeves@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-table.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-table.c	2006-09-14 21:03:16.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-table.c	2006-09-14 21:36:09.000000000 +0100
@@ -522,56 +522,61 @@ static int __table_get_device(struct dm_
 	return 0;
 }
 
+void dm_set_device_limits(struct dm_target *ti, struct block_device *bdev)
+{
+	request_queue_t *q = bdev_get_queue(bdev);
+	struct io_restrictions *rs = &ti->limits;
+
+	/*
+	 * Combine the device limits low.
+	 *
+	 * FIXME: if we move an io_restriction struct
+	 *        into q this would just be a call to
+	 *        combine_restrictions_low()
+	 */
+	rs->max_sectors =
+		min_not_zero(rs->max_sectors, q->max_sectors);
+
+	/* FIXME: Device-Mapper on top of RAID-0 breaks because DM
+	 *        currently doesn't honor MD's merge_bvec_fn routine.
+	 *        In this case, we'll force DM to use PAGE_SIZE or
+	 *        smaller I/O, just to be safe. A better fix is in the
+	 *        works, but add this for the time being so it will at
+	 *        least operate correctly.
+	 */
+	if (q->merge_bvec_fn)
+		rs->max_sectors =
+			min_not_zero(rs->max_sectors,
+				     (unsigned int) (PAGE_SIZE >> 9));
+
+	rs->max_phys_segments =
+		min_not_zero(rs->max_phys_segments,
+			     q->max_phys_segments);
+
+	rs->max_hw_segments =
+		min_not_zero(rs->max_hw_segments, q->max_hw_segments);
+
+	rs->hardsect_size = max(rs->hardsect_size, q->hardsect_size);
+
+	rs->max_segment_size =
+		min_not_zero(rs->max_segment_size, q->max_segment_size);
+
+	rs->seg_boundary_mask =
+		min_not_zero(rs->seg_boundary_mask,
+			     q->seg_boundary_mask);
+
+	rs->no_cluster |= !test_bit(QUEUE_FLAG_CLUSTER, &q->queue_flags);
+}
+EXPORT_SYMBOL_GPL(dm_set_device_limits);
 
 int dm_get_device(struct dm_target *ti, const char *path, sector_t start,
 		  sector_t len, int mode, struct dm_dev **result)
 {
 	int r = __table_get_device(ti->table, ti, path,
 				   start, len, mode, result);
-	if (!r) {
-		request_queue_t *q = bdev_get_queue((*result)->bdev);
-		struct io_restrictions *rs = &ti->limits;
-
-		/*
-		 * Combine the device limits low.
-		 *
-		 * FIXME: if we move an io_restriction struct
-		 *        into q this would just be a call to
-		 *        combine_restrictions_low()
-		 */
-		rs->max_sectors =
-			min_not_zero(rs->max_sectors, q->max_sectors);
 
-		/* FIXME: Device-Mapper on top of RAID-0 breaks because DM
-		 *        currently doesn't honor MD's merge_bvec_fn routine.
-		 *        In this case, we'll force DM to use PAGE_SIZE or
-		 *        smaller I/O, just to be safe. A better fix is in the
-		 *        works, but add this for the time being so it will at
-		 *        least operate correctly.
-		 */
-		if (q->merge_bvec_fn)
-			rs->max_sectors =
-				min_not_zero(rs->max_sectors,
-					     (unsigned int) (PAGE_SIZE >> 9));
-
-		rs->max_phys_segments =
-			min_not_zero(rs->max_phys_segments,
-				     q->max_phys_segments);
-
-		rs->max_hw_segments =
-			min_not_zero(rs->max_hw_segments, q->max_hw_segments);
-
-		rs->hardsect_size = max(rs->hardsect_size, q->hardsect_size);
-
-		rs->max_segment_size =
-			min_not_zero(rs->max_segment_size, q->max_segment_size);
-
-		rs->seg_boundary_mask =
-			min_not_zero(rs->seg_boundary_mask,
-				     q->seg_boundary_mask);
-
-		rs->no_cluster |= !test_bit(QUEUE_FLAG_CLUSTER, &q->queue_flags);
-	}
+	if (!r)
+		dm_set_device_limits(ti, (*result)->bdev);
 
 	return r;
 }
Index: linux-2.6.18-rc7/include/linux/device-mapper.h
===================================================================
--- linux-2.6.18-rc7.orig/include/linux/device-mapper.h	2006-09-14 21:03:16.000000000 +0100
+++ linux-2.6.18-rc7/include/linux/device-mapper.h	2006-09-14 21:36:09.000000000 +0100
@@ -72,6 +72,11 @@ typedef int (*dm_ioctl_fn) (struct dm_ta
 void dm_error(const char *message);
 
 /*
+ * Combine device limits.
+ */
+void dm_set_device_limits(struct dm_target *ti, struct block_device *bdev);
+
+/*
  * Constructors should call these functions to ensure destination devices
  * are opened/closed correctly.
  * FIXME: too many arguments.
