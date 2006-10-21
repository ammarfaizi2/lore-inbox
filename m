Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992841AbWJUHOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992841AbWJUHOY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992852AbWJUHOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:14:00 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:23687 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992847AbWJUHNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:13:50 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 19 of 23] autofs4: change uses of f_{dentry,
	vfsmnt} to use f_path
Message-Id: <98ffd30267ae73cec161.1161411464@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:44 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the autofs4 filesystem.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

2 files changed, 10 insertions(+), 9 deletions(-)
fs/autofs4/autofs_i.h |    3 ++-
fs/autofs4/root.c     |   16 ++++++++--------

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -150,7 +150,8 @@ static inline int autofs4_ispending(stru
 
 static inline void autofs4_copy_atime(struct file *src, struct file *dst)
 {
-	dst->f_dentry->d_inode->i_atime = src->f_dentry->d_inode->i_atime;
+	dst->f_path.dentry->d_inode->i_atime =
+		src->f_path.dentry->d_inode->i_atime;
 	return;
 }
 
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -74,7 +74,7 @@ static int autofs4_root_readdir(struct f
 static int autofs4_root_readdir(struct file *file, void *dirent,
 				filldir_t filldir)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(file->f_dentry->d_sb);
+	struct autofs_sb_info *sbi = autofs4_sbi(file->f_path.dentry->d_sb);
 	int oz_mode = autofs4_oz_mode(sbi);
 
 	DPRINTK("called, filp->f_pos = %lld", file->f_pos);
@@ -95,8 +95,8 @@ static int autofs4_root_readdir(struct f
 
 static int autofs4_dir_open(struct inode *inode, struct file *file)
 {
-	struct dentry *dentry = file->f_dentry;
-	struct vfsmount *mnt = file->f_vfsmnt;
+	struct dentry *dentry = file->f_path.dentry;
+	struct vfsmount *mnt = file->f_path.mnt;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct dentry *cursor;
 	int status;
@@ -172,7 +172,7 @@ out:
 
 static int autofs4_dir_close(struct inode *inode, struct file *file)
 {
-	struct dentry *dentry = file->f_dentry;
+	struct dentry *dentry = file->f_path.dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct dentry *cursor = file->private_data;
 	int status = 0;
@@ -204,7 +204,7 @@ out:
 
 static int autofs4_dir_readdir(struct file *file, void *dirent, filldir_t filldir)
 {
-	struct dentry *dentry = file->f_dentry;
+	struct dentry *dentry = file->f_path.dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct dentry *cursor = file->private_data;
 	int status;
@@ -858,14 +858,14 @@ static int autofs4_root_ioctl(struct ino
 		return autofs4_ask_reghost(sbi, p);
 
 	case AUTOFS_IOC_ASKUMOUNT:
-		return autofs4_ask_umount(filp->f_vfsmnt, p);
+		return autofs4_ask_umount(filp->f_path.mnt, p);
 
 	/* return a single thing to expire */
 	case AUTOFS_IOC_EXPIRE:
-		return autofs4_expire_run(inode->i_sb,filp->f_vfsmnt,sbi, p);
+		return autofs4_expire_run(inode->i_sb,filp->f_path.mnt,sbi, p);
 	/* same as above, but can send multiple expires through pipe */
 	case AUTOFS_IOC_EXPIRE_MULTI:
-		return autofs4_expire_multi(inode->i_sb,filp->f_vfsmnt,sbi, p);
+		return autofs4_expire_multi(inode->i_sb,filp->f_path.mnt,sbi, p);
 
 	default:
 		return -ENOSYS;


