Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSFEPrR>; Wed, 5 Jun 2002 11:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315471AbSFEPrQ>; Wed, 5 Jun 2002 11:47:16 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:64729 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315459AbSFEPrK>;
	Wed, 5 Jun 2002 11:47:10 -0400
Date: Thu, 6 Jun 2002 01:46:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: Matthew Wilcox <matthew@wil.cx>, LKML <linux-kernel@vger.kernel.org>,
        Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] fcntl_[sg]etlk() only need the file *
Message-Id: <20020606014617.4705f9dd.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another simple part of a Matthew Wilcox patch.

We do not need to pass the file descriptor to the fcntl_[sg]etlk
functions, only the struct file * which we have already got
from the file descriptor and verified.

Please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.20/fs/fcntl.c 2.5.20-sfr.2/fs/fcntl.c
--- 2.5.20/fs/fcntl.c	Sun May 26 19:20:31 2002
+++ 2.5.20-sfr.2/fs/fcntl.c	Thu Jun  6 01:19:45 2002
@@ -300,11 +300,11 @@
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
@@ -386,13 +386,11 @@
 
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
diff -ruN 2.5.20/fs/locks.c 2.5.20-sfr.2/fs/locks.c
--- 2.5.20/fs/locks.c	Fri Mar  8 14:37:19 2002
+++ 2.5.20-sfr.2/fs/locks.c	Thu Jun  6 01:39:11 2002
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
@@ -1423,9 +1415,8 @@
 /* Apply the lock described by l to an open file descriptor.
  * This implements both the F_SETLK and F_SETLKW commands of fcntl().
  */
-int fcntl_setlk(unsigned int fd, unsigned int cmd, struct flock *l)
+int fcntl_setlk(struct file *filp, unsigned int cmd, struct flock *l)
 {
-	struct file *filp;
 	struct file_lock *file_lock = locks_alloc_lock(0);
 	struct flock flock;
 	struct inode *inode;
@@ -1443,13 +1434,6 @@
 
 	/* Get arguments and validate them ...
 	 */
-
-	error = -EBADF;
-	filp = fget(fd);
-	if (!filp)
-		goto out;
-
-	error = -EINVAL;
 	inode = filp->f_dentry->d_inode;
 
 	/* Don't allow mandatory locks on files that may be memory mapped
@@ -1461,23 +1445,23 @@
 
 		if (!list_empty(&mapping->i_mmap_shared)) {
 			error = -EAGAIN;
-			goto out_putf;
+			goto out;
 		}
 	}
 
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
@@ -1495,23 +1479,21 @@
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
@@ -1521,9 +1503,8 @@
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
@@ -1535,19 +1516,14 @@
 	if ((flock.l_type != F_RDLCK) && (flock.l_type != F_WRLCK))
 		goto out;
 
-	error = -EBADF;
-	filp = fget(fd);
-	if (!filp)
-		goto out;
-
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
@@ -1570,8 +1546,6 @@
 	if (!copy_to_user(l, &flock, sizeof(flock)))
 		error = 0;
   
-out_putf:
-	fput(filp);
 out:
 	return error;
 }
@@ -1579,9 +1553,8 @@
 /* Apply the lock described by l to an open file descriptor.
  * This implements both the F_SETLK and F_SETLKW commands of fcntl().
  */
-int fcntl_setlk64(unsigned int fd, unsigned int cmd, struct flock64 *l)
+int fcntl_setlk64(struct file *filp, unsigned int cmd, struct flock64 *l)
 {
-	struct file *filp;
 	struct file_lock *file_lock = locks_alloc_lock(0);
 	struct flock64 flock;
 	struct inode *inode;
@@ -1599,13 +1572,6 @@
 
 	/* Get arguments and validate them ...
 	 */
-
-	error = -EBADF;
-	filp = fget(fd);
-	if (!filp)
-		goto out;
-
-	error = -EINVAL;
 	inode = filp->f_dentry->d_inode;
 
 	/* Don't allow mandatory locks on files that may be memory mapped
@@ -1617,23 +1583,23 @@
 
 		if (!list_empty(&mapping->i_mmap_shared)) {
 			error = -EAGAIN;
-			goto out_putf;
+			goto out;
 		}
 	}
 
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
@@ -1641,18 +1607,16 @@
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
diff -ruN 2.5.20/include/linux/fs.h 2.5.20-sfr.2/include/linux/fs.h
--- 2.5.20/include/linux/fs.h	Mon Jun  3 12:17:08 2002
+++ 2.5.20-sfr.2/include/linux/fs.h	Thu Jun  6 01:34:26 2002
@@ -576,11 +576,11 @@
 
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
