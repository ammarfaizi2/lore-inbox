Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSFJNvx>; Mon, 10 Jun 2002 09:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSFJNu5>; Mon, 10 Jun 2002 09:50:57 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:24960 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S314227AbSFJNuN>;
	Mon, 10 Jun 2002 09:50:13 -0400
Date: Mon, 10 Jun 2002 17:42:55 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADgtoT003851@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 4 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 4 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

   This patch performs comment cleanups and a switch to new mount option
   parsing code. REISERFS_MAX_NAME_LEN changed to REISERFS_MAX_NAME. hash= mount
   option support removed (it was an endless source of user complaints
   that it did not do what it sounds like it does). By Vladimir
   Saveliev.

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 fs/reiserfs/bitmap.c           |    5
 fs/reiserfs/dir.c              |    3
 fs/reiserfs/inode.c            |   32 ---
 fs/reiserfs/namei.c            |  189 ++++++-----------------
 fs/reiserfs/super.c            |  331 +++++++++++++++++++++++------------------
 include/linux/reiserfs_fs.h    |    4
 include/linux/reiserfs_fs_sb.h |    2
 7 files changed, 252 insertions(+), 314 deletions(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.597   -> 1.598  
#	 fs/reiserfs/namei.c	1.38    -> 1.39   
#	 fs/reiserfs/inode.c	1.60    -> 1.61   
#	 fs/reiserfs/super.c	1.45    -> 1.46   
#	include/linux/reiserfs_fs_sb.h	1.14    -> 1.15   
#	   fs/reiserfs/dir.c	1.15    -> 1.16   
#	fs/reiserfs/bitmap.c	1.18    -> 1.19   
#	include/linux/reiserfs_fs.h	1.31    -> 1.32   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.598
# reiserfs_fs_sb.h, reiserfs_fs.h, super.c, namei.c, inode.c, dir.c, bitmap.c:
#   reiserfs: comment cleanups and a switch to new mount option parsing code.  REISERFS_MAX_NAME_LEN changed to REISERFS_MAX_NAME. hash= mount option support removed. By Vladimir Saveliev.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c	Thu May 30 18:42:18 2002
+++ b/fs/reiserfs/bitmap.c	Thu May 30 18:42:18 2002
@@ -670,10 +670,7 @@
   return ret;
 }
 
-//
-// a portion of this function, was derived from minix or ext2's
-// analog. You should be able to tell which portion by looking at the
-// ext2 code and comparing. 
+
 static void __discard_prealloc (struct reiserfs_transaction_handle * th,
 				struct reiserfs_inode_info *ei)
 {
diff -Nru a/fs/reiserfs/dir.c b/fs/reiserfs/dir.c
--- a/fs/reiserfs/dir.c	Thu May 30 18:42:18 2002
+++ b/fs/reiserfs/dir.c	Thu May 30 18:42:18 2002
@@ -109,7 +109,7 @@
 		if (!d_name[d_reclen - 1])
 		    d_reclen = strlen (d_name);
 	
-		if (d_reclen > REISERFS_MAX_NAME_LEN(inode->i_sb->s_blocksize)){
+		if (d_reclen > REISERFS_MAX_NAME(inode->i_sb->s_blocksize)){
 		    /* too big to send back to VFS */
 		    continue ;
 		}
@@ -181,7 +181,6 @@
 
 
  end:
-    // FIXME: ext2_readdir does not reset f_pos
     filp->f_pos = next_pos;
     pathrelse (&path_to_entry);
     reiserfs_check_path(&path_to_entry) ;
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu May 30 18:42:18 2002
+++ b/fs/reiserfs/inode.c	Thu May 30 18:42:18 2002
@@ -20,10 +20,7 @@
 
 static int reiserfs_get_block (struct inode * inode, sector_t block,
 			       struct buffer_head * bh_result, int create);
-//
-// initially this function was derived from minix or ext2's analog and
-// evolved as the prototype did
-//
+
 void reiserfs_delete_inode (struct inode * inode)
 {
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2; 
@@ -112,8 +109,7 @@
 }
 
 //
-// FIXME: we might cache recently accessed indirect item (or at least
-// first 15 pointers just like ext2 does
+// FIXME: we might cache recently accessed indirect item
 
 // Ugh.  Not too eager for that....
 //  I cut the code until such time as I see a convincing argument (benchmark).
@@ -521,12 +517,7 @@
 #endif
     return reiserfs_new_unf_blocknrs (th, allocated_block_nr, tag);
 }
-//
-// initially this function was derived from ext2's analog and evolved
-// as the prototype did.  You'll need to look at the ext2 version to
-// determine which parts are derivative, if any, understanding that
-// there are only so many ways to code to a given interface.
-//
+
 int reiserfs_get_block (struct inode * inode, sector_t block,
 			struct buffer_head * bh_result, int create)
 {
@@ -1353,10 +1344,6 @@
 }
 
 
-//
-// initially this function was derived from minix or ext2's analog and
-// evolved as the prototype did
-//
 /* looks for stat data, then copies fields to it, marks the buffer
    containing stat data as dirty */
 /* reiserfs inodes are never really dirty, since the dirty inode call
@@ -2034,18 +2021,13 @@
     return error ;
 }
 
-//
-// this is exactly what 2.3.99-pre9's ext2_readpage is
-//
+
 static int reiserfs_readpage (struct file *f, struct page * page)
 {
     return block_read_full_page (page, reiserfs_get_block);
 }
 
 
-//
-// modified from ext2_writepage is
-//
 static int reiserfs_writepage (struct page * page)
 {
     struct inode *inode = page->mapping->host ;
@@ -2054,9 +2036,6 @@
 }
 
 
-//
-// from ext2_prepare_write, but modified
-//
 int reiserfs_prepare_write(struct file *f, struct page *page, 
 			   unsigned from, unsigned to) {
     struct inode *inode = page->mapping->host ;
@@ -2066,9 +2045,6 @@
 }
 
 
-//
-// this is exactly what 2.3.99-pre9's ext2_bmap is
-//
 static int reiserfs_aop_bmap(struct address_space *as, long block) {
   return generic_block_bmap(as, block, reiserfs_bmap) ;
 }
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Thu May 30 18:42:18 2002
+++ b/fs/reiserfs/namei.c	Thu May 30 18:42:18 2002
@@ -195,13 +195,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_match (struct reiserfs_dir_entry * de, 
 			   const char * name, int namelen)
 {
@@ -284,13 +277,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 // may return NAME_FOUND, NAME_FOUND_INVISIBLE, NAME_NOT_FOUND
 // FIXME: should add something like IOERROR
 static int reiserfs_find_entry (struct inode * dir, const char * name, int namelen, 
@@ -300,7 +286,7 @@
     int retval;
 
 
-    if (namelen > REISERFS_MAX_NAME_LEN (dir->i_sb->s_blocksize))
+    if (namelen > REISERFS_MAX_NAME (dir->i_sb->s_blocksize))
 	return NAME_NOT_FOUND;
 
     /* we will search for this key in the tree */
@@ -330,13 +316,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static struct dentry * reiserfs_lookup (struct inode * dir, struct dentry * dentry)
 {
     int retval;
@@ -344,7 +323,7 @@
     struct reiserfs_dir_entry de;
     INITIALIZE_PATH (path_to_entry);
 
-    if (dentry->d_name.len > REISERFS_MAX_NAME_LEN (dir->i_sb->s_blocksize))
+    if (REISERFS_MAX_NAME (dir->i_sb->s_blocksize) < dentry->d_name.len)
 	return ERR_PTR(-ENAMETOOLONG);
 
     lock_kernel();
@@ -412,14 +391,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
-
 /* add entry to the directory (entry can be hidden). 
 
 insert definition of when hidden directories are used here -Hans
@@ -447,7 +418,7 @@
     if (!namelen)
 	return -EINVAL;
 
-    if (namelen > REISERFS_MAX_NAME_LEN (dir->i_sb->s_blocksize))
+    if (namelen > REISERFS_MAX_NAME (dir->i_sb->s_blocksize))
 	return -ENAMETOOLONG;
 
     /* each entry has unique key. compose it */
@@ -587,13 +558,6 @@
     return 0 ;
 }
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_create (struct inode * dir, struct dentry *dentry, int mode)
 {
     int retval;
@@ -601,8 +565,7 @@
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 ;
     struct reiserfs_transaction_handle th ;
 
-    inode = new_inode(dir->i_sb) ;
-    if (!inode) {
+    if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
     retval = new_inode_init(inode, dir, mode);
@@ -642,13 +605,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_mknod (struct inode * dir, struct dentry *dentry, int mode, int rdev)
 {
     int retval;
@@ -656,8 +612,7 @@
     struct reiserfs_transaction_handle th ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
 
-    inode = new_inode(dir->i_sb) ;
-    if (!inode) {
+    if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
     retval = new_inode_init(inode, dir, mode);
@@ -699,13 +654,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_mkdir (struct inode * dir, struct dentry *dentry, int mode)
 {
     int retval;
@@ -714,8 +662,7 @@
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
 
     mode = S_IFDIR | mode;
-    inode = new_inode(dir->i_sb) ;
-    if (!inode) {
+    if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
     retval = new_inode_init(inode, dir, mode);
@@ -779,14 +726,6 @@
     return 1 ;
 }
 
-
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_rmdir (struct inode * dir, struct dentry *dentry)
 {
     int retval;
@@ -869,14 +808,6 @@
     return retval;	
 }
 
-
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_unlink (struct inode * dir, struct dentry *dentry)
 {
     int retval;
@@ -954,15 +885,8 @@
     return retval;
 }
 
-
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
-static int reiserfs_symlink (struct inode * dir, struct dentry * dentry, const char * symname)
+static int reiserfs_symlink (struct inode * parent_dir, 
+                            struct dentry * dentry, const char * symname)
 {
     int retval;
     struct inode * inode;
@@ -972,24 +896,23 @@
     int mode = S_IFLNK | S_IRWXUGO;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
 
-    inode = new_inode(dir->i_sb) ;
-    if (!inode) {
+    if (!(inode = new_inode(parent_dir->i_sb))) {
 	return -ENOMEM ;
     }
-    retval = new_inode_init(inode, dir, mode);
+    retval = new_inode_init(inode, parent_dir, mode);
     if (retval) {
         return retval;
     }
 
     lock_kernel();
     item_len = ROUND_UP (strlen (symname));
-    if (item_len > MAX_DIRECT_ITEM_LEN (dir->i_sb->s_blocksize)) {
+    if (item_len > MAX_DIRECT_ITEM_LEN (parent_dir->i_sb->s_blocksize)) {
 	retval =  -ENAMETOOLONG;
 	drop_new_inode(inode);
 	goto out_failed;
     }
   
-    name = reiserfs_kmalloc (item_len, GFP_NOFS, dir->i_sb);
+    name = reiserfs_kmalloc (item_len, GFP_NOFS, parent_dir->i_sb);
     if (!name) {
 	drop_new_inode(inode);
 	retval =  -ENOMEM;
@@ -998,17 +921,17 @@
     memcpy (name, symname, strlen (symname));
     padd_item (name, item_len, strlen (symname));
 
-    journal_begin(&th, dir->i_sb, jbegin_count) ;
+    journal_begin(&th, parent_dir->i_sb, jbegin_count) ;
 
-    retval = reiserfs_new_inode (&th, dir, mode, name, strlen (symname), 
+    retval = reiserfs_new_inode (&th, parent_dir, mode, name, strlen (symname), 
                                  dentry, inode);
-    reiserfs_kfree (name, item_len, dir->i_sb);
+    reiserfs_kfree (name, item_len, parent_dir->i_sb);
     if (retval) { /* reiserfs_new_inode iputs for us */
 	goto out_failed;
     }
 
     reiserfs_update_inode_transaction(inode) ;
-    reiserfs_update_inode_transaction(dir) ;
+    reiserfs_update_inode_transaction(parent_dir) ;
 
     inode->i_op = &page_symlink_inode_operations;
     inode->i_mapping->a_ops = &reiserfs_address_space_operations;
@@ -1017,31 +940,23 @@
     //
     //reiserfs_update_sd (&th, inode, READ_BLOCKS);
 
-    retval = reiserfs_add_entry (&th, dir, dentry->d_name.name, dentry->d_name.len, 
-				 inode, 1/*visible*/);
+    retval = reiserfs_add_entry (&th, parent_dir, dentry->d_name.name, 
+                                 dentry->d_name.len, inode, 1/*visible*/);
     if (retval) {
 	inode->i_nlink--;
 	reiserfs_update_sd (&th, inode);
-	journal_end(&th, dir->i_sb, jbegin_count) ;
+	journal_end(&th, parent_dir->i_sb, jbegin_count) ;
 	iput (inode);
 	goto out_failed;
     }
 
     d_instantiate(dentry, inode);
-    journal_end(&th, dir->i_sb, jbegin_count) ;
+    journal_end(&th, parent_dir->i_sb, jbegin_count) ;
 out_failed:
     unlock_kernel();
     return retval;
 }
 
-
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_link (struct dentry * old_dentry, struct inode * dir, struct dentry * dentry)
 {
     int retval;
@@ -1049,6 +964,7 @@
     int windex ;
     struct reiserfs_transaction_handle th ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
+    time_t ctime;
 
     lock_kernel();
     if (inode->i_nlink >= REISERFS_LINK_MAX) {
@@ -1075,7 +991,8 @@
     }
 
     inode->i_nlink++;
-    inode->i_ctime = CURRENT_TIME;
+    ctime = CURRENT_TIME;
+    inode->i_ctime = ctime;
     reiserfs_update_sd (&th, inode);
 
     atomic_inc(&inode->i_count) ;
@@ -1129,14 +1046,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
-
 /* 
  * process, that is going to call fix_nodes/do_balance must hold only
  * one path. If it holds 2 or more, it can get into endless waiting in
@@ -1151,10 +1060,12 @@
     INITIALIZE_PATH (dot_dot_entry_path);
     struct item_head new_entry_ih, old_entry_ih, dot_dot_ih ;
     struct reiserfs_dir_entry old_de, new_de, dot_dot_de;
-    struct inode * old_inode, * new_inode;
+    struct inode * old_inode, * new_dentry_inode;
     int windex ;
     struct reiserfs_transaction_handle th ;
     int jbegin_count ; 
+    umode_t old_inode_mode;
+    time_t ctime;
 
 
     /* two balancings: old name removal, new name insertion or "save" link,
@@ -1163,7 +1074,7 @@
     jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 3;
 
     old_inode = old_dentry->d_inode;
-    new_inode = new_dentry->d_inode;
+    new_dentry_inode = new_dentry->d_inode;
 
     // make sure, that oldname still exists and points to an object we
     // are going to rename
@@ -1182,13 +1093,14 @@
 	return -ENOENT;
     }
 
-    if (S_ISDIR(old_inode->i_mode)) {
+    old_inode_mode = old_inode->i_mode;
+    if (S_ISDIR(old_inode_mode)) {
 	// make sure, that directory being renamed has correct ".." 
 	// and that its new parent directory has not too many links
 	// already
 
-	if (new_inode) {
-	    if (!reiserfs_empty_dir(new_inode)) {
+	if (new_dentry_inode) {
+	    if (!reiserfs_empty_dir(new_dentry_inode)) {
 		unlock_kernel();
 		return -ENOTEMPTY;
 	    }
@@ -1219,9 +1131,7 @@
     retval = reiserfs_add_entry (&th, new_dir, new_dentry->d_name.name, new_dentry->d_name.len, 
 				 old_inode, 0);
     if (retval == -EEXIST) {
-	// FIXME: is it possible, that new_inode == 0 here? If yes, it
-	// is not clear how does ext2 handle that
-	if (!new_inode) {
+	if (!new_dentry_inode) {
 	    reiserfs_panic (old_dir->i_sb,
 			    "vs-7050: new entry is found, new inode == 0\n");
 	}
@@ -1240,8 +1150,8 @@
     */
     reiserfs_update_inode_transaction(old_inode) ;
 
-    if (new_inode) 
-	reiserfs_update_inode_transaction(new_inode) ;
+    if (new_dentry_inode) 
+	reiserfs_update_inode_transaction(new_dentry_inode) ;
 
     while (1) {
 	// look for old name using corresponding entry key (found by reiserfs_find_entry)
@@ -1288,18 +1198,18 @@
 	if (item_moved(&new_entry_ih, &new_entry_path) ||
 	    !entry_points_to_object(new_dentry->d_name.name, 
 	                            new_dentry->d_name.len,
-				    &new_de, new_inode) ||
+				    &new_de, new_dentry_inode) ||
 	    item_moved(&old_entry_ih, &old_entry_path) || 
 	    !entry_points_to_object (old_dentry->d_name.name, 
 	                             old_dentry->d_name.len,
 				     &old_de, old_inode)) {
 	    reiserfs_restore_prepared_buffer (old_inode->i_sb, new_de.de_bh);
 	    reiserfs_restore_prepared_buffer (old_inode->i_sb, old_de.de_bh);
-	    if (S_ISDIR(old_inode->i_mode))
+	    if (S_ISDIR(old_inode_mode))
 		reiserfs_restore_prepared_buffer (old_inode->i_sb, dot_dot_de.de_bh);
 	    continue;
 	}
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (S_ISDIR(old_inode_mode)) {
 	    if ( item_moved(&dot_dot_ih, &dot_dot_entry_path) ||
 		!entry_points_to_object ( "..", 2, &dot_dot_de, old_dir) ) {
 		reiserfs_restore_prepared_buffer (old_inode->i_sb, old_de.de_bh);
@@ -1309,7 +1219,7 @@
 	    }
 	}
 
-	RFALSE( S_ISDIR(old_inode->i_mode) && 
+	RFALSE( S_ISDIR(old_inode_mode) && 
 		 !reiserfs_buffer_prepared(dot_dot_de.de_bh), "" );
 
 	break;
@@ -1327,22 +1237,23 @@
     old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
     new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
 
-    if (new_inode) {
+    if (new_dentry_inode) {
 	// adjust link number of the victim
-	if (S_ISDIR(new_inode->i_mode)) {
-	    new_inode->i_nlink  = 0;
+	if (S_ISDIR(new_dentry_inode->i_mode)) {
+	    new_dentry_inode->i_nlink  = 0;
 	} else {
-	    new_inode->i_nlink--;
+	    new_dentry_inode->i_nlink--;
 	}
-	new_inode->i_ctime = CURRENT_TIME;
+	ctime = CURRENT_TIME;
+	new_dentry_inode->i_ctime = ctime;
     }
 
-    if (S_ISDIR(old_inode->i_mode)) {
+    if (S_ISDIR(old_inode_mode)) {
 	// adjust ".." of renamed directory 
 	set_ino_in_dir_entry (&dot_dot_de, INODE_PKEY (new_dir));
 	journal_mark_dirty (&th, new_dir->i_sb, dot_dot_de.de_bh);
 	
-        if (!new_inode)
+        if (!new_dentry_inode)
 	    /* there (in new_dir) was no directory, so it got new link
 	       (".."  of renamed directory) */
 	    INC_DIR_INODE_NLINK(new_dir);
@@ -1367,10 +1278,10 @@
     reiserfs_update_sd (&th, old_dir);
     reiserfs_update_sd (&th, new_dir);
 
-    if (new_inode) {
-	if (new_inode->i_nlink == 0)
-	    add_save_link (&th, new_inode, 0/* not truncate */);
-	reiserfs_update_sd (&th, new_inode);
+    if (new_dentry_inode) {
+	if (new_dentry_inode->i_nlink == 0)
+	    add_save_link (&th, new_dentry_inode, 0/* not truncate */);
+	reiserfs_update_sd (&th, new_dentry_inode);
     }
 
     pop_journal_writer(windex) ;
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Thu May 30 18:42:18 2002
+++ b/fs/reiserfs/super.c	Thu May 30 18:42:18 2002
@@ -65,13 +65,6 @@
 static int reiserfs_remount (struct super_block * s, int * flags, char * data);
 static int reiserfs_statfs (struct super_block * s, struct statfs * buf);
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static void reiserfs_write_super (struct super_block * s)
 {
 
@@ -84,13 +77,6 @@
   unlock_kernel() ;
 }
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static void reiserfs_write_super_lockfs (struct super_block * s)
 {
 
@@ -369,13 +355,6 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static void reiserfs_put_super (struct super_block * s)
 {
   int i;
@@ -510,100 +489,190 @@
   get_dentry: reiserfs_get_dentry,
 } ;
 
-/* this was (ext2)parse_options */
-static int parse_options (char * options, unsigned long * mount_options, unsigned long * blocks, char **jdev_name)
-{
-    char * this_char;
+/* this struct is used in reiserfs_getopt () for containing the value for those
+   mount options that have values rather than being toggles. */
+typedef struct {
     char * value;
-  
+    int bitmask; /* bit which is to be set in mount_options bitmask when this
+                    value is found, 0 is no bits are to be set */
+} arg_desc_t;
+
+
+/* this struct is used in reiserfs_getopt() for describing the set of reiserfs
+   mount options */
+typedef struct {
+    char * option_name;
+    int arg_required; /* 0 if argument is not required, not 0 otherwise */
+    const arg_desc_t * values; /* list of values accepted by an option */
+    int bitmask;  /* bit which is to be set in mount_options bitmask when this
+		     option is selected, 0 is not bits are to be set */
+} opt_desc_t;
+
+/* possible values for "-o block-allocator=" and bits which are to be set in
+   s_mount_opt of reiserfs specific part of in-core super block */
+const arg_desc_t balloc[] = {
+    {"noborder", REISERFS_NO_BORDER},
+    {"no_unhashed_relocation", REISERFS_NO_UNHASHED_RELOCATION},
+    {"hashed_relocation", REISERFS_HASHED_RELOCATION},
+    {"test4", REISERFS_TEST4},
+    {NULL, -1}
+};
+
+
+/* proceed only one option from a list *cur - string containing of mount options
+   opts - array of options which are accepted
+   opt_arg - if option is found and requires an argument and if it is specifed
+   in the input - pointer to the argument is stored here
+   bit_flags - if option requires to set a certain bit - it is set here
+   return -1 if unknown option is found, opt->arg_required otherwise */
+static int reiserfs_getopt (char ** cur, opt_desc_t * opts, char ** opt_arg,
+			    unsigned long * bit_flags)
+{
+    char * p;
+    /* foo=bar, 
+       ^   ^  ^
+       |   |  +-- option_end
+       |   +-- arg_start
+       +-- option_start
+    */
+    const opt_desc_t * opt;
+    const arg_desc_t * arg;
+    
+    
+    p = *cur;
+    
+    /* assume argument cannot contain commas */
+    *cur = strchr (p, ',');
+    if (*cur) {
+	*(*cur) = '\0';
+	(*cur) ++;
+    }
+    
+    /* for every option in the list */
+    for (opt = opts; opt->option_name; opt ++) {
+	if (!strncmp (p, opt->option_name, strlen (opt->option_name))) {
+	    if (bit_flags && opt->bitmask != -1)
+		set_bit (opt->bitmask, bit_flags);
+	    break;
+	}
+    }
+    if (!opt->option_name) {
+	printk ("reiserfs_getopt: unknown option \"%s\"\n", p);
+	return -1;
+    }
+    
+    p += strlen (opt->option_name);
+    switch (*p) {
+    case '=':
+	if (!opt->arg_required) {
+	    printk ("reiserfs_getopt: the option \"%s\" does not require an argument\n",
+		    opt->option_name);
+	    return -1;
+	}
+	break;
+	
+    case 0:
+	if (opt->arg_required) {
+	    printk ("reiserfs_getopt: the option \"%s\" requires an argument\n", opt->option_name);
+	    return -1;
+	}
+	break;
+    default:
+	printk ("reiserfs_getopt: head of option \"%s\" is only correct\n", opt->option_name);
+	return -1;
+    }
+	
+    /* move to the argument, or to next option if argument is not required */
+    p ++;
+    
+    if ( opt->arg_required && !strlen (p) ) {
+	/* this catches "option=," */
+	printk ("reiserfs_getopt: empty argument for \"%s\"\n", opt->option_name);
+	return -1;
+    }
+    
+    if (!opt->values) {
+	/* *opt_arg contains pointer to argument */
+	*opt_arg = p;
+	return opt->arg_required;
+    }
+    
+    /* values possible for this option are listed in opt->values */
+    for (arg = opt->values; arg->value; arg ++) {
+	if (!strcmp (p, arg->value)) {
+	    if (bit_flags && arg->bitmask != -1 )
+		set_bit (arg->bitmask, bit_flags);
+	    return opt->arg_required;
+	}
+    }
+    
+    printk ("reiserfs_getopt: bad value \"%s\" for option \"%s\"\n", p, opt->option_name);
+    return -1;
+}
+
+
+/* returns 0 if something is wrong in option string, 1 - otherwise */
+static int reiserfs_parse_options (char * options, /* string given via mount's -o */
+				   unsigned long * mount_options,
+				   /* after the parsing phase, contains the
+				      collection of bitflags defining what
+				      mount options were selected. */
+				   unsigned long * blocks, /* strtol-ed from NNN of resize=NNN */
+				   char ** jdev_name)
+{
+    int c;
+    char * arg = NULL;
+    char * pos;
+    opt_desc_t opts[] = {
+		{"notail", 0, 0, NOTAIL},
+		{"conv", 0, 0, REISERFS_CONVERT}, 
+		{"attrs", 0, 0, REISERFS_ATTRS}, 
+		{"nolog", 0, 0, -1},
+		{"replayonly", 0, 0, REPLAYONLY},
+		
+		{"block-allocator", 'a', balloc, -1}, 
+		
+		{"resize", 'r', 0, -1},
+		{"jdev", 'j', 0, -1},
+		{NULL, 0, 0, -1}
+    };
+	
     *blocks = 0;
-    if (!options)
+    if (!options || !*options)
 	/* use default configuration: create tails, journaling on, no
-           conversion to newest format */
+	   conversion to newest format */
 	return 1;
-    while ((this_char = strsep (&options, ",")) != NULL) {
-	if (!*this_char)
-	    continue;
-	if ((value = strchr (this_char, '=')) != NULL)
-	    *value++ = 0;
-	if (!strcmp (this_char, "notail")) {
-	    set_bit (NOTAIL, mount_options);
-	} else if (!strcmp (this_char, "conv")) {
-	    // if this is set, we update super block such that
-	    // the partition will not be mounable by 3.5.x anymore
-	    set_bit (REISERFS_CONVERT, mount_options);
-	} else if (!strcmp (this_char, "noborder")) {
-				/* this is used for benchmarking
-                                   experimental variations, it is not
-                                   intended for users to use, only for
-                                   developers who want to casually
-                                   hack in something to test */
-	    set_bit (REISERFS_NO_BORDER, mount_options);
-	} else if (!strcmp (this_char, "no_unhashed_relocation")) {
-	    set_bit (REISERFS_NO_UNHASHED_RELOCATION, mount_options);
-	} else if (!strcmp (this_char, "hashed_relocation")) {
-	    set_bit (REISERFS_HASHED_RELOCATION, mount_options);
-	} else if (!strcmp (this_char, "test4")) {
-	    set_bit (REISERFS_TEST4, mount_options);
-	} else if (!strcmp (this_char, "nolog")) {
-	    reiserfs_warning("reiserfs: nolog mount option not supported yet\n");
-	} else if (!strcmp (this_char, "replayonly")) {
-	    set_bit (REPLAYONLY, mount_options);
-	} else if (!strcmp (this_char, "resize")) {
-	    if (value && *value){
-		*blocks = simple_strtoul (value, &value, 0);
-	    } else {
-	  	printk("reiserfs: resize option requires a value\n");
+    
+    for (pos = options; pos; ) {
+	c = reiserfs_getopt (&pos, opts, &arg, mount_options);
+	if (c == -1)
+	    /* wrong option is given */
+	    return 0;
+	
+	if (c == 'r') {
+	    char * p;
+	    
+	    p = 0;
+	    /* "resize=NNN" */
+	    *blocks = simple_strtoul (arg, &p, 0);
+	    if (*p != '\0') {
+		/* NNN does not look like a number */
+		printk ("reiserfs_parse_options: bad value %s\n", arg);
 		return 0;
 	    }
-	} else if (!strcmp (this_char, "hash")) {
-	    if (value && *value) {
-		/* if they specify any hash option, we force detection
-		** to make sure they aren't using the wrong hash
-		*/
-	        if (!strcmp(value, "rupasov")) {
-		    set_bit (FORCE_RUPASOV_HASH, mount_options);
-		    set_bit (FORCE_HASH_DETECT, mount_options);
-		} else if (!strcmp(value, "tea")) {
-		    set_bit (FORCE_TEA_HASH, mount_options);
-		    set_bit (FORCE_HASH_DETECT, mount_options);
-		} else if (!strcmp(value, "r5")) {
-		    set_bit (FORCE_R5_HASH, mount_options);
-		    set_bit (FORCE_HASH_DETECT, mount_options);
-		} else if (!strcmp(value, "detect")) {
-		    set_bit (FORCE_HASH_DETECT, mount_options);
-		} else {
-		    printk("reiserfs: invalid hash function specified\n") ;
-		    return 0 ;
-		}
-	    } else {
-	  	printk("reiserfs: hash option requires a value\n");
-		return 0 ;
-	    }
-	} else if (!strcmp (this_char, "jdev")) {
-	    if (value && *value && jdev_name) {
-		    *jdev_name = value;
-	    } else {
-		    printk("reiserfs: jdev option requires a value\n");
-		    return 0 ;
+	}
+
+	if (c == 'j') {
+	    if (arg && *arg && jdev_name) {
+		*jdev_name = arg;
 	    }
-	} else {
-	    printk ("reiserfs: Unrecognized mount option %s\n", this_char);
-	    return 0;
 	}
     }
+    
     return 1;
 }
 
-
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
-static int reiserfs_remount (struct super_block * s, int * flags, char * data)
+static int reiserfs_remount (struct super_block * s, int * mount_flags, char * arg)
 {
   struct reiserfs_super_block * rs;
   struct reiserfs_transaction_handle th ;
@@ -611,21 +680,21 @@
   unsigned long mount_options;
 
   rs = SB_DISK_SUPER_BLOCK (s);
-  if (!parse_options(data, &mount_options, &blocks, NULL))
-  	return 0;
 
+  if (!reiserfs_parse_options(arg, &mount_options, &blocks, NULL))
+    return -EINVAL;
+  
   if(blocks) {
-      int rc = reiserfs_resize(s, blocks);
-      if (rc != 0)
-	  return rc;
+    int rc = reiserfs_resize(s, blocks);
+    if (rc != 0)
+      return rc;
   }
 
-  if ((unsigned long)(*flags & MS_RDONLY) == (s->s_flags & MS_RDONLY)) {
-    /* there is nothing to do to remount read-only fs as read-only fs */
-    return 0;
-  }
-  
-  if (*flags & MS_RDONLY) {
+  if (*mount_flags & MS_RDONLY) {
+    /* remount rean-only */
+    if (s->s_flags & MS_RDONLY)
+      /* it is read-only already */
+      return 0;
     /* try to remount file system with read-only permissions */
     if (sb_umount_state(rs) == REISERFS_VALID_FS || REISERFS_SB(s)->s_mount_state != REISERFS_VALID_FS) {
       return 0;
@@ -641,7 +710,7 @@
     REISERFS_SB(s)->s_mount_state = sb_umount_state(rs) ;
     s->s_flags &= ~MS_RDONLY ; /* now it is safe to call journal_begin */
     journal_begin(&th, s, 10) ;
-
+    
     /* Mount a partition which is read-only, read-write */
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
     REISERFS_SB(s)->s_mount_state = sb_umount_state(rs);
@@ -656,7 +725,7 @@
   SB_JOURNAL(s)->j_must_wait = 1 ;
   journal_end(&th, s, 10) ;
 
-  if (!( *flags & MS_RDONLY ) )
+  if (!( *mount_flags & MS_RDONLY ) )
     finish_unfinished( s );
 
   return 0;
@@ -997,13 +1066,6 @@
     return 0;
 }
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_fill_super (struct super_block * s, void * data, int silent)
 {
     struct inode *root_inode;
@@ -1027,7 +1089,7 @@
     memset (sbi, 0, sizeof (struct reiserfs_sb_info));
 
     jdev_name = NULL;
-    if (parse_options ((char *) data, &(sbi->s_mount_opt), &blocks, &jdev_name) == 0) {
+    if (reiserfs_parse_options ((char *) data, &(sbi->s_mount_opt), &blocks, &jdev_name) == 0) {
 	goto error;
     }
 
@@ -1191,26 +1253,19 @@
 }
 
 
-//
-// a portion of this function, particularly the VFS interface portion,
-// was derived from minix or ext2's analog and evolved as the
-// prototype did. You should be able to tell which portion by looking
-// at the ext2 code and comparing. It's subfunctions contain no code
-// used as a template unless they are so labeled.
-//
 static int reiserfs_statfs (struct super_block * s, struct statfs * buf)
 {
   struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
   
-				/* changed to accomodate gcc folks.*/
-  buf->f_type    =  REISERFS_SUPER_MAGIC;
-  buf->f_bsize   = s->s_blocksize;
-  buf->f_blocks  = sb_block_count(rs) - sb_bmap_nr(rs) - 1;
+  buf->f_namelen = (REISERFS_MAX_NAME (s->s_blocksize));
+  buf->f_ffree   = -1;
+  buf->f_files   = -1;
   buf->f_bfree   = sb_free_blocks(rs);
   buf->f_bavail  = buf->f_bfree;
-  buf->f_files   = -1;
-  buf->f_ffree   = -1;
-  buf->f_namelen = (REISERFS_MAX_NAME_LEN (s->s_blocksize));
+  buf->f_blocks  = sb_block_count(rs) - sb_bmap_nr(rs) - 1;
+  buf->f_bsize   = s->s_blocksize;
+  /* changed to accomodate gcc folks.*/
+  buf->f_type    =  REISERFS_SUPER_MAGIC;
   return 0;
 }
 
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Thu May 30 18:42:18 2002
+++ b/include/linux/reiserfs_fs.h	Thu May 30 18:42:18 2002
@@ -1062,9 +1062,7 @@
 #define B_I_E_NAME(bh,ih,entry_num) ((char *)(bh->b_data + ih_location(ih) + deh_location(B_I_DEH(bh,ih)+(entry_num))))
 
 // two entries per block (at least)
-//#define REISERFS_MAX_NAME_LEN(block_size) 
-//((block_size - BLKH_SIZE - IH_SIZE - DEH_SIZE * 2) / 2)
-#define REISERFS_MAX_NAME_LEN(block_size) 255
+#define REISERFS_MAX_NAME(block_size) 255
 
 
 /* this structure is used for operations on directory entries. It is
diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	Thu May 30 18:42:18 2002
+++ b/include/linux/reiserfs_fs_sb.h	Thu May 30 18:42:18 2002
@@ -408,6 +408,8 @@
 #define REISERFS_HASHED_RELOCATION 13
 #define REISERFS_TEST4 14 
 
+#define REISERFS_ATTRS 15
+
 #define REISERFS_TEST1 11
 #define REISERFS_TEST2 12
 #define REISERFS_TEST3 13
