Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVCYRje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVCYRje (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 12:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVCYRj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 12:39:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:22950 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261701AbVCYRd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 12:33:26 -0500
Subject: [PATCH] remove non-DISCONTIG use of pgdat->node_mem_map
To: akpm@osdl.org
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 25 Mar 2005 09:33:19 -0800
Message-Id: <E1DEsgS-0002zz-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch effectively eliminates direct use of pgdat->node_mem_map
outside of the DISCONTIG code.  On a flat memory system, these fields
aren't currently used, neither are they on a sparsemem system.

There was also a node_mem_map(nid) macro on many architectures. Its
use along with the use of ->node_mem_map itself was not consistent.
It has been removed in favor of two new, more explicit,
arch-independent macros:

	pgdat_page_nr(pgdat, pagenr)
	nid_page_nr(nid, pagenr)

I called them "pgdat" and "nid" because we overload the term "node"
to mean "NUMA node", "DISCONTIG node" or "pg_data_t" in very
confusing ways.  I believe the newer names are much clearer.

These macros can be overridden in the sparsemem case with a
theoretically slower operation using node_start_pfn and pfn_to_page(),
instead.  We could make this the only behavior if people want,  but
I don't want to change too much at once.  One thing at a time.

This patch removes more code than it adds.

Compile tested on alpha, alpha discontig, arm, arm-discontig, i386,
i386 generic, NUMAQ, Summit, ppc64, ppc64 discontig, and x86_64. Full
list here: http://sr71.net/patches/2.6.12/2.6.12-rc1-mhp2/configs/

Boot tested on NUMAQ, x86 SMP and ppc64 power4/5 LPARs.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/alpha/mm/numa.c             |   16 +++++++---------
 memhotplug-dave/arch/i386/mm/pgtable.c           |    2 +-
 memhotplug-dave/arch/ia64/mm/discontig.c         |    9 +++++----
 memhotplug-dave/arch/m32r/mm/init.c              |    4 ++--
 memhotplug-dave/arch/mips/sgi-ip27/ip27-memory.c |    5 ++---
 memhotplug-dave/arch/parisc/mm/init.c            |    2 +-
 memhotplug-dave/arch/ppc64/mm/init.c             |    4 ++--
 memhotplug-dave/include/asm-alpha/mmzone.h       |    3 +--
 memhotplug-dave/include/asm-i386/mmzone.h        |    3 +--
 memhotplug-dave/include/asm-m32r/mmzone.h        |    3 +--
 memhotplug-dave/include/asm-parisc/mmzone.h      |    3 +--
 memhotplug-dave/include/asm-ppc64/mmzone.h       |    3 +--
 memhotplug-dave/include/asm-x86_64/mmzone.h      |    5 +----
 memhotplug-dave/include/linux/mmzone.h           |    2 ++
 mm/page_alloc.c                                  |    0 
 15 files changed, 28 insertions(+), 36 deletions(-)

diff -puN arch/alpha/mm/numa.c~A1-no-node_mem_map arch/alpha/mm/numa.c
--- memhotplug/arch/alpha/mm/numa.c~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/arch/alpha/mm/numa.c	2005-03-25 08:57:38.000000000 -0800
@@ -327,8 +327,6 @@ void __init mem_init(void)
 	extern char _text, _etext, _data, _edata;
 	extern char __init_begin, __init_end;
 	unsigned long nid, i;
-	struct page * lmem_map;
-
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	reservedpages = 0;
@@ -338,10 +336,10 @@ void __init mem_init(void)
 		 */
 		totalram_pages += free_all_bootmem_node(NODE_DATA(nid));
 
-		lmem_map = node_mem_map(nid);
 		pfn = NODE_DATA(nid)->node_start_pfn;
 		for (i = 0; i < node_spanned_pages(nid); i++, pfn++)
-			if (page_is_ram(pfn) && PageReserved(lmem_map+i))
+			if (page_is_ram(pfn) &&
+			    PageReserved(nid_page_nr(nid, i)))
 				reservedpages++;
 	}
 
@@ -373,18 +371,18 @@ show_mem(void)
 	show_free_areas();
 	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
 	for_each_online_node(nid) {
-		struct page * lmem_map = node_mem_map(nid);
 		i = node_spanned_pages(nid);
 		while (i-- > 0) {
+			struct page *page = nid_page_nr(nid, i);
 			total++;
-			if (PageReserved(lmem_map+i))
+			if (PageReserved(page))
 				reserved++;
-			else if (PageSwapCache(lmem_map+i))
+			else if (PageSwapCache(page))
 				cached++;
-			else if (!page_count(lmem_map+i))
+			else if (!page_count(page))
 				free++;
 			else
-				shared += page_count(lmem_map + i) - 1;
+				shared += page_count(page) - 1;
 		}
 	}
 	printk("%ld pages of RAM\n",total);
diff -puN arch/arm26/mm/init.c~A1-no-node_mem_map arch/arm26/mm/init.c
diff -puN arch/i386/mm/pgtable.c~A1-no-node_mem_map arch/i386/mm/pgtable.c
--- memhotplug/arch/i386/mm/pgtable.c~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/pgtable.c	2005-03-25 08:28:26.000000000 -0800
@@ -36,7 +36,7 @@ void show_mem(void)
 	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
 	for_each_pgdat(pgdat) {
 		for (i = 0; i < pgdat->node_spanned_pages; ++i) {
-			page = pgdat->node_mem_map + i;
+			page = pgdat_page_nr(pgdat, i);
 			total++;
 			if (PageHighMem(page))
 				highmem++;
diff -puN arch/ia64/mm/contig.c~A1-no-node_mem_map arch/ia64/mm/contig.c
diff -puN arch/ia64/mm/discontig.c~A1-no-node_mem_map arch/ia64/mm/discontig.c
--- memhotplug/arch/ia64/mm/discontig.c~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/arch/ia64/mm/discontig.c	2005-03-25 08:28:26.000000000 -0800
@@ -560,14 +560,15 @@ void show_mem(void)
 		int shared = 0, cached = 0, reserved = 0;
 		printk("Node ID: %d\n", pgdat->node_id);
 		for(i = 0; i < pgdat->node_spanned_pages; i++) {
+			struct page *page = pgdat_page_nr(pgdat, i);
 			if (!ia64_pfn_valid(pgdat->node_start_pfn+i))
 				continue;
-			if (PageReserved(pgdat->node_mem_map+i))
+			if (PageReserved(page))
 				reserved++;
-			else if (PageSwapCache(pgdat->node_mem_map+i))
+			else if (PageSwapCache(page))
 				cached++;
-			else if (page_count(pgdat->node_mem_map+i))
-				shared += page_count(pgdat->node_mem_map+i)-1;
+			else if (page_count(page))
+				shared += page_count(page)-1;
 		}
 		total_present += present;
 		total_reserved += reserved;
diff -puN arch/m32r/mm/init.c~A1-no-node_mem_map arch/m32r/mm/init.c
--- memhotplug/arch/m32r/mm/init.c~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/arch/m32r/mm/init.c	2005-03-25 08:28:26.000000000 -0800
@@ -49,7 +49,7 @@ void show_mem(void)
 	printk("Free swap:       %6ldkB\n",nr_swap_pages<<(PAGE_SHIFT-10));
 	for_each_pgdat(pgdat) {
 		for (i = 0; i < pgdat->node_spanned_pages; ++i) {
-			page = pgdat->node_mem_map + i;
+			page = pgdat_page_nr(pgdat, i);
 			total++;
 			if (PageHighMem(page))
 				highmem++;
@@ -152,7 +152,7 @@ int __init reservedpages_count(void)
 	reservedpages = 0;
 	for_each_online_node(nid)
 		for (i = 0 ; i < MAX_LOW_PFN(nid) - START_PFN(nid) ; i++)
-			if (PageReserved(NODE_DATA(nid)->node_mem_map + i))
+			if (PageReserved(nid_page_nr(nid, i)))
 				reservedpages++;
 
 	return reservedpages;
diff -puN arch/mips/sgi-ip27/ip27-memory.c~A1-no-node_mem_map arch/mips/sgi-ip27/ip27-memory.c
--- memhotplug/arch/mips/sgi-ip27/ip27-memory.c~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/arch/mips/sgi-ip27/ip27-memory.c	2005-03-25 08:28:26.000000000 -0800
@@ -549,9 +549,8 @@ void __init mem_init(void)
 		 */
 		numslots = node_getlastslot(node);
 		for (slot = 1; slot <= numslots; slot++) {
-			p = NODE_DATA(node)->node_mem_map +
-				(slot_getbasepfn(node, slot) -
-				 slot_getbasepfn(node, 0));
+			p = nid_page_nr(node, slot_getbasepfn(node, slot) -
+					      slot_getbasepfn(node, 0));
 
 			/*
 			 * Free valid memory in current slot.
diff -puN arch/parisc/mm/init.c~A1-no-node_mem_map arch/parisc/mm/init.c
--- memhotplug/arch/parisc/mm/init.c~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/arch/parisc/mm/init.c	2005-03-25 08:28:26.000000000 -0800
@@ -506,7 +506,7 @@ void show_mem(void)
 		for (j = node_start_pfn(i); j < node_end_pfn(i); j++) {
 			struct page *p;
 
-			p = node_mem_map(i) + j - node_start_pfn(i);
+			p = nid_page_nr(i, j) - node_start_pfn(i);
 
 			total++;
 			if (PageReserved(p))
diff -puN arch/ppc64/mm/init.c~A1-no-node_mem_map arch/ppc64/mm/init.c
--- memhotplug/arch/ppc64/mm/init.c~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/arch/ppc64/mm/init.c	2005-03-25 08:28:26.000000000 -0800
@@ -100,7 +100,7 @@ void show_mem(void)
 	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
 	for_each_pgdat(pgdat) {
 		for (i = 0; i < pgdat->node_spanned_pages; i++) {
-			page = pgdat->node_mem_map + i;
+			page = pgdat_page_nr(pgdat, i);
 			total++;
 			if (PageReserved(page))
 				reserved++;
@@ -724,7 +724,7 @@ void __init mem_init(void)
 
 	for_each_pgdat(pgdat) {
 		for (i = 0; i < pgdat->node_spanned_pages; i++) {
-			page = pgdat->node_mem_map + i;
+			page = pgdat_page_nr(pgdat, i);
 			if (PageReserved(page))
 				reservedpages++;
 		}
diff -puN arch/sh/mm/init.c~A1-no-node_mem_map arch/sh/mm/init.c
diff -puN arch/sh64/mm/init.c~A1-no-node_mem_map arch/sh64/mm/init.c
diff -puN arch/v850/kernel/setup.c~A1-no-node_mem_map arch/v850/kernel/setup.c
diff -puN include/asm-alpha/mmzone.h~A1-no-node_mem_map include/asm-alpha/mmzone.h
--- memhotplug/include/asm-alpha/mmzone.h~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/include/asm-alpha/mmzone.h	2005-03-25 08:28:26.000000000 -0800
@@ -57,7 +57,6 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p, 
  * Given a kernel address, find the home node of the underlying memory.
  */
 #define kvaddr_to_nid(kaddr)	pa_to_nid(__pa(kaddr))
-#define node_mem_map(nid)	(NODE_DATA(nid)->node_mem_map)
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 
 #define local_mapnr(kvaddr) \
@@ -108,7 +107,7 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p, 
 #define pfn_to_page(pfn)						\
 ({									\
  	unsigned long kaddr = (unsigned long)__va((pfn) << PAGE_SHIFT);	\
-	(node_mem_map(kvaddr_to_nid(kaddr)) + local_mapnr(kaddr));	\
+	(NODE_DATA(kvaddr_to_nid(kaddr))->node_mem_map + local_mapnr(kaddr));	\
 })
 
 #define page_to_pfn(page)						\
diff -puN include/asm-arm/mmzone.h~A1-no-node_mem_map include/asm-arm/mmzone.h
diff -puN include/asm-i386/mmzone.h~A1-no-node_mem_map include/asm-i386/mmzone.h
--- memhotplug/include/asm-i386/mmzone.h~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/include/asm-i386/mmzone.h	2005-03-25 08:28:26.000000000 -0800
@@ -79,7 +79,6 @@ static inline int pfn_to_nid(unsigned lo
  */
 #define kvaddr_to_nid(kaddr)	pfn_to_nid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define node_mem_map(nid)	(NODE_DATA(nid)->node_mem_map)
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)						\
 ({									\
@@ -100,7 +99,7 @@ static inline int pfn_to_nid(unsigned lo
 ({									\
 	unsigned long __pfn = pfn;					\
 	int __node  = pfn_to_nid(__pfn);				\
-	&node_mem_map(__node)[node_localnr(__pfn,__node)];		\
+	&NODE_DATA(__node)->node_mem_map[node_localnr(__pfn,__node)];	\
 })
 
 #define page_to_pfn(pg)							\
diff -puN include/asm-m32r/mmzone.h~A1-no-node_mem_map include/asm-m32r/mmzone.h
--- memhotplug/include/asm-m32r/mmzone.h~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/include/asm-m32r/mmzone.h	2005-03-25 08:28:26.000000000 -0800
@@ -14,7 +14,6 @@ extern struct pglist_data *node_data[];
 #define NODE_DATA(nid)		(node_data[nid])
 
 #define node_localnr(pfn, nid)	((pfn) - NODE_DATA(nid)->node_start_pfn)
-#define node_mem_map(nid)	(NODE_DATA(nid)->node_mem_map)
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)						\
 ({									\
@@ -32,7 +31,7 @@ extern struct pglist_data *node_data[];
 ({									\
 	unsigned long __pfn = pfn;					\
 	int __node  = pfn_to_nid(__pfn);				\
-	&node_mem_map(__node)[node_localnr(__pfn,__node)];		\
+	&NODE_DATA(__node)->node_mem_map[node_localnr(__pfn,__node)];	\
 })
 
 #define page_to_pfn(pg)							\
diff -puN include/asm-mips/mmzone.h~A1-no-node_mem_map include/asm-mips/mmzone.h
diff -puN include/asm-parisc/mmzone.h~A1-no-node_mem_map include/asm-parisc/mmzone.h
--- memhotplug/include/asm-parisc/mmzone.h~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/include/asm-parisc/mmzone.h	2005-03-25 08:28:26.000000000 -0800
@@ -19,7 +19,6 @@ extern struct node_map_data node_data[];
  */
 #define kvaddr_to_nid(kaddr)	pfn_to_nid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define node_mem_map(nid)	(NODE_DATA(nid)->node_mem_map)
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)						\
 ({									\
@@ -38,7 +37,7 @@ extern struct node_map_data node_data[];
 ({									\
 	unsigned long __pfn = (pfn);					\
 	int __node  = pfn_to_nid(__pfn);				\
-	&node_mem_map(__node)[node_localnr(__pfn,__node)];		\
+	&NODE_DATA(__node)->node_mem_map[node_localnr(__pfn,__node)];	\
 })
 
 #define page_to_pfn(pg)							\
diff -puN include/asm-ppc64/mmzone.h~A1-no-node_mem_map include/asm-ppc64/mmzone.h
--- memhotplug/include/asm-ppc64/mmzone.h~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/include/asm-ppc64/mmzone.h	2005-03-25 08:28:26.000000000 -0800
@@ -65,7 +65,6 @@ static inline int pa_to_nid(unsigned lon
  */
 #define kvaddr_to_nid(kaddr)	pa_to_nid(__pa(kaddr))
 
-#define node_mem_map(nid)	(NODE_DATA(nid)->node_mem_map)
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)	(NODE_DATA(nid)->node_end_pfn)
 
@@ -76,7 +75,7 @@ static inline int pa_to_nid(unsigned lon
 #define discontigmem_pfn_to_page(pfn) \
 ({ \
 	unsigned long __tmp = pfn; \
-	(node_mem_map(pfn_to_nid(__tmp)) + \
+	(NODE_DATA(pfn_to_nid(__tmp))->node_mem_map + \
 	 node_localnr(__tmp, pfn_to_nid(__tmp))); \
 })
 
diff -puN include/asm-sh/mmzone.h~A1-no-node_mem_map include/asm-sh/mmzone.h
diff -puN include/asm-x86_64/mmzone.h~A1-no-node_mem_map include/asm-x86_64/mmzone.h
--- memhotplug/include/asm-x86_64/mmzone.h~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/include/asm-x86_64/mmzone.h	2005-03-25 08:28:26.000000000 -0800
@@ -35,9 +35,6 @@ static inline __attribute__((pure)) int 
 #define kvaddr_to_nid(kaddr)	phys_to_nid(__pa(kaddr))
 #define NODE_DATA(nid)		(node_data[nid])
 
-#define node_mem_map(nid)	(NODE_DATA(nid)->node_mem_map)
-
-#define node_mem_map(nid)	(NODE_DATA(nid)->node_mem_map)
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)       (NODE_DATA(nid)->node_start_pfn + \
 				 NODE_DATA(nid)->node_spanned_pages)
@@ -50,7 +47,7 @@ static inline __attribute__((pure)) int 
    (2.4 used to). */
 #define pfn_to_page(pfn) ({ \
 	int nid = phys_to_nid(((unsigned long)(pfn)) << PAGE_SHIFT); 	\
-	((pfn) - node_start_pfn(nid)) + node_mem_map(nid);		\
+	((pfn) - node_start_pfn(nid)) + NODE_DATA(nid)->node_mem_map;	\
 })
 
 #define page_to_pfn(page) \
diff -puN include/linux/mmzone.h~A1-no-node_mem_map include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~A1-no-node_mem_map	2005-03-25 08:28:26.000000000 -0800
+++ memhotplug-dave/include/linux/mmzone.h	2005-03-25 08:28:26.000000000 -0800
@@ -267,6 +267,8 @@ typedef struct pglist_data {
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
 #define node_spanned_pages(nid)	(NODE_DATA(nid)->node_spanned_pages)
+#define pgdat_page_nr(pgdat, pagenr)	((pgdat)->node_mem_map + (pagenr))
+#define nid_page_nr(nid, pagenr) 	pgdat_page_nr(NODE_DATA(nid),(pagenr))
 
 extern struct pglist_data *pgdat_list;
 
diff -puN mm/page_alloc.c~A1-no-node_mem_map mm/page_alloc.c
_
