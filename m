Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVKFIWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVKFIWB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVKFIWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:22:01 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:45666 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932320AbVKFIWA (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:22:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:CC:Subject:References:In-Reply-To:Content-Type;
  b=foGXZF8uJjBFPjgLNjgdmLBjJKUFOUXCwnJqBc9SU9ShP3HP8ElN++xjBIuC9x1oZLLZJ8i3hwi6BFfSBD+M3OWtyrvIq1BHQGP7CB7GLC6MJtP4NV/C6FddJ4mVDS8SZO06sbPKYSVhCD6lPG0EARVxYW+9qafmo/4cyaDuYq8=  ;
Message-ID: <436DBDA9.2040908@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:24:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 6/14] mm: microopt conditions
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au>
In-Reply-To: <436DBD82.2070500@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------050502040203000405020605"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050502040203000405020605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

6/14

-- 
SUSE Labs, Novell Inc.


--------------050502040203000405020605
Content-Type: text/plain;
 name="mm-microopt-conditions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-microopt-conditions.patch"

Micro optimise some conditionals where we don't need lazy evaluation.

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -339,9 +339,9 @@ static inline void __free_pages_bulk (st
 
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
@@ -351,7 +351,7 @@ static inline void free_pages_check(cons
 			1 << PG_slab	|
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved )))
+			1 << PG_reserved ))))
 		bad_page(function, page);
 	if (PageDirty(page))
 		__ClearPageDirty(page);
@@ -452,9 +452,9 @@ expand(struct zone *zone, struct page *p
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
@@ -465,7 +465,7 @@ static void prep_new_page(struct page *p
 			1 << PG_slab    |
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_reserved )))
+			1 << PG_reserved ))))
 		bad_page(__FUNCTION__, page);
 
 	page->flags &= ~(1 << PG_uptodate | 1 << PG_error |

--------------050502040203000405020605--
Send instant messages to your online friends http://au.messenger.yahoo.com 
