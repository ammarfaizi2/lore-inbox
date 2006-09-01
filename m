Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWIALL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWIALL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWIALLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:11:44 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:1365 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751485AbWIALL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:11:26 -0400
Date: Fri, 1 Sep 2006 13:11:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com,
       rhim@cc.gateh.edu
Subject: [patch 8/9] Guest page hinting: discarded page list.
Message-ID: <20060901111117.GI15684@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[patch 8/9] Guest page hinting: discarded page list.

The discarded page list is used to postpone the freeing of discarded
pages. The PG_discarded is set by either __remove_from_page_cache,
__delete_from_swap_cache or the discard fault handler for pages that
have been removed by the host. free_hot_cold_page test for the bit
and puts the page to a per-cpu discarded page list if it is set.
try_to_free_pages does an smp_call_function to collect all the
partial discarded page lists and frees them.

There are two reasons why this is desirable. First, discarded page are
really cold. Before the guest can reaccess the page frame the host
needs to provide a fresh page. It is faster to use only non-discarded
pages which do not require a host action as long as the working set
of the guest allows it.

The second reason has to do with the peculiars of the s390 architecture.
The discard fault exception delivers the absolute address of the page
that caused the fault to the guest instead of the virtual address. With
the virtual address we could have used the page table entry of the
current process to safely get a reference to the discarded page. We can
get to the struct page from the absolute page address but it is rather
hard to get to a proper page reference. The page that caused the fault
could already have been freed and reused for a different purpose. None
of the fields in the struct page would be reliable to use. The discard
list and the call of smp_call_function before freeing discarded pages
makes sure that the discard fault handler is reached only for pages that
have not been freed yet. A call to get_page_unless_zero can then be used
to get a proper page reference.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/page-states.h |    4 +++
 mm/page_alloc.c             |   56 ++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                 |    3 ++
 3 files changed, 63 insertions(+)

diff -urpN linux-2.6/include/linux/page-states.h linux-2.6-patched/include/linux/page-states.h
--- linux-2.6/include/linux/page-states.h	2006-09-01 12:50:25.000000000 +0200
+++ linux-2.6-patched/include/linux/page-states.h	2006-09-01 12:50:25.000000000 +0200
@@ -69,9 +69,13 @@
  * - page_reset_writable:
  *     Resets the page state after the last writable page table entry
  *     refering to the page has been removed.
+ * - page_shrink_discards:
+ *     Frees all pages that free_hot_cold_page has put on the list of
+ *     discarded pages.
  */
 extern void page_unmap_all(struct page *page);
 extern void page_discard(struct page *page);
+extern unsigned long page_shrink_discards(void);
 
 static inline int page_make_stable(struct page *page)
 {
diff -urpN linux-2.6/mm/page_alloc.c linux-2.6-patched/mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c	2006-09-01 12:50:25.000000000 +0200
+++ linux-2.6-patched/mm/page_alloc.c	2006-09-01 12:50:25.000000000 +0200
@@ -786,6 +786,42 @@ void drain_local_pages(void)
 }
 #endif /* CONFIG_PM */
 
+#if defined(CONFIG_PAGE_DISCARD_LIST)
+DEFINE_PER_CPU(struct list_head, page_discard_list);
+
+static void __page_shrink_discards(void *info)
+{
+	static DEFINE_SPINLOCK(splice_lock);
+	struct list_head *discard_list = info;
+	struct list_head *cpu_list = &__get_cpu_var(page_discard_list);
+
+	if (list_empty(cpu_list))
+		return;
+	spin_lock(&splice_lock);
+	list_splice_init(cpu_list, discard_list);
+	spin_unlock(&splice_lock);
+}
+
+unsigned long page_shrink_discards(void)
+{
+	struct list_head pages_to_free = LIST_HEAD_INIT(pages_to_free);
+	struct page *page, *next;
+	unsigned long freed = 0;
+
+	if (!page_host_discards())
+		return 0;
+
+	on_each_cpu(__page_shrink_discards, &pages_to_free, 0, 1);
+
+	list_for_each_entry_safe(page, next, &pages_to_free, lru) {
+		ClearPageDiscarded(page);
+		free_cold_page(page);
+		freed++;
+	}
+	return freed;
+}
+#endif
+
 /*
  * Free a 0-order page
  */
@@ -795,6 +831,16 @@ static void fastcall free_hot_cold_page(
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
 
+#if defined(CONFIG_PAGE_DISCARD_LIST)
+	if (page_host_discards() && unlikely(PageDiscarded(page))) {
+		local_irq_disable();
+		list_add_tail(&page->lru,
+			      &__get_cpu_var(page_discard_list));
+		local_irq_enable();
+		return;
+	}
+#endif
+
 	arch_free_page(page, 0);
 
 	if (PageAnon(page))
@@ -2810,6 +2856,10 @@ static int page_alloc_cpu_notify(struct 
 		local_irq_disable();
 		__drain_pages(cpu);
 		vm_events_fold_cpu(cpu);
+#if defined(CONFIG_PAGE_DISCARD_LIST)
+		list_splice_init(&per_cpu(page_discard_list, cpu),
+ 				 &__get_cpu_var(page_discard_list));
+#endif
 		local_irq_enable();
 		refresh_cpu_vm_stats(cpu);
 	}
@@ -2819,6 +2869,12 @@ static int page_alloc_cpu_notify(struct 
 
 void __init page_alloc_init(void)
 {
+#if defined(CONFIG_PAGE_DISCARD_LIST)
+	int i;
+
+	for_each_possible_cpu(i)
+		INIT_LIST_HEAD(&per_cpu(page_discard_list, i));
+#endif
 	hotcpu_notifier(page_alloc_cpu_notify, 0);
 }
 
diff -urpN linux-2.6/mm/vmscan.c linux-2.6-patched/mm/vmscan.c
--- linux-2.6/mm/vmscan.c	2006-09-01 12:50:23.000000000 +0200
+++ linux-2.6-patched/mm/vmscan.c	2006-09-01 12:50:25.000000000 +0200
@@ -1034,6 +1034,9 @@ unsigned long try_to_free_pages(struct z
 		sc.nr_scanned = 0;
 		if (!priority)
 			disable_swap_token();
+#ifdef CONFIG_PAGE_DISCARD_LIST
+		nr_reclaimed += page_shrink_discards();
+#endif
 		nr_reclaimed += shrink_zones(priority, zones, &sc);
 		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
 		if (reclaim_state) {
