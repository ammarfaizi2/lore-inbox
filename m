Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWHWGTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWHWGTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 02:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWHWGTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 02:19:16 -0400
Received: from mx1.mail.ru ([194.67.23.121]:1875 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751392AbWHWGTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 02:19:15 -0400
Date: Wed, 23 Aug 2006 10:28:32 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2]: ufs: truncate correction
Message-ID: <20060823062832.GA8380@rain>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1)When we allocated last fragment in ufs_truncate,
we read page, check if block mapped to address, and if not
trying to allocate it. This is wrong behaviour,
fragment may be NOT allocated, but mapped, this happened because of
"block map" function not checked allocated fragment or not,
it just take address of the first fragment in the block, add
offset of fragment and return result, this is correct behaviour
in almost all situation except call from ufs_truncate.

2)Almost all implementation of UFS, which I can investigate have such
"defect": if you have full disk, and try truncate file,
for example 3GB to 2MB, and have hole in this region,
truncate return -ENOSPC. I tried evade from this problem,
but "block allocation" algorithm is tied to right value of
i_lastfrag, and fix of this corner case may slow down
of ordinaries scenarios, so this patch makes behavior of "truncate"
operations similar to what other UFS implementations do.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.18-rc4-mm1/fs/ufs/truncate.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/fs/ufs/truncate.c
+++ linux-2.6.18-rc4-mm1/fs/ufs/truncate.c
@@ -375,17 +375,15 @@ static int ufs_alloc_lastblock(struct in
 	int err = 0;
 	struct address_space *mapping = inode->i_mapping;
 	struct ufs_sb_private_info *uspi = UFS_SB(inode->i_sb)->s_uspi;
-	struct ufs_inode_info *ufsi = UFS_I(inode);
 	unsigned lastfrag, i, end;
 	struct page *lastpage;
 	struct buffer_head *bh;
 
 	lastfrag = (i_size_read(inode) + uspi->s_fsize - 1) >> uspi->s_fshift;
 
-	if (!lastfrag) {
-		ufsi->i_lastfrag = 0;
+	if (!lastfrag)
 		goto out;
-	}
+
 	lastfrag--;
 
 	lastpage = ufs_get_locked_page(mapping, lastfrag >>
@@ -400,25 +398,25 @@ static int ufs_alloc_lastblock(struct in
        for (i = 0; i < end; ++i)
                bh = bh->b_this_page;
 
-       if (!buffer_mapped(bh)) {
-               err = ufs_getfrag_block(inode, lastfrag, bh, 1);
 
-               if (unlikely(err))
-                       goto out_unlock;
+       err = ufs_getfrag_block(inode, lastfrag, bh, 1);
+
+       if (unlikely(err))
+	       goto out_unlock;
 
-               if (buffer_new(bh)) {
-                       clear_buffer_new(bh);
-                       unmap_underlying_metadata(bh->b_bdev,
-						 bh->b_blocknr);
-		       /*
-			* we do not zeroize fragment, because of
-			* if it maped to hole, it already contains zeroes
-			*/
-                       set_buffer_uptodate(bh);
-                       mark_buffer_dirty(bh);
-                       set_page_dirty(lastpage);
-               }
+       if (buffer_new(bh)) {
+	       clear_buffer_new(bh);
+	       unmap_underlying_metadata(bh->b_bdev,
+					 bh->b_blocknr);
+	       /*
+		* we do not zeroize fragment, because of
+		* if it maped to hole, it already contains zeroes
+		*/
+	       set_buffer_uptodate(bh);
+	       mark_buffer_dirty(bh);
+	       set_page_dirty(lastpage);
        }
+
 out_unlock:
        ufs_put_locked_page(lastpage);
 out:
@@ -440,23 +438,11 @@ int ufs_truncate(struct inode *inode, lo
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return -EPERM;
 
-	if (inode->i_size > old_i_size) {
-		/*
-		 * if we expand file we should care about
-		 * allocation of block for last byte first of all
-		 */
-		err = ufs_alloc_lastblock(inode);
-
-		if (err) {
-			i_size_write(inode, old_i_size);
-			goto out;
-		}
-		/*
-		 * go away, because of we expand file, and we do not
-		 * need free blocks, and zeroizes page
-		 */
-		lock_kernel();
-		goto almost_end;
+	err = ufs_alloc_lastblock(inode);
+
+	if (err) {
+		i_size_write(inode, old_i_size);
+		goto out;
 	}
 
 	block_truncate_page(inode->i_mapping, inode->i_size, ufs_getfrag_block);
@@ -477,21 +463,8 @@ int ufs_truncate(struct inode *inode, lo
 		yield();
 	}
 
-	if (inode->i_size < old_i_size) {
-		/*
-		 * now we should have enough space
-		 * to allocate block for last byte
-		 */
-		err = ufs_alloc_lastblock(inode);
-		if (err)
-			/*
-			 * looks like all the same - we have no space,
-			 * but we truncate file already
-			 */
-			inode->i_size = (ufsi->i_lastfrag - 1) * uspi->s_fsize;
-	}
-almost_end:
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
+	ufsi->i_lastfrag = DIRECT_FRAGMENT;
 	unlock_kernel();
 	mark_inode_dirty(inode);
 out:

-- 
/Evgeniy

