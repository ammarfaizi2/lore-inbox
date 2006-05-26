Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWEZLx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWEZLx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWEZLx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:53:26 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:16346 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932427AbWEZLxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:19 -0400
Message-ID: <348644383.05317@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115308.522890112@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:23 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 17/33] readahead: context based method
Content-Disposition: inline; filename=readahead-method-context.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the slow code path of adaptive read-ahead.

No valid state info is available, so the page cache is queried to obtain
the required position/timing info. This kind of estimation is more conservative
than the stateful method, and also fluctuates more on load variance.


HOW IT WORKS
============

It works by peeking into the file cache and check if there are any history
pages present or accessed. In this way it can detect almost all forms of
sequential / semi-sequential read patterns, e.g.
        - parallel / interleaved sequential scans on one file
        - sequential reads across file open/close
        - mixed sequential / random accesses
        - sparse / skimming sequential read


HOW DATABASES CAN BENEFIT FROM IT
=================================

The adaptive readahead might help db performance in the following cases:
        - concurrent sequential scans
        - sequential scan on a fragmented table
        - index scan with clustered matches
        - index scan on majority rows (in case the planner goes wrong)


ALGORITHM STEPS
===============

        - look back/forward to find the ra_index;
        - look back to estimate a thrashing safe ra_size;
        - assemble the next read-ahead request in file_ra_state;
        - submit it.


ALGORITHM DYNAMICS
==================

* startup
When a sequential read is detected, chunk size is set to readahead-min
and grows up with each readahead.  The grow speed is controlled by
readahead-ratio.  When readahead-ratio == 100, the new logic grows chunk
sizes exponentially -- like the current logic, but lags behind it at
early steps.

* stabilize
When chunk size reaches readahead-max, or comes close to
        (readahead-ratio * thrashing-threshold)
it stops growing and stay there.

The main difference with the stock readahead logic occurs at and after
the time chunk size stops growing:
     -  The current logic grows chunk size exponentially in normal and
        decreases it by 2 each time thrashing is seen. That can lead to
        thrashing with almost every readahead for very slow streams.
     -  The new logic can stop at a size below the thrashing-threshold,
        and stay there stable.

* on stream speed up or system load fall
thrashing-threshold follows up and chunk size is likely to be enlarged.

* on stream slow down or system load rocket up
thrashing-threshold falls down.
If thrashing happened, the next read would be treated as a random read,
and with another read the chunk-size-growing-phase is restarted.

For a slow stream that has (thrashing-threshold < readahead-max):
      - When readahead-ratio = 100, there is only one chunk in cache at
        most time;
      - When readahead-ratio = 50, there are two chunks in cache at most
        time.
      - Lowing readahead-ratio helps gracefully cut down the chunk size
        without thrashing.


OVERHEADS
=========

The context based method has some overheads over the stateful method, due
to more lockings and memory scans.

Running oprofile on the following command shows the following differences:

	# diff sparse sparse1

	total oprofile samples	run1	run2
	stateful method		560482	558696
	stateless method	564463	559413

So the average overhead is about 0.4%.

Detailed diffprofile data:

# diffprofile oprofile.50.stateful oprofile.50.stateless
      2998    41.1% isolate_lru_pages
      2669    26.4% shrink_zone
      1822    14.7% system_call
      1419    27.6% radix_tree_delete
      1376    14.8% _raw_write_lock
      1279    27.4% free_pages_bulk
      1111    12.0% _raw_write_unlock
      1035    43.3% free_hot_cold_page
       849    15.3% unlock_page
       786    29.6% page_referenced
       710     4.6% kmap_atomic
       651    26.4% __pagevec_release_nonlru
       586    16.1% __rmqueue
       578    11.3% find_get_page
       481    15.5% page_waitqueue
       440     6.6% add_to_page_cache
       420    33.7% fget_light
       260     4.3% get_page_from_freelist
       223    13.7% find_busiest_group
       221    35.1% mutex_debug_check_no_locks_freed
       211     0.0% radix_tree_scan_hole
       198    35.5% delay_tsc
       195    14.8% ext3_get_branch
       182    12.6% profile_tick
       173     0.0% radix_tree_cache_lookup_node
       164    22.9% find_next_bit
       162    50.3% page_cache_readahead_adaptive
...
       106     0.0% radix_tree_scan_hole_backward
...
       -51    -7.6% radix_tree_preload
...
       -68    -2.1% radix_tree_insert
...
       -87    -2.0% mark_page_accessed
       -88    -2.0% __pagevec_lru_add
      -103    -7.7% softlockup_tick
      -107   -71.8% free_block
      -122   -77.7% do_IRQ
      -132   -82.0% do_timer
      -140   -47.1% ack_edge_ioapic_vector
      -168   -81.2% handle_IRQ_event
      -192   -35.2% irq_entries_start
      -204   -14.8% rw_verify_area
      -214   -13.2% account_system_time
      -233    -9.5% radix_tree_lookup_node
      -234   -16.6% scheduler_tick
      -259   -58.7% __do_IRQ
      -266    -6.8% put_page
      -318   -29.3% rcu_pending
      -333    -3.0% do_generic_mapping_read
      -337   -28.3% hrtimer_run_queues
      -493   -27.0% __rcu_pending
     -1038    -9.4% default_idle
     -3323    -3.5% __copy_to_user_ll
    -10331    -5.9% do_mpage_readpage

# diffprofile oprofile.50.stateful2 oprofile.50.stateless2
      1739     1.1% do_mpage_readpage
       833     0.9% __copy_to_user_ll
       340    21.3% find_busiest_group
       288     9.5% free_hot_cold_page
       261     4.6% _raw_read_unlock
       239     3.9% get_page_from_freelist
       201     0.0% radix_tree_scan_hole
       163    14.3% raise_softirq
       160     0.0% radix_tree_cache_lookup_node
       160    11.8% update_process_times
       136     9.3% fget_light
       121    35.1% page_cache_readahead_adaptive
       117    36.0% restore_all
       117     2.8% mark_page_accessed
       109     6.4% rebalance_tick
       107     9.4% sys_read
       102     0.0% radix_tree_scan_hole_backward
...
        63     4.0% readahead_cache_hit
...
       -10   -15.9% radix_tree_node_alloc
...
       -39    -1.7% radix_tree_lookup_node
       -39   -10.3% irq_entries_start
       -43    -1.3% radix_tree_insert
...
       -47    -4.6% __do_page_cache_readahead
       -64    -9.3% radix_tree_preload
       -65    -5.4% rw_verify_area
       -65    -2.2% vfs_read
       -70    -4.7% timer_interrupt
       -71    -1.0% __wake_up_bit
       -73    -1.1% radix_tree_delete
       -79   -12.6% __mod_page_state_offset
       -94    -1.8% __find_get_block
       -94    -2.2% __pagevec_lru_add
      -102    -1.7% free_pages_bulk
      -116    -1.3% _raw_read_lock
      -123    -7.4% do_sync_read
      -130    -8.4% ext3_get_blocks_handle
      -142    -3.8% put_page
      -146    -7.9% mpage_readpages
      -147    -5.6% apic_timer_interrupt
      -168    -1.6% _raw_write_unlock
      -172    -5.0% page_referenced
      -206    -3.2% unlock_page
      -212   -15.0% restore_nocheck
      -213    -2.1% default_idle
      -245    -5.0% __rmqueue
      -278    -4.3% find_get_page
      -282    -2.1% system_call
      -287   -11.8% run_timer_softirq
      -300    -2.7% _raw_write_lock
      -420    -3.2% shrink_zone
      -661    -5.7% isolate_lru_pages

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |  329 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 329 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1165,6 +1165,328 @@ state_based_readahead(struct address_spa
 }
 
 /*
+ * Page cache context based estimation of read-ahead/look-ahead size/index.
+ *
+ * The logic first looks around to find the start point of next read-ahead,
+ * and then, if necessary, looks backward in the inactive_list to get an
+ * estimation of the thrashing-threshold.
+ *
+ * The estimation theory can be illustrated with figure:
+ *
+ *   chunk A           chunk B                      chunk C                 head
+ *
+ *   l01 l11           l12   l21                    l22
+ *| |-->|-->|       |------>|-->|                |------>|
+ *| +-------+       +-----------+                +-------------+               |
+ *| |   #   |       |       #   |                |       #     |               |
+ *| +-------+       +-----------+                +-------------+               |
+ *| |<==============|<===========================|<============================|
+ *        L0                     L1                            L2
+ *
+ * Let f(l) = L be a map from
+ * 	l: the number of pages read by the stream
+ * to
+ * 	L: the number of pages pushed into inactive_list in the mean time
+ * then
+ * 	f(l01) <= L0
+ * 	f(l11 + l12) = L1
+ * 	f(l21 + l22) = L2
+ * 	...
+ * 	f(l01 + l11 + ...) <= Sum(L0 + L1 + ...)
+ *			   <= Length(inactive_list) = f(thrashing-threshold)
+ *
+ * So the count of countinuous history pages left in the inactive_list is always
+ * a lower estimation of the true thrashing-threshold.
+ */
+
+#define PAGE_REFCNT_0           0
+#define PAGE_REFCNT_1           (1 << PG_referenced)
+#define PAGE_REFCNT_2           (1 << PG_active)
+#define PAGE_REFCNT_3           ((1 << PG_active) | (1 << PG_referenced))
+#define PAGE_REFCNT_MASK        PAGE_REFCNT_3
+
+/*
+ * STATUS   REFERENCE COUNT      TYPE
+ *  __                   0      fresh
+ *  _R       PAGE_REFCNT_1      stale
+ *  A_       PAGE_REFCNT_2      disturbed once
+ *  AR       PAGE_REFCNT_3      disturbed twice
+ *
+ *  A/R: Active / Referenced
+ */
+static inline unsigned long page_refcnt(struct page *page)
+{
+        return page->flags & PAGE_REFCNT_MASK;
+}
+
+/*
+ * Now that revisited pages are put into active_list immediately,
+ * we cannot get an accurate estimation of
+ *
+ * 		len(inactive_list) / speed(leader)
+ *
+ * on the situation of two sequential readers that come close enough:
+ *
+ *        chunk 1         chunk 2               chunk 3
+ *      ==========  =============-------  --------------------
+ *                     follower ^                     leader ^
+ *
+ * In this case, using cold_page_refcnt() in the context based method yields
+ * conservative read-ahead size, while page_refcnt() yields aggressive size.
+ */
+static inline unsigned long cold_page_refcnt(struct page *page)
+{
+	if (!page || PageActive(page))
+		return 0;
+
+	return page_refcnt(page);
+}
+
+/*
+ * Find past-the-end index of the segment at @index.
+ *
+ * Segment is defined as a full range of cached pages in a file.
+ * (Whereas a chunk refers to a range of cached pages that are brought in
+ *  by read-ahead in one shot.)
+ */
+static pgoff_t find_segtail(struct address_space *mapping,
+					pgoff_t index, unsigned long max_scan)
+{
+	pgoff_t ra_index;
+
+	cond_resched();
+	read_lock_irq(&mapping->tree_lock);
+	ra_index = radix_tree_scan_hole(&mapping->page_tree, index, max_scan);
+	read_unlock_irq(&mapping->tree_lock);
+
+	if (ra_index <= index + max_scan)
+		return ra_index;
+	else
+		return 0;
+}
+
+/*
+ * Find past-the-end index of the segment before @index.
+ */
+static pgoff_t find_segtail_backward(struct address_space *mapping,
+					pgoff_t index, unsigned long max_scan)
+{
+	pgoff_t origin = index;
+
+	if (max_scan > index)
+		max_scan = index;
+
+	/*
+	 * Poor man's radix_tree_scan_data_backward() implementation.
+	 * Acceptable because max_scan won't be large.
+	 */
+	read_lock_irq(&mapping->tree_lock);
+	for (; origin - index < max_scan;)
+		if (__probe_page(mapping, --index)) {
+			read_unlock_irq(&mapping->tree_lock);
+			return index + 1;
+		}
+	read_unlock_irq(&mapping->tree_lock);
+
+	return 0;
+}
+
+/*
+ * Count/estimate cache hits in range [first_index, last_index].
+ * The estimation is simple and optimistic.
+ */
+static int count_cache_hit(struct address_space *mapping,
+				pgoff_t first_index, pgoff_t last_index)
+{
+	struct page *page;
+	int size = last_index - first_index + 1;
+	int count = 0;
+	int i;
+
+	/*
+	 * The first page may well is chunk head and has been accessed,
+	 * so it is index 0 that makes the estimation optimistic. This
+	 * behavior guarantees a readahead when (size < ra_max) and
+	 * (readahead_hit_rate >= 16).
+	 */
+	for (i = 0; i < 16;) {
+		page = radix_tree_lookup(&mapping->page_tree, first_index +
+						size * ((i++ * 29) & 15) / 16);
+		if (cold_page_refcnt(page) >= PAGE_REFCNT_1 && ++count >= 2)
+			break;
+	}
+
+	return size * count / i;
+}
+
+/*
+ * Look back and check history pages to estimate thrashing-threshold.
+ */
+static unsigned long query_page_cache_segment(struct address_space *mapping,
+				struct file_ra_state *ra,
+				unsigned long *remain, pgoff_t offset,
+				unsigned long ra_min, unsigned long ra_max)
+{
+	pgoff_t index;
+	unsigned long count;
+	unsigned long nr_lookback;
+
+	/*
+	 * Scan backward and check the near @ra_max pages.
+	 * The count here determines ra_size.
+	 */
+	cond_resched();
+	read_lock_irq(&mapping->tree_lock);
+	index = radix_tree_scan_hole_backward(&mapping->page_tree,
+							offset, ra_max);
+
+	*remain = offset - index;
+
+	if (offset == ra->readahead_index && ra_cache_hit_ok(ra))
+		count = *remain;
+	else if (count_cache_hit(mapping, index + 1, offset) *
+						readahead_hit_rate >= *remain)
+		count = *remain;
+	else
+		count = ra_min;
+
+	/*
+	 * Unnecessary to count more?
+	 */
+	if (count < ra_max)
+		goto out_unlock;
+
+	if (unlikely(ra->flags & RA_FLAG_NO_LOOKAHEAD))
+		goto out_unlock;
+
+	/*
+	 * Check the far pages coarsely.
+	 * The enlarged count here helps increase la_size.
+	 */
+	nr_lookback = ra_max * (LOOKAHEAD_RATIO + 1) *
+						100 / (readahead_ratio | 1);
+
+	for (count += ra_max; count < nr_lookback; count += ra_max)
+		if (!__probe_page(mapping, offset - count))
+			break;
+
+out_unlock:
+	read_unlock_irq(&mapping->tree_lock);
+
+	/*
+	 *  For sequential read that extends from index 0, the counted value
+	 *  may well be far under the true threshold, so return it unmodified
+	 *  for further processing in adjust_rala_aggressive().
+	 */
+	if (count >= offset)
+		count = offset;
+	else
+		count = max(ra_min, count * readahead_ratio / 100);
+
+	ddprintk("query_page_cache_segment: "
+			"ino=%lu, idx=%lu, count=%lu, remain=%lu\n",
+			mapping->host->i_ino, offset, count, *remain);
+
+	return count;
+}
+
+/*
+ * Determine the request parameters for context based read-ahead that extends
+ * from start of file.
+ *
+ * The major weakness of stateless method is perhaps the slow grow up speed of
+ * ra_size. The logic tries to make up for this in the important case of
+ * sequential reads that extend from start of file. In this case, the ra_size
+ * is not chosen to make the whole next chunk safe (as in normal ones). Only
+ * half of which is safe. The added 'unsafe' half is the look-ahead part. It
+ * is expected to be safeguarded by rescue_pages() when the previous chunks are
+ * lost.
+ */
+static int adjust_rala_aggressive(unsigned long ra_max,
+				unsigned long *ra_size, unsigned long *la_size)
+{
+	pgoff_t index = *ra_size;
+
+	*ra_size -= min(*ra_size, *la_size);
+	*ra_size = *ra_size * readahead_ratio / 100;
+	*la_size = index * readahead_ratio / 100;
+	*ra_size += *la_size;
+
+	if (*ra_size > ra_max)
+		*ra_size = ra_max;
+	if (*la_size > *ra_size)
+		*la_size = *ra_size;
+
+	return 1;
+}
+
+/*
+ * Main function for page context based read-ahead.
+ *
+ * RETURN VALUE		HINT
+ *      1		@ra contains a valid ra-request, please submit it
+ *      0		no seq-pattern discovered, please try the next method
+ *     -1		please don't do _any_ readahead
+ */
+static int
+try_context_based_readahead(struct address_space *mapping,
+			struct file_ra_state *ra, struct page *prev_page,
+			struct page *page, pgoff_t index,
+			unsigned long ra_min, unsigned long ra_max)
+{
+	pgoff_t ra_index;
+	unsigned long ra_size;
+	unsigned long la_size;
+	unsigned long remain_pages;
+
+	/* Where to start read-ahead?
+	 * NFSv3 daemons may process adjacent requests in parallel,
+	 * leading to many locally disordered, globally sequential reads.
+	 * So do not require nearby history pages to be present or accessed.
+	 */
+	if (page) {
+		ra_index = find_segtail(mapping, index, ra_max * 5 / 4);
+		if (!ra_index)
+			return -1;
+	} else if (prev_page || probe_page(mapping, index - 1)) {
+		ra_index = index;
+	} else if (readahead_hit_rate > 1) {
+		ra_index = find_segtail_backward(mapping, index,
+						readahead_hit_rate + ra_min);
+		if (!ra_index)
+			return 0;
+		ra_min += 2 * (index - ra_index);
+		index = ra_index;	/* pretend the request starts here */
+	} else
+		return 0;
+
+	ra_size = query_page_cache_segment(mapping, ra, &remain_pages,
+							index, ra_min, ra_max);
+
+	la_size = ra_index - index;
+	if (page && remain_pages <= la_size &&
+			remain_pages < index && la_size > 1) {
+		rescue_pages(page, la_size);
+		return -1;
+	}
+
+	if (ra_size == index) {
+		if (!adjust_rala_aggressive(ra_max, &ra_size, &la_size))
+			return -1;
+		ra_set_class(ra, RA_CLASS_CONTEXT_AGGRESSIVE);
+	} else {
+		if (!adjust_rala(ra_max, &ra_size, &la_size))
+			return -1;
+		ra_set_class(ra, RA_CLASS_CONTEXT);
+	}
+
+	ra_set_index(ra, index, ra_index);
+	ra_set_size(ra, ra_size, la_size);
+
+	return 1;
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory. Reasonable?
  *
  * Table of concrete numbers for 4KB page size:

--
