Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbUDQJxI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 05:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUDQJxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 05:53:08 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:40635 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263768AbUDQJtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 05:49:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Consolidate sys32_readv and sys32_writev
Date: Fri, 16 Apr 2004 18:02:19 +0200
User-Agent: KMail/1.6.1
References: <200404161800.22367.arnd@arndb.de>
In-Reply-To: <200404161800.22367.arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404161802.19673.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The seven implementations of this have gone out of sync and are mostly buggy.
The new compat_sys_* version is based on the ppc64 implementation, which
most closely resembles the code in sys_readv/sys_writev.

Tested on x86_64, ia64 and s390.

 arch/ia64/ia32/ia32_entry.S        |    4
 arch/ia64/ia32/sys_ia32.c          |   79 ---------------
 arch/mips/kernel/linux32.c         |  144 ----------------------------
 arch/mips/kernel/scall64-n32.S     |    4
 arch/mips/kernel/scall64-o32.S     |    4
 arch/parisc/kernel/sys_parisc32.c  |  143 ----------------------------
 arch/parisc/kernel/syscall_table.S |    4
 arch/ppc64/kernel/misc.S           |    4
 arch/ppc64/kernel/sys_ppc32.c      |  172 ----------------------------------
 arch/s390/kernel/compat_linux.c    |  138 ---------------------------
 arch/s390/kernel/compat_wrapper.S  |   16 +--
 arch/s390/kernel/syscalls.S        |    4
 arch/sparc64/kernel/sys_sparc32.c  |  176 -----------------------------------
 arch/sparc64/kernel/sys_sunos32.c  |    7 -
 arch/sparc64/kernel/systbls.S      |    2
 arch/x86_64/ia32/ia32entry.S       |    4
 arch/x86_64/ia32/sys_ia32.c        |   98 -------------------
 fs/compat.c                        |  186 +++++++++++++++++++++++++++++++++++++
 include/linux/compat.h             |    6 +
 19 files changed, 217 insertions(+), 978 deletions(-)

===== arch/ia64/ia32/ia32_entry.S 1.35 vs edited =====
--- 1.35/arch/ia64/ia32/ia32_entry.S	Fri Mar 26 20:05:24 2004
+++ edited/arch/ia64/ia32/ia32_entry.S	Thu Apr 15 17:22:00 2004
@@ -353,8 +353,8 @@
 	data8 sys32_select
 	data8 sys_flock
 	data8 sys32_msync
-	data8 sys32_readv	  /* 145 */
-	data8 sys32_writev
+	data8 compat_sys_readv	  /* 145 */
+	data8 compat_sys_writev
 	data8 sys_getsid
 	data8 sys_fdatasync
 	data8 sys32_sysctl
===== arch/ia64/ia32/sys_ia32.c 1.94 vs edited =====
--- 1.94/arch/ia64/ia32/sys_ia32.c	Mon Apr 12 19:54:22 2004
+++ edited/arch/ia64/ia32/sys_ia32.c	Thu Apr 15 17:22:00 2004
@@ -941,85 +941,6 @@
 			    (struct compat_timeval *) A(a.tvp));
 }
 
-static struct iovec *
-get_compat_iovec (struct compat_iovec *iov32, struct iovec *iov_buf, u32 count, int type)
-{
-	u32 i, buf, len;
-	struct iovec *ivp, *iov;
-
-	/* Get the "struct iovec" from user memory */
-
-	if (!count)
-		return 0;
-	if (verify_area(VERIFY_READ, iov32, sizeof(struct compat_iovec)*count))
-		return NULL;
-	if (count > UIO_MAXIOV)
-		return NULL;
-	if (count > UIO_FASTIOV) {
-		iov = kmalloc(count*sizeof(struct iovec), GFP_KERNEL);
-		if (!iov)
-			return NULL;
-	} else
-		iov = iov_buf;
-
-	ivp = iov;
-	for (i = 0; i < count; i++) {
-		if (__get_user(len, &iov32->iov_len) || __get_user(buf, &iov32->iov_base)) {
-			if (iov != iov_buf)
-				kfree(iov);
-			return NULL;
-		}
-		if (verify_area(type, (void *)A(buf), len)) {
-			if (iov != iov_buf)
-				kfree(iov);
-			return((struct iovec *)0);
-		}
-		ivp->iov_base = (void *)A(buf);
-		ivp->iov_len = (__kernel_size_t) len;
-		iov32++;
-		ivp++;
-	}
-	return iov;
-}
-
-asmlinkage long
-sys32_readv (int fd, struct compat_iovec *vector, u32 count)
-{
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov;
-	long ret;
-	mm_segment_t old_fs = get_fs();
-
-	iov = get_compat_iovec(vector, iovstack, count, VERIFY_WRITE);
-	if (!iov)
-		return -EFAULT;
-	set_fs(KERNEL_DS);
-	ret = sys_readv(fd, iov, count);
-	set_fs(old_fs);
-	if (iov != iovstack)
-		kfree(iov);
-	return ret;
-}
-
-asmlinkage long
-sys32_writev (int fd, struct compat_iovec *vector, u32 count)
-{
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov;
-	long ret;
-	mm_segment_t old_fs = get_fs();
-
-	iov = get_compat_iovec(vector, iovstack, count, VERIFY_READ);
-	if (!iov)
-		return -EFAULT;
-	set_fs(KERNEL_DS);
-	ret = sys_writev(fd, iov, count);
-	set_fs(old_fs);
-	if (iov != iovstack)
-		kfree(iov);
-	return ret;
-}
-
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
===== arch/mips/kernel/linux32.c 1.22 vs edited =====
--- 1.22/arch/mips/kernel/linux32.c	Wed Feb 25 11:31:12 2004
+++ edited/arch/mips/kernel/linux32.c	Thu Apr 15 17:22:00 2004
@@ -671,150 +671,6 @@
 	return sys_llseek(fd, offset_high, offset_low, result, origin);
 }
 
-typedef ssize_t (*IO_fn_t)(struct file *, char *, size_t, loff_t *);
-
-static long
-do_readv_writev32(int type, struct file *file, const struct compat_iovec *vector,
-		  u32 count)
-{
-	unsigned long tot_len;
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov=iovstack, *ivp;
-	struct inode *inode;
-	long retval, i;
-	IO_fn_t fn;
-
-	/* First get the "struct iovec" from user memory and
-	 * verify all the pointers
-	 */
-	if (!count)
-		return 0;
-	if(verify_area(VERIFY_READ, vector, sizeof(struct compat_iovec)*count))
-		return -EFAULT;
-	if (count > UIO_MAXIOV)
-		return -EINVAL;
-	if (count > UIO_FASTIOV) {
-		iov = kmalloc(count*sizeof(struct iovec), GFP_KERNEL);
-		if (!iov)
-			return -ENOMEM;
-	}
-
-	tot_len = 0;
-	i = count;
-	ivp = iov;
-	while (i > 0) {
-		u32 len;
-		u32 buf;
-
-		__get_user(len, &vector->iov_len);
-		__get_user(buf, &vector->iov_base);
-		tot_len += len;
-		ivp->iov_base = (void *)A(buf);
-		ivp->iov_len = (__kernel_size_t) len;
-		vector++;
-		ivp++;
-		i--;
-	}
-
-	inode = file->f_dentry->d_inode;
-	/* VERIFY_WRITE actually means a read, as we write to user space */
-	retval = locks_verify_area((type == VERIFY_WRITE
-				    ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
-				   inode, file, file->f_pos, tot_len);
-	if (retval) {
-		if (iov != iovstack)
-			kfree(iov);
-		return retval;
-	}
-
-	/* Then do the actual IO.  Note that sockets need to be handled
-	 * specially as they have atomicity guarantees and can handle
-	 * iovec's natively
-	 */
-#ifdef CONFIG_NET
-	if (inode->i_sock) {
-		int err;
-		err = sock_readv_writev(type, inode, file, iov, count, tot_len);
-		if (iov != iovstack)
-			kfree(iov);
-		return err;
-	}
-#endif
-
-	if (!file->f_op) {
-		if (iov != iovstack)
-			kfree(iov);
-		return -EINVAL;
-	}
-	/* VERIFY_WRITE actually means a read, as we write to user space */
-	fn = file->f_op->read;
-	if (type == VERIFY_READ)
-		fn = (IO_fn_t) file->f_op->write;
-	ivp = iov;
-	while (count > 0) {
-		void * base;
-		int len, nr;
-
-		base = ivp->iov_base;
-		len = ivp->iov_len;
-		ivp++;
-		count--;
-		nr = fn(file, base, len, &file->f_pos);
-		if (nr < 0) {
-			if (retval)
-				break;
-			retval = nr;
-			break;
-		}
-		retval += nr;
-		if (nr != len)
-			break;
-	}
-	if (iov != iovstack)
-		kfree(iov);
-
-	return retval;
-}
-
-asmlinkage long
-sys32_readv(int fd, struct compat_iovec *vector, u32 count)
-{
-	struct file *file;
-	ssize_t ret;
-
-	ret = -EBADF;
-	file = fget(fd);
-	if (!file)
-		goto bad_file;
-	if (file->f_op && (file->f_mode & FMODE_READ) &&
-	    (file->f_op->readv || file->f_op->read))
-		ret = do_readv_writev32(VERIFY_WRITE, file, vector, count);
-
-	fput(file);
-
-bad_file:
-	return ret;
-}
-
-asmlinkage long
-sys32_writev(int fd, struct compat_iovec *vector, u32 count)
-{
-	struct file *file;
-	ssize_t ret;
-
-	ret = -EBADF;
-	file = fget(fd);
-	if(!file)
-		goto bad_file;
-	if (file->f_op && (file->f_mode & FMODE_WRITE) &&
-	    (file->f_op->writev || file->f_op->write))
-	        ret = do_readv_writev32(VERIFY_READ, file, vector, count);
-	fput(file);
-
-bad_file:
-	return ret;
-}
-
 /* From the Single Unix Spec: pread & pwrite act like lseek to pos + op +
    lseek back to original location.  They fail just like lseek does on
    non-seekable files.  */
===== arch/mips/kernel/scall64-n32.S 1.2 vs edited =====
--- 1.2/arch/mips/kernel/scall64-n32.S	Thu Feb 19 21:53:00 2004
+++ edited/arch/mips/kernel/scall64-n32.S	Thu Apr 15 17:22:00 2004
@@ -128,8 +128,8 @@
 	PTR	compat_sys_ioctl		/* 6015 */
 	PTR	sys_pread64
 	PTR	sys_pwrite64
-	PTR	sys32_readv
-	PTR	sys32_writev
+	PTR	compat_sys_readv
+	PTR	compat_sys_writev
 	PTR	sys_access			/* 6020 */
 	PTR	sys_pipe
 	PTR	sys32_select
===== arch/mips/kernel/scall64-o32.S 1.2 vs edited =====
--- 1.2/arch/mips/kernel/scall64-o32.S	Thu Feb 19 21:53:00 2004
+++ edited/arch/mips/kernel/scall64-o32.S	Thu Apr 15 17:22:00 2004
@@ -400,8 +400,8 @@
 	sys	sys32_select	5
 	sys	sys_flock	2
 	sys	sys_msync	3
-	sys	sys32_readv	3			/* 4145 */
-	sys	sys32_writev	3
+	sys	compat_sys_readv	3		/* 4145 */
+	sys	compat_sys_writev	3
 	sys	sys_cacheflush	3
 	sys	sys_cachectl	3
 	sys	sys_sysmips	4
===== arch/parisc/kernel/sys_parisc32.c 1.25 vs edited =====
--- 1.25/arch/parisc/kernel/sys_parisc32.c	Mon Apr 12 19:54:22 2004
+++ edited/arch/parisc/kernel/sys_parisc32.c	Thu Apr 15 17:22:00 2004
@@ -609,149 +609,6 @@
 	return error;
 }
 
-/* readv/writev stolen from mips64 */
-typedef ssize_t (*IO_fn_t)(struct file *, char *, size_t, loff_t *);
-
-static long
-do_readv_writev32(int type, struct file *file, const struct compat_iovec *vector,
-		  u32 count)
-{
-	unsigned long tot_len;
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov=iovstack, *ivp;
-	struct inode *inode;
-	long retval, i;
-	IO_fn_t fn;
-
-	/* First get the "struct iovec" from user memory and
-	 * verify all the pointers
-	 */
-	if (!count)
-		return 0;
-	if(verify_area(VERIFY_READ, vector, sizeof(struct compat_iovec)*count))
-		return -EFAULT;
-	if (count > UIO_MAXIOV)
-		return -EINVAL;
-	if (count > UIO_FASTIOV) {
-		iov = kmalloc(count*sizeof(struct iovec), GFP_KERNEL);
-		if (!iov)
-			return -ENOMEM;
-	}
-
-	tot_len = 0;
-	i = count;
-	ivp = iov;
-	while (i > 0) {
-		u32 len;
-		u32 buf;
-
-		__get_user(len, &vector->iov_len);
-		__get_user(buf, &vector->iov_base);
-		tot_len += len;
-		ivp->iov_base = compat_ptr(buf);
-		ivp->iov_len = (compat_size_t) len;
-		vector++;
-		ivp++;
-		i--;
-	}
-
-	inode = file->f_dentry->d_inode;
-	/* VERIFY_WRITE actually means a read, as we write to user space */
-	retval = locks_verify_area((type == VERIFY_WRITE
-				    ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
-				   inode, file, file->f_pos, tot_len);
-	if (retval) {
-		if (iov != iovstack)
-			kfree(iov);
-		return retval;
-	}
-
-	/* Then do the actual IO.  Note that sockets need to be handled
-	 * specially as they have atomicity guarantees and can handle
-	 * iovec's natively
-	 */
-	if (inode->i_sock) {
-		int err;
-		err = sock_readv_writev(type, inode, file, iov, count, tot_len);
-		if (iov != iovstack)
-			kfree(iov);
-		return err;
-	}
-
-	if (!file->f_op) {
-		if (iov != iovstack)
-			kfree(iov);
-		return -EINVAL;
-	}
-	/* VERIFY_WRITE actually means a read, as we write to user space */
-	fn = file->f_op->read;
-	if (type == VERIFY_READ)
-		fn = (IO_fn_t) file->f_op->write;		
-	ivp = iov;
-	while (count > 0) {
-		void * base;
-		int len, nr;
-
-		base = ivp->iov_base;
-		len = ivp->iov_len;
-		ivp++;
-		count--;
-		nr = fn(file, base, len, &file->f_pos);
-		if (nr < 0) {
-			if (retval)
-				break;
-			retval = nr;
-			break;
-		}
-		retval += nr;
-		if (nr != len)
-			break;
-	}
-	if (iov != iovstack)
-		kfree(iov);
-
-	return retval;
-}
-
-asmlinkage long
-sys32_readv(int fd, struct compat_iovec *vector, u32 count)
-{
-	struct file *file;
-	ssize_t ret;
-
-	ret = -EBADF;
-	file = fget(fd);
-	if (!file)
-		goto bad_file;
-	if (file->f_op && (file->f_mode & FMODE_READ) &&
-	    (file->f_op->readv || file->f_op->read))
-		ret = do_readv_writev32(VERIFY_WRITE, file, vector, count);
-
-	fput(file);
-
-bad_file:
-	return ret;
-}
-
-asmlinkage long
-sys32_writev(int fd, struct compat_iovec *vector, u32 count)
-{
-	struct file *file;
-	ssize_t ret;
-
-	ret = -EBADF;
-	file = fget(fd);
-	if(!file)
-		goto bad_file;
-	if (file->f_op && (file->f_mode & FMODE_WRITE) &&
-	    (file->f_op->writev || file->f_op->write))
-	        ret = do_readv_writev32(VERIFY_READ, file, vector, count);
-	fput(file);
-
-bad_file:
-	return ret;
-}
-
 /*** copied from mips64 ***/
 /*
  * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
===== arch/parisc/kernel/syscall_table.S 1.4 vs edited =====
--- 1.4/arch/parisc/kernel/syscall_table.S	Fri Mar 26 20:05:25 2004
+++ edited/arch/parisc/kernel/syscall_table.S	Thu Apr 15 17:22:00 2004
@@ -236,8 +236,8 @@
 	ENTRY_SAME(flock)
 	ENTRY_SAME(msync)
 	/* struct iovec contains pointers */
-	ENTRY_DIFF(readv)		/* 145 */
-	ENTRY_DIFF(writev)
+	ENTRY_COMP(readv)		/* 145 */
+	ENTRY_COMP(writev)
 	ENTRY_SAME(getsid)
 	ENTRY_SAME(fdatasync)
 	/* struct __sysctl_args is a mess */
===== arch/ppc64/kernel/misc.S 1.75 vs edited =====
--- 1.75/arch/ppc64/kernel/misc.S	Mon Apr 12 19:54:08 2004
+++ edited/arch/ppc64/kernel/misc.S	Thu Apr 15 17:22:00 2004
@@ -717,8 +717,8 @@
 	.llong .ppc32_select
 	.llong .sys_flock
 	.llong .sys_msync
-	.llong .sys32_readv		/* 145 */
-	.llong .sys32_writev
+	.llong .compat_sys_readv	/* 145 */
+	.llong .compat_sys_writev
 	.llong .sys32_getsid
 	.llong .sys_fdatasync
 	.llong .sys32_sysctl
===== arch/ppc64/kernel/sys_ppc32.c 1.86 vs edited =====
--- 1.86/arch/ppc64/kernel/sys_ppc32.c	Wed Mar 24 13:24:38 2004
+++ edited/arch/ppc64/kernel/sys_ppc32.c	Thu Apr 15 17:22:00 2004
@@ -78,178 +78,6 @@
 
 #include "pci.h"
 
-typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
-typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
-
-static long do_readv_writev32(int type, struct file *file,
-			      const struct compat_iovec *vector, u32 count)
-{
-	compat_ssize_t tot_len;
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov=iovstack, *ivp;
-	struct inode *inode;
-	long retval, i;
-	io_fn_t fn;
-	iov_fn_t fnv;
-
-	/*
-	 * SuS says "The readv() function *may* fail if the iovcnt argument
-	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
-	 * traditionally returned zero for zero segments, so...
-	 */
-	retval = 0;
-	if (count == 0)
-		goto out;
-
-	/* First get the "struct iovec" from user memory and
-	 * verify all the pointers
-	 */
-	retval = -EINVAL;
-	if (count > UIO_MAXIOV)
-		goto out;
-	if (!file->f_op)
-		goto out;
-	if (count > UIO_FASTIOV) {
-		retval = -ENOMEM;
-		iov = kmalloc(count*sizeof(struct iovec), GFP_KERNEL);
-		if (!iov)
-			goto out;
-	}
-	retval = -EFAULT;
-	if (verify_area(VERIFY_READ, vector, sizeof(struct compat_iovec)*count))
-		goto out;
-
-	/*
-	 * Single unix specification:
-	 * We should -EINVAL if an element length is not >= 0 and fitting an
-	 * ssize_t.  The total length is fitting an ssize_t
-	 *
-	 * Be careful here because iov_len is a size_t not an ssize_t
-	 */
-	tot_len = 0;
-	i = count;
-	ivp = iov;
-	retval = -EINVAL;
-	while(i > 0) {
-		compat_ssize_t tmp = tot_len;
-		compat_ssize_t len;
-		u32 buf;
-
-		if (__get_user(len, &vector->iov_len) ||
-		    __get_user(buf, &vector->iov_base)) {
-			retval = -EFAULT;
-			goto out;
-		}
-		if (len < 0)	/* size_t not fitting an compat_ssize_t .. */
-			goto out;
-		tot_len += len;
-		if (tot_len < tmp) /* maths overflow on the compat_ssize_t */
-			goto out;
-		ivp->iov_base = (void *)A(buf);
-		ivp->iov_len = (__kernel_size_t) len;
-		vector++;
-		ivp++;
-		i--;
-	}
-	if (tot_len == 0) {
-		retval = 0;
-		goto out;
-	}
-
-	inode = file->f_dentry->d_inode;
-	/* VERIFY_WRITE actually means a read, as we write to user space */
-	retval = locks_verify_area((type == READ
-				    ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
-				   inode, file, file->f_pos, tot_len);
-	if (retval)
-		goto out;
-
-	if (type == READ) {
-		fn = file->f_op->read;
-		fnv = file->f_op->readv;
-	} else {
-		fn = (io_fn_t)file->f_op->write;
-		fnv = file->f_op->writev;
-	}
-	if (fnv) {
-		retval = fnv(file, iov, count, &file->f_pos);
-		goto out;
-	}
-
-	/* Do it by hand, with file-ops */
-	ivp = iov;
-	while (count > 0) {
-		void * base;
-		int len, nr;
-
-		base = ivp->iov_base;
-		len = ivp->iov_len;
-		ivp++;
-		count--;
-
-		nr = fn(file, base, len, &file->f_pos);
-
-		if (nr < 0) {
-			if (!retval)
-				retval = nr;
-			break;
-		}
-		retval += nr;
-		if (nr != len)
-			break;
-	}
-out:
-	if (iov != iovstack)
-		kfree(iov);
-	if ((retval + (type == READ)) > 0)
-		dnotify_parent(file->f_dentry,
-			       (type == READ) ? DN_ACCESS : DN_MODIFY);
-
-	return retval;
-}
-
-asmlinkage long sys32_readv(int fd, struct compat_iovec *vector, u32 count)
-{
-	struct file *file;
-	int ret = -EBADF;
-
-	file = fget(fd);
-	if (!file || !(file->f_mode & FMODE_READ))
-		goto out; 
-
-	ret = -EINVAL;
-	if (!file->f_op || (!file->f_op->readv && !file->f_op->read))
-		goto out;
-
-	ret = do_readv_writev32(READ, file, vector, count);
-
-out:
-	if (file)
-		fput(file);
-	return ret;
-}
-
-asmlinkage long sys32_writev(int fd, struct compat_iovec *vector, u32 count)
-{
-	struct file *file;
-	int ret = -EBADF;
-
-	file = fget(fd);
-	if (!file || !(file->f_mode & FMODE_WRITE))
-		goto out;
-
-	ret = -EINVAL;
-	if (!file->f_op || (!file->f_op->writev && !file->f_op->write))
-		goto out;
-
-	ret = do_readv_writev32(WRITE, file, vector, count);
-
-out:
-	if (file)
-		fput(file);
-	return ret;
-}
-
 /* readdir & getdents */
 #define NAME_OFFSET(de) ((int) ((de)->d_name - (char *) (de)))
 #define ROUND_UP(x) (((x)+sizeof(u32)-1) & ~(sizeof(u32)-1))
===== arch/s390/kernel/compat_linux.c 1.19 vs edited =====
--- 1.19/arch/s390/kernel/compat_linux.c	Sat Mar 27 22:46:54 2004
+++ edited/arch/s390/kernel/compat_linux.c	Thu Apr 15 17:22:00 2004
@@ -373,144 +373,6 @@
 		return sys_ftruncate(fd, (high << 32) | low);
 }
 
-typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
-typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
-
-static long do_readv_writev32(int type, struct file *file,
-			      const struct compat_iovec *vector, u32 count)
-{
-	unsigned long tot_len;
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov=iovstack, *ivp;
-	struct inode *inode;
-	long retval, i;
-	io_fn_t fn;
-	iov_fn_t fnv;
-
-	/* First get the "struct iovec" from user memory and
-	 * verify all the pointers
-	 */
-	if (!count)
-		return 0;
-	if (verify_area(VERIFY_READ, vector, sizeof(struct compat_iovec)*count))
-		return -EFAULT;
-	if (count > UIO_MAXIOV)
-		return -EINVAL;
-	if (count > UIO_FASTIOV) {
-		iov = kmalloc(count*sizeof(struct iovec), GFP_KERNEL);
-		if (!iov)
-			return -ENOMEM;
-	}
-
-	tot_len = 0;
-	i = count;
-	ivp = iov;
-	retval = -EINVAL;
-	while(i > 0) {
-		compat_ssize_t tmp = tot_len;
-		compat_ssize_t len;
-		u32 buf;
-
-		if (__get_user(len, &vector->iov_len) ||
-		    __get_user(buf, &vector->iov_base)) {
-			retval = -EFAULT;
-			goto out;
-		}
-		if (len < 0)	/* size_t not fitting an ssize_t32 .. */
-			goto out;
-		tot_len += len;
-		if (tot_len < tmp) /* maths overflow on the compat_ssize_t */
-			goto out;
-		ivp->iov_base = (void *)A(buf);
-		ivp->iov_len = (__kernel_size_t) len;
-		vector++;
-		ivp++;
-		i--;
-	}
-	if (tot_len == 0) {
-		retval = 0;
-		goto out;
-	}
-
-	inode = file->f_dentry->d_inode;
-	/* VERIFY_WRITE actually means a read, as we write to user space */
-	retval = locks_verify_area((type == VERIFY_WRITE
-				    ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
-				   inode, file, file->f_pos, tot_len);
-	if (retval)
-		goto out;
-
-	/* VERIFY_WRITE actually means a read, as we write to user space */
-	fnv = (type == VERIFY_WRITE ? file->f_op->readv : file->f_op->writev);
-	if (fnv) {
-		retval = fnv(file, iov, count, &file->f_pos);
-		goto out;
-	}
-
-	fn = (type == VERIFY_WRITE ? file->f_op->read :
-	      (io_fn_t) file->f_op->write);
-
-	ivp = iov;
-	while (count > 0) {
-		void * base;
-		int len, nr;
-
-		base = ivp->iov_base;
-		len = ivp->iov_len;
-		ivp++;
-		count--;
-		nr = fn(file, base, len, &file->f_pos);
-		if (nr < 0) {
-			if (!retval)
-				retval = nr;
-			break;
-		}
-		retval += nr;
-		if (nr != len)
-			break;
-	}
-out:
-	if (iov != iovstack)
-		kfree(iov);
-
-	return retval;
-}
-
-asmlinkage long sys32_readv(int fd, struct compat_iovec *vector, unsigned long count)
-{
-	struct file *file;
-	long ret = -EBADF;
-
-	file = fget(fd);
-	if(!file)
-		goto bad_file;
-
-	if (file->f_op && (file->f_mode & FMODE_READ) &&
-	    (file->f_op->readv || file->f_op->read))
-		ret = do_readv_writev32(VERIFY_WRITE, file, vector, count);
-	fput(file);
-
-bad_file:
-	return ret;
-}
-
-asmlinkage long sys32_writev(int fd, struct compat_iovec *vector, unsigned long count)
-{
-	struct file *file;
-	int ret = -EBADF;
-
-	file = fget(fd);
-	if(!file)
-		goto bad_file;
-	if (file->f_op && (file->f_mode & FMODE_WRITE) &&
-	    (file->f_op->writev || file->f_op->write))
-		ret = do_readv_writev32(VERIFY_READ, file, vector, count);
-	fput(file);
-
-bad_file:
-	return ret;
-}
-
 /* readdir & getdents */
 
 #define NAME_OFFSET(de) ((int) ((de)->d_name - (char *) (de)))
===== arch/s390/kernel/compat_wrapper.S 1.9 vs edited =====
--- 1.9/arch/s390/kernel/compat_wrapper.S	Sat Mar 27 22:43:12 2004
+++ edited/arch/s390/kernel/compat_wrapper.S	Thu Apr 15 17:22:00 2004
@@ -663,19 +663,19 @@
 	lgfr	%r4,%r4			# int
 	jg	sys_msync		# branch to system call
 
-	.globl  sys32_readv_wrapper 
-sys32_readv_wrapper:
+	.globl  compat_sys_readv_wrapper 
+compat_sys_readv_wrapper:
 	lgfr	%r2,%r2			# int
-	llgtr	%r3,%r3			# const struct iovec_emu31 *
+	llgtr	%r3,%r3			# const struct compat_iovec *
 	llgfr	%r4,%r4			# unsigned long
-	jg	sys32_readv		# branch to system call
+	jg	compat_sys_readv	# branch to system call
 
-	.globl  sys32_writev_wrapper 
-sys32_writev_wrapper:
+	.globl  compat_sys_writev_wrapper 
+compat_sys_writev_wrapper:
 	lgfr	%r2,%r2			# int
-	llgtr	%r3,%r3			# const struct iovec_emu31 *
+	llgtr	%r3,%r3			# const struct compat_iovec *
 	llgfr	%r4,%r4			# unsigned long
-	jg	sys32_writev		# branch to system call
+	jg	compat_sys_writev	# branch to system call
 
 	.globl  sys32_getsid_wrapper 
 sys32_getsid_wrapper:
===== arch/s390/kernel/syscalls.S 1.9 vs edited =====
--- 1.9/arch/s390/kernel/syscalls.S	Wed Mar 17 13:02:24 2004
+++ edited/arch/s390/kernel/syscalls.S	Thu Apr 15 17:22:00 2004
@@ -153,8 +153,8 @@
 SYSCALL(sys_select,sys_select,sys32_select_wrapper)
 SYSCALL(sys_flock,sys_flock,sys32_flock_wrapper)
 SYSCALL(sys_msync,sys_msync,sys32_msync_wrapper)
-SYSCALL(sys_readv,sys_readv,sys32_readv_wrapper)		/* 145 */
-SYSCALL(sys_writev,sys_writev,sys32_writev_wrapper)
+SYSCALL(sys_readv,sys_readv,compat_sys_readv_wrapper)		/* 145 */
+SYSCALL(sys_writev,sys_writev,compat_sys_writev_wrapper)
 SYSCALL(sys_getsid,sys_getsid,sys32_getsid_wrapper)
 SYSCALL(sys_fdatasync,sys_fdatasync,sys32_fdatasync_wrapper)
 SYSCALL(sys_sysctl,sys_sysctl,sys32_sysctl_wrapper)
===== arch/sparc64/kernel/sys_sparc32.c 1.95 vs edited =====
--- 1.95/arch/sparc64/kernel/sys_sparc32.c	Sat Mar 27 22:46:54 2004
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Thu Apr 15 17:22:00 2004
@@ -832,182 +832,6 @@
 		return sys_ftruncate(fd, (high << 32) | low);
 }
 
-typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
-typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
-
-static long do_readv_writev32(int type, struct file *file,
-			      const struct compat_iovec *vector, u32 count)
-{
-	compat_ssize_t tot_len;
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov=iovstack, *ivp;
-	struct inode *inode;
-	long retval, i;
-	io_fn_t fn;
-	iov_fn_t fnv;
-
-	/*
-	 * SuS says "The readv() function *may* fail if the iovcnt argument
-	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
-	 * traditionally returned zero for zero segments, so...
-	 */
-	retval = 0;
-	if (count == 0)
-		goto out;
-
-	/* First get the "struct iovec" from user memory and
-	 * verify all the pointers
-	 */
-	retval = -EINVAL;
-	if (count > UIO_MAXIOV)
-		goto out;
-	if (!file->f_op)
-		goto out;
-	if (count > UIO_FASTIOV) {
-		retval = -ENOMEM;
-		iov = kmalloc(count*sizeof(struct iovec), GFP_KERNEL);
-		if (!iov)
-			goto out;
-	}
-	retval = -EFAULT;
-	if (verify_area(VERIFY_READ, vector, sizeof(struct compat_iovec)*count))
-		goto out;
-
-	/*
-	 * Single unix specification:
-	 * We should -EINVAL if an element length is not >= 0 and fitting an
-	 * ssize_t.  The total length is fitting an ssize_t
-	 *
-	 * Be careful here because iov_len is a size_t not an ssize_t
-	 */
-	tot_len = 0;
-	i = count;
-	ivp = iov;
-	retval = -EINVAL;
-	while(i > 0) {
-		compat_ssize_t tmp = tot_len;
-		compat_ssize_t len;
-		u32 buf;
-
-		if (__get_user(len, &vector->iov_len) ||
-		    __get_user(buf, &vector->iov_base)) {
-			retval = -EFAULT;
-			goto out;
-		}
-		if (len < 0)	/* size_t not fitting an ssize_t32 .. */
-			goto out;
-		tot_len += len;
-		if (tot_len < tmp) /* maths overflow on the compat_ssize_t */
-			goto out;
-		ivp->iov_base = (void *)A(buf);
-		ivp->iov_len = (__kernel_size_t) len;
-		vector++;
-		ivp++;
-		i--;
-	}
-	if (tot_len == 0) {
-		retval = 0;
-		goto out;
-	}
-
-	inode = file->f_dentry->d_inode;
-	/* VERIFY_WRITE actually means a read, as we write to user space */
-	retval = locks_verify_area((type == READ
-				    ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
-				   inode, file, file->f_pos, tot_len);
-	if (retval)
-		goto out;
-
-	if (type == READ) {
-		fn = file->f_op->read;
-		fnv = file->f_op->readv;
-	} else {
-		fn = (io_fn_t)file->f_op->write;
-		fnv = file->f_op->writev;
-	}
-	if (fnv) {
-		retval = fnv(file, iov, count, &file->f_pos);
-		goto out;
-	}
-
-	/* Do it by hand, with file-ops */
-	ivp = iov;
-	while (count > 0) {
-		void * base;
-		int len, nr;
-
-		base = ivp->iov_base;
-		len = ivp->iov_len;
-		ivp++;
-		count--;
-
-		nr = fn(file, base, len, &file->f_pos);
-
-		if (nr < 0) {
-			if (!retval)
-				retval = nr;
-			break;
-		}
-		retval += nr;
-		if (nr != len)
-			break;
-	}
-out:
-	if (iov != iovstack)
-		kfree(iov);
-	if ((retval + (type == READ)) > 0)
-		dnotify_parent(file->f_dentry,
-			(type == READ) ? DN_ACCESS : DN_MODIFY);
-
-	return retval;
-}
-
-asmlinkage long sys32_readv(int fd, struct compat_iovec *vector, u32 count)
-{
-	struct file *file;
-	int ret;
-
-	file = fget(fd);
-	if(!file)
-		return -EBADF;
-
-	ret = -EBADF;
-	if (!(file->f_mode & FMODE_READ))
-		goto out;
-	ret = -EINVAL;
-	if (!file->f_op || (!file->f_op->readv && !file->f_op->read))
-		goto out;
-
-	ret = do_readv_writev32(READ, file, vector, count);
-
-out:
-	fput(file);
-	return ret;
-}
-
-asmlinkage long sys32_writev(int fd, struct compat_iovec *vector, u32 count)
-{
-	struct file *file;
-	int ret;
-
-	file = fget(fd);
-	if(!file)
-		return -EBADF;
-
-	ret = -EBADF;
-	if (!(file->f_mode & FMODE_WRITE))
-		goto out;
-	ret = -EINVAL;
-	if (!file->f_op || (!file->f_op->writev && !file->f_op->write))
-		goto out;
-
-	ret = do_readv_writev32(WRITE, file, vector, count);
-
-out:
-	fput(file);
-	return ret;
-}
-
 /* readdir & getdents */
 
 #define NAME_OFFSET(de) ((int) ((de)->d_name - (char *) (de)))
===== arch/sparc64/kernel/sys_sunos32.c 1.39 vs edited =====
--- 1.39/arch/sparc64/kernel/sys_sunos32.c	Fri Mar 26 23:16:26 2004
+++ edited/arch/sparc64/kernel/sys_sunos32.c	Thu Apr 15 17:22:00 2004
@@ -1203,9 +1203,6 @@
 	return ret;
 }
 
-extern asmlinkage int sys32_readv(u32 fd, u32 vector, s32 count);
-extern asmlinkage int sys32_writev(u32 fd, u32 vector, s32 count);
-
 asmlinkage int sunos_read(unsigned int fd, u32 buf, u32 count)
 {
 	int ret;
@@ -1218,7 +1215,7 @@
 {
 	int ret;
 
-	ret = check_nonblock(sys32_readv(fd, vector, count), fd);
+	ret = check_nonblock(compat_sys_readv(fd, (void*)A(vector), count), fd);
 	return ret;
 }
 
@@ -1234,7 +1231,7 @@
 {
 	int ret;
 
-	ret = check_nonblock(sys32_writev(fd, vector, count), fd);
+	ret = check_nonblock(compat_sys_writev(fd, (void*)A(vector), count), fd);
 	return ret;
 }
 
===== arch/sparc64/kernel/systbls.S 1.52 vs edited =====
--- 1.52/arch/sparc64/kernel/systbls.S	Fri Mar 26 20:05:27 2004
+++ edited/arch/sparc64/kernel/systbls.S	Thu Apr 15 17:22:00 2004
@@ -43,7 +43,7 @@
 	.word sys32_rt_sigtimedwait, sys32_rt_sigqueueinfo, sys32_rt_sigsuspend, sys_setresuid, sys_getresuid
 /*110*/	.word sys_setresgid, sys_getresgid, sys_setregid, sys_nis_syscall, sys_nis_syscall
 	.word sys_getgroups, sys32_gettimeofday, compat_sys_getrusage, sys_nis_syscall, sys_getcwd
-/*120*/	.word sys32_readv, sys32_writev, sys32_settimeofday, sys32_fchown16, sys_fchmod
+/*120*/	.word compat_sys_readv, compat_sys_writev, sys32_settimeofday, sys32_fchown16, sys_fchmod
 	.word sys_nis_syscall, sys32_setreuid16, sys32_setregid16, sys_rename, sys_truncate
 /*130*/	.word sys_ftruncate, sys_flock, sys_lstat64, sys_nis_syscall, sys_nis_syscall
 	.word sys_nis_syscall, sys_mkdir, sys_rmdir, sys32_utimes, sys_stat64
===== arch/x86_64/ia32/ia32entry.S 1.31 vs edited =====
--- 1.31/arch/x86_64/ia32/ia32entry.S	Mon Apr 12 19:54:59 2004
+++ edited/arch/x86_64/ia32/ia32entry.S	Thu Apr 15 17:22:00 2004
@@ -450,8 +450,8 @@
 	.quad sys32_select
 	.quad sys_flock
 	.quad sys_msync
-	.quad sys32_readv		/* 145 */
-	.quad sys32_writev
+	.quad compat_sys_readv		/* 145 */
+	.quad compat_sys_writev
 	.quad sys_getsid
 	.quad sys_fdatasync
 	.quad sys32_sysctl	/* sysctl */
===== arch/x86_64/ia32/sys_ia32.c 1.57 vs edited =====
--- 1.57/arch/x86_64/ia32/sys_ia32.c	Mon Apr 12 19:54:22 2004
+++ edited/arch/x86_64/ia32/sys_ia32.c	Thu Apr 15 17:22:00 2004
@@ -726,104 +726,6 @@
 			    (struct compat_timeval *)A(a.tvp));
 }
 
-static struct iovec *
-get_compat_iovec(struct compat_iovec *iov32, struct iovec *iov_buf, u32 *count, int type, int *errp)
-{
-	int i;
-	u32 buf, len;
-	struct iovec *ivp, *iov;
-	unsigned long totlen; 
-
-	/* Get the "struct iovec" from user memory */
-
-	*errp = 0;
-	if (!*count)
-		return 0;
-	*errp = -EINVAL;
-	if (*count > UIO_MAXIOV)
-		return(struct iovec *)0;
-	*errp = -EFAULT;
-	if(verify_area(VERIFY_READ, iov32, sizeof(struct compat_iovec)*(*count)))
-		return(struct iovec *)0;
-	if (*count > UIO_FASTIOV) {
-		*errp = -ENOMEM; 
-		iov = kmalloc(*count*sizeof(struct iovec), GFP_KERNEL);
-		if (!iov)
-			return((struct iovec *)0);
-	} else
-		iov = iov_buf;
-
-	ivp = iov;
-	totlen = 0;
-	for (i = 0; i < *count; i++) {
-		*errp = __get_user(len, &iov32->iov_len) |
-		  	__get_user(buf, &iov32->iov_base);	
-		if (*errp)
-			goto error;
-		*errp = verify_area(type, (void *)A(buf), len);
-		if (*errp) {
-			if (i > 0) { 
-				*count = i;
-				break;
-			} 
-			goto error;
-		}
-		/* SuS checks: */
-		*errp = -EINVAL; 
-		if ((int)len < 0)
-			goto error;
-		if ((totlen += len) >= 0x7fffffff)
-			goto error;			
-		ivp->iov_base = (void *)A(buf);
-		ivp->iov_len = (__kernel_size_t)len;
-		iov32++;
-		ivp++;
-	}
-	*errp = 0;
-	return(iov);
-
-error:
-	if (iov != iov_buf)
-		kfree(iov);
-	return NULL;
-}
-
-asmlinkage long
-sys32_readv(int fd, struct compat_iovec *vector, u32 count)
-{
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	if ((iov = get_compat_iovec(vector, iovstack, &count, VERIFY_WRITE, &ret)) == NULL)
-		return ret;
-	set_fs(KERNEL_DS);
-	ret = sys_readv(fd, iov, count);
-	set_fs(old_fs);
-	if (iov != iovstack)
-		kfree(iov);
-	return ret;
-}
-
-asmlinkage long
-sys32_writev(int fd, struct compat_iovec *vector, u32 count)
-{
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	if ((iov = get_compat_iovec(vector, iovstack, &count, VERIFY_READ, &ret)) == NULL)
-		return ret;
-	set_fs(KERNEL_DS);
-	ret = sys_writev(fd, iov, count);
-	set_fs(old_fs);
-	if (iov != iovstack)
-		kfree(iov);
-	return ret;
-}
-
 /*
  * sys_time() can be implemented in user-level using
  * sys_gettimeofday().  x86-64 did this but i386 Linux did not
===== fs/compat.c 1.22 vs edited =====
--- 1.22/fs/compat.c	Fri Mar 26 20:05:31 2004
+++ edited/fs/compat.c	Thu Apr 15 17:22:00 2004
@@ -34,9 +34,17 @@
 #include <linux/syscalls.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
+#include <linux/dnotify.h>
+#include <linux/highuid.h>
+#include <linux/sunrpc/svc.h>
+#include <linux/nfsd/nfsd.h>
+#include <linux/nfsd/syscall.h>
+#include <linux/personality.h>
+
 #include <net/sock.h>		/* siocdevprivate_ioctl */
 
 #include <asm/uaccess.h>
+#include <asm/mmu_context.h>
 
 /*
  * Not all architectures have sys_utime, so implement this in terms
@@ -794,3 +802,181 @@
 	return retval;
 }
 
+static ssize_t compat_do_readv_writev(int type, struct file *file,
+			       const struct compat_iovec __user *uvector,
+			       unsigned long nr_segs, loff_t *pos)
+{
+	typedef ssize_t (*io_fn_t)(struct file *, char __user *, size_t, loff_t *);
+	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
+
+	compat_ssize_t tot_len;
+	struct iovec iovstack[UIO_FASTIOV];
+	struct iovec *iov=iovstack, *vector;
+	ssize_t ret;
+	int seg;
+	io_fn_t fn;
+	iov_fn_t fnv;
+	struct inode *inode;
+
+	/*
+	 * SuS says "The readv() function *may* fail if the iovcnt argument
+	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
+	 * traditionally returned zero for zero segments, so...
+	 */
+	ret = 0;
+	if (nr_segs == 0)
+		goto out;
+
+	/*
+	 * First get the "struct iovec" from user memory and
+	 * verify all the pointers
+	 */
+	ret = -EINVAL;
+	if ((nr_segs > UIO_MAXIOV) || (nr_segs <= 0))
+		goto out;
+	if (!file->f_op)
+		goto out;
+	if (nr_segs > UIO_FASTIOV) {
+		ret = -ENOMEM;
+		iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
+		if (!iov)
+			goto out;
+	}
+	ret = -EFAULT;
+	if (verify_area(VERIFY_READ, uvector, nr_segs*sizeof(*uvector)))
+		goto out;
+
+	/*
+	 * Single unix specification:
+	 * We should -EINVAL if an element length is not >= 0 and fitting an
+	 * ssize_t.  The total length is fitting an ssize_t
+	 *
+	 * Be careful here because iov_len is a size_t not an ssize_t
+	 */
+	tot_len = 0;
+	vector = iov;
+	ret = -EINVAL;
+	for (seg = 0 ; seg < nr_segs; seg++) {
+		compat_ssize_t tmp = tot_len;
+		compat_ssize_t len;
+		compat_uptr_t buf;
+
+		if (__get_user(len, &uvector->iov_len) ||
+		    __get_user(buf, &uvector->iov_base)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		if (len < 0)	/* size_t not fitting an compat_ssize_t .. */
+			goto out;
+		tot_len += len;
+		if (tot_len < tmp) /* maths overflow on the compat_ssize_t */
+			goto out;
+		vector->iov_base = compat_ptr(buf);
+		vector->iov_len = (compat_size_t) len;
+		uvector++;
+		vector++;
+	}
+	if (tot_len == 0) {
+		ret = 0;
+		goto out;
+	}
+
+	inode = file->f_dentry->d_inode;
+	/* VERIFY_WRITE actually means a read, as we write to user space */
+	ret = locks_verify_area((type == READ 
+				 ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
+				inode, file, *pos, tot_len);
+	if (ret)
+		goto out;
+
+	fnv = NULL;
+	if (type == READ) {
+		fn = file->f_op->read;
+		fnv = file->f_op->readv;
+	} else {
+		fn = (io_fn_t)file->f_op->write;
+		fnv = file->f_op->writev;
+	}
+	if (fnv) {
+		ret = fnv(file, iov, nr_segs, pos);
+		goto out;
+	}
+
+	/* Do it by hand, with file-ops */
+	ret = 0;
+	vector = iov;
+	while (nr_segs > 0) {
+		void __user * base;
+		size_t len;
+		ssize_t nr;
+
+		base = vector->iov_base;
+		len = vector->iov_len;
+		vector++;
+		nr_segs--;
+
+		nr = fn(file, base, len, pos);
+
+		if (nr < 0) {
+			if (!ret) ret = nr;
+			break;
+		}
+		ret += nr;
+		if (nr != len)
+			break;
+	}
+out:
+	if (iov != iovstack)
+		kfree(iov);
+	if ((ret + (type == READ)) > 0)
+		dnotify_parent(file->f_dentry,
+				(type == READ) ? DN_ACCESS : DN_MODIFY);
+	return ret;
+}
+
+asmlinkage ssize_t
+compat_sys_readv(unsigned long fd, const struct compat_iovec __user *vec, unsigned long vlen)
+{
+	struct file *file;
+	ssize_t ret = -EBADF;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+
+	if (!(file->f_mode & FMODE_READ))
+		goto out; 
+
+	ret = -EINVAL;
+	if (!file->f_op || (!file->f_op->readv && !file->f_op->read))
+		goto out;
+
+	ret = compat_do_readv_writev(READ, file, vec, vlen, &file->f_pos);
+
+out:
+	fput(file);
+	return ret;
+}
+
+asmlinkage ssize_t
+compat_sys_writev(unsigned long fd, const struct compat_iovec __user *vec, unsigned long vlen)
+{
+	struct file *file;
+	ssize_t ret = -EBADF;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+	if (!(file->f_mode & FMODE_WRITE))
+		goto out;
+
+	ret = -EINVAL;
+	if (!file->f_op || (!file->f_op->writev && !file->f_op->write))
+		goto out;
+
+	ret = compat_do_readv_writev(WRITE, file, vec, vlen, &file->f_pos);
+
+out:
+	fput(file);
+	return ret;
+}
===== include/linux/compat.h 1.20 vs edited =====
--- 1.20/include/linux/compat.h	Mon Apr 12 19:54:17 2004
+++ edited/include/linux/compat.h	Thu Apr 15 17:22:00 2004
@@ -117,5 +117,11 @@
 long compat_sys_shmctl(int first, int second, void __user *uptr);
 long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
 		unsigned nsems, const struct compat_timespec __user *timeout);
+
+asmlinkage ssize_t compat_sys_readv(unsigned long fd,
+		const struct compat_iovec __user *vec, unsigned long vlen);
+asmlinkage ssize_t compat_sys_writev(unsigned long fd,
+		const struct compat_iovec __user *vec, unsigned long vlen);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */

