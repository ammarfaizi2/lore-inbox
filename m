Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266974AbTAPDg1>; Wed, 15 Jan 2003 22:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbTAPDg1>; Wed, 15 Jan 2003 22:36:27 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:52440 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266974AbTAPDgY>;
	Wed, 15 Jan 2003 22:36:24 -0500
Date: Thu, 16 Jan 2003 14:45:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davem@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_sigpending and compat_sys_sigprocmask
 sparc64
Message-Id: <20030116144513.52a8480b.sfr@canb.auug.org.au>
In-Reply-To: <20030116144129.2251138d.sfr@canb.auug.org.au>
References: <20030116144129.2251138d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Hare is the sparc64 part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.58-32bit.5/arch/sparc64/kernel/sys_sparc32.c 2.5.58-32bit.6/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.58-32bit.5/arch/sparc64/kernel/sys_sparc32.c	2003-01-15 14:54:34.000000000 +1100
+++ 2.5.58-32bit.6/arch/sparc64/kernel/sys_sparc32.c	2003-01-16 01:43:41.000000000 +1100
@@ -1679,23 +1679,6 @@
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
@@ -1732,21 +1715,6 @@
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
diff -ruN 2.5.58-32bit.5/arch/sparc64/kernel/systbls.S 2.5.58-32bit.6/arch/sparc64/kernel/systbls.S
--- 2.5.58-32bit.5/arch/sparc64/kernel/systbls.S	2003-01-14 09:57:52.000000000 +1100
+++ 2.5.58-32bit.6/arch/sparc64/kernel/systbls.S	2003-01-16 01:43:27.000000000 +1100
@@ -55,7 +55,7 @@
 	.word sys_quotactl, sys_set_tid_address, sys32_mount, sys_ustat, sys_setxattr
 /*170*/	.word sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys32_getdents
 	.word sys_setsid, sys_fchdir, sys_fgetxattr, sys_listxattr, sys_llistxattr
-/*180*/	.word sys_flistxattr, sys_removexattr, sys_lremovexattr, sys32_sigpending, sys_ni_syscall
+/*180*/	.word sys_flistxattr, sys_removexattr, sys_lremovexattr, compat_sys_sigpending, sys_ni_syscall
 	.word sys_setpgid, sys_fremovexattr, sys_tkill, sys_exit_group, sparc64_newuname
 /*190*/	.word sys32_init_module, sparc64_personality, sys_remap_file_pages, sys_epoll_create, sys_epoll_ctl
 	.word sys_epoll_wait, sys_nis_syscall, sys_getppid, sys32_sigaction, sys_sgetmask
@@ -63,7 +63,7 @@
 	.word sys32_readahead, sys32_socketcall, sys_syslog, sys32_lookup_dcookie, sys_nis_syscall
 /*210*/	.word sys_nis_syscall, sys_nis_syscall, sys_waitpid, sys_swapoff, sys32_sysinfo
 	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
-/*220*/	.word sys32_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys_getpgid
+/*220*/	.word compat_sys_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
 
 	/* 234 and 235 were for the hugetlb syscalls.  They can be reused */
@@ -206,7 +206,7 @@
 	.word sunos_nosys, sunos_getdents, sys_setsid
 	.word sys_fchdir, sunos_nosys, sunos_nosys
 	.word sunos_nosys, sunos_nosys, sunos_nosys
-	.word sunos_nosys, sys32_sigpending, sunos_nosys
+	.word sunos_nosys, compat_sys_sigpending, sunos_nosys
 	.word sys_setpgid, sunos_pathconf, sunos_fpathconf
 	.word sunos_sysconf, sunos_uname, sunos_nosys
 	.word sunos_nosys, sunos_nosys, sunos_nosys
