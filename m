Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753189AbWKVOix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbWKVOix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 09:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbWKVOiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 09:38:52 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:52384
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1752694AbWKVOiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 09:38:52 -0500
Date: Wed, 22 Nov 2006 14:38:35 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: [PATCH] numa node ids are int, page_to_nid and zone_to_nid should return int
Message-ID: <4ca02d5d043ebc00c0687ccb12d515c7@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

numa node ids are int, page_to_nid and zone_to_nid should return int

NUMA node ids are passed as either int or unsigned int almost exclusivly
page_to_nid and zone_to_nid both return unsigned long.  This is a
throw back to when page_to_nid was a #define and was thus exposing
the real type of the page flags field.

In addition to fixing up the definitions of page_to_nid and zone_to_nid
I audited the users of these functions identifying the following
incorrect uses:

1) mm/page_alloc.c show_node() -- printk dumping the node id,
2) include/asm-ia64/pgalloc.h pgtable_quicklist_free() -- comparison
   against numa_node_id() which returns an int from cpu_to_node(), and
3) mm/mpolicy.c check_pte_range -- used as an index in node_isset which
   uses bit_set which in generic code takes an int.

Against 2.6.19-rc5-mm2.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/include/asm-ia64/pgalloc.h b/include/asm-ia64/pgalloc.h
index 9cb68e9..393e04c 100644
--- a/include/asm-ia64/pgalloc.h
+++ b/include/asm-ia64/pgalloc.h
@@ -60,7 +60,7 @@ static inline void *pgtable_quicklist_al
 static inline void pgtable_quicklist_free(void *pgtable_entry)
 {
 #ifdef CONFIG_NUMA
-	unsigned long nid = page_to_nid(virt_to_page(pgtable_entry));
+	int nid = page_to_nid(virt_to_page(pgtable_entry));
 
 	if (unlikely(nid != numa_node_id())) {
 		free_page((unsigned long)pgtable_entry);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d42985a..869042c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -455,7 +455,7 @@ static inline int page_zone_id(struct pa
 	return (page->flags >> ZONEID_PGSHIFT) & ZONEID_MASK;
 }
 
-static inline unsigned long zone_to_nid(struct zone *zone)
+static inline int zone_to_nid(struct zone *zone)
 {
 #ifdef CONFIG_NUMA
 	return zone->node;
@@ -465,9 +465,9 @@ static inline unsigned long zone_to_nid(
 }
 
 #ifdef NODE_NOT_IN_PAGE_FLAGS
-extern unsigned long page_to_nid(struct page *page);
+extern int page_to_nid(struct page *page);
 #else
-static inline unsigned long page_to_nid(struct page *page)
+static inline int page_to_nid(struct page *page)
 {
 	return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
 }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b3dfecd..f7c352f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -221,7 +221,7 @@ static int check_pte_range(struct vm_are
 	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	do {
 		struct page *page;
-		unsigned int nid;
+		int nid;
 
 		if (!pte_present(*pte))
 			continue;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 19ab611..a795f85 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1566,7 +1566,7 @@ unsigned int nr_free_pagecache_pages(voi
 static inline void show_node(struct zone *zone)
 {
 	if (NUMA_BUILD)
-		printk("Node %ld ", zone_to_nid(zone));
+		printk("Node %d ", zone_to_nid(zone));
 }
 
 /*
diff --git a/mm/sparse.c b/mm/sparse.c
index 158d6a2..ac26eb0 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -36,7 +36,7 @@ static u8 section_to_node_table[NR_MEM_S
 static u16 section_to_node_table[NR_MEM_SECTIONS] __cacheline_aligned;
 #endif
 
-unsigned long page_to_nid(struct page *page)
+int page_to_nid(struct page *page)
 {
 	return section_to_node_table[page_to_section(page)];
 }
