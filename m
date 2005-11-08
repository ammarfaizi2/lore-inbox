Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965391AbVKHDpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965391AbVKHDpR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965392AbVKHDpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:45:17 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:31915 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965391AbVKHDpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:45:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=Qa7DLNEzuVgp4gA/b9taikl3o2iqSfFW3We6QrAWpX3Jb5vWSyxMedF1Dr2eBo46fd1iStN907/G8jHM73B/RAUFOkY8e9laA2es723pzIzR04Cm7jhcYPeF1REwY4vJ7tm3yoeZw3n4KmshpePSGUjdek1gZBbv6XpbGEM/XTA=  ;
Message-ID: <43701FC6.5050104@yahoo.com.au>
Date: Tue, 08 Nov 2005 14:47:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rohit Seth <rohit.seth@intel.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Cleanup of __alloc_pages
References: <20051107174349.A8018@unix-os.sc.intel.com>	 <20051107175358.62c484a3.akpm@osdl.org> <1131416195.20471.31.camel@akash.sc.intel.com>
In-Reply-To: <1131416195.20471.31.camel@akash.sc.intel.com>
Content-Type: multipart/mixed;
 boundary="------------010307080208040805040802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307080208040805040802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rohit Seth wrote:
> On Mon, 2005-11-07 at 17:53 -0800, Andrew Morton wrote:
> 
>>"Rohit, Seth" <rohit.seth@intel.com> wrote:
>>
>>>[PATCH]: Clean up of __alloc_pages. Couple of difference from original behavior:
>>>	1- remove the initial reclaim logic
>>>	2- GFP_HIGH pages are allowed to go little below watermark sooner.
>>>	3- Search for free pages unconditionally after direct reclaim.
>>
>>Would it be possible to break these into three separate patches?  The
>>cleanup part should be #1.
>>
> 
> 
> Doing the above three things as part of this clean up patch makes the
> code look extra clean... Is there any specific issue coming out of 2 & 3
> above.
> 

#2 as I explained I don't like changing this. What this does is basically
make __GFP_HIGH allocations sometimes randomly enter direct reclaim rather
than have a nice buffer of asynch reclaim like we do now for that and all
other types of allocations.

It only reduces calls to kswapd by about as much as it will be increasing
calls to direct reclaim.

Anyway, as promised, I've attached (sorry) a patch to correct the
problems I see in it and revert previous behaviour for #2 and #3.

I'm not immediately sure of any problems with changing #3, however OOM
behaviour is pretty fragile and I wouldn't like to change it as part
of this patch.

> 
>>>+		if (!skip_cpuset_chk && (!cpuset_zone_allowed(z, gfp_mask)))
>>
>>It'd be nice to not have the `skip_cpuset_chk' flag there.  a) it gives
>>Linus conniptions and b) it's a little extra overhead for !CONFIG_CPUSETS
>>kernels.
>>
> 

The compiler will constant fold this out if it is halfway smart.

> 
> I think it will be easier to do this change as a follow on patch as that
> will change the header file, function definition and such.  Can we defer
> this to separate follow on patch.
> 
> 
>>>-	zone_statistics(zonelist, z);
>>>+	zone_statistics(zonelist, page_zone(page));
>>
>>Evaluating page_zone() is not completely trivial.  Can we avoid the above?
> 

Done.

Let me know what you think (compile tested only, at this stage).

-- 
SUSE Labs, Novell Inc.


--------------010307080208040805040802
Content-Type: text/plain;
 name="__alloc_pages-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="__alloc_pages-cleanup.patch"

From: Rohit Seth <rohit.seth@intel.com>

Clean up of __alloc_pages.

Signed-off-by: Rohit Seth <rohit.seth@intel.com>

Restoration of previous behaviour, plus further cleanups
by introducing an 'alloc_flags', removing the last of
should_reclaim_zone.

Signed-off-by: Nick Piggin <npiggin@suse.de>


Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2005-11-08 14:39:56.000000000 +1100
+++ linux-2.6/mm/page_alloc.c	2005-11-08 14:42:11.000000000 +1100
@@ -707,9 +707,7 @@ buffered_rmqueue(struct zone *zone, int 
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
@@ -729,20 +727,25 @@ buffered_rmqueue(struct zone *zone, int 
 	return page;
 }
 
+#define ALLOC_WATERMARKS	0x01 /* check watermarks */
+#define ALLOC_HARDER		0x02 /* try to alloc harder */
+#define ALLOC_HIGH		0x04 /* __GFP_HIGH set */
+#define ALLOC_CPUSET		0x08 /* check for correct cpuset */
+
 /*
  * Return 1 if free pages are above 'mark'. This takes into account the order
  * of the allocation.
  */
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
-		      int classzone_idx, int can_try_harder, int gfp_high)
+		      int classzone_idx, int alloc_flags)
 {
 	/* free_pages my go negative - that's OK */
 	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
 	int o;
 
-	if (gfp_high)
+	if (alloc_flags & ALLOC_HIGH)
 		min -= min / 2;
-	if (can_try_harder)
+	if (alloc_flags & ALLOC_HARDER)
 		min -= min / 4;
 
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
@@ -760,14 +763,41 @@ int zone_watermark_ok(struct zone *z, in
 	return 1;
 }
 
-static inline int
-should_reclaim_zone(struct zone *z, gfp_t gfp_mask)
-{
-	if (!z->reclaim_pages)
-		return 0;
-	if (gfp_mask & __GFP_NORECLAIM)
-		return 0;
-	return 1;
+/*
+ * get_page_from_freeliest goes through the zonelist trying to allocate
+ * a page.
+ */
+static struct page *
+get_page_from_freelist(gfp_t gfp_mask, unsigned int order,
+		struct zonelist *zonelist, int alloc_flags)
+{
+	struct zone **z = zonelist->zones;
+	struct page *page = NULL;
+	int classzone_idx = zone_idx(*z);
+
+	/*
+	 * Go through the zonelist once, looking for a zone with enough free.
+	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
+	 */
+	do {
+		if ((alloc_flags & ALLOC_CPUSET) &&
+				!cpuset_zone_allowed(*z, gfp_mask))
+			continue;
+
+		if (alloc_flags & ALLOC_WATERMARKS) {
+			if (!zone_watermark_ok(*z, order, (*z)->pages_low,
+				    classzone_idx, alloc_flags))
+				continue;
+		}
+
+		page = buffered_rmqueue(*z, order, gfp_mask);
+		if (page) {
+			zone_statistics(zonelist, *z);
+			break;
+		}
+		z++;
+	} while (*z != NULL);
+	return page;
 }
 
 /*
@@ -778,70 +808,49 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 		struct zonelist *zonelist)
 {
 	const int wait = gfp_mask & __GFP_WAIT;
-	struct zone **zones, *z;
+	struct zone **z;
 	struct page *page;
 	struct reclaim_state reclaim_state;
 	struct task_struct *p = current;
-	int i;
-	int classzone_idx;
 	int do_retry;
-	int can_try_harder;
+	int alloc_flags;
 	int did_some_progress;
 
 	might_sleep_if(wait);
 
-	/*
-	 * The caller may dip into page reserves a bit more if the caller
-	 * cannot run direct reclaim, or is the caller has realtime scheduling
-	 * policy
-	 */
-	can_try_harder = (unlikely(rt_task(p)) && !in_interrupt()) || !wait;
-
-	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
+	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 
-	if (unlikely(zones[0] == NULL)) {
+	if (unlikely(*z == NULL)) {
 		/* Should this ever happen?? */
 		return NULL;
 	}
+restart:
+	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
+				zonelist, ALLOC_WATERMARKS|ALLOC_CPUSET);
+	if (page)
+		goto got_pg;
 
-	classzone_idx = zone_idx(zones[0]);
+	do {
+		wakeup_kswapd(*z, order);
+		z++;
+	} while (*z != NULL);
 
-restart:
 	/*
-	 * Go through the zonelist once, looking for a zone with enough free.
-	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
+	 * OK, we're below the kswapd watermark and have kicked background
+	 * reclaim. Now things get more complex, so st up alloc_flags according
+	 * to how we want to proceed.
+	 *
+	 * The caller may dip into page reserves a bit more if the caller
+	 * cannot run direct reclaim, or is the caller has realtime scheduling
+	 * policy.
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
-		}
-
-		page = buffered_rmqueue(z, order, gfp_mask);
-		if (page)
-			goto got_pg;
-	}
-
-	for (i = 0; (z = zones[i]) != NULL; i++)
-		wakeup_kswapd(z, order);
+	alloc_flags = 0;
+	if ((unlikely(rt_task(p)) && !in_interrupt()) || !wait)
+		alloc_flags |= ALLOC_HARDER;
+	if (gfp_mask & __GFP_HIGH)
+		alloc_flags |= ALLOC_HIGH;
+	if (wait)
+		alloc_flags |= ALLOC_CPUSET;
 
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
@@ -851,19 +860,9 @@ zone_reclaim_retry:
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
+	page = get_page_from_freelist(gfp_mask, order, zonelist, alloc_flags);
+	if (page)
+		goto got_pg;
 
 	/* This allocation should allow future memory freeing. */
 
@@ -871,13 +870,10 @@ zone_reclaim_retry:
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
+			page = get_page_from_freelist(gfp_mask, order,
+						zonelist, ALLOC_CPUSET);
+			if (page)
+				goto got_pg;
 		}
 		goto nopage;
 	}
@@ -894,7 +890,7 @@ rebalance:
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
-	did_some_progress = try_to_free_pages(zones, gfp_mask);
+	did_some_progress = try_to_free_pages(zonelist->zones, gfp_mask);
 
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
@@ -902,19 +898,10 @@ rebalance:
 	cond_resched();
 
 	if (likely(did_some_progress)) {
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
+		page = get_page_from_freelist(gfp_mask, order,
+						zonelist, alloc_flags);
+		if (page)
+			goto got_pg;
 	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
 		/*
 		 * Go through the zonelist yet one more time, keep
@@ -922,18 +909,10 @@ rebalance:
 		 * a parallel oom killing, we must fail if we're still
 		 * under heavy pressure.
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
+		page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
+				zonelist, ALLOC_WATERMARKS|ALLOC_CPUSET);
+		if (page)
+			goto got_pg;
 
 		out_of_memory(gfp_mask, order);
 		goto restart;
@@ -966,9 +945,7 @@ nopage:
 		dump_stack();
 		show_mem();
 	}
-	return NULL;
 got_pg:
-	zone_statistics(zonelist, z);
 	return page;
 }
 
Index: linux-2.6/include/linux/mmzone.h
===================================================================
--- linux-2.6.orig/include/linux/mmzone.h	2005-11-08 14:39:56.000000000 +1100
+++ linux-2.6/include/linux/mmzone.h	2005-11-08 14:41:26.000000000 +1100
@@ -302,7 +302,7 @@ void get_zone_counts(unsigned long *acti
 void build_all_zonelists(void);
 void wakeup_kswapd(struct zone *zone, int order);
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
-		int alloc_type, int can_try_harder, int gfp_high);
+		int classzone_idx, int alloc_flags);
 
 #ifdef CONFIG_HAVE_MEMORY_PRESENT
 void memory_present(int nid, unsigned long start, unsigned long end);
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c	2005-11-08 14:39:56.000000000 +1100
+++ linux-2.6/mm/vmscan.c	2005-11-08 14:41:26.000000000 +1100
@@ -1069,7 +1069,7 @@ loop_again:
 
 			if (nr_pages == 0) {	/* Not software suspend */
 				if (zone_watermark_ok(zone, order,
-					zone->pages_high, first_low_zone, 0, 0))
+					zone->pages_high, first_low_zone, 0))
 					continue;
 
 				all_zones_ok = 0;
@@ -1222,7 +1222,7 @@ void wakeup_kswapd(struct zone *zone, in
 		return;
 
 	pgdat = zone->zone_pgdat;
-	if (zone_watermark_ok(zone, order, zone->pages_low, 0, 0, 0))
+	if (zone_watermark_ok(zone, order, zone->pages_low, 0, 0))
 		return;
 	if (pgdat->kswapd_max_order < order)
 		pgdat->kswapd_max_order = order;

--------------010307080208040805040802--
Send instant messages to your online friends http://au.messenger.yahoo.com 
