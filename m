Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbQKVMAN>; Wed, 22 Nov 2000 07:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131468AbQKVMAD>; Wed, 22 Nov 2000 07:00:03 -0500
Received: from zeus.kernel.org ([209.10.41.242]:22287 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129259AbQKVL7m>;
	Wed, 22 Nov 2000 06:59:42 -0500
Date: Wed, 22 Nov 2000 11:26:46 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>
Subject: [patch] O_SYNC patch 3/3, add inode dirty buffer list support to ext2
Message-ID: <20001122112646.D6516@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This final part of the O_SYNC patches adds calls to ext2, and to
generic_commit_write, to record dirty buffers against the owning
inode.  It also removes most of fs/ext2/fsync.c, which now simply
calls the generic sync code.

--Stephen

2.4.0test11.02.ext2-osync.diff :


--- linux-2.4.0-test11/fs/buffer.c.~1~	Tue Nov 21 15:51:17 2000
+++ linux-2.4.0-test11/fs/buffer.c	Tue Nov 21 16:35:35 2000
@@ -1727,6 +1727,7 @@
 			set_bit(BH_Uptodate, &bh->b_state);
 			if (!atomic_set_buffer_dirty(bh)) {
 				__mark_dirty(bh);
+				buffer_insert_inode_queue(bh, inode);
 				need_balance_dirty = 1;
 			}
 		}
--- linux-2.4.0-test11/fs/ext2/fsync.c.~1~	Tue Nov 21 15:47:48 2000
+++ linux-2.4.0-test11/fs/ext2/fsync.c	Tue Nov 21 16:01:15 2000
@@ -28,98 +28,6 @@
 #include <linux/smp_lock.h>
 
 
-#define blocksize	(EXT2_BLOCK_SIZE(inode->i_sb))
-#define addr_per_block	(EXT2_ADDR_PER_BLOCK(inode->i_sb))
-
-static int sync_indirect(struct inode * inode, u32 * block, int wait)
-{
-	struct buffer_head * bh;
-	
-	if (!*block)
-		return 0;
-	bh = get_hash_table(inode->i_dev, le32_to_cpu(*block), blocksize);
-	if (!bh)
-		return 0;
-	if (wait && buffer_req(bh) && !buffer_uptodate(bh)) {
-		/* There can be a parallell read(2) that started read-I/O
-		   on the buffer so we can't assume that there's been
-		   an I/O error without first waiting I/O completation. */
-		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh))
-		{
-			brelse (bh);
-			return -1;
-		}
-	}
-	if (wait || !buffer_uptodate(bh) || !buffer_dirty(bh)) {
-		if (wait)
-			/* when we return from fsync all the blocks
-			   must be _just_ stored on disk */
-			wait_on_buffer(bh);
-		brelse(bh);
-		return 0;
-	}
-	ll_rw_block(WRITE, 1, &bh);
-	atomic_dec(&bh->b_count);
-	return 0;
-}
-
-static int sync_iblock(struct inode * inode, u32 * iblock, 
-			struct buffer_head ** bh, int wait) 
-{
-	int rc, tmp;
-	
-	*bh = NULL;
-	tmp = le32_to_cpu(*iblock);
-	if (!tmp)
-		return 0;
-	rc = sync_indirect(inode, iblock, wait);
-	if (rc)
-		return rc;
-	*bh = bread(inode->i_dev, tmp, blocksize);
-	if (!*bh)
-		return -1;
-	return 0;
-}
-
-static int sync_dindirect(struct inode * inode, u32 * diblock, int wait)
-{
-	int i;
-	struct buffer_head * dind_bh;
-	int rc, err = 0;
-
-	rc = sync_iblock(inode, diblock, &dind_bh, wait);
-	if (rc || !dind_bh)
-		return rc;
-	
-	for (i = 0; i < addr_per_block; i++) {
-		rc = sync_indirect(inode, ((u32 *) dind_bh->b_data) + i, wait);
-		if (rc)
-			err = rc;
-	}
-	brelse(dind_bh);
-	return err;
-}
-
-static int sync_tindirect(struct inode * inode, u32 * tiblock, int wait)
-{
-	int i;
-	struct buffer_head * tind_bh;
-	int rc, err = 0;
-
-	rc = sync_iblock(inode, tiblock, &tind_bh, wait);
-	if (rc || !tind_bh)
-		return rc;
-	
-	for (i = 0; i < addr_per_block; i++) {
-		rc = sync_dindirect(inode, ((u32 *) tind_bh->b_data) + i, wait);
-		if (rc)
-			err = rc;
-	}
-	brelse(tind_bh);
-	return err;
-}
-
 /*
  *	File may be NULL when we are called. Perhaps we shouldn't
  *	even pass file to fsync ?
@@ -127,34 +35,20 @@
 
 int ext2_sync_file(struct file * file, struct dentry *dentry, int datasync)
 {
-	int wait, err = 0;
 	struct inode *inode = dentry->d_inode;
+	return ext2_fsync_inode(inode, datasync);
+}
 
-	lock_kernel();
-	if (S_ISLNK(inode->i_mode) && !(inode->i_blocks))
-		/*
-		 * Don't sync fast links!
-		 */
-		goto skip;
-
-	err = generic_buffer_fdatasync(inode, 0, ~0UL);
-
-	for (wait=0; wait<=1; wait++)
-	{
-		err |= sync_indirect(inode,
-				     inode->u.ext2_i.i_data+EXT2_IND_BLOCK,
-				     wait);
-		err |= sync_dindirect(inode,
-				      inode->u.ext2_i.i_data+EXT2_DIND_BLOCK, 
-				      wait);
-		err |= sync_tindirect(inode, 
-				      inode->u.ext2_i.i_data+EXT2_TIND_BLOCK, 
-				      wait);
-	}
-skip:
-	if ((inode->i_state & I_DIRTY_DATASYNC) || 
-	    ((inode->i_state & I_DIRTY) && !datasync))
-		err |= ext2_sync_inode (inode);
-	unlock_kernel();
+int ext2_fsync_inode(struct inode *inode, int datasync)
+{
+	int err;
+	
+	err  = fsync_inode_buffers(inode);
+	if (!(inode->i_state & I_DIRTY))
+		return err;
+	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+		return err;
+	
+	err |= ext2_sync_inode(inode);
 	return err ? -EIO : 0;
 }
--- linux-2.4.0-test11/fs/ext2/inode.c.~1~	Tue Nov 21 15:40:22 2000
+++ linux-2.4.0-test11/fs/ext2/inode.c	Tue Nov 21 16:01:15 2000
@@ -404,7 +404,7 @@
 		branch[n].p = (u32*) bh->b_data + offsets[n];
 		*branch[n].p = branch[n].key;
 		mark_buffer_uptodate(bh, 1);
-		mark_buffer_dirty(bh);
+		mark_buffer_dirty_inode(bh, inode);
 		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync) {
 			ll_rw_block (WRITE, 1, &bh);
 			wait_on_buffer (bh);
@@ -469,7 +469,7 @@
 
 	/* had we spliced it onto indirect block? */
 	if (where->bh) {
-		mark_buffer_dirty(where->bh);
+		mark_buffer_dirty_inode(where->bh, inode);
 		if (IS_SYNC(inode) || inode->u.ext2_i.i_osync) {
 			ll_rw_block (WRITE, 1, &where->bh);
 			wait_on_buffer(where->bh);
@@ -591,7 +591,7 @@
 				wait_on_buffer(bh);
 			memset(bh->b_data, 0, inode->i_sb->s_blocksize);
 			mark_buffer_uptodate(bh, 1);
-			mark_buffer_dirty(bh);
+			mark_buffer_dirty_inode(bh, inode);
 		}
 		return bh;
 	}
@@ -907,7 +907,7 @@
 		if (partial == chain)
 			mark_inode_dirty(inode);
 		else
-			mark_buffer_dirty(partial->bh);
+			mark_buffer_dirty_inode(partial->bh, inode);
 		ext2_free_branches(inode, &nr, &nr+1, (chain+n-1) - partial);
 	}
 	/* Clear the ends of indirect blocks on the shared branch */
@@ -916,7 +916,7 @@
 				   partial->p + 1,
 				   (u32*)partial->bh->b_data + addr_per_block,
 				   (chain+n-1) - partial);
-		mark_buffer_dirty(partial->bh);
+		mark_buffer_dirty_inode(partial->bh, inode);
 		if (IS_SYNC(inode)) {
 			ll_rw_block (WRITE, 1, &partial->bh);
 			wait_on_buffer (partial->bh);
@@ -1208,7 +1208,7 @@
 		raw_inode->i_block[0] = cpu_to_le32(kdev_t_to_nr(inode->i_rdev));
 	else for (block = 0; block < EXT2_N_BLOCKS; block++)
 		raw_inode->i_block[block] = inode->u.ext2_i.i_data[block];
-	mark_buffer_dirty(bh);
+	mark_buffer_dirty_inode(bh, inode);
 	if (do_sync) {
 		ll_rw_block (WRITE, 1, &bh);
 		wait_on_buffer (bh);
--- linux-2.4.0-test11/fs/ext2/namei.c.~1~	Tue Nov 21 15:40:22 2000
+++ linux-2.4.0-test11/fs/ext2/namei.c	Tue Nov 21 16:01:15 2000
@@ -296,7 +296,7 @@
 			dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
 			mark_inode_dirty(dir);
 			dir->i_version = ++event;
-			mark_buffer_dirty(bh);
+			mark_buffer_dirty_inode(bh, dir);
 			if (IS_SYNC(dir)) {
 				ll_rw_block (WRITE, 1, &bh);
 				wait_on_buffer (bh);
@@ -337,7 +337,7 @@
 			else
 				de->inode = 0;
 			dir->i_version = ++event;
-			mark_buffer_dirty(bh);
+			mark_buffer_dirty_inode(bh, dir);
 			if (IS_SYNC(dir)) {
 				ll_rw_block (WRITE, 1, &bh);
 				wait_on_buffer (bh);
@@ -449,7 +449,7 @@
 	strcpy (de->name, "..");
 	ext2_set_de_type(dir->i_sb, de, S_IFDIR);
 	inode->i_nlink = 2;
-	mark_buffer_dirty(dir_block);
+	mark_buffer_dirty_inode(dir_block, dir);
 	brelse (dir_block);
 	inode->i_mode = S_IFDIR | mode;
 	if (dir->i_mode & S_ISGID)
@@ -755,7 +755,7 @@
 					      EXT2_FEATURE_INCOMPAT_FILETYPE))
 			new_de->file_type = old_de->file_type;
 		new_dir->i_version = ++event;
-		mark_buffer_dirty(new_bh);
+		mark_buffer_dirty_inode(new_bh, new_dir);
 		if (IS_SYNC(new_dir)) {
 			ll_rw_block (WRITE, 1, &new_bh);
 			wait_on_buffer (new_bh);
@@ -786,7 +786,7 @@
 	mark_inode_dirty(old_dir);
 	if (dir_bh) {
 		PARENT_INO(dir_bh->b_data) = le32_to_cpu(new_dir->i_ino);
-		mark_buffer_dirty(dir_bh);
+		mark_buffer_dirty_inode(dir_bh, old_inode);
 		old_dir->i_nlink--;
 		mark_inode_dirty(old_dir);
 		if (new_inode) {
--- linux-2.4.0-test11/include/linux/ext2_fs.h.~1~	Tue Nov 21 15:40:22 2000
+++ linux-2.4.0-test11/include/linux/ext2_fs.h	Tue Nov 21 16:01:15 2000
@@ -549,6 +549,7 @@
 
 /* fsync.c */
 extern int ext2_sync_file (struct file *, struct dentry *, int);
+extern int ext2_fsync_inode (struct inode *, int);
 
 /* ialloc.c */
 extern struct inode * ext2_new_inode (const struct inode *, int, int *);
--- linux-2.4.0-test11/mm/filemap.c.~1~	Tue Nov 21 15:47:48 2000
+++ linux-2.4.0-test11/mm/filemap.c	Tue Nov 21 16:01:15 2000
@@ -2521,8 +2521,14 @@
 	if (cached_page)
 		page_cache_free(cached_page);
 
+	/* For now, when the user asks for O_SYNC, we'll actually
+	 * provide O_DSYNC. */
+	if ((status >= 0) && (file->f_flags & O_SYNC))
+		status = generic_osync_inode(inode, 1); /* 1 means datasync */
+	
 	err = written ? written : status;
 out:
+
 	up(&inode->i_sem);
 	return err;
 fail_write:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
