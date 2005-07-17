Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVGQRqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVGQRqn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 13:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVGQRoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 13:44:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:38282 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261345AbVGQRmH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 13:42:07 -0400
Subject: [RFC] [PATCH 4/4]add ext3 writeback writpages
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Cc: Badari Pulavarty <pbadari@us.ibm.com>, suparna@in.ibm.com, tytso@mit.edu,
       alex@clusterfs.com, adilger@clusterfs.com
In-Reply-To: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
References: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Sun, 17 Jul 2005 10:41:07 -0700
Message-Id: <1121622067.4609.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

support multiple block allocation for ext3 writeback mode through writepages().


---

 linux-2.6.12-ming/fs/ext3/inode.c       |  131 ++++++++++++++++++++++++++++++++
 linux-2.6.12-ming/fs/mpage.c            |    8 +
 linux-2.6.12-ming/include/linux/mpage.h |   17 ++++
 3 files changed, 153 insertions(+), 3 deletions(-)

diff -puN fs/ext3/inode.c~writepages fs/ext3/inode.c
--- linux-2.6.12/fs/ext3/inode.c~writepages	2005-07-17 17:11:43.239274864 -0700
+++ linux-2.6.12-ming/fs/ext3/inode.c	2005-07-17 17:11:43.259271824 -0700
@@ -36,6 +36,7 @@
 #include <linux/writeback.h>
 #include <linux/mpage.h>
 #include <linux/uio.h>
+#include <linux/pagevec.h>
 #include "xattr.h"
 #include "acl.h"
 
@@ -1719,6 +1720,135 @@ out_fail:
 	return ret;
 }
 
+static int
+ext3_writeback_writepages(struct address_space *mapping,
+				struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+	const unsigned blkbits = inode->i_blkbits;
+	int err = 0;
+	int ret = 0;
+	int done = 0;
+	unsigned int max_pages_to_cluster = 0;
+	struct pagevec pvec;
+	int nr_pages;
+	pgoff_t index;
+	pgoff_t end = -1;		/* Inclusive */
+	int scanned = 0;
+	int is_range = 0;
+	struct page *page;
+	struct mpageio mio = {
+		.bio = NULL
+	};
+
+	pagevec_init(&pvec, 0);
+	if (wbc->sync_mode == WB_SYNC_NONE) {
+		index = mapping->writeback_index; /* Start from prev offset */
+	} else {
+		index = 0;			  /* whole-file sweep */
+		scanned = 1;
+	}
+	if (wbc->start || wbc->end) {
+		index = wbc->start >> PAGE_CACHE_SHIFT;
+		end = wbc->end >> PAGE_CACHE_SHIFT;
+		is_range = 1;
+		scanned = 1;
+	}
+	max_pages_to_cluster = min(EXT3_MAX_TRANS_DATA, (pgoff_t)PAGEVEC_SIZE);
+
+retry:
+	down_read(&inode->i_alloc_sem);
+	while (!done && (index <= end) &&
+			(nr_pages = pagevec_contig_lookup_tag(&pvec, mapping,
+			&index, PAGECACHE_TAG_DIRTY,
+			min(end - index, max_pages_to_cluster-1) + 1))) {
+		unsigned i;
+
+		scanned = 1;
+		for (i = 0; i < nr_pages; i++) {
+			page = pvec.pages[i];
+
+			lock_page(page);
+
+			if (unlikely(page->mapping != mapping)) {
+				unlock_page(page);
+				break;
+			}
+
+			if (unlikely(is_range) && page->index > end) {
+				unlock_page(page);
+				break;
+			}
+
+			if (wbc->sync_mode != WB_SYNC_NONE)
+				wait_on_page_writeback(page);
+
+			if (PageWriteback(page) ||
+					!clear_page_dirty_for_io(page)) {
+				unlock_page(page);
+				break;
+			}
+		}
+
+		if (i) {
+			unsigned j;
+			handle_t *handle;
+
+			page = pvec.pages[i-1];
+			index = page->index + 1;
+			mio.final_block_in_request =
+				min(index, end) << (PAGE_CACHE_SHIFT - blkbits);
+
+			handle = ext3_journal_start(inode,
+					i + ext3_writepage_trans_blocks(inode));
+
+			if (IS_ERR(handle)) {
+				err = PTR_ERR(handle);
+				done = 1;
+			}
+			for (j = 0; j < i; j++) {
+				page = pvec.pages[j];
+				if (!done) {
+					ret = __mpage_writepage(&mio, page,
+						ext3_writepages_get_blocks, wbc,
+						ext3_writeback_writepage_helper);
+					if (ret || (--(wbc->nr_to_write) <= 0))
+						done = 1;
+				} else {
+					redirty_page_for_writepage(wbc, page);
+					unlock_page(page);
+				}
+			}
+			if (!err && mio.bio)
+				mio.bio = mpage_bio_submit(WRITE, mio.bio);
+			if (!err)
+				err = ext3_journal_stop(handle);
+			if (!ret) {
+				ret = err;
+				if (ret)
+					done = 1;
+			}
+		}
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+
+	up_read(&inode->i_alloc_sem);
+
+	if (!scanned && !done) {
+		/*
+		 * We hit the last page and there is more work to be done: wrap
+		 * back to the start of the file
+		 */
+		scanned = 1;
+		index = 0;
+		goto retry;
+	}
+	if (!is_range)
+		mapping->writeback_index = index;
+	return ret;
+}
+
 static int ext3_journalled_writepage(struct page *page,
 				struct writeback_control *wbc)
 {
@@ -1923,6 +2053,7 @@ static struct address_space_operations e
 	.readpage	= ext3_readpage,
 	.readpages	= ext3_readpages,
 	.writepage	= ext3_writeback_writepage,
+	.writepages	= ext3_writeback_writepages,
 	.sync_page	= block_sync_page,
 	.prepare_write	= ext3_prepare_write,
 	.commit_write	= ext3_writeback_commit_write,
diff -puN fs/mpage.c~writepages fs/mpage.c
--- linux-2.6.12/fs/mpage.c~writepages	2005-07-17 17:11:43.243274256 -0700
+++ linux-2.6.12-ming/fs/mpage.c	2005-07-17 17:12:43.220156384 -0700
@@ -90,7 +90,7 @@ static int mpage_end_io_write(struct bio
 	return 0;
 }
 
-static struct bio *mpage_bio_submit(int rw, struct bio *bio)
+struct bio *mpage_bio_submit(int rw, struct bio *bio)
 {
 	bio->bi_end_io = mpage_end_io_read;
 	if (rw == WRITE)
@@ -373,6 +373,7 @@ int mpage_readpage(struct page *page, ge
 }
 EXPORT_SYMBOL(mpage_readpage);
 
+#if 0
 struct mpageio {
 	struct bio *bio;
 	struct buffer_head map_bh;
@@ -383,6 +384,7 @@ struct mpageio {
 	sector_t boundary_block;
 	struct block_device *boundary_bdev;
 };
+#endif
 
 /*
  * Maps as many contiguous disk blocks as it can within the range of
@@ -450,7 +452,7 @@ static unsigned long mpage_get_more_bloc
  * written, so it can intelligently allocate a suitably-sized BIO.  For now,
  * just allocate full-size (16-page) BIOs.
  */
-static int
+int
 __mpage_writepage(struct mpageio *mio, struct page *page,
 	get_blocks_t get_blocks, struct writeback_control *wbc,
 	writepage_t writepage_fn)
@@ -532,7 +534,7 @@ __mpage_writepage(struct mpageio *mio, s
 	 */
 	BUG_ON(!PageUptodate(page));
 	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
-	last_block = (i_size - 1) >> blkbits;
+	last_block = (i_size) >> blkbits;
 	blocks_to_skip = block_in_file - mio->block_in_file;
 	mio->block_in_file = block_in_file;
 	if (blocks_to_skip < (map_bh->b_size >> blkbits)) {
diff -puN include/linux/mpage.h~writepages include/linux/mpage.h
--- linux-2.6.12/include/linux/mpage.h~writepages	2005-07-17 17:11:43.246273800 -0700
+++ linux-2.6.12-ming/include/linux/mpage.h	2005-07-17 17:11:43.263271216 -0700
@@ -9,9 +9,23 @@
  * (And no, it doesn't do the #ifdef __MPAGE_H thing, and it doesn't do
  * nested includes.  Get it right in the .c file).
  */
+#ifndef _LINUX_BUFFER_HEAD_H
+#include <linux/buffer_head.h>
+#endif
 
 struct writeback_control;
 
+struct mpageio {
+	struct bio *bio;
+	struct buffer_head map_bh;
+	unsigned long block_in_file;
+	unsigned long final_block_in_request;
+	sector_t block_in_bio;
+	int boundary;
+	sector_t boundary_block;
+	struct block_device *boundary_bdev;
+};
+
 int mpage_readpages(struct address_space *mapping, struct list_head *pages,
 				unsigned nr_pages, get_block_t get_block);
 int mpage_readpage(struct page *page, get_block_t get_block);
@@ -23,6 +37,9 @@ int mpage_writepage(struct page *page, g
 int __mpage_writepages(struct address_space *mapping,
                 struct writeback_control *wbc, get_blocks_t get_blocks,
                 writepage_t writepage);
+int __mpage_writepage(struct mpageio *mio, struct page *page,
+        get_blocks_t get_blocks, struct writeback_control *wbc,
+        writepage_t writepage_fn);
 
 static inline int
 generic_writepages(struct address_space *mapping, struct writeback_control *wbc)

_


