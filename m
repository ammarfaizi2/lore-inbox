Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263290AbVCEAgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbVCEAgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbVCEAMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:12:21 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:32670 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263373AbVCDXYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:24:36 -0500
Subject: [PATCH] 2.6.11-mm1 ext3 writepages support for writeback mode
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-aacjWweXfxP0cO/Hzudm"
Organization: 
Message-Id: <1109978510.7236.18.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Mar 2005 15:21:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aacjWweXfxP0cO/Hzudm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Here is the 2.6.11-mm1 patch for adding writepages support
for ext3 writeback mode. Could you include it in -mm tree ?

Thanks,
Badari



--=-aacjWweXfxP0cO/Hzudm
Content-Disposition: attachment; filename=ext3-writepages.patch
Content-Type: text/x-patch; name=ext3-writepages.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naurp -X dontdiff linux-2.6.11/fs/ext3/inode.c linux-2.6.11.new/fs/ext3/inode.c
--- linux-2.6.11/fs/ext3/inode.c	2005-03-01 23:38:13.000000000 -0800
+++ linux-2.6.11.new/fs/ext3/inode.c	2005-03-04 15:35:02.304473032 -0800
@@ -858,6 +858,12 @@ get_block:
 	return ret;
 }
 
+static int ext3_writepages_get_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh, int create)
+{
+	return ext3_direct_io_get_blocks(inode, iblock, 1, bh, create);
+}
+
 /*
  * `handle' can be NULL if create is zero
  */
@@ -1323,6 +1329,45 @@ out_fail:
 	return ret;
 }
 
+static int 
+ext3_writeback_writepage_helper(struct page *page,
+				struct writeback_control *wbc)
+{
+	return block_write_full_page(page, ext3_get_block, wbc);
+}
+
+static int
+ext3_writeback_writepages(struct address_space *mapping, 
+				struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+	handle_t *handle = NULL;
+	int err, ret = 0;
+
+	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
+		return ret;
+
+	handle = ext3_journal_start(inode, ext3_writepage_trans_blocks(inode));
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		return ret;
+	}
+
+        ret = __mpage_writepages(mapping, wbc, ext3_writepages_get_block,
+					ext3_writeback_writepage_helper);
+
+	/*
+	 * Need to reaquire the handle since ext3_writepages_get_block()
+	 * can restart the handle
+	 */
+	handle = journal_current_handle();
+
+	err = ext3_journal_stop(handle);
+	if (!ret)
+		ret = err;
+	return ret;
+}
+
 static int ext3_writeback_writepage(struct page *page,
 				struct writeback_control *wbc)
 {
@@ -1554,6 +1599,7 @@ static struct address_space_operations e
 	.readpage	= ext3_readpage,
 	.readpages	= ext3_readpages,
 	.writepage	= ext3_writeback_writepage,
+	.writepages	= ext3_writeback_writepages,
 	.sync_page	= block_sync_page,
 	.prepare_write	= ext3_prepare_write,
 	.commit_write	= ext3_writeback_commit_write,
diff -Naurp -X dontdiff linux-2.6.11/fs/mpage.c linux-2.6.11.new/fs/mpage.c
--- linux-2.6.11/fs/mpage.c	2005-03-04 16:01:06.302709160 -0800
+++ linux-2.6.11.new/fs/mpage.c	2005-03-04 15:58:30.608378296 -0800
@@ -626,6 +626,15 @@ int
 mpage_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, get_block_t get_block)
 {
+	return __mpage_writepages(mapping, wbc, get_block,
+		mapping->a_ops->writepage);
+}
+
+int
+__mpage_writepages(struct address_space *mapping,
+		struct writeback_control *wbc, get_block_t get_block,
+		writepage_t writepage_fn)
+{
 	struct backing_dev_info *bdi = mapping->backing_dev_info;
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
@@ -715,7 +724,7 @@ retry:
 			} else {
 				bio = __mpage_writepage(bio, page, get_block,
 						&last_block_in_bio, &ret, wbc,
-						page->mapping->a_ops->writepage);
+						writepage_fn);
 			}
 			if (ret || (--(wbc->nr_to_write) <= 0))
 				done = 1;
@@ -743,6 +752,7 @@ retry:
 	return ret;
 }
 EXPORT_SYMBOL(mpage_writepages);
+EXPORT_SYMBOL(__mpage_writepages);
 
 int mpage_writepage(struct page *page, get_block_t get_block,
 	struct writeback_control *wbc)
diff -Naurp -X dontdiff linux-2.6.11/include/linux/mpage.h linux-2.6.11.new/include/linux/mpage.h
--- linux-2.6.11/include/linux/mpage.h	2005-03-04 16:01:07.654503656 -0800
+++ linux-2.6.11.new/include/linux/mpage.h	2005-03-04 15:35:56.778191768 -0800
@@ -20,6 +20,9 @@ int mpage_writepages(struct address_spac
 		struct writeback_control *wbc, get_block_t get_block);
 int mpage_writepage(struct page *page, get_block_t *get_block,
 		struct writeback_control *wbc);
+int __mpage_writepages(struct address_space *mapping,
+		struct writeback_control *wbc, get_block_t get_block,
+		writepage_t writepage);
 
 static inline int
 generic_writepages(struct address_space *mapping, struct writeback_control *wbc)

--=-aacjWweXfxP0cO/Hzudm--

