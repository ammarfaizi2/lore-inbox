Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbVGNSdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbVGNSdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263087AbVGNSdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:33:32 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:3263 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263072AbVGNSb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:31:28 -0400
Message-Id: <200507141830.j6EIUlRZ023653@ms-smtp-03-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Sun, 17 Jul 2005 08:53:50 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc2-mm2 3/7] v9fs: VFS inode operations (2.0.2)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [3/7] of the v9fs-2.0.2 patch against Linux 2.6.13-rc2-mm2.

This part of the patch contains the VFS inode interfaces changes related
to hch's comments.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>


 ----------

 fs/9p/vfs_inode.c   |   69 +++++-----------------------------------------------
 1 files changed, 7 insertions(+), 62 deletions(-)

 ----------

--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -34,9 +34,9 @@
 #include <linux/smp_lock.h>
 #include <linux/inet.h>
 #include <linux/namei.h>
+#include <linux/idr.h>
 
 #include "debug.h"
-#include "idpool.h"
 #include "v9fs.h"
 #include "9p.h"
 #include "v9fs_vfs.h"
@@ -268,7 +268,6 @@ struct inode *v9fs_get_inode(struct supe
 		default:
 			dprintk(DEBUG_ERROR, "BAD mode 0x%x S_IFMT 0x%x\n",
 				mode, mode & S_IFMT);
-			sb->s_op->put_inode(inode);
 			return ERR_PTR(-EINVAL);
 		}
 	} else {
@@ -446,30 +445,14 @@ static int v9fs_remove(struct inode *dir
 	dprintk(DEBUG_VFS, "inode: %p dentry: %p rmdir: %d\n", dir, file,
 		rmdir);
 
-	if (!dir || !S_ISDIR(dir->i_mode)) {
-		dprintk(DEBUG_ERROR, "dir inode is NULL or not a directory\n");
-		return -ENOENT;
-	}
-
-	if (!file) {
-		dprintk(DEBUG_ERROR, "NO dentry for file to remove\n");
-		return -EBADF;
-	}
-
-	if (!file->d_inode) {
-		dprintk(DEBUG_ERROR,
-			"dentry %p NO INODE for file to remove!\n", file);
-		return -EBADF;
-	}
-
 	file_inode = file->d_inode;
 	sb = file_inode->i_sb;
 	v9ses = v9fs_inode2v9ses(file_inode);
 	v9fid = v9fs_fid_lookup(file, FID_OP);
 
-	if (!sb || !v9ses || !v9fid) {
+	if (!v9fid) {
 		dprintk(DEBUG_ERROR,
-			"no superblock or v9session or v9fs_fid\n");
+			"no v9fs_fid\n");
 		return -EBADF;
 	}
 
@@ -480,14 +463,6 @@ static int v9fs_remove(struct inode *dir
 		return -EBADF;
 	}
 
-	if (rmdir && (!S_ISDIR(file_inode->i_mode))) {
-		dprintk(DEBUG_ERROR, "trying to remove non-directory\n");
-		return -ENOTDIR;
-	} else if ((!rmdir) && S_ISDIR(file_inode->i_mode)) {
-		dprintk(DEBUG_ERROR, "trying to remove directory\n");
-		return -EISDIR;
-	}
-
 	result = v9fs_t_remove(v9ses, fid, &fcall);
 	if (result < 0)
 		dprintk(DEBUG_ERROR, "remove of file fails: %s(%d)\n",
@@ -498,7 +473,6 @@ static int v9fs_remove(struct inode *dir
 	}
 
 	kfree(fcall);
-
 	return result;
 }
 
@@ -556,17 +530,12 @@ static struct dentry *v9fs_vfs_lookup(st
 	dprintk(DEBUG_VFS, "dir: %p dentry: (%s) %p nameidata: %p\n",
 		dir, dentry->d_iname, dentry, nameidata);
 
-	if (!dir) {
-		dprintk(DEBUG_ERROR, "no dir inode\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	sb = dir->i_sb;
 	v9ses = v9fs_inode2v9ses(dir);
 	dirfid = v9fs_fid_lookup(dentry->d_parent, FID_WALK);
 
-	if (!sb || !v9ses || !dirfid) {
-		dprintk(DEBUG_ERROR, "no superblock, v9ses, or dirfid\n");
+	if (!dirfid) {
+		dprintk(DEBUG_ERROR, "no dirfid\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -867,7 +836,7 @@ void
 v9fs_mistat2inode(struct v9fs_stat *mistat, struct inode *inode,
 		  struct super_block *sb)
 {
-	struct v9fs_session_info *v9ses = sb ? sb->s_fs_info : NULL;
+	struct v9fs_session_info *v9ses = sb->s_fs_info;
 
 	inode->i_nlink = 1;
 
@@ -878,7 +847,7 @@ v9fs_mistat2inode(struct v9fs_stat *mist
 	inode->i_uid = -1;
 	inode->i_gid = -1;
 
-	if (v9ses && v9ses->extended) {
+	if (v9ses->extended) {
 		/* TODO: string to uid mapping via user-space daemon */
 		inode->i_uid = mistat->n_uid;
 		inode->i_gid = mistat->n_gid;
@@ -959,7 +928,6 @@ v9fs_vfs_symlink(struct inode *dir, stru
 	int retval = -EPERM;
 	struct v9fs_fid *newfid;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
-	struct super_block *sb = dir ? dir->i_sb : NULL;
 	struct v9fs_fcall *fcall = NULL;
 	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
 
@@ -969,11 +937,6 @@ v9fs_vfs_symlink(struct inode *dir, stru
 	if(!mistat)
 		return -ENOMEM;
 
-	if ((!dentry) || (!sb) || (!v9ses)) {
-		dprintk(DEBUG_ERROR, "problem with arguments\n");
-		return -EBADF;
-	}
-
 	if (!v9ses->extended) {
 		dprintk(DEBUG_ERROR, "not extended\n");
 		goto FreeFcall;
@@ -997,9 +960,7 @@ v9fs_vfs_symlink(struct inode *dir, stru
 		goto FreeFcall;
 	}
 
-	/* need to update dcache so we show up */
 	kfree(fcall);
-	fcall = NULL;
 
 	if (v9fs_t_clunk(v9ses, newfid->fid, &fcall)) {
 		dprintk(DEBUG_ERROR, "clunk for symlink failed: %s\n",
@@ -1172,7 +1133,6 @@ v9fs_vfs_link(struct dentry *old_dentry,
 {
 	int retval = -EPERM;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
-	struct super_block *sb = dir ? dir->i_sb : NULL;
 	struct v9fs_fcall *fcall = NULL;
 	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
 	struct v9fs_fid *oldfid = v9fs_fid_lookup(old_dentry, FID_OP);
@@ -1185,12 +1145,6 @@ v9fs_vfs_link(struct dentry *old_dentry,
 	if (!mistat)
 		return -ENOMEM;
 
-	if ((!dentry) || (!sb) || (!v9ses) || (!oldfid)) {
-		dprintk(DEBUG_ERROR, "problem with arguments\n");
-		retval = -EBADF;
-		goto FreeMem;
-	}
-
 	if (!v9ses->extended) {
 		dprintk(DEBUG_ERROR, "not extended\n");
 		goto FreeMem;
@@ -1221,9 +1175,7 @@ v9fs_vfs_link(struct dentry *old_dentry,
 		goto FreeMem;
 	}
 
-	/* need to update dcache so we show up */
 	kfree(fcall);
-	fcall = NULL;
 
 	if (v9fs_t_clunk(v9ses, newfid->fid, &fcall)) {
 		dprintk(DEBUG_ERROR, "clunk for symlink failed: %s\n",
@@ -1258,7 +1210,6 @@ v9fs_vfs_mknod(struct inode *dir, struct
 	int retval = -EPERM;
 	struct v9fs_fid *newfid;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
-	struct super_block *sb = dir ? dir->i_sb : NULL;
 	struct v9fs_fcall *fcall = NULL;
 	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
 	char *symname = __getname();
@@ -1274,12 +1225,6 @@ v9fs_vfs_mknod(struct inode *dir, struct
 		goto FreeMem;
 	}
 
-	if ((!dentry) || (!sb) || (!v9ses)) {
-		dprintk(DEBUG_ERROR, "problem with arguments\n");
-		retval = -EBADF;
-		goto FreeMem;
-	}
-
 	if (!v9ses->extended) {
 		dprintk(DEBUG_ERROR, "not extended\n");
 		goto FreeMem;
