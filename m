Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281709AbRKQHOS>; Sat, 17 Nov 2001 02:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281711AbRKQHOJ>; Sat, 17 Nov 2001 02:14:09 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:20484 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281709AbRKQHN5>; Sat, 17 Nov 2001 02:13:57 -0500
Message-ID: <3BF60E0A.CA8AEAB4@zip.com.au>
Date: Fri, 16 Nov 2001 23:13:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: "Stephen C. Tweedie" <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: synchronous mounts
In-Reply-To: message from Stephen C. Tweedie on Thursday November 15,
		<3BF376EC.EA9B03C8@zip.com.au>
		<20011115214525.C14221@redhat.com> <15348.33549.67021.527467@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> Andrew's patch fixes O_SYNC in data=journal and data=ordered modes,
> but does not fix fsync in data=writeback mode.
> 

Neil, thanks for spotting this.

patch-2.4.10-pre11 introduced a new per-inode dirty buffer queue,
inode.i_dirty_data_buffers.

generic_commit_write() was changed so that it placed buffers on that
queue, rather than i_dirty_buffers.  A new function fsync_inode_data_buffers()
was added for writing the new buffer list out.

That patch changed ext2 and reiserfs to use the new function. The patch was
not copied to any mailing list. There was no announcement and no discussion.
There are no comments in the code indicating the distinction between these
lists and why we have two such.

This change broke fsync() for three in-kernel filesystems as well
as the then-out-of-kernel ext3 and presumably any other buffer-based
Linux filesystems.

Ah.  google finds this, from April:

	http://www.uwsg.iu.edu/hypermail/linux/kernel/0104.1/0810.html

which attempts to explain why the separate list was added.  It
appears to be bogus.  There is no reason why, if correctly done,
syncing a list of ext2 data buffers and indirects should be
significantly slower than syncing just the data. 


Here's a fix.  A better fix would be to back out the unnecesary
list and its support functions.


--- linux-2.4.15-pre5/fs/minix/file.c	Mon Sep 10 07:31:30 2001
+++ linux-akpm/fs/minix/file.c	Fri Nov 16 22:07:53 2001
@@ -30,8 +30,10 @@ struct inode_operations minix_file_inode
 int minix_sync_file(struct file * file, struct dentry *dentry, int datasync)
 {
 	struct inode *inode = dentry->d_inode;
-	int err  = fsync_inode_buffers(inode);
+	int err;
 
+	err = fsync_inode_buffers(inode);
+	err |= fsync_inode_data_buffers(inode);
 	if (!(inode->i_state & I_DIRTY))
 		return err;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
--- linux-2.4.15-pre5/fs/sysv/file.c	Thu Nov 15 23:44:29 2001
+++ linux-akpm/fs/sysv/file.c	Fri Nov 16 22:09:20 2001
@@ -35,8 +35,10 @@ struct inode_operations sysv_file_inode_
 int sysv_sync_file(struct file * file, struct dentry *dentry, int datasync)
 {
 	struct inode *inode = dentry->d_inode;
-	int err  = fsync_inode_buffers(inode);
+	int err;
 
+	err = fsync_inode_buffers(inode);
+	err |= fsync_inode_data_buffers(inode);
 	if (!(inode->i_state & I_DIRTY))
 		return err;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
--- linux-2.4.15-pre5/fs/udf/fsync.c	Mon Jun 11 19:15:27 2001
+++ linux-akpm/fs/udf/fsync.c	Fri Nov 16 22:11:03 2001
@@ -45,6 +45,7 @@ int udf_fsync_inode(struct inode *inode,
 	int err;
 
 	err = fsync_inode_buffers(inode);
+	err |= fsync_inode_data_buffers(inode);
 	if (!(inode->i_state & I_DIRTY))
 		return err;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
--- linux-2.4.15-pre5/fs/ext3/fsync.c	Thu Nov 15 23:44:29 2001
+++ linux-akpm/fs/ext3/fsync.c	Fri Nov 16 22:09:34 2001
@@ -62,6 +62,7 @@ int ext3_sync_file(struct file * file, s
 	 * we'll end up waiting on them in commit.
 	 */
 	ret = fsync_inode_buffers(inode);
+	ret |= fsync_inode_data_buffers(inode);
 
 	ext3_force_commit(inode->i_sb);
