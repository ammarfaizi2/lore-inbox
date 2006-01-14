Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWANMmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWANMmH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWANMmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:42:07 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:36957 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751103AbWANMmF (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 14 Jan 2006 07:42:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type;
  b=OFtwYKOpxfB3tZqfCvolMIy35nvLUY334x9UnMBFFUEWPt13SXG2V3eNZ3lzHT4+6gWCL8t9c3FFZJiO32aYggL248UhkHFV2y1gJGMw3RTYwjMASSNgzcx+UXGCuzo+Mz+N2IcI+Wk27SIEd7jLNQXxaVZnLcS353U3Pr8Kyrk=  ;
Message-ID: <43C8F198.3010609@yahoo.com.au>
Date: Sat, 14 Jan 2006 23:42:00 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch] mm: cleanup bootmem
Content-Type: multipart/mixed;
 boundary="------------020406020704010703060408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020406020704010703060408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Objections?

-- 
SUSE Labs, Novell Inc.


--------------020406020704010703060408
Content-Type: text/plain;
 name="mm-cleanup-bootmem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-cleanup-bootmem.patch"

The bootmem code added to page_alloc.c duplicated some page freeing code
that it really doesn't need to because it is not so performance critical.

While we're here, make prefetching work properly by actually prefetching
the page we're about to use before prefetching ahead to the next one (ie.
get the most important transaction started first). Also prefetch just a
single page ahead rather than leaving a gap of 16.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -55,8 +55,6 @@ unsigned long totalhigh_pages __read_mos
 long nr_swap_pages;
 int percpu_pagelist_fraction;
 
-static void fastcall free_hot_cold_page(struct page *page, int cold);
-
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
  *	1G machine -> (16M dma, 800M-16M normal, 1G-800M high)
@@ -444,28 +442,23 @@ void fastcall __init __free_pages_bootme
 	if (order == 0) {
 		__ClearPageReserved(page);
 		set_page_count(page, 0);
-
-		free_hot_cold_page(page, 0);
+		set_page_refs(page, 0);
+		__free_page(page);
 	} else {
-		LIST_HEAD(list);
 		int loop;
 
+		prefetchw(page);
 		for (loop = 0; loop < BITS_PER_LONG; loop++) {
 			struct page *p = &page[loop];
 
-			if (loop + 16 < BITS_PER_LONG)
-				prefetchw(p + 16);
+			if (loop + 1 < BITS_PER_LONG)
+				prefetchw(p + 1);
 			__ClearPageReserved(p);
 			set_page_count(p, 0);
 		}
 
-		arch_free_page(page, order);
-
-		mod_page_state(pgfree, 1 << order);
-
-		list_add(&page->lru, &list);
-		kernel_map_pages(page, 1 << order, 0);
-		free_pages_bulk(page_zone(page), 1, &list, order);
+		set_page_refs(page, order);
+		__free_pages(page, order);
 	}
 }
 

--------------020406020704010703060408--
Send instant messages to your online friends http://au.messenger.yahoo.com 
