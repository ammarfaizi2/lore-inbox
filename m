Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbTAPDmg>; Wed, 15 Jan 2003 22:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbTAPDme>; Wed, 15 Jan 2003 22:42:34 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:2521 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267102AbTAPDlo>;
	Wed, 15 Jan 2003 22:41:44 -0500
Date: Thu, 16 Jan 2003 14:50:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_sigpending and compat_sys_sigprocmask
 mips64
Message-Id: <20030116145031.0e194a0f.sfr@canb.auug.org.au>
In-Reply-To: <20030116144129.2251138d.sfr@canb.auug.org.au>
References: <20030116144129.2251138d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

Here is the mips64 part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.5/arch/mips64/kernel/scall_o32.S 2.5.58-32bit.6/arch/mips64/kernel/scall_o32.S
--- 2.5.58-32bit.5/arch/mips64/kernel/scall_o32.S	2003-01-13 11:07:06.000000000 +1100
+++ 2.5.58-32bit.6/arch/mips64/kernel/scall_o32.S	2003-01-16 01:40:09.000000000 +1100
@@ -306,7 +306,7 @@
 	sys	sys_setreuid	2			/* 4070 */
 	sys	sys_setregid	2
 	sys	sys32_sigsuspend	0
-	sys	sys32_sigpending	1
+	sys	compat_sys_sigpending	1
 	sys	sys_sethostname	2
 	sys	sys32_setrlimit	2			/* 4075 */
 	sys	sys32_getrlimit	2
@@ -359,7 +359,7 @@
 	sys	sys_ni_syscall	0	/* sys_modify_ldt */
 	sys	sys32_adjtimex	1
 	sys	sys_mprotect	3			/* 4125 */
-	sys	sys32_sigprocmask	3
+	sys	compat_sys_sigprocmask	3
 	sys	sys_create_module 2
 	sys	sys_init_module	5
 	sys	sys_delete_module 1
diff -ruN 2.5.58-32bit.5/arch/mips64/kernel/signal32.c 2.5.58-32bit.6/arch/mips64/kernel/signal32.c
--- 2.5.58-32bit.5/arch/mips64/kernel/signal32.c	2003-01-15 16:12:21.000000000 +1100
+++ 2.5.58-32bit.6/arch/mips64/kernel/signal32.c	2003-01-16 01:40:36.000000000 +1100
@@ -694,44 +694,6 @@
 	return 0;
 }
 
-extern asmlinkage int sys_sigprocmask(int how, old_sigset_t *set,
-						old_sigset_t *oset);
-
-asmlinkage int sys32_sigprocmask(int how, compat_old_sigset_t *set, 
-				 compat_old_sigset_t *oset)
-{
-	old_sigset_t s;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	if (set && get_user (s, set))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_sigprocmask(how, set ? &s : NULL, oset ? &s : NULL);
-	set_fs (old_fs);
-	if (!ret && oset && put_user (s, oset))
-		return -EFAULT;
-	return ret;
-}
-
-asmlinkage long sys_sigpending(old_sigset_t *set);
-
-asmlinkage int sys32_sigpending(compat_old_sigset_t *set)
-{
-	old_sigset_t pending;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs (KERNEL_DS);
-	ret = sys_sigpending(&pending);
-	set_fs (old_fs);
-
-	if (put_user(pending, set))
-		return -EFAULT;
-
-	return ret;
-}
-
 asmlinkage int sys32_rt_sigaction(int sig, const struct sigaction32 *act,
 				  struct sigaction32 *oact,
 				  unsigned int sigsetsize)
