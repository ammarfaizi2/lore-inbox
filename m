Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280774AbRKOIFP>; Thu, 15 Nov 2001 03:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280773AbRKOIFH>; Thu, 15 Nov 2001 03:05:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62216 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280774AbRKOIEu>; Thu, 15 Nov 2001 03:04:50 -0500
Message-ID: <3BF376EC.EA9B03C8@zip.com.au>
Date: Thu, 15 Nov 2001 00:03:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Neil Brown <neilb@cse.unsw.edu.au>
Subject: synchronous mounts
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux is not syncing write() data for files on synchronously mounted
filesystems, and it isn't syncing write() data for ext2/3 files which
are operating under `chattr +S'.

Is this deliberate, or a bug?

This patch makes write()s data-synchronous.  There's a fix-for-the-fix
here for ext3.  Other filesystems which are second-guessing the generic
layer's behaviour may also end up doing a double sync with this patch.

Really, generic_osync_inode() needs to be front-ended by
an inode_operations method.


--- linux-2.4.15-pre4/mm/filemap.c	Mon Nov 12 11:16:12 2001
+++ linux-akpm/mm/filemap.c	Wed Nov 14 22:50:25 2001
@@ -2916,8 +2916,10 @@ unlock:
 
 	/* For now, when the user asks for O_SYNC, we'll actually
 	 * provide O_DSYNC. */
-	if ((status >= 0) && (file->f_flags & O_SYNC))
-		status = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
+	if (status >= 0) {
+		if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
+			status = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
+	}
 	
 	err = written ? written : status;
 out:
--- linux-2.4.15-pre4/fs/ext3/file.c	Mon Nov 12 11:16:12 2001
+++ linux-akpm/fs/ext3/file.c	Wed Nov 14 23:52:08 2001
@@ -61,22 +61,19 @@ static int ext3_open_file (struct inode 
 static ssize_t
 ext3_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
-	int ret;
 	struct inode *inode = file->f_dentry->d_inode;
 
-	ret = generic_file_write(file, buf, count, ppos);
-	if ((ret >= 0) && IS_SYNC(inode)) {
-		if (file->f_flags & O_SYNC) {
-			/*
-			 * generic_osync_inode() has already done the sync
-			 */
-		} else {
-			int ret2 = ext3_force_commit(inode->i_sb);
-			if (ret2)
-				ret = ret2;
-		}
-	}
-	return ret;
+	/*
+	 * Nasty: if the file is subject to synchronous writes then we need
+	 * to force generic_osync_inode() to call ext3_write_inode().
+	 * We do that by marking the inode dirty.  This adds much more
+	 * computational expense than we need, but we're going to sync
+	 * anyway.
+	 */
+	if (IS_SYNC(inode) || (file->f_flags & O_SYNC))
+		mark_inode_dirty(inode);
+
+	return generic_file_write(file, buf, count, ppos);
 }
 
 struct file_operations ext3_file_operations = {
