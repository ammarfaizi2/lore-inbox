Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030538AbWBHFpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbWBHFpW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbWBHFpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:45:22 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:6852 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030538AbWBHFpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:45:21 -0500
Message-ID: <43E985BB.9020901@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 14:46:35 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andi Kleen <ak@suse.de>
Subject: [PATCH] unify pfn_to_page take 2 [3/25] x86_64 funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 can use generic one.
When DISCONTIGMEM is selected, CONFIG_DONT_INLINE_PFN_TO_PAGE=y.
pfn_to_page/page_to_pfn are not inlined.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/arch/x86_64/mm/numa.c
===================================================================
--- test-layout-free-zone.orig/arch/x86_64/mm/numa.c
+++ test-layout-free-zone/arch/x86_64/mm/numa.c
@@ -362,28 +362,6 @@ EXPORT_SYMBOL(memnodemap);
  EXPORT_SYMBOL(node_data);

  #ifdef CONFIG_DISCONTIGMEM
-/*
- * Functions to convert PFNs from/to per node page addresses.
- * These are out of line because they are quite big.
- * They could be all tuned by pre caching more state.
- * Should do that.
- */
-
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
Index: test-layout-free-zone/include/asm-x86_64/mmzone.h
===================================================================
--- test-layout-free-zone.orig/include/asm-x86_64/mmzone.h
+++ test-layout-free-zone/include/asm-x86_64/mmzone.h
@@ -39,8 +39,6 @@ static inline __attribute__((pure)) int
  #define pfn_to_nid(pfn) phys_to_nid((unsigned long)(pfn) << PAGE_SHIFT)
  #define kvaddr_to_nid(kaddr)	phys_to_nid(__pa(kaddr))

-extern struct page *pfn_to_page(unsigned long pfn);
-extern unsigned long page_to_pfn(struct page *page);
  extern int pfn_valid(unsigned long pfn);
  #endif

Index: test-layout-free-zone/include/asm-x86_64/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-x86_64/page.h
+++ test-layout-free-zone/include/asm-x86_64/page.h
@@ -123,8 +123,6 @@ typedef struct { unsigned long pgprot; }
  #define __boot_va(x)		__va(x)
  #define __boot_pa(x)		__pa(x)
  #ifdef CONFIG_FLATMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < end_pfn)
  #endif

Index: test-layout-free-zone/arch/x86_64/Kconfig
===================================================================
--- test-layout-free-zone.orig/arch/x86_64/Kconfig
+++ test-layout-free-zone/arch/x86_64/Kconfig
@@ -321,6 +321,10 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
  	def_bool y
  	depends on NUMA

+config DONT_INLINE_PFN_TO_PAGE
+	def_bool y
+	depends on DISCONTIGMEM
+
  config NR_CPUS
  	int "Maximum number of CPUs (2-256)"
  	range 2 256

