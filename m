Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262349AbSJDQRn>; Fri, 4 Oct 2002 12:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262350AbSJDQRn>; Fri, 4 Oct 2002 12:17:43 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:2709 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262349AbSJDQRf>; Fri, 4 Oct 2002 12:17:35 -0400
Date: Fri, 4 Oct 2002 18:23:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [RFC, patch] 2.5.40: stat.st_gen for inode generations
Message-ID: <Pine.GSO.3.96.1021004165203.6208H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 As you may know, there are serious problems with creating unique file
handles in the userland NFS server.  They exist because the inode
generation number, which allows to determine if an inode was deleted and
recreated, is currently only available to the kernel -- it's by no means
exported to user programs.  I've been working to remove this limitation
recently and here I am presenting the results. 

1. Linux was modified to add another member of "struct stat" and "struct
stat64".  The member provides the value of the inode generation at the
time one of the stat syscalls is invoked.  It is named "st_gen" as it is
the name other systems give it (it seems DEC OSF/1 and IBM AIX define this
member currently).  New syscalls have been defined wherever spare space
was not available in "struct stat" or "struct stat64", otherwise only the
semantics of old ones was extended.  Due to its moderate size the patch is
not attached.  It's available at:
'ftp://ftp.ds2.pg.gda.pl/pub/macro/st_gen/patches/2.5.40/patch-2.5.40-stat-st_gen-42.gz'. 
However, since the generic part of the patch is actually quite small and
most of the space is taken by arch-specific updates (especially 32-bit
compatibility calls for 64-bit systems), I've attached a stripped-down
version for the i386 only below.

2. Glibc was updated to make the Linux change usable.  This is an example
implementation and may seriously differ from what might go into glibc
finally.  The patch is available at: 
'ftp://ftp.ds2.pg.gda.pl/pub/macro/st_gen/patches/glibc-2.2.5-stat-st_gen.patch.gz'. 

3. The userland NFS server was changed to embed the inode generation into
file handles.  The patch is available at: 
'ftp://ftp.ds2.pg.gda.pl/pub/macro/st_gen/patches/nfs-server-2.2beta50-stat.patch.gz'. 

 The changes were successfully used with 2.4 kernels since January 2002
(selected patches used are at the site as well -- just browse around). 
The 2.5.40 patch builds successfully but I couldn't test it at the
run-time as the BusLogic SCSI driver doesn't work.  I decided to make the
patch available anyway as the deadline for new 2.5 features is close. 

 Comments, suggestions, etc. are welcomed, as usually. ;-) 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.5.40-stat-st_gen-42extr
diff -up --recursive --new-file linux-2.5.40.macro/arch/i386/kernel/entry.S linux-2.5.40/arch/i386/kernel/entry.S
--- linux-2.5.40.macro/arch/i386/kernel/entry.S	2002-10-01 07:06:26.000000000 +0000
+++ linux-2.5.40/arch/i386/kernel/entry.S	2002-10-04 16:10:41.000000000 +0000
@@ -736,6 +736,9 @@ ENTRY(sys_call_table)
 	.long sys_alloc_hugepages /* 250 */
 	.long sys_free_hugepages
 	.long sys_exit_group
+	.long sys_newstat64
+	.long sys_newlstat64
+	.long sys_newfstat64	/* 255 */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -up --recursive --new-file linux-2.5.40.macro/fs/stat.c linux-2.5.40/fs/stat.c
--- linux-2.5.40.macro/fs/stat.c	2002-10-01 07:06:21.000000000 +0000
+++ linux-2.5.40/fs/stat.c	2002-10-04 16:12:51.000000000 +0000
@@ -32,6 +32,7 @@ void generic_fillattr(struct inode *inod
 	stat->size = inode->i_size;
 	stat->blocks = inode->i_blocks;
 	stat->blksize = inode->i_blksize;
+	stat->gen = inode->i_generation;
 }
 
 int vfs_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
@@ -95,13 +96,11 @@ int vfs_fstat(unsigned int fd, struct ks
 	return error;
 }
 
-#if !defined(__alpha__) && !defined(__sparc__) && !defined(__ia64__) \
- && !defined(CONFIG_ARCH_S390) && !defined(__hppa__) && !defined(__x86_64__) \
- && !defined(__arm__)
+#if defined(__i386__) || defined(__m68k__) || defined(__mips__) || \
+    defined(__ppc__) || defined(__sh__)
 
 /*
- * For backward compatibility?  Maybe this should be moved
- * into arch/i386 instead?
+ * For backward compatibility.  Not to be used for new ports.
  */
 static int cp_old_stat(struct kstat *stat, struct __old_kernel_stat * statbuf)
 {
@@ -117,6 +116,7 @@ static int cp_old_stat(struct kstat *sta
 		warncount = 0;
 	}
 
+	memset(&tmp, 0, sizeof(tmp));
 	tmp.st_dev = stat->dev;
 	tmp.st_ino = stat->ino;
 	tmp.st_mode = stat->mode;
@@ -165,7 +165,6 @@ asmlinkage long sys_fstat(unsigned int f
 
 	return error;
 }
-
 #endif
 
 static int cp_new_stat(struct kstat *stat, struct stat *statbuf)
@@ -190,6 +189,7 @@ static int cp_new_stat(struct kstat *sta
 	tmp.st_ctime = stat->ctime;
 	tmp.st_blocks = stat->blocks;
 	tmp.st_blksize = stat->blksize;
+	tmp.st_gen = stat->gen;
 	return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
 }
 
@@ -251,7 +251,49 @@ asmlinkage long sys_readlink(const char 
 
 
 /* ---------- LFS-64 ----------- */
-#if !defined(__alpha__) && !defined(__ia64__) && !defined(__mips64) && !defined(__x86_64__) && !defined(CONFIG_ARCH_S390X)
+#if !defined(__alpha__) && !defined(__ia64__) && !defined(__mips64__) && \
+    !defined(CONFIG_ARCH_S390X) && !defined(__x86_64__)
+
+#if defined(__arm__) || defined(__cris__) || defined(__i386__) || \
+    defined(__m68k__) || defined(__mips__) || defined(CONFIG_ARCH_S390)
+/*
+ * For backward compatibility.  Not to be used for new ports.
+ */
+static long cp_old_stat64(struct kstat *stat,
+			  struct __old_kernel_stat64 * statbuf)
+{
+	static int warncount = 5;
+	struct __old_kernel_stat64 tmp;
+
+	if (warncount > 0) {
+		warncount--;
+		printk(KERN_WARNING "VFS: Warning: %s using old stat64() call. Recompile your binary.\n",
+			current->comm);
+	} else if (warncount < 0) {
+		/* it's laughable, but... */
+		warncount = 0;
+	}
+
+	memset(&tmp, 0, sizeof(tmp));
+	tmp.st_dev = stat->dev;
+	tmp.st_ino = stat->ino;
+#ifdef STAT64_HAS_BROKEN_ST_INO
+	tmp.__st_ino = stat->ino;
+#endif
+	tmp.st_mode = stat->mode;
+	tmp.st_nlink = stat->nlink;
+	tmp.st_uid = stat->uid;
+	tmp.st_gid = stat->gid;
+	tmp.st_rdev = stat->rdev;
+	tmp.st_atime = stat->atime;
+	tmp.st_mtime = stat->mtime;
+	tmp.st_ctime = stat->ctime;
+	tmp.st_size = stat->size;
+	tmp.st_blocks = stat->blocks;
+	tmp.st_blksize = stat->blksize;
+	return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
+}
+#endif
 
 static long cp_new_stat64(struct kstat *stat, struct stat64 *statbuf)
 {
@@ -274,10 +316,52 @@ static long cp_new_stat64(struct kstat *
 	tmp.st_size = stat->size;
 	tmp.st_blocks = stat->blocks;
 	tmp.st_blksize = stat->blksize;
+	tmp.st_gen = stat->gen;
 	return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
 }
 
-asmlinkage long sys_stat64(char * filename, struct stat64 * statbuf, long flags)
+#if defined(__arm__) || defined(__cris__) || defined(__i386__) || \
+    defined(__m68k__) || defined(__mips__) || defined(CONFIG_ARCH_S390)
+/*
+ * For backward compatibility.  Not to be used for new ports.
+ */
+asmlinkage long sys_stat64(char * filename,
+			   struct __old_kernel_stat64 * statbuf, long flags)
+{
+	struct kstat stat;
+	int error = vfs_stat(filename, &stat);
+
+	if (!error)
+		error = cp_old_stat64(&stat, statbuf);
+
+	return error;
+}
+asmlinkage long sys_lstat64(char * filename,
+			    struct __old_kernel_stat64 * statbuf, long flags)
+{
+	struct kstat stat;
+	int error = vfs_lstat(filename, &stat);
+
+	if (!error)
+		error = cp_old_stat64(&stat, statbuf);
+
+	return error;
+}
+asmlinkage long sys_fstat64(unsigned long fd,
+			    struct __old_kernel_stat64 * statbuf, long flags)
+{
+	struct kstat stat;
+	int error = vfs_fstat(fd, &stat);
+
+	if (!error)
+		error = cp_old_stat64(&stat, statbuf);
+
+	return error;
+}
+#endif
+
+asmlinkage long sys_newstat64(char * filename, struct stat64 * statbuf,
+			      long flags)
 {
 	struct kstat stat;
 	int error = vfs_stat(filename, &stat);
@@ -287,7 +371,8 @@ asmlinkage long sys_stat64(char * filena
 
 	return error;
 }
-asmlinkage long sys_lstat64(char * filename, struct stat64 * statbuf, long flags)
+asmlinkage long sys_newlstat64(char * filename, struct stat64 * statbuf,
+			       long flags)
 {
 	struct kstat stat;
 	int error = vfs_lstat(filename, &stat);
@@ -297,7 +382,8 @@ asmlinkage long sys_lstat64(char * filen
 
 	return error;
 }
-asmlinkage long sys_fstat64(unsigned long fd, struct stat64 * statbuf, long flags)
+asmlinkage long sys_newfstat64(unsigned long fd, struct stat64 * statbuf,
+			       long flags)
 {
 	struct kstat stat;
 	int error = vfs_fstat(fd, &stat);
@@ -307,5 +393,4 @@ asmlinkage long sys_fstat64(unsigned lon
 
 	return error;
 }
-
 #endif /* LFS-64 */
diff -up --recursive --new-file linux-2.5.40.macro/include/asm-i386/stat.h linux-2.5.40/include/asm-i386/stat.h
--- linux-2.5.40.macro/include/asm-i386/stat.h	2002-10-01 07:06:16.000000000 +0000
+++ linux-2.5.40/include/asm-i386/stat.h	2002-10-04 16:10:41.000000000 +0000
@@ -34,8 +34,42 @@ struct stat {
 	unsigned long  __unused2;
 	unsigned long  st_ctime;
 	unsigned long  __unused3;
+	unsigned int   st_gen;
 	unsigned long  __unused4;
-	unsigned long  __unused5;
+};
+
+struct __old_kernel_stat64 {
+	unsigned short	st_dev;
+	unsigned char	__pad0[10];
+
+#define STAT64_HAS_BROKEN_ST_INO	1
+	unsigned long	__st_ino;
+
+	unsigned int	st_mode;
+	unsigned int	st_nlink;
+
+	unsigned long	st_uid;
+	unsigned long	st_gid;
+
+	unsigned short	st_rdev;
+	unsigned char	__pad3[10];
+
+	long long	st_size;
+	unsigned long	st_blksize;
+
+	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
+	unsigned long	__pad4;		/* future possible st_blocks high bits */
+
+	unsigned long	st_atime;
+	unsigned long	__pad5;
+
+	unsigned long	st_mtime;
+	unsigned long	__pad6;
+
+	unsigned long	st_ctime;
+	unsigned long	__pad7;		/* will be high 32 bits of ctime someday */
+
+	unsigned long long	st_ino;
 };
 
 /* This matches struct stat64 in glibc2.1, hence the absolutely
@@ -73,6 +107,9 @@ struct stat64 {
 	unsigned long	__pad7;		/* will be high 32 bits of ctime someday */
 
 	unsigned long long	st_ino;
+
+	unsigned int	st_gen;
+	unsigned int	__pad8;
 };
 
 #endif
diff -up --recursive --new-file linux-2.5.40.macro/include/asm-i386/unistd.h linux-2.5.40/include/asm-i386/unistd.h
--- linux-2.5.40.macro/include/asm-i386/unistd.h	2002-10-01 07:07:10.000000000 +0000
+++ linux-2.5.40/include/asm-i386/unistd.h	2002-10-04 16:10:41.000000000 +0000
@@ -199,9 +199,9 @@
 #define __NR_mmap2		192
 #define __NR_truncate64		193
 #define __NR_ftruncate64	194
-#define __NR_stat64		195
-#define __NR_lstat64		196
-#define __NR_fstat64		197
+#define __NR_oldstat64		195
+#define __NR_oldlstat64		196
+#define __NR_oldfstat64		197
 #define __NR_lchown32		198
 #define __NR_getuid32		199
 #define __NR_getgid32		200
@@ -257,6 +257,9 @@
 #define __NR_alloc_hugepages	250
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
+#define __NR_stat64		253
+#define __NR_lstat64		254
+#define __NR_fstat64		255
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 

