Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbTGAAZs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 20:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTGAAZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 20:25:48 -0400
Received: from holomorphy.com ([66.224.33.161]:51114 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265060AbTGAAZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 20:25:45 -0400
Date: Mon, 30 Jun 2003 17:39:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-ID: <20030701003958.GB20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030627202130.066c183b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627202130.066c183b.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 08:21:30PM -0700, Andrew Morton wrote:
> Just bits and pieces.

It was suggested during my last round of OOM killer fixes that one of
my patches, which just checked nr_free_buffer_pages() > 0, should also
consider userspace (i.e. reclaimable at will) memory free.

This patch implements that suggestion. Lightly tested, and expected to
fall within the "relatively trivial" category.

We're still not out of hot water here yet, since the minimum thresholds
will still send all processes into perpetual torpor under persistent
low memory conditions while fooling the OOM heuristics. But this is at
least better than complete ignorance of ZONE_NORMAL exhaustion.


-- wli


diff -prauN wli-2.5.73-31/include/linux/mm.h wli-2.5.73-32/include/linux/mm.h
--- wli-2.5.73-31/include/linux/mm.h	2003-06-29 01:39:42.000000000 -0700
+++ wli-2.5.73-32/include/linux/mm.h	2003-06-30 16:42:28.000000000 -0700
@@ -605,7 +605,8 @@ static inline struct vm_area_struct * fi
 
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
-extern unsigned int nr_used_zone_pages(void);
+unsigned int nr_used_low_pages(void);
+unsigned int nr_used_zone_pages(void);
 
 extern struct page * vmalloc_to_page(void *addr);
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
diff -prauN wli-2.5.73-31/mm/oom_kill.c wli-2.5.73-32/mm/oom_kill.c
--- wli-2.5.73-31/mm/oom_kill.c	2003-06-22 11:32:55.000000000 -0700
+++ wli-2.5.73-32/mm/oom_kill.c	2003-06-30 16:46:49.000000000 -0700
@@ -217,9 +217,9 @@ void out_of_memory(void)
 	unsigned long now, since;
 
 	/*
-	 * Enough swap space left?  Not OOM.
+	 * Enough swap space and ZONE_NORMAL left?  Not OOM.
 	 */
-	if (nr_swap_pages > 0)
+	if (nr_swap_pages > 0 && nr_free_buffer_pages() + nr_used_low_pages() > 0)
 		return;
 
 	spin_lock(&oom_lock);
diff -prauN wli-2.5.73-31/mm/page_alloc.c wli-2.5.73-32/mm/page_alloc.c
--- wli-2.5.73-31/mm/page_alloc.c	2003-06-23 10:53:46.000000000 -0700
+++ wli-2.5.73-32/mm/page_alloc.c	2003-06-30 17:06:20.000000000 -0700
@@ -738,17 +738,6 @@ unsigned int nr_free_pages(void)
 }
 EXPORT_SYMBOL(nr_free_pages);
 
-unsigned int nr_used_zone_pages(void)
-{
-	unsigned int pages = 0;
-	struct zone *zone;
-
-	for_each_zone(zone)
-		pages += zone->nr_active + zone->nr_inactive;
-
-	return pages;
-}
-
 #ifdef CONFIG_NUMA
 unsigned int nr_free_pages_pgdat(pg_data_t *pgdat)
 {
@@ -782,6 +771,28 @@ static unsigned int nr_free_zone_pages(i
 	return sum;
 }
 
+static unsigned int __nr_used_zone_pages(int offset)
+{
+	struct zone *zone;
+	unsigned int sum = 0;
+
+	for_each_zone(zone)
+		if (zone - zone->zone_pgdat->node_zones <= offset)
+			sum += zone->nr_active + zone->nr_inactive;
+
+	return sum;
+}
+
+unsigned int nr_used_zone_pages(void)
+{
+	return __nr_used_zone_pages(GFP_HIGHUSER & GFP_ZONEMASK);
+}
+
+unsigned int nr_used_low_pages(void)
+{
+	return __nr_used_zone_pages(GFP_USER & GFP_ZONEMASK);
+}
+
 /*
  * Amount of free RAM allocatable within ZONE_DMA and ZONE_NORMAL
  */
