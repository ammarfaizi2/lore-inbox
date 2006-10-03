Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWJCRv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWJCRv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWJCRv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:51:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30944 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030392AbWJCRv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:51:57 -0400
Date: Tue, 3 Oct 2006 13:51:49 -0400 (EDT)
From: Chip Coldwell <coldwell@redhat.com>
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org
Subject: direct IO regression in 2.6.18
Message-ID: <Pine.LNX.4.64.0610031330400.31975@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following commit caused a regression in direct IO:

commit 016eb4a0ed06a3677d67a584da901f0e9a63c666
Author: Andrew Morton <akpm@osdl.org>
Date:   Fri Sep 8 09:48:38 2006 -0700

     [PATCH] invalidate_complete_page() race fix

     If a CPU faults this page into pagetables after invalidate_mapping_pages()
     checked page_mapped(), invalidate_complete_page() will still proceed to remove
     the page from pagecache.  This leaves the page-faulting process with a
     detached page.  If it was MAP_SHARED then file data loss will ensue.

     Fix that up by checking the page's refcount after taking tree_lock.

     Cc: Nick Piggin <nickpiggin@yahoo.com.au>
     Cc: Hugh Dickins <hugh@veritas.com>
     Cc: <stable@kernel.org>
     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/mm/truncate.c b/mm/truncate.c
index cf1b015..c6ab55e 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -68,10 +68,10 @@ invalidate_complete_page(struct address_
  		return 0;

  	write_lock_irq(&mapping->tree_lock);
-	if (PageDirty(page)) {
-		write_unlock_irq(&mapping->tree_lock);
-		return 0;
-	}
+	if (PageDirty(page))
+		goto failed;
+	if (page_count(page) != 2)	/* caller's ref + pagecache ref */
+		goto failed;

  	BUG_ON(PagePrivate(page));
  	__remove_from_page_cache(page);
@@ -79,6 +79,9 @@ invalidate_complete_page(struct address_
  	ClearPageUptodate(page);
  	page_cache_release(page);	/* pagecache ref */
  	return 1;
+failed:
+	write_unlock_irq(&mapping->tree_lock);
+	return 0;
  }

  /**


The issue is that invalidate_complete_page is in two different code
paths, the normal one (prune_icache calls invalidate_inode_pages calls
invalidate_mapping_pages calls invalidate_complete_page) and also via
direct IO (generic_file_direct_write calls generic_file_direct_IO
calls invalidate_inode_pages2_range calls invalidate_complete_page).
In the latter case, the page is (usually) not even in the page cache
and the refcount can legitimately != 2.

Chip

-- 
Charles M. "Chip" Coldwell
Senior Software Engineer
Red Hat, Inc
978-392-2426

