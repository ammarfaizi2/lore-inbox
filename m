Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265800AbSLDHWU>; Wed, 4 Dec 2002 02:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSLDHWU>; Wed, 4 Dec 2002 02:22:20 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:45959 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265800AbSLDHWG>;
	Wed, 4 Dec 2002 02:22:06 -0500
Date: Wed, 4 Dec 2002 18:29:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: willy@debian.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compatibility syscall layer - PARISC
Message-Id: <20021204182926.09c50dd4.sfr@canb.auug.org.au>
In-Reply-To: <20021204180224.406d143c.sfr@canb.auug.org.au>
References: <20021204180224.406d143c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy, Linus,

This is tha PARISC specific patch.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50-BK.2/arch/parisc/Kconfig 2.5.50-BK.2-32bit.1/arch/parisc/Kconfig
--- 2.5.50-BK.2/arch/parisc/Kconfig	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/parisc/Kconfig	2002-12-03 16:56:52.000000000 +1100
@@ -107,6 +107,11 @@
 	  enable this option otherwise. The 64bit kernel is significantly bigger
 	  and slower than the 32bit one.
 
+config COMPAT
+	bool
+	depends PARISC64
+	default y
+
 config PDC_NARROW
 	bool "32-bit firmware"
 	depends on PARISC64
diff -ruN 2.5.50-BK.2/arch/parisc/kernel/binfmt_elf32.c 2.5.50-BK.2-32bit.1/arch/parisc/kernel/binfmt_elf32.c
--- 2.5.50-BK.2/arch/parisc/kernel/binfmt_elf32.c	2002-10-31 14:05:12.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/parisc/kernel/binfmt_elf32.c	2002-12-04 15:24:51.000000000 +1100
@@ -19,7 +19,7 @@
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/elfcore.h>
-#include "sys32.h"		/* struct timeval32 */
+#include <linux/compat.h>		/* struct compat_timeval */
 
 #define elf_prstatus elf_prstatus32
 struct elf_prstatus32
@@ -32,10 +32,10 @@
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
diff -ruN 2.5.50-BK.2/arch/parisc/kernel/ioctl32.c 2.5.50-BK.2-32bit.1/arch/parisc/kernel/ioctl32.c
--- 2.5.50-BK.2/arch/parisc/kernel/ioctl32.c	2002-10-31 14:05:12.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/parisc/kernel/ioctl32.c	2002-12-04 15:25:09.000000000 +1100
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/compat.h>
 #include "sys32.h"
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -164,7 +165,7 @@
  
 static int do_siocgstamp(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	struct timeval32 *up = (struct timeval32 *)arg;
+	struct compat_timeval *up = (struct compat_timeval *)arg;
 	struct timeval ktv;
 	mm_segment_t old_fs = get_fs();
 	int err;
@@ -1060,8 +1061,8 @@
 #define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
 
 struct ppp_idle32 {
-	__kernel_time_t32 xmit_idle;
-	__kernel_time_t32 recv_idle;
+	compat_time_t xmit_idle;
+	compat_time_t recv_idle;
 };
 #define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
 
diff -ruN 2.5.50-BK.2/arch/parisc/kernel/signal32.c 2.5.50-BK.2-32bit.1/arch/parisc/kernel/signal32.c
--- 2.5.50-BK.2/arch/parisc/kernel/signal32.c	2002-10-31 14:05:13.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/parisc/kernel/signal32.c	2002-12-04 14:34:27.000000000 +1100
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/compat.h>
 
 #include <asm/uaccess.h>
 #include "sys32.h"
@@ -175,7 +176,7 @@
 typedef struct {
 	unsigned int ss_sp;
 	int ss_flags;
-	__kernel_size_t32 ss_size;
+	compat_size_t ss_size;
 } stack_t32;
 
 int 
diff -ruN 2.5.50-BK.2/arch/parisc/kernel/sys32.h 2.5.50-BK.2-32bit.1/arch/parisc/kernel/sys32.h
--- 2.5.50-BK.2/arch/parisc/kernel/sys32.h	2002-10-31 14:05:13.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/parisc/kernel/sys32.h	2002-12-04 15:25:32.000000000 +1100
@@ -12,11 +12,6 @@
     set_fs (old_fs); \
 }
 
-struct timeval32 {
-	int tv_sec;
-	int tv_usec;
-};
-
 typedef __u32 __sighandler_t32;
 
 #include <linux/signal.h>
diff -ruN 2.5.50-BK.2/arch/parisc/kernel/sys_parisc32.c 2.5.50-BK.2-32bit.1/arch/parisc/kernel/sys_parisc32.c
--- 2.5.50-BK.2/arch/parisc/kernel/sys_parisc32.c	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/parisc/kernel/sys_parisc32.c	2002-12-04 16:18:23.000000000 +1100
@@ -16,7 +16,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -52,6 +51,7 @@
 #include <linux/mman.h>
 #include <linux/binfmts.h>
 #include <linux/namei.h>
+#include <linux/compat.h>
 
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -386,42 +386,6 @@
  * code available in case it's useful to others. -PB
  */
 
-/* from utime.h */
-struct utimbuf32 {
-	__kernel_time_t32 actime;
-	__kernel_time_t32 modtime;
-};
-
-asmlinkage long sys32_utime(char *filename, struct utimbuf32 *times)
-{
-    struct utimbuf32 times32;
-    struct utimbuf times64;
-    extern long sys_utime(char *filename, struct utimbuf *times);
-    char *fname;
-    long ret;
-
-    if (!times)
-    	return sys_utime(filename, NULL);
-
-    /* get the 32-bit struct from user space */
-    if (copy_from_user(&times32, times, sizeof times32))
-    	return -EFAULT;
-
-    /* convert it into the 64-bit one */
-    times64.actime = times32.actime;
-    times64.modtime = times32.modtime;
-
-    /* grab the file name */
-    fname = getname(filename);
-
-    KERNEL_SYSCALL(ret, sys_utime, fname, &times64);
-
-    /* free the file name */
-    putname(fname);
-
-    return ret;
-}
-
 struct tms32 {
 	__kernel_clock_t32 tms_utime;
 	__kernel_clock_t32 tms_stime;
@@ -584,71 +548,42 @@
 }
 #endif /* CONFIG_SYSCTL */
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-                
 static int
-put_timespec32(struct timespec32 *u, struct timespec *t)
+put_compat_timespec(struct compat_timespec *u, struct timespec *t)
 {
-	struct timespec32 t32;
+	struct compat_timespec t32;
 	t32.tv_sec = t->tv_sec;
 	t32.tv_nsec = t->tv_nsec;
 	return copy_to_user(u, &t32, sizeof t32);
 }
 
-asmlinkage int sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
-{
-	struct timespec t;
-	struct timespec32 t32;
-	int ret;
-	extern asmlinkage int sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp);
-	
-	if (copy_from_user(&t32, rqtp, sizeof t32))
-		return -EFAULT;
-	t.tv_sec = t32.tv_sec;
-	t.tv_nsec = t32.tv_nsec;
-
-	DBG(("sys32_nanosleep({%d, %d})\n", t32.tv_sec, t32.tv_nsec));
-
-	KERNEL_SYSCALL(ret, sys_nanosleep, &t, rmtp ? &t : NULL);
-	if (rmtp && ret == -EINTR) {
-		if (put_timespec32(rmtp, &t))
-			return -EFAULT;
-	}
-	return ret;
-}
-
 asmlinkage long sys32_sched_rr_get_interval(pid_t pid,
-	struct timespec32 *interval)
+	struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
 	extern asmlinkage long sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 	
 	KERNEL_SYSCALL(ret, sys_sched_rr_get_interval, pid, &t);
-	if (put_timespec32(interval, &t))
+	if (put_compat_timespec(interval, &t))
 		return -EFAULT;
 	return ret;
 }
 
-typedef __kernel_time_t32 time_t32;
-
 static int
-put_timeval32(struct timeval32 *u, struct timeval *t)
+put_compat_timeval(struct compat_timeval *u, struct timeval *t)
 {
-	struct timeval32 t32;
+	struct compat_timeval t32;
 	t32.tv_sec = t->tv_sec;
 	t32.tv_usec = t->tv_usec;
 	return copy_to_user(u, &t32, sizeof t32);
 }
 
 static int
-get_timeval32(struct timeval32 *u, struct timeval *t)
+get_compat_timeval(struct compat_timeval *u, struct timeval *t)
 {
 	int err;
-	struct timeval32 t32;
+	struct compat_timeval t32;
 
 	if ((err = copy_from_user(&t32, u, sizeof t32)) == 0)
 	{
@@ -658,10 +593,10 @@
 	return err;
 }
 
-asmlinkage long sys32_time(time_t32 *tloc)
+asmlinkage long sys32_time(compat_time_t *tloc)
 {
     time_t now = get_seconds();
-    time_t32 now32 = now;
+    compat_time_t now32 = now;
 
     if (tloc)
     	if (put_user(now32, tloc))
@@ -671,14 +606,14 @@
 }
 
 asmlinkage int
-sys32_gettimeofday(struct timeval32 *tv, struct timezone *tz)
+sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
     extern void do_gettimeofday(struct timeval *tv);
 
     if (tv) {
 	    struct timeval ktv;
 	    do_gettimeofday(&ktv);
-	    if (put_timeval32(tv, &ktv))
+	    if (put_compat_timeval(tv, &ktv))
 		    return -EFAULT;
     }
     if (tz) {
@@ -690,14 +625,14 @@
 }
 
 asmlinkage int
-sys32_settimeofday(struct timeval32 *tv, struct timezone *tz)
+sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
     struct timeval ktv;
     struct timezone ktz;
     extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 
     if (tv) {
-	    if (get_timeval32(tv, &ktv))
+	    if (get_compat_timeval(tv, &ktv))
 		    return -EFAULT;
     }
     if (tz) {
@@ -708,67 +643,9 @@
     return do_sys_settimeofday(tv ? &ktv : NULL, tz ? &ktz : NULL);
 }
 
-struct	itimerval32 {
-	struct	timeval32 it_interval;	/* timer interval */
-	struct	timeval32 it_value;	/* current value */
-};
-
-asmlinkage long sys32_getitimer(int which, struct itimerval32 *ov32)
-{
-	int error = -EFAULT;
-	struct itimerval get_buffer;
-	extern int do_getitimer(int which, struct itimerval *value);
-
-	if (ov32) {
-		error = do_getitimer(which, &get_buffer);
-		if (!error) {
-			struct itimerval32 gb32;
-			gb32.it_interval.tv_sec = get_buffer.it_interval.tv_sec;
-			gb32.it_interval.tv_usec = get_buffer.it_interval.tv_usec;
-			gb32.it_value.tv_sec = get_buffer.it_value.tv_sec;
-			gb32.it_value.tv_usec = get_buffer.it_value.tv_usec;
-			if (copy_to_user(ov32, &gb32, sizeof(gb32)))
-				error = -EFAULT; 
-		}
-	}
-	return error;
-}
-
-asmlinkage long sys32_setitimer(int which, struct itimerval32 *v32,
-			      struct itimerval32 *ov32)
-{
-	struct itimerval set_buffer, get_buffer;
-	struct itimerval32 sb32, gb32;
-	extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ov32);
-	int error;
-
-	if (v32) {
-		if(copy_from_user(&sb32, v32, sizeof(sb32)))
-			return -EFAULT;
-
-		set_buffer.it_interval.tv_sec = sb32.it_interval.tv_sec;
-		set_buffer.it_interval.tv_usec = sb32.it_interval.tv_usec;
-		set_buffer.it_value.tv_sec = sb32.it_value.tv_sec;
-		set_buffer.it_value.tv_usec = sb32.it_value.tv_usec;
-	} else
-		memset((char *) &set_buffer, 0, sizeof(set_buffer));
-
-	error = do_setitimer(which, &set_buffer, ov32 ? &get_buffer : 0);
-	if (error || !ov32)
-		return error;
-
-	gb32.it_interval.tv_sec = get_buffer.it_interval.tv_sec;
-	gb32.it_interval.tv_usec = get_buffer.it_interval.tv_usec;
-	gb32.it_value.tv_sec = get_buffer.it_value.tv_sec;
-	gb32.it_value.tv_usec = get_buffer.it_value.tv_usec;
-	if (copy_to_user(ov32, &gb32, sizeof(gb32)))
-		return -EFAULT; 
-	return 0;
-}
-
 struct rusage32 {
-        struct timeval32 ru_utime;
-        struct timeval32 ru_stime;
+        struct compat_timeval ru_utime;
+        struct compat_timeval ru_stime;
         int    ru_maxrss;
         int    ru_ixrss;
         int    ru_idrss;
@@ -850,11 +727,11 @@
 	unsigned short	st_reserved2;	/* old st_gid */
 	__kernel_dev_t32		st_rdev;
 	__kernel_off_t32		st_size;
-	__kernel_time_t32	st_atime;
+	compat_time_t	st_atime;
 	unsigned int	st_spare1;
-	__kernel_time_t32	st_mtime;
+	compat_time_t	st_mtime;
 	unsigned int	st_spare2;
-	__kernel_time_t32	st_ctime;
+	compat_time_t	st_ctime;
 	unsigned int	st_spare3;
 	int		st_blksize;
 	int		st_blocks;
@@ -1302,7 +1179,7 @@
 }
 
 static int
-qm_modules(char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_modules(char *buf, size_t bufsize, compat_size_t *ret)
 {
 	struct module *mod;
 	size_t nmod, space, len;
@@ -1337,7 +1214,7 @@
 }
 
 static int
-qm_deps(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_deps(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t i, space, len;
 
@@ -1374,7 +1251,7 @@
 }
 
 static int
-qm_refs(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_refs(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t nrefs, space, len;
 	struct module_ref *ref;
@@ -1418,7 +1295,7 @@
 }
 
 static inline int
-qm_symbols(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_symbols(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t i, space, len;
 	struct module_symbol *s;
@@ -1477,7 +1354,7 @@
 }
 
 static inline int
-qm_info(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_info(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	int error = 0;
 
@@ -1505,7 +1382,7 @@
 	return error;
 }
 
-asmlinkage int sys32_query_module(char *name_user, int which, char *buf, __kernel_size_t32 bufsize, __kernel_size_t32 *ret)
+asmlinkage int sys32_query_module(char *name_user, int which, char *buf, compat_size_t bufsize, compat_size_t *ret)
 {
 	struct module *mod;
 	int err;
@@ -1776,14 +1653,14 @@
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
@@ -1917,7 +1794,7 @@
 {
 	struct cmsghdr32 *ucmsg;
 	struct cmsghdr *kcmsg, *kcmsg_base;
-	__kernel_size_t32 ucmlen;
+	compat_size_t ucmlen;
 	__kernel_size_t kcmlen, tmp;
 
 	kcmlen = 0;
@@ -2283,7 +2160,7 @@
 		err = move_addr_to_user(addr, kern_msg.msg_namelen, uaddr, uaddr_len);
 	if(cmsg_ptr != 0 && err >= 0) {
 		unsigned long ucmsg_ptr = ((unsigned long)kern_msg.msg_control);
-		__kernel_size_t32 uclen = (__kernel_size_t32) (ucmsg_ptr - cmsg_ptr);
+		compat_size_t uclen = (compat_size_t) (ucmsg_ptr - cmsg_ptr);
 		err |= __put_user(uclen, &user_msg->msg_controllen);
 	}
 	if(err >= 0)
@@ -2590,7 +2467,7 @@
 #define DIVIDE_ROUND_UP(x,y) (((x)+(y)-1)/(y))
 
 asmlinkage long
-sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, struct timeval32 *tvp)
+sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, struct compat_timeval *tvp)
 {
 	fd_set_bits fds;
 	char *bits;
@@ -2599,7 +2476,7 @@
 
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (tvp) {
-		struct timeval32 tv32;
+		struct compat_timeval tv32;
 		time_t sec, usec;
 
 		if ((ret = copy_from_user(&tv32, tvp, sizeof tv32)))
@@ -2903,8 +2780,8 @@
     __u32 dqb_ihardlimit;
     __u32 dqb_isoftlimit;
     __u32 dqb_curinodes;
-    __kernel_time_t32 dqb_btime;
-    __kernel_time_t32 dqb_itime;
+    compat_time_t dqb_btime;
+    compat_time_t dqb_itime;
 };
                                 
 
@@ -2965,7 +2842,7 @@
 	int tolerance;		/* clock frequency tolerance (ppm)
 				 * (read only)
 				 */
-	struct timeval32 time;	/* (read only) */
+	struct compat_timeval time;	/* (read only) */
 	int tick;		/* (modified) usecs between clock ticks */
 
 	int ppsfreq;           /* pps frequency (scaled ppm) (ro) */
diff -ruN 2.5.50-BK.2/include/asm-parisc/compat.h 2.5.50-BK.2-32bit.1/include/asm-parisc/compat.h
--- 2.5.50-BK.2/include/asm-parisc/compat.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/asm-parisc/compat.h	2002-12-04 15:14:16.000000000 +1100
@@ -0,0 +1,18 @@
+#ifndef _ASM_PARISC_COMPAT_H
+#define _ASM_PARISC_COMPAT_H
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
+#endif /* _ASM_PARISC_COMPAT_H */
diff -ruN 2.5.50-BK.2/include/asm-parisc/posix_types.h 2.5.50-BK.2-32bit.1/include/asm-parisc/posix_types.h
--- 2.5.50-BK.2/include/asm-parisc/posix_types.h	2002-10-31 14:06:07.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/include/asm-parisc/posix_types.h	2002-12-04 14:46:06.000000000 +1100
@@ -66,10 +66,7 @@
 typedef unsigned short		__kernel_ipc_pid_t32;
 typedef unsigned int		__kernel_uid_t32;
 typedef unsigned int		__kernel_gid_t32;
-typedef unsigned int		__kernel_size_t32;
-typedef int			__kernel_ssize_t32;
 typedef int			__kernel_ptrdiff_t32;
-typedef int			__kernel_time_t32;
 typedef int			__kernel_suseconds_t32;
 typedef int			__kernel_clock_t32;
 typedef int			__kernel_daddr_t32;
