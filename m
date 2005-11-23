Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbVKWFg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbVKWFg3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 00:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVKWFg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 00:36:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42135 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030314AbVKWFg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 00:36:27 -0500
Date: Tue, 22 Nov 2005 21:36:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rohit Seth <rohit.seth@intel.com>
Cc: torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
 conditions
Message-Id: <20051122213612.4adef5d0.akpm@osdl.org>
In-Reply-To: <20051122161000.A22430@unix-os.sc.intel.com>
References: <20051122161000.A22430@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth <rohit.seth@intel.com> wrote:
>
> Andrew, Linus,
> 
> [PATCH]: This patch free pages (pcp->batch from each list at a time) from
> local pcp lists when a higher order allocation request is not able to 
> get serviced from global free_list.
> 
> This should help fix some of the earlier failures seen with order 1 allocations.
> 
> I will send separate patches for:
> 
> 1- Reducing the remote cpus pcp
> 2- Clean up page_alloc.c for CONFIG_HOTPLUG_CPU to use this code appropiately
> 
> +static int
> +reduce_cpu_pcp(void )
> +{
> +	struct zone *zone;
> +	unsigned long flags;
> +	unsigned int cpu = get_cpu();
> +	int i, ret=0;
> +
> +	local_irq_save(flags);
> +	for_each_zone(zone) {
> +		struct per_cpu_pageset *pset;
> +
> +		pset = zone_pcp(zone, cpu);
> +		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
> +			struct per_cpu_pages *pcp;
> +
> +			pcp = &pset->pcp[i];
> +			if (pcp->count == 0)
> +				continue;
> +			pcp->count -= free_pages_bulk(zone, pcp->batch,
> +						&pcp->list, 0);
> +			ret++;
> +		}
> +	}
> +	local_irq_restore(flags);
> +	put_cpu();
> +	return ret;
> +}

This significantly duplicates the existing drain_local_pages().

>  
> +	if (order > 0) 
> +		while (reduce_cpu_pcp()) {
> +			if (get_page_from_freelist(gfp_mask, order, zonelist, alloc_flags))

This forgot to assign to local variable `page'!  It'll return NULL and will
leak memory.

The `while' loop worries me for some reason, so I wimped out and just tried
the remote drain once.

> +				goto got_pg;
> +		}
> +	/* FIXME: Add the support for reducing/draining the remote pcps.

This is easy enough to do.

I wanted to call the all-CPU drainer `drain_remote_pages' but that's
already taken by some rather poorly-named NUMA thing which also duplicates
most of __drain_pages().

This patch is against a random selection of the enormous number of mm/
patches in -mm.  I haven't runtime-tested it yet.

We need to verify that this patch actually does something useful.



 include/linux/gfp.h     |    2 +
 include/linux/suspend.h |    1 
 mm/page_alloc.c         |   85 ++++++++++++++++++++++++++++++++++++------------
 3 files changed, 66 insertions(+), 22 deletions(-)

diff -puN include/linux/gfp.h~mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions include/linux/gfp.h
--- devel/include/linux/gfp.h~mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions	2005-11-22 21:32:47.000000000 -0800
+++ devel-akpm/include/linux/gfp.h	2005-11-22 21:32:47.000000000 -0800
@@ -109,6 +109,8 @@ static inline struct page *alloc_pages_n
 		NODE_DATA(nid)->node_zonelists + gfp_zone(gfp_mask));
 }
 
+extern int drain_local_pages(void);
+
 #ifdef CONFIG_NUMA
 extern struct page *alloc_pages_current(gfp_t gfp_mask, unsigned order);
 
diff -puN include/linux/suspend.h~mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions include/linux/suspend.h
--- devel/include/linux/suspend.h~mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions	2005-11-22 21:32:47.000000000 -0800
+++ devel-akpm/include/linux/suspend.h	2005-11-22 21:32:47.000000000 -0800
@@ -40,7 +40,6 @@ extern dev_t swsusp_resume_device;
 extern int shrink_mem(void);
 
 /* mm/page_alloc.c */
-extern void drain_local_pages(void);
 extern void mark_free_pages(struct zone *zone);
 
 #ifdef CONFIG_PM
diff -puN mm/page_alloc.c~mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions mm/page_alloc.c
--- devel/mm/page_alloc.c~mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions	2005-11-22 21:32:47.000000000 -0800
+++ devel-akpm/mm/page_alloc.c	2005-11-22 21:32:47.000000000 -0800
@@ -578,32 +578,71 @@ void drain_remote_pages(void)
 }
 #endif
 
-#if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
-static void __drain_pages(unsigned int cpu)
+/*
+ * Drain any cpu-local pages into the buddy lists.  Must be called under
+ * local_irq_disable().
+ */
+static int __drain_pages(unsigned int cpu)
 {
-	unsigned long flags;
 	struct zone *zone;
-	int i;
+	int ret = 0;
 
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;
+		int i;
 
 		pset = zone_pcp(zone, cpu);
 		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
 			struct per_cpu_pages *pcp;
 
 			pcp = &pset->pcp[i];
-			local_irq_save(flags);
+			if (!pcp->count)
+				continue;
 			pcp->count -= free_pages_bulk(zone, pcp->count,
 						&pcp->list, 0);
-			local_irq_restore(flags);
+			ret++;
 		}
 	}
+	return ret;
 }
-#endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU */
 
-#ifdef CONFIG_PM
+/*
+ * Spill all of this CPU's per-cpu pages back into the buddy allocator.
+ */
+int drain_local_pages(void)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+	ret = __drain_pages(smp_processor_id());
+	local_irq_restore(flags);
+	return ret;
+}
+
+static void drainer(void *p)
+{
+	atomic_add(drain_local_pages(), p);
+}
+
+/*
+ * Drain the per-cpu pages on all CPUs.  If called from interrupt context we
+ * can only drain the local CPU's pages, since cross-CPU calls are deadlocky
+ * from interrupt context.
+ */
+static int drain_all_local_pages(void)
+{
+	if (in_interrupt()) {
+		return drain_local_pages();
+	} else {
+		atomic_t ret = ATOMIC_INIT(0);
+
+		on_each_cpu(drainer, &ret, 0, 1);
+		return atomic_read(&ret);
+	}
+}
 
+#ifdef CONFIG_PM
 void mark_free_pages(struct zone *zone)
 {
 	unsigned long zone_pfn, flags;
@@ -629,17 +668,6 @@ void mark_free_pages(struct zone *zone)
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
-/*
- * Spill all of this CPU's per-cpu pages back into the buddy allocator.
- */
-void drain_local_pages(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);	
-	__drain_pages(smp_processor_id());
-	local_irq_restore(flags);	
-}
 #endif /* CONFIG_PM */
 
 static void zone_statistics(struct zonelist *zonelist, struct zone *z)
@@ -913,8 +941,16 @@ nofail_alloc:
 	}
 
 	/* Atomic allocations - we can't balance anything */
-	if (!wait)
-		goto nopage;
+	if (!wait) {
+		/*
+		 * Check if there are pages available on pcp lists that can be
+		 * moved to global page list to satisfy higher order allocations
+		 */
+		if (order > 0 && drain_all_local_pages())
+			goto restart;
+		else
+			goto nopage;
+	}
 
 rebalance:
 	cond_resched();
@@ -952,6 +988,13 @@ rebalance:
 		goto restart;
 	}
 
+	if (order > 0 && drain_all_local_pages()) {
+		page = get_page_from_freelist(gfp_mask, order, zonelist,
+						alloc_flags);
+		if (page)
+			goto got_pg;
+	}
+
 	/*
 	 * Don't let big-order allocations loop unless the caller explicitly
 	 * requests that.  Wait for some write requests to complete then retry.
_

