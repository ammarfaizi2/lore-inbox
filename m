Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVDXSqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVDXSqN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVDXSp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:45:59 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:35502 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262368AbVDXSol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:44:41 -0400
Subject: [patch 2/7] uml: quick fix syscall table for x86_64
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:19:12 +0200
Message-Id: <20050424181912.30DEC55CFB@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the moved syscall table for the x86_64 SUBARCH:
*) redirect __NR_chown and such to versions aware of 32-bit UIDs,
*) avoid the useless hack for sys_nfsservctl,
*) use sys_sendfile64 in the table rather than sys_sendfile.
*) __NR_uselib is sys_ni_syscall on x86_64 (which does not support A.OUT).
*) __NR_getrlimit is sys_getrlimit, not sys_old_getrlimit

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/sys-x86_64/sys_call_table.c |   53 +++++++----------
 1 files changed, 24 insertions(+), 29 deletions(-)

diff -puN arch/um/sys-x86_64/sys_call_table.c~uml-quick-fix-syscall-table-x86_64 arch/um/sys-x86_64/sys_call_table.c
--- linux-2.6.12/arch/um/sys-x86_64/sys_call_table.c~uml-quick-fix-syscall-table-x86_64	2005-04-24 20:17:03.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/sys-x86_64/sys_call_table.c	2005-04-24 20:17:03.000000000 +0200
@@ -14,12 +14,6 @@
 #include "sysdep/syscalls.h"
 #include "kern_util.h"
 
-#ifdef CONFIG_NFSD
-#define NFSSERVCTL sys_nfsservctl
-#else
-#define NFSSERVCTL sys_ni_syscall
-#endif
-
 #define LAST_GENERIC_SYSCALL __NR_keyctl
 
 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
@@ -52,6 +46,7 @@ extern syscall_handler_t sys_get_mempoli
 extern syscall_handler_t sys_set_mempolicy;
 extern syscall_handler_t sys_sys_setaltroot;
 
+/* On X86-64 all syscalls are aware of 32-bit [ug]ids, so I had to fix this!*/
 syscall_handler_t *sys_call_table[] = {
 	[ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
 	[ __NR_exit ] = (syscall_handler_t *) sys_exit,
@@ -72,12 +67,12 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_time ] = um_time,
 	[ __NR_mknod ] = (syscall_handler_t *) sys_mknod,
 	[ __NR_chmod ] = (syscall_handler_t *) sys_chmod,
-	[ __NR_lchown ] = (syscall_handler_t *) sys_lchown16,
+	[ __NR_lchown ] = (syscall_handler_t *) sys_lchown,
 	[ __NR_lseek ] = (syscall_handler_t *) sys_lseek,
 	[ __NR_getpid ] = (syscall_handler_t *) sys_getpid,
 	[ __NR_mount ] = (syscall_handler_t *) sys_mount,
-	[ __NR_setuid ] = (syscall_handler_t *) sys_setuid16,
-	[ __NR_getuid ] = (syscall_handler_t *) sys_getuid16,
+	[ __NR_setuid ] = (syscall_handler_t *) sys_setuid,
+	[ __NR_getuid ] = (syscall_handler_t *) sys_getuid,
  	[ __NR_ptrace ] = (syscall_handler_t *) sys_ptrace,
 	[ __NR_alarm ] = (syscall_handler_t *) sys_alarm,
 	[ __NR_pause ] = (syscall_handler_t *) sys_pause,
@@ -94,10 +89,10 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_pipe ] = (syscall_handler_t *) sys_pipe,
 	[ __NR_times ] = (syscall_handler_t *) sys_times,
 	[ __NR_brk ] = (syscall_handler_t *) sys_brk,
-	[ __NR_setgid ] = (syscall_handler_t *) sys_setgid16,
-	[ __NR_getgid ] = (syscall_handler_t *) sys_getgid16,
-	[ __NR_geteuid ] = (syscall_handler_t *) sys_geteuid16,
-	[ __NR_getegid ] = (syscall_handler_t *) sys_getegid16,
+	[ __NR_setgid ] = (syscall_handler_t *) sys_setgid,
+	[ __NR_getgid ] = (syscall_handler_t *) sys_getgid,
+	[ __NR_geteuid ] = (syscall_handler_t *) sys_geteuid,
+	[ __NR_getegid ] = (syscall_handler_t *) sys_getegid,
 	[ __NR_acct ] = (syscall_handler_t *) sys_acct,
 	[ __NR_umount2 ] = (syscall_handler_t *) sys_umount,
 	[ __NR_ioctl ] = (syscall_handler_t *) sys_ioctl,
@@ -110,26 +105,26 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_getppid ] = (syscall_handler_t *) sys_getppid,
 	[ __NR_getpgrp ] = (syscall_handler_t *) sys_getpgrp,
 	[ __NR_setsid ] = (syscall_handler_t *) sys_setsid,
-	[ __NR_setreuid ] = (syscall_handler_t *) sys_setreuid16,
-	[ __NR_setregid ] = (syscall_handler_t *) sys_setregid16,
+	[ __NR_setreuid ] = (syscall_handler_t *) sys_setreuid,
+	[ __NR_setregid ] = (syscall_handler_t *) sys_setregid,
 	[ __NR_sethostname ] = (syscall_handler_t *) sys_sethostname,
 	[ __NR_setrlimit ] = (syscall_handler_t *) sys_setrlimit,
-	[ __NR_getrlimit ] = (syscall_handler_t *) sys_old_getrlimit,
+	[ __NR_getrlimit ] = (syscall_handler_t *) sys_getrlimit,
 	[ __NR_getrusage ] = (syscall_handler_t *) sys_getrusage,
 	[ __NR_gettimeofday ] = (syscall_handler_t *) sys_gettimeofday,
 	[ __NR_settimeofday ] = (syscall_handler_t *) sys_settimeofday,
-	[ __NR_getgroups ] = (syscall_handler_t *) sys_getgroups16,
-	[ __NR_setgroups ] = (syscall_handler_t *) sys_setgroups16,
+	[ __NR_getgroups ] = (syscall_handler_t *) sys_getgroups,
+	[ __NR_setgroups ] = (syscall_handler_t *) sys_setgroups,
 	[ __NR_symlink ] = (syscall_handler_t *) sys_symlink,
 	[ __NR_readlink ] = (syscall_handler_t *) sys_readlink,
-	[ __NR_uselib ] = (syscall_handler_t *) sys_uselib,
+	[ __NR_uselib ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_swapon ] = (syscall_handler_t *) sys_swapon,
 	[ __NR_reboot ] = (syscall_handler_t *) sys_reboot,
 	[ __NR_munmap ] = (syscall_handler_t *) sys_munmap,
 	[ __NR_truncate ] = (syscall_handler_t *) sys_truncate,
 	[ __NR_ftruncate ] = (syscall_handler_t *) sys_ftruncate,
 	[ __NR_fchmod ] = (syscall_handler_t *) sys_fchmod,
-	[ __NR_fchown ] = (syscall_handler_t *) sys_fchown16,
+	[ __NR_fchown ] = (syscall_handler_t *) sys_fchown,
 	[ __NR_getpriority ] = (syscall_handler_t *) sys_getpriority,
 	[ __NR_setpriority ] = (syscall_handler_t *) sys_setpriority,
 	[ __NR_statfs ] = (syscall_handler_t *) sys_statfs,
@@ -161,8 +156,8 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_sysfs ] = (syscall_handler_t *) sys_sysfs,
 	[ __NR_personality ] = (syscall_handler_t *) sys_personality,
 	[ __NR_afs_syscall ] = (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_setfsuid ] = (syscall_handler_t *) sys_setfsuid16,
-	[ __NR_setfsgid ] = (syscall_handler_t *) sys_setfsgid16,
+	[ __NR_setfsuid ] = (syscall_handler_t *) sys_setfsuid,
+	[ __NR_setfsgid ] = (syscall_handler_t *) sys_setfsgid,
 	[ __NR_getdents ] = (syscall_handler_t *) sys_getdents,
 	[ __NR_flock ] = (syscall_handler_t *) sys_flock,
 	[ __NR_msync ] = (syscall_handler_t *) sys_msync,
@@ -185,13 +180,13 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_sched_rr_get_interval ] = (syscall_handler_t *) sys_sched_rr_get_interval,
 	[ __NR_nanosleep ] = (syscall_handler_t *) sys_nanosleep,
 	[ __NR_mremap ] = (syscall_handler_t *) sys_mremap,
-	[ __NR_setresuid ] = (syscall_handler_t *) sys_setresuid16,
-	[ __NR_getresuid ] = (syscall_handler_t *) sys_getresuid16,
+	[ __NR_setresuid ] = (syscall_handler_t *) sys_setresuid,
+	[ __NR_getresuid ] = (syscall_handler_t *) sys_getresuid,
 	[ __NR_query_module ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_poll ] = (syscall_handler_t *) sys_poll,
-	[ __NR_nfsservctl ] = (syscall_handler_t *) NFSSERVCTL,
-	[ __NR_setresgid ] = (syscall_handler_t *) sys_setresgid16,
-	[ __NR_getresgid ] = (syscall_handler_t *) sys_getresgid16,
+	[ __NR_nfsservctl ] = (syscall_handler_t *) sys_nfsservctl,
+	[ __NR_setresgid ] = (syscall_handler_t *) sys_setresgid,
+	[ __NR_getresgid ] = (syscall_handler_t *) sys_getresgid,
 	[ __NR_prctl ] = (syscall_handler_t *) sys_prctl,
 	[ __NR_rt_sigreturn ] = (syscall_handler_t *) sys_rt_sigreturn,
 	[ __NR_rt_sigaction ] = (syscall_handler_t *) sys_rt_sigaction,
@@ -202,12 +197,12 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_rt_sigsuspend ] = (syscall_handler_t *) sys_rt_sigsuspend,
 	[ __NR_pread64 ] = (syscall_handler_t *) sys_pread64,
 	[ __NR_pwrite64 ] = (syscall_handler_t *) sys_pwrite64,
-	[ __NR_chown ] = (syscall_handler_t *) sys_chown16,
+	[ __NR_chown ] = (syscall_handler_t *) sys_chown,
 	[ __NR_getcwd ] = (syscall_handler_t *) sys_getcwd,
 	[ __NR_capget ] = (syscall_handler_t *) sys_capget,
 	[ __NR_capset ] = (syscall_handler_t *) sys_capset,
 	[ __NR_sigaltstack ] = (syscall_handler_t *) sys_sigaltstack,
-	[ __NR_sendfile ] = (syscall_handler_t *) sys_sendfile,
+	[ __NR_sendfile ] = (syscall_handler_t *) sys_sendfile64,
 	[ __NR_getpmsg ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_putpmsg ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_vfork ] = (syscall_handler_t *) sys_vfork,
_
