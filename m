Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbSLDHLu>; Wed, 4 Dec 2002 02:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbSLDHLu>; Wed, 4 Dec 2002 02:11:50 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:23686 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265230AbSLDHLe>;
	Wed, 4 Dec 2002 02:11:34 -0500
Date: Wed, 4 Dec 2002 18:18:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ak@muc.de
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compatibility syscall layer - X86_64
Message-Id: <20021204181850.00e8495a.sfr@canb.auug.org.au>
In-Reply-To: <20021204180224.406d143c.sfr@canb.auug.org.au>
References: <20021204180224.406d143c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi, Linus,

Here is the x86_64 specific patch.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50-BK.2/arch/x86_64/Kconfig 2.5.50-BK.2-32bit.1/arch/x86_64/Kconfig
--- 2.5.50-BK.2/arch/x86_64/Kconfig	2002-11-28 10:34:43.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/x86_64/Kconfig	2002-12-03 17:02:32.000000000 +1100
@@ -425,6 +425,11 @@
 	  turn this on, unless you're 100% sure that you don't have any 32bit programs
 	  left.
 
+config COMPAT
+	bool
+	depends on IA32_EMULATION
+	default y
+
 endmenu
 
 source "drivers/mtd/Kconfig"
diff -ruN 2.5.50-BK.2/arch/x86_64/ia32/ia32_binfmt.c 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/ia32_binfmt.c
--- 2.5.50-BK.2/arch/x86_64/ia32/ia32_binfmt.c	2002-10-21 01:02:47.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/ia32_binfmt.c	2002-12-04 15:35:28.000000000 +1100
@@ -6,6 +6,7 @@
  * of ugly preprocessor tricks. Talk about very very poor man's inheritance.
  */ 
 #include <linux/types.h>
+#include <linux/compat.h>
 #include <linux/config.h> 
 #include <linux/stddef.h>
 #include <linux/module.h>
@@ -53,11 +54,6 @@
 	int	si_errno;			/* errno */
 };
 
-struct timeval32
-{
-    int tv_sec, tv_usec;
-};
-
 #define jiffies_to_timeval(a,b) do { (b)->tv_usec = 0; (b)->tv_sec = (a)/HZ; }while(0)
 
 struct elf_prstatus
@@ -70,10 +66,10 @@
 	pid_t	pr_ppid;
 	pid_t	pr_pgrp;
 	pid_t	pr_sid;
-	struct timeval32 pr_utime;	/* User time */
-	struct timeval32 pr_stime;	/* System time */
-	struct timeval32 pr_cutime;	/* Cumulative user time */
-	struct timeval32 pr_cstime;	/* Cumulative system time */
+	struct compat_timeval pr_utime;	/* User time */
+	struct compat_timeval pr_stime;	/* System time */
+	struct compat_timeval pr_cutime;	/* Cumulative user time */
+	struct compat_timeval pr_cstime;	/* Cumulative system time */
 	elf_gregset_t pr_reg;	/* GP registers */
 	int pr_fpvalid;		/* True if math co-processor being used.  */
 };
diff -ruN 2.5.50-BK.2/arch/x86_64/ia32/ia32_ioctl.c 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/ia32_ioctl.c
--- 2.5.50-BK.2/arch/x86_64/ia32/ia32_ioctl.c	2002-10-21 01:02:47.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/ia32_ioctl.c	2002-12-04 15:35:52.000000000 +1100
@@ -11,6 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -405,14 +406,9 @@
 	return err;
 }
 
-struct timeval32 {
-	int tv_sec;
-	int tv_usec;
-};
-
 static int do_siocgstamp(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	struct timeval32 *up = (struct timeval32 *)arg;
+	struct compat_timeval *up = (struct compat_timeval *)arg;
 	struct timeval ktv;
 	mm_segment_t old_fs = get_fs();
 	int err;
@@ -1611,8 +1607,8 @@
 #define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
 
 struct ppp_idle32 {
-	__kernel_time_t32 xmit_idle;
-	__kernel_time_t32 recv_idle;
+	compat_time_t xmit_idle;
+	compat_time_t recv_idle;
 };
 #define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
 
diff -ruN 2.5.50-BK.2/arch/x86_64/ia32/ia32entry.S 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/ia32entry.S
--- 2.5.50-BK.2/arch/x86_64/ia32/ia32entry.S	2002-10-21 01:02:47.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/ia32entry.S	2002-12-04 17:40:54.000000000 +1100
@@ -151,7 +151,7 @@
 	.quad sys_alarm		/* XXX sign extension??? */ 
 	.quad ni_syscall	/* (old)fstat */
 	.quad sys_pause
-	.quad sys32_utime	/* 30 */
+	.quad compat_sys_utime	/* 30 */
 	.quad ni_syscall	/* old stty syscall holder */
 	.quad ni_syscall	/* old gtty syscall holder */
 	.quad sys_access
@@ -225,8 +225,8 @@
 	.quad sys_ioperm
 	.quad sys32_socketcall
 	.quad sys_syslog
-	.quad sys32_setitimer
-	.quad sys32_getitimer	/* 105 */
+	.quad compat_sys_setitimer
+	.quad compat_sys_getitimer	/* 105 */
 	.quad sys32_newstat
 	.quad sys32_newlstat
 	.quad sys32_newfstat
@@ -283,7 +283,7 @@
 	.quad sys_sched_get_priority_max
 	.quad sys_sched_get_priority_min  /* 160 */
 	.quad sys_sched_rr_get_interval
-	.quad sys32_nanosleep
+	.quad compat_sys_nanosleep
 	.quad sys_mremap
 	.quad sys_setresuid16
 	.quad sys_getresuid16	/* 165 */
diff -ruN 2.5.50-BK.2/arch/x86_64/ia32/ipc32.c 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/ipc32.c
--- 2.5.50-BK.2/arch/x86_64/ia32/ipc32.c	2002-10-21 01:02:47.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/ipc32.c	2002-12-04 14:42:24.000000000 +1100
@@ -8,6 +8,7 @@
 #include <linux/shm.h>
 #include <linux/slab.h>
 #include <linux/ipc.h>
+#include <linux/compat.h>
 #include <asm/mman.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -53,8 +54,8 @@
 
 struct semid_ds32 {
 	struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-	__kernel_time_t32 sem_otime;              /* last semop time */
-	__kernel_time_t32 sem_ctime;              /* last change time */
+	compat_time_t sem_otime;              /* last semop time */
+	compat_time_t sem_ctime;              /* last change time */
 	u32 sem_base;              /* ptr to first semaphore in array */
 	u32 sem_pending;          /* pending operations to be processed */
 	u32 sem_pending_last;    /* last pending operation */
@@ -64,9 +65,9 @@
 
 struct semid64_ds32 {
 	struct ipc64_perm32 sem_perm;
-	__kernel_time_t32 sem_otime;
+	compat_time_t sem_otime;
 	unsigned int __unused1;
-	__kernel_time_t32 sem_ctime;
+	compat_time_t sem_ctime;
 	unsigned int __unused2;
 	unsigned int sem_nsems;
 	unsigned int __unused3;
@@ -77,9 +78,9 @@
 	struct ipc_perm32 msg_perm;
 	u32 msg_first;
 	u32 msg_last;
-	__kernel_time_t32 msg_stime;
-	__kernel_time_t32 msg_rtime;
-	__kernel_time_t32 msg_ctime;
+	compat_time_t msg_stime;
+	compat_time_t msg_rtime;
+	compat_time_t msg_ctime;
 	u32 wwait;
 	u32 rwait;
 	unsigned short msg_cbytes;
@@ -91,11 +92,11 @@
 
 struct msqid64_ds32 {
 	struct ipc64_perm32 msg_perm;
-	__kernel_time_t32 msg_stime;
+	compat_time_t msg_stime;
 	unsigned int __unused1;
-	__kernel_time_t32 msg_rtime;
+	compat_time_t msg_rtime;
 	unsigned int __unused2;
-	__kernel_time_t32 msg_ctime;
+	compat_time_t msg_ctime;
 	unsigned int __unused3;
 	unsigned int msg_cbytes;
 	unsigned int msg_qnum;
@@ -109,9 +110,9 @@
 struct shmid_ds32 {
 	struct ipc_perm32 shm_perm;
 	int shm_segsz;
-	__kernel_time_t32 shm_atime;
-	__kernel_time_t32 shm_dtime;
-	__kernel_time_t32 shm_ctime;
+	compat_time_t shm_atime;
+	compat_time_t shm_dtime;
+	compat_time_t shm_ctime;
 	__kernel_ipc_pid_t32 shm_cpid;
 	__kernel_ipc_pid_t32 shm_lpid;
 	unsigned short shm_nattch;
@@ -119,12 +120,12 @@
 
 struct shmid64_ds32 {
 	struct ipc64_perm32 shm_perm;
-	__kernel_size_t32 shm_segsz;
-	__kernel_time_t32 shm_atime;
+	compat_size_t shm_segsz;
+	compat_time_t shm_atime;
 	unsigned int __unused1;
-	__kernel_time_t32 shm_dtime;
+	compat_time_t shm_dtime;
 	unsigned int __unused2;
-	__kernel_time_t32 shm_ctime;
+	compat_time_t shm_ctime;
 	unsigned int __unused3;
 	__kernel_pid_t32 shm_cpid;
 	__kernel_pid_t32 shm_lpid;
diff -ruN 2.5.50-BK.2/arch/x86_64/ia32/socket32.c 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/socket32.c
--- 2.5.50-BK.2/arch/x86_64/ia32/socket32.c	2002-10-16 14:51:16.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/socket32.c	2002-12-04 14:41:55.000000000 +1100
@@ -19,6 +19,7 @@
 #include <linux/icmpv6.h>
 #include <linux/socket.h>
 #include <linux/filter.h>
+#include <linux/compat.h>
 
 #include <net/scm.h>
 #include <net/sock.h>
@@ -123,7 +124,7 @@
 {
 	struct cmsghdr32 *ucmsg;
 	struct cmsghdr *kcmsg, *kcmsg_base;
-	__kernel_size_t32 ucmlen;
+	compat_size_t ucmlen;
 	__kernel_size_t kcmlen, tmp;
 
 	kcmlen = 0;
@@ -489,7 +490,7 @@
 		err = move_addr_to_user(addr, kern_msg.msg_namelen, uaddr, uaddr_len);
 	if(cmsg_ptr != 0 && err >= 0) {
 		unsigned long ucmsg_ptr = ((unsigned long)kern_msg.msg_control);
-		__kernel_size_t32 uclen = (__kernel_size_t32) (ucmsg_ptr - cmsg_ptr);
+		compat_size_t uclen = (compat_size_t) (ucmsg_ptr - cmsg_ptr);
 		err |= __put_user(uclen, &user_msg->msg_controllen);
 	}
 	if(err >= 0)
@@ -606,10 +607,10 @@
 extern asmlinkage long sys_getpeername(int fd, struct sockaddr *usockaddr,
 				      int *usockaddr_len);
 extern asmlinkage long sys_send(int fd, void *buff, size_t len, unsigned flags);
-extern asmlinkage long sys_sendto(int fd, u32 buff, __kernel_size_t32 len,
+extern asmlinkage long sys_sendto(int fd, u32 buff, compat_size_t len,
 				   unsigned flags, u32 addr, int addr_len);
 extern asmlinkage long sys_recv(int fd, void *ubuf, size_t size, unsigned flags);
-extern asmlinkage long sys_recvfrom(int fd, u32 ubuf, __kernel_size_t32 size,
+extern asmlinkage long sys_recvfrom(int fd, u32 ubuf, compat_size_t size,
 				     unsigned flags, u32 addr, u32 addr_len);
 extern asmlinkage long sys_getsockopt(int fd, int level, int optname,
 				       u32 optval, u32 optlen);
diff -ruN 2.5.50-BK.2/arch/x86_64/ia32/sys_ia32.c 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/sys_ia32.c
--- 2.5.50-BK.2/arch/x86_64/ia32/sys_ia32.c	2002-11-18 15:47:41.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/x86_64/ia32/sys_ia32.c	2002-12-04 16:27:36.000000000 +1100
@@ -26,7 +26,6 @@
 #include <linux/fs.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -58,6 +57,7 @@
 #include <linux/binfmts.h>
 #include <linux/init.h>
 #include <linux/aio_abi.h>
+#include <linux/compat.h>
 #include <asm/mman.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -498,19 +498,8 @@
 	return ret;
 }
 
-struct timeval32
-{
-    int tv_sec, tv_usec;
-};
-
-struct itimerval32
-{
-    struct timeval32 it_interval;
-    struct timeval32 it_value;
-};
-
 static inline long
-get_tv32(struct timeval *o, struct timeval32 *i)
+get_tv32(struct timeval *o, struct compat_timeval *i)
 {
 	int err = -EFAULT; 
 	if (access_ok(VERIFY_READ, i, sizeof(*i))) { 
@@ -521,7 +510,7 @@
 }
 
 static inline long
-put_tv32(struct timeval32 *o, struct timeval *i)
+put_tv32(struct compat_timeval *o, struct timeval *i)
 {
 	int err = -EFAULT;
 	if (access_ok(VERIFY_WRITE, o, sizeof(*o))) { 
@@ -531,70 +520,6 @@
 	return err; 
 }
 
-static inline long
-get_it32(struct itimerval *o, struct itimerval32 *i)
-{
-	int err = -EFAULT; 
-	if (access_ok(VERIFY_READ, i, sizeof(*i))) { 
-		err = __get_user(o->it_interval.tv_sec, &i->it_interval.tv_sec);
-		err |= __get_user(o->it_interval.tv_usec, &i->it_interval.tv_usec);
-		err |= __get_user(o->it_value.tv_sec, &i->it_value.tv_sec);
-		err |= __get_user(o->it_value.tv_usec, &i->it_value.tv_usec);
-	}
-	return err;
-}
-
-static inline long
-put_it32(struct itimerval32 *o, struct itimerval *i)
-{
-	int err = -EFAULT;
-	if (access_ok(VERIFY_WRITE, o, sizeof(*o))) {
-		err = __put_user(i->it_interval.tv_sec, &o->it_interval.tv_sec);
-		err |= __put_user(i->it_interval.tv_usec, &o->it_interval.tv_usec);
-		err |= __put_user(i->it_value.tv_sec, &o->it_value.tv_sec);
-		err |= __put_user(i->it_value.tv_usec, &o->it_value.tv_usec); 
-	} 
-	return err;
-}
-
-extern int do_getitimer(int which, struct itimerval *value);
-
-asmlinkage long
-sys32_getitimer(int which, struct itimerval32 *it)
-{
-	struct itimerval kit;
-	int error;
-
-	error = do_getitimer(which, &kit);
-	if (!error && put_it32(it, &kit))
-		error = -EFAULT;
-
-	return error;
-}
-
-extern int do_setitimer(int which, struct itimerval *, struct itimerval *);
-
-asmlinkage long
-sys32_setitimer(int which, struct itimerval32 *in, struct itimerval32 *out)
-{
-	struct itimerval kin, kout;
-	int error;
-
-	if (in) {
-		if (get_it32(&kin, in))
-			return -EFAULT;
-	} else
-		memset(&kin, 0, sizeof(kin));
-
-	error = do_setitimer(which, &kin, out ? &kout : NULL);
-	if (error || !out)
-		return error;
-	if (put_it32(out, &kout))
-		return -EFAULT;
-
-	return 0;
-
-}
 asmlinkage unsigned long 
 sys32_alarm(unsigned int seconds)
 {
@@ -616,45 +541,11 @@
 /* Translations due to time_t size differences.  Which affects all
    sorts of things, like timeval and itimerval.  */
 
-struct utimbuf_32 {
-	int	atime;
-	int	mtime;
-};
-
-extern asmlinkage long sys_utimes(char * filename, struct timeval * utimes);
-extern asmlinkage long sys_gettimeofday (struct timeval *tv, struct timezone *tz);
-
-asmlinkage long
-ia32_utime(char * filename, struct utimbuf_32 *times32)
-{
-	mm_segment_t old_fs = get_fs();
-	struct timeval tv[2];
-	long ret;
-
-	if (times32) {
-		get_user(tv[0].tv_sec, &times32->atime);
-		tv[0].tv_usec = 0;
-		get_user(tv[1].tv_sec, &times32->mtime);
-		tv[1].tv_usec = 0;
-		set_fs (KERNEL_DS);
-	} else {
-		set_fs (KERNEL_DS);
-		ret = sys_gettimeofday(&tv[0], 0);
-		if (ret < 0)
-			goto out;
-		tv[1] = tv[0];
-	}
-	ret = sys_utimes(filename, tv);
-  out:
-	set_fs (old_fs);
-	return ret;
-}
-
 extern struct timezone sys_tz;
 extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 
 asmlinkage long
-sys32_gettimeofday(struct timeval32 *tv, struct timezone *tz)
+sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	if (tv) {
 		struct timeval ktv;
@@ -670,7 +561,7 @@
 }
 
 asmlinkage long
-sys32_settimeofday(struct timeval32 *tv, struct timezone *tz)
+sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	struct timeval ktv;
 	struct timezone ktz;
@@ -827,7 +718,7 @@
 #define ROUND_UP_TIME(x,y) (((x)+(y)-1)/(y))
 
 asmlinkage long
-sys32_select(int n, fd_set *inp, fd_set *outp, fd_set *exp, struct timeval32 *tvp32)
+sys32_select(int n, fd_set *inp, fd_set *outp, fd_set *exp, struct compat_timeval *tvp32)
 {
 	fd_set_bits fds;
 	char *bits;
@@ -931,37 +822,7 @@
 	if (copy_from_user(&a, arg, sizeof(a)))
 		return -EFAULT;
 	return sys32_select(a.n, (fd_set *)A(a.inp), (fd_set *)A(a.outp), (fd_set *)A(a.exp),
-			    (struct timeval32 *)A(a.tvp));
-}
-
-struct timespec32 {
-	int 	tv_sec;
-	int	tv_nsec;
-};
-
-extern asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp); 
-
-asmlinkage long
-sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	int ret;
-	mm_segment_t old_fs = get_fs ();
-	
-	if (verify_area(VERIFY_READ, rqtp, sizeof(struct timespec32)) ||
-	    __get_user (t.tv_sec, &rqtp->tv_sec) ||
-	    __get_user (t.tv_nsec, &rqtp->tv_nsec))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_nanosleep(&t, rmtp ? &t : NULL);
-	set_fs (old_fs);
-	if (rmtp && ret == -EINTR) {
-		if (verify_area(VERIFY_WRITE, rmtp, sizeof(struct timespec32)) ||
-		    __put_user (t.tv_sec, &rmtp->tv_sec) ||
-	    	    __put_user (t.tv_nsec, &rmtp->tv_nsec))
-			return -EFAULT;
-	}
-	return ret;
+			    (struct compat_timeval *)A(a.tvp));
 }
 
 asmlinkage ssize_t sys_readv(unsigned long,const struct iovec *,unsigned long);
@@ -1153,8 +1014,8 @@
 }
 
 struct rusage32 {
-        struct timeval32 ru_utime;
-        struct timeval32 ru_stime;
+        struct compat_timeval ru_utime;
+        struct compat_timeval ru_stime;
         int    ru_maxrss;
         int    ru_ixrss;
         int    ru_idrss;
@@ -1406,38 +1267,6 @@
 
 /* 32-bit timeval and related flotsam.  */
 
-extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
-};
-
-asmlinkage long
-sys32_utime(char * filename, struct utimbuf32 *times)
-{
-	struct utimbuf t;
-	mm_segment_t old_fs;
-	int ret;
-	char *filenam;
-	
-	if (!times)
-		return sys_utime(filename, NULL);
-	if (verify_area(VERIFY_READ, times, sizeof(struct utimbuf32)) ||
-	    __get_user (t.actime, &times->actime) ||
-	    __get_user (t.modtime, &times->modtime))
-		return -EFAULT;
-	filenam = getname (filename);
-	ret = PTR_ERR(filenam);
-	if (!IS_ERR(filenam)) {
-		old_fs = get_fs();
-		set_fs (KERNEL_DS); 
-		ret = sys_utime(filenam, &t);
-		set_fs (old_fs);
-		putname(filenam);
-	}
-	return ret;
-}
-
 extern asmlinkage long sys_sysfs(int option, unsigned long arg1,
 				unsigned long arg2);
 
@@ -1528,7 +1357,7 @@
 						struct timespec *interval);
 
 asmlinkage long
-sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct timespec32 *interval)
+sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
@@ -1537,7 +1366,7 @@
 	set_fs (KERNEL_DS);
 	ret = sys_sched_rr_get_interval(pid, &t);
 	set_fs (old_fs);
-	if (verify_area(VERIFY_WRITE, interval, sizeof(struct timespec32)) ||
+	if (verify_area(VERIFY_WRITE, interval, sizeof(struct compat_timespec)) ||
 	    __put_user (t.tv_sec, &interval->tv_sec) ||
 	    __put_user (t.tv_nsec, &interval->tv_nsec))
 		return -EFAULT;
@@ -1582,7 +1411,7 @@
 extern asmlinkage long sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
 asmlinkage long
-sys32_rt_sigpending(sigset32_t *set, __kernel_size_t32 sigsetsize)
+sys32_rt_sigpending(sigset32_t *set, compat_size_t sigsetsize)
 {
 	sigset_t s;
 	sigset32_t s32;
@@ -1688,7 +1517,7 @@
 
 asmlinkage long
 sys32_rt_sigtimedwait(sigset32_t *uthese, siginfo_t32 *uinfo,
-		      struct timespec32 *uts, __kernel_size_t32 sigsetsize)
+		      struct compat_timespec *uts, compat_size_t sigsetsize)
 {
 	sigset_t s;
 	sigset32_t s32;
@@ -1707,7 +1536,7 @@
 	case 1: s.sig[0] = s32.sig[0] | (((long)s32.sig[1]) << 32);
 	}
 	if (uts) {
-		if (verify_area(VERIFY_READ, uts, sizeof(struct timespec32)) ||
+		if (verify_area(VERIFY_READ, uts, sizeof(struct compat_timespec)) ||
 		    __get_user (t.tv_sec, &uts->tv_sec) ||
 		    __get_user (t.tv_nsec, &uts->tv_nsec))
 			return -EFAULT;
@@ -1749,7 +1578,7 @@
 asmlinkage long sys_utimes(char *, struct timeval *);
 
 asmlinkage long
-sys32_utimes(char *filename, struct timeval32 *tvs)
+sys32_utimes(char *filename, struct compat_timeval *tvs)
 {
 	char *kfilename;
 	struct timeval ktvs[2];
@@ -1851,20 +1680,17 @@
 extern asmlinkage ssize_t sys_pwrite64(unsigned int fd, const char * buf,
 				     size_t count, loff_t pos);
 
-typedef __kernel_ssize_t32 ssize_t32;
-
-
 /* warning: next two assume little endian */ 
-asmlinkage ssize_t32
-sys32_pread(unsigned int fd, char *ubuf, __kernel_size_t32 count,
+asmlinkage compat_size_t
+sys32_pread(unsigned int fd, char *ubuf, compat_size_t count,
 	    u32 poslo, u32 poshi)
 {
 	return sys_pread64(fd, ubuf, count,
 			 ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
-asmlinkage ssize_t32
-sys32_pwrite(unsigned int fd, char *ubuf, __kernel_size_t32 count,
+asmlinkage compat_size_t
+sys32_pwrite(unsigned int fd, char *ubuf, compat_size_t count,
 	     u32 poslo, u32 poshi)
 {
 	return sys_pwrite64(fd, ubuf, count,
@@ -1916,7 +1742,7 @@
 	u32 modes;
 	s32 offset, freq, maxerror, esterror;
 	s32 status, constant, precision, tolerance;
-	struct timeval32 time;
+	struct compat_timeval time;
 	s32 tick;
 	s32 ppsfreq, jitter, shift, stabil;
 	s32 jitcnt, calcnt, errcnt, stbcnt;
diff -ruN 2.5.50-BK.2/include/asm-x86_64/compat.h 2.5.50-BK.2-32bit.1/include/asm-x86_64/compat.h
--- 2.5.50-BK.2/include/asm-x86_64/compat.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/asm-x86_64/compat.h	2002-12-04 15:17:13.000000000 +1100
@@ -0,0 +1,18 @@
+#ifndef _ASM_X86_64_COMPAT_H
+#define _ASM_X86_64_COMPAT_H
+/*
+ * Architecture specific compatibility types
+ */
+#include <linux/types.h>
+
+typedef u32		compat_size_t;
+typedef s32		compat_ssize_t;
+typedef s32		compat_time_t;
+typedef s32		compat_suseconds_t;
+
+struct compat_timespec {
+	compat_time_t	tv_sec;
+	s32		tv_nsec;
+};
+
+#endif /* _ASM_X86_64_COMPAT_H */
diff -ruN 2.5.50-BK.2/include/asm-x86_64/ia32.h 2.5.50-BK.2-32bit.1/include/asm-x86_64/ia32.h
--- 2.5.50-BK.2/include/asm-x86_64/ia32.h	2002-10-21 13:35:27.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/asm-x86_64/ia32.h	2002-12-04 14:46:21.000000000 +1100
@@ -10,10 +10,7 @@
  */
 
 /* 32bit compatibility types */
-typedef unsigned int	       __kernel_size_t32;
-typedef int		       __kernel_ssize_t32;
 typedef int		       __kernel_ptrdiff_t32;
-typedef int		       __kernel_time_t32;
 typedef int		       __kernel_clock_t32;
 typedef int		       __kernel_pid_t32;
 typedef unsigned short	       __kernel_ipc_pid_t32;
diff -ruN 2.5.50-BK.2/include/asm-x86_64/socket32.h 2.5.50-BK.2-32bit.1/include/asm-x86_64/socket32.h
--- 2.5.50-BK.2/include/asm-x86_64/socket32.h	2002-10-21 01:02:53.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/asm-x86_64/socket32.h	2002-12-04 14:31:17.000000000 +1100
@@ -1,6 +1,8 @@
 #ifndef SOCKET32_H
 #define SOCKET32_H 1
 
+#include <linux/compat.h>
+
 /* XXX This really belongs in some header file... -DaveM */
 #define MAX_SOCK_ADDR	128		/* 108 for Unix domain - 
 					   16 for IP, 16 for IPX,
@@ -11,14 +13,14 @@
         u32               msg_name;
         int               msg_namelen;
         u32               msg_iov;
-        __kernel_size_t32 msg_iovlen;
+        compat_size_t msg_iovlen;
         u32               msg_control;
-        __kernel_size_t32 msg_controllen;
+        compat_size_t msg_controllen;
         unsigned          msg_flags;
 };
 
 struct cmsghdr32 {
-        __kernel_size_t32 cmsg_len;
+        compat_size_t cmsg_len;
         int               cmsg_level;
         int               cmsg_type;
 };
