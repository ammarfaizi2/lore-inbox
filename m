Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbSIZNxn>; Thu, 26 Sep 2002 09:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSIZNwG>; Thu, 26 Sep 2002 09:52:06 -0400
Received: from pc-62-31-66-34-ed.blueyonder.co.uk ([62.31.66.34]:22403 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261294AbSIZNue>; Thu, 26 Sep 2002 09:50:34 -0400
Date: Thu, 26 Sep 2002 14:55:32 +0100
Message-Id: <200209261355.g8QDtWF16994@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 2/7] 2.4.20-pre4/ext3: Fix the order of inodes being marked dirty in a couple of corner cases.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only impact of this bug is that the on-disk copies of i_version
might got out of sync for a directory, or that an error inserting an
inode into a directory might leave its i_nlinks or i_ctime incorrect
on disk for a short interval.  Neither problem will cause trouble for
ext3 during normal operation, but the nlink problem might cause e2fsck
to emit unnecessary warnings if we crash while the incorrect version
of the inode is in the journal.

--- linux-2.4-ext3merge/fs/ext3/namei.c.=K0001=.orig	Thu Sep 26 12:19:14 2002
+++ linux-2.4-ext3merge/fs/ext3/namei.c	Thu Sep 26 12:25:37 2002
@@ -354,8 +354,8 @@
 			 */
 			dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 			dir->u.ext3_i.i_flags &= ~EXT3_INDEX_FL;
-			ext3_mark_inode_dirty(handle, dir);
 			dir->i_version = ++event;
+			ext3_mark_inode_dirty(handle, dir);
 			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
 			ext3_journal_dirty_metadata(handle, bh);
 			brelse(bh);
@@ -464,8 +464,8 @@
 		inode->i_op = &ext3_file_inode_operations;
 		inode->i_fop = &ext3_file_operations;
 		inode->i_mapping->a_ops = &ext3_aops;
-		ext3_mark_inode_dirty(handle, inode);
 		err = ext3_add_nondir(handle, dentry, inode);
+		ext3_mark_inode_dirty(handle, inode);
 	}
 	ext3_journal_stop(handle, dir);
 	return err;
@@ -489,8 +489,8 @@
 	err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
 		init_special_inode(inode, mode, rdev);
-		ext3_mark_inode_dirty(handle, inode);
 		err = ext3_add_nondir(handle, dentry, inode);
+		ext3_mark_inode_dirty(handle, inode);
 	}
 	ext3_journal_stop(handle, dir);
 	return err;
@@ -829,9 +829,9 @@
 	 * recovery. */
 	inode->i_size = 0;
 	ext3_orphan_add(handle, inode);
-	ext3_mark_inode_dirty(handle, inode);
 	dir->i_nlink--;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	ext3_mark_inode_dirty(handle, inode);
 	dir->u.ext3_i.i_flags &= ~EXT3_INDEX_FL;
 	ext3_mark_inode_dirty(handle, dir);
 
@@ -883,8 +883,8 @@
 	inode->i_nlink--;
 	if (!inode->i_nlink)
 		ext3_orphan_add(handle, inode);
-	ext3_mark_inode_dirty(handle, inode);
 	inode->i_ctime = dir->i_ctime;
+	ext3_mark_inode_dirty(handle, inode);
 	retval = 0;
 
 end_unlink:
@@ -933,8 +933,8 @@
 		inode->i_size = l-1;
 	}
 	inode->u.ext3_i.i_disksize = inode->i_size;
-	ext3_mark_inode_dirty(handle, inode);
 	err = ext3_add_nondir(handle, dentry, inode);
+	ext3_mark_inode_dirty(handle, inode);
 out_stop:
 	ext3_journal_stop(handle, dir);
 	return err;
@@ -970,8 +970,8 @@
 	ext3_inc_count(handle, inode);
 	atomic_inc(&inode->i_count);
 
-	ext3_mark_inode_dirty(handle, inode);
 	err = ext3_add_nondir(handle, dentry, inode);
+	ext3_mark_inode_dirty(handle, inode);
 	ext3_journal_stop(handle, dir);
 	return err;
 }
