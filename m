Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTJGQ06 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTJGQ06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:26:58 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:19009 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262493AbTJGQ0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:26:55 -0400
Date: Tue, 7 Oct 2003 12:26:34 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Matt Domsch <Matt_Domsch@Dell.com>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>
Subject: [PATCH] page->flags corruption fix
Message-ID: <Pine.LNX.4.44.0310071224200.31052-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the "better safe than sorry" category. Thanks go out to
Matt Domsch and Robert Hentosh. A similar fix went into the
2.6 kernel. Please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1192  -> 1.1193 
#	  include/linux/mm.h	1.43    -> 1.44   
#	     mm/page_alloc.c	1.63    -> 1.64   
#	        mm/filemap.c	1.88    -> 1.89   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/07	riel@cessna.boston.redhat.com	1.1193
# fix page->flags corruption due to races between atomic and non-atomic
# accesses, originally found and fixed by Robert Hentosh and Matt Domsch
# --------------------------------------------
#
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Tue Oct  7 12:19:34 2003
+++ b/include/linux/mm.h	Tue Oct  7 12:19:34 2003
@@ -322,9 +322,11 @@
 #define TryLockPage(page)	test_and_set_bit(PG_locked, &(page)->flags)
 #define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
+#define ClearPageChecked(page)	clear_bit(PG_checked, &(page)->flags)
 #define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
 #define ClearPageLaunder(page)	clear_bit(PG_launder, &(page)->flags)
+#define ClearPageArch1(page)	clear_bit(PG_arch_1, &(page)->flags)
 
 /*
  * The zone field is never updated after free_area_init_core()
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Tue Oct  7 12:19:34 2003
+++ b/mm/filemap.c	Tue Oct  7 12:19:34 2003
@@ -654,10 +654,13 @@
 	struct address_space *mapping, unsigned long offset,
 	struct page **hash)
 {
-	unsigned long flags;
-
-	flags = page->flags & ~(1 << PG_uptodate | 1 << PG_error | 1 << PG_dirty | 1 << PG_referenced | 1 << PG_arch_1 | 1 << PG_checked);
-	page->flags = flags | (1 << PG_locked);
+	ClearPageUptodate(page);
+	ClearPageError(page);
+	ClearPageDirty(page);
+	ClearPageReferenced(page);
+	ClearPageArch1(page);
+	ClearPageChecked(page);
+	LockPage(page);
 	page_cache_get(page);
 	page->index = offset;
 	add_page_to_inode_queue(mapping, page);
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Tue Oct  7 12:19:34 2003
+++ b/mm/page_alloc.c	Tue Oct  7 12:19:34 2003
@@ -109,7 +109,8 @@
 		BUG();
 	if (PageActive(page))
 		BUG();
-	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
+	ClearPageReferenced(page);
+	ClearPageDirty(page);
 
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;

