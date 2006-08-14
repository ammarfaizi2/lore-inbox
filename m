Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWHNVQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWHNVQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWHNVP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:15:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48601 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964909AbWHNVPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:15:43 -0400
From: David Howells <dhowells@redhat.com>
Subject: [RHEL5 PATCH 2/4] VFS: Make inode numbers 64-bits
Date: Mon, 14 Aug 2006 22:15:09 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org#,
       dhowells@redhat.com
Message-Id: <20060814211509.27190.51352.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
References: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the in-kernel representations of inode number 64-bit in size at a minimum
as some network filesystems (eg: NFS) and local filesystems (eg: XFS) provide
such.

The 64-bit inode number will be returned through stat64() and getdents64() on
archs that are currently set up to do so.

This patch changes __kernel_ino_t to be "unsigned long long" on all archs, but
changes usages of that in struct stat to be the old type so that the userspace
interface does not change.  The 64-bit division patch is required to get this
to link on some archs.

struct inode::i_ino and struct kstat::ino have been converted to ino_t.
Neither needs moving within the bounds of its parent structure to make sure
that they reside on a 64-bit boundary if the structure itself does so.

Without this patch, on 32-bit archs, 64-bit inode numbers are rendered as
32-bit values, zero-extended to 64-bits for return through stat64() and
getdents64().  This can cause problems in userspace as programs such as ld.so
attempt to distinguish files based on their device and inode numbers.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-alpha/posix_types.h   |    2 +-
 include/asm-arm/posix_types.h     |    2 +-
 include/asm-arm26/posix_types.h   |    2 +-
 include/asm-cris/posix_types.h    |    2 +-
 include/asm-frv/posix_types.h     |    2 +-
 include/asm-h8300/posix_types.h   |    2 +-
 include/asm-i386/posix_types.h    |    2 +-
 include/asm-ia64/posix_types.h    |    2 +-
 include/asm-m32r/posix_types.h    |    2 +-
 include/asm-m68k/posix_types.h    |    2 +-
 include/asm-mips/posix_types.h    |    2 +-
 include/asm-mips/stat.h           |    2 +-
 include/asm-parisc/posix_types.h  |    2 +-
 include/asm-parisc/stat.h         |    2 +-
 include/asm-powerpc/posix_types.h |    2 +-
 include/asm-powerpc/stat.h        |    2 +-
 include/asm-s390/posix_types.h    |    4 ++--
 include/asm-sh/posix_types.h      |    2 +-
 include/asm-sh64/posix_types.h    |    2 +-
 include/asm-sparc/posix_types.h   |    2 +-
 include/asm-sparc64/posix_types.h |    2 +-
 include/asm-sparc64/stat.h        |    2 +-
 include/asm-v850/posix_types.h    |    2 +-
 include/asm-x86_64/posix_types.h  |    2 +-
 include/asm-xtensa/posix_types.h  |    2 +-
 include/linux/fs.h                |    2 +-
 include/linux/stat.h              |    2 +-
 27 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/asm-alpha/posix_types.h b/include/asm-alpha/posix_types.h
index c78c04a..bbc5a0f 100644
--- a/include/asm-alpha/posix_types.h
+++ b/include/asm-alpha/posix_types.h
@@ -7,7 +7,7 @@ #define _ALPHA_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned int	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned int	__kernel_mode_t;
 typedef unsigned int	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/asm-arm/posix_types.h b/include/asm-arm/posix_types.h
index e142a2a..708f9a1 100644
--- a/include/asm-arm/posix_types.h
+++ b/include/asm-arm/posix_types.h
@@ -19,7 +19,7 @@ #define __ARCH_ARM_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long		__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned short		__kernel_mode_t;
 typedef unsigned short		__kernel_nlink_t;
 typedef long			__kernel_off_t;
diff --git a/include/asm-arm26/posix_types.h b/include/asm-arm26/posix_types.h
index f8d1eb4..25b05b0 100644
--- a/include/asm-arm26/posix_types.h
+++ b/include/asm-arm26/posix_types.h
@@ -19,7 +19,7 @@ #define __ARCH_ARM_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long		__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned short		__kernel_mode_t;
 typedef unsigned short		__kernel_nlink_t;
 typedef long			__kernel_off_t;
diff --git a/include/asm-cris/posix_types.h b/include/asm-cris/posix_types.h
index 6d26fee..c1ce6f3 100644
--- a/include/asm-cris/posix_types.h
+++ b/include/asm-cris/posix_types.h
@@ -14,7 +14,7 @@ #include <asm/bitops.h>
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long __kernel_ino_t;
 typedef unsigned short	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/asm-frv/posix_types.h b/include/asm-frv/posix_types.h
index 73c2ba8..1522ea9 100644
--- a/include/asm-frv/posix_types.h
+++ b/include/asm-frv/posix_types.h
@@ -7,7 +7,7 @@ #define _ASM_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned short	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/asm-h8300/posix_types.h b/include/asm-h8300/posix_types.h
index 7de94b1..0122b26 100644
--- a/include/asm-h8300/posix_types.h
+++ b/include/asm-h8300/posix_types.h
@@ -7,7 +7,7 @@ #define __ARCH_H8300_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned short	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/asm-i386/posix_types.h b/include/asm-i386/posix_types.h
index 133e31e..1c4d743 100644
--- a/include/asm-i386/posix_types.h
+++ b/include/asm-i386/posix_types.h
@@ -7,7 +7,7 @@ #define __ARCH_I386_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned short	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/asm-ia64/posix_types.h b/include/asm-ia64/posix_types.h
index adb6227..37169ee 100644
--- a/include/asm-ia64/posix_types.h
+++ b/include/asm-ia64/posix_types.h
@@ -12,7 +12,7 @@ #define _ASM_IA64_POSIX_TYPES_H
  *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned int	__kernel_mode_t;
 typedef unsigned int	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/asm-m32r/posix_types.h b/include/asm-m32r/posix_types.h
index 47e7e85..46e0a65 100644
--- a/include/asm-m32r/posix_types.h
+++ b/include/asm-m32r/posix_types.h
@@ -11,7 +11,7 @@ #define _ASM_M32R_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned short	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/asm-m68k/posix_types.h b/include/asm-m68k/posix_types.h
index fa166ee..6152981 100644
--- a/include/asm-m68k/posix_types.h
+++ b/include/asm-m68k/posix_types.h
@@ -7,7 +7,7 @@ #define __ARCH_M68K_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned short	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/asm-mips/posix_types.h b/include/asm-mips/posix_types.h
index c2e8a00..8e3e3f5 100644
--- a/include/asm-mips/posix_types.h
+++ b/include/asm-mips/posix_types.h
@@ -17,7 +17,7 @@ #include <asm/sgidefs.h>
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned int	__kernel_mode_t;
 #if (_MIPS_SZLONG == 32)
 typedef unsigned long	__kernel_nlink_t;
diff --git a/include/asm-mips/stat.h b/include/asm-mips/stat.h
index 6e00f75..32e5c45 100644
--- a/include/asm-mips/stat.h
+++ b/include/asm-mips/stat.h
@@ -18,7 +18,7 @@ #if (_MIPS_SIM == _MIPS_SIM_ABI32) || (_
 struct stat {
 	unsigned	st_dev;
 	long		st_pad1[3];		/* Reserved for network id */
-	ino_t		st_ino;
+	unsigned long	st_ino;
 	mode_t		st_mode;
 	nlink_t		st_nlink;
 	uid_t		st_uid;
diff --git a/include/asm-parisc/posix_types.h b/include/asm-parisc/posix_types.h
index 9b19970..1e63cdf 100644
--- a/include/asm-parisc/posix_types.h
+++ b/include/asm-parisc/posix_types.h
@@ -6,7 +6,7 @@ #define __ARCH_PARISC_POSIX_TYPES_H
  * be a little careful about namespace pollution etc.  Also, we cannot
  * assume GCC is being used.
  */
-typedef unsigned long		__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned short		__kernel_mode_t;
 typedef unsigned short		__kernel_nlink_t;
 typedef long			__kernel_off_t;
diff --git a/include/asm-parisc/stat.h b/include/asm-parisc/stat.h
index 9d5fbbc..399a109 100644
--- a/include/asm-parisc/stat.h
+++ b/include/asm-parisc/stat.h
@@ -40,7 +40,7 @@ typedef __kernel_off64_t	off64_t;
 
 struct hpux_stat64 {
 	unsigned int	st_dev;		/* dev_t is 32 bits on parisc */
-	ino_t           st_ino;         /* 32 bits */
+	unsigned long   st_ino;         /* 32 bits */
 	mode_t		st_mode;	/* 16 bits */
 	nlink_t		st_nlink;	/* 16 bits */
 	unsigned short	st_reserved1;	/* old st_uid */
diff --git a/include/asm-powerpc/posix_types.h b/include/asm-powerpc/posix_types.h
index c639107..72d5047 100644
--- a/include/asm-powerpc/posix_types.h
+++ b/include/asm-powerpc/posix_types.h
@@ -7,7 +7,7 @@ #define _ASM_POWERPC_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned int	__kernel_mode_t;
 typedef long		__kernel_off_t;
 typedef int		__kernel_pid_t;
diff --git a/include/asm-powerpc/stat.h b/include/asm-powerpc/stat.h
index e4edc51..02dd186 100644
--- a/include/asm-powerpc/stat.h
+++ b/include/asm-powerpc/stat.h
@@ -28,7 +28,7 @@ #endif /* !__powerpc64__ */
 
 struct stat {
 	unsigned long	st_dev;
-	ino_t		st_ino;
+	unsigned long	st_ino;
 #ifdef __powerpc64__
 	nlink_t		st_nlink;
 	mode_t		st_mode;
diff --git a/include/asm-s390/posix_types.h b/include/asm-s390/posix_types.h
index b94c988..c853731 100644
--- a/include/asm-s390/posix_types.h
+++ b/include/asm-s390/posix_types.h
@@ -34,7 +34,7 @@ #endif
 
 #ifndef __s390x__
 
-typedef unsigned long   __kernel_ino_t;
+typedef unsigned long long   __kernel_ino_t;
 typedef unsigned short  __kernel_mode_t;
 typedef unsigned short  __kernel_nlink_t;
 typedef unsigned short  __kernel_ipc_pid_t;
@@ -50,7 +50,7 @@ typedef unsigned short	__kernel_old_dev_
 
 #else /* __s390x__ */
 
-typedef unsigned int    __kernel_ino_t;
+typedef unsigned long long    __kernel_ino_t;
 typedef unsigned int    __kernel_mode_t;
 typedef unsigned int    __kernel_nlink_t;
 typedef int             __kernel_ipc_pid_t;
diff --git a/include/asm-sh/posix_types.h b/include/asm-sh/posix_types.h
index 0a3d2f5..7a2d0b7 100644
--- a/include/asm-sh/posix_types.h
+++ b/include/asm-sh/posix_types.h
@@ -7,7 +7,7 @@ #define __ASM_SH_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned short	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/asm-sh64/posix_types.h b/include/asm-sh64/posix_types.h
index 0620317..affa4b7 100644
--- a/include/asm-sh64/posix_types.h
+++ b/include/asm-sh64/posix_types.h
@@ -16,7 +16,7 @@ #define __ASM_SH64_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned short	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/asm-sparc/posix_types.h b/include/asm-sparc/posix_types.h
index 9ef1b3d..0d4a5fe 100644
--- a/include/asm-sparc/posix_types.h
+++ b/include/asm-sparc/posix_types.h
@@ -17,7 +17,7 @@ typedef int                    __kernel_
 typedef unsigned short         __kernel_ipc_pid_t;
 typedef unsigned short         __kernel_uid_t;
 typedef unsigned short         __kernel_gid_t;
-typedef unsigned long          __kernel_ino_t;
+typedef unsigned long long     __kernel_ino_t;
 typedef unsigned short         __kernel_mode_t;
 typedef unsigned short         __kernel_umode_t;
 typedef short                  __kernel_nlink_t;
diff --git a/include/asm-sparc64/posix_types.h b/include/asm-sparc64/posix_types.h
index c86b945..3cbba61 100644
--- a/include/asm-sparc64/posix_types.h
+++ b/include/asm-sparc64/posix_types.h
@@ -16,7 +16,7 @@ typedef int                    __kernel_
 typedef int                    __kernel_ipc_pid_t;
 typedef unsigned int           __kernel_uid_t;
 typedef unsigned int           __kernel_gid_t;
-typedef unsigned long          __kernel_ino_t;
+typedef unsigned long long     __kernel_ino_t;
 typedef unsigned int           __kernel_mode_t;
 typedef unsigned short         __kernel_umode_t;
 typedef unsigned int           __kernel_nlink_t;
diff --git a/include/asm-sparc64/stat.h b/include/asm-sparc64/stat.h
index 128c27e..644dc4d 100644
--- a/include/asm-sparc64/stat.h
+++ b/include/asm-sparc64/stat.h
@@ -6,7 +6,7 @@ #include <linux/types.h>
 
 struct stat {
 	unsigned   st_dev;
-	ino_t   st_ino;
+	unsigned long   st_ino;
 	mode_t  st_mode;
 	short   st_nlink;
 	uid_t   st_uid;
diff --git a/include/asm-v850/posix_types.h b/include/asm-v850/posix_types.h
index ccb7297..ea6ccb6 100644
--- a/include/asm-v850/posix_types.h
+++ b/include/asm-v850/posix_types.h
@@ -14,7 +14,7 @@
 #ifndef __V850_POSIX_TYPES_H__
 #define __V850_POSIX_TYPES_H__
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long __kernel_ino_t;
 typedef unsigned long long __kernel_ino64_t;
 typedef unsigned int	__kernel_mode_t;
 typedef unsigned int	__kernel_nlink_t;
diff --git a/include/asm-x86_64/posix_types.h b/include/asm-x86_64/posix_types.h
index 9926aa4..c287564 100644
--- a/include/asm-x86_64/posix_types.h
+++ b/include/asm-x86_64/posix_types.h
@@ -7,7 +7,7 @@ #define _ASM_X86_64_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned int	__kernel_mode_t;
 typedef unsigned long	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/asm-xtensa/posix_types.h b/include/asm-xtensa/posix_types.h
index 2c816b0..30b8ca4 100644
--- a/include/asm-xtensa/posix_types.h
+++ b/include/asm-xtensa/posix_types.h
@@ -19,7 +19,7 @@ #define _XTENSA_POSIX_TYPES_H
  * assume GCC is being used.
  */
 
-typedef unsigned long	__kernel_ino_t;
+typedef unsigned long long	__kernel_ino_t;
 typedef unsigned int	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
 typedef long		__kernel_off_t;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cc9657..caa9182 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -499,7 +499,7 @@ struct inode {
 	struct list_head	i_list;
 	struct list_head	i_sb_list;
 	struct list_head	i_dentry;
-	unsigned long		i_ino;
+	ino_t			i_ino;
 	atomic_t		i_count;
 	umode_t			i_mode;
 	unsigned int		i_nlink;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 8669291..967cfbe 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,7 +57,7 @@ #include <linux/types.h>
 #include <linux/time.h>
 
 struct kstat {
-	unsigned long	ino;
+	ino_t		ino;
 	dev_t		dev;
 	umode_t		mode;
 	unsigned int	nlink;
