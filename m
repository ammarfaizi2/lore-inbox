Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSLMEjI>; Thu, 12 Dec 2002 23:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSLMEjI>; Thu, 12 Dec 2002 23:39:08 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:53663 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261338AbSLMEiz>;
	Thu, 12 Dec 2002 23:38:55 -0500
Date: Fri, 13 Dec 2002 15:46:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] consolidate sys32_new[lf]stat - s390x
Message-Id: <20021213154639.44905ba2.sfr@canb.auug.org.au>
In-Reply-To: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
References: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

This is the s390x part of the patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.1/arch/s390x/kernel/entry.S 2.5.51-32bit.2/arch/s390x/kernel/entry.S
--- 2.5.51-32bit.1/arch/s390x/kernel/entry.S	2002-12-10 17:05:19.000000000 +1100
+++ 2.5.51-32bit.2/arch/s390x/kernel/entry.S	2002-12-13 14:55:35.000000000 +1100
@@ -482,9 +482,9 @@
         .long  SYSCALL(sys_syslog,sys32_syslog_wrapper)
         .long  SYSCALL(sys_setitimer,compat_sys_setitimer_wrapper)
         .long  SYSCALL(sys_getitimer,compat_sys_getitimer_wrapper)   /* 105 */
-        .long  SYSCALL(sys_newstat,sys32_newstat_wrapper)
-        .long  SYSCALL(sys_newlstat,sys32_newlstat_wrapper)
-        .long  SYSCALL(sys_newfstat,sys32_newfstat_wrapper)
+        .long  SYSCALL(sys_newstat,compat_sys_newstat_wrapper)
+        .long  SYSCALL(sys_newlstat,compat_sys_newlstat_wrapper)
+        .long  SYSCALL(sys_newfstat,compat_sys_newfstat_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old uname syscall */
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* iopl for i386 */
         .long  SYSCALL(sys_vhangup,sys_vhangup)
diff -ruN 2.5.51-32bit.1/arch/s390x/kernel/ioctl32.c 2.5.51-32bit.2/arch/s390x/kernel/ioctl32.c
--- 2.5.51-32bit.1/arch/s390x/kernel/ioctl32.c	2002-12-10 15:26:49.000000000 +1100
+++ 2.5.51-32bit.2/arch/s390x/kernel/ioctl32.c	2002-12-12 14:05:42.000000000 +1100
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
@@ -378,9 +379,9 @@
 
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
diff -ruN 2.5.51-32bit.1/arch/s390x/kernel/linux32.c 2.5.51-32bit.2/arch/s390x/kernel/linux32.c
--- 2.5.51-32bit.1/arch/s390x/kernel/linux32.c	2002-12-10 17:05:51.000000000 +1100
+++ 2.5.51-32bit.2/arch/s390x/kernel/linux32.c	2002-12-13 14:44:28.000000000 +1100
@@ -268,7 +268,7 @@
         __kernel_gid32_t        gid;
         __kernel_uid32_t        cuid;
         __kernel_gid32_t        cgid;
-        __kernel_mode_t32       mode;
+        compat_mode_t       mode;
         unsigned short          __pad1;
         unsigned short          seq;
         unsigned short          __pad2;
@@ -279,11 +279,11 @@
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
 
@@ -337,8 +337,8 @@
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
@@ -364,8 +364,8 @@
 	unsigned int		__unused2;
 	compat_time_t  	shm_ctime;
 	unsigned int		__unused3;
-	__kernel_pid_t32	shm_cpid;
-	__kernel_pid_t32	shm_lpid;
+	compat_pid_t	shm_cpid;
+	compat_pid_t	shm_lpid;
 	unsigned int		shm_nattch;
 	unsigned int		__unused4;
 	unsigned int		__unused5;
@@ -1393,7 +1393,7 @@
 	return ret;
 }
 
-static int cp_new_stat32(struct kstat *stat, struct stat32 *statbuf)
+int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
 {
 	int err;
 
@@ -1420,39 +1420,6 @@
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
@@ -1463,16 +1430,16 @@
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
@@ -1492,11 +1459,11 @@
 
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
@@ -1655,7 +1622,7 @@
 	return err;
 }
 
-asmlinkage int sys32_wait4(__kernel_pid_t32 pid, unsigned int *stat_addr, int options, struct rusage32 *ru)
+asmlinkage int sys32_wait4(compat_pid_t pid, unsigned int *stat_addr, int options, struct rusage32 *ru)
 {
 	if (!ru)
 		return sys_wait4(pid, stat_addr, options, NULL);
@@ -1717,7 +1684,7 @@
 
 extern asmlinkage int sys_sched_rr_get_interval(pid_t pid, struct timespec *interval);
 
-asmlinkage int sys32_sched_rr_get_interval(__kernel_pid_t32 pid,
+asmlinkage int sys32_sched_rr_get_interval(compat_pid_t pid,
 		struct compat_timespec *interval)
 {
 	struct timespec t;
@@ -3253,27 +3220,27 @@
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
 
@@ -3402,7 +3369,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_uidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_udimap[i],
-			      &(((__kernel_uid_t32 *)A(uaddr))[i]));
+			      &(((compat_uid_t *)A(uaddr))[i]));
 	err |= __get_user(karg->ca_umap.ug_gidbase,
 		      &arg32->ca32_umap.ug32_gidbase);
 	err |= __get_user(karg->ca_umap.ug_uidlen,
@@ -3416,7 +3383,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_gidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_gdimap[i],
-			      &(((__kernel_gid_t32 *)A(uaddr))[i]));
+			      &(((compat_gid_t *)A(uaddr))[i]));
 
 	return err;
 }
@@ -3680,7 +3647,7 @@
 
 extern asmlinkage ssize_t sys_sendfile(int out_fd, int in_fd, off_t *offset, size_t count);
 
-asmlinkage int sys32_sendfile(int out_fd, int in_fd, __kernel_off_t32 *offset, s32 count)
+asmlinkage int sys32_sendfile(int out_fd, int in_fd, compat_off_t *offset, s32 count)
 {
 	mm_segment_t old_fs = get_fs();
 	int ret;
@@ -4147,7 +4114,7 @@
 extern asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_setaffinity(__kernel_pid_t32 pid, unsigned int len,
+asmlinkage int sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
@@ -4171,7 +4138,7 @@
 extern asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
 					    unsigned long *user_mask_ptr);
 
-asmlinkage int sys32_sched_getaffinity(__kernel_pid_t32 pid, unsigned int len,
+asmlinkage int sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
 				       u32 *user_mask_ptr)
 {
 	unsigned long kernel_mask;
diff -ruN 2.5.51-32bit.1/arch/s390x/kernel/linux32.h 2.5.51-32bit.2/arch/s390x/kernel/linux32.h
--- 2.5.51-32bit.1/arch/s390x/kernel/linux32.h	2002-12-10 15:40:49.000000000 +1100
+++ 2.5.51-32bit.2/arch/s390x/kernel/linux32.h	2002-12-12 16:11:15.000000000 +1100
@@ -16,17 +16,9 @@
 	((unsigned long)(__x))
 
 /* Now 32bit compatibility types */
-typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
-typedef unsigned short         __kernel_uid_t32;
-typedef unsigned short         __kernel_gid_t32;
-typedef unsigned short         __kernel_dev_t32;
-typedef unsigned int           __kernel_ino_t32;
-typedef unsigned short         __kernel_mode_t32;
 typedef unsigned short         __kernel_umode_t32;
-typedef short                  __kernel_nlink_t32;
 typedef int                    __kernel_daddr_t32;
-typedef int                    __kernel_off_t32;
 typedef unsigned int           __kernel_caddr_t32;
 typedef long                   __kernel_loff_t32;
 typedef __kernel_fsid_t        __kernel_fsid_t32;  
@@ -43,35 +35,12 @@
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
diff -ruN 2.5.51-32bit.1/arch/s390x/kernel/wrapper32.S 2.5.51-32bit.2/arch/s390x/kernel/wrapper32.S
--- 2.5.51-32bit.1/arch/s390x/kernel/wrapper32.S	2002-12-10 17:04:36.000000000 +1100
+++ 2.5.51-32bit.2/arch/s390x/kernel/wrapper32.S	2002-12-13 14:55:15.000000000 +1100
@@ -470,31 +470,31 @@
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# struct itimerval_emu31 *
 	llgtr	%r4,%r4			# struct itimerval_emu31 *
-	jg	compat_sys_setitimer		# branch to system call
+	jg	compat_sys_setitimer	# branch to system call
 
 	.globl  compat_sys_getitimer_wrapper 
 compat_sys_getitimer_wrapper:
 	lgfr	%r2,%r2			# int
 	llgtr	%r3,%r3			# struct itimerval_emu31 *
-	jg	compat_sys_getitimer		# branch to system call
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
 
diff -ruN 2.5.51-32bit.1/include/asm-s390x/compat.h 2.5.51-32bit.2/include/asm-s390x/compat.h
--- 2.5.51-32bit.1/include/asm-s390x/compat.h	2002-12-10 16:38:17.000000000 +1100
+++ 2.5.51-32bit.2/include/asm-s390x/compat.h	2002-12-12 16:14:04.000000000 +1100
@@ -11,6 +11,14 @@
 typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
+typedef s32		compat_pid_t;
+typedef u16		compat_uid_t;
+typedef u16		compat_gid_t;
+typedef u16		compat_mode_t;
+typedef u32		compat_ino_t;
+typedef u16		compat_dev_t;
+typedef s32		compat_off_t;
+typedef u16		compat_nlink_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
@@ -22,4 +30,27 @@
 	s32		tv_usec;
 };
 
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
 #endif /* _ASM_S390X_COMPAT_H */
