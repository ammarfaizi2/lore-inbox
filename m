Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbVH1ROc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVH1ROc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 13:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVH1ROc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 13:14:32 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:45473 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750854AbVH1ROb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 13:14:31 -0400
Subject: [PATCH 2.6.13-rc6-mm2] v9fs: readlink extended mode check
From: Eric Van Hensbergen <ericvh@gmail.com>
To: linux-fsdevel@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
Content-Type: text/plain
Date: Sun, 28 Aug 2005 12:14:13 -0500
Message-Id: <1125249253.17501.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LANL reported some issues with random crashes during mount of
legacy protocol servers (9P2000 versus 9P2000.u) -- crash was always
happening in readlink (which should never happen in legacy mode).  Added
some sanity conditionals to the get_inode code which should prevent the
errors LANL was seeing.  Code tested benign through regression.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit 4bbf929d3991fde7eeb8754ae10025644637a268
tree bf671c4f29343ef86eb9c00030fa66d06915560b
parent f58a81f47f45c929ea0a1f74f9f15a27d3ad4ded
author Eric Van Hensbergen <ericvh@gmail.com> Tue, 02 Aug 2005 15:40:46
-0500
committer Eric Van Hensbergen <ericvh@gmail.com> Tue, 02 Aug 2005
15:40:46 -0500

 fs/9p/vfs_inode.c |   35 ++++++++++++++++++++++++++++++-----
 1 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -44,6 +44,7 @@
 #include "fid.h"
 
 static struct inode_operations v9fs_dir_inode_operations;
+static struct inode_operations v9fs_dir_inode_operations_ext;
 static struct inode_operations v9fs_file_inode_operations;
 static struct inode_operations v9fs_symlink_inode_operations;
 
@@ -232,6 +233,7 @@ v9fs_mistat2unix(struct v9fs_stat *mista
 struct inode *v9fs_get_inode(struct super_block *sb, int mode)
 {
 	struct inode *inode = NULL;
+	struct v9fs_session_info *v9ses = sb->s_fs_info;
 
 	dprintk(DEBUG_VFS, "super block: %p mode: %o\n", sb, mode);
 
@@ -250,6 +252,10 @@ struct inode *v9fs_get_inode(struct supe
 		case S_IFBLK:
 		case S_IFCHR:
 		case S_IFSOCK:
+			if(!v9ses->extended) {
+				dprintk(DEBUG_ERROR, "special files without extended mode\n");
+				return ERR_PTR(-EINVAL);
+			}
 			init_special_inode(inode, inode->i_mode,
 					   inode->i_rdev);
 			break;
@@ -257,14 +263,21 @@ struct inode *v9fs_get_inode(struct supe
 			inode->i_op = &v9fs_file_inode_operations;
 			inode->i_fop = &v9fs_file_operations;
 			break;
+		case S_IFLNK:
+			if(!v9ses->extended) {
+				dprintk(DEBUG_ERROR, "extended modes used w/o 9P2000.u\n");
+				return ERR_PTR(-EINVAL);
+			}
+			inode->i_op = &v9fs_symlink_inode_operations;
+			break;
 		case S_IFDIR:
 			inode->i_nlink++;
-			inode->i_op = &v9fs_dir_inode_operations;
+			if(v9ses->extended)
+				inode->i_op = &v9fs_dir_inode_operations_ext;
+			else
+				inode->i_op = &v9fs_dir_inode_operations;
 			inode->i_fop = &v9fs_dir_operations;
 			break;
-		case S_IFLNK:
-			inode->i_op = &v9fs_symlink_inode_operations;
-			break;
 		default:
 			dprintk(DEBUG_ERROR, "BAD mode 0x%x S_IFMT 0x%x\n",
 				mode, mode & S_IFMT);
@@ -1284,7 +1297,7 @@ v9fs_vfs_mknod(struct inode *dir, struct
 	return retval;
 }
 
-static struct inode_operations v9fs_dir_inode_operations = {
+static struct inode_operations v9fs_dir_inode_operations_ext = {
 	.create = v9fs_vfs_create,
 	.lookup = v9fs_vfs_lookup,
 	.symlink = v9fs_vfs_symlink,
@@ -1299,6 +1312,18 @@ static struct inode_operations v9fs_dir_
 	.setattr = v9fs_vfs_setattr,
 };
 
+static struct inode_operations v9fs_dir_inode_operations = {
+	.create = v9fs_vfs_create,
+	.lookup = v9fs_vfs_lookup,
+	.unlink = v9fs_vfs_unlink,
+	.mkdir = v9fs_vfs_mkdir,
+	.rmdir = v9fs_vfs_rmdir,
+	.mknod = v9fs_vfs_mknod,
+	.rename = v9fs_vfs_rename,
+	.getattr = v9fs_vfs_getattr,
+	.setattr = v9fs_vfs_setattr,
+};
+
 static struct inode_operations v9fs_file_inode_operations = {
 	.getattr = v9fs_vfs_getattr,
 	.setattr = v9fs_vfs_setattr,


