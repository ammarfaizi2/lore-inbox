Return-Path: <linux-kernel-owner+w=401wt.eu-S1750880AbXAPK2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbXAPK2i (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 05:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbXAPK2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 05:28:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43217 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbXAPK2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 05:28:23 -0500
Message-Id: <20070116101815.148698000@taijtu.programming.kicks-ass.net>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
User-Agent: quilt/0.46-1
Date: Tue, 16 Jan 2007 10:45:58 +0100
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org
Cc: David Miller <davem@davemloft.net>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/9] mm: page allocation rank
Content-Disposition: inline; filename=page_alloc-rank.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce page allocation rank.

This allocation rank is an measure of the 'hardness' of the page allocation.
Where hardness refers to how deep we have to reach (and thereby if reclaim 
was activated) to obtain the page.

It basically is a mapping from the ALLOC_/gfp flags into a scalar quantity,
which allows for comparisons of the kind: 
  'would this allocation have succeeded using these gfp flags'.

For the gfp -> alloc_flags mapping we use the 'hardest' possible, those
used by __alloc_pages() right before going into direct reclaim.

The alloc_flags -> rank mapping is given by: 2*2^wmark - harder - 2*high
where wmark = { min = 1, low, high } and harder, high are booleans.
This gives:
  0 is the hardest possible allocation - ALLOC_NO_WATERMARK,
  1 is ALLOC_WMARK_MIN|ALLOC_HARDER|ALLOC_HIGH,
  ...
  15 is ALLOC_WMARK_HIGH|ALLOC_HARDER,
  16 is the softest allocation - ALLOC_WMARK_HIGH.

Rank <= 4 will have woke up kswapd and when also > 0 might have ran into
direct reclaim.

Rank > 8 rarely happens and means lots of memory free (due to parallel oom kill).

The allocation rank is stored in page->index for successful allocations.

'offline' testing of the rank is made impossible by direct reclaim and
fragmentation issues. That is, it is impossible to tell if a given allocation
will succeed without actually doing it.

The purpose of this measure is to introduce some fairness into the slab
allocator.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 mm/internal.h   |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c |   58 ++++++++++--------------------------
 2 files changed, 106 insertions(+), 41 deletions(-)

Index: linux-2.6-git/mm/internal.h
===================================================================
--- linux-2.6-git.orig/mm/internal.h	2007-01-08 11:53:13.000000000 +0100
+++ linux-2.6-git/mm/internal.h	2007-01-09 11:29:18.000000000 +0100
@@ -12,6 +12,7 @@
 #define __MM_INTERNAL_H
 
 #include <linux/mm.h>
+#include <linux/hardirq.h>
 
 static inline void set_page_count(struct page *page, int v)
 {
@@ -37,4 +38,92 @@ static inline void __put_page(struct pag
 extern void fastcall __init __free_pages_bootmem(struct page *page,
 						unsigned int order);
 
+#define ALLOC_HARDER		0x01 /* try to alloc harder */
+#define ALLOC_HIGH		0x02 /* __GFP_HIGH set */
+#define ALLOC_WMARK_MIN		0x04 /* use pages_min watermark */
+#define ALLOC_WMARK_LOW		0x08 /* use pages_low watermark */
+#define ALLOC_WMARK_HIGH	0x10 /* use pages_high watermark */
+#define ALLOC_NO_WATERMARKS	0x20 /* don't check watermarks at all */
+#define ALLOC_CPUSET		0x40 /* check for correct cpuset */
+
+/*
+ * get the deepest reaching allocation flags for the given gfp_mask
+ */
+static int inline gfp_to_alloc_flags(gfp_t gfp_mask)
+{
+	struct task_struct *p = current;
+	int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
+	const gfp_t wait = gfp_mask & __GFP_WAIT;
+
+	/*
+	 * The caller may dip into page reserves a bit more if the caller
+	 * cannot run direct reclaim, or if the caller has realtime scheduling
+	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
+	 * set both ALLOC_HARDER (!wait) and ALLOC_HIGH (__GFP_HIGH).
+	 */
+	if (gfp_mask & __GFP_HIGH)
+		alloc_flags |= ALLOC_HIGH;
+
+	if (!wait) {
+		alloc_flags |= ALLOC_HARDER;
+		/*
+		 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
+		 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
+		 */
+		alloc_flags &= ~ALLOC_CPUSET;
+	} else if (unlikely(rt_task(p)) && !in_interrupt())
+		alloc_flags |= ALLOC_HARDER;
+
+	if (likely(!(gfp_mask & __GFP_NOMEMALLOC))) {
+		if (!in_interrupt() &&
+		    ((p->flags & PF_MEMALLOC) ||
+		     unlikely(test_thread_flag(TIF_MEMDIE))))
+			alloc_flags |= ALLOC_NO_WATERMARKS;
+	}
+
+	return alloc_flags;
+}
+
+#define MAX_ALLOC_RANK	16
+
+/*
+ * classify the allocation: 0 is hardest, 16 is easiest.
+ */
+static inline int alloc_flags_to_rank(int alloc_flags)
+{
+	int rank;
+
+	if (alloc_flags & ALLOC_NO_WATERMARKS)
+		return 0;
+
+	rank = alloc_flags & (ALLOC_WMARK_MIN|ALLOC_WMARK_LOW|ALLOC_WMARK_HIGH);
+	rank -= alloc_flags & (ALLOC_HARDER|ALLOC_HIGH);
+
+	return rank;
+}
+
+static inline int gfp_to_rank(gfp_t gfp_mask)
+{
+	/*
+	 * Although correct this full version takes a ~3% performance
+	 * hit on the network tests in aim9.
+	 *
+
+	return alloc_flags_to_rank(gfp_to_alloc_flags(gfp_mask));
+
+	 *
+	 * Just check the bare essential ALLOC_NO_WATERMARKS case this keeps
+	 * the aim9 results within the error margin.
+	 */
+
+	if (likely(!(gfp_mask & __GFP_NOMEMALLOC))) {
+		if (!in_interrupt() &&
+		    ((current->flags & PF_MEMALLOC) ||
+		     unlikely(test_thread_flag(TIF_MEMDIE))))
+			return 0;
+	}
+
+	return 1;
+}
+
 #endif
Index: linux-2.6-git/mm/page_alloc.c
===================================================================
--- linux-2.6-git.orig/mm/page_alloc.c	2007-01-08 11:53:13.000000000 +0100
+++ linux-2.6-git/mm/page_alloc.c	2007-01-09 11:29:18.000000000 +0100
@@ -888,14 +888,6 @@ failed:
 	return NULL;
 }
 
-#define ALLOC_NO_WATERMARKS	0x01 /* don't check watermarks at all */
-#define ALLOC_WMARK_MIN		0x02 /* use pages_min watermark */
-#define ALLOC_WMARK_LOW		0x04 /* use pages_low watermark */
-#define ALLOC_WMARK_HIGH	0x08 /* use pages_high watermark */
-#define ALLOC_HARDER		0x10 /* try to alloc harder */
-#define ALLOC_HIGH		0x20 /* __GFP_HIGH set */
-#define ALLOC_CPUSET		0x40 /* check for correct cpuset */
-
 #ifdef CONFIG_FAIL_PAGE_ALLOC
 
 static struct fail_page_alloc_attr {
@@ -1186,6 +1178,7 @@ zonelist_scan:
 
 		page = buffered_rmqueue(zonelist, zone, order, gfp_mask);
 		if (page)
+			page->index = alloc_flags_to_rank(alloc_flags);
 			break;
 this_zone_full:
 		if (NUMA_BUILD)
@@ -1259,48 +1252,27 @@ restart:
 	 * OK, we're below the kswapd watermark and have kicked background
 	 * reclaim. Now things get more complex, so set up alloc_flags according
 	 * to how we want to proceed.
-	 *
-	 * The caller may dip into page reserves a bit more if the caller
-	 * cannot run direct reclaim, or if the caller has realtime scheduling
-	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
-	 * set both ALLOC_HARDER (!wait) and ALLOC_HIGH (__GFP_HIGH).
 	 */
-	alloc_flags = ALLOC_WMARK_MIN;
-	if ((unlikely(rt_task(p)) && !in_interrupt()) || !wait)
-		alloc_flags |= ALLOC_HARDER;
-	if (gfp_mask & __GFP_HIGH)
-		alloc_flags |= ALLOC_HIGH;
-	if (wait)
-		alloc_flags |= ALLOC_CPUSET;
+	alloc_flags = gfp_to_alloc_flags(gfp_mask);
 
-	/*
-	 * Go through the zonelist again. Let __GFP_HIGH and allocations
-	 * coming from realtime tasks go deeper into reserves.
-	 *
-	 * This is the last chance, in general, before the goto nopage.
-	 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
-	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
-	 */
-	page = get_page_from_freelist(gfp_mask, order, zonelist, alloc_flags);
+	/* This is the last chance, in general, before the goto nopage. */
+	page = get_page_from_freelist(gfp_mask, order, zonelist,
+			alloc_flags & ~ALLOC_NO_WATERMARKS);
 	if (page)
 		goto got_pg;
 
 	/* This allocation should allow future memory freeing. */
-
 rebalance:
-	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
-			&& !in_interrupt()) {
-		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
+	if (alloc_flags & ALLOC_NO_WATERMARKS) {
 nofail_alloc:
-			/* go through the zonelist yet again, ignoring mins */
-			page = get_page_from_freelist(gfp_mask, order,
+		/* go through the zonelist yet again, ignoring mins */
+		page = get_page_from_freelist(gfp_mask, order,
 				zonelist, ALLOC_NO_WATERMARKS);
-			if (page)
-				goto got_pg;
-			if (gfp_mask & __GFP_NOFAIL) {
-				congestion_wait(WRITE, HZ/50);
-				goto nofail_alloc;
-			}
+		if (page)
+			goto got_pg;
+		if (wait && (gfp_mask & __GFP_NOFAIL)) {
+			congestion_wait(WRITE, HZ/50);
+			goto nofail_alloc;
 		}
 		goto nopage;
 	}
@@ -1309,6 +1281,10 @@ nofail_alloc:
 	if (!wait)
 		goto nopage;
 
+	/* Avoid recursion of direct reclaim */
+	if (p->flags & PF_MEMALLOC)
+		goto nopage;
+
 	cond_resched();
 
 	/* We now go into synchronous reclaim */

-- 

