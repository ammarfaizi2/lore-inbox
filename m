Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVAZAcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVAZAcU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVAZAcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:32:03 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:21444 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262265AbVAZAXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:23:43 -0500
Subject: [RFC][PATCH 2/5] consolidate set_max_mapnr_init() implementations
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 25 Jan 2005 16:23:37 -0800
Message-Id: <E1Ctay9-0006lh-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


discontig.c has its own version of set_max_mapnr_init().  However,
all that it really does differently from the mm/init.c version is
skip setting max_mapnr (which doesn't exist because there's no 
mem_map[]).-

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/mm/discontig.c |    9 ---------
 memhotplug-dave/arch/i386/mm/init.c      |   11 +++++++----
 2 files changed, 7 insertions(+), 13 deletions(-)

diff -puN arch/i386/mm/init.c~A1.2-cleanup-set_max_mapnr_init arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~A1.2-cleanup-set_max_mapnr_init	2005-01-25 13:51:03.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/init.c	2005-01-25 14:05:28.000000000 -0800
@@ -567,19 +567,22 @@ static void __init test_wp_bit(void)
 	}
 }
 
-#ifndef CONFIG_DISCONTIGMEM
 static void __init set_max_mapnr_init(void)
 {
 #ifdef CONFIG_HIGHMEM
-	max_mapnr = num_physpages = highend_pfn;
+	num_physpages = highend_pfn;
 #else
-	max_mapnr = num_physpages = max_low_pfn;
+	num_physpages = max_low_pfn;
+#endif
+#ifndef CONFIG_DISCONTIGMEM
+	max_mapnr = num_physpages;
 #endif
 }
+
+#ifndef CONFIG_DISCONTIGMEM
 #define __free_all_bootmem() free_all_bootmem()
 #else
 #define __free_all_bootmem() free_all_bootmem_node(NODE_DATA(0))
-extern void set_max_mapnr_init(void);
 #endif /* !CONFIG_DISCONTIGMEM */
 
 static struct kcore_list kcore_mem, kcore_vmalloc; 
diff -puN arch/i386/mm/discontig.c~A1.2-cleanup-set_max_mapnr_init arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~A1.2-cleanup-set_max_mapnr_init	2005-01-25 13:51:03.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-01-25 13:57:32.000000000 -0800
@@ -370,12 +370,3 @@ void __init set_highmem_pages_init(int b
 	totalram_pages += totalhigh_pages;
 #endif
 }
-
-void __init set_max_mapnr_init(void)
-{
-#ifdef CONFIG_HIGHMEM
-	num_physpages = highend_pfn;
-#else
-	num_physpages = max_low_pfn;
-#endif
-}
_
