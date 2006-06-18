Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWFRJmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWFRJmA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 05:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWFRJmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 05:42:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:26342 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750754AbWFRJl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 05:41:59 -0400
Date: Sun, 18 Jun 2006 11:41:57 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>, Jens Axboe <axboe@suse.de>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: [patch] rfc: fix splice mapping race?
Message-ID: <20060618094157.GD14452@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I would be interested in confirmation/comments for this patch.

I believe splice is unsafe to access the page mapping obtained
when the page was unlocked: the page could subsequently be truncated
and the mapping reclaimed (see set_page_dirty_lock comments).

Modify the remove_mapping precondition to ensure the caller has
locked the page and obtained the correct mapping. Modify callers to
ensure the mapping is the correct one.

In page migration, detect the missing mapping early and bail out if
that is the case: the page is not going to get un-truncated, so
retrying is just a waste of time.

Signed-off-by: Nick Piggin <npiggin@suse.de>
 

Index: linux-2.6/fs/splice.c
===================================================================
--- linux-2.6.orig/fs/splice.c
+++ linux-2.6/fs/splice.c
@@ -55,9 +55,12 @@ static int page_cache_pipe_buf_steal(str
 				     struct pipe_buffer *buf)
 {
 	struct page *page = buf->page;
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping;
 
 	lock_page(page);
+	mapping = page_mapping(page);
+	if (!mapping)
+		goto out_failed;
 
 	WARN_ON(!PageUptodate(page));
 
@@ -74,6 +77,7 @@ static int page_cache_pipe_buf_steal(str
 		try_to_release_page(page, mapping_gfp_mask(mapping));
 
 	if (!remove_mapping(mapping, page)) {
+out_failed:
 		unlock_page(page);
 		return 1;
 	}
Index: linux-2.6/mm/migrate.c
===================================================================
--- linux-2.6.orig/mm/migrate.c
+++ linux-2.6/mm/migrate.c
@@ -136,9 +136,13 @@ static int swap_page(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 
-	if (page_mapped(page) && mapping)
+	if (!mapping)
+		return -EINVAL; /* page truncated. signal permanent failure */
+
+	if (page_mapped(page)) {
 		if (try_to_unmap(page, 1) != SWAP_SUCCESS)
 			goto unlock_retry;
+	}
 
 	if (PageDirty(page)) {
 		/* Page is dirty, try to write it out here */
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -362,8 +362,8 @@ pageout_t pageout(struct page *page, str
 
 int remove_mapping(struct address_space *mapping, struct page *page)
 {
-	if (!mapping)
-		return 0;		/* truncate got there first */
+	BUG_ON(!PageLocked(page));
+	BUG_ON(mapping != page->mapping);
 
 	write_lock_irq(&mapping->tree_lock);
 
@@ -532,7 +532,7 @@ static unsigned long shrink_page_list(st
 				goto free_it;
 		}
 
-		if (!remove_mapping(mapping, page))
+		if (!mapping || !remove_mapping(mapping, page))
 			goto keep_locked;
 
 free_it:
