Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289794AbSBKOZF>; Mon, 11 Feb 2002 09:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289776AbSBKOY5>; Mon, 11 Feb 2002 09:24:57 -0500
Received: from angband.namesys.com ([212.16.7.85]:16000 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289757AbSBKOYl>; Mon, 11 Feb 2002 09:24:41 -0500
Date: Mon, 11 Feb 2002 17:24:37 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 2.5 [1 of 8] 01-ioerrors-checks-2.diff
Message-ID: <20020211172437.A1768@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    Make sure all reiserfs_find_entry users correctly understand IO_ERROR retval.

--- linux/fs/reiserfs/namei.c.orig	Mon Feb 11 09:28:48 2002
+++ linux/fs/reiserfs/namei.c	Mon Feb 11 09:51:24 2002
@@ -340,7 +340,7 @@
 static struct dentry * reiserfs_lookup (struct inode * dir, struct dentry * dentry)
 {
     int retval;
-    struct inode * inode = 0;
+    struct inode * inode = NULL;
     struct reiserfs_dir_entry de;
     INITIALIZE_PATH (path_to_entry);
 
@@ -358,6 +358,9 @@
 	    return ERR_PTR(-EACCES);
         }
     }
+    if ( retval == IO_ERROR ) {
+	return ERR_PTR(-EIO);
+    }
 
     d_add(dentry, inode);
     return NULL;
@@ -443,6 +446,10 @@
 	    reiserfs_kfree (buffer, buflen, dir->i_sb);
 	pathrelse (&path);
 
+	if ( retval == IO_ERROR ) {
+	    return -EIO;
+	}
+
         if (retval != NAME_FOUND) {
 	    reiserfs_warning ("zam-7002:" __FUNCTION__ ": \"reiserfs_find_entry\" has returned"
                               " unexpected value (%d)\n", retval);
@@ -715,10 +722,14 @@
     windex = push_journal_writer("reiserfs_rmdir") ;
 
     de.de_gen_number_bit_string = 0;
-    if (reiserfs_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &path, &de) == NAME_NOT_FOUND) {
+    if ( (retval = reiserfs_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &path, &de)) == NAME_NOT_FOUND) {
 	retval = -ENOENT;
 	goto end_rmdir;
+    } else if ( retval == IO_ERROR) {
+	retval = -EIO;
+	goto end_rmdir;
     }
+
     inode = dentry->d_inode;
 
     reiserfs_update_inode_transaction(inode) ;
@@ -800,9 +811,12 @@
     windex = push_journal_writer("reiserfs_unlink") ;
 	
     de.de_gen_number_bit_string = 0;
-    if (reiserfs_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &path, &de) == NAME_NOT_FOUND) {
+    if ( (retval = reiserfs_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &path, &de)) == NAME_NOT_FOUND) {
 	retval = -ENOENT;
 	goto end_unlink;
+    } else if (retval == IO_ERROR) {
+	retval = -EIO;
+	goto end_unlink;
     }
 
     reiserfs_update_inode_transaction(inode) ;
@@ -1065,8 +1079,10 @@
     retval = reiserfs_find_entry (old_dir, old_dentry->d_name.name, old_dentry->d_name.len,
 				  &old_entry_path, &old_de);
     pathrelse (&old_entry_path);
+    if (retval == IO_ERROR)
+	return -EIO;
+
     if (retval != NAME_FOUND || old_de.de_objectid != old_inode->i_ino) {
-	// FIXME: IO error is possible here
 	return -ENOENT;
     }
 
@@ -1138,6 +1154,8 @@
 	new_de.de_gen_number_bit_string = 0;
 	retval = reiserfs_find_entry (new_dir, new_dentry->d_name.name, new_dentry->d_name.len, 
 				      &new_entry_path, &new_de);
+	// reiserfs_add_entry should not return IO_ERROR, because it is called with essentially same parameters from
+        // reiserfs_add_entry above, and we'll catch any i/o errors before we get here.
 	if (retval != NAME_FOUND_INVISIBLE && retval != NAME_FOUND)
 	    BUG ();
 
