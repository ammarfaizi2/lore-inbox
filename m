Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbTFIOVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTFIOVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:21:11 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:33292 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264370AbTFIOVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:21:00 -0400
Date: Mon, 9 Jun 2003 15:34:40 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] dm: Replace __HIGH() and __LOW() macros
Message-ID: <20030609143440.GB11331@fib011235813.fsnet.co.uk>
References: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace __HIGH() and __LOW() with max() and min_not_zero().
--- diff/drivers/md/dm-table.c	2003-05-21 11:50:15.000000000 +0100
+++ source/drivers/md/dm-table.c	2003-06-09 15:04:57.000000000 +0100
@@ -78,22 +78,33 @@
 	return result;
 }
 
-#define __HIGH(l, r) if (*(l) < (r)) *(l) = (r)
-#define __LOW(l, r) if (*(l) == 0 || *(l) > (r)) *(l) = (r)
+/*
+ * Returns the minimum that is _not_ zero, unless both are zero.
+ */
+#define min_not_zero(l, r) (l == 0) ? r : ((r == 0) ? l : min(l, r))
 
 /*
  * Combine two io_restrictions, always taking the lower value.
  */
-
 static void combine_restrictions_low(struct io_restrictions *lhs,
 				     struct io_restrictions *rhs)
 {
-	__LOW(&lhs->max_sectors, rhs->max_sectors);
-	__LOW(&lhs->max_phys_segments, rhs->max_phys_segments);
-	__LOW(&lhs->max_hw_segments, rhs->max_hw_segments);
-	__HIGH(&lhs->hardsect_size, rhs->hardsect_size);
-	__LOW(&lhs->max_segment_size, rhs->max_segment_size);
-	__LOW(&lhs->seg_boundary_mask, rhs->seg_boundary_mask);
+	lhs->max_sectors =
+		min_not_zero(lhs->max_sectors, rhs->max_sectors);
+
+	lhs->max_phys_segments =
+		min_not_zero(lhs->max_phys_segments, rhs->max_phys_segments);
+
+	lhs->max_hw_segments =
+		min_not_zero(lhs->max_hw_segments, rhs->max_hw_segments);
+
+	lhs->hardsect_size = max(lhs->hardsect_size, rhs->hardsect_size);
+
+	lhs->max_segment_size =
+		min_not_zero(lhs->max_segment_size, rhs->max_segment_size);
+
+	lhs->seg_boundary_mask =
+		min_not_zero(lhs->seg_boundary_mask, rhs->seg_boundary_mask);
 }
 
 /*
@@ -481,13 +492,31 @@
 		request_queue_t *q = bdev_get_queue((*result)->bdev);
 		struct io_restrictions *rs = &ti->limits;
 
-		/* combine the device limits low */
-		__LOW(&rs->max_sectors, q->max_sectors);
-		__LOW(&rs->max_phys_segments, q->max_phys_segments);
-		__LOW(&rs->max_hw_segments, q->max_hw_segments);
-		__HIGH(&rs->hardsect_size, q->hardsect_size);
-		__LOW(&rs->max_segment_size, q->max_segment_size);
-		__LOW(&rs->seg_boundary_mask, q->seg_boundary_mask);
+		/*
+		 * Combine the device limits low.
+		 *
+		 * FIXME: if we move an io_restriction struct
+		 *        into q this would just be a call to
+		 *        combine_restrictions_low()
+		 */
+		rs->max_sectors =
+			min_not_zero(rs->max_sectors, q->max_sectors);
+
+		rs->max_phys_segments =
+			min_not_zero(rs->max_phys_segments,
+				     q->max_phys_segments);
+
+		rs->max_hw_segments =
+			min_not_zero(rs->max_hw_segments, q->max_hw_segments);
+
+		rs->hardsect_size = max(rs->hardsect_size, q->hardsect_size);
+
+		rs->max_segment_size =
+			min_not_zero(rs->max_segment_size, q->max_segment_size);
+
+		rs->seg_boundary_mask =
+			min_not_zero(rs->seg_boundary_mask,
+				     q->seg_boundary_mask);
 	}
 
 	return r;
