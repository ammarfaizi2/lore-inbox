Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425392AbWLHLWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425392AbWLHLWQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425403AbWLHLWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:22:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59597 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1425392AbWLHLWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:22:15 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, menage@google.com, Paul Jackson <pj@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Date: Fri, 08 Dec 2006 03:21:52 -0800
Message-Id: <20061208112152.12631.67436.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset - rework cpuset_zone_allowed api
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Elaborate the API for calling cpuset_zone_allowed(), so that users
have to explicitly choose between the two variants:

  cpuset_zone_allowed_hardwall()
  cpuset_zone_allowed_softwall()

Until now, whether or not you got the hardwall flavor depended solely
on whether or not you or'd in the __GFP_HARDWALL gfp flag to the
gfp_mask argument.

If you didn't specify __GFP_HARDWALL, you implicitly got the softwall
version.

Unfortunately, this meant that users would end up with the softwall
version without thinking about it.  Since only the softwall version
might sleep, this led to bugs with possible sleeping in interrupt
context on more than one occassion.

The hardwall version requires that the current tasks mems_allowed
allows the node of the specified zone (or that you're in interrupt
or that __GFP_THISNODE is set or that you're on a one cpuset system.)

The softwall version, depending on the gfp_mask, might allow a node
if it was allowed in the nearest enclusing cpuset marked mem_exclusive
(which requires taking the cpuset lock 'callback_mutex' to evaluate.)

This patch removes the cpuset_zone_allowed() call, and forces the
caller to explicitly choose between the hardwall and the softwall case.

If the caller wants the gfp_mask to determine this choice, they
should (1) be sure they can sleep or that __GFP_HARDWALL is set,
and (2) invoke the cpuset_zone_allowed_softwall() routine.

This adds another 100 or 200 bytes to the kernel text space,
due to the few lines of nearly duplicate code at the top of
both cpuset_zone_allowed_* routines.  It should save a few
instructions executed for the calls that turned into calls
of cpuset_zone_allowed_hardwall, thanks to not having to
set (before the call) then check (within the call) the
__GFP_HARDWALL flag.

For the most critical call, from get_page_from_freelist(),
the same instructions are executed as before -- the
old cpuset_zone_allowed() routine it used to call is
the same code as the cpuset_zone_allowed_softwall()
routine that it calls now.

Not a perfect win, but seems worth it, to reduce this
chance of hitting a sleeping with irq off complaint again.

Signed-off-by: Paul Jackson <pj@sgi.com>

---
 include/linux/cpuset.h |   22 ++++++++++---
 kernel/cpuset.c        |   82 +++++++++++++++++++++++++++++++++++++++----------
 mm/hugetlb.c           |    2 -
 mm/oom_kill.c          |    2 -
 mm/page_alloc.c        |    2 -
 mm/slab.c              |    3 -
 mm/vmscan.c            |    8 ++--
 7 files changed, 92 insertions(+), 29 deletions(-)

--- 2.6.19-rc6-mm2.orig/include/linux/cpuset.h	2006-12-08 03:04:58.320035672 -0800
+++ 2.6.19-rc6-mm2/include/linux/cpuset.h	2006-12-08 03:06:39.377345895 -0800
@@ -30,10 +30,19 @@ void cpuset_update_task_memory_state(voi
 		nodes_subset((nodes), current->mems_allowed)
 int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl);
 
-extern int __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask);
-static int inline cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
+extern int __cpuset_zone_allowed_softwall(struct zone *z, gfp_t gfp_mask);
+extern int __cpuset_zone_allowed_hardwall(struct zone *z, gfp_t gfp_mask);
+
+static int inline cpuset_zone_allowed_softwall(struct zone *z, gfp_t gfp_mask)
+{
+	return number_of_cpusets <= 1 ||
+		__cpuset_zone_allowed_softwall(z, gfp_mask);
+}
+
+static int inline cpuset_zone_allowed_hardwall(struct zone *z, gfp_t gfp_mask)
 {
-	return number_of_cpusets <= 1 || __cpuset_zone_allowed(z, gfp_mask);
+	return number_of_cpusets <= 1 ||
+		__cpuset_zone_allowed_hardwall(z, gfp_mask);
 }
 
 extern int cpuset_excl_nodes_overlap(const struct task_struct *p);
@@ -94,7 +103,12 @@ static inline int cpuset_zonelist_valid_
 	return 1;
 }
 
-static inline int cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
+static inline int cpuset_zone_allowed_softwall(struct zone *z, gfp_t gfp_mask)
+{
+	return 1;
+}
+
+static inline int cpuset_zone_allowed_hardwall(struct zone *z, gfp_t gfp_mask)
 {
 	return 1;
 }
--- 2.6.19-rc6-mm2.orig/kernel/cpuset.c	2006-12-08 03:04:58.320035672 -0800
+++ 2.6.19-rc6-mm2/kernel/cpuset.c	2006-12-08 03:06:39.381345947 -0800
@@ -2262,32 +2262,48 @@ static const struct cpuset *nearest_excl
 }
 
 /**
- * cpuset_zone_allowed - Can we allocate memory on zone z's memory node?
+ * cpuset_zone_allowed_softwall - Can we allocate on zone z's memory node?
  * @z: is this zone on an allowed node?
- * @gfp_mask: memory allocation flags (we use __GFP_HARDWALL)
+ * @gfp_mask: memory allocation flags
  *
- * If we're in interrupt, yes, we can always allocate.  If zone
+ * If we're in interrupt, yes, we can always allocate.  If
+ * __GFP_THISNODE is set, yes, we can always allocate.  If zone
  * z's node is in our tasks mems_allowed, yes.  If it's not a
  * __GFP_HARDWALL request and this zone's nodes is in the nearest
  * mem_exclusive cpuset ancestor to this tasks cpuset, yes.
  * Otherwise, no.
  *
+ * If __GFP_HARDWALL is set, cpuset_zone_allowed_softwall()
+ * reduces to cpuset_zone_allowed_hardwall().  Otherwise,
+ * cpuset_zone_allowed_softwall() might sleep, and might allow a zone
+ * from an enclosing cpuset.
+ *
+ * cpuset_zone_allowed_hardwall() only handles the simpler case of
+ * hardwall cpusets, and never sleeps.
+ *
+ * The __GFP_THISNODE placement logic is really handled elsewhere,
+ * by forcibly using a zonelist starting at a specified node, and by
+ * (in get_page_from_freelist()) refusing to consider the zones for
+ * any node on the zonelist except the first.  By the time any such
+ * calls get to this routine, we should just shut up and say 'yes'.
+ *
  * GFP_USER allocations are marked with the __GFP_HARDWALL bit,
  * and do not allow allocations outside the current tasks cpuset.
  * GFP_KERNEL allocations are not so marked, so can escape to the
- * nearest mem_exclusive ancestor cpuset.
+ * nearest enclosing mem_exclusive ancestor cpuset.
  *
- * Scanning up parent cpusets requires callback_mutex.  The __alloc_pages()
- * routine only calls here with __GFP_HARDWALL bit _not_ set if
- * it's a GFP_KERNEL allocation, and all nodes in the current tasks
- * mems_allowed came up empty on the first pass over the zonelist.
- * So only GFP_KERNEL allocations, if all nodes in the cpuset are
- * short of memory, might require taking the callback_mutex mutex.
+ * Scanning up parent cpusets requires callback_mutex.  The
+ * __alloc_pages() routine only calls here with __GFP_HARDWALL bit
+ * _not_ set if it's a GFP_KERNEL allocation, and all nodes in the
+ * current tasks mems_allowed came up empty on the first pass over
+ * the zonelist.  So only GFP_KERNEL allocations, if all nodes in the
+ * cpuset are short of memory, might require taking the callback_mutex
+ * mutex.
  *
  * The first call here from mm/page_alloc:get_page_from_freelist()
- * has __GFP_HARDWALL set in gfp_mask, enforcing hardwall cpusets, so
- * no allocation on a node outside the cpuset is allowed (unless in
- * interrupt, of course).
+ * has __GFP_HARDWALL set in gfp_mask, enforcing hardwall cpusets,
+ * so no allocation on a node outside the cpuset is allowed (unless
+ * in interrupt, of course).
  *
  * The second pass through get_page_from_freelist() doesn't even call
  * here for GFP_ATOMIC calls.  For those calls, the __alloc_pages()
@@ -2300,12 +2316,12 @@ static const struct cpuset *nearest_excl
  *	GFP_USER     - only nodes in current tasks mems allowed ok.
  *
  * Rule:
- *    Don't call cpuset_zone_allowed() if you can't sleep, unless you
+ *    Don't call cpuset_zone_allowed_softwall if you can't sleep, unless you
  *    pass in the __GFP_HARDWALL flag set in gfp_flag, which disables
  *    the code that might scan up ancestor cpusets and sleep.
- **/
+ */
 
-int __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
+int __cpuset_zone_allowed_softwall(struct zone *z, gfp_t gfp_mask)
 {
 	int node;			/* node that zone z is on */
 	const struct cpuset *cs;	/* current cpuset ancestors */
@@ -2335,6 +2351,40 @@ int __cpuset_zone_allowed(struct zone *z
 	return allowed;
 }
 
+/*
+ * cpuset_zone_allowed_hardwall - Can we allocate on zone z's memory node?
+ * @z: is this zone on an allowed node?
+ * @gfp_mask: memory allocation flags
+ *
+ * If we're in interrupt, yes, we can always allocate.
+ * If __GFP_THISNODE is set, yes, we can always allocate.  If zone
+ * z's node is in our tasks mems_allowed, yes.   Otherwise, no.
+ *
+ * The __GFP_THISNODE placement logic is really handled elsewhere,
+ * by forcibly using a zonelist starting at a specified node, and by
+ * (in get_page_from_freelist()) refusing to consider the zones for
+ * any node on the zonelist except the first.  By the time any such
+ * calls get to this routine, we should just shut up and say 'yes'.
+ *
+ * Unlike the cpuset_zone_allowed_softwall() variant, above,
+ * this variant requires that the zone be in the current tasks
+ * mems_allowed or that we're in interrupt.  It does not scan up the
+ * cpuset hierarchy for the nearest enclosing mem_exclusive cpuset.
+ * It never sleeps.
+ */
+
+int __cpuset_zone_allowed_hardwall(struct zone *z, gfp_t gfp_mask)
+{
+	int node;			/* node that zone z is on */
+
+	if (in_interrupt() || (gfp_mask & __GFP_THISNODE))
+		return 1;
+	node = zone_to_nid(z);
+	if (node_isset(node, current->mems_allowed))
+		return 1;
+	return 0;
+}
+
 /**
  * cpuset_lock - lock out any changes to cpuset structures
  *
--- 2.6.19-rc6-mm2.orig/mm/hugetlb.c	2006-12-08 03:04:58.320035672 -0800
+++ 2.6.19-rc6-mm2/mm/hugetlb.c	2006-12-08 03:06:39.381345947 -0800
@@ -73,7 +73,7 @@ static struct page *dequeue_huge_page(st
 
 	for (z = zonelist->zones; *z; z++) {
 		nid = zone_to_nid(*z);
-		if (cpuset_zone_allowed(*z, GFP_HIGHUSER) &&
+		if (cpuset_zone_allowed_softwall(*z, GFP_HIGHUSER) &&
 		    !list_empty(&hugepage_freelists[nid]))
 			break;
 	}
--- 2.6.19-rc6-mm2.orig/mm/oom_kill.c	2006-12-08 03:04:58.324035724 -0800
+++ 2.6.19-rc6-mm2/mm/oom_kill.c	2006-12-08 03:06:39.385345999 -0800
@@ -177,7 +177,7 @@ static inline int constrained_alloc(stru
 	nodemask_t nodes = node_online_map;
 
 	for (z = zonelist->zones; *z; z++)
-		if (cpuset_zone_allowed(*z, gfp_mask))
+		if (cpuset_zone_allowed_softwall(*z, gfp_mask))
 			node_clear(zone_to_nid(*z), nodes);
 		else
 			return CONSTRAINT_CPUSET;
--- 2.6.19-rc6-mm2.orig/mm/page_alloc.c	2006-12-08 03:04:58.324035724 -0800
+++ 2.6.19-rc6-mm2/mm/page_alloc.c	2006-12-08 03:06:39.385345999 -0800
@@ -1179,7 +1179,7 @@ zonelist_scan:
 			zone->zone_pgdat != zonelist->zones[0]->zone_pgdat))
 				break;
 		if ((alloc_flags & ALLOC_CPUSET) &&
-			!cpuset_zone_allowed(zone, gfp_mask))
+			!cpuset_zone_allowed_softwall(zone, gfp_mask))
 				goto try_next_zone;
 
 		if (!(alloc_flags & ALLOC_NO_WATERMARKS)) {
--- 2.6.19-rc6-mm2.orig/mm/slab.c	2006-12-08 03:04:58.324035724 -0800
+++ 2.6.19-rc6-mm2/mm/slab.c	2006-12-08 03:06:39.389346051 -0800
@@ -3261,8 +3261,7 @@ void *fallback_alloc(struct kmem_cache *
 		int nid = zone_to_nid(*z);
 
 		if (zone_idx(*z) <= ZONE_NORMAL &&
-				cpuset_zone_allowed(*z,
-					flags | __GFP_HARDWALL) &&
+				cpuset_zone_allowed_hardwall(*z, flags) &&
 				cache->nodelists[nid])
 			obj = ____cache_alloc_node(cache,
 					flags | __GFP_THISNODE, nid);
--- 2.6.19-rc6-mm2.orig/mm/vmscan.c	2006-12-08 03:04:58.324035724 -0800
+++ 2.6.19-rc6-mm2/mm/vmscan.c	2006-12-08 03:06:39.389346051 -0800
@@ -986,7 +986,7 @@ static unsigned long shrink_zones(int pr
 		if (!populated_zone(zone))
 			continue;
 
-		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
+		if (!cpuset_zone_allowed_hardwall(zone, GFP_KERNEL))
 			continue;
 
 		note_zone_scanning_priority(zone, priority);
@@ -1051,7 +1051,7 @@ unsigned long try_to_free_pages(struct z
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
 
-		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
+		if (!cpuset_zone_allowed_hardwall(zone, GFP_KERNEL))
 			continue;
 
 		lru_pages += zone->nr_active + zone->nr_inactive;
@@ -1106,7 +1106,7 @@ out:
 	for (i = 0; zones[i] != 0; i++) {
 		struct zone *zone = zones[i];
 
-		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
+		if (!cpuset_zone_allowed_hardwall(zone, GFP_KERNEL))
 			continue;
 
 		zone->prev_priority = priority;
@@ -1372,7 +1372,7 @@ void wakeup_kswapd(struct zone *zone, in
 		return;
 	if (pgdat->kswapd_max_order < order)
 		pgdat->kswapd_max_order = order;
-	if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
+	if (!cpuset_zone_allowed_hardwall(zone, GFP_KERNEL))
 		return;
 	if (!waitqueue_active(&pgdat->kswapd_wait))
 		return;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
