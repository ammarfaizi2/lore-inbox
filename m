Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317877AbSGWAff>; Mon, 22 Jul 2002 20:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317886AbSGWAfe>; Mon, 22 Jul 2002 20:35:34 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:6916 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317877AbSGWAex>;
	Mon, 22 Jul 2002 20:34:53 -0400
Date: Mon, 22 Jul 2002 17:38:06 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM changes for 2.5.27
Message-ID: <20020723003806.GB660@kroah.com>
References: <20020723003702.GA660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020723003702.GA660@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 24 Jun 2002 23:35:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.665   -> 1.665.1.1
#	     fs/file_table.c	1.9     -> 1.10   
#	           fs/open.c	1.26    -> 1.27   
#	           mm/mmap.c	1.35    -> 1.36   
#	      fs/proc/base.c	1.26    -> 1.27   
#	          fs/fcntl.c	1.11    -> 1.12   
#	          fs/dquot.c	1.43    -> 1.44   
#	           fs/attr.c	1.9     -> 1.10   
#	include/linux/security.h	1.1     -> 1.2    
#	           fs/stat.c	1.12    -> 1.13   
#	          fs/ioctl.c	1.4     -> 1.5    
#	    security/dummy.c	1.1     -> 1.1.1.1
#	  include/linux/fs.h	1.145   -> 1.145.1.1
#	        fs/dnotify.c	1.4     -> 1.5    
#	        mm/filemap.c	1.113   -> 1.114  
#	          fs/namei.c	1.50    -> 1.50.2.1
#	security/capability.c	1.1     -> 1.1.1.1
#	    init/do_mounts.c	1.19    -> 1.20   
#	      net/core/scm.c	1.2     -> 1.3    
#	       mm/mprotect.c	1.11    -> 1.12   
#	          fs/xattr.c	1.6     -> 1.7    
#	          fs/super.c	1.79    -> 1.80   
#	        fs/readdir.c	1.8     -> 1.9    
#	       kernel/acct.c	1.11    -> 1.12   
#	drivers/char/tty_io.c	1.28    -> 1.28.1.1
#	     fs/read_write.c	1.9     -> 1.10   
#	      fs/namespace.c	1.26    -> 1.27   
#	          fs/locks.c	1.20    -> 1.21   
#	          fs/quota.c	1.7     -> 1.8    
#	          fs/inode.c	1.66    -> 1.67   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/22	sds@tislabs.com	1.665.1.1
# [PATCH] LSM: file related LSM hooks
# 
# The below patch adds the filesystem-related LSM hooks, specifically the
# super_block, inode, and file hooks, to the 2.5.27 kernel.
# --------------------------------------------
#
diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Mon Jul 22 17:25:51 2002
+++ b/drivers/char/tty_io.c	Mon Jul 22 17:25:51 2002
@@ -1458,6 +1458,10 @@
 		if (!waitqueue_active(&tty->read_wait))
 			tty->minimum_to_wake = 1;
 		if (filp->f_owner.pid == 0) {
+			retval = security_ops->file_set_fowner(filp);
+			if (retval)
+				return retval;
+
 			filp->f_owner.pid = (-tty->pgrp) ? : current->pid;
 			filp->f_owner.uid = current->uid;
 			filp->f_owner.euid = current->euid;
diff -Nru a/fs/attr.c b/fs/attr.c
--- a/fs/attr.c	Mon Jul 22 17:25:51 2002
+++ b/fs/attr.c	Mon Jul 22 17:25:51 2002
@@ -12,6 +12,7 @@
 #include <linux/dnotify.h>
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
+#include <linux/security.h>
 
 /* Taken over from the old code... */
 
@@ -151,10 +152,14 @@
 		}
 	}
 
-	if (inode->i_op && inode->i_op->setattr) 
-		error = inode->i_op->setattr(dentry, attr);
-	else {
+	if (inode->i_op && inode->i_op->setattr) {
+		error = security_ops->inode_setattr(dentry, attr);
+		if (!error)
+			error = inode->i_op->setattr(dentry, attr);
+	} else {
 		error = inode_change_ok(inode, attr);
+		if (!error)
+			error = security_ops->inode_setattr(dentry, attr);
 		if (!error) {
 			if ((ia_valid & ATTR_UID && attr->ia_uid != inode->i_uid) ||
 			    (ia_valid & ATTR_GID && attr->ia_gid != inode->i_gid))
diff -Nru a/fs/dnotify.c b/fs/dnotify.c
--- a/fs/dnotify.c	Mon Jul 22 17:25:51 2002
+++ b/fs/dnotify.c	Mon Jul 22 17:25:51 2002
@@ -68,6 +68,7 @@
 	struct dnotify_struct **prev;
 	struct inode *inode;
 	fl_owner_t id = current->files;
+	int error;
 
 	if ((arg & ~DN_MULTISHOT) == 0) {
 		dnotify_flush(filp, id);
@@ -93,6 +94,13 @@
 		}
 		prev = &odn->dn_next;
 	}
+
+	error = security_ops->file_set_fowner(filp);
+	if (error) {
+		write_unlock(&dn_lock);
+		return error;
+	}
+
 	filp->f_owner.pid = current->pid;
 	filp->f_owner.uid = current->uid;
 	filp->f_owner.euid = current->euid;
diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Mon Jul 22 17:25:51 2002
+++ b/fs/dquot.c	Mon Jul 22 17:25:51 2002
@@ -1316,6 +1316,9 @@
 	error = -EIO;
 	if (!f->f_op || !f->f_op->read || !f->f_op->write)
 		goto out_f;
+	error = security_ops->quota_on(f);
+	if (error)
+		goto out_f;
 	inode = f->f_dentry->d_inode;
 	error = -EACCES;
 	if (!S_ISREG(inode->i_mode))
diff -Nru a/fs/fcntl.c b/fs/fcntl.c
--- a/fs/fcntl.c	Mon Jul 22 17:25:51 2002
+++ b/fs/fcntl.c	Mon Jul 22 17:25:51 2002
@@ -11,6 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/iobuf.h>
+#include <linux/security.h>
 
 #include <asm/poll.h>
 #include <asm/siginfo.h>
@@ -305,6 +306,13 @@
 			break;
 		case F_SETOWN:
 			lock_kernel();
+
+			err = security_ops->file_set_fowner(filp);
+			if (err) {
+				unlock_kernel();
+				break;
+			}
+
 			filp->f_owner.pid = arg;
 			filp->f_owner.uid = current->uid;
 			filp->f_owner.euid = current->euid;
@@ -353,6 +361,12 @@
 	if (!filp)
 		goto out;
 
+	err = security_ops->file_fcntl(filp, cmd, arg);
+	if (err) {
+		fput(filp);
+		return err;
+	}
+
 	err = do_fcntl(fd, cmd, arg, filp);
 
  	fput(filp);
@@ -371,6 +385,13 @@
 	if (!filp)
 		goto out;
 
+	err = security_ops->file_fcntl(filp, cmd, arg);
+	if (err) {
+		fput(filp);
+		return err;
+	}
+	err = -EBADF;
+	
 	switch (cmd) {
 		case F_GETLK64:
 			err = fcntl_getlk64(filp, (struct flock64 *) arg);
@@ -409,6 +430,10 @@
 	    (fown->euid ^ p->suid) && (fown->euid ^ p->uid) &&
 	    (fown->uid ^ p->suid) && (fown->uid ^ p->uid))
 		return;
+
+	if (security_ops->file_send_sigiotask(p, fown, fd, reason))
+		return;
+
 	switch (fown->signum) {
 		siginfo_t si;
 		default:
diff -Nru a/fs/file_table.c b/fs/file_table.c
--- a/fs/file_table.c	Mon Jul 22 17:25:51 2002
+++ b/fs/file_table.c	Mon Jul 22 17:25:51 2002
@@ -13,6 +13,7 @@
 #include <linux/smp_lock.h>
 #include <linux/iobuf.h>
 #include <linux/fs.h>
+#include <linux/security.h>
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {0, 0, NR_FILE};
@@ -43,6 +44,12 @@
 		files_stat.nr_free_files--;
 	new_one:
 		memset(f, 0, sizeof(*f));
+		if (security_ops->file_alloc_security(f)) {
+			list_add(&f->f_list, &free_list);
+			files_stat.nr_free_files++;
+			file_list_unlock();
+			return NULL;
+		}
 		atomic_set(&f->f_count,1);
 		f->f_version = ++event;
 		f->f_uid = current->fsuid;
@@ -117,6 +124,7 @@
 
 	if (file->f_op && file->f_op->release)
 		file->f_op->release(inode, file);
+	security_ops->file_free_security(file);
 	fops_put(file->f_op);
 	if (file->f_mode & FMODE_WRITE)
 		put_write_access(inode);
@@ -149,6 +157,7 @@
 void put_filp(struct file *file)
 {
 	if(atomic_dec_and_test(&file->f_count)) {
+		security_ops->file_free_security(file);
 		file_list_lock();
 		list_del(&file->f_list);
 		list_add(&file->f_list, &free_list);
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Mon Jul 22 17:25:51 2002
+++ b/fs/inode.c	Mon Jul 22 17:25:51 2002
@@ -16,6 +16,7 @@
 #include <linux/backing-dev.h>
 #include <linux/wait.h>
 #include <linux/hash.h>
+#include <linux/security.h>
 
 /*
  * This is needed for the following functions:
@@ -100,6 +101,14 @@
 	if (inode) {
 		struct address_space * const mapping = &inode->i_data;
 
+		inode->i_security = NULL;
+		if (security_ops->inode_alloc_security(inode)) {
+			if (inode->i_sb->s_op->destroy_inode)
+				inode->i_sb->s_op->destroy_inode(inode);
+			else
+				kmem_cache_free(inode_cachep, (inode));
+			return NULL;
+		}
 		inode->i_sb = sb;
 		inode->i_dev = sb->s_dev;
 		inode->i_blkbits = sb->s_blocksize_bits;
@@ -137,6 +146,7 @@
 {
 	if (inode_has_buffers(inode))
 		BUG();
+	security_ops->inode_free_security(inode);
 	if (inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
 	else
@@ -792,6 +802,8 @@
 
 	if (inode->i_data.nrpages)
 		truncate_inode_pages(&inode->i_data, 0);
+
+	security_ops->inode_delete(inode);
 
 	if (op && op->delete_inode) {
 		void (*delete)(struct inode *) = op->delete_inode;
diff -Nru a/fs/ioctl.c b/fs/ioctl.c
--- a/fs/ioctl.c	Mon Jul 22 17:25:51 2002
+++ b/fs/ioctl.c	Mon Jul 22 17:25:51 2002
@@ -8,6 +8,7 @@
 #include <linux/smp_lock.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -57,6 +58,13 @@
 	if (!filp)
 		goto out;
 	error = 0;
+
+	error = security_ops->file_ioctl(filp, cmd, arg);
+        if (error) {
+                fput(filp);
+                goto out;
+        }
+
 	lock_kernel();
 	switch (cmd) {
 		case FIOCLEX:
diff -Nru a/fs/locks.c b/fs/locks.c
--- a/fs/locks.c	Mon Jul 22 17:25:51 2002
+++ b/fs/locks.c	Mon Jul 22 17:25:51 2002
@@ -1309,6 +1309,11 @@
 	fl->fl_next = *before;
 	*before = fl;
 	list_add(&fl->fl_link, &file_lock_list);
+
+	error = security_ops->file_set_fowner(filp);
+	if (error)
+		goto out_unlock;
+
 	filp->f_owner.pid = current->pid;
 	filp->f_owner.uid = current->uid;
 	filp->f_owner.euid = current->euid;
@@ -1354,6 +1359,11 @@
 	if (error < 0)
 		goto out_putf;
 
+	error = security_ops->file_lock(filp, cmd,
+					(cmd & LOCK_NB) ? 0 : 1);
+	if (error)
+		goto out_putf;
+
 	error = flock_lock_file(filp, lock,
 				(cmd & (LOCK_UN | LOCK_NB)) ? 0 : 1);
 
@@ -1484,6 +1494,11 @@
 		goto out;
 	}
 
+	error = security_ops->file_lock(filp, file_lock->fl_type,
+	                                cmd == F_SETLKW);
+	if (error)
+		goto out;
+
 	if (filp->f_op && filp->f_op->lock != NULL) {
 		error = filp->f_op->lock(filp, cmd, file_lock);
 		if (error < 0)
@@ -1602,6 +1617,11 @@
 		error = -EINVAL;
 		goto out;
 	}
+
+	error = security_ops->file_lock(filp, file_lock->fl_type,
+					cmd == F_SETLKW64);
+	if (error)
+		goto out;
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
 		error = filp->f_op->lock(filp, cmd, file_lock);
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Mon Jul 22 17:25:51 2002
+++ b/fs/namei.c	Mon Jul 22 17:25:51 2002
@@ -23,6 +23,7 @@
 #include <linux/dnotify.h>
 #include <linux/smp_lock.h>
 #include <linux/personality.h>
+#include <linux/security.h>
 
 #include <asm/namei.h>
 #include <asm/uaccess.h>
@@ -204,9 +205,20 @@
 
 int permission(struct inode * inode,int mask)
 {
+	int retval;
+	int submask;
+
+	/* Ordinary permission routines do not understand MAY_APPEND. */
+	submask = mask & ~MAY_APPEND;
+
 	if (inode->i_op && inode->i_op->permission)
-		return inode->i_op->permission(inode, mask);
-	return vfs_permission(inode, mask);
+		retval = inode->i_op->permission(inode, submask);
+	else
+		retval = vfs_permission(inode, submask);
+	if (retval)
+		return retval;
+
+	return security_ops->inode_permission(inode, mask);
 }
 
 /*
@@ -318,15 +330,17 @@
 		mode >>= 3;
 
 	if (mode & MAY_EXEC)
-		return 0;
+		goto ok;
 
 	if ((inode->i_mode & S_IXUGO) && capable(CAP_DAC_OVERRIDE))
-		return 0;
+		goto ok;
 
 	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
-		return 0;
+		goto ok;
 
 	return -EACCES;
+ok:
+	return security_ops->inode_permission_lite(inode, MAY_EXEC);
 }
 
 /*
@@ -358,8 +372,10 @@
 			result = dir->i_op->lookup(dir, dentry);
 			if (result)
 				dput(dentry);
-			else
+			else {
 				result = dentry;
+				security_ops->inode_post_lookup(dir, result);
+			}
 		}
 		up(&dir->i_sem);
 		return result;
@@ -388,7 +404,7 @@
  */
 static inline int do_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	int err;
+	int err = -ELOOP;
 	if (current->link_count >= 5)
 		goto loop;
 	if (current->total_link_count >= 40)
@@ -397,6 +413,9 @@
 		current->state = TASK_RUNNING;
 		schedule();
 	}
+	err = security_ops->inode_follow_link(dentry, nd);
+	if (err)
+		goto loop;
 	current->link_count++;
 	current->total_link_count++;
 	UPDATE_ATIME(dentry->d_inode);
@@ -405,7 +424,7 @@
 	return err;
 loop:
 	path_release(nd);
-	return -ELOOP;
+	return err;
 }
 
 int follow_up(struct vfsmount **mnt, struct dentry **dentry)
@@ -897,9 +916,10 @@
 		if (!new)
 			goto out;
 		dentry = inode->i_op->lookup(inode, new);
-		if (!dentry)
+		if (!dentry) {
 			dentry = new;
-		else
+			security_ops->inode_post_lookup(inode, dentry);
+		} else
 			dput(new);
 	}
 out:
@@ -1103,14 +1123,17 @@
 
 	if (!dir->i_op || !dir->i_op->create)
 		return -EACCES;	/* shouldn't it be ENOSYS? */
-
-	DQUOT_INIT(dir);
-
 	mode &= S_IALLUGO;
 	mode |= S_IFREG;
+	error = security_ops->inode_create(dir, dentry, mode);
+	if (error)
+		return error;
+	DQUOT_INIT(dir);
 	error = dir->i_op->create(dir, dentry, mode);
-	if (!error)
+	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		security_ops->inode_post_create(dir, dentry, mode);
+	}
 	return error;
 }
 
@@ -1211,6 +1234,11 @@
 
 	acc_mode = ACC_MODE(flag);
 
+	/* Allow the LSM permission hook to distinguish append 
+	   access from general write access. */
+	if (flag & O_APPEND)
+		acc_mode |= MAY_APPEND;
+
 	/*
 	 * The simplest case - just a plain lookup.
 	 */
@@ -1316,6 +1344,9 @@
 	 * stored in nd->last.name and we will have to putname() it when we
 	 * are done. Procfs-like symlinks just set LAST_BIND.
 	 */
+	error = security_ops->inode_follow_link(dentry, nd);
+	if (error)
+		goto exit_dput;
 	UPDATE_ATIME(dentry->d_inode);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
 	dput(dentry);
@@ -1379,10 +1410,16 @@
 	if (!dir->i_op || !dir->i_op->mknod)
 		return -EPERM;
 
+	error = security_ops->inode_mknod(dir, dentry, mode, dev);
+	if (error)
+		return error;
+
 	DQUOT_INIT(dir);
 	error = dir->i_op->mknod(dir, dentry, mode, dev);
-	if (!error)
+	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		security_ops->inode_post_mknod(dir, dentry, mode, dev);
+	}
 	return error;
 }
 
@@ -1440,11 +1477,17 @@
 	if (!dir->i_op || !dir->i_op->mkdir)
 		return -EPERM;
 
-	DQUOT_INIT(dir);
 	mode &= (S_IRWXUGO|S_ISVTX);
+	error = security_ops->inode_mkdir(dir, dentry, mode);
+	if (error)
+		return error;
+
+	DQUOT_INIT(dir);
 	error = dir->i_op->mkdir(dir, dentry, mode);
-	if (!error)
+	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		security_ops->inode_post_mkdir(dir,dentry, mode);
+	}
 	return error;
 }
 
@@ -1523,9 +1566,12 @@
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
-		error = dir->i_op->rmdir(dir, dentry);
-		if (!error)
-			dentry->d_inode->i_flags |= S_DEAD;
+		error = security_ops->inode_rmdir(dir, dentry);
+		if (!error) {
+			error = dir->i_op->rmdir(dir, dentry);
+			if (!error)
+				dentry->d_inode->i_flags |= S_DEAD;
+		}
 	}
 	up(&dentry->d_inode->i_sem);
 	if (!error) {
@@ -1595,9 +1641,12 @@
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
-		error = dir->i_op->unlink(dir, dentry);
-		if (!error)
-			d_delete(dentry);
+		error = security_ops->inode_unlink(dir, dentry);
+		if (!error) {
+			error = dir->i_op->unlink(dir, dentry);
+			if (!error)
+				d_delete(dentry);
+		}
 	}
 	up(&dentry->d_inode->i_sem);
 	dput(dentry);
@@ -1660,10 +1709,16 @@
 	if (!dir->i_op || !dir->i_op->symlink)
 		return -EPERM;
 
+	error = security_ops->inode_symlink(dir, dentry, oldname);
+	if (error)
+		return error;
+
 	DQUOT_INIT(dir);
 	error = dir->i_op->symlink(dir, dentry, oldname);
-	if (!error)
+	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		security_ops->inode_post_symlink(dir, dentry, oldname);
+	}
 	return error;
 }
 
@@ -1725,12 +1780,18 @@
 	if (S_ISDIR(old_dentry->d_inode->i_mode))
 		return -EPERM;
 
+	error = security_ops->inode_link(old_dentry, dir, new_dentry);
+	if (error)
+		return error;
+
 	down(&old_dentry->d_inode->i_sem);
 	DQUOT_INIT(dir);
 	error = dir->i_op->link(old_dentry, dir, new_dentry);
 	up(&old_dentry->d_inode->i_sem);
-	if (!error)
+	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
+		security_ops->inode_post_link(old_dentry, dir, new_dentry);
+	}
 	return error;
 }
 
@@ -1822,9 +1883,13 @@
 	 * If we are going to change the parent - check write permissions,
 	 * we'll need to flip '..'.
 	 */
-	if (new_dir != old_dir)
+	if (new_dir != old_dir) {
 		error = permission(old_dentry->d_inode, MAY_WRITE);
+		if (error)
+			return error;
+	}
 
+	error = security_ops->inode_rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (error)
 		return error;
 
@@ -1845,8 +1910,11 @@
 			d_rehash(new_dentry);
 		dput(new_dentry);
 	}
-	if (!error)
+	if (!error) {
 		d_move(old_dentry,new_dentry);
+		security_ops->inode_post_rename(old_dir, old_dentry,
+							new_dir, new_dentry);
+	}
 	return error;
 }
 
@@ -1856,6 +1924,10 @@
 	struct inode *target;
 	int error;
 
+	error = security_ops->inode_rename(old_dir, old_dentry, new_dir, new_dentry);
+	if (error)
+		return error;
+
 	dget(new_dentry);
 	target = new_dentry->d_inode;
 	if (target)
@@ -1868,6 +1940,7 @@
 		/* The following d_move() should become unconditional */
 		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
 			d_move(old_dentry, new_dentry);
+		security_ops->inode_post_rename(old_dir, old_dentry, new_dir, new_dentry);
 	}
 	if (target)
 		up(&target->i_sem);
diff -Nru a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Mon Jul 22 17:25:51 2002
+++ b/fs/namespace.c	Mon Jul 22 17:25:51 2002
@@ -288,6 +288,10 @@
 	struct super_block * sb = mnt->mnt_sb;
 	int retval = 0;
 
+	retval = security_ops->sb_umount(mnt, flags);
+	if (retval)
+		return retval;
+
 	/*
 	 * If we may have to abort operations to get out of this
 	 * mount, and they will themselves hold resources we must
@@ -337,6 +341,7 @@
 		DQUOT_OFF(sb);
 		acct_auto_close(sb);
 		unlock_kernel();
+		security_ops->sb_umount_close(mnt);
 		spin_lock(&dcache_lock);
 	}
 	retval = -EBUSY;
@@ -346,6 +351,8 @@
 		retval = 0;
 	}
 	spin_unlock(&dcache_lock);
+	if (retval)
+		security_ops->sb_umount_busy(mnt);
 	up_write(&current->namespace->sem);
 	return retval;
 }
@@ -463,6 +470,10 @@
 	if (IS_DEADDIR(nd->dentry->d_inode))
 		goto out_unlock;
 
+	err = security_ops->sb_check_sb(mnt, nd);
+	if (err)
+		goto out_unlock;
+
 	spin_lock(&dcache_lock);
 	if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry)) {
 		struct list_head head;
@@ -475,6 +486,8 @@
 	spin_unlock(&dcache_lock);
 out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
+	if (!err)
+		security_ops->sb_post_addmount(mnt, nd);
 	return err;
 }
 
@@ -544,6 +557,8 @@
 	if (!err)
 		nd->mnt->mnt_flags=mnt_flags;
 	up_write(&sb->s_umount);
+	if (!err)
+		security_ops->sb_post_remount(nd->mnt, flags, data);
 	return err;
 }
 
@@ -726,6 +741,10 @@
 	if (retval)
 		return retval;
 
+	retval = security_ops->sb_mount(dev_name, &nd, type_page, flags, data_page);
+	if (retval)
+		goto dput_out;
+
 	if (flags & MS_REMOUNT)
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
@@ -736,6 +755,7 @@
 	else
 		retval = do_add_mount(&nd, type_page, flags, mnt_flags,
 				      dev_name, data_page);
+dput_out:
 	path_release(&nd);
 	return retval;
 }
@@ -919,6 +939,12 @@
 	if (error)
 		goto out1;
 
+	error = security_ops->sb_pivotroot(&old_nd, &new_nd);
+	if (error) {
+		path_release(&old_nd);
+		goto out1;
+	}
+
 	read_lock(&current->fs->lock);
 	user_nd.mnt = mntget(current->fs->rootmnt);
 	user_nd.dentry = dget(current->fs->root);
@@ -963,6 +989,7 @@
 	attach_mnt(new_nd.mnt, &root_parent);
 	spin_unlock(&dcache_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
+	security_ops->sb_post_pivotroot(&user_nd, &new_nd);
 	error = 0;
 	path_release(&root_parent);
 	path_release(&parent_nd);
diff -Nru a/fs/open.c b/fs/open.c
--- a/fs/open.c	Mon Jul 22 17:25:51 2002
+++ b/fs/open.c	Mon Jul 22 17:25:51 2002
@@ -17,6 +17,7 @@
 #include <linux/iobuf.h>
 #include <linux/namei.h>
 #include <linux/backing-dev.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
@@ -30,6 +31,9 @@
 		retval = -ENOSYS;
 		if (sb->s_op && sb->s_op->statfs) {
 			memset(buf, 0, sizeof(struct statfs));
+			retval = security_ops->sb_statfs(sb);
+			if (retval)
+				return retval;
 			retval = sb->s_op->statfs(sb, buf);
 		}
 	}
diff -Nru a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c	Mon Jul 22 17:25:51 2002
+++ b/fs/proc/base.c	Mon Jul 22 17:25:51 2002
@@ -406,7 +406,7 @@
 };
 
 #define MAY_PTRACE(p) \
-(p==current||(p->parent==current&&(p->ptrace & PT_PTRACED)&&p->state==TASK_STOPPED))
+(p==current||(p->parent==current&&(p->ptrace & PT_PTRACED)&&p->state==TASK_STOPPED&&security_ops->ptrace(current,p)==0))
 
 
 static int mem_open(struct inode* inode, struct file* file)
diff -Nru a/fs/quota.c b/fs/quota.c
--- a/fs/quota.c	Mon Jul 22 17:25:51 2002
+++ b/fs/quota.c	Mon Jul 22 17:25:51 2002
@@ -12,6 +12,7 @@
 #include <asm/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/security.h>
 
 /* Check validity of quotactl */
 static int check_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)
@@ -96,7 +97,8 @@
 	else if (cmd != Q_GETFMT && cmd != Q_SYNC && cmd != Q_GETINFO && cmd != Q_XGETQSTAT)
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-	return 0;
+
+	return security_ops->quotactl (cmd, type, id, sb);
 }
 
 /* Resolve device pathname to superblock */
diff -Nru a/fs/read_write.c b/fs/read_write.c
--- a/fs/read_write.c	Mon Jul 22 17:25:51 2002
+++ b/fs/read_write.c	Mon Jul 22 17:25:51 2002
@@ -11,6 +11,7 @@
 #include <linux/uio.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
@@ -117,6 +118,13 @@
 	file = fget(fd);
 	if (!file)
 		goto bad;
+
+	retval = security_ops->file_llseek(file);
+	if (retval) {
+		fput(file);
+		goto bad;
+	}
+
 	retval = -EINVAL;
 	if (origin <= 2) {
 		loff_t res = llseek(file, offset, origin);
@@ -142,6 +150,11 @@
 	file = fget(fd);
 	if (!file)
 		goto bad;
+
+	retval = security_ops->file_llseek(file);
+	if (retval)
+		goto out_putf;
+
 	retval = -EINVAL;
 	if (origin > 2)
 		goto out_putf;
@@ -176,9 +189,12 @@
 
 	ret = locks_verify_area(FLOCK_VERIFY_READ, inode, file, *pos, count);
 	if (!ret) {
-		ret = file->f_op->read(file, buf, count, pos);
-		if (ret > 0)
-			dnotify_parent(file->f_dentry, DN_ACCESS);
+		ret = security_ops->file_permission (file, MAY_READ);
+		if (!ret) {
+			ret = file->f_op->read(file, buf, count, pos);
+			if (ret > 0)
+				dnotify_parent(file->f_dentry, DN_ACCESS);
+		}
 	}
 
 	return ret;
@@ -198,9 +214,12 @@
 
 	ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file, *pos, count);
 	if (!ret) {
-		ret = file->f_op->write(file, buf, count, pos);
-		if (ret > 0)
-			dnotify_parent(file->f_dentry, DN_MODIFY);
+		ret = security_ops->file_permission (file, MAY_WRITE);
+		if (!ret) {
+			ret = file->f_op->write(file, buf, count, pos);
+			if (ret > 0)
+				dnotify_parent(file->f_dentry, DN_MODIFY);
+		}
 	}
 
 	return ret;
@@ -378,8 +397,11 @@
 	if (!file)
 		goto bad_file;
 	if (file->f_op && (file->f_mode & FMODE_READ) &&
-	    (file->f_op->readv || file->f_op->read))
-		ret = do_readv_writev(VERIFY_WRITE, file, vector, count);
+	    (file->f_op->readv || file->f_op->read)) {
+		ret = security_ops->file_permission (file, MAY_READ);
+		if (!ret)
+			ret = do_readv_writev(VERIFY_WRITE, file, vector, count);
+	}
 	fput(file);
 
 bad_file:
@@ -398,8 +420,11 @@
 	if (!file)
 		goto bad_file;
 	if (file->f_op && (file->f_mode & FMODE_WRITE) &&
-	    (file->f_op->writev || file->f_op->write))
-		ret = do_readv_writev(VERIFY_READ, file, vector, count);
+	    (file->f_op->writev || file->f_op->write)) {
+		ret = security_ops->file_permission (file, MAY_WRITE);
+		if (!ret)
+			ret = do_readv_writev(VERIFY_READ, file, vector, count);
+	}
 	fput(file);
 
 bad_file:
diff -Nru a/fs/readdir.c b/fs/readdir.c
--- a/fs/readdir.c	Mon Jul 22 17:25:51 2002
+++ b/fs/readdir.c	Mon Jul 22 17:25:51 2002
@@ -20,6 +20,11 @@
 	int res = -ENOTDIR;
 	if (!file->f_op || !file->f_op->readdir)
 		goto out;
+
+	res = security_ops->file_permission(file, MAY_READ);
+	if (res)
+		goto out;
+
 	down(&inode->i_sem);
 	res = -ENOENT;
 	if (!IS_DEADDIR(inode)) {
diff -Nru a/fs/stat.c b/fs/stat.c
--- a/fs/stat.c	Mon Jul 22 17:25:51 2002
+++ b/fs/stat.c	Mon Jul 22 17:25:51 2002
@@ -12,6 +12,7 @@
 #include <linux/highuid.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
@@ -36,6 +37,11 @@
 int vfs_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
 {
 	struct inode *inode = dentry->d_inode;
+	int retval;
+
+	retval = security_ops->inode_getattr(mnt, dentry);
+	if (retval)
+		return retval;
 
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(mnt, dentry, stat);
@@ -232,8 +238,11 @@
 
 		error = -EINVAL;
 		if (inode->i_op && inode->i_op->readlink) {
-			UPDATE_ATIME(inode);
-			error = inode->i_op->readlink(nd.dentry, buf, bufsiz);
+			error = security_ops->inode_readlink(nd.dentry);
+			if (!error) {
+				UPDATE_ATIME(inode);
+				error = inode->i_op->readlink(nd.dentry, buf, bufsiz);
+			}
 		}
 		path_release(&nd);
 	}
diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Mon Jul 22 17:25:51 2002
+++ b/fs/super.c	Mon Jul 22 17:25:51 2002
@@ -31,6 +31,8 @@
 #include <linux/buffer_head.h>		/* for fsync_super() */
 #include <asm/uaccess.h>
 
+#include <linux/security.h>
+
 void get_filesystem(struct file_system_type *fs);
 void put_filesystem(struct file_system_type *fs);
 struct file_system_type *get_fs_type(const char *name);
@@ -49,6 +51,11 @@
 	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
 	if (s) {
 		memset(s, 0, sizeof(struct super_block));
+		if (security_ops->sb_alloc_security(s)) {
+			kfree(s);
+			s = NULL;
+			goto out;
+		}
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_io);
 		INIT_LIST_HEAD(&s->s_locked_inodes);
@@ -67,6 +74,7 @@
 		s->dq_op = sb_dquot_ops;
 		s->s_qcop = sb_quotactl_ops;
 	}
+out:
 	return s;
 }
 
@@ -78,6 +86,7 @@
  */
 static inline void destroy_super(struct super_block *s)
 {
+	security_ops->sb_free_security(s);
 	kfree(s);
 }
 
diff -Nru a/fs/xattr.c b/fs/xattr.c
--- a/fs/xattr.c	Mon Jul 22 17:25:51 2002
+++ b/fs/xattr.c	Mon Jul 22 17:25:51 2002
@@ -85,11 +85,16 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->setxattr) {
+		error = security_ops->inode_setxattr(d, kname, kvalue,
+				size, flags);
+		if (error)
+			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->setxattr(d, kname, kvalue, size, flags);
 		up(&d->d_inode->i_sem);
 	}
 
+out:
 	xattr_free(kvalue, size);
 	return error;
 }
@@ -158,6 +163,9 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->getxattr) {
+		error = security_ops->inode_getxattr(d, kname);
+		if (error)
+			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
 		up(&d->d_inode->i_sem);
@@ -166,6 +174,7 @@
 	if (kvalue && error > 0)
 		if (copy_to_user(value, kvalue, error))
 			error = -EFAULT;
+out:
 	xattr_free(kvalue, size);
 	return error;
 }
@@ -227,6 +236,9 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->listxattr) {
+		error = security_ops->inode_listxattr(d);
+		if (error)
+			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->listxattr(d, klist, size);
 		up(&d->d_inode->i_sem);
@@ -235,6 +247,7 @@
 	if (klist && error > 0)
 		if (copy_to_user(list, klist, error))
 			error = -EFAULT;
+out:
 	xattr_free(klist, size);
 	return error;
 }
@@ -298,10 +311,14 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->removexattr) {
+		error = security_ops->inode_removexattr(d, kname);
+		if (error)
+			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->removexattr(d, kname);
 		up(&d->d_inode->i_sem);
 	}
+out:
 	return error;
 }
 
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Mon Jul 22 17:25:51 2002
+++ b/include/linux/fs.h	Mon Jul 22 17:25:51 2002
@@ -72,6 +72,7 @@
 #define MAY_EXEC 1
 #define MAY_WRITE 2
 #define MAY_READ 4
+#define MAY_APPEND 8
 
 #define FMODE_READ 1
 #define FMODE_WRITE 2
@@ -396,6 +397,7 @@
 	unsigned char		i_sock;
 
 	atomic_t		i_writecount;
+	void			*i_security;
 	__u32			i_generation;
 	union {
 		void				*generic_ip;
@@ -426,6 +428,7 @@
 	int pid;		/* pid or -pgrp where SIGIO should be sent */
 	uid_t uid, euid;	/* uid/euid of process setting the owner */
 	int signum;		/* posix.1b rt signal to be delivered on IO */
+	void *security;
 };
 
 static inline void inode_add_bytes(struct inode *inode, loff_t bytes)
@@ -489,6 +492,7 @@
 	struct file_ra_state	f_ra;
 
 	unsigned long		f_version;
+	void			*f_security;
 
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
@@ -642,6 +646,7 @@
 	int			s_count;
 	int			s_syncing;
 	atomic_t		s_active;
+	void                    *s_security;
 
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_io;		/* parked for writeback */
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Mon Jul 22 17:25:51 2002
+++ b/include/linux/security.h	Mon Jul 22 17:25:51 2002
@@ -103,6 +103,345 @@
  * 	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
  *
+ * Security hooks for filesystem operations.
+ *
+ * @sb_alloc_security:
+ *	Allocate and attach a security structure to the sb->s_security field.
+ *	The s_security field is initialized to NULL when the structure is
+ *	allocated.
+ *	@sb contains the super_block structure to be modified.
+ *	Return 0 if operation was successful.
+ * @sb_free_security:
+ *	Deallocate and clear the sb->s_security field.
+ *	@sb contains the super_block structure to be modified.
+ * @sb_statfs:
+ *	Check permission before obtaining filesystem statistics for the @sb
+ *	filesystem.
+ *	@sb contains the super_block structure for the filesystem.
+ *	Return 0 if permission is granted.  
+ * @sb_mount:
+ *	Check permission before an object specified by @dev_name is mounted on
+ *	the mount point named by @nd.  For an ordinary mount, @dev_name
+ *	identifies a device if the file system type requires a device.  For a
+ *	remount (@flags & MS_REMOUNT), @dev_name is irrelevant.  For a
+ *	loopback/bind mount (@flags & MS_BIND), @dev_name identifies the
+ *	pathname of the object being mounted.
+ *	@dev_name contains the name for object being mounted.
+ *	@nd contains the nameidata structure for mount point object.
+ *	@type contains the filesystem type.
+ *	@flags contains the mount flags.
+ *	@data contains the filesystem-specific data.
+ *	Return 0 if permission is granted.
+ * @sb_check_sb:
+ *	Check permission before the device with superblock @mnt->sb is mounted
+ *	on the mount point named by @nd.
+ *	@mnt contains the vfsmount for device being mounted.
+ *	@nd contains the nameidata object for the mount point.
+ *	Return 0 if permission is granted.
+ * @sb_umount:
+ *	Check permission before the @mnt file system is unmounted.
+ *	@mnt contains the mounted file system.
+ *	@flags contains the unmount flags, e.g. MNT_FORCE.
+ *	Return 0 if permission is granted.
+ * @sb_umount_close:
+ *	Close any files in the @mnt mounted filesystem that are held open by
+ *	the security module.  This hook is called during an umount operation
+ *	prior to checking whether the filesystem is still busy.
+ *	@mnt contains the mounted filesystem.
+ * @sb_umount_busy:
+ *	Handle a failed umount of the @mnt mounted filesystem, e.g.  re-opening
+ *	any files that were closed by umount_close.  This hook is called during
+ *	an umount operation if the umount fails after a call to the
+ *	umount_close hook.
+ *	@mnt contains the mounted filesystem.
+ * @sb_post_remount:
+ *	Update the security module's state when a filesystem is remounted.
+ *	This hook is only called if the remount was successful.
+ *	@mnt contains the mounted file system.
+ *	@flags contains the new filesystem flags.
+ *	@data contains the filesystem-specific data.
+ * @sb_post_mountroot:
+ *	Update the security module's state when the root filesystem is mounted.
+ *	This hook is only called if the mount was successful.
+ * @sb_post_addmount:
+ *	Update the security module's state when a filesystem is mounted.
+ *	This hook is called any time a mount is successfully grafetd to
+ *	the tree.
+ *	@mnt contains the mounted filesystem.
+ *	@mountpoint_nd contains the nameidata structure for the mount point.
+ * @sb_pivotroot:
+ *	Check permission before pivoting the root filesystem.
+ *	@old_nd contains the nameidata structure for the new location of the current root (put_old).
+ *      @new_nd contains the nameidata structure for the new root (new_root).
+ *	Return 0 if permission is granted.
+ * @sb_post_pivotroot:
+ *	Update module state after a successful pivot.
+ *	@old_nd contains the nameidata structure for the old root.
+ *      @new_nd contains the nameidata structure for the new root.
+ *
+ * Security hooks for inode operations.
+ *
+ * @inode_alloc_security:
+ *	Allocate and attach a security structure to @inode->i_security.  The
+ *	i_security field is initialized to NULL when the inode structure is
+ *	allocated.
+ *	@inode contains the inode structure.
+ *	Return 0 if operation was successful.
+ * @inode_free_security:
+ *	@inode contains the inode structure.
+ *	Deallocate the inode security structure and set @inode->i_security to
+ *	NULL. 
+ * @inode_create:
+ *	Check permission to create a regular file.
+ *	@dir contains inode structure of the parent of the new file.
+ *	@dentry contains the dentry structure for the file to be created.
+ *	@mode contains the file mode of the file to be created.
+ *	Return 0 if permission is granted.
+ * @inode_post_create:
+ *	Set the security attributes on a newly created regular file.  This hook
+ *	is called after a file has been successfully created.
+ *	@dir contains the inode structure of the parent directory of the new file.
+ *	@dentry contains the the dentry structure for the newly created file.
+ *	@mode contains the file mode.
+ * @inode_link:
+ *	Check permission before creating a new hard link to a file.
+ *	@old_dentry contains the dentry structure for an existing link to the file.
+ *	@dir contains the inode structure of the parent directory of the new link.
+ *	@new_dentry contains the dentry structure for the new link.
+ *	Return 0 if permission is granted.
+ * @inode_post_link:
+ *	Set security attributes for a new hard link to a file.
+ *	@old_dentry contains the dentry structure for the existing link.
+ *	@dir contains the inode structure of the parent directory of the new file.
+ *	@new_dentry contains the dentry structure for the new file link.
+ * @inode_unlink:
+ *	Check the permission to remove a hard link to a file. 
+ *	@dir contains the inode structure of parent directory of the file.
+ *	@dentry contains the dentry structure for file to be unlinked.
+ *	Return 0 if permission is granted.
+ * @inode_symlink:
+ *	Check the permission to create a symbolic link to a file.
+ *	@dir contains the inode structure of parent directory of the symbolic link.
+ *	@dentry contains the dentry structure of the symbolic link.
+ *	@old_name contains the pathname of file.
+ *	Return 0 if permission is granted.
+ * @inode_post_symlink:
+ *	@dir contains the inode structure of the parent directory of the new link.
+ *	@dentry contains the dentry structure of new symbolic link.
+ *	@old_name contains the pathname of file.
+ *	Set security attributes for a newly created symbolic link.  Note that
+ *	@dentry->d_inode may be NULL, since the filesystem might not
+ *	instantiate the dentry (e.g. NFS).
+ * @inode_mkdir:
+ *	Check permissions to create a new directory in the existing directory
+ *	associated with inode strcture @dir. 
+ *	@dir containst the inode structure of parent of the directory to be created.
+ *	@dentry contains the dentry structure of new directory.
+ *	@mode contains the mode of new directory.
+ *	Return 0 if permission is granted.
+ * @inode_post_mkdir:
+ *	Set security attributes on a newly created directory.
+ *	@dir contains the inode structure of parent of the directory to be created.
+ *	@dentry contains the dentry structure of new directory.
+ *	@mode contains the mode of new directory.
+ * @inode_rmdir:
+ *	Check the permission to remove a directory.
+ *	@dir contains the inode structure of parent of the directory to be removed.
+ *	@dentry contains the dentry structure of directory to be removed.
+ *	Return 0 if permission is granted.
+ * @inode_mknod:
+ *	Check permissions when creating a special file (or a socket or a fifo
+ *	file created via the mknod system call).  Note that if mknod operation
+ *	is being done for a regular file, then the create hook will be called
+ *	and not this hook.
+ *	@dir contains the inode structure of parent of the new file.
+ *	@dentry contains the dentry structure of the new file.
+ *	@mode contains the mode of the new file.
+ *	@dev contains the the device number.
+ *	Return 0 if permission is granted.
+ * @inode_post_mknod:
+ *	Set security attributes on a newly created special file (or socket or
+ *	fifo file created via the mknod system call).
+ *	@dir contains the inode structure of parent of the new node.
+ *	@dentry contains the dentry structure of the new node.
+ *	@mode contains the mode of the new node.
+ *	@dev contains the the device number.
+ * @inode_rename:
+ *	Check for permission to rename a file or directory.
+ *	@old_dir contains the inode structure for parent of the old link.
+ *	@old_dentry contains the dentry structure of the old link.
+ *	@new_dir contains the inode structure for parent of the new link.
+ *	@new_dentry contains the dentry structure of the new link.
+ *	Return 0 if permission is granted.
+ * @inode_post_rename:
+ *	Set security attributes on a renamed file or directory.
+ *	@old_dir contains the inode structure for parent of the old link.
+ *	@old_dentry contains the dentry structure of the old link.
+ *	@new_dir contains the inode structure for parent of the new link.
+ *	@new_dentry contains the dentry structure of the new link.
+ * @inode_readlink:
+ *	Check the permission to read the symbolic link.
+ *	@dentry contains the dentry structure for the file link.
+ *	Return 0 if permission is granted.
+ * @inode_follow_link:
+ *	Check permission to follow a symbolic link when looking up a pathname.
+ *	@dentry contains the dentry structure for the link.
+ *	@nd contains the nameidata structure for the parent directory.
+ *	Return 0 if permission is granted.
+ * @inode_permission:
+ *	Check permission before accessing an inode.  This hook is called by the
+ *	existing Linux permission function, so a security module can use it to
+ *	provide additional checking for existing Linux permission checks.
+ *	Notice that this hook is called when a file is opened (as well as many
+ *	other operations), whereas the file_security_ops permission hook is
+ *	called when the actual read/write operations are performed.
+ *	@inode contains the inode structure to check.
+ *	@mask contains the permission mask.
+ *	Return 0 if permission is granted.
+ * @inode_permission_lite:
+ * 	Check permission before accessing an inode.  This hook is
+ * 	currently only called when checking MAY_EXEC access during
+ * 	pathname resolution.  The dcache lock is held and thus modules
+ * 	that could sleep or contend the lock should return -EAGAIN to
+ * 	inform the kernel to drop the lock and try again calling the
+ * 	full permission hook.
+ * 	@inode contains the inode structure to check.
+ * 	@mask contains the permission mask.
+ * 	Return 0 if permission is granted.
+ * @inode_setattr:
+ *	Check permission before setting file attributes.  Note that the kernel
+ *	call to notify_change is performed from several locations, whenever
+ *	file attributes change (such as when a file is truncated, chown/chmod
+ *	operations, transferring disk quotas, etc).
+ *	@dentry contains the dentry structure for the file.
+ *	@attr is the iattr structure containing the new file attributes.
+ *	Return 0 if permission is granted.
+ * @inode_getattr:
+ *	Check permission before obtaining file attributes.
+ *	@mnt is the vfsmount where the dentry was looked up
+ *	@dentry contains the dentry structure for the file.
+ *	Return 0 if permission is granted.
+ * @inode_post_lookup:
+ *	Set the security attributes for a file after it has been looked up.
+ *	@inode contains the inode structure for parent directory.
+ *	@d contains the dentry structure for the file.
+ * @inode_delete:
+ *	@inode contains the inode structure for deleted inode.
+ *	This hook is called when a deleted inode is released (i.e. an inode
+ *	with no hard links has its use count drop to zero).  A security module
+ *	can use this hook to release any persistent label associated with the
+ *	inode.
+ * @inode_setxattr:
+ * 	Check permission before setting the extended attributes
+ * 	@value identified by @name for @dentry.
+ * 	Return 0 if permission is granted.
+ * @inode_getxattr:
+ * 	Check permission before obtaining the extended attributes
+ * 	identified by @name for @dentry.
+ * 	Return 0 if permission is granted.
+ * @inode_listxattr:
+ * 	Check permission before obtaining the list of extended attribute 
+ * 	names for @dentry.
+ * 	Return 0 if permission is granted.
+ * @inode_removexattr:
+ * 	Check permission before removing the extended attribute
+ * 	identified by @name for @dentry.
+ * 	Return 0 if permission is granted.
+ *
+ * Security hooks for file operations
+ *
+ * @file_permission:
+ *	Check file permissions before accessing an open file.  This hook is
+ *	called by various operations that read or write files.  A security
+ *	module can use this hook to perform additional checking on these
+ *	operations, e.g.  to revalidate permissions on use to support privilege
+ *	bracketing or policy changes.  Notice that this hook is used when the
+ *	actual read/write operations are performed, whereas the
+ *	inode_security_ops hook is called when a file is opened (as well as
+ *	many other operations).
+ *	Caveat:  Although this hook can be used to revalidate permissions for
+ *	various system call operations that read or write files, it does not
+ *	address the revalidation of permissions for memory-mapped files.
+ *	Security modules must handle this separately if they need such
+ *	revalidation.
+ *	@file contains the file structure being accessed.
+ *	@mask contains the requested permissions.
+ *	Return 0 if permission is granted.
+ * @file_alloc_security:
+ *	Allocate and attach a security structure to the file->f_security field.
+ *	The security field is initialized to NULL when the structure is first
+ *	created.
+ *	@file contains the file structure to secure.
+ *	Return 0 if the hook is successful and permission is granted.
+ * @file_free_security:
+ *	Deallocate and free any security structures stored in file->f_security.
+ *	@file contains the file structure being modified.
+ * @file_llseek:
+ *	Check permission before re-positioning the file offset in @file.
+ *	@file contains the file structure being modified.
+ *	Return 0 if permission is granted.
+ * @file_ioctl:
+ *	@file contains the file structure.
+ *	@cmd contains the operation to perform.
+ *	@arg contains the operational arguments.
+ *	Check permission for an ioctl operation on @file.  Note that @arg can
+ *	sometimes represents a user space pointer; in other cases, it may be a
+ *	simple integer value.  When @arg represents a user space pointer, it
+ *	should never be used by the security module.
+ *	Return 0 if permission is granted.
+ * @file_mmap :
+ *	Check permissions for a mmap operation.  The @file may be NULL, e.g.
+ *	if mapping anonymous memory.
+ *	@file contains the file structure for file to map (may be NULL).
+ *	@prot contains the requested permissions.
+ *	@flags contains the operational flags.
+ *	Return 0 if permission is granted.
+ * @file_mprotect:
+ *	Check permissions before changing memory access permissions.
+ *	@vma contains the memory region to modify.
+ *	@prot contains the requested permissions.
+ *	Return 0 if permission is granted.
+ * @file_lock:
+ *	Check permission before performing file locking operations.
+ *	Note: this hook mediates both flock and fcntl style locks.
+ *	@file contains the file structure.
+ *	@cmd contains the posix-translated lock operation to perform
+ *	(e.g. F_RDLCK, F_WRLCK).
+ *	@blocking indicates if the request is for a blocking lock.
+ *	Return 0 if permission is granted.
+ * @file_fcntl:
+ *	Check permission before allowing the file operation specified by @cmd
+ *	from being performed on the file @file.  Note that @arg can sometimes
+ *	represents a user space pointer; in other cases, it may be a simple
+ *	integer value.  When @arg represents a user space pointer, it should
+ *	never be used by the security module.
+ *	@file contains the file structure.
+ *	@cmd contains the operation to be performed.
+ *	@arg contains the operational arguments.
+ *	Return 0 if permission is granted.
+ * @file_set_fowner:
+ *	Save owner security information (typically from current->security) in
+ *	file->f_security for later use by the send_sigiotask hook.
+ *	@file contains the file structure to update.
+ *	Return 0 on success.
+ * @file_send_sigiotask:
+ *	Check permission for the file owner @fown to send SIGIO to the process
+ *	@tsk.  Note that this hook is always called from interrupt.  Note that
+ *	the fown_struct, @fown, is never outside the context of a struct file,
+ *	so the file structure (and associated security information) can always
+ *	be obtained:
+ *		(struct file *)((long)fown - offsetof(struct file,f_owner));
+ * 	@tsk contains the structure of task receiving signal.
+ *	@fown contains the file owner information.
+ *	@fd contains the file descriptor.
+ *	@reason contains the operational flags.
+ *	Return 0 if permission is granted.
+ * @file_receive:
+ *	This hook allows security modules to control the ability of a process
+ *	to receive an open file descriptor via socket IPC.
+ *	@file contains the file structure being received.
+ *	Return 0 if permission is granted.
+ *
  * Security hooks for task operations.
  *
  * @task_create:
@@ -277,6 +616,13 @@
  *	@effective contains the effective capability set.
  *	@inheritable contains the inheritable capability set.
  *	@permitted contains the permitted capability set.
+ * @acct:
+ *	Check permission before enabling or disabling process accounting.  If
+ *	accounting is being enabled, then @file refers to the open file used to
+ *	store accounting records.  If accounting is being disabled, then @file
+ *	is NULL.
+ *	@file contains the file structure for the accounting file (may be NULL).
+ *	Return 0 if permission is granted.
  * @capable:
  *	Check whether the @tsk process has the @cap capability.
  *	@tsk contains the task_struct for the process.
@@ -322,15 +668,99 @@
 			    kernel_cap_t * effective,
 			    kernel_cap_t * inheritable,
 			    kernel_cap_t * permitted);
+	int (*acct) (struct file * file);
 	int (*capable) (struct task_struct * tsk, int cap);
 	int (*sys_security) (unsigned int id, unsigned call,
 			     unsigned long *args);
+	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
+	int (*quota_on) (struct file * f);
 
 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
 	void (*bprm_free_security) (struct linux_binprm * bprm);
 	void (*bprm_compute_creds) (struct linux_binprm * bprm);
 	int (*bprm_set_security) (struct linux_binprm * bprm);
 	int (*bprm_check_security) (struct linux_binprm * bprm);
+
+	int (*sb_alloc_security) (struct super_block * sb);
+	void (*sb_free_security) (struct super_block * sb);
+	int (*sb_statfs) (struct super_block * sb);
+	int (*sb_mount) (char *dev_name, struct nameidata * nd,
+			 char *type, unsigned long flags, void *data);
+	int (*sb_check_sb) (struct vfsmount * mnt, struct nameidata * nd);
+	int (*sb_umount) (struct vfsmount * mnt, int flags);
+	void (*sb_umount_close) (struct vfsmount * mnt);
+	void (*sb_umount_busy) (struct vfsmount * mnt);
+	void (*sb_post_remount) (struct vfsmount * mnt,
+				 unsigned long flags, void *data);
+	void (*sb_post_mountroot) (void);
+	void (*sb_post_addmount) (struct vfsmount * mnt,
+				  struct nameidata * mountpoint_nd);
+	int (*sb_pivotroot) (struct nameidata * old_nd,
+			     struct nameidata * new_nd);
+	void (*sb_post_pivotroot) (struct nameidata * old_nd,
+				   struct nameidata * new_nd);
+
+	int (*inode_alloc_security) (struct inode *inode);	
+	void (*inode_free_security) (struct inode *inode);
+	int (*inode_create) (struct inode *dir,
+	                     struct dentry *dentry, int mode);
+	void (*inode_post_create) (struct inode *dir,
+	                           struct dentry *dentry, int mode);
+	int (*inode_link) (struct dentry *old_dentry,
+	                   struct inode *dir, struct dentry *new_dentry);
+	void (*inode_post_link) (struct dentry *old_dentry,
+	                         struct inode *dir, struct dentry *new_dentry);
+	int (*inode_unlink) (struct inode *dir, struct dentry *dentry);
+	int (*inode_symlink) (struct inode *dir,
+	                      struct dentry *dentry, const char *old_name);
+	void (*inode_post_symlink) (struct inode *dir,
+	                            struct dentry *dentry,
+	                            const char *old_name);
+	int (*inode_mkdir) (struct inode *dir, struct dentry *dentry, int mode);
+	void (*inode_post_mkdir) (struct inode *dir, struct dentry *dentry, 
+			    int mode);
+	int (*inode_rmdir) (struct inode *dir, struct dentry *dentry);
+	int (*inode_mknod) (struct inode *dir, struct dentry *dentry,
+	                    int mode, dev_t dev);
+	void (*inode_post_mknod) (struct inode *dir, struct dentry *dentry,
+	                          int mode, dev_t dev);
+	int (*inode_rename) (struct inode *old_dir, struct dentry *old_dentry,
+	                     struct inode *new_dir, struct dentry *new_dentry);
+	void (*inode_post_rename) (struct inode *old_dir,
+	                           struct dentry *old_dentry,
+	                           struct inode *new_dir,
+	                           struct dentry *new_dentry);
+	int (*inode_readlink) (struct dentry *dentry);
+	int (*inode_follow_link) (struct dentry *dentry, struct nameidata *nd);
+	int (*inode_permission) (struct inode *inode, int mask);
+	int (*inode_permission_lite) (struct inode *inode, int mask);
+	int (*inode_setattr)	(struct dentry *dentry, struct iattr *attr);
+	int (*inode_getattr) (struct vfsmount *mnt, struct dentry *dentry);
+	void (*inode_post_lookup) (struct inode *inode, struct dentry *d);
+        void (*inode_delete) (struct inode *inode);
+	int (*inode_setxattr) (struct dentry *dentry, char *name, void *value,
+			       size_t size, int flags);
+	int (*inode_getxattr) (struct dentry *dentry, char *name);
+	int (*inode_listxattr) (struct dentry *dentry);
+	int (*inode_removexattr) (struct dentry *dentry, char *name);
+
+	int (*file_permission) (struct file * file, int mask);
+	int (*file_alloc_security) (struct file * file);
+	void (*file_free_security) (struct file * file);
+	int (*file_llseek) (struct file * file);
+	int (*file_ioctl) (struct file * file, unsigned int cmd,
+			   unsigned long arg);
+	int (*file_mmap) (struct file * file,
+			  unsigned long prot, unsigned long flags);
+	int (*file_mprotect) (struct vm_area_struct * vma, unsigned long prot);
+	int (*file_lock) (struct file * file, unsigned int cmd, int blocking);
+	int (*file_fcntl) (struct file * file, unsigned int cmd,
+			   unsigned long arg);
+	int (*file_set_fowner) (struct file * file);
+	int (*file_send_sigiotask) (struct task_struct * tsk,
+				    struct fown_struct * fown,
+				    int fd, int reason);
+	int (*file_receive) (struct file * file);
 
 	int (*task_create) (unsigned long clone_flags);
 	int (*task_alloc_security) (struct task_struct * p);
diff -Nru a/init/do_mounts.c b/init/do_mounts.c
--- a/init/do_mounts.c	Mon Jul 22 17:25:51 2002
+++ b/init/do_mounts.c	Mon Jul 22 17:25:51 2002
@@ -845,6 +845,7 @@
 	sys_umount("/dev", 0);
 	sys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
+	security_ops->sb_post_mountroot();
 	mount_devfs_fs ();
 }
 
diff -Nru a/kernel/acct.c b/kernel/acct.c
--- a/kernel/acct.c	Mon Jul 22 17:25:51 2002
+++ b/kernel/acct.c	Mon Jul 22 17:25:51 2002
@@ -195,6 +195,7 @@
 {
 	struct file *file = NULL;
 	char *tmp;
+	int error;
 
 	if (!capable(CAP_SYS_PACCT))
 		return -EPERM;
@@ -220,6 +221,10 @@
 			return (-EIO);
 		}
 	}
+
+	error = security_ops->acct(file);
+	if (error)
+		return error;
 
 	spin_lock(&acct_globals.lock);
 	acct_file_reopen(file);
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Mon Jul 22 17:25:51 2002
+++ b/mm/filemap.c	Mon Jul 22 17:25:51 2002
@@ -21,6 +21,7 @@
 #include <linux/iobuf.h>
 #include <linux/hash.h>
 #include <linux/writeback.h>
+#include <linux/security.h>
 /*
  * This is needed for the following functions:
  *  - try_to_release_page
@@ -1143,6 +1144,10 @@
 	if (retval)
 		goto fput_in;
 
+	retval = security_ops->file_permission (in_file, MAY_READ);
+	if (retval)
+		goto fput_in;
+
 	/*
 	 * Get output file, and verify that it is ok..
 	 */
@@ -1157,6 +1162,10 @@
 		goto fput_out;
 	out_inode = out_file->f_dentry->d_inode;
 	retval = locks_verify_area(FLOCK_VERIFY_WRITE, out_inode, out_file, out_file->f_pos, count);
+	if (retval)
+		goto fput_out;
+
+	retval = security_ops->file_permission (out_file, MAY_WRITE);
 	if (retval)
 		goto fput_out;
 
diff -Nru a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c	Mon Jul 22 17:25:51 2002
+++ b/mm/mmap.c	Mon Jul 22 17:25:51 2002
@@ -14,6 +14,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/personality.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -475,6 +476,10 @@
 		}
 	}
 
+	error = security_ops->file_mmap(file, prot, flags);
+	if (error)
+		return error;
+		
 	/* Clear old maps */
 	error = -ENOMEM;
 munmap_back:
diff -Nru a/mm/mprotect.c b/mm/mprotect.c
--- a/mm/mprotect.c	Mon Jul 22 17:25:51 2002
+++ b/mm/mprotect.c	Mon Jul 22 17:25:51 2002
@@ -10,6 +10,7 @@
 #include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -305,6 +306,10 @@
 			error = -EACCES;
 			goto out;
 		}
+
+		error = security_ops->file_mprotect(vma, prot);
+		if (error)
+			goto out;
 
 		if (vma->vm_end > end) {
 			error = mprotect_fixup(vma, &prev, nstart, end, newflags);
diff -Nru a/net/core/scm.c b/net/core/scm.c
--- a/net/core/scm.c	Mon Jul 22 17:25:51 2002
+++ b/net/core/scm.c	Mon Jul 22 17:25:51 2002
@@ -22,6 +22,7 @@
 #include <linux/net.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
+#include <linux/security.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -216,6 +217,9 @@
 	for (i=0, cmfptr=(int*)CMSG_DATA(cm); i<fdmax; i++, cmfptr++)
 	{
 		int new_fd;
+		err = security_ops->file_receive(fp[i]);
+		if (err)
+			break;
 		err = get_unused_fd();
 		if (err < 0)
 			break;
diff -Nru a/security/capability.c b/security/capability.c
--- a/security/capability.c	Mon Jul 22 17:25:51 2002
+++ b/security/capability.c	Mon Jul 22 17:25:51 2002
@@ -37,6 +37,16 @@
 	return -ENOSYS;
 }
 
+static int cap_quotactl (int cmds, int type, int id, struct super_block *sb)
+{
+	return 0;
+}
+
+static int cap_quota_on (struct file *f)
+{
+	return 0;
+}
+
 static int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 {
 	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
@@ -95,6 +105,11 @@
 	target->cap_permitted = *permitted;
 }
 
+static int cap_acct (struct file *file)
+{
+	return 0;
+}
+
 static int cap_bprm_alloc_security (struct linux_binprm *bprm)
 {
 	return 0;
@@ -189,6 +204,294 @@
 	current->keep_capabilities = 0;
 }
 
+static int cap_sb_alloc_security (struct super_block *sb)
+{
+	return 0;
+}
+
+static void cap_sb_free_security (struct super_block *sb)
+{
+	return;
+}
+
+static int cap_sb_statfs (struct super_block *sb)
+{
+	return 0;
+}
+
+static int cap_mount (char *dev_name, struct nameidata *nd, char *type,
+		      unsigned long flags, void *data)
+{
+	return 0;
+}
+
+static int cap_check_sb (struct vfsmount *mnt, struct nameidata *nd)
+{
+	return 0;
+}
+
+static int cap_umount (struct vfsmount *mnt, int flags)
+{
+	return 0;
+}
+
+static void cap_umount_close (struct vfsmount *mnt)
+{
+	return;
+}
+
+static void cap_umount_busy (struct vfsmount *mnt)
+{
+	return;
+}
+
+static void cap_post_remount (struct vfsmount *mnt, unsigned long flags,
+			      void *data)
+{
+	return;
+}
+
+static void cap_post_mountroot (void)
+{
+	return;
+}
+
+static void cap_post_addmount (struct vfsmount *mnt, struct nameidata *nd)
+{
+	return;
+}
+
+static int cap_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
+{
+	return 0;
+}
+
+static void cap_post_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
+{
+	return;
+}
+
+static int cap_inode_alloc_security (struct inode *inode)
+{
+	return 0;
+}
+
+static void cap_inode_free_security (struct inode *inode)
+{
+	return;
+}
+
+static int cap_inode_create (struct inode *inode, struct dentry *dentry,
+			     int mask)
+{
+	return 0;
+}
+
+static void cap_inode_post_create (struct inode *inode, struct dentry *dentry,
+				   int mask)
+{
+	return;
+}
+
+static int cap_inode_link (struct dentry *old_dentry, struct inode *inode,
+			   struct dentry *new_dentry)
+{
+	return 0;
+}
+
+static void cap_inode_post_link (struct dentry *old_dentry, struct inode *inode,
+				 struct dentry *new_dentry)
+{
+	return;
+}
+
+static int cap_inode_unlink (struct inode *inode, struct dentry *dentry)
+{
+	return 0;
+}
+
+static int cap_inode_symlink (struct inode *inode, struct dentry *dentry,
+			      const char *name)
+{
+	return 0;
+}
+
+static void cap_inode_post_symlink (struct inode *inode, struct dentry *dentry,
+				    const char *name)
+{
+	return;
+}
+
+static int cap_inode_mkdir (struct inode *inode, struct dentry *dentry,
+			    int mask)
+{
+	return 0;
+}
+
+static void cap_inode_post_mkdir (struct inode *inode, struct dentry *dentry,
+				  int mask)
+{
+	return;
+}
+
+static int cap_inode_rmdir (struct inode *inode, struct dentry *dentry)
+{
+	return 0;
+}
+
+static int cap_inode_mknod (struct inode *inode, struct dentry *dentry,
+			    int major, dev_t minor)
+{
+	return 0;
+}
+
+static void cap_inode_post_mknod (struct inode *inode, struct dentry *dentry,
+				  int major, dev_t minor)
+{
+	return;
+}
+
+static int cap_inode_rename (struct inode *old_inode, struct dentry *old_dentry,
+			     struct inode *new_inode, struct dentry *new_dentry)
+{
+	return 0;
+}
+
+static void cap_inode_post_rename (struct inode *old_inode,
+				   struct dentry *old_dentry,
+				   struct inode *new_inode,
+				   struct dentry *new_dentry)
+{
+	return;
+}
+
+static int cap_inode_readlink (struct dentry *dentry)
+{
+	return 0;
+}
+
+static int cap_inode_follow_link (struct dentry *dentry,
+				  struct nameidata *nameidata)
+{
+	return 0;
+}
+
+static int cap_inode_permission (struct inode *inode, int mask)
+{
+	return 0;
+}
+
+static int cap_inode_permission_lite (struct inode *inode, int mask)
+{
+	return 0;
+}
+
+static int cap_inode_setattr (struct dentry *dentry, struct iattr *iattr)
+{
+	return 0;
+}
+
+static int cap_inode_getattr (struct vfsmount *mnt, struct dentry *dentry)
+{
+	return 0;
+}
+
+static void cap_post_lookup (struct inode *ino, struct dentry *d)
+{
+	return;
+}
+
+static void cap_delete (struct inode *ino)
+{
+	return;
+}
+
+static int cap_inode_setxattr (struct dentry *dentry, char *name, void *value,
+				size_t size, int flags)
+{
+	return 0;
+}
+
+static int cap_inode_getxattr (struct dentry *dentry, char *name)
+{
+	return 0;
+}
+
+static int cap_inode_listxattr (struct dentry *dentry)
+{
+	return 0;
+}
+
+static int cap_inode_removexattr (struct dentry *dentry, char *name)
+{
+	return 0;
+}
+
+static int cap_file_permission (struct file *file, int mask)
+{
+	return 0;
+}
+
+static int cap_file_alloc_security (struct file *file)
+{
+	return 0;
+}
+
+static void cap_file_free_security (struct file *file)
+{
+	return;
+}
+
+static int cap_file_llseek (struct file *file)
+{
+	return 0;
+}
+
+static int cap_file_ioctl (struct file *file, unsigned int command,
+			   unsigned long arg)
+{
+	return 0;
+}
+
+static int cap_file_mmap (struct file *file, unsigned long prot,
+			  unsigned long flags)
+{
+	return 0;
+}
+
+static int cap_file_mprotect (struct vm_area_struct *vma, unsigned long prot)
+{
+	return 0;
+}
+
+static int cap_file_lock (struct file *file, unsigned int cmd, int blocking)
+{
+	return 0;
+}
+
+static int cap_file_fcntl (struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	return 0;
+}
+
+static int cap_file_set_fowner (struct file *file)
+{
+	return 0;
+}
+
+static int cap_file_send_sigiotask (struct task_struct *tsk,
+				    struct fown_struct *fown, int fd,
+				    int reason)
+{
+	return 0;
+}
+
+static int cap_file_receive (struct file *file)
+{
+	return 0;
+}
+
 static int cap_task_create (unsigned long clone_flags)
 {
 	return 0;
@@ -391,14 +694,73 @@
 	capget:				cap_capget,
 	capset_check:			cap_capset_check,
 	capset_set:			cap_capset_set,
+	acct:				cap_acct,
 	capable:			cap_capable,
 	sys_security:			cap_sys_security,
+	quotactl:			cap_quotactl,
+	quota_on:			cap_quota_on,
 	
 	bprm_alloc_security:		cap_bprm_alloc_security,
 	bprm_free_security:		cap_bprm_free_security,
 	bprm_compute_creds:		cap_bprm_compute_creds,
 	bprm_set_security:		cap_bprm_set_security,
 	bprm_check_security:		cap_bprm_check_security,
+
+	sb_alloc_security:		cap_sb_alloc_security,
+	sb_free_security:		cap_sb_free_security,
+	sb_statfs:			cap_sb_statfs,
+	sb_mount:			cap_mount,
+	sb_check_sb:			cap_check_sb,
+	sb_umount:			cap_umount,
+	sb_umount_close:		cap_umount_close,
+	sb_umount_busy:			cap_umount_busy,
+	sb_post_remount:		cap_post_remount,
+	sb_post_mountroot:		cap_post_mountroot,
+	sb_post_addmount:		cap_post_addmount,
+	sb_pivotroot:			cap_pivotroot,
+	sb_post_pivotroot:		cap_post_pivotroot,
+	
+	inode_alloc_security:		cap_inode_alloc_security,
+	inode_free_security:		cap_inode_free_security,
+	inode_create:			cap_inode_create,
+	inode_post_create:		cap_inode_post_create,
+	inode_link:			cap_inode_link,
+	inode_post_link:		cap_inode_post_link,
+	inode_unlink:			cap_inode_unlink,
+	inode_symlink:			cap_inode_symlink,
+	inode_post_symlink:		cap_inode_post_symlink,
+	inode_mkdir:			cap_inode_mkdir,
+	inode_post_mkdir:		cap_inode_post_mkdir,
+	inode_rmdir:			cap_inode_rmdir,
+	inode_mknod:			cap_inode_mknod,
+	inode_post_mknod:		cap_inode_post_mknod,
+	inode_rename:			cap_inode_rename,
+	inode_post_rename:		cap_inode_post_rename,
+	inode_readlink:			cap_inode_readlink,
+	inode_follow_link:		cap_inode_follow_link,
+	inode_permission:		cap_inode_permission,
+	inode_permission_lite:		cap_inode_permission_lite,
+	inode_setattr:			cap_inode_setattr,
+	inode_getattr:			cap_inode_getattr,
+	inode_post_lookup:		cap_post_lookup,
+	inode_delete:			cap_delete,
+	inode_setxattr:			cap_inode_setxattr,
+	inode_getxattr:			cap_inode_getxattr,
+	inode_listxattr:		cap_inode_listxattr,
+	inode_removexattr:		cap_inode_removexattr,
+	
+	file_permission:		cap_file_permission,
+	file_alloc_security:		cap_file_alloc_security,
+	file_free_security:		cap_file_free_security,
+	file_llseek:			cap_file_llseek,
+	file_ioctl:			cap_file_ioctl,
+	file_mmap:			cap_file_mmap,
+	file_mprotect:			cap_file_mprotect,
+	file_lock:			cap_file_lock,
+	file_fcntl:			cap_file_fcntl,
+	file_set_fowner:		cap_file_set_fowner,
+	file_send_sigiotask:		cap_file_send_sigiotask,
+	file_receive:			cap_file_receive,
 	
 	task_create:			cap_task_create,
 	task_alloc_security:		cap_task_alloc_security,
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Mon Jul 22 17:25:51 2002
+++ b/security/dummy.c	Mon Jul 22 17:25:51 2002
@@ -46,6 +46,11 @@
 	return;
 }
 
+static int dummy_acct (struct file *file)
+{
+	return 0;
+}
+
 static int dummy_capable (struct task_struct *tsk, int cap)
 {
 	if (cap_is_fs_cap (cap) ? tsk->fsuid == 0 : tsk->euid == 0)
@@ -62,6 +67,16 @@
 	return -ENOSYS;
 }
 
+static int dummy_quotactl (int cmds, int type, int id, struct super_block *sb)
+{
+	return 0;
+}
+
+static int dummy_quota_on (struct file *f)
+{
+	return 0;
+}
+
 static int dummy_bprm_alloc_security (struct linux_binprm *bprm)
 {
 	return 0;
@@ -87,6 +102,298 @@
 	return 0;
 }
 
+static int dummy_sb_alloc_security (struct super_block *sb)
+{
+	return 0;
+}
+
+static void dummy_sb_free_security (struct super_block *sb)
+{
+	return;
+}
+
+static int dummy_sb_statfs (struct super_block *sb)
+{
+	return 0;
+}
+
+static int dummy_mount (char *dev_name, struct nameidata *nd, char *type,
+			unsigned long flags, void *data)
+{
+	return 0;
+}
+
+static int dummy_check_sb (struct vfsmount *mnt, struct nameidata *nd)
+{
+	return 0;
+}
+
+static int dummy_umount (struct vfsmount *mnt, int flags)
+{
+	return 0;
+}
+
+static void dummy_umount_close (struct vfsmount *mnt)
+{
+	return;
+}
+
+static void dummy_umount_busy (struct vfsmount *mnt)
+{
+	return;
+}
+
+static void dummy_post_remount (struct vfsmount *mnt, unsigned long flags,
+				void *data)
+{
+	return;
+}
+
+
+static void dummy_post_mountroot (void)
+{
+	return;
+}
+
+static void dummy_post_addmount (struct vfsmount *mnt, struct nameidata *nd)
+{
+	return;
+}
+
+static int dummy_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
+{
+	return 0;
+}
+
+static void dummy_post_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
+{
+	return;
+}
+
+static int dummy_inode_alloc_security (struct inode *inode)
+{
+	return 0;
+}
+
+static void dummy_inode_free_security (struct inode *inode)
+{
+	return;
+}
+
+static int dummy_inode_create (struct inode *inode, struct dentry *dentry,
+			       int mask)
+{
+	return 0;
+}
+
+static void dummy_inode_post_create (struct inode *inode, struct dentry *dentry,
+				     int mask)
+{
+	return;
+}
+
+static int dummy_inode_link (struct dentry *old_dentry, struct inode *inode,
+			     struct dentry *new_dentry)
+{
+	return 0;
+}
+
+static void dummy_inode_post_link (struct dentry *old_dentry,
+				   struct inode *inode,
+				   struct dentry *new_dentry)
+{
+	return;
+}
+
+static int dummy_inode_unlink (struct inode *inode, struct dentry *dentry)
+{
+	return 0;
+}
+
+static int dummy_inode_symlink (struct inode *inode, struct dentry *dentry,
+				const char *name)
+{
+	return 0;
+}
+
+static void dummy_inode_post_symlink (struct inode *inode,
+				      struct dentry *dentry, const char *name)
+{
+	return;
+}
+
+static int dummy_inode_mkdir (struct inode *inode, struct dentry *dentry,
+			      int mask)
+{
+	return 0;
+}
+
+static void dummy_inode_post_mkdir (struct inode *inode, struct dentry *dentry,
+				    int mask)
+{
+	return;
+}
+
+static int dummy_inode_rmdir (struct inode *inode, struct dentry *dentry)
+{
+	return 0;
+}
+
+static int dummy_inode_mknod (struct inode *inode, struct dentry *dentry,
+			      int major, dev_t minor)
+{
+	return 0;
+}
+
+static void dummy_inode_post_mknod (struct inode *inode, struct dentry *dentry,
+				    int major, dev_t minor)
+{
+	return;
+}
+
+static int dummy_inode_rename (struct inode *old_inode,
+			       struct dentry *old_dentry,
+			       struct inode *new_inode,
+			       struct dentry *new_dentry)
+{
+	return 0;
+}
+
+static void dummy_inode_post_rename (struct inode *old_inode,
+				     struct dentry *old_dentry,
+				     struct inode *new_inode,
+				     struct dentry *new_dentry)
+{
+	return;
+}
+
+static int dummy_inode_readlink (struct dentry *dentry)
+{
+	return 0;
+}
+
+static int dummy_inode_follow_link (struct dentry *dentry,
+				    struct nameidata *nameidata)
+{
+	return 0;
+}
+
+static int dummy_inode_permission (struct inode *inode, int mask)
+{
+	return 0;
+}
+
+static int dummy_inode_permission_lite (struct inode *inode, int mask)
+{
+	return 0;
+}
+
+static int dummy_inode_setattr (struct dentry *dentry, struct iattr *iattr)
+{
+	return 0;
+}
+
+static int dummy_inode_getattr (struct vfsmount *mnt, struct dentry *dentry)
+{
+	return 0;
+}
+
+static void dummy_post_lookup (struct inode *ino, struct dentry *d)
+{
+	return;
+}
+
+static void dummy_delete (struct inode *ino)
+{
+	return;
+}
+
+static int dummy_inode_setxattr (struct dentry *dentry, char *name, void *value,
+				size_t size, int flags)
+{
+	return 0;
+}
+
+static int dummy_inode_getxattr (struct dentry *dentry, char *name)
+{
+	return 0;
+}
+
+static int dummy_inode_listxattr (struct dentry *dentry)
+{
+	return 0;
+}
+
+static int dummy_inode_removexattr (struct dentry *dentry, char *name)
+{
+	return 0;
+}
+
+static int dummy_file_permission (struct file *file, int mask)
+{
+	return 0;
+}
+
+static int dummy_file_alloc_security (struct file *file)
+{
+	return 0;
+}
+
+static void dummy_file_free_security (struct file *file)
+{
+	return;
+}
+
+static int dummy_file_llseek (struct file *file)
+{
+	return 0;
+}
+
+static int dummy_file_ioctl (struct file *file, unsigned int command,
+			     unsigned long arg)
+{
+	return 0;
+}
+
+static int dummy_file_mmap (struct file *file, unsigned long prot,
+			    unsigned long flags)
+{
+	return 0;
+}
+
+static int dummy_file_mprotect (struct vm_area_struct *vma, unsigned long prot)
+{
+	return 0;
+}
+
+static int dummy_file_lock (struct file *file, unsigned int cmd, int blocking)
+{
+	return 0;
+}
+
+static int dummy_file_fcntl (struct file *file, unsigned int cmd,
+			     unsigned long arg)
+{
+	return 0;
+}
+
+static int dummy_file_set_fowner (struct file *file)
+{
+	return 0;
+}
+
+static int dummy_file_send_sigiotask (struct task_struct *tsk,
+				      struct fown_struct *fown, int fd,
+				      int reason)
+{
+	return 0;
+}
+
+static int dummy_file_receive (struct file *file)
+{
+	return 0;
+}
+
 static int dummy_task_create (unsigned long clone_flags)
 {
 	return 0;
@@ -201,14 +508,73 @@
 	capget:				dummy_capget,
 	capset_check:			dummy_capset_check,
 	capset_set:			dummy_capset_set,
+	acct:				dummy_acct,
 	capable:			dummy_capable,
 	sys_security:			dummy_sys_security,
+	quotactl:			dummy_quotactl,
+	quota_on:			dummy_quota_on,
 	
 	bprm_alloc_security:		dummy_bprm_alloc_security,
 	bprm_free_security:		dummy_bprm_free_security,
 	bprm_compute_creds:		dummy_bprm_compute_creds,
 	bprm_set_security:		dummy_bprm_set_security,
 	bprm_check_security:		dummy_bprm_check_security,
+
+	sb_alloc_security:		dummy_sb_alloc_security,
+	sb_free_security:		dummy_sb_free_security,
+	sb_statfs:			dummy_sb_statfs,
+	sb_mount:			dummy_mount,
+	sb_check_sb:			dummy_check_sb,
+	sb_umount:			dummy_umount,
+	sb_umount_close:		dummy_umount_close,
+	sb_umount_busy:			dummy_umount_busy,
+	sb_post_remount:		dummy_post_remount,
+	sb_post_mountroot:		dummy_post_mountroot,
+	sb_post_addmount:		dummy_post_addmount,
+	sb_pivotroot:			dummy_pivotroot,
+	sb_post_pivotroot:		dummy_post_pivotroot,
+	
+	inode_alloc_security:		dummy_inode_alloc_security,
+	inode_free_security:		dummy_inode_free_security,
+	inode_create:			dummy_inode_create,
+	inode_post_create:		dummy_inode_post_create,
+	inode_link:			dummy_inode_link,
+	inode_post_link:		dummy_inode_post_link,
+	inode_unlink:			dummy_inode_unlink,
+	inode_symlink:			dummy_inode_symlink,
+	inode_post_symlink:		dummy_inode_post_symlink,
+	inode_mkdir:			dummy_inode_mkdir,
+	inode_post_mkdir:		dummy_inode_post_mkdir,
+	inode_rmdir:			dummy_inode_rmdir,
+	inode_mknod:			dummy_inode_mknod,
+	inode_post_mknod:		dummy_inode_post_mknod,
+	inode_rename:			dummy_inode_rename,
+	inode_post_rename:		dummy_inode_post_rename,
+	inode_readlink:			dummy_inode_readlink,
+	inode_follow_link:		dummy_inode_follow_link,
+	inode_permission:		dummy_inode_permission,
+	inode_permission_lite:		dummy_inode_permission_lite,
+	inode_setattr:			dummy_inode_setattr,
+	inode_getattr:			dummy_inode_getattr,
+	inode_post_lookup:		dummy_post_lookup,
+	inode_delete:			dummy_delete,
+	inode_setxattr:			dummy_inode_setxattr,
+	inode_getxattr:			dummy_inode_getxattr,
+	inode_listxattr:		dummy_inode_listxattr,
+	inode_removexattr:		dummy_inode_removexattr,
+
+	file_permission:		dummy_file_permission,
+	file_alloc_security:		dummy_file_alloc_security,
+	file_free_security:		dummy_file_free_security,
+	file_llseek:			dummy_file_llseek,
+	file_ioctl:			dummy_file_ioctl,
+	file_mmap:			dummy_file_mmap,
+	file_mprotect:			dummy_file_mprotect,
+	file_lock:			dummy_file_lock,
+	file_fcntl:			dummy_file_fcntl,
+	file_set_fowner:		dummy_file_set_fowner,
+	file_send_sigiotask:		dummy_file_send_sigiotask,
+	file_receive:			dummy_file_receive,
 
 	task_create:			dummy_task_create,
 	task_alloc_security:		dummy_task_alloc_security,
