Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131568AbQL1U7I>; Thu, 28 Dec 2000 15:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131256AbQL1U66>; Thu, 28 Dec 2000 15:58:58 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:28945 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131593AbQL1U6o>; Thu, 28 Dec 2000 15:58:44 -0500
Date: Thu, 28 Dec 2000 16:35:21 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Juan Quintela <quintela@fi.udc.es>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] remove __mark_buffer_dirty and related changes
In-Reply-To: <Pine.LNX.4.10.10012281022560.12064-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012281627060.12364-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Dec 2000, Linus Torvalds wrote:

> I would actually prefer not having the balance_dirty() in
> mark_buffer_dirty() at all, and then just potentially adding an explicit
> balance_dirty to strategic places. There would probably not be that many
> of those strategic places.
> 
> As it stands, this is a bit too subtle for my taste, having people who
> sleep without really realizing it, and not necessarily really wanting to
> (not for correctness issues, but for latency issues - that superblock lock
> can be quite nasty)

Linus, here is a patch which:

 - removes __mark_buffer_dirty() 
 - makes mark_buffer_dirty() return the old dirty bit on the buffer
 - changes mark_buffer_dirty_inode() to return the value returned by
mark_buffer_dirty
   - changes all calls to mark_buffer_dirty_inode() (on ext2) to
balance_dirty() in case the return value of mark_buffer_dirty_inode() is
1.

Juan Quintela is going to send a patch which calls balance_dirty() after
unlocking the superblock lock on various places on ext2 as soon as he
finds time to.

Comments?


diff -Nur linux.orig/fs/block_dev.c linux/fs/block_dev.c
--- linux.orig/fs/block_dev.c	Thu Dec 28 17:42:14 2000
+++ linux/fs/block_dev.c	Thu Dec 28 17:55:03 2000
@@ -129,7 +129,8 @@
 		p += chars;
 		buf += chars;
 		mark_buffer_uptodate(bh, 1);
-		mark_buffer_dirty(bh);
+		if (mark_buffer_dirty(bh))
+			balance_dirty(dev);
 		if (filp->f_flags & O_SYNC)
 			bufferlist[buffercount++] = bh;
 		else
@@ -144,7 +145,6 @@
 			}
 			buffercount=0;
 		}
-		balance_dirty(dev);
 		if (write_error)
 			break;
 	}
diff -Nur linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Thu Dec 28 17:42:14 2000
+++ linux/fs/buffer.c	Thu Dec 28 17:49:17 2000
@@ -1078,16 +1078,13 @@
 
 /* atomic version, the user must call balance_dirty() by hand
    as soon as it become possible to block */
-void __mark_buffer_dirty(struct buffer_head *bh)
+int mark_buffer_dirty(struct buffer_head *bh)
 {
-	if (!atomic_set_buffer_dirty(bh))
+	if (!atomic_set_buffer_dirty(bh)) {
 		__mark_dirty(bh);
-}
-
-void mark_buffer_dirty(struct buffer_head *bh)
-{
-	__mark_buffer_dirty(bh);
-	balance_dirty(bh->b_dev);
+		return 1;
+	}
+	return 0;
 }
 
 /*
@@ -1851,7 +1848,7 @@
 	struct inode *inode = (struct inode *)mapping->host;
 	struct page *page;
 	struct buffer_head *bh;
-	int err;
+	int err, need_balance = 0;
 
 	blocksize = inode->i_sb->s_blocksize;
 	length = offset & (blocksize - 1);
@@ -1908,12 +1905,14 @@
 	flush_dcache_page(page);
 	kunmap(page);
 
-	mark_buffer_dirty(bh);
+	need_balance = mark_buffer_dirty(bh);
 	err = 0;
 
 unlock:
 	UnlockPage(page);
 	page_cache_release(page);
+	if (need_balance)
+		balance_dirty(bh->b_dev);
 out:
 	return err;
 }
diff -Nur linux.orig/fs/ext2/inode.c linux/fs/ext2/inode.c
--- linux.orig/fs/ext2/inode.c	Thu Dec 28 17:42:14 2000
+++ linux/fs/ext2/inode.c	Thu Dec 28 17:52:49 2000
@@ -404,7 +404,8 @@
 		branch[n].p = (u32*) bh->b_data + offsets[n];
 		*branch[n].p = branch[n].key;
 		mark_buffer_uptodate(bh, 1);
-		mark_buffer_dirty_inode(bh, inode);
+		if (mark_buffer_dirty_inode(bh, inode))
+			balance_dirty(bh->b_dev);
 		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync) {
 			ll_rw_block (WRITE, 1, &bh);
 			wait_on_buffer (bh);
@@ -469,7 +470,8 @@
 
 	/* had we spliced it onto indirect block? */
 	if (where->bh) {
-		mark_buffer_dirty_inode(where->bh, inode);
+		if (mark_buffer_dirty_inode(where->bh, inode))
+			balance_dirty(where->bh->b_dev);
 		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync) {
 			ll_rw_block (WRITE, 1, &where->bh);
 			wait_on_buffer(where->bh);
@@ -591,7 +593,8 @@
 				wait_on_buffer(bh);
 			memset(bh->b_data, 0, inode->i_sb->s_blocksize);
 			mark_buffer_uptodate(bh, 1);
-			mark_buffer_dirty_inode(bh, inode);
+			if (mark_buffer_dirty_inode(bh, inode))
+				balance_dirty(bh->b_dev);
 		}
 		return bh;
 	}
@@ -907,7 +910,8 @@
 		if (partial == chain)
 			mark_inode_dirty(inode);
 		else
-			mark_buffer_dirty_inode(partial->bh, inode);
+			if (mark_buffer_dirty_inode(partial->bh, inode))
+				balance_dirty(partial->bh->b_dev);
 		ext2_free_branches(inode, &nr, &nr+1, (chain+n-1) - partial);
 	}
 	/* Clear the ends of indirect blocks on the shared branch */
@@ -916,7 +920,8 @@
 				   partial->p + 1,
 				   (u32*)partial->bh->b_data + addr_per_block,
 				   (chain+n-1) - partial);
-		mark_buffer_dirty_inode(partial->bh, inode);
+		if (mark_buffer_dirty_inode(partial->bh, inode))
+			balance_dirty(partial->bh->b_dev);
 		if (IS_SYNC(inode)) {
 			ll_rw_block (WRITE, 1, &partial->bh);
 			wait_on_buffer (partial->bh);
@@ -1208,7 +1213,8 @@
 		raw_inode->i_block[0] = cpu_to_le32(kdev_t_to_nr(inode->i_rdev));
 	else for (block = 0; block < EXT2_N_BLOCKS; block++)
 		raw_inode->i_block[block] = inode->u.ext2_i.i_data[block];
-	mark_buffer_dirty(bh);
+	if (mark_buffer_dirty(bh))
+		balance_dirty(bh->b_dev);
 	if (do_sync) {
 		ll_rw_block (WRITE, 1, &bh);
 		wait_on_buffer (bh);
diff -Nur linux.orig/fs/ext2/namei.c linux/fs/ext2/namei.c
--- linux.orig/fs/ext2/namei.c	Thu Dec 28 17:42:14 2000
+++ linux/fs/ext2/namei.c	Thu Dec 28 17:54:11 2000
@@ -296,7 +296,8 @@
 			dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
 			mark_inode_dirty(dir);
 			dir->i_version = ++event;
-			mark_buffer_dirty_inode(bh, dir);
+			if (mark_buffer_dirty_inode(bh, dir))
+				balance_dirty(bh->b_dev);
 			if (IS_SYNC(dir)) {
 				ll_rw_block (WRITE, 1, &bh);
 				wait_on_buffer (bh);
@@ -337,7 +338,8 @@
 			else
 				de->inode = 0;
 			dir->i_version = ++event;
-			mark_buffer_dirty_inode(bh, dir);
+			if (mark_buffer_dirty_inode(bh, dir))
+				balance_dirty(bh->b_dev);
 			if (IS_SYNC(dir)) {
 				ll_rw_block (WRITE, 1, &bh);
 				wait_on_buffer (bh);
@@ -447,7 +449,8 @@
 	strcpy (de->name, "..");
 	ext2_set_de_type(dir->i_sb, de, S_IFDIR);
 	inode->i_nlink = 2;
-	mark_buffer_dirty_inode(dir_block, dir);
+	if (mark_buffer_dirty_inode(dir_block, dir))
+		balance_dirty(dir_block->b_dev);
 	brelse (dir_block);
 	inode->i_mode = S_IFDIR | mode;
 	if (dir->i_mode & S_ISGID)
@@ -755,7 +758,8 @@
 					      EXT2_FEATURE_INCOMPAT_FILETYPE))
 			new_de->file_type = old_de->file_type;
 		new_dir->i_version = ++event;
-		mark_buffer_dirty_inode(new_bh, new_dir);
+		if (mark_buffer_dirty_inode(new_bh, new_dir))
+			balance_dirty(new_bh->b_dev);
 		if (IS_SYNC(new_dir)) {
 			ll_rw_block (WRITE, 1, &new_bh);
 			wait_on_buffer (new_bh);
@@ -786,7 +790,8 @@
 	mark_inode_dirty(old_dir);
 	if (dir_bh) {
 		PARENT_INO(dir_bh->b_data) = le32_to_cpu(new_dir->i_ino);
-		mark_buffer_dirty_inode(dir_bh, old_inode);
+		if (mark_buffer_dirty_inode(dir_bh, old_inode))
+			balance_dirty(dir_bh->b_dev);
 		old_dir->i_nlink--;
 		mark_inode_dirty(old_dir);
 		if (new_inode) {
diff -Nur linux.orig/include/linux/fs.h linux/include/linux/fs.h
--- linux.orig/include/linux/fs.h	Thu Dec 28 17:42:18 2000
+++ linux/include/linux/fs.h	Thu Dec 28 17:49:46 2000
@@ -1019,8 +1019,7 @@
 		__mark_buffer_protected(bh);
 }
 
-extern void FASTCALL(__mark_buffer_dirty(struct buffer_head *bh));
-extern void FASTCALL(mark_buffer_dirty(struct buffer_head *bh));
+extern int FASTCALL(mark_buffer_dirty(struct buffer_head *bh));
 
 #define atomic_set_buffer_dirty(bh) test_and_set_bit(BH_Dirty, &(bh)->b_state)
 
@@ -1040,10 +1039,11 @@
 }
 
 extern void buffer_insert_inode_queue(struct buffer_head *, struct inode *);
-static inline void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
+static inline int mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 {
-	mark_buffer_dirty(bh);
+	int ret = mark_buffer_dirty(bh);
 	buffer_insert_inode_queue(bh, inode);
+	return ret;
 }
 
 extern void balance_dirty(kdev_t);
--- linux.orig/kernel/ksyms.c	Thu Dec 28 17:42:17 2000
+++ linux/kernel/ksyms.c	Thu Dec 28 18:14:44 2000
@@ -159,7 +159,6 @@
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(__d_path);
 EXPORT_SYMBOL(mark_buffer_dirty);
-EXPORT_SYMBOL(__mark_buffer_dirty);
 EXPORT_SYMBOL(__mark_inode_dirty);
 EXPORT_SYMBOL(get_empty_filp);
 EXPORT_SYMBOL(init_private_file);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
