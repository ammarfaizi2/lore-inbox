Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRBTK6S>; Tue, 20 Feb 2001 05:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129650AbRBTK56>; Tue, 20 Feb 2001 05:57:58 -0500
Received: from smtp010.mail.yahoo.com ([216.136.173.30]:4370 "HELO
	smtp010.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129631AbRBTK5u>; Tue, 20 Feb 2001 05:57:50 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A924B83.43133ED2@yahoo.com>
Date: Tue, 20 Feb 2001 05:48:35 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Better BUG() macro - take 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, it appears that some people want the __FILE__, __LINE__ (or equivalent)
in BUG() and some don't.  Fair enough.  I used the existing config option
CONFIG_DEBUG_ERRORS to allow people to choose.  There was also interest
in having BUG() in a more sensible place (e.g. <linux/kernel.h>) and the
arch specific part separate (I picked <asm-xxx/system.h>).

This only deals with i386 - wanted to put this out for comment before
editing for the others.  Change for other arch is simple though - just
remove BUG() from asm/page.h and put the *(int *)0=0; type part of what
was BUG() into asm/system.h as machine_bug(). Oh, and add the config
option to arch/*/config.in if it isn't already in use.

Feedback welcome (& thanks to those who already have done so)

Paul.

--- init/main.c~	Tue Feb 20 00:58:55 2001
+++ init/main.c	Tue Feb 20 02:45:55 2001
@@ -130,6 +130,9 @@
 char *execute_command;
 char root_device_name[64];
 
+#ifdef CONFIG_DEBUG_ERRORS
+const char *kernel_bug = "kernel BUG at %s: line %d!\n";
+#endif
 
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 static char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
--- include/asm-i386/page.h~	Sat Dec 16 04:02:20 2000
+++ include/asm-i386/page.h	Tue Feb 20 02:11:50 2001
@@ -82,15 +82,6 @@
 
 #ifndef __ASSEMBLY__
 
-/*
- * Tell the user there is some problem. Beep too, so we can
- * see^H^H^Hhear bugs in early bootup as well!
- */
-#define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	__asm__ __volatile__(".byte 0x0f,0x0b"); \
-} while (0)
-
 #define PAGE_BUG(page) do { \
 	BUG(); \
 } while (0)
--- arch/i386/config.in~	Tue Feb 20 00:04:13 2001
+++ arch/i386/config.in	Tue Feb 20 05:03:58 2001
@@ -366,4 +366,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Verbose kernel error messages' CONFIG_DEBUG_ERRORS
 endmenu
--- kernel/ksyms.c~	Wed Feb 14 02:42:16 2001
+++ kernel/ksyms.c	Tue Feb 20 03:06:04 2001
@@ -463,6 +463,7 @@
 EXPORT_SYMBOL(securebits);
 EXPORT_SYMBOL(cap_bset);
 EXPORT_SYMBOL(daemonize);
+EXPORT_SYMBOL(kernel_bug);
 
 /* Program loader interfaces */
 EXPORT_SYMBOL(setup_arg_pages);
--- include/asm-i386/system.h~	Tue Feb 20 00:02:07 2001
+++ include/asm-i386/system.h	Tue Feb 20 05:08:41 2001
@@ -112,6 +112,8 @@
 	__asm__("movl %0,%%cr0": :"r" (x));
 #define stts() write_cr0(8 | read_cr0())
 
+#define machine_bug() __asm__ __volatile__(".byte 0x0f,0x0b")
+ 
 #endif	/* __KERNEL__ */
 
 static inline unsigned long get_limit(unsigned long segment)
--- include/linux/mount.h~	Mon Nov 20 04:14:06 2000
+++ include/linux/mount.h	Tue Feb 20 04:54:09 2001
@@ -12,6 +12,8 @@
 #define _LINUX_MOUNT_H
 #ifdef __KERNEL__
 
+#include <asm/system.h>
+
 #define MNT_VISIBLE	1
 
 struct vfsmount
--- include/linux/kernel.h~	Sat Dec 16 04:02:31 2000
+++ include/linux/kernel.h	Tue Feb 20 05:19:04 2001
@@ -9,6 +9,7 @@
 
 #include <stdarg.h>
 #include <linux/linkage.h>
+#include <linux/config.h>
 #include <linux/stddef.h>
 
 /* Optimization barrier */
@@ -83,6 +84,22 @@
 	if (console_loglevel)
 		console_loglevel = 15;
 }
+
+/*
+ * Multiple copies of the printk text, plus long pathnames from
+ *  __FILE__ used to waste around 100k of memory!	Paul G.
+ */
+#ifdef CONFIG_DEBUG_ERRORS
+extern const char *kernel_bug;
+#define SOURCE_LOCATION() printk(kernel_bug, __FILE__, __LINE__)
+#else
+#define SOURCE_LOCATION()
+#endif
+
+#define BUG() do {              \
+	SOURCE_LOCATION();      \
+	machine_bug();          \
+} while (0)
 
 #if DEBUG
 #define pr_debug(fmt,arg...) \



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

