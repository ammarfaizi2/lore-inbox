Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVCAVNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVCAVNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVCAVNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:13:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62083 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261976AbVCAVNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:13:22 -0500
Date: Tue, 1 Mar 2005 21:11:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Colin Harrison <colin.harrison@virgin.net>,
       "Ammar T. Al-Sayegh" <ammar@kunet.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Bad page state mapcount
Message-ID: <Pine.LNX.4.61.0503012102001.32710@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small change to the tests for "Bad page state", to avoid one class of
the page_remove_rmap BUG reports, giving more information while letting
the system continue: check page_mapcount (_mapcount != -1) rather than
page_mapped (_mapcount >= 0).

And how does _mapcount go bad?  In the case under study, it looks sure
now that an overheating(?) Pentium III sometimes gets confused by a pair
of instructions in the no-buddy-bitmap __free_pages_bulk, and clears the
PG_private bit from the _mapcount field while buddying around - changing
PG_private value changes the bit cleared from _mapcount.  Bad page state
mapcount:-4096 would have tracked this down much sooner, and will be
recognizable if other cpus show the same aberrant reaction to 2.6.11.

The page_remove_rmap BUG does need to be replaced by more permissive and
informative handling, but I'm not yet ready to to finalize such a patch.

Please admit Colin Harrison to the Order of the Iridescent Penguin,
for his tireless testing.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.11-rc5-bk4/mm/page_alloc.c	2005-02-24 19:44:06.000000000 +0000
+++ linux/mm/page_alloc.c	2005-03-01 19:58:44.000000000 +0000
@@ -276,7 +276,7 @@ static inline void __free_pages_bulk (st
 
 static inline void free_pages_check(const char *function, struct page *page)
 {
-	if (	page_mapped(page) ||
+	if (	page_mapcount(page) ||
 		page->mapping != NULL ||
 		page_count(page) != 0 ||
 		(page->flags & (
@@ -404,7 +404,7 @@ void set_page_refs(struct page *page, in
  */
 static void prep_new_page(struct page *page, int order)
 {
-	if (page->mapping || page_mapped(page) ||
+	if (page->mapping || page_mapcount(page) ||
 	    (page->flags & (
 			1 << PG_private	|
 			1 << PG_locked	|
