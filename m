Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274723AbTGaOmM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274788AbTGaOmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:42:12 -0400
Received: from angband.namesys.com ([212.16.7.85]:48830 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S274723AbTGaOmF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:42:05 -0400
Date: Thu, 31 Jul 2003 18:42:04 +0400
From: Oleg Drokin <green@namesys.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.5] reiserfs: fix races between link and unlink on same file
Message-ID: <20030731144204.GP14081@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    This patch (originally by Chris Mason) fixes link/unlink races in reiserfs.
    The patch is against 2.6.0-test2, please apply.


===== fs/reiserfs/namei.c 1.47 vs edited =====
--- 1.47/fs/reiserfs/namei.c	Mon Jun 30 10:49:04 2003
+++ edited/fs/reiserfs/namei.c	Thu Jul 31 18:01:55 2003
@@ -822,6 +822,7 @@
     int windex ;
     struct reiserfs_transaction_handle th ;
     int jbegin_count;
+    unsigned long savelink;
 
     inode = dentry->d_inode;
 
@@ -858,11 +859,20 @@
 	inode->i_nlink = 1;
     }
 
+    inode->i_nlink--;
+
+    /* 
+     * we schedule before doing the add_save_link call, save the link
+     * count so we don't race
+     */
+    savelink = inode->i_nlink;
+
+
     retval = reiserfs_cut_from_item (&th, &path, &(de.de_entry_key), dir, NULL, 0);
-    if (retval < 0)
+    if (retval < 0) {
+	inode->i_nlink++;
 	goto end_unlink;
-
-    inode->i_nlink--;
+    }
     inode->i_ctime = CURRENT_TIME;
     reiserfs_update_sd (&th, inode);
 
@@ -871,7 +881,7 @@
     dir->i_ctime = dir->i_mtime = CURRENT_TIME;
     reiserfs_update_sd (&th, dir);
 
-    if (!inode->i_nlink)
+    if (!savelink)
        /* prevent file from getting lost */
        add_save_link (&th, inode, 0/* not truncate */);
 
@@ -976,6 +986,12 @@
 	reiserfs_write_unlock(dir->i_sb);
 	return -EMLINK;
     }
+    if (inode->i_nlink == 0) {
+        return -ENOENT;
+    }
+
+    /* inc before scheduling so reiserfs_unlink knows we are here */
+    inode->i_nlink++;
 
     journal_begin(&th, dir->i_sb, jbegin_count) ;
     windex = push_journal_writer("reiserfs_link") ;
@@ -988,13 +1004,13 @@
     reiserfs_update_inode_transaction(dir) ;
 
     if (retval) {
+	inode->i_nlink--;
 	pop_journal_writer(windex) ;
 	journal_end(&th, dir->i_sb, jbegin_count) ;
 	reiserfs_write_unlock(dir->i_sb);
 	return retval;
     }
 
-    inode->i_nlink++;
     inode->i_ctime = CURRENT_TIME;
     reiserfs_update_sd (&th, inode);
 
@@ -1068,6 +1084,7 @@
     struct reiserfs_transaction_handle th ;
     int jbegin_count ; 
     umode_t old_inode_mode;
+    unsigned long savelink = 1;
 
     /* two balancings: old name removal, new name insertion or "save" link,
        stat data updates: old directory and new directory and maybe block
@@ -1246,6 +1263,7 @@
 	    new_dentry_inode->i_nlink--;
 	}
 	new_dentry_inode->i_ctime = new_dir->i_ctime;
+	savelink = new_dentry_inode->i_nlink;
     }
 
     if (S_ISDIR(old_inode_mode)) {
@@ -1279,7 +1297,7 @@
     reiserfs_update_sd (&th, new_dir);
 
     if (new_dentry_inode) {
-	if (new_dentry_inode->i_nlink == 0)
+	if (savelink == 0)
 	    add_save_link (&th, new_dentry_inode, 0/* not truncate */);
 	reiserfs_update_sd (&th, new_dentry_inode);
     }
