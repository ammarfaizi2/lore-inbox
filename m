Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbULGUNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbULGUNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbULGUMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:12:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9369 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261910AbULGUJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:09:51 -0500
From: Mike Werner <werner@sgi.com>
Reply-To: werner@sgi.com
To: linux-kernel@vger.kernel.org
Subject: [RFC]Add an unlocked_ioctl file operation
Date: Tue, 7 Dec 2004 12:11:41 -0800
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412071211.41468.werner@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Andi Kleen's suggestion.

# This is a BitKeeper generated diff -Nru style patch.
#
#   Run Lindent on ioctl.c
#   Add an ioctl path which does not take the BKL.
# 
diff -Nru a/fs/ioctl.c b/fs/ioctl.c
--- a/fs/ioctl.c	2004-12-07 11:53:59 -08:00
+++ b/fs/ioctl.c	2004-12-07 11:53:59 -08:00
@@ -16,15 +16,15 @@
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
-static int file_ioctl(struct file *filp,unsigned int cmd,unsigned long arg)
+static int file_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	int error;
 	int block;
-	struct inode * inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_dentry->d_inode;
 	int __user *p = (int __user *)arg;
 
 	switch (cmd) {
-		case FIBMAP:
+	case FIBMAP:
 		{
 			struct address_space *mapping = filp->f_mapping;
 			int res;
@@ -39,101 +39,113 @@
 			res = mapping->a_ops->bmap(mapping, block);
 			return put_user(res, p);
 		}
-		case FIGETBSZ:
-			if (inode->i_sb == NULL)
-				return -EBADF;
-			return put_user(inode->i_sb->s_blocksize, p);
-		case FIONREAD:
-			return put_user(i_size_read(inode) - filp->f_pos, p);
+	case FIGETBSZ:
+		if (inode->i_sb == NULL)
+			return -EBADF;
+		return put_user(inode->i_sb->s_blocksize, p);
+	case FIONREAD:
+		return put_user(i_size_read(inode) - filp->f_pos, p);
 	}
 	if (filp->f_op && filp->f_op->ioctl)
 		return filp->f_op->ioctl(inode, filp, cmd, arg);
 	return -ENOTTY;
 }
 
-
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long 
arg)
-{	
-	struct file * filp;
+{
+	struct file *filp;
 	unsigned int flag;
 	int on, error = -EBADF;
-
+	int locked = 1;
 	filp = fget(fd);
 	if (!filp)
 		goto out;
 
 	error = security_file_ioctl(filp, cmd, arg);
 	if (error) {
-                fput(filp);
-                goto out;
-        }
+		fput(filp);
+		goto out;
+	}
+
+	if (filp->f_op && filp->f_op->unlocked_ioctl)
+		locked = 0;
+	else
+		lock_kernel();
 
-	lock_kernel();
 	switch (cmd) {
-		case FIOCLEX:
-			set_close_on_exec(fd, 1);
-			break;
+	case FIOCLEX:
+		set_close_on_exec(fd, 1);
+		break;
+
+	case FIONCLEX:
+		set_close_on_exec(fd, 0);
+		break;
 
-		case FIONCLEX:
-			set_close_on_exec(fd, 0);
+	case FIONBIO:
+		if ((error = get_user(on, (int __user *)arg)) != 0)
 			break;
-
-		case FIONBIO:
-			if ((error = get_user(on, (int __user *)arg)) != 0)
-				break;
-			flag = O_NONBLOCK;
+		flag = O_NONBLOCK;
 #ifdef __sparc__
-			/* SunOS compatibility item. */
-			if(O_NONBLOCK != O_NDELAY)
-				flag |= O_NDELAY;
+		/* SunOS compatibility item. */
+		if (O_NONBLOCK != O_NDELAY)
+			flag |= O_NDELAY;
 #endif
-			if (on)
-				filp->f_flags |= flag;
-			else
-				filp->f_flags &= ~flag;
-			break;
-
-		case FIOASYNC:
-			if ((error = get_user(on, (int __user *)arg)) != 0)
-				break;
-			flag = on ? FASYNC : 0;
-
-			/* Did FASYNC state change ? */
-			if ((flag ^ filp->f_flags) & FASYNC) {
-				if (filp->f_op && filp->f_op->fasync)
-					error = filp->f_op->fasync(fd, filp, on);
-				else error = -ENOTTY;
-			}
-			if (error != 0)
-				break;
+		if (on)
+			filp->f_flags |= flag;
+		else
+			filp->f_flags &= ~flag;
+		break;
 
-			if (on)
-				filp->f_flags |= FASYNC;
-			else
-				filp->f_flags &= ~FASYNC;
+	case FIOASYNC:
+		if ((error = get_user(on, (int __user *)arg)) != 0)
 			break;
+		flag = on ? FASYNC : 0;
 
-		case FIOQSIZE:
-			if (S_ISDIR(filp->f_dentry->d_inode->i_mode) ||
-			    S_ISREG(filp->f_dentry->d_inode->i_mode) ||
-			    S_ISLNK(filp->f_dentry->d_inode->i_mode)) {
-				loff_t res = inode_get_bytes(filp->f_dentry->d_inode);
-				error = copy_to_user((loff_t __user *)arg, &res, sizeof(res)) ? -EFAULT : 
0;
-			}
+		/* Did FASYNC state change ? */
+		if ((flag ^ filp->f_flags) & FASYNC) {
+			if (filp->f_op && filp->f_op->fasync)
+				error = filp->f_op->fasync(fd, filp, on);
 			else
 				error = -ENOTTY;
+		}
+		if (error != 0)
 			break;
-		default:
+
+		if (on)
+			filp->f_flags |= FASYNC;
+		else
+			filp->f_flags &= ~FASYNC;
+		break;
+
+	case FIOQSIZE:
+		if (S_ISDIR(filp->f_dentry->d_inode->i_mode) ||
+		    S_ISREG(filp->f_dentry->d_inode->i_mode) ||
+		    S_ISLNK(filp->f_dentry->d_inode->i_mode)) {
+			loff_t res = inode_get_bytes(filp->f_dentry->d_inode);
+			error =
+			    copy_to_user((loff_t __user *) arg, &res,
+					 sizeof(res)) ? -EFAULT : 0;
+		} else
 			error = -ENOTTY;
-			if (S_ISREG(filp->f_dentry->d_inode->i_mode))
-				error = file_ioctl(filp, cmd, arg);
-			else if (filp->f_op && filp->f_op->ioctl)
-				error = filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
+		break;
+	default:
+		error = -ENOTTY;
+		if (S_ISREG(filp->f_dentry->d_inode->i_mode))
+			error = file_ioctl(filp, cmd, arg);
+		else if (filp->f_op && filp->f_op->unlocked_ioctl)
+			error =
+			    filp->f_op->unlocked_ioctl(filp->f_dentry->d_inode,
+						       filp, cmd, arg);
+		else if (filp->f_op && filp->f_op->ioctl)
+			error =
+			    filp->f_op->ioctl(filp->f_dentry->d_inode, filp,
+					      cmd, arg);
 	}
-	unlock_kernel();
+	if (locked)
+		unlock_kernel();
 	fput(filp);
 
-out:
+      out:
 	return error;
 }
 
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2004-12-07 11:53:59 -08:00
+++ b/include/linux/fs.h	2004-12-07 11:53:59 -08:00
@@ -915,6 +915,7 @@
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
+	int (*unlocked_ioctl) (struct inode *, struct file *, unsigned int, unsigned 
long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
