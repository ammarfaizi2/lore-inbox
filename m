Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266689AbSLJGfj>; Tue, 10 Dec 2002 01:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbSLJGfh>; Tue, 10 Dec 2002 01:35:37 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:43476 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266686AbSLJGfa>;
	Tue, 10 Dec 2002 01:35:30 -0500
Date: Tue, 10 Dec 2002 17:43:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] consolidate sys32_times - ia64
Message-Id: <20021210174310.27abf559.sfr@canb.auug.org.au>
In-Reply-To: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
References: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

The ia64 patch ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.base/arch/ia64/ia32/ia32_entry.S 2.5.51-32bit.1/arch/ia64/ia32/ia32_entry.S
--- 2.5.51-32bit.base/arch/ia64/ia32/ia32_entry.S	2002-12-10 15:46:41.000000000 +1100
+++ 2.5.51-32bit.1/arch/ia64/ia32/ia32_entry.S	2002-12-10 17:00:17.000000000 +1100
@@ -234,7 +234,7 @@
 	data8 sys_rmdir		  /* 40 */
 	data8 sys_dup
 	data8 sys32_pipe
-	data8 sys32_times
+	data8 compat_sys_times
 	data8 sys32_ni_syscall	  /* old prof syscall holder */
 	data8 sys32_brk		  /* 45 */
 	data8 sys_setgid	/* 16-bit version */
diff -ruN 2.5.51-32bit.base/arch/ia64/ia32/sys_ia32.c 2.5.51-32bit.1/arch/ia64/ia32/sys_ia32.c
--- 2.5.51-32bit.base/arch/ia64/ia32/sys_ia32.c	2002-12-10 15:46:41.000000000 +1100
+++ 2.5.51-32bit.1/arch/ia64/ia32/sys_ia32.c	2002-12-10 16:58:43.000000000 +1100
@@ -2585,37 +2585,6 @@
 	return ret;
 }
 
-struct tms32 {
-	__kernel_clock_t32 tms_utime;
-	__kernel_clock_t32 tms_stime;
-	__kernel_clock_t32 tms_cutime;
-	__kernel_clock_t32 tms_cstime;
-};
-
-extern asmlinkage long sys_times (struct tms * tbuf);
-
-asmlinkage long
-sys32_times (struct tms32 *tbuf)
-{
-	mm_segment_t old_fs = get_fs();
-	struct tms t;
-	long ret;
-	int err;
-
-	set_fs(KERNEL_DS);
-	ret = sys_times(tbuf ? &t : NULL);
-	set_fs(old_fs);
-	if (tbuf) {
-		err = put_user (IA32_TICK(t.tms_utime), &tbuf->tms_utime);
-		err |= put_user (IA32_TICK(t.tms_stime), &tbuf->tms_stime);
-		err |= put_user (IA32_TICK(t.tms_cutime), &tbuf->tms_cutime);
-		err |= put_user (IA32_TICK(t.tms_cstime), &tbuf->tms_cstime);
-		if (err)
-			ret = -EFAULT;
-	}
-	return IA32_TICK(ret);
-}
-
 static unsigned int
 ia32_peek (struct pt_regs *regs, struct task_struct *child, unsigned long addr, unsigned int *val)
 {
diff -ruN 2.5.51-32bit.base/include/asm-ia64/compat.h 2.5.51-32bit.1/include/asm-ia64/compat.h
--- 2.5.51-32bit.base/include/asm-ia64/compat.h	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-ia64/compat.h	2002-12-10 16:37:41.000000000 +1100
@@ -6,9 +6,12 @@
 
 #include <linux/types.h>
 
+#define COMPAT_USER_HZ	100
+
 typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
+typedef s32		compat_clock_t;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -ruN 2.5.51-32bit.base/include/asm-ia64/ia32.h 2.5.51-32bit.1/include/asm-ia64/ia32.h
--- 2.5.51-32bit.base/include/asm-ia64/ia32.h	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-ia64/ia32.h	2002-12-10 16:59:04.000000000 +1100
@@ -6,14 +6,13 @@
 #ifdef CONFIG_IA32_SUPPORT
 
 #include <linux/binfmts.h>
+#include <linux/compat.h>
 
 /*
  * 32 bit structures for IA32 support.
  */
 
 /* 32bit compatibility types */
-typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_clock_t32;
 typedef int		__kernel_pid_t32;
 typedef unsigned short	__kernel_ipc_pid_t32;
 typedef unsigned short	__kernel_uid_t32;
@@ -36,7 +35,6 @@
 #define IA32_PAGE_MASK		(~(IA32_PAGE_SIZE - 1))
 #define IA32_PAGE_ALIGN(addr)	(((addr) + IA32_PAGE_SIZE - 1) & IA32_PAGE_MASK)
 #define IA32_CLOCKS_PER_SEC	100	/* Cast in stone for IA32 Linux */
-#define IA32_TICK(tick)		((unsigned long long)(tick) * IA32_CLOCKS_PER_SEC / CLOCKS_PER_SEC)
 
 /* fcntl.h */
 struct flock32 {
@@ -267,8 +265,8 @@
 			unsigned int _pid;	/* which child */
 			unsigned int _uid;	/* sender's uid */
 			int _status;		/* exit code */
-			__kernel_clock_t32 _utime;
-			__kernel_clock_t32 _stime;
+			compat_clock_t _utime;
+			compat_clock_t _stime;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
