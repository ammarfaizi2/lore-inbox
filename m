Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbSLJGcT>; Tue, 10 Dec 2002 01:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266676AbSLJGcT>; Tue, 10 Dec 2002 01:32:19 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:28116 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266675AbSLJGcP>;
	Tue, 10 Dec 2002 01:32:15 -0500
Date: Tue, 10 Dec 2002 17:39:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] consolidate sys32_times - sparc64
Message-Id: <20021210173951.0b351c90.sfr@canb.auug.org.au>
In-Reply-To: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
References: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

The sparc64 patch ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.base/arch/sparc64/kernel/sys_sparc32.c 2.5.51-32bit.1/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.51-32bit.base/arch/sparc64/kernel/sys_sparc32.c	2002-12-10 15:10:17.000000000 +1100
+++ 2.5.51-32bit.1/arch/sparc64/kernel/sys_sparc32.c	2002-12-10 17:06:24.000000000 +1100
@@ -1986,36 +1986,6 @@
 	return ret;
 }
 
-struct tms32 {
-	__kernel_clock_t32 tms_utime;
-	__kernel_clock_t32 tms_stime;
-	__kernel_clock_t32 tms_cutime;
-	__kernel_clock_t32 tms_cstime;
-};
-                                
-extern asmlinkage long sys_times(struct tms * tbuf);
-
-asmlinkage long sys32_times(struct tms32 *tbuf)
-{
-	struct tms t;
-	long ret;
-	mm_segment_t old_fs = get_fs ();
-	int err;
-	
-	set_fs (KERNEL_DS);
-	ret = sys_times(tbuf ? &t : NULL);
-	set_fs (old_fs);
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
 #define RLIM_INFINITY32	0x7fffffff
 #define RESOURCE32(x) ((x > RLIM_INFINITY32) ? RLIM_INFINITY32 : x)
 
diff -ruN 2.5.51-32bit.base/arch/sparc64/kernel/systbls.S 2.5.51-32bit.1/arch/sparc64/kernel/systbls.S
--- 2.5.51-32bit.base/arch/sparc64/kernel/systbls.S	2002-12-10 15:10:17.000000000 +1100
+++ 2.5.51-32bit.1/arch/sparc64/kernel/systbls.S	2002-12-10 17:06:07.000000000 +1100
@@ -27,7 +27,7 @@
 /*25*/	.word sys_time, sys_ptrace, sys_alarm, sys32_sigaltstack, sys32_pause
 /*30*/	.word compat_sys_utime, sys_lchown, sys_fchown, sys_access, sys_nice
 	.word sys_chown, sys_sync, sys_kill, sys32_newstat, sys32_sendfile
-/*40*/	.word sys32_newlstat, sys_dup, sys_pipe, sys32_times, sys_getuid
+/*40*/	.word sys32_newlstat, sys_dup, sys_pipe, compat_sys_times, sys_getuid
 	.word sys_umount, sys32_setgid16, sys32_getgid16, sys_signal, sys32_geteuid16
 /*50*/	.word sys32_getegid16, sys_acct, sys_nis_syscall, sys_getgid, sys32_ioctl
 	.word sys_reboot, sys32_mmap2, sys_symlink, sys_readlink, sys32_execve
diff -ruN 2.5.51-32bit.base/include/asm-sparc64/compat.h 2.5.51-32bit.1/include/asm-sparc64/compat.h
--- 2.5.51-32bit.base/include/asm-sparc64/compat.h	2002-12-10 15:10:40.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-sparc64/compat.h	2002-12-10 16:38:22.000000000 +1100
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
diff -ruN 2.5.51-32bit.base/include/asm-sparc64/posix_types.h 2.5.51-32bit.1/include/asm-sparc64/posix_types.h
--- 2.5.51-32bit.base/include/asm-sparc64/posix_types.h	2002-12-10 15:10:40.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-sparc64/posix_types.h	2002-12-10 15:42:57.000000000 +1100
@@ -48,8 +48,6 @@
 } __kernel_fsid_t;
 
 /* Now 32bit compatibility types */
-typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_clock_t32;
 typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
 typedef unsigned short         __kernel_uid_t32;
diff -ruN 2.5.51-32bit.base/include/asm-sparc64/siginfo.h 2.5.51-32bit.1/include/asm-sparc64/siginfo.h
--- 2.5.51-32bit.base/include/asm-sparc64/siginfo.h	2002-10-21 01:02:53.000000000 +1000
+++ 2.5.51-32bit.1/include/asm-sparc64/siginfo.h	2002-12-10 15:43:53.000000000 +1100
@@ -13,6 +13,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/compat.h>
+
 typedef union sigval32 {
 	int sival_int;
 	u32 sival_ptr;
@@ -50,8 +52,8 @@
 			__kernel_pid_t32 _pid;		/* which child */
 			unsigned int _uid;		/* sender's uid */
 			int _status;			/* exit code */
-			__kernel_clock_t32 _utime;
-			__kernel_clock_t32 _stime;
+			compat_clock_t _utime;
+			compat_clock_t _stime;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
