Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbVKJCJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVKJCJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVKJCJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:09:31 -0500
Received: from silver.veritas.com ([143.127.12.111]:5419 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751434AbVKJCJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:09:30 -0500
Date: Thu, 10 Nov 2005 02:08:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Paul Mackerras <paulus@samba.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       Matthew Wilcox <matthew@wil.cx>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] mm: inc_page_table_pages check max
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100203160.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 02:09:30.0088 (UTC) FILETIME=[C8C39680:01C5E59B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A 32-bit machine needs 16GB of page table space to back its max mapcount,
a 64-bit machine needs 16TB of page table space to back its max mapcount.

But, there are certainly 32-bit machines with 64GB physical - and more?
and even if 16TB were a 64-bit limit today, it would not be tomorrow.
Yet it'll be some time (I hope) before such machines need to use that
amount of their memory just on the page tables.

Therefore, guard against mapcount overflow on such extreme machines, by
limiting the number of page table pages with a check before incrementing
nr_page_table_pages.  That's a per_cpu variable, so add a per_cpu max,
and avoid extra locking (except at startup and rare occasions after).

Of course, normally those page tables would be filled with entries for
different pages, and no mapcount remotely approach the limit; but this
check avoids checks on hotter paths, without being too restrictive.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

But 64-bit powerpc and parisc are limited to 16GB of page table space by
this, because they don't yet provide the atomic64_t type and operations.
Is there someone who could provide the necessary atomic64_t for them?

 include/linux/mm.h         |    2 
 include/linux/page-flags.h |    1 
 mm/memory.c                |    7 +--
 mm/page_alloc.c            |   95 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 3 deletions(-)

--- mm13/include/linux/mm.h	2005-11-09 14:40:17.000000000 +0000
+++ mm14/include/linux/mm.h	2005-11-09 14:40:32.000000000 +0000
@@ -313,6 +313,7 @@ struct page {
 #define PCOUNT_SHIFT	23
 #define PCOUNT_MASK	((1UL << PCOUNT_SHIFT) - 1)
 #define PCOUNT_HIGH	(PCOUNT_MASK - PID_MAX_LIMIT)
+#define MAPCOUNT_MAX	(-1UL >> PCOUNT_SHIFT)
 
 /*
  * Drop a ref, return true if the logical refcount fell to zero
@@ -388,6 +389,7 @@ static inline int page_count_too_high(st
 #else /* !ATOMIC64_INIT */
 
 #define PCOUNT_HIGH	(INT_MAX - PID_MAX_LIMIT)
+#define MAPCOUNT_MAX	(INT_MAX - 2*PID_MAX_LIMIT)
 
 /*
  * Drop a ref, return true if the logical refcount fell to zero
--- mm13/include/linux/page-flags.h	2005-11-07 07:39:57.000000000 +0000
+++ mm14/include/linux/page-flags.h	2005-11-09 14:40:32.000000000 +0000
@@ -139,6 +139,7 @@ extern void get_page_state_node(struct p
 extern void get_full_page_state(struct page_state *ret);
 extern unsigned long __read_page_state(unsigned long offset);
 extern void __mod_page_state(unsigned long offset, unsigned long delta);
+extern int inc_page_table_pages(void);
 
 #define read_page_state(member) \
 	__read_page_state(offsetof(struct page_state, member))
--- mm13/mm/memory.c	2005-11-09 14:40:17.000000000 +0000
+++ mm14/mm/memory.c	2005-11-09 14:40:32.000000000 +0000
@@ -291,22 +291,23 @@ void free_pgtables(struct mmu_gather **t
 
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
 {
+	int ret = 0;
 	struct page *new = pte_alloc_one(mm, address);
 	if (!new)
 		return -ENOMEM;
 
 	pte_lock_init(new);
 	spin_lock(&mm->page_table_lock);
-	if (pmd_present(*pmd)) {	/* Another has populated it */
+	if (pmd_present(*pmd) ||	/* Another has populated it */
+	    (ret = inc_page_table_pages())) {
 		pte_lock_deinit(new);
 		pte_free(new);
 	} else {
 		mm->nr_ptes++;
-		inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
 	}
 	spin_unlock(&mm->page_table_lock);
-	return 0;
+	return ret;
 }
 
 int __pte_alloc_kernel(pmd_t *pmd, unsigned long address)
--- mm13/mm/page_alloc.c	2005-11-09 14:40:00.000000000 +0000
+++ mm14/mm/page_alloc.c	2005-11-09 14:40:32.000000000 +0000
@@ -1217,6 +1217,14 @@ static void show_node(struct zone *zone)
 #endif
 
 /*
+ * Declarations for inc_page_table_pages(): placed here in the hope
+ * that max_page_table_pages will share cacheline with page_states.
+ */
+#define MAX_PAGE_TABLE_PAGES	(MAPCOUNT_MAX / PTRS_PER_PTE)
+static DEFINE_SPINLOCK(max_page_tables_lock);
+static DEFINE_PER_CPU(unsigned long, max_page_table_pages) = {0};
+
+/*
  * Accumulate the page_state information across all CPUs.
  * The result is unavoidably approximate - it can change
  * during and after execution of this function.
@@ -1309,6 +1317,90 @@ void __mod_page_state(unsigned long offs
 
 EXPORT_SYMBOL(__mod_page_state);
 
+/*
+ * inc_page_table_pages() increments cpu page_state.nr_page_table_pages
+ * after checking against the MAX_PAGE_TABLE_PAGES limit: which ensures
+ * mapcount cannot wrap even if _every_ page table entry points to the
+ * same page.  Absurdly draconian, yet no serious practical limitation -
+ * limits 32-bit to 16GB in page tables, 64-bit to 16TB in page tables.
+ */
+int inc_page_table_pages(void)
+{
+	unsigned long offset;
+	unsigned long *max;
+	unsigned long *ptr;
+	unsigned long nr_ptps;
+	int nr_cpus;
+	long delta;
+	int cpu;
+
+	offset = offsetof(struct page_state, nr_page_table_pages);
+again:
+	ptr = (void *) &__get_cpu_var(page_states) + offset;
+	max = &__get_cpu_var(max_page_table_pages);
+	/*
+	 * Beware, *ptr and *max may go "negative" if more page
+	 * tables happen to be freed on this cpu than allocated.
+	 * We avoid the need for barriers by keeping max 1 low.
+	 */
+	if (likely((long)(*max - *ptr) > 0)) {
+		(*ptr)++;
+		return 0;
+	}
+
+	spin_lock(&max_page_tables_lock);
+	/*
+	 * Below, we drop *max on each cpu to stop racing allocations
+	 * while we're updating.  But perhaps another cpu just did the
+	 * update while we were waiting for the lock: don't do it again.
+	 */
+	if ((long)(*max - *ptr) > 0) {
+		(*ptr)++;
+		spin_unlock(&max_page_tables_lock);
+		return 0;
+	}
+
+	/*
+	 * Find how much is allocated and how many online cpus.
+	 * Stop racing allocations by dropping *max temporarily.
+	 */
+	nr_cpus = 0;
+	nr_ptps = 0;
+	for_each_online_cpu(cpu) {
+		ptr = (void *) &per_cpu(page_states, cpu) + offset;
+		max = &per_cpu(max_page_table_pages, cpu);
+		*max = *ptr;
+		nr_ptps += *max;
+		nr_cpus++;
+	}
+
+	/*
+	 * Allow each cpu the same quota.  Subtract 1 to avoid the need
+	 * for barriers above: each racing cpu might allocate one table
+	 * too many, but will meet a barrier before it can get another.
+	 */
+	delta = ((MAX_PAGE_TABLE_PAGES - nr_ptps) / nr_cpus) - 1;
+	if (delta <= 0) {
+		spin_unlock(&max_page_tables_lock);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Redistribute new maxima amongst the online cpus.
+	 * Don't allow too much if a new cpu has come online; don't
+	 * worry if a cpu went offline, it'll get sorted eventually.
+	 */
+	for_each_online_cpu(cpu) {
+		max = &per_cpu(max_page_table_pages, cpu);
+		*max += delta;
+		--nr_cpus;
+		if (!nr_cpus)
+			break;
+	}
+	spin_unlock(&max_page_tables_lock);
+	goto again;
+}
+
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free, struct pglist_data *pgdat)
 {
@@ -2431,6 +2523,9 @@ static int page_alloc_cpu_notify(struct 
 			src[i] = 0;
 		}
 
+		src = (unsigned long *)&per_cpu(max_page_table_pages, cpu);
+		*src = 0;
+
 		local_irq_enable();
 	}
 	return NOTIFY_OK;
