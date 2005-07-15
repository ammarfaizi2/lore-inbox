Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263183AbVGODAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbVGODAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 23:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbVGODAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 23:00:06 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:10306 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S263183AbVGOC7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:59:50 -0400
Message-ID: <42D72705.8010306@tu-harburg.de>
Date: Fri, 15 Jul 2005 05:01:25 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ramfs: pretend dirent sizes
Content-Type: multipart/mixed;
 boundary="------------060900010802040200080103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060900010802040200080103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds bogo dirent sizes for ramfs like already available for 
tmpfs.

Although i_size of directories isn't covered by the POSIX standard it is 
a bad idea to always set it to zero. Therefore pretend a bogo dirent 
size for directory i_sizes.

Jan


--------------060900010802040200080103
Content-Type: text/x-patch;
 name="ramfs_bogo_dirent_size.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ramfs_bogo_dirent_size.diff"

Signed-off-by: Jan Blunck <j.blunck@tu-harburg.de>

 fs/ramfs/inode.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 47 insertions(+), 4 deletions(-)

Index: linux-2.6/fs/ramfs/inode.c
===================================================================
--- linux-2.6.orig/fs/ramfs/inode.c
+++ linux-2.6/fs/ramfs/inode.c
@@ -38,6 +38,9 @@
 /* some random number */
 #define RAMFS_MAGIC	0x858458f6
 
+/* Pretend that each entry is of this size in directory's i_size */
+#define BOGO_DIRENT_SIZE 20
+
 static struct super_operations ramfs_ops;
 static struct address_space_operations ramfs_aops;
 static struct inode_operations ramfs_file_inode_operations;
@@ -77,6 +80,7 @@ struct inode *ramfs_get_inode(struct sup
 
 			/* directory inodes start off with i_nlink == 2 (for "." entry) */
 			inode->i_nlink++;
+			inode->i_size = 2 * BOGO_DIRENT_SIZE;
 			break;
 		case S_IFLNK:
 			inode->i_op = &page_symlink_inode_operations;
@@ -97,6 +101,7 @@ ramfs_mknod(struct inode *dir, struct de
 	int error = -ENOSPC;
 
 	if (inode) {
+		dir->i_size += BOGO_DIRENT_SIZE;
 		if (dir->i_mode & S_ISGID) {
 			inode->i_gid = dir->i_gid;
 			if (S_ISDIR(mode))
@@ -132,6 +137,7 @@ static int ramfs_symlink(struct inode * 
 		int l = strlen(symname)+1;
 		error = page_symlink(inode, symname, l);
 		if (!error) {
+			dir->i_size += BOGO_DIRENT_SIZE;
 			if (dir->i_mode & S_ISGID)
 				inode->i_gid = dir->i_gid;
 			d_instantiate(dentry, inode);
@@ -142,6 +148,43 @@ static int ramfs_symlink(struct inode * 
 	return error;
 }
 
+static int ramfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
+{
+	dir->i_size += BOGO_DIRENT_SIZE;
+	return simple_link(old_dentry, dir, dentry);
+}
+
+static int ramfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	dir->i_size -= BOGO_DIRENT_SIZE;
+	return simple_unlink(dir, dentry);
+}
+
+static int ramfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	int ret;
+
+	ret = simple_rmdir(dir, dentry);
+	if (ret != -ENOTEMPTY)
+		dir->i_size -= BOGO_DIRENT_SIZE;
+
+	return ret;
+}
+
+static int ramfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+			struct inode *new_dir, struct dentry *new_dentry)
+{
+	int ret;
+
+	ret = simple_rename(old_dir, old_dentry, new_dir, new_dentry);
+	if (ret != -ENOTEMPTY) {
+		old_dir->i_size -= BOGO_DIRENT_SIZE;
+		new_dir->i_size += BOGO_DIRENT_SIZE;
+	}
+
+	return ret;
+}
+
 static struct address_space_operations ramfs_aops = {
 	.readpage	= simple_readpage,
 	.prepare_write	= simple_prepare_write,
@@ -164,13 +207,13 @@ static struct inode_operations ramfs_fil
 static struct inode_operations ramfs_dir_inode_operations = {
 	.create		= ramfs_create,
 	.lookup		= simple_lookup,
-	.link		= simple_link,
-	.unlink		= simple_unlink,
+	.link		= ramfs_link,
+	.unlink		= ramfs_unlink,
 	.symlink	= ramfs_symlink,
 	.mkdir		= ramfs_mkdir,
-	.rmdir		= simple_rmdir,
+	.rmdir		= ramfs_rmdir,
 	.mknod		= ramfs_mknod,
-	.rename		= simple_rename,
+	.rename		= ramfs_rename,
 };
 
 static struct super_operations ramfs_ops = {

--------------060900010802040200080103--
