Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTATL07>; Mon, 20 Jan 2003 06:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbTATL07>; Mon, 20 Jan 2003 06:26:59 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:47082 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265675AbTATL0v>; Mon, 20 Jan 2003 06:26:51 -0500
Message-ID: <3E2BDF17.60501@namesys.com>
Date: Mon, 20 Jan 2003 14:35:51 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK] [2.4] ReiserFS iput deadlock fix
Content-Type: multipart/mixed;
 boundary="------------000104070104060700040005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000104070104060700040005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Please apply.

-- 
Hans


--------------000104070104060700040005
Content-Type: message/rfc822;
 name="[2.4] iput deadlock fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[2.4] iput deadlock fix"

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 28985 invoked from network); 20 Jan 2003 10:30:31 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 20 Jan 2003 10:30:31 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 9CB3B3F281; Mon, 20 Jan 2003 13:30:31 +0300 (MSK)
Date: Mon, 20 Jan 2003 13:30:31 +0300
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [2.4] iput deadlock fix
Message-ID: <20030120133031.A1296@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i

Hello!

   This changeset fixes possible iput deadlock in reiserfs, when iput
   is called and transaction is open. This is sometimes happen when
   there is no free space on the partition.
   Please apply.

   You can pull it from
   bk://thebsh.namesys.com/bk/reiser3-linux-2.4-iput-ddlk-fix

Diffstat:
 fs/reiserfs/inode.c         |  120 +++++++++++++++++++----------------
 fs/reiserfs/namei.c         |  147 +++++++++++++++++++++++++++-----------------
 include/linux/reiserfs_fs.h |   11 +--
 3 files changed, 162 insertions(+), 116 deletions(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.903   -> 1.904  
#	 fs/reiserfs/inode.c	1.40    -> 1.41   
#	 fs/reiserfs/namei.c	1.24    -> 1.25   
#	include/linux/reiserfs_fs.h	1.25    -> 1.26   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/20	green@angband.namesys.com	1.904
# reiserfs: iput deadlock fix - do not call iput() from inside of transaction
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Mon Jan 20 13:29:01 2003
+++ b/fs/reiserfs/inode.c	Mon Jan 20 13:29:01 2003
@@ -1463,13 +1463,22 @@
 /* inserts the stat data into the tree, and then calls
    reiserfs_new_directory (to insert ".", ".." item if new object is
    directory) or reiserfs_new_symlink (to insert symlink body if new
-   object is symlink) or nothing (if new object is regular file) */
-struct inode * reiserfs_new_inode (struct reiserfs_transaction_handle *th,
-				   struct inode * dir, int mode, 
-				   const char * symname, 
-				   int i_size, /* 0 for regular, EMTRY_DIR_SIZE for dirs,
-						  strlen (symname) for symlinks)*/
-				   struct dentry *dentry, struct inode *inode, int * err)
+   object is symlink) or nothing (if new object is regular file)
+
+   NOTE! uid and gid must already be set in the inode.  If we return
+   non-zero due to an error, we have to drop the quota previously allocated
+   for the fresh inode.  This can only be done outside a transaction, so
+   if we return non-zero, we also end the transaction.
+
+   */
+int reiserfs_new_inode (struct reiserfs_transaction_handle *th,
+				struct inode * dir, int mode,
+				const char * symname,
+				/* 0 for regular, EMTRY_DIR_SIZE for dirs,
+				   strlen (symname) for symlinks) */
+				int i_size,
+				struct dentry *dentry,
+				struct inode *inode)
 {
     struct super_block * sb;
     INITIALIZE_PATH (path_to_key);
@@ -1477,11 +1486,11 @@
     struct item_head ih;
     struct stat_data sd;
     int retval;
+    int err ;
   
     if (!dir || !dir->i_nlink) {
-	*err = -EPERM;
-	iput(inode) ;
-	return NULL;
+	err = -EPERM ;
+	goto out_bad_inode ;
     }
 
     sb = dir->i_sb;
@@ -1489,13 +1498,16 @@
 	    dir -> u.reiserfs_i.i_attrs & REISERFS_INHERIT_MASK;
     sd_attrs_to_i_attrs( inode -> u.reiserfs_i.i_attrs, inode );
 
+    /* symlink cannot be immutable or append only, right? */
+    if( S_ISLNK( inode -> i_mode ) )
+	    inode -> i_flags &= ~ ( S_IMMUTABLE | S_APPEND );
+
     /* item head of new item */
     ih.ih_key.k_dir_id = INODE_PKEY (dir)->k_objectid;
     ih.ih_key.k_objectid = cpu_to_le32 (reiserfs_get_unused_objectid (th));
     if (!ih.ih_key.k_objectid) {
-	iput(inode) ;
-	*err = -ENOMEM;
-	return NULL;
+	err = -ENOMEM ;
+	goto out_bad_inode ;
     }
     if (old_format_only (sb))
       /* not a perfect generation count, as object ids can be reused, but this
@@ -1511,12 +1523,24 @@
 #else
       inode->i_generation = ++event;
 #endif
+    /* fill stat data */
+    inode->i_nlink = (S_ISDIR (mode) ? 2 : 1);
+
+    /* uid and gid must already be set by the caller for quota init */
+
+    inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+    inode->i_size = i_size;
+    inode->i_blocks = (inode->i_size + 511) >> 9;
+    inode->u.reiserfs_i.i_first_direct_byte = S_ISLNK(mode) ? 1 : 
+      U32_MAX/*NO_BYTES_IN_DIRECT_ITEM*/;
+
+    INIT_LIST_HEAD(&inode->u.reiserfs_i.i_prealloc_list) ;
+
     if (old_format_only (sb))
 	make_le_item_head (&ih, 0, KEY_FORMAT_3_5, SD_OFFSET, TYPE_STAT_DATA, SD_V1_SIZE, MAX_US_INT);
     else
 	make_le_item_head (&ih, 0, KEY_FORMAT_3_6, SD_OFFSET, TYPE_STAT_DATA, SD_SIZE, MAX_US_INT);
 
-
     /* key to search for correct place for new stat data */
     _make_cpu_key (&key, KEY_FORMAT_3_6, le32_to_cpu (ih.ih_key.k_dir_id),
 		   le32_to_cpu (ih.ih_key.k_objectid), SD_OFFSET, TYPE_STAT_DATA, 3/*key length*/);
@@ -1524,47 +1548,21 @@
     /* find proper place for inserting of stat data */
     retval = search_item (sb, &key, &path_to_key);
     if (retval == IO_ERROR) {
-	iput (inode);
-	*err = -EIO;
-	return NULL;
+	err = -EIO;
+	goto out_bad_inode;
     }
     if (retval == ITEM_FOUND) {
 	pathrelse (&path_to_key);
-	iput (inode);
-	*err = -EEXIST;
-	return NULL;
+	err = -EEXIST;
+	goto out_bad_inode;
     }
 
-    /* fill stat data */
-    inode->i_mode = mode;
-    inode->i_nlink = (S_ISDIR (mode) ? 2 : 1);
-    inode->i_uid = current->fsuid;
-    if (dir->i_mode & S_ISGID) {
-	inode->i_gid = dir->i_gid;
-	if (S_ISDIR(mode))
-	    inode->i_mode |= S_ISGID;
-    } else
-	inode->i_gid = current->fsgid;
-
-    /* symlink cannot be immutable or append only, right? */
-    if( S_ISLNK( inode -> i_mode ) )
-	    inode -> i_flags &= ~ ( S_IMMUTABLE | S_APPEND );
-
-    inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-    inode->i_size = i_size;
-    inode->i_blocks = (inode->i_size + 511) >> 9;
-    inode->u.reiserfs_i.i_first_direct_byte = S_ISLNK(mode) ? 1 : 
-      U32_MAX/*NO_BYTES_IN_DIRECT_ITEM*/;
-
-    INIT_LIST_HEAD(&inode->u.reiserfs_i.i_prealloc_list) ;
-
     if (old_format_only (sb)) {
 	if (inode->i_uid & ~0xffff || inode->i_gid & ~0xffff) {
 	    pathrelse (&path_to_key);
 	    /* i_uid or i_gid is too big to be stored in stat data v3.5 */
-	    iput (inode);
-	    *err = -EINVAL;
-	    return NULL;
+	    err = -EINVAL;
+	    goto out_bad_inode;
 	}
 	inode2sd_v1 (&sd, inode);
     } else
@@ -1595,10 +1593,9 @@
 #endif
     retval = reiserfs_insert_item (th, &path_to_key, &key, &ih, (char *)(&sd));
     if (retval) {
-	iput (inode);
-	*err = retval;
 	reiserfs_check_path(&path_to_key) ;
-	return NULL;
+	err = retval;
+	goto out_bad_inode;
     }
 
 #ifdef DISPLACE_NEW_PACKING_LOCALITIES
@@ -1617,19 +1614,30 @@
 	retval = reiserfs_new_symlink (th, &ih, &path_to_key, symname, i_size);
     }
     if (retval) {
-      inode->i_nlink = 0;
-	iput (inode);
-	*err = retval;
+	err = retval;
 	reiserfs_check_path(&path_to_key) ;
-	return NULL;
+	journal_end(th, th->t_super, th->t_blocks_allocated) ;
+	goto out_inserted_sd;
     }
 
     insert_inode_hash (inode);
-    // we do not mark inode dirty: on disk content matches to the
-    // in-core one
+    reiserfs_update_sd(th, inode) ;
     reiserfs_check_path(&path_to_key) ;
 
-    return inode;
+    return 0;
+out_bad_inode:
+    /* Invalidate the object, nothing was inserted yet */
+    INODE_PKEY(inode)->k_objectid = 0;
+
+    /* dquot_drop must be done outside a transaction */
+    journal_end(th, th->t_super, th->t_blocks_allocated) ;
+    make_bad_inode(inode);
+
+out_inserted_sd:
+    inode->i_nlink = 0;
+    th->t_trans_id = 0 ; /* so the caller can't use this handle later */
+    iput(inode) ;
+    return err;
 }
 
 /*
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Mon Jan 20 13:29:01 2003
+++ b/fs/reiserfs/namei.c	Mon Jan 20 13:29:01 2003
@@ -488,27 +488,58 @@
     return 0;
 }
 
+/* quota utility function, call if you've had to abort after calling
+** new_inode_init, and have not called reiserfs_new_inode yet.
+** This should only be called on inodes that do not hav stat data
+** inserted into the tree yet.
+*/
+static int drop_new_inode(struct inode *inode) {
+    make_bad_inode(inode) ;
+    iput(inode) ;
+    return 0 ;
+}
+
+/* utility function that does setup for reiserfs_new_inode.  
+** DQUOT_ALLOC_INODE cannot be called inside a transaction, so we had
+** to pull some bits of reiserfs_new_inode out into this func.
+*/
+static int new_inode_init(struct inode *inode, struct inode *dir, int mode) {
+
+    /* the quota init calls have to know who to charge the quota to, so
+    ** we have to set uid and gid here
+    */
+    inode->i_uid = current->fsuid;
+    inode->i_mode = mode;
+
+    if (dir->i_mode & S_ISGID) {
+        inode->i_gid = dir->i_gid;
+        if (S_ISDIR(mode))
+            inode->i_mode |= S_ISGID;
+    } else
+        inode->i_gid = current->fsgid;
 
+    return 0 ;
+}
+  
 static int reiserfs_create (struct inode * dir, struct dentry *dentry, int mode)
 {
     int retval;
     struct inode * inode;
-    int windex ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 ;
     struct reiserfs_transaction_handle th ;
 
-
     if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
+    retval = new_inode_init(inode, dir, mode) ;
+    if (retval)
+	return retval ;
+
     journal_begin(&th, dir->i_sb, jbegin_count) ;
     th.t_caller = "create" ;
-    windex = push_journal_writer("reiserfs_create") ;
-    inode = reiserfs_new_inode (&th, dir, mode, 0, 0/*i_size*/, dentry, inode, &retval);
-    if (!inode) {
-	pop_journal_writer(windex) ;
-	journal_end(&th, dir->i_sb, jbegin_count) ;
-	return retval;
+    retval = reiserfs_new_inode (&th, dir, mode, 0, 0/*i_size*/, dentry, inode);
+    if (retval) {
+	goto out_failed ;
     }
 	
     inode->i_op = &reiserfs_file_inode_operations;
@@ -520,20 +551,19 @@
     if (retval) {
 	inode->i_nlink--;
 	reiserfs_update_sd (&th, inode);
-	pop_journal_writer(windex) ;
-	// FIXME: should we put iput here and have stat data deleted
-	// in the same transactioin
 	journal_end(&th, dir->i_sb, jbegin_count) ;
-	iput (inode);
-	return retval;
+	iput(inode) ;
+	goto out_failed ;
     }
     reiserfs_update_inode_transaction(inode) ;
     reiserfs_update_inode_transaction(dir) ;
 
     d_instantiate(dentry, inode);
-    pop_journal_writer(windex) ;
     journal_end(&th, dir->i_sb, jbegin_count) ;
     return 0;
+
+out_failed:
+    return retval ;
 }
 
 
@@ -541,21 +571,21 @@
 {
     int retval;
     struct inode * inode;
-    int windex ;
     struct reiserfs_transaction_handle th ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
 
     if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
+    retval = new_inode_init(inode, dir, mode) ;
+    if (retval)
+        return retval ;
+
     journal_begin(&th, dir->i_sb, jbegin_count) ;
-    windex = push_journal_writer("reiserfs_mknod") ;
 
-    inode = reiserfs_new_inode (&th, dir, mode, 0, 0/*i_size*/, dentry, inode, &retval);
-    if (!inode) {
-	pop_journal_writer(windex) ;
-	journal_end(&th, dir->i_sb, jbegin_count) ;
-	return retval;
+    retval = reiserfs_new_inode(&th, dir, mode, 0, 0/*i_size*/, dentry, inode);
+    if (retval) {
+	goto out_failed; 
     }
 
     init_special_inode(inode, mode, rdev) ;
@@ -571,16 +601,17 @@
     if (retval) {
 	inode->i_nlink--;
 	reiserfs_update_sd (&th, inode);
-	pop_journal_writer(windex) ;
 	journal_end(&th, dir->i_sb, jbegin_count) ;
-	iput (inode);
-	return retval;
+	iput(inode) ;
+        goto out_failed; 
     }
 
     d_instantiate(dentry, inode);
-    pop_journal_writer(windex) ;
     journal_end(&th, dir->i_sb, jbegin_count) ;
     return 0;
+
+out_failed:
+    return retval ;
 }
 
 
@@ -588,15 +619,18 @@
 {
     int retval;
     struct inode * inode;
-    int windex ;
     struct reiserfs_transaction_handle th ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
 
+    mode = S_IFDIR | mode;
     if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
+    retval = new_inode_init(inode, dir, mode) ;
+    if (retval)
+	return retval ;
+
     journal_begin(&th, dir->i_sb, jbegin_count) ;
-    windex = push_journal_writer("reiserfs_mkdir") ;
 
     /* inc the link count now, so another writer doesn't overflow it while
     ** we sleep later on.
@@ -607,15 +641,13 @@
     /* set flag that new packing locality created and new blocks for the content     * of that directory are not displaced yet */
     dir->u.reiserfs_i.new_packing_locality = 1;
 #endif
-    mode = S_IFDIR | mode;
-    inode = reiserfs_new_inode (&th, dir, mode, 0/*symlink*/,
-				old_format_only (dir->i_sb) ? EMPTY_DIR_SIZE_V1 : EMPTY_DIR_SIZE,
-				dentry, inode, &retval);
-    if (!inode) {
-	pop_journal_writer(windex) ;
+    retval = reiserfs_new_inode(&th, dir, mode, 0/*symlink*/,
+				old_format_only (dir->i_sb) ?
+				EMPTY_DIR_SIZE_V1 : EMPTY_DIR_SIZE,
+				dentry, inode) ;
+    if (retval) {
 	dir->i_nlink-- ;
-	journal_end(&th, dir->i_sb, jbegin_count) ;
-	return retval;
+	goto out_failed ;
     }
     reiserfs_update_inode_transaction(inode) ;
     reiserfs_update_inode_transaction(dir) ;
@@ -630,19 +662,20 @@
 	inode->i_nlink = 0;
 	DEC_DIR_INODE_NLINK(dir);
 	reiserfs_update_sd (&th, inode);
-	pop_journal_writer(windex) ;
 	journal_end(&th, dir->i_sb, jbegin_count) ;
-	iput (inode);
-	return retval;
+	iput(inode) ;
+	goto out_failed ;
     }
 
     // the above add_entry did not update dir's stat data
     reiserfs_update_sd (&th, dir);
 
     d_instantiate(dentry, inode);
-    pop_journal_writer(windex) ;
     journal_end(&th, dir->i_sb, jbegin_count) ;
     return 0;
+
+out_failed:
+    return retval ;
 }
 
 static inline int reiserfs_empty_dir(struct inode *inode) {
@@ -820,7 +853,7 @@
     struct inode * inode;
     char * name;
     int item_len;
-    int windex ;
+    int mode = S_IFLNK | S_IRWXUGO ;
     struct reiserfs_transaction_handle th ;
     int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
 
@@ -828,31 +861,34 @@
     if (!(inode = new_inode(parent_dir->i_sb))) {
   	return -ENOMEM ;
     }
+    retval = new_inode_init(inode, parent_dir, mode) ;
+    if (retval) {
+	return retval ;
+    }
 
     item_len = ROUND_UP (strlen (symname));
     if (item_len > MAX_DIRECT_ITEM_LEN (parent_dir->i_sb->s_blocksize)) {
-	iput(inode) ;
-	return -ENAMETOOLONG;
+	retval = -ENAMETOOLONG;
+	drop_new_inode(inode) ;
+	goto out_failed ;
     }
   
     name = reiserfs_kmalloc (item_len, GFP_NOFS, parent_dir->i_sb);
     if (!name) {
-	iput(inode) ;
-	return -ENOMEM;
+	retval = -ENOMEM;
+	drop_new_inode(inode) ;
+	goto out_failed ;
     }
     memcpy (name, symname, strlen (symname));
     padd_item (name, item_len, strlen (symname));
 
     journal_begin(&th, parent_dir->i_sb, jbegin_count) ;
-    windex = push_journal_writer("reiserfs_symlink") ;
 
-    inode = reiserfs_new_inode (&th, parent_dir, S_IFLNK | S_IRWXUGO, name, strlen (symname), dentry,
-				inode, &retval);
+    retval = reiserfs_new_inode(&th, parent_dir, mode, name,
+				strlen(symname), dentry, inode) ;
     reiserfs_kfree (name, item_len, parent_dir->i_sb);
-    if (inode == 0) { /* reiserfs_new_inode iputs for us */
-	pop_journal_writer(windex) ;
-	journal_end(&th, parent_dir->i_sb, jbegin_count) ;
-	return retval;
+    if (retval) {
+	goto out_failed ;
     }
 
     reiserfs_update_inode_transaction(inode) ;
@@ -870,16 +906,17 @@
     if (retval) {
 	inode->i_nlink--;
 	reiserfs_update_sd (&th, inode);
-	pop_journal_writer(windex) ;
 	journal_end(&th, parent_dir->i_sb, jbegin_count) ;
-	iput (inode);
-	return retval;
+	iput(inode) ;
+	goto out_failed ;
     }
 
     d_instantiate(dentry, inode);
-    pop_journal_writer(windex) ;
     journal_end(&th, parent_dir->i_sb, jbegin_count) ;
     return 0;
+
+out_failed:
+    return retval ;
 }
 
 
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Mon Jan 20 13:29:01 2003
+++ b/include/linux/reiserfs_fs.h	Mon Jan 20 13:29:01 2003
@@ -1748,11 +1748,12 @@
 struct inode * reiserfs_iget (struct super_block * s, 
 			      const struct cpu_key * key);
 
-
-struct inode * reiserfs_new_inode (struct reiserfs_transaction_handle *th, 
-				   struct inode * dir, int mode, 
-				   const char * symname, int item_len,
-				   struct dentry *dentry, struct inode *inode, int * err);
+int reiserfs_new_inode (struct reiserfs_transaction_handle *th,
+                               struct inode * dir, int mode,
+                               const char * symname,
+                               int i_size,
+                               struct dentry *dentry,
+                               struct inode *inode);
 int reiserfs_sync_inode (struct reiserfs_transaction_handle *th, struct inode * inode);
 void reiserfs_update_sd (struct reiserfs_transaction_handle *th, struct inode * inode);
 

Bye,
    Oleg



--------------000104070104060700040005--

