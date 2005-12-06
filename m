Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVLFS3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVLFS3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVLFS3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:29:08 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52963 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932529AbVLFS3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:29:07 -0500
Date: Tue, 6 Dec 2005 10:28:54 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051206182854.19188.23181.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com>
References: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 3/3] Make nr_pagecache a per node counter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make nr_pagecache a per node variable

The nr_pagecache atomic variable is a particular ugly spot in the VM right
now. We ultimately need a sortof accurate value. This patch makes nr_pagecache
conform to the other VM statistics

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/page-flags.h	2005-12-06 10:13:49.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/page-flags.h	2005-12-06 10:15:59.000000000 -0800
@@ -164,8 +164,8 @@ extern void __mod_page_state(unsigned lo
 /*
  * Node based accounting with per cpu differentials.
  */
-enum node_stat_item { NR_MAPPED };
-#define NR_STAT_ITEMS 1
+enum node_stat_item { NR_MAPPED, NR_PAGECACHE };
+#define NR_STAT_ITEMS 2
 
 extern unsigned long vm_stat_global[NR_STAT_ITEMS];
 extern unsigned long vm_stat_node[MAX_NUMNODES][NR_STAT_ITEMS];
Index: linux-2.6.15-rc5/include/linux/pagemap.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/pagemap.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/pagemap.h	2005-12-06 10:15:59.000000000 -0800
@@ -99,49 +99,9 @@ int add_to_page_cache_lru(struct page *p
 extern void remove_from_page_cache(struct page *page);
 extern void __remove_from_page_cache(struct page *page);
 
-extern atomic_t nr_pagecache;
-
-#ifdef CONFIG_SMP
-
-#define PAGECACHE_ACCT_THRESHOLD        max(16, NR_CPUS * 2)
-DECLARE_PER_CPU(long, nr_pagecache_local);
-
-/*
- * pagecache_acct implements approximate accounting for pagecache.
- * vm_enough_memory() do not need high accuracy. Writers will keep
- * an offset in their per-cpu arena and will spill that into the
- * global count whenever the absolute value of the local count
- * exceeds the counter's threshold.
- *
- * MUST be protected from preemption.
- * current protection is mapping->page_lock.
- */
-static inline void pagecache_acct(int count)
-{
-	long *local;
-
-	local = &__get_cpu_var(nr_pagecache_local);
-	*local += count;
-	if (*local > PAGECACHE_ACCT_THRESHOLD || *local < -PAGECACHE_ACCT_THRESHOLD) {
-		atomic_add(*local, &nr_pagecache);
-		*local = 0;
-	}
-}
-
-#else
-
-static inline void pagecache_acct(int count)
-{
-	atomic_add(count, &nr_pagecache);
-}
-#endif
-
 static inline unsigned long get_page_cache_size(void)
 {
-	int ret = atomic_read(&nr_pagecache);
-	if (unlikely(ret < 0))
-		ret = 0;
-	return ret;
+	return vm_stat_global[NR_PAGECACHE];
 }
 
 /*
Index: linux-2.6.15-rc5/mm/swap_state.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/swap_state.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/mm/swap_state.c	2005-12-06 10:15:59.000000000 -0800
@@ -84,7 +84,7 @@ static int __add_to_swap_cache(struct pa
 			SetPageSwapCache(page);
 			set_page_private(page, entry.val);
 			total_swapcache_pages++;
-			pagecache_acct(1);
+			inc_node_page_state(page_to_nid(page), NR_PAGECACHE);
 		}
 		write_unlock_irq(&swapper_space.tree_lock);
 		radix_tree_preload_end();
@@ -129,7 +129,7 @@ void __delete_from_swap_cache(struct pag
 	set_page_private(page, 0);
 	ClearPageSwapCache(page);
 	total_swapcache_pages--;
-	pagecache_acct(-1);
+	dec_node_page_state(page_to_nid(page), NR_PAGECACHE);
 	INC_CACHE_INFO(del_total);
 }
 
Index: linux-2.6.15-rc5/mm/filemap.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/filemap.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/mm/filemap.c	2005-12-06 10:15:59.000000000 -0800
@@ -115,7 +115,7 @@ void __remove_from_page_cache(struct pag
 	radix_tree_delete(&mapping->page_tree, page->index);
 	page->mapping = NULL;
 	mapping->nrpages--;
-	pagecache_acct(-1);
+	dec_node_page_state(page_to_nid(page), NR_PAGECACHE);
 }
 
 void remove_from_page_cache(struct page *page)
@@ -390,7 +390,7 @@ int add_to_page_cache(struct page *page,
 			page->mapping = mapping;
 			page->index = offset;
 			mapping->nrpages++;
-			pagecache_acct(1);
+			inc_node_page_state(page_to_nid(page), NR_PAGECACHE);
 		}
 		write_unlock_irq(&mapping->tree_lock);
 		radix_tree_preload_end();
