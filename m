Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWH1AB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWH1AB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 20:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWH1AB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 20:01:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:62922 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932327AbWH0X7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:59:14 -0400
Message-Id: <200608280001.01653.arnd@arndb.de>
References: <20060827214734.252316000@klappe.arndb.de>
Date: Mon, 28 Aug 2006 00:01:00 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
Subject: [PATCH 1/7] introduce kernel_execve
Content-Disposition: inline
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The use of execve() in the kernel is dubious, since it relies
on the __KERNEL_SYSCALLS__ mechanism that stores the result in
a global errno variable. As a first step of getting rid of
this, change all users to a global kernel_execve function that
returns a proper error code.

This function is a terrible hack, and a later patch removes
it again after the kernel syscalls are gone.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/init/do_mounts_initrd.c
===================================================================
--- linux-cg.orig/init/do_mounts_initrd.c	2006-08-27 23:17:58.000000000 +0200
+++ linux-cg/init/do_mounts_initrd.c	2006-08-27 23:18:58.000000000 +0200
@@ -1,4 +1,3 @@
-#define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
@@ -35,7 +34,7 @@
 	(void) sys_open("/dev/console",O_RDWR,0);
 	(void) sys_dup(0);
 	(void) sys_dup(0);
-	return execve(shell, argv, envp_init);
+	return kernel_execve(shell, argv, envp_init);
 }
 
 static void __init handle_initrd(void)
Index: linux-cg/kernel/kmod.c
===================================================================
--- linux-cg.orig/kernel/kmod.c	2006-08-27 23:17:58.000000000 +0200
+++ linux-cg/kernel/kmod.c	2006-08-27 23:18:58.000000000 +0200
@@ -18,8 +18,6 @@
 	call_usermodehelper wait flag, and remove exec_usermodehelper.
 	Rusty Russell <rusty@rustcorp.com.au>  Jan 2003
 */
-#define __KERNEL_SYSCALLS__
-
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/syscalls.h>
@@ -150,7 +148,8 @@
 
 	retval = -EPERM;
 	if (current->fs->root)
-		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
+		retval = kernel_execve(sub_info->path,
+				sub_info->argv, sub_info->envp);
 
 	/* Exec failed? */
 	sub_info->retval = retval;
Index: linux-cg/lib/Makefile
===================================================================
--- linux-cg.orig/lib/Makefile	2006-08-27 23:17:58.000000000 +0200
+++ linux-cg/lib/Makefile	2006-08-27 23:18:58.000000000 +0200
@@ -33,6 +33,8 @@
   lib-y += dec_and_lock.o
 endif
 
+lib-y += execve.o
+
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC32)	+= crc32.o
Index: linux-cg/lib/execve.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cg/lib/execve.c	2006-08-27 23:18:58.000000000 +0200
@@ -0,0 +1,23 @@
+#include <asm/bug.h>
+#include <asm/uaccess.h>
+
+#define __KERNEL_SYSCALLS__
+static int errno __attribute__((unused));
+#include <asm/unistd.h>
+
+#ifdef _syscall3
+int kernel_execve (const char *filename, char *const argv[], char *const envp[])
+								__attribute__((__weak__));
+int kernel_execve (const char *filename, char *const argv[], char *const envp[])
+{
+	mm_segment_t fs = get_fs();
+	int ret;
+
+	WARN_ON(segment_eq(fs, USER_DS));
+	ret = execve(filename, (char **)argv, (char **)envp);
+	if (ret)
+		ret = -errno;
+
+	return ret;
+}
+#endif
Index: linux-cg/init/main.c
===================================================================
--- linux-cg.orig/init/main.c	2006-08-27 23:17:58.000000000 +0200
+++ linux-cg/init/main.c	2006-08-27 23:18:58.000000000 +0200
@@ -9,8 +9,6 @@
  *  Simplified starting of init:  Michael A. Griffith <grif@acm.org> 
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
@@ -679,7 +677,7 @@
 static void run_init_process(char *init_filename)
 {
 	argv_init[0] = init_filename;
-	execve(init_filename, argv_init, envp_init);
+	kernel_execve(init_filename, argv_init, envp_init);
 }
 
 static int init(void * unused)
Index: linux-cg/arch/sparc64/kernel/power.c
===================================================================
--- linux-cg.orig/arch/sparc64/kernel/power.c	2006-08-27 23:18:53.000000000 +0200
+++ linux-cg/arch/sparc64/kernel/power.c	2006-08-27 23:19:04.000000000 +0200
@@ -4,8 +4,6 @@
  * Copyright (C) 1999 David S. Miller (davem@redhat.com)
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -14,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/pm.h>
+#include <linux/syscalls.h>
 
 #include <asm/system.h>
 #include <asm/auxio.h>
@@ -98,7 +97,7 @@
 
 	/* Ok, down we go... */
 	button_pressed = 0;
-	if (execve("/sbin/shutdown", argv, envp) < 0) {
+	if (kernel_execve("/sbin/shutdown", argv, envp) < 0) {
 		printk("powerd: shutdown execution failed\n");
 		add_wait_queue(&powerd_wait, &wait);
 		goto again;

--

