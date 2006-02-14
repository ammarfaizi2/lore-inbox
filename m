Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030543AbWBNJzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030543AbWBNJzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030545AbWBNJzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:55:32 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:59603 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030543AbWBNJzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:55:31 -0500
Message-ID: <43F1A94F.1060809@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 18:56:31 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] unify pfn_to_page take3 [2/23] i386 pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-i386/mmzone.h
===================================================================
--- testtree.orig/include/asm-i386/mmzone.h
+++ testtree/include/asm-i386/mmzone.h
@@ -70,8 +70,6 @@ static inline int pfn_to_nid(unsigned lo
  #endif
  }

-#define node_localnr(pfn, nid)		((pfn) - node_data[nid]->node_start_pfn)
-
  /*
   * Following are macros that each numa implmentation must define.
   */
@@ -86,21 +84,6 @@ static inline int pfn_to_nid(unsigned lo
  /* XXX: FIXME -- wli */
  #define kern_addr_valid(kaddr)	(0)

-#define pfn_to_page(pfn)						\
-({									\
-	unsigned long __pfn = pfn;					\
-	int __node  = pfn_to_nid(__pfn);				\
-	&NODE_DATA(__node)->node_mem_map[node_localnr(__pfn,__node)];	\
-})
-
-#define page_to_pfn(pg)							\
-({									\
-	struct page *__page = pg;					\
-	struct zone *__zone = page_zone(__page);			\
-	(unsigned long)(__page - __zone->zone_mem_map)			\
-		+ __zone->zone_start_pfn;				\
-})
-
  #ifdef CONFIG_X86_NUMAQ            /* we have contiguous memory on NUMA-Q */
  #define pfn_valid(pfn)          ((pfn) < num_physpages)
  #else
Index: testtree/include/asm-i386/page.h
===================================================================
--- testtree.orig/include/asm-i386/page.h
+++ testtree/include/asm-i386/page.h
@@ -126,8 +126,6 @@ extern int page_is_ram(unsigned long pag
  #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
  #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
  #ifdef CONFIG_FLATMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif /* CONFIG_FLATMEM */
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
@@ -141,6 +139,7 @@ extern int page_is_ram(unsigned long pag

  #endif /* __KERNEL__ */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _I386_PAGE_H */

