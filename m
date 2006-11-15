Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966590AbWKOHvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966590AbWKOHvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966599AbWKOHva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:51:30 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:18638 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S966590AbWKOHvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:51:21 -0500
Message-ID: <363577025.21912@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075028.829507795@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:21 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 14/28] readahead: state based method
Content-Disposition: inline; filename=readahead-state-based-method.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fast code path of adaptive read-ahead.

MAJOR STEPS
===========

        - estimate a thrashing safe ra_size;
        - assemble the next read-ahead request in file_ra_state;
        - submit it.

THE REFERENCE MODEL
===================

        1. inactive list has constant length and page flow speed
        2. the observed stream receives a steady flow of read requests
        3. no page activation, so that the inactive list forms a pipe

With that we get the picture showed below.

 |<------------------------- constant length ------------------------->|
 <<<<<<<<<<<<<<<<<<<<<<<<< steady flow of pages <<<<<<<<<<<<<<<<<<<<<<<<
 +---------------------------------------------------------------------+
 |tail                        inactive list                        head|
 |   =======                  ==========----                           |
 |   chunk A(stale pages)     chunk B(stale + fresh pages)             |
 +---------------------------------------------------------------------+

REAL WORLD ISSUES
=================

Real world workloads will always have fluctuations (violation of assumption
1 and 2). To counteract it, a tunable parameter readahead_ratio is introduced
to make the estimation conservative enough. Violation of assumption 3 will
not lead to thrashing, it is there just for simplicity of discussion.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
DESC
readahead: state based method - stand-alone size limit code
EDESC
From: Wu Fengguang <wfg@mail.ustc.edu.cn>

Separate out the readahead/lookahead sizes limiting code, and put them to
stand-alone limit_rala() function.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm2/mm/readahead.c
@@ -18,6 +18,8 @@
 #include <linux/pagevec.h>
 #include <linux/buffer_head.h>
 
+#include <asm/div64.h>
+
 /*
  * Convienent macros for min/max read-ahead pages.
  * Note that MAX_RA_PAGES is rounded down, while MIN_RA_PAGES is rounded up.
@@ -964,6 +966,161 @@ static int ra_submit(struct file_ra_stat
 }
 
 /*
+ * Deduce the read-ahead/look-ahead size from primitive values.
+ *
+ * Input:
+ *	- @ra_size stores the estimated thrashing-threshold.
+ *	- @la_size stores the look-ahead size of previous request.
+ */
+static int adjust_rala(unsigned long ra_max,
+			unsigned long *ra_size, unsigned long *la_size)
+{
+	/*
+	 * Substract the old look-ahead to get real safe size for the next
+	 * read-ahead request.
+	 */
+	if (*ra_size > *la_size)
+		*ra_size -= *la_size;
+	else {
+		ra_account(NULL, RA_EVENT_READAHEAD_SHRINK, *ra_size);
+		return 0;
+	}
+
+	/*
+	 * Set new la_size according to the (still large) ra_size.
+	 */
+	*la_size = *ra_size / LOOKAHEAD_RATIO;
+
+	return 1;
+}
+
+static void limit_rala(unsigned long ra_max, unsigned long la_old,
+			unsigned long *ra_size, unsigned long *la_size)
+{
+	unsigned long stream_shift;
+
+	/*
+	 * Apply basic upper limits.
+	 */
+	if (*ra_size > ra_max)
+		*ra_size = ra_max;
+	if (*la_size > *ra_size)
+		*la_size = *ra_size;
+
+	/*
+	 * Make sure stream_shift is not too small.
+	 * (So that the next global_shift will not be too small.)
+	 */
+	stream_shift = la_old + (*ra_size - *la_size);
+	if (stream_shift < *ra_size / 4)
+		*la_size -= (*ra_size / 4 - stream_shift);
+}
+
+/*
+ * The function estimates two values:
+ * 1. thrashing-threshold for the current stream
+ *    It is returned to make the next read-ahead request.
+ * 2. the remained safe space for the current chunk
+ *    It will be checked to ensure that the current chunk is safe.
+ *
+ * The computation will be pretty accurate under heavy load, and will vibrate
+ * more on light load(with small global_shift), so the grow speed of ra_size
+ * must be limited, and a moderate large stream_shift must be insured.
+ *
+ * The following figure illustrates the formula used in the function:
+ * 	While the stream reads stream_shift pages inside the chunks,
+ * 	the chunks are shifted global_shift pages inside inactive_list.
+ * So
+ * 	thrashing_threshold = free_mem * stream_shift / global_shift;
+ *
+ *
+ *      chunk A                    chunk B
+ *                          |<=============== global_shift ================|
+ *  +-------------+         +-------------------+                          |
+ *  |       #     |         |           #       |            inactive_list |
+ *  +-------------+         +-------------------+                     head |
+ *          |---->|         |---------->|
+ *             |                  |
+ *             +-- stream_shift --+
+ */
+static unsigned long compute_thrashing_threshold(struct file_ra_state *ra,
+							unsigned long *remain)
+{
+	unsigned long global_size;
+	unsigned long global_shift;
+	unsigned long stream_shift;
+	unsigned long ra_size;
+	uint64_t ll;
+
+	global_size = nr_free_inactive_pages_node(numa_node_id());
+	global_shift = nr_scanned_pages_node(numa_node_id()) - ra->age;
+	global_shift |= 1UL;
+	stream_shift = ra_invoke_interval(ra);
+
+	/* future safe space */
+	ll = (uint64_t) stream_shift * (global_size >> 9) * readahead_ratio * 5;
+	do_div(ll, global_shift);
+	ra_size = ll;
+
+	/* remained safe space */
+	if (global_size > global_shift) {
+		ll = (uint64_t) stream_shift * (global_size - global_shift);
+		do_div(ll, global_shift);
+		*remain = ll;
+	} else
+		*remain = 0;
+
+	ddprintk("compute_thrashing_threshold: "
+			"at %lu ra %lu=%lu*%lu/%lu, remain %lu for %lu\n",
+			ra->readahead_index, ra_size,
+			stream_shift, global_size, global_shift,
+			*remain, ra_lookahead_size(ra));
+
+	return ra_size;
+}
+
+/*
+ * Main function for file_ra_state based read-ahead.
+ */
+static unsigned long
+state_based_readahead(struct address_space *mapping, struct file *filp,
+			struct file_ra_state *ra,
+			struct page *page, pgoff_t offset,
+			unsigned long req_size, unsigned long ra_max)
+{
+	unsigned long ra_old, ra_size;
+	unsigned long la_old, la_size;
+	unsigned long remain_space;
+	unsigned long growth_limit;
+
+	la_old = la_size = ra->readahead_index - offset;
+	ra_old = ra_readahead_size(ra);
+	ra_size = compute_thrashing_threshold(ra, &remain_space);
+
+	if (page && remain_space <= la_size) {
+		rescue_pages(page, la_size);
+		return 0;
+	}
+
+	growth_limit = req_size;
+	growth_limit += ra_max / 16;
+	growth_limit += (2 + readahead_ratio / 64) * ra_old;
+	if (growth_limit > ra_max)
+	    growth_limit = ra_max;
+
+	if (!adjust_rala(growth_limit, &ra_size, &la_size))
+		return 0;
+
+	limit_rala(growth_limit, la_old, &ra_size, &la_size);
+
+	ra_set_class(ra, RA_CLASS_STATE);
+	ra_set_index(ra, offset, ra->readahead_index);
+	ra_set_size(ra, ra_size, la_size);
+
+	return ra_submit(ra, mapping, filp);
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory. Reasonable?
  *
  * Table of concrete numbers for 4KB page size:

--
