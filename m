Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030533AbWBHFkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbWBHFkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030532AbWBHFkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:40:05 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54205 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030533AbWBHFkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:40:03 -0500
Message-ID: <43E98482.2090305@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 14:41:22 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] unify pfn_to_page take 2 [1/25] generic funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Definitions of pfn_to_page/page_to_pfn are defined in each arch's include files.
But most of them just do the same thing.
This patch consolidates all definitions to generic one.

Changelog: v1->v2
  - linux/memory_model.h is added. this defines pfn<->page translation.
  - new config options (set by arch) CONFIG_DONT_INLINE_PFN_TO_PAGE
    and CONFIG_ARCH_HAS_PFN_TO_PAGE are added.
  - SPARSEMEM's page_to_pfn is moved to linux/memory_model.h

-- Kame.

This patch adds generci pfn_to_page/page_to_pfn definition.

Now, each arch has its own page_to_pfn/pfn_to_page. But most of them
do the same arithmatic. And I think this arithmatic is defined by memory model,
not by architecture.

3 types of arithmatic is defined in linux/memory_model.h.

New configs are added.
CONFIG_ARCH_HASH_PFN_TO_PAGE ..... for arch which uses *unusual* memory model.
                                    (see m68k..)
CONFIG_DONT_INLINE_PFN_TO_PAGE ... for achh which doesn't want to make these
				   funcs inlined. (for sparc64, x86_64, maybe
  				   making good result for some other archs.)

Helper macro ARCH_PFN_OFFSET, arch_pfn_to_nid, arch_local_pfn_offset()
are also added.

Signed-Off-BY: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/linux/memory_model.h
===================================================================
--- /dev/null
+++ test-layout-free-zone/include/linux/memory_model.h
@@ -0,0 +1,88 @@
+#ifndef __LINUX_MEMORY_MODEL_H
+#define __LINUX_MEMORY_MODEL_H
+/*
+ * pfn <-> page struct arithmatic for each memory model.
+ *
+ * 3 memory models are supported.
+ *
+ * FLATMEM      --  pfn = (page - mem_map) + offset
+ *                  page struct is contigous to max_pfn.
+ * DISCONTIGMEM --  pfn = (page - node->node_mem_map) + node->node_start_pfn.
+ *                  page struct is contigous within each node.
+ * SPARSEMEM    --  pfn = pfn_to_section(page_to_section(page)) + offset in section.
+ *                  page struct is contigous in each section.
+ */
+
+#ifndef CONFIG_ARCH_HAS_PFN_TO_PAGE
+/*
+ * some arch defines helper macro if necessary.
+ */
+/* used by FLATMEM */
+#ifndef ARCH_PFN_OFFSET
+#define ARCH_PFN_OFFSET (0UL)
+#endif
+
+/* used by DISCONTIGMEM */
+#ifndef arch_pfn_to_nid
+#define arch_pfn_to_nid(pfn)	pfn_to_nid((pfn))
+#endif
+
+#ifndef arch_local_pfn_offset
+#define arch_local_pfn_offset(pfn, nid) ((pfn) - NODE_DATA((nid))->node_start_pfn)
+#endif
+
+#ifdef CONFIG_DONT_INLINE_PFN_TO_PAGE
+
+/* not-inlined version for some archs. funcs are defined in mm/page_alloc.c */
+extern unsigned long page_to_pfn(struct page *page);
+extern struct page *pfn_to_page(unsigned long pfn);
+
+#else
+
+#if defined(CONFIG_FLATMEM)
+
+static inline unsigned long page_to_pfn(struct page *page)
+{
+	return (unsigned long)(page - mem_map) + ARCH_PFN_OFFSET;
+}
+
+static inline struct page *pfn_to_page(unsigned long pfn)
+{
+	return mem_map + (pfn - ARCH_PFN_OFFSET);
+}
+
+#elif defined(CONFIG_DISCONTIGMEM)
+
+static inline unsigned long page_to_pfn(struct page *page)
+{
+	struct zone *z = page_zone(page)
+	return (unsigned long)(page - z->zone_mem_map) + z->zone_start_pfn;
+}
+
+static inline struct page *pfn_to_page(unsigned long pfn)
+{
+	int nid = arch_pfn_to_nid(pfn);
+	struct pglist_data *pgdat = NODE_DATA(nid);
+	return pgdat->node_mem_map + arch_local_pfn_offset(pfn, nid);
+}
+
+#elif defined(CONFIG_SPARSEMEM)
+
+static inline unsigned long page_to_pfn(struct page *page)
+{
+	long section_id = page_to_section(page);
+	return page - __section_mem_map_addr(__nr_to_section(section_id));
+}
+
+static inline struct page * pfn_to_page(unsigned long pfn)
+{
+	return __section_mem_map_addr(__pfn_to_section(pfn)) + pfn;
+}
+
+#endif /* CONFIG_FLATMEM/DISCONTIGMEM/SPARSEMEM */
+
+#endif /* CONFIG_DONT_INLINE_PFN_TO_PAGE */
+
+#endif /* CONFIG_ARCH_HAS_PFN_TO_PAGE */
+
+#endif /* __LINUX_MEMORY_MODEL_H */
Index: test-layout-free-zone/include/linux/mmzone.h
===================================================================
--- test-layout-free-zone.orig/include/linux/mmzone.h
+++ test-layout-free-zone/include/linux/mmzone.h
@@ -602,16 +602,6 @@ static inline struct mem_section *__pfn_
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

  static inline int pfn_valid(unsigned long pfn)
  {
Index: test-layout-free-zone/mm/page_alloc.c
===================================================================
--- test-layout-free-zone.orig/mm/page_alloc.c
+++ test-layout-free-zone/mm/page_alloc.c
@@ -85,6 +85,55 @@ int min_free_kbytes = 1024;
  unsigned long __initdata nr_kernel_pages;
  unsigned long __initdata nr_all_pages;

+/*
+ *  page <-> pfn translation, not-inlined ver. (see linux/memory_model.h)
+ */
+#ifdef CONFIG_DONT_INLINE_PFN_TO_PAGE
+#if defined(CONFIG_FLATMEM)
+
+unsigned long page_to_pfn(struct page *page)
+{
+	return (unsigned long)(page - mem_map) + ARCH_PFN_OFFSET;
+}
+
+static inline struct page *pfn_to_page(unsigned long pfn)
+{
+	return mem_map + (pfn - ARCH_PFN_OFFSET);
+}
+
+#elif defined (CONFIG_DISCONTIGMEM)
+
+unsigned long page_to_pfn(struct page *page)
+{
+	struct zone *z = page_zone(page)
+	return (unsigned long)(page - z->zone_mem_map) + z->zone_start_pfn;
+}
+
+struct page *pfn_to_page(unsigned long pfn)
+{
+	int nid = arch_pfn_to_nid(pfn);
+	struct pglist_data *pgdat = NODE_DATA(nid);
+	return pgdat->node_mem_map + arch_local_pfn_offset(pfn, nid);
+}
+
+#elif defined (CONFIG_SPARSEMEM)
+
+static inline unsigned long page_to_pfn(struct page *page)
+{
+	long section_id = page_to_section(page);
+	return page - __section_mem_map_addr(__nr_to_section(section_id));
+}
+
+static inline struct page * pfn_to_page(unsigned long pfn)
+{
+	return __section_mem_map_addr(__pfn_to_section(pfn)) + pfn;
+}
+#endif
+
+EXPORT_SYMBOL(pfn_to_page);
+EXPORT_SYMBOL(page_to_pfn);
+#endif
+
  #ifdef CONFIG_DEBUG_VM
  static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
  {
Index: test-layout-free-zone/include/linux/mm.h
===================================================================
--- test-layout-free-zone.orig/include/linux/mm.h
+++ test-layout-free-zone/include/linux/mm.h
@@ -512,6 +512,9 @@ static inline void set_page_links(struct
  extern struct page *mem_map;
  #endif

+/* include pfn <-> page struct arithmatic for each memory model */
+#include <linux/memory_model.h>
+
  static __always_inline void *lowmem_page_address(struct page *page)
  {
  	return __va(page_to_pfn(page) << PAGE_SHIFT);



