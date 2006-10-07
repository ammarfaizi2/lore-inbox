Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWJGNFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWJGNFv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 09:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbWJGNFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 09:05:51 -0400
Received: from cantor2.suse.de ([195.135.220.15]:31922 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751548AbWJGNFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 09:05:50 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>
Message-Id: <20061007105807.14024.67270.sendpatchset@linux.site>
In-Reply-To: <20061007105758.14024.70048.sendpatchset@linux.site>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
Subject: [patch 1/3] mm: arch_free_page fix
Date: Sat,  7 Oct 2006 15:05:46 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the PG_reserved check was added, arch_free_page was being called in the
wrong place (it could be called for a page we don't actually want to free).
Fix that.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2006-08-05 18:38:50.000000000 +1000
+++ linux-2.6/mm/page_alloc.c	2006-09-17 17:19:32.000000000 +1000
@@ -443,7 +443,6 @@ static void __free_pages_ok(struct page 
 	int i;
 	int reserved = 0;
 
-	arch_free_page(page, order);
 	if (!PageHighMem(page))
 		debug_check_no_locks_freed(page_address(page),
 					   PAGE_SIZE<<order);
@@ -453,7 +452,9 @@ static void __free_pages_ok(struct page 
 	if (reserved)
 		return;
 
+	arch_free_page(page, order);
 	kernel_map_pages(page, 1 << order, 0);
+
 	local_irq_save(flags);
 	__count_vm_events(PGFREE, 1 << order);
 	free_one_page(page_zone(page), page, order);
@@ -717,13 +718,12 @@ static void fastcall free_hot_cold_page(
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
 
-	arch_free_page(page, 0);
-
 	if (PageAnon(page))
 		page->mapping = NULL;
 	if (free_pages_check(page))
 		return;
 
+	arch_free_page(page, 0);
 	kernel_map_pages(page, 1, 0);
 
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
