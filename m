Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVAJFX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVAJFX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAJFX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:23:58 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:16644
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262089AbVAJFOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:04 -0500
Message-Id: <200501100735.j0A7ZBPW005745@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, bstroesser@fujitsu-siemens.com
Subject: [PATCH 3/28] UML - split out arch-specific syscalls from generic ones
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:11 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This factors out a bunch of non-generic system calls into i386-specific
code.  It also adds the x86_64-specific system calls.
A couple of generic system calls handlers are declared in sysdep-i386 because
x86 has no declarations for them, but x86_64 has incompatible ones.

Also splits out syscalls on behalf on UML/S390 from Bodo Stroesser 

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/include/sysdep-i386/syscalls.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-i386/syscalls.h	2005-01-09 18:25:43.000000000 -0500
+++ 2.6.10/arch/um/include/sysdep-i386/syscalls.h	2005-01-09 19:06:34.000000000 -0500
@@ -8,11 +8,70 @@
 
 typedef long syscall_handler_t(struct pt_regs);
 
+/* Not declared on x86, incompatible declarations on x86_64, so these have
+ * to go here rather than in sys_call_table.c
+ */
+extern syscall_handler_t sys_ptrace;
+extern syscall_handler_t sys_rt_sigaction;
+
+extern syscall_handler_t old_mmap_i386;
+
 #define EXECUTE_SYSCALL(syscall, regs) \
 	((long (*)(struct syscall_args)) (*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))
 
+extern long sys_mmap2(unsigned long addr, unsigned long len,
+		      unsigned long prot, unsigned long flags,
+		      unsigned long fd, unsigned long pgoff);
+
 #define ARCH_SYSCALLS \
+	[ __NR_waitpid ] = (syscall_handler_t *) sys_waitpid, \
+	[ __NR_break ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_oldstat ] = (syscall_handler_t *) sys_stat, \
+	[ __NR_umount ] = (syscall_handler_t *) sys_oldumount, \
+	[ __NR_stime ] = um_stime, \
+	[ __NR_oldfstat ] = (syscall_handler_t *) sys_fstat, \
+	[ __NR_stty ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_gtty ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_nice ] = (syscall_handler_t *) sys_nice, \
+	[ __NR_ftime ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_prof ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_signal ] = (syscall_handler_t *) sys_signal, \
+	[ __NR_lock ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_mpx ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_ulimit ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_oldolduname ] = (syscall_handler_t *) sys_olduname, \
+	[ __NR_sigaction ] = (syscall_handler_t *) sys_sigaction, \
+	[ __NR_sgetmask ] = (syscall_handler_t *) sys_sgetmask, \
+	[ __NR_ssetmask ] = (syscall_handler_t *) sys_ssetmask, \
+	[ __NR_sigsuspend ] = (syscall_handler_t *) sys_sigsuspend, \
+	[ __NR_sigpending ] = (syscall_handler_t *) sys_sigpending, \
+	[ __NR_oldlstat ] = (syscall_handler_t *) sys_lstat, \
+	[ __NR_readdir ] = old_readdir, \
+	[ __NR_profil ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_socketcall ] = (syscall_handler_t *) sys_socketcall, \
+	[ __NR_olduname ] = (syscall_handler_t *) sys_uname, \
+	[ __NR_iopl ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_idle ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_ipc ] = (syscall_handler_t *) sys_ipc, \
+	[ __NR_sigreturn ] = (syscall_handler_t *) sys_sigreturn, \
+	[ __NR_sigprocmask ] = (syscall_handler_t *) sys_sigprocmask, \
+	[ __NR_bdflush ] = (syscall_handler_t *) sys_bdflush, \
+	[ __NR__llseek ] = (syscall_handler_t *) sys_llseek, \
+	[ __NR__newselect ] = (syscall_handler_t *) sys_select, \
+	[ __NR_vm86 ] = (syscall_handler_t *) sys_ni_syscall, \
 	[ __NR_mmap ] = (syscall_handler_t *) old_mmap_i386, \
+	[ __NR_ugetrlimit ] = (syscall_handler_t *) sys_getrlimit, \
+	[ __NR_mmap2 ] = (syscall_handler_t *) sys_mmap2, \
+	[ __NR_truncate64 ] = (syscall_handler_t *) sys_truncate64, \
+	[ __NR_ftruncate64 ] = (syscall_handler_t *) sys_ftruncate64, \
+	[ __NR_stat64 ] = (syscall_handler_t *) sys_stat64, \
+	[ __NR_lstat64 ] = (syscall_handler_t *) sys_lstat64, \
+	[ __NR_fstat64 ] = (syscall_handler_t *) sys_fstat64, \
+	[ __NR_fcntl64 ] = (syscall_handler_t *) sys_fcntl64, \
+	[ __NR_sendfile64 ] = (syscall_handler_t *) sys_sendfile64, \
+	[ __NR_statfs64 ] = (syscall_handler_t *) sys_statfs64, \
+	[ __NR_fstatfs64 ] = (syscall_handler_t *) sys_fstatfs64, \
+	[ __NR_fadvise64_64 ] = (syscall_handler_t *) sys_fadvise64_64, \
 	[ __NR_select ] = (syscall_handler_t *) old_select, \
 	[ __NR_vm86old ] = (syscall_handler_t *) sys_ni_syscall, \
         [ __NR_modify_ldt ] = (syscall_handler_t *) sys_modify_ldt, \
@@ -38,11 +97,19 @@
 	[ __NR_pivot_root ] = (syscall_handler_t *) sys_pivot_root, \
 	[ __NR_mincore ] = (syscall_handler_t *) sys_mincore, \
 	[ __NR_madvise ] = (syscall_handler_t *) sys_madvise, \
-        [ 222 ] = (syscall_handler_t *) sys_ni_syscall,
+        [ 222 ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ 223 ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_set_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_get_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64, \
+	[ 251 ] = (syscall_handler_t *) sys_ni_syscall, \
+        [ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages, \
+	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes, \
+	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall,
         
 /* 222 doesn't yet have a name in include/asm-i386/unistd.h */
 
-#define LAST_ARCH_SYSCALL 222
+#define LAST_ARCH_SYSCALL __NR_vserver
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
Index: 2.6.10/arch/um/include/sysdep-ppc/syscalls.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-ppc/syscalls.h	2005-01-09 19:06:07.000000000 -0500
+++ 2.6.10/arch/um/include/sysdep-ppc/syscalls.h	2005-01-09 19:06:34.000000000 -0500
@@ -34,9 +34,12 @@
 	[ __NR_multiplexer ] = sys_ni_syscall, \
 	[ __NR_mmap ] = old_mmap, \
 	[ __NR_madvise ] = sys_madvise, \
-	[ __NR_mincore ] = sys_mincore, 
+	[ __NR_mincore ] = sys_mincore, \
+	[ __NR_iopl ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes, \
+	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64,
 
-#define LAST_ARCH_SYSCALL __NR_mincore
+#define LAST_ARCH_SYSCALL __NR_fadvise64
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
Index: 2.6.10/arch/um/include/sysdep-x86_64/syscalls.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-x86_64/syscalls.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/include/sysdep-x86_64/syscalls.h	2005-01-09 19:06:34.000000000 -0500
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSDEP_X86_64_SYSCALLS_H__
+#define __SYSDEP_X86_64_SYSCALLS_H__
+
+#include <linux/msg.h>
+#include <linux/shm.h>
+
+typedef long syscall_handler_t(void);
+
+extern syscall_handler_t *ia32_sys_call_table[];
+
+#define EXECUTE_SYSCALL(syscall, regs) \
+	(((long (*)(long, long, long, long, long, long)) \
+	  (*sys_call_table[syscall]))(UPT_SYSCALL_ARG1(&regs->regs), \
+		 		      UPT_SYSCALL_ARG2(&regs->regs), \
+				      UPT_SYSCALL_ARG3(&regs->regs), \
+				      UPT_SYSCALL_ARG4(&regs->regs), \
+				      UPT_SYSCALL_ARG5(&regs->regs), \
+				      UPT_SYSCALL_ARG6(&regs->regs)))
+
+extern long old_mmap(unsigned long addr, unsigned long len,
+		     unsigned long prot, unsigned long flags,
+		     unsigned long fd, unsigned long pgoff);
+extern syscall_handler_t wrap_sys_shmat;
+extern syscall_handler_t sys_modify_ldt;
+extern syscall_handler_t sys_arch_prctl;
+
+#define ARCH_SYSCALLS \
+	[ __NR_mmap ] = (syscall_handler_t *) old_mmap, \
+	[ __NR_select ] = (syscall_handler_t *) sys_select, \
+	[ __NR_mincore ] = (syscall_handler_t *) sys_mincore, \
+	[ __NR_madvise ] = (syscall_handler_t *) sys_madvise, \
+	[ __NR_shmget ] = (syscall_handler_t *) sys_shmget, \
+	[ __NR_shmat ] = (syscall_handler_t *) wrap_sys_shmat, \
+	[ __NR_shmctl ] = (syscall_handler_t *) sys_shmctl, \
+	[ __NR_semop ] = (syscall_handler_t *) sys_semop, \
+	[ __NR_semget ] = (syscall_handler_t *) sys_semget, \
+	[ __NR_semctl ] = (syscall_handler_t *) sys_semctl, \
+	[ __NR_shmdt ] = (syscall_handler_t *) sys_shmdt, \
+	[ __NR_msgget ] = (syscall_handler_t *) sys_msgget, \
+	[ __NR_msgsnd ] = (syscall_handler_t *) sys_msgsnd, \
+	[ __NR_msgrcv ] = (syscall_handler_t *) sys_msgrcv, \
+	[ __NR_msgctl ] = (syscall_handler_t *) sys_msgctl, \
+	[ __NR_pivot_root ] = (syscall_handler_t *) sys_pivot_root, \
+	[ __NR_tuxcall ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_security ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_epoll_ctl_old ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_epoll_wait_old ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_modify_ldt ] = (syscall_handler_t *) sys_modify_ldt, \
+	[ __NR_arch_prctl ] = (syscall_handler_t *) sys_arch_prctl, \
+	[ __NR_socket ] = (syscall_handler_t *) sys_socket, \
+	[ __NR_connect ] = (syscall_handler_t *) sys_connect, \
+	[ __NR_accept ] = (syscall_handler_t *) sys_accept, \
+	[ __NR_recvfrom ] = (syscall_handler_t *) sys_recvfrom, \
+	[ __NR_recvmsg ] = (syscall_handler_t *) sys_recvmsg, \
+	[ __NR_sendmsg ] = (syscall_handler_t *) sys_sendmsg, \
+	[ __NR_bind ] = (syscall_handler_t *) sys_bind, \
+	[ __NR_listen ] = (syscall_handler_t *) sys_listen, \
+	[ __NR_getsockname ] = (syscall_handler_t *) sys_getsockname, \
+	[ __NR_getpeername ] = (syscall_handler_t *) sys_getpeername, \
+	[ __NR_socketpair ] = (syscall_handler_t *) sys_socketpair, \
+	[ __NR_sendto ] = (syscall_handler_t *) sys_sendto, \
+	[ __NR_shutdown ] = (syscall_handler_t *) sys_shutdown, \
+	[ __NR_setsockopt ] = (syscall_handler_t *) sys_setsockopt, \
+	[ __NR_getsockopt ] = (syscall_handler_t *) sys_getsockopt, \
+	[ __NR_iopl ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_set_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_get_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
+        [ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages, \
+	[ __NR_semtimedop ] = (syscall_handler_t *) sys_semtimedop, \
+	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64, \
+	[ 223 ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes, \
+	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ 251 ] = (syscall_handler_t *) sys_ni_syscall,
+
+#define LAST_ARCH_SYSCALL 251
+#define NR_syscalls 1024
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/signal_kern.c	2005-01-09 18:29:53.000000000 -0500
+++ 2.6.10/arch/um/kernel/signal_kern.c	2005-01-09 19:06:06.000000000 -0500
@@ -194,37 +194,6 @@
 	}
 }
 
-int sys_sigaction(int sig, const struct old_sigaction __user *act,
-			 struct old_sigaction __user *oact)
-{
-	struct k_sigaction new_ka, old_ka;
-	int ret;
-
-	if (act) {
-		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
-		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
-		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
-			return -EFAULT;
-		__get_user(new_ka.sa.sa_flags, &act->sa_flags);
-		__get_user(mask, &act->sa_mask);
-		siginitset(&new_ka.sa.sa_mask, mask);
-	}
-
-	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
-
-	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
-		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
-		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
-			return -EFAULT;
-		__put_user(old_ka.sa.sa_flags, &oact->sa_flags);
-		__put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask);
-	}
-
-	return ret;
-}
-
 long sys_sigaltstack(const stack_t *uss, stack_t *uoss)
 {
 	return(do_sigaltstack(uss, uoss, PT_REGS_SP(&current->thread.regs)));
Index: 2.6.10/arch/um/kernel/sys_call_table.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/sys_call_table.c	2005-01-09 18:25:43.000000000 -0500
+++ 2.6.10/arch/um/kernel/sys_call_table.c	2005-01-09 19:06:34.000000000 -0500
@@ -1,5 +1,6 @@
 /* 
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Copyright 2003 PathScale, Inc.
  * Licensed under the GPL
  */
 
@@ -32,7 +33,6 @@
 extern syscall_handler_t um_time;
 extern syscall_handler_t um_mount;
 extern syscall_handler_t um_stime;
-extern syscall_handler_t sys_ptrace;
 extern syscall_handler_t sys_pipe;
 extern syscall_handler_t sys_olduname;
 extern syscall_handler_t sys_sigaction;
@@ -43,11 +43,8 @@
 extern syscall_handler_t sys_sigreturn;
 extern syscall_handler_t sys_clone;
 extern syscall_handler_t sys_rt_sigreturn;
-extern syscall_handler_t sys_rt_sigaction;
 extern syscall_handler_t sys_sigaltstack;
 extern syscall_handler_t sys_vfork;
-extern syscall_handler_t sys_mmap2;
-extern syscall_handler_t old_mmap_i386;
 extern syscall_handler_t old_select;
 extern syscall_handler_t sys_modify_ldt;
 extern syscall_handler_t sys_rt_sigsuspend;
@@ -62,7 +59,6 @@
 	/* These three are declared differently in asm/unistd.h */
 	[ __NR_open ] = (syscall_handler_t *) sys_open,
 	[ __NR_close ] = (syscall_handler_t *) sys_close,
-	[ __NR_waitpid ] = (syscall_handler_t *) sys_waitpid,
 	[ __NR_creat ] (syscall_handler_t *) sys_creat,
 	[ __NR_link ] (syscall_handler_t *) sys_link,
 	[ __NR_unlink ] (syscall_handler_t *) sys_unlink,
@@ -74,25 +70,16 @@
 	[ __NR_mknod ] (syscall_handler_t *) sys_mknod,
 	[ __NR_chmod ] (syscall_handler_t *) sys_chmod,
 	[ __NR_lchown ] (syscall_handler_t *) sys_lchown16,
-	[ __NR_break ] (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_oldstat ] (syscall_handler_t *) sys_stat,
 	[ __NR_lseek ] = (syscall_handler_t *) sys_lseek,
 	[ __NR_getpid ] (syscall_handler_t *) sys_getpid,
 	[ __NR_mount ] = um_mount,
-	[ __NR_umount ] (syscall_handler_t *) sys_oldumount,
 	[ __NR_setuid ] (syscall_handler_t *) sys_setuid16,
 	[ __NR_getuid ] (syscall_handler_t *) sys_getuid16,
-	[ __NR_stime ] = um_stime,
-	[ __NR_ptrace ] (syscall_handler_t *) sys_ptrace,
+ 	[ __NR_ptrace ] (syscall_handler_t *) sys_ptrace,
 	[ __NR_alarm ] (syscall_handler_t *) sys_alarm,
-	[ __NR_oldfstat ] (syscall_handler_t *) sys_fstat,
 	[ __NR_pause ] (syscall_handler_t *) sys_pause,
 	[ __NR_utime ] (syscall_handler_t *) sys_utime,
-	[ __NR_stty ] (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_gtty ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_access ] (syscall_handler_t *) sys_access,
-	[ __NR_nice ] (syscall_handler_t *) sys_nice,
-	[ __NR_ftime ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_sync ] (syscall_handler_t *) sys_sync,
 	[ __NR_kill ] (syscall_handler_t *) sys_kill,
 	[ __NR_rename ] (syscall_handler_t *) sys_rename,
@@ -103,22 +90,16 @@
 	[ __NR_dup ] = (syscall_handler_t *) sys_dup,
 	[ __NR_pipe ] (syscall_handler_t *) sys_pipe,
 	[ __NR_times ] (syscall_handler_t *) sys_times,
-	[ __NR_prof ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_brk ] (syscall_handler_t *) sys_brk,
 	[ __NR_setgid ] (syscall_handler_t *) sys_setgid16,
 	[ __NR_getgid ] (syscall_handler_t *) sys_getgid16,
-	[ __NR_signal ] (syscall_handler_t *) sys_signal,
 	[ __NR_geteuid ] (syscall_handler_t *) sys_geteuid16,
 	[ __NR_getegid ] (syscall_handler_t *) sys_getegid16,
 	[ __NR_acct ] (syscall_handler_t *) sys_acct,
 	[ __NR_umount2 ] (syscall_handler_t *) sys_umount,
-	[ __NR_lock ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_ioctl ] (syscall_handler_t *) sys_ioctl,
 	[ __NR_fcntl ] (syscall_handler_t *) sys_fcntl,
-	[ __NR_mpx ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_setpgid ] (syscall_handler_t *) sys_setpgid,
-	[ __NR_ulimit ] (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_oldolduname ] (syscall_handler_t *) sys_olduname,
 	[ __NR_umask ] (syscall_handler_t *) sys_umask,
 	[ __NR_chroot ] (syscall_handler_t *) sys_chroot,
 	[ __NR_ustat ] (syscall_handler_t *) sys_ustat,
@@ -126,13 +107,8 @@
 	[ __NR_getppid ] (syscall_handler_t *) sys_getppid,
 	[ __NR_getpgrp ] (syscall_handler_t *) sys_getpgrp,
 	[ __NR_setsid ] = (syscall_handler_t *) sys_setsid,
-	[ __NR_sigaction ] (syscall_handler_t *) sys_sigaction,
-	[ __NR_sgetmask ] (syscall_handler_t *) sys_sgetmask,
-	[ __NR_ssetmask ] (syscall_handler_t *) sys_ssetmask,
 	[ __NR_setreuid ] (syscall_handler_t *) sys_setreuid16,
 	[ __NR_setregid ] (syscall_handler_t *) sys_setregid16,
-	[ __NR_sigsuspend ] (syscall_handler_t *) sys_sigsuspend,
-	[ __NR_sigpending ] (syscall_handler_t *) sys_sigpending,
 	[ __NR_sethostname ] (syscall_handler_t *) sys_sethostname,
 	[ __NR_setrlimit ] (syscall_handler_t *) sys_setrlimit,
 	[ __NR_getrlimit ] (syscall_handler_t *) sys_old_getrlimit,
@@ -142,12 +118,10 @@
 	[ __NR_getgroups ] (syscall_handler_t *) sys_getgroups16,
 	[ __NR_setgroups ] (syscall_handler_t *) sys_setgroups16,
 	[ __NR_symlink ] (syscall_handler_t *) sys_symlink,
-	[ __NR_oldlstat ] (syscall_handler_t *) sys_lstat,
 	[ __NR_readlink ] (syscall_handler_t *) sys_readlink,
 	[ __NR_uselib ] (syscall_handler_t *) sys_uselib,
 	[ __NR_swapon ] = (syscall_handler_t *) sys_swapon,
 	[ __NR_reboot ] (syscall_handler_t *) sys_reboot,
-	[ __NR_readdir ] = old_readdir,
 	[ __NR_munmap ] (syscall_handler_t *) sys_munmap,
 	[ __NR_truncate ] (syscall_handler_t *) sys_truncate,
 	[ __NR_ftruncate ] (syscall_handler_t *) sys_ftruncate,
@@ -155,33 +129,25 @@
 	[ __NR_fchown ] (syscall_handler_t *) sys_fchown16,
 	[ __NR_getpriority ] (syscall_handler_t *) sys_getpriority,
 	[ __NR_setpriority ] (syscall_handler_t *) sys_setpriority,
-	[ __NR_profil ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_statfs ] (syscall_handler_t *) sys_statfs,
 	[ __NR_fstatfs ] (syscall_handler_t *) sys_fstatfs,
 	[ __NR_ioperm ] (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_socketcall ] (syscall_handler_t *) sys_socketcall,
 	[ __NR_syslog ] (syscall_handler_t *) sys_syslog,
 	[ __NR_setitimer ] (syscall_handler_t *) sys_setitimer,
 	[ __NR_getitimer ] (syscall_handler_t *) sys_getitimer,
 	[ __NR_stat ] (syscall_handler_t *) sys_newstat,
 	[ __NR_lstat ] (syscall_handler_t *) sys_newlstat,
 	[ __NR_fstat ] (syscall_handler_t *) sys_newfstat,
-	[ __NR_olduname ] (syscall_handler_t *) sys_uname,
-	[ __NR_iopl ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_vhangup ] (syscall_handler_t *) sys_vhangup,
-	[ __NR_idle ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_wait4 ] = (syscall_handler_t *) sys_wait4,
 	[ __NR_swapoff ] = (syscall_handler_t *) sys_swapoff,
 	[ __NR_sysinfo ] (syscall_handler_t *) sys_sysinfo,
-	[ __NR_ipc ] (syscall_handler_t *) sys_ipc,
 	[ __NR_fsync ] (syscall_handler_t *) sys_fsync,
-	[ __NR_sigreturn ] (syscall_handler_t *) sys_sigreturn,
 	[ __NR_clone ] (syscall_handler_t *) sys_clone,
 	[ __NR_setdomainname ] (syscall_handler_t *) sys_setdomainname,
 	[ __NR_uname ] (syscall_handler_t *) sys_newuname,
 	[ __NR_adjtimex ] (syscall_handler_t *) sys_adjtimex,
 	[ __NR_mprotect ] (syscall_handler_t *) sys_mprotect,
-	[ __NR_sigprocmask ] (syscall_handler_t *) sys_sigprocmask,
 	[ __NR_create_module ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_init_module ] (syscall_handler_t *) sys_init_module,
 	[ __NR_delete_module ] (syscall_handler_t *) sys_delete_module,
@@ -189,15 +155,12 @@
 	[ __NR_quotactl ] (syscall_handler_t *) sys_quotactl,
 	[ __NR_getpgid ] (syscall_handler_t *) sys_getpgid,
 	[ __NR_fchdir ] (syscall_handler_t *) sys_fchdir,
-	[ __NR_bdflush ] (syscall_handler_t *) sys_bdflush,
 	[ __NR_sysfs ] (syscall_handler_t *) sys_sysfs,
 	[ __NR_personality ] (syscall_handler_t *) sys_personality,
 	[ __NR_afs_syscall ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_setfsuid ] (syscall_handler_t *) sys_setfsuid16,
 	[ __NR_setfsgid ] (syscall_handler_t *) sys_setfsgid16,
-	[ __NR__llseek ] (syscall_handler_t *) sys_llseek,
 	[ __NR_getdents ] (syscall_handler_t *) sys_getdents,
-	[ __NR__newselect ] = (syscall_handler_t *) sys_select,
 	[ __NR_flock ] (syscall_handler_t *) sys_flock,
 	[ __NR_msync ] (syscall_handler_t *) sys_msync,
 	[ __NR_readv ] (syscall_handler_t *) sys_readv,
@@ -221,7 +184,6 @@
 	[ __NR_mremap ] (syscall_handler_t *) sys_mremap,
 	[ __NR_setresuid ] (syscall_handler_t *) sys_setresuid16,
 	[ __NR_getresuid ] (syscall_handler_t *) sys_getresuid16,
-	[ __NR_vm86 ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_query_module ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_poll ] (syscall_handler_t *) sys_poll,
 	[ __NR_nfsservctl ] = (syscall_handler_t *) NFSSERVCTL,
@@ -246,16 +208,7 @@
 	[ __NR_getpmsg ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_putpmsg ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_vfork ] (syscall_handler_t *) sys_vfork,
-	[ __NR_ugetrlimit ] (syscall_handler_t *) sys_getrlimit,
-	[ __NR_mmap2 ] (syscall_handler_t *) sys_mmap2,
-	[ __NR_truncate64 ] (syscall_handler_t *) sys_truncate64,
-	[ __NR_ftruncate64 ] (syscall_handler_t *) sys_ftruncate64,
-	[ __NR_stat64 ] (syscall_handler_t *) sys_stat64,
-	[ __NR_lstat64 ] (syscall_handler_t *) sys_lstat64,
-	[ __NR_fstat64 ] (syscall_handler_t *) sys_fstat64,
 	[ __NR_getdents64 ] (syscall_handler_t *) sys_getdents64,
-	[ __NR_fcntl64 ] (syscall_handler_t *) sys_fcntl64,
-	[ 223 ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_gettid ] (syscall_handler_t *) sys_gettid,
 	[ __NR_readahead ] (syscall_handler_t *) sys_readahead,
 	[ __NR_setxattr ] (syscall_handler_t *) sys_setxattr,
@@ -271,25 +224,19 @@
 	[ __NR_lremovexattr ] (syscall_handler_t *) sys_lremovexattr,
 	[ __NR_fremovexattr ] (syscall_handler_t *) sys_fremovexattr,
 	[ __NR_tkill ] (syscall_handler_t *) sys_tkill,
-	[ __NR_sendfile64 ] (syscall_handler_t *) sys_sendfile64,
 	[ __NR_futex ] (syscall_handler_t *) sys_futex,
 	[ __NR_sched_setaffinity ] (syscall_handler_t *) sys_sched_setaffinity,
 	[ __NR_sched_getaffinity ] (syscall_handler_t *) sys_sched_getaffinity,
-	[ __NR_set_thread_area ] (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_get_thread_area ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_io_setup ] (syscall_handler_t *) sys_io_setup,
 	[ __NR_io_destroy ] (syscall_handler_t *) sys_io_destroy,
 	[ __NR_io_getevents ] (syscall_handler_t *) sys_io_getevents,
 	[ __NR_io_submit ] (syscall_handler_t *) sys_io_submit,
 	[ __NR_io_cancel ] (syscall_handler_t *) sys_io_cancel,
-	[ __NR_fadvise64 ] (syscall_handler_t *) sys_fadvise64,
-	[ 251 ] (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_exit_group ] (syscall_handler_t *) sys_exit_group,
 	[ __NR_lookup_dcookie ] (syscall_handler_t *) sys_lookup_dcookie,
 	[ __NR_epoll_create ] (syscall_handler_t *) sys_epoll_create,
 	[ __NR_epoll_ctl ] (syscall_handler_t *) sys_epoll_ctl,
 	[ __NR_epoll_wait ] (syscall_handler_t *) sys_epoll_wait,
-        [ __NR_remap_file_pages ] (syscall_handler_t *) sys_remap_file_pages,
         [ __NR_set_tid_address ] (syscall_handler_t *) sys_set_tid_address,
 	[ __NR_timer_create ] (syscall_handler_t *) sys_timer_create,
 	[ __NR_timer_settime ] (syscall_handler_t *) sys_timer_settime,
@@ -300,12 +247,7 @@
 	[ __NR_clock_gettime ] (syscall_handler_t *) sys_clock_gettime,
 	[ __NR_clock_getres ] (syscall_handler_t *) sys_clock_getres,
 	[ __NR_clock_nanosleep ] (syscall_handler_t *) sys_clock_nanosleep,
-	[ __NR_statfs64 ] (syscall_handler_t *) sys_statfs64,
-	[ __NR_fstatfs64 ] (syscall_handler_t *) sys_fstatfs64,
 	[ __NR_tgkill ] (syscall_handler_t *) sys_tgkill,
-	[ __NR_utimes ] (syscall_handler_t *) sys_utimes,
-	[ __NR_fadvise64_64 ] (syscall_handler_t *) sys_fadvise64_64,
-	[ __NR_vserver ] (syscall_handler_t *) sys_ni_syscall,
 
 	ARCH_SYSCALLS
 	[ LAST_SYSCALL + 1 ... NR_syscalls ] = 
Index: 2.6.10/arch/um/kernel/syscall_kern.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/syscall_kern.c	2005-01-09 18:25:43.000000000 -0500
+++ 2.6.10/arch/um/kernel/syscall_kern.c	2005-01-09 19:06:07.000000000 -0500
@@ -56,12 +56,11 @@
 }
 
 /* common code for old and new mmaps */
-static inline long do_mmap2(
-	unsigned long addr, unsigned long len,
-	unsigned long prot, unsigned long flags,
-	unsigned long fd, unsigned long pgoff)
+long sys_mmap2(unsigned long addr, unsigned long len,
+	       unsigned long prot, unsigned long flags,
+	       unsigned long fd, unsigned long pgoff)
 {
-	int error = -EBADF;
+	long error = -EBADF;
 	struct file * file = NULL;
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
@@ -81,38 +80,15 @@
 	return error;
 }
 
-long sys_mmap2(unsigned long addr, unsigned long len,
-	       unsigned long prot, unsigned long flags,
-	       unsigned long fd, unsigned long pgoff)
-{
-	return do_mmap2(addr, len, prot, flags, fd, pgoff);
-}
-
-/*
- * Perform the select(nd, in, out, ex, tv) and mmap() system
- * calls. Linux/i386 didn't use to be able to handle more than
- * 4 system call parameters, so these system calls used a memory
- * block for parameter passing..
- */
-
-struct mmap_arg_struct {
-	unsigned long addr;
-	unsigned long len;
-	unsigned long prot;
-	unsigned long flags;
-	unsigned long fd;
-	unsigned long offset;
-};
-
 long old_mmap(unsigned long addr, unsigned long len,
-	     unsigned long prot, unsigned long flags,
-	     unsigned long fd, unsigned long offset)
+	      unsigned long prot, unsigned long flags,
+	      unsigned long fd, unsigned long offset)
 {
 	long err = -EINVAL;
 	if (offset & ~PAGE_MASK)
 		goto out;
 
-	err = do_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
+	err = sys_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
  out:
 	return err;
 }
@@ -133,90 +109,6 @@
         return error;
 }
 
-/*
- * sys_ipc() is the de-multiplexer for the SysV IPC calls..
- *
- * This is really horribly ugly.
- */
-int sys_ipc (uint call, int first, int second,
-	     int third, void *ptr, long fifth)
-{
-	int version, ret;
-
-	version = call >> 16; /* hack for backward compatibility */
-	call &= 0xffff;
-
-	switch (call) {
-	case SEMOP:
-		return sys_semtimedop(first, (struct sembuf *) ptr, second, 
-				      NULL);
-	case SEMTIMEDOP:
-		return sys_semtimedop(first, (struct sembuf *) ptr, second,
-				      (const struct timespec *) fifth);
-	case SEMGET:
-		return sys_semget (first, second, third);
-	case SEMCTL: {
-		union semun fourth;
-		if (!ptr)
-			return -EINVAL;
-		if (get_user(fourth.__pad, (void **) ptr))
-			return -EFAULT;
-		return sys_semctl (first, second, third, fourth);
-	}
-
-	case MSGSND:
-		return sys_msgsnd (first, (struct msgbuf *) ptr, 
-				   second, third);
-	case MSGRCV:
-		switch (version) {
-		case 0: {
-			struct ipc_kludge tmp;
-			if (!ptr)
-				return -EINVAL;
-			
-			if (copy_from_user(&tmp,
-					   (struct ipc_kludge *) ptr, 
-					   sizeof (tmp)))
-				return -EFAULT;
-			return sys_msgrcv (first, tmp.msgp, second,
-					   tmp.msgtyp, third);
-		}
-		default:
-		        panic("msgrcv with version != 0");
-			return sys_msgrcv (first,
-					   (struct msgbuf *) ptr,
-					   second, fifth, third);
-		}
-	case MSGGET:
-		return sys_msgget ((key_t) first, second);
-	case MSGCTL:
-		return sys_msgctl (first, second, (struct msqid_ds *) ptr);
-
-	case SHMAT:
-		switch (version) {
-		default: {
-			ulong raddr;
-			ret = do_shmat (first, (char *) ptr, second, &raddr);
-			if (ret)
-				return ret;
-			return put_user (raddr, (ulong *) third);
-		}
-		case 1:	/* iBCS2 emulator entry point */
-			if (!segment_eq(get_fs(), get_ds()))
-				return -EINVAL;
-			return do_shmat (first, (char *) ptr, second, (ulong *) third);
-		}
-	case SHMDT: 
-		return sys_shmdt ((char *)ptr);
-	case SHMGET:
-		return sys_shmget (first, second, third);
-	case SHMCTL:
-		return sys_shmctl (first, second,
-				   (struct shmid_ds *) ptr);
-	default:
-		return -ENOSYS;
-	}
-}
 
 long sys_uname(struct old_utsname * name)
 {
Index: 2.6.10/arch/um/kernel/tt/syscall_kern.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/tt/syscall_kern.c	2005-01-09 18:25:43.000000000 -0500
+++ 2.6.10/arch/um/kernel/tt/syscall_kern.c	2005-01-09 19:06:07.000000000 -0500
@@ -14,95 +14,6 @@
 #include "sysdep/syscalls.h"
 #include "kern_util.h"
 
-static inline int check_area(void *ptr, int size)
-{
-	return(verify_area(VERIFY_WRITE, ptr, size));
-}
-
-static int check_readlink(struct pt_regs *regs)
-{
-	return(check_area((void *) UPT_SYSCALL_ARG1(&regs->regs),
-			  UPT_SYSCALL_ARG2(&regs->regs)));
-}
-
-static int check_utime(struct pt_regs *regs)
-{
-	return(check_area((void *) UPT_SYSCALL_ARG1(&regs->regs),
-			  sizeof(struct utimbuf)));
-}
-
-static int check_oldstat(struct pt_regs *regs)
-{
-	return(check_area((void *) UPT_SYSCALL_ARG1(&regs->regs), 
-			  sizeof(struct __old_kernel_stat)));
-}
-
-static int check_stat(struct pt_regs *regs)
-{
-	return(check_area((void *) UPT_SYSCALL_ARG1(&regs->regs), 
-			  sizeof(struct stat)));
-}
-
-static int check_stat64(struct pt_regs *regs)
-{
-	return(check_area((void *) UPT_SYSCALL_ARG1(&regs->regs), 
-			  sizeof(struct stat64)));
-}
-
-struct bogus {
-	int kernel_ds;
-	int (*check_params)(struct pt_regs *);
-};
-
-struct bogus this_is_bogus[256] = {
-	[ __NR_mknod ] = { 1, NULL },
-	[ __NR_mkdir ] = { 1, NULL },
-	[ __NR_rmdir ] = { 1, NULL },
-	[ __NR_unlink ] = { 1, NULL },
-	[ __NR_symlink ] = { 1, NULL },
-	[ __NR_link ] = { 1, NULL },
-	[ __NR_rename ] = { 1, NULL },
-	[ __NR_umount ] = { 1, NULL },
-	[ __NR_mount ] = { 1, NULL },
-	[ __NR_pivot_root ] = { 1, NULL },
-	[ __NR_chdir ] = { 1, NULL },
-	[ __NR_chroot ] = { 1, NULL },
-	[ __NR_open ] = { 1, NULL },
-	[ __NR_quotactl ] = { 1, NULL },
-	[ __NR_sysfs ] = { 1, NULL },
-	[ __NR_readlink ] = { 1, check_readlink },
-	[ __NR_acct ] = { 1, NULL },
-	[ __NR_execve ] = { 1, NULL },
-	[ __NR_uselib ] = { 1, NULL },
-	[ __NR_statfs ] = { 1, NULL },
-	[ __NR_truncate ] = { 1, NULL },
-	[ __NR_access ] = { 1, NULL },
-	[ __NR_chmod ] = { 1, NULL },
-	[ __NR_chown ] = { 1, NULL },
-	[ __NR_lchown ] = { 1, NULL },
-	[ __NR_utime ] = { 1, check_utime },
-	[ __NR_oldlstat ] = { 1, check_oldstat },
-	[ __NR_oldstat ] = { 1, check_oldstat },
-	[ __NR_stat ] = { 1, check_stat },
-	[ __NR_lstat ] = { 1, check_stat },
-	[ __NR_stat64 ] = { 1, check_stat64 },
-	[ __NR_lstat64 ] = { 1, check_stat64 },
-	[ __NR_chown32 ] = { 1, NULL },
-};
-
-/* sys_utimes */
-
-static int check_bogosity(struct pt_regs *regs)
-{
-	struct bogus *bogon = &this_is_bogus[UPT_SYSCALL_NR(&regs->regs)];
-
-	if(!bogon->kernel_ds) return(0);
-	if(bogon->check_params && (*bogon->check_params)(regs))
-		return(-EFAULT);
-	set_fs(KERNEL_DS);
-	return(0);
-}
-
 extern syscall_handler_t *sys_call_table[];
 
 long execute_syscall_tt(void *r)
@@ -117,12 +28,8 @@
 
 	if((syscall >= NR_syscalls) || (syscall < 0))
 		res = -ENOSYS;
-	else if(honeypot && check_bogosity(regs))
-		res = -EFAULT;
 	else res = EXECUTE_SYSCALL(syscall, regs);
 
-	set_fs(USER_DS);
-
 	return(res);
 }
 
Index: 2.6.10/arch/um/sys-i386/syscalls.c
===================================================================
--- 2.6.10.orig/arch/um/sys-i386/syscalls.c	2005-01-09 18:25:43.000000000 -0500
+++ 2.6.10/arch/um/sys-i386/syscalls.c	2005-01-09 19:06:06.000000000 -0500
@@ -1,9 +1,11 @@
 /* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
  * Licensed under the GPL
  */
 
 #include "linux/sched.h"
+#include "linux/shm.h"
+#include "asm/ipc.h"
 #include "asm/mman.h"
 #include "asm/uaccess.h"
 #include "asm/unistd.h"
@@ -28,7 +30,7 @@
 		    unsigned long prot, unsigned long flags,
 		    unsigned long fd, unsigned long offset);
 
-int old_mmap_i386(struct mmap_arg_struct *arg)
+long old_mmap_i386(struct mmap_arg_struct *arg)
 {
 	struct mmap_arg_struct a;
 	int err = -EFAULT;
@@ -47,7 +49,7 @@
 	struct timeval *tvp;
 };
 
-int old_select(struct sel_arg_struct *arg)
+long old_select(struct sel_arg_struct *arg)
 {
 	struct sel_arg_struct a;
 
@@ -60,8 +62,8 @@
 /* The i386 version skips reading from %esi, the fourth argument. So we must do
  * this, too.
  */
-int sys_clone(unsigned long clone_flags, unsigned long newsp, int *parent_tid,
-	      int unused, int *child_tid)
+long sys_clone(unsigned long clone_flags, unsigned long newsp, int *parent_tid,
+	       int unused, int *child_tid)
 {
 	long ret;
 
@@ -79,6 +81,122 @@
 }
 
 /*
+ * sys_ipc() is the de-multiplexer for the SysV IPC calls..
+ *
+ * This is really horribly ugly.
+ */
+long sys_ipc (uint call, int first, int second,
+	     int third, void *ptr, long fifth)
+{
+	int version, ret;
+
+	version = call >> 16; /* hack for backward compatibility */
+	call &= 0xffff;
+
+	switch (call) {
+	case SEMOP:
+		return sys_semtimedop(first, (struct sembuf *) ptr, second, 
+				      NULL);
+	case SEMTIMEDOP:
+		return sys_semtimedop(first, (struct sembuf *) ptr, second,
+				      (const struct timespec *) fifth);
+	case SEMGET:
+		return sys_semget (first, second, third);
+	case SEMCTL: {
+		union semun fourth;
+		if (!ptr)
+			return -EINVAL;
+		if (get_user(fourth.__pad, (void **) ptr))
+			return -EFAULT;
+		return sys_semctl (first, second, third, fourth);
+	}
+
+	case MSGSND:
+		return sys_msgsnd (first, (struct msgbuf *) ptr, 
+				   second, third);
+	case MSGRCV:
+		switch (version) {
+		case 0: {
+			struct ipc_kludge tmp;
+			if (!ptr)
+				return -EINVAL;
+			
+			if (copy_from_user(&tmp,
+					   (struct ipc_kludge *) ptr, 
+					   sizeof (tmp)))
+				return -EFAULT;
+			return sys_msgrcv (first, tmp.msgp, second,
+					   tmp.msgtyp, third);
+		}
+		default:
+		        panic("msgrcv with version != 0");
+			return sys_msgrcv (first,
+					   (struct msgbuf *) ptr,
+					   second, fifth, third);
+		}
+	case MSGGET:
+		return sys_msgget ((key_t) first, second);
+	case MSGCTL:
+		return sys_msgctl (first, second, (struct msqid_ds *) ptr);
+
+	case SHMAT:
+		switch (version) {
+		default: {
+			ulong raddr;
+			ret = do_shmat (first, (char *) ptr, second, &raddr);
+			if (ret)
+				return ret;
+			return put_user (raddr, (ulong *) third);
+		}
+		case 1:	/* iBCS2 emulator entry point */
+			if (!segment_eq(get_fs(), get_ds()))
+				return -EINVAL;
+			return do_shmat (first, (char *) ptr, second, (ulong *) third);
+		}
+	case SHMDT: 
+		return sys_shmdt ((char *)ptr);
+	case SHMGET:
+		return sys_shmget (first, second, third);
+	case SHMCTL:
+		return sys_shmctl (first, second,
+				   (struct shmid_ds *) ptr);
+	default:
+		return -ENOSYS;
+	}
+}
+
+long sys_sigaction(int sig, const struct old_sigaction __user *act,
+			 struct old_sigaction __user *oact)
+{
+	struct k_sigaction new_ka, old_ka;
+	int ret;
+
+	if (act) {
+		old_sigset_t mask;
+		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
+		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
+			return -EFAULT;
+		__get_user(new_ka.sa.sa_flags, &act->sa_flags);
+		__get_user(mask, &act->sa_mask);
+		siginitset(&new_ka.sa.sa_mask, mask);
+	}
+
+	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
+
+	if (!ret && oact) {
+		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
+		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
+			return -EFAULT;
+		__put_user(old_ka.sa.sa_flags, &oact->sa_flags);
+		__put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask);
+	}
+
+	return ret;
+}
+
+/*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
  * adjust the settings for this buffer only.  This must remain at the end
Index: 2.6.10/arch/um/sys-x86_64/syscalls.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/syscalls.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/syscalls.c	2005-01-09 18:30:10.000000000 -0500
@@ -0,0 +1,191 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#include "linux/linkage.h"
+#include "linux/slab.h"
+#include "linux/shm.h"
+#include "asm/uaccess.h"
+#define __FRAME_OFFSETS
+#include "asm/ptrace.h"
+#include "asm/unistd.h"
+#include "asm/prctl.h" /* XXX This should get the constants from libc */
+#include "choose-mode.h"
+
+asmlinkage long wrap_sys_shmat(int shmid, char __user *shmaddr, int shmflg)
+{
+	unsigned long raddr;
+
+	return do_shmat(shmid, shmaddr, shmflg, &raddr) ?: (long) raddr;
+} 
+
+#ifdef CONFIG_MODE_TT
+extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
+
+long sys_modify_ldt_tt(int func, void *ptr, unsigned long bytecount)
+{
+	/* XXX This should check VERIFY_WRITE depending on func, check this
+	 * in i386 as well.
+	 */
+	if(verify_area(VERIFY_READ, ptr, bytecount)) 
+		return(-EFAULT);
+	return(modify_ldt(func, ptr, bytecount));
+}
+#endif
+
+#ifdef CONFIG_MODE_SKAS
+extern int userspace_pid;
+
+#ifndef __NR_mm_indirect
+#define __NR_mm_indirect 241
+#endif
+
+long sys_modify_ldt_skas(int func, void *ptr, unsigned long bytecount)
+{
+	unsigned long args[6];
+        void *buf;
+        int res, n;
+
+        buf = kmalloc(bytecount, GFP_KERNEL);
+        if(buf == NULL)
+                return(-ENOMEM);
+
+        res = 0;
+
+        switch(func){
+        case 1:
+        case 0x11:
+                res = copy_from_user(buf, ptr, bytecount);
+                break;
+        }
+
+        if(res != 0){
+                res = -EFAULT;
+                goto out;
+        }
+
+	args[0] = func;
+	args[1] = (unsigned long) buf;
+	args[2] = bytecount;
+	res = syscall(__NR_mm_indirect, &current->mm->context.u, 
+		      __NR_modify_ldt, args);
+
+        if(res < 0)
+                goto out;
+
+        switch(func){
+        case 0:
+        case 2:
+                n = res;
+                res = copy_to_user(ptr, buf, n);
+                if(res != 0)
+                        res = -EFAULT;
+                else 
+                        res = n;
+                break;
+        }
+
+ out:
+        kfree(buf);
+        return(res);
+}
+#endif
+
+long sys_modify_ldt(int func, void *ptr, unsigned long bytecount)
+{
+        return(CHOOSE_MODE_PROC(sys_modify_ldt_tt, sys_modify_ldt_skas, func, 
+                                ptr, bytecount));
+}
+
+#ifdef CONFIG_MODE_TT
+extern long arch_prctl(int code, unsigned long addr);
+
+static long arch_prctl_tt(int code, unsigned long addr)
+{
+	unsigned long tmp;
+	long ret;
+
+	switch(code){
+	case ARCH_SET_GS:
+	case ARCH_SET_FS:
+		ret = arch_prctl(code, addr);
+		break;
+	case ARCH_GET_FS:
+	case ARCH_GET_GS:
+		ret = arch_prctl(code, (unsigned long) &tmp);
+		if(!ret)
+			ret = put_user(tmp, &addr);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return(ret);
+}
+#endif
+
+#ifdef CONFIG_MODE_SKAS
+
+static long arch_prctl_skas(int code, unsigned long addr)
+{
+	long ret = 0;
+
+	switch(code){
+	case ARCH_SET_GS:
+		current->thread.regs.regs.skas.regs[GS_BASE / sizeof(unsigned long)] = addr;
+		break;
+	case ARCH_SET_FS:
+		current->thread.regs.regs.skas.regs[FS_BASE / sizeof(unsigned long)] = addr;
+		break;
+	case ARCH_GET_FS:
+		ret = put_user(current->thread.regs.regs.skas.regs[GS / sizeof(unsigned long)], &addr);
+	        break;
+	case ARCH_GET_GS:
+		ret = put_user(current->thread.regs.regs.skas.regs[FS / sizeof(unsigned \
+long)], &addr);
+	        break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return(ret);
+}
+#endif
+
+long sys_arch_prctl(int code, unsigned long addr)
+{
+	return(CHOOSE_MODE_PROC(arch_prctl_tt, arch_prctl_skas, code, addr));
+}
+
+long sys_clone(unsigned long clone_flags, unsigned long newsp, 
+	       void __user *parent_tid, void __user *child_tid)
+{
+	long ret;
+
+	/* XXX: normal arch do here this pass, and also pass the regs to
+	 * do_fork, instead of NULL. Currently the arch-independent code
+	 * ignores these values, while the UML code (actually it's
+	 * copy_thread) does the right thing. But this should change,
+	 probably. */
+	/*if (!newsp)
+		newsp = UPT_SP(current->thread.regs);*/
+	current->thread.forking = 1;
+	ret = do_fork(clone_flags, newsp, NULL, 0, parent_tid, child_tid);
+	current->thread.forking = 0;
+	return(ret);
+}
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */

