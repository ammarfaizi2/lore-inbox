Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbTAPDkn>; Wed, 15 Jan 2003 22:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267011AbTAPDkm>; Wed, 15 Jan 2003 22:40:42 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:65496 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266976AbTAPDkj>;
	Wed, 15 Jan 2003 22:40:39 -0500
Date: Thu, 16 Jan 2003 14:49:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: [PATCH][COMPAT] compat_sys_sigpending and compat_sys_sigprocmask
 s390x
Message-Id: <20030116144927.74da17c3.sfr@canb.auug.org.au>
In-Reply-To: <20030116144129.2251138d.sfr@canb.auug.org.au>
References: <20030116144129.2251138d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the s390x part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.5/arch/s390x/kernel/entry.S 2.5.58-32bit.6/arch/s390x/kernel/entry.S
--- 2.5.58-32bit.5/arch/s390x/kernel/entry.S	2003-01-14 09:57:51.000000000 +1100
+++ 2.5.58-32bit.6/arch/s390x/kernel/entry.S	2003-01-16 01:42:59.000000000 +1100
@@ -464,7 +464,7 @@
         .long  SYSCALL(sys_ni_syscall,sys32_setreuid16_wrapper) /* old setreuid16 syscall */
         .long  SYSCALL(sys_ni_syscall,sys32_setregid16_wrapper) /* old setregid16 syscall */
         .long  SYSCALL(sys_sigsuspend_glue,sys32_sigsuspend_glue)
-        .long  SYSCALL(sys_sigpending,sys32_sigpending_wrapper)
+        .long  SYSCALL(sys_sigpending,compat_sys_sigpending_wrapper)
         .long  SYSCALL(sys_sethostname,sys32_sethostname_wrapper)
         .long  SYSCALL(sys_setrlimit,sys32_setrlimit_wrapper)   /* 75 */
         .long  SYSCALL(sys_getrlimit,sys32_old_getrlimit_wrapper) 
@@ -517,7 +517,7 @@
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* modify_ldt for i386 */
         .long  SYSCALL(sys_adjtimex,sys32_adjtimex_wrapper)
         .long  SYSCALL(sys_mprotect,sys32_mprotect_wrapper) /* 125 */
-        .long  SYSCALL(sys_sigprocmask,sys32_sigprocmask_wrapper)
+        .long  SYSCALL(sys_sigprocmask,compat_sys_sigprocmask_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old "create module" */
         .long  SYSCALL(sys_init_module,sys32_init_module_wrapper)
         .long  SYSCALL(sys_delete_module,sys32_delete_module_wrapper)
diff -ruN 2.5.58-32bit.5/arch/s390x/kernel/linux32.c 2.5.58-32bit.6/arch/s390x/kernel/linux32.c
--- 2.5.58-32bit.5/arch/s390x/kernel/linux32.c	2003-01-15 14:51:38.000000000 +1100
+++ 2.5.58-32bit.6/arch/s390x/kernel/linux32.c	2003-01-16 01:43:15.000000000 +1100
@@ -1621,23 +1621,6 @@
 	return ret;
 }
 
-extern asmlinkage int sys_sigprocmask(int how, old_sigset_t *set, old_sigset_t *oset);
-
-asmlinkage int sys32_sigprocmask(int how, compat_old_sigset_t *set, compat_old_sigset_t *oset)
-{
-	old_sigset_t s;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-	
-	if (set && get_user (s, set)) return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_sigprocmask(how, set ? &s : NULL, oset ? &s : NULL);
-	set_fs (old_fs);
-	if (ret) return ret;
-	if (oset && put_user (s, oset)) return -EFAULT;
-	return 0;
-}
-
 extern asmlinkage int sys_rt_sigprocmask(int how, sigset_t *set, sigset_t *oset, size_t sigsetsize);
 
 asmlinkage int sys32_rt_sigprocmask(int how, compat_sigset_t *set, compat_sigset_t *oset, compat_size_t sigsetsize)
@@ -1674,21 +1657,6 @@
 	return 0;
 }
 
-extern asmlinkage int sys_sigpending(old_sigset_t *set);
-
-asmlinkage int sys32_sigpending(compat_old_sigset_t *set)
-{
-	old_sigset_t s;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-		
-	set_fs (KERNEL_DS);
-	ret = sys_sigpending(&s);
-	set_fs (old_fs);
-	if (put_user (s, set)) return -EFAULT;
-	return ret;
-}
-
 extern asmlinkage int sys_rt_sigpending(sigset_t *set, size_t sigsetsize);
 
 asmlinkage int sys32_rt_sigpending(compat_sigset_t *set, compat_size_t sigsetsize)
diff -ruN 2.5.58-32bit.5/arch/s390x/kernel/wrapper32.S 2.5.58-32bit.6/arch/s390x/kernel/wrapper32.S
--- 2.5.58-32bit.5/arch/s390x/kernel/wrapper32.S	2003-01-14 09:57:51.000000000 +1100
+++ 2.5.58-32bit.6/arch/s390x/kernel/wrapper32.S	2003-01-16 01:42:40.000000000 +1100
@@ -288,10 +288,10 @@
 
 #sys32_sigsuspend_wrapper		# done in sigsuspend_glue 
 
-	.globl  sys32_sigpending_wrapper 
-sys32_sigpending_wrapper:
-	llgtr	%r2,%r2			# old_sigset_emu31_t *
-	jg	sys32_sigpending	# branch to system call
+	.globl  compat_sys_sigpending_wrapper 
+compat_sys_sigpending_wrapper:
+	llgtr	%r2,%r2			# compat_old_sigset_t *
+	jg	compat_sys_sigpending	# branch to system call
 
 	.globl  sys32_sethostname_wrapper 
 sys32_sethostname_wrapper:
@@ -557,12 +557,12 @@
 	llgfr	%r4,%r4			# unsigned long
 	jg	sys_mprotect		# branch to system call
 
-	.globl  sys32_sigprocmask_wrapper 
-sys32_sigprocmask_wrapper:
+	.globl  compat_sys_sigprocmask_wrapper 
+compat_sys_sigprocmask_wrapper:
 	lgfr	%r2,%r2			# int
-	llgtr	%r3,%r3			# old_sigset_emu31 *
-	llgtr	%r4,%r4			# old_sigset_emu31 *
-	jg	sys32_sigprocmask		# branch to system call
+	llgtr	%r3,%r3			# compat_old_sigset_t *
+	llgtr	%r4,%r4			# compat_old_sigset_t *
+	jg	compat_sys_sigprocmask		# branch to system call
 
 	.globl  sys32_init_module_wrapper 
 sys32_init_module_wrapper:
