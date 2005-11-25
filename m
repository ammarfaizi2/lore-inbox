Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbVKYPHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbVKYPHz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbVKYPHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:07:54 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:1262 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1161111AbVKYPHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:07:36 -0500
Message-Id: <20051125151550.440541000@localhost.localdomain>
References: <20051125151210.993109000@localhost.localdomain>
Date: Fri, 25 Nov 2005 23:12:20 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 10/19] readahead: state based method
Content-Disposition: inline; filename=readahead-method-stateful.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fast code path.

Major steps:
        - estimate a thrashing safe ra_size;
        - assemble the next read-ahead request in file_ra_state;
        - submit it.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/fs.h |    8 +
 include/linux/mm.h |    6 
 mm/memory.c        |    1 
 mm/readahead.c     |  355 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swap.c          |    2 
 mm/vmscan.c        |    3 
 6 files changed, 374 insertions(+), 1 deletion(-)

--- linux-2.6.15-rc2-mm1.orig/include/linux/fs.h
+++ linux-2.6.15-rc2-mm1/include/linux/fs.h
@@ -604,13 +604,19 @@ struct file_ra_state {
 	unsigned long start;		/* Current window */
 	unsigned long size;
 	unsigned long flags;		/* ra flags RA_FLAG_xxx*/
-	unsigned long cache_hit;	/* cache hit count*/
+	uint64_t      cache_hit;	/* cache hit count*/
 	unsigned long prev_page;	/* Cache last read() position */
 	unsigned long ahead_start;	/* Ahead window */
 	unsigned long ahead_size;
 	unsigned long ra_pages;		/* Maximum readahead window */
 	unsigned long mmap_hit;		/* Cache hit stat for mmap accesses */
 	unsigned long mmap_miss;	/* Cache miss stat for mmap accesses */
+
+	unsigned long age;
+	pgoff_t la_index;
+	pgoff_t ra_index;
+	pgoff_t lookahead_index;
+	pgoff_t readahead_index;
 };
 #define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
--- linux-2.6.15-rc2-mm1.orig/include/linux/mm.h
+++ linux-2.6.15-rc2-mm1/include/linux/mm.h
@@ -1009,6 +1009,12 @@ static inline int prefer_adaptive_readah
 	return readahead_ratio > 9;
 }
 
+DECLARE_PER_CPU(unsigned long, readahead_aging);
+static inline void inc_readahead_aging(void)
+{
+	__get_cpu_var(readahead_aging)++;
+}
+
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
 #ifdef CONFIG_IA64
--- linux-2.6.15-rc2-mm1.orig/mm/memory.c
+++ linux-2.6.15-rc2-mm1/mm/memory.c
@@ -1894,6 +1894,7 @@ static int do_anonymous_page(struct mm_s
 		page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 		if (!pte_none(*page_table))
 			goto release;
+		inc_readahead_aging();
 		inc_mm_counter(mm, anon_rss);
 		lru_cache_add_active(page);
 		SetPageReferenced(page);
--- linux-2.6.15-rc2-mm1.orig/mm/vmscan.c
+++ linux-2.6.15-rc2-mm1/mm/vmscan.c
@@ -539,6 +539,9 @@ static int shrink_list(struct list_head 
 			goto activate_locked;
 		}
 
+		if (!PageReferenced(page))
+			inc_readahead_aging();
+
 		referenced = page_referenced(page, 1, sc->priority <= 0);
 		/* In active use or really unfreeable?  Activate it. */
 		if (referenced && page_mapping_inuse(page))
--- linux-2.6.15-rc2-mm1.orig/mm/swap.c
+++ linux-2.6.15-rc2-mm1/mm/swap.c
@@ -124,6 +124,8 @@ void fastcall mark_page_accessed(struct 
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
 		SetPageReferenced(page);
+		if (PageLRU(page) && !PageActivate(page))
+			inc_readahead_aging();
 	}
 }
 
--- linux-2.6.15-rc2-mm1.orig/mm/readahead.c
+++ linux-2.6.15-rc2-mm1/mm/readahead.c
@@ -38,6 +38,12 @@ EXPORT_SYMBOL(readahead_hit_rate);
 int readahead_live_chunk = 2 * MAX_RA_PAGES;
 EXPORT_SYMBOL(readahead_live_chunk);
 
+/* Analog to zone->aging_total.
+ * But mainly increased on fresh page references, so is much more smoother.
+ */
+DEFINE_PER_CPU(unsigned long, readahead_aging);
+EXPORT_PER_CPU_SYMBOL(readahead_aging);
+
 /* Detailed classification of read-ahead behaviors. */
 #define RA_CLASS_SHIFT 3
 #define RA_CLASS_MASK  ((1 << RA_CLASS_SHIFT) - 1)
@@ -97,6 +103,7 @@ enum ra_event {
 #include <linux/init.h>
 
 u32 readahead_debug_level = 0;
+u32 debug_disable_stateful_method = 0;
 
 static int __init readahead_init(void)
 {
@@ -105,13 +112,26 @@ static int __init readahead_init(void)
 	root = debugfs_create_dir("readahead", NULL);
 
 	debugfs_create_u32("debug_level", 0644, root, &readahead_debug_level);
+	debugfs_create_bool("disable_stateful_method", 0644, root,
+						&debug_disable_stateful_method);
 
 	return 0;
 }
 
 module_init(readahead_init)
+
+static inline int disable_stateful_method(void)
+{
+	return debug_disable_stateful_method;
+}
+
 #else /* !DEBUG_READAHEAD */
 
+static inline int disable_stateful_method(void)
+{
+	return 0;
+}
+
 #endif /* DEBUG_READAHEAD */
 
 
@@ -807,6 +827,341 @@ out:
 }
 
 /*
+ * State based calculation of read-ahead request.
+ *
+ * This figure shows the meaning of file_ra_state members:
+ *
+ *             chunk A                            chunk B
+ *  +---------------------------+-------------------------------------------+
+ *  |             #             |                   #                       |
+ *  +---------------------------+-------------------------------------------+
+ *                ^             ^                   ^                       ^
+ *              la_index      ra_index     lookahead_index         readahead_index
+ */
+
+/*
+ * The global effective length of the inactive_list(s).
+ */
+static unsigned long node_free_and_cold_pages(void)
+{
+	unsigned int i;
+	unsigned long sum = 0;
+	struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += zones[i].nr_inactive +
+			zones[i].free_pages - zones[i].pages_low;
+
+	return sum;
+}
+
+/*
+ * A more smooth and timely analog to zone->aging_total.
+ */
+static unsigned long node_readahead_aging(void)
+{
+	unsigned long cpu;
+	unsigned long sum = 0;
+	cpumask_t mask = node_to_cpumask(numa_node_id());
+
+	for_each_cpu_mask(cpu, mask)
+		sum += per_cpu(readahead_aging, cpu);
+
+	return sum;
+}
+
+/*
+ * Set class of read-ahead
+ */
+static inline void set_ra_class(struct file_ra_state *ra,
+				enum ra_class ra_class)
+{
+	unsigned long FLAGS_MASK;
+	unsigned long flags;
+	unsigned long old_ra_class;
+
+	FLAGS_MASK = ~(RA_CLASS_MASK | (RA_CLASS_MASK << RA_CLASS_SHIFT));
+	flags = ra->flags & FLAGS_MASK;
+
+	old_ra_class = (ra->flags & RA_CLASS_MASK) << RA_CLASS_SHIFT;
+
+	ra->flags = flags | old_ra_class | ra_class;
+}
+
+/*
+ * The 64bit cache_hit stores three accumulated value and one counter value.
+ * MSB                                                                   LSB
+ * 3333333333333333 : 2222222222222222 : 1111111111111111 : 0000000000000000
+ */
+static inline int ra_cache_hit(struct file_ra_state *ra, int nr)
+{
+	return (ra->cache_hit >> (nr * 16)) & 0xFFFF;
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
+	ra->cache_hit -= n;
+	n <<= 16;
+	ra->cache_hit += n;
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
+ * Prepare file_ra_state for a new read-ahead sequence.
+ */
+static inline void ra_state_init(struct file_ra_state *ra,
+				pgoff_t la_index, pgoff_t ra_index)
+{
+	ra_addup_cache_hit(ra);
+	ra->cache_hit <<= 16;
+	ra->lookahead_index = la_index;
+	ra->readahead_index = ra_index;
+}
+
+/*
+ * Take down a new read-ahead request in file_ra_state.
+ */
+static inline void ra_state_update(struct file_ra_state *ra,
+				unsigned long ra_size, unsigned long la_size)
+{
+#ifdef DEBUG_READAHEAD
+	unsigned long old_ra = ra->readahead_index - ra->ra_index;
+	if (ra_size < old_ra && ra_cache_hit(ra, 0))
+		ra_account(ra, RA_EVENT_READAHEAD_SHRINK, old_ra - ra_size);
+#endif
+	ra_addup_cache_hit(ra);
+	ra->ra_index = ra->readahead_index;
+	ra->la_index = ra->lookahead_index;
+	ra->readahead_index += ra_size;
+	ra->lookahead_index = ra->readahead_index - la_size;
+	ra->age = node_readahead_aging();
+}
+
+/*
+ * Adjust the read-ahead request in file_ra_state.
+ */
+static inline void ra_state_adjust(struct file_ra_state *ra,
+				unsigned long ra_size, unsigned long la_size)
+{
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
+		if (ra_class == RA_CLASS_CONTEXT_ACCELERATED &&
+				eof_index > ra->lookahead_index + 1)
+			la_size = eof_index - ra->lookahead_index;
+		else
+			la_size = 0;
+		ra_size = eof_index - ra->ra_index;
+		ra_state_adjust(ra, ra_size, la_size);
+	}
+
+	actual = __do_page_cache_readahead(mapping, filp,
+					ra->ra_index, ra_size, la_size);
+
+#ifdef READAHEAD_STREAMING
+	if (actual < ra_size) {
+		struct page *page = find_page(mapping, ra->ra_index + actual);
+		if (page)
+			rescue_pages(page, ra_size);
+	}
+#endif
+
+	if (ra->readahead_index == eof_index)
+		ra_account(ra, RA_EVENT_READAHEAD_EOF, actual);
+	if (la_size)
+		ra_account(ra, RA_EVENT_LOOKAHEAD, la_size);
+	ra_account(ra, RA_EVENT_READAHEAD, actual);
+
+	dprintk("readahead-%s(ino=%lu, index=%lu, ra=%lu+%lu-%lu) = %d\n",
+			ra_class_name[ra_class],
+			mapping->host->i_ino, ra->la_index,
+			ra->ra_index, ra_size, la_size, actual);
+
+	return actual;
+}
+
+/*
+ * Determine the request parameters from primitive values.
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
+	else
+		return 0;
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
+ * 2. the remained space for the current chunk
+ *    It will be checked to ensure that the current chunk is safe.
+ *
+ * The computation will be pretty accurate under heavy load, and will vibrate
+ * more with light load(small global_shift), so the grow speed of ra_size
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
+
+	global_size = node_free_and_cold_pages();
+	global_shift = node_readahead_aging() - ra->age + 1;
+	stream_shift = ra_cache_hit(ra, 0);
+
+	ra_size = stream_shift *
+			global_size * readahead_ratio / (100 * global_shift);
+
+	if (global_size > global_shift)
+		*remain = stream_shift *
+				(global_size - global_shift) / global_shift;
+	else
+		*remain = 0;
+
+	ddprintk("compute_thrashing_threshold: "
+			"ra=%lu=%lu*%lu/%lu, remain %lu for %lu\n",
+			ra_size, stream_shift, global_size, global_shift,
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
+			struct file_ra_state *ra, struct page *page,
+			unsigned long ra_max)
+{
+	unsigned long ra_old;
+	unsigned long ra_size;
+	unsigned long la_size;
+	unsigned long remain_space;
+	unsigned long growth_limit;
+
+	la_size = ra->readahead_index - ra->lookahead_index;
+	ra_old = ra->readahead_index - ra->ra_index;
+	ra_size = compute_thrashing_threshold(ra, &remain_space);
+
+	if (readahead_ratio < VM_READAHEAD_PROTECT_RATIO &&
+			remain_space <= la_size && la_size > 1) {
+		rescue_pages(page, la_size);
+		return 0;
+	}
+
+	growth_limit = 2 * ra_old + (ra_max - ra_old) / 16;
+	if (!adjust_rala(min(ra_max, growth_limit), &ra_size, &la_size))
+		return 0;
+
+	set_ra_class(ra, RA_CLASS_STATE);
+	ra_state_update(ra, ra_size, la_size);
+
+	return ra_dispatch(ra, mapping, filp);
+}
+
+
+/*
  * ra_size is mainly determined by:
  * 1. sequential-start: min(MIN_RA_PAGES + (pages>>14), KB(128))
  * 2. sequential-max:	min(ra->ra_pages, 0xFFFF)

--
