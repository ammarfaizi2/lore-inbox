Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbQKHSep>; Wed, 8 Nov 2000 13:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbQKHSei>; Wed, 8 Nov 2000 13:34:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41882 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129689AbQKHSe0>;
	Wed, 8 Nov 2000 13:34:26 -0500
Date: Wed, 8 Nov 2000 13:34:23 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Tigran Aivazian <tigran@veritas.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test11-pre1] a few more BUG()s for vfs_XXX()
In-Reply-To: <Pine.LNX.4.21.0011081552060.5517-100000@saturn.homenet>
Message-ID: <Pine.GSO.4.21.0011081302160.6737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Nov 2000, Tigran Aivazian wrote:

> Hi Linus,
> 
> I think that the check for inode->i_op == NULL in various
> vfs_XXX() functions is bogus, i.e. if it is NULL then it must be a bug in
> some filesystem's ->read_inode() method and therefore, instead of
> returning error to userspace we should immediately panic, since it is a
> kernel bug.

Frankly, I don't see the reason why ->i_op should be always non-NULL.
We may go for such variant, but right now it is legitimate. Silly - yes,
but...

> The patch below does just that -- i.e. converts them into BUG()s. This

Now, _that_ is just plain silly. They are immediately followed by dereferencing
the thing. And we don't have a lot of architecture-specific filesystems.

If we want to do it - let's do it right. Patch below should take care of
all places in the main tree and 3rd-party code should make sure that
i_op is never set to NULL. If you want "no methods" - just leave i_op
as is, fs/inode.c initializes it so that it points to empty table anyway.

							Cheers,
								Al

Patch follows:
diff -urN rc11-pre1/arch/ia64/kernel/sys_ia64.c rc11-pre1-i_op/arch/ia64/kernel/sys_ia64.c
--- rc11-pre1/arch/ia64/kernel/sys_ia64.c	Thu Nov  2 22:38:14 2000
+++ rc11-pre1-i_op/arch/ia64/kernel/sys_ia64.c	Wed Nov  8 16:41:48 2000
@@ -205,7 +205,7 @@
 do_revalidate (struct dentry *dentry)
 {
 	struct inode * inode = dentry->d_inode;
-	if (inode->i_op && inode->i_op->revalidate)
+	if (inode->i_op->revalidate)
 		return inode->i_op->revalidate(dentry);
 	return 0;
 }
diff -urN rc11-pre1/arch/mips64/kernel/linux32.c rc11-pre1-i_op/arch/mips64/kernel/linux32.c
--- rc11-pre1/arch/mips64/kernel/linux32.c	Tue Aug  1 19:50:08 2000
+++ rc11-pre1-i_op/arch/mips64/kernel/linux32.c	Wed Nov  8 16:41:58 2000
@@ -38,7 +38,7 @@
 {
 	struct inode * inode = dentry->d_inode;
 
-	if (inode->i_op && inode->i_op->revalidate)
+	if (inode->i_op->revalidate)
 		return inode->i_op->revalidate(dentry);
 
 	return 0;
diff -urN rc11-pre1/arch/sparc64/kernel/sys_sparc32.c rc11-pre1-i_op/arch/sparc64/kernel/sys_sparc32.c
--- rc11-pre1/arch/sparc64/kernel/sys_sparc32.c	Thu Nov  2 22:38:20 2000
+++ rc11-pre1-i_op/arch/sparc64/kernel/sys_sparc32.c	Wed Nov  8 16:42:05 2000
@@ -1544,7 +1544,7 @@
 do_revalidate(struct dentry *dentry)
 {
 	struct inode * inode = dentry->d_inode;
-	if (inode->i_op && inode->i_op->revalidate)
+	if (inode->i_op->revalidate)
 		return inode->i_op->revalidate(dentry);
 	return 0;
 }
diff -urN rc11-pre1/drivers/isdn/avmb1/capifs.c rc11-pre1-i_op/drivers/isdn/avmb1/capifs.c
--- rc11-pre1/drivers/isdn/avmb1/capifs.c	Thu Nov  2 22:38:31 2000
+++ rc11-pre1-i_op/drivers/isdn/avmb1/capifs.c	Wed Nov  8 16:42:17 2000
@@ -468,7 +468,6 @@
 	ino_t ino = inode->i_ino;
 	struct capifs_sb_info *sbi = SBI(inode->i_sb);
 
-	inode->i_op = NULL;
 	inode->i_mode = 0;
 	inode->i_nlink = 0;
 	inode->i_size = 0;
diff -urN rc11-pre1/fs/attr.c rc11-pre1-i_op/fs/attr.c
--- rc11-pre1/fs/attr.c	Thu Nov  2 22:38:56 2000
+++ rc11-pre1-i_op/fs/attr.c	Wed Nov  8 16:42:28 2000
@@ -120,7 +120,7 @@
 		attr->ia_mtime = now;
 
 	lock_kernel();
-	if (inode->i_op && inode->i_op->setattr) 
+	if (inode->i_op->setattr) 
 		error = inode->i_op->setattr(dentry, attr);
 	else {
 		error = inode_change_ok(inode, attr);
diff -urN rc11-pre1/fs/autofs4/inode.c rc11-pre1-i_op/fs/autofs4/inode.c
--- rc11-pre1/fs/autofs4/inode.c	Thu Apr 27 22:09:53 2000
+++ rc11-pre1-i_op/fs/autofs4/inode.c	Wed Nov  8 16:46:25 2000
@@ -313,7 +313,6 @@
 	inode->i_blocks = 0;
 	inode->i_rdev = 0;
 	inode->i_nlink = 1;
-	inode->i_op = NULL;
 	inode->i_fop = NULL;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 
@@ -323,6 +322,8 @@
 		inode->i_fop = &autofs4_dir_operations;
 	} else if (S_ISLNK(inf->mode))
 		inode->i_op = &autofs4_symlink_inode_operations;
+	else
+		BUG();
 
 	return inode;
 }
diff -urN rc11-pre1/fs/isofs/inode.c rc11-pre1-i_op/fs/isofs/inode.c
--- rc11-pre1/fs/isofs/inode.c	Mon Jul 31 17:13:26 2000
+++ rc11-pre1-i_op/fs/isofs/inode.c	Wed Nov  8 16:50:03 2000
@@ -799,9 +799,6 @@
 	/* check the root inode */
 	if (!inode)
 		goto out_no_root;
-	if (!inode->i_op)
-		goto out_bad_root;
-	/* get the root dentry */
 	s->s_root = d_alloc_root(inode);
 	if (!(s->s_root))
 		goto out_no_root;
diff -urN rc11-pre1/fs/namei.c rc11-pre1-i_op/fs/namei.c
--- rc11-pre1/fs/namei.c	Wed Oct  4 03:44:55 2000
+++ rc11-pre1-i_op/fs/namei.c	Wed Nov  8 16:52:12 2000
@@ -156,7 +156,7 @@
 {
 	int mode = inode->i_mode;
 
-	if (inode->i_op && inode->i_op->permission) {
+	if (inode->i_op->permission) {
 		int retval;
 		lock_kernel();
 		retval = inode->i_op->permission(inode, mask);
@@ -503,10 +503,6 @@
 		inode = dentry->d_inode;
 		if (!inode)
 			goto out_dput;
-		err = -ENOTDIR; 
-		if (!inode->i_op)
-			goto out_dput;
-
 		if (inode->i_op->follow_link) {
 			err = do_follow_link(dentry, nd);
 			dput(dentry);
@@ -516,9 +512,6 @@
 			inode = nd->dentry->d_inode;
 			if (!inode)
 				break;
-			err = -ENOTDIR; 
-			if (!inode->i_op)
-				break;
 		} else {
 			dput(nd->dentry);
 			nd->dentry = dentry;
@@ -562,7 +555,7 @@
 			;
 		inode = dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
-		    && inode && inode->i_op && inode->i_op->follow_link) {
+		    && inode && inode->i_op->follow_link) {
 			err = do_follow_link(dentry, nd);
 			dput(dentry);
 			if (err)
@@ -577,7 +570,7 @@
 			goto no_inode;
 		if (lookup_flags & LOOKUP_DIRECTORY) {
 			err = -ENOTDIR; 
-			if (!inode->i_op || !inode->i_op->lookup)
+			if (!inode->i_op->lookup)
 				break;
 		}
 		goto return_base;
@@ -904,7 +897,7 @@
 		goto exit_lock;
 
 	error = -EACCES;	/* shouldn't it be ENOSYS? */
-	if (!dir->i_op || !dir->i_op->create)
+	if (!dir->i_op->create)
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
@@ -1014,7 +1007,7 @@
 	error = -ENOENT;
 	if (!dentry->d_inode)
 		goto exit_dput;
-	if (dentry->d_inode->i_op && dentry->d_inode->i_op->follow_link)
+	if (dentry->d_inode->i_op->follow_link)
 		goto do_link;
 
 	dput(nd->dentry);
@@ -1184,7 +1177,7 @@
 		goto exit_lock;
 
 	error = -EPERM;
-	if (!dir->i_op || !dir->i_op->mknod)
+	if (!dir->i_op->mknod)
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
@@ -1251,7 +1244,7 @@
 		goto exit_lock;
 
 	error = -EPERM;
-	if (!dir->i_op || !dir->i_op->mkdir)
+	if (!dir->i_op->mkdir)
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
@@ -1333,7 +1326,7 @@
 	if (error)
 		return error;
 
-	if (!dir->i_op || !dir->i_op->rmdir)
+	if (!dir->i_op->rmdir)
 		return -EPERM;
 
 	DQUOT_INIT(dir);
@@ -1408,7 +1401,7 @@
 	error = may_delete(dir, dentry, 0);
 	if (!error) {
 		error = -EPERM;
-		if (dir->i_op && dir->i_op->unlink) {
+		if (dir->i_op->unlink) {
 			DQUOT_INIT(dir);
 			if (d_mountpoint(dentry))
 				error = -EBUSY;
@@ -1480,7 +1473,7 @@
 		goto exit_lock;
 
 	error = -EPERM;
-	if (!dir->i_op || !dir->i_op->symlink)
+	if (!dir->i_op->symlink)
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
@@ -1554,7 +1547,7 @@
 	error = -EPERM;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		goto exit_lock;
-	if (!dir->i_op || !dir->i_op->link)
+	if (!dir->i_op->link)
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
@@ -1672,7 +1665,7 @@
 	if (error)
 		return error;
 
-	if (!old_dir->i_op || !old_dir->i_op->rename)
+	if (!old_dir->i_op->rename)
 		return -EPERM;
 
 	/*
@@ -1748,7 +1741,7 @@
 	if (error)
 		return error;
 
-	if (!old_dir->i_op || !old_dir->i_op->rename)
+	if (!old_dir->i_op->rename)
 		return -EPERM;
 
 	DQUOT_INIT(old_dir);
diff -urN rc11-pre1/fs/nfsd/vfs.c rc11-pre1-i_op/fs/nfsd/vfs.c
--- rc11-pre1/fs/nfsd/vfs.c	Wed Nov  8 16:35:26 2000
+++ rc11-pre1-i_op/fs/nfsd/vfs.c	Wed Nov  8 16:49:54 2000
@@ -829,7 +829,7 @@
 	dirp = dentry->d_inode;
 
 	err = nfserr_notdir;
-	if(!dirp->i_op || !dirp->i_op->lookup)
+	if(!dirp->i_op->lookup)
 		goto out;
 	/*
 	 * Check whether the response file handle has been verified yet.
@@ -956,7 +956,7 @@
 	/* Get all the sanity checks out of the way before
 	 * we lock the parent. */
 	err = nfserr_notdir;
-	if(!dirp->i_op || !dirp->i_op->lookup)
+	if(!dirp->i_op->lookup)
 		goto out;
 	fh_lock(fhp);
 
@@ -1077,7 +1077,7 @@
 	inode = dentry->d_inode;
 
 	err = nfserr_inval;
-	if (!inode->i_op || !inode->i_op->readlink)
+	if (!inode->i_op->readlink)
 		goto out;
 
 	UPDATE_ATIME(inode);
diff -urN rc11-pre1/fs/ramfs/inode.c rc11-pre1-i_op/fs/ramfs/inode.c
--- rc11-pre1/fs/ramfs/inode.c	Wed Oct  4 03:44:58 2000
+++ rc11-pre1-i_op/fs/ramfs/inode.c	Wed Nov  8 16:48:31 2000
@@ -123,7 +123,6 @@
 		inode->i_blocks = 0;
 		inode->i_rdev = to_kdev_t(dev);
 		inode->i_nlink = 1;
-		inode->i_op = NULL;
 		inode->i_fop = NULL;
 		inode->i_mapping->a_ops = &ramfs_aops;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
diff -urN rc11-pre1/fs/stat.c rc11-pre1-i_op/fs/stat.c
--- rc11-pre1/fs/stat.c	Mon Aug 28 21:15:19 2000
+++ rc11-pre1-i_op/fs/stat.c	Wed Nov  8 16:50:21 2000
@@ -19,7 +19,7 @@
 do_revalidate(struct dentry *dentry)
 {
 	struct inode * inode = dentry->d_inode;
-	if (inode->i_op && inode->i_op->revalidate)
+	if (inode->i_op->revalidate)
 		return inode->i_op->revalidate(dentry);
 	return 0;
 }
@@ -255,7 +255,7 @@
 		struct inode * inode = nd.dentry->d_inode;
 
 		error = -EINVAL;
-		if (inode->i_op && inode->i_op->readlink &&
+		if (inode->i_op->readlink &&
 		    !(error = do_revalidate(nd.dentry))) {
 			UPDATE_ATIME(inode);
 			error = inode->i_op->readlink(nd.dentry, buf, bufsiz);
diff -urN rc11-pre1/ipc/shm.c rc11-pre1-i_op/ipc/shm.c
--- rc11-pre1/ipc/shm.c	Wed Oct  4 03:45:11 2000
+++ rc11-pre1-i_op/ipc/shm.c	Wed Nov  8 16:49:14 2000
@@ -376,7 +376,6 @@
 	struct shmid_kernel *shp;
 
 	id = inode->i_ino;
-	inode->i_op = NULL;
 	inode->i_mode = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 
diff -urN rc11-pre1/mm/memory.c rc11-pre1-i_op/mm/memory.c
--- rc11-pre1/mm/memory.c	Wed Nov  8 16:35:28 2000
+++ rc11-pre1-i_op/mm/memory.c	Wed Nov  8 16:49:30 2000
@@ -996,7 +996,7 @@
 	spin_unlock(&mapping->i_shared_lock);
 	/* this should go into ->truncate */
 	inode->i_size = offset;
-	if (inode->i_op && inode->i_op->truncate)
+	if (inode->i_op->truncate)
 		inode->i_op->truncate(inode);
 	return;
 
@@ -1013,7 +1013,7 @@
 		}
 	}
 	inode->i_size = offset;
-	if (inode->i_op && inode->i_op->truncate)
+	if (inode->i_op->truncate)
 		inode->i_op->truncate(inode);
 out:
 	return;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
