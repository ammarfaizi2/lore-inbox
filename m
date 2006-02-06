Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWBFLTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWBFLTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWBFLTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:19:04 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:20456 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750770AbWBFLTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:19:03 -0500
Message-ID: <43E730EB.7070608@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:20:11 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [22/25]  x86_64 pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-x86_64/mmzone.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-x86_64/mmzone.h
+++ cleanup_pfn_page/include/asm-x86_64/mmzone.h
@@ -38,9 +38,7 @@ static inline __attribute__((pure)) int
  #ifdef CONFIG_DISCONTIGMEM
  #define pfn_to_nid(pfn) phys_to_nid((unsigned long)(pfn) << PAGE_SHIFT)
  #define kvaddr_to_nid(kaddr)	phys_to_nid(__pa(kaddr))
-
-extern struct page *pfn_to_page(unsigned long pfn);
-extern unsigned long page_to_pfn(struct page *page);
+#define arch_pfn_to_nid(pfn)	pfn_to_nid(pfn)
  extern int pfn_valid(unsigned long pfn);
  #endif

Index: cleanup_pfn_page/include/asm-x86_64/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-x86_64/page.h
+++ cleanup_pfn_page/include/asm-x86_64/page.h
@@ -123,8 +123,6 @@ typedef struct { unsigned long pgprot; }
  #define __boot_va(x)		__va(x)
  #define __boot_pa(x)		__pa(x)
  #ifdef CONFIG_FLATMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < end_pfn)
  #endif

Index: cleanup_pfn_page/arch/x86_64/mm/numa.c
===================================================================
--- cleanup_pfn_page.orig/arch/x86_64/mm/numa.c
+++ cleanup_pfn_page/arch/x86_64/mm/numa.c
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

