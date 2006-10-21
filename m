Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992842AbWJUHNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992842AbWJUHNz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992849AbWJUHNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:13:53 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:17543 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992838AbWJUHNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:13:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 23 of 23] xfs: change uses of f_{dentry,vfsmnt} to use f_path
Message-Id: <b3a659c3aad05e4b16d4.1161411468@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:48 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, xfs-masters@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the xfs filesystem.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

5 files changed, 23 insertions(+), 23 deletions(-)
fs/xfs/linux-2.6/xfs_file.c    |   28 ++++++++++++++--------------
fs/xfs/linux-2.6/xfs_ioctl.c   |   10 +++++-----
fs/xfs/linux-2.6/xfs_ioctl32.c |    2 +-
fs/xfs/linux-2.6/xfs_lrw.c     |    2 +-
fs/xfs/xfs_dfrag.c             |    4 ++--

diff --git a/fs/xfs/linux-2.6/xfs_file.c b/fs/xfs/linux-2.6/xfs_file.c
--- a/fs/xfs/linux-2.6/xfs_file.c
+++ b/fs/xfs/linux-2.6/xfs_file.c
@@ -55,7 +55,7 @@ __xfs_file_read(
 	loff_t			pos)
 {
 	struct file		*file = iocb->ki_filp;
-	bhv_vnode_t		*vp = vn_from_inode(file->f_dentry->d_inode);
+	bhv_vnode_t		*vp = vn_from_inode(file->f_path.dentry->d_inode);
 
 	BUG_ON(iocb->ki_pos != pos);
 	if (unlikely(file->f_flags & O_DIRECT))
@@ -131,7 +131,7 @@ xfs_file_sendfile(
 	read_actor_t		actor,
 	void			*target)
 {
-	return bhv_vop_sendfile(vn_from_inode(filp->f_dentry->d_inode),
+	return bhv_vop_sendfile(vn_from_inode(filp->f_path.dentry->d_inode),
 				filp, pos, 0, count, actor, target, NULL);
 }
 
@@ -143,7 +143,7 @@ xfs_file_sendfile_invis(
 	read_actor_t		actor,
 	void			*target)
 {
-	return bhv_vop_sendfile(vn_from_inode(filp->f_dentry->d_inode),
+	return bhv_vop_sendfile(vn_from_inode(filp->f_path.dentry->d_inode),
 				filp, pos, IO_INVIS, count, actor, target, NULL);
 }
 
@@ -155,7 +155,7 @@ xfs_file_splice_read(
 	size_t			len,
 	unsigned int		flags)
 {
-	return bhv_vop_splice_read(vn_from_inode(infilp->f_dentry->d_inode),
+	return bhv_vop_splice_read(vn_from_inode(infilp->f_path.dentry->d_inode),
 				   infilp, ppos, pipe, len, flags, 0, NULL);
 }
 
@@ -167,7 +167,7 @@ xfs_file_splice_read_invis(
 	size_t			len,
 	unsigned int		flags)
 {
-	return bhv_vop_splice_read(vn_from_inode(infilp->f_dentry->d_inode),
+	return bhv_vop_splice_read(vn_from_inode(infilp->f_path.dentry->d_inode),
 				   infilp, ppos, pipe, len, flags, IO_INVIS,
 				   NULL);
 }
@@ -180,7 +180,7 @@ xfs_file_splice_write(
 	size_t			len,
 	unsigned int		flags)
 {
-	return bhv_vop_splice_write(vn_from_inode(outfilp->f_dentry->d_inode),
+	return bhv_vop_splice_write(vn_from_inode(outfilp->f_path.dentry->d_inode),
 				    pipe, outfilp, ppos, len, flags, 0, NULL);
 }
 
@@ -192,7 +192,7 @@ xfs_file_splice_write_invis(
 	size_t			len,
 	unsigned int		flags)
 {
-	return bhv_vop_splice_write(vn_from_inode(outfilp->f_dentry->d_inode),
+	return bhv_vop_splice_write(vn_from_inode(outfilp->f_path.dentry->d_inode),
 				    pipe, outfilp, ppos, len, flags, IO_INVIS,
 				    NULL);
 }
@@ -212,7 +212,7 @@ xfs_file_close(
 	struct file	*filp,
 	fl_owner_t	id)
 {
-	return -bhv_vop_close(vn_from_inode(filp->f_dentry->d_inode), 0,
+	return -bhv_vop_close(vn_from_inode(filp->f_path.dentry->d_inode), 0,
 				file_count(filp) > 1 ? L_FALSE : L_TRUE, NULL);
 }
 
@@ -251,7 +251,7 @@ xfs_vm_nopage(
 	unsigned long		address,
 	int			*type)
 {
-	struct inode	*inode = area->vm_file->f_dentry->d_inode;
+	struct inode	*inode = area->vm_file->f_path.dentry->d_inode;
 	bhv_vnode_t	*vp = vn_from_inode(inode);
 
 	ASSERT_ALWAYS(vp->v_vfsp->vfs_flag & VFS_DMI);
@@ -268,7 +268,7 @@ xfs_file_readdir(
 	filldir_t	filldir)
 {
 	int		error = 0;
-	bhv_vnode_t	*vp = vn_from_inode(filp->f_dentry->d_inode);
+	bhv_vnode_t	*vp = vn_from_inode(filp->f_path.dentry->d_inode);
 	uio_t		uio;
 	iovec_t		iov;
 	int		eof = 0;
@@ -345,7 +345,7 @@ xfs_file_mmap(
 	vma->vm_ops = &xfs_file_vm_ops;
 
 #ifdef CONFIG_XFS_DMAPI
-	if (vn_from_inode(filp->f_dentry->d_inode)->v_vfsp->vfs_flag & VFS_DMI)
+	if (vn_from_inode(filp->f_path.dentry->d_inode)->v_vfsp->vfs_flag & VFS_DMI)
 		vma->vm_ops = &xfs_dmapi_file_vm_ops;
 #endif /* CONFIG_XFS_DMAPI */
 
@@ -360,7 +360,7 @@ xfs_file_ioctl(
 	unsigned long	p)
 {
 	int		error;
-	struct inode	*inode = filp->f_dentry->d_inode;
+	struct inode	*inode = filp->f_path.dentry->d_inode;
 	bhv_vnode_t	*vp = vn_from_inode(inode);
 
 	error = bhv_vop_ioctl(vp, inode, filp, 0, cmd, (void __user *)p);
@@ -382,7 +382,7 @@ xfs_file_ioctl_invis(
 	unsigned long	p)
 {
 	int		error;
-	struct inode	*inode = filp->f_dentry->d_inode;
+	struct inode	*inode = filp->f_path.dentry->d_inode;
 	bhv_vnode_t	*vp = vn_from_inode(inode);
 
 	error = bhv_vop_ioctl(vp, inode, filp, IO_INVIS, cmd, (void __user *)p);
@@ -404,7 +404,7 @@ xfs_vm_mprotect(
 	struct vm_area_struct *vma,
 	unsigned int	newflags)
 {
-	bhv_vnode_t	*vp = vn_from_inode(vma->vm_file->f_dentry->d_inode);
+	bhv_vnode_t	*vp = vn_from_inode(vma->vm_file->f_path.dentry->d_inode);
 	int		error = 0;
 
 	if (vp->v_vfsp->vfs_flag & VFS_DMI) {
diff --git a/fs/xfs/linux-2.6/xfs_ioctl.c b/fs/xfs/linux-2.6/xfs_ioctl.c
--- a/fs/xfs/linux-2.6/xfs_ioctl.c
+++ b/fs/xfs/linux-2.6/xfs_ioctl.c
@@ -107,9 +107,9 @@ xfs_find_handle(
 		if (!file)
 		    return -EBADF;
 
-		ASSERT(file->f_dentry);
-		ASSERT(file->f_dentry->d_inode);
-		inode = igrab(file->f_dentry->d_inode);
+		ASSERT(file->f_path.dentry);
+		ASSERT(file->f_path.dentry->d_inode);
+		inode = igrab(file->f_path.dentry->d_inode);
 		fput(file);
 		break;
 	}
@@ -333,10 +333,10 @@ xfs_open_by_handle(
 	}
 
 	/* Ensure umount returns EBUSY on umounts while this file is open. */
-	mntget(parfilp->f_vfsmnt);
+	mntget(parfilp->f_path.mnt);
 
 	/* Create file pointer. */
-	filp = dentry_open(dentry, parfilp->f_vfsmnt, hreq.oflags);
+	filp = dentry_open(dentry, parfilp->f_path.mnt, hreq.oflags);
 	if (IS_ERR(filp)) {
 		put_unused_fd(new_fd);
 		return -XFS_ERROR(-PTR_ERR(filp));
diff --git a/fs/xfs/linux-2.6/xfs_ioctl32.c b/fs/xfs/linux-2.6/xfs_ioctl32.c
--- a/fs/xfs/linux-2.6/xfs_ioctl32.c
+++ b/fs/xfs/linux-2.6/xfs_ioctl32.c
@@ -112,7 +112,7 @@ xfs_compat_ioctl(
 	unsigned	cmd,
 	unsigned long	arg)
 {
-	struct inode	*inode = file->f_dentry->d_inode;
+	struct inode	*inode = file->f_path.dentry->d_inode;
 	bhv_vnode_t	*vp = vn_from_inode(inode);
 	int		error;
 
diff --git a/fs/xfs/linux-2.6/xfs_lrw.c b/fs/xfs/linux-2.6/xfs_lrw.c
--- a/fs/xfs/linux-2.6/xfs_lrw.c
+++ b/fs/xfs/linux-2.6/xfs_lrw.c
@@ -805,7 +805,7 @@ start:
 	     !capable(CAP_FSETID)) {
 		error = xfs_write_clear_setuid(xip);
 		if (likely(!error))
-			error = -remove_suid(file->f_dentry);
+			error = -remove_suid(file->f_path.dentry);
 		if (unlikely(error)) {
 			xfs_iunlock(xip, iolock);
 			goto out_unlock_mutex;
diff --git a/fs/xfs/xfs_dfrag.c b/fs/xfs/xfs_dfrag.c
--- a/fs/xfs/xfs_dfrag.c
+++ b/fs/xfs/xfs_dfrag.c
@@ -71,7 +71,7 @@ xfs_swapext(
 
 	/* Pull information for the target fd */
 	if (((fp = fget((int)sxp->sx_fdtarget)) == NULL) ||
-	    ((vp = vn_from_inode(fp->f_dentry->d_inode)) == NULL))  {
+	    ((vp = vn_from_inode(fp->f_path.dentry->d_inode)) == NULL))  {
 		error = XFS_ERROR(EINVAL);
 		goto error0;
 	}
@@ -83,7 +83,7 @@ xfs_swapext(
 	}
 
 	if (((tfp = fget((int)sxp->sx_fdtmp)) == NULL) ||
-	    ((tvp = vn_from_inode(tfp->f_dentry->d_inode)) == NULL)) {
+	    ((tvp = vn_from_inode(tfp->f_path.dentry->d_inode)) == NULL)) {
 		error = XFS_ERROR(EINVAL);
 		goto error0;
 	}


