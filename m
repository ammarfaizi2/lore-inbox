Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbTBLEuu>; Tue, 11 Feb 2003 23:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbTBLEuu>; Tue, 11 Feb 2003 23:50:50 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:38844 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266939AbTBLEus>;
	Tue, 11 Feb 2003 23:50:48 -0500
Date: Wed, 12 Feb 2003 16:00:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH][COMPAT] compat_sys_futex 5/7 s390x
Message-Id: <20030212160017.4b6c8423.sfr@canb.auug.org.au>
In-Reply-To: <20030212154716.7c101942.sfr@canb.auug.org.au>
References: <20030212154716.7c101942.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the s390x part of the patch.  Hopefully Martin still wants me to
send these to you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60-32bit.1/arch/s390x/kernel/entry.S 2.5.60-32bit.2/arch/s390x/kernel/entry.S
--- 2.5.60-32bit.1/arch/s390x/kernel/entry.S	2003-01-17 14:01:01.000000000 +1100
+++ 2.5.60-32bit.2/arch/s390x/kernel/entry.S	2003-02-11 12:21:56.000000000 +1100
@@ -629,7 +629,7 @@
 	.long  SYSCALL(sys_fremovexattr,sys32_fremovexattr_wrapper) /* 235 */
 	.long  SYSCALL(sys_gettid,sys_gettid)
 	.long  SYSCALL(sys_tkill,sys_tkill)
-	.long  SYSCALL(sys_futex,sys32_futex_wrapper)
+	.long  SYSCALL(sys_futex,compat_sys_futex_wrapper)
 	.long  SYSCALL(sys_sched_setaffinity,sys32_sched_setaffinity_wrapper)
 	.long  SYSCALL(sys_sched_getaffinity,sys32_sched_getaffinity_wrapper) /* 240 */
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
diff -ruN 2.5.60-32bit.1/arch/s390x/kernel/linux32.c 2.5.60-32bit.2/arch/s390x/kernel/linux32.c
--- 2.5.60-32bit.1/arch/s390x/kernel/linux32.c	2003-02-11 09:39:17.000000000 +1100
+++ 2.5.60-32bit.2/arch/s390x/kernel/linux32.c	2003-02-11 12:21:56.000000000 +1100
@@ -4049,28 +4049,6 @@
 	return ret;
 }
 
-asmlinkage int 
-sys_futex(void *uaddr, int op, int val, struct timespec *utime);
-
-asmlinkage int
-sys32_futex(void *uaddr, int op, int val, 
-		 struct compat_timespec *timeout32)
-{
-	struct timespec tmp;
-	mm_segment_t old_fs;
-	int ret;
-
-	if (timeout32 && get_compat_timespec(&tmp, timeout32))
-		return -EINVAL;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_futex(uaddr, op, val, timeout32 ? &tmp : NULL);
-	set_fs(old_fs);
-
-	return ret;
-}
-
 asmlinkage ssize_t sys_read(unsigned int fd, char * buf, size_t count);
 
 asmlinkage compat_ssize_t sys32_read(unsigned int fd, char * buf, size_t count)
diff -ruN 2.5.60-32bit.1/arch/s390x/kernel/wrapper32.S 2.5.60-32bit.2/arch/s390x/kernel/wrapper32.S
--- 2.5.60-32bit.1/arch/s390x/kernel/wrapper32.S	2003-01-17 14:01:01.000000000 +1100
+++ 2.5.60-32bit.2/arch/s390x/kernel/wrapper32.S	2003-02-11 12:21:56.000000000 +1100
@@ -1088,13 +1088,13 @@
 	llgfr	%r4,%r4			# long
 	jg	sys32_fstat64		# branch to system call
 
-	.globl  sys32_futex_wrapper 
-sys32_futex_wrapper:
-	llgtr	%r2,%r2			# void *
+	.globl  compat_sys_futex_wrapper 
+compat_sys_futex_wrapper:
+	llgtr	%r2,%r2			# u32 *
 	lgfr	%r3,%r3			# int
 	lgfr	%r4,%r4			# int
-	llgtr	%r5,%r5			# struct timespec *
-	jg	sys32_futex		# branch to system call
+	llgtr	%r5,%r5			# struct compat_timespec *
+	jg	compat_sys_futex	# branch to system call
 
 	.globl	sys32_setxattr_wrapper
 sys32_setxattr_wrapper:
