Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbSLDHTK>; Wed, 4 Dec 2002 02:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265059AbSLDHTK>; Wed, 4 Dec 2002 02:19:10 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:9607 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S264867AbSLDHTD>;
	Wed, 4 Dec 2002 02:19:03 -0500
Date: Wed, 4 Dec 2002 18:26:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compatibility syscall layer - IA64
Message-Id: <20021204182627.7472c1be.sfr@canb.auug.org.au>
In-Reply-To: <20021204180224.406d143c.sfr@canb.auug.org.au>
References: <20021204180224.406d143c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Linus,

This is the IA64 specific patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50-BK.2/arch/ia64/Kconfig 2.5.50-BK.2-32bit.1/arch/ia64/Kconfig
--- 2.5.50-BK.2/arch/ia64/Kconfig	2002-11-28 10:34:41.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/ia64/Kconfig	2002-12-03 16:52:09.000000000 +1100
@@ -397,6 +397,11 @@
 	  run IA-32 Linux binaries on an IA-64 Linux system.
 	  If in doubt, say Y.
 
+config COMPAT
+	bool
+	depends on IA32_SUPPORT
+	default y
+
 config PERFMON
 	bool "Performance monitor support"
 	help
diff -ruN 2.5.50-BK.2/arch/ia64/ia32/ia32_entry.S 2.5.50-BK.2-32bit.1/arch/ia64/ia32/ia32_entry.S
--- 2.5.50-BK.2/arch/ia64/ia32/ia32_entry.S	2002-05-30 05:12:20.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/ia64/ia32/ia32_entry.S	2002-12-04 17:40:17.000000000 +1100
@@ -221,7 +221,7 @@
 	data8 sys32_alarm
 	data8 sys32_ni_syscall
 	data8 sys32_pause
-	data8 sys32_utime	  /* 30 */
+	data8 compat_sys_utime	  /* 30 */
 	data8 sys32_ni_syscall	  /* old stty syscall holder */
 	data8 sys32_ni_syscall	  /* old gtty syscall holder */
 	data8 sys_access
@@ -295,8 +295,8 @@
 	data8 sys32_ioperm
 	data8 sys32_socketcall
 	data8 sys_syslog
-	data8 sys32_setitimer
-	data8 sys32_getitimer	  /* 105 */
+	data8 compat_sys_setitimer
+	data8 compat_sys_getitimer	  /* 105 */
 	data8 sys32_newstat
 	data8 sys32_newlstat
 	data8 sys32_newfstat
@@ -353,7 +353,7 @@
 	data8 sys_sched_get_priority_max
 	data8 sys_sched_get_priority_min	 /* 160 */
 	data8 sys32_sched_rr_get_interval
-	data8 sys32_nanosleep
+	data8 compat_sys_nanosleep
 	data8 sys_mremap
 	data8 sys_setresuid	/* 16-bit version */
 	data8 sys32_getresuid16	/* 16-bit version */	  /* 165 */
diff -ruN 2.5.50-BK.2/arch/ia64/ia32/ia32_signal.c 2.5.50-BK.2-32bit.1/arch/ia64/ia32/ia32_signal.c
--- 2.5.50-BK.2/arch/ia64/ia32/ia32_signal.c	2002-10-31 14:05:10.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/ia64/ia32/ia32_signal.c	2002-12-03 16:50:05.000000000 +1100
@@ -22,6 +22,7 @@
 #include <linux/stddef.h>
 #include <linux/unistd.h>
 #include <linux/wait.h>
+#include <linux/compat.h>
 
 #include <asm/uaccess.h>
 #include <asm/rse.h>
@@ -570,8 +571,8 @@
 }
 
 asmlinkage long
-sys32_rt_sigtimedwait (sigset32_t *uthese, siginfo_t32 *uinfo, struct timespec32 *uts,
-		       unsigned int sigsetsize)
+sys32_rt_sigtimedwait (sigset32_t *uthese, siginfo_t32 *uinfo,
+		struct compat_timespec *uts, unsigned int sigsetsize)
 {
 	extern asmlinkage long sys_rt_sigtimedwait (const sigset_t *, siginfo_t *,
 						    const struct timespec *, size_t);
diff -ruN 2.5.50-BK.2/arch/ia64/ia32/sys_ia32.c 2.5.50-BK.2-32bit.1/arch/ia64/ia32/sys_ia32.c
--- 2.5.50-BK.2/arch/ia64/ia32/sys_ia32.c	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/ia64/ia32/sys_ia32.c	2002-12-04 16:16:19.000000000 +1100
@@ -20,7 +20,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -49,6 +48,7 @@
 #include <linux/ptrace.h>
 #include <linux/stat.h>
 #include <linux/ipc.h>
+#include <linux/compat.h>
 
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -697,90 +697,20 @@
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
-get_tv32 (struct timeval *o, struct timeval32 *i)
+get_tv32 (struct timeval *o, struct compat_timeval *i)
 {
 	return (!access_ok(VERIFY_READ, i, sizeof(*i)) ||
 		(__get_user(o->tv_sec, &i->tv_sec) | __get_user(o->tv_usec, &i->tv_usec)));
 }
 
 static inline long
-put_tv32 (struct timeval32 *o, struct timeval *i)
+put_tv32 (struct compat_timeval *o, struct timeval *i)
 {
 	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
 		(__put_user(i->tv_sec, &o->tv_sec) | __put_user(i->tv_usec, &o->tv_usec)));
 }
 
-static inline long
-get_it32 (struct itimerval *o, struct itimerval32 *i)
-{
-	return (!access_ok(VERIFY_READ, i, sizeof(*i)) ||
-		(__get_user(o->it_interval.tv_sec, &i->it_interval.tv_sec) |
-		 __get_user(o->it_interval.tv_usec, &i->it_interval.tv_usec) |
-		 __get_user(o->it_value.tv_sec, &i->it_value.tv_sec) |
-		 __get_user(o->it_value.tv_usec, &i->it_value.tv_usec)));
-}
-
-static inline long
-put_it32 (struct itimerval32 *o, struct itimerval *i)
-{
-	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
-		(__put_user(i->it_interval.tv_sec, &o->it_interval.tv_sec) |
-		 __put_user(i->it_interval.tv_usec, &o->it_interval.tv_usec) |
-		 __put_user(i->it_value.tv_sec, &o->it_value.tv_sec) |
-		 __put_user(i->it_value.tv_usec, &o->it_value.tv_usec)));
-}
-
-extern int do_getitimer (int which, struct itimerval *value);
-
-asmlinkage long
-sys32_getitimer (int which, struct itimerval32 *it)
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
-extern int do_setitimer (int which, struct itimerval *, struct itimerval *);
-
-asmlinkage long
-sys32_setitimer (int which, struct itimerval32 *in, struct itimerval32 *out)
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
 asmlinkage unsigned long
 sys32_alarm (unsigned int seconds)
 {
@@ -802,42 +732,11 @@
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
-sys32_utime (char *filename, struct utimbuf_32 *times32)
-{
-	mm_segment_t old_fs = get_fs();
-	struct timeval tv[2], *tvp;
-	long ret;
-
-	if (times32) {
-		if (get_user(tv[0].tv_sec, &times32->atime))
-			return -EFAULT;
-		tv[0].tv_usec = 0;
-		if (get_user(tv[1].tv_sec, &times32->mtime))
-			return -EFAULT;
-		tv[1].tv_usec = 0;
-		set_fs(KERNEL_DS);
-		tvp = tv;
-	} else
-		tvp = NULL;
-	ret = sys_utimes(filename, tvp);
-	set_fs(old_fs);
-	return ret;
-}
-
 extern struct timezone sys_tz;
 extern int do_sys_settimeofday (struct timeval *tv, struct timezone *tz);
 
 asmlinkage long
-sys32_gettimeofday (struct timeval32 *tv, struct timezone *tz)
+sys32_gettimeofday (struct compat_timeval *tv, struct timezone *tz)
 {
 	if (tv) {
 		struct timeval ktv;
@@ -853,7 +752,7 @@
 }
 
 asmlinkage long
-sys32_settimeofday (struct timeval32 *tv, struct timezone *tz)
+sys32_settimeofday (struct compat_timeval *tv, struct timezone *tz)
 {
 	struct timeval ktv;
 	struct timezone ktz;
@@ -1003,7 +902,7 @@
 #define ROUND_UP_TIME(x,y) (((x)+(y)-1)/(y))
 
 asmlinkage long
-sys32_select (int n, fd_set *inp, fd_set *outp, fd_set *exp, struct timeval32 *tvp32)
+sys32_select (int n, fd_set *inp, fd_set *outp, fd_set *exp, struct compat_timeval *tvp32)
 {
 	fd_set_bits fds;
 	char *bits;
@@ -1110,28 +1009,7 @@
 	if (copy_from_user(&a, arg, sizeof(a)))
 		return -EFAULT;
 	return sys32_select(a.n, (fd_set *) A(a.inp), (fd_set *) A(a.outp), (fd_set *) A(a.exp),
-			    (struct timeval32 *) A(a.tvp));
-}
-
-extern asmlinkage long sys_nanosleep (struct timespec *rqtp, struct timespec *rmtp);
-
-asmlinkage long
-sys32_nanosleep (struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	if (get_user (t.tv_sec, &rqtp->tv_sec) || get_user (t.tv_nsec, &rqtp->tv_nsec))
-		return -EFAULT;
-	set_fs(KERNEL_DS);
-	ret = sys_nanosleep(&t, rmtp ? &t : NULL);
-	set_fs(old_fs);
-	if (rmtp && ret == -EINTR) {
-		if (put_user(t.tv_sec, &rmtp->tv_sec) || put_user(t.tv_nsec, &rmtp->tv_nsec))
-			return -EFAULT;
-	}
-	return ret;
+			    (struct compat_timeval *) A(a.tvp));
 }
 
 struct iovec32 { unsigned int iov_base; int iov_len; };
@@ -1304,7 +1182,7 @@
 };
 
 struct cmsghdr32 {
-	__kernel_size_t32 cmsg_len;
+	compat_size_t cmsg_len;
 	int               cmsg_level;
 	int               cmsg_type;
 };
@@ -1369,7 +1247,7 @@
 {
 	struct cmsghdr *kcmsg, *kcmsg_base;
 	__kernel_size_t kcmlen, tmp;
-	__kernel_size_t32 ucmlen;
+	compat_size_t ucmlen;
 	struct cmsghdr32 *ucmsg;
 	long err;
 
@@ -1893,10 +1771,10 @@
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
 extern asmlinkage long sys_setsockopt(int fd, int level, int optname,
 				     char *optval, int optlen);
@@ -2018,8 +1896,8 @@
 
 struct semid_ds32 {
 	struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-	__kernel_time_t32 sem_otime;              /* last semop time */
-	__kernel_time_t32 sem_ctime;              /* last change time */
+	compat_time_t   sem_otime;              /* last semop time */
+	compat_time_t   sem_ctime;              /* last change time */
 	u32 sem_base;              /* ptr to first semaphore in array */
 	u32 sem_pending;          /* pending operations to be processed */
 	u32 sem_pending_last;    /* last pending operation */
@@ -2029,9 +1907,9 @@
 
 struct semid64_ds32 {
 	struct ipc64_perm32 sem_perm;
-	__kernel_time_t32 sem_otime;
+	compat_time_t   sem_otime;
 	unsigned int __unused1;
-	__kernel_time_t32 sem_ctime;
+	compat_time_t   sem_ctime;
 	unsigned int __unused2;
 	unsigned int sem_nsems;
 	unsigned int __unused3;
@@ -2042,9 +1920,9 @@
 	struct ipc_perm32 msg_perm;
 	u32 msg_first;
 	u32 msg_last;
-	__kernel_time_t32 msg_stime;
-	__kernel_time_t32 msg_rtime;
-	__kernel_time_t32 msg_ctime;
+	compat_time_t   msg_stime;
+	compat_time_t   msg_rtime;
+	compat_time_t   msg_ctime;
 	u32 wwait;
 	u32 rwait;
 	unsigned short msg_cbytes;
@@ -2056,11 +1934,11 @@
 
 struct msqid64_ds32 {
 	struct ipc64_perm32 msg_perm;
-	__kernel_time_t32 msg_stime;
+	compat_time_t   msg_stime;
 	unsigned int __unused1;
-	__kernel_time_t32 msg_rtime;
+	compat_time_t   msg_rtime;
 	unsigned int __unused2;
-	__kernel_time_t32 msg_ctime;
+	compat_time_t   msg_ctime;
 	unsigned int __unused3;
 	unsigned int msg_cbytes;
 	unsigned int msg_qnum;
@@ -2074,9 +1952,9 @@
 struct shmid_ds32 {
 	struct ipc_perm32 shm_perm;
 	int shm_segsz;
-	__kernel_time_t32 shm_atime;
-	__kernel_time_t32 shm_dtime;
-	__kernel_time_t32 shm_ctime;
+	compat_time_t   shm_atime;
+	compat_time_t   shm_dtime;
+	compat_time_t   shm_ctime;
 	__kernel_ipc_pid_t32 shm_cpid;
 	__kernel_ipc_pid_t32 shm_lpid;
 	unsigned short shm_nattch;
@@ -2084,12 +1962,12 @@
 
 struct shmid64_ds32 {
 	struct ipc64_perm shm_perm;
-	__kernel_size_t32 shm_segsz;
-	__kernel_time_t32 shm_atime;
+	compat_size_t shm_segsz;
+	compat_time_t   shm_atime;
 	unsigned int __unused1;
-	__kernel_time_t32 shm_dtime;
+	compat_time_t   shm_dtime;
 	unsigned int __unused2;
-	__kernel_time_t32 shm_ctime;
+	compat_time_t   shm_ctime;
 	unsigned int __unused3;
 	__kernel_pid_t32 shm_cpid;
 	__kernel_pid_t32 shm_lpid;
@@ -2614,8 +2492,8 @@
 }
 
 struct rusage32 {
-	struct timeval32 ru_utime;
-	struct timeval32 ru_stime;
+	struct compat_timeval ru_utime;
+	struct compat_timeval ru_stime;
 	int    ru_maxrss;
 	int    ru_ixrss;
 	int    ru_idrss;
@@ -3623,7 +3501,7 @@
 }
 
 asmlinkage long
-sys32_sched_rr_get_interval (pid_t pid, struct timespec32 *interval)
+sys32_sched_rr_get_interval (pid_t pid, struct compat_timespec *interval)
 {
 	extern asmlinkage long sys_sched_rr_get_interval (pid_t, struct timespec *);
 	mm_segment_t old_fs = get_fs();
@@ -4192,7 +4070,7 @@
 	u32 modes;
 	s32 offset, freq, maxerror, esterror;
 	s32 status, constant, precision, tolerance;
-	struct timeval32 time;
+	struct compat_timeval time;
 	s32 tick;
 	s32 ppsfreq, jitter, shift, stabil;
 	s32 jitcnt, calcnt, errcnt, stbcnt;
diff -ruN 2.5.50-BK.2/include/asm-ia64/compat.h 2.5.50-BK.2-32bit.1/include/asm-ia64/compat.h
--- 2.5.50-BK.2/include/asm-ia64/compat.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/asm-ia64/compat.h	2002-12-04 15:05:49.000000000 +1100
@@ -0,0 +1,19 @@
+#ifndef _ASM_IA64_COMPAT_H
+#define _ASM_IA64_COMPAT_H
+/*
+ * Architecture specific compatibility types
+ */
+
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
+#endif /* _ASM_IA64_COMPAT_H */
diff -ruN 2.5.50-BK.2/include/asm-ia64/ia32.h 2.5.50-BK.2-32bit.1/include/asm-ia64/ia32.h
--- 2.5.50-BK.2/include/asm-ia64/ia32.h	2002-10-31 14:06:05.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/include/asm-ia64/ia32.h	2002-12-04 14:45:54.000000000 +1100
@@ -12,10 +12,7 @@
  */
 
 /* 32bit compatibility types */
-typedef unsigned int	__kernel_size_t32;
-typedef int		__kernel_ssize_t32;
 typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_time_t32;
 typedef int		__kernel_clock_t32;
 typedef int		__kernel_pid_t32;
 typedef unsigned short	__kernel_ipc_pid_t32;
@@ -41,11 +38,6 @@
 #define IA32_CLOCKS_PER_SEC	100	/* Cast in stone for IA32 Linux */
 #define IA32_TICK(tick)		((unsigned long long)(tick) * IA32_CLOCKS_PER_SEC / CLOCKS_PER_SEC)
 
-struct timespec32 {
-	int	tv_sec;
-	int	tv_nsec;
-};
-
 /* fcntl.h */
 struct flock32 {
        short l_type;
