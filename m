Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030524AbWBNKcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbWBNKcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbWBNKcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:32:18 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:28545 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030524AbWBNKcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:32:17 -0500
Message-ID: <43F1B1DD.7030707@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:33:01 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] unify pfn_to_page take3 [11/23] m32r pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m32r can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-m32r/mmzone.h
===================================================================
--- testtree.orig/include/asm-m32r/mmzone.h
+++ testtree/include/asm-m32r/mmzone.h
@@ -21,20 +21,6 @@ extern struct pglist_data *node_data[];
  	__pgdat->node_start_pfn + __pgdat->node_spanned_pages - 1;	\
  })

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
  #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
  /*
   * pfn_valid should be made as fast as possible, and the current definition
Index: testtree/include/asm-m32r/page.h
===================================================================
--- testtree.orig/include/asm-m32r/page.h
+++ testtree/include/asm-m32r/page.h
@@ -76,9 +76,7 @@ typedef struct { unsigned long pgprot; }

  #ifndef CONFIG_DISCONTIGMEM
  #define PFN_BASE		(CONFIG_MEMORY_START >> PAGE_SHIFT)
-#define pfn_to_page(pfn)	(mem_map + ((pfn) - PFN_BASE))
-#define page_to_pfn(page)	\
-	((unsigned long)((page) - mem_map) + PFN_BASE)
+#define ARCH_PFN_OFFSET		PFN_BASE
  #define pfn_valid(pfn)		(((pfn) - PFN_BASE) < max_mapnr)
  #endif  /* !CONFIG_DISCONTIGMEM */

@@ -92,6 +90,7 @@ typedef struct { unsigned long pgprot; }

  #endif /* __KERNEL__ */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _ASM_M32R_PAGE_H */

