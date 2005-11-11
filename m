Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVKKIj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVKKIj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVKKIjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:39:23 -0500
Received: from i121.durables.org ([64.81.244.121]:10446 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932246AbVKKIgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:08 -0500
Date: Fri, 11 Nov 2005 02:35:54 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <11.282480653@selenic.com>
Message-Id: <12.282480653@selenic.com>
Subject: [PATCH 11/15] misc: Allow dropping panic text strings from kernel image
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Configurable support for panic strings

This drops panic message strings from the kernel image while
maintaining normal panic functionality.

$ size vmlinux vmlinux-baseline
   text    data     bss     dec     hex filename
3330172  529036  190556 4049764  3dcb64 vmlinux-baseline
3326488  529036  189532 4045056  3db900 vmlinux

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-misc/include/linux/kernel.h
===================================================================
--- 2.6.14-misc.orig/include/linux/kernel.h	2005-11-09 11:27:15.000000000 -0800
+++ 2.6.14-misc/include/linux/kernel.h	2005-11-10 23:26:41.000000000 -0800
@@ -87,8 +87,13 @@ extern int cond_resched(void);
 
 extern struct notifier_block *panic_notifier_list;
 extern long (*panic_blink)(long time);
+#ifdef CONFIG_FULL_PANIC
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
+#else
+#define panic(fmt, ...) tiny_panic(0, ## __VA_ARGS__)
+NORET_TYPE void tiny_panic(int a, ...) ATTRIB_NORET;
+#endif
 fastcall NORET_TYPE void do_exit(long error_code)
 	ATTRIB_NORET;
 NORET_TYPE void complete_and_exit(struct completion *, long)
Index: 2.6.14-misc/init/Kconfig
===================================================================
--- 2.6.14-misc.orig/init/Kconfig	2005-11-09 11:27:15.000000000 -0800
+++ 2.6.14-misc/init/Kconfig	2005-11-10 23:26:41.000000000 -0800
@@ -324,6 +324,14 @@ config DOUBLEFAULT
           would otherwise cause a system to silently reboot. Disabling this
           option saves about 4k.
 
+config FULL_PANIC
+	default y
+	bool "Full panic reporting data" if EMBEDDED
+	help
+	  This includes text descriptions of panics in addition to stack dumps.
+          Disabling compiles out the explanations for panics, saving
+	  string space. Use with caution.
+
 config BASE_FULL
 	default y
 	bool "Enable full-sized data structures for core" if EMBEDDED
Index: 2.6.14-misc/kernel/panic.c
===================================================================
--- 2.6.14-misc.orig/kernel/panic.c	2005-11-09 11:27:15.000000000 -0800
+++ 2.6.14-misc/kernel/panic.c	2005-11-10 23:26:41.000000000 -0800
@@ -54,12 +54,18 @@ EXPORT_SYMBOL(panic_blink);
  *
  *	This function never returns.
  */
- 
+
+#ifdef CONFIG_FULL_PANIC
 NORET_TYPE void panic(const char * fmt, ...)
 {
-	long i;
 	static char buf[1024];
 	va_list args;
+#else
+NORET_TYPE void tiny_panic(int a, ...)
+{
+#endif
+	long i;
+
 #if defined(CONFIG_ARCH_S390)
         unsigned long caller = (unsigned long) __builtin_return_address(0);
 #endif
@@ -72,10 +78,16 @@ NORET_TYPE void panic(const char * fmt, 
 	preempt_disable();
 
 	bust_spinlocks(1);
+
+#ifdef CONFIG_FULL_PANIC
 	va_start(args, fmt);
 	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 	printk(KERN_EMERG "Kernel panic - not syncing: %s\n",buf);
+#else
+	printk(KERN_EMERG "Kernel panic - not syncing\n");
+#endif
+
 	bust_spinlocks(0);
 
 	/*
@@ -94,7 +106,11 @@ NORET_TYPE void panic(const char * fmt, 
 	smp_send_stop();
 #endif
 
+#ifdef CONFIG_FULL_PANIC
 	notifier_call_chain(&panic_notifier_list, 0, buf);
+#else
+	notifier_call_chain(&panic_notifier_list, 0, "");
+#endif
 
 	if (!panic_blink)
 		panic_blink = no_blink;
@@ -136,7 +152,11 @@ NORET_TYPE void panic(const char * fmt, 
 	}
 }
 
+#ifdef CONFIG_FULL_PANIC
 EXPORT_SYMBOL(panic);
+#else
+EXPORT_SYMBOL(tiny_panic);
+#endif
 
 /**
  *	print_tainted - return a string to represent the kernel taint state.
