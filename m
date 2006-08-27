Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWH0X7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWH0X7z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWH0X71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:59:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:51184 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932312AbWH0X6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:58:50 -0400
Message-Id: <200608280000.50961.arnd@arndb.de>
References: <20060827214734.252316000@klappe.arndb.de>
Date: Mon, 28 Aug 2006 00:00:49 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au, linuxsh-shmedia-dev@lists.sourceforge.net,
       lethal@linux-sh.org, rc@rc0.org.uk
Subject: [PATCH 5/7] sh64: remove the use of kernel syscalls
Content-Disposition: inline
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sh64 is using system call macros to call some functions
from the kernel. Remove those so we can get rid of
kernel syscalls.

This is probably not the best implementation and may
need to be redone.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/arch/sh64/kernel/process.c
===================================================================
--- linux-cg.orig/arch/sh64/kernel/process.c	2006-08-27 23:36:34.000000000 +0200
+++ linux-cg/arch/sh64/kernel/process.c	2006-08-27 23:40:13.000000000 +0200
@@ -32,7 +32,6 @@
 #undef IDLE_TRACE
 /* Temporary flags/tests. All to be removed/undefined. END */
 
-#define __KERNEL_SYSCALLS__
 #include <stdarg.h>
 
 #include <linux/kernel.h>
@@ -230,13 +229,10 @@
 void idle_trace(void)
 {
 
-	_syscall0(int, getpid)
-	_syscall1(int, getpgid, int, pid)
-
 	if (!once) {
         	/* VM allocation/deallocation simple test */
 		test_VM();
-		pid = getpid();
+		pid = sys_getpid();
 
         	printk("Got all through to Idle !!\n");
         	printk("I'm now going to loop forever ...\n");
@@ -268,7 +264,7 @@
 		}
 		old_jiffies = jiffies;
 	}
-	pgid = getpgid(pid);
+	pgid = sys_getpgid(pid);
 	printk(".");
 }
 #else
@@ -628,18 +624,23 @@
  * a system call from a "real" process, but the process memory space will
  * not be free'd until both the parent and the child have exited.
  */
+#error please implement a working kernel_thread function like the other architectures
+/* _syscallN() does not work any more. this probably needs to call
+ * do_fork directly */
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-	/* A bit less processor dependent than older sh ... */
-	unsigned int reply;
-
-static __inline__ _syscall2(int,clone,unsigned long,flags,unsigned long,newsp)
-static __inline__ _syscall1(int,exit,int,ret)
+	register unsigned long reply asm ("r9") = ((0x13 << 16) | __NR_clone);
+	register unsigned long __flags asm ("r2") = flags | CLONE_VM;
+	register unsigned long __newsp asm ("r3") = 0;
+
+	__asm__ __volatile__ ("trapa	%1 !\t\t\t clone(%2,%3)"
+	: "=r" (__sc0) : "r" (__sc0), "r" (__sc2), "r" (__sc3));
+	__asm__ __volatile__ ("!dummy	%0 %1"
+	: : "r" (__sc0), "r" (__sc2), "r" (__sc3) : "memory");
 
-	reply = clone(flags | CLONE_VM, 0);
 	if (!reply) {
 		/* Child */
-		reply = exit(fn(arg));
+		reply = sys_exit(fn(arg));
 	}
 
 	return reply;

--

