Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270725AbRHPDiv>; Wed, 15 Aug 2001 23:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270727AbRHPDim>; Wed, 15 Aug 2001 23:38:42 -0400
Received: from mailb.telia.com ([194.22.194.6]:32260 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S270725AbRHPDib>;
	Wed, 15 Aug 2001 23:38:31 -0400
Message-Id: <200108160337.FAA11729@mailb.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] alternative way of calculating inactive_target
Date: Thu, 16 Aug 2001 05:33:22 +0200
X-Mailer: KMail [version 1.3]
Cc: <linux-mm@kvack.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

1. Two things in this file, first an unrelated issue (but included in the patch)
global_target in free_shortage shouldn't it be freepages.low?
Traditionally freepages.high has been when to stop freeing pages.

2. I have wondered about how inactive_target is calculated.
This is an alternative approach...

In this alternative approach I use two wrapping counters.
(memory_clock & memory_clock_rubberband)

memory_clock is incremented only when allocating pages (and it
is never decremented)

memory_clock_rubberband is calculated to be close to what
memory_clock should have been for MEMORY_CLOCK_WINDOW seconds
earlier, using current values and information about how long it was since it
was updated the last time. This makes it possible to recalculate the target
more often when pressure is high - and it simplifies kswapd too...

/RogerL

*******************************************
Patch prepared by: roger.larsson@norran.net

--- linux/mm/vmscan.c.orig	Wed Aug 15 23:28:31 2001
+++ linux/mm/vmscan.c	Thu Aug 16 03:45:10 2001
@@ -445,7 +445,6 @@
 	goto out;
 
 found_page:
-	memory_pressure++;
 	del_page_from_inactive_clean_list(page);
 	UnlockPage(page);
 	page->age = PAGE_AGE_START;
@@ -743,7 +742,7 @@
 {
 	pg_data_t *pgdat;
 	unsigned int global_free = 0;
-	unsigned int global_target = freepages.high;
+	unsigned int global_target = freepages.low;
 
 	/* Are we low on free pages anywhere? */
 	pgdat = pgdat_list;
@@ -781,6 +780,12 @@
 	unsigned int global_target = freepages.high + inactive_target;
 	unsigned int global_incative = 0;
 
+	/* In future when freepages.high is writeable.
+	 * meaning: stop when you have freepages.high!
+	 *
+	 * global_target = min(global_target, freepages.high)
+	 */
+
 	pgdat = pgdat_list;
 	do {
 		int i;
@@ -914,15 +919,8 @@
 	 * Kswapd main loop.
 	 */
 	for (;;) {
-		static long recalc = 0;
-
-		/* Once a second ... */
-		if (time_after(jiffies, recalc + HZ)) {
-			recalc = jiffies;
-
-			/* Recalculate VM statistics. */
-			recalculate_vm_stats();
-		}
+		/* Recalculate VM statistics. Time independent implementation */
+		recalculate_vm_stats();
 
 		if (!do_try_to_free_pages(GFP_KSWAPD, 1)) {
 			if (out_of_memory())
--- linux/mm/page_alloc.c.orig	Wed Aug 15 23:55:24 2001
+++ linux/mm/page_alloc.c	Thu Aug 16 03:16:19 2001
@@ -135,14 +135,6 @@
 	memlist_add_head(&(base + page_idx)->list, &area->free_list);
 
 	spin_unlock_irqrestore(&zone->lock, flags);
-
-	/*
-	 * We don't want to protect this variable from race conditions
-	 * since it's nothing important, but we do want to make sure
-	 * it never gets negative.
-	 */
-	if (memory_pressure > NR_CPUS)
-		memory_pressure--;
 }
 
 #define MARK_USED(index, order, area) \
@@ -288,7 +280,10 @@
 	/*
 	 * Allocations put pressure on the VM subsystem.
 	 */
-	memory_pressure++;
+	memory_clock++;
+	/* prevent dangerous wrap difference due to extremely fast allocs */
+	if (memory_clock - memory_clock_rubberband >= MEMORY_CLOCK_MAX_DIFF)
+		memory_clock_rubberband++;
 
 	/*
 	 * (If anyone calls gfp from interrupts nonatomically then it
--- linux/mm/swap.c.orig	Wed Aug 15 23:58:30 2001
+++ linux/mm/swap.c	Thu Aug 16 04:09:02 2001
@@ -46,11 +46,11 @@
  * is doing, averaged over a minute. We use this to determine how
  * many inactive pages we should have.
  *
- * In reclaim_page and __alloc_pages: memory_pressure++
- * In __free_pages_ok: memory_pressure--
- * In recalculate_vm_stats the value is decayed (once a second)
+ * In __alloc_pages: memory_clock++
+ * In recalculate_vm_stats the memory_clock_rubberband is moved (once a second)
  */
-int memory_pressure;
+int memory_clock;
+int memory_clock_rubberband;
 
 /* We track the number of pages currently being asynchronously swapped
    out, so that we don't try to swap TOO many pages out at once */
@@ -201,13 +201,33 @@
  * some useful statistics the VM subsystem uses to determine
  * its behaviour.
  */
+
 void recalculate_vm_stats(void)
 {
-	/*
-	 * Substract one second worth of memory_pressure from
-	 * memory_pressure.
-	 */
-	memory_pressure -= (memory_pressure >> INACTIVE_SHIFT);
+	static unsigned long jiffies_at_prev_update;
+	unsigned long jiffies_now = jiffies;
+
+	if (jiffies_now != jiffies_at_prev_update)
+	{
+		long elapsed = jiffies_now - jiffies_at_prev_update;
+
+		/*
+		 * Substract one second worth of memory_pressure from
+		 * memory_pressure.
+		 */
+		int old = memory_clock_rubberband;
+
+		/* "exact" formula... can be optimised */
+		int diff = (elapsed * (memory_clock - old) + (MEMORY_CLOCK_WINDOW * HZ + elapsed - 1)) / (MEMORY_CLOCK_WINDOW * HZ + elapsed);
+		
+		/* new can NEVER pass memory_clock since this is the only place were it is changed if the values
+		 * are close but it will sooner or later catch up with it */
+		int new = old + diff;
+
+		memory_clock_rubberband = new;
+
+		jiffies_at_prev_update = jiffies_now;
+	}
 }
 
 /*
--- linux/include/linux/swap.h.orig	Wed Aug 15 23:36:27 2001
+++ linux/include/linux/swap.h	Thu Aug 16 05:25:16 2001
@@ -99,7 +99,8 @@
 struct zone_t;
 
 /* linux/mm/swap.c */
-extern int memory_pressure;
+extern int memory_clock;
+extern int memory_clock_rubberband;
 extern void deactivate_page(struct page *);
 extern void deactivate_page_nolock(struct page *);
 extern void activate_page(struct page *);
@@ -249,16 +250,27 @@
 	ZERO_PAGE_BUG \
 }
 
+
+/*
+ * The memory_clock_rubberband is calculated to be
+ * approximately where memory_clock were for
+ * MEMORY_CLOCK_WINDOW seconds since.
+ * Note: please use a power of two...
+ */
+#define MEMORY_CLOCK_WINDOW 2
+
+/* to prevent overflow in calculations */
+#define MEMORY_CLOCK_MAX_DIFF ((1 << (8*sizeof(memory_clock) - 2)) / (MEMORY_CLOCK_WINDOW*HZ))
+
 /*
- * In mm/swap.c::recalculate_vm_stats(), we substract
- * inactive_target from memory_pressure every second.
- * This means that memory_pressure is smoothed over
- * 64 (1 << INACTIVE_SHIFT) seconds.
+ * The inactive_target is measured in pages/second
+ * In mm/swap.c::recalculate_vm_stats(), we move
+ * the memory_clock_rubberband
+ * Note: difference can never be negative, unsigned wrap is taken care of
+ *
  */
-#define INACTIVE_SHIFT 6
-#define inactive_min(a,b) ((a) < (b) ? (a) : (b))
-#define inactive_target inactive_min((memory_pressure >> INACTIVE_SHIFT), \
-		(num_physpages / 4))
+#define inactive_target ((memory_clock - memory_clock_rubberband)/MEMORY_CLOCK_WINDOW)
+
 
 /*
  * Ugly ugly ugly HACK to make sure the inactive lists
