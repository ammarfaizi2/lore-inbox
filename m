Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWC3E7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWC3E7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 23:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWC3E7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 23:59:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63187 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S1750820AbWC3E7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 23:59:21 -0500
Date: Thu, 30 Mar 2006 13:59:08 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: Re: [PATCH 2.6.16-git] defines MMU mode specific syscalls as
 'cond_syscall' and clean-up unneeded macros
In-reply-to: <20060329153251.30826295.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, linux@arm.linux.org.uk
Message-id: <200603301359.08701.hyok.choi@samsung.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_m/6CJz3OYjrZlIy0mh+nWA)"
User-Agent: KMail/1.8.3
References: <200603291829.57719.hyok.choi@samsung.com>
 <20060329153251.30826295.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_m/6CJz3OYjrZlIy0mh+nWA)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline

On Thursday 30 March 2006 08:32 am, Andrew Morton wrote:
> "Hyok S. Choi" <hyok.choi@samsung.com> wrote:
> > diff --git a/arch/frv/kernel/entry.S b/arch/frv/kernel/entry.S
> > index 1d21c8d..a9b5952 100644
> > --- a/arch/frv/kernel/entry.S
> > +++ b/arch/frv/kernel/entry.S
>
> Your email client mangled this patch more than I am prepared to unmangle
> it.  Probably you need to use a text/plain attachment when resending,
> please.

Okay, I've attached the patch.
(BTW, I could not guess what part of my previous mail was mangled. I found no 
problem when I got the patch from the mailing-list, by gmail?)

-- 
Hyok
ARM Linux 2.6 MPU/noMMU Project http://opensrc.sec.samsung.com/

--Boundary_(ID_m/6CJz3OYjrZlIy0mh+nWA)
Content-type: text/plain; charset=iso-8859-1; name=nommu-sys_ni.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=nommu-sys_ni.diff

defines MMU mode specific syscalls as 'cond_syscall' and clean-up unneeded macros

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

--Boundary_(ID_m/6CJz3OYjrZlIy0mh+nWA)--
