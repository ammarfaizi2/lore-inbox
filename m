Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVKUNZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVKUNZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 08:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVKUNZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 08:25:19 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:59809 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750775AbVKUNZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 08:25:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=n7iMo476BsFBvzKZWrovvIuqlqYg6ik9XMtQ0OtxVtLSgzUrSTU+YSyfGcJCllxhDMfxe0p0xYBwVZiWqjNaKJ9NwHC1Zmj6LhPsm45xmMQbW7RTagrTkUx+bUXuBYNGi9VCAKAojQioJ1j6pF7HNsF8sWyXPiL//jNvo9SuAok=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051121124102.14370.93106.sendpatchset@didi.local0.net>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Subject: [patch 5/12] mm: microopt conditions
Date: Mon, 21 Nov 2005 08:25:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micro optimise some conditionals where we don't need lazy evaluation.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -342,9 +342,9 @@ static inline void __free_pages_bulk (st
 
 static inline void free_pages_check(const char *function, struct page *page)
 {
-	if (	page_mapcount(page) ||
-		page->mapping != NULL ||
-		page_count(page) != 0 ||
+	if (unlikely(page_mapcount(page) |
+		(page->mapping != NULL)  |
+		(page_count(page) != 0)  |
 		(page->flags & (
 			1 << PG_lru	|
 			1 << PG_private |
@@ -354,7 +354,7 @@ static inline void free_pages_check(cons
 			1 << PG_slab	|
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved )))
+			1 << PG_reserved ))))
 		bad_page(function, page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
@@ -455,9 +455,9 @@ expand(struct zone *zone, struct page *p
  */
 static void prep_new_page(struct page *page, int order)
 {
-	if (	page_mapcount(page) ||
-		page->mapping != NULL ||
-		page_count(page) != 0 ||
+	if (unlikely(page_mapcount(page) |
+		(page->mapping != NULL)  |
+		(page_count(page) != 0)  |
 		(page->flags & (
 			1 << PG_lru	|
 			1 << PG_private	|
@@ -468,7 +468,7 @@ static void prep_new_page(struct page *p
 			1 << PG_slab    |
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved )))
+			1 << PG_reserved ))))
 		bad_page(__FUNCTION__, page);
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
Send instant messages to your online friends http://au.messenger.yahoo.com 
