Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262835AbVA2BTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbVA2BTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 20:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbVA2BTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 20:19:36 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:6276 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S262835AbVA2BSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 20:18:53 -0500
From: Zach Brown <zach.brown@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Zach Brown <zach.brown@oracle.com>
Message-Id: <20050129011906.29569.18736.24335@volauvent.pdx.zabbo.net>
Subject: [Patch] invalidate range of pages after direct IO write
Date: Fri, 28 Jan 2005 18:16:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After a direct IO write only invalidate the pages that the write intersected.
invalidate_inode_pages2_range(mapping, pgoff start, pgoff end) is added and
called from generic_file_direct_IO().  This doesn't break some subtle agreement
with some other part of the code, does it?

While we're in there, invalidate_inode_pages2() was calling
unmap_mapping_range() with the wrong convention in the single page case.  It
was providing the byte offset of the final page rather than the length of the
hole being unmapped.  This is also fixed.

This was lightly tested with a 10k op fsx run with O_DIRECT on a 16MB file in
ext3 on a junky old IDE drive.  Totaling vmstat columns of blocks read and
written during the runs shows that read traffic drops significantly.  The run
time seems to have gone down a little.

Two runs before the patch gave the following user/real/sys times and total
blocks in and out:

0m28.029s 0m20.093s 0m3.166s 16673 125107 
0m27.949s 0m20.068s 0m3.227s 18426 126094

and after the patch:

0m26.775s 0m19.996s 0m3.060s 3505 124982
0m26.856s 0m19.935s 0m3.052s 3505 125279

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 include/linux/fs.h |    2 ++
 mm/filemap.c       |    5 ++++-
 mm/truncate.c      |   52 ++++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 44 insertions(+), 15 deletions(-)

Index: 2.6-mm-odirinv/include/linux/fs.h
===================================================================
--- 2.6-mm-odirinv.orig/include/linux/fs.h	2005-01-28 14:14:19.000000000 -0800
+++ 2.6-mm-odirinv/include/linux/fs.h	2005-01-28 14:14:35.000000000 -0800
@@ -1369,6 +1369,8 @@
 		invalidate_inode_pages(inode->i_mapping);
 }
 extern int invalidate_inode_pages2(struct address_space *mapping);
+extern int invalidate_inode_pages2_range(struct address_space *mapping,
+					 pgoff_t start, pgoff_t end);
 extern int write_inode_now(struct inode *, int);
 extern int filemap_fdatawrite(struct address_space *);
 extern int filemap_flush(struct address_space *);
Index: 2.6-mm-odirinv/mm/filemap.c
===================================================================
--- 2.6-mm-odirinv.orig/mm/filemap.c	2005-01-28 13:32:06.000000000 -0800
+++ 2.6-mm-odirinv/mm/filemap.c	2005-01-28 14:21:04.000000000 -0800
@@ -2325,7 +2325,10 @@
 		retval = mapping->a_ops->direct_IO(rw, iocb, iov,
 						offset, nr_segs);
 		if (rw == WRITE && mapping->nrpages) {
-			int err = invalidate_inode_pages2(mapping);
+			pgoff_t end = (offset + iov_length(iov, nr_segs) - 1)
+				      >> PAGE_CACHE_SHIFT;
+			int err = invalidate_inode_pages2_range(mapping,
+					offset >> PAGE_CACHE_SHIFT, end);
 			if (err)
 				retval = err;
 		}
Index: 2.6-mm-odirinv/mm/truncate.c
===================================================================
--- 2.6-mm-odirinv.orig/mm/truncate.c	2005-01-28 13:32:06.000000000 -0800
+++ 2.6-mm-odirinv/mm/truncate.c	2005-01-28 17:03:09.783939857 -0800
@@ -99,7 +99,7 @@
 }
 
 /**
- * truncate_inode_pages - truncate range of pages specified by start and
+ * truncate_inode_pages_range - truncate range of pages specified by start and
  * end byte offsets
  * @mapping: mapping to truncate
  * @lstart: offset from which to truncate
@@ -279,28 +279,38 @@
 EXPORT_SYMBOL(invalidate_inode_pages);
 
 /**
- * invalidate_inode_pages2 - remove all pages from an address_space
+ * invalidate_inode_pages2_range - remove range of pages from an address_space
  * @mapping - the address_space
+ * @start: the page offset 'from' which to invalidate
+ * @end: the page offset 'to' which to invalidate (inclusive)
  *
  * Any pages which are found to be mapped into pagetables are unmapped prior to
  * invalidation.
  *
  * Returns -EIO if any pages could not be invalidated.
  */
-int invalidate_inode_pages2(struct address_space *mapping)
+int invalidate_inode_pages2_range(struct address_space *mapping,
+				  pgoff_t start, pgoff_t end)
 {
 	struct pagevec pvec;
-	pgoff_t next = 0;
+	pgoff_t next;
 	int i;
 	int ret = 0;
-	int did_full_unmap = 0;
+	int did_range_unmap = 0;
 
 	pagevec_init(&pvec, 0);
-	while (!ret && pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+	next = start;
+	while (next <= end &&
+	       !ret && pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
 		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 			int was_dirty;
 
+			if (page->index > end) {
+				next = page->index;
+				break;
+			}
+
 			lock_page(page);
 			if (page->mapping != mapping) {	/* truncate race? */
 				unlock_page(page);
@@ -309,24 +319,23 @@
 			wait_on_page_writeback(page);
 			next = page->index + 1;
 			while (page_mapped(page)) {
-				if (!did_full_unmap) {
+				if (!did_range_unmap) {
 					/*
 					 * Zap the rest of the file in one hit.
-					 * FIXME: invalidate_inode_pages2()
-					 * should take start/end offsets.
 					 */
 					unmap_mapping_range(mapping,
-						page->index << PAGE_CACHE_SHIFT,
-					  	-1, 0);
-					did_full_unmap = 1;
+					    page->index << PAGE_CACHE_SHIFT,
+					    (end - page->index + 1)
+							<< PAGE_CACHE_SHIFT,
+					    0);
+					did_range_unmap = 1;
 				} else {
 					/*
 					 * Just zap this page
 					 */
 					unmap_mapping_range(mapping,
 					  page->index << PAGE_CACHE_SHIFT,
-					  (page->index << PAGE_CACHE_SHIFT)+1,
-					  0);
+					  PAGE_CACHE_SIZE, 0);
 				}
 			}
 			was_dirty = test_clear_page_dirty(page);
@@ -342,4 +351,19 @@
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(invalidate_inode_pages2_range);
+
+/**
+ * invalidate_inode_pages2 - remove all pages from an address_space
+ * @mapping - the address_space
+ *
+ * Any pages which are found to be mapped into pagetables are unmapped prior to
+ * invalidation.
+ *
+ * Returns -EIO if any pages could not be invalidated.
+ */
+int invalidate_inode_pages2(struct address_space *mapping)
+{
+	return invalidate_inode_pages2_range(mapping, 0, ~0UL);
+}
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
