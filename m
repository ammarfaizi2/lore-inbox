Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbVKWF6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbVKWF6x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 00:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbVKWF6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 00:58:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29338 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030319AbVKWF6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 00:58:52 -0500
Date: Tue, 22 Nov 2005 21:58:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: rohit.seth@intel.com, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, christoph@lameter.com
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
 conditions
Message-Id: <20051122215838.2abfdbd4.akpm@osdl.org>
In-Reply-To: <20051122213612.4adef5d0.akpm@osdl.org>
References: <20051122161000.A22430@unix-os.sc.intel.com>
	<20051122213612.4adef5d0.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> The `while' loop worries me for some reason, so I wimped out and just tried
>  the remote drain once.

Even the `goto restart' which is in this patch worries me from a livelock
POV.  Perhaps we should only ever run drain_all_local_pages() once per
__alloc_pages() invokation.

And perhaps we should run drain_all_local_pages() for GFP_ATOMIC or
PF_MEMALLOC attempts too.


--- devel/include/linux/gfp.h~mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions	2005-11-22 21:47:33.000000000 -0800
+++ devel-akpm/include/linux/gfp.h	2005-11-22 21:57:22.000000000 -0800
@@ -109,6 +109,8 @@ static inline struct page *alloc_pages_n
 		NODE_DATA(nid)->node_zonelists + gfp_zone(gfp_mask));
 }
 
+extern void drain_local_pages(void);
+
 #ifdef CONFIG_NUMA
 extern struct page *alloc_pages_current(gfp_t gfp_mask, unsigned order);
 
diff -puN include/linux/suspend.h~mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions include/linux/suspend.h
--- devel/include/linux/suspend.h~mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions	2005-11-22 21:47:33.000000000 -0800
+++ devel-akpm/include/linux/suspend.h	2005-11-22 21:47:33.000000000 -0800
@@ -40,7 +40,6 @@ extern dev_t swsusp_resume_device;
 extern int shrink_mem(void);
 
 /* mm/page_alloc.c */
-extern void drain_local_pages(void);
 extern void mark_free_pages(struct zone *zone);
 
 #ifdef CONFIG_PM
diff -puN mm/page_alloc.c~mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions mm/page_alloc.c
--- devel/mm/page_alloc.c~mm-free-pages-from-local-pcp-lists-under-tight-memory-conditions	2005-11-22 21:47:33.000000000 -0800
+++ devel-akpm/mm/page_alloc.c	2005-11-22 21:58:01.000000000 -0800
@@ -578,32 +578,65 @@ void drain_remote_pages(void)
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
+void drain_local_pages(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__drain_pages(smp_processor_id());
+	local_irq_restore(flags);
+}
 
+static void drainer(void *p)
+{
+	drain_local_pages();
+}
+
+/*
+ * Drain the per-cpu pages on all CPUs.  If called from interrupt context we
+ * can only drain the local CPU's pages, since cross-CPU calls are deadlocky
+ * from interrupt context.
+ */
+static void drain_all_local_pages(void)
+{
+	if (in_interrupt())
+		drain_local_pages();
+	else
+		on_each_cpu(drainer, NULL, 0, 1);
+}
+
+#ifdef CONFIG_PM
 void mark_free_pages(struct zone *zone)
 {
 	unsigned long zone_pfn, flags;
@@ -629,17 +662,6 @@ void mark_free_pages(struct zone *zone)
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
@@ -889,6 +911,10 @@ restart:
 	if (gfp_mask & __GFP_HIGH)
 		alloc_flags |= ALLOC_DIP_LESS;
 
+	if (order > 0 || (!wait && (gfp_mask & __GFP_HIGH)) ||
+			(p->flags & PF_MEMALLOC))
+		drain_all_local_pages();
+
 	page = get_page_from_freelist(gfp_mask, order, zonelist, alloc_flags);
 	if (page)
 		goto got_pg;
_

