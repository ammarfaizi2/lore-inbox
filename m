Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbTEQCWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 22:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbTEQCWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 22:22:20 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:36849 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261174AbTEQCWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 22:22:08 -0400
Date: Fri, 16 May 2003 19:36:44 -0700
From: Andrew Morton <akpm@digeo.com>
To: Valdis.Kletnieks@vt.edu
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-Id: <20030516193644.22907083.akpm@digeo.com>
In-Reply-To: <200305170001.h4H0113n001351@turing-police.cc.vt.edu>
References: <Pine.LNX.4.44.0305141758070.28007-100000@home.transmeta.com>
	<1053122141.5589.45.camel@dhcp22.swansea.linux.org.uk>
	<200305170001.h4H0113n001351@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 May 2003 02:34:55.0609 (UTC) FILETIME=[E6F69E90:01C31C1C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> > 	Remove kernel features for embedded systems (Y/N)
>  > 
>  > its no more dangerous/hassle than the kernel debug menu
> 
>  OK.. I know I argued against making it visible to the user at all, but if it's
>  phrased like that, it will at least (hopefully) dissuade everybody who
>  doesn't know what an embedded system is.
> 
>  And after all, Linux isn't about dissuading the truly determined, nor is it
>  about making moral judgements regarding their wizardry/idiocy ratio....

I'd agree with all that.  I've updated the initial patch thusly:

General setup --->
    [*] Remove kernel features for embedded systems
          Removable kernel features for embedded systems  --->
              [ ] Enable futex support

So enabling CONFIG_EMBEDDED causes the user to be offered CONFIG_FUTEX, and
there are appropriate stern warnings everywhere.


 init/Kconfig          |   24 +++++++++++++++++++++++-
 kernel/Makefile       |    3 ++-
 kernel/compat.c       |    5 +++--
 kernel/sys.c          |    2 ++
 5 files changed, 32 insertions(+), 4 deletions(-)

diff -puN init/Kconfig~CONFIG_FUTEX init/Kconfig
--- 25/init/Kconfig~CONFIG_FUTEX	2003-05-16 19:17:34.000000000 -0700
+++ 25-akpm/init/Kconfig	2003-05-16 19:32:43.000000000 -0700
@@ -108,8 +108,31 @@ config LOG_BUF_SHIFT
 		     13 =>  8 KB
 		     12 =>  4 KB
 
+
+config EMBEDDED
+	bool "Remove kernel features for embedded systems"
+	default n
+	help
+	  This option allows certain base kernel features to be removed from
+	  the build.  This is for specialized environments which can tolerate
+	  a "non-standard" kernel.  Only use this if you really know what you
+	  are doing.
+
+menu "Removable kernel features for embedded systems"
+	depends on EMBEDDED
+
+config FUTEX
+	bool "Enable futex support"
+	depends on EMBEDDED
+	default y
+	help
+	  Disabling this option will cause the kernel to be built without
+	  support for "fast userspace mutexes".  The resulting kernel may not
+	  run glibc-based applications correctly.
+
 endmenu
 
+endmenu
 
 menu "Loadable module support"
 
@@ -181,4 +204,3 @@ config KMOD
 	  in <file:Documentation/kmod.txt>.
 
 endmenu
-
diff -puN kernel/Makefile~CONFIG_FUTEX kernel/Makefile
--- 25/kernel/Makefile~CONFIG_FUTEX	2003-05-16 19:17:34.000000000 -0700
+++ 25-akpm/kernel/Makefile	2003-05-16 19:17:34.000000000 -0700
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
--- 25/kernel/sys.c~CONFIG_FUTEX	2003-05-16 19:17:34.000000000 -0700
+++ 25-akpm/kernel/sys.c	2003-05-16 19:17:34.000000000 -0700
@@ -228,6 +228,8 @@ cond_syscall(sys_shutdown)
 cond_syscall(sys_sendmsg)
 cond_syscall(sys_recvmsg)
 cond_syscall(sys_socketcall)
+cond_syscall(sys_futex)
+cond_syscall(compat_sys_futex)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
diff -puN kernel/compat.c~CONFIG_FUTEX kernel/compat.c
--- 25/kernel/compat.c~CONFIG_FUTEX	2003-05-16 19:17:34.000000000 -0700
+++ 25-akpm/kernel/compat.c	2003-05-16 19:17:34.000000000 -0700
@@ -18,6 +18,7 @@
 #include <linux/signal.h>
 #include <linux/sched.h>	/* for MAX_SCHEDULE_TIMEOUT */
 #include <linux/futex.h>	/* for FUTEX_WAIT */
+#include <linux/unistd.h>
 
 #include <asm/uaccess.h>
 
@@ -211,8 +212,7 @@ asmlinkage long compat_sys_sigprocmask(i
 	return ret;
 }
 
-extern long do_futex(unsigned long, int, int, unsigned long);
-
+#ifdef CONFIG_FUTEX
 asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
 		struct compat_timespec *utime)
 {
@@ -226,6 +226,7 @@ asmlinkage long compat_sys_futex(u32 *ua
 	}
 	return do_futex((unsigned long)uaddr, op, val, timeout);
 }
+#endif
 
 asmlinkage long sys_setrlimit(unsigned int resource, struct rlimit *rlim);
 
diff -puN include/linux/futex.h~CONFIG_FUTEX include/linux/futex.h
--- 25/include/linux/futex.h~CONFIG_FUTEX	2003-05-16 19:17:34.000000000 -0700
+++ 25-akpm/include/linux/futex.h	2003-05-16 19:17:34.000000000 -0700
@@ -8,4 +8,6 @@
 
 extern asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime);
 
+long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout);
+
 #endif

_

