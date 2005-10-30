Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932778AbVJ3Brn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbVJ3Brn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 21:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932780AbVJ3Brn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 21:47:43 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:3533 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932778AbVJ3Brm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 21:47:42 -0400
Date: Sat, 29 Oct 2005 18:47:28 -0700
From: Paul Jackson <pj@sgi.com>
To: "Rohit, Seth" <rohit.seth@intel.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-Id: <20051029184728.100e3058.pj@sgi.com>
In-Reply-To: <20051028183326.A28611@unix-os.sc.intel.com>
References: <20051028183326.A28611@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple more items:
 1) Lets try for a consistent use of type "gfp_t" for gfp_mask.
 2) The can_try_harder flag values were driving me nuts.
 3) The "inline" you added to buffered_rmqueue() blew up my compile.
 4) The return from try_to_free_pages() was put in "i" for no evident reason.
 5) I have no clue what the replenish flag you added to buffered_rmqueue does.

You patch has:
> can_try_harder can have following 
>  * values:
>  * -1 => No need to check for the watermarks.
>  *  0 => Don't go too low down in deeps below the low watermark (GFP_HIGH)
>  *  1 => Go far below the low watermark.  See zone_watermark_ok (RT TASK)

Later on, you have an inequality test on this value:
	if ((can_try_harder >= 0)
and a non-zero test:
	if (can_try_harder)

That's three magic values, not even in increasing order of "how hard
one should try", tested a couple of different ways that requires
absorbing the complete details of the three values and their ordering
before one can read the code.

I'd like to use a enum type, to put names to these 3 values, and I'd
like to put them in order of increasing desperation.

The following patch tweaks the gfp_mask type, makes can_try_harder
an enum, removes the inline from buffered_rmqueue(), doesn't stash
the return value of try_to_free_pages(), and removes buffered_rmqueue's
replenish flag.  It applies on top of your patch.  If you like it, I'd
be happiest if you picked it up and incorporated it into your work.

I compiled it once, never tested or booted.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/mmzone.h |    9 ++++++++-
 mm/page_alloc.c        |   39 +++++++++++++++++++--------------------
 mm/vmscan.c            |    9 ++++++---
 3 files changed, 33 insertions(+), 24 deletions(-)

--- 2.6.14-rc5-mm1-cpuset-patches.orig/include/linux/mmzone.h	2005-10-25 09:37:45.154588634 -0700
+++ 2.6.14-rc5-mm1-cpuset-patches/include/linux/mmzone.h	2005-10-29 17:58:28.433716118 -0700
@@ -330,8 +330,15 @@ void get_zone_counts(unsigned long *acti
 			unsigned long *free);
 void build_all_zonelists(void);
 void wakeup_kswapd(struct zone *zone, int order);
+
+typedef enum {
+  dont_try_harder,	/* Don't go much below low watermark (GFP_HIGH) */
+  try_harder,		/* Go far below low watermark (RT TASK) */
+  try_really_hard	/* Ignore all watermarks */
+} can_try_harder_t;
+
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
-		int alloc_type, int can_try_harder, int gfp_high);
+	int alloc_type, can_try_harder_t can_try_harder, int gfp_high);
 
 #ifdef CONFIG_HAVE_MEMORY_PRESENT
 void memory_present(int nid, unsigned long start, unsigned long end);
--- 2.6.14-rc5-mm1-cpuset-patches.orig/mm/page_alloc.c	2005-10-29 14:44:55.371576062 -0700
+++ 2.6.14-rc5-mm1-cpuset-patches/mm/page_alloc.c	2005-10-29 18:40:41.358953388 -0700
@@ -713,8 +713,8 @@ static inline void prep_zero_page(struct
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
  * or two.
  */
-struct inline page *
-buffered_rmqueue(struct zone *zone, int order, gfp_t gfp_flags, int replenish)
+struct page *
+buffered_rmqueue(struct zone *zone, int order, gfp_t gfp_flags)
 {
 	unsigned long flags;
 	struct page *page = NULL;
@@ -725,7 +725,7 @@ buffered_rmqueue(struct zone *zone, int 
 
 		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 		local_irq_save(flags);
-		if ((pcp->count <= pcp->low) && replenish)
+		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
 						pcp->batch, &pcp->list);
 		if (pcp->count) {
@@ -756,16 +756,12 @@ buffered_rmqueue(struct zone *zone, int 
 }
 
 /* get_page_from_freeliest loops through all the possible zones
- * to find out if it can allocate a page.  can_try_harder can have following 
- * values:
- * -1 => No need to check for the watermarks.
- *  0 => Don't go too low down in deeps below the low watermark (GFP_HIGH)
- *  1 => Go far below the low watermark.  See zone_watermark_ok (RT TASK)
+ * to find out if it can allocate a page.
  */
 
 static struct page *
-get_page_from_freelist(unsigned int __nocast gfp_mask, unsigned int order, 
-			struct zone **zones, int can_try_harder)
+get_page_from_freelist(gfp_t gfp_mask, unsigned int order,
+			struct zone **zones, can_try_harder_t can_try_harder)
 {
 	struct zone *z;
 	struct page *page = NULL;
@@ -780,13 +776,13 @@ get_page_from_freelist(unsigned int __no
 		if (!cpuset_zone_allowed(z, gfp_mask))
 			continue;
 
-		if ((can_try_harder >= 0) && 
+		if ((can_try_harder < try_really_hard) &&
 			(!zone_watermark_ok(z, order, z->pages_low,
 				       classzone_idx, can_try_harder, 
 				       gfp_mask & __GFP_HIGH)))
 			continue;
 
-		page = buffered_rmqueue(z, order, gfp_mask, 1);
+		page = buffered_rmqueue(z, order, gfp_mask);
 		if (page) 
 			break;
 	}
@@ -798,7 +794,7 @@ get_page_from_freelist(unsigned int __no
  * of the allocation.
  */
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
-		      int classzone_idx, int can_try_harder, int gfp_high)
+	int classzone_idx, can_try_harder_t can_try_harder, int gfp_high)
 {
 	/* free_pages my go negative - that's OK */
 	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
@@ -806,7 +802,7 @@ int zone_watermark_ok(struct zone *z, in
 
 	if (gfp_high)
 		min -= min / 2;
-	if (can_try_harder)
+	if (can_try_harder >= try_harder)
 		min -= min / 4;
 
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
@@ -878,7 +874,7 @@ static inline void __stack_trace(struct 
 }
 
 static inline void set_page_owner(struct page *page,
-			unsigned int order, unsigned int gfp_mask)
+			unsigned int order, gfp_t gfp_mask)
 {
 	unsigned long address, bp;
 #ifdef CONFIG_X86_64
@@ -906,7 +902,7 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 	struct task_struct *p = current;
 	int i;
 	int do_retry;
-	int can_try_harder;
+	can_try_harder_t can_try_harder = dont_try_harder;
 
 	might_sleep_if(wait);
 
@@ -915,7 +911,8 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 	 * cannot run direct reclaim, or is the caller has realtime scheduling
 	 * policy
 	 */
-	can_try_harder = (unlikely(rt_task(p)) && !in_interrupt()) || !wait;
+	if ((unlikely(rt_task(p)) && !in_interrupt()) || !wait)
+		can_try_harder = try_harder;
 
 	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 
@@ -924,7 +921,8 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 		return NULL;
 	}
 restart:
-	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order, zones, 0);
+	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order, zones,
+					dont_try_harder);
 	if (page)
 		goto got_pg;
 
@@ -951,7 +949,8 @@ restart:
 			&& !in_interrupt()) {
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
 			/* go through the zonelist yet again, ignoring mins */
-			page = get_page_from_freelist(gfp_mask, order, zones, -1);
+			page = get_page_from_freelist(gfp_mask, order, zones,
+						try_really_hard);
 			if (page)
 				goto got_pg;
 		}
@@ -970,7 +969,7 @@ rebalance:
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	i = try_to_free_pages(zones, gfp_mask);
+	try_to_free_pages(zones, gfp_mask);
 
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
--- 2.6.14-rc5-mm1-cpuset-patches.orig/mm/vmscan.c	2005-10-25 09:38:47.225573361 -0700
+++ 2.6.14-rc5-mm1-cpuset-patches/mm/vmscan.c	2005-10-29 17:21:39.268886029 -0700
@@ -1082,7 +1082,8 @@ loop_again:
 					continue;
 
 				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, 0, 0, 0)) {
+						zone->pages_high, 0, 0,
+						dont_try_harder)) {
 					end_zone = i;
 					goto scan;
 				}
@@ -1119,7 +1120,8 @@ scan:
 
 			if (nr_pages == 0) {	/* Not software suspend */
 				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, end_zone, 0, 0))
+						zone->pages_high, end_zone,
+						0, dont_try_harder))
 					all_zones_ok = 0;
 			}
 			zone->temp_priority = priority;
@@ -1267,7 +1269,8 @@ void wakeup_kswapd(struct zone *zone, in
 		return;
 
 	pgdat = zone->zone_pgdat;
-	if (zone_watermark_ok(zone, order, zone->pages_low, 0, 0, 0))
+	if (zone_watermark_ok(zone, order, zone->pages_low, 0, 0,
+					dont_try_harder))
 		return;
 	if (pgdat->kswapd_max_order < order)
 		pgdat->kswapd_max_order = order;


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
