Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262064AbSI3Nnj>; Mon, 30 Sep 2002 09:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262068AbSI3Nnj>; Mon, 30 Sep 2002 09:43:39 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:34766 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262064AbSI3Nnf> convert rfc822-to-8bit; Mon, 30 Sep 2002 09:43:35 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.39 s390 (4/26): syscalls.
Date: Mon, 30 Sep 2002 14:51:56 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301451.56224.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New system calls: security, async. i/o and sys_exit_group. Add 31 bit emulation
function for sys_futex.

diff -urN linux-2.5.39/arch/s390/kernel/entry.S linux-2.5.39-s390/arch/s390/kernel/entry.S
--- linux-2.5.39/arch/s390/kernel/entry.S	Fri Sep 27 23:49:13 2002
+++ linux-2.5.39-s390/arch/s390/kernel/entry.S	Mon Sep 30 13:25:21 2002
@@ -581,7 +581,15 @@
 	.long  sys_futex
 	.long  sys_sched_setaffinity
 	.long  sys_sched_getaffinity	 /* 240 */
-	.rept  255-240
+	.long  sys_security
+	.long  sys_ni_syscall		 /* reserved for TUX */
+	.long  sys_io_setup
+	.long  sys_io_destroy
+	.long  sys_io_getevents		 /* 245 */
+	.long  sys_io_submit
+	.long  sys_io_cancel
+	.long  sys_exit_group
+	.rept  255-248
 	.long  sys_ni_syscall
 	.endr
 
diff -urN linux-2.5.39/arch/s390x/kernel/entry.S linux-2.5.39-s390/arch/s390x/kernel/entry.S
--- linux-2.5.39/arch/s390x/kernel/entry.S	Mon Sep 30 13:25:21 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/entry.S	Mon Sep 30 13:25:21 2002
@@ -606,13 +606,21 @@
 	.long  SYSCALL(sys_flistxattr,sys32_flistxattr_wrapper)
 	.long  SYSCALL(sys_removexattr,sys32_removexattr_wrapper)
 	.long  SYSCALL(sys_lremovexattr,sys32_lremovexattr_wrapper)
-	.long  SYSCALL(sys_fremovexattr,sys32_fremovexattr_wrapper)
+	.long  SYSCALL(sys_fremovexattr,sys32_fremovexattr_wrapper) /* 235 */
 	.long  SYSCALL(sys_gettid,sys_gettid)
 	.long  SYSCALL(sys_tkill,sys_tkill)
 	.long  SYSCALL(sys_futex,sys32_futex_wrapper)
 	.long  SYSCALL(sys_sched_setaffinity,sys32_sched_setaffinity_wrapper)
-	.long  SYSCALL(sys_sched_getaffinity,sys32_sched_getaffinity_wrapper)
-        .rept  255-240
+	.long  SYSCALL(sys_sched_getaffinity,sys32_sched_getaffinity_wrapper) /* 240 */
+	.long  SYSCALL(sys_security,sys_ni_syscall)
+	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* reserved for TUX */
+	.long  SYSCALL(sys_io_setup,sys_ni_syscall)
+	.long  SYSCALL(sys_io_destroy,sys_ni_syscall)
+	.long  SYSCALL(sys_io_getevents,sys_ni_syscall)       /* 245 */
+	.long  SYSCALL(sys_io_submit,sys_ni_syscall)
+	.long  SYSCALL(sys_io_cancel,sys_ni_syscall)
+	.long  SYSCALL(sys_exit_group,sys32_exit_group_wrapper)
+        .rept  255-248
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
 	.endr
 
diff -urN linux-2.5.39/arch/s390x/kernel/linux32.c linux-2.5.39-s390/arch/s390x/kernel/linux32.c
--- linux-2.5.39/arch/s390x/kernel/linux32.c	Mon Sep 30 13:25:21 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/linux32.c	Mon Sep 30 13:25:21 2002
@@ -4531,3 +4531,34 @@
 
 	return ret;
 }
+
+asmlinkage int 
+sys_futex(void *uaddr, int op, int val, struct timespec *utime);
+
+asmlinkage int
+sys32_futex(void *uaddr, int op, int val, 
+		 struct timespec32 *timeout32)
+{
+	long ret;
+	struct timespec tmp, *timeout;
+
+	ret = -ENOMEM;
+	timeout = kmalloc(sizeof(*timeout), GFP_USER);
+	if (!timeout)
+		goto out;
+
+	ret = -EINVAL;
+	if (get_user (tmp.tv_sec,  &timeout32->tv_sec)  ||
+	    get_user (tmp.tv_nsec, &timeout32->tv_nsec) ||
+	    put_user (tmp.tv_sec,  &timeout->tv_sec)    ||
+	    put_user (tmp.tv_nsec, &timeout->tv_nsec))
+		goto out_free;
+
+	ret = sys_futex(uaddr, op, val, timeout);
+
+out_free:
+	kfree(timeout);
+out:
+	return ret;
+}
+
diff -urN linux-2.5.39/arch/s390x/kernel/wrapper32.S linux-2.5.39-s390/arch/s390x/kernel/wrapper32.S
--- linux-2.5.39/arch/s390x/kernel/wrapper32.S	Fri Sep 27 23:49:52 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/wrapper32.S	Mon Sep 30 13:25:21 2002
@@ -1114,7 +1114,7 @@
 	lgfr	%r3,%r3			# int
 	lgfr	%r4,%r4			# int
 	llgtr	%r5,%r5			# struct timespec *
-	jg	sys_futex		# branch to system call
+	jg	sys32_futex		# branch to system call
 
 	.globl	sys32_setxattr_wrapper
 sys32_setxattr_wrapper:
@@ -1220,3 +1220,7 @@
 	llgtr	%r4,%r4			# unsigned long *
 	jg	sys32_sched_getaffinity
 
+	.globl  sys32_exit_group_wrapper
+sys32_exit_group_wrapper:
+	lgfr	%r2,%r2			# int
+	jg	sys_exit_group		# branch to system call
diff -urN linux-2.5.39/include/asm-s390/unistd.h linux-2.5.39-s390/include/asm-s390/unistd.h
--- linux-2.5.39/include/asm-s390/unistd.h	Fri Sep 27 23:50:59 2002
+++ linux-2.5.39-s390/include/asm-s390/unistd.h	Mon Sep 30 13:25:21 2002
@@ -231,6 +231,16 @@
 #define __NR_futex		238
 #define __NR_sched_setaffinity	239
 #define __NR_sched_getaffinity	240
+#define __NR_security		241	/* syscall for security modules */
+/*
+ * Number 242 is reserved for tux
+ */
+#define __NR_io_setup		243
+#define __NR_io_destroy		244
+#define __NR_io_getevents	245
+#define __NR_io_submit		246
+#define __NR_io_cancel		247
+#define __NR_exit_group		248
 
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
diff -urN linux-2.5.39/include/asm-s390x/unistd.h linux-2.5.39-s390/include/asm-s390x/unistd.h
--- linux-2.5.39/include/asm-s390x/unistd.h	Fri Sep 27 23:50:24 2002
+++ linux-2.5.39-s390/include/asm-s390x/unistd.h	Mon Sep 30 13:25:21 2002
@@ -198,6 +198,16 @@
 #define __NR_futex		238
 #define __NR_sched_setaffinity	239
 #define __NR_sched_getaffinity	240
+#define __NR_security		241	/* syscall for security modules */
+/*
+ * Number 242 is reserved for tux
+ */
+#define __NR_io_setup		243
+#define __NR_io_destroy		244
+#define __NR_io_getevents	245
+#define __NR_io_submit		246
+#define __NR_io_cancel		247
+#define __NR_exit_group		248
 
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */

