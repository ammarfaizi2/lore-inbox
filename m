Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992880AbWJUHS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992880AbWJUHS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992855AbWJUHOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:14:31 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:23943 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992847AbWJUHOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:04 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 06 of 23] ext4: change uses of f_{dentry, vfsmnt} to use f_path
Message-Id: <dc423de2c3d8b76055dc.1161411451@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:31 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the ext4 filesystem.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

4 files changed, 8 insertions(+), 8 deletions(-)
fs/ext4/dir.c   |    8 ++++----
fs/ext4/file.c  |    2 +-
fs/ext4/ioctl.c |    2 +-
fs/ext4/namei.c |    4 ++--

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -103,7 +103,7 @@ static int ext4_readdir(struct file * fi
 	struct ext4_dir_entry_2 *de;
 	struct super_block *sb;
 	int err;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	int ret = 0;
 
 	sb = inode->i_sb;
@@ -122,7 +122,7 @@ static int ext4_readdir(struct file * fi
 		 * We don't set the inode dirty flag since it's not
 		 * critical that it get flushed back to the disk.
 		 */
-		EXT4_I(filp->f_dentry->d_inode)->i_flags &= ~EXT4_INDEX_FL;
+		EXT4_I(filp->f_path.dentry->d_inode)->i_flags &= ~EXT4_INDEX_FL;
 	}
 #endif
 	stored = 0;
@@ -399,7 +399,7 @@ static int call_filldir(struct file * fi
 {
 	struct dir_private_info *info = filp->private_data;
 	loff_t	curr_pos;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct super_block * sb;
 	int error;
 
@@ -429,7 +429,7 @@ static int ext4_dx_readdir(struct file *
 			 void * dirent, filldir_t filldir)
 {
 	struct dir_private_info *info = filp->private_data;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct fname *fname;
 	int	ret;
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -52,7 +52,7 @@ ext4_file_write(struct kiocb *iocb, cons
 		unsigned long nr_segs, loff_t pos)
 {
 	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 	ssize_t ret;
 	int err;
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -256,7 +256,7 @@ flags_err:
 #ifdef CONFIG_COMPAT
 long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 	int ret;
 
 	/* These are just misnamed, they actually get/put from/to user an int */
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -593,7 +593,7 @@ int ext4_htree_fill_tree(struct file *di
 
 	dxtrace(printk("In htree_fill_tree, start hash: %x:%x\n", start_hash,
 		       start_minor_hash));
-	dir = dir_file->f_dentry->d_inode;
+	dir = dir_file->f_path.dentry->d_inode;
 	if (!(EXT4_I(dir)->i_flags & EXT4_INDEX_FL)) {
 		hinfo.hash_version = EXT4_SB(dir->i_sb)->s_def_hash_version;
 		hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
@@ -604,7 +604,7 @@ int ext4_htree_fill_tree(struct file *di
 	}
 	hinfo.hash = start_hash;
 	hinfo.minor_hash = 0;
-	frame = dx_probe(NULL, dir_file->f_dentry->d_inode, &hinfo, frames, &err);
+	frame = dx_probe(NULL, dir_file->f_path.dentry->d_inode, &hinfo, frames, &err);
 	if (!frame)
 		return err;
 


