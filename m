Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbVKHBoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbVKHBoE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbVKHBoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:44:04 -0500
Received: from fmr24.intel.com ([143.183.121.16]:34978 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S965132AbVKHBoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:44:03 -0500
Date: Mon, 7 Nov 2005 17:43:49 -0800
From: "Rohit, Seth" <rohit.seth@intel.com>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: Cleanup of __alloc_pages
Message-ID: <20051107174349.A8018@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH]: Clean up of __alloc_pages. Couple of difference from original behavior:
	1- remove the initial reclaim logic
	2- GFP_HIGH pages are allowed to go little below watermark sooner.
	3- Search for free pages unconditionally after direct reclaim.

	Signed-off-by: Rohit Seth <rohit.seth@intel.com>


--- linux-2.6.14.org/mm/page_alloc.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14/mm/page_alloc.c	2005-11-07 09:37:45.000000000 -0800
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
@@ -770,6 +768,45 @@
 	return 1;
 }
 
+/* get_page_from_freeliest loops through all the possible zones
+ * to find out if it can allocate a page.  can_try_harder can have following
+ * values:
+ * -1 => No need to check for the watermarks.
+ *  0 => Don't go too low down in deeps below the low watermark (GFP_HIGH)
+ *  1 => Go far below the low watermark.  See zone_watermark_ok (RT TASK)
+ *
+ * cpuset check is not performed when the skip_cpuset_chk flag is set.
+ */
+
+static struct page *
+get_page_from_freelist(gfp_t gfp_mask, unsigned int order, struct zone **zones, 
+			int can_try_harder, int skip_cpuset_chk)
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
+		if (!skip_cpuset_chk && (!cpuset_zone_allowed(z, gfp_mask)))
+			continue;
+		if ((can_try_harder >= 0) &&
+			(!zone_watermark_ok(z, order, z->pages_low,
+				       classzone_idx, can_try_harder,
+				       gfp_mask & __GFP_HIGH)))
+			continue;
+
+		page = buffered_rmqueue(z, order, gfp_mask);
+		if (page)
+			break;
+	}
+	return page;
+}
+
 /*
  * This is the 'heart' of the zoned buddy allocator.
  */
@@ -778,15 +815,13 @@
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
 
@@ -803,42 +838,10 @@
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
+	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order, zones, 0, 0);
+	if (page)
+		goto got_pg;
 
 	for (i = 0; (z = zones[i]) != NULL; i++)
 		wakeup_kswapd(z, order);
@@ -851,19 +854,11 @@
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
+						can_try_harder, 1);
+	if (page)
+		goto got_pg;
 
 	/* This allocation should allow future memory freeing. */
 
@@ -871,13 +866,9 @@
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
+			page = get_page_from_freelist(gfp_mask, order, zones, -1, 1);
+			if (page)
+				goto got_pg;
 		}
 		goto nopage;
 	}
@@ -894,47 +885,20 @@
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	did_some_progress = try_to_free_pages(zones, gfp_mask);
+	try_to_free_pages(zones, gfp_mask);
 
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
+	page = get_page_from_freelist(gfp_mask, order, zones, can_try_harder, 0);
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
@@ -968,7 +932,7 @@
 	}
 	return NULL;
 got_pg:
-	zone_statistics(zonelist, z);
+	zone_statistics(zonelist, page_zone(page));
 	return page;
 }
 
