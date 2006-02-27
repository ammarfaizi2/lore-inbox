Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWB0Qba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWB0Qba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 11:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWB0Qba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 11:31:30 -0500
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:30220 "EHLO
	mail.sw.starentnetworks.com") by vger.kernel.org with ESMTP
	id S1751413AbWB0Qb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 11:31:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17411.10591.927433.619327@zeus.sw.starentnetworks.com>
Date: Mon, 27 Feb 2006 11:31:27 -0500
From: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cramfs mounts provide corrupted content since 2.6.15
In-Reply-To: <20060225220130.GA2748@suse.de>
References: <20060225110844.GA18221@suse.de>
	<20060225125551.GA21203@suse.de>
	<17408.34808.422077.518881@zeus.sw.starentnetworks.com>
	<20060225220130.GA2748@suse.de>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering writes:
>  On Sat, Feb 25, Dave Johnson wrote:
> 
> > Looking at your output it's definitely getting inodes confused with
> > each other so the checks in cramfs_iget5_test() aren't working.
> > 
> > Can you stat the files in question to make sure they are actually
> > inode #1 on a working as well as non-working kernel?  If your mkcramfs
> > isn't using #1 for empty files/links/dirs that'd be the problem.
> 
> Another try, and different results again:

Is it the same files every time you mount/umount the image?


I think I've spotted an issue.

Both ifind() and find_inode() will call the test function on inodes
that still have I_LOCK|I_NEW set.  This means everything that the
test function needs _must_ be set in the set function (which is called
while the inode_lock is still held).

This could cause issues for inodes of 1 (only i_ino is getting set
right now).

However since you're seeing issues for inodes != 1, it could indicate
code elsewhere that isn't checking for I_LOCK|I_NEW.

Anyway, can you give the following patch a try?

-- 
Dave Johnson
Starent Networks

======================================


Fill out inode contents in cramfs_iget5_set() instead of get_cramfs_inode() to
prevent issues if cramfs_iget5_test() is called with I_LOCK|I_NEW still set.

Signed-off-by: Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>

diff -Naur linux-2.6.15.4.orig/fs/cramfs/inode.c linux-2.6.15.4/fs/cramfs/inode.c
--- linux-2.6.15.4.orig/fs/cramfs/inode.c	2006-02-10 07:22:48.000000000 +0000
+++ linux-2.6.15.4/fs/cramfs/inode.c	2006-02-27 15:16:52.000000000 +0000
@@ -66,8 +66,36 @@
 
 static int cramfs_iget5_set(struct inode *inode, void *opaque)
 {
+	static struct timespec zerotime;
 	struct cramfs_inode *cramfs_inode = opaque;
+	inode->i_mode = cramfs_inode->mode;
+	inode->i_uid = cramfs_inode->uid;
+	inode->i_size = cramfs_inode->size;
+	inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_gid = cramfs_inode->gid;
+	/* Struct copy intentional */
+	inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
 	inode->i_ino = CRAMINO(cramfs_inode);
+	/* inode->i_nlink is left 1 - arguably wrong for directories,
+	   but it's the best we can do without reading the directory
+           contents.  1 yields the right result in GNU find, even
+	   without -noleaf option. */
+	if (S_ISREG(inode->i_mode)) {
+		inode->i_fop = &generic_ro_fops;
+		inode->i_data.a_ops = &cramfs_aops;
+	} else if (S_ISDIR(inode->i_mode)) {
+		inode->i_op = &cramfs_dir_inode_operations;
+		inode->i_fop = &cramfs_directory_operations;
+	} else if (S_ISLNK(inode->i_mode)) {
+		inode->i_op = &page_symlink_inode_operations;
+		inode->i_data.a_ops = &cramfs_aops;
+	} else {
+		inode->i_size = 0;
+		inode->i_blocks = 0;
+		init_special_inode(inode, inode->i_mode,
+			old_decode_dev(cramfs_inode->size));
+	}
 	return 0;
 }
 
@@ -77,37 +105,7 @@
 	struct inode *inode = iget5_locked(sb, CRAMINO(cramfs_inode),
 					    cramfs_iget5_test, cramfs_iget5_set,
 					    cramfs_inode);
-	static struct timespec zerotime;
-
 	if (inode && (inode->i_state & I_NEW)) {
-		inode->i_mode = cramfs_inode->mode;
-		inode->i_uid = cramfs_inode->uid;
-		inode->i_size = cramfs_inode->size;
-		inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
-		inode->i_blksize = PAGE_CACHE_SIZE;
-		inode->i_gid = cramfs_inode->gid;
-		/* Struct copy intentional */
-		inode->i_mtime = inode->i_atime = inode->i_ctime = zerotime;
-		inode->i_ino = CRAMINO(cramfs_inode);
-		/* inode->i_nlink is left 1 - arguably wrong for directories,
-		   but it's the best we can do without reading the directory
-	           contents.  1 yields the right result in GNU find, even
-		   without -noleaf option. */
-		if (S_ISREG(inode->i_mode)) {
-			inode->i_fop = &generic_ro_fops;
-			inode->i_data.a_ops = &cramfs_aops;
-		} else if (S_ISDIR(inode->i_mode)) {
-			inode->i_op = &cramfs_dir_inode_operations;
-			inode->i_fop = &cramfs_directory_operations;
-		} else if (S_ISLNK(inode->i_mode)) {
-			inode->i_op = &page_symlink_inode_operations;
-			inode->i_data.a_ops = &cramfs_aops;
-		} else {
-			inode->i_size = 0;
-			inode->i_blocks = 0;
-			init_special_inode(inode, inode->i_mode,
-				old_decode_dev(cramfs_inode->size));
-		}
 		unlock_new_inode(inode);
 	}
 	return inode;

