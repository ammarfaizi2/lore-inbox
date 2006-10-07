Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbWJGNGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWJGNGC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 09:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbWJGNGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 09:06:01 -0400
Received: from mail.suse.de ([195.135.220.2]:22928 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751680AbWJGNF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 09:05:58 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>
Message-Id: <20061007105815.14024.99053.sendpatchset@linux.site>
In-Reply-To: <20061007105758.14024.70048.sendpatchset@linux.site>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
Subject: [patch 2/3] mm: locks_freed fix
Date: Sat,  7 Oct 2006 15:05:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the lock debug checks below the page reserved checks.
Also, having debug_check_no_locks_freed in kernel_map_pages is wrong.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h	2006-10-06 11:59:47.000000000 +1000
+++ linux-2.6/include/linux/mm.h	2006-10-06 12:00:02.000000000 +1000
@@ -1038,12 +1038,7 @@ static inline void vm_stat_account(struc
 
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
-kernel_map_pages(struct page *page, int numpages, int enable)
-{
-	if (!PageHighMem(page) && !enable)
-		debug_check_no_locks_freed(page_address(page),
-					   numpages * PAGE_SIZE);
-}
+kernel_map_pages(struct page *page, int numpages, int enable) {}
 #endif
 
 extern struct vm_area_struct *get_gate_vma(struct task_struct *tsk);
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2006-10-06 11:59:47.000000000 +1000
+++ linux-2.6/mm/page_alloc.c	2006-10-06 12:01:52.000000000 +1000
@@ -443,15 +443,13 @@ static void __free_pages_ok(struct page 
 	int i;
 	int reserved = 0;
 
-	if (!PageHighMem(page))
-		debug_check_no_locks_freed(page_address(page),
-					   PAGE_SIZE<<order);
-
 	for (i = 0 ; i < (1 << order) ; ++i)
 		reserved += free_pages_check(page + i);
 	if (reserved)
 		return;
 
+	if (!PageHighMem(page))
+		debug_check_no_locks_freed(page_address(page),PAGE_SIZE<<order);
 	arch_free_page(page, order);
 	kernel_map_pages(page, 1 << order, 0);
 
@@ -723,6 +721,8 @@ static void fastcall free_hot_cold_page(
 	if (free_pages_check(page))
 		return;
 
+	if (!PageHighMem(page))
+		debug_check_no_locks_freed(page_address(page), PAGE_SIZE);
 	arch_free_page(page, 0);
 	kernel_map_pages(page, 1, 0);
 
