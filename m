Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbSL3GbZ>; Mon, 30 Dec 2002 01:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbSL3GbZ>; Mon, 30 Dec 2002 01:31:25 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:34730 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266765AbSL3Gaj>;
	Mon, 30 Dec 2002 01:30:39 -0500
Date: Mon, 30 Dec 2002 17:38:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] Eliminate the rest of the __kernel_..._t32
 typedefs 0/7
Message-Id: <20021230173854.3374eb1f.sfr@canb.auug.org.au>
In-Reply-To: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
References: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

S390X specific stuff ...

This is basically the whole compatibility syscall infrastructure.
Are there parts of this that I can merge directly to Linus?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.53/arch/s390x/Kconfig 2.5.53-32bit.1/arch/s390x/Kconfig
--- 2.5.53/arch/s390x/Kconfig	2002-12-10 15:10:17.000000000 +1100
+++ 2.5.53-32bit.1/arch/s390x/Kconfig	2002-12-16 14:51:53.000000000 +1100
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
diff -ruN 2.5.53/arch/s390x/kernel/binfmt_elf32.c 2.5.53-32bit.1/arch/s390x/kernel/binfmt_elf32.c
--- 2.5.53/arch/s390x/kernel/binfmt_elf32.c	2002-09-01 12:00:02.000000000 +1000
+++ 2.5.53-32bit.1/arch/s390x/kernel/binfmt_elf32.c	2002-12-16 14:51:53.000000000 +1100
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
diff -ruN 2.5.53/arch/s390x/kernel/entry.S 2.5.53-32bit.1/arch/s390x/kernel/entry.S
--- 2.5.53/arch/s390x/kernel/entry.S	2002-12-16 14:49:47.000000000 +1100
+++ 2.5.53-32bit.1/arch/s390x/kernel/entry.S	2002-12-16 14:51:53.000000000 +1100
@@ -421,7 +421,7 @@
         .long  SYSCALL(sys_alarm,sys32_alarm_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old fstat syscall */
         .long  SYSCALL(sys_pause,sys32_pause)
-        .long  SYSCALL(sys_utime,sys32_utime_wrapper)           /* 30 */
+        .long  SYSCALL(sys_utime,compat_sys_utime_wrapper)           /* 30 */
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old stty syscall */
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old gtty syscall */
         .long  SYSCALL(sys_access,sys32_access_wrapper)
@@ -434,7 +434,7 @@
         .long  SYSCALL(sys_rmdir,sys32_rmdir_wrapper)           /* 40 */
         .long  SYSCALL(sys_dup,sys32_dup_wrapper)
         .long  SYSCALL(sys_pipe,sys32_pipe_wrapper)
-        .long  SYSCALL(sys_times,sys32_times_wrapper)
+        .long  SYSCALL(sys_times,compat_sys_times_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old prof syscall */
         .long  SYSCALL(sys_brk,sys32_brk_wrapper)               /* 45 */
         .long  SYSCALL(sys_ni_syscall,sys32_setgid16)   /* old setgid16 syscall*/
@@ -495,11 +495,11 @@
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
         .long  SYSCALL(sys_socketcall,sys32_socketcall_wrapper)
         .long  SYSCALL(sys_syslog,sys32_syslog_wrapper)
-        .long  SYSCALL(sys_setitimer,sys32_setitimer_wrapper)
-        .long  SYSCALL(sys_getitimer,sys32_getitimer_wrapper)   /* 105 */
-        .long  SYSCALL(sys_newstat,sys32_newstat_wrapper)
-        .long  SYSCALL(sys_newlstat,sys32_newlstat_wrapper)
-        .long  SYSCALL(sys_newfstat,sys32_newfstat_wrapper)
+        .long  SYSCALL(sys_setitimer,compat_sys_setitimer_wrapper)
+        .long  SYSCALL(sys_getitimer,compat_sys_getitimer_wrapper)   /* 105 */
+        .long  SYSCALL(sys_newstat,compat_sys_newstat_wrapper)
+        .long  SYSCALL(sys_newlstat,compat_sys_newlstat_wrapper)
+        .long  SYSCALL(sys_newfstat,compat_sys_newfstat_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old uname syscall */
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* iopl for i386 */
         .long  SYSCALL(sys_vhangup,sys_vhangup)
@@ -553,7 +553,7 @@
         .long  SYSCALL(sys_sched_get_priority_max,sys32_sched_get_priority_max_wrapper)
         .long  SYSCALL(sys_sched_get_priority_min,sys32_sched_get_priority_min_wrapper)
         .long  SYSCALL(sys_sched_rr_get_interval,sys32_sched_rr_get_interval_wrapper)
-        .long  SYSCALL(sys_nanosleep,sys32_nanosleep_wrapper)
+        .long  SYSCALL(sys_nanosleep,compat_sys_nanosleep_wrapper)
         .long  SYSCALL(sys_mremap,sys32_mremap_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys32_setresuid16_wrapper) /* old setresuid16 syscall */
         .long  SYSCALL(sys_ni_syscall,sys32_getresuid16_wrapper) /* old getresuid16 syscall */
diff -ruN 2.5.53/arch/s390x/kernel/ioctl32.c 2.5.53-32bit.1/arch/s390x/kernel/ioctl32.c
--- 2.5.53/arch/s390x/kernel/ioctl32.c	2002-11-28 10:34:42.000000000 +1100
+++ 2.5.53-32bit.1/arch/s390x/kernel/ioctl32.c	2002-12-16 14:51:53.000000000 +1100
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
@@ -70,11 +71,6 @@
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
@@ -383,9 +379,9 @@
 
 struct loop_info32 {
 	int			lo_number;      /* ioctl r/o */
-	__kernel_dev_t32	lo_device;      /* ioctl r/o */
+	compat_dev_t	lo_device;      /* ioctl r/o */
 	unsigned int		lo_inode;       /* ioctl r/o */
-	__kernel_dev_t32	lo_rdevice;     /* ioctl r/o */
+	compat_dev_t	lo_rdevice;     /* ioctl r/o */
 	int			lo_offset;
 	int			lo_encrypt_type;
 	int			lo_encrypt_key_size;    /* ioctl w/o */
diff -ruN 2.5.53/arch/s390x/kernel/linux32.c 2.5.53-32bit.1/arch/s390x/kernel/linux32.c
--- 2.5.53/arch/s390x/kernel/linux32.c	2002-11-28 10:34:42.000000000 +1100
+++ 2.5.53-32bit.1/arch/s390x/kernel/linux32.c	2002-12-30 16:09:33.000000000 +1100
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
@@ -297,7 +268,7 @@
         __kernel_gid32_t        gid;
         __kernel_uid32_t        cuid;
         __kernel_gid32_t        cgid;
-        __kernel_mode_t32       mode;
+        compat_mode_t       mode;
         unsigned short          __pad1;
         unsigned short          seq;
         unsigned short          __pad2;
@@ -308,18 +279,18 @@
 struct ipc_perm32
 {
 	key_t    	  key;
-        __kernel_uid_t32  uid;
-        __kernel_gid_t32  gid;
-        __kernel_uid_t32  cuid;
-        __kernel_gid_t32  cgid;
-        __kernel_mode_t32 mode;
+        compat_uid_t  uid;
+        compat_gid_t  gid;
+        compat_uid_t  cuid;
+        compat_gid_t  cgid;
+        compat_mode_t mode;
         unsigned short  seq;
 };
 
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
@@ -343,31 +314,31 @@
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
         unsigned short msg_qnum;  
         unsigned short msg_qbytes;
-        __kernel_ipc_pid_t32 msg_lspid;
-        __kernel_ipc_pid_t32 msg_lrpid;
+        compat_ipc_pid_t msg_lspid;
+        compat_ipc_pid_t msg_lrpid;
 };
 
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
-	__kernel_pid_t32 msg_lspid;
-	__kernel_pid_t32 msg_lrpid;
+	compat_pid_t msg_lspid;
+	compat_pid_t msg_lrpid;
 	unsigned int  __unused1;
 	unsigned int  __unused2;
 };
@@ -376,25 +347,25 @@
 struct shmid_ds32 {
 	struct ipc_perm32       shm_perm;
 	int                     shm_segsz;
-	__kernel_time_t32       shm_atime;
-	__kernel_time_t32       shm_dtime;
-	__kernel_time_t32       shm_ctime;
-	__kernel_ipc_pid_t32    shm_cpid; 
-	__kernel_ipc_pid_t32    shm_lpid; 
+	compat_time_t         shm_atime;
+	compat_time_t         shm_dtime;
+	compat_time_t         shm_ctime;
+	compat_ipc_pid_t    shm_cpid; 
+	compat_ipc_pid_t    shm_lpid; 
 	unsigned short          shm_nattch;
 };
 
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
-	__kernel_pid_t32	shm_cpid;
-	__kernel_pid_t32	shm_lpid;
+	compat_pid_t	shm_cpid;
+	compat_pid_t	shm_lpid;
 	unsigned int		shm_nattch;
 	unsigned int		__unused4;
 	unsigned int		__unused5;
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
@@ -1452,7 +1393,7 @@
 	return ret;
 }
 
-static int cp_new_stat32(struct kstat *stat, struct stat32 *statbuf)
+int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
 {
 	int err;
 
@@ -1479,39 +1420,6 @@
 	return err;
 }
 
-asmlinkage int sys32_newstat(char * filename, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int error = vfs_stat(filename, &stat);
-
-	if (!error)
-		error = cp_new_stat32(&stat, statbuf);
-
-	return error;
-}
-
-asmlinkage int sys32_newlstat(char * filename, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int error = vfs_lstat(filename, &stat);
-
-	if (!error)
-		error = cp_new_stat32(&stat, statbuf);
-
-	return error;
-}
-
-asmlinkage int sys32_newfstat(unsigned int fd, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int error = vfs_fstat(fd, &stat);
-
-	if (!error)
-		error = cp_new_stat32(&stat, statbuf);
-
-	return error;
-}
-
 extern asmlinkage int sys_sysfs(int option, unsigned long arg1, unsigned long arg2);
 
 asmlinkage int sys32_sysfs(int option, u32 arg1, u32 arg2)
@@ -1522,16 +1430,16 @@
 struct ncp_mount_data32 {
         int version;
         unsigned int ncp_fd;
-        __kernel_uid_t32 mounted_uid;
-        __kernel_pid_t32 wdog_pid;
+        compat_uid_t mounted_uid;
+        compat_pid_t wdog_pid;
         unsigned char mounted_vol[NCP_VOLNAME_LEN + 1];
         unsigned int time_out;
         unsigned int retry_count;
         unsigned int flags;
-        __kernel_uid_t32 uid;
-        __kernel_gid_t32 gid;
-        __kernel_mode_t32 file_mode;
-        __kernel_mode_t32 dir_mode;
+        compat_uid_t uid;
+        compat_gid_t gid;
+        compat_mode_t file_mode;
+        compat_mode_t dir_mode;
 };
 
 static void *do_ncp_super_data_conv(void *raw_data)
@@ -1551,11 +1459,11 @@
 
 struct smb_mount_data32 {
         int version;
-        __kernel_uid_t32 mounted_uid;
-        __kernel_uid_t32 uid;
-        __kernel_gid_t32 gid;
-        __kernel_mode_t32 file_mode;
-        __kernel_mode_t32 dir_mode;
+        compat_uid_t mounted_uid;
+        compat_uid_t uid;
+        compat_gid_t gid;
+        compat_mode_t file_mode;
+        compat_mode_t dir_mode;
 };
 
 static void *do_smb_super_data_conv(void *raw_data)
@@ -1671,8 +1579,8 @@
 }
 
 struct rusage32 {
-        struct timeval32 ru_utime;
-        struct timeval32 ru_stime;
+        struct compat_timeval ru_utime;
+        struct compat_timeval ru_stime;
         s32    ru_maxrss;
         s32    ru_ixrss;
         s32    ru_idrss;
@@ -1714,7 +1622,7 @@
 	return err;
 }
 
-asmlinkage int sys32_wait4(__kernel_pid_t32 pid, unsigned int *stat_addr, int options, struct rusage32 *ru)
+asmlinkage int sys32_wait4(compat_pid_t pid, unsigned int *stat_addr, int options, struct rusage32 *ru)
 {
 	if (!ru)
 		return sys_wait4(pid, stat_addr, options, NULL);
@@ -1774,14 +1682,10 @@
 	return ret;
 }
 
-struct timespec32 {
-	s32    tv_sec;
-	s32    tv_nsec;
-};
-                
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 
-asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct timespec32 *interval)
+asmlinkage int sys32_sched_rr_get_interval(compat_pid_t pid,
+		struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
@@ -1796,28 +1700,6 @@
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
@@ -1837,7 +1719,7 @@
 
 extern asmlinkage int sys_rt_sigprocmask(int how, sigset_t *set, sigset_t *oset, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigprocmask(int how, sigset_t32 *set, sigset_t32 *oset, __kernel_size_t32 sigsetsize)
+asmlinkage int sys32_rt_sigprocmask(int how, sigset_t32 *set, sigset_t32 *oset, compat_size_t sigsetsize)
 {
 	sigset_t s;
 	sigset_t32 s32;
@@ -1888,7 +1770,7 @@
 
 extern asmlinkage int sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigpending(sigset_t32 *set, __kernel_size_t32 sigsetsize)
+asmlinkage int sys32_rt_sigpending(sigset_t32 *set, compat_size_t sigsetsize)
 {
 	sigset_t s;
 	sigset_t32 s32;
@@ -1916,7 +1798,7 @@
 
 asmlinkage int
 sys32_rt_sigtimedwait(sigset_t32 *uthese, siginfo_t32 *uinfo,
-		      struct timespec32 *uts, __kernel_size_t32 sigsetsize)
+		      struct compat_timespec *uts, compat_size_t sigsetsize)
 {
 	int ret, sig;
 	sigset_t these;
@@ -2015,36 +1897,6 @@
 	return ret;
 }
 
-struct tms32 {
-	__kernel_clock_t32 tms_utime;
-	__kernel_clock_t32 tms_stime;
-	__kernel_clock_t32 tms_cutime;
-	__kernel_clock_t32 tms_cstime;
-};
-                                
-extern asmlinkage long sys_times(struct tms * tbuf);
-
-asmlinkage long sys32_times(struct tms32 *tbuf)
-{
-	struct tms t;
-	long ret;
-	mm_segment_t old_fs = get_fs ();
-	int err;
-	
-	set_fs (KERNEL_DS);
-	ret = sys_times(tbuf ? &t : NULL);
-	set_fs (old_fs);
-	if (tbuf) {
-		err = put_user (t.tms_utime, &tbuf->tms_utime);
-		err |= __put_user (t.tms_stime, &tbuf->tms_stime);
-		err |= __put_user (t.tms_cutime, &tbuf->tms_cutime);
-		err |= __put_user (t.tms_cstime, &tbuf->tms_cstime);
-		if (err)
-			ret = -EFAULT;
-	}
-	return ret;
-}
-
 #define RLIM_OLD_INFINITY32	0x7fffffff
 #define RLIM_INFINITY32		0xffffffff
 #define RESOURCE32_OLD(x)	((x > RLIM_OLD_INFINITY32) ? RLIM_OLD_INFINITY32 : x)
@@ -2136,14 +1988,14 @@
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
@@ -2277,7 +2129,7 @@
 {
 	struct cmsghdr32 *ucmsg;
 	struct cmsghdr *kcmsg, *kcmsg_base;
-	__kernel_size_t32 ucmlen;
+	compat_size_t ucmlen;
 	__kernel_size_t kcmlen, tmp;
 
 	kcmlen = 0;
@@ -2498,12 +2350,12 @@
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
@@ -2746,7 +2598,7 @@
 	err = __put_user(msg_sys.msg_flags, &msg->msg_flags);
 	if (err)
 		goto out_freeiov;
-	err = __put_user((__kernel_size_t32) ((unsigned long)msg_sys.msg_control - cmsg_ptr), &msg->msg_controllen);
+	err = __put_user((compat_size_t) ((unsigned long)msg_sys.msg_control - cmsg_ptr), &msg->msg_controllen);
 	if (err)
 		goto out_freeiov;
 	err = len;
@@ -2848,7 +2700,7 @@
 		struct timeval tmp;
 		mm_segment_t old_fs;
 
-		if (get_tv32(&tmp, (struct timeval32 *)optval ))
+		if (get_tv32(&tmp, (struct compat_timeval *)optval ))
 			return -EFAULT;
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
@@ -3126,7 +2978,7 @@
 }
 
 static int
-qm_modules(char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_modules(char *buf, size_t bufsize, compat_size_t *ret)
 {
 	struct module *mod;
 	size_t nmod, space, len;
@@ -3161,7 +3013,7 @@
 }
 
 static int
-qm_deps(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_deps(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t i, space, len;
 
@@ -3198,7 +3050,7 @@
 }
 
 static int
-qm_refs(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_refs(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t nrefs, space, len;
 	struct module_ref *ref;
@@ -3242,7 +3094,7 @@
 }
 
 static inline int
-qm_symbols(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_symbols(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	size_t i, space, len;
 	struct module_symbol *s;
@@ -3301,7 +3153,7 @@
 }
 
 static inline int
-qm_info(struct module *mod, char *buf, size_t bufsize, __kernel_size_t32 *ret)
+qm_info(struct module *mod, char *buf, size_t bufsize, compat_size_t *ret)
 {
 	int error = 0;
 
@@ -3368,27 +3220,27 @@
 struct nfsctl_export32 {
 	s8			ex32_client[NFSCLNT_IDMAX+1];
 	s8			ex32_path[NFS_MAXPATHLEN+1];
-	__kernel_dev_t32	ex32_dev;
-	__kernel_ino_t32	ex32_ino;
+	compat_dev_t	ex32_dev;
+	compat_ino_t	ex32_ino;
 	s32			ex32_flags;
-	__kernel_uid_t32	ex32_anon_uid;
-	__kernel_gid_t32	ex32_anon_gid;
+	compat_uid_t	ex32_anon_uid;
+	compat_gid_t	ex32_anon_gid;
 };
 
 struct nfsctl_uidmap32 {
 	u32			ug32_ident;   /* char * */
-	__kernel_uid_t32	ug32_uidbase;
+	compat_uid_t	ug32_uidbase;
 	s32			ug32_uidlen;
 	u32			ug32_udimap;  /* uid_t * */
-	__kernel_uid_t32	ug32_gidbase;
+	compat_uid_t	ug32_gidbase;
 	s32			ug32_gidlen;
 	u32			ug32_gdimap;  /* gid_t * */
 };
 
 struct nfsctl_fhparm32 {
 	struct sockaddr		gf32_addr;
-	__kernel_dev_t32	gf32_dev;
-	__kernel_ino_t32	gf32_ino;
+	compat_dev_t	gf32_dev;
+	compat_ino_t	gf32_ino;
 	s32			gf32_version;
 };
 
@@ -3517,7 +3369,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_uidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_udimap[i],
-			      &(((__kernel_uid_t32 *)A(uaddr))[i]));
+			      &(((compat_uid_t *)A(uaddr))[i]));
 	err |= __get_user(karg->ca_umap.ug_gidbase,
 		      &arg32->ca32_umap.ug32_gidbase);
 	err |= __get_user(karg->ca_umap.ug_uidlen,
@@ -3531,7 +3383,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_gidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_gdimap[i],
-			      &(((__kernel_gid_t32 *)A(uaddr))[i]));
+			      &(((compat_gid_t *)A(uaddr))[i]));
 
 	return err;
 }
@@ -3683,7 +3535,7 @@
 extern struct timezone sys_tz;
 extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 
-asmlinkage int sys32_gettimeofday(struct timeval32 *tv, struct timezone *tz)
+asmlinkage int sys32_gettimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	if (tv) {
 		struct timeval ktv;
@@ -3698,7 +3550,7 @@
 	return 0;
 }
 
-asmlinkage int sys32_settimeofday(struct timeval32 *tv, struct timezone *tz)
+asmlinkage int sys32_settimeofday(struct compat_timeval *tv, struct timezone *tz)
 {
 	struct timeval ktv;
 	struct timezone ktz;
@@ -3715,46 +3567,9 @@
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
@@ -3807,34 +3622,32 @@
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
 
 extern asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset, size_t count);
 
-asmlinkage int sys32_sendfile(int out_fd, int in_fd, __kernel_off_t32 *offset, s32 count)
+asmlinkage int sys32_sendfile(int out_fd, int in_fd, compat_off_t *offset, s32 count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -3857,7 +3670,7 @@
 					 loff_t *offset, size_t count);
 
 asmlinkage int sys32_sendfile64(int out_fd, int in_fd, 
-				__kernel_loff_t32 *offset, s32 count)
+				compat_loff_t *offset, s32 count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -3882,7 +3695,7 @@
 	u32 modes;
 	s32 offset, freq, maxerror, esterror;
 	s32 status, constant, precision, tolerance;
-	struct timeval32 time;
+	struct compat_timeval time;
 	s32 tick;
 	s32 ppsfreq, jitter, shift, stabil;
 	s32 jitcnt, calcnt, errcnt, stbcnt;
@@ -4301,7 +4114,7 @@
 extern asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_setaffinity(__kernel_pid_t32 pid, unsigned int len,
+asmlinkage int sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
@@ -4325,7 +4138,7 @@
 extern asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_getaffinity(__kernel_pid_t32 pid, unsigned int len,
+asmlinkage int sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
@@ -4353,7 +4166,7 @@
 
 asmlinkage int
 sys32_futex(void *uaddr, int op, int val, 
-		 struct timespec32 *timeout32)
+		 struct compat_timespec *timeout32)
 {
 	struct timespec tmp;
 	mm_segment_t old_fs;
@@ -4373,9 +4186,9 @@
 
 asmlinkage ssize_t sys_read(unsigned int fd, char * buf, size_t count);
 
-asmlinkage ssize_t32 sys32_read(unsigned int fd, char * buf, size_t count)
+asmlinkage compat_ssize_t sys32_read(unsigned int fd, char * buf, size_t count)
 {
-	if ((ssize_t32) count < 0)
+	if ((compat_ssize_t) count < 0)
 		return -EINVAL; 
 
 	return sys_read(fd, buf, count);
@@ -4383,9 +4196,9 @@
 
 asmlinkage ssize_t sys_write(unsigned int fd, const char * buf, size_t count);
 
-asmlinkage ssize_t32 sys32_write(unsigned int fd, char * buf, size_t count)
+asmlinkage compat_ssize_t sys32_write(unsigned int fd, char * buf, size_t count)
 {
-	if ((ssize_t32) count < 0)
+	if ((compat_ssize_t) count < 0)
 		return -EINVAL; 
 
 	return sys_write(fd, buf, count);
diff -ruN 2.5.53/arch/s390x/kernel/linux32.h 2.5.53-32bit.1/arch/s390x/kernel/linux32.h
--- 2.5.53/arch/s390x/kernel/linux32.h	2002-10-08 12:02:40.000000000 +1000
+++ 2.5.53-32bit.1/arch/s390x/kernel/linux32.h	2002-12-30 16:28:47.000000000 +1100
@@ -2,6 +2,7 @@
 #define _ASM_S390X_S390_H
 
 #include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/socket.h>
 #include <linux/nfs_fs.h>
 #include <linux/sunrpc/svc.h>
@@ -15,26 +16,6 @@
 	((unsigned long)(__x))
 
 /* Now 32bit compatibility types */
-typedef unsigned int           __kernel_size_t32;
-typedef int                    __kernel_ssize_t32;
-typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
-typedef int                    __kernel_clock_t32;
-typedef int                    __kernel_pid_t32;
-typedef unsigned short         __kernel_ipc_pid_t32;
-typedef unsigned short         __kernel_uid_t32;
-typedef unsigned short         __kernel_gid_t32;
-typedef unsigned short         __kernel_dev_t32;
-typedef unsigned int           __kernel_ino_t32;
-typedef unsigned short         __kernel_mode_t32;
-typedef unsigned short         __kernel_umode_t32;
-typedef short                  __kernel_nlink_t32;
-typedef int                    __kernel_daddr_t32;
-typedef int                    __kernel_off_t32;
-typedef unsigned int           __kernel_caddr_t32;
-typedef long                   __kernel_loff_t32;
-typedef __kernel_fsid_t        __kernel_fsid_t32;  
-
 struct ipc_kludge_32 {
         __u32   msgp;                           /* pointer              */
         __s32   msgtyp;
@@ -47,35 +28,12 @@
 struct flock32 {
         short l_type;
         short l_whence;
-        __kernel_off_t32 l_start;
-        __kernel_off_t32 l_len;
-        __kernel_pid_t32 l_pid;
+        compat_off_t l_start;
+        compat_off_t l_len;
+        compat_pid_t l_pid;
         short __unused;
 }; 
 
-struct stat32 {
-	unsigned short	st_dev;
-	unsigned short	__pad1;
-	__u32		st_ino;
-	unsigned short	st_mode;
-	unsigned short	st_nlink;
-	unsigned short	st_uid;
-	unsigned short	st_gid;
-	unsigned short	st_rdev;
-	unsigned short	__pad2;
-	__u32		st_size;
-	__u32		st_blksize;
-	__u32		st_blocks;
-	__u32		st_atime;
-	__u32		__unused1;
-	__u32		st_mtime;
-	__u32		__unused2;
-	__u32		st_ctime;
-	__u32		__unused3;
-	__u32		__unused4;
-	__u32		__unused5;
-};
-
 struct statfs32 {
 	__s32			f_type;
 	__s32			f_bsize;
@@ -141,8 +99,8 @@
 			pid_t			_pid;	/* which child */
 			uid_t			_uid;	/* sender's uid */
 			int			_status;/* exit code */
-			__kernel_clock_t32	_utime;
-			__kernel_clock_t32	_stime;
+			compat_clock_t		_utime;
+			compat_clock_t		_stime;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
@@ -253,7 +211,7 @@
 typedef struct {
 	__u32			ss_sp;		/* pointer */
 	int			ss_flags;
-	__kernel_size_t32	ss_size;
+	compat_size_t		ss_size;
 } stack_t32;
 
 /* asm/ucontext.h */
diff -ruN 2.5.53/arch/s390x/kernel/wrapper32.S 2.5.53-32bit.1/arch/s390x/kernel/wrapper32.S
--- 2.5.53/arch/s390x/kernel/wrapper32.S	2002-11-28 10:34:42.000000000 +1100
+++ 2.5.53-32bit.1/arch/s390x/kernel/wrapper32.S	2002-12-16 14:51:53.000000000 +1100
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
@@ -182,10 +182,10 @@
 	llgtr	%r2,%r2			# u32 *
 	jg	sys_pipe		# branch to system call
 
-	.globl  sys32_times_wrapper 
-sys32_times_wrapper:
-	llgtr	%r2,%r2			# struct tms_emu31 *
-	jg	sys32_times		# branch to system call
+	.globl  compat_sys_times_wrapper 
+compat_sys_times_wrapper:
+	llgtr	%r2,%r2			# struct compat_tms *
+	jg	compat_sys_times	# branch to system call
 
 	.globl  sys32_brk_wrapper 
 sys32_brk_wrapper:
@@ -465,36 +465,36 @@
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
+	jg	compat_sys_setitimer	# branch to system call
 
-	.globl  sys32_getitimer_wrapper 
-sys32_getitimer_wrapper:
+	.globl  compat_sys_getitimer_wrapper 
+compat_sys_getitimer_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# struct itimerval_emu31 *
-	jg	sys32_getitimer		# branch to system call
+	jg	compat_sys_getitimer	# branch to system call
 
-	.globl  sys32_newstat_wrapper 
-sys32_newstat_wrapper:
+	.globl  compat_sys_newstat_wrapper 
+compat_sys_newstat_wrapper:
 	llgtr	%r2,%r2			# char *
 	llgtr	%r3,%r3			# struct stat_emu31 *
-	jg	sys32_newstat		# branch to system call
+	jg	compat_sys_newstat	# branch to system call
 
-	.globl  sys32_newlstat_wrapper 
-sys32_newlstat_wrapper:
+	.globl  compat_sys_newlstat_wrapper 
+compat_sys_newlstat_wrapper:
 	llgtr	%r2,%r2			# char *
 	llgtr	%r3,%r3			# struct stat_emu31 *
-	jg	sys32_newlstat		# branch to system call
+	jg	compat_sys_newlstat	# branch to system call
 
-	.globl  sys32_newfstat_wrapper 
-sys32_newfstat_wrapper:
+	.globl  compat_sys_newfstat_wrapper 
+compat_sys_newfstat_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# struct stat_emu31 *
-	jg	sys32_newfstat		# branch to system call
+	jg	compat_sys_newfstat	# branch to system call
 
 #sys32_vhangup_wrapper			# void 
 
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
 
diff -ruN 2.5.53/include/asm-s390x/compat.h 2.5.53-32bit.1/include/asm-s390x/compat.h
--- 2.5.53/include/asm-s390x/compat.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.53-32bit.1/include/asm-s390x/compat.h	2002-12-30 16:28:37.000000000 +1100
@@ -0,0 +1,61 @@
+#ifndef _ASM_S390X_COMPAT_H
+#define _ASM_S390X_COMPAT_H
+/*
+ * Architecture specific compatibility types
+ */
+#include <linux/types.h>
+
+#define COMPAT_USER_HZ	100
+
+typedef u32		compat_size_t;
+typedef s32		compat_ssize_t;
+typedef s32		compat_time_t;
+typedef s32		compat_clock_t;
+typedef s32		compat_pid_t;
+typedef u16		compat_uid_t;
+typedef u16		compat_gid_t;
+typedef u16		compat_mode_t;
+typedef u32		compat_ino_t;
+typedef u16		compat_dev_t;
+typedef s32		compat_off_t;
+typedef s64		compat_loff_t;
+typedef u16		compat_nlink_t;
+typedef u16		compat_ipc_pid_t;
+typedef s32		compat_daddr_t;
+typedef u32		compat_caddr_t;
+typedef __kernel_fsid_t	compat_fsid_t;
+
+struct compat_timespec {
+	compat_time_t	tv_sec;
+	s32		tv_nsec;
+};
+
+struct compat_timeval {
+	compat_time_t	tv_sec;
+	s32		tv_usec;
+};
+
+struct compat_stat {
+	compat_dev_t	st_dev;
+	u16		__pad1;
+	compat_ino_t	st_ino;
+	compat_mode_t	st_mode;
+	compat_nlink_t	st_nlink;
+	compat_uid_t	st_uid;
+	compat_gid_t	st_gid;
+	compat_dev_t	st_rdev;
+	u16		__pad2;
+	u32		st_size;
+	u32		st_blksize;
+	u32		st_blocks;
+	u32		st_atime;
+	u32		__unused1;
+	u32		st_mtime;
+	u32		__unused2;
+	u32		st_ctime;
+	u32		__unused3;
+	u32		__unused4;
+	u32		__unused5;
+};
+
+#endif /* _ASM_S390X_COMPAT_H */
