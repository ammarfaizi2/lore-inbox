Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVKKIhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVKKIhe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVKKIgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:36:41 -0500
Received: from i121.durables.org ([64.81.244.121]:11470 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932238AbVKKIgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:22 -0500
Date: Fri, 11 Nov 2005 02:35:55 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <12.282480653@selenic.com>
Message-Id: <13.282480653@selenic.com>
Subject: [PATCH 12/15] misc: Configurable panic support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Configurable no-op of panic()

Similar to disabling printk and BUG_ON, this allows completely
removing the panic infrastructure for systems where it isn't useful.

   text    data     bss     dec     hex
3330172  529036  190556 4049764  3dcb64 baseline
3324560  529016  189532 4043108  3db164 no-panic

Index: 2.6.14-misc/init/Kconfig
===================================================================
--- 2.6.14-misc.orig/init/Kconfig	2005-11-09 16:48:24.000000000 -0800
+++ 2.6.14-misc/init/Kconfig	2005-11-09 16:50:44.000000000 -0800
@@ -324,7 +324,16 @@ config DOUBLEFAULT
           would otherwise cause a system to silently reboot. Disabling this
           option saves about 4k.
 
+config PANIC
+	default y
+	bool "Enable panic reporting code" if EMBEDDED
+	help
+	  Disabling this completely removes panic handling code.
+          Warning: this can result in data loss if a panic condition
+          occurs, as the kernel may ignore the condition entirely.
+
 config FULL_PANIC
+        depends PANIC
 	default y
 	bool "Full panic reporting data" if EMBEDDED
 	help
Index: 2.6.14-misc/init/main.c
===================================================================
--- 2.6.14-misc.orig/init/main.c	2005-11-09 16:48:24.000000000 -0800
+++ 2.6.14-misc/init/main.c	2005-11-09 16:50:44.000000000 -0800
@@ -742,4 +742,5 @@ static int init(void * unused)
 	run_init_process("/bin/sh");
 
 	panic("No init found.  Try passing init= option to kernel.");
+	return 0;
 }
Index: 2.6.14-misc/kernel/panic.c
===================================================================
--- 2.6.14-misc.orig/kernel/panic.c	2005-11-09 16:50:29.000000000 -0800
+++ 2.6.14-misc/kernel/panic.c	2005-11-09 16:50:55.000000000 -0800
@@ -37,15 +37,16 @@ static int __init panic_setup(char *str)
 }
 __setup("panic=", panic_setup);
 
+/* Returns how long it waited in ms */
+long (*panic_blink)(long time);
+EXPORT_SYMBOL(panic_blink);
+
+#ifdef CONFIG_PANIC
 static long no_blink(long time)
 {
 	return 0;
 }
 
-/* Returns how long it waited in ms */
-long (*panic_blink)(long time);
-EXPORT_SYMBOL(panic_blink);
-
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -157,6 +158,7 @@ EXPORT_SYMBOL(panic);
 #else
 EXPORT_SYMBOL(tiny_panic);
 #endif
+#endif
 
 /**
  *	print_tainted - return a string to represent the kernel taint state.
Index: 2.6.14-misc/include/linux/kernel.h
===================================================================
--- 2.6.14-misc.orig/include/linux/kernel.h	2005-11-09 16:48:24.000000000 -0800
+++ 2.6.14-misc/include/linux/kernel.h	2005-11-09 16:50:44.000000000 -0800
@@ -87,6 +87,11 @@ extern int cond_resched(void);
 
 extern struct notifier_block *panic_notifier_list;
 extern long (*panic_blink)(long time);
+#ifndef CONFIG_PANIC
+NORET_TYPE static inline void panic(const char * fmt, ...)
+	__attribute__ ((NORET_AND format (printf, 1, 2)));
+NORET_TYPE static inline void panic(const char * fmt, ...) {}
+#else
 #ifdef CONFIG_FULL_PANIC
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
@@ -94,6 +99,7 @@ NORET_TYPE void panic(const char * fmt, 
 #define panic(fmt, ...) tiny_panic(0, ## __VA_ARGS__)
 NORET_TYPE void tiny_panic(int a, ...) ATTRIB_NORET;
 #endif
+#endif
 fastcall NORET_TYPE void do_exit(long error_code)
 	ATTRIB_NORET;
 NORET_TYPE void complete_and_exit(struct completion *, long)
