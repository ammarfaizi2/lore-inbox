Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266652AbSLJGaj>; Tue, 10 Dec 2002 01:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266654AbSLJGaj>; Tue, 10 Dec 2002 01:30:39 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:15828 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266652AbSLJGah>;
	Tue, 10 Dec 2002 01:30:37 -0500
Date: Tue, 10 Dec 2002 17:38:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: anton@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] consolidate sys32_times - ppc64
Message-Id: <20021210173817.6bb1c536.sfr@canb.auug.org.au>
In-Reply-To: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
References: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

This is the ppc specific patch ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.base/arch/ppc64/kernel/misc.S 2.5.51-32bit.1/arch/ppc64/kernel/misc.S
--- 2.5.51-32bit.base/arch/ppc64/kernel/misc.S	2002-12-10 15:10:16.000000000 +1100
+++ 2.5.51-32bit.1/arch/ppc64/kernel/misc.S	2002-12-10 17:06:50.000000000 +1100
@@ -551,7 +551,7 @@
 	.llong .sys_rmdir		/* 40 */
 	.llong .sys_dup
 	.llong .sys_pipe
-	.llong .sys32_times
+	.llong .compat_sys_times
 	.llong .sys_ni_syscall		/* old prof syscall */
 	.llong .sys_brk			/* 45 */
 	.llong .sys_setgid
diff -ruN 2.5.51-32bit.base/arch/ppc64/kernel/sys_ppc32.c 2.5.51-32bit.1/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.51-32bit.base/arch/ppc64/kernel/sys_ppc32.c	2002-12-10 15:10:16.000000000 +1100
+++ 2.5.51-32bit.1/arch/ppc64/kernel/sys_ppc32.c	2002-12-10 17:07:08.000000000 +1100
@@ -2076,37 +2076,6 @@
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
-	
-	return ret;
-}
-
 struct msgbuf32 { s32 mtype; char mtext[1]; };
 
 struct semid_ds32 {
diff -ruN 2.5.51-32bit.base/include/asm-ppc64/compat.h 2.5.51-32bit.1/include/asm-ppc64/compat.h
--- 2.5.51-32bit.base/include/asm-ppc64/compat.h	2002-12-10 15:10:39.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-ppc64/compat.h	2002-12-10 16:38:13.000000000 +1100
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
diff -ruN 2.5.51-32bit.base/include/asm-ppc64/ppc32.h 2.5.51-32bit.1/include/asm-ppc64/ppc32.h
--- 2.5.51-32bit.base/include/asm-ppc64/ppc32.h	2002-12-10 15:10:39.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-ppc64/ppc32.h	2002-12-10 15:44:11.000000000 +1100
@@ -44,8 +44,6 @@
 })
 
 /* These are here to support 32-bit syscalls on a 64-bit kernel. */
-typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_clock_t32;
 typedef int		__kernel_pid_t32;
 typedef unsigned short	__kernel_ipc_pid_t32;
 typedef unsigned int	__kernel_uid_t32;
@@ -110,8 +108,8 @@
 			__kernel_pid_t32 _pid;		/* which child */
 			__kernel_uid_t32 _uid;		/* sender's uid */
 			int _status;			/* exit code */
-			__kernel_clock_t32 _utime;
-			__kernel_clock_t32 _stime;
+			compat_clock_t _utime;
+			compat_clock_t _stime;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
