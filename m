Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbSKTHVR>; Wed, 20 Nov 2002 02:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267638AbSKTHUT>; Wed, 20 Nov 2002 02:20:19 -0500
Received: from dp.samba.org ([66.70.73.150]:57299 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267639AbSKTHTt>;
	Wed, 20 Nov 2002 02:19:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@yggdrasil.com>
Subject: [PATCH] module device table restoration 
Date: Wed, 20 Nov 2002 18:00:19 +1100
Message-Id: <20021120072654.322C02C087@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Adam Richter.  I have a nicer solution based on aliases,
but it requires coordination with USB, PCI and PCMCIA maintainers,
which is taking time.

This restores the old code in the meantime: one week without this is
too long or people who need it.  8(

Please apply unless Adam has objections,
Rusty.

--- linux-2.5.48/include/linux/module.h	2002-11-17 20:29:52.000000000 -0800
+++ linux/include/linux/module.h	2002-11-18 08:05:19.000000000 -0800
@@ -26,8 +26,6 @@
 #define MODULE_AUTHOR(name)
 #define MODULE_DESCRIPTION(desc)
 #define MODULE_SUPPORTED_DEVICE(name)
-#define MODULE_GENERIC_TABLE(gtype,name)
-#define MODULE_DEVICE_TABLE(type,name)
 #define MODULE_PARM_DESC(var,desc)
 #define print_symbol(format, addr)
 #define print_modules()
@@ -40,14 +38,28 @@
 };
 
 #ifdef MODULE
+
+#define MODULE_GENERIC_TABLE(gtype,name)	\
+static const unsigned long __module_##gtype##_size \
+  __attribute__ ((unused)) = sizeof(struct gtype##_id); \
+static const struct gtype##_id * __module_##gtype##_table \
+  __attribute__ ((unused)) = name
+
 /* This is magically filled in by the linker, but THIS_MODULE must be
    a constant so it works in initializers. */
 extern struct module __this_module;
 #define THIS_MODULE (&__this_module)
-#else
+
+#else  /* !MODULE */
+
+#define MODULE_GENERIC_TABLE(gtype,name)
 #define THIS_MODULE ((struct module *)0)
+
 #endif
 
+#define MODULE_DEVICE_TABLE(type,name)		\
+  MODULE_GENERIC_TABLE(type##_device,name)
+
 #ifdef CONFIG_MODULES
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
