Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWBLLfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWBLLfS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 06:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWBLLfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 06:35:17 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:38805 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750909AbWBLLfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 06:35:16 -0500
Date: Sun, 12 Feb 2006 12:35:03 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] s390: fstatat64 support
Message-ID: <20060212113503.GA23520@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Heiko Carstens <heiko.carstens@de.ibm.com>

Add fstatat64 support to s390 in order to follow changes with
commit cff2b760096d1e6feaa31948e7af4abbefe47822 .
Also fixes compilation for 31 bit.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/compat_wrapper.S |    8 ++++----
 arch/s390/kernel/syscalls.S       |    2 +-
 include/asm-s390/unistd.h         |    4 +++-
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index cc20f0e..2d02162 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -905,6 +905,26 @@ asmlinkage long sys32_fstat64(unsigned l
 	return ret;
 }
 
+asmlinkage long sys32_fstatat(unsigned int dfd, char __user *filename,
+			      struct stat64_emu31 __user* statbuf, int flag)
+{
+	struct kstat stat;
+	int error = -EINVAL;
+
+	if ((flag & ~AT_SYMLINK_NOFOLLOW) != 0)
+		goto out;
+
+	if (flag & AT_SYMLINK_NOFOLLOW)
+		error = vfs_lstat_fd(dfd, filename, &stat);
+	else
+		error = vfs_stat_fd(dfd, filename, &stat);
+
+	if (!error)
+		error = cp_stat64(statbuf, &stat);
+out:
+	return error;
+}
+
 /*
  * Linux/i386 didn't use to be able to handle more than
  * 4 system call parameters, so these system calls used a memory
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 38a6ef5..dd2d6c3 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1523,13 +1523,13 @@ compat_sys_futimesat_wrapper:
 	llgtr	%r4,%r4			# struct timeval *
 	jg	compat_sys_futimesat
 
-	.globl compat_sys_newfstatat_wrapper
-compat_sys_newfstatat_wrapper:
+	.globl sys32_fstatat_wrapper
+sys32_fstatat_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# char *
-	llgtr	%r4,%r4			# struct stat *
+	llgtr	%r4,%r4			# struct stat64 *
 	lgfr	%r5,%r5			# int
-	jg	compat_sys_newfstatat
+	jg	sys32_fstatat
 
 	.globl sys_unlinkat_wrapper
 sys_unlinkat_wrapper:
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index e86a4de..84921fe 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -301,7 +301,7 @@ SYSCALL(sys_mkdirat,sys_mkdirat,sys_mkdi
 SYSCALL(sys_mknodat,sys_mknodat,sys_mknodat_wrapper)	/* 290 */
 SYSCALL(sys_fchownat,sys_fchownat,sys_fchownat_wrapper)
 SYSCALL(sys_futimesat,sys_futimesat,compat_sys_futimesat_wrapper)
-SYSCALL(sys_newfstatat,sys_newfstatat,compat_sys_newfstatat_wrapper)
+SYSCALL(sys_fstatat64,sys_newfstatat,sys32_fstatat_wrapper)
 SYSCALL(sys_unlinkat,sys_unlinkat,sys_unlinkat_wrapper)
 SYSCALL(sys_renameat,sys_renameat,sys_renameat_wrapper)	/* 295 */
 SYSCALL(sys_linkat,sys_linkat,sys_linkat_wrapper)
diff --git a/include/asm-s390/unistd.h b/include/asm-s390/unistd.h
index 0a2f666..657d582 100644
--- a/include/asm-s390/unistd.h
+++ b/include/asm-s390/unistd.h
@@ -285,7 +285,7 @@
 #define __NR_mknodat		290
 #define __NR_fchownat		291
 #define __NR_futimesat		292
-#define __NR_newfstatat		293
+#define __NR_fstatat64		293
 #define __NR_unlinkat		294
 #define __NR_renameat		295
 #define __NR_linkat		296
@@ -359,6 +359,7 @@
 #undef  __NR_fcntl64
 #undef  __NR_sendfile64
 #undef  __NR_fadvise64_64
+#undef  __NR_fstatat64
 
 #define __NR_select		142
 #define __NR_getrlimit		191	/* SuS compliant getrlimit */
@@ -381,6 +382,7 @@
 #define __NR_setgid  		214
 #define __NR_setfsuid  		215
 #define __NR_setfsgid  		216
+#define __NR_newfstatat		293
 
 #endif
 
