Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbSLJGhK>; Tue, 10 Dec 2002 01:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbSLJGhK>; Tue, 10 Dec 2002 01:37:10 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:55252 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266688AbSLJGhD>;
	Tue, 10 Dec 2002 01:37:03 -0500
Date: Tue, 10 Dec 2002 17:44:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] consolidate sys32_times - s390x
Message-Id: <20021210174440.7be2bc6e.sfr@canb.auug.org.au>
In-Reply-To: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
References: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

The s390x patch ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.base/arch/s390x/kernel/entry.S 2.5.51-32bit.1/arch/s390x/kernel/entry.S
--- 2.5.51-32bit.base/arch/s390x/kernel/entry.S	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/arch/s390x/kernel/entry.S	2002-12-10 17:05:19.000000000 +1100
@@ -419,7 +419,7 @@
         .long  SYSCALL(sys_rmdir,sys32_rmdir_wrapper)           /* 40 */
         .long  SYSCALL(sys_dup,sys32_dup_wrapper)
         .long  SYSCALL(sys_pipe,sys32_pipe_wrapper)
-        .long  SYSCALL(sys_times,sys32_times_wrapper)
+        .long  SYSCALL(sys_times,compat_sys_times_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old prof syscall */
         .long  SYSCALL(sys_brk,sys32_brk_wrapper)               /* 45 */
         .long  SYSCALL(sys_ni_syscall,sys32_setgid16)   /* old setgid16 syscall*/
diff -ruN 2.5.51-32bit.base/arch/s390x/kernel/linux32.c 2.5.51-32bit.1/arch/s390x/kernel/linux32.c
--- 2.5.51-32bit.base/arch/s390x/kernel/linux32.c	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/arch/s390x/kernel/linux32.c	2002-12-10 17:05:51.000000000 +1100
@@ -1930,36 +1930,6 @@
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
 #define RLIM_OLD_INFINITY32	0x7fffffff
 #define RLIM_INFINITY32		0xffffffff
 #define RESOURCE32_OLD(x)	((x > RLIM_OLD_INFINITY32) ? RLIM_OLD_INFINITY32 : x)
diff -ruN 2.5.51-32bit.base/arch/s390x/kernel/linux32.h 2.5.51-32bit.1/arch/s390x/kernel/linux32.h
--- 2.5.51-32bit.base/arch/s390x/kernel/linux32.h	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/arch/s390x/kernel/linux32.h	2002-12-10 15:40:49.000000000 +1100
@@ -16,8 +16,6 @@
 	((unsigned long)(__x))
 
 /* Now 32bit compatibility types */
-typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_clock_t32;
 typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
 typedef unsigned short         __kernel_uid_t32;
@@ -139,8 +137,8 @@
 			pid_t			_pid;	/* which child */
 			uid_t			_uid;	/* sender's uid */
 			int			_status;/* exit code */
-			__kernel_clock_t32	_utime;
-			__kernel_clock_t32	_stime;
+			compat_clock_t		_utime;
+			compat_clock_t		_stime;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
diff -ruN 2.5.51-32bit.base/arch/s390x/kernel/wrapper32.S 2.5.51-32bit.1/arch/s390x/kernel/wrapper32.S
--- 2.5.51-32bit.base/arch/s390x/kernel/wrapper32.S	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/arch/s390x/kernel/wrapper32.S	2002-12-10 17:04:36.000000000 +1100
@@ -182,10 +182,10 @@
 	llgtr	%r2,%r2			# u32 *
 	jg	sys_pipe		# branch to system call
 
-	.globl  sys32_times_wrapper 
-sys32_times_wrapper:
-	llgtr	%r2,%r2			# struct tms_emu31 *
-	jg	sys32_times		# branch to system call
+	.globl  compat_sys_times_wrapper 
+compat_sys_times_wrapper:
+	llgtr	%r2,%r2			# struct compat_tms *
+	jg	compat_sys_times	# branch to system call
 
 	.globl  sys32_brk_wrapper 
 sys32_brk_wrapper:
diff -ruN 2.5.51-32bit.base/include/asm-s390x/compat.h 2.5.51-32bit.1/include/asm-s390x/compat.h
--- 2.5.51-32bit.base/include/asm-s390x/compat.h	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-s390x/compat.h	2002-12-10 16:38:17.000000000 +1100
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
