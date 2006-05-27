Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWE0PyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWE0PyK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbWE0Pwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:52:32 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:26844 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751572AbWE0Pvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:51:35 -0400
Message-ID: <348745092.16246@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060527155133.216888332@localhost.localdomain>
References: <20060527154849.927021763@localhost.localdomain>
Date: Sat, 27 May 2006 23:49:04 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 15/32] readahead: state based method
Content-Disposition: inline; filename=readahead-method-stateful.patch
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
---

 mm/readahead.c |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 147 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1002,6 +1002,153 @@ static int ra_dispatch(struct file_ra_st
 }
 
 /*
+ * Deduce the read-ahead/look-ahead size from primitive values.
+ *
+ * Input:
+ *	- @ra_size stores the estimated thrashing-threshold.
+ *	- @la_size stores the look-ahead size of previous request.
+ */
+static int adjust_rala(unsigned long ra_max,
+				unsigned long *ra_size, unsigned long *la_size)
+{
+	unsigned long stream_shift = *la_size;
+
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
+	/*
+	 * Apply upper limits.
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
+	stream_shift += (*ra_size - *la_size);
+	if (stream_shift < *ra_size / 4)
+		*la_size -= (*ra_size / 4 - stream_shift);
+
+	return 1;
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
+ * This figure illustrates the formula used in the function:
+ * While the stream reads stream_shift pages inside the chunks,
+ * the chunks are shifted global_shift pages inside inactive_list.
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
+	global_shift = node_readahead_aging() - ra->age;
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
+			struct page *page, pgoff_t index,
+			unsigned long req_size, unsigned long ra_max)
+{
+	unsigned long ra_old;
+	unsigned long ra_size;
+	unsigned long la_size;
+	unsigned long remain_space;
+	unsigned long growth_limit;
+
+	la_size = ra->readahead_index - index;
+	ra_size = compute_thrashing_threshold(ra, &remain_space);
+
+	if (page && remain_space <= la_size && la_size > 1) {
+		rescue_pages(page, la_size);
+		return 0;
+	}
+
+	ra_old = ra_readahead_size(ra);
+	growth_limit = req_size;
+	growth_limit += ra_max / 16;
+	growth_limit += (2 + readahead_ratio / 64) * ra_old;
+	if (growth_limit > ra_max)
+		growth_limit = ra_max;
+
+	if (!adjust_rala(growth_limit, &ra_size, &la_size))
+		return 0;
+
+	ra_set_class(ra, RA_CLASS_STATE);
+	ra_set_index(ra, index, ra->readahead_index);
+	ra_set_size(ra, ra_size, la_size);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory. Reasonable?
  *
  * Table of concrete numbers for 4KB page size:

--
