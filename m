Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbSK1FRH>; Thu, 28 Nov 2002 00:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbSK1FRH>; Thu, 28 Nov 2002 00:17:07 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:8699 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S264748AbSK1FQp>;
	Thu, 28 Nov 2002 00:16:45 -0500
Date: Thu, 28 Nov 2002 16:22:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, davem@redhat.com, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-Id: <20021128162231.6935e3af.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0211270913480.7657-100000@home.transmeta.com>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0211270913480.7657-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, 27 Nov 2002 09:18:06 -0800 (PST) Linus Torvalds <torvalds@transmeta.com> wrote:
>
> 
> On Wed, 27 Nov 2002, Stephen Rothwell wrote:
> > 
> > How's this one :-)
> 
> Better.
> 
> > This patch does:
> > 	introduces CONFIG_COMPAT32
> > 	introduces linux/compat32.h - which contains only struct timespec32
> > 		for now
> > 	creates an architecture independent version of sys32_nanosleep
> > 		in kernel/timer.c
> 
> May I just suggest doing a
> 
> 	kernel/compat32.c

OK, new version. In addition to the old patch this one does:
	creates kernel/compat32.c and put sys32_nanosleep there
	sys32_nanosleep now returns long
	creates asm-*/compat32.h
	creates a typedef for compat32_time_t
	uses compat32_time_t in timespec32
	renames __kernel_time_t32 to compat32_time_t everywhere

Does this move in the right direction?

Dave, does this do more like what you want?

> and doing most everything there? I think we're better off that way, even 
> if it means that "do_nanosleep()" etc cannot be static.

I was trying to keep the two versions close to each other, but fine.

This one has been built on PPC64. (Thanks, Anton)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50/arch/ia64/Kconfig 2.5.50-32bit.1/arch/ia64/Kconfig
--- 2.5.50/arch/ia64/Kconfig	2002-11-28 10:34:41.000000000 +1100
+++ 2.5.50-32bit.1/arch/ia64/Kconfig	2002-11-28 13:22:35.000000000 +1100
@@ -397,6 +397,11 @@
 	  run IA-32 Linux binaries on an IA-64 Linux system.
 	  If in doubt, say Y.
 
+config COMPAT32
+	bool
+	depends on IA32_SUPPORT
+	default y
+
 config PERFMON
 	bool "Performance monitor support"
 	help
diff -ruN 2.5.50/arch/ia64/ia32/ia32_signal.c 2.5.50-32bit.1/arch/ia64/ia32/ia32_signal.c
--- 2.5.50/arch/ia64/ia32/ia32_signal.c	2002-10-31 14:05:10.000000000 +1100
+++ 2.5.50-32bit.1/arch/ia64/ia32/ia32_signal.c	2002-11-28 14:10:42.000000000 +1100
@@ -22,6 +22,7 @@
 #include <linux/stddef.h>
 #include <linux/unistd.h>
 #include <linux/wait.h>
+#include <linux/compat32.h>
 
 #include <asm/uaccess.h>
 #include <asm/rse.h>
@@ -570,8 +571,8 @@
 }
 
 asmlinkage long
-sys32_rt_sigtimedwait (sigset32_t *uthese, siginfo_t32 *uinfo, struct timespec32 *uts,
-		       unsigned int sigsetsize)
+sys32_rt_sigtimedwait (sigset32_t *uthese, siginfo_t32 *uinfo,
+		struct timespec32 *uts, unsigned int sigsetsize)
 {
 	extern asmlinkage long sys_rt_sigtimedwait (const sigset_t *, siginfo_t *,
 						    const struct timespec *, size_t);
diff -ruN 2.5.50/arch/ia64/ia32/sys_ia32.c 2.5.50-32bit.1/arch/ia64/ia32/sys_ia32.c
--- 2.5.50/arch/ia64/ia32/sys_ia32.c	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.50-32bit.1/arch/ia64/ia32/sys_ia32.c	2002-11-28 14:35:53.000000000 +1100
@@ -49,6 +49,7 @@
 #include <linux/ptrace.h>
 #include <linux/stat.h>
 #include <linux/ipc.h>
+#include <linux/compat32.h>
 
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -1113,27 +1114,6 @@
 			    (struct timeval32 *) A(a.tvp));
 }
 
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
-}
-
 struct iovec32 { unsigned int iov_base; int iov_len; };
 asmlinkage ssize_t sys_readv (unsigned long,const struct iovec *,unsigned long);
 asmlinkage ssize_t sys_writev (unsigned long,const struct iovec *,unsigned long);
@@ -2018,8 +1998,8 @@
 
 struct semid_ds32 {
 	struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-	__kernel_time_t32 sem_otime;              /* last semop time */
-	__kernel_time_t32 sem_ctime;              /* last change time */
+	compat32_time_t   sem_otime;              /* last semop time */
+	compat32_time_t   sem_ctime;              /* last change time */
 	u32 sem_base;              /* ptr to first semaphore in array */
 	u32 sem_pending;          /* pending operations to be processed */
 	u32 sem_pending_last;    /* last pending operation */
@@ -2029,9 +2009,9 @@
 
 struct semid64_ds32 {
 	struct ipc64_perm32 sem_perm;
-	__kernel_time_t32 sem_otime;
+	compat32_time_t   sem_otime;
 	unsigned int __unused1;
-	__kernel_time_t32 sem_ctime;
+	compat32_time_t   sem_ctime;
 	unsigned int __unused2;
 	unsigned int sem_nsems;
 	unsigned int __unused3;
@@ -2042,9 +2022,9 @@
 	struct ipc_perm32 msg_perm;
 	u32 msg_first;
 	u32 msg_last;
-	__kernel_time_t32 msg_stime;
-	__kernel_time_t32 msg_rtime;
-	__kernel_time_t32 msg_ctime;
+	compat32_time_t   msg_stime;
+	compat32_time_t   msg_rtime;
+	compat32_time_t   msg_ctime;
 	u32 wwait;
 	u32 rwait;
 	unsigned short msg_cbytes;
@@ -2056,11 +2036,11 @@
 
 struct msqid64_ds32 {
 	struct ipc64_perm32 msg_perm;
-	__kernel_time_t32 msg_stime;
+	compat32_time_t   msg_stime;
 	unsigned int __unused1;
-	__kernel_time_t32 msg_rtime;
+	compat32_time_t   msg_rtime;
 	unsigned int __unused2;
-	__kernel_time_t32 msg_ctime;
+	compat32_time_t   msg_ctime;
 	unsigned int __unused3;
 	unsigned int msg_cbytes;
 	unsigned int msg_qnum;
@@ -2074,9 +2054,9 @@
 struct shmid_ds32 {
 	struct ipc_perm32 shm_perm;
 	int shm_segsz;
-	__kernel_time_t32 shm_atime;
-	__kernel_time_t32 shm_dtime;
-	__kernel_time_t32 shm_ctime;
+	compat32_time_t   shm_atime;
+	compat32_time_t   shm_dtime;
+	compat32_time_t   shm_ctime;
 	__kernel_ipc_pid_t32 shm_cpid;
 	__kernel_ipc_pid_t32 shm_lpid;
 	unsigned short shm_nattch;
@@ -2085,11 +2065,11 @@
 struct shmid64_ds32 {
 	struct ipc64_perm shm_perm;
 	__kernel_size_t32 shm_segsz;
-	__kernel_time_t32 shm_atime;
+	compat32_time_t   shm_atime;
 	unsigned int __unused1;
-	__kernel_time_t32 shm_dtime;
+	compat32_time_t   shm_dtime;
 	unsigned int __unused2;
-	__kernel_time_t32 shm_ctime;
+	compat32_time_t   shm_ctime;
 	unsigned int __unused3;
 	__kernel_pid_t32 shm_cpid;
 	__kernel_pid_t32 shm_lpid;
diff -ruN 2.5.50/arch/mips64/Kconfig 2.5.50-32bit.1/arch/mips64/Kconfig
--- 2.5.50/arch/mips64/Kconfig	2002-11-28 10:35:37.000000000 +1100
+++ 2.5.50-32bit.1/arch/mips64/Kconfig	2002-11-28 13:22:35.000000000 +1100
@@ -371,6 +371,11 @@
 	  compatibility. Since all software available for Linux/MIPS is
 	  currently 32-bit you should say Y here.
 
+config COMPAT32
+	bool
+	depends on MIPS32_COMPAT
+	default y
+
 config BINFMT_ELF32
 	bool
 	depends on MIPS32_COMPAT
diff -ruN 2.5.50/arch/mips64/kernel/linux32.c 2.5.50-32bit.1/arch/mips64/kernel/linux32.c
--- 2.5.50/arch/mips64/kernel/linux32.c	2002-10-21 01:02:44.000000000 +1000
+++ 2.5.50-32bit.1/arch/mips64/kernel/linux32.c	2002-11-28 14:36:49.000000000 +1100
@@ -27,6 +27,7 @@
 #include <linux/personality.h>
 #include <linux/timex.h>
 #include <linux/dnotify.h>
+#include <linux/compat32.h>
 #include <net/sock.h>
 
 #include <asm/uaccess.h>
@@ -119,7 +120,7 @@
 extern asmlinkage int sys_utime(char * filename, struct utimbuf * times);
 
 struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
+	compat32_time_t actime, modtime;
 };
 
 asmlinkage int sys32_utime(char * filename, struct utimbuf32 *times)
@@ -1205,11 +1206,6 @@
 
 
 
-struct timespec32 {
-	int 	tv_sec;
-	int	tv_nsec;
-};
-
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid,
 						struct timespec *interval);
 
@@ -1230,31 +1226,6 @@
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
@@ -1418,8 +1389,8 @@
 
 struct semid_ds32 {
         struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-        __kernel_time_t32 sem_otime;              /* last semop time */
-        __kernel_time_t32 sem_ctime;              /* last change time */
+        compat32_time_t   sem_otime;              /* last semop time */
+        compat32_time_t   sem_ctime;              /* last change time */
         u32 sem_base;              /* ptr to first semaphore in array */
         u32 sem_pending;          /* pending operations to be processed */
         u32 sem_pending_last;    /* last pending operation */
@@ -1432,9 +1403,9 @@
         struct ipc_perm32 msg_perm;
         u32 msg_first;
         u32 msg_last;
-        __kernel_time_t32 msg_stime;
-        __kernel_time_t32 msg_rtime;
-        __kernel_time_t32 msg_ctime;
+        compat32_time_t   msg_stime;
+        compat32_time_t   msg_rtime;
+        compat32_time_t   msg_ctime;
         u32 wwait;
         u32 rwait;
         unsigned short msg_cbytes;
@@ -1447,9 +1418,9 @@
 struct shmid_ds32 {
         struct ipc_perm32       shm_perm;
         int                     shm_segsz;
-        __kernel_time_t32       shm_atime;
-        __kernel_time_t32       shm_dtime;
-        __kernel_time_t32       shm_ctime;
+        compat32_time_t         shm_atime;
+        compat32_time_t         shm_dtime;
+        compat32_time_t         shm_ctime;
         __kernel_ipc_pid_t32    shm_cpid; 
         __kernel_ipc_pid_t32    shm_lpid; 
         unsigned short          shm_nattch;
diff -ruN 2.5.50/arch/parisc/Kconfig 2.5.50-32bit.1/arch/parisc/Kconfig
--- 2.5.50/arch/parisc/Kconfig	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.50-32bit.1/arch/parisc/Kconfig	2002-11-28 13:22:36.000000000 +1100
@@ -107,6 +107,11 @@
 	  enable this option otherwise. The 64bit kernel is significantly bigger
 	  and slower than the 32bit one.
 
+config COMPAT32
+	bool
+	depends PARISC64
+	default y
+
 config PDC_NARROW
 	bool "32-bit firmware"
 	depends on PARISC64
diff -ruN 2.5.50/arch/parisc/kernel/ioctl32.c 2.5.50-32bit.1/arch/parisc/kernel/ioctl32.c
--- 2.5.50/arch/parisc/kernel/ioctl32.c	2002-10-31 14:05:12.000000000 +1100
+++ 2.5.50-32bit.1/arch/parisc/kernel/ioctl32.c	2002-11-28 14:38:55.000000000 +1100
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/compat32.h>
 #include "sys32.h"
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -1060,8 +1061,8 @@
 #define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
 
 struct ppp_idle32 {
-	__kernel_time_t32 xmit_idle;
-	__kernel_time_t32 recv_idle;
+	compat32_time_t xmit_idle;
+	compat32_time_t recv_idle;
 };
 #define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
 
diff -ruN 2.5.50/arch/parisc/kernel/sys_parisc32.c 2.5.50-32bit.1/arch/parisc/kernel/sys_parisc32.c
--- 2.5.50/arch/parisc/kernel/sys_parisc32.c	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.50-32bit.1/arch/parisc/kernel/sys_parisc32.c	2002-11-28 14:37:59.000000000 +1100
@@ -52,6 +52,7 @@
 #include <linux/mman.h>
 #include <linux/binfmts.h>
 #include <linux/namei.h>
+#include <linux/compat32.h>
 
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -388,8 +389,8 @@
 
 /* from utime.h */
 struct utimbuf32 {
-	__kernel_time_t32 actime;
-	__kernel_time_t32 modtime;
+	compat32_time_t actime;
+	compat32_time_t modtime;
 };
 
 asmlinkage long sys32_utime(char *filename, struct utimbuf32 *times)
@@ -584,11 +585,6 @@
 }
 #endif /* CONFIG_SYSCTL */
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-                
 static int
 put_timespec32(struct timespec32 *u, struct timespec *t)
 {
@@ -598,28 +594,6 @@
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
 	struct timespec32 *interval)
 {
@@ -633,8 +607,6 @@
 	return ret;
 }
 
-typedef __kernel_time_t32 time_t32;
-
 static int
 put_timeval32(struct timeval32 *u, struct timeval *t)
 {
@@ -658,10 +630,10 @@
 	return err;
 }
 
-asmlinkage long sys32_time(time_t32 *tloc)
+asmlinkage long sys32_time(compat32_time_t *tloc)
 {
     time_t now = get_seconds();
-    time_t32 now32 = now;
+    compat32_time_t now32 = now;
 
     if (tloc)
     	if (put_user(now32, tloc))
@@ -850,11 +822,11 @@
 	unsigned short	st_reserved2;	/* old st_gid */
 	__kernel_dev_t32		st_rdev;
 	__kernel_off_t32		st_size;
-	__kernel_time_t32	st_atime;
+	compat32_time_t	st_atime;
 	unsigned int	st_spare1;
-	__kernel_time_t32	st_mtime;
+	compat32_time_t	st_mtime;
 	unsigned int	st_spare2;
-	__kernel_time_t32	st_ctime;
+	compat32_time_t	st_ctime;
 	unsigned int	st_spare3;
 	int		st_blksize;
 	int		st_blocks;
@@ -2903,8 +2875,8 @@
     __u32 dqb_ihardlimit;
     __u32 dqb_isoftlimit;
     __u32 dqb_curinodes;
-    __kernel_time_t32 dqb_btime;
-    __kernel_time_t32 dqb_itime;
+    compat32_time_t dqb_btime;
+    compat32_time_t dqb_itime;
 };
                                 
 
diff -ruN 2.5.50/arch/ppc64/Kconfig 2.5.50-32bit.1/arch/ppc64/Kconfig
--- 2.5.50/arch/ppc64/Kconfig	2002-11-18 15:47:40.000000000 +1100
+++ 2.5.50-32bit.1/arch/ppc64/Kconfig	2002-11-28 13:22:36.000000000 +1100
@@ -33,6 +33,10 @@
 	bool
 	default y
 
+config COMPAT32
+	bool
+	default y
+
 source "init/Kconfig"
 
 
diff -ruN 2.5.50/arch/ppc64/kernel/ioctl32.c 2.5.50-32bit.1/arch/ppc64/kernel/ioctl32.c
--- 2.5.50/arch/ppc64/kernel/ioctl32.c	2002-11-11 14:55:28.000000000 +1100
+++ 2.5.50-32bit.1/arch/ppc64/kernel/ioctl32.c	2002-11-28 14:44:58.000000000 +1100
@@ -22,6 +22,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/compat32.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -1424,8 +1425,8 @@
 #define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
 
 struct ppp_idle32 {
-	__kernel_time_t32 xmit_idle;
-	__kernel_time_t32 recv_idle;
+	compat32_time_t xmit_idle;
+	compat32_time_t recv_idle;
 };
 #define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
 
diff -ruN 2.5.50/arch/ppc64/kernel/signal32.c 2.5.50-32bit.1/arch/ppc64/kernel/signal32.c
--- 2.5.50/arch/ppc64/kernel/signal32.c	2002-10-21 01:02:45.000000000 +1000
+++ 2.5.50-32bit.1/arch/ppc64/kernel/signal32.c	2002-11-28 13:22:36.000000000 +1100
@@ -22,6 +22,7 @@
 #include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/elf.h>
+#include <linux/compat32.h>
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
diff -ruN 2.5.50/arch/ppc64/kernel/sys_ppc32.c 2.5.50-32bit.1/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.50/arch/ppc64/kernel/sys_ppc32.c	2002-11-28 10:35:37.000000000 +1100
+++ 2.5.50-32bit.1/arch/ppc64/kernel/sys_ppc32.c	2002-11-28 14:46:31.000000000 +1100
@@ -54,6 +54,7 @@
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
 #include <linux/security.h>
+#include <linux/compat32.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -72,7 +73,7 @@
 extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
 
 struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
+	compat32_time_t actime, modtime;
 };
 
 asmlinkage long sys32_utime(char * filename, struct utimbuf32 *times)
@@ -1775,37 +1776,6 @@
 
 
 
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
@@ -2163,8 +2133,8 @@
 
 struct semid_ds32 {
 	struct ipc_perm sem_perm;
-	__kernel_time_t32 sem_otime;
-	__kernel_time_t32 sem_ctime;
+	compat32_time_t sem_otime;
+	compat32_time_t sem_ctime;
 	u32 sem_base;
 	u32 sem_pending;
 	u32 sem_pending_last;
@@ -2175,9 +2145,9 @@
 struct semid64_ds32 {
 	struct ipc64_perm sem_perm;
 	unsigned int __unused1;
-	__kernel_time_t32 sem_otime;
+	compat32_time_t sem_otime;
 	unsigned int __unused2;
-	__kernel_time_t32 sem_ctime;
+	compat32_time_t sem_ctime;
 	u32 sem_nsems;
 	u32 __unused3;
 	u32 __unused4;
@@ -2188,9 +2158,9 @@
 	struct ipc_perm msg_perm;
 	u32 msg_first;
 	u32 msg_last;
-	__kernel_time_t32 msg_stime;
-	__kernel_time_t32 msg_rtime;
-	__kernel_time_t32 msg_ctime;
+	compat32_time_t msg_stime;
+	compat32_time_t msg_rtime;
+	compat32_time_t msg_ctime;
 	u32 msg_lcbytes;
 	u32 msg_lqbytes;
 	unsigned short msg_cbytes;
@@ -2203,11 +2173,11 @@
 struct msqid64_ds32 {
 	struct ipc64_perm msg_perm;
 	unsigned int __unused1;
-	__kernel_time_t32 msg_stime;
+	compat32_time_t msg_stime;
 	unsigned int __unused2;
-	__kernel_time_t32 msg_rtime;
+	compat32_time_t msg_rtime;
 	unsigned int __unused3;
-	__kernel_time_t32 msg_ctime;
+	compat32_time_t msg_ctime;
 	unsigned int msg_cbytes;
 	unsigned int msg_qnum;
 	unsigned int msg_qbytes;
@@ -2220,9 +2190,9 @@
 struct shmid_ds32 {
 	struct ipc_perm shm_perm;
 	int shm_segsz;
-	__kernel_time_t32 shm_atime;
-	__kernel_time_t32 shm_dtime;
-	__kernel_time_t32 shm_ctime;
+	compat32_time_t shm_atime;
+	compat32_time_t shm_dtime;
+	compat32_time_t shm_ctime;
 	__kernel_ipc_pid_t32 shm_cpid;
 	__kernel_ipc_pid_t32 shm_lpid;
 	unsigned short shm_nattch;
@@ -2234,11 +2204,11 @@
 struct shmid64_ds32 {
 	struct ipc64_perm shm_perm;
 	unsigned int __unused1;
-	__kernel_time_t32 shm_atime;
+	compat32_time_t shm_atime;
 	unsigned int __unused2;
-	__kernel_time_t32 shm_dtime;
+	compat32_time_t shm_dtime;
 	unsigned int __unused3;
-	__kernel_time_t32 shm_ctime;
+	compat32_time_t shm_ctime;
 	unsigned int __unused4;
 	__kernel_size_t32 shm_segsz;
 	__kernel_pid_t32 shm_cpid;
@@ -3259,12 +3229,12 @@
 			 * from 64-bit time values to 32-bit time values
 			 */
 		case SO_TIMESTAMP: {
-			__kernel_time_t32* ptr_time32 = CMSG32_DATA(kcmsg32);
+			compat32_time_t* ptr_time32 = CMSG32_DATA(kcmsg32);
 			__kernel_time_t*   ptr_time   = CMSG_DATA(ucmsg);
 			*ptr_time32     = *ptr_time;
 			*(ptr_time32+1) = *(ptr_time+1);
 			kcmsg32->cmsg_len -= 2*(sizeof(__kernel_time_t) -
-						sizeof(__kernel_time_t32));
+						sizeof(compat32_time_t));
 		}
 		default:;
 		}
@@ -4234,9 +4204,9 @@
 	return error;
 }
 
-asmlinkage long sys32_time(__kernel_time_t32* tloc)
+asmlinkage long sys32_time(compat32_time_t* tloc)
 {
-	__kernel_time_t32 secs;
+	compat32_time_t secs;
 
 	struct timeval tv;
 
diff -ruN 2.5.50/arch/s390x/Kconfig 2.5.50-32bit.1/arch/s390x/Kconfig
--- 2.5.50/arch/s390x/Kconfig	2002-11-28 10:34:42.000000000 +1100
+++ 2.5.50-32bit.1/arch/s390x/Kconfig	2002-11-28 13:22:36.000000000 +1100
@@ -92,6 +92,11 @@
 	  (and some other stuff like libraries and such) is needed for
 	  executing 31 bit applications.  It is safe to say "Y".
 
+config COMPAT32
+	bool
+	depends on S390_SUPPORT
+	default y
+
 config BINFMT_ELF32
 	tristate "Kernel support for 31 bit ELF binaries"
 	depends on S390_SUPPORT
diff -ruN 2.5.50/arch/s390x/kernel/linux32.c 2.5.50-32bit.1/arch/s390x/kernel/linux32.c
--- 2.5.50/arch/s390x/kernel/linux32.c	2002-11-28 10:34:42.000000000 +1100
+++ 2.5.50-32bit.1/arch/s390x/kernel/linux32.c	2002-11-28 14:41:30.000000000 +1100
@@ -57,6 +57,7 @@
 #include <linux/icmpv6.h>
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
+#include <linux/compat32.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -318,8 +319,8 @@
 
 struct semid_ds32 {
         struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-        __kernel_time_t32 sem_otime;              /* last semop time */
-        __kernel_time_t32 sem_ctime;              /* last change time */
+        compat32_time_t   sem_otime;              /* last semop time */
+        compat32_time_t   sem_ctime;              /* last change time */
         u32 sem_base;              /* ptr to first semaphore in array */
         u32 sem_pending;          /* pending operations to be processed */
         u32 sem_pending_last;    /* last pending operation */
@@ -330,9 +331,9 @@
 struct semid64_ds32 {
 	struct ipc64_perm_ds32 sem_perm;
 	unsigned int	  __pad1;
-	__kernel_time_t32 sem_otime;
+	compat32_time_t   sem_otime;
 	unsigned int	  __pad2;
-	__kernel_time_t32 sem_ctime;
+	compat32_time_t   sem_ctime;
 	u32 sem_nsems;
 	u32 __unused1;
 	u32 __unused2;
@@ -343,9 +344,9 @@
         struct ipc_perm32 msg_perm;
         u32 msg_first;
         u32 msg_last;
-        __kernel_time_t32 msg_stime;
-        __kernel_time_t32 msg_rtime;
-        __kernel_time_t32 msg_ctime;
+        compat32_time_t   msg_stime;
+        compat32_time_t   msg_rtime;
+        compat32_time_t   msg_ctime;
         u32 wwait;
         u32 rwait;
         unsigned short msg_cbytes;
@@ -358,11 +359,11 @@
 struct msqid64_ds32 {
 	struct ipc64_perm_ds32 msg_perm;
 	unsigned int   __pad1;
-	__kernel_time_t32 msg_stime;
+	compat32_time_t msg_stime;
 	unsigned int   __pad2;
-	__kernel_time_t32 msg_rtime;
+	compat32_time_t msg_rtime;
 	unsigned int   __pad3;
-	__kernel_time_t32 msg_ctime;
+	compat32_time_t msg_ctime;
 	unsigned int  msg_cbytes;
 	unsigned int  msg_qnum;
 	unsigned int  msg_qbytes;
@@ -376,9 +377,9 @@
 struct shmid_ds32 {
 	struct ipc_perm32       shm_perm;
 	int                     shm_segsz;
-	__kernel_time_t32       shm_atime;
-	__kernel_time_t32       shm_dtime;
-	__kernel_time_t32       shm_ctime;
+	compat32_time_t         shm_atime;
+	compat32_time_t         shm_dtime;
+	compat32_time_t         shm_ctime;
 	__kernel_ipc_pid_t32    shm_cpid; 
 	__kernel_ipc_pid_t32    shm_lpid; 
 	unsigned short          shm_nattch;
@@ -387,11 +388,11 @@
 struct shmid64_ds32 {
 	struct ipc64_perm_ds32	shm_perm;
 	__kernel_size_t32	shm_segsz;
-	__kernel_time_t32	shm_atime;
+	compat32_time_t  	shm_atime;
 	unsigned int		__unused1;
-	__kernel_time_t32	shm_dtime;
+	compat32_time_t  	shm_dtime;
 	unsigned int		__unused2;
-	__kernel_time_t32	shm_ctime;
+	compat32_time_t  	shm_ctime;
 	unsigned int		__unused3;
 	__kernel_pid_t32	shm_cpid;
 	__kernel_pid_t32	shm_lpid;
@@ -1013,7 +1014,7 @@
 extern asmlinkage int sys_utime(char * filename, struct utimbuf * times);
 
 struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
+	compat32_time_t actime, modtime;
 };
 
 asmlinkage int sys32_utime(char * filename, struct utimbuf32 *times)
@@ -1774,11 +1775,6 @@
 	return ret;
 }
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-                
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 
 asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct timespec32 *interval)
@@ -1796,28 +1792,6 @@
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
@@ -2498,12 +2472,12 @@
 			 * from 64-bit time values to 32-bit time values
 			*/
 		case SO_TIMESTAMP: {
-			__kernel_time_t32* ptr_time32 = CMSG32_DATA(kcmsg32);
+			compat32_time_t* ptr_time32 = CMSG32_DATA(kcmsg32);
 			__kernel_time_t*   ptr_time   = CMSG_DATA(ucmsg);
 			get_user(*ptr_time32, ptr_time);
 			get_user(*(ptr_time32+1), ptr_time+1);
 			kcmsg32->cmsg_len -= 2*(sizeof(__kernel_time_t) -
-						sizeof(__kernel_time_t32));
+						sizeof(compat32_time_t));
 		}
 		default:;
 		}
diff -ruN 2.5.50/arch/s390x/kernel/linux32.h 2.5.50-32bit.1/arch/s390x/kernel/linux32.h
--- 2.5.50/arch/s390x/kernel/linux32.h	2002-10-08 12:02:40.000000000 +1000
+++ 2.5.50-32bit.1/arch/s390x/kernel/linux32.h	2002-11-28 14:39:23.000000000 +1100
@@ -18,7 +18,6 @@
 typedef unsigned int           __kernel_size_t32;
 typedef int                    __kernel_ssize_t32;
 typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
 typedef int                    __kernel_clock_t32;
 typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
diff -ruN 2.5.50/arch/s390x/kernel/wrapper32.S 2.5.50-32bit.1/arch/s390x/kernel/wrapper32.S
--- 2.5.50/arch/s390x/kernel/wrapper32.S	2002-11-28 10:34:42.000000000 +1100
+++ 2.5.50-32bit.1/arch/s390x/kernel/wrapper32.S	2002-11-28 13:22:36.000000000 +1100
@@ -748,8 +748,8 @@
 
 	.globl  sys32_nanosleep_wrapper 
 sys32_nanosleep_wrapper:
-	llgtr	%r2,%r2			# struct timespec_emu31 *
-	llgtr	%r3,%r3			# struct timespec_emu31 *
+	llgtr	%r2,%r2			# struct timespec32 *
+	llgtr	%r3,%r3			# struct timespec32 *
 	jg	sys32_nanosleep		# branch to system call
 
 	.globl  sys32_mremap_wrapper 
diff -ruN 2.5.50/arch/sparc64/Kconfig 2.5.50-32bit.1/arch/sparc64/Kconfig
--- 2.5.50/arch/sparc64/Kconfig	2002-11-28 10:35:37.000000000 +1100
+++ 2.5.50-32bit.1/arch/sparc64/Kconfig	2002-11-28 13:22:36.000000000 +1100
@@ -352,6 +352,11 @@
 	  This allows you to run 32-bit binaries on your Ultra.
 	  Everybody wants this; say Y.
 
+config COMPAT32
+	bool
+	depends on SPARC32_COMPAT
+	default y
+
 config BINFMT_ELF32
 	tristate "Kernel support for 32-bit ELF binaries"
 	depends on SPARC32_COMPAT
diff -ruN 2.5.50/arch/sparc64/kernel/ioctl32.c 2.5.50-32bit.1/arch/sparc64/kernel/ioctl32.c
--- 2.5.50/arch/sparc64/kernel/ioctl32.c	2002-11-18 15:47:41.000000000 +1100
+++ 2.5.50-32bit.1/arch/sparc64/kernel/ioctl32.c	2002-11-28 14:43:09.000000000 +1100
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/compat32.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -1743,8 +1744,8 @@
 #define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
 
 struct ppp_idle32 {
-	__kernel_time_t32 xmit_idle;
-	__kernel_time_t32 recv_idle;
+	compat32_time_t xmit_idle;
+	compat32_time_t recv_idle;
 };
 #define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
 
diff -ruN 2.5.50/arch/sparc64/kernel/sys_sparc32.c 2.5.50-32bit.1/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.50/arch/sparc64/kernel/sys_sparc32.c	2002-11-28 10:35:37.000000000 +1100
+++ 2.5.50-32bit.1/arch/sparc64/kernel/sys_sparc32.c	2002-11-28 14:44:11.000000000 +1100
@@ -51,6 +51,7 @@
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
 #include <linux/dnotify.h>
+#include <linux/compat32.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -327,8 +328,8 @@
 
 struct semid_ds32 {
         struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-        __kernel_time_t32 sem_otime;              /* last semop time */
-        __kernel_time_t32 sem_ctime;              /* last change time */
+        compat32_time_t   sem_otime;              /* last semop time */
+        compat32_time_t   sem_ctime;              /* last change time */
         u32 sem_base;              /* ptr to first semaphore in array */
         u32 sem_pending;          /* pending operations to be processed */
         u32 sem_pending_last;    /* last pending operation */
@@ -339,9 +340,9 @@
 struct semid64_ds32 {
 	struct ipc64_perm sem_perm;		  /* this structure is the same on sparc32 and sparc64 */
 	unsigned int	  __pad1;
-	__kernel_time_t32 sem_otime;
+	compat32_time_t   sem_otime;
 	unsigned int	  __pad2;
-	__kernel_time_t32 sem_ctime;
+	compat32_time_t   sem_ctime;
 	u32 sem_nsems;
 	u32 __unused1;
 	u32 __unused2;
@@ -352,9 +353,9 @@
         struct ipc_perm32 msg_perm;
         u32 msg_first;
         u32 msg_last;
-        __kernel_time_t32 msg_stime;
-        __kernel_time_t32 msg_rtime;
-        __kernel_time_t32 msg_ctime;
+        compat32_time_t   msg_stime;
+        compat32_time_t   msg_rtime;
+        compat32_time_t   msg_ctime;
         u32 wwait;
         u32 rwait;
         unsigned short msg_cbytes;
@@ -367,11 +368,11 @@
 struct msqid64_ds32 {
 	struct ipc64_perm msg_perm;
 	unsigned int   __pad1;
-	__kernel_time_t32 msg_stime;
+	compat32_time_t   msg_stime;
 	unsigned int   __pad2;
-	__kernel_time_t32 msg_rtime;
+	compat32_time_t   msg_rtime;
 	unsigned int   __pad3;
-	__kernel_time_t32 msg_ctime;
+	compat32_time_t   msg_ctime;
 	unsigned int  msg_cbytes;
 	unsigned int  msg_qnum;
 	unsigned int  msg_qbytes;
@@ -385,9 +386,9 @@
 struct shmid_ds32 {
 	struct ipc_perm32       shm_perm;
 	int                     shm_segsz;
-	__kernel_time_t32       shm_atime;
-	__kernel_time_t32       shm_dtime;
-	__kernel_time_t32       shm_ctime;
+	compat32_time_t         shm_atime;
+	compat32_time_t         shm_dtime;
+	compat32_time_t         shm_ctime;
 	__kernel_ipc_pid_t32    shm_cpid; 
 	__kernel_ipc_pid_t32    shm_lpid; 
 	unsigned short          shm_nattch;
@@ -396,11 +397,11 @@
 struct shmid64_ds32 {
 	struct ipc64_perm	shm_perm;
 	unsigned int		__pad1;
-	__kernel_time_t32	shm_atime;
+	compat32_time_t  	shm_atime;
 	unsigned int		__pad2;
-	__kernel_time_t32	shm_dtime;
+	compat32_time_t  	shm_dtime;
 	unsigned int		__pad3;
-	__kernel_time_t32	shm_ctime;
+	compat32_time_t  	shm_ctime;
 	__kernel_size_t32	shm_segsz;
 	__kernel_pid_t32	shm_cpid;
 	__kernel_pid_t32	shm_lpid;
@@ -967,7 +968,7 @@
 extern asmlinkage int sys_utime(char * filename, struct utimbuf * times);
 
 struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
+	compat32_time_t actime, modtime;
 };
 
 asmlinkage int sys32_utime(char * filename, struct utimbuf32 *times)
@@ -1794,11 +1795,6 @@
 	return ret;
 }
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-                
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 
 asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct timespec32 *interval)
@@ -1816,28 +1812,6 @@
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
diff -ruN 2.5.50/arch/sparc64/kernel/sys_sunos32.c 2.5.50-32bit.1/arch/sparc64/kernel/sys_sunos32.c
--- 2.5.50/arch/sparc64/kernel/sys_sunos32.c	2002-11-28 10:34:43.000000000 +1100
+++ 2.5.50-32bit.1/arch/sparc64/kernel/sys_sunos32.c	2002-11-28 14:42:21.000000000 +1100
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/types.h>
+#include <linux/compat32.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
@@ -948,9 +949,9 @@
         struct ipc_perm32 msg_perm;
         u32 msg_first;
         u32 msg_last;
-        __kernel_time_t32 msg_stime;
-        __kernel_time_t32 msg_rtime;
-        __kernel_time_t32 msg_ctime;
+        compat32_time_t msg_stime;
+        compat32_time_t msg_rtime;
+        compat32_time_t msg_ctime;
         u32 wwait;
         u32 rwait;
         unsigned short msg_cbytes;
@@ -1085,9 +1086,9 @@
 struct shmid_ds32 {
         struct ipc_perm32       shm_perm;
         int                     shm_segsz;
-        __kernel_time_t32       shm_atime;
-        __kernel_time_t32       shm_dtime;
-        __kernel_time_t32       shm_ctime;
+        compat32_time_t         shm_atime;
+        compat32_time_t         shm_dtime;
+        compat32_time_t         shm_ctime;
         __kernel_ipc_pid_t32    shm_cpid; 
         __kernel_ipc_pid_t32    shm_lpid; 
         unsigned short          shm_nattch;
diff -ruN 2.5.50/arch/x86_64/Kconfig 2.5.50-32bit.1/arch/x86_64/Kconfig
--- 2.5.50/arch/x86_64/Kconfig	2002-11-28 10:34:43.000000000 +1100
+++ 2.5.50-32bit.1/arch/x86_64/Kconfig	2002-11-28 13:22:36.000000000 +1100
@@ -425,6 +425,11 @@
 	  turn this on, unless you're 100% sure that you don't have any 32bit programs
 	  left.
 
+config COMPAT32
+	bool
+	depends on IA32_EMULATION
+	default y
+
 endmenu
 
 source "drivers/mtd/Kconfig"
diff -ruN 2.5.50/arch/x86_64/ia32/ia32_ioctl.c 2.5.50-32bit.1/arch/x86_64/ia32/ia32_ioctl.c
--- 2.5.50/arch/x86_64/ia32/ia32_ioctl.c	2002-10-21 01:02:47.000000000 +1000
+++ 2.5.50-32bit.1/arch/x86_64/ia32/ia32_ioctl.c	2002-11-28 14:47:13.000000000 +1100
@@ -11,6 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/compat32.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -1611,8 +1612,8 @@
 #define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
 
 struct ppp_idle32 {
-	__kernel_time_t32 xmit_idle;
-	__kernel_time_t32 recv_idle;
+	compat32_time_t xmit_idle;
+	compat32_time_t recv_idle;
 };
 #define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
 
diff -ruN 2.5.50/arch/x86_64/ia32/ipc32.c 2.5.50-32bit.1/arch/x86_64/ia32/ipc32.c
--- 2.5.50/arch/x86_64/ia32/ipc32.c	2002-10-21 01:02:47.000000000 +1000
+++ 2.5.50-32bit.1/arch/x86_64/ia32/ipc32.c	2002-11-28 14:48:46.000000000 +1100
@@ -8,6 +8,7 @@
 #include <linux/shm.h>
 #include <linux/slab.h>
 #include <linux/ipc.h>
+#include <linux/compat32.h>
 #include <asm/mman.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -53,8 +54,8 @@
 
 struct semid_ds32 {
 	struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-	__kernel_time_t32 sem_otime;              /* last semop time */
-	__kernel_time_t32 sem_ctime;              /* last change time */
+	compat32_time_t sem_otime;              /* last semop time */
+	compat32_time_t sem_ctime;              /* last change time */
 	u32 sem_base;              /* ptr to first semaphore in array */
 	u32 sem_pending;          /* pending operations to be processed */
 	u32 sem_pending_last;    /* last pending operation */
@@ -64,9 +65,9 @@
 
 struct semid64_ds32 {
 	struct ipc64_perm32 sem_perm;
-	__kernel_time_t32 sem_otime;
+	compat32_time_t sem_otime;
 	unsigned int __unused1;
-	__kernel_time_t32 sem_ctime;
+	compat32_time_t sem_ctime;
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
+	compat32_time_t msg_stime;
+	compat32_time_t msg_rtime;
+	compat32_time_t msg_ctime;
 	u32 wwait;
 	u32 rwait;
 	unsigned short msg_cbytes;
@@ -91,11 +92,11 @@
 
 struct msqid64_ds32 {
 	struct ipc64_perm32 msg_perm;
-	__kernel_time_t32 msg_stime;
+	compat32_time_t msg_stime;
 	unsigned int __unused1;
-	__kernel_time_t32 msg_rtime;
+	compat32_time_t msg_rtime;
 	unsigned int __unused2;
-	__kernel_time_t32 msg_ctime;
+	compat32_time_t msg_ctime;
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
+	compat32_time_t shm_atime;
+	compat32_time_t shm_dtime;
+	compat32_time_t shm_ctime;
 	__kernel_ipc_pid_t32 shm_cpid;
 	__kernel_ipc_pid_t32 shm_lpid;
 	unsigned short shm_nattch;
@@ -120,11 +121,11 @@
 struct shmid64_ds32 {
 	struct ipc64_perm32 shm_perm;
 	__kernel_size_t32 shm_segsz;
-	__kernel_time_t32 shm_atime;
+	compat32_time_t shm_atime;
 	unsigned int __unused1;
-	__kernel_time_t32 shm_dtime;
+	compat32_time_t shm_dtime;
 	unsigned int __unused2;
-	__kernel_time_t32 shm_ctime;
+	compat32_time_t shm_ctime;
 	unsigned int __unused3;
 	__kernel_pid_t32 shm_cpid;
 	__kernel_pid_t32 shm_lpid;
diff -ruN 2.5.50/arch/x86_64/ia32/sys_ia32.c 2.5.50-32bit.1/arch/x86_64/ia32/sys_ia32.c
--- 2.5.50/arch/x86_64/ia32/sys_ia32.c	2002-11-18 15:47:41.000000000 +1100
+++ 2.5.50-32bit.1/arch/x86_64/ia32/sys_ia32.c	2002-11-28 14:47:41.000000000 +1100
@@ -58,6 +58,7 @@
 #include <linux/binfmts.h>
 #include <linux/init.h>
 #include <linux/aio_abi.h>
+#include <linux/compat32.h>
 #include <asm/mman.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -934,36 +935,6 @@
 			    (struct timeval32 *)A(a.tvp));
 }
 
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
-}
-
 asmlinkage ssize_t sys_readv(unsigned long,const struct iovec *,unsigned long);
 asmlinkage ssize_t sys_writev(unsigned long,const struct iovec *,unsigned long);
 
@@ -1409,7 +1380,7 @@
 extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
 
 struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
+	compat32_time_t actime, modtime;
 };
 
 asmlinkage long
diff -ruN 2.5.50/include/asm-ia64/compat32.h 2.5.50-32bit.1/include/asm-ia64/compat32.h
--- 2.5.50/include/asm-ia64/compat32.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-32bit.1/include/asm-ia64/compat32.h	2002-11-28 14:20:49.000000000 +1100
@@ -0,0 +1,9 @@
+#ifndef _ASM_IA64_COMPAT32_H
+#define _ASM_IA64_COMPAT32_H
+/*
+ * Architecture specific 32 bit compatibility types
+ */
+
+typedef s32		compat32_time_t;
+
+#endif /* _ASM_IA64_COMPAT32_H */
diff -ruN 2.5.50/include/asm-ia64/ia32.h 2.5.50-32bit.1/include/asm-ia64/ia32.h
--- 2.5.50/include/asm-ia64/ia32.h	2002-10-31 14:06:05.000000000 +1100
+++ 2.5.50-32bit.1/include/asm-ia64/ia32.h	2002-11-28 14:30:23.000000000 +1100
@@ -15,7 +15,6 @@
 typedef unsigned int	__kernel_size_t32;
 typedef int		__kernel_ssize_t32;
 typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_time_t32;
 typedef int		__kernel_clock_t32;
 typedef int		__kernel_pid_t32;
 typedef unsigned short	__kernel_ipc_pid_t32;
@@ -41,11 +40,6 @@
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
diff -ruN 2.5.50/include/asm-mips64/compat32.h 2.5.50-32bit.1/include/asm-mips64/compat32.h
--- 2.5.50/include/asm-mips64/compat32.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-32bit.1/include/asm-mips64/compat32.h	2002-11-28 14:22:15.000000000 +1100
@@ -0,0 +1,9 @@
+#ifndef _ASM_MIPS64_COMPAT32_H
+#define _ASM_MIPS64_COMPAT32_H
+/*
+ * Architecture specific 32 bit compatibility types
+ */
+
+typedef s32		compat32_time_t;
+
+#endif /* _ASM_MIPS64_COMPAT32_H */
diff -ruN 2.5.50/include/asm-mips64/posix_types.h 2.5.50-32bit.1/include/asm-mips64/posix_types.h
--- 2.5.50/include/asm-mips64/posix_types.h	2000-07-10 15:18:15.000000000 +1000
+++ 2.5.50-32bit.1/include/asm-mips64/posix_types.h	2002-11-28 14:30:39.000000000 +1100
@@ -61,7 +61,6 @@
 typedef unsigned int	__kernel_size_t32;
 typedef int		__kernel_ssize_t32;
 typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_time_t32;
 typedef int		__kernel_suseconds_t32;
 typedef int		__kernel_clock_t32;
 typedef int		__kernel_daddr_t32;
diff -ruN 2.5.50/include/asm-mips64/stat.h 2.5.50-32bit.1/include/asm-mips64/stat.h
--- 2.5.50/include/asm-mips64/stat.h	2002-11-18 15:47:55.000000000 +1100
+++ 2.5.50-32bit.1/include/asm-mips64/stat.h	2002-11-28 14:31:37.000000000 +1100
@@ -10,6 +10,7 @@
 #define _ASM_STAT_H
 
 #include <linux/types.h>
+#include <linux/compat32.h>
 
 struct __old_kernel_stat {
 	unsigned int	st_dev;
@@ -40,11 +41,11 @@
 	int		    st_pad2[2];
 	__kernel_off_t32    st_size;
 	int		    st_pad3;
-	__kernel_time_t32   st_atime;
+	compat32_time_t     st_atime;
 	int		    reserved0;
-	__kernel_time_t32   st_mtime;
+	compat32_time_t     st_mtime;
 	int		    reserved1;
-	__kernel_time_t32   st_ctime;
+	compat32_time_t     st_ctime;
 	int		    reserved2;
 	int		    st_blksize;
 	int		    st_blocks;
diff -ruN 2.5.50/include/asm-parisc/compat32.h 2.5.50-32bit.1/include/asm-parisc/compat32.h
--- 2.5.50/include/asm-parisc/compat32.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-32bit.1/include/asm-parisc/compat32.h	2002-11-28 14:22:38.000000000 +1100
@@ -0,0 +1,9 @@
+#ifndef _ASM_PARISC_COMPAT32_H
+#define _ASM_PARISC_COMPAT32_H
+/*
+ * Architecture specific 32 bit compatibility types
+ */
+
+typedef s32		compat32_time_t;
+
+#endif /* _ASM_PARISC_COMPAT32_H */
diff -ruN 2.5.50/include/asm-parisc/posix_types.h 2.5.50-32bit.1/include/asm-parisc/posix_types.h
--- 2.5.50/include/asm-parisc/posix_types.h	2002-10-31 14:06:07.000000000 +1100
+++ 2.5.50-32bit.1/include/asm-parisc/posix_types.h	2002-11-28 14:31:56.000000000 +1100
@@ -69,7 +69,6 @@
 typedef unsigned int		__kernel_size_t32;
 typedef int			__kernel_ssize_t32;
 typedef int			__kernel_ptrdiff_t32;
-typedef int			__kernel_time_t32;
 typedef int			__kernel_suseconds_t32;
 typedef int			__kernel_clock_t32;
 typedef int			__kernel_daddr_t32;
diff -ruN 2.5.50/include/asm-ppc64/compat32.h 2.5.50-32bit.1/include/asm-ppc64/compat32.h
--- 2.5.50/include/asm-ppc64/compat32.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-32bit.1/include/asm-ppc64/compat32.h	2002-11-28 14:22:47.000000000 +1100
@@ -0,0 +1,9 @@
+#ifndef _ASM_PPC64_COMPAT32_H
+#define _ASM_PPC64_COMPAT32_H
+/*
+ * Architecture specific 32 bit compatibility types
+ */
+
+typedef s32		compat32_time_t;
+
+#endif /* _ASM_PPC64_COMPAT32_H */
diff -ruN 2.5.50/include/asm-ppc64/ppc32.h 2.5.50-32bit.1/include/asm-ppc64/ppc32.h
--- 2.5.50/include/asm-ppc64/ppc32.h	2002-10-21 01:02:53.000000000 +1000
+++ 2.5.50-32bit.1/include/asm-ppc64/ppc32.h	2002-11-28 14:34:33.000000000 +1100
@@ -1,6 +1,7 @@
 #ifndef _PPC64_PPC32_H
 #define _PPC64_PPC32_H
 
+#include <linux/compat32.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
 
@@ -46,7 +47,6 @@
 typedef unsigned int	__kernel_size_t32;
 typedef int		__kernel_ssize_t32;
 typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_time_t32;
 typedef int		__kernel_clock_t32;
 typedef int		__kernel_pid_t32;
 typedef unsigned short	__kernel_ipc_pid_t32;
@@ -185,11 +185,11 @@
 	__kernel_off_t32   st_size; /* 4 */
 	__kernel_off_t32   st_blksize; /* 4 */
 	__kernel_off_t32   st_blocks; /* 4 */
-	__kernel_time_t32  st_atime; /* 4 */
+	compat32_time_t    st_atime; /* 4 */
 	unsigned int       __unused1; /* 4 */
-	__kernel_time_t32  st_mtime; /* 4 */
+	compat32_time_t    st_mtime; /* 4 */
 	unsigned int       __unused2; /* 4 */
-	__kernel_time_t32  st_ctime; /* 4 */
+	compat32_time_t    st_ctime; /* 4 */
 	unsigned int       __unused3; /* 4 */
 	unsigned int  __unused4[2]; /* 2*4 */
 };
diff -ruN 2.5.50/include/asm-s390x/compat32.h 2.5.50-32bit.1/include/asm-s390x/compat32.h
--- 2.5.50/include/asm-s390x/compat32.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-32bit.1/include/asm-s390x/compat32.h	2002-11-28 14:22:59.000000000 +1100
@@ -0,0 +1,9 @@
+#ifndef _ASM_S390X_COMPAT32_H
+#define _ASM_S390X_COMPAT32_H
+/*
+ * Architecture specific 32 bit compatibility types
+ */
+
+typedef s32		compat32_time_t;
+
+#endif /* _ASM_S390X_COMPAT32_H */
diff -ruN 2.5.50/include/asm-sparc64/compat32.h 2.5.50-32bit.1/include/asm-sparc64/compat32.h
--- 2.5.50/include/asm-sparc64/compat32.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-32bit.1/include/asm-sparc64/compat32.h	2002-11-28 14:23:09.000000000 +1100
@@ -0,0 +1,9 @@
+#ifndef _ASM_SPARC64_COMPAT32_H
+#define _ASM_SPARC64_COMPAT32_H
+/*
+ * Architecture specific 32 bit compatibility types
+ */
+
+typedef s32		compat32_time_t;
+
+#endif /* _ASM_SPARC64_COMPAT32_H */
diff -ruN 2.5.50/include/asm-sparc64/posix_types.h 2.5.50-32bit.1/include/asm-sparc64/posix_types.h
--- 2.5.50/include/asm-sparc64/posix_types.h	2000-10-28 04:55:01.000000000 +1100
+++ 2.5.50-32bit.1/include/asm-sparc64/posix_types.h	2002-11-28 14:32:10.000000000 +1100
@@ -51,7 +51,6 @@
 typedef unsigned int           __kernel_size_t32;
 typedef int                    __kernel_ssize_t32;
 typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
 typedef int                    __kernel_clock_t32;
 typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
diff -ruN 2.5.50/include/asm-sparc64/stat.h 2.5.50-32bit.1/include/asm-sparc64/stat.h
--- 2.5.50/include/asm-sparc64/stat.h	2002-11-18 15:47:55.000000000 +1100
+++ 2.5.50-32bit.1/include/asm-sparc64/stat.h	2002-11-28 14:33:25.000000000 +1100
@@ -3,6 +3,7 @@
 #define _SPARC64_STAT_H
 
 #include <linux/types.h>
+#include <linux/compat32.h>
 #include <linux/time.h>
 
 struct stat32 {
@@ -14,11 +15,11 @@
 	__kernel_gid_t32   st_gid;
 	__kernel_dev_t32   st_rdev;
 	__kernel_off_t32   st_size;
-	__kernel_time_t32  st_atime;
+	compat32_time_t    st_atime;
 	unsigned int       __unused1;
-	__kernel_time_t32  st_mtime;
+	compat32_time_t    st_mtime;
 	unsigned int       __unused2;
-	__kernel_time_t32  st_ctime;
+	compat32_time_t    st_ctime;
 	unsigned int       __unused3;
 	__kernel_off_t32   st_blksize;
 	__kernel_off_t32   st_blocks;
diff -ruN 2.5.50/include/asm-x86_64/compat32.h 2.5.50-32bit.1/include/asm-x86_64/compat32.h
--- 2.5.50/include/asm-x86_64/compat32.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-32bit.1/include/asm-x86_64/compat32.h	2002-11-28 14:23:21.000000000 +1100
@@ -0,0 +1,9 @@
+#ifndef _ASM_X86_64_COMPAT32_H
+#define _ASM_X86_64_COMPAT32_H
+/*
+ * Architecture specific 32 bit compatibility types
+ */
+
+typedef s32		compat32_time_t;
+
+#endif /* _ASM_X86_64_COMPAT32_H */
diff -ruN 2.5.50/include/asm-x86_64/ia32.h 2.5.50-32bit.1/include/asm-x86_64/ia32.h
--- 2.5.50/include/asm-x86_64/ia32.h	2002-10-21 13:35:27.000000000 +1000
+++ 2.5.50-32bit.1/include/asm-x86_64/ia32.h	2002-11-28 14:34:57.000000000 +1100
@@ -13,7 +13,6 @@
 typedef unsigned int	       __kernel_size_t32;
 typedef int		       __kernel_ssize_t32;
 typedef int		       __kernel_ptrdiff_t32;
-typedef int		       __kernel_time_t32;
 typedef int		       __kernel_clock_t32;
 typedef int		       __kernel_pid_t32;
 typedef unsigned short	       __kernel_ipc_pid_t32;
diff -ruN 2.5.50/include/linux/compat32.h 2.5.50-32bit.1/include/linux/compat32.h
--- 2.5.50/include/linux/compat32.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-32bit.1/include/linux/compat32.h	2002-11-28 14:24:26.000000000 +1100
@@ -0,0 +1,15 @@
+#ifndef _LINUX_COMPAT32_H
+#define _LINUX_COMPAT32_H
+/*
+ * These are the type definitions for the 32 compatibility
+ * layer on 64 bit architectures.
+ */
+#include <linux/types.h>
+#include <asm/compat32.h>
+
+struct timespec32 {
+	compat32_time_t	tv_sec;
+	s32		tv_nsec;
+};
+
+#endif /* _LINUX_COMPAT32_H */
diff -ruN 2.5.50/include/linux/time.h 2.5.50-32bit.1/include/linux/time.h
--- 2.5.50/include/linux/time.h	2002-11-18 15:47:56.000000000 +1100
+++ 2.5.50-32bit.1/include/linux/time.h	2002-11-28 13:52:45.000000000 +1100
@@ -138,6 +138,7 @@
 #ifdef __KERNEL__
 extern void do_gettimeofday(struct timeval *tv);
 extern void do_settimeofday(struct timeval *tv);
+extern long do_nanosleep(struct timespec *t);
 #endif
 
 #define FD_SETSIZE		__FD_SETSIZE
diff -ruN 2.5.50/kernel/Makefile 2.5.50-32bit.1/kernel/Makefile
--- 2.5.50/kernel/Makefile	2002-11-28 10:34:59.000000000 +1100
+++ 2.5.50-32bit.1/kernel/Makefile	2002-11-28 14:11:10.000000000 +1100
@@ -21,6 +21,7 @@
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_COMPAT32) += compat32.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -ruN 2.5.50/kernel/compat32.c 2.5.50-32bit.1/kernel/compat32.c
--- 2.5.50/kernel/compat32.c	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-32bit.1/kernel/compat32.c	2002-11-28 14:12:49.000000000 +1100
@@ -0,0 +1,40 @@
+/*
+ *  linux/kernel/compat32.c
+ *
+ *  Kernel compatibililty routines for e.g. 32 bit syscall support
+ *  on 64 bit kernels.
+ *
+ *  Copyright (C) 2002 Stephen Rothwell, IBM Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <linux/compat32.h>
+#include <linux/errno.h>
+#include <linux/time.h>
+
+#include <asm/uaccess.h>
+
+asmlinkage long sys32_nanosleep(struct timespec32 *rqtp,
+		struct timespec32 *rmtp)
+{
+	struct timespec t;
+	struct timespec32 ct;
+	s32 ret;
+
+	if (copy_from_user(&ct, rqtp, sizeof(ct)))
+		return -EFAULT;
+	t.tv_sec = ct.tv_sec;
+	t.tv_nsec = ct.tv_nsec;
+	ret = do_nanosleep(&t);
+	if (rmtp && (ret == -EINTR)) {
+		ct.tv_sec = t.tv_sec;
+		ct.tv_nsec = t.tv_nsec;
+		if (copy_to_user(rmtp, &ct, sizeof(ct)))
+			return -EFAULT;
+	}
+	return ret;
+}
diff -ruN 2.5.50/kernel/timer.c 2.5.50-32bit.1/kernel/timer.c
--- 2.5.50/kernel/timer.c	2002-11-28 10:35:50.000000000 +1100
+++ 2.5.50-32bit.1/kernel/timer.c	2002-11-28 13:43:01.000000000 +1100
@@ -1022,33 +1022,41 @@
 	return current->pid;
 }
 
-asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
+long do_nanosleep(struct timespec *t)
 {
-	struct timespec t;
 	unsigned long expire;
 
-	if(copy_from_user(&t, rqtp, sizeof(struct timespec)))
-		return -EFAULT;
-
-	if (t.tv_nsec >= 1000000000L || t.tv_nsec < 0 || t.tv_sec < 0)
+	if ((t->tv_nsec >= 1000000000L) || (t->tv_nsec < 0) || (t->tv_sec < 0))
 		return -EINVAL;
 
-	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
+	expire = timespec_to_jiffies(t) + (t->tv_sec || t->tv_nsec);
 
 	current->state = TASK_INTERRUPTIBLE;
 	expire = schedule_timeout(expire);
 
 	if (expire) {
-		if (rmtp) {
-			jiffies_to_timespec(expire, &t);
-			if (copy_to_user(rmtp, &t, sizeof(struct timespec)))
-				return -EFAULT;
-		}
+		jiffies_to_timespec(expire, t);
 		return -EINTR;
 	}
 	return 0;
 }
 
+asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
+{
+	struct timespec t;
+	long ret;
+
+	if (copy_from_user(&t, rqtp, sizeof(t)))
+		return -EFAULT;
+
+	ret = do_nanosleep(&t);
+	if (rmtp && (ret == -EINTR)) {
+		if (copy_to_user(rmtp, &t, sizeof(t)))
+			return -EFAULT;
+	}
+	return ret;
+}
+
 /*
  * sys_sysinfo - fill in sysinfo struct
  */ 
