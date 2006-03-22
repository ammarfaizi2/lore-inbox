Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWCVWeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWCVWeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932892AbWCVWeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:34:36 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:21226 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932891AbWCVWec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:34:32 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223358.12658.36902.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 17/34] mm: page-replace-info.patch
Date: Wed, 22 Mar 2006 23:34:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Isolate the printing of various policy related information.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h |    3 ++
 mm/page_alloc.c                 |   44 +--------------------------------
 mm/useonce.c                    |   52 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 42 deletions(-)

Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -6,6 +6,7 @@
 #include <linux/mmzone.h>
 #include <linux/mm.h>
 #include <linux/pagevec.h>
+#include <linux/seq_file.h>
 
 struct scan_control {
 	/* Ask refill_inactive_zone, or shrink_cache to scan this many pages */
@@ -92,6 +93,8 @@ extern void page_replace_shrink(struct z
 /* void page_replace_mark_accessed(struct page *); */
 /* void page_replace_remove(struct zone *, struct page *); */
 /* void __page_replace_rotate_reclaimable(struct zone *, struct page *); */
+extern void page_replace_show(struct zone *);
+extern void page_replace_zoneinfo(struct zone *, struct seq_file *);
 
 #ifdef CONFIG_MIGRATION
 extern int page_replace_isolate(struct page *p);
Index: linux-2.6-git/mm/useonce.c
===================================================================
--- linux-2.6-git.orig/mm/useonce.c
+++ linux-2.6-git/mm/useonce.c
@@ -426,3 +426,55 @@ void page_replace_shrink(struct zone *zo
 
 	atomic_dec(&zone->reclaim_in_progress);
 }
+
+#define K(x) ((x) << (PAGE_SHIFT-10))
+
+void page_replace_show(struct zone *zone)
+{
+	printk("%s"
+	       " free:%lukB"
+	       " min:%lukB"
+	       " low:%lukB"
+	       " high:%lukB"
+	       " active:%lukB"
+	       " inactive:%lukB"
+	       " present:%lukB"
+	       " pages_scanned:%lu"
+	       " all_unreclaimable? %s"
+	       "\n",
+	       zone->name,
+	       K(zone->free_pages),
+	       K(zone->pages_min),
+	       K(zone->pages_low),
+	       K(zone->pages_high),
+	       K(zone->nr_active),
+	       K(zone->nr_inactive),
+	       K(zone->present_pages),
+	       zone->pages_scanned,
+	       (zone->all_unreclaimable ? "yes" : "no")
+	      );
+}
+
+void page_replace_zoneinfo(struct zone *zone, struct seq_file *m)
+{
+	seq_printf(m,
+		   "\n  pages free     %lu"
+		   "\n        min      %lu"
+		   "\n        low      %lu"
+		   "\n        high     %lu"
+		   "\n        active   %lu"
+		   "\n        inactive %lu"
+		   "\n        scanned  %lu (a: %lu i: %lu)"
+		   "\n        spanned  %lu"
+		   "\n        present  %lu",
+		   zone->free_pages,
+		   zone->pages_min,
+		   zone->pages_low,
+		   zone->pages_high,
+		   zone->nr_active,
+		   zone->nr_inactive,
+		   zone->pages_scanned,
+		   zone->nr_scan_active, zone->nr_scan_inactive,
+		   zone->spanned_pages,
+		   zone->present_pages);
+}
Index: linux-2.6-git/mm/page_alloc.c
===================================================================
--- linux-2.6-git.orig/mm/page_alloc.c
+++ linux-2.6-git/mm/page_alloc.c
@@ -1432,28 +1432,7 @@ void show_free_areas(void)
 		int i;
 
 		show_node(zone);
-		printk("%s"
-			" free:%lukB"
-			" min:%lukB"
-			" low:%lukB"
-			" high:%lukB"
-			" active:%lukB"
-			" inactive:%lukB"
-			" present:%lukB"
-			" pages_scanned:%lu"
-			" all_unreclaimable? %s"
-			"\n",
-			zone->name,
-			K(zone->free_pages),
-			K(zone->pages_min),
-			K(zone->pages_low),
-			K(zone->pages_high),
-			K(zone->nr_active),
-			K(zone->nr_inactive),
-			K(zone->present_pages),
-			zone->pages_scanned,
-			(zone->all_unreclaimable ? "yes" : "no")
-			);
+		page_replace_show(zone);
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			printk(" %lu", zone->lowmem_reserve[i]);
@@ -2218,26 +2197,7 @@ static int zoneinfo_show(struct seq_file
 
 		spin_lock_irqsave(&zone->lock, flags);
 		seq_printf(m, "Node %d, zone %8s", pgdat->node_id, zone->name);
-		seq_printf(m,
-			   "\n  pages free     %lu"
-			   "\n        min      %lu"
-			   "\n        low      %lu"
-			   "\n        high     %lu"
-			   "\n        active   %lu"
-			   "\n        inactive %lu"
-			   "\n        scanned  %lu (a: %lu i: %lu)"
-			   "\n        spanned  %lu"
-			   "\n        present  %lu",
-			   zone->free_pages,
-			   zone->pages_min,
-			   zone->pages_low,
-			   zone->pages_high,
-			   zone->nr_active,
-			   zone->nr_inactive,
-			   zone->pages_scanned,
-			   zone->nr_scan_active, zone->nr_scan_inactive,
-			   zone->spanned_pages,
-			   zone->present_pages);
+		page_replace_zoneinfo(zone, m);
 		seq_printf(m,
 			   "\n        protection: (%lu",
 			   zone->lowmem_reserve[0]);
