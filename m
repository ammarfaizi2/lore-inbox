Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbTBLEYQ>; Tue, 11 Feb 2003 23:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTBLEYQ>; Tue, 11 Feb 2003 23:24:16 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:36539 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266805AbTBLEYB>;
	Tue, 11 Feb 2003 23:24:01 -0500
Date: Wed, 12 Feb 2003 15:33:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] outstanding compatibility changes 2/4 parisc
Message-Id: <20030212153327.2270dc06.sfr@canb.auug.org.au>
In-Reply-To: <20030212152927.77384c95.sfr@canb.auug.org.au>
References: <20030212152927.77384c95.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

Here are the outstanding compatibility patches I have for mips64 against
2.5.60.  Will you merge these, or should I just send them to Linus?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60/arch/mips64/kernel/ioctl32.c 2.5.60-32bit.1/arch/mips64/kernel/ioctl32.c
--- 2.5.60/arch/mips64/kernel/ioctl32.c	2003-01-15 11:20:31.000000000 +1100
+++ 2.5.60-32bit.1/arch/mips64/kernel/ioctl32.c	2003-02-11 12:21:29.000000000 +1100
@@ -116,13 +116,13 @@
                 struct  ifmap32 ifru_map;
                 char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
 		char	ifru_newname[IFNAMSIZ];
-                __kernel_caddr_t32 ifru_data;
+                compat_caddr_t ifru_data;
         } ifr_ifru;
 };
 
 struct ifconf32 {
         int     ifc_len;                        /* size of buffer       */
-        __kernel_caddr_t32  ifcbuf;
+        compat_caddr_t  ifcbuf;
 };
 
 #ifdef CONFIG_NET
@@ -433,8 +433,8 @@
 	__u32	mt_dsreg;
 	__u32	mt_gstat;
 	__u32	mt_erreg;
-	__kernel_daddr_t32	mt_fileno;
-	__kernel_daddr_t32	mt_blkno;
+	compat_daddr_t	mt_fileno;
+	compat_daddr_t	mt_blkno;
 };
 #define MTIOCGET32	_IOR('m', 2, struct mtget32)
 
diff -ruN 2.5.60/arch/mips64/kernel/linux32.c 2.5.60-32bit.1/arch/mips64/kernel/linux32.c
--- 2.5.60/arch/mips64/kernel/linux32.c	2003-01-02 15:13:45.000000000 +1100
+++ 2.5.60-32bit.1/arch/mips64/kernel/linux32.c	2003-02-11 12:21:29.000000000 +1100
@@ -41,9 +41,9 @@
  * Revalidate the inode. This is required for proper NFS attribute caching.
  */
 
-static int cp_new_stat32(struct kstat *stat, struct stat32 *statbuf)
+int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
 {
-	struct stat32 tmp;
+	struct compat_stat tmp;
 
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.st_dev = stat->dev;
@@ -62,39 +62,6 @@
 	return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
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
-asmlinkage long sys32_newfstat(unsigned int fd, struct stat32 * statbuf)
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
 asmlinkage int sys_mmap2(void) {return 0;}
 
 asmlinkage long sys_truncate(const char * path, unsigned long length);
@@ -480,7 +447,7 @@
 }
 
 asmlinkage int
-sys32_wait4(__kernel_pid_t32 pid, unsigned int * stat_addr, int options,
+sys32_wait4(compat_pid_t pid, unsigned int * stat_addr, int options,
 	    struct rusage32 * ru)
 {
 	if (!ru)
@@ -502,7 +469,7 @@
 }
 
 asmlinkage int
-sys32_waitpid(__kernel_pid_t32 pid, unsigned int *stat_addr, int options)
+sys32_waitpid(compat_pid_t pid, unsigned int *stat_addr, int options)
 {
 	return sys32_wait4(pid, stat_addr, options, NULL);
 }
@@ -557,72 +524,6 @@
 	return ret;
 }
 
-struct statfs32 {
-	int	f_type;
-	int	f_bsize;
-	int	f_frsize;
-	int	f_blocks;
-	int	f_bfree;
-	int	f_files;
-	int	f_ffree;
-	int	f_bavail;
-	__kernel_fsid_t32	f_fsid;
-	int	f_namelen;
-	int	f_spare[6];
-};
-
-static inline int
-put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)
-{
-	int err;
-	
-	err = put_user (kbuf->f_type, &ubuf->f_type);
-	err |= __put_user (kbuf->f_bsize, &ubuf->f_bsize);
-	err |= __put_user (kbuf->f_blocks, &ubuf->f_blocks);
-	err |= __put_user (kbuf->f_bfree, &ubuf->f_bfree);
-	err |= __put_user (kbuf->f_bavail, &ubuf->f_bavail);
-	err |= __put_user (kbuf->f_files, &ubuf->f_files);
-	err |= __put_user (kbuf->f_ffree, &ubuf->f_ffree);
-	err |= __put_user (kbuf->f_namelen, &ubuf->f_namelen);
-	err |= __put_user (kbuf->f_fsid.val[0], &ubuf->f_fsid.val[0]);
-	err |= __put_user (kbuf->f_fsid.val[1], &ubuf->f_fsid.val[1]);
-	return err;
-}
-
-extern asmlinkage int sys_statfs(const char * path, struct statfs * buf);
-
-asmlinkage int
-sys32_statfs(const char * path, struct statfs32 *buf)
-{
-	int ret;
-	struct statfs s;
-	mm_segment_t old_fs = get_fs();
-	
-	set_fs (KERNEL_DS);
-	ret = sys_statfs((const char *)path, &s);
-	set_fs (old_fs);
-	if (put_statfs(buf, &s))
-		return -EFAULT;
-	return ret;
-}
-
-extern asmlinkage int sys_fstatfs(unsigned int fd, struct statfs * buf);
-
-asmlinkage int
-sys32_fstatfs(unsigned int fd, struct statfs32 *buf)
-{
-	int ret;
-	struct statfs s;
-	mm_segment_t old_fs = get_fs();
-	
-	set_fs (KERNEL_DS);
-	ret = sys_fstatfs(fd, &s);
-	set_fs (old_fs);
-	if (put_statfs(buf, &s))
-		return -EFAULT;
-	return ret;
-}
-
 extern asmlinkage int
 sys_getrusage(int who, struct rusage *ru);
 
@@ -1110,7 +1011,7 @@
 						struct timespec *interval);
 
 asmlinkage int
-sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct compat_timespec *interval)
+sys32_sched_rr_get_interval(compat_pid_t pid, struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
@@ -1119,42 +1020,12 @@
 	set_fs (KERNEL_DS);
 	ret = sys_sched_rr_get_interval(pid, &t);
 	set_fs (old_fs);
-	if (put_user (t.tv_sec, &interval->tv_sec) ||
-	    __put_user (t.tv_nsec, &interval->tv_nsec))
+	if (put_compat_timespec(&t, interval))
 		return -EFAULT;
 	return ret;
 }
 
 
-struct tms32 {
-	int tms_utime;
-	int tms_stime;
-	int tms_cutime;
-	int tms_cstime;
-};
-
-extern asmlinkage long sys_times(struct tms * tbuf);
-asmlinkage long sys32_times(struct tms32 *tbuf)
-{
-	struct tms t;
-	long ret;
-	mm_segment_t old_fs = get_fs();
-	int err;
-
-	set_fs(KERNEL_DS);
-	ret = sys_times(tbuf ? &t : NULL);
-	set_fs(old_fs);
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
 extern asmlinkage int sys_setsockopt(int fd, int level, int optname,
 				     char *optval, int optlen);
 
@@ -1197,39 +1068,6 @@
 	return sys_setsockopt(fd, level, optname, optval, optlen);
 }
 
-struct flock32 {
-	short l_type;
-	short l_whence;
-	__kernel_off_t32 l_start;
-	__kernel_off_t32 l_len;
-	__kernel_pid_t32 l_pid;
-	short __unused;
-};
-
-static inline int get_flock(struct flock *kfl, struct flock32 *ufl)
-{
-	int err;
-	
-	err = get_user(kfl->l_type, &ufl->l_type);
-	err |= __get_user(kfl->l_whence, &ufl->l_whence);
-	err |= __get_user(kfl->l_start, &ufl->l_start);
-	err |= __get_user(kfl->l_len, &ufl->l_len);
-	err |= __get_user(kfl->l_pid, &ufl->l_pid);
-	return err;
-}
-
-static inline int put_flock(struct flock *kfl, struct flock32 *ufl)
-{
-	int err;
-	
-	err = __put_user(kfl->l_type, &ufl->l_type);
-	err |= __put_user(kfl->l_whence, &ufl->l_whence);
-	err |= __put_user(kfl->l_start, &ufl->l_start);
-	err |= __put_user(kfl->l_len, &ufl->l_len);
-	err |= __put_user(kfl->l_pid, &ufl->l_pid);
-	return err;
-}
-
 extern asmlinkage long
 sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
 
@@ -1245,12 +1083,12 @@
 			mm_segment_t old_fs;
 			long ret;
 			
-			if (get_flock(&f, (struct flock32 *)arg))
+			if (get_compat_flock(&f, (struct compat_flock *)arg))
 				return -EFAULT;
 			old_fs = get_fs(); set_fs (KERNEL_DS);
 			ret = sys_fcntl(fd, cmd, (unsigned long)&f);
 			set_fs (old_fs);
-			if (put_flock(&f, (struct flock32 *)arg))
+			if (put_compat_flock(&f, (struct compat_flock *)arg))
 				return -EFAULT;
 			return ret;
 		}
@@ -1279,11 +1117,11 @@
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
 
@@ -1311,8 +1149,8 @@
         unsigned short msg_cbytes;
         unsigned short msg_qnum;  
         unsigned short msg_qbytes;
-        __kernel_ipc_pid_t32 msg_lspid;
-        __kernel_ipc_pid_t32 msg_lrpid;
+        compat_ipc_pid_t msg_lspid;
+        compat_ipc_pid_t msg_lrpid;
 };
 
 struct shmid_ds32 {
@@ -1321,8 +1159,8 @@
         compat_time_t         shm_atime;
         compat_time_t         shm_dtime;
         compat_time_t         shm_ctime;
-        __kernel_ipc_pid_t32    shm_cpid; 
-        __kernel_ipc_pid_t32    shm_lpid; 
+        compat_ipc_pid_t    shm_cpid; 
+        compat_ipc_pid_t    shm_lpid; 
         unsigned short          shm_nattch;
 };
 
@@ -1685,11 +1523,11 @@
 
 struct sysctl_args32
 {
-	__kernel_caddr_t32 name;
+	compat_caddr_t name;
 	int nlen;
-	__kernel_caddr_t32 oldval;
-	__kernel_caddr_t32 oldlenp;
-	__kernel_caddr_t32 newval;
+	compat_caddr_t oldval;
+	compat_caddr_t oldlenp;
+	compat_caddr_t newval;
 	compat_size_t newlen;
 	unsigned int __unused[4];
 };
diff -ruN 2.5.60/arch/mips64/kernel/scall_o32.S 2.5.60-32bit.1/arch/mips64/kernel/scall_o32.S
--- 2.5.60/arch/mips64/kernel/scall_o32.S	2002-12-16 14:49:47.000000000 +1100
+++ 2.5.60-32bit.1/arch/mips64/kernel/scall_o32.S	2003-02-11 12:21:29.000000000 +1100
@@ -276,7 +276,7 @@
 	sys	sys_rmdir	1			/* 4040 */
 	sys	sys_dup		1
 	sys	sys_pipe	0
-	sys	sys32_times	1
+	sys	compat_sys_times	1
 	sys	sys_ni_syscall	0
 	sys	sys_brk		1			/* 4045 */
 	sys	sys_setgid	1
@@ -306,7 +306,7 @@
 	sys	sys_setreuid	2			/* 4070 */
 	sys	sys_setregid	2
 	sys	sys32_sigsuspend	0
-	sys	sys32_sigpending	1
+	sys	compat_sys_sigpending	1
 	sys	sys_sethostname	2
 	sys	sys32_setrlimit	2			/* 4075 */
 	sys	sys32_getrlimit	2
@@ -332,16 +332,16 @@
 	sys	sys_getpriority	2
 	sys	sys_setpriority	3
 	sys	sys_ni_syscall	0
-	sys	sys32_statfs	2
-	sys	sys32_fstatfs	2			/* 4100 */
+	sys	compat_sys_statfs	2
+	sys	compat_sys_fstatfs	2			/* 4100 */
 	sys	sys_ni_syscall	0	/* sys_ioperm */
 	sys	sys_socketcall	2
 	sys	sys_syslog	3
 	sys	compat_sys_setitimer	3
 	sys	compat_sys_getitimer	2			/* 4105 */
-	sys	sys32_newstat	2
-	sys	sys32_newlstat	2
-	sys	sys32_newfstat	2
+	sys	compat_sys_newstat	2
+	sys	compat_sys_newlstat	2
+	sys	compat_sys_newfstat	2
 	sys	sys_ni_syscall	0	/* was sys_uname */
 	sys	sys_ni_syscall	0	/* sys_ioperm  *//* 4110 */
 	sys	sys_vhangup	0
@@ -359,7 +359,7 @@
 	sys	sys_ni_syscall	0	/* sys_modify_ldt */
 	sys	sys32_adjtimex	1
 	sys	sys_mprotect	3			/* 4125 */
-	sys	sys32_sigprocmask	3
+	sys	compat_sys_sigprocmask	3
 	sys	sys_create_module 2
 	sys	sys_init_module	5
 	sys	sys_delete_module 1
diff -ruN 2.5.60/arch/mips64/kernel/signal32.c 2.5.60-32bit.1/arch/mips64/kernel/signal32.c
--- 2.5.60/arch/mips64/kernel/signal32.c	2003-01-02 15:13:45.000000000 +1100
+++ 2.5.60-32bit.1/arch/mips64/kernel/signal32.c	2003-02-11 12:21:29.000000000 +1100
@@ -39,20 +39,13 @@
 
 /* 32-bit compatibility types */
 
-#define _NSIG32_BPW	32
-#define _NSIG32_WORDS	(_NSIG / _NSIG32_BPW)
-
-typedef struct {
-	unsigned int sig[_NSIG32_WORDS];
-} sigset32_t;
-
 typedef unsigned int __sighandler32_t;
 typedef void (*vfptr_t)(void);
 
 struct sigaction32 {
 	unsigned int		sa_flags;
 	__sighandler32_t	sa_handler;
-	sigset32_t		sa_mask;
+	compat_sigset_t		sa_mask;
 	unsigned int		sa_restorer;
 	int			sa_resv[1];     /* reserved */
 };
@@ -98,7 +91,7 @@
 extern void __get_sigset_unknown_nsig(void);
 
 static inline int
-put_sigset(const sigset_t *kbuf, sigset32_t *ubuf)
+put_sigset(const sigset_t *kbuf, compat_sigset_t *ubuf)
 {
 	int err = 0;
 
@@ -120,7 +113,7 @@
 }
 
 static inline int
-get_sigset(sigset_t *kbuf, const sigset32_t *ubuf)
+get_sigset(sigset_t *kbuf, const compat_sigset_t *ubuf)
 {
 	int err = 0;
 	unsigned long sig[4];
@@ -150,11 +143,11 @@
 asmlinkage inline int
 sys32_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
-	sigset32_t *uset;
+	compat_sigset_t *uset;
 	sigset_t newset, saveset;
 
 	save_static(&regs);
-	uset = (sigset32_t *) regs.regs[4];
+	uset = (compat_sigset_t *) regs.regs[4];
 	if (get_sigset(&newset, uset))
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
@@ -178,17 +171,17 @@
 asmlinkage int
 sys32_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
-	sigset32_t *uset;
+	compat_sigset_t *uset;
 	sigset_t newset, saveset;
         size_t sigsetsize;
 
 	save_static(&regs);
 	/* XXX Don't preclude handling different sized sigset_t's.  */
 	sigsetsize = regs.regs[5];
-	if (sigsetsize != sizeof(sigset32_t))
+	if (sigsetsize != sizeof(compat_sigset_t))
 		return -EINVAL;
 
-	uset = (sigset32_t *) regs.regs[4];
+	uset = (compat_sigset_t *) regs.regs[4];
 	if (get_sigset(&newset, uset))
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
@@ -701,44 +694,6 @@
 	return 0;
 }
 
-extern asmlinkage int sys_sigprocmask(int how, old_sigset_t *set,
-						old_sigset_t *oset);
-
-asmlinkage int sys32_sigprocmask(int how, old_sigset_t32 *set, 
-				 old_sigset_t32 *oset)
-{
-	old_sigset_t s;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	if (set && get_user (s, set))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_sigprocmask(how, set ? &s : NULL, oset ? &s : NULL);
-	set_fs (old_fs);
-	if (!ret && oset && put_user (s, oset))
-		return -EFAULT;
-	return ret;
-}
-
-asmlinkage long sys_sigpending(old_sigset_t *set);
-
-asmlinkage int sys32_sigpending(old_sigset_t32 *set)
-{
-	old_sigset_t pending;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs (KERNEL_DS);
-	ret = sys_sigpending(&pending);
-	set_fs (old_fs);
-
-	if (put_user(pending, set))
-		return -EFAULT;
-
-	return ret;
-}
-
 asmlinkage int sys32_rt_sigaction(int sig, const struct sigaction32 *act,
 				  struct sigaction32 *oact,
 				  unsigned int sigsetsize)
@@ -789,7 +744,7 @@
 asmlinkage long sys_rt_sigprocmask(int how, sigset_t *set, sigset_t *oset,
 				   size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigprocmask(int how, sigset32_t *set, sigset32_t *oset,
+asmlinkage int sys32_rt_sigprocmask(int how, compat_sigset_t *set, compat_sigset_t *oset,
 				    unsigned int sigsetsize)
 {
 	sigset_t old_set, new_set;
@@ -812,7 +767,7 @@
 
 asmlinkage long sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
-asmlinkage int sys32_rt_sigpending(sigset32_t *uset, unsigned int sigsetsize)
+asmlinkage int sys32_rt_sigpending(compat_sigset_t *uset, unsigned int sigsetsize)
 {
 	int ret;
 	sigset_t set;
diff -ruN 2.5.60/include/asm-mips64/compat.h 2.5.60-32bit.1/include/asm-mips64/compat.h
--- 2.5.60/include/asm-mips64/compat.h	2002-12-16 14:49:54.000000000 +1100
+++ 2.5.60-32bit.1/include/asm-mips64/compat.h	2003-02-11 12:21:29.000000000 +1100
@@ -5,14 +5,86 @@
  */
 #include <linux/types.h>
 
+#define COMPAT_USER_HZ	100
+
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
-typedef s32		compat_suseconds_t;
+typedef s32		compat_clock_t;
+typedef s32		compat_pid_t;
+typedef s32		compat_uid_t;
+typedef s32		compat_gid_t;
+typedef u32		compat_mode_t;
+typedef u32		compat_ino_t;
+typedef u32		compat_dev_t;
+typedef s32		compat_off_t;
+typedef u32		compat_nlink_t;
+typedef s32		compat_ipc_pid_t;
+typedef s32		compat_daddr_t;
+typedef u32		compat_caddr_t;
+typedef __kernel_fsid_t	compat_fsid_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
 	s32		tv_nsec;
 };
 
+struct compat_timeval {
+	compat_time_t	tv_sec;
+	s32		tv_usec;
+};
+
+struct compat_stat {
+	compat_dev_t	st_dev;
+	s32		st_pad1[3];
+	compat_ino_t	st_ino;
+	compat_mode_t	st_mode;
+	compat_nlink_t	st_nlink;
+	compat_uid_t	st_uid;
+	compat_gid_t	st_gid;
+	compat_dev_t	st_rdev;
+	s32		st_pad2[2];
+	compat_off_t	st_size;
+	s32		st_pad3;
+	compat_time_t	st_atime;
+	s32		reserved0;
+	compat_time_t	st_mtime;
+	s32		reserved1;
+	compat_time_t	st_ctime;
+	s32		reserved2;
+	s32		st_blksize;
+	s32		st_blocks;
+	s32		st_pad4[14];
+};
+
+struct compat_flock {
+	short		l_type;
+	short		l_whence;
+	compat_off_t	l_start;
+	compat_off_t	l_len;
+	compat_pid_t	l_pid;
+	short		__unused;
+};
+
+struct compat_statfs {
+	int		f_type;
+	int		f_bsize;
+	int		f_frsize;
+	int		f_blocks;
+	int		f_bfree;
+	int		f_files;
+	int		f_ffree;
+	int		f_bavail;
+	compat_fsid_t	f_fsid;
+	int		f_namelen;
+	int		f_spare[6];
+};
+
+typedef u32		compat_old_sigset_t;
+
+#define _COMPAT_NSIG		128
+#define _COMPAT_NSIG_BPW	32
+
+typedef u32		compat_sigset_word;
+
 #endif /* _ASM_MIPS64_COMPAT_H */
diff -ruN 2.5.60/include/asm-mips64/posix_types.h 2.5.60-32bit.1/include/asm-mips64/posix_types.h
--- 2.5.60/include/asm-mips64/posix_types.h	2002-12-16 14:49:54.000000000 +1100
+++ 2.5.60-32bit.1/include/asm-mips64/posix_types.h	2003-02-11 12:21:29.000000000 +1100
@@ -48,23 +48,6 @@
         int    val[2];
 } __kernel_fsid_t;
 
-/* Now 32bit compatibility types */
-typedef unsigned int	__kernel_dev_t32;
-typedef unsigned int	__kernel_ino_t32;
-typedef unsigned int	__kernel_mode_t32;
-typedef unsigned int	__kernel_nlink_t32;
-typedef int		__kernel_off_t32;
-typedef int		__kernel_pid_t32;
-typedef int		__kernel_ipc_pid_t32;
-typedef int		__kernel_uid_t32;
-typedef int		__kernel_gid_t32;
-typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_suseconds_t32;
-typedef int		__kernel_clock_t32;
-typedef int		__kernel_daddr_t32;
-typedef unsigned int	__kernel_caddr_t32;
-typedef __kernel_fsid_t	__kernel_fsid_t32;
-
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
 #undef __FD_SET
diff -ruN 2.5.60/include/asm-mips64/signal.h 2.5.60-32bit.1/include/asm-mips64/signal.h
--- 2.5.60/include/asm-mips64/signal.h	2003-02-11 09:39:59.000000000 +1100
+++ 2.5.60-32bit.1/include/asm-mips64/signal.h	2003-02-11 12:21:29.000000000 +1100
@@ -20,7 +20,6 @@
 } sigset_t;
 
 typedef unsigned long old_sigset_t;		/* at least 32 bits */
-typedef unsigned int old_sigset_t32;
 
 #define SIGHUP		 1	/* Hangup (POSIX).  */
 #define SIGINT		 2	/* Interrupt (ANSI).  */
diff -ruN 2.5.60/include/asm-mips64/stat.h 2.5.60-32bit.1/include/asm-mips64/stat.h
--- 2.5.60/include/asm-mips64/stat.h	2002-12-16 14:49:54.000000000 +1100
+++ 2.5.60-32bit.1/include/asm-mips64/stat.h	2003-02-11 12:21:29.000000000 +1100
@@ -10,7 +10,6 @@
 #define _ASM_STAT_H
 
 #include <linux/types.h>
-#include <linux/compat.h>
 
 struct __old_kernel_stat {
 	unsigned int	st_dev;
@@ -29,29 +28,6 @@
 	unsigned int	st_unused[2];
 };
 
-struct stat32 {
-	__kernel_dev_t32    st_dev;
-	int		    st_pad1[3];
-	__kernel_ino_t32    st_ino;
-	__kernel_mode_t32   st_mode;
-	__kernel_nlink_t32  st_nlink;
-	__kernel_uid_t32    st_uid;
-	__kernel_gid_t32    st_gid;
-	__kernel_dev_t32    st_rdev;
-	int		    st_pad2[2];
-	__kernel_off_t32    st_size;
-	int		    st_pad3;
-	compat_time_t     st_atime;
-	int		    reserved0;
-	compat_time_t     st_mtime;
-	int		    reserved1;
-	compat_time_t     st_ctime;
-	int		    reserved2;
-	int		    st_blksize;
-	int		    st_blocks;
-	int		    st_pad4[14];
-};
-
 /* The memory layout is the same as of struct stat64 of the 32-bit kernel.  */
 struct stat {
 	dev_t		st_dev;
