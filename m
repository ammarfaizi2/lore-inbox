Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbSLDHAV>; Wed, 4 Dec 2002 02:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbSLDHAV>; Wed, 4 Dec 2002 02:00:21 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:18309 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266939AbSLDHAI>;
	Wed, 4 Dec 2002 02:00:08 -0500
Date: Wed, 4 Dec 2002 18:07:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: anton@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compatibility syscall layer - PPC64
Message-Id: <20021204180729.22cf57c0.sfr@canb.auug.org.au>
In-Reply-To: <20021204180224.406d143c.sfr@canb.auug.org.au>
References: <20021204180224.406d143c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton, Linus,

This is the PPC64 specific patch.  It goes slightly further than necessary
by defining compat_size_t and compat_ssize_t.

This builds.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50-BK.2/arch/ppc64/Kconfig 2.5.50-BK.2-32bit.1/arch/ppc64/Kconfig
--- 2.5.50-BK.2/arch/ppc64/Kconfig	2002-12-04 12:07:31.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/ppc64/Kconfig	2002-12-04 12:18:35.000000000 +1100
@@ -33,6 +33,10 @@
 	bool
 	default y
 
+config COMPAT
+	bool
+	default y
+
 source "init/Kconfig"
 
 
diff -ruN 2.5.50-BK.2/arch/ppc64/kernel/binfmt_elf32.c 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/binfmt_elf32.c
--- 2.5.50-BK.2/arch/ppc64/kernel/binfmt_elf32.c	2002-07-25 10:42:55.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/binfmt_elf32.c	2002-12-04 15:33:43.000000000 +1100
@@ -21,11 +21,7 @@
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
@@ -38,10 +34,10 @@
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
 	elf_gregset_t pr_reg;		/* General purpose registers. */
 	int pr_fpvalid;		/* True if math co-processor being used. */
 };
@@ -64,9 +60,9 @@
 
 #include <linux/time.h>
 
-#define jiffies_to_timeval jiffies_to_timeval32
+#define jiffies_to_timeval jiffies_to_compat_timeval
 static __inline__ void
-jiffies_to_timeval32(unsigned long jiffies, struct timeval32 *value)
+jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
 {
 	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
 	value->tv_sec = jiffies / HZ;
diff -ruN 2.5.50-BK.2/arch/ppc64/kernel/ioctl32.c 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/ioctl32.c
--- 2.5.50-BK.2/arch/ppc64/kernel/ioctl32.c	2002-11-11 14:55:28.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/ioctl32.c	2002-12-04 15:34:07.000000000 +1100
@@ -22,6 +22,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -397,14 +398,9 @@
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
@@ -1424,8 +1420,8 @@
 #define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
 
 struct ppp_idle32 {
-	__kernel_time_t32 xmit_idle;
-	__kernel_time_t32 recv_idle;
+	compat_time_t xmit_idle;
+	compat_time_t recv_idle;
 };
 #define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
 
diff -ruN 2.5.50-BK.2/arch/ppc64/kernel/misc.S 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/misc.S
--- 2.5.50-BK.2/arch/ppc64/kernel/misc.S	2002-12-04 12:07:31.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/misc.S	2002-12-04 17:40:50.000000000 +1100
@@ -538,7 +538,7 @@
 	.llong .sys_alarm
 	.llong .sys_ni_syscall		/* old fstat syscall */
 	.llong .sys32_pause
-	.llong .sys32_utime		/* 30 */
+	.llong .compat_sys_utime		/* 30 */
 	.llong .sys_ni_syscall		/* old stty syscall */
 	.llong .sys_ni_syscall		/* old gtty syscall */
 	.llong .sys32_access
@@ -612,8 +612,8 @@
 	.llong .sys_ioperm
 	.llong .sys32_socketcall
 	.llong .sys32_syslog
-	.llong .sys32_setitimer
-	.llong .sys32_getitimer		/* 105 */
+	.llong .compat_sys_setitimer
+	.llong .compat_sys_getitimer		/* 105 */
 	.llong .sys32_newstat
 	.llong .sys32_newlstat
 	.llong .sys32_newfstat
@@ -670,7 +670,7 @@
 	.llong .sys32_sched_get_priority_max
 	.llong .sys32_sched_get_priority_min  /* 160 */
 	.llong .sys32_sched_rr_get_interval
-	.llong .sys32_nanosleep
+	.llong .compat_sys_nanosleep
 	.llong .sys32_mremap
 	.llong .sys_setresuid
 	.llong .sys_getresuid	        /* 165 */
diff -ruN 2.5.50-BK.2/arch/ppc64/kernel/signal32.c 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/signal32.c
--- 2.5.50-BK.2/arch/ppc64/kernel/signal32.c	2002-10-21 01:02:45.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/signal32.c	2002-12-04 14:40:20.000000000 +1100
@@ -22,6 +22,7 @@
 #include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/elf.h>
+#include <linux/compat.h>
 #include <asm/ppc32.h>
 #include <asm/uaccess.h>
 #include <asm/ppcdebug.h>
@@ -53,11 +54,6 @@
 #define MSR_USERCHANGE	0
 #endif
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-
 struct sigregs32 {
 	/*
 	 * the gp_regs array is 32 bit representation of the pt_regs
@@ -635,8 +631,7 @@
 extern long sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
 
-long sys32_rt_sigpending(sigset32_t *set,
-		__kernel_size_t32 sigsetsize)
+long sys32_rt_sigpending(sigset32_t *set, compat_size_t sigsetsize)
 {
 	sigset_t s;
 	sigset32_t s32;
@@ -708,7 +703,7 @@
 		size_t sigsetsize);
 
 long sys32_rt_sigtimedwait(sigset32_t *uthese, siginfo_t32 *uinfo,
-		struct timespec32 *uts, __kernel_size_t32 sigsetsize)
+		struct compat_timespec *uts, compat_size_t sigsetsize)
 {
 	sigset_t s;
 	sigset32_t s32;
diff -ruN 2.5.50-BK.2/arch/ppc64/kernel/sys32.S 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/sys32.S
--- 2.5.50-BK.2/arch/ppc64/kernel/sys32.S	2002-12-04 12:07:32.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/sys32.S	2002-12-04 14:40:30.000000000 +1100
@@ -134,7 +134,7 @@
 	lwz		r6,12(r10)
 	b		.sys_recv
 
-_STATIC(do_sys_sendto) /* sys32_sendto(int, u32, __kernel_size_t32, unsigned int, u32, int) */
+_STATIC(do_sys_sendto) /* sys32_sendto(int, u32, compat_size_t, unsigned int, u32, int) */
 	mr		r10,r4
 	lwa		r3,0(r10)
 	lwz		r4,4(r10)
@@ -144,7 +144,7 @@
 	lwa		r8,20(r10)
 	b		.sys32_sendto
 
-_STATIC(do_sys_recvfrom) /* sys32_recvfrom(int, u32, __kernel_size_t32, unsigned int, u32, u32) */
+_STATIC(do_sys_recvfrom) /* sys32_recvfrom(int, u32, compat_size_t, unsigned int, u32, u32) */
 	mr		r10,r4
 	lwa		r3,0(r10)
 	lwz		r4,4(r10)
diff -ruN 2.5.50-BK.2/arch/ppc64/kernel/sys_ppc32.c 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.50-BK.2/arch/ppc64/kernel/sys_ppc32.c	2002-12-04 12:07:32.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/ppc64/kernel/sys_ppc32.c	2002-12-04 16:26:18.000000000 +1100
@@ -22,7 +22,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -58,6 +57,7 @@
 #include <linux/binfmts.h>
 #include <linux/dnotify.h>
 #include <linux/security.h>
+#include <linux/compat.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -73,38 +73,7 @@
 #include <asm/ppc32.h>
 #include <asm/mmu_context.h>
 
-extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
-};
-
-asmlinkage long sys32_utime(char * filename, struct utimbuf32 *times)
-{
-	struct utimbuf t;
-	mm_segment_t old_fs;
-	int ret;
-	char *filenam;
-	
-	if (!times)
-		return sys_utime(filename, NULL);
-	if (get_user(t.actime, &times->actime) ||
-	    __get_user(t.modtime, &times->modtime))
-		return -EFAULT;
-	filenam = getname(filename);
-	ret = PTR_ERR(filenam);
-	if (!IS_ERR(filenam)) {
-		old_fs = get_fs();
-		set_fs (KERNEL_DS); 
-		ret = sys_utime(filenam, &t);
-		set_fs (old_fs);
-		putname (filenam);
-	}
-
-	return ret;
-}
-
-struct iovec32 { u32 iov_base; __kernel_size_t32 iov_len; };
+struct iovec32 { u32 iov_base; compat_size_t iov_len; };
 
 typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
 typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
@@ -112,7 +81,7 @@
 static long do_readv_writev32(int type, struct file *file,
 			      const struct iovec32 *vector, u32 count)
 {
-	__kernel_ssize_t32 tot_len;
+	compat_ssize_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov=iovstack, *ivp;
 	struct inode *inode;
@@ -159,8 +128,8 @@
 	ivp = iov;
 	retval = -EINVAL;
 	while(i > 0) {
-		__kernel_ssize_t32 tmp = tot_len;
-		__kernel_ssize_t32 len;
+		compat_ssize_t tmp = tot_len;
+		compat_ssize_t len;
 		u32 buf;
 
 		if (__get_user(len, &vector->iov_len) ||
@@ -168,10 +137,10 @@
 			retval = -EFAULT;
 			goto out;
 		}
-		if (len < 0)	/* size_t not fitting an ssize_t32 .. */
+		if (len < 0)	/* size_t not fitting an compat_ssize_t .. */
 			goto out;
 		tot_len += len;
-		if (tot_len < tmp) /* maths overflow on the ssize_t32 */
+		if (tot_len < tmp) /* maths overflow on the compat_ssize_t */
 			goto out;
 		ivp->iov_base = (void *)A(buf);
 		ivp->iov_len = (__kernel_size_t) len;
@@ -664,20 +633,6 @@
 
 /* 32-bit timeval and related flotsam.  */
 
-struct timeval32
-{
-	int tv_sec, tv_usec;
-};
-
-struct itimerval32
-{
-	struct timeval32 it_interval;
-	struct timeval32 it_value;
-};
-
-
-
-
 /*
  * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
  * 64-bit unsigned longs.
@@ -743,7 +698,7 @@
 asmlinkage long sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, u32 tvp_x)
 {
 	fd_set_bits fds;
-	struct timeval32 *tvp = (struct timeval32 *)AA(tvp_x);
+	struct compat_timeval *tvp = (struct compat_timeval *)AA(tvp_x);
 	char *bits;
 	unsigned long nn;
 	long timeout;
@@ -1021,7 +976,7 @@
 	u32 modes;
 	s32 offset, freq, maxerror, esterror;
 	s32 status, constant, precision, tolerance;
-	struct timeval32 time;
+	struct compat_timeval time;
 	s32 tick;
 	s32 ppsfreq, jitter, shift, stabil;
 	s32 jitcnt, calcnt, errcnt, stbcnt;
@@ -1098,7 +1053,7 @@
 
 extern asmlinkage unsigned long sys_create_module(const char *name_user, size_t size);
 
-asmlinkage unsigned long sys32_create_module(const char *name_user, __kernel_size_t32 size)
+asmlinkage unsigned long sys32_create_module(const char *name_user, compat_size_t size)
 {
 	return sys_create_module(name_user, (size_t)size);
 }
@@ -1181,7 +1136,7 @@
 }
 
 static int
-qm_modules(char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_modules(char *buf, size_t bufsize, compat_size_t *ret)
 {
 	struct module *mod;
 	size_t nmod, space, len;
@@ -1216,7 +1171,7 @@
 }
 
 static int
-qm_deps(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_deps(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t i, space, len;
 
@@ -1253,7 +1208,7 @@
 }
 
 static int
-qm_refs(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_refs(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t nrefs, space, len;
 	struct module_ref *ref;
@@ -1297,7 +1252,7 @@
 }
 
 static inline int
-qm_symbols(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_symbols(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t i, space, len;
 	struct module_symbol *s;
@@ -1356,7 +1311,7 @@
 }
 
 static inline int
-qm_info(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_info(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	int error = 0;
 
@@ -1389,7 +1344,7 @@
  * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
  * and the register representation of a signed int (msr in 64-bit mode) is performed.
  */
-asmlinkage long sys32_query_module(char *name_user, u32 which, char *buf, __kernel_size_t32 bufsize, u32 ret)
+asmlinkage long sys32_query_module(char *name_user, u32 which, char *buf, compat_size_t bufsize, u32 ret)
 {
 	struct module *mod;
 	int err;
@@ -1425,19 +1380,19 @@
 		err = 0;
 		break;
 	case QM_MODULES:
-		err = qm_modules(buf, bufsize, (__kernel_size_t32 *)AA(ret));
+		err = qm_modules(buf, bufsize, (compat_size_t *)AA(ret));
 		break;
 	case QM_DEPS:
-		err = qm_deps(mod, buf, bufsize, (__kernel_size_t32 *)AA(ret));
+		err = qm_deps(mod, buf, bufsize, (compat_size_t *)AA(ret));
 		break;
 	case QM_REFS:
-		err = qm_refs(mod, buf, bufsize, (__kernel_size_t32 *)AA(ret));
+		err = qm_refs(mod, buf, bufsize, (compat_size_t *)AA(ret));
 		break;
 	case QM_SYMBOLS:
-		err = qm_symbols(mod, buf, bufsize, (__kernel_size_t32 *)AA(ret));
+		err = qm_symbols(mod, buf, bufsize, (compat_size_t *)AA(ret));
 		break;
 	case QM_INFO:
-		err = qm_info(mod, buf, bufsize, (__kernel_size_t32 *)AA(ret));
+		err = qm_info(mod, buf, bufsize, (compat_size_t *)AA(ret));
 		break;
 	default:
 		err = -EINVAL;
@@ -1863,37 +1818,6 @@
 
 
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-
-extern asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp);
-
-asmlinkage long sys32_nanosleep(struct timespec32 *rqtp, struct timespec32 *rmtp)
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
-	
-	return ret;
-}
-
-
-
-
 /* These are here just in case some old sparc32 binary calls it. */
 asmlinkage long sys32_pause(void)
 {
@@ -1905,32 +1829,14 @@
 
 
 
-static inline long get_it32(struct itimerval *o, struct itimerval32 *i)
-{
-	return (!access_ok(VERIFY_READ, i, sizeof(*i)) ||
-		(__get_user(o->it_interval.tv_sec, &i->it_interval.tv_sec) |
-		 __get_user(o->it_interval.tv_usec, &i->it_interval.tv_usec) |
-		 __get_user(o->it_value.tv_sec, &i->it_value.tv_sec) |
-		 __get_user(o->it_value.tv_usec, &i->it_value.tv_usec)));
-}
-
-static inline long put_it32(struct itimerval32 *o, struct itimerval *i)
-{
-	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
-		(__put_user(i->it_interval.tv_sec, &o->it_interval.tv_sec) |
-		 __put_user(i->it_interval.tv_usec, &o->it_interval.tv_usec) |
-		 __put_user(i->it_value.tv_sec, &o->it_value.tv_sec) |
-		 __put_user(i->it_value.tv_usec, &o->it_value.tv_usec)));
-}
-
-static inline long get_tv32(struct timeval *o, struct timeval32 *i)
+static inline long get_tv32(struct timeval *o, struct compat_timeval *i)
 {
 	return (!access_ok(VERIFY_READ, i, sizeof(*i)) ||
 		(__get_user(o->tv_sec, &i->tv_sec) |
 		 __get_user(o->tv_usec, &i->tv_usec)));
 }
 
-static inline long put_tv32(struct timeval32 *o, struct timeval *i)
+static inline long put_tv32(struct compat_timeval *o, struct timeval *i)
 {
 	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
 		(__put_user(i->tv_sec, &o->tv_sec) |
@@ -1940,54 +1846,6 @@
 
 
 
-extern int do_getitimer(int which, struct itimerval *value);
-
-/* Note: it is necessary to treat which as an unsigned int, 
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long sys32_getitimer(u32 which, struct itimerval32 *it)
-{
-	struct itimerval kit;
-	int error;
-	
-	error = do_getitimer((int)which, &kit);
-	if (!error && put_it32(it, &kit))
-		error = -EFAULT;
-
-	return error;
-}
-
-
-
-extern int do_setitimer(int which, struct itimerval *, struct itimerval *);
-
-/* Note: it is necessary to treat which as an unsigned int, 
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long sys32_setitimer(u32 which, struct itimerval32 *in, struct itimerval32 *out)
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
-	error = do_setitimer((int)which, &kin, out ? &kout : NULL);
-	if (error || !out)
-		return error;
-	if (put_it32(out, &kout))
-		return -EFAULT;
-
-	return 0;
-}
-
 #define RLIM_INFINITY32	0xffffffff
 #define RESOURCE32(x) ((x > RLIM_INFINITY32) ? RLIM_INFINITY32 : x)
 
@@ -2062,8 +1920,8 @@
 
 
 struct rusage32 {
-        struct timeval32 ru_utime;
-        struct timeval32 ru_stime;
+        struct compat_timeval ru_utime;
+        struct compat_timeval ru_stime;
         s32    ru_maxrss;
         s32    ru_ixrss;
         s32    ru_idrss;
@@ -2180,7 +2038,7 @@
 extern struct timezone sys_tz;
 extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 
-asmlinkage long sys32_gettimeofday(struct timeval32 *tv, struct timezone *tz)
+asmlinkage long sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	if (tv) {
 		struct timeval ktv;
@@ -2198,7 +2056,7 @@
 
 
 
-asmlinkage long sys32_settimeofday(struct timeval32 *tv, struct timezone *tz)
+asmlinkage long sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	struct timeval ktv;
 	struct timezone ktz;
@@ -2251,8 +2109,8 @@
 
 struct semid_ds32 {
 	struct ipc_perm sem_perm;
-	__kernel_time_t32 sem_otime;
-	__kernel_time_t32 sem_ctime;
+	compat_time_t sem_otime;
+	compat_time_t sem_ctime;
 	u32 sem_base;
 	u32 sem_pending;
 	u32 sem_pending_last;
@@ -2263,9 +2121,9 @@
 struct semid64_ds32 {
 	struct ipc64_perm sem_perm;
 	unsigned int __unused1;
-	__kernel_time_t32 sem_otime;
+	compat_time_t sem_otime;
 	unsigned int __unused2;
-	__kernel_time_t32 sem_ctime;
+	compat_time_t sem_ctime;
 	u32 sem_nsems;
 	u32 __unused3;
 	u32 __unused4;
@@ -2276,9 +2134,9 @@
 	struct ipc_perm msg_perm;
 	u32 msg_first;
 	u32 msg_last;
-	__kernel_time_t32 msg_stime;
-	__kernel_time_t32 msg_rtime;
-	__kernel_time_t32 msg_ctime;
+	compat_time_t msg_stime;
+	compat_time_t msg_rtime;
+	compat_time_t msg_ctime;
 	u32 msg_lcbytes;
 	u32 msg_lqbytes;
 	unsigned short msg_cbytes;
@@ -2291,11 +2149,11 @@
 struct msqid64_ds32 {
 	struct ipc64_perm msg_perm;
 	unsigned int __unused1;
-	__kernel_time_t32 msg_stime;
+	compat_time_t msg_stime;
 	unsigned int __unused2;
-	__kernel_time_t32 msg_rtime;
+	compat_time_t msg_rtime;
 	unsigned int __unused3;
-	__kernel_time_t32 msg_ctime;
+	compat_time_t msg_ctime;
 	unsigned int msg_cbytes;
 	unsigned int msg_qnum;
 	unsigned int msg_qbytes;
@@ -2308,9 +2166,9 @@
 struct shmid_ds32 {
 	struct ipc_perm shm_perm;
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
@@ -2322,13 +2180,13 @@
 struct shmid64_ds32 {
 	struct ipc64_perm shm_perm;
 	unsigned int __unused1;
-	__kernel_time_t32 shm_atime;
+	compat_time_t shm_atime;
 	unsigned int __unused2;
-	__kernel_time_t32 shm_dtime;
+	compat_time_t shm_dtime;
 	unsigned int __unused3;
-	__kernel_time_t32 shm_ctime;
+	compat_time_t shm_ctime;
 	unsigned int __unused4;
-	__kernel_size_t32 shm_segsz;
+	compat_size_t shm_segsz;
 	__kernel_pid_t32 shm_cpid;
 	__kernel_pid_t32 shm_lpid;
 	unsigned int shm_nattch;
@@ -2966,7 +2824,7 @@
 
 static int do_set_sock_timeout(int fd, int level, int optname, char *optval, int optlen)
 {
-	struct timeval32 *up = (struct timeval32 *) optval;
+	struct compat_timeval *up = (struct compat_timeval *) optval;
 	struct timeval ktime;
 	mm_segment_t old_fs;
 	int err;
@@ -3003,7 +2861,7 @@
 
 static int do_get_sock_timeout(int fd, int level, int optname, char *optval, int *optlen)
 {
-	struct timeval32 *up = (struct timeval32 *) optval;
+	struct compat_timeval *up = (struct compat_timeval *) optval;
 	struct timeval ktime;
 	mm_segment_t old_fs;
 	int len, err;
@@ -3054,15 +2912,15 @@
 	u32               msg_name;
 	int               msg_namelen;
 	u32               msg_iov;
-	__kernel_size_t32 msg_iovlen;
+	compat_size_t msg_iovlen;
 	u32               msg_control;
-	__kernel_size_t32 msg_controllen;
+	compat_size_t msg_controllen;
 	unsigned          msg_flags;
 };
 
 struct cmsghdr32
 {
-	__kernel_size_t32 cmsg_len;
+	compat_size_t cmsg_len;
 	int               cmsg_level;
 	int               cmsg_type;
 };
@@ -3180,7 +3038,7 @@
 {
 	struct cmsghdr32 *ucmsg;
 	struct cmsghdr *kcmsg, *kcmsg_base;
-	__kernel_size_t32 ucmlen;
+	compat_size_t ucmlen;
 	__kernel_size_t kcmlen, tmp;
 
 	kcmlen = 0;
@@ -3447,12 +3305,12 @@
 			 * from 64-bit time values to 32-bit time values
 			 */
 		case SO_TIMESTAMP: {
-			__kernel_time_t32* ptr_time32 = CMSG32_DATA(kcmsg32);
+			compat_time_t* ptr_time32 = CMSG32_DATA(kcmsg32);
 			__kernel_time_t*   ptr_time   = CMSG_DATA(ucmsg);
 			*ptr_time32     = *ptr_time;
 			*(ptr_time32+1) = *(ptr_time+1);
 			kcmsg32->cmsg_len -= 2*(sizeof(__kernel_time_t) -
-						sizeof(__kernel_time_t32));
+						sizeof(compat_time_t));
 		}
 		default:;
 		}
@@ -3563,7 +3421,7 @@
 		err = move_addr_to_user(addr, kern_msg.msg_namelen, uaddr, uaddr_len);
 	if(cmsg_ptr != 0 && err >= 0) {
 		unsigned long ucmsg_ptr = ((unsigned long)kern_msg.msg_control);
-		__kernel_size_t32 uclen = (__kernel_size_t32) (ucmsg_ptr - cmsg_ptr);
+		compat_size_t uclen = (compat_size_t) (ucmsg_ptr - cmsg_ptr);
 		err |= __put_user(uclen, &user_msg->msg_controllen);
 	}
 	if(err >= 0)
@@ -3821,7 +3679,7 @@
  * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
  * and the register representation of a signed int (msr in 64-bit mode) is performed.
  */
-asmlinkage int sys32_sched_rr_get_interval(u32 pid, struct timespec32 *interval)
+asmlinkage int sys32_sched_rr_get_interval(u32 pid, struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
@@ -4323,15 +4181,13 @@
 extern ssize_t sys_pwrite64(unsigned int fd, const char *buf, size_t count,
 			    loff_t pos);
 
-typedef __kernel_ssize_t32 ssize_t32;
-
-ssize_t32 sys32_pread64(unsigned int fd, char *ubuf, __kernel_size_t32 count,
+compat_ssize_t sys32_pread64(unsigned int fd, char *ubuf, compat_size_t count,
 			u32 reg6, u32 poshi, u32 poslo)
 {
 	return sys_pread64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
-ssize_t32 sys32_pwrite64(unsigned int fd, char *ubuf, __kernel_size_t32 count,
+compat_ssize_t sys32_pwrite64(unsigned int fd, char *ubuf, compat_size_t count,
 			 u32 reg6, u32 poshi, u32 poslo)
 {
 	return sys_pwrite64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
@@ -4339,7 +4195,7 @@
 
 extern ssize_t sys_readahead(int fd, loff_t offset, size_t count);
 
-ssize_t32 sys32_readahead(int fd, u32 r4, u32 offhi, u32 offlo, u32 count)
+compat_ssize_t sys32_readahead(int fd, u32 r4, u32 offhi, u32 offlo, u32 count)
 {
         return sys_readahead(fd, ((loff_t)offhi << 32) | offlo, AA(count));
 }
@@ -4418,9 +4274,9 @@
 	return error;
 }
 
-asmlinkage long sys32_time(__kernel_time_t32* tloc)
+asmlinkage long sys32_time(compat_time_t* tloc)
 {
-	__kernel_time_t32 secs;
+	compat_time_t secs;
 
 	struct timeval tv;
 
diff -ruN 2.5.50-BK.2/include/asm-ppc64/compat.h 2.5.50-BK.2-32bit.1/include/asm-ppc64/compat.h
--- 2.5.50-BK.2/include/asm-ppc64/compat.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/asm-ppc64/compat.h	2002-12-04 15:14:56.000000000 +1100
@@ -0,0 +1,18 @@
+#ifndef _ASM_PPC64_COMPAT_H
+#define _ASM_PPC64_COMPAT_H
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
+#endif /* _ASM_PPC64_COMPAT_H */
diff -ruN 2.5.50-BK.2/include/asm-ppc64/ppc32.h 2.5.50-BK.2-32bit.1/include/asm-ppc64/ppc32.h
--- 2.5.50-BK.2/include/asm-ppc64/ppc32.h	2002-12-04 12:07:39.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/include/asm-ppc64/ppc32.h	2002-12-04 14:46:15.000000000 +1100
@@ -1,6 +1,7 @@
 #ifndef _PPC64_PPC32_H
 #define _PPC64_PPC32_H
 
+#include <linux/compat.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 
@@ -43,10 +44,7 @@
 })
 
 /* These are here to support 32-bit syscalls on a 64-bit kernel. */
-typedef unsigned int	__kernel_size_t32;
-typedef int		__kernel_ssize_t32;
 typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_time_t32;
 typedef int		__kernel_clock_t32;
 typedef int		__kernel_pid_t32;
 typedef unsigned short	__kernel_ipc_pid_t32;
@@ -160,7 +158,7 @@
 typedef struct sigaltstack_32 {
 	unsigned int ss_sp;
 	int ss_flags;
-	__kernel_size_t32 ss_size;
+	compat_size_t ss_size;
 } stack_32_t;
 
 struct flock32 {
@@ -183,11 +181,11 @@
 	__kernel_off_t32   st_size; /* 4 */
 	__kernel_off_t32   st_blksize; /* 4 */
 	__kernel_off_t32   st_blocks; /* 4 */
-	__kernel_time_t32  st_atime; /* 4 */
+	compat_time_t    st_atime; /* 4 */
 	unsigned int       __unused1; /* 4 */
-	__kernel_time_t32  st_mtime; /* 4 */
+	compat_time_t    st_mtime; /* 4 */
 	unsigned int       __unused2; /* 4 */
-	__kernel_time_t32  st_ctime; /* 4 */
+	compat_time_t    st_ctime; /* 4 */
 	unsigned int       __unused3; /* 4 */
 	unsigned int  __unused4[2]; /* 2*4 */
 };
