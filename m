Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVJ2Bdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVJ2Bdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 21:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVJ2Bdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 21:33:43 -0400
Received: from fmr24.intel.com ([143.183.121.16]:2449 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750863AbVJ2Bdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 21:33:42 -0400
Date: Fri, 28 Oct 2005 18:33:26 -0700
From: "Rohit, Seth" <rohit.seth@intel.com>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: Clean up of __alloc_pages
Message-ID: <20051028183326.A28611@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH]: Below is the cleanup of __alloc_pages code.  As discussed earlier,
the only changes in this clean up are:

	1- remove the initial direct reclaim logic
	2- GFP_HIGH pages are allowed to go little below low watermark sooner
	3- Search for free pages unconditionally after direct reclaim

I've not added the logic of looking into PCPs first in this rev of patch.  I will send a
seperate patch for adding that support (needing extra logic for NUMA).

	Signed-off-by: Rohit Seth <rohit.seth@intel.com>


diff -Naru linux-2.6.14.org/mm/page_alloc.c linux-2.6.14/mm/page_alloc.c
--- linux-2.6.14.org/mm/page_alloc.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14/mm/page_alloc.c	2005-10-28 10:11:39.000000000 -0700
@@ -685,8 +685,8 @@
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
  * or two.
  */
-static struct page *
-buffered_rmqueue(struct zone *zone, int order, gfp_t gfp_flags)
+static inline struct page *
+buffered_rmqueue(struct zone *zone, int order, gfp_t gfp_flags, int replenish)
 {
 	unsigned long flags;
 	struct page *page = NULL;
@@ -697,7 +697,7 @@
 
 		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 		local_irq_save(flags);
-		if (pcp->count <= pcp->low)
+		if ((pcp->count <= pcp->low) && replenish)
 			pcp->count += rmqueue_bulk(zone, 0,
 						pcp->batch, &pcp->list);
 		if (pcp->count) {
@@ -707,9 +707,7 @@
 		}
 		local_irq_restore(flags);
 		put_cpu();
-	}
-
-	if (page == NULL) {
+	} else {
 		spin_lock_irqsave(&zone->lock, flags);
 		page = __rmqueue(zone, order);
 		spin_unlock_irqrestore(&zone->lock, flags);
@@ -770,6 +768,44 @@
 	return 1;
 }
 
+/* get_page_from_freeliest loops through all the possible zones
+ * to find out if it can allocate a page.  can_try_harder can have following 
+ * values:
+ * -1 => No need to check for the watermarks.
+ *  0 => Don't go too low down in deeps below the low watermark (GFP_HIGH)
+ *  1 => Go far below the low watermark.  See zone_watermark_ok (RT TASK)
+ */
+
+static struct page *
+get_page_from_freelist(unsigned int __nocast gfp_mask, unsigned int order, 
+			struct zone **zones, int can_try_harder)
+{
+	struct zone *z;
+	struct page *page = NULL;
+	int classzone_idx = zone_idx(zones[0]);
+	int i;
+
+	/*
+	 * Go through the zonelist once, looking for a zone with enough free.
+	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
+	 */
+	for (i = 0; (z = zones[i]) != NULL; i++) {
+		if (!cpuset_zone_allowed(z, gfp_mask))
+			continue;
+
+		if ((can_try_harder >= 0) && 
+			(!zone_watermark_ok(z, order, z->pages_low,
+				       classzone_idx, can_try_harder, 
+				       gfp_mask & __GFP_HIGH)))
+			continue;
+
+		page = buffered_rmqueue(z, order, gfp_mask, 1);
+		if (page) 
+			break;
+	}
+	return page;
+}
+
 /*
  * This is the 'heart' of the zoned buddy allocator.
  */
@@ -778,15 +814,13 @@
 		struct zonelist *zonelist)
 {
 	const int wait = gfp_mask & __GFP_WAIT;
-	struct zone **zones, *z;
+	struct zone **zones, *z = NULL;
 	struct page *page;
 	struct reclaim_state reclaim_state;
 	struct task_struct *p = current;
 	int i;
-	int classzone_idx;
 	int do_retry;
 	int can_try_harder;
-	int did_some_progress;
 
 	might_sleep_if(wait);
 
@@ -803,42 +837,10 @@
 		/* Should this ever happen?? */
 		return NULL;
 	}
-
-	classzone_idx = zone_idx(zones[0]);
-
 restart:
-	/*
-	 * Go through the zonelist once, looking for a zone with enough free.
-	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
-	 */
-	for (i = 0; (z = zones[i]) != NULL; i++) {
-		int do_reclaim = should_reclaim_zone(z, gfp_mask);
-
-		if (!cpuset_zone_allowed(z, __GFP_HARDWALL))
-			continue;
-
-		/*
-		 * If the zone is to attempt early page reclaim then this loop
-		 * will try to reclaim pages and check the watermark a second
-		 * time before giving up and falling back to the next zone.
-		 */
-zone_reclaim_retry:
-		if (!zone_watermark_ok(z, order, z->pages_low,
-				       classzone_idx, 0, 0)) {
-			if (!do_reclaim)
-				continue;
-			else {
-				zone_reclaim(z, gfp_mask, order);
-				/* Only try reclaim once */
-				do_reclaim = 0;
-				goto zone_reclaim_retry;
-			}
-		}
-
-		page = buffered_rmqueue(z, order, gfp_mask);
-		if (page)
-			goto got_pg;
-	}
+	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order, zones, 0);
+	if (page)
+		goto got_pg;
 
 	for (i = 0; (z = zones[i]) != NULL; i++)
 		wakeup_kswapd(z, order);
@@ -851,19 +853,11 @@
 	 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
-	for (i = 0; (z = zones[i]) != NULL; i++) {
-		if (!zone_watermark_ok(z, order, z->pages_min,
-				       classzone_idx, can_try_harder,
-				       gfp_mask & __GFP_HIGH))
-			continue;
-
-		if (wait && !cpuset_zone_allowed(z, gfp_mask))
-			continue;
-
-		page = buffered_rmqueue(z, order, gfp_mask);
-		if (page)
-			goto got_pg;
-	}
+	if (!wait)
+		page = get_page_from_freelist(gfp_mask, order, zones, 
+						can_try_harder);
+	if (page)
+		goto got_pg;
 
 	/* This allocation should allow future memory freeing. */
 
@@ -871,13 +865,9 @@
 			&& !in_interrupt()) {
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
 			/* go through the zonelist yet again, ignoring mins */
-			for (i = 0; (z = zones[i]) != NULL; i++) {
-				if (!cpuset_zone_allowed(z, gfp_mask))
-					continue;
-				page = buffered_rmqueue(z, order, gfp_mask);
-				if (page)
-					goto got_pg;
-			}
+			page = get_page_from_freelist(gfp_mask, order, zones, -1);
+			if (page)
+				goto got_pg;
 		}
 		goto nopage;
 	}
@@ -894,47 +884,20 @@
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	did_some_progress = try_to_free_pages(zones, gfp_mask);
+	i = try_to_free_pages(zones, gfp_mask);
 
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
 
 	cond_resched();
 
-	if (likely(did_some_progress)) {
-		for (i = 0; (z = zones[i]) != NULL; i++) {
-			if (!zone_watermark_ok(z, order, z->pages_min,
-					       classzone_idx, can_try_harder,
-					       gfp_mask & __GFP_HIGH))
-				continue;
-
-			if (!cpuset_zone_allowed(z, gfp_mask))
-				continue;
-
-			page = buffered_rmqueue(z, order, gfp_mask);
-			if (page)
-				goto got_pg;
-		}
-	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
+	page = get_page_from_freelist(gfp_mask, order, zones, can_try_harder);
+	if (page)
+		goto got_pg;
+	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
 		/*
-		 * Go through the zonelist yet one more time, keep
-		 * very high watermark here, this is only to catch
-		 * a parallel oom killing, we must fail if we're still
-		 * under heavy pressure.
+		 * Start the OOM here.
 		 */
-		for (i = 0; (z = zones[i]) != NULL; i++) {
-			if (!zone_watermark_ok(z, order, z->pages_high,
-					       classzone_idx, 0, 0))
-				continue;
-
-			if (!cpuset_zone_allowed(z, __GFP_HARDWALL))
-				continue;
-
-			page = buffered_rmqueue(z, order, gfp_mask);
-			if (page)
-				goto got_pg;
-		}
-
 		out_of_memory(gfp_mask, order);
 		goto restart;
 	}
@@ -968,7 +931,7 @@
 	}
 	return NULL;
 got_pg:
-	zone_statistics(zonelist, z);
+	zone_statistics(zonelist, page_zone(page));
 	return page;
 }
 
