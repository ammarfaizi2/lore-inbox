Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbWBNJxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbWBNJxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030542AbWBNJxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:53:51 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:22169 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030541AbWBNJxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:53:50 -0500
Message-ID: <43F1A8EC.6000405@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 18:54:52 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH] unify pfn_to_page take3 [1/23] generic functions
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 memory models, FLATMEM, DISCONTIGMEM, SPARSEMEM.
Each arch defines its own page_to_pfn(), pfn_to_page() for each models.
But most of them can use the same function.

This patch adds asm-generic/memory_model.h, which defines generic
page_to_pfn(), pfn_to_page() for each memory model.

When CONFIG_OUT_OF_LINE_PFN_TO_PAGE=y, out-of-line functions are
used instead of macro. This is enabled by some archs and  reduces
text size.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-generic/memory_model.h
===================================================================
--- /dev/null
+++ testtree/include/asm-generic/memory_model.h
@@ -0,0 +1,77 @@
+#ifndef __ASM_MEMORY_MODEL_H
+#define __ASM_MEMORY_MODEL_H
+
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+
+#if defined(CONFIG_FLATMEM)
+
+#ifndef ARCH_PFN_OFFSET
+#define ARCH_PFN_OFFSET		(0UL)
+#endif
+
+#elif defined(CONFIG_DISCONTIGMEM)
+
+#ifndef arch_pfn_to_nid
+#define arch_pfn_to_nid(pfn)	pfn_to_nid(pfn)
+#endif
+
+#ifndef arch_local_page_offset
+#define arch_local_page_offset(pfn, nid)	\
+	((pfn) - NODE_DATA(nid)->node_start_pfn)
+#endif
+
+#endif /* CONFIG_DISCONTIGMEM */
+
+#ifdef CONFIG_OUT_OF_LINE_PFN_TO_PAGE
+struct page;
+/* this is useful when inlined pfn_to_page is too big */
+extern struct page *pfn_to_page(unsigned long pfn);
+extern unsigned long page_to_pfn(struct page *page);
+#else
+/*
+ * supports 3 memory models.
+ */
+#if defined(CONFIG_FLATMEM)
+
+#define pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
+#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
+				 ARCH_PFN_OFFSET)
+#elif defined(CONFIG_DISCONTIGMEM)
+
+#define pfn_to_page(pfn)			\
+({	unsigned long __pfn = (pfn);		\
+	unsigned long __nid = arch_pfn_to_nid(pfn);  \
+	NODE_DATA(__nid)->node_mem_map + arch_local_page_offset(__pfn, __nid);\
+})
+
+#define page_to_pfn(pg)			\
+({	struct page *__pg = (pg);		\
+	struct zone *__zone = page_zone(__pg);	\
+	(unsigned long)(__pg - __zone->zone_mem_map) +	\
+	 __zone->zone_start_pfn;			\
+})
+
+#elif defined(CONFIG_SPARSEMEM)
+/*
+ * Note: section's mem_map is encorded to reflect its start_pfn.
+ * section[i].section_mem_map == mem_map's address - start_pfn;
+ */
+#define page_to_pfn(pg)					\
+({	struct page *__pg = (pg);				\
+	int __sec = page_to_section(__pg);			\
+	__pg - __section_mem_map_addr(__nr_to_section(__sec));	\
+})
+
+#define pfn_to_page(pfn)				\
+({	unsigned long __pfn = (pfn);			\
+	struct mem_section *__sec = __pfn_to_section(__pfn);	\
+	__section_mem_map_addr(__sec) + __pfn;		\
+})
+#endif /* CONFIG_FLATMEM/DISCONTIGMEM/SPARSEMEM */
+#endif /* CONFIG_OUT_OF_LINE_PFN_TO_PAGE */
+
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL__ */
+
+#endif
Index: testtree/include/linux/mmzone.h
===================================================================
--- testtree.orig/include/linux/mmzone.h
+++ testtree/include/linux/mmzone.h
@@ -602,17 +602,6 @@ static inline struct mem_section *__pfn_
  	return __nr_to_section(pfn_to_section_nr(pfn));
  }

-#define pfn_to_page(pfn) 						\
-({ 									\
-	unsigned long __pfn = (pfn);					\
-	__section_mem_map_addr(__pfn_to_section(__pfn)) + __pfn;	\
-})
-#define page_to_pfn(page)						\
-({									\
-	page - __section_mem_map_addr(__nr_to_section(			\
-		page_to_section(page)));				\
-})
-
  static inline int pfn_valid(unsigned long pfn)
  {
  	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
Index: testtree/mm/page_alloc.c
===================================================================
--- testtree.orig/mm/page_alloc.c
+++ testtree/mm/page_alloc.c
@@ -2726,3 +2726,45 @@ void *__init alloc_large_system_hash(con

  	return table;
  }
+
+#ifdef CONFIG_OUT_OF_LINE_PFN_TO_PAGE
+/*
+ * pfn <-> page translation. out-of-line version.
+ * (see asm-generic/memory_model.h)
+ */
+#if defined(CONFIG_FLATMEM)
+struct page *pfn_to_page(unsigned long pfn)
+{
+	return mem_map + (pfn - ARCH_PFN_OFFSET);
+}
+unsigned long page_to_pfn(struct page *page)
+{
+	return (page - mem_map) + ARCH_PFN_OFFSET;
+}
+#elif defined(CONFIG_DISCONTIGMEM)
+struct page *pfn_to_page(unsigned long pfn)
+{
+	int nid = arch_pfn_to_nid(pfn);
+	return NODE_DATA(nid)->node_mem_map + arch_local_page_offset(pfn,nid);
+}
+unsigned long page_to_pfn(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	return (page - zone->zone_mem_map) + zone->zone_start_pfn;
+
+}
+#elif defined(CONFIG_SPARSEMEM)
+struct page *pfn_to_page(unsigned long pfn)
+{
+	return __section_mem_map_addr(__pfn_to_section(pfn)) + pfn;
+}
+
+unsigned long page_to_pfn(struct page *page)
+{
+	long section_id = page_to_section(page);
+	return page - __section_mem_map_addr(__nr_to_section(section_id));
+}
+#endif /* CONFIG_FLATMEM/DISCONTIGMME/SPARSEMEM */
+EXPORT_SYMBOL(pfn_to_page);
+EXPORT_SYMBOL(page_to_pfn);
+#endif /* CONFIG_OUT_OF_LINE_PFN_TO_PAGE */


