Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSLMEnv>; Thu, 12 Dec 2002 23:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbSLMEnv>; Thu, 12 Dec 2002 23:43:51 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:17056 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261353AbSLMEno>;
	Thu, 12 Dec 2002 23:43:44 -0500
Date: Fri, 13 Dec 2002 15:51:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: willy@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] consolidate sys32_new[lf]stat - parisc
Message-Id: <20021213155123.5082a535.sfr@canb.auug.org.au>
In-Reply-To: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
References: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Here is the parisc part of the patch.  Unfortunately, I realise this
breaks on parisc (there is an assumption that the compatibility
syscall routine names start with sys32_).  I will fix this in the
next patch (hopefully).
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.1/arch/parisc/kernel/ioctl32.c 2.5.51-32bit.2/arch/parisc/kernel/ioctl32.c
--- 2.5.51-32bit.1/arch/parisc/kernel/ioctl32.c	2002-12-10 15:26:49.000000000 +1100
+++ 2.5.51-32bit.2/arch/parisc/kernel/ioctl32.c	2002-12-12 14:05:05.000000000 +1100
@@ -1366,9 +1366,9 @@
 
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
@@ -1577,7 +1577,7 @@
 	set_fs(old_fs);
 
 	if (err >= 0)
-		err = put_user(kuid, (__kernel_uid_t32 *)arg);
+		err = put_user(kuid, (compat_uid_t *)arg);
 
 	return err;
 }
@@ -1864,7 +1864,7 @@
 } lv_status_byindex_req32_t;
 
 typedef struct {
-	__kernel_dev_t32 dev;
+	compat_dev_t dev;
 	u32   lv;
 } lv_status_bydev_req32_t;
 
@@ -3628,7 +3628,7 @@
 HANDLE_IOCTL(EXT2_IOC32_SETVERSION, do_ext2_ioctl)
 #if 0
 /* One SMB ioctl needs translations. */
-#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, __kernel_uid_t32)
+#define SMB_IOC_GETMOUNTUID_32 _IOR('u', 1, compat_uid_t)
 HANDLE_IOCTL(SMB_IOC_GETMOUNTUID_32, do_smb_getmountuid)
 #endif
 HANDLE_IOCTL(ATM_GETLINKRATE32, do_atm_ioctl)
diff -ruN 2.5.51-32bit.1/arch/parisc/kernel/sys_parisc32.c 2.5.51-32bit.2/arch/parisc/kernel/sys_parisc32.c
--- 2.5.51-32bit.1/arch/parisc/kernel/sys_parisc32.c	2002-12-10 17:03:26.000000000 +1100
+++ 2.5.51-32bit.2/arch/parisc/kernel/sys_parisc32.c	2002-12-12 17:23:57.000000000 +1100
@@ -389,9 +389,9 @@
 struct flock32 {
 	short l_type;
 	short l_whence;
-	__kernel_off_t32 l_start;
-	__kernel_off_t32 l_len;
-	__kernel_pid_t32 l_pid;
+	compat_off_t l_start;
+	compat_off_t l_len;
+	compat_pid_t l_pid;
 };
 
 
@@ -674,7 +674,7 @@
 }
 
 asmlinkage int
-sys32_wait4(__kernel_pid_t32 pid, unsigned int * stat_addr, int options,
+sys32_wait4(compat_pid_t pid, unsigned int * stat_addr, int options,
 	    struct rusage32 * ru)
 {
 	if (!ru)
@@ -692,41 +692,13 @@
 	}
 }
 
-struct stat32 {
-	__kernel_dev_t32		st_dev;		/* dev_t is 32 bits on parisc */
-	__kernel_ino_t32		st_ino;		/* 32 bits */
-	__kernel_mode_t32	st_mode;	/* 16 bits */
-	__kernel_nlink_t32		st_nlink;	/* 16 bits */
-	unsigned short	st_reserved1;	/* old st_uid */
-	unsigned short	st_reserved2;	/* old st_gid */
-	__kernel_dev_t32		st_rdev;
-	__kernel_off_t32		st_size;
-	compat_time_t	st_atime;
-	unsigned int	st_spare1;
-	compat_time_t	st_mtime;
-	unsigned int	st_spare2;
-	compat_time_t	st_ctime;
-	unsigned int	st_spare3;
-	int		st_blksize;
-	int		st_blocks;
-	unsigned int	__unused1;	/* ACL stuff */
-	__kernel_dev_t32		__unused2;	/* network */
-	__kernel_ino_t32		__unused3;	/* network */
-	unsigned int	__unused4;	/* cnodes */
-	unsigned short	__unused5;	/* netsite */
-	short		st_fstype;
-	__kernel_dev_t32		st_realdev;
-	unsigned short	st_basemode;
-	unsigned short	st_spareshort;
-	__kernel_uid_t32		st_uid;
-	__kernel_gid_t32		st_gid;
-	unsigned int	st_spare4[3];
-};
-
-static int cp_new_stat32(struct kstat *stat, struct stat32 *statbuf)
+int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
 {
 	int err;
 
+	if (stat->size > MAX_NON_LFS)
+		return -EOVERFLOW;
+
 	err  = put_user(stat->dev, &statbuf->st_dev);
 	err |= put_user(stat->ino, &statbuf->st_ino);
 	err |= put_user(stat->mode, &statbuf->st_mode);
@@ -734,8 +706,6 @@
 	err |= put_user(0, &statbuf->st_reserved1);
 	err |= put_user(0, &statbuf->st_reserved2);
 	err |= put_user(stat->rdev, &statbuf->st_rdev);
-	if (stat->size > MAX_NON_LFS)
-		return -EOVERFLOW;
 	err |= put_user(stat->size, &statbuf->st_size);
 	err |= put_user(stat->atime, &statbuf->st_atime);
 	err |= put_user(0, &statbuf->st_spare1);
@@ -763,42 +733,9 @@
 	return err;
 }
 
-asmlinkage long sys32_newstat(char * filename, struct stat32 *statbuf)
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
-asmlinkage long sys32_newlstat(char * filename, struct stat32 *statbuf)
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
-asmlinkage long sys32_newfstat(unsigned int fd, struct stat32 *statbuf)
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
 struct linux32_dirent {
 	u32	d_ino;
-	__kernel_off_t32	d_off;
+	compat_off_t	d_off;
 	u16	d_reclen;
 	char	d_name[1];
 };
@@ -2619,7 +2556,7 @@
 	char			ex_client[NFSCLNT_IDMAX+1];
 	char			ex_path[NFS_MAXPATHLEN+1];
 	__kernel_dev_t		ex_dev;
-	__kernel_ino_t32	ex_ino;
+	compat_ino_t	ex_ino;
 	int			ex_flags;
 	__kernel_uid_t		ex_anon_uid;
 	__kernel_gid_t		ex_anon_gid;
@@ -2629,7 +2566,7 @@
 struct nfsctl_fhparm32 {
 	struct sockaddr		gf_addr;
 	__kernel_dev_t		gf_dev;
-	__kernel_ino_t32	gf_ino;
+	compat_ino_t	gf_ino;
 	int			gf_version;
 };
 
diff -ruN 2.5.51-32bit.1/include/asm-parisc/compat.h 2.5.51-32bit.2/include/asm-parisc/compat.h
--- 2.5.51-32bit.1/include/asm-parisc/compat.h	2002-12-10 16:38:08.000000000 +1100
+++ 2.5.51-32bit.2/include/asm-parisc/compat.h	2002-12-12 16:14:20.000000000 +1100
@@ -11,6 +11,14 @@
 typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
+typedef s32		compat_pid_t;
+typedef u32		compat_uid_t;
+typedef u32		compat_gid_t;
+typedef u16		compat_mode_t;
+typedef u32		compat_ino_t;
+typedef u32		compat_dev_t;
+typedef s32		compat_off_t;
+typedef u16		compat_nlink_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
@@ -22,4 +30,35 @@
 	s32		tv_usec;
 };
 
+struct compat_stat {
+	compat_dev_t	st_dev;		/* dev_t is 32 bits on parisc */
+	compat_ino_t	st_ino;		/* 32 bits */
+	compat_mode_t	st_mode;	/* 16 bits */
+	compat_nlink_t	st_nlink;	/* 16 bits */
+	u16		st_reserved1;	/* old st_uid */
+	u16		st_reserved2;	/* old st_gid */
+	compat_dev_t	st_rdev;
+	compat_off_t	st_size;
+	compat_time_t	st_atime;
+	u32		st_spare1;
+	compat_time_t	st_mtime;
+	u32		st_spare2;
+	compat_time_t	st_ctime;
+	u32		st_spare3;
+	s32		st_blksize;
+	s32		st_blocks;
+	u32		__unused1;	/* ACL stuff */
+	compat_dev_t	__unused2;	/* network */
+	compat_ino_t	__unused3;	/* network */
+	u32		__unused4;	/* cnodes */
+	u16		__unused5;	/* netsite */
+	short		st_fstype;
+	compat_dev_t	st_realdev;
+	u16		st_basemode;
+	u16		st_spareshort;
+	compat_uid_t	st_uid;
+	compat_gid_t	st_gid;
+	u32		st_spare4[3];
+};
+
 #endif /* _ASM_PARISC_COMPAT_H */
diff -ruN 2.5.51-32bit.1/include/asm-parisc/posix_types.h 2.5.51-32bit.2/include/asm-parisc/posix_types.h
--- 2.5.51-32bit.1/include/asm-parisc/posix_types.h	2002-12-10 15:42:51.000000000 +1100
+++ 2.5.51-32bit.2/include/asm-parisc/posix_types.h	2002-12-12 15:57:18.000000000 +1100
@@ -57,15 +57,7 @@
 
 #if defined(__KERNEL__) && defined(__LP64__)
 /* Now 32bit compatibility types */
-typedef unsigned int		__kernel_dev_t32;
-typedef unsigned int		__kernel_ino_t32;
-typedef unsigned short		__kernel_mode_t32;
-typedef unsigned short		__kernel_nlink_t32;
-typedef int			__kernel_off_t32;
-typedef int			__kernel_pid_t32;
 typedef unsigned short		__kernel_ipc_pid_t32;
-typedef unsigned int		__kernel_uid_t32;
-typedef unsigned int		__kernel_gid_t32;
 typedef int			__kernel_daddr_t32;
 typedef unsigned int		__kernel_caddr_t32;
 #endif
