Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSLMEhY>; Thu, 12 Dec 2002 23:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSLMEhY>; Thu, 12 Dec 2002 23:37:24 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:42655 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261337AbSLMEhO>;
	Thu, 12 Dec 2002 23:37:14 -0500
Date: Fri, 13 Dec 2002 15:44:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] consolidate sys32_new[lf]stat - ia64
Message-Id: <20021213154459.7a48db5b.sfr@canb.auug.org.au>
In-Reply-To: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
References: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

This is the ia64 part of the patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.1/arch/ia64/ia32/ia32_entry.S 2.5.51-32bit.2/arch/ia64/ia32/ia32_entry.S
--- 2.5.51-32bit.1/arch/ia64/ia32/ia32_entry.S	2002-12-10 17:00:17.000000000 +1100
+++ 2.5.51-32bit.2/arch/ia64/ia32/ia32_entry.S	2002-12-13 14:54:13.000000000 +1100
@@ -297,9 +297,9 @@
 	data8 sys_syslog
 	data8 compat_sys_setitimer
 	data8 compat_sys_getitimer	  /* 105 */
-	data8 sys32_newstat
-	data8 sys32_newlstat
-	data8 sys32_newfstat
+	data8 compat_sys_newstat
+	data8 compat_sys_newlstat
+	data8 compat_sys_newfstat
 	data8 sys32_ni_syscall
 	data8 sys32_iopl		  /* 110 */
 	data8 sys_vhangup
diff -ruN 2.5.51-32bit.1/arch/ia64/ia32/sys_ia32.c 2.5.51-32bit.2/arch/ia64/ia32/sys_ia32.c
--- 2.5.51-32bit.1/arch/ia64/ia32/sys_ia32.c	2002-12-10 16:58:43.000000000 +1100
+++ 2.5.51-32bit.2/arch/ia64/ia32/sys_ia32.c	2002-12-12 17:22:58.000000000 +1100
@@ -175,8 +175,7 @@
 	return r;
 }
 
-static inline int
-putstat (struct stat32 *ubuf, struct kstat *stat)
+int cp_compat_stat(struct kstat *stat, struct compat_stat *ubuf)
 {
 	int err;
 
@@ -202,42 +201,6 @@
 	return err;
 }
 
-asmlinkage long
-sys32_newstat (char *filename, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int ret = vfs_stat(filename, &stat);
-
-	if (!ret)
-		ret = putstat(statbuf, &stat);
-
-	return ret;
-}
-
-asmlinkage long
-sys32_newlstat (char *filename, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int ret = vfs_lstat(filename, &stat);
-
-	if (!ret)
-		ret = putstat(statbuf, &stat);
-
-	return ret;
-}
-
-asmlinkage long
-sys32_newfstat (unsigned int fd, struct stat32 *statbuf)
-{
-	struct kstat stat;
-	int ret = vfs_fstat(fd, &stat);
-
-	if (!ret)
-		ret = putstat(statbuf, &stat);
-
-	return ret;
-}
-
 #if PAGE_SHIFT > IA32_PAGE_SHIFT
 
 
@@ -1872,11 +1835,11 @@
 
 struct ipc_perm32 {
 	key_t key;
-	__kernel_uid_t32 uid;
-	__kernel_gid_t32 gid;
-	__kernel_uid_t32 cuid;
-	__kernel_gid_t32 cgid;
-	__kernel_mode_t32 mode;
+	compat_uid_t uid;
+	compat_gid_t gid;
+	compat_uid_t cuid;
+	compat_gid_t cgid;
+	compat_mode_t mode;
 	unsigned short seq;
 };
 
@@ -1886,7 +1849,7 @@
 	__kernel_gid32_t32 gid;
 	__kernel_uid32_t32 cuid;
 	__kernel_gid32_t32 cgid;
-	__kernel_mode_t32 mode;
+	compat_mode_t mode;
 	unsigned short __pad1;
 	unsigned short seq;
 	unsigned short __pad2;
@@ -1943,8 +1906,8 @@
 	unsigned int msg_cbytes;
 	unsigned int msg_qnum;
 	unsigned int msg_qbytes;
-	__kernel_pid_t32 msg_lspid;
-	__kernel_pid_t32 msg_lrpid;
+	compat_pid_t msg_lspid;
+	compat_pid_t msg_lrpid;
 	unsigned int __unused4;
 	unsigned int __unused5;
 };
@@ -1969,8 +1932,8 @@
 	unsigned int __unused2;
 	compat_time_t   shm_ctime;
 	unsigned int __unused3;
-	__kernel_pid_t32 shm_cpid;
-	__kernel_pid_t32 shm_lpid;
+	compat_pid_t shm_cpid;
+	compat_pid_t shm_lpid;
 	unsigned int shm_nattch;
 	unsigned int __unused4;
 	unsigned int __unused5;
@@ -3552,16 +3515,16 @@
 struct ncp_mount_data32 {
 	int version;
 	unsigned int ncp_fd;
-	__kernel_uid_t32 mounted_uid;
+	compat_uid_t mounted_uid;
 	int wdog_pid;
 	unsigned char mounted_vol[NCP_VOLNAME_LEN + 1];
 	unsigned int time_out;
 	unsigned int retry_count;
 	unsigned int flags;
-	__kernel_uid_t32 uid;
-	__kernel_gid_t32 gid;
-	__kernel_mode_t32 file_mode;
-	__kernel_mode_t32 dir_mode;
+	compat_uid_t uid;
+	compat_gid_t gid;
+	compat_mode_t file_mode;
+	compat_mode_t dir_mode;
 };
 
 static void *
@@ -3583,11 +3546,11 @@
 
 struct smb_mount_data32 {
 	int version;
-	__kernel_uid_t32 mounted_uid;
-	__kernel_uid_t32 uid;
-	__kernel_gid_t32 gid;
-	__kernel_mode_t32 file_mode;
-	__kernel_mode_t32 dir_mode;
+	compat_uid_t mounted_uid;
+	compat_uid_t uid;
+	compat_gid_t gid;
+	compat_mode_t file_mode;
+	compat_mode_t dir_mode;
 };
 
 static void *
@@ -3705,52 +3668,52 @@
 
 extern asmlinkage long sys_setreuid(uid_t ruid, uid_t euid);
 
-asmlinkage long sys32_setreuid(__kernel_uid_t32 ruid, __kernel_uid_t32 euid)
+asmlinkage long sys32_setreuid(compat_uid_t ruid, compat_uid_t euid)
 {
 	uid_t sruid, seuid;
 
-	sruid = (ruid == (__kernel_uid_t32)-1) ? ((uid_t)-1) : ((uid_t)ruid);
-	seuid = (euid == (__kernel_uid_t32)-1) ? ((uid_t)-1) : ((uid_t)euid);
+	sruid = (ruid == (compat_uid_t)-1) ? ((uid_t)-1) : ((uid_t)ruid);
+	seuid = (euid == (compat_uid_t)-1) ? ((uid_t)-1) : ((uid_t)euid);
 	return sys_setreuid(sruid, seuid);
 }
 
 extern asmlinkage long sys_setresuid(uid_t ruid, uid_t euid, uid_t suid);
 
 asmlinkage long
-sys32_setresuid(__kernel_uid_t32 ruid, __kernel_uid_t32 euid,
-		__kernel_uid_t32 suid)
+sys32_setresuid(compat_uid_t ruid, compat_uid_t euid,
+		compat_uid_t suid)
 {
 	uid_t sruid, seuid, ssuid;
 
-	sruid = (ruid == (__kernel_uid_t32)-1) ? ((uid_t)-1) : ((uid_t)ruid);
-	seuid = (euid == (__kernel_uid_t32)-1) ? ((uid_t)-1) : ((uid_t)euid);
-	ssuid = (suid == (__kernel_uid_t32)-1) ? ((uid_t)-1) : ((uid_t)suid);
+	sruid = (ruid == (compat_uid_t)-1) ? ((uid_t)-1) : ((uid_t)ruid);
+	seuid = (euid == (compat_uid_t)-1) ? ((uid_t)-1) : ((uid_t)euid);
+	ssuid = (suid == (compat_uid_t)-1) ? ((uid_t)-1) : ((uid_t)suid);
 	return sys_setresuid(sruid, seuid, ssuid);
 }
 
 extern asmlinkage long sys_setregid(gid_t rgid, gid_t egid);
 
 asmlinkage long
-sys32_setregid(__kernel_gid_t32 rgid, __kernel_gid_t32 egid)
+sys32_setregid(compat_gid_t rgid, compat_gid_t egid)
 {
 	gid_t srgid, segid;
 
-	srgid = (rgid == (__kernel_gid_t32)-1) ? ((gid_t)-1) : ((gid_t)rgid);
-	segid = (egid == (__kernel_gid_t32)-1) ? ((gid_t)-1) : ((gid_t)egid);
+	srgid = (rgid == (compat_gid_t)-1) ? ((gid_t)-1) : ((gid_t)rgid);
+	segid = (egid == (compat_gid_t)-1) ? ((gid_t)-1) : ((gid_t)egid);
 	return sys_setregid(srgid, segid);
 }
 
 extern asmlinkage long sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid);
 
 asmlinkage long
-sys32_setresgid(__kernel_gid_t32 rgid, __kernel_gid_t32 egid,
-		__kernel_gid_t32 sgid)
+sys32_setresgid(compat_gid_t rgid, compat_gid_t egid,
+		compat_gid_t sgid)
 {
 	gid_t srgid, segid, ssgid;
 
-	srgid = (rgid == (__kernel_gid_t32)-1) ? ((gid_t)-1) : ((gid_t)rgid);
-	segid = (egid == (__kernel_gid_t32)-1) ? ((gid_t)-1) : ((gid_t)egid);
-	ssgid = (sgid == (__kernel_gid_t32)-1) ? ((gid_t)-1) : ((gid_t)sgid);
+	srgid = (rgid == (compat_gid_t)-1) ? ((gid_t)-1) : ((gid_t)rgid);
+	segid = (egid == (compat_gid_t)-1) ? ((gid_t)-1) : ((gid_t)egid);
+	ssgid = (sgid == (compat_gid_t)-1) ? ((gid_t)-1) : ((gid_t)sgid);
 	return sys_setresgid(srgid, segid, ssgid);
 }
 
@@ -3772,27 +3735,27 @@
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
 
@@ -3912,7 +3875,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_uidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_udimap[i],
-			      &(((__kernel_uid_t32 *)A(uaddr))[i]));
+			      &(((compat_uid_t *)A(uaddr))[i]));
 	err |= __get_user(karg->ca_umap.ug_gidbase,
 		      &arg32->ca32_umap.ug32_gidbase);
 	err |= __get_user(karg->ca_umap.ug_uidlen,
@@ -3927,7 +3890,7 @@
 		return -ENOMEM;
 	for(i = 0; i < karg->ca_umap.ug_gidlen; i++)
 		err |= __get_user(karg->ca_umap.ug_gdimap[i],
-			      &(((__kernel_gid_t32 *)A(uaddr))[i]));
+			      &(((compat_gid_t *)A(uaddr))[i]));
 
 	return err;
 }
diff -ruN 2.5.51-32bit.1/include/asm-ia64/compat.h 2.5.51-32bit.2/include/asm-ia64/compat.h
--- 2.5.51-32bit.1/include/asm-ia64/compat.h	2002-12-10 16:37:41.000000000 +1100
+++ 2.5.51-32bit.2/include/asm-ia64/compat.h	2002-12-12 16:59:16.000000000 +1100
@@ -3,7 +3,6 @@
 /*
  * Architecture specific compatibility types
  */
-
 #include <linux/types.h>
 
 #define COMPAT_USER_HZ	100
@@ -12,6 +11,14 @@
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
@@ -23,4 +30,27 @@
 	s32		tv_usec;
 };
 
+struct compat_stat {
+	compat_dev_t	st_dev;
+	u16		__pad1;
+	compat_ino_t	st_ino;
+	compat_mode_t	st_mode;
+	compat_nlink_t	st_nlink;
+	compay_uid_t	st_uid;
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
 #endif /* _ASM_IA64_COMPAT_H */
diff -ruN 2.5.51-32bit.1/include/asm-ia64/ia32.h 2.5.51-32bit.2/include/asm-ia64/ia32.h
--- 2.5.51-32bit.1/include/asm-ia64/ia32.h	2002-12-10 16:59:04.000000000 +1100
+++ 2.5.51-32bit.2/include/asm-ia64/ia32.h	2002-12-12 15:08:44.000000000 +1100
@@ -13,19 +13,12 @@
  */
 
 /* 32bit compatibility types */
-typedef int		__kernel_pid_t32;
 typedef unsigned short	__kernel_ipc_pid_t32;
-typedef unsigned short	__kernel_uid_t32;
 typedef unsigned int	__kernel_uid32_t32;
-typedef unsigned short	__kernel_gid_t32;
 typedef unsigned int	__kernel_gid32_t32;
-typedef unsigned short	__kernel_dev_t32;
-typedef unsigned int	__kernel_ino_t32;
-typedef unsigned short	__kernel_mode_t32;
 typedef unsigned short	__kernel_umode_t32;
 typedef short		__kernel_nlink_t32;
 typedef int		__kernel_daddr_t32;
-typedef int		__kernel_off_t32;
 typedef unsigned int	__kernel_caddr_t32;
 typedef long		__kernel_loff_t32;
 typedef __kernel_fsid_t	__kernel_fsid_t32;
@@ -40,9 +33,9 @@
 struct flock32 {
        short l_type;
        short l_whence;
-       __kernel_off_t32 l_start;
-       __kernel_off_t32 l_len;
-       __kernel_pid_t32 l_pid;
+       compat_off_t l_start;
+       compat_off_t l_len;
+       compat_pid_t l_pid;
 };
 
 #define F_GETLK64	12
@@ -167,29 +160,6 @@
 	sigset_t	  uc_sigmask;	/* mask last for extensibility */
 };
 
-struct stat32 {
-       unsigned short st_dev;
-       unsigned short __pad1;
-       unsigned int st_ino;
-       unsigned short st_mode;
-       unsigned short st_nlink;
-       unsigned short st_uid;
-       unsigned short st_gid;
-       unsigned short st_rdev;
-       unsigned short __pad2;
-       unsigned int  st_size;
-       unsigned int  st_blksize;
-       unsigned int  st_blocks;
-       unsigned int  st_atime;
-       unsigned int  __unused1;
-       unsigned int  st_mtime;
-       unsigned int  __unused2;
-       unsigned int  st_ctime;
-       unsigned int  __unused3;
-       unsigned int  __unused4;
-       unsigned int  __unused5;
-};
-
 struct stat64 {
 	unsigned short	st_dev;
 	unsigned char	__pad0[10];
