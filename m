Return-Path: <linux-kernel-owner+w=401wt.eu-S1751859AbXAVO7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbXAVO7V (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 09:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXAVO7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 09:59:21 -0500
Received: from mx1-2.mail.ru ([194.67.23.121]:23509 "EHLO mx1.mail.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751859AbXAVO7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 09:59:20 -0500
Date: Mon, 22 Jan 2007 18:04:54 +0300
From: Evgeniy Dushistov <dushistov@mail.ru>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/3]: ufs: alloc metadata null page fix
Message-ID: <20070122150454.GA10752@rain>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These series of patches result of 
UFS1 write support stress testing, like running
fsx-linux, untar and build linux kernel etc


We pass from ufs::get_block_t to levels below:
pointer to the current page, to make possible things like
reallocation of blocks on the fly, and we also uses this pointer
for indication, what actually we allocate data block or 
meta data block,
but currently we make decision about what we allocate on
the wrong level, this may and cause oops if we allocate
blocks in some special order.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>                                                  
                                                                                                  
--- 

Index: linux-2.6.20-rc5/fs/ufs/balloc.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/ufs/balloc.c
+++ linux-2.6.20-rc5/fs/ufs/balloc.c
@@ -233,7 +233,7 @@ static void ufs_change_blocknr(struct in
 {
 	unsigned int blk_per_page = 1 << (PAGE_CACHE_SHIFT - inode->i_blkbits);
 	struct address_space *mapping = inode->i_mapping;
-	pgoff_t index, cur_index = locked_page->index;
+	pgoff_t index, cur_index;
 	unsigned int i, j;
 	struct page *page;
 	struct buffer_head *head, *bh;
@@ -241,8 +241,11 @@ static void ufs_change_blocknr(struct in
 	UFSD("ENTER, ino %lu, count %u, oldb %u, newb %u\n",
 	      inode->i_ino, count, oldb, newb);
 
+	BUG_ON(!locked_page);
 	BUG_ON(!PageLocked(locked_page));
 
+	cur_index = locked_page->index;
+
 	for (i = 0; i < count; i += blk_per_page) {
 		index = (baseblk+i) >> (PAGE_CACHE_SHIFT - inode->i_blkbits);
 
Index: linux-2.6.20-rc5/fs/ufs/inode.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/ufs/inode.c
+++ linux-2.6.20-rc5/fs/ufs/inode.c
@@ -242,7 +242,8 @@ repeat:
 			goal = tmp + uspi->s_fpb;
 		tmp = ufs_new_fragments (inode, p, fragment - blockoff, 
 					 goal, required + blockoff,
-					 err, locked_page);
+					 err,
+					 phys != NULL ? locked_page : NULL);
 	}
 	/*
 	 * We will extend last allocated block
@@ -250,7 +251,7 @@ repeat:
 	else if (lastblock == block) {
 		tmp = ufs_new_fragments(inode, p, fragment - (blockoff - lastblockoff),
 					fs32_to_cpu(sb, *p), required +  (blockoff - lastblockoff),
-					err, locked_page);
+					err, phys != NULL ? locked_page : NULL);
 	} else /* (lastblock > block) */ {
 	/*
 	 * We will allocate new block before last allocated block
@@ -261,7 +262,8 @@ repeat:
 				goal = tmp + uspi->s_fpb;
 		}
 		tmp = ufs_new_fragments(inode, p, fragment - blockoff,
-					goal, uspi->s_fpb, err, locked_page);
+					goal, uspi->s_fpb, err,
+					phys != NULL ? locked_page : NULL);
 	}
 	if (!tmp) {
 		if ((!blockoff && *p) || 
@@ -438,9 +440,11 @@ int ufs_getfrag_block(struct inode *inod
 	 * it much more readable:
 	 */
 #define GET_INODE_DATABLOCK(x) \
-	ufs_inode_getfrag(inode, x, fragment, 1, &err, &phys, &new, bh_result->b_page)
+	ufs_inode_getfrag(inode, x, fragment, 1, &err, &phys, &new,\
+			  bh_result->b_page)
 #define GET_INODE_PTR(x) \
-	ufs_inode_getfrag(inode, x, fragment, uspi->s_fpb, &err, NULL, NULL, NULL)
+	ufs_inode_getfrag(inode, x, fragment, uspi->s_fpb, &err, NULL, NULL,\
+			  bh_result->b_page)
 #define GET_INDIRECT_DATABLOCK(x) \
 	ufs_inode_getblock(inode, bh, x, fragment,	\
 			  &err, &phys, &new, bh_result->b_page)
-- 
/Evgeniy

