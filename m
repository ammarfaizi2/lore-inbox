Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbSLJGjp>; Tue, 10 Dec 2002 01:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbSLJGjp>; Tue, 10 Dec 2002 01:39:45 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:1749 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266717AbSLJGjm>;
	Tue, 10 Dec 2002 01:39:42 -0500
Date: Tue, 10 Dec 2002 17:47:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] consolidate sys32_times - mips64
Message-Id: <20021210174715.2d5e3dd6.sfr@canb.auug.org.au>
In-Reply-To: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
References: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

The mips64 patch ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.base/arch/mips64/kernel/linux32.c 2.5.51-32bit.1/arch/mips64/kernel/linux32.c
--- 2.5.51-32bit.base/arch/mips64/kernel/linux32.c	2002-12-10 15:46:41.000000000 +1100
+++ 2.5.51-32bit.1/arch/mips64/kernel/linux32.c	2002-12-10 17:00:58.000000000 +1100
@@ -1125,35 +1125,6 @@
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
 
diff -ruN 2.5.51-32bit.base/arch/mips64/kernel/scall_o32.S 2.5.51-32bit.1/arch/mips64/kernel/scall_o32.S
--- 2.5.51-32bit.base/arch/mips64/kernel/scall_o32.S	2002-12-10 15:46:41.000000000 +1100
+++ 2.5.51-32bit.1/arch/mips64/kernel/scall_o32.S	2002-12-10 17:02:02.000000000 +1100
@@ -276,7 +276,7 @@
 	sys	sys_rmdir	1			/* 4040 */
 	sys	sys_dup		1
 	sys	sys_pipe	0
-	sys	sys32_times	1
+	sys	compat_sys_times	1
 	sys	sys_ni_syscall	0
 	sys	sys_brk		1			/* 4045 */
 	sys	sys_setgid	1
diff -ruN 2.5.51-32bit.base/include/asm-mips64/compat.h 2.5.51-32bit.1/include/asm-mips64/compat.h
--- 2.5.51-32bit.base/include/asm-mips64/compat.h	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-mips64/compat.h	2002-12-10 16:37:59.000000000 +1100
@@ -5,9 +5,12 @@
  */
 #include <linux/types.h>
 
+#define COMPAT_USER_HZ	100
+
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
+typedef s32		compat_clock_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -ruN 2.5.51-32bit.base/include/asm-mips64/posix_types.h 2.5.51-32bit.1/include/asm-mips64/posix_types.h
--- 2.5.51-32bit.base/include/asm-mips64/posix_types.h	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-mips64/posix_types.h	2002-12-10 15:42:41.000000000 +1100
@@ -58,9 +58,6 @@
 typedef int		__kernel_ipc_pid_t32;
 typedef int		__kernel_uid_t32;
 typedef int		__kernel_gid_t32;
-typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_suseconds_t32;
-typedef int		__kernel_clock_t32;
 typedef int		__kernel_daddr_t32;
 typedef unsigned int	__kernel_caddr_t32;
 typedef __kernel_fsid_t	__kernel_fsid_t32;
