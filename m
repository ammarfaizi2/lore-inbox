Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273424AbRIWLwv>; Sun, 23 Sep 2001 07:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273415AbRIWLwn>; Sun, 23 Sep 2001 07:52:43 -0400
Received: from mons.uio.no ([129.240.130.14]:58590 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S273414AbRIWLwd>;
	Sun, 23 Sep 2001 07:52:33 -0400
MIME-Version: 1.0
Message-ID: <15277.52482.300391.970844@charged.uio.no>
Date: Sun, 23 Sep 2001 13:52:34 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix 64-bit locking code in 2.4.10-preX
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

  The following constitutes a slight rewrite of a patch that has been
sent to you earlier by H.J.

  It fixes the locking code so that it conforms to the Single UNIX
specs. According to the latter, we need to return -EOVERFLOW rather
than -EINVAL whenever an offset overflows.

  In addition, the patch ensures that lockd and the NFS client both
recognize the (G|S)ETLK64 locking commands on 32-bit architectures.

  Finally, a small fix to the lockd xdr code. We need to zero unused
bytes in NFS filehandles as the comparisons all assume this.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.10-rdplus/fs/lockd/clntproc.c linux-2.4.10-locks/fs/lockd/clntproc.c
--- linux-2.4.10-rdplus/fs/lockd/clntproc.c	Mon Dec  4 03:01:01 2000
+++ linux-2.4.10-locks/fs/lockd/clntproc.c	Sat Sep 22 23:54:46 2001
@@ -142,7 +142,7 @@
 
 	/* If we're cleaning up locks because the process is exiting,
 	 * perform the RPC call asynchronously. */
-	if ((cmd == F_SETLK || cmd == F_SETLKW)
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd))
 	    && fl->fl_type == F_UNLCK
 	    && (current->flags & PF_EXITING)) {
 		sigfillset(&current->blocked);	/* Mask all signals */
@@ -166,17 +166,16 @@
 	/* Set up the argument struct */
 	nlmclnt_setlockargs(call, fl);
 
-	if (cmd == F_GETLK) {
+	if (IS_SETLK(cmd) || IS_SETLKW(cmd)) {
+		if (fl->fl_type != F_UNLCK) {
+			call->a_args.block = IS_SETLKW(cmd) ? 1 : 0;
+			status = nlmclnt_lock(call, fl);
+		} else
+			status = nlmclnt_unlock(call, fl);
+	} else if (IS_GETLK(cmd))
 		status = nlmclnt_test(call, fl);
-	} else if ((cmd == F_SETLK || cmd == F_SETLKW)
-		   && fl->fl_type == F_UNLCK) {
-		status = nlmclnt_unlock(call, fl);
-	} else if (cmd == F_SETLK || cmd == F_SETLKW) {
-		call->a_args.block = (cmd == F_SETLKW)? 1 : 0;
-		status = nlmclnt_lock(call, fl);
-	} else {
+	else
 		status = -EINVAL;
-	}
 
 	if (status < 0 && (call->a_flags & RPC_TASK_ASYNC))
 		kfree(call);
diff -u --recursive --new-file linux-2.4.10-rdplus/fs/lockd/xdr.c linux-2.4.10-locks/fs/lockd/xdr.c
--- linux-2.4.10-rdplus/fs/lockd/xdr.c	Sat Sep 22 15:42:00 2001
+++ linux-2.4.10-locks/fs/lockd/xdr.c	Sun Sep 23 12:03:25 2001
@@ -91,6 +91,7 @@
 		return NULL;
 	}
 	f->size = NFS2_FHSIZE;
+	memset(f->data, 0, sizeof(f->data));
 	memcpy(f->data, p, NFS2_FHSIZE);
 	return p + XDR_QUADLEN(NFS2_FHSIZE);
 }
diff -u --recursive --new-file linux-2.4.10-rdplus/fs/locks.c linux-2.4.10-locks/fs/locks.c
--- linux-2.4.10-rdplus/fs/locks.c	Sat Sep 22 15:42:01 2001
+++ linux-2.4.10-locks/fs/locks.c	Sat Sep 22 15:52:07 2001
@@ -257,7 +257,7 @@
 static int flock_to_posix_lock(struct file *filp, struct file_lock *fl,
 			       struct flock *l)
 {
-	loff_t start;
+	off_t start, end;
 
 	switch (l->l_whence) {
 	case 0: /*SEEK_SET*/
@@ -270,17 +270,16 @@
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
 	
@@ -292,7 +291,7 @@
 	fl->fl_insert = NULL;
 	fl->fl_remove = NULL;
 
-	return (assign_type(fl, l->l_type) == 0);
+	return assign_type(fl, l->l_type);
 }
 
 #if BITS_PER_LONG == 32
@@ -312,14 +311,14 @@
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
@@ -339,10 +338,10 @@
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
 
@@ -1370,8 +1369,8 @@
 	if (!filp)
 		goto out;
 
-	error = -EINVAL;
-	if (!flock_to_posix_lock(filp, &file_lock, &flock))
+	error = flock_to_posix_lock(filp, &file_lock, &flock);
+	if (error)
 		goto out_putf;
 
 	if (filp->f_op && filp->f_op->lock) {
@@ -1460,8 +1459,8 @@
 		}
 	}
 
-	error = -EINVAL;
-	if (!flock_to_posix_lock(filp, file_lock, &flock))
+	error = flock_to_posix_lock(filp, file_lock, &flock);
+	if (error)
 		goto out_putf;
 	
 	error = -EBADF;
@@ -1535,8 +1534,8 @@
 	if (!filp)
 		goto out;
 
-	error = -EINVAL;
-	if (!flock64_to_posix_lock(filp, &file_lock, &flock))
+	error = flock64_to_posix_lock(filp, &file_lock, &flock);
+	if (error)
 		goto out_putf;
 
 	if (filp->f_op && filp->f_op->lock) {
@@ -1613,8 +1612,8 @@
 		}
 	}
 
-	error = -EINVAL;
-	if (!flock64_to_posix_lock(filp, file_lock, &flock))
+	error = flock64_to_posix_lock(filp, file_lock, &flock);
+	if (error)
 		goto out_putf;
 	
 	error = -EBADF;
diff -u --recursive --new-file linux-2.4.10-rdplus/fs/nfs/file.c linux-2.4.10-locks/fs/nfs/file.c
--- linux-2.4.10-rdplus/fs/nfs/file.c	Sat Sep 22 15:42:04 2001
+++ linux-2.4.10-locks/fs/nfs/file.c	Sat Sep 22 23:14:03 2001
@@ -264,7 +264,7 @@
 
 	/* Fake OK code if mounted without NLM support */
 	if (NFS_SERVER(inode)->flags & NFS_MOUNT_NONLM) {
-		if (cmd == F_GETLK)
+		if (IS_GETLK(cmd))
 			status = LOCK_USE_CLNT;
 		goto out_ok;
 	}
@@ -304,7 +304,7 @@
 	 * This makes locking act as a cache coherency point.
 	 */
  out_ok:
-	if ((cmd == F_SETLK || cmd == F_SETLKW) && fl->fl_type != F_UNLCK) {
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
 		filemap_fdatasync(inode->i_mapping);
 		down(&inode->i_sem);
 		nfs_wb_all(inode);      /* we may have slept */
diff -u --recursive --new-file linux-2.4.10-rdplus/include/linux/fcntl.h linux-2.4.10-locks/include/linux/fcntl.h
--- linux-2.4.10-rdplus/include/linux/fcntl.h	Sat Sep 22 16:04:07 2001
+++ linux-2.4.10-locks/include/linux/fcntl.h	Sun Sep 23 10:38:39 2001
@@ -23,4 +23,28 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+#ifdef __KERNEL__
+
+#if BITS_PER_LONG == 32
+#define IS_GETLK32(cmd)		((cmd) == F_GETLK)
+#define IS_SETLK32(cmd)		((cmd) == F_SETLK)
+#define IS_SETLKW32(cmd)	((cmd) == F_SETLKW)
+#define IS_GETLK64(cmd)		((cmd) == F_GETLK64)
+#define IS_SETLK64(cmd)		((cmd) == F_SETLK64)
+#define IS_SETLKW64(cmd)	((cmd) == F_SETLKW64)
+#else
+#define IS_GETLK32(cmd)		(0)
+#define IS_SETLK32(cmd)		(0)
+#define IS_SETLKW32(cmd)	(0)
+#define IS_GETLK64(cmd)		((cmd) == F_GETLK)
+#define IS_SETLK64(cmd)		((cmd) == F_SETLK)
+#define IS_SETLKW64(cmd)	((cmd) == F_SETLKW)
+#endif /* BITS_PER_LONG == 32 */
+
+#define IS_GETLK(cmd)	(IS_GETLK32(cmd)  || IS_GETLK64(cmd))
+#define IS_SETLK(cmd)	(IS_SETLK32(cmd)  || IS_SETLK64(cmd))
+#define IS_SETLKW(cmd)	(IS_SETLKW32(cmd) || IS_SETLKW64(cmd))
+
+#endif /* __KERNEL__ */
+
 #endif

