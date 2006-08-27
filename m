Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWH0X7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWH0X7S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWH0X7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:59:17 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:10738 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932319AbWH0X7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:59:07 -0400
Message-Id: <20060827215637.781868000@klappe.arndb.de>
References: <20060827214734.252316000@klappe.arndb.de>
Date: Sun, 27 Aug 2006 23:47:41 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
Subject: [PATCH 7/7] remove the global errno from the kernel
Content-Disposition: inline; filename=kernel_execve3.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last in-kernel user of errno is gone, so we should
remove the definition and everything referring to it.
This also removes the now-unused lib/execve.c file
that was introduced earlier.

Also remove a few bogus definitions of __KERNEL_SYSCALLS__
that were already unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/lib/Makefile
===================================================================
--- linux-cg.orig/lib/Makefile	2006-08-27 23:44:35.000000000 +0200
+++ linux-cg/lib/Makefile	2006-08-27 23:44:38.000000000 +0200
@@ -2,7 +2,7 @@
 # Makefile for some libs needed in the kernel.
 #
 
-lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
+lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
 	 sha1.o
Index: linux-cg/lib/execve.c
===================================================================
--- linux-cg.orig/lib/execve.c	2006-08-27 23:44:35.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,23 +0,0 @@
-#include <asm/bug.h>
-#include <asm/uaccess.h>
-
-#define __KERNEL_SYSCALLS__
-static int errno __attribute__((unused));
-#include <asm/unistd.h>
-
-#ifdef _syscall3
-int kernel_execve (const char *filename, char *const argv[], char *const envp[])
-								__attribute__((__weak__));
-int kernel_execve (const char *filename, char *const argv[], char *const envp[])
-{
-	mm_segment_t fs = get_fs();
-	int ret;
-
-	WARN_ON(segment_eq(fs, USER_DS));
-	ret = execve(filename, (char **)argv, (char **)envp);
-	if (ret)
-		ret = -errno;
-
-	return ret;
-}
-#endif
Index: linux-cg/include/linux/unistd.h
===================================================================
--- linux-cg.orig/include/linux/unistd.h	2006-08-27 23:41:34.000000000 +0200
+++ linux-cg/include/linux/unistd.h	2006-08-27 23:44:38.000000000 +0200
@@ -1,12 +1,8 @@
 #ifndef _LINUX_UNISTD_H_
 #define _LINUX_UNISTD_H_
 
-#ifdef __KERNEL__
-extern int errno;
-#endif
-
 /*
- * Include machine specific syscallX macros
+ * Include machine specific syscall numbers
  */
 #include <asm/unistd.h>
 
Index: linux-cg/lib/errno.c
===================================================================
--- linux-cg.orig/lib/errno.c	2006-08-27 23:41:34.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,7 +0,0 @@
-/*
- *  linux/lib/errno.c
- *
- *  Copyright (C) 1991, 1992  Linus Torvalds
- */
-
-int errno;
Index: linux-cg/arch/ia64/kernel/process.c
===================================================================
--- linux-cg.orig/arch/ia64/kernel/process.c	2006-08-27 23:44:53.000000000 +0200
+++ linux-cg/arch/ia64/kernel/process.c	2006-08-27 23:44:54.000000000 +0200
@@ -8,8 +8,6 @@
  * 2005-10-07 Keith Owens <kaos@sgi.com>
  *	      Add notify_die() hooks.
  */
-#define __KERNEL_SYSCALLS__	/* see <asm/unistd.h> */
-
 #include <linux/cpu.h>
 #include <linux/pm.h>
 #include <linux/elf.h>
Index: linux-cg/drivers/media/dvb/dvb-core/dvb_ringbuffer.c
===================================================================
--- linux-cg.orig/drivers/media/dvb/dvb-core/dvb_ringbuffer.c	2006-08-27 23:44:53.000000000 +0200
+++ linux-cg/drivers/media/dvb/dvb-core/dvb_ringbuffer.c	2006-08-27 23:44:54.000000000 +0200
@@ -26,7 +26,6 @@
 
 
 
-#define __KERNEL_SYSCALLS__
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
Index: linux-cg/drivers/net/wireless/ipw2100.c
===================================================================
--- linux-cg.orig/drivers/net/wireless/ipw2100.c	2006-08-27 23:44:53.000000000 +0200
+++ linux-cg/drivers/net/wireless/ipw2100.c	2006-08-27 23:44:54.000000000 +0200
@@ -150,7 +150,6 @@
 #include <linux/skbuff.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
-#define __KERNEL_SYSCALLS__
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>

--

