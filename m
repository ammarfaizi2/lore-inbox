Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVD0D1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVD0D1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 23:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVD0D1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 23:27:36 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:45574 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261899AbVD0D1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 23:27:31 -0400
Subject: [PATCH] JFS fsync wrong behavior when I/O failure occurs
From: fs <fs@ercist.iscas.ac.cn>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: iscas
Message-Id: <1114612509.2999.30.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Apr 2005 10:35:09 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch has sent to JFS maintainer, and ACKed,
but filtered by LKML, so I send it again.

JFS contains a bug with sys_fsync(jfs_fsync), also with
fs/mpage.c:mpage_end_io_write

Symptom
The open-write-fsync-close code will not return error when disk I/O
occurs
between open and fsync.

Details
1. sys_fsync does 3 jobs: 
  submit all pages taged with PAGECACHE_TAG_DIRTY to disk I/O, 
  do file-system related fsync operations
  wait all pages taged with PAGECACHE_TAG_WRITEBACK to complete.
Here, all disk I/O are asynchronous, when finished, mpage_end_io_write
will
remove page from mapping's PAGECACHE_TAG_WRITEBACK tree. If I/O fails,
it will also set PG_error flag, but it FORGET to set the mapping->flags
AS_EIO
flag. So in step 3, sys_fsync won't notice these pages.
2. Besides 1, jfs_fsync should return error also, but it doesn't wait
the page
uptodate, e.g.:
jfs_fsync->jfs_commit_inode->txCommit->diWrite->read_metapage->__get_metapage
->read_cache_page reads a page from disk. Because read is async, when
read_cache_page: err = filler(data, page), filler will not return error,
it just submits I/O request and returns. So, page is not uptodate.
only use if(IS_ERROR(mp->page)) is not enough, we should add 
"|| !PageUptodate(mp->page)" - remember, mp->data = kmap(mp->page) +
page_offst, 
later, the outer function will have mem access with mp->data. If
mp->data is not
uptodate, dangerous.

Patch
diff -urN linux-2.6.11.7/fs/jfs/jfs_metapage.c
linux-2.6.11.7.new/fs/jfs/jfs_metapage.c
--- linux-2.6.11.7/fs/jfs/jfs_metapage.c 2005-04-07 14:57:26.000000000
-0400
+++ linux-2.6.11.7.new/fs/jfs/jfs_metapage.c 2005-04-25
16:33:59.000000000 -0400
@@ -347,7 +347,13 @@
    jfs_info("__get_metapage: Calling read_cache_page");
    mp->page = read_cache_page(mapping, lblock,
         (filler_t *)mapping->a_ops->readpage, NULL);
-   if (IS_ERR(mp->page)) {
+   if (IS_ERR(mp->page) || !PageUptodate(mp->page)) {
+    /* Page hasn't been uptodate yet because of
+     * async I/O, in most cases, I/O error has 
+     * occurred. We must make sure the page is 
+     * uptodate - the outer function will do mem
+     * operations with kmap(mp->page) + page_offset
+     */
     jfs_err("read_cache_page failed!");
     goto freeit;
    } else
diff -urN linux-2.6.11.7/fs/mpage.c linux-2.6.11.7.new/fs/mpage.c
--- linux-2.6.11.7/fs/mpage.c 2005-04-07 14:57:25.000000000 -0400
+++ linux-2.6.11.7.new/fs/mpage.c 2005-04-25 16:38:05.000000000 -0400
@@ -79,8 +79,10 @@
   if (--bvec >= bio->bi_io_vec)
    prefetchw(&bvec->bv_page->flags);
 
-  if (!uptodate)
+  if (!uptodate){
    SetPageError(page);
+   set_bit(AS_EIO, &page->mapping->flags);
+  }
   end_page_writeback(page);
  } while (bvec >= bio->bi_io_vec);
  bio_put(bio);

Ref
http://developer.osdl.jp/projects/doubt/fs-consistency-and-coherency/index.html

Signed-off-by: Qu Fuping<qufuping@ercist.iscas.ac.cn>



