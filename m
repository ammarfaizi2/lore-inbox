Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316422AbSEZUnO>; Sun, 26 May 2002 16:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSEZUl4>; Sun, 26 May 2002 16:41:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47632 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316383AbSEZUkc>;
	Sun, 26 May 2002 16:40:32 -0400
Message-ID: <3CF148FD.D056DA0A@zip.com.au>
Date: Sun, 26 May 2002 13:43:41 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 9/18] enable direct-to-BIO readahead for ext3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Turn on multipage no-buffers reads for ext3.



=====================================

--- 2.5.18/fs/ext3/inode.c~ext3-mpage-read	Sun May 26 12:37:52 2002
+++ 2.5.18-akpm/fs/ext3/inode.c	Sun May 26 12:37:52 2002
@@ -33,6 +33,7 @@
 #include <linux/quotaops.h>
 #include <linux/string.h>
 #include <linux/buffer_head.h>
+#include <linux/mpage.h>
 
 /*
  * SEARCH_FROM_ZERO forces each block allocation to search from the start
@@ -1340,9 +1341,15 @@ out_fail:
 
 static int ext3_readpage(struct file *file, struct page *page)
 {
-	return block_read_full_page(page,ext3_get_block);
+	return mpage_readpage(page, ext3_get_block);
 }
 
+static int
+ext3_readpages(struct address_space *mapping,
+		struct list_head *pages, unsigned nr_pages)
+{
+	return mpage_readpages(mapping, pages, nr_pages, ext3_get_block);
+}
 
 static int ext3_flushpage(struct page *page, unsigned long offset)
 {
@@ -1359,6 +1366,7 @@ static int ext3_releasepage(struct page 
 
 struct address_space_operations ext3_aops = {
 	readpage:	ext3_readpage,		/* BKL not held.  Don't need */
+	readpages:	ext3_readpages,		/* BKL not held.  Don't need */
 	writepage:	ext3_writepage,		/* BKL not held.  We take it */
 	sync_page:	block_sync_page,
 	prepare_write:	ext3_prepare_write,	/* BKL not held.  We take it */


-
