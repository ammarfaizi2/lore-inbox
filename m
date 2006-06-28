Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423241AbWF1JdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423241AbWF1JdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 05:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWF1JdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 05:33:05 -0400
Received: from mx2.mail.ru ([194.67.23.122]:52582 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1030487AbWF1JdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 05:33:02 -0400
Date: Wed, 28 Jun 2006 13:38:51 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH]: ufs: truncate should allocate block for last byte
Message-ID: <20060628093851.GA1719@rain.homenetwork>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
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

To make possible return error code and
to know about old size, this patch removes 
`truncate' from ufs inode_operations and
uses `setattr' method to call ufs_truncate.

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
@@ -369,24 +369,97 @@ static int ufs_trunc_tindirect (struct i
 	UFSD("EXIT\n");
 	return retry;
 }
-		
-void ufs_truncate (struct inode * inode)
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
+int ufs_truncate(struct inode *inode, loff_t old_i_size)
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
 
-	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
-		return;
+	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+	      S_ISLNK(inode->i_mode)))
+		return -EINVAL;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-		return;
+		return -EPERM;
 
-	block_truncate_page(inode->i_mapping,	inode->i_size, ufs_getfrag_block);
+	if (inode->i_size > old_i_size) {
+		/*
+		 * if we expand file we should care about
+		 * allocation of block for last byte first of all
+		 */
+		err = ufs_alloc_lastblock(inode);
+
+		if (err) {
+			i_size_write(inode, old_i_size);
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
@@ -404,9 +477,58 @@ void ufs_truncate (struct inode * inode)
 		yield();
 	}
 
+	if (inode->i_size < old_i_size) {
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
 	unlock_kernel();
 	mark_inode_dirty(inode);
-	UFSD("EXIT\n");
+out:
+	UFSD("EXIT: err %d\n", err);
+	return err;
 }
+
+
+/*
+ * We don't define our `inode->i_op->truncate', and call it here,
+ * because of:
+ * - there is no way to know old size
+ * - there is no way inform user about error, if it happens in `truncate'
+ */
+static int ufs_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = dentry->d_inode;
+	unsigned int ia_valid = attr->ia_valid;
+	int error;
+
+	error = inode_change_ok(inode, attr);
+	if (error)
+		return error;
+
+	if (ia_valid & ATTR_SIZE &&
+	    attr->ia_size != i_size_read(inode)) {
+		loff_t old_i_size = inode->i_size;
+		error = vmtruncate(inode, attr->ia_size);
+		if (error)
+			return error;
+		error = ufs_truncate(inode, old_i_size);
+		if (error)
+			return error;
+	}
+	return inode_setattr(inode, attr);
+}
+
+struct inode_operations ufs_file_inode_operations = {
+		     .setattr = ufs_setattr,
+};
Index: linux-2.6.17-mm2/fs/ufs/util.c
===================================================================
--- linux-2.6.17-mm2.orig/fs/ufs/util.c
+++ linux-2.6.17-mm2/fs/ufs/util.c
@@ -233,3 +233,57 @@ ufs_set_inode_dev(struct super_block *sb
 	else
 		ufsi->i_u1.i_data[0] = fs32;
 }
+
+/**
+ * ufs_get_locked_page() - locate, pin and lock a pagecache page, if not exist
+ * read it from disk.
+ * @mapping: the address_space to search
+ * @index: the page index
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
Index: linux-2.6.17-mm2/fs/ufs/file.c
===================================================================
--- linux-2.6.17-mm2.orig/fs/ufs/file.c
+++ linux-2.6.17-mm2/fs/ufs/file.c
@@ -60,7 +60,3 @@ const struct file_operations ufs_file_op
 	.fsync		= ufs_sync_file,
 	.sendfile	= generic_file_sendfile,
 };
-
-struct inode_operations ufs_file_inode_operations = {
-	.truncate	= ufs_truncate,
-};
Index: linux-2.6.17-mm2/fs/ufs/inode.c
===================================================================
--- linux-2.6.17-mm2.orig/fs/ufs/inode.c
+++ linux-2.6.17-mm2/fs/ufs/inode.c
@@ -841,14 +841,17 @@ int ufs_sync_inode (struct inode *inode)
 
 void ufs_delete_inode (struct inode * inode)
 {
+	loff_t old_i_size;
+
 	truncate_inode_pages(&inode->i_data, 0);
 	/*UFS_I(inode)->i_dtime = CURRENT_TIME;*/
 	lock_kernel();
 	mark_inode_dirty(inode);
 	ufs_update_inode(inode, IS_SYNC(inode));
+	old_i_size = inode->i_size;
 	inode->i_size = 0;
-	if (inode->i_blocks)
-		ufs_truncate (inode);
+	if (inode->i_blocks && ufs_truncate(inode, old_i_size))
+		ufs_warning(inode->i_sb, __FUNCTION__, "ufs_truncate failed\n");
 	ufs_free_inode (inode);
 	unlock_kernel();
 }
Index: linux-2.6.17-mm2/include/linux/ufs_fs.h
===================================================================
--- linux-2.6.17-mm2.orig/include/linux/ufs_fs.h
+++ linux-2.6.17-mm2/include/linux/ufs_fs.h
@@ -993,7 +993,7 @@ extern void ufs_panic (struct super_bloc
 extern struct inode_operations ufs_fast_symlink_inode_operations;
 
 /* truncate.c */
-extern void ufs_truncate (struct inode *);
+extern int ufs_truncate (struct inode *, loff_t);
 
 static inline struct ufs_sb_info *UFS_SB(struct super_block *sb)
 {


-- 
/Evgeniy

