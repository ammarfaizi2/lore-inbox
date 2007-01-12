Return-Path: <linux-kernel-owner+w=401wt.eu-S932344AbXALRF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbXALRF1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbXALRF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:05:27 -0500
Received: from [213.46.243.16] ([213.46.243.16]:58974 "EHLO
	amsfep11-int.chello.nl" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932344AbXALRFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:05:25 -0500
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20070112160104.GA5766@localhost.localdomain>
References: <20070112160104.GA5766@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 18:03:54 +0100
Message-Id: <1168621434.26496.50.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-12 at 08:01 -0800, Ravikiran G Thirumalai wrote:
> Hi,
> We noticed high interrupt hold off times while running some memory intensive
> tests on a Sun x4600 8 socket 16 core x86_64 box.  We noticed softlockups,
> lost ticks and even wall time drifting (which is probably a bug in the
> x86_64 timer subsystem). 
> 
> The test was simple, we have 16 processes, each allocating 3.5G of memory
> and and touching each and every page and returning.  Each of the process is
> bound to a node (socket), with the local node being the preferred node for
> allocation (numactl --cpubind=$node ./numa-membomb --preferred=$node).  Each
> socket has 4G of physical memory and there are two cores on each socket. On
> start of the test, the machine becomes unresponsive after sometime and
> prints out softlockup and OOM messages.  We then found out the cause
> for softlockups being the excessive spin times on zone_lru lock.  The fact
> that spin_lock_irq disables interrupts while spinning made matters very bad.
> We instrumented the spin_lock_irq code and found that the spin time on the
> lru locks was in the order of a few seconds (tens of seconds at times) and
> the hold time was comparatively lesser.
> 
> We did not use any lock debugging options and used plain old rdtsc to
> measure cycles.  (We disable cpu freq scaling in the BIOS). All we did was
> this:
> 
> void __lockfunc _spin_lock_irq(spinlock_t *lock)
> {
>         local_irq_disable();
>         ------------------------> rdtsc(t1);
>         preempt_disable();
>         spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
>         _raw_spin_lock(lock);
>         ------------------------> rdtsc(t2);
>         if (lock->spin_time < (t2 - t1))
>                 lock->spin_time = t2 - t1;
> }
> 
> On some runs, we found that the zone->lru_lock spun for 33 seconds or more
> while the maximal CS time was 3 seconds or so.
> 
> While the softlockups and the like went away by enabling interrupts during
> spinning, as mentioned in http://lkml.org/lkml/2007/1/3/29 ,
> Andi thought maybe this is exposing a problem with zone->lru_locks and 
> hence warrants a discussion on lkml, hence this post.  Are there any 
> plans/patches/ideas to address the spin time under such extreme conditions?
> 
> I will be happy to provide any additional information (config/dmesg/test
> case if needed.

I have been tinkering with this because -rt shows similar issues.
Find there the patch so far, it works on UP, but it still went *boom*
the last time I tried an actual SMP box.

So take this patch only as an indication of the direction I'm working
in.

One concern I have with the taken approach is cacheline bouncing.
Perhaps I should retain some form of per-cpu data structure.

---
Subject: mm: streamline zone->lock acquisition on lru_cache_add

By buffering the lru pages on a per cpu basis the flush of that buffer
is prone to bounce around zones. Furthermore release_pages can also acquire
the zone->lock.

Streeamline all this by replacing the per cpu buffer with a per zone
lockless buffer. Once the buffer is filled flush it and perform
all needed operation under one lock acquisition.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/mmzone.h |   12 +++
 mm/internal.h          |    2 
 mm/page_alloc.c        |   21 ++++++
 mm/swap.c              |  169 +++++++++++++++++++++++++++++++++----------------
 4 files changed, 149 insertions(+), 55 deletions(-)

Index: linux-2.6-rt/include/linux/mmzone.h
===================================================================
--- linux-2.6-rt.orig/include/linux/mmzone.h	2007-01-11 16:27:08.000000000 +0100
+++ linux-2.6-rt/include/linux/mmzone.h	2007-01-11 16:32:08.000000000 +0100
@@ -153,6 +153,17 @@ enum zone_type {
 #define ZONES_SHIFT 2
 #endif
 
+/*
+ * must be power of 2 to avoid wrap around artifacts
+ */
+#define PAGEBUF_SIZE	32
+
+struct pagebuf {
+	atomic_t head;
+	atomic_t tail;
+	struct page *pages[PAGEBUF_SIZE];
+};
+
 struct zone {
 	/* Fields commonly accessed by the page allocator */
 	unsigned long		free_pages;
@@ -188,6 +199,7 @@ struct zone {
 #endif
 	struct free_area	free_area[MAX_ORDER];
 
+	struct pagebuf		pagebuf;
 
 	ZONE_PADDING(_pad1_)
 
Index: linux-2.6-rt/mm/swap.c
===================================================================
--- linux-2.6-rt.orig/mm/swap.c	2007-01-11 16:27:08.000000000 +0100
+++ linux-2.6-rt/mm/swap.c	2007-01-11 16:36:34.000000000 +0100
@@ -31,6 +31,8 @@
 #include <linux/notifier.h>
 #include <linux/init.h>
 
+#include "internal.h"
+
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
 
@@ -170,49 +172,131 @@ void fastcall mark_page_accessed(struct 
 
 EXPORT_SYMBOL(mark_page_accessed);
 
+static int __pagebuf_add(struct zone *zone, struct page *page)
+{
+	BUG_ON(page_zone(page) != zone);
+
+	switch (page_count(page)) {
+	case 0:
+		BUG();
+
+	case 1:
+		/*
+		 * we're the sole owner, don't bother inserting
+		 */
+		if (PageActive(page))
+			ClearPageActive(page);
+		__put_page(page);
+		return 0;
+
+	default:
+		VM_BUG_ON(PageLRU(page));
+		SetPageLRU(page);
+		if (PageActive(page))
+			add_page_to_active_list(zone, page);
+		else
+			add_page_to_inactive_list(zone, page);
+
+		if (unlikely(put_page_testzero(page))) {
+			/*
+			 * we are the last, remove again
+			 */
+			VM_BUG_ON(!PageLRU(page));
+			ClearPageLRU(page);
+			del_page_from_lru(zone, page);
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
+static int __pagebuf_size(struct pagebuf *pb)
+{
+	int tail = atomic_read(&pb->tail);
+	int head = atomic_read(&pb->head);
+	int size = (head + PAGEBUF_SIZE - tail) % PAGEBUF_SIZE;
+
+	if (!size && pb->pages[tail])
+		size = PAGEBUF_SIZE;
+
+	return size;
+}
+
+static void __pagebuf_flush(struct zone *zone, int nr_pages)
+{
+	struct pagebuf *pb = &zone->pagebuf;
+	int i;
+
+	for (i = 0; i < nr_pages && __pagebuf_size(pb); i++) {
+		int pos = atomic_inc_return(&pb->tail) % PAGEBUF_SIZE;
+		struct page *page = pb->pages[pos];
+		if (page && cmpxchg(&pb->pages[pos], page, NULL) == page) {
+			if (!__pagebuf_add(zone, page))
+				__free_cache_page(zone, page);
+		}
+	}
+}
+
+static void pagebuf_flush(struct zone *zone)
+{
+	spin_lock_irq(&zone->lock);
+	__pagebuf_flush(zone, PAGEBUF_SIZE);
+	spin_unlock_irq(&zone->lock);
+}
+
+static void pagebuf_add(struct zone *zone, struct page *page)
+{
+	struct pagebuf *pb = &zone->pagebuf;
+	int pos;
+
+	pos = atomic_inc_return(&pb->head) % PAGEBUF_SIZE;
+	if (unlikely(cmpxchg(&pb->pages[pos], NULL, page) != NULL)) {
+		/*
+		 * This races, but should be harmless
+		 */
+		atomic_dec(&pb->head);
+		spin_lock_irq(&zone->lock);
+
+		if (!__pagebuf_add(zone, page))
+			__free_cache_page(zone, page);
+
+flush:
+		__pagebuf_flush(zone, PAGEBUF_SIZE);
+		spin_unlock_irq(&zone->lock);
+		return;
+	}
+
+	if (__pagebuf_size(pb) > PAGEBUF_SIZE/2 &&
+			spin_trylock_irq(&zone->lock))
+		goto flush;
+}
+
 /**
  * lru_cache_add: add a page to the page lists
  * @page: the page to add
  */
-static DEFINE_PER_CPU_LOCKED(struct pagevec, lru_add_pvecs) = { 0, };
-static DEFINE_PER_CPU_LOCKED(struct pagevec, lru_add_active_pvecs) = { 0, };
-
 void fastcall lru_cache_add(struct page *page)
 {
-	int cpu;
-	struct pagevec *pvec = &get_cpu_var_locked(lru_add_pvecs, &cpu);
-
 	page_cache_get(page);
-	if (!pagevec_add(pvec, page))
-		__pagevec_lru_add(pvec);
-	put_cpu_var_locked(lru_add_pvecs, cpu);
+	pagebuf_add(page_zone(page), page);
 }
 
 void fastcall lru_cache_add_active(struct page *page)
 {
-	int cpu;
-	struct pagevec *pvec = &get_cpu_var_locked(lru_add_active_pvecs, &cpu);
-
-	page_cache_get(page);
-	if (!pagevec_add(pvec, page))
-		__pagevec_lru_add_active(pvec);
-	put_cpu_var_locked(lru_add_active_pvecs, cpu);
+	VM_BUG_ON(PageActive(page));
+	SetPageActive(page);
+	lru_cache_add(page);
 }
 
 void lru_add_drain(void)
 {
-	struct pagevec *pvec;
-	int cpu;
+	int i;
+	struct zone *zones;
 
-	pvec = &get_cpu_var_locked(lru_add_pvecs, &cpu);
-	if (pagevec_count(pvec))
-		__pagevec_lru_add(pvec);
-	put_cpu_var_locked(lru_add_pvecs, cpu);
-
-	pvec = &get_cpu_var_locked(lru_add_active_pvecs, &cpu);
-	if (pagevec_count(pvec))
-		__pagevec_lru_add_active(pvec);
-	put_cpu_var_locked(lru_add_active_pvecs, cpu);
+	zones = NODE_DATA(cpu_to_node(cpu))->node_zones;
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		pagebuf_flush(&zones[i]);
 }
 
 #ifdef CONFIG_NUMA
@@ -351,25 +435,12 @@ void __pagevec_release_nonlru(struct pag
 void __pagevec_lru_add(struct pagevec *pvec)
 {
 	int i;
-	struct zone *zone = NULL;
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
 
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
-		VM_BUG_ON(PageLRU(page));
-		SetPageLRU(page);
-		add_page_to_inactive_list(zone, page);
+		pagebuf_add(page_zone(page), page);
 	}
-	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
-	release_pages(pvec->pages, pvec->nr, pvec->cold);
 	pagevec_reinit(pvec);
 }
 
@@ -378,27 +449,15 @@ EXPORT_SYMBOL(__pagevec_lru_add);
 void __pagevec_lru_add_active(struct pagevec *pvec)
 {
 	int i;
-	struct zone *zone = NULL;
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
 
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
-		VM_BUG_ON(PageLRU(page));
-		SetPageLRU(page);
 		VM_BUG_ON(PageActive(page));
 		SetPageActive(page);
-		add_page_to_active_list(zone, page);
+
+		pagebuf_add(page_zone(page), page);
 	}
-	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
-	release_pages(pvec->pages, pvec->nr, pvec->cold);
 	pagevec_reinit(pvec);
 }
 
Index: linux-2.6-rt/mm/internal.h
===================================================================
--- linux-2.6-rt.orig/mm/internal.h	2007-01-11 16:27:08.000000000 +0100
+++ linux-2.6-rt/mm/internal.h	2007-01-11 16:27:15.000000000 +0100
@@ -37,4 +37,6 @@ static inline void __put_page(struct pag
 extern void fastcall __init __free_pages_bootmem(struct page *page,
 						unsigned int order);
 
+extern void __free_cache_page(struct zone *zone, struct page *page);
+
 #endif
Index: linux-2.6-rt/mm/page_alloc.c
===================================================================
--- linux-2.6-rt.orig/mm/page_alloc.c	2007-01-11 16:27:08.000000000 +0100
+++ linux-2.6-rt/mm/page_alloc.c	2007-01-11 16:27:15.000000000 +0100
@@ -555,6 +555,27 @@ static void __free_pages_ok(struct page 
 	unlock_cpu_pcp(flags, this_cpu);
 }
 
+void __free_cache_page(struct zone *zone, struct page *page)
+{
+	BUG_ON(PageCompound(page));
+
+	if (PageAnon(page))
+		page->mapping = NULL;
+	if (free_pages_check(page))
+		return;
+
+	if (!PageHighMem(page))
+		debug_check_no_locks_freed(page_address(page),PAGE_SIZE);
+
+	arch_free_page(page, 0);
+	kernel_map_pages(page, 1, 0);
+
+	__count_vm_events(PGFREE, 1);
+	zone->all_unreclaimable = 0;
+	zone->pages_scanned = 0;
+	__free_one_page(page, zone, 0);
+}
+
 /*
  * permit the bootmem allocator to evade page validation on high-order frees
  */


