Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264192AbTCXNG3>; Mon, 24 Mar 2003 08:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264184AbTCXNG3>; Mon, 24 Mar 2003 08:06:29 -0500
Received: from hera.cwi.nl ([192.16.191.8]:50857 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264200AbTCXNFR>;
	Mon, 24 Mar 2003 08:05:17 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 24 Mar 2003 14:16:22 +0100 (MET)
Message-Id: <UTC200303241316.h2ODGM605276.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] - struct stat - Attention all arch maintainers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below a patch that changes struct stat for a number of
architectures. Maintainers, please watch carefully.

Struct stat is used to transfer information from kernel
to user space on a stat() system call.
It has fields st_dev, st_rdev.

The size of these fields is in principle unrelated to
the size of a dev_t in user space or the size of a
dev_t or kdev_t in kernel space.

It is just the "capacity" of the channel.
The actual amount of useful information is the minimum
of the four sizes (kernel dev_t, kernel kdev_t,
user dev_t, width of stat st_dev, st_rdev fields).

The goal of this patch is to make sure that the stat() and stat64()
system calls transmit at least 32 and 64 bits, respectively.
This is achieved by using the padding that was present already.
We fail when no padding was present, or when the padding is on
the wrong side (after the field, while the machine is big-endian).

alpha:	stat: uses unsigned int, 32 bits
arm:	stat: uses unsigned short - bad.
	The padding is on one side, which means that this can
	be made into unsigned long only on little endian systems.
	FIXED - unless __ARMEB__.
	stat64: used unsigned short - FIXED, now unsigned long long.
cris:	stat: used unsigned short - FIXED, now unsigned long
	stat64: used unsigned short - FIXED, now unsigned long long.
i386:	stat: used unsigned short - FIXED, now unsigned long
	stat64: used unsigned short - FIXED, now unsigned long long.
ia64:	stat: uses unsigned long, 64 bits
m68k:	stat: used unsigned short - bad, but this cannot be fixed
	since m68k is big-endian, and the available padding is on
	the wrong side. NOT FIXED.
	stat64: used unsigned short - FIXED, now unsigned long long.
mips:	stat: uses dev_t which is unsigned int, 32 bits
	stat64: used unsigned long, 32 bits. NOT FIXED.
	(There is padding on one side, so this can be fixed if __MIPSEL__.)
mips64:	stat: uses dev_t which is unsigned int, 32 bits
parisc:	stat: uses dev_t, 32 bits
	stat64: uses unsigned long long, 64 bits
ppc:	stat: uses dev_t which is unsigned int, 32 bits
	stat64: unsigned long long, 64 bits
ppc64:	stat: uses dev_t which is unsigned long, 64 bits
	stat64: uses unsigned long, 64 bits
sparc:	stat: uses unsigned short, no padding. NOT FIXED.
	stat64: used unsigned short - FIXED, now unsigned long long.
sparc64:stat: uses dev_t which is unsigned int, 32 bits
	stat64: used unsigned short - FIXED, now unsigned long long.
s390:	stat: used unsigned short, big-endian, padding on the wrong side,
	NOT FIXED.
	stat64: used unsigned short - FIXED, now unsigned long long.
s390x:	stat: uses unsigned long, 64 bits
sh:	stat: used unsigned short, but padding maybe on wrong side.
	NOT FIXED.
	stat64: used unsigned short - FIXED, now unsigned long long.
v850:	stat: used __kernel_dev_t.
	BUG: NEVER use __kernel types in a user space interface.
	Replaced the types. FIXED - now unsigned int - 32 bits.
	stat64: FIXED - now unsigned long long - 64 bits.
x86_64:	stat: uses unsigned long, 64 bits

So, on most architectures we achieve the aim of 32 bits for stat,
64 bits for stat64. On all architectures we achieve at least
16 bits for stat, 32 bits for stat64.

Andries

 asm-arm/stat.h     |   26 +++++++++++---------------
 asm-cris/stat.h    |   16 +++++++---------
 asm-i386/stat.h    |   16 +++++++---------
 asm-m68k/stat.h    |    8 +++-----
 asm-s390/stat.h    |   12 +++++-------
 asm-sh/stat.h      |   18 ++----------------
 asm-sparc/stat.h   |    8 +++-----
 asm-sparc64/stat.h |    6 ++----
 asm-v850/stat.h    |   34 ++++++++++++++++------------------
 9 files changed, 56 insertions(+), 88 deletions(-)

diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-arm/stat.h b/include/asm-arm/stat.h
--- a/include/asm-arm/stat.h	Fri Nov 22 22:40:19 2002
+++ b/include/asm-arm/stat.h	Mon Mar 24 13:44:11 2003
@@ -18,15 +18,23 @@
 #define STAT_HAVE_NSEC 
 
 struct stat {
+#if defined(__ARMEB__)
 	unsigned short st_dev;
 	unsigned short __pad1;
-	unsigned long st_ino;
+#else
+	unsigned long  st_dev;
+#endif
+	unsigned long  st_ino;
 	unsigned short st_mode;
 	unsigned short st_nlink;
 	unsigned short st_uid;
 	unsigned short st_gid;
+#if defined(__ARMEB__)
 	unsigned short st_rdev;
 	unsigned short __pad2;
+#else
+	unsigned long  st_rdev;
+#endif
 	unsigned long  st_size;
 	unsigned long  st_blksize;
 	unsigned long  st_blocks;
@@ -46,13 +54,7 @@
  * in the hope that the kernel has stretched to using larger sizes.
  */
 struct stat64 {
-#if defined(__ARMEB__)
-	unsigned char   __pad0b[6];
-	unsigned short  st_dev;
-#else
-	unsigned short  st_dev;
-	unsigned char   __pad0b[6];
-#endif
+	unsigned long long	st_dev;
 	unsigned char   __pad0[4];
 
 #define STAT64_HAS_BROKEN_ST_INO	1
@@ -63,13 +65,7 @@
 	unsigned long	st_uid;
 	unsigned long	st_gid;
 
-#if defined(__ARMEB__)
-	unsigned char   __pad3b[6];
-	unsigned short  st_rdev;
-#else /* Must be little */
-	unsigned short  st_rdev;
-	unsigned char   __pad3b[6];
-#endif
+	unsigned long long	st_rdev;
 	unsigned char   __pad3[4];
 
 	long long	st_size;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-cris/stat.h b/include/asm-cris/stat.h
--- a/include/asm-cris/stat.h	Fri Nov 22 22:40:13 2002
+++ b/include/asm-cris/stat.h	Mon Mar 24 13:31:10 2003
@@ -21,15 +21,13 @@
 #define STAT_HAVE_NSEC 1
 
 struct stat {
-	unsigned short st_dev;
-	unsigned short __pad1;
-	unsigned long st_ino;
+	unsigned long  st_dev;
+	unsigned long  st_ino;
 	unsigned short st_mode;
 	unsigned short st_nlink;
 	unsigned short st_uid;
 	unsigned short st_gid;
-	unsigned short st_rdev;
-	unsigned short __pad2;
+	unsigned long  st_rdev;
 	unsigned long  st_size;
 	unsigned long  st_blksize;
 	unsigned long  st_blocks;
@@ -47,8 +45,8 @@
  * insane amounts of padding around dev_t's.
  */
 struct stat64 {
-	unsigned short	st_dev;
-	unsigned char	__pad0[10];
+	unsigned long long	st_dev;
+	unsigned char	__pad0[4];
 
 #define STAT64_HAS_BROKEN_ST_INO	1
 	unsigned long	__st_ino;
@@ -59,8 +57,8 @@
 	unsigned long	st_uid;
 	unsigned long	st_gid;
 
-	unsigned short	st_rdev;
-	unsigned char	__pad3[10];
+	unsigned long long	st_rdev;
+	unsigned char	__pad3[4];
 
 	long long	st_size;
 	unsigned long	st_blksize;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-i386/stat.h b/include/asm-i386/stat.h
--- a/include/asm-i386/stat.h	Fri Nov 22 22:40:17 2002
+++ b/include/asm-i386/stat.h	Mon Mar 24 13:44:44 2003
@@ -16,15 +16,13 @@
 };
 
 struct stat {
-	unsigned short st_dev;
-	unsigned short __pad1;
-	unsigned long st_ino;
+	unsigned long  st_dev;
+	unsigned long  st_ino;
 	unsigned short st_mode;
 	unsigned short st_nlink;
 	unsigned short st_uid;
 	unsigned short st_gid;
-	unsigned short st_rdev;
-	unsigned short __pad2;
+	unsigned long  st_rdev;
 	unsigned long  st_size;
 	unsigned long  st_blksize;
 	unsigned long  st_blocks;
@@ -42,8 +40,8 @@
  * insane amounts of padding around dev_t's.
  */
 struct stat64 {
-	unsigned short	st_dev;
-	unsigned char	__pad0[10];
+	unsigned long long	st_dev;
+	unsigned char	__pad0[4];
 
 #define STAT64_HAS_BROKEN_ST_INO	1
 	unsigned long	__st_ino;
@@ -54,8 +52,8 @@
 	unsigned long	st_uid;
 	unsigned long	st_gid;
 
-	unsigned short	st_rdev;
-	unsigned char	__pad3[10];
+	unsigned long long	st_rdev;
+	unsigned char	__pad3[4];
 
 	long long	st_size;
 	unsigned long	st_blksize;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-m68k/stat.h b/include/asm-m68k/stat.h
--- a/include/asm-m68k/stat.h	Fri Nov 22 22:40:43 2002
+++ b/include/asm-m68k/stat.h	Mon Mar 24 13:45:15 2003
@@ -18,7 +18,7 @@
 struct stat {
 	unsigned short st_dev;
 	unsigned short __pad1;
-	unsigned long st_ino;
+	unsigned long  st_ino;
 	unsigned short st_mode;
 	unsigned short st_nlink;
 	unsigned short st_uid;
@@ -42,8 +42,7 @@
  * insane amounts of padding around dev_t's.
  */
 struct stat64 {
-	unsigned char	__pad0[6];
-	unsigned short	st_dev;
+	unsigned long long	st_dev;
 	unsigned char	__pad1[2];
 
 #define STAT64_HAS_BROKEN_ST_INO	1
@@ -55,8 +54,7 @@
 	unsigned long	st_uid;
 	unsigned long	st_gid;
 
-	unsigned char	__pad2[6];
-	unsigned short	st_rdev;
+	unsigned long long	st_rdev;
 	unsigned char	__pad3[2];
 
 	long long	st_size;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-s390/stat.h b/include/asm-s390/stat.h
--- a/include/asm-s390/stat.h	Fri Nov 22 22:41:09 2002
+++ b/include/asm-s390/stat.h	Mon Mar 24 13:47:05 2003
@@ -26,7 +26,7 @@
 struct stat {
         unsigned short st_dev;
         unsigned short __pad1;
-        unsigned long st_ino;
+        unsigned long  st_ino;
         unsigned short st_mode;
         unsigned short st_nlink;
         unsigned short st_uid;
@@ -52,8 +52,7 @@
  * insane amounts of padding around dev_t's.
  */
 struct stat64 {
-        unsigned char   __pad0[6];
-        unsigned short  st_dev;
+        unsigned long long	st_dev;
         unsigned int    __pad1;
 #define STAT64_HAS_BROKEN_ST_INO        1
         unsigned long   __st_ino;
@@ -61,10 +60,9 @@
         unsigned int    st_nlink;
         unsigned long   st_uid;
         unsigned long   st_gid;
-        unsigned char   __pad2[6];
-        unsigned short  st_rdev;
+        unsigned long long	st_rdev;
         unsigned int    __pad3;
-        long long       st_size;
+        long long	st_size;
         unsigned long   st_blksize;
         unsigned char   __pad4[4];
         unsigned long   __pad5;     /* future possible st_blocks high bits */
@@ -75,7 +73,7 @@
         unsigned long   st_mtime_nsec;
         unsigned long   st_ctime;
         unsigned long   st_ctime_nsec;  /* will be high 32 bits of ctime someday */
-        unsigned long long      st_ino;
+        unsigned long long	st_ino;
 };
 
 #endif
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sh/stat.h b/include/asm-sh/stat.h
--- a/include/asm-sh/stat.h	Fri Nov 22 22:40:15 2002
+++ b/include/asm-sh/stat.h	Mon Mar 24 13:42:52 2003
@@ -44,15 +44,7 @@
  * insane amounts of padding around dev_t's.
  */
 struct stat64 {
-#if defined(__BIG_ENDIAN__)
-	unsigned char   __pad0b[6];
-	unsigned short	st_dev;
-#elif defined(__LITTLE_ENDIAN__)
-	unsigned short	st_dev;
-	unsigned char	__pad0b[6];
-#else
-#error Must know endian to build stat64 structure!
-#endif
+	unsigned long long	st_dev;
 	unsigned char	__pad0[4];
 
 	unsigned long	st_ino;
@@ -62,13 +54,7 @@
 	unsigned long	st_uid;
 	unsigned long	st_gid;
 
-#if defined(__BIG_ENDIAN__)
-	unsigned char	__pad3b[6];
-	unsigned short	st_rdev;
-#else /* Must be little */
-	unsigned short	st_rdev;
-	unsigned char	__pad3b[6];
-#endif
+	unsigned long long	st_rdev;
 	unsigned char	__pad3[4];
 
 	long long	st_size;
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sparc/stat.h b/include/asm-sparc/stat.h
--- a/include/asm-sparc/stat.h	Fri Nov 22 22:40:50 2002
+++ b/include/asm-sparc/stat.h	Mon Mar 24 13:19:32 2003
@@ -41,10 +41,9 @@
 #define STAT_HAVE_NSEC 1
 
 struct stat64 {
-	unsigned char	__pad0[6];
-	unsigned short	st_dev;
+	unsigned long long st_dev;
 
-	unsigned long long	st_ino;
+	unsigned long long st_ino;
 
 	unsigned int	st_mode;
 	unsigned int	st_nlink;
@@ -52,8 +51,7 @@
 	unsigned int	st_uid;
 	unsigned int	st_gid;
 
-	unsigned char	__pad2[6];
-	unsigned short	st_rdev;
+	unsigned long long st_rdev;
 
 	unsigned char	__pad3[8];
 
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sparc64/stat.h b/include/asm-sparc64/stat.h
--- a/include/asm-sparc64/stat.h	Wed Jan  1 23:54:28 2003
+++ b/include/asm-sparc64/stat.h	Mon Mar 24 13:28:49 2003
@@ -25,8 +25,7 @@
 /* This is sparc32 stat64 structure. */
 
 struct stat64 {
-	unsigned char	__pad0[6];
-	unsigned short	st_dev;
+	unsigned long long	st_dev;
 
 	unsigned long long	st_ino;
 
@@ -36,8 +35,7 @@
 	unsigned int	st_uid;
 	unsigned int	st_gid;
 
-	unsigned char	__pad2[6];
-	unsigned short	st_rdev;
+	unsigned long long	st_rdev;
 
 	unsigned char	__pad3[8];
 
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-v850/stat.h b/include/asm-v850/stat.h
--- a/include/asm-v850/stat.h	Sat Jan 18 23:54:30 2003
+++ b/include/asm-v850/stat.h	Mon Mar 24 13:49:35 2003
@@ -17,14 +17,14 @@
 #include <asm/posix_types.h>
 
 struct stat {
-	__kernel_dev_t	st_dev;
-	__kernel_ino_t	st_ino;
-	__kernel_mode_t	st_mode;
-	__kernel_nlink_t st_nlink;
-	__kernel_uid_t 	st_uid;
-	__kernel_gid_t 	st_gid;
-	__kernel_dev_t	st_rdev;
-	__kernel_off_t	st_size;
+	unsigned int	st_dev;
+	unsigned long	st_ino;
+	unsigned int	st_mode;
+	unsigned int	st_nlink;
+	unsigned int 	st_uid;
+	unsigned int 	st_gid;
+	unsigned int	st_rdev;
+	long		st_size;
 	unsigned long	st_blksize;
 	unsigned long	st_blocks;
 	unsigned long	st_atime;
@@ -38,23 +38,21 @@
 };
 
 struct stat64 {
-	__kernel_dev_t	st_dev;
-	unsigned long	__unused0;
+	unsigned long long	st_dev;
 	unsigned long	__unused1;
 
-	__kernel_ino64_t st_ino;
+	unsigned long long	st_ino;
 
-	__kernel_mode_t	st_mode;
-	__kernel_nlink_t st_nlink;
+	unsigned int	st_mode;
+	unsigned int	st_nlink;
 
-	__kernel_uid_t	st_uid;
-	__kernel_gid_t	st_gid;
+	unsigned int	st_uid;
+	unsigned int	st_gid;
 
-	__kernel_dev_t	st_rdev;
-	unsigned long	__unused2;
+	unsigned long long	st_rdev;
 	unsigned long	__unused3;
 
-	__kernel_loff_t	st_size;
+	long long	st_size;
 	unsigned long	st_blksize;
 
 	unsigned long	st_blocks; /* No. of 512-byte blocks allocated */
