Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWJJDOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWJJDOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWJJDN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:13:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30381 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964930AbWJJDNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:13:42 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 19/25] nfsd: vfs.c endianness annotations
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX83p-0004GK-Ak@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:13:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


don't use the same variable to store NFS and host error values

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/vfs.c             |  299 ++++++++++++++++++++++++---------------------
 include/linux/nfsd/nfsd.h |   38 +++---
 2 files changed, 176 insertions(+), 161 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 1141bd2..f21e917 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -110,7 +110,7 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, s
 	struct dentry *dentry = *dpp;
 	struct vfsmount *mnt = mntget(exp->ex_mnt);
 	struct dentry *mounts = dget(dentry);
-	int err = nfs_ok;
+	int err = 0;
 
 	while (follow_down(&mnt,&mounts)&&d_mountpoint(mounts));
 
@@ -148,14 +148,15 @@ out:
  *   clients and is explicitly disallowed for NFSv3
  *      NeilBrown <neilb@cse.unsw.edu.au>
  */
-int
+__be32
 nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 					int len, struct svc_fh *resfh)
 {
 	struct svc_export	*exp;
 	struct dentry		*dparent;
 	struct dentry		*dentry;
-	int			err;
+	__be32			err;
+	int			host_err;
 
 	dprintk("nfsd: nfsd_lookup(fh %s, %.*s)\n", SVCFH_fmt(fhp), len,name);
 
@@ -193,7 +194,7 @@ nfsd_lookup(struct svc_rqst *rqstp, stru
 			exp2 = exp_parent(exp->ex_client, mnt, dentry,
 					  &rqstp->rq_chandle);
 			if (IS_ERR(exp2)) {
-				err = PTR_ERR(exp2);
+				host_err = PTR_ERR(exp2);
 				dput(dentry);
 				mntput(mnt);
 				goto out_nfserr;
@@ -210,14 +211,14 @@ nfsd_lookup(struct svc_rqst *rqstp, stru
 	} else {
 		fh_lock(fhp);
 		dentry = lookup_one_len(name, dparent, len);
-		err = PTR_ERR(dentry);
+		host_err = PTR_ERR(dentry);
 		if (IS_ERR(dentry))
 			goto out_nfserr;
 		/*
 		 * check if we have crossed a mount point ...
 		 */
 		if (d_mountpoint(dentry)) {
-			if ((err = nfsd_cross_mnt(rqstp, &dentry, &exp))) {
+			if ((host_err = nfsd_cross_mnt(rqstp, &dentry, &exp))) {
 				dput(dentry);
 				goto out_nfserr;
 			}
@@ -236,7 +237,7 @@ out:
 	return err;
 
 out_nfserr:
-	err = nfserrno(err);
+	err = nfserrno(host_err);
 	goto out;
 }
 
@@ -244,7 +245,7 @@ out_nfserr:
  * Set various file attributes.
  * N.B. After this call fhp needs an fh_put
  */
-int
+__be32
 nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 	     int check_guard, time_t guardtime)
 {
@@ -253,7 +254,8 @@ nfsd_setattr(struct svc_rqst *rqstp, str
 	int		accmode = MAY_SATTR;
 	int		ftype = 0;
 	int		imode;
-	int		err;
+	__be32		err;
+	int		host_err;
 	int		size_change = 0;
 
 	if (iap->ia_valid & (ATTR_ATIME | ATTR_MTIME | ATTR_SIZE))
@@ -319,19 +321,19 @@ #define	MAX_TOUCH_TIME_ERROR (30*60)
 		 * If we are changing the size of the file, then
 		 * we need to break all leases.
 		 */
-		err = break_lease(inode, FMODE_WRITE | O_NONBLOCK);
-		if (err == -EWOULDBLOCK)
-			err = -ETIMEDOUT;
-		if (err) /* ENOMEM or EWOULDBLOCK */
+		host_err = break_lease(inode, FMODE_WRITE | O_NONBLOCK);
+		if (host_err == -EWOULDBLOCK)
+			host_err = -ETIMEDOUT;
+		if (host_err) /* ENOMEM or EWOULDBLOCK */
 			goto out_nfserr;
 
-		err = get_write_access(inode);
-		if (err)
+		host_err = get_write_access(inode);
+		if (host_err)
 			goto out_nfserr;
 
 		size_change = 1;
-		err = locks_verify_truncate(inode, NULL, iap->ia_size);
-		if (err) {
+		host_err = locks_verify_truncate(inode, NULL, iap->ia_size);
+		if (host_err) {
 			put_write_access(inode);
 			goto out_nfserr;
 		}
@@ -357,8 +359,8 @@ #define	MAX_TOUCH_TIME_ERROR (30*60)
 	err = nfserr_notsync;
 	if (!check_guard || guardtime == inode->i_ctime.tv_sec) {
 		fh_lock(fhp);
-		err = notify_change(dentry, iap);
-		err = nfserrno(err);
+		host_err = notify_change(dentry, iap);
+		err = nfserrno(host_err);
 		fh_unlock(fhp);
 	}
 	if (size_change)
@@ -370,7 +372,7 @@ out:
 	return err;
 
 out_nfserr:
-	err = nfserrno(err);
+	err = nfserrno(host_err);
 	goto out;
 }
 
@@ -420,11 +422,12 @@ out:
 	return error;
 }
 
-int
+__be32
 nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
     struct nfs4_acl *acl)
 {
-	int error;
+	__be32 error;
+	int host_error;
 	struct dentry *dentry;
 	struct inode *inode;
 	struct posix_acl *pacl = NULL, *dpacl = NULL;
@@ -440,20 +443,20 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqst
 	if (S_ISDIR(inode->i_mode))
 		flags = NFS4_ACL_DIR;
 
-	error = nfs4_acl_nfsv4_to_posix(acl, &pacl, &dpacl, flags);
-	if (error == -EINVAL) {
+	host_error = nfs4_acl_nfsv4_to_posix(acl, &pacl, &dpacl, flags);
+	if (host_error == -EINVAL) {
 		error = nfserr_attrnotsupp;
 		goto out;
-	} else if (error < 0)
+	} else if (host_error < 0)
 		goto out_nfserr;
 
-	error = set_nfsv4_acl_one(dentry, pacl, POSIX_ACL_XATTR_ACCESS);
-	if (error < 0)
+	host_error = set_nfsv4_acl_one(dentry, pacl, POSIX_ACL_XATTR_ACCESS);
+	if (host_error < 0)
 		goto out_nfserr;
 
 	if (S_ISDIR(inode->i_mode)) {
-		error = set_nfsv4_acl_one(dentry, dpacl, POSIX_ACL_XATTR_DEFAULT);
-		if (error < 0)
+		host_error = set_nfsv4_acl_one(dentry, dpacl, POSIX_ACL_XATTR_DEFAULT);
+		if (host_error < 0)
 			goto out_nfserr;
 	}
 
@@ -464,7 +467,7 @@ out:
 	posix_acl_release(dpacl);
 	return (error);
 out_nfserr:
-	error = nfserrno(error);
+	error = nfserrno(host_error);
 	goto out;
 }
 
@@ -571,14 +574,14 @@ static struct accessmap	nfs3_anyaccess[]
     {	0,			0				}
 };
 
-int
+__be32
 nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *supported)
 {
 	struct accessmap	*map;
 	struct svc_export	*export;
 	struct dentry		*dentry;
 	u32			query, result = 0, sresult = 0;
-	unsigned int		error;
+	__be32			error;
 
 	error = fh_verify(rqstp, fhp, 0, MAY_NOP);
 	if (error)
@@ -598,7 +601,7 @@ nfsd_access(struct svc_rqst *rqstp, stru
 	query = *access;
 	for  (; map->access; map++) {
 		if (map->access & query) {
-			unsigned int err2;
+			__be32 err2;
 
 			sresult |= map->access;
 
@@ -637,13 +640,15 @@ #endif /* CONFIG_NFSD_V3 */
  * The access argument indicates the type of open (read/write/lock)
  * N.B. After this call fhp needs an fh_put
  */
-int
+__be32
 nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 			int access, struct file **filp)
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
-	int		flags = O_RDONLY|O_LARGEFILE, err;
+	int		flags = O_RDONLY|O_LARGEFILE;
+	__be32		err;
+	int		host_err;
 
 	/*
 	 * If we get here, then the client has already done an "open",
@@ -673,10 +678,10 @@ nfsd_open(struct svc_rqst *rqstp, struct
 	 * Check to see if there are any leases on this file.
 	 * This may block while leases are broken.
 	 */
-	err = break_lease(inode, O_NONBLOCK | ((access & MAY_WRITE) ? FMODE_WRITE : 0));
-	if (err == -EWOULDBLOCK)
-		err = -ETIMEDOUT;
-	if (err) /* NOMEM or WOULDBLOCK */
+	host_err = break_lease(inode, O_NONBLOCK | ((access & MAY_WRITE) ? FMODE_WRITE : 0));
+	if (host_err == -EWOULDBLOCK)
+		host_err = -ETIMEDOUT;
+	if (host_err) /* NOMEM or WOULDBLOCK */
 		goto out_nfserr;
 
 	if (access & MAY_WRITE) {
@@ -689,10 +694,9 @@ nfsd_open(struct svc_rqst *rqstp, struct
 	}
 	*filp = dentry_open(dget(dentry), mntget(fhp->fh_export->ex_mnt), flags);
 	if (IS_ERR(*filp))
-		err = PTR_ERR(*filp);
+		host_err = PTR_ERR(*filp);
 out_nfserr:
-	if (err)
-		err = nfserrno(err);
+	err = nfserrno(host_err);
 out:
 	return err;
 }
@@ -830,14 +834,15 @@ nfsd_read_actor(read_descriptor_t *desc,
 	return size;
 }
 
-static int
+static __be32
 nfsd_vfs_read(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
               loff_t offset, struct kvec *vec, int vlen, unsigned long *count)
 {
 	struct inode *inode;
 	struct raparms	*ra;
 	mm_segment_t	oldfs;
-	int		err;
+	__be32		err;
+	int		host_err;
 
 	err = nfserr_perm;
 	inode = file->f_dentry->d_inode;
@@ -855,12 +860,12 @@ #endif
 
 	if (file->f_op->sendfile && rqstp->rq_sendfile_ok) {
 		rqstp->rq_resused = 1;
-		err = file->f_op->sendfile(file, &offset, *count,
+		host_err = file->f_op->sendfile(file, &offset, *count,
 						 nfsd_read_actor, rqstp);
 	} else {
 		oldfs = get_fs();
 		set_fs(KERNEL_DS);
-		err = vfs_readv(file, (struct iovec __user *)vec, vlen, &offset);
+		host_err = vfs_readv(file, (struct iovec __user *)vec, vlen, &offset);
 		set_fs(oldfs);
 	}
 
@@ -874,13 +879,13 @@ #endif
 		spin_unlock(&rab->pb_lock);
 	}
 
-	if (err >= 0) {
-		nfsdstats.io_read += err;
-		*count = err;
+	if (host_err >= 0) {
+		nfsdstats.io_read += host_err;
+		*count = host_err;
 		err = 0;
 		fsnotify_access(file->f_dentry);
 	} else 
-		err = nfserrno(err);
+		err = nfserrno(host_err);
 out:
 	return err;
 }
@@ -895,7 +900,7 @@ static void kill_suid(struct dentry *den
 	mutex_unlock(&dentry->d_inode->i_mutex);
 }
 
-static int
+static __be32
 nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
 				loff_t offset, struct kvec *vec, int vlen,
 	   			unsigned long cnt, int *stablep)
@@ -904,7 +909,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, s
 	struct dentry		*dentry;
 	struct inode		*inode;
 	mm_segment_t		oldfs;
-	int			err = 0;
+	__be32			err = 0;
+	int			host_err;
 	int			stable = *stablep;
 
 #ifdef MSNFS
@@ -940,18 +946,18 @@ #endif
 
 	/* Write the data. */
 	oldfs = get_fs(); set_fs(KERNEL_DS);
-	err = vfs_writev(file, (struct iovec __user *)vec, vlen, &offset);
+	host_err = vfs_writev(file, (struct iovec __user *)vec, vlen, &offset);
 	set_fs(oldfs);
-	if (err >= 0) {
+	if (host_err >= 0) {
 		nfsdstats.io_write += cnt;
 		fsnotify_modify(file->f_dentry);
 	}
 
 	/* clear setuid/setgid flag after write */
-	if (err >= 0 && (inode->i_mode & (S_ISUID | S_ISGID)))
+	if (host_err >= 0 && (inode->i_mode & (S_ISUID | S_ISGID)))
 		kill_suid(dentry);
 
-	if (err >= 0 && stable) {
+	if (host_err >= 0 && stable) {
 		static ino_t	last_ino;
 		static dev_t	last_dev;
 
@@ -977,7 +983,7 @@ #endif
 
 			if (inode->i_state & I_DIRTY) {
 				dprintk("nfsd: write sync %d\n", current->pid);
-				err=nfsd_sync(file);
+				host_err=nfsd_sync(file);
 			}
 #if 0
 			wake_up(&inode->i_wait);
@@ -987,11 +993,11 @@ #endif
 		last_dev = inode->i_sb->s_dev;
 	}
 
-	dprintk("nfsd: write complete err=%d\n", err);
-	if (err >= 0)
+	dprintk("nfsd: write complete host_err=%d\n", host_err);
+	if (host_err >= 0)
 		err = 0;
 	else 
-		err = nfserrno(err);
+		err = nfserrno(host_err);
 out:
 	return err;
 }
@@ -1001,12 +1007,12 @@ out:
  * on entry. On return, *count contains the number of bytes actually read.
  * N.B. After this call fhp needs an fh_put
  */
-int
+__be32
 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
 		loff_t offset, struct kvec *vec, int vlen,
 		unsigned long *count)
 {
-	int		err;
+	__be32		err;
 
 	if (file) {
 		err = nfsd_permission(fhp->fh_export, fhp->fh_dentry,
@@ -1030,12 +1036,12 @@ out:
  * The stable flag requests synchronous writes.
  * N.B. After this call fhp needs an fh_put
  */
-int
+__be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
 		loff_t offset, struct kvec *vec, int vlen, unsigned long cnt,
 		int *stablep)
 {
-	int			err = 0;
+	__be32			err = 0;
 
 	if (file) {
 		err = nfsd_permission(fhp->fh_export, fhp->fh_dentry,
@@ -1067,12 +1073,12 @@ #ifdef CONFIG_NFSD_V3
  * Unfortunately we cannot lock the file to make sure we return full WCC
  * data to the client, as locking happens lower down in the filesystem.
  */
-int
+__be32
 nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
                loff_t offset, unsigned long count)
 {
 	struct file	*file;
-	int		err;
+	__be32		err;
 
 	if ((u64)count > ~(u64)offset)
 		return nfserr_inval;
@@ -1100,14 +1106,15 @@ #endif /* CONFIG_NFSD_V3 */
  *
  * N.B. Every call to nfsd_create needs an fh_put for _both_ fhp and resfhp
  */
-int
+__be32
 nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		char *fname, int flen, struct iattr *iap,
 		int type, dev_t rdev, struct svc_fh *resfhp)
 {
 	struct dentry	*dentry, *dchild = NULL;
 	struct inode	*dirp;
-	int		err;
+	__be32		err;
+	int		host_err;
 
 	err = nfserr_perm;
 	if (!flen)
@@ -1134,7 +1141,7 @@ nfsd_create(struct svc_rqst *rqstp, stru
 		/* called from nfsd_proc_mkdir, or possibly nfsd3_proc_create */
 		fh_lock_nested(fhp, I_MUTEX_PARENT);
 		dchild = lookup_one_len(fname, dentry, flen);
-		err = PTR_ERR(dchild);
+		host_err = PTR_ERR(dchild);
 		if (IS_ERR(dchild))
 			goto out_nfserr;
 		err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
@@ -1173,22 +1180,22 @@ nfsd_create(struct svc_rqst *rqstp, stru
 	err = nfserr_perm;
 	switch (type) {
 	case S_IFREG:
-		err = vfs_create(dirp, dchild, iap->ia_mode, NULL);
+		host_err = vfs_create(dirp, dchild, iap->ia_mode, NULL);
 		break;
 	case S_IFDIR:
-		err = vfs_mkdir(dirp, dchild, iap->ia_mode);
+		host_err = vfs_mkdir(dirp, dchild, iap->ia_mode);
 		break;
 	case S_IFCHR:
 	case S_IFBLK:
 	case S_IFIFO:
 	case S_IFSOCK:
-		err = vfs_mknod(dirp, dchild, iap->ia_mode, rdev);
+		host_err = vfs_mknod(dirp, dchild, iap->ia_mode, rdev);
 		break;
 	default:
 	        printk("nfsd: bad file type %o in nfsd_create\n", type);
-		err = -EINVAL;
+		host_err = -EINVAL;
 	}
-	if (err < 0)
+	if (host_err < 0)
 		goto out_nfserr;
 
 	if (EX_ISSYNC(fhp->fh_export)) {
@@ -1203,7 +1210,7 @@ nfsd_create(struct svc_rqst *rqstp, stru
 	 * directories via NFS.
 	 */
 	if ((iap->ia_valid &= ~(ATTR_UID|ATTR_GID|ATTR_MODE)) != 0) {
-		int err2 = nfsd_setattr(rqstp, resfhp, iap, 0, (time_t)0);
+		__be32 err2 = nfsd_setattr(rqstp, resfhp, iap, 0, (time_t)0);
 		if (err2)
 			err = err2;
 	}
@@ -1218,7 +1225,7 @@ out:
 	return err;
 
 out_nfserr:
-	err = nfserrno(err);
+	err = nfserrno(host_err);
 	goto out;
 }
 
@@ -1226,7 +1233,7 @@ #ifdef CONFIG_NFSD_V3
 /*
  * NFSv3 version of nfsd_create
  */
-int
+__be32
 nfsd_create_v3(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		char *fname, int flen, struct iattr *iap,
 		struct svc_fh *resfhp, int createmode, u32 *verifier,
@@ -1234,7 +1241,8 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 {
 	struct dentry	*dentry, *dchild = NULL;
 	struct inode	*dirp;
-	int		err;
+	__be32		err;
+	int		host_err;
 	__u32		v_mtime=0, v_atime=0;
 	int		v_mode=0;
 
@@ -1264,7 +1272,7 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 	 * Compose the response file handle.
 	 */
 	dchild = lookup_one_len(fname, dentry, flen);
-	err = PTR_ERR(dchild);
+	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild))
 		goto out_nfserr;
 
@@ -1320,8 +1328,8 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 		goto out;
 	}
 
-	err = vfs_create(dirp, dchild, iap->ia_mode, NULL);
-	if (err < 0)
+	host_err = vfs_create(dirp, dchild, iap->ia_mode, NULL);
+	if (host_err < 0)
 		goto out_nfserr;
 
 	if (EX_ISSYNC(fhp->fh_export)) {
@@ -1350,7 +1358,7 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 	 */
  set_attr:
 	if ((iap->ia_valid &= ~(ATTR_UID|ATTR_GID)) != 0) {
- 		int err2 = nfsd_setattr(rqstp, resfhp, iap, 0, (time_t)0);
+ 		__be32 err2 = nfsd_setattr(rqstp, resfhp, iap, 0, (time_t)0);
 		if (err2)
 			err = err2;
 	}
@@ -1368,7 +1376,7 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
  	return err;
  
  out_nfserr:
-	err = nfserrno(err);
+	err = nfserrno(host_err);
 	goto out;
 }
 #endif /* CONFIG_NFSD_V3 */
@@ -1378,13 +1386,14 @@ #endif /* CONFIG_NFSD_V3 */
  * fits into the buffer. On return, it contains the true length.
  * N.B. After this call fhp needs an fh_put
  */
-int
+__be32
 nfsd_readlink(struct svc_rqst *rqstp, struct svc_fh *fhp, char *buf, int *lenp)
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
 	mm_segment_t	oldfs;
-	int		err;
+	__be32		err;
+	int		host_err;
 
 	err = fh_verify(rqstp, fhp, S_IFLNK, MAY_NOP);
 	if (err)
@@ -1403,18 +1412,18 @@ nfsd_readlink(struct svc_rqst *rqstp, st
 	 */
 
 	oldfs = get_fs(); set_fs(KERNEL_DS);
-	err = inode->i_op->readlink(dentry, buf, *lenp);
+	host_err = inode->i_op->readlink(dentry, buf, *lenp);
 	set_fs(oldfs);
 
-	if (err < 0)
+	if (host_err < 0)
 		goto out_nfserr;
-	*lenp = err;
+	*lenp = host_err;
 	err = 0;
 out:
 	return err;
 
 out_nfserr:
-	err = nfserrno(err);
+	err = nfserrno(host_err);
 	goto out;
 }
 
@@ -1422,7 +1431,7 @@ out_nfserr:
  * Create a symlink and look up its inode
  * N.B. After this call _both_ fhp and resfhp need an fh_put
  */
-int
+__be32
 nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				char *fname, int flen,
 				char *path,  int plen,
@@ -1430,7 +1439,8 @@ nfsd_symlink(struct svc_rqst *rqstp, str
 				struct iattr *iap)
 {
 	struct dentry	*dentry, *dnew;
-	int		err, cerr;
+	__be32		err, cerr;
+	int		host_err;
 	umode_t		mode;
 
 	err = nfserr_noent;
@@ -1446,7 +1456,7 @@ nfsd_symlink(struct svc_rqst *rqstp, str
 	fh_lock(fhp);
 	dentry = fhp->fh_dentry;
 	dnew = lookup_one_len(fname, dentry, flen);
-	err = PTR_ERR(dnew);
+	host_err = PTR_ERR(dnew);
 	if (IS_ERR(dnew))
 		goto out_nfserr;
 
@@ -1458,21 +1468,21 @@ nfsd_symlink(struct svc_rqst *rqstp, str
 	if (unlikely(path[plen] != 0)) {
 		char *path_alloced = kmalloc(plen+1, GFP_KERNEL);
 		if (path_alloced == NULL)
-			err = -ENOMEM;
+			host_err = -ENOMEM;
 		else {
 			strncpy(path_alloced, path, plen);
 			path_alloced[plen] = 0;
-			err = vfs_symlink(dentry->d_inode, dnew, path_alloced, mode);
+			host_err = vfs_symlink(dentry->d_inode, dnew, path_alloced, mode);
 			kfree(path_alloced);
 		}
 	} else
-		err = vfs_symlink(dentry->d_inode, dnew, path, mode);
+		host_err = vfs_symlink(dentry->d_inode, dnew, path, mode);
 
-	if (!err)
+	if (!host_err) {
 		if (EX_ISSYNC(fhp->fh_export))
-			err = nfsd_sync_dir(dentry);
-	if (err)
-		err = nfserrno(err);
+			host_err = nfsd_sync_dir(dentry);
+	}
+	err = nfserrno(host_err);
 	fh_unlock(fhp);
 
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
@@ -1482,7 +1492,7 @@ out:
 	return err;
 
 out_nfserr:
-	err = nfserrno(err);
+	err = nfserrno(host_err);
 	goto out;
 }
 
@@ -1490,13 +1500,14 @@ out_nfserr:
  * Create a hardlink
  * N.B. After this call _both_ ffhp and tfhp need an fh_put
  */
-int
+__be32
 nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 				char *name, int len, struct svc_fh *tfhp)
 {
 	struct dentry	*ddir, *dnew, *dold;
 	struct inode	*dirp, *dest;
-	int		err;
+	__be32		err;
+	int		host_err;
 
 	err = fh_verify(rqstp, ffhp, S_IFDIR, MAY_CREATE);
 	if (err)
@@ -1517,24 +1528,25 @@ nfsd_link(struct svc_rqst *rqstp, struct
 	dirp = ddir->d_inode;
 
 	dnew = lookup_one_len(name, ddir, len);
-	err = PTR_ERR(dnew);
+	host_err = PTR_ERR(dnew);
 	if (IS_ERR(dnew))
 		goto out_nfserr;
 
 	dold = tfhp->fh_dentry;
 	dest = dold->d_inode;
 
-	err = vfs_link(dold, dirp, dnew);
-	if (!err) {
+	host_err = vfs_link(dold, dirp, dnew);
+	if (!host_err) {
 		if (EX_ISSYNC(ffhp->fh_export)) {
 			err = nfserrno(nfsd_sync_dir(ddir));
 			write_inode_now(dest, 1);
 		}
+		err = 0;
 	} else {
-		if (err == -EXDEV && rqstp->rq_vers == 2)
+		if (host_err == -EXDEV && rqstp->rq_vers == 2)
 			err = nfserr_acces;
 		else
-			err = nfserrno(err);
+			err = nfserrno(host_err);
 	}
 
 	dput(dnew);
@@ -1544,7 +1556,7 @@ out:
 	return err;
 
 out_nfserr:
-	err = nfserrno(err);
+	err = nfserrno(host_err);
 	goto out_unlock;
 }
 
@@ -1552,13 +1564,14 @@ out_nfserr:
  * Rename a file
  * N.B. After this call _both_ ffhp and tfhp need an fh_put
  */
-int
+__be32
 nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 			    struct svc_fh *tfhp, char *tname, int tlen)
 {
 	struct dentry	*fdentry, *tdentry, *odentry, *ndentry, *trap;
 	struct inode	*fdir, *tdir;
-	int		err;
+	__be32		err;
+	int		host_err;
 
 	err = fh_verify(rqstp, ffhp, S_IFDIR, MAY_REMOVE);
 	if (err)
@@ -1589,22 +1602,22 @@ nfsd_rename(struct svc_rqst *rqstp, stru
 	fill_pre_wcc(tfhp);
 
 	odentry = lookup_one_len(fname, fdentry, flen);
-	err = PTR_ERR(odentry);
+	host_err = PTR_ERR(odentry);
 	if (IS_ERR(odentry))
 		goto out_nfserr;
 
-	err = -ENOENT;
+	host_err = -ENOENT;
 	if (!odentry->d_inode)
 		goto out_dput_old;
-	err = -EINVAL;
+	host_err = -EINVAL;
 	if (odentry == trap)
 		goto out_dput_old;
 
 	ndentry = lookup_one_len(tname, tdentry, tlen);
-	err = PTR_ERR(ndentry);
+	host_err = PTR_ERR(ndentry);
 	if (IS_ERR(ndentry))
 		goto out_dput_old;
-	err = -ENOTEMPTY;
+	host_err = -ENOTEMPTY;
 	if (ndentry == trap)
 		goto out_dput_new;
 
@@ -1612,14 +1625,14 @@ #ifdef MSNFS
 	if ((ffhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
 		((atomic_read(&odentry->d_count) > 1)
 		 || (atomic_read(&ndentry->d_count) > 1))) {
-			err = -EPERM;
+			host_err = -EPERM;
 	} else
 #endif
-	err = vfs_rename(fdir, odentry, tdir, ndentry);
-	if (!err && EX_ISSYNC(tfhp->fh_export)) {
-		err = nfsd_sync_dir(tdentry);
-		if (!err)
-			err = nfsd_sync_dir(fdentry);
+	host_err = vfs_rename(fdir, odentry, tdir, ndentry);
+	if (!host_err && EX_ISSYNC(tfhp->fh_export)) {
+		host_err = nfsd_sync_dir(tdentry);
+		if (!host_err)
+			host_err = nfsd_sync_dir(fdentry);
 	}
 
  out_dput_new:
@@ -1627,8 +1640,7 @@ #endif
  out_dput_old:
 	dput(odentry);
  out_nfserr:
-	if (err)
-		err = nfserrno(err);
+	err = nfserrno(host_err);
 
 	/* we cannot reply on fh_unlock on the two filehandles,
 	 * as that would do the wrong thing if the two directories
@@ -1647,13 +1659,14 @@ out:
  * Unlink a file or directory
  * N.B. After this call fhp needs an fh_put
  */
-int
+__be32
 nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 				char *fname, int flen)
 {
 	struct dentry	*dentry, *rdentry;
 	struct inode	*dirp;
-	int		err;
+	__be32		err;
+	int		host_err;
 
 	err = nfserr_acces;
 	if (!flen || isdotent(fname, flen))
@@ -1667,7 +1680,7 @@ nfsd_unlink(struct svc_rqst *rqstp, stru
 	dirp = dentry->d_inode;
 
 	rdentry = lookup_one_len(fname, dentry, flen);
-	err = PTR_ERR(rdentry);
+	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
 		goto out_nfserr;
 
@@ -1684,22 +1697,23 @@ nfsd_unlink(struct svc_rqst *rqstp, stru
 #ifdef MSNFS
 		if ((fhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
 			(atomic_read(&rdentry->d_count) > 1)) {
-			err = -EPERM;
+			host_err = -EPERM;
 		} else
 #endif
-		err = vfs_unlink(dirp, rdentry);
+		host_err = vfs_unlink(dirp, rdentry);
 	} else { /* It's RMDIR */
-		err = vfs_rmdir(dirp, rdentry);
+		host_err = vfs_rmdir(dirp, rdentry);
 	}
 
 	dput(rdentry);
 
-	if (err == 0 &&
-	    EX_ISSYNC(fhp->fh_export))
-			err = nfsd_sync_dir(dentry);
+	if (host_err)
+		goto out_nfserr;
+	if (EX_ISSYNC(fhp->fh_export))
+		host_err = nfsd_sync_dir(dentry);
 
 out_nfserr:
-	err = nfserrno(err);
+	err = nfserrno(host_err);
 out:
 	return err;
 }
@@ -1708,11 +1722,12 @@ out:
  * Read entries from a directory.
  * The  NFSv3/4 verifier we ignore for now.
  */
-int
+__be32
 nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp, 
 	     struct readdir_cd *cdp, encode_dent_fn func)
 {
-	int		err;
+	__be32		err;
+	int 		host_err;
 	struct file	*file;
 	loff_t		offset = *offsetp;
 
@@ -1734,10 +1749,10 @@ nfsd_readdir(struct svc_rqst *rqstp, str
 
 	do {
 		cdp->err = nfserr_eof; /* will be cleared on successful read */
-		err = vfs_readdir(file, (filldir_t) func, cdp);
-	} while (err >=0 && cdp->err == nfs_ok);
-	if (err)
-		err = nfserrno(err);
+		host_err = vfs_readdir(file, (filldir_t) func, cdp);
+	} while (host_err >=0 && cdp->err == nfs_ok);
+	if (host_err)
+		err = nfserrno(host_err);
 	else
 		err = cdp->err;
 	*offsetp = vfs_llseek(file, 0, 1);
@@ -1754,10 +1769,10 @@ out:
  * Get file system stats
  * N.B. After this call fhp needs an fh_put
  */
-int
+__be32
 nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat)
 {
-	int err = fh_verify(rqstp, fhp, 0, MAY_NOP);
+	__be32 err = fh_verify(rqstp, fhp, 0, MAY_NOP);
 	if (!err && vfs_statfs(fhp->fh_dentry,stat))
 		err = nfserr_io;
 	return err;
@@ -1766,7 +1781,7 @@ nfsd_statfs(struct svc_rqst *rqstp, stru
 /*
  * Check for a user's access permissions to this inode.
  */
-int
+__be32
 nfsd_permission(struct svc_export *exp, struct dentry *dentry, int acc)
 {
 	struct inode	*inode = dentry->d_inode;
diff --git a/include/linux/nfsd/nfsd.h b/include/linux/nfsd/nfsd.h
index 2f75160..19a3c83 100644
--- a/include/linux/nfsd/nfsd.h
+++ b/include/linux/nfsd/nfsd.h
@@ -72,57 +72,57 @@ int		nfsd_racache_init(int);
 void		nfsd_racache_shutdown(void);
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		                struct svc_export **expp);
-int		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
+__be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
 				const char *, int, struct svc_fh *);
-int		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
+__be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
 				struct iattr *, int, time_t);
 #ifdef CONFIG_NFSD_V4
-int             nfsd4_set_nfs4_acl(struct svc_rqst *, struct svc_fh *,
+__be32          nfsd4_set_nfs4_acl(struct svc_rqst *, struct svc_fh *,
                     struct nfs4_acl *);
 int             nfsd4_get_nfs4_acl(struct svc_rqst *, struct dentry *, struct nfs4_acl **);
 #endif /* CONFIG_NFSD_V4 */
-int		nfsd_create(struct svc_rqst *, struct svc_fh *,
+__be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
 				int type, dev_t rdev, struct svc_fh *res);
 #ifdef CONFIG_NFSD_V3
-int		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
-int		nfsd_create_v3(struct svc_rqst *, struct svc_fh *,
+__be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
+__be32		nfsd_create_v3(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
 				struct svc_fh *res, int createmode,
 				u32 *verifier, int *truncp);
-int		nfsd_commit(struct svc_rqst *, struct svc_fh *,
+__be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
 				loff_t, unsigned long);
 #endif /* CONFIG_NFSD_V3 */
-int		nfsd_open(struct svc_rqst *, struct svc_fh *, int,
+__be32		nfsd_open(struct svc_rqst *, struct svc_fh *, int,
 				int, struct file **);
 void		nfsd_close(struct file *);
-int 		nfsd_read(struct svc_rqst *, struct svc_fh *, struct file *,
+__be32 		nfsd_read(struct svc_rqst *, struct svc_fh *, struct file *,
 				loff_t, struct kvec *, int, unsigned long *);
-int 		nfsd_write(struct svc_rqst *, struct svc_fh *,struct file *,
+__be32 		nfsd_write(struct svc_rqst *, struct svc_fh *,struct file *,
 				loff_t, struct kvec *,int, unsigned long, int *);
-int		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
+__be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
 				char *, int *);
-int		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
+__be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, char *path, int plen,
 				struct svc_fh *res, struct iattr *);
-int		nfsd_link(struct svc_rqst *, struct svc_fh *,
+__be32		nfsd_link(struct svc_rqst *, struct svc_fh *,
 				char *, int, struct svc_fh *);
-int		nfsd_rename(struct svc_rqst *,
+__be32		nfsd_rename(struct svc_rqst *,
 				struct svc_fh *, char *, int,
 				struct svc_fh *, char *, int);
-int		nfsd_remove(struct svc_rqst *,
+__be32		nfsd_remove(struct svc_rqst *,
 				struct svc_fh *, char *, int);
-int		nfsd_unlink(struct svc_rqst *, struct svc_fh *, int type,
+__be32		nfsd_unlink(struct svc_rqst *, struct svc_fh *, int type,
 				char *name, int len);
 int		nfsd_truncate(struct svc_rqst *, struct svc_fh *,
 				unsigned long size);
-int		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
+__be32		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
 			     loff_t *, struct readdir_cd *, encode_dent_fn);
-int		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
+__be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 				struct kstatfs *);
 
 int		nfsd_notify_change(struct inode *, struct iattr *);
-int		nfsd_permission(struct svc_export *, struct dentry *, int);
+__be32		nfsd_permission(struct svc_export *, struct dentry *, int);
 int		nfsd_sync_dir(struct dentry *dp);
 
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
-- 
1.4.2.GIT


