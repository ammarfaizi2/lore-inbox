Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264649AbSLDHJz>; Wed, 4 Dec 2002 02:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSLDHJz>; Wed, 4 Dec 2002 02:09:55 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:10118 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S264649AbSLDHJo>;
	Wed, 4 Dec 2002 02:09:44 -0500
Date: Wed, 4 Dec 2002 18:16:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davem@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compatibility syscall layer - SPARC64
Message-Id: <20021204181658.6acf7aa0.sfr@canb.auug.org.au>
In-Reply-To: <20021204180224.406d143c.sfr@canb.auug.org.au>
References: <20021204180224.406d143c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Linus,

This is the Sparc64 specific patch.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50-BK.2/arch/sparc64/Kconfig 2.5.50-BK.2-32bit.1/arch/sparc64/Kconfig
--- 2.5.50-BK.2/arch/sparc64/Kconfig	2002-11-28 10:35:37.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/sparc64/Kconfig	2002-12-03 17:00:37.000000000 +1100
@@ -352,6 +352,11 @@
 	  This allows you to run 32-bit binaries on your Ultra.
 	  Everybody wants this; say Y.
 
+config COMPAT
+	bool
+	depends on SPARC32_COMPAT
+	default y
+
 config BINFMT_ELF32
 	tristate "Kernel support for 32-bit ELF binaries"
 	depends on SPARC32_COMPAT
diff -ruN 2.5.50-BK.2/arch/sparc64/kernel/binfmt_elf32.c 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/binfmt_elf32.c
--- 2.5.50-BK.2/arch/sparc64/kernel/binfmt_elf32.c	2002-11-28 10:35:37.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/binfmt_elf32.c	2002-12-04 15:29:39.000000000 +1100
@@ -86,11 +86,7 @@
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/elfcore.h>
-
-struct timeval32
-{
-	int tv_sec, tv_usec;
-};
+#include <linux/compat.h>
 
 #define elf_prstatus elf_prstatus32
 struct elf_prstatus32
@@ -103,10 +99,10 @@
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
@@ -136,9 +132,9 @@
 
 #include <linux/time.h>
 
-#define jiffies_to_timeval jiffies_to_timeval32
+#define jiffies_to_timeval jiffies_to_compat_timeval
 static __inline__ void
-jiffies_to_timeval32(unsigned long jiffies, struct timeval32 *value)
+jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
 {
 	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
 	value->tv_sec = jiffies / HZ;
diff -ruN 2.5.50-BK.2/arch/sparc64/kernel/ioctl32.c 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/ioctl32.c
--- 2.5.50-BK.2/arch/sparc64/kernel/ioctl32.c	2002-11-18 15:47:41.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/ioctl32.c	2002-12-04 15:30:07.000000000 +1100
@@ -10,6 +10,7 @@
 
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
@@ -1743,8 +1739,8 @@
 #define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
 
 struct ppp_idle32 {
-	__kernel_time_t32 xmit_idle;
-	__kernel_time_t32 recv_idle;
+	compat_time_t xmit_idle;
+	compat_time_t recv_idle;
 };
 #define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
 
diff -ruN 2.5.50-BK.2/arch/sparc64/kernel/signal32.c 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/signal32.c
--- 2.5.50-BK.2/arch/sparc64/kernel/signal32.c	2002-11-28 10:35:37.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/signal32.c	2002-12-04 14:37:20.000000000 +1100
@@ -19,6 +19,7 @@
 #include <linux/tty.h>
 #include <linux/smp_lock.h>
 #include <linux/binfmts.h>
+#include <linux/compat.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -181,7 +182,7 @@
 	sigset_t32 set32;
         
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (((__kernel_size_t32)sigsetsize) != sizeof(sigset_t)) {
+	if (((compat_size_t)sigsetsize) != sizeof(sigset_t)) {
 		regs->tstate |= TSTATE_ICARRY;
 		regs->u_regs[UREG_I0] = EINVAL;
 		return;
diff -ruN 2.5.50-BK.2/arch/sparc64/kernel/sys32.S 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/sys32.S
--- 2.5.50-BK.2/arch/sparc64/kernel/sys32.S	2002-11-11 14:55:28.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/sys32.S	2002-12-04 14:36:56.000000000 +1100
@@ -175,7 +175,7 @@
 	 lduwa		[%o1 + 0x4] %asi, %o1
 	nop
 	nop
-do_sys_sendto: /* sys32_sendto(int, u32, __kernel_size_t32, unsigned int, u32, int) */
+do_sys_sendto: /* sys32_sendto(int, u32, compat_size_t, unsigned int, u32, int) */
 	ldswa		[%o1 + 0x0] %asi, %o0
 	sethi		%hi(sys32_sendto), %g1
 	lduwa		[%o1 + 0x8] %asi, %o2
@@ -184,7 +184,7 @@
 	ldswa		[%o1 + 0x14] %asi, %o5
 	jmpl		%g1 + %lo(sys32_sendto), %g0
 	 lduwa		[%o1 + 0x4] %asi, %o1
-do_sys_recvfrom: /* sys32_recvfrom(int, u32, __kernel_size_t32, unsigned int, u32, u32) */
+do_sys_recvfrom: /* sys32_recvfrom(int, u32, compat_size_t, unsigned int, u32, u32) */
 	ldswa		[%o1 + 0x0] %asi, %o0
 	sethi		%hi(sys32_recvfrom), %g1
 	lduwa		[%o1 + 0x8] %asi, %o2
diff -ruN 2.5.50-BK.2/arch/sparc64/kernel/sys_sparc32.c 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.50-BK.2/arch/sparc64/kernel/sys_sparc32.c	2002-12-04 12:07:33.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/sys_sparc32.c	2002-12-04 16:24:44.000000000 +1100
@@ -15,7 +15,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -52,6 +51,7 @@
 #include <linux/binfmts.h>
 #include <linux/dnotify.h>
 #include <linux/security.h>
+#include <linux/compat.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -263,49 +263,20 @@
 
 /* 32-bit timeval and related flotsam.  */
 
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
-static long get_tv32(struct timeval *o, struct timeval32 *i)
+static long get_tv32(struct timeval *o, struct compat_timeval *i)
 {
 	return (!access_ok(VERIFY_READ, tv32, sizeof(*tv32)) ||
 		(__get_user(o->tv_sec, &i->tv_sec) |
 		 __get_user(o->tv_usec, &i->tv_usec)));
 }
 
-static inline long put_tv32(struct timeval32 *o, struct timeval *i)
+static inline long put_tv32(struct compat_timeval *o, struct timeval *i)
 {
 	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
 		(__put_user(i->tv_sec, &o->tv_sec) |
 		 __put_user(i->tv_usec, &o->tv_usec)));
 }
 
-static inline long get_it32(struct itimerval *o, struct itimerval32 *i)
-{
-	return (!access_ok(VERIFY_READ, i32, sizeof(*i32)) ||
-		(__get_user(o->it_interval.tv_sec, &i->it_interval.tv_sec) |
-		 __get_user(o->it_interval.tv_usec, &i->it_interval.tv_usec) |
-		 __get_user(o->it_value.tv_sec, &i->it_value.tv_sec) |
-		 __get_user(o->it_value.tv_usec, &i->it_value.tv_usec)));
-}
-
-static long put_it32(struct itimerval32 *o, struct itimerval *i)
-{
-	return (!access_ok(VERIFY_WRITE, i32, sizeof(*i32)) ||
-		(__put_user(i->it_interval.tv_sec, &o->it_interval.tv_sec) |
-		 __put_user(i->it_interval.tv_usec, &o->it_interval.tv_usec) |
-		 __put_user(i->it_value.tv_sec, &o->it_value.tv_sec) |
-		 __put_user(i->it_value.tv_usec, &o->it_value.tv_usec)));
-}
-
 extern asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on);
 
 asmlinkage int sys32_ioperm(u32 from, u32 num, int on)
@@ -328,8 +299,8 @@
 
 struct semid_ds32 {
         struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-        __kernel_time_t32 sem_otime;              /* last semop time */
-        __kernel_time_t32 sem_ctime;              /* last change time */
+        compat_time_t   sem_otime;              /* last semop time */
+        compat_time_t   sem_ctime;              /* last change time */
         u32 sem_base;              /* ptr to first semaphore in array */
         u32 sem_pending;          /* pending operations to be processed */
         u32 sem_pending_last;    /* last pending operation */
@@ -340,9 +311,9 @@
 struct semid64_ds32 {
 	struct ipc64_perm sem_perm;		  /* this structure is the same on sparc32 and sparc64 */
 	unsigned int	  __pad1;
-	__kernel_time_t32 sem_otime;
+	compat_time_t   sem_otime;
 	unsigned int	  __pad2;
-	__kernel_time_t32 sem_ctime;
+	compat_time_t   sem_ctime;
 	u32 sem_nsems;
 	u32 __unused1;
 	u32 __unused2;
@@ -353,9 +324,9 @@
         struct ipc_perm32 msg_perm;
         u32 msg_first;
         u32 msg_last;
-        __kernel_time_t32 msg_stime;
-        __kernel_time_t32 msg_rtime;
-        __kernel_time_t32 msg_ctime;
+        compat_time_t   msg_stime;
+        compat_time_t   msg_rtime;
+        compat_time_t   msg_ctime;
         u32 wwait;
         u32 rwait;
         unsigned short msg_cbytes;
@@ -368,11 +339,11 @@
 struct msqid64_ds32 {
 	struct ipc64_perm msg_perm;
 	unsigned int   __pad1;
-	__kernel_time_t32 msg_stime;
+	compat_time_t   msg_stime;
 	unsigned int   __pad2;
-	__kernel_time_t32 msg_rtime;
+	compat_time_t   msg_rtime;
 	unsigned int   __pad3;
-	__kernel_time_t32 msg_ctime;
+	compat_time_t   msg_ctime;
 	unsigned int  msg_cbytes;
 	unsigned int  msg_qnum;
 	unsigned int  msg_qbytes;
@@ -386,9 +357,9 @@
 struct shmid_ds32 {
 	struct ipc_perm32       shm_perm;
 	int                     shm_segsz;
-	__kernel_time_t32       shm_atime;
-	__kernel_time_t32       shm_dtime;
-	__kernel_time_t32       shm_ctime;
+	compat_time_t         shm_atime;
+	compat_time_t         shm_dtime;
+	compat_time_t         shm_ctime;
 	__kernel_ipc_pid_t32    shm_cpid; 
 	__kernel_ipc_pid_t32    shm_lpid; 
 	unsigned short          shm_nattch;
@@ -397,12 +368,12 @@
 struct shmid64_ds32 {
 	struct ipc64_perm	shm_perm;
 	unsigned int		__pad1;
-	__kernel_time_t32	shm_atime;
+	compat_time_t  	shm_atime;
 	unsigned int		__pad2;
-	__kernel_time_t32	shm_dtime;
+	compat_time_t  	shm_dtime;
 	unsigned int		__pad3;
-	__kernel_time_t32	shm_ctime;
-	__kernel_size_t32	shm_segsz;
+	compat_time_t  	shm_ctime;
+	compat_size_t	shm_segsz;
 	__kernel_pid_t32	shm_cpid;
 	__kernel_pid_t32	shm_lpid;
 	unsigned int		shm_nattch;
@@ -965,37 +936,7 @@
 		return sys_ftruncate(fd, (high << 32) | low);
 }
 
-extern asmlinkage int sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
-};
-
-asmlinkage int sys32_utime(char * filename, struct utimbuf32 *times)
-{
-	struct utimbuf t;
-	mm_segment_t old_fs;
-	int ret;
-	char *filenam;
-	
-	if (!times)
-		return sys_utime(filename, NULL);
-	if (get_user (t.actime, &times->actime) ||
-	    __get_user (t.modtime, &times->modtime))
-		return -EFAULT;
-	filenam = getname (filename);
-	ret = PTR_ERR(filenam);
-	if (!IS_ERR(filenam)) {
-		old_fs = get_fs();
-		set_fs (KERNEL_DS); 
-		ret = sys_utime(filenam, &t);
-		set_fs (old_fs);
-		putname (filenam);
-	}
-	return ret;
-}
-
-struct iovec32 { u32 iov_base; __kernel_size_t32 iov_len; };
+struct iovec32 { u32 iov_base; compat_size_t iov_len; };
 
 typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
 typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
@@ -1003,7 +944,7 @@
 static long do_readv_writev32(int type, struct file *file,
 			      const struct iovec32 *vector, u32 count)
 {
-	__kernel_ssize_t32 tot_len;
+	compat_ssize_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov=iovstack, *ivp;
 	struct inode *inode;
@@ -1035,16 +976,16 @@
 	ivp = iov;
 	retval = -EINVAL;
 	while(i > 0) {
-		__kernel_ssize_t32 tmp = tot_len;
-		__kernel_ssize_t32 len;
+		compat_ssize_t tmp = tot_len;
+		compat_ssize_t len;
 		u32 buf;
 
 		__get_user(len, &vector->iov_len);
 		__get_user(buf, &vector->iov_base);
-		if (len < 0)	/* size_t not fittina an ssize_t32 .. */
+		if (len < 0)	/* size_t not fittina an compat_ssize_t .. */
 			goto out;
 		tot_len += len;
-		if (tot_len < tmp) /* maths overflow on the ssize_t32 */
+		if (tot_len < tmp) /* maths overflow on the compat_ssize_t */
 			goto out;
 		ivp->iov_base = (void *)A(buf);
 		ivp->iov_len = (__kernel_size_t) len;
@@ -1331,7 +1272,7 @@
 asmlinkage int sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, u32 tvp_x)
 {
 	fd_set_bits fds;
-	struct timeval32 *tvp = (struct timeval32 *)AA(tvp_x);
+	struct compat_timeval *tvp = (struct compat_timeval *)AA(tvp_x);
 	char *bits;
 	unsigned long nn;
 	long timeout;
@@ -1692,8 +1633,8 @@
 }
 
 struct rusage32 {
-        struct timeval32 ru_utime;
-        struct timeval32 ru_stime;
+        struct compat_timeval ru_utime;
+        struct compat_timeval ru_stime;
         s32    ru_maxrss;
         s32    ru_ixrss;
         s32    ru_idrss;
@@ -1795,14 +1736,9 @@
 	return ret;
 }
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-                
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 
-asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct timespec32 *interval)
+asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
@@ -1817,28 +1753,6 @@
 	return ret;
 }
 
-extern asmlinkage int sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp);
-
-asmlinkage int sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	int ret;
-	mm_segment_t old_fs = get_fs ();
-	
-	if (get_user (t.tv_sec, &rqtp->tv_sec) ||
-	    __get_user (t.tv_nsec, &rqtp->tv_nsec))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_nanosleep(&t, rmtp ? &t : NULL);
-	set_fs (old_fs);
-	if (rmtp && ret == -EINTR) {
-		if (__put_user (t.tv_sec, &rmtp->tv_sec) ||
-	    	    __put_user (t.tv_nsec, &rmtp->tv_nsec))
-			return -EFAULT;
-	}
-	return ret;
-}
-
 extern asmlinkage int sys_sigprocmask(int how, old_sigset_t *set, old_sigset_t *oset);
 
 asmlinkage int sys32_sigprocmask(int how, old_sigset_t32 *set, old_sigset_t32 *oset)
@@ -1858,7 +1772,7 @@
 
 extern asmlinkage int sys_rt_sigprocmask(int how, sigset_t *set, sigset_t *oset, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigprocmask(int how, sigset_t32 *set, sigset_t32 *oset, __kernel_size_t32 sigsetsize)
+asmlinkage int sys32_rt_sigprocmask(int how, sigset_t32 *set, sigset_t32 *oset, compat_size_t sigsetsize)
 {
 	sigset_t s;
 	sigset_t32 s32;
@@ -1909,7 +1823,7 @@
 
 extern asmlinkage int sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigpending(sigset_t32 *set, __kernel_size_t32 sigsetsize)
+asmlinkage int sys32_rt_sigpending(sigset_t32 *set, compat_size_t sigsetsize)
 {
 	sigset_t s;
 	sigset_t32 s32;
@@ -1934,7 +1848,7 @@
 
 asmlinkage int
 sys32_rt_sigtimedwait(sigset_t32 *uthese, siginfo_t32 *uinfo,
-		      struct timespec32 *uts, __kernel_size_t32 sigsetsize)
+		      struct compat_timespec *uts, compat_size_t sigsetsize)
 {
 	int ret, sig;
 	sigset_t these;
@@ -2139,14 +2053,14 @@
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
@@ -2280,7 +2194,7 @@
 {
 	struct cmsghdr32 *ucmsg;
 	struct cmsghdr *kcmsg, *kcmsg_base;
-	__kernel_size_t32 ucmlen;
+	compat_size_t ucmlen;
 	__kernel_size_t kcmlen, tmp;
 
 	kcmlen = 0;
@@ -2646,7 +2560,7 @@
 		err = move_addr_to_user(addr, kern_msg.msg_namelen, uaddr, uaddr_len);
 	if(cmsg_ptr != 0 && err >= 0) {
 		unsigned long ucmsg_ptr = ((unsigned long)kern_msg.msg_control);
-		__kernel_size_t32 uclen = (__kernel_size_t32) (ucmsg_ptr - cmsg_ptr);
+		compat_size_t uclen = (compat_size_t) (ucmsg_ptr - cmsg_ptr);
 		err |= __put_user(uclen, &user_msg->msg_controllen);
 	}
 	if(err >= 0)
@@ -2734,7 +2648,7 @@
 
 static int do_set_sock_timeout(int fd, int level, int optname, char *optval, int optlen)
 {
-	struct timeval32 *up = (struct timeval32 *) optval;
+	struct compat_timeval *up = (struct compat_timeval *) optval;
 	struct timeval ktime;
 	mm_segment_t old_fs;
 	int err;
@@ -2772,7 +2686,7 @@
 
 static int do_get_sock_timeout(int fd, int level, int optname, char *optval, int *optlen)
 {
-	struct timeval32 *up = (struct timeval32 *) optval;
+	struct compat_timeval *up = (struct compat_timeval *) optval;
 	struct timeval ktime;
 	mm_segment_t old_fs;
 	int len, err;
@@ -2843,7 +2757,7 @@
 
 asmlinkage int
 sys32_rt_sigaction(int sig, struct sigaction32 *act, struct sigaction32 *oact,
-		   void *restorer, __kernel_size_t32 sigsetsize)
+		   void *restorer, compat_size_t sigsetsize)
 {
         struct k_sigaction new_ka, old_ka;
         int ret;
@@ -3481,7 +3395,7 @@
 extern struct timezone sys_tz;
 extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 
-asmlinkage int sys32_gettimeofday(struct timeval32 *tv, struct timezone *tz)
+asmlinkage int sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	if (tv) {
 		struct timeval ktv;
@@ -3496,7 +3410,7 @@
 	return 0;
 }
 
-asmlinkage int sys32_settimeofday(struct timeval32 *tv, struct timezone *tz)
+asmlinkage int sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	struct timeval ktv;
 	struct timezone ktz;
@@ -3513,46 +3427,9 @@
 	return do_sys_settimeofday(tv ? &ktv : NULL, tz ? &ktz : NULL);
 }
 
-extern int do_getitimer(int which, struct itimerval *value);
-
-asmlinkage int sys32_getitimer(int which, struct itimerval32 *it)
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
-asmlinkage int sys32_setitimer(int which, struct itimerval32 *in, struct itimerval32 *out)
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
-
 asmlinkage int sys_utimes(char *, struct timeval *);
 
-asmlinkage int sys32_utimes(char *filename, struct timeval32 *tvs)
+asmlinkage int sys32_utimes(char *filename, struct compat_timeval *tvs)
 {
 	char *kfilename;
 	struct timeval ktvs[2];
@@ -3636,23 +3513,21 @@
 extern asmlinkage ssize_t sys_pwrite64(unsigned int fd, const char * buf,
 				     size_t count, loff_t pos);
 
-typedef __kernel_ssize_t32 ssize_t32;
-
-asmlinkage ssize_t32 sys32_pread64(unsigned int fd, char *ubuf,
-				   __kernel_size_t32 count, u32 poshi, u32 poslo)
+asmlinkage compat_ssize_t sys32_pread64(unsigned int fd, char *ubuf,
+				   compat_size_t count, u32 poshi, u32 poslo)
 {
 	return sys_pread64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
-asmlinkage ssize_t32 sys32_pwrite64(unsigned int fd, char *ubuf,
-				    __kernel_size_t32 count, u32 poshi, u32 poslo)
+asmlinkage compat_ssize_t sys32_pwrite64(unsigned int fd, char *ubuf,
+				    compat_size_t count, u32 poshi, u32 poslo)
 {
 	return sys_pwrite64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
 extern asmlinkage ssize_t sys_readahead(int fd, loff_t offset, size_t count);
 
-asmlinkage ssize_t32 sys32_readahead(int fd, u32 offhi, u32 offlo, s32 count)
+asmlinkage compat_ssize_t sys32_readahead(int fd, u32 offhi, u32 offlo, s32 count)
 {
 	return sys_readahead(fd, ((loff_t)AA(offhi) << 32) | AA(offlo), count);
 }
@@ -3705,7 +3580,7 @@
 	u32 modes;
 	s32 offset, freq, maxerror, esterror;
 	s32 status, constant, precision, tolerance;
-	struct timeval32 time;
+	struct compat_timeval time;
 	s32 tick;
 	s32 ppsfreq, jitter, shift, stabil;
 	s32 jitcnt, calcnt, errcnt, stbcnt;
diff -ruN 2.5.50-BK.2/arch/sparc64/kernel/sys_sunos32.c 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/sys_sunos32.c
--- 2.5.50-BK.2/arch/sparc64/kernel/sys_sunos32.c	2002-11-28 10:34:43.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/sys_sunos32.c	2002-12-04 15:28:36.000000000 +1100
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/types.h>
+#include <linux/compat.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
@@ -528,11 +529,6 @@
 extern asmlinkage int
 sys32_select(int n, u32 inp, u32 outp, u32 exp, u32 tvp);
 
-struct timeval32
-{
-	int tv_sec, tv_usec;
-};
-
 asmlinkage int sunos_select(int width, u32 inp, u32 outp, u32 exp, u32 tvp_x)
 {
 	int ret;
@@ -540,7 +536,7 @@
 	/* SunOS binaries expect that select won't change the tvp contents */
 	ret = sys32_select (width, inp, outp, exp, tvp_x);
 	if (ret == -EINTR && tvp_x) {
-		struct timeval32 *tvp = (struct timeval32 *)A(tvp_x);
+		struct compat_timeval *tvp = (struct compat_timeval *)A(tvp_x);
 		time_t sec, usec;
 
 		__get_user(sec, &tvp->tv_sec);
@@ -948,9 +944,9 @@
         struct ipc_perm32 msg_perm;
         u32 msg_first;
         u32 msg_last;
-        __kernel_time_t32 msg_stime;
-        __kernel_time_t32 msg_rtime;
-        __kernel_time_t32 msg_ctime;
+        compat_time_t msg_stime;
+        compat_time_t msg_rtime;
+        compat_time_t msg_ctime;
         u32 wwait;
         u32 rwait;
         unsigned short msg_cbytes;
@@ -1085,9 +1081,9 @@
 struct shmid_ds32 {
         struct ipc_perm32       shm_perm;
         int                     shm_segsz;
-        __kernel_time_t32       shm_atime;
-        __kernel_time_t32       shm_dtime;
-        __kernel_time_t32       shm_ctime;
+        compat_time_t         shm_atime;
+        compat_time_t         shm_dtime;
+        compat_time_t         shm_ctime;
         __kernel_ipc_pid_t32    shm_cpid; 
         __kernel_ipc_pid_t32    shm_lpid; 
         unsigned short          shm_nattch;
diff -ruN 2.5.50-BK.2/arch/sparc64/kernel/systbls.S 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/systbls.S
--- 2.5.50-BK.2/arch/sparc64/kernel/systbls.S	2002-11-28 10:35:37.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/sparc64/kernel/systbls.S	2002-12-04 17:40:44.000000000 +1100
@@ -25,7 +25,7 @@
 /*15*/	.word sys32_chmod, sys32_lchown16, sparc_brk, sys_perfctr, sys32_lseek
 /*20*/	.word sys_getpid, sys_capget, sys_capset, sys32_setuid16, sys32_getuid16
 /*25*/	.word sys_time, sys_ptrace, sys_alarm, sys32_sigaltstack, sys32_pause
-/*30*/	.word sys32_utime, sys_lchown, sys_fchown, sys_access, sys_nice
+/*30*/	.word compat_sys_utime, sys_lchown, sys_fchown, sys_access, sys_nice
 	.word sys_chown, sys_sync, sys_kill, sys32_newstat, sys32_sendfile
 /*40*/	.word sys32_newlstat, sys_dup, sys_pipe, sys32_times, sys_getuid
 	.word sys_umount, sys32_setgid16, sys32_getgid16, sys_signal, sys32_geteuid16
@@ -35,8 +35,8 @@
 	.word sys_msync, sys_vfork, sys32_pread64, sys32_pwrite64, sys_geteuid
 /*70*/	.word sys_getegid, sys32_mmap, sys_setreuid, sys_munmap, sys_mprotect
 	.word sys_madvise, sys_vhangup, sys32_truncate64, sys_mincore, sys32_getgroups16
-/*80*/	.word sys32_setgroups16, sys_getpgrp, sys_setgroups, sys32_setitimer, sys32_ftruncate64
-	.word sys_swapon, sys32_getitimer, sys_setuid, sys_sethostname, sys_setgid
+/*80*/	.word sys32_setgroups16, sys_getpgrp, sys_setgroups, compat_sys_setitimer, sys32_ftruncate64
+	.word sys_swapon, compat_sys_getitimer, sys_setuid, sys_sethostname, sys_setgid
 /*90*/	.word sys_dup2, sys_setfsuid, sys32_fcntl, sys32_select, sys_setfsgid
 	.word sys_fsync, sys_setpriority32, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
 /*100*/ .word sys_getpriority, sys32_rt_sigreturn, sys32_rt_sigaction, sys32_rt_sigprocmask, sys32_rt_sigpending
@@ -68,7 +68,7 @@
 /*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, sys_alloc_hugepages
 	.word sys_free_hugepages, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, sys_sched_setscheduler, sys_sched_getscheduler
-	.word sys_sched_yield, sys_sched_get_priority_max, sys_sched_get_priority_min, sys32_sched_rr_get_interval, sys32_nanosleep
+	.word sys_sched_yield, sys_sched_get_priority_max, sys_sched_get_priority_min, sys32_sched_rr_get_interval, compat_sys_nanosleep
 /*250*/	.word sys32_mremap, sys32_sysctl, sys_getsid, sys_fdatasync, sys32_nfsservctl
 	.word sys_aplib
 
@@ -166,8 +166,8 @@
 	.word sys_mprotect, sys_madvise, sys_vhangup
 	.word sunos_nosys, sys_mincore, sys32_getgroups16
 	.word sys32_setgroups16, sys_getpgrp, sunos_setpgrp
-	.word sys32_setitimer, sunos_nosys, sys_swapon
-	.word sys32_getitimer, sys_gethostname, sys_sethostname
+	.word compat_sys_setitimer, sunos_nosys, sys_swapon
+	.word compat_sys_getitimer, sys_gethostname, sys_sethostname
 	.word sunos_getdtablesize, sys_dup2, sunos_nop
 	.word sys32_fcntl, sunos_select, sunos_nop
 	.word sys_fsync, sys_setpriority32, sunos_socket
diff -ruN 2.5.50-BK.2/arch/sparc64/solaris/misc.c 2.5.50-BK.2-32bit.1/arch/sparc64/solaris/misc.c
--- 2.5.50-BK.2/arch/sparc64/solaris/misc.c	2002-10-14 18:17:30.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/sparc64/solaris/misc.c	2002-12-04 15:32:41.000000000 +1100
@@ -16,6 +16,7 @@
 #include <linux/file.h>
 #include <linux/timex.h>
 #include <linux/major.h>
+#include <linux/compat.h>
 
 #include <asm/uaccess.h>
 #include <asm/string.h>
@@ -597,12 +598,8 @@
 	return ret;
 }
 
-struct timeval32 {
-	int tv_sec, tv_usec;
-};
-
 struct sol_ntptimeval {
-	struct timeval32 time;
+	struct compat_timeval time;
 	s32 maxerror;
 	s32 esterror;
 };
diff -ruN 2.5.50-BK.2/arch/sparc64/solaris/socket.c 2.5.50-BK.2-32bit.1/arch/sparc64/solaris/socket.c
--- 2.5.50-BK.2/arch/sparc64/solaris/socket.c	2002-11-28 10:34:43.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/sparc64/solaris/socket.c	2002-12-04 14:39:38.000000000 +1100
@@ -14,6 +14,7 @@
 #include <linux/socket.h>
 #include <linux/file.h>
 #include <linux/net.h>
+#include <linux/compat.h>
 
 #include <asm/uaccess.h>
 #include <asm/string.h>
@@ -378,7 +379,7 @@
 	if(kern_msg.msg_controllen) {
 		struct sol_cmsghdr *ucmsg = (struct sol_cmsghdr *)kern_msg.msg_control;
 		unsigned long *kcmsg;
-		__kernel_size_t32 cmlen;
+		compat_size_t cmlen;
 
 		if(kern_msg.msg_controllen > sizeof(ctl) &&
 		   kern_msg.msg_controllen <= 256) {
@@ -392,7 +393,7 @@
 		*kcmsg++ = (unsigned long)cmlen;
 		err = -EFAULT;
 		if(copy_from_user(kcmsg, &ucmsg->cmsg_level,
-				  kern_msg.msg_controllen - sizeof(__kernel_size_t32)))
+				  kern_msg.msg_controllen - sizeof(compat_size_t)))
 			goto out_freectl;
 		kern_msg.msg_control = ctl_buf;
 	}
diff -ruN 2.5.50-BK.2/include/asm-sparc64/compat.h 2.5.50-BK.2-32bit.1/include/asm-sparc64/compat.h
--- 2.5.50-BK.2/include/asm-sparc64/compat.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/asm-sparc64/compat.h	2002-12-04 15:16:20.000000000 +1100
@@ -0,0 +1,18 @@
+#ifndef _ASM_SPARC64_COMPAT_H
+#define _ASM_SPARC64_COMPAT_H
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
+#endif /* _ASM_SPARC64_COMPAT_H */
diff -ruN 2.5.50-BK.2/include/asm-sparc64/posix_types.h 2.5.50-BK.2-32bit.1/include/asm-sparc64/posix_types.h
--- 2.5.50-BK.2/include/asm-sparc64/posix_types.h	2000-10-28 04:55:01.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/include/asm-sparc64/posix_types.h	2002-12-04 14:46:11.000000000 +1100
@@ -48,10 +48,7 @@
 } __kernel_fsid_t;
 
 /* Now 32bit compatibility types */
-typedef unsigned int           __kernel_size_t32;
-typedef int                    __kernel_ssize_t32;
 typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
 typedef int                    __kernel_clock_t32;
 typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
diff -ruN 2.5.50-BK.2/include/asm-sparc64/signal.h 2.5.50-BK.2-32bit.1/include/asm-sparc64/signal.h
--- 2.5.50-BK.2/include/asm-sparc64/signal.h	2002-06-21 10:22:39.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/asm-sparc64/signal.h	2002-12-04 14:29:24.000000000 +1100
@@ -8,6 +8,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/personality.h>
 #include <linux/types.h>
+#include <linux/compat.h>
 #endif
 #endif
 
@@ -250,7 +251,7 @@
 typedef struct sigaltstack32 {
 	u32			ss_sp;
 	int			ss_flags;
-	__kernel_size_t32	ss_size;
+	compat_size_t		ss_size;
 } stack_t32;
 
 #define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
diff -ruN 2.5.50-BK.2/include/asm-sparc64/stat.h 2.5.50-BK.2-32bit.1/include/asm-sparc64/stat.h
--- 2.5.50-BK.2/include/asm-sparc64/stat.h	2002-11-18 15:47:55.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/include/asm-sparc64/stat.h	2002-12-03 17:05:52.000000000 +1100
@@ -3,6 +3,7 @@
 #define _SPARC64_STAT_H
 
 #include <linux/types.h>
+#include <linux/compat.h>
 #include <linux/time.h>
 
 struct stat32 {
@@ -14,11 +15,11 @@
 	__kernel_gid_t32   st_gid;
 	__kernel_dev_t32   st_rdev;
 	__kernel_off_t32   st_size;
-	__kernel_time_t32  st_atime;
+	compat_time_t    st_atime;
 	unsigned int       __unused1;
-	__kernel_time_t32  st_mtime;
+	compat_time_t    st_mtime;
 	unsigned int       __unused2;
-	__kernel_time_t32  st_ctime;
+	compat_time_t    st_ctime;
 	unsigned int       __unused3;
 	__kernel_off_t32   st_blksize;
 	__kernel_off_t32   st_blocks;
