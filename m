Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbTAPDfM>; Wed, 15 Jan 2003 22:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266974AbTAPDfL>; Wed, 15 Jan 2003 22:35:11 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:49112 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266970AbTAPDfI>;
	Wed, 15 Jan 2003 22:35:08 -0500
Date: Thu, 16 Jan 2003 14:43:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: anton@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_sigpending and compat_sys_sigprocmask
 ppc64
Message-Id: <20030116144358.0c357e85.sfr@canb.auug.org.au>
In-Reply-To: <20030116144129.2251138d.sfr@canb.auug.org.au>
References: <20030116144129.2251138d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

Here is the ppc64 part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.5/arch/ppc64/kernel/misc.S 2.5.58-32bit.6/arch/ppc64/kernel/misc.S
--- 2.5.58-32bit.5/arch/ppc64/kernel/misc.S	2003-01-14 09:57:51.000000000 +1100
+++ 2.5.58-32bit.6/arch/ppc64/kernel/misc.S	2003-01-16 01:43:58.000000000 +1100
@@ -541,7 +541,7 @@
 	.llong .sys_setreuid	        /* 70 */
 	.llong .sys_setregid
 	.llong .sys_sigsuspend
-	.llong .sys32_sigpending
+	.llong .compat_sys_sigpending
 	.llong .sys32_sethostname
 	.llong .sys32_setrlimit	        /* 75 */
 	.llong .sys32_old_getrlimit
@@ -594,7 +594,7 @@
 	.llong .sys_ni_syscall		/* old modify_ldt syscall */
 	.llong .sys32_adjtimex
 	.llong .sys_mprotect		/* 125 */
-	.llong .sys32_sigprocmask
+	.llong .compat_sys_sigprocmask
 	.llong .sys_ni_syscall		/* old create_module syscall */
 	.llong .sys32_init_module
 	.llong .sys32_delete_module
diff -ruN 2.5.58-32bit.5/arch/ppc64/kernel/signal32.c 2.5.58-32bit.6/arch/ppc64/kernel/signal32.c
--- 2.5.58-32bit.5/arch/ppc64/kernel/signal32.c	2003-01-15 14:55:15.000000000 +1100
+++ 2.5.58-32bit.6/arch/ppc64/kernel/signal32.c	2003-01-16 01:44:35.000000000 +1100
@@ -104,8 +104,6 @@
  *
  *  System Calls
  *       sigaction                sys32_sigaction
- *       sigpending               sys32_sigpending
- *       sigprocmask              sys32_sigprocmask
  *       sigreturn                sys32_sigreturn
  *
  *  Note sigsuspend has no special 32 bit routine - uses the 64 bit routine
@@ -147,54 +145,6 @@
 }
 
 
-extern long sys_sigpending(old_sigset_t *set);
-
-long sys32_sigpending(compat_old_sigset_t *set)
-{
-	old_sigset_t s;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs(KERNEL_DS);
-	ret = sys_sigpending(&s);
-	set_fs(old_fs);
-	if (put_user(s, set))
-		return -EFAULT;
-	return ret;
-}
-
-
-extern long sys_sigprocmask(int how, old_sigset_t *set,
-		old_sigset_t *oset);
-
-/*
- * Note: it is necessary to treat how as an unsigned int, with the
- * corresponding cast to a signed int to insure that the proper
- * conversion (sign extension) between the register representation
- * of a signed int (msr in 32-bit mode) and the register representation
- * of a signed int (msr in 64-bit mode) is performed.
- */
-long sys32_sigprocmask(u32 how, compat_old_sigset_t *set,
-		compat_old_sigset_t *oset)
-{
-	old_sigset_t s;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	if (set && get_user(s, set))
-		return -EFAULT;
-	set_fs(KERNEL_DS);
-	ret = sys_sigprocmask((int)how, set ? &s : NULL, oset ? &s : NULL);
-	set_fs(old_fs);
-	if (ret)
-		return ret;
-	if (oset && put_user (s, oset))
-		return -EFAULT;
-	return 0;
-}
-
-
-
 /*
  * When we have signals to deliver, we set up on the
  * user stack, going down from the original stack pointer:
