Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWDBV2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWDBV2u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 17:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWDBV2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 17:28:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62385 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964782AbWDBV2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 17:28:49 -0400
Date: Sun, 2 Apr 2006 23:00:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, kamezawa.hiroyu@jp.fujitsu.com
Subject: include/asm-arm/memory.h changes break zaurus sl-5500 boot
Message-ID: <20060402210003.GA11979@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This reverts this (and one more) patch, and fixes boot on
collie. Without this patch, I get some fairly strange warnings about
shift bigger than page size in pfn_to_page().

								Pavel

commit 7eb98a2f3b605d8a11434d855b58d828393ea533
tree 4643bb90d8fe3e48ca8d042286ca3d55b8560d45
parent 1c05dda2b6f025267ab79a267e0a84628a3760e1
author KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> Mon, 27 Mar
2006 01:15:37 -0800
committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 27 Mar 2006
08:44:44 -0800

    [PATCH] unify pfn_to_page: arm pfn_to_page

    ARM can use generic funcs.
    PFN_TO_NID, LOCAL_MAP_NR are defined by sub-archs.

    Signed-off-by: KAMEZAWA Hirotuki <kamezawa.hiroyu@jp.fujitsu.com>
    Cc: Russell King <rmk@arm.linux.org.uk>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>


diff --git a/include/asm-alpha/mmzone.h b/include/asm-alpha/mmzone.h
index 192d80c..c900439 100644
--- a/include/asm-alpha/mmzone.h
+++ b/include/asm-alpha/mmzone.h
@@ -83,7 +83,8 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p, 
 	pte_t pte;                                                           \
 	unsigned long pfn;                                                   \
 									     \
-	pfn = page_to_pfn(page) << 32; \
+	pfn = ((unsigned long)((page)-page_zone(page)->zone_mem_map)) << 32; \
+	pfn += page_zone(page)->zone_start_pfn << 32;			     \
 	pte_val(pte) = pfn | pgprot_val(pgprot);			     \
 									     \
 	pte;								     \
diff --git a/include/asm-arm/memory.h b/include/asm-arm/memory.h
index afa5c3e..b4e1146 100644
--- a/include/asm-arm/memory.h
+++ b/include/asm-arm/memory.h
@@ -172,7 +172,9 @@ static inline __deprecated void *bus_to_
  *  virt_addr_valid(k)	indicates whether a virtual address is valid
  */
 #ifndef CONFIG_DISCONTIGMEM
-#define ARCH_PFN_OFFSET		(PHYS_PFN_OFFSET)
+
+#define page_to_pfn(page)	(((page) - mem_map) + PHYS_PFN_OFFSET)
+#define pfn_to_page(pfn)	((mem_map + (pfn)) - PHYS_PFN_OFFSET)
 #define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))
 
 #define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
@@ -187,8 +189,13 @@ static inline __deprecated void *bus_to_
  * around in memory.
  */
 #include <linux/numa.h>
-#define arch_pfn_to_nid(pfn)	(PFN_TO_NID(pfn))
-#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))
+
+#define page_to_pfn(page)					\
+	(( (page) - page_zone(page)->zone_mem_map)		\
+	  + page_zone(page)->zone_start_pfn)
+
+#define pfn_to_page(pfn)					\
+	(PFN_TO_MAPBASE(pfn) + LOCAL_MAP_NR((pfn) << PAGE_SHIFT))
 
 #define pfn_valid(pfn)						\
 	({							\
@@ -236,6 +243,4 @@ static inline __deprecated void *bus_to_
 
 #endif
 
-#include <asm-generic/memory_model.h>
-
 #endif
diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
index 0cfb086..a7bb497 100644
--- a/include/asm-generic/memory_model.h
+++ b/include/asm-generic/memory_model.h
@@ -45,11 +45,11 @@ extern unsigned long page_to_pfn(struct 
 	NODE_DATA(__nid)->node_mem_map + arch_local_page_offset(__pfn, __nid);\
 })
 
-#define page_to_pfn(pg)							\
-({	struct page *__pg = (pg);					\
-	struct pglist_data *__pgdat = NODE_DATA(page_to_nid(__pg));	\
-	(unsigned long)(__pg - __pgdat->node_mem_map) +			\
-	 __pgdat->node_start_pfn;					\
+#define page_to_pfn(pg)			\
+({	struct page *__pg = (pg);		\
+	struct zone *__zone = page_zone(__pg);	\
+	(unsigned long)(__pg - __zone->zone_mem_map) +	\
+	 __zone->zone_start_pfn;			\
 })
 
 #elif defined(CONFIG_SPARSEMEM)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b5c2112..9d2b23e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -226,6 +226,7 @@ struct zone {
 	 * Discontig memory support fields.
 	 */
 	struct pglist_data	*zone_pgdat;
+	struct page		*zone_mem_map;
 	/* zone_start_pfn == zone_start_paddr >> PAGE_SHIFT */
 	unsigned long		zone_start_pfn;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dc523a1..519724d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2041,6 +2041,7 @@ static __meminit void init_currently_emp
 	zone_wait_table_init(zone, size);
 	pgdat->nr_zones = zone_idx(zone) + 1;
 
+	zone->zone_mem_map = pfn_to_page(zone_start_pfn);
 	zone->zone_start_pfn = zone_start_pfn;
 
 	memmap_init(size, pgdat->node_id, zone_idx(zone), zone_start_pfn);
@@ -2767,8 +2768,9 @@ struct page *pfn_to_page(unsigned long p
 }
 unsigned long page_to_pfn(struct page *page)
 {
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
-	return (page - pgdat->node_mem_map) + pgdat->node_start_pfn;
+	struct zone *zone = page_zone(page);
+	return (page - zone->zone_mem_map) + zone->zone_start_pfn;
+
 }
 #elif defined(CONFIG_SPARSEMEM)
 struct page *pfn_to_page(unsigned long pfn)

-- 
Picture of sleeping (Linux) penguin wanted...
