Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293458AbSDXI5F>; Wed, 24 Apr 2002 04:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310224AbSDXIzC>; Wed, 24 Apr 2002 04:55:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45841 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293680AbSDXIym>;
	Wed, 24 Apr 2002 04:54:42 -0400
Message-ID: <3CC672EC.A99BE497@zip.com.au>
Date: Wed, 24 Apr 2002 01:55:08 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] remove inode.i_dirty_data_buffers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Removes inode.i_dirty_data_buffers.  It's no longer used - all dirty
buffers have their pages marked dirty and filemap_fdatasync() /
filemap_fdatawait() catches it all.

Updates all callers.

There's a problem with JFS - it was performing buffer-based
writeback with pages locked, so it deadlocks.  My attempt
to fix that (by not locking metapage pages) has been sent
to the JFS list for confirmation.


=====================================

--- 2.5.9/fs/buffer.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/buffer.c	Wed Apr 24 01:44:54 2002
@@ -434,8 +434,7 @@ int inode_has_buffers(struct inode *inod
 	int ret;
 	
 	spin_lock(&inode->i_bufferlist_lock);
-	ret = !list_empty(&inode->i_dirty_buffers) ||
-			!list_empty(&inode->i_dirty_data_buffers);
+	ret = !list_empty(&inode->i_dirty_buffers);
 	spin_unlock(&inode->i_bufferlist_lock);
 	
 	return ret;
@@ -697,9 +696,6 @@ void invalidate_inode_buffers(struct ino
 	while ((entry = inode->i_dirty_buffers.next) !=
 				&inode->i_dirty_buffers)
 		__remove_inode_queue(BH_ENTRY(entry));
-	while ((entry = inode->i_dirty_data_buffers.next) !=
-				&inode->i_dirty_data_buffers)
-		__remove_inode_queue(BH_ENTRY(entry));
 	spin_unlock(&inode->i_bufferlist_lock);
 }
 
@@ -957,10 +953,6 @@ __getblk(struct block_device *bdev, sect
  * discover all the uptodate buffers, will set the page uptodate
  * and will perform no I/O.
  */
-static inline void __mark_dirty(struct buffer_head *bh)
-{
-	__set_page_dirty_nobuffers(bh->b_page);
-}
 
 /**
  * mark_buffer_dirty - mark a buffer_head as needing writeout
@@ -976,7 +968,7 @@ static inline void __mark_dirty(struct b
 void mark_buffer_dirty(struct buffer_head *bh)
 {
 	if (!atomic_set_buffer_dirty(bh))
-		__mark_dirty(bh);
+		__set_page_dirty_nobuffers(bh->b_page);
 }
 
 /*
@@ -1503,10 +1495,7 @@ static int __block_commit_write(struct i
 				partial = 1;
 		} else {
 			mark_buffer_uptodate(bh, 1);
-			if (!atomic_set_buffer_dirty(bh)) {
-				__mark_dirty(bh);
-				buffer_insert_inode_data_queue(bh, inode);
-			}
+			mark_buffer_dirty(bh);
 		}
 	}
 
--- 2.5.9/fs/inode.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/inode.c	Wed Apr 24 01:06:12 2002
@@ -143,7 +143,6 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_data.io_pages);
 	INIT_LIST_HEAD(&inode->i_dentry);
 	INIT_LIST_HEAD(&inode->i_dirty_buffers);
-	INIT_LIST_HEAD(&inode->i_dirty_data_buffers);
 	INIT_LIST_HEAD(&inode->i_devices);
 	sema_init(&inode->i_sem, 1);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
--- 2.5.9/include/linux/fs.h~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/include/linux/fs.h	Wed Apr 24 01:44:54 2002
@@ -434,7 +434,6 @@ struct inode {
 	struct list_head	i_dentry;
 
 	struct list_head	i_dirty_buffers;   /* uses i_bufferlist_lock */
-	struct list_head	i_dirty_data_buffers;
 	spinlock_t		i_bufferlist_lock;
 
 	unsigned long		i_ino;
@@ -1260,13 +1259,6 @@ buffer_insert_inode_queue(struct buffer_
 			bh, &inode->i_dirty_buffers);
 }
 
-static inline void
-buffer_insert_inode_data_queue(struct buffer_head *bh, struct inode *inode)
-{
-	buffer_insert_list(&inode->i_bufferlist_lock,
-			bh, &inode->i_dirty_data_buffers);
-}
-
 #define atomic_set_buffer_dirty(bh) test_and_set_bit(BH_Dirty, &(bh)->b_state)
 
 static inline void mark_buffer_async(struct buffer_head * bh, int on)
@@ -1335,11 +1327,6 @@ static inline int fsync_inode_buffers(st
 	return fsync_buffers_list(&inode->i_bufferlist_lock,
 				&inode->i_dirty_buffers);
 }
-static inline int fsync_inode_data_buffers(struct inode *inode)
-{
-	return fsync_buffers_list(&inode->i_bufferlist_lock,
-				&inode->i_dirty_data_buffers);
-}
 extern int inode_has_buffers(struct inode *);
 extern int filemap_fdatasync(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
--- 2.5.9/fs/ext2/fsync.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/ext2/fsync.c	Wed Apr 24 01:06:12 2002
@@ -38,7 +38,6 @@ int ext2_sync_file(struct file * file, s
 	int err;
 	
 	err  = fsync_inode_buffers(inode);
-	err |= fsync_inode_data_buffers(inode);
 	if (!(inode->i_state & I_DIRTY))
 		return err;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
--- 2.5.9/fs/ext3/fsync.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/ext3/fsync.c	Wed Apr 24 01:06:12 2002
@@ -62,8 +62,6 @@ int ext3_sync_file(struct file * file, s
 	 * we'll end up waiting on them in commit.
 	 */
 	ret = fsync_inode_buffers(inode);
-	ret |= fsync_inode_data_buffers(inode);
-
 	ext3_force_commit(inode->i_sb);
 
 	return ret;
--- 2.5.9/fs/jfs/file.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/jfs/file.c	Wed Apr 24 01:06:12 2002
@@ -33,8 +33,6 @@ int jfs_fsync(struct file *file, struct 
 	struct inode *inode = dentry->d_inode;
 	int rc = 0;
 
-	rc = fsync_inode_data_buffers(inode);
-
 	if (!(inode->i_state & I_DIRTY))
 		return rc;
 	if (datasync || !(inode->i_state & I_DIRTY_DATASYNC))
--- 2.5.9/fs/jfs/jfs_dmap.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/jfs/jfs_dmap.c	Wed Apr 24 01:06:12 2002
@@ -325,7 +325,8 @@ int dbSync(struct inode *ipbmap)
 	/*
 	 * write out dirty pages of bmap
 	 */
-	fsync_inode_data_buffers(ipbmap);
+	filemap_fdatasync(ipbmap->i_mapping);
+	filemap_fdatawait(ipbmap->i_mapping);
 
 	ipbmap->i_state |= I_DIRTY;
 	diWriteSpecial(ipbmap);
--- 2.5.9/fs/jfs/jfs_imap.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/jfs/jfs_imap.c	Wed Apr 24 01:06:12 2002
@@ -282,7 +282,8 @@ int diSync(struct inode *ipimap)
 	/*
 	 * write out dirty pages of imap
 	 */
-	fsync_inode_data_buffers(ipimap);
+	filemap_fdatasync(ipimap->i_mapping);
+	filemap_fdatawait(ipimap->i_mapping);
 
 	diWriteSpecial(ipimap);
 
@@ -607,7 +608,8 @@ void diFreeSpecial(struct inode *ip)
 		jERROR(1, ("diFreeSpecial called with NULL ip!\n"));
 		return;
 	}
-	fsync_inode_data_buffers(ip);
+	filemap_fdatasync(ip->i_mapping);
+	filemap_fdatawait(ip->i_mapping);
 	truncate_inode_pages(ip->i_mapping, 0);
 	iput(ip);
 }
--- 2.5.9/fs/jfs/jfs_logmgr.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/jfs/jfs_logmgr.c	Wed Apr 24 01:06:12 2002
@@ -966,9 +966,21 @@ int lmLogSync(log_t * log, int nosyncwai
 		 * We need to make sure all of the "written" metapages
 		 * actually make it to disk
 		 */
-		fsync_inode_data_buffers(sbi->ipbmap);
-		fsync_inode_data_buffers(sbi->ipimap);
-		fsync_inode_data_buffers(sbi->direct_inode);
+		/*
+		 * NOTE!  It's more efficient to perform the three
+		 * fdatasyncs and then the three fdatawaits, rather
+		 * than sync/wait/sync/wait/sync/wait.  If there are
+		 * no ordering requirements here, then it's recommended.
+		 * akpm@zip.com.zu
+		 */
+		filemap_fdatasync(sbi->ipbmap->i_mapping);
+		filemap_fdatawait(sbi->ipbmap->i_mapping);
+
+		filemap_fdatasync(sbi->ipimap->i_mapping);
+		filemap_fdatawait(sbi->ipimap->i_mapping);
+
+		filemap_fdatasync(sbi->direct_inode->i_mapping);
+		filemap_fdatawait(sbi->direct_inode->i_mapping);
 
 		lrd.logtid = 0;
 		lrd.backchain = 0;
--- 2.5.9/fs/jfs/jfs_txnmgr.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/jfs/jfs_txnmgr.c	Wed Apr 24 01:06:12 2002
@@ -1163,8 +1163,10 @@ int txCommit(tid_t tid,		/* transaction 
 		 * committing transactions and use i_sem instead.
 		 */
 		if ((!S_ISDIR(ip->i_mode))
-		    && (tblk->flag & COMMIT_DELETE) == 0)
-			fsync_inode_data_buffers(ip);
+		    && (tblk->flag & COMMIT_DELETE) == 0) {
+			filemap_fdatasync(ip->i_mapping);
+			filemap_fdatawait(ip->i_mapping);
+		}
 
 		/*
 		 * Mark inode as not dirty.  It will still be on the dirty
--- 2.5.9/fs/jfs/super.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/jfs/super.c	Wed Apr 24 01:06:12 2002
@@ -151,7 +151,12 @@ static void jfs_put_super(struct super_b
 	 * We need to clean out the direct_inode pages since this inode
 	 * is not in the inode hash.
 	 */
-	fsync_inode_data_buffers(sbi->direct_inode);
+	/*
+	 * Is this right?  Should we writeback sbi->direct_mapping instead?
+	 * - akpm@zip.com.au
+	 */
+	filemap_fdatasync(sbi->direct_inode->i_mapping);
+	filemap_fdatawait(sbi->direct_inode->i_mapping);
 	truncate_inode_pages(sbi->direct_mapping, 0);
 	iput(sbi->direct_inode);
 	sbi->direct_inode = NULL;
@@ -337,7 +342,8 @@ out_no_rw:
 		jERROR(1, ("jfs_umount failed with return code %d\n", rc));
 	}
 out_mount_failed:
-	fsync_inode_data_buffers(sbi->direct_inode);
+	filemap_fdatasync(sbi->direct_inode->i_mapping);
+	filemap_fdatawait(sbi->direct_inode->i_mapping);
 	truncate_inode_pages(sbi->direct_mapping, 0);
 	make_bad_inode(sbi->direct_inode);
 	iput(sbi->direct_inode);
--- 2.5.9/fs/minix/file.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/minix/file.c	Wed Apr 24 01:06:12 2002
@@ -32,7 +32,6 @@ int minix_sync_file(struct file * file, 
 	int err;
 
 	err = fsync_inode_buffers(inode);
-	err |= fsync_inode_data_buffers(inode);
 	if (!(inode->i_state & I_DIRTY))
 		return err;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
--- 2.5.9/fs/reiserfs/file.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/reiserfs/file.c	Wed Apr 24 01:06:12 2002
@@ -86,7 +86,6 @@ static int reiserfs_sync_file(
       BUG ();
 
   n_err = fsync_inode_buffers(p_s_inode) ;
-  n_err |= fsync_inode_data_buffers(p_s_inode);
   reiserfs_commit_for_inode(p_s_inode) ;
   unlock_kernel() ;
   return ( n_err < 0 ) ? -EIO : 0;
--- 2.5.9/fs/sysv/file.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/sysv/file.c	Wed Apr 24 01:06:12 2002
@@ -38,7 +38,6 @@ int sysv_sync_file(struct file * file, s
 	int err;
 
 	err = fsync_inode_buffers(inode);
-	err |= fsync_inode_data_buffers(inode);
 	if (!(inode->i_state & I_DIRTY))
 		return err;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
--- 2.5.9/fs/udf/fsync.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/udf/fsync.c	Wed Apr 24 01:06:12 2002
@@ -45,7 +45,6 @@ int udf_fsync_inode(struct inode *inode,
 	int err;
 
 	err = fsync_inode_buffers(inode);
-	err |= fsync_inode_data_buffers(inode);
 	if (!(inode->i_state & I_DIRTY))
 		return err;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
--- 2.5.9/mm/filemap.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/mm/filemap.c	Wed Apr 24 01:06:12 2002
@@ -1089,8 +1089,6 @@ static ssize_t generic_file_direct_IO(in
 	 */
 	retval = filemap_fdatasync(mapping);
 	if (retval == 0)
-		retval = fsync_inode_data_buffers(inode);
-	if (retval == 0)
 		retval = filemap_fdatawait(mapping);
 	if (retval < 0)
 		goto out_free;
--- 2.5.9/fs/jfs/jfs_metapage.c~cleanup-040-i_dirty_data_buffers	Wed Apr 24 01:06:12 2002
+++ 2.5.9-akpm/fs/jfs/jfs_metapage.c	Wed Apr 24 01:44:52 2002
@@ -349,6 +349,9 @@ metapage_t *__get_metapage(struct inode 
 		page_index = lblock >> l2BlocksPerPage;
 		page_offset = (lblock - (page_index << l2BlocksPerPage)) <<
 		    l2bsize;
+		/*
+		 * AKPM: s/PAGE_SIZE/PAGE_CACHE_SIZE/ ?
+		 */
 		if ((page_offset + size) > PAGE_SIZE) {
 			spin_unlock(&meta_lock);
 			jERROR(1, ("MetaData crosses page boundary!!\n"));
@@ -394,8 +397,10 @@ metapage_t *__get_metapage(struct inode 
 				__free_metapage(mp);
 				spin_unlock(&meta_lock);
 				return NULL;
-			} else
+			} else {
 				INCREMENT(mpStat.pagealloc);
+				unlock_page(mp->page);
+			}
 		} else {
 			jFYI(1,
 			     ("__get_metapage: Calling read_cache_page\n"));
@@ -412,7 +417,6 @@ metapage_t *__get_metapage(struct inode 
 				return NULL;
 			} else
 				INCREMENT(mpStat.pagealloc);
-			lock_page(mp->page);
 		}
 		mp->data = (void *) (kmap(mp->page) + page_offset);
 	}
@@ -459,6 +463,7 @@ static void __write_metapage(metapage_t 
 	page_offset =
 	    (mp->index - (page_index << l2BlocksPerPage)) << l2bsize;
 
+	lock_page(mp->page);
 	rc = mp->mapping->a_ops->prepare_write(NULL, mp->page, page_offset,
 					       page_offset +
 					       mp->logical_size);
@@ -466,6 +471,7 @@ static void __write_metapage(metapage_t 
 		jERROR(1, ("prepare_write return %d!\n", rc));
 		ClearPageUptodate(mp->page);
 		kunmap(mp->page);
+		unlock_page(mp->page);
 		clear_bit(META_dirty, &mp->flag);
 		return;
 	}
@@ -476,6 +482,7 @@ static void __write_metapage(metapage_t 
 		jERROR(1, ("commit_write returned %d\n", rc));
 	}
 
+	unlock_page(mp->page);
 	clear_bit(META_dirty, &mp->flag);
 
 	jFYI(1, ("__write_metapage done\n"));
@@ -525,7 +532,6 @@ void release_metapage(metapage_t * mp)
 			mp->data = 0;
 			if (test_bit(META_dirty, &mp->flag))
 				__write_metapage(mp);
-			unlock_page(mp->page);
 			if (test_bit(META_sync, &mp->flag)) {
 				sync_metapage(mp);
 				clear_bit(META_sync, &mp->flag);
@@ -585,7 +591,9 @@ void invalidate_metapages(struct inode *
 			/*
 			 * If in the metapage cache, we've got the page locked
 			 */
+			lock_page(mp->page);
 			block_flushpage(mp->page, 0);
+			unlock_page(mp->page);
 		} else {
 			spin_unlock(&meta_lock);
 			page = find_lock_page(mapping, lblock>>l2BlocksPerPage);
@@ -608,7 +616,6 @@ void invalidate_inode_metapages(struct i
 		clear_bit(META_dirty, &mp->flag);
 		set_bit(META_discard, &mp->flag);
 		kunmap(mp->page);
-		unlock_page(mp->page);
 		page_cache_release(mp->page);
 		INCREMENT(mpStat.pagefree);
 		mp->data = 0;
