Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWBFKpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWBFKpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWBFKpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:45:17 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:61421 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751036AbWBFKpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:45:16 -0500
Message-ID: <43E72901.2080103@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 19:46:25 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [1/25] generic page_to_pfn / pfn_to_page
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3 memory models are now available, memmaps of 3 models are defined as

FLATMEM      --- pfn = (page - mem_map) + offset
DISCONTIGMEM --- pfn = (page - page_node(page)->node_mem_map) +
                           (page_node(page)->node_start_pfn)
SPARSEMEM    --- see linux/mmzone.h , generic ones are defined.

Now, each arch has its own page_to_pfn()/pfn_to_page() on FLATMEM/DISCONTIGIMEM.
But most of them keeps above assumptions and looks same to i386's ones.

This patch unifies each arch's page_to_pfn/pfn_to_page to generic ones.
This patch is against 2.6.16-rc2.

comments ?

-- Kame

This patch defines generic page_to_pfn()/pfn_to_page().
For DISCONTIGMEM, page_to_pfn/pfn_to_page are not inlined.
(x86_64 already has not-inlined version and it reduces text size.)

If FLATMEM and memmap <-> pfn translation needs offset,
ARCH_PFN_OFFSET is defined by each archs.

If DISCONTIGMEM , each arch defines arch_pfn_to_nid().
If necessary, arch_local_map_nr(pfn, nid) is also defined.
arch_local_map_nr() calculates page offset in a node.

Signed-Off-By: KAMEZAWA Hiruyoki <kamezawa.hiroyu@jp.fujitu.com>


Index: cleanup_pfn_page/include/linux/mm.h
===================================================================
--- cleanup_pfn_page.orig/include/linux/mm.h
+++ cleanup_pfn_page/include/linux/mm.h
@@ -512,6 +512,32 @@ static inline void set_page_links(struct
  extern struct page *mem_map;
  #endif

+#if !defined(ARCH_HAS_PFN_PAGE) && !defined(CONFIG_SPARSEMEM)
+#if CONFIG_FLATMEM
+
+#ifndef ARCH_PFN_OFFSET
+#define ARCH_PFN_OFFSET	0
+#endif
+static inline unsigned long page_to_pfn(struct page *page)
+{
+	return (unsigned long)(page - mem_map) + ARCH_PFN_OFFSET;
+}
+static inline struct page *pfn_to_page(unsigned long pfn)
+{
+	return mem_map + (pfn - ARCH_PFN_OFFSET);
+}
+#endif /* CONFIG_FLATMEM */
+#ifdef CONFIG_DISCONTIGMEM
+/* arch_pfn_to_nid/arch_local_map_nr is defined if necesary */
+#ifndef arch_local_map_nr
+#define arch_local_map_nr(pfn ,nid)	((pfn) - NODE_DATA(nid)->node_start_pfn)
+#endif
+extern unsigned long page_to_pfn(struct page *page);
+extern struct page* pfn_to_page(unsigned long pfn);
+#endif /* CONFIG_DISCONTIGMEM */
+
+#endif
+
  static __always_inline void *lowmem_page_address(struct page *page)
  {
  	return __va(page_to_pfn(page) << PAGE_SHIFT);
Index: cleanup_pfn_page/mm/page_alloc.c
===================================================================
--- cleanup_pfn_page.orig/mm/page_alloc.c
+++ cleanup_pfn_page/mm/page_alloc.c
@@ -85,6 +85,25 @@ int min_free_kbytes = 1024;
  unsigned long __initdata nr_kernel_pages;
  unsigned long __initdata nr_all_pages;

+#if defined(CONFIG_DISCONTIGMEM) && !defined(CONFIG_VIRTUAL_MEM_MAP)
+
+struct page *pfn_to_page(unsigned long pfn)
+{
+	struct pglist_data *pgdat;
+	int nid = arch_pfn_to_nid(pfn);
+	pgdat = NODE_DATA(nid);
+	return pgdat->node_mem_map + arch_local_map_nr(pfn, nid);
+}
+EXPORT_SYMBOL(pfn_to_page);
+
+unsigned long page_to_pfn(struct page *page)
+{
+	struct zone *z = page_zone(page);
+	return z->zone_start_pfn + (unsigned long)(page - z->zone_mem_map);
+}
+EXPORT_SYMBOL(page_to_pfn);
+#endif
+
  #ifdef CONFIG_DEBUG_VM
  static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
  {


