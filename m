Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291123AbSAaQFE>; Thu, 31 Jan 2002 11:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291126AbSAaQEo>; Thu, 31 Jan 2002 11:04:44 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:16402 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S291123AbSAaQEh>; Thu, 31 Jan 2002 11:04:37 -0500
Date: Thu, 31 Jan 2002 19:04:28 +0300
Message-Id: <200201311604.g0VG4Se13338@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, green@namesys.com, reiserfs-list@namesys.com
Subject: [PATCH] 2.4 ReiserFS rename bugfix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply.  The previous version of this bugfix was discovered by a
user to have been a reversed patch, so please use this one.

Hans


--- linux/fs/reiserfs/namei.c.orig	Thu Jan 31 14:47:21 2002
+++ linux/fs/reiserfs/namei.c	Thu Jan 31 14:47:38 2002
@@ -1043,7 +1043,7 @@
     INITIALIZE_PATH (old_entry_path);
     INITIALIZE_PATH (new_entry_path);
     INITIALIZE_PATH (dot_dot_entry_path);
-    struct item_head new_entry_ih, old_entry_ih ;
+    struct item_head new_entry_ih, old_entry_ih, dot_dot_ih ;
     struct reiserfs_dir_entry old_de, new_de, dot_dot_de;
     struct inode * old_inode, * new_inode;
     int windex ;
@@ -1132,6 +1132,8 @@
 
 	copy_item_head(&old_entry_ih, get_ih(&old_entry_path)) ;
 
+	reiserfs_prepare_for_journal(old_inode->i_sb, old_de.de_bh, 1) ;
+
 	// look for new name by reiserfs_find_entry
 	new_de.de_gen_number_bit_string = 0;
 	retval = reiserfs_find_entry (new_dir, new_dentry->d_name.name, new_dentry->d_name.len, 
@@ -1146,6 +1148,7 @@
 	if (S_ISDIR(old_inode->i_mode)) {
 	    if (search_by_entry_key (new_dir->i_sb, &dot_dot_de.de_entry_key, &dot_dot_entry_path, &dot_dot_de) != NAME_FOUND)
 		BUG ();
+	    copy_item_head(&dot_dot_ih, get_ih(&dot_dot_entry_path)) ;
 	    // node containing ".." gets into transaction
 	    reiserfs_prepare_for_journal(old_inode->i_sb, dot_dot_de.de_bh, 1) ;
 	}
@@ -1162,23 +1165,33 @@
 	** of the above checks could have scheduled.  We have to be
 	** sure our items haven't been shifted by another process.
 	*/
-	if (!entry_points_to_object(new_dentry->d_name.name, 
+	if (item_moved(&new_entry_ih, &new_entry_path) ||
+	    !entry_points_to_object(new_dentry->d_name.name, 
 	                            new_dentry->d_name.len,
 				    &new_de, new_inode) ||
-	    item_moved(&new_entry_ih, &new_entry_path) ||
 	    item_moved(&old_entry_ih, &old_entry_path) || 
 	    !entry_points_to_object (old_dentry->d_name.name, 
 	                             old_dentry->d_name.len,
 				     &old_de, old_inode)) {
 	    reiserfs_restore_prepared_buffer (old_inode->i_sb, new_de.de_bh);
+	    reiserfs_restore_prepared_buffer (old_inode->i_sb, old_de.de_bh);
 	    if (S_ISDIR(old_inode->i_mode))
 		reiserfs_restore_prepared_buffer (old_inode->i_sb, dot_dot_de.de_bh);
 	    continue;
 	}
+	if (S_ISDIR(old_inode->i_mode)) {
+	    if ( item_moved(&dot_dot_ih, &dot_dot_entry_path) ||
+		 !entry_points_to_object ( "..", 2, &dot_dot_de, old_dir) ) {
+		reiserfs_restore_prepared_buffer (old_inode->i_sb, old_de.de_bh);
+		reiserfs_restore_prepared_buffer (old_inode->i_sb, new_de.de_bh);
+		reiserfs_restore_prepared_buffer (old_inode->i_sb, dot_dot_de.de_bh);
+		continue;
+	    }
+	}
+
 
 	RFALSE( S_ISDIR(old_inode->i_mode) && 
-		(!entry_points_to_object ("..", 2, &dot_dot_de, old_dir) || 
-		 !reiserfs_buffer_prepared(dot_dot_de.de_bh)), "" );
+		!reiserfs_buffer_prepared(dot_dot_de.de_bh), "" );
 
 	break;
     }
@@ -1191,6 +1204,7 @@
     journal_mark_dirty (&th, old_dir->i_sb, new_de.de_bh);
 
     mark_de_hidden (old_de.de_deh + old_de.de_entry_num);
+    journal_mark_dirty (&th, old_dir->i_sb, old_de.de_bh);
     old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
     new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
 


