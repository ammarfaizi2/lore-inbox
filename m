Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWC2J3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWC2J3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 04:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWC2J3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 04:29:49 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:22895 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S1751080AbWC2J3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 04:29:48 -0500
Date: Wed, 29 Mar 2006 18:29:57 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 2.6.16-git] defines MMU mode specific syscalls as
 'cond_syscall' and clean-up unneeded macros
To: linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>
Message-id: <200603291829.57719.hyok.choi@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.8.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyok S. Choi <hyok.choi@samsung.com>

For some architectures, a few syscalls are not linked in noMMU mode.
In that case, the MMU depending syscalls are needed to be defined
as 'cond_syscall'. For example, ARM architecture selectively links
sys_mlock by the mode configuration.

In case of FRV, it has been managed by #ifdef CONFIG_MMU macro in
arch/frv/kernel/entry.S. However these conditional macros are just
duplicates if they were defined as cond_syscall. Compilation test
is done with FRV toolchains for both of MMU and noMMU mode.

Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
---

 arch/frv/kernel/entry.S |   26 ++++++++++----------------
 kernel/sys_ni.c         |   12 ++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/frv/kernel/entry.S b/arch/frv/kernel/entry.S
index 1d21c8d..a9b5952 100644
--- a/arch/frv/kernel/entry.S
+++ b/arch/frv/kernel/entry.S
@@ -1170,12 +1170,6 @@ __syscall_badsys:
 # syscall vector table
 #
 
###############################################################################
-#ifdef CONFIG_MMU
-#define __MMU(X) X
-#else
-#define __MMU(X) sys_ni_syscall
-#endif
-
 	.section .rodata
 ALIGN
 	.globl		sys_call_table
@@ -1305,7 +1299,7 @@ sys_call_table:
 	.long sys_newuname
 	.long sys_ni_syscall	/* old "cacheflush" */
 	.long sys_adjtimex
-	.long __MMU(sys_mprotect) /* 125 */
+	.long sys_mprotect	/* 125 */
 	.long sys_sigprocmask
 	.long sys_ni_syscall	/* old "create_module" */
 	.long sys_init_module
@@ -1324,16 +1318,16 @@ sys_call_table:
 	.long sys_getdents
 	.long sys_select
 	.long sys_flock
-	.long __MMU(sys_msync)
+	.long sys_msync
 	.long sys_readv		/* 145 */
 	.long sys_writev
 	.long sys_getsid
 	.long sys_fdatasync
 	.long sys_sysctl
-	.long __MMU(sys_mlock)		/* 150 */
-	.long __MMU(sys_munlock)
-	.long __MMU(sys_mlockall)
-	.long __MMU(sys_munlockall)
+	.long sys_mlock		/* 150 */
+	.long sys_munlock
+	.long sys_mlockall
+	.long sys_munlockall
 	.long sys_sched_setparam
 	.long sys_sched_getparam   /* 155 */
 	.long sys_sched_setscheduler
@@ -1343,7 +1337,7 @@ sys_call_table:
 	.long sys_sched_get_priority_min  /* 160 */
 	.long sys_sched_rr_get_interval
 	.long sys_nanosleep
-	.long __MMU(sys_mremap)
+	.long sys_mremap
 	.long sys_setresuid16
 	.long sys_getresuid16	/* 165 */
 	.long sys_ni_syscall	/* for vm86 */
@@ -1398,8 +1392,8 @@ sys_call_table:
 	.long sys_setfsuid		/* 215 */
 	.long sys_setfsgid
 	.long sys_pivot_root
-	.long __MMU(sys_mincore)
-	.long __MMU(sys_madvise)
+	.long sys_mincore
+	.long sys_madvise
 	.long sys_getdents64	/* 220 */
 	.long sys_fcntl64
 	.long sys_ni_syscall	/* reserved for TUX */
@@ -1437,7 +1431,7 @@ sys_call_table:
 	.long sys_epoll_create
 	.long sys_epoll_ctl	/* 255 */
 	.long sys_epoll_wait
- 	.long __MMU(sys_remap_file_pages)
+ 	.long sys_remap_file_pages
  	.long sys_set_tid_address
  	.long sys_timer_create
  	.long sys_timer_settime		/* 260 */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d82864c..5433195 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -120,3 +120,15 @@ cond_syscall(sys32_sysctl);
 cond_syscall(ppc_rtas);
 cond_syscall(sys_spu_run);
 cond_syscall(sys_spu_create);
+
+/* mmu depending weak syscall entries */
+cond_syscall(sys_mprotect);
+cond_syscall(sys_msync);
+cond_syscall(sys_mlock);
+cond_syscall(sys_munlock);
+cond_syscall(sys_mlockall);
+cond_syscall(sys_munlockall);
+cond_syscall(sys_mincore);
+cond_syscall(sys_madvise);
+cond_syscall(sys_mremap);
+cond_syscall(sys_remap_file_pages);

--
Hyok
ARM Linux 2.6 MPU/noMMU Project http://opensrc.sec.samsung.com/
