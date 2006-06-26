Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWFZNnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWFZNnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWFZNnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:43:19 -0400
Received: from mx1.mail.ru ([194.67.23.121]:60783 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1030197AbWFZNnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:43:17 -0400
Date: Mon, 26 Jun 2006 17:49:06 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] [PATCH 3/3]: ufs: allocate last block in ufs_truncate
Message-ID: <20060626134906.GA8469@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes buggy behaviour of UFS 
in such kind of scenario:
open(, O_TRUNC...)
ftruncate(, 1024)
ftruncate(, 0)

such scenario causes ufs_panic and remount read-only.
This happen because of according to specification
UFS should always allocate block for last byte,
and many parts of our implementation rely on this,
but `ufs_truncate' doesn't care about this.

In `ufs_truncate' I make several assumptions about
VFS service functions behaviour, may be I missed something,
see patch bellow.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-mm2/fs/ufs/balloc.c
===================================================================
--- linux-2.6.17-mm2.orig/fs/ufs/balloc.c
+++ linux-2.6.17-mm2/fs/ufs/balloc.c
@@ -217,48 +217,6 @@ failed:
 	return;
 }
 
-static struct page *ufs_get_locked_page(struct address_space *mapping,
-				  unsigned long index)
-{
-	struct page *page;
-
-try_again:
-	page = find_lock_page(mapping, index);
-	if (!page) {
-		page = read_cache_page(mapping, index,
-				       (filler_t*)mapping->a_ops->readpage,
-				       NULL);
-		if (IS_ERR(page)) {
-			printk(KERN_ERR "ufs_change_blocknr: "
-			       "read_cache_page error: ino %lu, index: %lu\n",
-			       mapping->host->i_ino, index);
-			goto out;
-		}
-
-		lock_page(page);
-
-		if (!PageUptodate(page) || PageError(page)) {
-			unlock_page(page);
-			page_cache_release(page);
-
-			printk(KERN_ERR "ufs_change_blocknr: "
-			       "can not read page: ino %lu, index: %lu\n",
-			       mapping->host->i_ino, index);
-
-			page = ERR_PTR(-EIO);
-			goto out;
-		}
-	}
-
-	if (unlikely(!page->mapping || !page_has_buffers(page))) {
-		unlock_page(page);
-		page_cache_release(page);
-		goto try_again;/*we really need these buffers*/
-	}
-out:
-	return page;
-}
-
 /*
  * Modify inode page cache in such way:
  * have - blocks with b_blocknr equal to oldb...oldb+count-1
@@ -311,10 +269,8 @@ static void ufs_change_blocknr(struct in
 
 		set_page_dirty(page);
 
-		if (likely(cur_index != index)) {
-			unlock_page(page);
-			page_cache_release(page);
-		}
+		if (likely(cur_index != index))
+			ufs_put_locked_page(page);
  	}
 	UFSD("EXIT\n");
 }
Index: linux-2.6.17-mm2/fs/ufs/truncate.c
===================================================================
--- linux-2.6.17-mm2.orig/fs/ufs/truncate.c
+++ linux-2.6.17-mm2/fs/ufs/truncate.c
@@ -369,24 +369,96 @@ static int ufs_trunc_tindirect (struct i
 	UFSD("EXIT\n");
 	return retry;
 }
-		
+
+static int ufs_alloc_lastblock(struct inode *inode)
+{
+	int err = 0;
+	struct address_space *mapping = inode->i_mapping;
+	struct ufs_sb_private_info *uspi = UFS_SB(inode->i_sb)->s_uspi;
+	struct ufs_inode_info *ufsi = UFS_I(inode);
+	unsigned lastfrag, i, end;
+	struct page *lastpage;
+	struct buffer_head *bh;
+
+	lastfrag = (i_size_read(inode) + uspi->s_fsize - 1) >> uspi->s_fshift;
+
+	if (!lastfrag) {
+		ufsi->i_lastfrag = 0;
+		goto out;
+	}
+	lastfrag--;
+
+	lastpage = ufs_get_locked_page(mapping, lastfrag >>
+				       (PAGE_CACHE_SHIFT - inode->i_blkbits));
+       if (IS_ERR(lastpage)) {
+               err = -EIO;
+               goto out;
+       }
+
+       end = lastfrag & ((1 << (PAGE_CACHE_SHIFT - inode->i_blkbits)) - 1);
+       bh = page_buffers(lastpage);
+       for (i = 0; i < end; ++i)
+               bh = bh->b_this_page;
+
+       if (!buffer_mapped(bh)) {
+               err = ufs_getfrag_block(inode, lastfrag, bh, 1);
+
+               if (unlikely(err))
+                       goto out_unlock;
+
+               if (buffer_new(bh)) {
+                       clear_buffer_new(bh);
+                       unmap_underlying_metadata(bh->b_bdev,
+						 bh->b_blocknr);
+		       /*
+			* we do not zeroize fragment, because of
+			* if it maped to hole, it already contains zeroes
+			*/
+                       set_buffer_uptodate(bh);
+                       mark_buffer_dirty(bh);
+                       set_page_dirty(lastpage);
+               }
+       }
+out_unlock:
+       ufs_put_locked_page(lastpage);
+out:
+       return err;
+}
+
 void ufs_truncate (struct inode * inode)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
-	struct super_block * sb;
-	struct ufs_sb_private_info * uspi;
-	int retry;
+	struct super_block *sb = inode->i_sb;
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
+	int retry, err = 0;
 	
 	UFSD("ENTER\n");
-	sb = inode->i_sb;
-	uspi = UFS_SB(sb)->s_uspi;
 
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
 		return;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
 
-	block_truncate_page(inode->i_mapping,	inode->i_size, ufs_getfrag_block);
+	if (inode->i_size > ufsi->i_size) {
+		/*
+		 * if we expand file we should care about
+		 * allocation of block for last byte first of all
+		 */
+		err = ufs_alloc_lastblock(inode);
+
+		if (err) {
+			i_size_write(inode, ufsi->i_size);
+			goto out;
+		}
+		/*
+		 * go away, because of we expand file, and we do not
+		 * need free blocks, and zeroizes page
+		 */
+		lock_kernel();
+		goto almost_end;
+	}
+
+	block_truncate_page(inode->i_mapping, inode->i_size, ufs_getfrag_block);
 
 	lock_kernel();
 	while (1) {
@@ -404,9 +476,27 @@ void ufs_truncate (struct inode * inode)
 		yield();
 	}
 
+	if (inode->i_size < ufsi->i_size) {
+		/*
+		 * now we should have enough space
+		 * to allocate block for last byte
+		 */
+		err = ufs_alloc_lastblock(inode);
+		if (err)
+			/*
+			 * looks like all the same - we have no space,
+			 * but we truncate file already
+			 */
+			inode->i_size = (ufsi->i_lastfrag - 1) * uspi->s_fsize;
+	}
+almost_end:
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
-	ufsi->i_lastfrag = DIRECT_FRAGMENT;
+	ufsi->i_size = inode->i_size;
 	unlock_kernel();
 	mark_inode_dirty(inode);
+out:
+	if (err)
+		ufs_warning(sb, __FUNCTION__, "FAILED, error code: %d\n", err);
+
 	UFSD("EXIT\n");
 }
Index: linux-2.6.17-mm2/fs/ufs/util.c
===================================================================
--- linux-2.6.17-mm2.orig/fs/ufs/util.c
+++ linux-2.6.17-mm2/fs/ufs/util.c
@@ -233,3 +233,56 @@ ufs_set_inode_dev(struct super_block *sb
 	else
 		ufsi->i_u1.i_data[0] = fs32;
 }
+
+/**
+ * ufs_get_locked_page() - locate, pin and lock a pagecache page, if not exist
+ * read it from disk.
+ * @mapping: the address_space to search
+ *
+ * Locates the desired pagecache page, if not exist we'll read it,
+ * locks it, increments its reference
+ * count and returns its address.
+ *
+ */
+
+struct page *ufs_get_locked_page(struct address_space *mapping,
+				 pgoff_t index)
+{
+	struct page *page;
+
+try_again:
+	page = find_lock_page(mapping, index);
+	if (!page) {
+		page = read_cache_page(mapping, index,
+				       (filler_t*)mapping->a_ops->readpage,
+				       NULL);
+		if (IS_ERR(page)) {
+			printk(KERN_ERR "ufs_change_blocknr: "
+			       "read_cache_page error: ino %lu, index: %lu\n",
+			       mapping->host->i_ino, index);
+			goto out;
+		}
+
+		lock_page(page);
+
+		if (!PageUptodate(page) || PageError(page)) {
+			unlock_page(page);
+			page_cache_release(page);
+
+			printk(KERN_ERR "ufs_change_blocknr: "
+			       "can not read page: ino %lu, index: %lu\n",
+			       mapping->host->i_ino, index);
+
+			page = ERR_PTR(-EIO);
+			goto out;
+		}
+	}
+
+	if (unlikely(!page->mapping || !page_has_buffers(page))) {
+		unlock_page(page);
+		page_cache_release(page);
+		goto try_again;/*we really need these buffers*/
+	}
+out:
+	return page;
+}
Index: linux-2.6.17-mm2/fs/ufs/util.h
===================================================================
--- linux-2.6.17-mm2.orig/fs/ufs/util.h
+++ linux-2.6.17-mm2/fs/ufs/util.h
@@ -251,6 +251,14 @@ extern void _ubh_ubhcpymem_(struct ufs_s
 #define ubh_memcpyubh(ubh,mem,size) _ubh_memcpyubh_(uspi,ubh,mem,size)
 extern void _ubh_memcpyubh_(struct ufs_sb_private_info *, struct ufs_buffer_head *, unsigned char *, unsigned);
 
+/* This functions works with cache pages*/
+extern struct page *ufs_get_locked_page(struct address_space *mapping,
+					pgoff_t index);
+static inline void ufs_put_locked_page(struct page *page)
+{
+       unlock_page(page);
+       page_cache_release(page);
+}
 
 
 /*

-- 
/Evgeniy

