Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSLDHUz>; Wed, 4 Dec 2002 02:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbSLDHUy>; Wed, 4 Dec 2002 02:20:54 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:22151 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265351AbSLDHUj>;
	Wed, 4 Dec 2002 02:20:39 -0500
Date: Wed, 4 Dec 2002 18:28:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
Message-Id: <20021204182802.1b675d08.sfr@canb.auug.org.au>
In-Reply-To: <20021204180224.406d143c.sfr@canb.auug.org.au>
References: <20021204180224.406d143c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf, Linus,

This is the MIPS64 specific patch.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50-BK.2/arch/mips64/Kconfig 2.5.50-BK.2-32bit.1/arch/mips64/Kconfig
--- 2.5.50-BK.2/arch/mips64/Kconfig	2002-11-28 10:35:37.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/mips64/Kconfig	2002-12-03 16:53:57.000000000 +1100
@@ -371,6 +371,11 @@
 	  compatibility. Since all software available for Linux/MIPS is
 	  currently 32-bit you should say Y here.
 
+config COMPAT
+	bool
+	depends on MIPS32_COMPAT
+	default y
+
 config BINFMT_ELF32
 	bool
 	depends on MIPS32_COMPAT
diff -ruN 2.5.50-BK.2/arch/mips64/kernel/ioctl32.c 2.5.50-BK.2-32bit.1/arch/mips64/kernel/ioctl32.c
--- 2.5.50-BK.2/arch/mips64/kernel/ioctl32.c	2002-11-05 10:50:55.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/mips64/kernel/ioctl32.c	2002-12-04 15:21:53.000000000 +1100
@@ -9,6 +9,7 @@
  */
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
@@ -65,14 +66,9 @@
 
 #define A(__x) ((unsigned long)(__x))
 
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
diff -ruN 2.5.50-BK.2/arch/mips64/kernel/linux32.c 2.5.50-BK.2-32bit.1/arch/mips64/kernel/linux32.c
--- 2.5.50-BK.2/arch/mips64/kernel/linux32.c	2002-10-21 01:02:44.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/mips64/kernel/linux32.c	2002-12-04 16:17:27.000000000 +1100
@@ -22,11 +22,11 @@
 #include <linux/sem.h>
 #include <linux/msg.h>
 #include <linux/sysctl.h>
-#include <linux/utime.h>
 #include <linux/utsname.h>
 #include <linux/personality.h>
 #include <linux/timex.h>
 #include <linux/dnotify.h>
+#include <linux/compat.h>
 #include <net/sock.h>
 
 #include <asm/uaccess.h>
@@ -116,36 +116,6 @@
 	return sys_ftruncate(fd, ((long) high << 32) | low);
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
 #if 0
 /*
  * count32() counts the number of arguments/envelopes
@@ -463,20 +433,9 @@
 	return(n);
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
 struct rusage32 {
-        struct timeval32 ru_utime;
-        struct timeval32 ru_stime;
+        struct compat_timeval ru_utime;
+        struct compat_timeval ru_stime;
         int    ru_maxrss;
         int    ru_ixrss;
         int    ru_idrss;
@@ -683,7 +642,7 @@
 }
 
 static inline long
-get_tv32(struct timeval *o, struct timeval32 *i)
+get_tv32(struct timeval *o, struct compat_timeval *i)
 {
 	return (!access_ok(VERIFY_READ, i, sizeof(*i)) ||
 		(__get_user(o->tv_sec, &i->tv_sec) |
@@ -691,72 +650,13 @@
 }
 
 static inline long
-get_it32(struct itimerval *o, struct itimerval32 *i)
-{
-	return (!access_ok(VERIFY_READ, i, sizeof(*i)) ||
-		(__get_user(o->it_interval.tv_sec, &i->it_interval.tv_sec) |
-		 __get_user(o->it_interval.tv_usec, &i->it_interval.tv_usec) |
-		 __get_user(o->it_value.tv_sec, &i->it_value.tv_sec) |
-		 __get_user(o->it_value.tv_usec, &i->it_value.tv_usec)));
-}
-
-static inline long
-put_tv32(struct timeval32 *o, struct timeval *i)
+put_tv32(struct compat_timeval *o, struct timeval *i)
 {
 	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
 		(__put_user(i->tv_sec, &o->tv_sec) |
 		 __put_user(i->tv_usec, &o->tv_usec)));
 }
 
-static inline long
-put_it32(struct itimerval32 *o, struct itimerval *i)
-{
-	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
-		(__put_user(i->it_interval.tv_sec, &o->it_interval.tv_sec) |
-		 __put_user(i->it_interval.tv_usec, &o->it_interval.tv_usec) |
-		 __put_user(i->it_value.tv_sec, &o->it_value.tv_sec) |
-		 __put_user(i->it_value.tv_usec, &o->it_value.tv_usec)));
-}
-
-extern int do_getitimer(int which, struct itimerval *value);
-
-asmlinkage int
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
-
-asmlinkage int
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
@@ -784,7 +684,7 @@
 extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 
 asmlinkage int
-sys32_gettimeofday(struct timeval32 *tv, struct timezone *tz)
+sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	if (tv) {
 		struct timeval ktv;
@@ -800,7 +700,7 @@
 }
 
 asmlinkage int
-sys32_settimeofday(struct timeval32 *tv, struct timezone *tz)
+sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	struct timeval ktv;
 	struct timezone ktz;
@@ -1112,7 +1012,7 @@
 #define MAX_SELECT_SECONDS \
 	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
 
-asmlinkage int sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, struct timeval32 *tvp)
+asmlinkage int sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, struct compat_timeval *tvp)
 {
 	fd_set_bits fds;
 	char *bits;
@@ -1205,16 +1105,11 @@
 
 
 
-struct timespec32 {
-	int 	tv_sec;
-	int	tv_nsec;
-};
-
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid,
 						struct timespec *interval);
 
 asmlinkage int
-sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct timespec32 *interval)
+sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
@@ -1230,31 +1125,6 @@
 }
 
 
-extern asmlinkage int sys_nanosleep(struct timespec *rqtp,
-				    struct timespec *rmtp); 
-
-asmlinkage int
-sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	int ret;
-	mm_segment_t old_fs = get_fs ();
-
-	if (get_user (t.tv_sec, &rqtp->tv_sec) ||
-	    __get_user (t.tv_nsec, &rqtp->tv_nsec))
-		return -EFAULT;
-	
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
 struct tms32 {
 	int tms_utime;
 	int tms_stime;
@@ -1418,8 +1288,8 @@
 
 struct semid_ds32 {
         struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-        __kernel_time_t32 sem_otime;              /* last semop time */
-        __kernel_time_t32 sem_ctime;              /* last change time */
+        compat_time_t   sem_otime;              /* last semop time */
+        compat_time_t   sem_ctime;              /* last change time */
         u32 sem_base;              /* ptr to first semaphore in array */
         u32 sem_pending;          /* pending operations to be processed */
         u32 sem_pending_last;    /* last pending operation */
@@ -1432,9 +1302,9 @@
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
@@ -1447,9 +1317,9 @@
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
@@ -1819,7 +1689,7 @@
 	__kernel_caddr_t32 oldval;
 	__kernel_caddr_t32 oldlenp;
 	__kernel_caddr_t32 newval;
-	__kernel_size_t32 newlen;
+	compat_size_t newlen;
 	unsigned int __unused[4];
 };
 
@@ -1935,7 +1805,7 @@
 	u32 modes;
 	s32 offset, freq, maxerror, esterror;
 	s32 status, constant, precision, tolerance;
-	struct timeval32 time;
+	struct compat_timeval time;
 	s32 tick;
 	s32 ppsfreq, jitter, shift, stabil;
 	s32 jitcnt, calcnt, errcnt, stbcnt;
diff -ruN 2.5.50-BK.2/arch/mips64/kernel/scall_o32.S 2.5.50-BK.2-32bit.1/arch/mips64/kernel/scall_o32.S
--- 2.5.50-BK.2/arch/mips64/kernel/scall_o32.S	2002-02-11 15:12:25.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/mips64/kernel/scall_o32.S	2002-12-04 17:40:22.000000000 +1100
@@ -263,7 +263,7 @@
 	sys	sys32_alarm	1
 	sys	sys_fstat	2
 	sys	sys_pause	0
-	sys	sys32_utime	2			/* 4030 */
+	sys	compat_sys_utime	2			/* 4030 */
 	sys	sys_ni_syscall	0
 	sys	sys_ni_syscall	0
 	sys	sys_access	2
@@ -337,8 +337,8 @@
 	sys	sys_ni_syscall	0	/* sys_ioperm */
 	sys	sys_socketcall	2
 	sys	sys_syslog	3
-	sys	sys32_setitimer	3
-	sys	sys32_getitimer	2			/* 4105 */
+	sys	compat_sys_setitimer	3
+	sys	compat_sys_getitimer	2			/* 4105 */
 	sys	sys32_newstat	2
 	sys	sys32_newlstat	2
 	sys	sys32_newfstat	2
@@ -399,7 +399,7 @@
 	sys	sys_sched_get_priority_max 1
 	sys	sys_sched_get_priority_min 1
 	sys	sys32_sched_rr_get_interval 2		/* 4165 */
-	sys	sys32_nanosleep	2
+	sys	compat_sys_nanosleep	2
 	sys	sys_mremap	4
 	sys	sys_accept	3
 	sys	sys_bind	3
diff -ruN 2.5.50-BK.2/arch/mips64/kernel/signal32.c 2.5.50-BK.2-32bit.1/arch/mips64/kernel/signal32.c
--- 2.5.50-BK.2/arch/mips64/kernel/signal32.c	2002-05-30 05:12:21.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/mips64/kernel/signal32.c	2002-12-04 14:33:00.000000000 +1100
@@ -17,6 +17,7 @@
 #include <linux/wait.h>
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
+#include <linux/compat.h>
 
 #include <asm/asm.h>
 #include <asm/bitops.h>
@@ -59,7 +60,7 @@
 /* IRIX compatible stack_t  */
 typedef struct sigaltstack32 {
 	s32 ss_sp;
-	__kernel_size_t32 ss_size;
+	compat_size_t ss_size;
 	int ss_flags;
 } stack32_t;
 
diff -ruN 2.5.50-BK.2/include/asm-mips64/compat.h 2.5.50-BK.2-32bit.1/include/asm-mips64/compat.h
--- 2.5.50-BK.2/include/asm-mips64/compat.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/asm-mips64/compat.h	2002-12-04 15:12:07.000000000 +1100
@@ -0,0 +1,18 @@
+#ifndef _ASM_MIPS64_COMPAT_H
+#define _ASM_MIPS64_COMPAT_H
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
+#endif /* _ASM_MIPS64_COMPAT_H */
diff -ruN 2.5.50-BK.2/include/asm-mips64/posix_types.h 2.5.50-BK.2-32bit.1/include/asm-mips64/posix_types.h
--- 2.5.50-BK.2/include/asm-mips64/posix_types.h	2000-07-10 15:18:15.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/asm-mips64/posix_types.h	2002-12-04 14:46:01.000000000 +1100
@@ -58,10 +58,7 @@
 typedef int		__kernel_ipc_pid_t32;
 typedef int		__kernel_uid_t32;
 typedef int		__kernel_gid_t32;
-typedef unsigned int	__kernel_size_t32;
-typedef int		__kernel_ssize_t32;
 typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_time_t32;
 typedef int		__kernel_suseconds_t32;
 typedef int		__kernel_clock_t32;
 typedef int		__kernel_daddr_t32;
diff -ruN 2.5.50-BK.2/include/asm-mips64/stat.h 2.5.50-BK.2-32bit.1/include/asm-mips64/stat.h
--- 2.5.50-BK.2/include/asm-mips64/stat.h	2002-11-18 15:47:55.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/include/asm-mips64/stat.h	2002-12-03 17:05:07.000000000 +1100
@@ -10,6 +10,7 @@
 #define _ASM_STAT_H
 
 #include <linux/types.h>
+#include <linux/compat.h>
 
 struct __old_kernel_stat {
 	unsigned int	st_dev;
@@ -40,11 +41,11 @@
 	int		    st_pad2[2];
 	__kernel_off_t32    st_size;
 	int		    st_pad3;
-	__kernel_time_t32   st_atime;
+	compat_time_t     st_atime;
 	int		    reserved0;
-	__kernel_time_t32   st_mtime;
+	compat_time_t     st_mtime;
 	int		    reserved1;
-	__kernel_time_t32   st_ctime;
+	compat_time_t     st_ctime;
 	int		    reserved2;
 	int		    st_blksize;
 	int		    st_blocks;
