Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVJATAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVJATAi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 15:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVJATAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 15:00:38 -0400
Received: from fmr22.intel.com ([143.183.121.14]:16335 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750827AbVJATAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 15:00:38 -0400
Date: Sat, 1 Oct 2005 12:00:23 -0700
From: "Seth, Rohit" <rohit.seth@intel.com>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: Clean up of __alloc_pages
Message-ID: <20051001120023.A10250@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	[PATCH]: Below is the cleaning up of __alloc_pages code.  Few 
		 things different from original version are

	1: remove the initial direct reclaim logic 
	2: order zero pages are now first looked into pcp list upfront
	3: GFP_HIGH pages are allowed to go little below low watermark sooner
	4: Search for free pages unconditionally after direct reclaim

	Signed-off-by: Rohit Seth <rohit.seth@intel.com>


--- linux-2.6.14-rc2-mm1.org/mm/page_alloc.c	2005-09-27 10:03:51.000000000 -0700
+++ linux-2.6.14-rc2-mm1/mm/page_alloc.c	2005-10-01 10:40:06.000000000 -0700
@@ -722,7 +722,8 @@
  * or two.
  */
 static struct page *
-buffered_rmqueue(struct zone *zone, int order, unsigned int __nocast gfp_flags)
+buffered_rmqueue(struct zone *zone, int order, unsigned int __nocast gfp_flags,
+			int replenish)
 {
 	unsigned long flags;
 	struct page *page = NULL;
@@ -733,7 +734,7 @@
 
 		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 		local_irq_save(flags);
-		if (pcp->count <= pcp->low)
+		if ((pcp->count <= pcp->low) && replenish)
 			pcp->count += rmqueue_bulk(zone, 0,
 						pcp->batch, &pcp->list);
 		if (pcp->count) {
@@ -743,9 +744,7 @@
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
@@ -858,6 +857,44 @@
 }
 #endif /* CONFIG_PAGE_OWNER */
 
+/* This function get_page_from_freeliest loops through all the possible zones
+ * to find out if it can allocate a page.  can_try_harder can have following 
+ * values:
+ * -1 => No need to check for the watermarks.
+ *  0 => Don't go too low down in deeps below the low watermark (GFP_HIGH)
+ *  1 => Go far below the low watermark.  See zone_watermark_ok (RT TASK)
+ */
+
+static inline struct page *
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
@@ -866,15 +903,13 @@
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
 
@@ -892,45 +927,23 @@
 		return NULL;
 	}
 
-	classzone_idx = zone_idx(zones[0]);
-
-restart:
-	/*
-	 * Go through the zonelist once, looking for a zone with enough free.
-	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
+	/* First check if we can easily take a page from any pcp list
+	 * for 0 order pages.  Don't replenish any pcp list at this time.
 	 */
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
+	if (order == 0) {
+		for (i = 0; (z = zones[i]) != NULL; i++) {
+			page = buffered_rmqueue(z, 0, gfp_mask, 0);
+			if (page) 
+				goto got_pg;
 		}
-
-		page = buffered_rmqueue(z, order, gfp_mask);
-		if (page)
-			goto got_pg;
 	}
+restart:
+	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order, zones, 0);
+	if (page)
+		goto got_pg;
 
 	for (i = 0; (z = zones[i]) != NULL; i++)
 		wakeup_kswapd(z, order);
-
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
 	 * coming from realtime tasks to go deeper into reserves
@@ -939,19 +952,12 @@
 	 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
-	for (i = 0; (z = zones[i]) != NULL; i++) {
-		if (!zone_watermark_ok(z, order, z->pages_min,
-				       classzone_idx, can_try_harder,
-				       gfp_mask & __GFP_HIGH))
-			continue;
 
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
 
@@ -959,13 +965,9 @@
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
@@ -982,47 +984,21 @@
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
+	page = get_page_from_freelist(gfp_mask, order, zones,
+					can_try_harder);
+	if (page)
+		goto got_pg;
+	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
 		/*
-		 * Go through the zonelist yet one more time, keep
-		 * very high watermark here, this is only to catch
-		 * a parallel oom killing, we must fail if we're still
-		 * under heavy pressure.
+		 * Start the OOM for this scenario.
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
@@ -1060,7 +1036,7 @@
 #ifdef CONFIG_PAGE_OWNER
 	set_page_owner(page, order, gfp_mask);
 #endif
-	zone_statistics(zonelist, z);
+	zone_statistics(zonelist, page_zone(page));
 	return page;
 }
 
