Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266676AbSLJGeE>; Tue, 10 Dec 2002 01:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266682AbSLJGeD>; Tue, 10 Dec 2002 01:34:03 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:35028 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266676AbSLJGeA>;
	Tue, 10 Dec 2002 01:34:00 -0500
Date: Tue, 10 Dec 2002 17:41:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] consolidate sys32_times - x86_64
Message-Id: <20021210174136.6443b188.sfr@canb.auug.org.au>
In-Reply-To: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
References: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

The x86_64 patch ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.base/arch/x86_64/ia32/ia32entry.S 2.5.51-32bit.1/arch/x86_64/ia32/ia32entry.S
--- 2.5.51-32bit.base/arch/x86_64/ia32/ia32entry.S	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/arch/x86_64/ia32/ia32entry.S	2002-12-10 17:07:24.000000000 +1100
@@ -164,7 +164,7 @@
 	.quad sys_rmdir		/* 40 */
 	.quad sys_dup
 	.quad sys32_pipe
-	.quad sys32_times
+	.quad compat_sys_times
 	.quad ni_syscall			/* old prof syscall holder */
 	.quad sys_brk		/* 45 */
 	.quad sys_setgid16
diff -ruN 2.5.51-32bit.base/arch/x86_64/ia32/sys_ia32.c 2.5.51-32bit.1/arch/x86_64/ia32/sys_ia32.c
--- 2.5.51-32bit.base/arch/x86_64/ia32/sys_ia32.c	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/arch/x86_64/ia32/sys_ia32.c	2002-12-10 17:07:52.000000000 +1100
@@ -1107,37 +1107,6 @@
 	return ret;
 }
 
-struct tms32 {
-	__kernel_clock_t32 tms_utime;
-	__kernel_clock_t32 tms_stime;
-	__kernel_clock_t32 tms_cutime;
-	__kernel_clock_t32 tms_cstime;
-};
-                                
-extern int sys_times(struct tms *);
-
-asmlinkage long
-sys32_times(struct tms32 *tbuf)
-{
-	struct tms t;
-	long ret;
-	mm_segment_t old_fs = get_fs ();
-	
-	set_fs (KERNEL_DS);
-	ret = sys_times(tbuf ? &t : NULL);
-	set_fs (old_fs);
-	if (tbuf) {
-		if (verify_area(VERIFY_WRITE, tbuf, sizeof(struct tms32)) ||
-		    __put_user (t.tms_utime, &tbuf->tms_utime) ||
-		    __put_user (t.tms_stime, &tbuf->tms_stime) ||
-		    __put_user (t.tms_cutime, &tbuf->tms_cutime) ||
-		    __put_user (t.tms_cstime, &tbuf->tms_cstime))
-			return -EFAULT;
-	}
-	return ret;
-}
-
-
 static inline int get_flock(struct flock *kfl, struct flock32 *ufl)
 {
 	int err;
diff -ruN 2.5.51-32bit.base/include/asm-x86_64/compat.h 2.5.51-32bit.1/include/asm-x86_64/compat.h
--- 2.5.51-32bit.base/include/asm-x86_64/compat.h	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-x86_64/compat.h	2002-12-10 16:38:26.000000000 +1100
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
diff -ruN 2.5.51-32bit.base/include/asm-x86_64/ia32.h 2.5.51-32bit.1/include/asm-x86_64/ia32.h
--- 2.5.51-32bit.base/include/asm-x86_64/ia32.h	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-x86_64/ia32.h	2002-12-10 15:44:49.000000000 +1100
@@ -5,13 +5,13 @@
 
 #ifdef CONFIG_IA32_EMULATION
 
+#include <compat.h>
+
 /*
  * 32 bit structures for IA32 support.
  */
 
 /* 32bit compatibility types */
-typedef int		       __kernel_ptrdiff_t32;
-typedef int		       __kernel_clock_t32;
 typedef int		       __kernel_pid_t32;
 typedef unsigned short	       __kernel_ipc_pid_t32;
 typedef unsigned short	       __kernel_uid_t32;
@@ -201,8 +201,8 @@
 			unsigned int _pid;	/* which child */
 			unsigned int _uid;	/* sender's uid */
 			int _status;		/* exit code */
-			__kernel_clock_t32 _utime;
-			__kernel_clock_t32 _stime;
+			compat_clock_t _utime;
+			compat_clock_t _stime;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
