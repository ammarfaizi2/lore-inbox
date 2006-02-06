Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWBFKsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWBFKsP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWBFKsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:48:14 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15293 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751065AbWBFKsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:48:14 -0500
Message-ID: <43E729AB.7090201@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 19:49:15 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [2/25] alpha page_to_pfn / pfn_to_page
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drop alpha's page_to_pfn/pfn_to_page().

When Discontigmem :
Original pfn_to_page looks complicated. it used
pa_to_nid(__pa(__va(pfn << PAGE_SHIFT))),but it is same to pfn_to_nid(pfn).

local_mapnr(__va((pfn) << PAGE_SHIFT) was
__pa (__va(pfn) << PAGE_SHIFT)) >> PAGE_SHIFT - NODE_DATA(nid)->node_start_pfn.
but it is equivalent to  pfn - NODE_DATA(nid)->node_start_pfn.

Alpha seems to be able to use generic ones.
Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-alpha/mmzone.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-alpha/mmzone.h
+++ cleanup_pfn_page/include/asm-alpha/mmzone.h
@@ -59,8 +59,6 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p,
  #define kvaddr_to_nid(kaddr)	pa_to_nid(__pa(kaddr))
  #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)

-#define local_mapnr(kvaddr) \
-      ((__pa(kvaddr) >> PAGE_SHIFT) - node_start_pfn(kvaddr_to_nid(kvaddr)))

  /*
   * Given a kaddr, LOCAL_BASE_ADDR finds the owning node of the memory
@@ -104,15 +102,6 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p,
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

  #define page_to_pa(page)						\
  	((( (page) - page_zone(page)->zone_mem_map )			\
@@ -125,6 +114,9 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p,

  #define virt_addr_valid(kaddr)	pfn_valid((__pa(kaddr) >> PAGE_SHIFT))

+
+#define arch_pfn_to_nid(pfn)	pfn_to_nid(pfn)
+
  #endif /* CONFIG_DISCONTIGMEM */

  #endif /* _ASM_MMZONE_H_ */
Index: cleanup_pfn_page/include/asm-alpha/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-alpha/page.h
+++ cleanup_pfn_page/include/asm-alpha/page.h
@@ -85,8 +85,6 @@ typedef unsigned long pgprot_t;
  #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
  #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
  #ifndef CONFIG_DISCONTIGMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

  #define pfn_valid(pfn)		((pfn) < max_mapnr)

