Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWBNKME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWBNKME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWBNKLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:11:38 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:40423 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030300AbWBNKLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:11:25 -0500
Message-ID: <43F1ACFF.2070702@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:12:15 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, axp-list@redhat.com
Subject: [PATCH] unify pfn_to_page take3 [5/23] alpha pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-alpha/mmzone.h
===================================================================
--- testtree.orig/include/asm-alpha/mmzone.h
+++ testtree/include/asm-alpha/mmzone.h
@@ -59,9 +59,6 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p,
  #define kvaddr_to_nid(kaddr)	pa_to_nid(__pa(kaddr))
  #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)

-#define local_mapnr(kvaddr) \
-      ((__pa(kvaddr) >> PAGE_SHIFT) - node_start_pfn(kvaddr_to_nid(kvaddr)))
-
  /*
   * Given a kaddr, LOCAL_BASE_ADDR finds the owning node of the memory
   * and returns the kaddr corresponding to first physical page in the
@@ -104,19 +101,8 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p,
  	__xx;                                                           \
  })

-#define pfn_to_page(pfn)						\
-({									\
- 	unsigned long kaddr = (unsigned long)__va((pfn) << PAGE_SHIFT);	\
-	(NODE_DATA(kvaddr_to_nid(kaddr))->node_mem_map + local_mapnr(kaddr));	\
-})
-
-#define page_to_pfn(page)						\
-	((page) - page_zone(page)->zone_mem_map +			\
-	 (page_zone(page)->zone_start_pfn))
-
  #define page_to_pa(page)						\
-	((( (page) - page_zone(page)->zone_mem_map )			\
-	+ page_zone(page)->zone_start_pfn) << PAGE_SHIFT)
+	(page_to_pfn(page) << PAGE_SHIFT)

  #define pfn_to_nid(pfn)		pa_to_nid(((u64)(pfn) << PAGE_SHIFT))
  #define pfn_valid(pfn)							\
Index: testtree/include/asm-alpha/page.h
===================================================================
--- testtree.orig/include/asm-alpha/page.h
+++ testtree/include/asm-alpha/page.h
@@ -85,8 +85,6 @@ typedef unsigned long pgprot_t;
  #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
  #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
  #ifndef CONFIG_DISCONTIGMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

  #define pfn_valid(pfn)		((pfn) < max_mapnr)
@@ -95,9 +93,9 @@ typedef unsigned long pgprot_t;

  #define VM_DATA_DEFAULT_FLAGS		(VM_READ | VM_WRITE | VM_EXEC | \
  					 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
-
  #endif /* __KERNEL__ */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _ALPHA_PAGE_H */

