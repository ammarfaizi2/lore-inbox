Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUE2TcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUE2TcR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 15:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUE2TcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 15:32:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46499 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263775AbUE2TcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 15:32:13 -0400
Date: Sat, 29 May 2004 12:31:55 -0700
From: "David S. Miller" <davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: compat syscall args
Message-Id: <20040529123155.5ca76207.davem@redhat.com>
In-Reply-To: <20040529122319.49eaafe1.davem@redhat.com>
References: <20040529122319.49eaafe1.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004 12:23:19 -0700
"David S. Miller" <davem@redhat.com> wrote:

> Each platform is going to behave differently in this area, so
> I suppose the right thing to do really is to have the arch
> specific code use little zero/sign extender stubs when necessary
> so that the compat layer can assume that the args are properly
> sign/zero extended already.  I guess this is how I'll fix this
> up on sparc64 for now.

As it turns out we're taking care of this already via stubs
in arch/sparc64/kernel/sys32.S, I just need to add them for
select and futex.

Here is how I'm going to fix this on sparc64 therefore.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/29 12:27:54-07:00 davem@nuts.davemloft.net 
#   [SPARC64]: compat select and futex need %o4 zero-extended.
# 
# arch/sparc64/kernel/systbls.S
#   2004/05/29 12:27:36-07:00 davem@nuts.davemloft.net +3 -3
#   [SPARC64]: compat select and futex need %o4 zero-extended.
# 
# arch/sparc64/kernel/sys32.S
#   2004/05/29 12:27:36-07:00 davem@nuts.davemloft.net +13 -0
#   [SPARC64]: compat select and futex need %o4 zero-extended.
# 
diff -Nru a/arch/sparc64/kernel/sys32.S b/arch/sparc64/kernel/sys32.S
--- a/arch/sparc64/kernel/sys32.S	2004-05-29 12:28:12 -07:00
+++ b/arch/sparc64/kernel/sys32.S	2004-05-29 12:28:12 -07:00
@@ -6,6 +6,7 @@
  * Copyright (C) 1998 Jakub Jelinek   (jj@ultra.linux.cz)
  */
 
+#include <linux/config.h>
 #include <asm/errno.h>
 
 /* NOTE: call as jump breaks return stack, we have to avoid that */
@@ -77,6 +78,18 @@
 sys32_mq_timedreceive:
 	sethi		%hi(compat_sys_mq_timedreceive), %g1
 	jmpl		%g1 + %lo(compat_sys_mq_timedreceive), %g0
+	 srl		%o4, 0, %o4
+
+	.globl		sys32_select
+sys32_select:
+	sethi		%hi(compat_sys_select), %g1
+	jmpl		%g1 + %lo(compat_sys_select), %g0
+	 srl		%o4, 0, %o4
+
+	.globl		sys32_futex
+sys32_futex:
+	sethi		%hi(compat_sys_futex), %g1
+	jmpl		%g1 + %lo(compat_sys_futex), %g0
 	 srl		%o4, 0, %o4
 
 	.align		32
diff -Nru a/arch/sparc64/kernel/systbls.S b/arch/sparc64/kernel/systbls.S
--- a/arch/sparc64/kernel/systbls.S	2004-05-29 12:28:12 -07:00
+++ b/arch/sparc64/kernel/systbls.S	2004-05-29 12:28:12 -07:00
@@ -37,7 +37,7 @@
 	.word sys_madvise, sys_vhangup, sys32_truncate64, sys_mincore, sys32_getgroups16
 /*80*/	.word sys32_setgroups16, sys_getpgrp, sys_setgroups, compat_sys_setitimer, sys32_ftruncate64
 	.word sys_swapon, compat_sys_getitimer, sys_setuid, sys_sethostname, sys_setgid
-/*90*/	.word sys_dup2, sys_setfsuid, compat_sys_fcntl, compat_sys_select, sys_setfsgid
+/*90*/	.word sys_dup2, sys_setfsuid, compat_sys_fcntl, sys32_select, sys_setfsgid
 	.word sys_fsync, sys_setpriority32, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
 /*100*/ .word sys_getpriority, sys32_rt_sigreturn, sys32_rt_sigaction, sys32_rt_sigprocmask, sys32_rt_sigpending
 	.word sys32_rt_sigtimedwait, sys32_rt_sigqueueinfo, sys32_rt_sigsuspend, sys_setresuid, sys_getresuid
@@ -47,7 +47,7 @@
 	.word sys_nis_syscall, sys32_setreuid16, sys32_setregid16, sys_rename, sys_truncate
 /*130*/	.word sys_ftruncate, sys_flock, sys_lstat64, sys_nis_syscall, sys_nis_syscall
 	.word sys_nis_syscall, sys_mkdir, sys_rmdir, sys32_utimes, sys_stat64
-/*140*/	.word sys32_sendfile64, sys_nis_syscall, compat_sys_futex, sys_gettid, compat_sys_getrlimit
+/*140*/	.word sys32_sendfile64, sys_nis_syscall, sys32_futex, sys_gettid, compat_sys_getrlimit
 	.word compat_sys_setrlimit, sys_pivot_root, sys32_prctl, sys32_pciconfig_read, sys32_pciconfig_write
 /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
 	.word compat_sys_fcntl64, sys_ni_syscall, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
@@ -65,7 +65,7 @@
 	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
 /*220*/	.word compat_sys_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
-/*230*/	.word compat_sys_select, sys_time, sys_nis_syscall, sys_stime, compat_statfs64
+/*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, compat_statfs64
 	.word compat_fstatfs64, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, sys_sched_setscheduler, sys_sched_getscheduler
 	.word sys_sched_yield, sys_sched_get_priority_max, sys_sched_get_priority_min, sys32_sched_rr_get_interval, compat_sys_nanosleep

