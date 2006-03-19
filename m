Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWCSCgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWCSCgy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWCSCfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:35:03 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:51394 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751273AbWCSCen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:43 -0500
Message-Id: <20060319023455.526787000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:27 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 14/23] readahead: state based method
Content-Disposition: inline; filename=readahead-method-stateful.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fast code path of adaptive read-ahead.

MAJOR STEPS
        - estimate a thrashing safe ra_size;
        - assemble the next read-ahead request in file_ra_state;
        - submit it.

THE REFERENCE MODEL
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

Real world workloads will always have fluctuations (violation of assumption
1 and 2). To counteract it, a tunable parameter readahead_ratio is introduced
to make the estimation conservative enough. Violation of assumption 3 will
not lead to thrashing, it is there just for simplicity of discussion.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/fs.h |   41 +++++--
 mm/readahead.c     |  286 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 317 insertions(+), 10 deletions(-)

--- linux-2.6.16-rc6-mm2.orig/include/linux/fs.h
+++ linux-2.6.16-rc6-mm2/include/linux/fs.h
@@ -611,19 +611,40 @@ struct fown_struct {
  * Track a single file's readahead state
  */
 struct file_ra_state {
-	unsigned long start;		/* Current window */
-	unsigned long size;
-	unsigned long flags;		/* ra flags RA_FLAG_xxx*/
-	unsigned long cache_hit;	/* cache hit count*/
-	unsigned long prev_page;	/* Cache last read() position */
-	unsigned long ahead_start;	/* Ahead window */
-	unsigned long ahead_size;
-	unsigned long ra_pages;		/* Maximum readahead window */
-	unsigned long mmap_hit;		/* Cache hit stat for mmap accesses */
-	unsigned long mmap_miss;	/* Cache miss stat for mmap accesses */
+	union {
+		struct { /* conventional read-ahead */
+			unsigned long start;		/* Current window */
+			unsigned long size;
+			unsigned long ahead_start;	/* Ahead window */
+			unsigned long ahead_size;
+			unsigned long cache_hit;        /* cache hit count */
+		};
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+		struct { /* adaptive read-ahead */
+			pgoff_t la_index;
+			pgoff_t ra_index;
+			pgoff_t lookahead_index;
+			pgoff_t readahead_index;
+			unsigned long age;
+			uint64_t cache_hits;
+		};
+#endif
+	};
+
+	/* mmap read-around */
+	unsigned long mmap_hit;         /* Cache hit stat for mmap accesses */
+	unsigned long mmap_miss;        /* Cache miss stat for mmap accesses */
+
+	/* common ones */
+	unsigned long flags;            /* ra flags RA_FLAG_xxx*/
+	unsigned long prev_page;        /* Cache last read() position */
+	unsigned long ra_pages;         /* Maximum readahead window */
 };
 #define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
+#define RA_FLAG_MMAP		(1UL<<31)	/* mmaped page access */
+#define RA_FLAG_NO_LOOKAHEAD	(1UL<<30)	/* disable look-ahead */
+#define RA_FLAG_NFSD		(1UL<<29)	/* request from nfsd */
 
 struct file {
 	/*
--- linux-2.6.16-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.16-rc6-mm2/mm/readahead.c
@@ -16,6 +16,7 @@
 #include <linux/pagevec.h>
 #include <linux/writeback.h>
 #include <linux/nfsd/const.h>
+#include <asm/div64.h>
 
 /* The default max/min read-ahead pages. */
 #define KB(size)	(((size)*1024 + PAGE_CACHE_SIZE-1) / PAGE_CACHE_SIZE)
@@ -1060,6 +1061,291 @@ static unsigned long node_readahead_agin
 }
 
 /*
+ * The 64bit cache_hits stores three accumulated values and a counter value.
+ * MSB                                                                   LSB
+ * 3333333333333333 : 2222222222222222 : 1111111111111111 : 0000000000000000
+ */
+static inline int ra_cache_hit(struct file_ra_state *ra, int nr)
+{
+	return (ra->cache_hits >> (nr * 16)) & 0xFFFF;
+}
+
+/*
+ * Conceptual code:
+ * ra_cache_hit(ra, 1) += ra_cache_hit(ra, 0);
+ * ra_cache_hit(ra, 0) = 0;
+ */
+static inline void ra_addup_cache_hit(struct file_ra_state *ra)
+{
+	int n;
+
+	n = ra_cache_hit(ra, 0);
+	ra->cache_hits -= n;
+	n <<= 16;
+	ra->cache_hits += n;
+}
+
+/*
+ * The read-ahead is deemed success if cache-hit-rate >= 1/readahead_hit_rate.
+ */
+static inline int ra_cache_hit_ok(struct file_ra_state *ra)
+{
+	return ra_cache_hit(ra, 0) * readahead_hit_rate >=
+					(ra->lookahead_index - ra->la_index);
+}
+
+/*
+ * Check if @index falls in the @ra request.
+ */
+static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
+{
+	if (index < ra->la_index || index >= ra->readahead_index)
+		return 0;
+
+	if (index >= ra->ra_index)
+		return 1;
+	else
+		return -1;
+}
+
+/*
+ * Which method is issuing this read-ahead?
+ */
+static inline void ra_set_class(struct file_ra_state *ra,
+				enum ra_class ra_class)
+{
+	unsigned long flags_mask;
+	unsigned long flags;
+	unsigned long old_ra_class;
+
+	flags_mask = ~(RA_CLASS_MASK | (RA_CLASS_MASK << RA_CLASS_SHIFT));
+	flags = ra->flags & flags_mask;
+
+	old_ra_class = (ra->flags & RA_CLASS_MASK) << RA_CLASS_SHIFT;
+
+	ra->flags = flags | old_ra_class | ra_class;
+
+	ra_addup_cache_hit(ra);
+	if (ra_class != RA_CLASS_STATE)
+		ra->cache_hits <<= 16;
+
+	ra->age = node_readahead_aging();
+}
+
+/*
+ * Where is the old read-ahead and look-ahead?
+ */
+static inline void ra_set_index(struct file_ra_state *ra,
+				pgoff_t la_index, pgoff_t ra_index)
+{
+	ra->la_index = la_index;
+	ra->ra_index = ra_index;
+}
+
+/*
+ * Where is the new read-ahead and look-ahead?
+ */
+static inline void ra_set_size(struct file_ra_state *ra,
+				unsigned long ra_size, unsigned long la_size)
+{
+	/* Disable look-ahead for loopback file. */
+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
+		la_size = 0;
+
+	ra->readahead_index = ra->ra_index + ra_size;
+	ra->lookahead_index = ra->readahead_index - la_size;
+}
+
+/*
+ * Submit IO for the read-ahead request in file_ra_state.
+ */
+static int ra_dispatch(struct file_ra_state *ra,
+			struct address_space *mapping, struct file *filp)
+{
+	pgoff_t eof_index;
+	unsigned long ra_size;
+	unsigned long la_size;
+	int actual;
+	enum ra_class ra_class;
+
+	ra_class = (ra->flags & RA_CLASS_MASK);
+	BUG_ON(ra_class == 0 || ra_class > RA_CLASS_END);
+
+	eof_index = ((i_size_read(mapping->host) - 1) >> PAGE_CACHE_SHIFT) + 1;
+	ra_size = ra->readahead_index - ra->ra_index;
+	la_size = ra->readahead_index - ra->lookahead_index;
+
+	/* Snap to EOF. */
+	if (unlikely(ra->ra_index >= eof_index))
+		return 0;
+	if (ra->readahead_index + ra_size / 2 > eof_index) {
+		if (ra_class == RA_CLASS_CONTEXT_AGGRESSIVE &&
+				eof_index > ra->lookahead_index + 1)
+			la_size = eof_index - ra->lookahead_index;
+		else
+			la_size = 0;
+		ra_size = eof_index - ra->ra_index;
+		ra_set_size(ra, ra_size, la_size);
+	}
+
+	actual = __do_page_cache_readahead(mapping, filp,
+					ra->ra_index, ra_size, la_size);
+
+#ifdef CONFIG_DEBUG_READAHEAD
+	if (ra->flags & RA_FLAG_MMAP)
+		ra_account(ra, RA_EVENT_READAHEAD_MMAP, actual);
+	if (ra->readahead_index == eof_index)
+		ra_account(ra, RA_EVENT_READAHEAD_EOF, actual);
+	if (la_size)
+		ra_account(ra, RA_EVENT_LOOKAHEAD, la_size);
+	if (ra_size > actual)
+		ra_account(ra, RA_EVENT_IO_CACHE_HIT, ra_size - actual);
+	ra_account(ra, RA_EVENT_READAHEAD, actual);
+
+	dprintk("readahead-%s(ino=%lu, index=%lu, ra=%lu+%lu-%lu) = %d\n",
+			ra_class_name[ra_class],
+			mapping->host->i_ino, ra->la_index,
+			ra->ra_index, ra_size, la_size, actual);
+#endif /* CONFIG_DEBUG_READAHEAD */
+
+	return actual;
+}
+
+/*
+ * Determine the ra request from primitive values.
+ *
+ * It applies the following rules:
+ *   - Substract ra_size by the old look-ahead to get real safe read-ahead;
+ *   - Set new la_size according to the (still large) ra_size;
+ *   - Apply upper limits;
+ *   - Make sure stream_shift is not too small.
+ *     (So that the next global_shift will not be too small.)
+ *
+ * Input:
+ * ra_size stores the estimated thrashing-threshold.
+ * la_size stores the look-ahead size of previous request.
+ */
+static inline int adjust_rala(unsigned long ra_max,
+				unsigned long *ra_size, unsigned long *la_size)
+{
+	unsigned long stream_shift = *la_size;
+
+	if (*ra_size > *la_size)
+		*ra_size -= *la_size;
+	else {
+		ra_account(NULL, RA_EVENT_READAHEAD_SHRINK, *ra_size);
+		return 0;
+	}
+
+	*la_size = *ra_size / LOOKAHEAD_RATIO;
+
+	if (*ra_size > ra_max)
+		*ra_size = ra_max;
+	if (*la_size > *ra_size)
+		*la_size = *ra_size;
+
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
+static inline unsigned long compute_thrashing_threshold(
+						struct file_ra_state *ra,
+						unsigned long *remain)
+{
+	unsigned long global_size;
+	unsigned long global_shift;
+	unsigned long stream_shift;
+	unsigned long ra_size;
+	uint64_t ll;
+
+	global_size = node_free_and_cold_pages();
+	global_shift = node_readahead_aging() - ra->age;
+	global_shift |= 1UL;
+	stream_shift = ra_cache_hit(ra, 0);
+
+	ll = (uint64_t) stream_shift * (global_size >> 9) * readahead_ratio * 5;
+	do_div(ll, global_shift);
+	ra_size = ll;
+
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
+			*remain, ra->readahead_index - ra->lookahead_index);
+
+	return ra_size;
+}
+
+/*
+ * Main function for file_ra_state based read-ahead.
+ */
+static inline unsigned long
+state_based_readahead(struct address_space *mapping, struct file *filp,
+			struct file_ra_state *ra,
+			struct page *page, pgoff_t index,
+			unsigned long ra_size, unsigned long ra_max)
+{
+	unsigned long ra_old;
+	unsigned long la_size;
+	unsigned long remain_space;
+	unsigned long growth_limit;
+
+	la_size = ra->readahead_index - index;
+	ra_old = ra->readahead_index - ra->ra_index;
+	growth_limit = ra_size + ra_max / 16 +
+				(2 + readahead_ratio / 64) * ra_old;
+	ra_size = compute_thrashing_threshold(ra, &remain_space);
+
+	if (page && remain_space <= la_size && la_size > 1) {
+		rescue_pages(page, la_size);
+		return 0;
+	}
+
+	if (!adjust_rala(min(ra_max, growth_limit), &ra_size, &la_size))
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
  * ra_min is mainly determined by the size of cache memory.
  * Table of concrete numbers for 4KB page size:
  *   inactive + free (MB):    4   8   16   32   64  128  256  512 1024

--
