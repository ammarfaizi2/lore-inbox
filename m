Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290794AbSBNHZq>; Thu, 14 Feb 2002 02:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290806AbSBNHZi>; Thu, 14 Feb 2002 02:25:38 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:27898 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S290794AbSBNHZU>; Thu, 14 Feb 2002 02:25:20 -0500
Date: Wed, 13 Feb 2002 23:24:14 -0800
From: Chris Wright <chris@wirex.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: [PATCH] 2.5.5-pre1 fcntl_[gs]etlk* cleanup
Message-ID: <20020213232414.M4501@figure1.int.wirex.com>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	matthew@wil.cx
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The sys_fcntl() code does fget(fd) upon entry.  Later during the
F_GETLK, F_SETLK, F_GETLK64 and F_SETLK64 code paths, the fd is looked
up again, rather than using the filp that is already known.  AFAICT this
is not necessary.  The patch below addresses this.

- fcntl_getlk, fcntl_setlk, fcntl_setlk64, and fcntl_getlk64 now take filp
- collapse F_SETLK64 and F_SETLKW64 cases to one fall through case.
- removed unused -EINVAL assignment in fcntl_setlk and fcntl_setlk64

This patch compiles, boots and runs fine.  Please consider applying.

thanks,
-chris

--- linux-2.5.5-pre1/fs/fcntl.c	Tue Feb  5 07:24:35 2002
+++ linux-2.5.5-pre1-fcntl/fs/fcntl.c	Wed Feb 13 22:37:45 2002
@@ -296,11 +296,11 @@
 			unlock_kernel();
 			break;
 		case F_GETLK:
-			err = fcntl_getlk(fd, (struct flock *) arg);
+			err = fcntl_getlk(filp, (struct flock *) arg);
 			break;
 		case F_SETLK:
 		case F_SETLKW:
-			err = fcntl_setlk(fd, cmd, (struct flock *) arg);
+			err = fcntl_setlk(filp, cmd, (struct flock *) arg);
 			break;
 		case F_GETOWN:
 			/*
@@ -382,13 +382,11 @@
 
 	switch (cmd) {
 		case F_GETLK64:
-			err = fcntl_getlk64(fd, (struct flock64 *) arg);
+			err = fcntl_getlk64(filp, (struct flock64 *) arg);
 			break;
 		case F_SETLK64:
-			err = fcntl_setlk64(fd, cmd, (struct flock64 *) arg);
-			break;
 		case F_SETLKW64:
-			err = fcntl_setlk64(fd, cmd, (struct flock64 *) arg);
+			err = fcntl_setlk64(filp, cmd, (struct flock64 *) arg);
 			break;
 		default:
 			err = do_fcntl(fd, cmd, arg, filp);
--- linux-2.5.5-pre1/fs/locks.c	Fri Feb  8 19:10:55 2002
+++ linux-2.5.5-pre1-fcntl/fs/locks.c	Wed Feb 13 22:37:45 2002
@@ -1353,9 +1353,8 @@
 /* Report the first existing lock that would conflict with l.
  * This implements the F_GETLK command of fcntl().
  */
-int fcntl_getlk(unsigned int fd, struct flock *l)
+int fcntl_getlk(struct file *filp, struct flock *l)
 {
-	struct file *filp;
 	struct file_lock *fl, file_lock;
 	struct flock flock;
 	int error;
@@ -1367,19 +1366,14 @@
 	if ((flock.l_type != F_RDLCK) && (flock.l_type != F_WRLCK))
 		goto out;
 
-	error = -EBADF;
-	filp = fget(fd);
-	if (!filp)
-		goto out;
-
 	error = flock_to_posix_lock(filp, &file_lock, &flock);
 	if (error)
-		goto out_putf;
+		goto out;
 
 	if (filp->f_op && filp->f_op->lock) {
 		error = filp->f_op->lock(filp, F_GETLK, &file_lock);
 		if (error < 0)
-			goto out_putf;
+			goto out;
 		else if (error == LOCK_USE_CLNT)
 		  /* Bypass for NFS with no locking - 2.0.36 compat */
 		  fl = posix_test_lock(filp, &file_lock);
@@ -1399,10 +1393,10 @@
 		 */
 		error = -EOVERFLOW;
 		if (fl->fl_start > OFFT_OFFSET_MAX)
-			goto out_putf;
+			goto out;
 		if ((fl->fl_end != OFFSET_MAX)
 		    && (fl->fl_end > OFFT_OFFSET_MAX))
-			goto out_putf;
+			goto out;
 #endif
 		flock.l_start = fl->fl_start;
 		flock.l_len = fl->fl_end == OFFSET_MAX ? 0 :
@@ -1414,8 +1408,6 @@
 	if (!copy_to_user(l, &flock, sizeof(flock)))
 		error = 0;
   
-out_putf:
-	fput(filp);
 out:
 	return error;
 }
@@ -1423,12 +1415,11 @@
 /* Apply the lock described by l to an open file descriptor.
  * This implements both the F_SETLK and F_SETLKW commands of fcntl().
  */
-int fcntl_setlk(unsigned int fd, unsigned int cmd, struct flock *l)
+int fcntl_setlk(struct file *filp, unsigned int cmd, struct flock *l)
 {
-	struct file *filp;
 	struct file_lock *file_lock = locks_alloc_lock(0);
 	struct flock flock;
-	struct inode *inode;
+	struct inode *inode = filp->f_dentry->d_inode;
 	int error;
 
 	if (file_lock == NULL)
@@ -1441,17 +1432,6 @@
 	if (copy_from_user(&flock, l, sizeof(flock)))
 		goto out;
 
-	/* Get arguments and validate them ...
-	 */
-
-	error = -EBADF;
-	filp = fget(fd);
-	if (!filp)
-		goto out;
-
-	error = -EINVAL;
-	inode = filp->f_dentry->d_inode;
-
 	/* Don't allow mandatory locks on files that may be memory mapped
 	 * and shared.
 	 */
@@ -1461,23 +1441,25 @@
 
 		if (mapping->i_mmap_shared != NULL) {
 			error = -EAGAIN;
-			goto out_putf;
+			goto out;
 		}
 	}
 
+	/* Get arguments and validate them ...
+	 */
 	error = flock_to_posix_lock(filp, file_lock, &flock);
 	if (error)
-		goto out_putf;
+		goto out;
 	
 	error = -EBADF;
 	switch (flock.l_type) {
 	case F_RDLCK:
 		if (!(filp->f_mode & FMODE_READ))
-			goto out_putf;
+			goto out;
 		break;
 	case F_WRLCK:
 		if (!(filp->f_mode & FMODE_WRITE))
-			goto out_putf;
+			goto out;
 		break;
 	case F_UNLCK:
 		break;
@@ -1495,23 +1477,21 @@
 	}
 }
 		if (!(filp->f_mode & 3))
-			goto out_putf;
+			goto out;
 		break;
 #endif
 	default:
 		error = -EINVAL;
-		goto out_putf;
+		goto out;
 	}
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
 		error = filp->f_op->lock(filp, cmd, file_lock);
 		if (error < 0)
-			goto out_putf;
+			goto out;
 	}
 	error = posix_lock_file(filp, file_lock, cmd == F_SETLKW);
 
-out_putf:
-	fput(filp);
 out:
 	locks_free_lock(file_lock);
 	return error;
@@ -1521,9 +1501,8 @@
 /* Report the first existing lock that would conflict with l.
  * This implements the F_GETLK command of fcntl().
  */
-int fcntl_getlk64(unsigned int fd, struct flock64 *l)
+int fcntl_getlk64(struct file *filp, struct flock64 *l)
 {
-	struct file *filp;
 	struct file_lock *fl, file_lock;
 	struct flock64 flock;
 	int error;
@@ -1535,19 +1514,15 @@
 	if ((flock.l_type != F_RDLCK) && (flock.l_type != F_WRLCK))
 		goto out;
 
-	error = -EBADF;
-	filp = fget(fd);
-	if (!filp)
-		goto out;
 
 	error = flock64_to_posix_lock(filp, &file_lock, &flock);
 	if (error)
-		goto out_putf;
+		goto out;
 
 	if (filp->f_op && filp->f_op->lock) {
 		error = filp->f_op->lock(filp, F_GETLK, &file_lock);
 		if (error < 0)
-			goto out_putf;
+			goto out;
 		else if (error == LOCK_USE_CLNT)
 		  /* Bypass for NFS with no locking - 2.0.36 compat */
 		  fl = posix_test_lock(filp, &file_lock);
@@ -1570,8 +1545,6 @@
 	if (!copy_to_user(l, &flock, sizeof(flock)))
 		error = 0;
   
-out_putf:
-	fput(filp);
 out:
 	return error;
 }
@@ -1579,12 +1552,11 @@
 /* Apply the lock described by l to an open file descriptor.
  * This implements both the F_SETLK and F_SETLKW commands of fcntl().
  */
-int fcntl_setlk64(unsigned int fd, unsigned int cmd, struct flock64 *l)
+int fcntl_setlk64(struct file *filp, unsigned int cmd, struct flock64 *l)
 {
-	struct file *filp;
 	struct file_lock *file_lock = locks_alloc_lock(0);
 	struct flock64 flock;
-	struct inode *inode;
+	struct inode *inode = filp->f_dentry->d_inode;
 	int error;
 
 	if (file_lock == NULL)
@@ -1597,16 +1569,6 @@
 	if (copy_from_user(&flock, l, sizeof(flock)))
 		goto out;
 
-	/* Get arguments and validate them ...
-	 */
-
-	error = -EBADF;
-	filp = fget(fd);
-	if (!filp)
-		goto out;
-
-	error = -EINVAL;
-	inode = filp->f_dentry->d_inode;
 
 	/* Don't allow mandatory locks on files that may be memory mapped
 	 * and shared.
@@ -1617,23 +1579,25 @@
 
 		if (mapping->i_mmap_shared != NULL) {
 			error = -EAGAIN;
-			goto out_putf;
+			goto out;
 		}
 	}
 
+	/* Get arguments and validate them ...
+	 */
 	error = flock64_to_posix_lock(filp, file_lock, &flock);
 	if (error)
-		goto out_putf;
+		goto out;
 	
 	error = -EBADF;
 	switch (flock.l_type) {
 	case F_RDLCK:
 		if (!(filp->f_mode & FMODE_READ))
-			goto out_putf;
+			goto out;
 		break;
 	case F_WRLCK:
 		if (!(filp->f_mode & FMODE_WRITE))
-			goto out_putf;
+			goto out;
 		break;
 	case F_UNLCK:
 		break;
@@ -1641,18 +1605,16 @@
 	case F_EXLCK:
 	default:
 		error = -EINVAL;
-		goto out_putf;
+		goto out;
 	}
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
 		error = filp->f_op->lock(filp, cmd, file_lock);
 		if (error < 0)
-			goto out_putf;
+			goto out;
 	}
 	error = posix_lock_file(filp, file_lock, cmd == F_SETLKW64);
 
-out_putf:
-	fput(filp);
 out:
 	locks_free_lock(file_lock);
 	return error;
--- linux-2.5.5-pre1/include/linux/fs.h	Mon Feb 11 11:26:32 2002
+++ linux-2.5.5-pre1-fcntl/include/linux/fs.h	Wed Feb 13 22:37:46 2002
@@ -580,11 +580,11 @@
 
 #include <linux/fcntl.h>
 
-extern int fcntl_getlk(unsigned int, struct flock *);
-extern int fcntl_setlk(unsigned int, unsigned int, struct flock *);
+extern int fcntl_getlk(struct file *, struct flock *);
+extern int fcntl_setlk(struct file *, unsigned int, struct flock *);
 
-extern int fcntl_getlk64(unsigned int, struct flock64 *);
-extern int fcntl_setlk64(unsigned int, unsigned int, struct flock64 *);
+extern int fcntl_getlk64(struct file *, struct flock64 *);
+extern int fcntl_setlk64(struct file *, unsigned int, struct flock64 *);
 
 /* fs/locks.c */
 extern void locks_init_lock(struct file_lock *);
