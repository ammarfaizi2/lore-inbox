Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVBGVUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVBGVUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVBGVUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:20:34 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:18660 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S261328AbVBGVUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:20:17 -0500
From: Zach Brown <zach.brown@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Zach Brown <zach.brown@oracle.com>
Message-Id: <20050207212016.10913.6867.90598@volauvent.pdx.zabbo.net>
Subject: [Patch] write and wait on range before direct io read
Date: Mon,  7 Feb 2005 13:20:16 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds filemap_write_and_wait_range(mapping, lstart, lend) which starts
writeback and waits on a range of pages.  We call this from __blkdev_direct_IO
with just the range that is going to be read by the direct_IO read.  It was
lightly tested with fsx and ext3 and passed.

Signed-off-by: Zach Brown <zach.brown@oracle.com>

---

 fs/direct-io.c     |    7 +++++--
 include/linux/fs.h |    2 ++
 mm/filemap.c       |   16 ++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

Index: 2.6-bk-odirinv/fs/direct-io.c
===================================================================
--- 2.6-bk-odirinv.orig/fs/direct-io.c	2005-02-07 11:19:40.000000000 -0800
+++ 2.6-bk-odirinv/fs/direct-io.c	2005-02-07 12:43:09.572259133 -0800
@@ -1206,7 +1206,8 @@
 	 */
 	dio->lock_type = dio_lock_type;
 	if (dio_lock_type != DIO_NO_LOCKING) {
-		if (rw == READ) {
+		/* watch out for a 0 len io from a tricksy fs */
+		if (rw == READ && end > offset) {
 			struct address_space *mapping;
 
 			mapping = iocb->ki_filp->f_mapping;
@@ -1214,7 +1215,9 @@
 				down(&inode->i_sem);
 				reader_with_isem = 1;
 			}
-			retval = filemap_write_and_wait(mapping);
+
+			retval = filemap_write_and_wait_range(mapping, offset,
+							      end - 1);
 			if (retval) {
 				kfree(dio);
 				goto out;
Index: 2.6-bk-odirinv/include/linux/fs.h
===================================================================
--- 2.6-bk-odirinv.orig/include/linux/fs.h	2005-02-07 11:26:23.000000000 -0800
+++ 2.6-bk-odirinv/include/linux/fs.h	2005-02-07 12:26:43.030749241 -0800
@@ -1359,6 +1359,8 @@
 extern int filemap_flush(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern int filemap_write_and_wait(struct address_space *mapping);
+extern int filemap_write_and_wait_range(struct address_space *mapping,
+				        loff_t lstart, loff_t lend);
 extern void sync_supers(void);
 extern void sync_filesystems(int wait);
 extern void emergency_sync(void);
Index: 2.6-bk-odirinv/mm/filemap.c
===================================================================
--- 2.6-bk-odirinv.orig/mm/filemap.c	2005-02-07 11:26:23.000000000 -0800
+++ 2.6-bk-odirinv/mm/filemap.c	2005-02-07 13:00:29.723440763 -0800
@@ -336,6 +336,22 @@
 	return retval;
 }
 
+int filemap_write_and_wait_range(struct address_space *mapping,
+				 loff_t lstart, loff_t lend)
+{
+	int retval = 0;
+
+	if (mapping->nrpages) {
+		retval = __filemap_fdatawrite_range(mapping, lstart, lend,
+						    WB_SYNC_ALL);
+		if (retval == 0)
+			retval = wait_on_page_writeback_range(mapping,
+						    lstart >> PAGE_CACHE_SHIFT,
+						    lend >> PAGE_CACHE_SHIFT);
+	}
+	return retval;
+}
+
 /*
  * This function is used to add newly allocated pagecache pages:
  * the page is new, so we can just run SetPageLocked() against it.
