Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTENGSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTENGSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:18:32 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:15657 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262056AbTENGST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:18:19 -0400
Date: Tue, 13 May 2003 23:32:19 -0700
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: ch@murgatroid.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-Id: <20030513233219.5f39bf33.akpm@digeo.com>
In-Reply-To: <20030514071446.A2647@infradead.org>
References: <20030513213157.A1063@heavens.murgatroid.com>
	<20030514071446.A2647@infradead.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 06:31:01.0233 (UTC) FILETIME=[63180E10:01C319E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, May 13, 2003 at 09:32:07PM -0700, Christopher Hoover wrote:
> > Not everyone needs futex support, so it should be optional.  This is
> > needed for small platforms.
> 
> Looks good.  I think you want to disable it unconditionally for !CONFIG_MMU.
> 

It needs some changes for non-ia32.


diff -puN init/Kconfig~CONFIG_FUTEX init/Kconfig
--- 25-power4/init/Kconfig~CONFIG_FUTEX	2003-05-13 22:12:34.000000000 -0700
+++ 25-power4-akpm/init/Kconfig	2003-05-13 22:12:34.000000000 -0700
@@ -108,8 +108,14 @@ config LOG_BUF_SHIFT
 		     13 =>  8 KB
 		     12 =>  4 KB
 
-endmenu
 
+config FUTEX
+       bool "Futex support"
+       default y
+       ---help---
+       Say Y if you want support for Fast Userspace Mutexes (Futexes).
+
+endmenu
 
 menu "Loadable module support"
 
diff -puN kernel/Makefile~CONFIG_FUTEX kernel/Makefile
--- 25-power4/kernel/Makefile~CONFIG_FUTEX	2003-05-13 22:12:34.000000000 -0700
+++ 25-power4-akpm/kernel/Makefile	2003-05-13 22:15:09.000000000 -0700
@@ -5,9 +5,10 @@
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o workqueue.o futex.o pid.o \
+	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
 
+obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
 obj-$(CONFIG_LOCKMETER) += lockmeter.o
diff -puN kernel/sys.c~CONFIG_FUTEX kernel/sys.c
--- 25-power4/kernel/sys.c~CONFIG_FUTEX	2003-05-13 22:12:34.000000000 -0700
+++ 25-power4-akpm/kernel/sys.c	2003-05-13 22:12:34.000000000 -0700
@@ -228,6 +228,7 @@ cond_syscall(sys_shutdown)
 cond_syscall(sys_sendmsg)
 cond_syscall(sys_recvmsg)
 cond_syscall(sys_socketcall)
+cond_syscall(sys_futex)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
diff -puN kernel/compat.c~CONFIG_FUTEX kernel/compat.c
--- 25-power4/kernel/compat.c~CONFIG_FUTEX	2003-05-13 22:17:56.000000000 -0700
+++ 25-power4-akpm/kernel/compat.c	2003-05-13 22:27:29.000000000 -0700
@@ -211,11 +211,10 @@ asmlinkage long compat_sys_sigprocmask(i
 	return ret;
 }
 
-extern long do_futex(unsigned long, int, int, unsigned long);
-
 asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
 		struct compat_timespec *utime)
 {
+#ifdef CONFIG_FUTEX
 	struct timespec t;
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
 
@@ -225,6 +224,9 @@ asmlinkage long compat_sys_futex(u32 *ua
 		timeout = timespec_to_jiffies(&t) + 1;
 	}
 	return do_futex((unsigned long)uaddr, op, val, timeout);
+#else
+	return -ENOSYS;
+#endif
 }
 
 asmlinkage long sys_setrlimit(unsigned int resource, struct rlimit *rlim);
diff -puN include/linux/futex.h~CONFIG_FUTEX include/linux/futex.h
--- 25-power4/include/linux/futex.h~CONFIG_FUTEX	2003-05-13 22:18:20.000000000 -0700
+++ 25-power4-akpm/include/linux/futex.h	2003-05-13 22:22:21.000000000 -0700
@@ -8,4 +8,6 @@
 
 extern asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime);
 
+long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout);
+
 #endif

_

