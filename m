Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAYXm0>; Thu, 25 Jan 2001 18:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132884AbRAYXmJ>; Thu, 25 Jan 2001 18:42:09 -0500
Received: from mail.valinux.com ([198.186.202.175]:22028 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129143AbRAYXmA>;
	Thu, 25 Jan 2001 18:42:00 -0500
Date: Thu, 25 Jan 2001 15:41:33 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: nfs@lists.sourceforge.net, linux kernel <linux-kernel@vger.kernel.org>
Subject: A NFS/LFS patch for kernel 2.4.0
Message-ID: <20010125154133.A13644@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch for kernel 2.4.0. Without it, kernel 2.4.0 won't pass
the Connectathon Testsuite.

-- 
H.J. Lu (hjl@valinux.com)
---
--- linux/fs/lockd/clntproc.c.lfs	Sun Dec  3 18:01:01 2000
+++ linux/fs/lockd/clntproc.c	Thu Jan 25 14:58:42 2001
@@ -142,7 +142,8 @@ nlmclnt_proc(struct inode *inode, int cm
 
 	/* If we're cleaning up locks because the process is exiting,
 	 * perform the RPC call asynchronously. */
-	if ((cmd == F_SETLK || cmd == F_SETLKW)
+	if ((cmd == F_SETLK || cmd == F_SETLKW
+	     || cmd == F_SETLK64 || cmd == F_SETLKW64)
 	    && fl->fl_type == F_UNLCK
 	    && (current->flags & PF_EXITING)) {
 		sigfillset(&current->blocked);	/* Mask all signals */
@@ -166,13 +167,15 @@ nlmclnt_proc(struct inode *inode, int cm
 	/* Set up the argument struct */
 	nlmclnt_setlockargs(call, fl);
 
-	if (cmd == F_GETLK) {
+	if (cmd == F_GETLK || cmd == F_GETLK64) {
 		status = nlmclnt_test(call, fl);
-	} else if ((cmd == F_SETLK || cmd == F_SETLKW)
+	} else if ((cmd == F_SETLK || cmd == F_SETLKW
+		    || cmd == F_SETLK64 || cmd == F_SETLKW64)
 		   && fl->fl_type == F_UNLCK) {
 		status = nlmclnt_unlock(call, fl);
-	} else if (cmd == F_SETLK || cmd == F_SETLKW) {
-		call->a_args.block = (cmd == F_SETLKW)? 1 : 0;
+	} else if (cmd == F_SETLK || cmd == F_SETLKW
+		   || cmd == F_SETLK64 || cmd == F_SETLKW64) {
+		call->a_args.block = (cmd == F_SETLKW) || cmd == F_SETLKW64? 1 : 0;
 		status = nlmclnt_lock(call, fl);
 	} else {
 		status = -EINVAL;
--- linux/fs/locks.c.lfs	Sun Dec  3 10:24:07 2000
+++ linux/fs/locks.c	Thu Jan 25 15:12:31 2001
@@ -257,7 +257,7 @@ static int assign_type(struct file_lock 
 static int flock_to_posix_lock(struct file *filp, struct file_lock *fl,
 			       struct flock *l)
 {
-	loff_t start;
+	off_t start, end;
 
 	switch (l->l_whence) {
 	case 0: /*SEEK_SET*/
@@ -270,17 +270,16 @@ static int flock_to_posix_lock(struct fi
 		start = filp->f_dentry->d_inode->i_size;
 		break;
 	default:
-		return (0);
+		return -EINVAL;
 	}
 
 	if (((start += l->l_start) < 0) || (l->l_len < 0))
-		return (0);
-	fl->fl_end = start + l->l_len - 1;
-	if (l->l_len > 0 && fl->fl_end < 0)
-		return (0);
-	if (fl->fl_end > OFFT_OFFSET_MAX)
-		return 0;
+		return -EINVAL;
+	end = start + l->l_len - 1;
+	if (l->l_len > 0 && end < 0)
+		return -EOVERFLOW;
 	fl->fl_start = start;	/* we record the absolute position */
+	fl->fl_end = end;
 	if (l->l_len == 0)
 		fl->fl_end = OFFSET_MAX;
 	
@@ -292,7 +291,7 @@ static int flock_to_posix_lock(struct fi
 	fl->fl_insert = NULL;
 	fl->fl_remove = NULL;
 
-	return (assign_type(fl, l->l_type) == 0);
+	return assign_type(fl, l->l_type);
 }
 
 #if BITS_PER_LONG == 32
@@ -312,14 +311,14 @@ static int flock64_to_posix_lock(struct 
 		start = filp->f_dentry->d_inode->i_size;
 		break;
 	default:
-		return (0);
+		return -EINVAL;
 	}
 
 	if (((start += l->l_start) < 0) || (l->l_len < 0))
-		return (0);
+		return -EINVAL;
 	fl->fl_end = start + l->l_len - 1;
 	if (l->l_len > 0 && fl->fl_end < 0)
-		return (0);
+		return -EOVERFLOW;
 	fl->fl_start = start;	/* we record the absolute position */
 	if (l->l_len == 0)
 		fl->fl_end = OFFSET_MAX;
@@ -339,10 +338,10 @@ static int flock64_to_posix_lock(struct 
 		fl->fl_type = l->l_type;
 		break;
 	default:
-		return (0);
+		return -EINVAL;
 	}
 
-	return (1);
+	return (0);
 }
 #endif
 
@@ -1352,8 +1351,8 @@ int fcntl_getlk(unsigned int fd, struct 
 	if (!filp)
 		goto out;
 
-	error = -EINVAL;
-	if (!flock_to_posix_lock(filp, &file_lock, &flock))
+	error = flock_to_posix_lock(filp, &file_lock, &flock);
+	if (error)
 		goto out_putf;
 
 	if (filp->f_op && filp->f_op->lock) {
@@ -1442,8 +1441,8 @@ int fcntl_setlk(unsigned int fd, unsigne
 		}
 	}
 
-	error = -EINVAL;
-	if (!flock_to_posix_lock(filp, file_lock, &flock))
+	error = flock_to_posix_lock(filp, file_lock, &flock);
+	if (error)
 		goto out_putf;
 	
 	error = -EBADF;
@@ -1517,8 +1516,8 @@ int fcntl_getlk64(unsigned int fd, struc
 	if (!filp)
 		goto out;
 
-	error = -EINVAL;
-	if (!flock64_to_posix_lock(filp, &file_lock, &flock))
+	error = flock64_to_posix_lock(filp, &file_lock, &flock);
+	if (error)
 		goto out_putf;
 
 	if (filp->f_op && filp->f_op->lock) {
@@ -1595,8 +1594,8 @@ int fcntl_setlk64(unsigned int fd, unsig
 		}
 	}
 
-	error = -EINVAL;
-	if (!flock64_to_posix_lock(filp, file_lock, &flock))
+	error = flock64_to_posix_lock(filp, file_lock, &flock);
+	if (error)
 		goto out_putf;
 	
 	error = -EBADF;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
