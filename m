Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSLOUSX>; Sun, 15 Dec 2002 15:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSLOUSX>; Sun, 15 Dec 2002 15:18:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:18888 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262430AbSLOUSQ>;
	Sun, 15 Dec 2002 15:18:16 -0500
Message-ID: <3DFCE55B.E9C634E2@digeo.com>
Date: Sun, 15 Dec 2002 12:26:03 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: [patch] ext3 use-after-free bugfix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2002 20:26:04.0252 (UTC) FILETIME=[30DB89C0:01C2A478]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A change was made to ext3 in 2.4.20-pre9 which will cause the
filesystem to run ext3_mark_inode_dirty() against a freed inode.

This will occur when an application attempts to add a new file/directory
to the filesystem and encounters space or inode exhaustion.

The results of this are unpredictable.  Usually, nothing happens.  But
it can cause random memory corruption on SMP, and the kernel will crash
if compiled for "debug memory allocations".

The problem is that ext3_add_nondir() will do an iput() of the inode
on error (which frees the inode) but we then run ext3_mark_inode_dirty()
against it.

Fix it so that we only run ext3_mark_inode_dirty() if the inode was
successfully instantiated.



 fs/ext3/namei.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

--- 24/fs/ext3/namei.c~ext3-use-after-free	Sun Dec 15 11:27:50 2002
+++ 24-akpm/fs/ext3/namei.c	Sun Dec 15 11:27:50 2002
@@ -429,8 +429,11 @@ static int ext3_add_nondir(handle_t *han
 {
 	int err = ext3_add_entry(handle, dentry, inode);
 	if (!err) {
-		d_instantiate(dentry, inode);
-		return 0;
+		err = ext3_mark_inode_dirty(handle, inode);
+		if (err == 0) {
+			d_instantiate(dentry, inode);
+			return 0;
+		}
 	}
 	ext3_dec_count(handle, inode);
 	iput(inode);
@@ -465,7 +468,6 @@ static int ext3_create (struct inode * d
 		inode->i_fop = &ext3_file_operations;
 		inode->i_mapping->a_ops = &ext3_aops;
 		err = ext3_add_nondir(handle, dentry, inode);
-		ext3_mark_inode_dirty(handle, inode);
 	}
 	ext3_journal_stop(handle, dir);
 	return err;
@@ -490,7 +492,6 @@ static int ext3_mknod (struct inode * di
 	if (!IS_ERR(inode)) {
 		init_special_inode(inode, mode, rdev);
 		err = ext3_add_nondir(handle, dentry, inode);
-		ext3_mark_inode_dirty(handle, inode);
 	}
 	ext3_journal_stop(handle, dir);
 	return err;
@@ -934,7 +935,6 @@ static int ext3_symlink (struct inode * 
 	}
 	inode->u.ext3_i.i_disksize = inode->i_size;
 	err = ext3_add_nondir(handle, dentry, inode);
-	ext3_mark_inode_dirty(handle, inode);
 out_stop:
 	ext3_journal_stop(handle, dir);
 	return err;
@@ -971,7 +971,6 @@ static int ext3_link (struct dentry * ol
 	atomic_inc(&inode->i_count);
 
 	err = ext3_add_nondir(handle, dentry, inode);
-	ext3_mark_inode_dirty(handle, inode);
 	ext3_journal_stop(handle, dir);
 	return err;
 }

_
