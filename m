Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbSI3Nu7>; Mon, 30 Sep 2002 09:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262071AbSI3Ntf>; Mon, 30 Sep 2002 09:49:35 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:27371 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S262077AbSI3Nnu> convert rfc822-to-8bit; Mon, 30 Sep 2002 09:43:50 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.39 s390 (11/26): 31bit emulation.
Date: Mon, 30 Sep 2002 14:55:37 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209301455.37832.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bug in 31 bit emulation of sys_msgsnd and rename sys32_pread/sys32_pwrite
to sys32_pread64/sys32_pwrite64.

diff -urN linux-2.5.39/arch/s390x/kernel/linux32.c linux-2.5.39-s390/arch/s390x/kernel/linux32.c
--- linux-2.5.39/arch/s390x/kernel/linux32.c	Mon Sep 30 13:25:30 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/linux32.c	Mon Sep 30 13:32:17 2002
@@ -514,16 +514,15 @@
 	if (!p)
 		return -ENOMEM;
 
+	err = -EINVAL;
 	if (second > MSGMAX || first < 0 || second < 0)
-		return -EINVAL;
+		goto out;
 
 	err = -EFAULT;
 	if (!uptr)
 		goto out;
-
-	err = get_user (p->mtype, &up->mtype);
-	err |= __copy_from_user (p->mtext, &up->mtext, second);
-	if (err)
+        if (get_user (p->mtype, &up->mtype) ||
+	    __copy_from_user (p->mtext, &up->mtext, second))
 		goto out;
 	old_fs = get_fs ();
 	set_fs (KERNEL_DS);
@@ -3997,13 +3996,13 @@
 
 typedef __kernel_ssize_t32 ssize_t32;
 
-asmlinkage ssize_t32 sys32_pread(unsigned int fd, char *ubuf,
+asmlinkage ssize_t32 sys32_pread64(unsigned int fd, char *ubuf,
 				 __kernel_size_t32 count, u32 poshi, u32 poslo)
 {
 	return sys_pread64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
-asmlinkage ssize_t32 sys32_pwrite(unsigned int fd, char *ubuf,
+asmlinkage ssize_t32 sys32_pwrite64(unsigned int fd, char *ubuf,
 				  __kernel_size_t32 count, u32 poshi, u32 poslo)
 {
 	return sys_pwrite64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
diff -urN linux-2.5.39/arch/s390x/kernel/wrapper32.S linux-2.5.39-s390/arch/s390x/kernel/wrapper32.S
--- linux-2.5.39/arch/s390x/kernel/wrapper32.S	Mon Sep 30 13:25:30 2002
+++ linux-2.5.39-s390/arch/s390x/kernel/wrapper32.S	Mon Sep 30 13:32:17 2002
@@ -872,23 +872,23 @@
 
 #sys32_rt_sigsuspend_wrapper		# done in rt_sigsuspend_glue 
 
-	.globl  sys32_pread_wrapper 
-sys32_pread_wrapper:
+	.globl  sys32_pread64_wrapper 
+sys32_pread64_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# char *
 	llgfr	%r4,%r4			# size_t
 	llgfr	%r5,%r5			# u32
 	llgfr	%r6,%r6			# u32
-	jg	sys32_pread		# branch to system call
+	jg	sys32_pread64		# branch to system call
 
-	.globl  sys32_pwrite_wrapper 
-sys32_pwrite_wrapper:
+	.globl  sys32_pwrite64_wrapper 
+sys32_pwrite64_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# const char *
 	llgfr	%r4,%r4			# size_t
 	llgfr	%r5,%r5			# u32
 	llgfr	%r6,%r6			# u32
-	jg	sys32_pwrite		# branch to system call
+	jg	sys32_pwrite64		# branch to system call
 
 	.globl  sys32_chown16_wrapper 
 sys32_chown16_wrapper:

