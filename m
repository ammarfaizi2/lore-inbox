Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbSJQV2T>; Thu, 17 Oct 2002 17:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262166AbSJQV1W>; Thu, 17 Oct 2002 17:27:22 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:51982 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262156AbSJQVYk>;
	Thu, 17 Oct 2002 17:24:40 -0400
Date: Thu, 17 Oct 2002 14:30:19 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.43
Message-ID: <20021017213019.GF1125@kroah.com>
References: <20021017212620.GA1125@kroah.com> <20021017212809.GB1125@kroah.com> <20021017212839.GC1125@kroah.com> <20021017212924.GD1125@kroah.com> <20021017212958.GE1125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017212958.GE1125@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.802, 2002/10/17 14:06:57-07:00, greg@kroah.com

LSM: change all of the VFS related security calls to the new format.


diff -Nru a/fs/attr.c b/fs/attr.c
--- a/fs/attr.c	Thu Oct 17 14:19:00 2002
+++ b/fs/attr.c	Thu Oct 17 14:19:00 2002
@@ -153,13 +153,12 @@
 	}
 
 	if (inode->i_op && inode->i_op->setattr) {
-		error = security_ops->inode_setattr(dentry, attr);
-		if (!error)
+		if (!(error = security_inode_setattr(dentry, attr)))
 			error = inode->i_op->setattr(dentry, attr);
 	} else {
 		error = inode_change_ok(inode, attr);
 		if (!error)
-			error = security_ops->inode_setattr(dentry, attr);
+			error = security_inode_setattr(dentry, attr);
 		if (!error) {
 			if ((ia_valid & ATTR_UID && attr->ia_uid != inode->i_uid) ||
 			    (ia_valid & ATTR_GID && attr->ia_gid != inode->i_gid))
diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Thu Oct 17 14:19:00 2002
+++ b/fs/dquot.c	Thu Oct 17 14:19:00 2002
@@ -1306,8 +1306,7 @@
 	error = -EIO;
 	if (!f->f_op || !f->f_op->read || !f->f_op->write)
 		goto out_f;
-	error = security_ops->quota_on(f);
-	if (error)
+	if ((error = security_quota_on(f)))
 		goto out_f;
 	inode = f->f_dentry->d_inode;
 	error = -EACCES;
diff -Nru a/fs/fcntl.c b/fs/fcntl.c
--- a/fs/fcntl.c	Thu Oct 17 14:19:00 2002
+++ b/fs/fcntl.c	Thu Oct 17 14:19:00 2002
@@ -274,8 +274,7 @@
 {
 	int err;
 	
-	err = security_ops->file_set_fowner(filp);
-	if (err)
+	if ((err = security_file_set_fowner(filp)))
 		return err;
 
 	f_modown(filp, arg, current->uid, current->euid, force);
@@ -368,8 +367,7 @@
 	if (!filp)
 		goto out;
 
-	err = security_ops->file_fcntl(filp, cmd, arg);
-	if (err) {
+	if ((err = security_file_fcntl(filp, cmd, arg))) {
 		fput(filp);
 		return err;
 	}
@@ -392,8 +390,7 @@
 	if (!filp)
 		goto out;
 
-	err = security_ops->file_fcntl(filp, cmd, arg);
-	if (err) {
+	if ((err = security_file_fcntl(filp, cmd, arg))) {
 		fput(filp);
 		return err;
 	}
@@ -444,7 +441,7 @@
 	if (!sigio_perm(p, fown))
 		return;
 
-	if (security_ops->file_send_sigiotask(p, fown, fd, reason))
+	if (security_file_send_sigiotask(p, fown, fd, reason))
 		return;
 
 	switch (fown->signum) {
diff -Nru a/fs/file_table.c b/fs/file_table.c
--- a/fs/file_table.c	Thu Oct 17 14:19:00 2002
+++ b/fs/file_table.c	Thu Oct 17 14:19:00 2002
@@ -46,7 +46,7 @@
 		files_stat.nr_free_files--;
 	new_one:
 		memset(f, 0, sizeof(*f));
-		if (security_ops->file_alloc_security(f)) {
+		if (security_file_alloc(f)) {
 			list_add(&f->f_list, &free_list);
 			files_stat.nr_free_files++;
 			file_list_unlock();
@@ -127,7 +127,7 @@
 
 	if (file->f_op && file->f_op->release)
 		file->f_op->release(inode, file);
-	security_ops->file_free_security(file);
+	security_file_free(file);
 	fops_put(file->f_op);
 	if (file->f_mode & FMODE_WRITE)
 		put_write_access(inode);
@@ -160,7 +160,7 @@
 void put_filp(struct file *file)
 {
 	if(atomic_dec_and_test(&file->f_count)) {
-		security_ops->file_free_security(file);
+		security_file_free(file);
 		file_list_lock();
 		list_del(&file->f_list);
 		list_add(&file->f_list, &free_list);
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Thu Oct 17 14:19:00 2002
+++ b/fs/inode.c	Thu Oct 17 14:19:00 2002
@@ -120,7 +120,7 @@
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
 		inode->i_security = NULL;
-		if (security_ops->inode_alloc_security(inode)) {
+		if (security_inode_alloc(inode)) {
 			if (inode->i_sb->s_op->destroy_inode)
 				inode->i_sb->s_op->destroy_inode(inode);
 			else
@@ -146,7 +146,7 @@
 {
 	if (inode_has_buffers(inode))
 		BUG();
-	security_ops->inode_free_security(inode);
+	security_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode) {
 		inode->i_sb->s_op->destroy_inode(inode);
 	} else {
@@ -922,7 +922,7 @@
 	if (inode->i_data.nrpages)
 		truncate_inode_pages(&inode->i_data, 0);
 
-	security_ops->inode_delete(inode);
+	security_inode_delete(inode);
 
 	if (op && op->delete_inode) {
 		void (*delete)(struct inode *) = op->delete_inode;
diff -Nru a/fs/ioctl.c b/fs/ioctl.c
--- a/fs/ioctl.c	Thu Oct 17 14:19:00 2002
+++ b/fs/ioctl.c	Thu Oct 17 14:19:00 2002
@@ -59,8 +59,7 @@
 		goto out;
 	error = 0;
 
-	error = security_ops->file_ioctl(filp, cmd, arg);
-        if (error) {
+	if ((error = security_file_ioctl(filp, cmd, arg))) {
                 fput(filp);
                 goto out;
         }
diff -Nru a/fs/locks.c b/fs/locks.c
--- a/fs/locks.c	Thu Oct 17 14:19:00 2002
+++ b/fs/locks.c	Thu Oct 17 14:19:00 2002
@@ -1175,8 +1175,7 @@
 		return -EACCES;
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
-	error = security_ops->file_lock(filp, arg);
-	if (error)
+	if ((error = security_file_lock(filp, arg)))
 		return error;
 
 	lock_kernel();
@@ -1289,8 +1288,7 @@
 	if (error)
 		goto out_putf;
 
-	error = security_ops->file_lock(filp, cmd);
-	if (error)
+	if ((error = security_file_lock(filp, cmd)))
 		goto out_free;
 
 	for (;;) {
@@ -1439,8 +1437,7 @@
 		goto out;
 	}
 
-	error = security_ops->file_lock(filp, file_lock->fl_type);
-	if (error)
+	if ((error = security_file_lock(filp, file_lock->fl_type)))
 		goto out;
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
@@ -1579,8 +1576,7 @@
 		goto out;
 	}
 
-	error = security_ops->file_lock(filp, file_lock->fl_type);
-	if (error)
+	if ((error = security_file_lock(filp, file_lock->fl_type)))
 		goto out;
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Thu Oct 17 14:19:00 2002
+++ b/fs/namei.c	Thu Oct 17 14:19:00 2002
@@ -218,7 +218,7 @@
 	if (retval)
 		return retval;
 
-	return security_ops->inode_permission(inode, mask);
+	return security_inode_permission(inode, mask);
 }
 
 /*
@@ -340,7 +340,7 @@
 
 	return -EACCES;
 ok:
-	return security_ops->inode_permission_lite(inode, MAY_EXEC);
+	return security_inode_permission_lite(inode, MAY_EXEC);
 }
 
 /*
@@ -374,7 +374,7 @@
 				dput(dentry);
 			else {
 				result = dentry;
-				security_ops->inode_post_lookup(dir, result);
+				security_inode_post_lookup(dir, result);
 			}
 		}
 		up(&dir->i_sem);
@@ -413,8 +413,7 @@
 		current->state = TASK_RUNNING;
 		schedule();
 	}
-	err = security_ops->inode_follow_link(dentry, nd);
-	if (err)
+	if ((err = security_inode_follow_link(dentry, nd)))
 		goto loop;
 	current->link_count++;
 	current->total_link_count++;
@@ -918,7 +917,7 @@
 		dentry = inode->i_op->lookup(inode, new);
 		if (!dentry) {
 			dentry = new;
-			security_ops->inode_post_lookup(inode, dentry);
+			security_inode_post_lookup(inode, dentry);
 		} else
 			dput(new);
 	}
@@ -1125,14 +1124,13 @@
 		return -EACCES;	/* shouldn't it be ENOSYS? */
 	mode &= S_IALLUGO;
 	mode |= S_IFREG;
-	error = security_ops->inode_create(dir, dentry, mode);
-	if (error)
+	if ((error = security_inode_create(dir, dentry, mode)))
 		return error;
 	DQUOT_INIT(dir);
 	error = dir->i_op->create(dir, dentry, mode);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
-		security_ops->inode_post_create(dir, dentry, mode);
+		security_inode_post_create(dir, dentry, mode);
 	}
 	return error;
 }
@@ -1344,8 +1342,7 @@
 	 * stored in nd->last.name and we will have to putname() it when we
 	 * are done. Procfs-like symlinks just set LAST_BIND.
 	 */
-	error = security_ops->inode_follow_link(dentry, nd);
-	if (error)
+	if ((error = security_inode_follow_link(dentry, nd)))
 		goto exit_dput;
 	UPDATE_ATIME(dentry->d_inode);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
@@ -1410,15 +1407,14 @@
 	if (!dir->i_op || !dir->i_op->mknod)
 		return -EPERM;
 
-	error = security_ops->inode_mknod(dir, dentry, mode, dev);
-	if (error)
+	if ((error = security_inode_mknod(dir, dentry, mode, dev)))
 		return error;
 
 	DQUOT_INIT(dir);
 	error = dir->i_op->mknod(dir, dentry, mode, dev);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
-		security_ops->inode_post_mknod(dir, dentry, mode, dev);
+		security_inode_post_mknod(dir, dentry, mode, dev);
 	}
 	return error;
 }
@@ -1478,15 +1474,14 @@
 		return -EPERM;
 
 	mode &= (S_IRWXUGO|S_ISVTX);
-	error = security_ops->inode_mkdir(dir, dentry, mode);
-	if (error)
+	if ((error = security_inode_mkdir(dir, dentry, mode)))
 		return error;
 
 	DQUOT_INIT(dir);
 	error = dir->i_op->mkdir(dir, dentry, mode);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
-		security_ops->inode_post_mkdir(dir,dentry, mode);
+		security_inode_post_mkdir(dir,dentry, mode);
 	}
 	return error;
 }
@@ -1570,8 +1565,7 @@
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
-		error = security_ops->inode_rmdir(dir, dentry);
-		if (!error) {
+		if (!(error = security_inode_rmdir(dir, dentry))) {
 			error = dir->i_op->rmdir(dir, dentry);
 			if (!error)
 				dentry->d_inode->i_flags |= S_DEAD;
@@ -1644,10 +1638,8 @@
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
-		error = security_ops->inode_unlink(dir, dentry);
-		if (!error) {
+		if (!(error = security_inode_unlink(dir, dentry)))
 			error = dir->i_op->unlink(dir, dentry);
-		}
 	}
 	up(&dentry->d_inode->i_sem);
 	if (!error) {
@@ -1709,15 +1701,14 @@
 	if (!dir->i_op || !dir->i_op->symlink)
 		return -EPERM;
 
-	error = security_ops->inode_symlink(dir, dentry, oldname);
-	if (error)
+	if ((error = security_inode_symlink(dir, dentry, oldname)))
 		return error;
 
 	DQUOT_INIT(dir);
 	error = dir->i_op->symlink(dir, dentry, oldname);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
-		security_ops->inode_post_symlink(dir, dentry, oldname);
+		security_inode_post_symlink(dir, dentry, oldname);
 	}
 	return error;
 }
@@ -1780,8 +1771,7 @@
 	if (S_ISDIR(old_dentry->d_inode->i_mode))
 		return -EPERM;
 
-	error = security_ops->inode_link(old_dentry, dir, new_dentry);
-	if (error)
+	if ((error = security_inode_link(old_dentry, dir, new_dentry)))
 		return error;
 
 	down(&old_dentry->d_inode->i_sem);
@@ -1790,7 +1780,7 @@
 	up(&old_dentry->d_inode->i_sem);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
-		security_ops->inode_post_link(old_dentry, dir, new_dentry);
+		security_inode_post_link(old_dentry, dir, new_dentry);
 	}
 	return error;
 }
@@ -1889,8 +1879,7 @@
 			return error;
 	}
 
-	error = security_ops->inode_rename(old_dir, old_dentry, new_dir, new_dentry);
-	if (error)
+	if ((error = security_inode_rename(old_dir, old_dentry, new_dir, new_dentry)))
 		return error;
 
 	target = new_dentry->d_inode;
@@ -1912,8 +1901,8 @@
 	}
 	if (!error) {
 		d_move(old_dentry,new_dentry);
-		security_ops->inode_post_rename(old_dir, old_dentry,
-							new_dir, new_dentry);
+		security_inode_post_rename(old_dir, old_dentry,
+					   new_dir, new_dentry);
 	}
 	return error;
 }
@@ -1924,8 +1913,7 @@
 	struct inode *target;
 	int error;
 
-	error = security_ops->inode_rename(old_dir, old_dentry, new_dir, new_dentry);
-	if (error)
+	if ((error = security_inode_rename(old_dir, old_dentry, new_dir, new_dentry)))
 		return error;
 
 	dget(new_dentry);
@@ -1940,7 +1928,7 @@
 		/* The following d_move() should become unconditional */
 		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
 			d_move(old_dentry, new_dentry);
-		security_ops->inode_post_rename(old_dir, old_dentry, new_dir, new_dentry);
+		security_inode_post_rename(old_dir, old_dentry, new_dir, new_dentry);
 	}
 	if (target)
 		up(&target->i_sem);
diff -Nru a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Thu Oct 17 14:19:00 2002
+++ b/fs/namespace.c	Thu Oct 17 14:19:00 2002
@@ -289,8 +289,7 @@
 	struct super_block * sb = mnt->mnt_sb;
 	int retval = 0;
 
-	retval = security_ops->sb_umount(mnt, flags);
-	if (retval)
+	if ((retval = security_sb_umount(mnt, flags)))
 		return retval;
 
 	/*
@@ -342,7 +341,7 @@
 		DQUOT_OFF(sb);
 		acct_auto_close(sb);
 		unlock_kernel();
-		security_ops->sb_umount_close(mnt);
+		security_sb_umount_close(mnt);
 		spin_lock(&dcache_lock);
 	}
 	retval = -EBUSY;
@@ -353,7 +352,7 @@
 	}
 	spin_unlock(&dcache_lock);
 	if (retval)
-		security_ops->sb_umount_busy(mnt);
+		security_sb_umount_busy(mnt);
 	up_write(&current->namespace->sem);
 	return retval;
 }
@@ -471,8 +470,7 @@
 	if (IS_DEADDIR(nd->dentry->d_inode))
 		goto out_unlock;
 
-	err = security_ops->sb_check_sb(mnt, nd);
-	if (err)
+	if ((err = security_sb_check_sb(mnt, nd)))
 		goto out_unlock;
 
 	spin_lock(&dcache_lock);
@@ -488,7 +486,7 @@
 out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
 	if (!err)
-		security_ops->sb_post_addmount(mnt, nd);
+		security_sb_post_addmount(mnt, nd);
 	return err;
 }
 
@@ -559,7 +557,7 @@
 		nd->mnt->mnt_flags=mnt_flags;
 	up_write(&sb->s_umount);
 	if (!err)
-		security_ops->sb_post_remount(nd->mnt, flags, data);
+		security_sb_post_remount(nd->mnt, flags, data);
 	return err;
 }
 
@@ -742,8 +740,7 @@
 	if (retval)
 		return retval;
 
-	retval = security_ops->sb_mount(dev_name, &nd, type_page, flags, data_page);
-	if (retval)
+	if ((retval = security_sb_mount(dev_name, &nd, type_page, flags, data_page)))
 		goto dput_out;
 
 	if (flags & MS_REMOUNT)
@@ -940,8 +937,7 @@
 	if (error)
 		goto out1;
 
-	error = security_ops->sb_pivotroot(&old_nd, &new_nd);
-	if (error) {
+	if ((error = security_sb_pivotroot(&old_nd, &new_nd))) {
 		path_release(&old_nd);
 		goto out1;
 	}
@@ -990,7 +986,7 @@
 	attach_mnt(new_nd.mnt, &root_parent);
 	spin_unlock(&dcache_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
-	security_ops->sb_post_pivotroot(&user_nd, &new_nd);
+	security_sb_post_pivotroot(&user_nd, &new_nd);
 	error = 0;
 	path_release(&root_parent);
 	path_release(&parent_nd);
diff -Nru a/fs/open.c b/fs/open.c
--- a/fs/open.c	Thu Oct 17 14:19:00 2002
+++ b/fs/open.c	Thu Oct 17 14:19:00 2002
@@ -30,8 +30,7 @@
 		retval = -ENOSYS;
 		if (sb->s_op && sb->s_op->statfs) {
 			memset(buf, 0, sizeof(struct statfs));
-			retval = security_ops->sb_statfs(sb);
-			if (retval)
+			if ((retval = security_sb_statfs(sb)))
 				return retval;
 			retval = sb->s_op->statfs(sb, buf);
 		}
diff -Nru a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c	Thu Oct 17 14:19:00 2002
+++ b/fs/proc/base.c	Thu Oct 17 14:19:00 2002
@@ -395,7 +395,7 @@
 };
 
 #define MAY_PTRACE(p) \
-(p==current||(p->parent==current&&(p->ptrace & PT_PTRACED)&&p->state==TASK_STOPPED&&security_ops->ptrace(current,p)==0))
+(p==current||(p->parent==current&&(p->ptrace & PT_PTRACED)&&p->state==TASK_STOPPED&&security_ptrace(current,p)==0))
 
 
 static int mem_open(struct inode* inode, struct file* file)
diff -Nru a/fs/quota.c b/fs/quota.c
--- a/fs/quota.c	Thu Oct 17 14:19:00 2002
+++ b/fs/quota.c	Thu Oct 17 14:19:00 2002
@@ -98,7 +98,7 @@
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
-	return security_ops->quotactl (cmd, type, id, sb);
+	return security_quotactl (cmd, type, id, sb);
 }
 
 /* Resolve device pathname to superblock */
diff -Nru a/fs/read_write.c b/fs/read_write.c
--- a/fs/read_write.c	Thu Oct 17 14:19:00 2002
+++ b/fs/read_write.c	Thu Oct 17 14:19:00 2002
@@ -193,8 +193,7 @@
 
 	ret = locks_verify_area(FLOCK_VERIFY_READ, inode, file, *pos, count);
 	if (!ret) {
-		ret = security_ops->file_permission (file, MAY_READ);
-		if (!ret) {
+		if (!(ret = security_file_permission (file, MAY_READ))) {
 			if (file->f_op->read)
 				ret = file->f_op->read(file, buf, count, pos);
 			else
@@ -233,8 +232,7 @@
 
 	ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file, *pos, count);
 	if (!ret) {
-		ret = security_ops->file_permission (file, MAY_WRITE);
-		if (!ret) {
+		if (!(ret = security_file_permission (file, MAY_WRITE))) {
 			if (file->f_op->write)
 				ret = file->f_op->write(file, buf, count, pos);
 			else
@@ -465,8 +463,7 @@
 		goto bad_file;
 	if (file->f_op && (file->f_mode & FMODE_READ) &&
 	    (file->f_op->readv || file->f_op->read)) {
-		ret = security_ops->file_permission (file, MAY_READ);
-		if (!ret)
+		if (!(ret = security_file_permission (file, MAY_READ)))
 			ret = do_readv_writev(READ, file, vector, nr_segs);
 	}
 	fput(file);
@@ -488,8 +485,7 @@
 		goto bad_file;
 	if (file->f_op && (file->f_mode & FMODE_WRITE) &&
 	    (file->f_op->writev || file->f_op->write)) {
-		ret = security_ops->file_permission (file, MAY_WRITE);
-		if (!ret)
+		if (!(ret = security_file_permission (file, MAY_WRITE)))
 			ret = do_readv_writev(WRITE, file, vector, nr_segs);
 	}
 	fput(file);
diff -Nru a/fs/readdir.c b/fs/readdir.c
--- a/fs/readdir.c	Thu Oct 17 14:19:00 2002
+++ b/fs/readdir.c	Thu Oct 17 14:19:00 2002
@@ -22,8 +22,7 @@
 	if (!file->f_op || !file->f_op->readdir)
 		goto out;
 
-	res = security_ops->file_permission(file, MAY_READ);
-	if (res)
+	if ((res = security_file_permission(file, MAY_READ)))
 		goto out;
 
 	down(&inode->i_sem);
diff -Nru a/fs/stat.c b/fs/stat.c
--- a/fs/stat.c	Thu Oct 17 14:19:00 2002
+++ b/fs/stat.c	Thu Oct 17 14:19:00 2002
@@ -39,8 +39,7 @@
 	struct inode *inode = dentry->d_inode;
 	int retval;
 
-	retval = security_ops->inode_getattr(mnt, dentry);
-	if (retval)
+	if ((retval = security_inode_getattr(mnt, dentry)))
 		return retval;
 
 	if (inode->i_op->getattr)
@@ -238,8 +237,7 @@
 
 		error = -EINVAL;
 		if (inode->i_op && inode->i_op->readlink) {
-			error = security_ops->inode_readlink(nd.dentry);
-			if (!error) {
+			if (!(error = security_inode_readlink(nd.dentry))) {
 				UPDATE_ATIME(inode);
 				error = inode->i_op->readlink(nd.dentry, buf, bufsiz);
 			}
diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Thu Oct 17 14:19:00 2002
+++ b/fs/super.c	Thu Oct 17 14:19:00 2002
@@ -51,7 +51,7 @@
 	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
 	if (s) {
 		memset(s, 0, sizeof(struct super_block));
-		if (security_ops->sb_alloc_security(s)) {
+		if (security_sb_alloc(s)) {
 			kfree(s);
 			s = NULL;
 			goto out;
@@ -85,7 +85,7 @@
  */
 static inline void destroy_super(struct super_block *s)
 {
-	security_ops->sb_free_security(s);
+	security_sb_free(s);
 	kfree(s);
 }
 
diff -Nru a/fs/xattr.c b/fs/xattr.c
--- a/fs/xattr.c	Thu Oct 17 14:19:00 2002
+++ b/fs/xattr.c	Thu Oct 17 14:19:00 2002
@@ -86,9 +86,7 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->setxattr) {
-		error = security_ops->inode_setxattr(d, kname, kvalue,
-				size, flags);
-		if (error)
+		if ((error = security_inode_setxattr(d, kname, kvalue, size, flags)))
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->setxattr(d, kname, kvalue, size, flags);
@@ -164,8 +162,7 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->getxattr) {
-		error = security_ops->inode_getxattr(d, kname);
-		if (error)
+		if ((error = security_inode_getxattr(d, kname)))
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
@@ -237,8 +234,7 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->listxattr) {
-		error = security_ops->inode_listxattr(d);
-		if (error)
+		if ((error = security_inode_listxattr(d)))
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->listxattr(d, klist, size);
@@ -312,8 +308,7 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->removexattr) {
-		error = security_ops->inode_removexattr(d, kname);
-		if (error)
+		if ((error = security_inode_removexattr(d, kname)))
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->removexattr(d, kname);
diff -Nru a/init/do_mounts.c b/init/do_mounts.c
--- a/init/do_mounts.c	Thu Oct 17 14:19:00 2002
+++ b/init/do_mounts.c	Thu Oct 17 14:19:00 2002
@@ -800,7 +800,7 @@
 	sys_umount("/dev", 0);
 	sys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
-	security_ops->sb_post_mountroot();
+	security_sb_post_mountroot();
 	mount_devfs_fs ();
 }
 
diff -Nru a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c	Thu Oct 17 14:19:00 2002
+++ b/mm/mmap.c	Thu Oct 17 14:19:00 2002
@@ -498,8 +498,7 @@
 		}
 	}
 
-	error = security_ops->file_mmap(file, prot, flags);
-	if (error)
+	if ((error = security_file_mmap(file, prot, flags)))
 		return error;
 		
 	/* Clear old maps */
diff -Nru a/mm/mprotect.c b/mm/mprotect.c
--- a/mm/mprotect.c	Thu Oct 17 14:19:00 2002
+++ b/mm/mprotect.c	Thu Oct 17 14:19:00 2002
@@ -262,8 +262,7 @@
 			goto out;
 		}
 
-		error = security_ops->file_mprotect(vma, prot);
-		if (error)
+		if ((error = security_file_mprotect(vma, prot)))
 			goto out;
 
 		if (vma->vm_end > end) {
diff -Nru a/net/core/scm.c b/net/core/scm.c
--- a/net/core/scm.c	Thu Oct 17 14:19:00 2002
+++ b/net/core/scm.c	Thu Oct 17 14:19:00 2002
@@ -217,8 +217,7 @@
 	for (i=0, cmfptr=(int*)CMSG_DATA(cm); i<fdmax; i++, cmfptr++)
 	{
 		int new_fd;
-		err = security_ops->file_receive(fp[i]);
-		if (err)
+		if ((err = security_file_receive(fp[i])))
 			break;
 		err = get_unused_fd();
 		if (err < 0)
