Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268647AbTBZFp3>; Wed, 26 Feb 2003 00:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268653AbTBZFp3>; Wed, 26 Feb 2003 00:45:29 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:42713 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S268647AbTBZFpO>;
	Wed, 26 Feb 2003 00:45:14 -0500
Date: Wed, 26 Feb 2003 16:54:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx
Subject: [PATCH][COMPAT] make struct compat_iovec
Message-Id: <20030226165420.08cdcb56.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a simple patch that just creates struct compat_iovec and renames
all the usages of struct iovec32.  In order to have a generic
compat_iovec, I have invented a compat_uptr_t which is a user pointer
passed from a compatibility mode process.  We do not need to use this for
pointers passed as syscall paramaters because the compatibility syscall
entry code is assumed to have correctly extended any pointers (by zero
extension in general, but s390x is probably diferent).

Please apply.  I don't think anyone will have any problems with this.

This patch is leading up to an attempt at compat_sys_{send,recv}msg and
then compat_sys_{read,write}v.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.63/arch/ia64/ia32/ia32_ioctl.c 2.5.63-iovec/arch/ia64/ia32/ia32_ioctl.c
--- 2.5.63/arch/ia64/ia32/ia32_ioctl.c	2003-02-11 09:39:10.000000000 +1100
+++ 2.5.63-iovec/arch/ia64/ia32/ia32_ioctl.c	2003-02-26 16:10:50.000000000 +1100
@@ -8,6 +8,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/compat.h>
 #include <linux/dirent.h>
 #include <linux/fs.h>		/* argh, msdos_fs.h isn't self-contained... */
 
@@ -97,11 +98,9 @@
 	int info;		/* [o] auxiliary information */
 } sg_io_hdr32_t;  /* 64 bytes long (on IA32) */
 
-struct iovec32 { unsigned int iov_base; int iov_len; };
-
 static int alloc_sg_iovec(sg_io_hdr_t *sgp, int uptr32)
 {
-	struct iovec32 *uiov = (struct iovec32 *) P(uptr32);
+	struct compat_iovec *uiov = (struct compat_iovec *) P(uptr32);
 	sg_iovec_t *kiov;
 	int i;
 
@@ -136,7 +135,7 @@
 
 static int copy_back_sg_iovec(sg_io_hdr_t *sgp, int uptr32)
 {
-	struct iovec32 *uiov = (struct iovec32 *) P(uptr32);
+	struct compat_iovec *uiov = (struct compat_iovec *) P(uptr32);
 	sg_iovec_t *kiov = (sg_iovec_t *) sgp->dxferp;
 	int i;
 
diff -ruN 2.5.63/arch/ia64/ia32/sys_ia32.c 2.5.63-iovec/arch/ia64/ia32/sys_ia32.c
--- 2.5.63/arch/ia64/ia32/sys_ia32.c	2003-02-25 12:59:25.000000000 +1100
+++ 2.5.63-iovec/arch/ia64/ia32/sys_ia32.c	2003-02-26 16:27:45.000000000 +1100
@@ -924,7 +924,6 @@
 			    (struct compat_timeval *) A(a.tvp));
 }
 
-struct iovec32 { unsigned int iov_base; int iov_len; };
 asmlinkage ssize_t sys_readv (unsigned long,const struct iovec *,unsigned long);
 asmlinkage ssize_t sys_writev (unsigned long,const struct iovec *,unsigned long);
 
@@ -971,14 +970,14 @@
 }
 
 asmlinkage long
-sys32_readv (int fd, struct iovec32 *vector, u32 count)
+sys32_readv (int fd, struct compat_iovec *vector, u32 count)
 {
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov;
 	long ret;
 	mm_segment_t old_fs = get_fs();
 
-	iov = get_iovec32(vector, iovstack, count, VERIFY_WRITE);
+	iov = get_compat_iovec(vector, iovstack, count, VERIFY_WRITE);
 	if (!iov)
 		return -EFAULT;
 	set_fs(KERNEL_DS);
@@ -990,14 +989,14 @@
 }
 
 asmlinkage long
-sys32_writev (int fd, struct iovec32 *vector, u32 count)
+sys32_writev (int fd, struct compat_iovec *vector, u32 count)
 {
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov;
 	long ret;
 	mm_segment_t old_fs = get_fs();
 
-	iov = get_iovec32(vector, iovstack, count, VERIFY_READ);
+	iov = get_compat_iovec(vector, iovstack, count, VERIFY_READ);
 	if (!iov)
 		return -EFAULT;
 	set_fs(KERNEL_DS);
@@ -1242,10 +1241,10 @@
  */
 
 static inline int
-verify_iovec32 (struct msghdr *m, struct iovec *iov, char *address, int mode)
+verify_compat_iovec (struct msghdr *m, struct iovec *iov, char *address, int mode)
 {
 	int size, err, ct;
-	struct iovec32 *iov32;
+	struct compat_iovec *iov32;
 
 	if (m->msg_namelen) {
 		if (mode == VERIFY_READ) {
@@ -1258,13 +1257,13 @@
 		m->msg_name = NULL;
 
 	err = -EFAULT;
-	size = m->msg_iovlen * sizeof(struct iovec32);
+	size = m->msg_iovlen * sizeof(struct compat_iovec);
 	if (copy_from_user(iov, m->msg_iov, size))
 		goto out;
 	m->msg_iov = iov;
 
 	err = 0;
-	iov32 = (struct iovec32 *)iov;
+	iov32 = (struct compat_iovec *)iov;
 	for (ct = m->msg_iovlen; ct-- > 0; ) {
 		iov[ct].iov_len = (__kernel_size_t)iov32[ct].iov_len;
 		iov[ct].iov_base = (void *) A(iov32[ct].iov_base);
@@ -1490,7 +1489,7 @@
 
 	/* Check whether to allocate the iovec area*/
 	err = -ENOMEM;
-	iov_size = msg_sys.msg_iovlen * sizeof(struct iovec32);
+	iov_size = msg_sys.msg_iovlen * sizeof(struct compat_iovec);
 	if (msg_sys.msg_iovlen > UIO_FASTIOV) {
 		iov = sock_kmalloc(sock->sk, iov_size, GFP_KERNEL);
 		if (!iov)
@@ -1498,7 +1497,7 @@
 	}
 
 	/* This will also move the address data into kernel space */
-	err = verify_iovec32(&msg_sys, iov, address, VERIFY_READ);
+	err = verify_compat_iovec(&msg_sys, iov, address, VERIFY_READ);
 	if (err < 0)
 		goto out_freeiov;
 	total_len = err;
@@ -1580,7 +1579,7 @@
 
 	uaddr = msg_sys.msg_name;
 	uaddr_len = &msg->msg_namelen;
-	err = verify_iovec32(&msg_sys, iov, addr, VERIFY_WRITE);
+	err = verify_compat_iovec(&msg_sys, iov, addr, VERIFY_WRITE);
 	if (err < 0)
 		goto out_freeiov;
 	total_len=err;
diff -ruN 2.5.63/arch/mips64/kernel/linux32.c 2.5.63-iovec/arch/mips64/kernel/linux32.c
--- 2.5.63/arch/mips64/kernel/linux32.c	2003-02-25 12:59:27.000000000 +1100
+++ 2.5.63-iovec/arch/mips64/kernel/linux32.c	2003-02-26 16:11:42.000000000 +1100
@@ -729,12 +729,10 @@
 	return sys_llseek(fd, offset_high, offset_low, result, origin);
 }
 
-struct iovec32 { unsigned int iov_base; int iov_len; };
-
 typedef ssize_t (*IO_fn_t)(struct file *, char *, size_t, loff_t *);
 
 static long
-do_readv_writev32(int type, struct file *file, const struct iovec32 *vector,
+do_readv_writev32(int type, struct file *file, const struct compat_iovec *vector,
 		  u32 count)
 {
 	unsigned long tot_len;
@@ -749,7 +747,7 @@
 	 */
 	if (!count)
 		return 0;
-	if(verify_area(VERIFY_READ, vector, sizeof(struct iovec32)*count))
+	if(verify_area(VERIFY_READ, vector, sizeof(struct compat_iovec)*count))
 		return -EFAULT;
 	if (count > UIO_MAXIOV)
 		return -EINVAL;
@@ -835,7 +833,7 @@
 }
 
 asmlinkage long
-sys32_readv(int fd, struct iovec32 *vector, u32 count)
+sys32_readv(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct file *file;
 	ssize_t ret;
@@ -855,7 +853,7 @@
 }
 
 asmlinkage long
-sys32_writev(int fd, struct iovec32 *vector, u32 count)
+sys32_writev(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct file *file;
 	ssize_t ret;
@@ -1920,10 +1918,10 @@
  */
 
 static inline int
-verify_iovec32(struct msghdr *m, struct iovec *iov, char *address, int mode)
+verify_compat_iovec(struct msghdr *m, struct iovec *iov, char *address, int mode)
 {
 	int size, err, ct;
-	struct iovec32 *iov32;
+	struct compat_iovec *iov32;
 	
 	if(m->msg_namelen)
 	{
@@ -1939,13 +1937,13 @@
 		m->msg_name = NULL;
 
 	err = -EFAULT;
-	size = m->msg_iovlen * sizeof(struct iovec32);
+	size = m->msg_iovlen * sizeof(struct compat_iovec);
 	if (copy_from_user(iov, m->msg_iov, size))
 		goto out;
 	m->msg_iov=iov;
 
 	err = 0;
-	iov32 = (struct iovec32 *)iov;
+	iov32 = (struct compat_iovec *)iov;
 	for (ct = m->msg_iovlen; ct-- > 0; ) {
 		iov[ct].iov_len = (__kernel_size_t)iov32[ct].iov_len;
 		iov[ct].iov_base = (void *) A(iov32[ct].iov_base);
@@ -1990,7 +1988,7 @@
 
 	/* Check whether to allocate the iovec area*/
 	err = -ENOMEM;
-	iov_size = msg_sys.msg_iovlen * sizeof(struct iovec32);
+	iov_size = msg_sys.msg_iovlen * sizeof(struct compat_iovec);
 	if (msg_sys.msg_iovlen > UIO_FASTIOV) {
 		iov = sock_kmalloc(sock->sk, iov_size, GFP_KERNEL);
 		if (!iov)
@@ -1998,7 +1996,7 @@
 	}
 
 	/* This will also move the address data into kernel space */
-	err = verify_iovec32(&msg_sys, iov, address, VERIFY_READ);
+	err = verify_compat_iovec(&msg_sys, iov, address, VERIFY_READ);
 	if (err < 0) 
 		goto out_freeiov;
 	total_len = err;
@@ -2089,7 +2087,7 @@
 	 
 	uaddr = msg_sys.msg_name;
 	uaddr_len = &msg->msg_namelen;
-	err = verify_iovec32(&msg_sys, iov, addr, VERIFY_WRITE);
+	err = verify_compat_iovec(&msg_sys, iov, addr, VERIFY_WRITE);
 	if (err < 0)
 		goto out_freeiov;
 	total_len=err;
diff -ruN 2.5.63/arch/parisc/kernel/sys_parisc32.c 2.5.63-iovec/arch/parisc/kernel/sys_parisc32.c
--- 2.5.63/arch/parisc/kernel/sys_parisc32.c	2003-02-18 11:46:33.000000000 +1100
+++ 2.5.63-iovec/arch/parisc/kernel/sys_parisc32.c	2003-02-26 16:11:57.000000000 +1100
@@ -919,12 +919,10 @@
 
 
 /* readv/writev stolen from mips64 */
-struct iovec32 { unsigned int iov_base; int iov_len; };
-
 typedef ssize_t (*IO_fn_t)(struct file *, char *, size_t, loff_t *);
 
 static long
-do_readv_writev32(int type, struct file *file, const struct iovec32 *vector,
+do_readv_writev32(int type, struct file *file, const struct compat_iovec *vector,
 		  u32 count)
 {
 	unsigned long tot_len;
@@ -939,7 +937,7 @@
 	 */
 	if (!count)
 		return 0;
-	if(verify_area(VERIFY_READ, vector, sizeof(struct iovec32)*count))
+	if(verify_area(VERIFY_READ, vector, sizeof(struct compat_iovec)*count))
 		return -EFAULT;
 	if (count > UIO_MAXIOV)
 		return -EINVAL;
@@ -1025,7 +1023,7 @@
 }
 
 asmlinkage long
-sys32_readv(int fd, struct iovec32 *vector, u32 count)
+sys32_readv(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct file *file;
 	ssize_t ret;
@@ -1045,7 +1043,7 @@
 }
 
 asmlinkage long
-sys32_writev(int fd, struct iovec32 *vector, u32 count)
+sys32_writev(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct file *file;
 	ssize_t ret;
@@ -1127,7 +1125,7 @@
 }
 
 static inline int iov_from_user32_to_kern(struct iovec *kiov,
-					  struct iovec32 *uiov32,
+					  struct compat_iovec *uiov32,
 					  int niov)
 {
 	int tot_len = 0;
@@ -1175,7 +1173,7 @@
 }
 
 /* I've named the args so it is easy to tell whose space the pointers are in. */
-static int verify_iovec32(struct msghdr *kern_msg, struct iovec *kern_iov,
+static int verify_compat_iovec(struct msghdr *kern_msg, struct iovec *kern_iov,
 			  char *kern_address, int mode)
 {
 	int tot_len;
@@ -1200,7 +1198,7 @@
 	}
 
 	tot_len = iov_from_user32_to_kern(kern_iov,
-					  (struct iovec32 *)kern_msg->msg_iov,
+					  (struct compat_iovec *)kern_msg->msg_iov,
 					  kern_msg->msg_iovlen);
 	if(tot_len >= 0)
 		kern_msg->msg_iov = kern_iov;
@@ -1472,7 +1470,7 @@
 		return -EFAULT;
 	if(kern_msg.msg_iovlen > UIO_MAXIOV)
 		return -EINVAL;
-	err = verify_iovec32(&kern_msg, iov, address, VERIFY_READ);
+	err = verify_compat_iovec(&kern_msg, iov, address, VERIFY_READ);
 	if (err < 0)
 		goto out;
 	total_len = err;
@@ -1522,7 +1520,7 @@
 
 	uaddr = kern_msg.msg_name;
 	uaddr_len = &user_msg->msg_namelen;
-	err = verify_iovec32(&kern_msg, iov, addr, VERIFY_WRITE);
+	err = verify_compat_iovec(&kern_msg, iov, addr, VERIFY_WRITE);
 	if (err < 0)
 		goto out;
 	total_len = err;
diff -ruN 2.5.63/arch/ppc64/kernel/sys_ppc32.c 2.5.63-iovec/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.63/arch/ppc64/kernel/sys_ppc32.c	2003-02-25 12:59:29.000000000 +1100
+++ 2.5.63-iovec/arch/ppc64/kernel/sys_ppc32.c	2003-02-26 16:13:17.000000000 +1100
@@ -74,13 +74,11 @@
 #include <asm/ppc32.h>
 #include <asm/mmu_context.h>
 
-struct iovec32 { u32 iov_base; compat_size_t iov_len; };
-
 typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
 typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
 
 static long do_readv_writev32(int type, struct file *file,
-			      const struct iovec32 *vector, u32 count)
+			      const struct compat_iovec *vector, u32 count)
 {
 	compat_ssize_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
@@ -114,7 +112,7 @@
 			goto out;
 	}
 	retval = -EFAULT;
-	if (verify_area(VERIFY_READ, vector, sizeof(struct iovec32)*count))
+	if (verify_area(VERIFY_READ, vector, sizeof(struct compat_iovec)*count))
 		goto out;
 
 	/*
@@ -206,7 +204,7 @@
 	return retval;
 }
 
-asmlinkage long sys32_readv(int fd, struct iovec32 *vector, u32 count)
+asmlinkage long sys32_readv(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct file *file;
 	int ret = -EBADF;
@@ -227,7 +225,7 @@
 	return ret;
 }
 
-asmlinkage long sys32_writev(int fd, struct iovec32 *vector, u32 count)
+asmlinkage long sys32_writev(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct file *file;
 	int ret = -EBADF;
@@ -2355,7 +2353,7 @@
 }
 
 static inline int iov_from_user32_to_kern(struct iovec *kiov,
-					  struct iovec32 *uiov32,
+					  struct compat_iovec *uiov32,
 					  int niov)
 {
 	int tot_len = 0;
@@ -2379,7 +2377,7 @@
 }
 
 /* I've named the args so it is easy to tell whose space the pointers are in. */
-static int verify_iovec32(struct msghdr *kern_msg, struct iovec *kern_iov,
+static int verify_compat_iovec(struct msghdr *kern_msg, struct iovec *kern_iov,
 			  char *kern_address, int mode)
 {
 	int tot_len;
@@ -2404,7 +2402,7 @@
 	}
 
 	tot_len = iov_from_user32_to_kern(kern_iov,
-					  (struct iovec32 *)kern_msg->msg_iov,
+					  (struct compat_iovec *)kern_msg->msg_iov,
 					  kern_msg->msg_iovlen);
 	if(tot_len >= 0)
 		kern_msg->msg_iov = kern_iov;
@@ -2506,7 +2504,7 @@
 		return -EFAULT;
 	if(kern_msg.msg_iovlen > UIO_MAXIOV)
 		return -EINVAL;
-	err = verify_iovec32(&kern_msg, iov, address, VERIFY_READ);
+	err = verify_compat_iovec(&kern_msg, iov, address, VERIFY_READ);
 	if (err < 0)
 		goto out;
 	total_len = err;
@@ -2760,7 +2758,7 @@
 
 	uaddr = kern_msg.msg_name;
 	uaddr_len = &user_msg->msg_namelen;
-	err = verify_iovec32(&kern_msg, iov, addr, VERIFY_WRITE);
+	err = verify_compat_iovec(&kern_msg, iov, addr, VERIFY_WRITE);
 	if (err < 0)
 		goto out;
 	total_len = err;
diff -ruN 2.5.63/arch/s390x/kernel/linux32.c 2.5.63-iovec/arch/s390x/kernel/linux32.c
--- 2.5.63/arch/s390x/kernel/linux32.c	2003-02-25 12:59:30.000000000 +1100
+++ 2.5.63-iovec/arch/s390x/kernel/linux32.c	2003-02-26 16:12:23.000000000 +1100
@@ -904,13 +904,11 @@
 		return sys_ftruncate(fd, (high << 32) | low);
 }
 
-struct iovec32 { u32 iov_base; compat_size_t iov_len; };
-
 typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
 typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
 
 static long do_readv_writev32(int type, struct file *file,
-			      const struct iovec32 *vector, u32 count)
+			      const struct compat_iovec *vector, u32 count)
 {
 	unsigned long tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
@@ -925,7 +923,7 @@
 	 */
 	if (!count)
 		return 0;
-	if (verify_area(VERIFY_READ, vector, sizeof(struct iovec32)*count))
+	if (verify_area(VERIFY_READ, vector, sizeof(struct compat_iovec)*count))
 		return -EFAULT;
 	if (count > UIO_MAXIOV)
 		return -EINVAL;
@@ -996,7 +994,7 @@
 	return retval;
 }
 
-asmlinkage long sys32_readv(int fd, struct iovec32 *vector, u32 count)
+asmlinkage long sys32_readv(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct file *file;
 	long ret = -EBADF;
@@ -1014,7 +1012,7 @@
 	return ret;
 }
 
-asmlinkage long sys32_writev(int fd, struct iovec32 *vector, u32 count)
+asmlinkage long sys32_writev(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct file *file;
 	int ret = -EBADF;
@@ -1926,7 +1924,7 @@
 }
 
 static inline int iov_from_user32_to_kern(struct iovec *kiov,
-					  struct iovec32 *uiov32,
+					  struct compat_iovec *uiov32,
 					  int niov)
 {
 	int tot_len = 0;
@@ -1974,7 +1972,7 @@
 }
 
 /* I've named the args so it is easy to tell whose space the pointers are in. */
-static int verify_iovec32(struct msghdr *kern_msg, struct iovec *kern_iov,
+static int verify_compat_iovec(struct msghdr *kern_msg, struct iovec *kern_iov,
 			  char *kern_address, int mode)
 {
 	int tot_len;
@@ -1999,7 +1997,7 @@
 	}
 
 	tot_len = iov_from_user32_to_kern(kern_iov,
-					  (struct iovec32 *)kern_msg->msg_iov,
+					  (struct compat_iovec *)kern_msg->msg_iov,
 					  kern_msg->msg_iovlen);
 	if(tot_len >= 0)
 		kern_msg->msg_iov = kern_iov;
@@ -2301,7 +2299,7 @@
 
 	/* Check whether to allocate the iovec area*/
 	err = -ENOMEM;
-	iov_size = msg_sys.msg_iovlen * sizeof(struct iovec32);
+	iov_size = msg_sys.msg_iovlen * sizeof(struct compat_iovec);
 	if (msg_sys.msg_iovlen > UIO_FASTIOV) {
 		iov = sock_kmalloc(sock->sk, iov_size, GFP_KERNEL);
 		if (!iov)
@@ -2309,7 +2307,7 @@
 	}
 
 	/* This will also move the address data into kernel space */
-	err = verify_iovec32(&msg_sys, iov, address, VERIFY_READ);
+	err = verify_compat_iovec(&msg_sys, iov, address, VERIFY_READ);
 	if (err < 0) 
 		goto out_freeiov;
 	total_len = err;
@@ -2462,7 +2460,7 @@
 	 
 	uaddr = msg_sys.msg_name;
 	uaddr_len = &msg->msg_namelen;
-	err = verify_iovec32(&msg_sys, iov, addr, VERIFY_WRITE);
+	err = verify_compat_iovec(&msg_sys, iov, addr, VERIFY_WRITE);
 	if (err < 0)
 		goto out_freeiov;
 	total_len=err;
diff -ruN 2.5.63/arch/sparc64/kernel/sys_sparc32.c 2.5.63-iovec/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.63/arch/sparc64/kernel/sys_sparc32.c	2003-02-25 12:59:31.000000000 +1100
+++ 2.5.63-iovec/arch/sparc64/kernel/sys_sparc32.c	2003-02-26 16:12:44.000000000 +1100
@@ -860,13 +860,11 @@
 		return sys_ftruncate(fd, (high << 32) | low);
 }
 
-struct iovec32 { u32 iov_base; compat_size_t iov_len; };
-
 typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
 typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
 
 static long do_readv_writev32(int type, struct file *file,
-			      const struct iovec32 *vector, u32 count)
+			      const struct compat_iovec *vector, u32 count)
 {
 	compat_ssize_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
@@ -900,7 +898,7 @@
 			goto out;
 	}
 	retval = -EFAULT;
-	if (verify_area(VERIFY_READ, vector, sizeof(struct iovec32)*count))
+	if (verify_area(VERIFY_READ, vector, sizeof(struct compat_iovec)*count))
 		goto out;
 
 	/*
@@ -992,7 +990,7 @@
 	return retval;
 }
 
-asmlinkage long sys32_readv(int fd, struct iovec32 *vector, u32 count)
+asmlinkage long sys32_readv(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct file *file;
 	int ret;
@@ -1015,7 +1013,7 @@
 	return ret;
 }
 
-asmlinkage long sys32_writev(int fd, struct iovec32 *vector, u32 count)
+asmlinkage long sys32_writev(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct file *file;
 	int ret;
@@ -1966,7 +1964,7 @@
 }
 
 static inline int iov_from_user32_to_kern(struct iovec *kiov,
-					  struct iovec32 *uiov32,
+					  struct compat_iovec *uiov32,
 					  int niov)
 {
 	int tot_len = 0;
@@ -2014,7 +2012,7 @@
 }
 
 /* I've named the args so it is easy to tell whose space the pointers are in. */
-static int verify_iovec32(struct msghdr *kern_msg, struct iovec *kern_iov,
+static int verify_compat_iovec(struct msghdr *kern_msg, struct iovec *kern_iov,
 			  char *kern_address, int mode)
 {
 	int tot_len;
@@ -2039,7 +2037,7 @@
 	}
 
 	tot_len = iov_from_user32_to_kern(kern_iov,
-					  (struct iovec32 *)kern_msg->msg_iov,
+					  (struct compat_iovec *)kern_msg->msg_iov,
 					  kern_msg->msg_iovlen);
 	if(tot_len >= 0)
 		kern_msg->msg_iov = kern_iov;
@@ -2328,7 +2326,7 @@
 		return -EFAULT;
 	if(kern_msg.msg_iovlen > UIO_MAXIOV)
 		return -EINVAL;
-	err = verify_iovec32(&kern_msg, iov, address, VERIFY_READ);
+	err = verify_compat_iovec(&kern_msg, iov, address, VERIFY_READ);
 	if (err < 0)
 		goto out;
 	total_len = err;
@@ -2378,7 +2376,7 @@
 
 	uaddr = kern_msg.msg_name;
 	uaddr_len = &user_msg->msg_namelen;
-	err = verify_iovec32(&kern_msg, iov, addr, VERIFY_WRITE);
+	err = verify_compat_iovec(&kern_msg, iov, addr, VERIFY_WRITE);
 	if (err < 0)
 		goto out;
 	total_len = err;
diff -ruN 2.5.63/arch/sparc64/solaris/socket.c 2.5.63-iovec/arch/sparc64/solaris/socket.c
--- 2.5.63/arch/sparc64/solaris/socket.c	2002-12-10 15:10:17.000000000 +1100
+++ 2.5.63-iovec/arch/sparc64/solaris/socket.c	2003-02-26 16:12:56.000000000 +1100
@@ -267,13 +267,8 @@
 	unsigned char	cmsg_data[0];
 };
 
-struct iovec32 {
-	u32		iov_base;
-	u32 iov_len;
-};
-
 static inline int iov_from_user32_to_kern(struct iovec *kiov,
-					  struct iovec32 *uiov32,
+					  struct compat_iovec *uiov32,
 					  int niov)
 {
 	int tot_len = 0;
@@ -322,7 +317,7 @@
 }
 
 /* I've named the args so it is easy to tell whose space the pointers are in. */
-static int verify_iovec32(struct msghdr *kern_msg, struct iovec *kern_iov,
+static int verify_compat_iovec(struct msghdr *kern_msg, struct iovec *kern_iov,
 			  char *kern_address, int mode)
 {
 	int tot_len;
@@ -347,7 +342,7 @@
 	}
 
 	tot_len = iov_from_user32_to_kern(kern_iov,
-					  (struct iovec32 *)kern_msg->msg_iov,
+					  (struct compat_iovec *)kern_msg->msg_iov,
 					  kern_msg->msg_iovlen);
 	if(tot_len >= 0)
 		kern_msg->msg_iov = kern_iov;
@@ -371,7 +366,7 @@
 		return -EFAULT;
 	if(kern_msg.msg_iovlen > UIO_MAXIOV)
 		return -EINVAL;
-	err = verify_iovec32(&kern_msg, iov, address, VERIFY_READ);
+	err = verify_compat_iovec(&kern_msg, iov, address, VERIFY_READ);
 	if (err < 0)
 		goto out;
 	total_len = err;
@@ -439,7 +434,7 @@
 
 	uaddr = kern_msg.msg_name;
 	uaddr_len = &user_msg->msg_namelen;
-	err = verify_iovec32(&kern_msg, iov, addr, VERIFY_WRITE);
+	err = verify_compat_iovec(&kern_msg, iov, addr, VERIFY_WRITE);
 	if (err < 0)
 		goto out;
 	total_len = err;
diff -ruN 2.5.63/arch/x86_64/ia32/socket32.c 2.5.63-iovec/arch/x86_64/ia32/socket32.c
--- 2.5.63/arch/x86_64/ia32/socket32.c	2002-12-27 15:15:41.000000000 +1100
+++ 2.5.63-iovec/arch/x86_64/ia32/socket32.c	2003-02-26 16:13:33.000000000 +1100
@@ -35,7 +35,7 @@
 
 
 static inline int iov_from_user32_to_kern(struct iovec *kiov,
-					  struct iovec32 *uiov32,
+					  struct compat_iovec *uiov32,
 					  int niov)
 {
 	int tot_len = 0;
@@ -83,7 +83,7 @@
 }
 
 /* I've named the args so it is easy to tell whose space the pointers are in. */
-static int verify_iovec32(struct msghdr *kern_msg, struct iovec *kern_iov,
+static int verify_compat_iovec(struct msghdr *kern_msg, struct iovec *kern_iov,
 			  char *kern_address, int mode)
 {
 	int tot_len;
@@ -108,7 +108,7 @@
 	}
 
 	tot_len = iov_from_user32_to_kern(kern_iov,
-					  (struct iovec32 *)kern_msg->msg_iov,
+					  (struct compat_iovec *)kern_msg->msg_iov,
 					  kern_msg->msg_iovlen);
 	if(tot_len >= 0)
 		kern_msg->msg_iov = kern_iov;
@@ -380,7 +380,7 @@
 		return -EFAULT;
 	if(kern_msg.msg_iovlen > UIO_MAXIOV)
 		return -EINVAL;
-	err = verify_iovec32(&kern_msg, iov, address, VERIFY_READ);
+	err = verify_compat_iovec(&kern_msg, iov, address, VERIFY_READ);
 	if (err < 0)
 		goto out;
 	total_len = err;
@@ -430,7 +430,7 @@
 
 	uaddr = kern_msg.msg_name;
 	uaddr_len = &user_msg->msg_namelen;
-	err = verify_iovec32(&kern_msg, iov, addr, VERIFY_WRITE);
+	err = verify_compat_iovec(&kern_msg, iov, addr, VERIFY_WRITE);
 	if (err < 0)
 		goto out;
 	total_len = err;
diff -ruN 2.5.63/arch/x86_64/ia32/sys_ia32.c 2.5.63-iovec/arch/x86_64/ia32/sys_ia32.c
--- 2.5.63/arch/x86_64/ia32/sys_ia32.c	2003-02-25 12:59:32.000000000 +1100
+++ 2.5.63-iovec/arch/x86_64/ia32/sys_ia32.c	2003-02-26 16:13:45.000000000 +1100
@@ -738,7 +738,7 @@
 asmlinkage ssize_t sys_writev(unsigned long,const struct iovec *,unsigned long);
 
 static struct iovec *
-get_iovec32(struct iovec32 *iov32, struct iovec *iov_buf, u32 count, int type, int *errp)
+get_compat_iovec(struct compat_iovec *iov32, struct iovec *iov_buf, u32 count, int type, int *errp)
 {
 	int i;
 	u32 buf, len;
@@ -751,7 +751,7 @@
 		return 0;
 	if (count > UIO_MAXIOV)
 		return(struct iovec *)0;
-	if(verify_area(VERIFY_READ, iov32, sizeof(struct iovec32)*count))
+	if(verify_area(VERIFY_READ, iov32, sizeof(struct compat_iovec)*count))
 		return(struct iovec *)0;
 	if (count > UIO_FASTIOV) {
 		*errp = -ENOMEM; 
@@ -792,14 +792,14 @@
 }
 
 asmlinkage long
-sys32_readv(int fd, struct iovec32 *vector, u32 count)
+sys32_readv(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov;
 	int ret;
 	mm_segment_t old_fs = get_fs();
 
-	if ((iov = get_iovec32(vector, iovstack, count, VERIFY_WRITE, &ret)) == NULL)
+	if ((iov = get_compat_iovec(vector, iovstack, count, VERIFY_WRITE, &ret)) == NULL)
 		return ret;
 	set_fs(KERNEL_DS);
 	ret = sys_readv(fd, iov, count);
@@ -810,14 +810,14 @@
 }
 
 asmlinkage long
-sys32_writev(int fd, struct iovec32 *vector, u32 count)
+sys32_writev(int fd, struct compat_iovec *vector, u32 count)
 {
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov;
 	int ret;
 	mm_segment_t old_fs = get_fs();
 
-	if ((iov = get_iovec32(vector, iovstack, count, VERIFY_READ, &ret)) == NULL)
+	if ((iov = get_compat_iovec(vector, iovstack, count, VERIFY_READ, &ret)) == NULL)
 		return ret;
 	set_fs(KERNEL_DS);
 	ret = sys_writev(fd, iov, count);
diff -ruN 2.5.63/include/asm-ia64/compat.h 2.5.63-iovec/include/asm-ia64/compat.h
--- 2.5.63/include/asm-ia64/compat.h	2003-02-11 09:39:57.000000000 +1100
+++ 2.5.63-iovec/include/asm-ia64/compat.h	2003-02-26 16:09:26.000000000 +1100
@@ -27,6 +27,15 @@
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
 
+/*
+ * A pointer from user mode.  This should not be used
+ * for syscall parameters, just declare them as pointers
+ * because the syscall entry code will have zero extended
+ * them already.
+ */
+typedef u32		compat_uptr_t;
+#define	COMPAT_UPTR_TO_PTR(x)	((void*)(unsigned long)(x))
+
 struct compat_timespec {
 	compat_time_t	tv_sec;
 	s32		tv_nsec;
diff -ruN 2.5.63/include/asm-mips64/compat.h 2.5.63-iovec/include/asm-mips64/compat.h
--- 2.5.63/include/asm-mips64/compat.h	2002-12-16 14:49:54.000000000 +1100
+++ 2.5.63-iovec/include/asm-mips64/compat.h	2003-02-26 16:09:30.000000000 +1100
@@ -10,6 +10,15 @@
 typedef s32		compat_time_t;
 typedef s32		compat_suseconds_t;
 
+/*
+ * A pointer from user mode.  This should not be used
+ * for syscall parameters, just declare them as pointers
+ * because the syscall entry code will have zero extended
+ * them already.
+ */
+typedef u32		compat_uptr_t;
+#define	COMPAT_UPTR_TO_PTR(x)	((void*)(unsigned long)(x))
+
 struct compat_timespec {
 	compat_time_t	tv_sec;
 	s32		tv_nsec;
diff -ruN 2.5.63/include/asm-parisc/compat.h 2.5.63-iovec/include/asm-parisc/compat.h
--- 2.5.63/include/asm-parisc/compat.h	2003-02-11 09:39:59.000000000 +1100
+++ 2.5.63-iovec/include/asm-parisc/compat.h	2003-02-26 16:09:49.000000000 +1100
@@ -23,6 +23,15 @@
 typedef s32	compat_daddr_t;
 typedef u32	compat_caddr_t;
 
+/*
+ * A pointer from user mode.  This should not be used
+ * for syscall parameters, just declare them as pointers
+ * because the syscall entry code will have zero extended
+ * them already.
+ */
+typedef u32		compat_uptr_t;
+#define	COMPAT_UPTR_TO_PTR(x)	((void*)(unsigned long)(x))
+
 struct compat_timespec {
 	compat_time_t		tv_sec;
 	s32			tv_nsec;
diff -ruN 2.5.63/include/asm-ppc64/compat.h 2.5.63-iovec/include/asm-ppc64/compat.h
--- 2.5.63/include/asm-ppc64/compat.h	2003-02-11 09:39:59.000000000 +1100
+++ 2.5.63-iovec/include/asm-ppc64/compat.h	2003-02-26 16:09:55.000000000 +1100
@@ -25,6 +25,15 @@
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
 
+/*
+ * A pointer from user mode.  This should not be used
+ * for syscall parameters, just declare them as pointers
+ * because the syscall entry code will have zero extended
+ * them already.
+ */
+typedef u32		compat_uptr_t;
+#define	COMPAT_UPTR_TO_PTR(x)	((void*)(unsigned long)(x))
+
 struct compat_timespec {
 	compat_time_t	tv_sec;
 	s32		tv_nsec;
diff -ruN 2.5.63/include/asm-s390x/compat.h 2.5.63-iovec/include/asm-s390x/compat.h
--- 2.5.63/include/asm-s390x/compat.h	2003-02-25 12:59:57.000000000 +1100
+++ 2.5.63-iovec/include/asm-s390x/compat.h	2003-02-26 16:09:59.000000000 +1100
@@ -25,6 +25,15 @@
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
 
+/*
+ * A pointer from user mode.  This should not be used
+ * for syscall parameters, just declare them as pointers
+ * because the syscall entry code will have zero extended
+ * them already.
+ */
+typedef u32		compat_uptr_t;
+#define	COMPAT_UPTR_TO_PTR(x)	((void*)((unsigned long)((x) & 0x7FFFFFFFUL)))
+
 struct compat_timespec {
 	compat_time_t	tv_sec;
 	s32		tv_nsec;
diff -ruN 2.5.63/include/asm-sparc64/compat.h 2.5.63-iovec/include/asm-sparc64/compat.h
--- 2.5.63/include/asm-sparc64/compat.h	2003-02-11 09:40:00.000000000 +1100
+++ 2.5.63-iovec/include/asm-sparc64/compat.h	2003-02-26 16:10:13.000000000 +1100
@@ -25,6 +25,15 @@
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
 
+/*
+ * A pointer from user mode.  This should not be used
+ * for syscall parameters, just declare them as pointers
+ * because the syscall entry code will have zero extended
+ * them already.
+ */
+typedef u32		compat_uptr_t;
+#define	COMPAT_UPTR_TO_PTR(x)	((void*)(unsigned long)(x))
+
 struct compat_timespec {
 	compat_time_t	tv_sec;
 	s32		tv_nsec;
diff -ruN 2.5.63/include/asm-x86_64/compat.h 2.5.63-iovec/include/asm-x86_64/compat.h
--- 2.5.63/include/asm-x86_64/compat.h	2003-02-11 09:40:00.000000000 +1100
+++ 2.5.63-iovec/include/asm-x86_64/compat.h	2003-02-26 16:10:19.000000000 +1100
@@ -27,6 +27,15 @@
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
 
+/*
+ * A pointer from user mode.  This should not be used
+ * for syscall parameters, just declare them as pointers
+ * because the syscall entry code will have zero extended
+ * them already.
+ */
+typedef u32		compat_uptr_t;
+#define	COMPAT_UPTR_TO_PTR(x)	((void*)(unsigned long)(x))
+
 struct compat_timespec {
 	compat_time_t	tv_sec;
 	s32		tv_nsec;
diff -ruN 2.5.63/include/asm-x86_64/ia32.h 2.5.63-iovec/include/asm-x86_64/ia32.h
--- 2.5.63/include/asm-x86_64/ia32.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.63-iovec/include/asm-x86_64/ia32.h	2003-02-26 16:01:58.000000000 +1100
@@ -153,11 +153,6 @@
 	char			f_fpack[6];
 };
 
-struct iovec32 { 
-	unsigned int iov_base; 
-	int iov_len; 
-};
-
 #define IA32_PAGE_OFFSET 0xffffe000
 #define IA32_STACK_TOP IA32_PAGE_OFFSET
 
diff -ruN 2.5.63/include/linux/compat.h 2.5.63-iovec/include/linux/compat.h
--- 2.5.63/include/linux/compat.h	2003-01-17 14:01:07.000000000 +1100
+++ 2.5.63-iovec/include/linux/compat.h	2003-02-26 16:03:57.000000000 +1100
@@ -39,6 +39,11 @@
 	compat_sigset_word	sig[_COMPAT_NSIG_WORDS];
 } compat_sigset_t;
 
+struct compat_iovec {
+	compat_uptr_t		iov_base;
+	compat_size_t		iov_len;
+};
+
 extern int cp_compat_stat(struct kstat *, struct compat_stat *);
 extern int get_compat_flock(struct flock *, struct compat_flock *);
 extern int put_compat_flock(struct flock *, struct compat_flock *);
