Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290716AbSARPO3>; Fri, 18 Jan 2002 10:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290719AbSARPOU>; Fri, 18 Jan 2002 10:14:20 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:17421 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S290716AbSARPOH>; Fri, 18 Jan 2002 10:14:07 -0500
Message-ID: <3C483ADB.6080308@namesys.com>
Date: Fri, 18 Jan 2002 18:10:19 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: [PATCH] rename bug patch for 2.4 --- my mangling undone
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just discovered how not to cut and paste a patch, sorry.  This one is correct, the other sent this morning will not work due to extra carriage returns getting into it.

Credit Oleg, his explanation is below, it is tested by several Namesys internal testers, and reviewed.

Hans
*****************************************************************************************************************

Hello!

     A-rename_stale_item_bug-1.diff
     This patch fixes 2 bugs in reiserfs_rename(). First one being attempt to access item before verifying it was
     not moved since last access. Second is a window, where old filename may be written to disk with 'visible'
     flag unset without these changes be journaled.

Bye,
     Oleg

--- linux/fs/reiserfs/namei.c.orig	Thu Jan 17 14:05:11 2002
+++ linux/fs/reiserfs/namei.c	Thu Jan 17 17:09:23 2002
@@ -1057,7 +1057,7 @@
      INITIALIZE_PATH (old_entry_path);
      INITIALIZE_PATH (new_entry_path);
      INITIALIZE_PATH (dot_dot_entry_path);
-    struct item_head new_entry_ih, old_entry_ih ;
+    struct item_head new_entry_ih, old_entry_ih, dot_dot_ih ;
      struct reiserfs_dir_entry old_de, new_de, dot_dot_de;
      struct inode * old_inode, * new_inode;
      int windex ;
@@ -1151,6 +1151,8 @@

  	copy_item_head(&old_entry_ih, get_ih(&old_entry_path)) ;

+ 
reiserfs_prepare_for_journal(old_inode->i_sb, old_de.de_bh, 1) ;
+
  	// look for new name by reiserfs_find_entry
  	new_de.de_gen_number_bit_string = 0;
  	retval = reiserfs_find_entry (new_dir, new_dentry->d_name.name, new_dentry->d_name.len,
@@ -1167,6 +1169,7 @@
  	if (S_ISDIR(old_inode->i_mode)) {
  	    if (search_by_entry_key (new_dir->i_sb, &dot_dot_de.de_entry_key, &dot_dot_entry_path, &dot_dot_de) != NAME_FOUND)
  		BUG ();
+ 
     copy_item_head(&dot_dot_ih, get_ih(&dot_dot_entry_path)) ;
  	    // node containing ".." gets into transaction
  	    reiserfs_prepare_for_journal(old_inode->i_sb, dot_dot_de.de_bh, 1) ;
  	}
@@ -1183,23 +1186,33 @@
  	** of the above checks could have scheduled.  We have to be
  	** sure our items haven't been shifted by another process.
  	*/
- 
if (!entry_points_to_object(new_dentry->d_name.name,
+ 
if (item_moved(&new_entry_ih, &new_entry_path) ||
+ 
     !entry_points_to_object(new_dentry->d_name.name,
  	                            new_dentry->d_name.len,
  	 
		    &new_de, new_inode) ||
- 
     item_moved(&new_entry_ih, &new_entry_path) ||
  	    item_moved(&old_entry_ih, &old_entry_path) ||
  	    !entry_points_to_object (old_dentry->d_name.name,
  	                             old_dentry->d_name.len,
  	 
		     &old_de, old_inode)) {
  	    reiserfs_restore_prepared_buffer (old_inode->i_sb, new_de.de_bh);
+ 
     reiserfs_restore_prepared_buffer (old_inode->i_sb, old_de.de_bh);
  	    if (S_ISDIR(old_inode->i_mode))
  		reiserfs_restore_prepared_buffer (old_inode->i_sb, dot_dot_de.de_bh);
  	    continue;
  	}
+ 
if (S_ISDIR(old_inode->i_mode)) {
+ 
     if ( item_moved(&dot_dot_ih, &dot_dot_entry_path) ||
+ 
	 !entry_points_to_object ( "..", 2, &dot_dot_de, old_dir) ) {
+ 
	reiserfs_restore_prepared_buffer (old_inode->i_sb, old_de.de_bh);
+ 
	reiserfs_restore_prepared_buffer (old_inode->i_sb, new_de.de_bh);
+ 
	reiserfs_restore_prepared_buffer (old_inode->i_sb, dot_dot_de.de_bh);
+ 
	continue;
+ 
     }
+ 
}
+

  	RFALSE( S_ISDIR(old_inode->i_mode) &&
- 
	(!entry_points_to_object ("..", 2, &dot_dot_de, old_dir) ||
- 
	 !reiserfs_buffer_prepared(dot_dot_de.de_bh)), "" );
+ 
	!reiserfs_buffer_prepared(dot_dot_de.de_bh), "" );

  	break;
      }
@@ -1212,6 +1225,7 @@
      journal_mark_dirty (&th, old_dir->i_sb, new_de.de_bh);

      mark_de_hidden (old_de.de_deh + old_de.de_entry_num);
+    journal_mark_dirty (&th, old_dir->i_sb, old_de.de_bh);
      old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
      new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;




