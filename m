Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSFJNuY>; Mon, 10 Jun 2002 09:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSFJNuX>; Mon, 10 Jun 2002 09:50:23 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:23936 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S314422AbSFJNuL>;
	Mon, 10 Jun 2002 09:50:11 -0400
Date: Mon, 10 Jun 2002 17:42:56 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADgu10003884@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 15 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 15 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

    Currently we lock the entire kernel when really locking just
    locking the super block for that particular filesystem is enough.
    So we introduce reiserfs_write(un)lock, which is a simple wrapper
    for now, but will later fix this.

Diffstat:
 fs/reiserfs/dir.c           |   11 ++++---
 fs/reiserfs/file.c          |   12 ++++----
 fs/reiserfs/inode.c         |   41 +++++++++++++---------------
 fs/reiserfs/ioctl.c         |    4 +-
 fs/reiserfs/namei.c         |   64 ++++++++++++++++++++++----------------------
 fs/reiserfs/super.c         |   12 ++++----
 include/linux/reiserfs_fs.h |    7 ++++
 7 files changed, 79 insertions(+), 72 deletions(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.608   -> 1.609  
#	  fs/reiserfs/file.c	1.15    -> 1.16   
#	 fs/reiserfs/namei.c	1.39    -> 1.40   
#	 fs/reiserfs/inode.c	1.62    -> 1.63   
#	 fs/reiserfs/ioctl.c	1.8     -> 1.9    
#	 fs/reiserfs/super.c	1.47    -> 1.48   
#	   fs/reiserfs/dir.c	1.16    -> 1.17   
#	include/linux/reiserfs_fs.h	1.33    -> 1.34   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.609
# reiserfs_fs.h, super.c, namei.c, ioctl.c, inode.c, file.c, dir.c:
#   reiserfs_write(un)lock introducion. Simple wrapper for now.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/dir.c b/fs/reiserfs/dir.c
--- a/fs/reiserfs/dir.c	Thu May 30 18:42:30 2002
+++ b/fs/reiserfs/dir.c	Thu May 30 18:42:30 2002
@@ -24,9 +24,10 @@
 };
 
 int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry, int datasync) {
-  lock_kernel();
-  reiserfs_commit_for_inode(dentry->d_inode) ;
-  unlock_kernel() ;
+  struct inode *inode = dentry->d_inode;
+  reiserfs_write_lock(inode->i_sb);
+  reiserfs_commit_for_inode(inode) ;
+  reiserfs_write_unlock(inode->i_sb) ;
   return 0 ;
 }
 
@@ -50,7 +51,7 @@
     struct reiserfs_dir_entry de;
     int ret = 0;
 
-    lock_kernel();
+    reiserfs_write_lock(inode->i_sb);
 
     reiserfs_check_lock_depth("readdir") ;
 
@@ -186,7 +187,7 @@
     reiserfs_check_path(&path_to_entry) ;
     UPDATE_ATIME(inode) ;
  out:
-    unlock_kernel();
+    reiserfs_write_unlock(inode->i_sb);
     return ret;
 }
 
diff -Nru a/fs/reiserfs/file.c b/fs/reiserfs/file.c
--- a/fs/reiserfs/file.c	Thu May 30 18:42:30 2002
+++ b/fs/reiserfs/file.c	Thu May 30 18:42:30 2002
@@ -39,7 +39,7 @@
 	return 0;
     }    
     
-    lock_kernel() ;
+    reiserfs_write_lock(inode->i_sb);
     down (&inode->i_sem); 
     journal_begin(&th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3) ;
     reiserfs_update_inode_transaction(inode) ;
@@ -61,7 +61,7 @@
 	pop_journal_writer(windex) ;
     }
     up (&inode->i_sem); 
-    unlock_kernel() ;
+    reiserfs_write_unlock(inode->i_sb);
     return 0;
 }
 
@@ -84,21 +84,21 @@
   struct inode * p_s_inode = p_s_dentry->d_inode;
   int n_err;
 
-  lock_kernel() ;
+  reiserfs_write_lock(p_s_inode->i_sb);
 
   if (!S_ISREG(p_s_inode->i_mode))
       BUG ();
 
   n_err = sync_mapping_buffers(p_s_inode->i_mapping) ;
   reiserfs_commit_for_inode(p_s_inode) ;
-  unlock_kernel() ;
+  reiserfs_write_unlock(p_s_inode->i_sb);
   return ( n_err < 0 ) ? -EIO : 0;
 }
 
 static int reiserfs_setattr(struct dentry *dentry, struct iattr *attr) {
     struct inode *inode = dentry->d_inode ;
     int error ;
-    lock_kernel();
+    reiserfs_write_lock(inode->i_sb);
     if (attr->ia_valid & ATTR_SIZE) {
 	/* version 2 items will be caught by the s_maxbytes check
 	** done for us in vmtruncate
@@ -136,7 +136,7 @@
         inode_setattr(inode, attr) ;
 
 out:
-    unlock_kernel();
+    reiserfs_write_unlock(inode->i_sb);
     return error ;
 }
 
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu May 30 18:42:30 2002
+++ b/fs/reiserfs/inode.c	Thu May 30 18:42:30 2002
@@ -28,7 +28,7 @@
     struct reiserfs_transaction_handle th ;
 
   
-    lock_kernel() ; 
+    reiserfs_write_lock(inode->i_sb);
 
     /* The = 0 happens when we abort creating a new inode for some reason like lack of space.. */
     if (!(inode->i_state & I_NEW) && INODE_PKEY(inode)->k_objectid != 0) { /* also handles bad_inode case */
@@ -53,7 +53,7 @@
     }
     clear_inode (inode); /* note this must go after the journal_end to prevent deadlock */
     inode->i_blocks = 0;
-    unlock_kernel() ;
+    reiserfs_write_unlock(inode->i_sb);
 }
 
 static void _make_cpu_key (struct cpu_key * key, int version, __u32 dirid, __u32 objectid, 
@@ -408,10 +408,10 @@
     if (!file_capable (inode, block))
 	return -EFBIG;
 
-    lock_kernel() ;
+    reiserfs_write_lock(inode->i_sb);
     /* do not read the direct item */
     _get_block_create_0 (inode, block, bh_result, 0) ;
-    unlock_kernel() ;
+    reiserfs_write_unlock(inode->i_sb);
     return 0;
 }
 
@@ -545,17 +545,17 @@
     loff_t new_offset = (((loff_t)block) << inode->i_sb->s_blocksize_bits) + 1 ;
 
 				/* bad.... */
-    lock_kernel() ;
+    reiserfs_write_lock(inode->i_sb);
     th.t_trans_id = 0 ;
     version = get_inode_item_key_version (inode);
 
     if (block < 0) {
-	unlock_kernel();
+	reiserfs_write_unlock(inode->i_sb);
 	return -EIO;
     }
 
     if (!file_capable (inode, block)) {
-	unlock_kernel() ;
+	reiserfs_write_unlock(inode->i_sb);
 	return -EFBIG;
     }
 
@@ -567,7 +567,7 @@
 	/* find number of block-th logical block of the file */
 	ret = _get_block_create_0 (inode, block, bh_result, 
 	                           create | GET_BLOCK_READ_DIRECT) ;
-	unlock_kernel() ;
+	reiserfs_write_unlock(inode->i_sb);
 	return ret;
     }
 
@@ -658,7 +658,7 @@
 	if (transaction_started)
 	    journal_end(&th, inode->i_sb, jbegin_count) ;
 
-	unlock_kernel() ;
+	reiserfs_write_unlock(inode->i_sb);
 	 
 	/* the item was found, so new blocks were not added to the file
 	** there is no need to make sure the inode is updated with this 
@@ -857,7 +857,6 @@
 
 
     retval = 0;
-    reiserfs_check_path(&path) ;
 
  failure:
     if (transaction_started) {
@@ -865,7 +864,7 @@
       journal_end(&th, inode->i_sb, jbegin_count) ;
     }
     pop_journal_writer(windex) ;
-    unlock_kernel() ;
+    reiserfs_write_unlock(inode->i_sb);
     reiserfs_check_path(&path) ;
     return retval;
 }
@@ -1366,11 +1365,11 @@
     ** ignored because the altered inode has already been logged.
     */
     if (do_sync && !(current->flags & PF_MEMALLOC)) {
-	lock_kernel() ;
+	reiserfs_write_lock(inode->i_sb);
 	journal_begin(&th, inode->i_sb, jbegin_count) ;
 	reiserfs_update_sd (&th, inode);
 	journal_end_sync(&th, inode->i_sb, jbegin_count) ;
-	unlock_kernel() ;
+	reiserfs_write_unlock(inode->i_sb);
     }
 }
 
@@ -1746,7 +1745,7 @@
     int error ;
     struct buffer_head *bh = NULL ;
 
-    lock_kernel ();
+    reiserfs_write_lock(p_s_inode->i_sb);
 
     if (p_s_inode->i_size > 0) {
         if ((error = grab_tail_page(p_s_inode, &page, &bh))) {
@@ -1801,7 +1800,7 @@
 	page_cache_release(page) ;
     }
 
-    unlock_kernel ();
+    reiserfs_write_unlock(p_s_inode->i_sb);
 }
 
 static int map_block_for_writepage(struct inode *inode, 
@@ -1825,7 +1824,7 @@
 
     kmap(bh_result->b_page) ;
 start_over:
-    lock_kernel() ;
+    reiserfs_write_lock(inode->i_sb);
     journal_begin(&th, inode->i_sb, jbegin_count) ;
     reiserfs_update_inode_transaction(inode) ;
 
@@ -1892,7 +1891,7 @@
 out:
     pathrelse(&path) ;
     journal_end(&th, inode->i_sb, jbegin_count) ;
-    unlock_kernel() ;
+    reiserfs_write_unlock(inode->i_sb);
 
     /* this is where we fill in holes in the file. */
     if (use_get_block) {
@@ -2064,13 +2063,13 @@
     */
     if (pos > inode->i_size) {
 	struct reiserfs_transaction_handle th ;
-	lock_kernel() ;
+	reiserfs_write_lock(inode->i_sb);
 	journal_begin(&th, inode->i_sb, 1) ;
 	reiserfs_update_inode_transaction(inode) ;
 	inode->i_size = pos ;
 	reiserfs_update_sd(&th, inode) ;
 	journal_end(&th, inode->i_sb, 1) ;
-	unlock_kernel() ;
+	reiserfs_write_unlock(inode->i_sb);
     }
  
     ret = generic_commit_write(f, page, from, to) ;
@@ -2079,9 +2078,9 @@
     ** for any packed tails the file might have had
     */
     if (f && (f->f_flags & O_SYNC)) {
-	lock_kernel() ;
+	reiserfs_write_lock(inode->i_sb);
  	reiserfs_commit_for_inode(inode) ;
-	unlock_kernel();
+	reiserfs_write_unlock(inode->i_sb);
     }
     return ret ;
 }
diff -Nru a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
--- a/fs/reiserfs/ioctl.c	Thu May 30 18:42:30 2002
+++ b/fs/reiserfs/ioctl.c	Thu May 30 18:42:30 2002
@@ -49,7 +49,7 @@
     if (REISERFS_I(inode)->i_flags & i_nopack_mask) {
         return 0 ;
     }
-    lock_kernel();
+    reiserfs_write_lock(inode->i_sb);
 
     /* we need to make sure nobody is changing the file size beneath
     ** us
@@ -88,6 +88,6 @@
 
 out:
     up(&inode->i_sem) ;
-    unlock_kernel();    
+    reiserfs_write_unlock(inode->i_sb);
     return retval;
 }
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Thu May 30 18:42:30 2002
+++ b/fs/reiserfs/namei.c	Thu May 30 18:42:30 2002
@@ -326,18 +326,18 @@
     if (REISERFS_MAX_NAME (dir->i_sb->s_blocksize) < dentry->d_name.len)
 	return ERR_PTR(-ENAMETOOLONG);
 
-    lock_kernel();
+    reiserfs_write_lock(dir->i_sb);
     de.de_gen_number_bit_string = 0;
     retval = reiserfs_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &path_to_entry, &de);
     pathrelse (&path_to_entry);
     if (retval == NAME_FOUND) {
 	inode = reiserfs_iget (dir->i_sb, (struct cpu_key *)&(de.de_dir_id));
 	if (!inode || IS_ERR(inode)) {
-	    unlock_kernel();
+	    reiserfs_write_unlock(dir->i_sb);
 	    return ERR_PTR(-EACCES);
         }
     }
-    unlock_kernel();
+    reiserfs_write_unlock(dir->i_sb);
     if ( retval == IO_ERROR ) {
 	return ERR_PTR(-EIO);
     }
@@ -369,15 +369,15 @@
     }
     de.de_gen_number_bit_string = 0;
 
-    lock_kernel();
+    reiserfs_write_lock(dir->i_sb);
     retval = reiserfs_find_entry (dir, "..", 2, &path_to_entry, &de);
     pathrelse (&path_to_entry);
     if (retval != NAME_FOUND) {
-	unlock_kernel();
+	reiserfs_write_unlock(dir->i_sb);
 	return ERR_PTR(-ENOENT);
     }
     inode = reiserfs_iget (dir->i_sb, (struct cpu_key *)&(de.de_dir_id));
-    unlock_kernel();
+    reiserfs_write_unlock(dir->i_sb);
 
     if (!inode || IS_ERR(inode)) {
 	return ERR_PTR(-EACCES);
@@ -572,7 +572,7 @@
     if (retval)
         return retval;
 
-    lock_kernel();
+    reiserfs_write_lock(dir->i_sb);
     journal_begin(&th, dir->i_sb, jbegin_count) ;
     th.t_caller = "create" ;
     retval = reiserfs_new_inode (&th, dir, mode, 0, 0/*i_size*/, dentry, inode);
@@ -600,7 +600,7 @@
     journal_end(&th, dir->i_sb, jbegin_count) ;
 
 out_failed:
-    unlock_kernel();
+    reiserfs_write_unlock(dir->i_sb);
     return retval;
 }
 
@@ -619,7 +619,7 @@
     if (retval)
         return retval;
 
-    lock_kernel();
+    reiserfs_write_lock(dir->i_sb);
     journal_begin(&th, dir->i_sb, jbegin_count) ;
 
     retval = reiserfs_new_inode (&th, dir, mode, 0, 0/*i_size*/, dentry, inode);
@@ -649,7 +649,7 @@
     journal_end(&th, dir->i_sb, jbegin_count) ;
 
 out_failed:
-    unlock_kernel();
+    reiserfs_write_unlock(dir->i_sb);
     return retval;
 }
 
@@ -669,7 +669,7 @@
     if (retval)
         return retval;
 
-    lock_kernel();
+    reiserfs_write_lock(dir->i_sb);
     journal_begin(&th, dir->i_sb, jbegin_count) ;
 
     /* inc the link count now, so another writer doesn't overflow it while
@@ -709,7 +709,7 @@
     d_instantiate(dentry, inode);
     journal_end(&th, dir->i_sb, jbegin_count) ;
 out_failed:
-    unlock_kernel();
+    reiserfs_write_unlock(dir->i_sb);
     return retval;
 }
 
@@ -740,7 +740,7 @@
     /* we will be doing 2 balancings and update 2 stat data */
     jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2;
 
-    lock_kernel();
+    reiserfs_write_lock(dir->i_sb);
     journal_begin(&th, dir->i_sb, jbegin_count) ;
     windex = push_journal_writer("reiserfs_rmdir") ;
 
@@ -794,7 +794,7 @@
     pop_journal_writer(windex) ;
     journal_end(&th, dir->i_sb, jbegin_count) ;
     reiserfs_check_path(&path) ;
-    unlock_kernel();
+    reiserfs_write_unlock(dir->i_sb);
     return 0;
 	
  end_rmdir:
@@ -804,7 +804,7 @@
     pathrelse (&path);
     pop_journal_writer(windex) ;
     journal_end(&th, dir->i_sb, jbegin_count) ;
-    unlock_kernel();
+    reiserfs_write_unlock(dir->i_sb);
     return retval;	
 }
 
@@ -824,7 +824,7 @@
        two stat datas */
     jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2;
 
-    lock_kernel();
+    reiserfs_write_lock(dir->i_sb);
     journal_begin(&th, dir->i_sb, jbegin_count) ;
     windex = push_journal_writer("reiserfs_unlink") ;
 	
@@ -873,7 +873,7 @@
     pop_journal_writer(windex) ;
     journal_end(&th, dir->i_sb, jbegin_count) ;
     reiserfs_check_path(&path) ;
-    unlock_kernel();
+    reiserfs_write_unlock(dir->i_sb);
     return 0;
 
  end_unlink:
@@ -881,7 +881,7 @@
     pop_journal_writer(windex) ;
     journal_end(&th, dir->i_sb, jbegin_count) ;
     reiserfs_check_path(&path) ;
-    unlock_kernel();
+    reiserfs_write_unlock(dir->i_sb);
     return retval;
 }
 
@@ -904,7 +904,7 @@
         return retval;
     }
 
-    lock_kernel();
+    reiserfs_write_lock(parent_dir->i_sb);
     item_len = ROUND_UP (strlen (symname));
     if (item_len > MAX_DIRECT_ITEM_LEN (parent_dir->i_sb->s_blocksize)) {
 	retval =  -ENAMETOOLONG;
@@ -953,7 +953,7 @@
     d_instantiate(dentry, inode);
     journal_end(&th, parent_dir->i_sb, jbegin_count) ;
 out_failed:
-    unlock_kernel();
+    reiserfs_write_unlock(parent_dir->i_sb);
     return retval;
 }
 
@@ -966,10 +966,10 @@
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
     time_t ctime;
 
-    lock_kernel();
+    reiserfs_write_lock(dir->i_sb);
     if (inode->i_nlink >= REISERFS_LINK_MAX) {
 	//FIXME: sd_nlink is 32 bit for new files
-	unlock_kernel();
+	reiserfs_write_unlock(dir->i_sb);
 	return -EMLINK;
     }
 
@@ -986,7 +986,7 @@
     if (retval) {
 	pop_journal_writer(windex) ;
 	journal_end(&th, dir->i_sb, jbegin_count) ;
-	unlock_kernel();
+	reiserfs_write_unlock(dir->i_sb);
 	return retval;
     }
 
@@ -999,7 +999,7 @@
     d_instantiate(dentry, inode);
     pop_journal_writer(windex) ;
     journal_end(&th, dir->i_sb, jbegin_count) ;
-    unlock_kernel();
+    reiserfs_write_unlock(dir->i_sb);
     return 0;
 }
 
@@ -1079,17 +1079,17 @@
     // make sure, that oldname still exists and points to an object we
     // are going to rename
     old_de.de_gen_number_bit_string = 0;
-    lock_kernel();
+    reiserfs_write_lock(old_dir->i_sb);
     retval = reiserfs_find_entry (old_dir, old_dentry->d_name.name, old_dentry->d_name.len,
 				  &old_entry_path, &old_de);
     pathrelse (&old_entry_path);
     if (retval == IO_ERROR) {
-	unlock_kernel();
+	reiserfs_write_unlock(old_dir->i_sb);
 	return -EIO;
     }
 
     if (retval != NAME_FOUND || old_de.de_objectid != old_inode->i_ino) {
-	unlock_kernel();
+	reiserfs_write_unlock(old_dir->i_sb);
 	return -ENOENT;
     }
 
@@ -1101,7 +1101,7 @@
 
 	if (new_dentry_inode) {
 	    if (!reiserfs_empty_dir(new_dentry_inode)) {
-		unlock_kernel();
+		reiserfs_write_unlock(old_dir->i_sb);
 		return -ENOTEMPTY;
 	    }
 	}
@@ -1113,13 +1113,13 @@
 	retval = reiserfs_find_entry (old_inode, "..", 2, &dot_dot_entry_path, &dot_dot_de);
 	pathrelse (&dot_dot_entry_path);
 	if (retval != NAME_FOUND) {
-	    unlock_kernel();
+	    reiserfs_write_unlock(old_dir->i_sb);
 	    return -EIO;
 	}
 
 	/* inode number of .. must equal old_dir->i_ino */
 	if (dot_dot_de.de_objectid != old_dir->i_ino) {
-	    unlock_kernel();
+	    reiserfs_write_unlock(old_dir->i_sb);
 	    return -EIO;
 	}
     }
@@ -1138,7 +1138,7 @@
     } else if (retval) {
 	pop_journal_writer(windex) ;
 	journal_end(&th, old_dir->i_sb, jbegin_count) ;
-	unlock_kernel();
+	reiserfs_write_unlock(old_dir->i_sb);
 	return retval;
     }
 
@@ -1286,7 +1286,7 @@
 
     pop_journal_writer(windex) ;
     journal_end(&th, old_dir->i_sb, jbegin_count) ;
-    unlock_kernel();
+    reiserfs_write_unlock(old_dir->i_sb);
     return 0;
 }
 
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Thu May 30 18:42:30 2002
+++ b/fs/reiserfs/super.c	Thu May 30 18:42:30 2002
@@ -69,12 +69,12 @@
 {
 
   int dirty = 0 ;
-  lock_kernel() ;
+  reiserfs_write_lock(s);
   if (!(s->s_flags & MS_RDONLY)) {
     dirty = flush_old_commits(s, 1) ;
   }
   s->s_dirt = dirty;
-  unlock_kernel() ;
+  reiserfs_write_unlock(s);
 }
 
 static void reiserfs_write_super_lockfs (struct super_block * s)
@@ -82,7 +82,7 @@
 
   int dirty = 0 ;
   struct reiserfs_transaction_handle th ;
-  lock_kernel() ;
+  reiserfs_write_lock(s);
   if (!(s->s_flags & MS_RDONLY)) {
     journal_begin(&th, s, 1) ;
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1);
@@ -91,7 +91,7 @@
     journal_end(&th, s, 1) ;
   }
   s->s_dirt = dirty;
-  unlock_kernel() ;
+  reiserfs_write_unlock(s);
 }
 
 void reiserfs_unlockfs(struct super_block *s) {
@@ -455,7 +455,7 @@
 	                  inode->i_ino) ;
         return ;
     }
-    lock_kernel() ;
+    reiserfs_write_lock(inode->i_sb);
 
     /* this is really only used for atime updates, so they don't have
     ** to be included in O_SYNC or fsync
@@ -463,7 +463,7 @@
     journal_begin(&th, inode->i_sb, 1) ;
     reiserfs_update_sd (&th, inode);
     journal_end(&th, inode->i_sb, 1) ;
-    unlock_kernel() ;
+    reiserfs_write_unlock(inode->i_sb);
 }
 
 struct super_operations reiserfs_sops = 
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Thu May 30 18:42:30 2002
+++ b/include/linux/reiserfs_fs.h	Thu May 30 18:42:30 2002
@@ -20,6 +20,7 @@
 #include <asm/unaligned.h>
 #include <linux/bitops.h>
 #include <linux/proc_fs.h>
+#include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include <linux/reiserfs_fs_i.h>
 #include <linux/reiserfs_fs_sb.h>
@@ -2076,6 +2077,12 @@
  
 /* ioctl's command */
 #define REISERFS_IOC_UNPACK		_IOW(0xCD,1,long)
+
+/* Locking primitives */
+/* Right now we are still falling back to (un)lock_kernel, but eventually that
+   would evolve into real per-fs locks */
+#define reiserfs_write_lock( sb ) lock_kernel()
+#define reiserfs_write_unlock( sb ) unlock_kernel()
  			         
 #endif /* _LINUX_REISER_FS_H */
 
