Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbSLJGlE>; Tue, 10 Dec 2002 01:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbSLJGlE>; Tue, 10 Dec 2002 01:41:04 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:13269 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266718AbSLJGlC>;
	Tue, 10 Dec 2002 01:41:02 -0500
Date: Tue, 10 Dec 2002 17:48:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: matthew@wil.cx
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] consolidate sys32_times - parisc
Message-Id: <20021210174841.6c2ddd52.sfr@canb.auug.org.au>
In-Reply-To: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
References: <20021210173530.6ec651d2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Here is the parisc patch ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.base/arch/parisc/kernel/sys_parisc32.c 2.5.51-32bit.1/arch/parisc/kernel/sys_parisc32.c
--- 2.5.51-32bit.base/arch/parisc/kernel/sys_parisc32.c	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/arch/parisc/kernel/sys_parisc32.c	2002-12-10 17:03:26.000000000 +1100
@@ -386,32 +386,6 @@
  * code available in case it's useful to others. -PB
  */
 
-struct tms32 {
-	__kernel_clock_t32 tms_utime;
-	__kernel_clock_t32 tms_stime;
-	__kernel_clock_t32 tms_cutime;
-	__kernel_clock_t32 tms_cstime;
-};
-                                
-asmlinkage long sys32_times(struct tms32 *tbuf)
-{
-	struct tms t;
-	long ret;
-	extern asmlinkage long sys_times(struct tms * tbuf);
-int err;
-	
-	KERNEL_SYSCALL(ret, sys_times, tbuf ? &t : NULL);
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
 struct flock32 {
 	short l_type;
 	short l_whence;
diff -ruN 2.5.51-32bit.base/include/asm-parisc/compat.h 2.5.51-32bit.1/include/asm-parisc/compat.h
--- 2.5.51-32bit.base/include/asm-parisc/compat.h	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-parisc/compat.h	2002-12-10 16:38:08.000000000 +1100
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
diff -ruN 2.5.51-32bit.base/include/asm-parisc/posix_types.h 2.5.51-32bit.1/include/asm-parisc/posix_types.h
--- 2.5.51-32bit.base/include/asm-parisc/posix_types.h	2002-12-10 15:46:42.000000000 +1100
+++ 2.5.51-32bit.1/include/asm-parisc/posix_types.h	2002-12-10 15:42:51.000000000 +1100
@@ -66,9 +66,6 @@
 typedef unsigned short		__kernel_ipc_pid_t32;
 typedef unsigned int		__kernel_uid_t32;
 typedef unsigned int		__kernel_gid_t32;
-typedef int			__kernel_ptrdiff_t32;
-typedef int			__kernel_suseconds_t32;
-typedef int			__kernel_clock_t32;
 typedef int			__kernel_daddr_t32;
 typedef unsigned int		__kernel_caddr_t32;
 #endif
