Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbTENHji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 03:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbTENHje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 03:39:34 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:33268 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id S262251AbTENHj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 03:39:29 -0400
Date: Wed, 14 May 2003 00:52:15 -0700
From: Christopher Hoover <ch@murgatroid.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, ch@murgatroid.com
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-ID: <20030514005213.A3325@heavens.murgatroid.com>
References: <20030513213157.A1063@heavens.murgatroid.com> <20030514071446.A2647@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030514071446.A2647@infradead.org>; from hch@infradead.org on Wed, May 14, 2003 at 07:14:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 07:14:46AM +0100, Christoph Hellwig wrote:
> On Tue, May 13, 2003 at 09:32:07PM -0700, Christopher Hoover wrote:
> > Not everyone needs futex support, so it should be optional.  This is
> > needed for small platforms.
> 
> Looks good.  I think you want to disable it unconditionally for !CONFIG_MMU.

Good point.  

Here it is again with the config change.  The previous version also had
had a Makefile typo.  Plus a cond_syscall for compat_sys_futex to make
it work for CONFIG_COMPAT (untested), as pointed out by akpm.

diff --exclude=drivers --exclude=net --exclude=sound -X dontdiff.txt -Naurp linux-2.5.69.orig/include/linux/futex.h linux-2.5.69/include/linux/futex.h
--- linux-2.5.69.orig/include/linux/futex.h	2003-05-04 16:53:33.000000000 -0700
+++ linux-2.5.69/include/linux/futex.h	2003-05-14 00:17:25.000000000 -0700
@@ -8,4 +8,6 @@
 
 extern asmlinkage long sys_futex(u32 *uaddr, int op, int val, struct timespec *utime);
 
+long do_futex(unsigned long, int, int, unsigned long);
+
 #endif
diff --exclude=drivers --exclude=net --exclude=sound -X dontdiff.txt -Naurp linux-2.5.69.orig/init/Kconfig linux-2.5.69/init/Kconfig
--- linux-2.5.69.orig/init/Kconfig	2003-05-04 16:53:37.000000000 -0700
+++ linux-2.5.69/init/Kconfig	2003-05-14 00:03:05.000000000 -0700
@@ -108,8 +108,15 @@ config LOG_BUF_SHIFT
 		     13 =>  8 KB
 		     12 =>  4 KB
 
-endmenu
 
+config FUTEX
+       bool "Futex support"
+       depends on MMU
+       default y
+       ---help---
+       Say Y if you want support for Fast Userspace Mutexes (Futexes).
+
+endmenu
 
 menu "Loadable module support"
 
diff --exclude=drivers --exclude=net --exclude=sound -X dontdiff.txt -Naurp linux-2.5.69.orig/kernel/Makefile linux-2.5.69/kernel/Makefile
--- linux-2.5.69.orig/kernel/Makefile	2003-05-04 16:53:07.000000000 -0700
+++ linux-2.5.69/kernel/Makefile	2003-05-14 00:02:30.000000000 -0700
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
 obj-$(CONFIG_UID16) += uid16.o
diff --exclude=drivers --exclude=net --exclude=sound -X dontdiff.txt -Naurp linux-2.5.69.orig/kernel/compat.c linux-2.5.69/kernel/compat.c
--- linux-2.5.69.orig/kernel/compat.c	2003-05-04 16:53:29.000000000 -0700
+++ linux-2.5.69/kernel/compat.c	2003-05-14 00:17:32.000000000 -0700
@@ -211,8 +211,7 @@ asmlinkage long compat_sys_sigprocmask(i
 	return ret;
 }
 
-extern long do_futex(unsigned long, int, int, unsigned long);
-
+#ifdef CONFIG_FUTEX
 asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
 		struct compat_timespec *utime)
 {
@@ -226,6 +225,7 @@ asmlinkage long compat_sys_futex(u32 *ua
 	}
 	return do_futex((unsigned long)uaddr, op, val, timeout);
 }
+#endif
 
 asmlinkage long sys_setrlimit(unsigned int resource, struct rlimit *rlim);
 
diff --exclude=drivers --exclude=net --exclude=sound -X dontdiff.txt -Naurp linux-2.5.69.orig/kernel/sys.c linux-2.5.69/kernel/sys.c
--- linux-2.5.69.orig/kernel/sys.c	2003-05-04 16:53:02.000000000 -0700
+++ linux-2.5.69/kernel/sys.c	2003-05-14 00:12:07.000000000 -0700
@@ -226,6 +226,8 @@ cond_syscall(sys_shutdown)
 cond_syscall(sys_sendmsg)
 cond_syscall(sys_recvmsg)
 cond_syscall(sys_socketcall)
+cond_syscall(sys_futex)
+cond_syscall(compat_sys_futex)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {


