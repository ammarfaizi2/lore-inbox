Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbSIXRZX>; Tue, 24 Sep 2002 13:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261743AbSIXRXM>; Tue, 24 Sep 2002 13:23:12 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:52892 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261718AbSIXRWl> convert rfc822-to-8bit; Tue, 24 Sep 2002 13:22:41 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.38 s390 fixes: 09_emu31.
Date: Tue, 24 Sep 2002 19:19:47 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241919.47035.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bug in 31 bit emulation of sys_msgsnd and rename sys32_pread/sys32_pwrite
to sys32_pread64/sys32_pwrite64.

diff -urN linux-2.5.38/arch/s390x/kernel/linux32.c linux-2.5.38-s390/arch/s390x/kernel/linux32.c
--- linux-2.5.38/arch/s390x/kernel/linux32.c	Tue Sep 24 17:41:45 2002
+++ linux-2.5.38-s390/arch/s390x/kernel/linux32.c	Tue Sep 24 17:42:28 2002
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
diff -urN linux-2.5.38/arch/s390x/kernel/wrapper32.S linux-2.5.38-s390/arch/s390x/kernel/wrapper32.S
--- linux-2.5.38/arch/s390x/kernel/wrapper32.S	Tue Sep 24 17:41:45 2002
+++ linux-2.5.38-s390/arch/s390x/kernel/wrapper32.S	Tue Sep 24 17:42:28 2002
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

