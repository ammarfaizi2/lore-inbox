Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbSK1A2e>; Wed, 27 Nov 2002 19:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbSK1A2e>; Wed, 27 Nov 2002 19:28:34 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:9989 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264984AbSK1A2Q>;
	Wed, 27 Nov 2002 19:28:16 -0500
Date: Wed, 27 Nov 2002 16:27:31 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] More LSM changes for 2.5.49
Message-ID: <20021128002730.GE7187@kroah.com>
References: <20021127230626.GB7187@kroah.com> <20021128002638.GD7187@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021128002638.GD7187@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.926, 2002/11/27 15:11:25-08:00, greg@kroah.com

LSM: change if statements into something more readable for the fs/* files.


diff -Nru a/fs/attr.c b/fs/attr.c
--- a/fs/attr.c	Wed Nov 27 15:18:10 2002
+++ b/fs/attr.c	Wed Nov 27 15:18:10 2002
@@ -157,7 +157,8 @@
 		return 0;
 
 	if (inode->i_op && inode->i_op->setattr) {
-		if (!(error = security_inode_setattr(dentry, attr)))
+		error = security_inode_setattr(dentry, attr);
+		if (!error)
 			error = inode->i_op->setattr(dentry, attr);
 	} else {
 		error = inode_change_ok(inode, attr);
diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Wed Nov 27 15:18:10 2002
+++ b/fs/dquot.c	Wed Nov 27 15:18:10 2002
@@ -1307,7 +1307,8 @@
 	error = -EIO;
 	if (!f->f_op || !f->f_op->read || !f->f_op->write)
 		goto out_f;
-	if ((error = security_quota_on(f)))
+	error = security_quota_on(f);
+	if (error)
 		goto out_f;
 	inode = f->f_dentry->d_inode;
 	error = -EACCES;
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Wed Nov 27 15:18:10 2002
+++ b/fs/exec.c	Wed Nov 27 15:18:10 2002
@@ -841,7 +841,8 @@
 	}
 
 	/* fill in binprm security blob */
-	if ((retval = security_bprm_set(bprm)))
+	retval = security_bprm_set(bprm);
+	if (retval)
 		return retval;
 
 	memset(bprm->buf,0,BINPRM_BUF_SIZE);
@@ -958,7 +959,8 @@
 	    }
 	}
 #endif
-	if ((retval = security_bprm_check(bprm)))
+	retval = security_bprm_check(bprm);
+	if (retval)
 		return retval;
 
 	/* kernel module loader fixup */
@@ -1054,7 +1056,8 @@
 	if ((retval = bprm.envc) < 0)
 		goto out_mm;
 
-	if ((retval = security_bprm_alloc(&bprm)))
+	retval = security_bprm_alloc(&bprm);
+	if (retval)
 		goto out;
 
 	retval = prepare_binprm(&bprm);
diff -Nru a/fs/fcntl.c b/fs/fcntl.c
--- a/fs/fcntl.c	Wed Nov 27 15:18:10 2002
+++ b/fs/fcntl.c	Wed Nov 27 15:18:10 2002
@@ -274,7 +274,8 @@
 {
 	int err;
 	
-	if ((err = security_file_set_fowner(filp)))
+	err = security_file_set_fowner(filp);
+	if (err)
 		return err;
 
 	f_modown(filp, arg, current->uid, current->euid, force);
@@ -367,7 +368,8 @@
 	if (!filp)
 		goto out;
 
-	if ((err = security_file_fcntl(filp, cmd, arg))) {
+	err = security_file_fcntl(filp, cmd, arg);
+	if (err) {
 		fput(filp);
 		return err;
 	}
@@ -390,7 +392,8 @@
 	if (!filp)
 		goto out;
 
-	if ((err = security_file_fcntl(filp, cmd, arg))) {
+	err = security_file_fcntl(filp, cmd, arg);
+	if (err) {
 		fput(filp);
 		return err;
 	}
diff -Nru a/fs/ioctl.c b/fs/ioctl.c
--- a/fs/ioctl.c	Wed Nov 27 15:18:10 2002
+++ b/fs/ioctl.c	Wed Nov 27 15:18:10 2002
@@ -59,7 +59,8 @@
 		goto out;
 	error = 0;
 
-	if ((error = security_file_ioctl(filp, cmd, arg))) {
+	error = security_file_ioctl(filp, cmd, arg);
+	if (error) {
                 fput(filp);
                 goto out;
         }
diff -Nru a/fs/locks.c b/fs/locks.c
--- a/fs/locks.c	Wed Nov 27 15:18:10 2002
+++ b/fs/locks.c	Wed Nov 27 15:18:10 2002
@@ -1185,7 +1185,8 @@
 		return -EACCES;
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
-	if ((error = security_file_lock(filp, arg)))
+	error = security_file_lock(filp, arg);
+	if (error)
 		return error;
 
 	lock_kernel();
@@ -1298,7 +1299,8 @@
 	if (error)
 		goto out_putf;
 
-	if ((error = security_file_lock(filp, cmd)))
+	error = security_file_lock(filp, cmd);
+	if (error)
 		goto out_free;
 
 	for (;;) {
@@ -1449,7 +1451,8 @@
 		goto out;
 	}
 
-	if ((error = security_file_lock(filp, file_lock->fl_type)))
+	error = security_file_lock(filp, file_lock->fl_type);
+	if (error)
 		goto out;
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
@@ -1588,7 +1591,8 @@
 		goto out;
 	}
 
-	if ((error = security_file_lock(filp, file_lock->fl_type)))
+	error = security_file_lock(filp, file_lock->fl_type);
+	if (error)
 		goto out;
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Wed Nov 27 15:18:10 2002
+++ b/fs/namei.c	Wed Nov 27 15:18:10 2002
@@ -413,7 +413,8 @@
 		current->state = TASK_RUNNING;
 		schedule();
 	}
-	if ((err = security_inode_follow_link(dentry, nd)))
+	err = security_inode_follow_link(dentry, nd);
+	if (err)
 		goto loop;
 	current->link_count++;
 	current->total_link_count++;
@@ -1124,7 +1125,8 @@
 		return -EACCES;	/* shouldn't it be ENOSYS? */
 	mode &= S_IALLUGO;
 	mode |= S_IFREG;
-	if ((error = security_inode_create(dir, dentry, mode)))
+	error = security_inode_create(dir, dentry, mode);
+	if (error)
 		return error;
 	DQUOT_INIT(dir);
 	error = dir->i_op->create(dir, dentry, mode);
@@ -1343,7 +1345,8 @@
 	 * stored in nd->last.name and we will have to putname() it when we
 	 * are done. Procfs-like symlinks just set LAST_BIND.
 	 */
-	if ((error = security_inode_follow_link(dentry, nd)))
+	error = security_inode_follow_link(dentry, nd);
+	if (error)
 		goto exit_dput;
 	UPDATE_ATIME(dentry->d_inode);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
@@ -1408,7 +1411,8 @@
 	if (!dir->i_op || !dir->i_op->mknod)
 		return -EPERM;
 
-	if ((error = security_inode_mknod(dir, dentry, mode, dev)))
+	error = security_inode_mknod(dir, dentry, mode, dev);
+	if (error)
 		return error;
 
 	DQUOT_INIT(dir);
@@ -1476,7 +1480,8 @@
 		return -EPERM;
 
 	mode &= (S_IRWXUGO|S_ISVTX);
-	if ((error = security_inode_mkdir(dir, dentry, mode)))
+	error = security_inode_mkdir(dir, dentry, mode);
+	if (error)
 		return error;
 
 	DQUOT_INIT(dir);
@@ -1568,7 +1573,8 @@
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
-		if (!(error = security_inode_rmdir(dir, dentry))) {
+		error = security_inode_rmdir(dir, dentry);
+		if (!error) {
 			error = dir->i_op->rmdir(dir, dentry);
 			if (!error)
 				dentry->d_inode->i_flags |= S_DEAD;
@@ -1641,7 +1647,8 @@
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
-		if (!(error = security_inode_unlink(dir, dentry)))
+		error = security_inode_unlink(dir, dentry);
+		if (error)
 			error = dir->i_op->unlink(dir, dentry);
 	}
 	up(&dentry->d_inode->i_sem);
@@ -1704,7 +1711,8 @@
 	if (!dir->i_op || !dir->i_op->symlink)
 		return -EPERM;
 
-	if ((error = security_inode_symlink(dir, dentry, oldname)))
+	error = security_inode_symlink(dir, dentry, oldname);
+	if (error)
 		return error;
 
 	DQUOT_INIT(dir);
@@ -1774,7 +1782,8 @@
 	if (S_ISDIR(old_dentry->d_inode->i_mode))
 		return -EPERM;
 
-	if ((error = security_inode_link(old_dentry, dir, new_dentry)))
+	error = security_inode_link(old_dentry, dir, new_dentry);
+	if (error)
 		return error;
 
 	down(&old_dentry->d_inode->i_sem);
@@ -1882,7 +1891,8 @@
 			return error;
 	}
 
-	if ((error = security_inode_rename(old_dir, old_dentry, new_dir, new_dentry)))
+	error = security_inode_rename(old_dir, old_dentry, new_dir, new_dentry);
+	if (error)
 		return error;
 
 	target = new_dentry->d_inode;
@@ -1916,7 +1926,8 @@
 	struct inode *target;
 	int error;
 
-	if ((error = security_inode_rename(old_dir, old_dentry, new_dir, new_dentry)))
+	error = security_inode_rename(old_dir, old_dentry, new_dir, new_dentry);
+	if (error)
 		return error;
 
 	dget(new_dentry);
diff -Nru a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Wed Nov 27 15:18:10 2002
+++ b/fs/namespace.c	Wed Nov 27 15:18:10 2002
@@ -289,7 +289,8 @@
 	struct super_block * sb = mnt->mnt_sb;
 	int retval = 0;
 
-	if ((retval = security_sb_umount(mnt, flags)))
+	retval = security_sb_umount(mnt, flags);
+	if (retval)
 		return retval;
 
 	/*
@@ -470,7 +471,8 @@
 	if (IS_DEADDIR(nd->dentry->d_inode))
 		goto out_unlock;
 
-	if ((err = security_sb_check_sb(mnt, nd)))
+	err = security_sb_check_sb(mnt, nd);
+	if (err)
 		goto out_unlock;
 
 	spin_lock(&dcache_lock);
@@ -740,7 +742,8 @@
 	if (retval)
 		return retval;
 
-	if ((retval = security_sb_mount(dev_name, &nd, type_page, flags, data_page)))
+	retval = security_sb_mount(dev_name, &nd, type_page, flags, data_page);
+	if (retval)
 		goto dput_out;
 
 	if (flags & MS_REMOUNT)
@@ -985,7 +988,8 @@
 	if (error)
 		goto out1;
 
-	if ((error = security_sb_pivotroot(&old_nd, &new_nd))) {
+	error = security_sb_pivotroot(&old_nd, &new_nd);
+	if (error) {
 		path_release(&old_nd);
 		goto out1;
 	}
diff -Nru a/fs/open.c b/fs/open.c
--- a/fs/open.c	Wed Nov 27 15:18:10 2002
+++ b/fs/open.c	Wed Nov 27 15:18:10 2002
@@ -31,7 +31,8 @@
 		retval = -ENOSYS;
 		if (sb->s_op && sb->s_op->statfs) {
 			memset(buf, 0, sizeof(struct statfs));
-			if ((retval = security_sb_statfs(sb)))
+			retval = security_sb_statfs(sb);
+			if (retval)
 				return retval;
 			retval = sb->s_op->statfs(sb, buf);
 		}
diff -Nru a/fs/read_write.c b/fs/read_write.c
--- a/fs/read_write.c	Wed Nov 27 15:18:10 2002
+++ b/fs/read_write.c	Wed Nov 27 15:18:10 2002
@@ -193,7 +193,8 @@
 
 	ret = locks_verify_area(FLOCK_VERIFY_READ, inode, file, *pos, count);
 	if (!ret) {
-		if (!(ret = security_file_permission (file, MAY_READ))) {
+		ret = security_file_permission (file, MAY_READ);
+		if (!ret) {
 			if (file->f_op->read)
 				ret = file->f_op->read(file, buf, count, pos);
 			else
@@ -232,7 +233,8 @@
 
 	ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file, *pos, count);
 	if (!ret) {
-		if (!(ret = security_file_permission (file, MAY_WRITE))) {
+		ret = security_file_permission (file, MAY_WRITE);
+		if (!ret) {
 			if (file->f_op->write)
 				ret = file->f_op->write(file, buf, count, pos);
 			else
diff -Nru a/fs/readdir.c b/fs/readdir.c
--- a/fs/readdir.c	Wed Nov 27 15:18:10 2002
+++ b/fs/readdir.c	Wed Nov 27 15:18:10 2002
@@ -22,7 +22,8 @@
 	if (!file->f_op || !file->f_op->readdir)
 		goto out;
 
-	if ((res = security_file_permission(file, MAY_READ)))
+	res = security_file_permission(file, MAY_READ);
+	if (res)
 		goto out;
 
 	down(&inode->i_sem);
diff -Nru a/fs/stat.c b/fs/stat.c
--- a/fs/stat.c	Wed Nov 27 15:18:10 2002
+++ b/fs/stat.c	Wed Nov 27 15:18:10 2002
@@ -38,7 +38,8 @@
 	struct inode *inode = dentry->d_inode;
 	int retval;
 
-	if ((retval = security_inode_getattr(mnt, dentry)))
+	retval = security_inode_getattr(mnt, dentry);
+	if (retval)
 		return retval;
 
 	if (inode->i_op->getattr)
@@ -241,7 +242,8 @@
 
 		error = -EINVAL;
 		if (inode->i_op && inode->i_op->readlink) {
-			if (!(error = security_inode_readlink(nd.dentry))) {
+			error = security_inode_readlink(nd.dentry);
+			if (!error) {
 				UPDATE_ATIME(inode);
 				error = inode->i_op->readlink(nd.dentry, buf, bufsiz);
 			}
diff -Nru a/fs/xattr.c b/fs/xattr.c
--- a/fs/xattr.c	Wed Nov 27 15:18:10 2002
+++ b/fs/xattr.c	Wed Nov 27 15:18:10 2002
@@ -86,7 +86,8 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->setxattr) {
-		if ((error = security_inode_setxattr(d, kname, kvalue, size, flags)))
+		error = security_inode_setxattr(d, kname, kvalue, size, flags);
+		if (error)
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->setxattr(d, kname, kvalue, size, flags);
@@ -162,7 +163,8 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->getxattr) {
-		if ((error = security_inode_getxattr(d, kname)))
+		error = security_inode_getxattr(d, kname);
+		if (error)
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
@@ -234,7 +236,8 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->listxattr) {
-		if ((error = security_inode_listxattr(d)))
+		error = security_inode_listxattr(d);
+		if (error)
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->listxattr(d, klist, size);
@@ -308,7 +311,8 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->removexattr) {
-		if ((error = security_inode_removexattr(d, kname)))
+		error = security_inode_removexattr(d, kname);
+		if (error)
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->removexattr(d, kname);
