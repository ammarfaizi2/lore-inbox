Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030544AbWBNJ5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030544AbWBNJ5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbWBNJ5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:57:50 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56278 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030544AbWBNJ5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:57:50 -0500
Message-ID: <43F1A9DB.1000604@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 18:58:51 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] unify pfn_to_page take3 [3/23] x86_64 pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 can use generic funcs.
For DISCONTIGMEM, CONFIG_OUT_OF_LINE_PFN_TO_PAGE is selected.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/arch/x86_64/mm/numa.c
===================================================================
--- testtree.orig/arch/x86_64/mm/numa.c
+++ testtree/arch/x86_64/mm/numa.c
@@ -369,21 +369,6 @@ EXPORT_SYMBOL(node_data);
   * Should do that.
   */

-/* Requires pfn_valid(pfn) to be true */
-struct page *pfn_to_page(unsigned long pfn)
-{
-	int nid = phys_to_nid(((unsigned long)(pfn)) << PAGE_SHIFT);
-	return (pfn - node_start_pfn(nid)) + NODE_DATA(nid)->node_mem_map;
-}
-EXPORT_SYMBOL(pfn_to_page);
-
-unsigned long page_to_pfn(struct page *page)
-{
-	return (long)(((page) - page_zone(page)->zone_mem_map) +
-		      page_zone(page)->zone_start_pfn);
-}
-EXPORT_SYMBOL(page_to_pfn);
-
  int pfn_valid(unsigned long pfn)
  {
  	unsigned nid;
Index: testtree/include/asm-x86_64/mmzone.h
===================================================================
--- testtree.orig/include/asm-x86_64/mmzone.h
+++ testtree/include/asm-x86_64/mmzone.h
@@ -39,12 +39,8 @@ static inline __attribute__((pure)) int
  #define pfn_to_nid(pfn) phys_to_nid((unsigned long)(pfn) << PAGE_SHIFT)
  #define kvaddr_to_nid(kaddr)	phys_to_nid(__pa(kaddr))

-extern struct page *pfn_to_page(unsigned long pfn);
-extern unsigned long page_to_pfn(struct page *page);
  extern int pfn_valid(unsigned long pfn);
  #endif

-#define local_mapnr(kvaddr) \
-	( (__pa(kvaddr) >> PAGE_SHIFT) - node_start_pfn(kvaddr_to_nid(kvaddr)) )
  #endif
  #endif
Index: testtree/include/asm-x86_64/page.h
===================================================================
--- testtree.orig/include/asm-x86_64/page.h
+++ testtree/include/asm-x86_64/page.h
@@ -123,8 +123,6 @@ typedef struct { unsigned long pgprot; }
  #define __boot_va(x)		__va(x)
  #define __boot_pa(x)		__pa(x)
  #ifdef CONFIG_FLATMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < end_pfn)
  #endif

@@ -140,6 +138,7 @@ typedef struct { unsigned long pgprot; }

  #endif /* __KERNEL__ */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _X86_64_PAGE_H */
Index: testtree/arch/x86_64/Kconfig
===================================================================
--- testtree.orig/arch/x86_64/Kconfig
+++ testtree/arch/x86_64/Kconfig
@@ -321,6 +321,10 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
  	def_bool y
  	depends on NUMA

+config OUT_OF_LINE_PFN_TO_PAGE
+	def_bool y
+	depends on DISCONTIGMEM
+
  config NR_CPUS
  	int "Maximum number of CPUs (2-256)"
  	range 2 256

