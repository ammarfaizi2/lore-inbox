Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTB0Jpm>; Thu, 27 Feb 2003 04:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTB0Jpm>; Thu, 27 Feb 2003 04:45:42 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:19987 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S262492AbTB0Jpk>; Thu, 27 Feb 2003 04:45:40 -0500
Date: Thu, 27 Feb 2003 09:55:22 +0000
To: Greg KH <greg@kroah.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] dm: __LOW macro fix no. 2
Message-ID: <20030227095522.GA6312@fib011235813.fsnet.co.uk>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk> <20030226171249.GG8369@fib011235813.fsnet.co.uk> <20030226181454.GA16350@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226181454.GA16350@kroah.com>
User-Agent: Mutt/1.5.3i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Any happier with this ?  The second hunk of the patch may disappear at
some point.

- Joe


Replace __HIGH() and __LOW() with max() and min_not_zero().


--- diff/drivers/md/dm-table.c	2003-02-26 16:10:24.000000000 +0000
+++ source/drivers/md/dm-table.c	2003-02-27 09:44:31.000000000 +0000
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
@@ -486,13 +497,31 @@
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
