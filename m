Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSLDHXs>; Wed, 4 Dec 2002 02:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSLDHXs>; Wed, 4 Dec 2002 02:23:48 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:2952 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265480AbSLDHX3>;
	Wed, 4 Dec 2002 02:23:29 -0500
Date: Wed, 4 Dec 2002 18:30:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: schwidefsky@de.ibm.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
Message-Id: <20021204183043.470d1b97.sfr@canb.auug.org.au>
In-Reply-To: <20021204180224.406d143c.sfr@canb.auug.org.au>
References: <20021204180224.406d143c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin, Linus,

This is the S390x specific patch.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50-BK.2/arch/s390x/Kconfig 2.5.50-BK.2-32bit.1/arch/s390x/Kconfig
--- 2.5.50-BK.2/arch/s390x/Kconfig	2002-11-28 10:34:42.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/s390x/Kconfig	2002-12-03 16:58:25.000000000 +1100
@@ -92,6 +92,11 @@
 	  (and some other stuff like libraries and such) is needed for
 	  executing 31 bit applications.  It is safe to say "Y".
 
+config COMPAT
+	bool
+	depends on S390_SUPPORT
+	default y
+
 config BINFMT_ELF32
 	tristate "Kernel support for 31 bit ELF binaries"
 	depends on S390_SUPPORT
diff -ruN 2.5.50-BK.2/arch/s390x/kernel/binfmt_elf32.c 2.5.50-BK.2-32bit.1/arch/s390x/kernel/binfmt_elf32.c
--- 2.5.50-BK.2/arch/s390x/kernel/binfmt_elf32.c	2002-09-01 12:00:02.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/s390x/kernel/binfmt_elf32.c	2002-12-04 15:27:08.000000000 +1100
@@ -115,14 +115,10 @@
 #include <linux/config.h>
 #include <linux/elfcore.h>
 #include <linux/binfmts.h>
+#include <linux/compat.h>
 
 int setup_arg_pages32(struct linux_binprm *bprm);
 
-struct timeval32
-{
-    int tv_sec, tv_usec;
-};
-
 #define elf_prstatus elf_prstatus32
 struct elf_prstatus32
 {
@@ -134,10 +130,10 @@
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
diff -ruN 2.5.50-BK.2/arch/s390x/kernel/entry.S 2.5.50-BK.2-32bit.1/arch/s390x/kernel/entry.S
--- 2.5.50-BK.2/arch/s390x/kernel/entry.S	2002-11-28 10:35:37.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/s390x/kernel/entry.S	2002-12-04 17:40:35.000000000 +1100
@@ -406,7 +406,7 @@
         .long  SYSCALL(sys_alarm,sys32_alarm_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old fstat syscall */
         .long  SYSCALL(sys_pause,sys32_pause)
-        .long  SYSCALL(sys_utime,sys32_utime_wrapper)           /* 30 */
+        .long  SYSCALL(sys_utime,compat_sys_utime_wrapper)           /* 30 */
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old stty syscall */
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old gtty syscall */
         .long  SYSCALL(sys_access,sys32_access_wrapper)
@@ -480,8 +480,8 @@
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
         .long  SYSCALL(sys_socketcall,sys32_socketcall_wrapper)
         .long  SYSCALL(sys_syslog,sys32_syslog_wrapper)
-        .long  SYSCALL(sys_setitimer,sys32_setitimer_wrapper)
-        .long  SYSCALL(sys_getitimer,sys32_getitimer_wrapper)   /* 105 */
+        .long  SYSCALL(sys_setitimer,compat_sys_setitimer_wrapper)
+        .long  SYSCALL(sys_getitimer,compat_sys_getitimer_wrapper)   /* 105 */
         .long  SYSCALL(sys_newstat,sys32_newstat_wrapper)
         .long  SYSCALL(sys_newlstat,sys32_newlstat_wrapper)
         .long  SYSCALL(sys_newfstat,sys32_newfstat_wrapper)
@@ -538,7 +538,7 @@
         .long  SYSCALL(sys_sched_get_priority_max,sys32_sched_get_priority_max_wrapper)
         .long  SYSCALL(sys_sched_get_priority_min,sys32_sched_get_priority_min_wrapper)
         .long  SYSCALL(sys_sched_rr_get_interval,sys32_sched_rr_get_interval_wrapper)
-        .long  SYSCALL(sys_nanosleep,sys32_nanosleep_wrapper)
+        .long  SYSCALL(sys_nanosleep,compat_sys_nanosleep_wrapper)
         .long  SYSCALL(sys_mremap,sys32_mremap_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys32_setresuid16_wrapper) /* old setresuid16 syscall */
         .long  SYSCALL(sys_ni_syscall,sys32_getresuid16_wrapper) /* old getresuid16 syscall */
diff -ruN 2.5.50-BK.2/arch/s390x/kernel/ioctl32.c 2.5.50-BK.2-32bit.1/arch/s390x/kernel/ioctl32.c
--- 2.5.50-BK.2/arch/s390x/kernel/ioctl32.c	2002-11-28 10:34:42.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/s390x/kernel/ioctl32.c	2002-12-04 15:26:13.000000000 +1100
@@ -70,11 +70,6 @@
 	return ret;
 }
 
-struct timeval32 {
-	int tv_sec;
-	int tv_usec;
-};
-
 #define EXT2_IOC32_GETFLAGS               _IOR('f', 1, int)
 #define EXT2_IOC32_SETFLAGS               _IOW('f', 2, int)
 #define EXT2_IOC32_GETVERSION             _IOR('v', 1, int)
diff -ruN 2.5.50-BK.2/arch/s390x/kernel/linux32.c 2.5.50-BK.2-32bit.1/arch/s390x/kernel/linux32.c
--- 2.5.50-BK.2/arch/s390x/kernel/linux32.c	2002-11-28 10:34:42.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/s390x/kernel/linux32.c	2002-12-04 16:23:19.000000000 +1100
@@ -22,7 +22,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -57,6 +56,7 @@
 #include <linux/icmpv6.h>
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
+#include <linux/compat.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -245,49 +245,20 @@
 
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
-static inline long get_tv32(struct timeval *o, struct timeval32 *i)
+static inline long get_tv32(struct timeval *o, struct compat_timeval *i)
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
-static inline long put_it32(struct itimerval32 *o, struct itimerval *i)
-{
-	return (!access_ok(VERIFY_WRITE, i32, sizeof(*i32)) ||
-		(__put_user(i->it_interval.tv_sec, &o->it_interval.tv_sec) |
-		 __put_user(i->it_interval.tv_usec, &o->it_interval.tv_usec) |
-		 __put_user(i->it_value.tv_sec, &o->it_value.tv_sec) |
-		 __put_user(i->it_value.tv_usec, &o->it_value.tv_usec)));
-}
-
 struct msgbuf32 { s32 mtype; char mtext[1]; };
 
 struct ipc64_perm_ds32
@@ -318,8 +289,8 @@
 
 struct semid_ds32 {
         struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-        __kernel_time_t32 sem_otime;              /* last semop time */
-        __kernel_time_t32 sem_ctime;              /* last change time */
+        compat_time_t   sem_otime;              /* last semop time */
+        compat_time_t   sem_ctime;              /* last change time */
         u32 sem_base;              /* ptr to first semaphore in array */
         u32 sem_pending;          /* pending operations to be processed */
         u32 sem_pending_last;    /* last pending operation */
@@ -330,9 +301,9 @@
 struct semid64_ds32 {
 	struct ipc64_perm_ds32 sem_perm;
 	unsigned int	  __pad1;
-	__kernel_time_t32 sem_otime;
+	compat_time_t   sem_otime;
 	unsigned int	  __pad2;
-	__kernel_time_t32 sem_ctime;
+	compat_time_t   sem_ctime;
 	u32 sem_nsems;
 	u32 __unused1;
 	u32 __unused2;
@@ -343,9 +314,9 @@
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
@@ -358,11 +329,11 @@
 struct msqid64_ds32 {
 	struct ipc64_perm_ds32 msg_perm;
 	unsigned int   __pad1;
-	__kernel_time_t32 msg_stime;
+	compat_time_t msg_stime;
 	unsigned int   __pad2;
-	__kernel_time_t32 msg_rtime;
+	compat_time_t msg_rtime;
 	unsigned int   __pad3;
-	__kernel_time_t32 msg_ctime;
+	compat_time_t msg_ctime;
 	unsigned int  msg_cbytes;
 	unsigned int  msg_qnum;
 	unsigned int  msg_qbytes;
@@ -376,9 +347,9 @@
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
@@ -386,12 +357,12 @@
 
 struct shmid64_ds32 {
 	struct ipc64_perm_ds32	shm_perm;
-	__kernel_size_t32	shm_segsz;
-	__kernel_time_t32	shm_atime;
+	compat_size_t	shm_segsz;
+	compat_time_t  	shm_atime;
 	unsigned int		__unused1;
-	__kernel_time_t32	shm_dtime;
+	compat_time_t  	shm_dtime;
 	unsigned int		__unused2;
-	__kernel_time_t32	shm_ctime;
+	compat_time_t  	shm_ctime;
 	unsigned int		__unused3;
 	__kernel_pid_t32	shm_cpid;
 	__kernel_pid_t32	shm_lpid;
@@ -1010,37 +981,7 @@
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
@@ -1363,7 +1304,7 @@
 asmlinkage int sys32_select(int n, u32 *inp, u32 *outp, u32 *exp, u32 tvp_x)
 {
 	fd_set_bits fds;
-	struct timeval32 *tvp = (struct timeval32 *)AA(tvp_x);
+	struct compat_timeval *tvp = (struct compat_timeval *)AA(tvp_x);
 	char *bits;
 	unsigned long nn;
 	long timeout;
@@ -1671,8 +1612,8 @@
 }
 
 struct rusage32 {
-        struct timeval32 ru_utime;
-        struct timeval32 ru_stime;
+        struct compat_timeval ru_utime;
+        struct compat_timeval ru_stime;
         s32    ru_maxrss;
         s32    ru_ixrss;
         s32    ru_idrss;
@@ -1774,14 +1715,10 @@
 	return ret;
 }
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-                
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 
-asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct timespec32 *interval)
+asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid,
+		struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
@@ -1796,28 +1733,6 @@
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
@@ -1837,7 +1752,7 @@
 
 extern asmlinkage int sys_rt_sigprocmask(int how, sigset_t *set, sigset_t *oset, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigprocmask(int how, sigset_t32 *set, sigset_t32 *oset, __kernel_size_t32 sigsetsize)
+asmlinkage int sys32_rt_sigprocmask(int how, sigset_t32 *set, sigset_t32 *oset, compat_size_t sigsetsize)
 {
 	sigset_t s;
 	sigset_t32 s32;
@@ -1888,7 +1803,7 @@
 
 extern asmlinkage int sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigpending(sigset_t32 *set, __kernel_size_t32 sigsetsize)
+asmlinkage int sys32_rt_sigpending(sigset_t32 *set, compat_size_t sigsetsize)
 {
 	sigset_t s;
 	sigset_t32 s32;
@@ -1916,7 +1831,7 @@
 
 asmlinkage int
 sys32_rt_sigtimedwait(sigset_t32 *uthese, siginfo_t32 *uinfo,
-		      struct timespec32 *uts, __kernel_size_t32 sigsetsize)
+		      struct compat_timespec *uts, compat_size_t sigsetsize)
 {
 	int ret, sig;
 	sigset_t these;
@@ -2136,14 +2051,14 @@
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
@@ -2277,7 +2192,7 @@
 {
 	struct cmsghdr32 *ucmsg;
 	struct cmsghdr *kcmsg, *kcmsg_base;
-	__kernel_size_t32 ucmlen;
+	compat_size_t ucmlen;
 	__kernel_size_t kcmlen, tmp;
 
 	kcmlen = 0;
@@ -2498,12 +2413,12 @@
 			 * from 64-bit time values to 32-bit time values
 			*/
 		case SO_TIMESTAMP: {
-			__kernel_time_t32* ptr_time32 = CMSG32_DATA(kcmsg32);
+			compat_time_t* ptr_time32 = CMSG32_DATA(kcmsg32);
 			__kernel_time_t*   ptr_time   = CMSG_DATA(ucmsg);
 			get_user(*ptr_time32, ptr_time);
 			get_user(*(ptr_time32+1), ptr_time+1);
 			kcmsg32->cmsg_len -= 2*(sizeof(__kernel_time_t) -
-						sizeof(__kernel_time_t32));
+						sizeof(compat_time_t));
 		}
 		default:;
 		}
@@ -2746,7 +2661,7 @@
 	err = __put_user(msg_sys.msg_flags, &msg->msg_flags);
 	if (err)
 		goto out_freeiov;
-	err = __put_user((__kernel_size_t32) ((unsigned long)msg_sys.msg_control - cmsg_ptr), &msg->msg_controllen);
+	err = __put_user((compat_size_t) ((unsigned long)msg_sys.msg_control - cmsg_ptr), &msg->msg_controllen);
 	if (err)
 		goto out_freeiov;
 	err = len;
@@ -2848,7 +2763,7 @@
 		struct timeval tmp;
 		mm_segment_t old_fs;
 
-		if (get_tv32(&tmp, (struct timeval32 *)optval ))
+		if (get_tv32(&tmp, (struct compat_timeval *)optval ))
 			return -EFAULT;
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
@@ -3126,7 +3041,7 @@
 }
 
 static int
-qm_modules(char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_modules(char *buf, size_t bufsize, compat_size_t *ret)
 {
 	struct module *mod;
 	size_t nmod, space, len;
@@ -3161,7 +3076,7 @@
 }
 
 static int
-qm_deps(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_deps(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t i, space, len;
 
@@ -3198,7 +3113,7 @@
 }
 
 static int
-qm_refs(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_refs(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t nrefs, space, len;
 	struct module_ref *ref;
@@ -3242,7 +3157,7 @@
 }
 
 static inline int
-qm_symbols(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_symbols(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t i, space, len;
 	struct module_symbol *s;
@@ -3301,7 +3216,7 @@
 }
 
 static inline int
-qm_info(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_info(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	int error = 0;
 
@@ -3683,7 +3598,7 @@
 extern struct timezone sys_tz;
 extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 
-asmlinkage int sys32_gettimeofday(struct timeval32 *tv, struct timezone *tz)
+asmlinkage int sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	if (tv) {
 		struct timeval ktv;
@@ -3698,7 +3613,7 @@
 	return 0;
 }
 
-asmlinkage int sys32_settimeofday(struct timeval32 *tv, struct timezone *tz)
+asmlinkage int sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	struct timeval ktv;
 	struct timezone ktz;
@@ -3715,46 +3630,9 @@
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
@@ -3807,27 +3685,25 @@
 extern asmlinkage ssize_t sys_pwrite64(unsigned int fd, const char * buf,
 				     size_t count, loff_t pos);
 
-typedef __kernel_ssize_t32 ssize_t32;
-
-asmlinkage ssize_t32 sys32_pread64(unsigned int fd, char *ubuf,
-				 __kernel_size_t32 count, u32 poshi, u32 poslo)
+asmlinkage compat_ssize_t sys32_pread64(unsigned int fd, char *ubuf,
+				 compat_size_t count, u32 poshi, u32 poslo)
 {
-	if ((ssize_t32) count < 0)
+	if ((compat_ssize_t) count < 0)
 		return -EINVAL;
 	return sys_pread64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
-asmlinkage ssize_t32 sys32_pwrite64(unsigned int fd, char *ubuf,
-				  __kernel_size_t32 count, u32 poshi, u32 poslo)
+asmlinkage compat_ssize_t sys32_pwrite64(unsigned int fd, char *ubuf,
+				  compat_size_t count, u32 poshi, u32 poslo)
 {
-	if ((ssize_t32) count < 0)
+	if ((compat_ssize_t) count < 0)
 		return -EINVAL;
 	return sys_pwrite64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
 extern asmlinkage ssize_t sys_readahead(int fd, loff_t offset, size_t count);
 
-asmlinkage ssize_t32 sys32_readahead(int fd, u32 offhi, u32 offlo, s32 count)
+asmlinkage compat_ssize_t sys32_readahead(int fd, u32 offhi, u32 offlo, s32 count)
 {
 	return sys_readahead(fd, ((loff_t)AA(offhi) << 32) | AA(offlo), count);
 }
@@ -3882,7 +3758,7 @@
 	u32 modes;
 	s32 offset, freq, maxerror, esterror;
 	s32 status, constant, precision, tolerance;
-	struct timeval32 time;
+	struct compat_timeval time;
 	s32 tick;
 	s32 ppsfreq, jitter, shift, stabil;
 	s32 jitcnt, calcnt, errcnt, stbcnt;
@@ -4353,7 +4229,7 @@
 
 asmlinkage int
 sys32_futex(void *uaddr, int op, int val, 
-		 struct timespec32 *timeout32)
+		 struct compat_timespec *timeout32)
 {
 	struct timespec tmp;
 	mm_segment_t old_fs;
@@ -4373,9 +4249,9 @@
 
 asmlinkage ssize_t sys_read(unsigned int fd, char * buf, size_t count);
 
-asmlinkage ssize_t32 sys32_read(unsigned int fd, char * buf, size_t count)
+asmlinkage compat_ssize_t sys32_read(unsigned int fd, char * buf, size_t count)
 {
-	if ((ssize_t32) count < 0)
+	if ((compat_ssize_t) count < 0)
 		return -EINVAL; 
 
 	return sys_read(fd, buf, count);
@@ -4383,9 +4259,9 @@
 
 asmlinkage ssize_t sys_write(unsigned int fd, const char * buf, size_t count);
 
-asmlinkage ssize_t32 sys32_write(unsigned int fd, char * buf, size_t count)
+asmlinkage compat_ssize_t sys32_write(unsigned int fd, char * buf, size_t count)
 {
-	if ((ssize_t32) count < 0)
+	if ((compat_ssize_t) count < 0)
 		return -EINVAL; 
 
 	return sys_write(fd, buf, count);
diff -ruN 2.5.50-BK.2/arch/s390x/kernel/linux32.h 2.5.50-BK.2-32bit.1/arch/s390x/kernel/linux32.h
--- 2.5.50-BK.2/arch/s390x/kernel/linux32.h	2002-10-08 12:02:40.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/arch/s390x/kernel/linux32.h	2002-12-04 14:46:24.000000000 +1100
@@ -2,6 +2,7 @@
 #define _ASM_S390X_S390_H
 
 #include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/socket.h>
 #include <linux/nfs_fs.h>
 #include <linux/sunrpc/svc.h>
@@ -15,10 +16,7 @@
 	((unsigned long)(__x))
 
 /* Now 32bit compatibility types */
-typedef unsigned int           __kernel_size_t32;
-typedef int                    __kernel_ssize_t32;
 typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
 typedef int                    __kernel_clock_t32;
 typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
@@ -253,7 +251,7 @@
 typedef struct {
 	__u32			ss_sp;		/* pointer */
 	int			ss_flags;
-	__kernel_size_t32	ss_size;
+	compat_size_t		ss_size;
 } stack_t32;
 
 /* asm/ucontext.h */
diff -ruN 2.5.50-BK.2/arch/s390x/kernel/wrapper32.S 2.5.50-BK.2-32bit.1/arch/s390x/kernel/wrapper32.S
--- 2.5.50-BK.2/arch/s390x/kernel/wrapper32.S	2002-11-28 10:34:42.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/arch/s390x/kernel/wrapper32.S	2002-12-04 17:40:29.000000000 +1100
@@ -130,11 +130,11 @@
 
 #sys32_pause_wrapper			# void 
 
-	.globl  sys32_utime_wrapper 
-sys32_utime_wrapper:
+	.globl  compat_sys_utime_wrapper 
+compat_sys_utime_wrapper:
 	llgtr	%r2,%r2			# char *
-	llgtr	%r3,%r3			# struct utimbuf_emu31 *
-	jg	sys32_utime		# branch to system call
+	llgtr	%r3,%r3			# struct compat_utimbuf *
+	jg	compat_sys_utime		# branch to system call
 
 	.globl  sys32_access_wrapper 
 sys32_access_wrapper:
@@ -465,18 +465,18 @@
 	lgfr	%r4,%r4			# int
 	jg	sys_syslog		# branch to system call
 
-	.globl  sys32_setitimer_wrapper 
-sys32_setitimer_wrapper:
+	.globl  compat_sys_setitimer_wrapper 
+compat_sys_setitimer_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# struct itimerval_emu31 *
 	llgtr	%r4,%r4			# struct itimerval_emu31 *
-	jg	sys32_setitimer		# branch to system call
+	jg	compat_sys_setitimer		# branch to system call
 
-	.globl  sys32_getitimer_wrapper 
-sys32_getitimer_wrapper:
+	.globl  compat_sys_getitimer_wrapper 
+compat_sys_getitimer_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# struct itimerval_emu31 *
-	jg	sys32_getitimer		# branch to system call
+	jg	compat_sys_getitimer		# branch to system call
 
 	.globl  sys32_newstat_wrapper 
 sys32_newstat_wrapper:
@@ -743,14 +743,14 @@
 	.globl  sys32_sched_rr_get_interval_wrapper 
 sys32_sched_rr_get_interval_wrapper:
 	lgfr	%r2,%r2			# pid_t
-	llgtr	%r3,%r3			# struct timespec_emu31 *
+	llgtr	%r3,%r3			# struct compat_timespec *
 	jg	sys32_sched_rr_get_interval	# branch to system call
 
-	.globl  sys32_nanosleep_wrapper 
-sys32_nanosleep_wrapper:
-	llgtr	%r2,%r2			# struct timespec_emu31 *
-	llgtr	%r3,%r3			# struct timespec_emu31 *
-	jg	sys32_nanosleep		# branch to system call
+	.globl  compat_sys_nanosleep_wrapper 
+compat_sys_nanosleep_wrapper:
+	llgtr	%r2,%r2			# struct compat_timespec *
+	llgtr	%r3,%r3			# struct compat_timespec *
+	jg	compat_sys_nanosleep		# branch to system call
 
 	.globl  sys32_mremap_wrapper 
 sys32_mremap_wrapper:
@@ -839,7 +839,7 @@
 sys32_rt_sigtimedwait_wrapper:
 	llgtr	%r2,%r2			# const sigset_emu31_t *
 	llgtr	%r3,%r3			# siginfo_emu31_t *
-	llgtr	%r4,%r4			# const struct timespec_emu31 *
+	llgtr	%r4,%r4			# const struct compat_timespec *
 	llgfr	%r5,%r5			# size_t
 	jg	sys32_rt_sigtimedwait	# branch to system call
 
diff -ruN 2.5.50-BK.2/include/asm-s390x/compat.h 2.5.50-BK.2-32bit.1/include/asm-s390x/compat.h
--- 2.5.50-BK.2/include/asm-s390x/compat.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/asm-s390x/compat.h	2002-12-04 15:15:45.000000000 +1100
@@ -0,0 +1,18 @@
+#ifndef _ASM_S390X_COMPAT_H
+#define _ASM_S390X_COMPAT_H
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
+#endif /* _ASM_S390X_COMPAT_H */
