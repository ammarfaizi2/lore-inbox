Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRADVxW>; Thu, 4 Jan 2001 16:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbRADVxE>; Thu, 4 Jan 2001 16:53:04 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:59399 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129370AbRADVwy>; Thu, 4 Jan 2001 16:52:54 -0500
Date: Thu, 04 Jan 2001 16:52:49 -0500
From: Chris Mason <mason@suse.com>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: reiserfs patch for 2.4.0-prerelease
Message-ID: <244070000.978645169@tiny>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This patch is meant to be applied on top of the reiserfs
3.6.23 patch to get everything working in the new prerelease
kernels.  The order is:

untar linux-2.4.0-prerelease.tar.bz2
apply linux-2.4.0-test12-reiserfs-3.6.23.gz
apply this patch
apply the fs/super.c patch to make sure fsync_dev is called
when unmounting /.  This was already sent to l-k, I'll send
to the reiserfs list as well.

If you want to apply the prerelease-diff from the testing dir
it can go before or after the reiserfs patches.

These changes have been tested, but still need more.  Don't apply
if you aren't willing to bleed a little.

Changes:

Undoes the fs/buffer.c fuzz error from patching 3.6.23 into the
prerelease kernels.

Remove the super unlocking hack that was needed to avoid 
deadlocks with my old end_io tasks.  The tasks are gone,
so are the deadlocks.

Change around the dirty inode call back so the reiserfs
inodes get properly marked as dirty for the O_SYNC and dirty
page stuff.  This is kind of ugly, and I need to change it
around more.  But, it will work for now.

Add proper O_SYNC and fsync support.

Fix reiserfs makefile and page->mapping->host casts to work with
the new kernel.

Log the super before balancing to avoid warning messages about
logging an unprepared buffer.

Clears the dirty bit before sending buffers to submit_bh
in reiserfs_writepage.

Please send any bug reports to the reiserfs list.

-chris

diff -urN linux-3.6.23/fs/buffer.c linux/fs/buffer.c
--- linux-3.6.23/fs/buffer.c	Thu Jan  4 15:45:33 2001
+++ linux/fs/buffer.c	Thu Jan  4 15:43:22 2001
@@ -1647,8 +1647,6 @@
 				buffer_insert_inode_queue(bh, inode);
 				need_balance_dirty = 1;
 			}
-			if (buffer_uptodate(bh))
-				continue ;
 		}
 	}
 
diff -urN linux-3.6.23/fs/inode.c linux/fs/inode.c
--- linux-3.6.23/fs/inode.c	Thu Jan  4 15:45:33 2001
+++ linux/fs/inode.c	Thu Jan  4 15:43:34 2001
@@ -134,10 +134,6 @@
 void __mark_inode_dirty(struct inode *inode, int flags)
 {
 	struct super_block * sb = inode->i_sb;
-	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->dirty_inode){
-		inode->i_sb->s_op->dirty_inode(inode) ;
-		return ;
-	}
 	if (sb) {
 		spin_lock(&inode_lock);
 		if ((inode->i_state & flags) != flags) {
diff -urN linux-3.6.23/fs/reiserfs/Makefile linux/fs/reiserfs/Makefile
--- linux-3.6.23/fs/reiserfs/Makefile	Thu Jan  4 15:45:33 2001
+++ linux/fs/reiserfs/Makefile	Thu Jan  4 15:43:34 2001
@@ -8,10 +8,10 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 O_TARGET := reiserfs.o
-O_OBJS   := bitmap.o do_balan.o namei.o inode.o file.o dir.o fix_node.o super.o prints.o objectid.o \
+obj-y   := bitmap.o do_balan.o namei.o inode.o file.o dir.o fix_node.o super.o prints.o objectid.o \
 lbalance.o ibalance.o stree.o hashes.o buffer2.o tail_conversion.o journal.o resize.o tail_conversion.o version.o item_ops.o ioctl.o
 
-M_OBJS   := $(O_TARGET)
+obj-m   := $(O_TARGET)
 
 include $(TOPDIR)/Rules.make
 
diff -urN linux-3.6.23/fs/reiserfs/file.c linux/fs/reiserfs/file.c
--- linux-3.6.23/fs/reiserfs/file.c	Thu Jan  4 15:45:33 2001
+++ linux/fs/reiserfs/file.c	Thu Jan  4 15:43:34 2001
@@ -90,11 +90,9 @@
   if (!S_ISREG(p_s_inode->i_mode))
       BUG ();
 
-  /* step one, flush all dirty buffers in the file's page map to disk */
-  n_err = generic_buffer_fdatasync(p_s_inode, 0, ~0UL) ;
-  
-  /* step two, commit the current transaction to flush any metadata
-  ** changes
+  n_err = fsync_inode_buffers(p_s_inode) ;
+  /* commit the current transaction to flush any metadata
+  ** changes.  sys_fsync takes care of flushing the dirty pages for us
   */
   journal_begin(&th, p_s_inode->i_sb, jbegin_count) ;
   windex = push_journal_writer("sync_file") ;
diff -urN linux-3.6.23/fs/reiserfs/fix_node.c linux/fs/reiserfs/fix_node.c
--- linux-3.6.23/fs/reiserfs/fix_node.c	Thu Jan  4 15:45:33 2001
+++ linux/fs/reiserfs/fix_node.c	Thu Jan  4 15:43:34 2001
@@ -2499,7 +2499,20 @@
         if ( FILESYSTEM_CHANGED_TB (p_s_tb) )
             return REPEAT_SEARCH;
     }
-
+    /* we log the super here so we know it is prepared and inside the
+    ** transaction before the do_balance starts.  This way, do_balance
+    ** won't have to prepare it later on, when we aren't allowed to
+    ** schedule
+    */
+    reiserfs_prepare_for_journal(p_s_tb->tb_sb,
+    				 SB_BUFFER_WITH_SB(p_s_tb->tb_sb), 1) ;
+    if ( FILESYSTEM_CHANGED_TB (p_s_tb) ) {
+	reiserfs_restore_prepared_buffer(p_s_tb->tb_sb, 
+	                                 SB_BUFFER_WITH_SB(p_s_tb->tb_sb)) ;
+	return REPEAT_SEARCH;
+    }
+    journal_mark_dirty(p_s_tb->transaction_handle, p_s_tb->tb_sb,
+		       SB_BUFFER_WITH_SB(p_s_tb->tb_sb)) ;
 #ifndef __KERNEL__
     if ( atomic_read (&(p_s_tbS0->b_count)) > 1 || 
 	 (p_s_tb->L[0] && atomic_read (&(p_s_tb->L[0]->b_count)) > 1) ||
diff -urN linux-3.6.23/fs/reiserfs/inode.c linux/fs/reiserfs/inode.c
--- linux-3.6.23/fs/reiserfs/inode.c	Thu Jan  4 15:45:33 2001
+++ linux/fs/reiserfs/inode.c	Thu Jan  4 15:43:34 2001
@@ -1170,20 +1170,41 @@
 //
 /* looks for stat data, then copies fields to it, marks the buffer
    containing stat data as dirty */
+/* reiserfs inodes are never really dirty, since the dirty inode call
+** always logs them.  This call allows the VFS inode marking routines
+** to properly mark inodes for datasync and such, but only actually
+** does something when called for a synchronous update.
+*/
 void reiserfs_write_inode (struct inode * inode, int do_sync) {
-    int windex ;
     struct reiserfs_transaction_handle th ;
-    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
+    int jbegin_count = 1 ;
 
+    if (inode->i_sb->s_flags & MS_RDONLY) {
+        reiserfs_warning("clm-6005: writing inode %lu on readonly FS\n", 
+	                  inode->i_ino) ;
+        return ;
+    }
+    if (do_sync) {
+	lock_kernel() ;
+	journal_begin(&th, inode->i_sb, jbegin_count) ;
+	reiserfs_update_sd (&th, inode);
+	journal_end_sync(&th, inode->i_sb, jbegin_count) ;
+	unlock_kernel() ;
+    }
+}
+
+void reiserfs_dirty_inode (struct inode * inode) {
+    struct reiserfs_transaction_handle th ;
+
+    if (inode->i_sb->s_flags & MS_RDONLY) {
+        reiserfs_warning("clm-6006: writing inode %lu on readonly FS\n", 
+	                  inode->i_ino) ;
+        return ;
+    }
     lock_kernel() ;
-    journal_begin(&th, inode->i_sb, jbegin_count) ;
-    windex = push_journal_writer("write_inode") ;
+    journal_begin(&th, inode->i_sb, 1) ;
     reiserfs_update_sd (&th, inode);
-    pop_journal_writer(windex) ;
-    if (do_sync) 
-	journal_end_sync(&th, inode->i_sb, jbegin_count) ;
-    else
-	journal_end(&th, inode->i_sb, jbegin_count) ;
+    journal_end(&th, inode->i_sb, 1) ;
     unlock_kernel() ;
 }
 
@@ -1684,14 +1705,18 @@
 	lock_buffer(bh) ;
 	atomic_inc(&bh->b_count) ; /* async end_io handler decs this */
 	set_buffer_async_io(bh) ;
-	set_bit(BH_Dirty, &bh->b_state) ;
+	/* submit_bh doesn't care if the buffer is dirty, but nobody
+	** later on in the call chain will be cleaning it.  So, we
+	** clean the buffer here, it still gets written either way.
+	*/
+	clear_bit(BH_Dirty, &bh->b_state) ;
 	set_bit(BH_Uptodate, &bh->b_state) ;
 	submit_bh(WRITE, bh) ;
     }
 }
 
 static int reiserfs_write_full_page(struct page *page) {
-    struct inode *inode = (struct inode *)page->mapping->host ;
+    struct inode *inode = page->mapping->host ;
     unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT ;
     unsigned last_offset = PAGE_CACHE_SIZE;
     int error = 0;
@@ -1790,7 +1815,7 @@
 //
 static int reiserfs_writepage (struct page * page)
 {
-    struct inode *inode = (struct inode *)page->mapping->host ;
+    struct inode *inode = page->mapping->host ;
     reiserfs_wait_on_write_block(inode->i_sb) ;
     return reiserfs_write_full_page(page) ;
 }
@@ -1800,7 +1825,7 @@
 // from ext2_prepare_write, but modified
 //
 int reiserfs_prepare_write(struct file *f, struct page *page, unsigned from, unsigned to) {
-    struct inode *inode = (struct inode *)page->mapping->host ;
+    struct inode *inode = page->mapping->host ;
     reiserfs_wait_on_write_block(inode->i_sb) ;
     fix_tail_page_for_writing(page) ;
     return block_prepare_write(page, from, to, reiserfs_get_block) ;
@@ -1817,12 +1842,23 @@
 
 static int reiserfs_commit_write(struct file *f, struct page *page, 
                                  unsigned from, unsigned to) {
-    struct inode *inode = (struct inode *)(page->mapping->host) ;
+    struct inode *inode = page->mapping->host ;
     int ret ; 
+    struct reiserfs_transaction_handle th ;
     
     reiserfs_wait_on_write_block(inode->i_sb) ;
     prevent_flush_page_lock(page, inode) ;
     ret = generic_commit_write(f, page, from, to) ;
+    /* we test for O_SYNC here so we can commit the transaction
+    ** for any packed tails the file might have had
+    */
+    if (f->f_flags & O_SYNC) {
+	journal_begin(&th, inode->i_sb, 1) ;
+	reiserfs_prepare_for_journal(inode->i_sb, 
+	                             SB_BUFFER_WITH_SB(inode->i_sb), 1) ;
+	journal_mark_dirty(&th, inode->i_sb, SB_BUFFER_WITH_SB(inode->i_sb)) ;
+	journal_end_sync(&th, inode->i_sb, 1) ;
+    }
     allow_flush_page_lock(page, inode) ;
     return ret ;
 }
diff -urN linux-3.6.23/fs/reiserfs/resize.c linux/fs/reiserfs/resize.c
--- linux-3.6.23/fs/reiserfs/resize.c	Thu Jan  4 15:45:33 2001
+++ linux/fs/reiserfs/resize.c	Thu Jan  4 15:43:34 2001
@@ -134,10 +134,8 @@
 	    SB_AP_BITMAP(s) = bitmap;
 	}
 	
-	unlock_super(s) ; /* deadlock avoidance */
 	/* begin transaction */
 	journal_begin(&th, s, 10);
-	lock_super(s) ; /* must keep super locked during these ops */
 
 	/* correct last bitmap blocks in old and new disk layout */
 	reiserfs_prepare_for_journal(s, SB_AP_BITMAP(s)[bmap_nr - 1], 1);
@@ -163,9 +161,7 @@
 	journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB(s));
 	
 	SB_JOURNAL(s)->j_must_wait = 1;
-	unlock_super(s) ; /* see comments in reiserfs_put_super() */
 	journal_end(&th, s, 10);
-	lock_super(s);
 
 	return 0;
 }
diff -urN linux-3.6.23/fs/reiserfs/super.c linux/fs/reiserfs/super.c
--- linux-3.6.23/fs/reiserfs/super.c	Thu Jan  4 15:45:33 2001
+++ linux/fs/reiserfs/super.c	Thu Jan  4 15:43:34 2001
@@ -46,9 +46,7 @@
   int dirty = 0 ;
   lock_kernel() ;
   if (!(s->s_flags & MS_RDONLY)) {
-    unlock_super(s) ;
     dirty = flush_old_commits(s, 1) ;
-    lock_super(s) ;
   }
   s->s_dirt = dirty;
   unlock_kernel() ;
@@ -68,12 +66,10 @@
   struct reiserfs_transaction_handle th ;
   lock_kernel() ;
   if (!(s->s_flags & MS_RDONLY)) {
-    unlock_super(s) ;
     journal_begin(&th, s, 1) ;
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     reiserfs_block_writes(&th) ;
     journal_end(&th, s, 1) ;
-    lock_super(s) ;
   }
   s->s_dirt = dirty;
   unlock_kernel() ;
@@ -98,14 +94,6 @@
   int i;
   struct reiserfs_transaction_handle th ;
   
-  /* the end_io task has to call get_super, which locks the super, which
-  ** will deadlock with the journal.  So, we unlock, and then relock
-  ** when the journal is done.
-  ** 
-  ** this sucks.
-  */
-  unlock_super(s) ;
-
   /* change file system state to current state if it was mounted with read-write permissions */
   if (!(s->s_flags & MS_RDONLY)) {
     journal_begin(&th, s, 10) ;
@@ -118,7 +106,6 @@
   ** to do a journal_end
   */
   journal_release(&th, s) ;
-  lock_super(s) ;
 
   for (i = 0; i < SB_BMAP_NR (s); i ++)
     brelse (SB_AP_BITMAP (s)[i]);
@@ -271,9 +258,7 @@
       return 0;
     }
 
-    unlock_super(s) ;
     journal_begin(&th, s, 10) ;
-    lock_super(s) ;
     /* Mounting a rw partition read-only. */
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
     rs->s_state = cpu_to_le16 (s->u.reiserfs_sb.s_mount_state);
@@ -282,9 +267,7 @@
   } else {
     s->u.reiserfs_sb.s_mount_state = le16_to_cpu(rs->s_state) ;
     s->s_flags &= ~MS_RDONLY ; /* now it is safe to call journal_begin */
-    unlock_super(s) ;
     journal_begin(&th, s, 10) ;
-    lock_super(s) ;
 
     /* Mount a partition which is read-only, read-write */
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
@@ -298,9 +281,7 @@
   }
   /* this will force a full flush of all journal lists */
   SB_JOURNAL(s)->j_must_wait = 1 ;
-  unlock_super(s) ;
   journal_end(&th, s, 10) ;
-  lock_super(s) ;
   return 0;
 }
 
diff -urN linux-3.6.23/fs/reiserfs/utils/lib/version.c linux/fs/reiserfs/utils/lib/version.c
--- linux-3.6.23/fs/reiserfs/utils/lib/version.c	Thu Jan  4 15:45:34 2001
+++ linux/fs/reiserfs/utils/lib/version.c	Thu Jan  4 15:46:42 2001
@@ -3,5 +3,5 @@
  */
 
 char *reiserfs_get_version_string(void) {
-  return "ReiserFS version 3.6.23" ;
+  return "ReiserFS version 3.6.24" ;
 }
diff -urN linux-3.6.23/fs/reiserfs/version.c linux/fs/reiserfs/version.c
--- linux-3.6.23/fs/reiserfs/version.c	Thu Jan  4 15:45:34 2001
+++ linux/fs/reiserfs/version.c	Thu Jan  4 15:46:32 2001
@@ -3,5 +3,5 @@
  */
 
 char *reiserfs_get_version_string(void) {
-  return "ReiserFS version 3.6.23" ;
+  return "ReiserFS version 3.6.24" ;
 }
diff -urN linux-3.6.23/include/linux/fs.h linux/include/linux/fs.h
--- linux-3.6.23/include/linux/fs.h	Thu Jan  4 15:45:34 2001
+++ linux/include/linux/fs.h	Thu Jan  4 15:43:34 2001
@@ -462,35 +462,6 @@
 	} u;
 };
 
-/* Inode state bits.. */
-#define I_DIRTY_SYNC		1 /* Not dirty enough for O_DATASYNC */
-#define I_DIRTY_DATASYNC	2 /* Data-related inode changes pending */
-#define I_DIRTY_PAGES		4 /* Data-related inode changes pending */
-#define I_LOCK			8
-#define I_FREEING		16
-#define I_CLEAR			32
-
-#define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
-
-extern void __mark_inode_dirty(struct inode *, int);
-static inline void mark_inode_dirty(struct inode *inode)
-{
-	if ((inode->i_state & I_DIRTY) != I_DIRTY)
-		__mark_inode_dirty(inode, I_DIRTY);
-}
-
-static inline void mark_inode_dirty_sync(struct inode *inode)
-{
-	if (!(inode->i_state & I_DIRTY_SYNC))
-		__mark_inode_dirty(inode, I_DIRTY_SYNC);
-}
-
-static inline void mark_inode_dirty_pages(struct inode *inode)
-{
-	if (inode && !(inode->i_state & I_DIRTY_PAGES))
-		__mark_inode_dirty(inode, I_DIRTY_PAGES);
-}
-
 struct fown_struct {
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
@@ -840,6 +811,39 @@
 	void (*clear_inode) (struct inode *);
 	void (*umount_begin) (struct super_block *);
 };
+
+/* Inode state bits.. */
+#define I_DIRTY_SYNC		1 /* Not dirty enough for O_DATASYNC */
+#define I_DIRTY_DATASYNC	2 /* Data-related inode changes pending */
+#define I_DIRTY_PAGES		4 /* Data-related inode changes pending */
+#define I_LOCK			8
+#define I_FREEING		16
+#define I_CLEAR			32
+
+#define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
+
+extern void __mark_inode_dirty(struct inode *, int);
+static inline void mark_inode_dirty(struct inode *inode)
+{
+	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->dirty_inode)
+		inode->i_sb->s_op->dirty_inode(inode) ;
+	if ((inode->i_state & I_DIRTY) != I_DIRTY)
+		__mark_inode_dirty(inode, I_DIRTY);
+}
+
+static inline void mark_inode_dirty_sync(struct inode *inode)
+{
+	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->dirty_inode)
+		inode->i_sb->s_op->dirty_inode(inode) ;
+	if (!(inode->i_state & I_DIRTY_SYNC))
+		__mark_inode_dirty(inode, I_DIRTY_SYNC);
+}
+
+static inline void mark_inode_dirty_pages(struct inode *inode)
+{
+	if (inode && !(inode->i_state & I_DIRTY_PAGES))
+		__mark_inode_dirty(inode, I_DIRTY_PAGES);
+}
 
 struct dquot_operations {
 	void (*initialize) (struct inode *, short);
diff -urN linux-3.6.23/include/linux/reiserfs_fs.h linux/include/linux/reiserfs_fs.h
--- linux-3.6.23/include/linux/reiserfs_fs.h	Thu Jan  4 15:45:34 2001
+++ linux/include/linux/reiserfs_fs.h	Thu Jan  4 15:43:34 2001
@@ -1809,9 +1809,7 @@
 void reiserfs_write_inode (struct inode * inode, int) ;
 
 /* we don't mark inodes dirty, we just log them */
-static inline void reiserfs_dirty_inode (struct inode * inode) {
-  reiserfs_write_inode(inode, 0) ;
-}
+void reiserfs_dirty_inode (struct inode * inode) ;
 
 struct inode * reiserfs_new_inode (struct reiserfs_transaction_handle *th, const struct inode * dir, int mode, 
 				   const char * symname, int item_len,

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
