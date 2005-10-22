Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVJVQbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVJVQbj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVJVQbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:31:39 -0400
Received: from gold.veritas.com ([143.127.12.110]:5382 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932265AbVJVQbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:31:38 -0400
Date: Sat, 22 Oct 2005 17:30:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] mm: fix rss and mmlist locking
In-Reply-To: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510221729200.18047@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Oct 2005 16:31:38.0124 (UTC) FILETIME=[133A3CC0:01C5D726]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of oddities were guarded by page_table_lock, no longer properly
guarded when that is split.

The mm_counters of file_rss and anon_rss: make those an atomic_t, or an
atomic64_t if the architecture supports it, in such a case.  Definitions
by courtesy of Christoph Lameter: who spent considerable effort on more
scalable ways of counting, but found insufficient benefit in practice.

And adding an mm with swap to the mmlist for swapoff: the list is well-
guarded by its own lock, but the list_empty check now has to be repeated
inside it.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/sched.h |   42 ++++++++++++++++++++++++++++++++++++++----
 mm/memory.c           |    4 +++-
 mm/rmap.c             |    3 ++-
 3 files changed, 43 insertions(+), 6 deletions(-)

--- mm7/include/linux/sched.h	2005-10-17 12:05:38.000000000 +0100
+++ mm8/include/linux/sched.h	2005-10-22 14:07:39.000000000 +0100
@@ -250,13 +250,47 @@ arch_get_unmapped_area_topdown(struct fi
 extern void arch_unmap_area(struct mm_struct *, unsigned long);
 extern void arch_unmap_area_topdown(struct mm_struct *, unsigned long);
 
+#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
+/*
+ * The mm counters are not protected by its page_table_lock,
+ * so must be incremented atomically.
+ */
+#ifdef ATOMIC64_INIT
+#define set_mm_counter(mm, member, value) atomic64_set(&(mm)->_##member, value)
+#define get_mm_counter(mm, member) ((unsigned long)atomic64_read(&(mm)->_##member))
+#define add_mm_counter(mm, member, value) atomic64_add(value, &(mm)->_##member)
+#define inc_mm_counter(mm, member) atomic64_inc(&(mm)->_##member)
+#define dec_mm_counter(mm, member) atomic64_dec(&(mm)->_##member)
+typedef atomic64_t mm_counter_t;
+#else /* !ATOMIC64_INIT */
+/*
+ * The counters wrap back to 0 at 2^32 * PAGE_SIZE,
+ * that is, at 16TB if using 4kB page size.
+ */
+#define set_mm_counter(mm, member, value) atomic_set(&(mm)->_##member, value)
+#define get_mm_counter(mm, member) ((unsigned long)atomic_read(&(mm)->_##member))
+#define add_mm_counter(mm, member, value) atomic_add(value, &(mm)->_##member)
+#define inc_mm_counter(mm, member) atomic_inc(&(mm)->_##member)
+#define dec_mm_counter(mm, member) atomic_dec(&(mm)->_##member)
+typedef atomic_t mm_counter_t;
+#endif /* !ATOMIC64_INIT */
+
+#else  /* NR_CPUS < CONFIG_SPLIT_PTLOCK_CPUS */
+/*
+ * The mm counters are protected by its page_table_lock,
+ * so can be incremented directly.
+ */
 #define set_mm_counter(mm, member, value) (mm)->_##member = (value)
 #define get_mm_counter(mm, member) ((mm)->_##member)
 #define add_mm_counter(mm, member, value) (mm)->_##member += (value)
 #define inc_mm_counter(mm, member) (mm)->_##member++
 #define dec_mm_counter(mm, member) (mm)->_##member--
-#define get_mm_rss(mm) ((mm)->_file_rss + (mm)->_anon_rss)
+typedef unsigned long mm_counter_t;
+
+#endif /* NR_CPUS < CONFIG_SPLIT_PTLOCK_CPUS */
 
+#define get_mm_rss(mm)					\
+	(get_mm_counter(mm, file_rss) + get_mm_counter(mm, anon_rss))
 #define update_hiwater_rss(mm)	do {			\
 	unsigned long _rss = get_mm_rss(mm);		\
 	if ((mm)->hiwater_rss < _rss)			\
@@ -267,8 +301,6 @@ extern void arch_unmap_area_topdown(stru
 		(mm)->hiwater_vm = (mm)->total_vm;	\
 } while (0)
 
-typedef unsigned long mm_counter_t;
-
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
@@ -292,7 +324,9 @@ struct mm_struct {
 						 * by mmlist_lock
 						 */
 
-	/* Special counters protected by the page_table_lock */
+	/* Special counters, in some configurations protected by the
+	 * page_table_lock, in other configurations by being atomic.
+	 */
 	mm_counter_t _file_rss;
 	mm_counter_t _anon_rss;
 
--- mm7/mm/memory.c	2005-10-22 14:07:25.000000000 +0100
+++ mm8/mm/memory.c	2005-10-22 14:07:40.000000000 +0100
@@ -372,7 +372,9 @@ copy_one_pte(struct mm_struct *dst_mm, s
 			/* make sure dst_mm is on swapoff's mmlist. */
 			if (unlikely(list_empty(&dst_mm->mmlist))) {
 				spin_lock(&mmlist_lock);
-				list_add(&dst_mm->mmlist, &src_mm->mmlist);
+				if (list_empty(&dst_mm->mmlist))
+					list_add(&dst_mm->mmlist,
+						 &src_mm->mmlist);
 				spin_unlock(&mmlist_lock);
 			}
 		}
--- mm7/mm/rmap.c	2005-10-22 14:07:25.000000000 +0100
+++ mm8/mm/rmap.c	2005-10-22 14:07:40.000000000 +0100
@@ -559,7 +559,8 @@ static int try_to_unmap_one(struct page 
 		swap_duplicate(entry);
 		if (list_empty(&mm->mmlist)) {
 			spin_lock(&mmlist_lock);
-			list_add(&mm->mmlist, &init_mm.mmlist);
+			if (list_empty(&mm->mmlist))
+				list_add(&mm->mmlist, &init_mm.mmlist);
 			spin_unlock(&mmlist_lock);
 		}
 		set_pte_at(mm, address, pte, swp_entry_to_pte(entry));
