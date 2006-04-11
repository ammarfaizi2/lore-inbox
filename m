Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWDKTpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWDKTpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWDKTpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:45:51 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:24024
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750864AbWDKTpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:45:50 -0400
Date: Tue, 11 Apr 2006 20:45:39 +0100
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] squash duplicate page_to_pfn and pfn_to_page
Message-ID: <20060411194539.GA2507@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

squash duplicate page_to_pfn and pfn_to_page

We have architectures where the size of page_to_pfn and pfn_to_page
are significant enough to overall image size that they wish to
push them out of line.  However, in the process we have grown
a second copy of the implementation of each of these routines
for each memory model.  Share the implmentation exposing it either
inline or out-of-line as required.

Tested on a range of test boxes with various memory models.  Against
2.6.17-rc1-mm2.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 include/asm-generic/memory_model.h |   27 +++++++++++++++------------
 mm/page_alloc.c                    |   32 ++------------------------------
 2 files changed, 17 insertions(+), 42 deletions(-)
diff -upN reference/include/asm-generic/memory_model.h current/include/asm-generic/memory_model.h
--- reference/include/asm-generic/memory_model.h
+++ current/include/asm-generic/memory_model.h
@@ -23,29 +23,23 @@
 
 #endif /* CONFIG_DISCONTIGMEM */
 
-#ifdef CONFIG_OUT_OF_LINE_PFN_TO_PAGE
-struct page;
-/* this is useful when inlined pfn_to_page is too big */
-extern struct page *pfn_to_page(unsigned long pfn);
-extern unsigned long page_to_pfn(struct page *page);
-#else
 /*
  * supports 3 memory models.
  */
 #if defined(CONFIG_FLATMEM)
 
-#define pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
+#define __pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
+#define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
 				 ARCH_PFN_OFFSET)
 #elif defined(CONFIG_DISCONTIGMEM)
 
-#define pfn_to_page(pfn)			\
+#define __pfn_to_page(pfn)			\
 ({	unsigned long __pfn = (pfn);		\
 	unsigned long __nid = arch_pfn_to_nid(pfn);  \
 	NODE_DATA(__nid)->node_mem_map + arch_local_page_offset(__pfn, __nid);\
 })
 
-#define page_to_pfn(pg)							\
+#define __page_to_pfn(pg)						\
 ({	struct page *__pg = (pg);					\
 	struct pglist_data *__pgdat = NODE_DATA(page_to_nid(__pg));	\
 	(unsigned long)(__pg - __pgdat->node_mem_map) +			\
@@ -57,18 +51,27 @@ extern unsigned long page_to_pfn(struct 
  * Note: section's mem_map is encorded to reflect its start_pfn.
  * section[i].section_mem_map == mem_map's address - start_pfn;
  */
-#define page_to_pfn(pg)					\
+#define __page_to_pfn(pg)					\
 ({	struct page *__pg = (pg);				\
 	int __sec = page_to_section(__pg);			\
 	__pg - __section_mem_map_addr(__nr_to_section(__sec));	\
 })
 
-#define pfn_to_page(pfn)				\
+#define __pfn_to_page(pfn)				\
 ({	unsigned long __pfn = (pfn);			\
 	struct mem_section *__sec = __pfn_to_section(__pfn);	\
 	__section_mem_map_addr(__sec) + __pfn;		\
 })
 #endif /* CONFIG_FLATMEM/DISCONTIGMEM/SPARSEMEM */
+
+#ifdef CONFIG_OUT_OF_LINE_PFN_TO_PAGE
+struct page;
+/* this is useful when inlined pfn_to_page is too big */
+extern struct page *pfn_to_page(unsigned long pfn);
+extern unsigned long page_to_pfn(struct page *page);
+#else
+#define page_to_pfn __page_to_pfn
+#define pfn_to_page __pfn_to_page
 #endif /* CONFIG_OUT_OF_LINE_PFN_TO_PAGE */
 
 #endif /* __ASSEMBLY__ */
diff -upN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c
+++ current/mm/page_alloc.c
@@ -2861,42 +2861,14 @@ void *__init alloc_large_system_hash(con
 }
 
 #ifdef CONFIG_OUT_OF_LINE_PFN_TO_PAGE
-/*
- * pfn <-> page translation. out-of-line version.
- * (see asm-generic/memory_model.h)
- */
-#if defined(CONFIG_FLATMEM)
 struct page *pfn_to_page(unsigned long pfn)
 {
-	return mem_map + (pfn - ARCH_PFN_OFFSET);
+	return __pfn_to_page(pfn);
 }
 unsigned long page_to_pfn(struct page *page)
 {
-	return (page - mem_map) + ARCH_PFN_OFFSET;
+	return __page_to_pfn(page);
 }
-#elif defined(CONFIG_DISCONTIGMEM)
-struct page *pfn_to_page(unsigned long pfn)
-{
-	int nid = arch_pfn_to_nid(pfn);
-	return NODE_DATA(nid)->node_mem_map + arch_local_page_offset(pfn,nid);
-}
-unsigned long page_to_pfn(struct page *page)
-{
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
-	return (page - pgdat->node_mem_map) + pgdat->node_start_pfn;
-}
-#elif defined(CONFIG_SPARSEMEM)
-struct page *pfn_to_page(unsigned long pfn)
-{
-	return __section_mem_map_addr(__pfn_to_section(pfn)) + pfn;
-}
-
-unsigned long page_to_pfn(struct page *page)
-{
-	long section_id = page_to_section(page);
-	return page - __section_mem_map_addr(__nr_to_section(section_id));
-}
-#endif /* CONFIG_FLATMEM/DISCONTIGMME/SPARSEMEM */
 EXPORT_SYMBOL(pfn_to_page);
 EXPORT_SYMBOL(page_to_pfn);
 #endif /* CONFIG_OUT_OF_LINE_PFN_TO_PAGE */
