Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266792AbSL3Gfw>; Mon, 30 Dec 2002 01:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbSL3Gfw>; Mon, 30 Dec 2002 01:35:52 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:60074 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266792AbSL3Gfl>;
	Mon, 30 Dec 2002 01:35:41 -0500
Date: Mon, 30 Dec 2002 17:43:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] Eliminate the rest of the __kernel_..._t32 typedefs
 6/7 MIPS64
Message-Id: <20021230174359.3ab49ddc.sfr@canb.auug.org.au>
In-Reply-To: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
References: <20021230171959.63ea2d5d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

MIPS64 specific stuff ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.53/arch/mips64/kernel/ioctl32.c 2.5.53-32bit.1/arch/mips64/kernel/ioctl32.c
--- 2.5.53/arch/mips64/kernel/ioctl32.c	2002-12-16 14:49:47.000000000 +1100
+++ 2.5.53-32bit.1/arch/mips64/kernel/ioctl32.c	2002-12-30 15:37:15.000000000 +1100
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
 
diff -ruN 2.5.53/arch/mips64/kernel/linux32.c 2.5.53-32bit.1/arch/mips64/kernel/linux32.c
--- 2.5.53/arch/mips64/kernel/linux32.c	2002-12-16 14:49:47.000000000 +1100
+++ 2.5.53-32bit.1/arch/mips64/kernel/linux32.c	2002-12-30 16:28:24.000000000 +1100
@@ -40,9 +40,9 @@
  * Revalidate the inode. This is required for proper NFS attribute caching.
  */
 
-static int cp_new_stat32(struct kstat *stat, struct stat32 *statbuf)
+int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
 {
-	struct stat32 tmp;
+	struct compat_stat tmp;
 
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.st_dev = stat->dev;
@@ -61,39 +61,6 @@
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
@@ -479,7 +446,7 @@
 }
 
 asmlinkage int
-sys32_wait4(__kernel_pid_t32 pid, unsigned int * stat_addr, int options,
+sys32_wait4(compat_pid_t pid, unsigned int * stat_addr, int options,
 	    struct rusage32 * ru)
 {
 	if (!ru)
@@ -501,7 +468,7 @@
 }
 
 asmlinkage int
-sys32_waitpid(__kernel_pid_t32 pid, unsigned int *stat_addr, int options)
+sys32_waitpid(compat_pid_t pid, unsigned int *stat_addr, int options)
 {
 	return sys32_wait4(pid, stat_addr, options, NULL);
 }
@@ -565,7 +532,7 @@
 	int	f_files;
 	int	f_ffree;
 	int	f_bavail;
-	__kernel_fsid_t32	f_fsid;
+	compat_fsid_t	f_fsid;
 	int	f_namelen;
 	int	f_spare[6];
 };
@@ -1109,7 +1076,7 @@
 						struct timespec *interval);
 
 asmlinkage int
-sys32_sched_rr_get_interval(__kernel_pid_t32 pid, struct compat_timespec *interval)
+sys32_sched_rr_get_interval(compat_pid_t pid, struct compat_timespec *interval)
 {
 	struct timespec t;
 	int ret;
@@ -1125,35 +1092,6 @@
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
 
@@ -1199,9 +1137,9 @@
 struct flock32 {
 	short l_type;
 	short l_whence;
-	__kernel_off_t32 l_start;
-	__kernel_off_t32 l_len;
-	__kernel_pid_t32 l_pid;
+	compat_off_t l_start;
+	compat_off_t l_len;
+	compat_pid_t l_pid;
 	short __unused;
 };
 
@@ -1278,11 +1216,11 @@
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
 
@@ -1310,8 +1248,8 @@
         unsigned short msg_cbytes;
         unsigned short msg_qnum;  
         unsigned short msg_qbytes;
-        __kernel_ipc_pid_t32 msg_lspid;
-        __kernel_ipc_pid_t32 msg_lrpid;
+        compat_ipc_pid_t msg_lspid;
+        compat_ipc_pid_t msg_lrpid;
 };
 
 struct shmid_ds32 {
@@ -1320,8 +1258,8 @@
         compat_time_t         shm_atime;
         compat_time_t         shm_dtime;
         compat_time_t         shm_ctime;
-        __kernel_ipc_pid_t32    shm_cpid; 
-        __kernel_ipc_pid_t32    shm_lpid; 
+        compat_ipc_pid_t    shm_cpid; 
+        compat_ipc_pid_t    shm_lpid; 
         unsigned short          shm_nattch;
 };
 
@@ -1684,11 +1622,11 @@
 
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
diff -ruN 2.5.53/arch/mips64/kernel/scall_o32.S 2.5.53-32bit.1/arch/mips64/kernel/scall_o32.S
--- 2.5.53/arch/mips64/kernel/scall_o32.S	2002-12-16 14:49:47.000000000 +1100
+++ 2.5.53-32bit.1/arch/mips64/kernel/scall_o32.S	2002-12-16 14:51:53.000000000 +1100
@@ -276,7 +276,7 @@
 	sys	sys_rmdir	1			/* 4040 */
 	sys	sys_dup		1
 	sys	sys_pipe	0
-	sys	sys32_times	1
+	sys	compat_sys_times	1
 	sys	sys_ni_syscall	0
 	sys	sys_brk		1			/* 4045 */
 	sys	sys_setgid	1
@@ -339,9 +339,9 @@
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
diff -ruN 2.5.53/include/asm-mips64/compat.h 2.5.53-32bit.1/include/asm-mips64/compat.h
--- 2.5.53/include/asm-mips64/compat.h	2002-12-16 14:49:54.000000000 +1100
+++ 2.5.53-32bit.1/include/asm-mips64/compat.h	2002-12-30 16:24:38.000000000 +1100
@@ -5,14 +5,56 @@
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
 #endif /* _ASM_MIPS64_COMPAT_H */
diff -ruN 2.5.53/include/asm-mips64/posix_types.h 2.5.53-32bit.1/include/asm-mips64/posix_types.h
--- 2.5.53/include/asm-mips64/posix_types.h	2002-12-16 14:49:54.000000000 +1100
+++ 2.5.53-32bit.1/include/asm-mips64/posix_types.h	2002-12-30 16:25:00.000000000 +1100
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
diff -ruN 2.5.53/include/asm-mips64/stat.h 2.5.53-32bit.1/include/asm-mips64/stat.h
--- 2.5.53/include/asm-mips64/stat.h	2002-12-16 14:49:54.000000000 +1100
+++ 2.5.53-32bit.1/include/asm-mips64/stat.h	2002-12-16 14:51:53.000000000 +1100
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
