Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWENJ7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWENJ7c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 05:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWENJ7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 05:59:32 -0400
Received: from mx2.mail.ru ([194.67.23.122]:42882 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S932360AbWENJ7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 05:59:30 -0400
Date: Sun, 14 May 2006 14:02:35 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] [PATCH 3/3] ufs: change b_blocknr
Message-ID: <20060514100235.GA21341@rain.homenetwork>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because of ufs's layout, code which works with UFS should
time to time change such map "online":
physical location<-->logical inode block

Current implementation of this cause kernel "hang up" and 
damage of data.

This patch should solve this problems. It passes some tests,
but I'm not sure that it completely correct. 
The most tricky part is ufs_change_blocknr function. 
May be some one can comment this patch?

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/balloc.c linux-2.6.17-rc4/fs/ufs/balloc.c
--- linux-2.6.17-rc4-vanilla/fs/ufs/balloc.c	2006-05-14 13:46:32.236268250 +0400
+++ linux-2.6.17-rc4/fs/ufs/balloc.c	2006-05-14 13:32:36.188018500 +0400
@@ -39,7 +39,8 @@ static void ufs_clusteracct(struct super
 /*
  * Free 'count' fragments from fragment number 'fragment'
  */
-void ufs_free_fragments (struct inode * inode, unsigned fragment, unsigned count) {
+void ufs_free_fragments (struct inode * inode, unsigned fragment, unsigned count)
+{
 	struct super_block * sb;
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
@@ -134,7 +135,8 @@ failed:
 /*
  * Free 'count' fragments from fragment number 'fragment' (free whole blocks)
  */
-void ufs_free_blocks (struct inode * inode, unsigned fragment, unsigned count) {
+void ufs_free_blocks (struct inode * inode, unsigned fragment, unsigned count)
+{
 	struct super_block * sb;
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
@@ -222,15 +224,92 @@ failed:
 	return;
 }
 
+/*
+ * Modify inode page cache in such way:
+ * have - blocks with b_blocknr equal to oldb...oldb+count-1
+ * get - blocks with b_blocknr equal to newb...newb+count-1
+ * also we suppose that oldb...oldb+count-1 blocks 
+ * situated at the end of file
+ */
+static void ufs_change_blocknr(struct inode *inode, unsigned int count, 
+			       unsigned int oldb, unsigned int newb, 
+			       struct page *locked_page)
+{
+	unsigned int blk_per_page = 1UL << (PAGE_CACHE_SHIFT - inode->i_blkbits);
+	sector_t baseblk=((inode->i_size-1)>>inode->i_blkbits)+1-count;
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t cur_index=locked_page->index;
+	unsigned int i, j;
+	struct page *page;
+	struct buffer_head *head, *bh;
+
+	UFSD(("ENTER, ino %lu, count %u, oldb %u, newb %u\n", inode->i_ino, count, oldb, newb));
+
+	for (i=0; i<count; i+=blk_per_page) {
+		pgoff_t index = (baseblk+i) >> (PAGE_CACHE_SHIFT - inode->i_blkbits);
+
+		if (likely(cur_index!=index))
+			page = find_lock_page(mapping, index);
+		else
+			page = locked_page;
+
+		if (!page) {
+			page = read_cache_page(mapping, index,
+					       (filler_t*)mapping->a_ops->readpage, NULL);
+			if (IS_ERR(page)) {
+				printk(KERN_ERR "ufs_change_blocknr: read_cache_page error: "
+				       "ino %lu, index: %lu\n", inode->i_ino, index);
+				continue;
+			}
+
+			wait_on_page_locked(page);
+			
+			if (!PageUptodate(page) || PageError(page)) {
+				page_cache_release(page);
+				printk(KERN_ERR "ufs_change_blocknr: can not read page: "
+				       "ino %lu, index: %lu\n", inode->i_ino, index);
+				continue;
+			}
+		  
+			lock_page(page);
+		}
+
+		if (!page_has_buffers(page))
+			goto out;
+
+		j=i;
+		head = page_buffers(page);
+		bh = head;
+		do {
+			if (likely(bh->b_blocknr==j+oldb && j<count)) {
+				get_bh(bh);
+				lock_buffer(bh);
+				bh->b_blocknr = newb+j++;
+				mark_buffer_dirty(bh);
+				unlock_buffer(bh);
+				put_bh(bh);
+			}
+ 
+			bh = bh->b_this_page;
+		} while (bh != head);
+ 
+		__set_page_dirty_buffers(page);
+	out:
+		if (likely(cur_index!=index)) {
+			unlock_page(page);
+			page_cache_release(page);
+		}
+ 	}
+	UFSD(("EXIT\n"));
+}
 
-unsigned ufs_new_fragments (struct inode * inode, __fs32 * p, unsigned fragment,
-	unsigned goal, unsigned count, int * err )
+unsigned ufs_new_fragments(struct inode * inode, __fs32 * p, unsigned fragment,
+			   unsigned goal, unsigned count, int * err, struct page *locked_page)
 {
 	struct super_block * sb;
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
-	struct buffer_head * bh;
-	unsigned cgno, oldcount, newcount, tmp, request, i, result;
+	unsigned cgno, oldcount, newcount, tmp, request, result;
 	
 	UFSD(("ENTER, ino %lu, fragment %u, goal %u, count %u\n", inode->i_ino, fragment, goal, count))
 	
@@ -343,24 +422,8 @@ unsigned ufs_new_fragments (struct inode
 	}
 	result = ufs_alloc_fragments (inode, cgno, goal, request, err);
 	if (result) {
-		for (i = 0; i < oldcount; i++) {
-			bh = sb_bread(sb, tmp + i);
-			if(bh)
-			{
-				clear_buffer_dirty(bh);
-				bh->b_blocknr = result + i;
-				mark_buffer_dirty (bh);
-				if (IS_SYNC(inode))
-					sync_dirty_buffer(bh);
-				brelse (bh);
-			}
-			else
-			{
-				printk(KERN_ERR "ufs_new_fragments: bread fail\n");
-				unlock_super(sb);
-				return 0;
-			}
-		}
+		ufs_change_blocknr(inode, oldcount, tmp, result, locked_page);
+
 		*p = cpu_to_fs32(sb, result);
 		*err = 0;
 		inode->i_blocks += count << uspi->s_nspfshift;
diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/inode.c linux-2.6.17-rc4/fs/ufs/inode.c
--- linux-2.6.17-rc4-vanilla/fs/ufs/inode.c	2006-05-14 13:46:32.248269000 +0400
+++ linux-2.6.17-rc4/fs/ufs/inode.c	2006-05-14 11:12:38.399189500 +0400
@@ -173,9 +173,10 @@ static inline void ufs_clear_block(struc
 }
 
 
-static struct buffer_head * ufs_inode_getfrag (struct inode *inode,
-	unsigned int fragment, unsigned int new_fragment,
-	unsigned int required, int *err, int metadata, long *phys, int *new)
+static struct buffer_head *ufs_inode_getfrag(struct inode *inode,
+					     unsigned int fragment, unsigned int new_fragment,
+					     unsigned int required, int *err, int metadata, 
+					     long *phys, int *new, struct page *locked_page)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
 	struct super_block * sb;
@@ -233,7 +234,8 @@ repeat:
 		if (lastblockoff) {
 			p2 = ufsi->i_u1.i_data + lastblock;
 			tmp = ufs_new_fragments (inode, p2, lastfrag, 
-				fs32_to_cpu(sb, *p2), uspi->s_fpb - lastblockoff, err);
+						 fs32_to_cpu(sb, *p2), uspi->s_fpb - lastblockoff, 
+						 err, locked_page);
 			if (!tmp) {
 				if (lastfrag != ufsi->i_lastfrag)
 					goto repeat;
@@ -245,14 +247,16 @@ repeat:
 		}
 		goal = fs32_to_cpu(sb, ufsi->i_u1.i_data[lastblock]) + uspi->s_fpb;
 		tmp = ufs_new_fragments (inode, p, fragment - blockoff, 
-			goal, required + blockoff, err);
+					 goal, required + blockoff, 
+					 err, locked_page);
 	}
 	/*
 	 * We will extend last allocated block
 	 */
 	else if (lastblock == block) {
-		tmp = ufs_new_fragments (inode, p, fragment - (blockoff - lastblockoff),
-			fs32_to_cpu(sb, *p), required +  (blockoff - lastblockoff), err);
+		tmp = ufs_new_fragments(inode, p, fragment - (blockoff - lastblockoff),
+					fs32_to_cpu(sb, *p), required +  (blockoff - lastblockoff), 
+					err, locked_page);
 	}
 	/*
 	 * We will allocate new block before last allocated block
@@ -260,8 +264,8 @@ repeat:
 	else /* (lastblock > block) */ {
 		if (lastblock && (tmp = fs32_to_cpu(sb, ufsi->i_u1.i_data[lastblock-1])))
 			goal = tmp + uspi->s_fpb;
-		tmp = ufs_new_fragments (inode, p, fragment - blockoff, 
-			goal, uspi->s_fpb, err);
+		tmp = ufs_new_fragments(inode, p, fragment - blockoff, 
+					goal, uspi->s_fpb, err, locked_page);
 	}
 	if (!tmp) {
 		if ((!blockoff && *p) || 
@@ -304,9 +308,10 @@ repeat2:
      */
 }
 
-static struct buffer_head * ufs_block_getfrag (struct inode *inode,
-	struct buffer_head *bh, unsigned int fragment, unsigned int new_fragment, 
-	unsigned int blocksize, int * err, int metadata, long *phys, int *new)
+static struct buffer_head *ufs_block_getfrag(struct inode *inode, struct buffer_head *bh, 
+					     unsigned int fragment, unsigned int new_fragment, 
+					     unsigned int blocksize, int * err, int metadata, 
+					     long *phys, int *new, struct page *locked_page)
 {
 	struct super_block * sb;
 	struct ufs_sb_private_info * uspi;
@@ -351,7 +356,8 @@ repeat:
 		goal = tmp + uspi->s_fpb;
 	else
 		goal = bh->b_blocknr + uspi->s_fpb;
-	tmp = ufs_new_fragments (inode, p, ufs_blknum(new_fragment), goal, uspi->s_fpb, err);
+	tmp = ufs_new_fragments(inode, p, ufs_blknum(new_fragment), goal, 
+				uspi->s_fpb, err, locked_page);
 	if (!tmp) {
 		if (fs32_to_cpu(sb, *p))
 			goto repeat;
@@ -425,15 +431,15 @@ int ufs_getfrag_block (struct inode *ino
 	 * it much more readable:
 	 */
 #define GET_INODE_DATABLOCK(x) \
-		ufs_inode_getfrag(inode, x, fragment, 1, &err, 0, &phys, &new)
+	ufs_inode_getfrag(inode, x, fragment, 1, &err, 0, &phys, &new, bh_result->b_page)
 #define GET_INODE_PTR(x) \
-		ufs_inode_getfrag(inode, x, fragment, uspi->s_fpb, &err, 1, NULL, NULL)
+	ufs_inode_getfrag(inode, x, fragment, uspi->s_fpb, &err, 1, NULL, NULL, bh_result->b_page)
 #define GET_INDIRECT_DATABLOCK(x) \
-		ufs_block_getfrag(inode, bh, x, fragment, sb->s_blocksize, \
-				  &err, 0, &phys, &new);
+	ufs_block_getfrag(inode, bh, x, fragment, sb->s_blocksize,	\
+			  &err, 0, &phys, &new, bh_result->b_page);
 #define GET_INDIRECT_PTR(x) \
-		ufs_block_getfrag(inode, bh, x, fragment, sb->s_blocksize, \
-				  &err, 1, NULL, NULL);
+	ufs_block_getfrag(inode, bh, x, fragment, sb->s_blocksize,	\
+			  &err, 1, NULL, NULL, bh_result->b_page);
 
 	if (ptr < UFS_NDIR_FRAGMENT) {
 		bh = GET_INODE_DATABLOCK(ptr);
diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/include/linux/ufs_fs.h linux-2.6.17-rc4/include/linux/ufs_fs.h
--- linux-2.6.17-rc4-vanilla/include/linux/ufs_fs.h	2006-05-14 13:45:37.888871750 +0400
+++ linux-2.6.17-rc4/include/linux/ufs_fs.h	2006-05-14 11:12:38.407190000 +0400
@@ -876,7 +876,8 @@ struct ufs_super_block_third {
 /* balloc.c */
 extern void ufs_free_fragments (struct inode *, unsigned, unsigned);
 extern void ufs_free_blocks (struct inode *, unsigned, unsigned);
-extern unsigned ufs_new_fragments (struct inode *, __fs32 *, unsigned, unsigned, unsigned, int *);
+extern unsigned ufs_new_fragments(struct inode *, __fs32 *, unsigned, unsigned, 
+				  unsigned, int *, struct page *);
 
 /* cylinder.c */
 extern struct ufs_cg_private_info * ufs_load_cylinder (struct super_block *, unsigned);

-- 
/Evgeniy

