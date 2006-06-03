Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWFCOZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWFCOZa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 10:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWFCOZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 10:25:29 -0400
Received: from mx2.mail.ru ([194.67.23.122]:15676 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1030307AbWFCOZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 10:25:14 -0400
Date: Sat, 3 Jun 2006 18:29:39 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5]: ufs: zero metadata
Message-ID: <20060603142939.GA16468@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At now if we allocate several "metadata" blocks
(pointers to indirect blocks for example), we fill
with zeroes only the first block. This cause some problems
in "truncate" function. Also this patch remove some unused
arguments from several functions and add comments.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-rc5-mm1/fs/ufs/inode.c
===================================================================
--- linux-2.6.17-rc5-mm1.orig/fs/ufs/inode.c
+++ linux-2.6.17-rc5-mm1/fs/ufs/inode.c
@@ -152,7 +152,7 @@ out:
 	return ret;
 }
 
-static void ufs_clear_block(struct inode *inode, struct buffer_head *bh)
+static void ufs_clear_frag(struct inode *inode, struct buffer_head *bh)
 {
 	lock_buffer(bh);
 	memset(bh->b_data, 0, inode->i_sb->s_blocksize);
@@ -163,27 +163,52 @@ static void ufs_clear_block(struct inode
 		sync_dirty_buffer(bh);
 }
 
-static struct buffer_head *ufs_inode_getfrag(struct inode *inode,
-					     unsigned int fragment, unsigned int new_fragment,
-					     unsigned int required, int *err, int metadata,
-					     long *phys, int *new, struct page *locked_page)
+static struct buffer_head *
+ufs_clear_frags(struct inode *inode, sector_t beg,
+		unsigned int n)
+{
+	struct buffer_head *res, *bh;
+	sector_t end = beg + n;
+
+	res = sb_getblk(inode->i_sb, beg);
+	ufs_clear_frag(inode, res);
+	for (++beg; beg < end; ++beg) {
+		bh = sb_getblk(inode->i_sb, beg);
+		ufs_clear_frag(inode, bh);
+	}
+	return res;
+}
+
+/**
+ * ufs_inode_getfrag() - allocate new fragment(s)
+ * @inode - pointer to inode
+ * @fragment - number of `fragment' which hold pointer
+ *   to new allocated fragment(s)
+ * @new_fragment - number of new allocated fragment(s)
+ * @required - how many fragment(s) we require
+ * @err - we set it if something wrong
+ * @phys - pointer to where we save physical number of new allocated fragments,
+ *   NULL if we allocate not data(indirect blocks for example).
+ * @new - we set it if we allocate new block
+ * @locked_page - for ufs_new_fragments()
+ */
+static struct buffer_head *
+ufs_inode_getfrag(struct inode *inode, unsigned int fragment,
+		  sector_t new_fragment, unsigned int required, int *err,
+		  long *phys, int *new, struct page *locked_page)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
-	struct super_block * sb;
-	struct ufs_sb_private_info * uspi;
+	struct super_block *sb = inode->i_sb;
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	struct buffer_head * result;
 	unsigned block, blockoff, lastfrag, lastblock, lastblockoff;
 	unsigned tmp, goal;
 	__fs32 * p, * p2;
-	unsigned flags = 0;
 
-	UFSD("ENTER, ino %lu, fragment %u, new_fragment %u, required %u\n",
-		inode->i_ino, fragment, new_fragment, required);
-
-	sb = inode->i_sb;
-	uspi = UFS_SB(sb)->s_uspi;
+	UFSD("ENTER, ino %lu, fragment %u, new_fragment %llu, required %u, "
+	     "metadata %d\n", inode->i_ino, fragment,
+	     (unsigned long long)new_fragment, required, !phys);
 
-	flags = UFS_SB(sb)->s_flags;
         /* TODO : to be done for write support
         if ( (flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
              goto ufs2;
@@ -198,7 +223,7 @@ repeat:
 	tmp = fs32_to_cpu(sb, *p);
 	lastfrag = ufsi->i_lastfrag;
 	if (tmp && fragment < lastfrag) {
-		if (metadata) {
+		if (!phys) {
 			result = sb_getblk(sb, uspi->s_sbbase + tmp + blockoff);
 			if (tmp == fs32_to_cpu(sb, *p)) {
 				UFSD("EXIT, result %u\n", tmp + blockoff);
@@ -265,9 +290,8 @@ repeat:
 		return NULL;
 	}
 
-	if (metadata) {
-		result = sb_getblk(inode->i_sb, tmp + blockoff);
-		ufs_clear_block(inode, result);
+	if (!phys) {
+		result = ufs_clear_frags(inode, tmp + blockoff, required);
 	} else {
 		*phys = tmp + blockoff;
 		result = NULL;
@@ -298,23 +322,35 @@ repeat2:
      */
 }
 
-static struct buffer_head *ufs_block_getfrag(struct inode *inode, struct buffer_head *bh,
-					     unsigned int fragment, unsigned int new_fragment,
-					     unsigned int blocksize, int * err, int metadata,
-					     long *phys, int *new, struct page *locked_page)
+/**
+ * ufs_inode_getblock() - allocate new block
+ * @inode - pointer to inode
+ * @bh - pointer to block which hold "pointer" to new allocated block
+ * @fragment - number of `fragment' which hold pointer
+ *   to new allocated block
+ * @new_fragment - number of new allocated fragment
+ *  (block will hold this fragment and also uspi->s_fpb-1)
+ * @err - see ufs_inode_getfrag()
+ * @phys - see ufs_inode_getfrag()
+ * @new - see ufs_inode_getfrag()
+ * @locked_page - see ufs_inode_getfrag()
+ */
+static struct buffer_head *
+ufs_inode_getblock(struct inode *inode, struct buffer_head *bh,
+		  unsigned int fragment, sector_t new_fragment, int *err,
+		  long *phys, int *new, struct page *locked_page)
 {
-	struct super_block * sb;
-	struct ufs_sb_private_info * uspi;
+	struct super_block *sb = inode->i_sb;
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	struct buffer_head * result;
 	unsigned tmp, goal, block, blockoff;
 	__fs32 * p;
 
-	sb = inode->i_sb;
-	uspi = UFS_SB(sb)->s_uspi;
 	block = ufs_fragstoblks (fragment);
 	blockoff = ufs_fragnum (fragment);
 
-	UFSD("ENTER, ino %lu, fragment %u, new_fragment %u\n", inode->i_ino, fragment, new_fragment);
+	UFSD("ENTER, ino %lu, fragment %u, new_fragment %llu, metadata %d\n",
+	     inode->i_ino, fragment, (unsigned long long)new_fragment, !phys);
 
 	result = NULL;
 	if (!bh)
@@ -330,7 +366,7 @@ static struct buffer_head *ufs_block_get
 repeat:
 	tmp = fs32_to_cpu(sb, *p);
 	if (tmp) {
-		if (metadata) {
+		if (!phys) {
 			result = sb_getblk(sb, uspi->s_sbbase + tmp + blockoff);
 			if (tmp == fs32_to_cpu(sb, *p))
 				goto out;
@@ -355,9 +391,8 @@ repeat:
 	}		
 
 
-	if (metadata) {
-		result = sb_getblk(sb, tmp + blockoff);
-		ufs_clear_block(inode, result);
+	if (!phys) {
+		result = ufs_clear_frags(inode, tmp + blockoff, uspi->s_fpb);
 	} else {
 		*phys = tmp + blockoff;
 		*new = 1;
@@ -375,11 +410,12 @@ out:
 	return result;
 }
 
-/*
- * This function gets the block which contains the fragment.
+/**
+ * ufs_getfrag_bloc() - `get_block_t' function, interface between UFS and
+ * readpage, writepage and so on
  */
 
-int ufs_getfrag_block (struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create)
+int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create)
 {
 	struct super_block * sb = inode->i_sb;
 	struct ufs_sb_private_info * uspi = UFS_SB(sb)->s_uspi;
@@ -421,15 +457,15 @@ int ufs_getfrag_block (struct inode *ino
 	 * it much more readable:
 	 */
 #define GET_INODE_DATABLOCK(x) \
-	ufs_inode_getfrag(inode, x, fragment, 1, &err, 0, &phys, &new, bh_result->b_page)
+	ufs_inode_getfrag(inode, x, fragment, 1, &err, &phys, &new, bh_result->b_page)
 #define GET_INODE_PTR(x) \
-	ufs_inode_getfrag(inode, x, fragment, uspi->s_fpb, &err, 1, NULL, NULL, bh_result->b_page)
+	ufs_inode_getfrag(inode, x, fragment, uspi->s_fpb, &err, NULL, NULL, bh_result->b_page)
 #define GET_INDIRECT_DATABLOCK(x) \
-	ufs_block_getfrag(inode, bh, x, fragment, sb->s_blocksize,	\
-			  &err, 0, &phys, &new, bh_result->b_page);
+	ufs_inode_getblock(inode, bh, x, fragment,	\
+			  &err, &phys, &new, bh_result->b_page);
 #define GET_INDIRECT_PTR(x) \
-	ufs_block_getfrag(inode, bh, x, fragment, sb->s_blocksize,	\
-			  &err, 1, NULL, NULL, bh_result->b_page);
+	ufs_inode_getblock(inode, bh, x, fragment,	\
+			  &err, NULL, NULL, bh_result->b_page);
 
 	if (ptr < UFS_NDIR_FRAGMENT) {
 		bh = GET_INODE_DATABLOCK(ptr);


-- 
/Evgeniy

