Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbWBHFtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbWBHFtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbWBHFtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:49:52 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:7625 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030542AbWBHFtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:49:51 -0500
Message-ID: <43E986B6.2080203@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 14:50:46 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: rth@twiddle.net, ink@jurassic.park.msu.ru
Subject: PATCH] unify pfn_to_page take 2 [5/25] alpha funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha can use generic pfn_to_page definition.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-alpha/mmzone.h
===================================================================
--- test-layout-free-zone.orig/include/asm-alpha/mmzone.h
+++ test-layout-free-zone/include/asm-alpha/mmzone.h
@@ -104,19 +104,8 @@ PLAT_NODE_DATA_LOCALNR(unsigned long p,
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
Index: test-layout-free-zone/include/asm-alpha/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-alpha/page.h
+++ test-layout-free-zone/include/asm-alpha/page.h
@@ -85,8 +85,6 @@ typedef unsigned long pgprot_t;
  #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
  #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
  #ifndef CONFIG_DISCONTIGMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

  #define pfn_valid(pfn)		((pfn) < max_mapnr)

