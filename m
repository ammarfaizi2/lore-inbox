Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWBLTrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWBLTrK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWBLTrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:47:10 -0500
Received: from silver.veritas.com ([143.127.12.111]:57887 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751398AbWBLTrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:47:09 -0500
Date: Sun, 12 Feb 2006 19:47:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] compound page: default destructor
In-Reply-To: <Pine.LNX.4.61.0602121943150.15774@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0602121946580.15774@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602121943150.15774@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Feb 2006 19:47:08.0839 (UTC) FILETIME=[1BF50B70:01C6300D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow I imagined that calling a NULL destructor would free a compound
page rather than oopsing.  No, we must supply a default destructor,
__free_pages_ok using the order noted by prep_compound_page.  hugetlb
can still replace this as before with its own free_huge_page pointer.

The case that needs this is not common: rarely does put_compound_page's
put_page_testzero bring the count down to 0.  But if get_user_pages is
applied to some part of a compound page, without immediate release (e.g.
AIO or Infiniband), then it's possible for its put_page to come after
the containing vma has been unmapped and the driver done its free_pages.

That's just the kind of case compound pages are supposed to be guarding
against (but Nick points out, nor did PageReserved handle this right).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/page_alloc.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

--- 2.6.16-rc2-git11+/mm/page_alloc.c	2006-02-10 20:03:19.000000000 +0000
+++ 2.6.16-rc2-git11++/mm/page_alloc.c	2006-02-10 20:07:05.000000000 +0000
@@ -56,6 +56,7 @@ long nr_swap_pages;
 int percpu_pagelist_fraction;
 
 static void fastcall free_hot_cold_page(struct page *page, int cold);
+static void __free_pages_ok(struct page *page, unsigned int order);
 
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
@@ -173,12 +174,18 @@ static void bad_page(struct page *page)
  * put_page() function.  Its ->lru.prev holds the order of allocation.
  * This usage means that zero-order pages may not be compound.
  */
+
+static void free_compound_page(struct page *page)
+{
+	__free_pages_ok(page, (unsigned long)page[1].lru.prev);
+}
+
 static void prep_compound_page(struct page *page, unsigned long order)
 {
 	int i;
 	int nr_pages = 1 << order;
 
-	page[1].lru.next = NULL;			/* set dtor */
+	page[1].lru.next = (void *)free_compound_page;	/* set dtor */
 	page[1].lru.prev = (void *)order;
 	for (i = 0; i < nr_pages; i++) {
 		struct page *p = page + i;
