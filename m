Return-Path: <linux-kernel-owner+willy=40w.ods.org-S281911AbUKBEFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S281911AbUKBEFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S519175AbUKBEFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 23:05:07 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:42948 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S270217AbUKBECE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 23:02:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16775.1694.677128.411401@wombat.chubb.wattle.id.au>
Date: Tue, 2 Nov 2004 15:01:34 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IA64 build broken... cond_syscall()... Fixes?
In-Reply-To: <20041101201808.58a559a5.akpm@osdl.org>
References: <200411020239.iA22dsQl026520@mail23.syd.optusnet.com.au>
	<20041101201808.58a559a5.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Peter Chubb <peterc@gelato.unsw.edu.au> wrote:

>> Most architectures use inline assembly language which avoids the
>> problem.  However, we don't want to do this for IA64, to allow
>> compilers other than gcc to be used (in general, gcc generated code
>> for IA64 is extremely poor).
>> 
>> There are several ways to fix this.  The simple way is to ensure
>> that there are no prototypes for any system calls included in
>> kernel/sys.c (the only place where cond_syscall is used).  That's
>> what this patch does:

Andrew> But I bet it introduces various nasty warnings or
Andrew> type-unsafety on other architectures.

The main issue would be the other system calls defined in sys.c, that
don't have a prototype in scope.  There were no warnings on the
architectures I test compiled on (i386, ARM, IA64).

Andrew> Shouldn't we just bite the bullet and hoist all that
Andrew> cond_syscall stuff out into its own .c file?

OK.  Patch appended.

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>


diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.6/kernel/Makefile linux-2.5-import/kernel/Makefile
--- linux-2.6/kernel/Makefile	2004-11-02 14:52:36 +11:00
+++ linux-2.5-import/kernel/Makefile	2004-11-02 14:34:46 +11:00
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o
+	    kthread.o wait.o kfifo.o sys_ni.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.6/kernel/sys.c linux-2.5-import/kernel/sys.c
--- linux-2.6/kernel/sys.c	2004-11-02 14:52:36 +11:00
+++ linux-2.5-import/kernel/sys.c	2004-11-02 14:34:51 +11:00
@@ -5,7 +5,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/utsname.h>
@@ -25,10 +24,8 @@
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
 
-/* Don't include this - it breaks ia64's cond_syscall() implementation */
-#if 0
+#include <linux/compat.h>
 #include <linux/syscalls.h>
-#endif
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -218,82 +215,6 @@
 }
 
 EXPORT_SYMBOL(unregister_reboot_notifier);
-
-asmlinkage long sys_ni_syscall(void)
-{
-	return -ENOSYS;
-}
-
-cond_syscall(sys_nfsservctl)
-cond_syscall(sys_quotactl)
-cond_syscall(sys_acct)
-cond_syscall(sys_lookup_dcookie)
-cond_syscall(sys_swapon)
-cond_syscall(sys_swapoff)
-cond_syscall(sys_init_module)
-cond_syscall(sys_delete_module)
-cond_syscall(sys_socketpair)
-cond_syscall(sys_bind)
-cond_syscall(sys_listen)
-cond_syscall(sys_accept)
-cond_syscall(sys_connect)
-cond_syscall(sys_getsockname)
-cond_syscall(sys_getpeername)
-cond_syscall(sys_sendto)
-cond_syscall(sys_send)
-cond_syscall(sys_recvfrom)
-cond_syscall(sys_recv)
-cond_syscall(sys_socket)
-cond_syscall(sys_setsockopt)
-cond_syscall(sys_getsockopt)
-cond_syscall(sys_shutdown)
-cond_syscall(sys_sendmsg)
-cond_syscall(sys_recvmsg)
-cond_syscall(sys_socketcall)
-cond_syscall(sys_futex)
-cond_syscall(compat_sys_futex)
-cond_syscall(sys_epoll_create)
-cond_syscall(sys_epoll_ctl)
-cond_syscall(sys_epoll_wait)
-cond_syscall(sys_semget)
-cond_syscall(sys_semop)
-cond_syscall(sys_semtimedop)
-cond_syscall(sys_semctl)
-cond_syscall(sys_msgget)
-cond_syscall(sys_msgsnd)
-cond_syscall(sys_msgrcv)
-cond_syscall(sys_msgctl)
-cond_syscall(sys_shmget)
-cond_syscall(sys_shmdt)
-cond_syscall(sys_shmctl)
-cond_syscall(sys_mq_open)
-cond_syscall(sys_mq_unlink)
-cond_syscall(sys_mq_timedsend)
-cond_syscall(sys_mq_timedreceive)
-cond_syscall(sys_mq_notify)
-cond_syscall(sys_mq_getsetattr)
-cond_syscall(compat_sys_mq_open)
-cond_syscall(compat_sys_mq_timedsend)
-cond_syscall(compat_sys_mq_timedreceive)
-cond_syscall(compat_sys_mq_notify)
-cond_syscall(compat_sys_mq_getsetattr)
-cond_syscall(sys_mbind)
-cond_syscall(sys_get_mempolicy)
-cond_syscall(sys_set_mempolicy)
-cond_syscall(compat_mbind)
-cond_syscall(compat_get_mempolicy)
-cond_syscall(compat_set_mempolicy)
-cond_syscall(sys_add_key)
-cond_syscall(sys_request_key)
-cond_syscall(sys_keyctl)
-cond_syscall(compat_sys_keyctl)
-cond_syscall(compat_sys_socketcall)
-
-/* arch-specific weak syscall entries */
-cond_syscall(sys_pciconfig_read)
-cond_syscall(sys_pciconfig_write)
-cond_syscall(sys_pciconfig_iobase)
-
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
 	int no_nice;
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.6/kernel/sys_ni.c linux-2.5-import/kernel/sys_ni.c
--- linux-2.6/kernel/sys_ni.c	1970-01-01 10:00:00 +10:00
+++ linux-2.5-import/kernel/sys_ni.c	2004-11-02 14:48:55 +11:00
@@ -0,0 +1,81 @@
+#include <asm/unistd.h>
+#include <linux/errno.h>
+
+/*
+ * Non-implemented system calls get redirected here.
+ */
+asmlinkage long sys_ni_syscall(void)
+{
+	return -ENOSYS;
+}
+
+cond_syscall(sys_nfsservctl)
+cond_syscall(sys_quotactl)
+cond_syscall(sys_acct)
+cond_syscall(sys_lookup_dcookie)
+cond_syscall(sys_swapon)
+cond_syscall(sys_swapoff)
+cond_syscall(sys_init_module)
+cond_syscall(sys_delete_module)
+cond_syscall(sys_socketpair)
+cond_syscall(sys_bind)
+cond_syscall(sys_listen)
+cond_syscall(sys_accept)
+cond_syscall(sys_connect)
+cond_syscall(sys_getsockname)
+cond_syscall(sys_getpeername)
+cond_syscall(sys_sendto)
+cond_syscall(sys_send)
+cond_syscall(sys_recvfrom)
+cond_syscall(sys_recv)
+cond_syscall(sys_socket)
+cond_syscall(sys_setsockopt)
+cond_syscall(sys_getsockopt)
+cond_syscall(sys_shutdown)
+cond_syscall(sys_sendmsg)
+cond_syscall(sys_recvmsg)
+cond_syscall(sys_socketcall)
+cond_syscall(sys_futex)
+cond_syscall(compat_sys_futex)
+cond_syscall(sys_epoll_create)
+cond_syscall(sys_epoll_ctl)
+cond_syscall(sys_epoll_wait)
+cond_syscall(sys_semget)
+cond_syscall(sys_semop)
+cond_syscall(sys_semtimedop)
+cond_syscall(sys_semctl)
+cond_syscall(sys_msgget)
+cond_syscall(sys_msgsnd)
+cond_syscall(sys_msgrcv)
+cond_syscall(sys_msgctl)
+cond_syscall(sys_shmget)
+cond_syscall(sys_shmdt)
+cond_syscall(sys_shmctl)
+cond_syscall(sys_mq_open)
+cond_syscall(sys_mq_unlink)
+cond_syscall(sys_mq_timedsend)
+cond_syscall(sys_mq_timedreceive)
+cond_syscall(sys_mq_notify)
+cond_syscall(sys_mq_getsetattr)
+cond_syscall(compat_sys_mq_open)
+cond_syscall(compat_sys_mq_timedsend)
+cond_syscall(compat_sys_mq_timedreceive)
+cond_syscall(compat_sys_mq_notify)
+cond_syscall(compat_sys_mq_getsetattr)
+cond_syscall(sys_mbind)
+cond_syscall(sys_get_mempolicy)
+cond_syscall(sys_set_mempolicy)
+cond_syscall(compat_mbind)
+cond_syscall(compat_get_mempolicy)
+cond_syscall(compat_set_mempolicy)
+cond_syscall(sys_add_key)
+cond_syscall(sys_request_key)
+cond_syscall(sys_keyctl)
+cond_syscall(compat_sys_keyctl)
+cond_syscall(compat_sys_socketcall)
+
+/* arch-specific weak syscall entries */
+cond_syscall(sys_pciconfig_read)
+cond_syscall(sys_pciconfig_write)
+cond_syscall(sys_pciconfig_iobase)
+


-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
