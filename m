Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVDEX3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVDEX3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 19:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDEX3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 19:29:30 -0400
Received: from ns3.dataphone.se ([212.37.0.170]:41447 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261968AbVDEX3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 19:29:21 -0400
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050405225747.15125.8087.59570@clementine.local>
Subject: [PATCH][RFC] disable built-in modules V2
Date: Wed,  6 Apr 2005 01:29:19 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here comes version 2 of the disable built-in patch.

This patch makes it possible to disable built-in code from the kernel
command line. The patch is rather simple - it extends the compiled-in case 
of module_init() to include __setup() with a name based on KBUILD_MODNAME.

As an example, if you want to disable built-in firewire support then you
could pass "force_ohci1394=off" on the kernel command line. The feature added
by this patch comes handy when you want to boot a precompiled kernel from a 
live cd on som exotic hardware that makes built-in drivers crash.

Changes since last release:
- Upgraded and tested with 2.6.12-rc2
- Added "force_"-prefix to cope with namespace pollution

Signed-off-by: Magnus Damm <damm@opensource.se>

diff -urNp linux-2.6.12-rc2/include/linux/init.h linux-2.6.12-rc2-disable_builtin/include/linux/init.h
--- linux-2.6.12-rc2/include/linux/init.h	2005-04-05 16:57:29.000000000 +0200
+++ linux-2.6.12-rc2-disable_builtin/include/linux/init.h	2005-04-06 00:26:07.000000000 +0200
@@ -143,6 +143,16 @@ struct obs_kernel_param {
 
 /* Relies on saved_command_line being set */
 void __init parse_early_param(void);
+
+void __init disable_initcall(void *fn);
+#define __module_init_disable(x)				\
+static int __init x##_disable_module(char *str)			\
+{								\
+	disable_initcall(x);					\
+	return 1;						\
+}								\
+__setup("force_" __stringify(KBUILD_MODNAME) "=off", x##_disable_module)
+
 #endif /* __ASSEMBLY__ */
 
 /**
@@ -153,7 +163,7 @@ void __init parse_early_param(void);
  * builtin) or at module insertion time (if a module).  There can only
  * be one per module.
  */
-#define module_init(x)	__initcall(x);
+#define module_init(x)	__initcall(x); __module_init_disable(x);  
 
 /**
  * module_exit() - driver exit entry point
diff -urNp linux-2.6.12-rc2/init/main.c linux-2.6.12-rc2-disable_builtin/init/main.c
--- linux-2.6.12-rc2/init/main.c	2005-04-05 16:59:55.000000000 +0200
+++ linux-2.6.12-rc2-disable_builtin/init/main.c	2005-04-05 21:07:05.000000000 +0200
@@ -539,6 +539,17 @@ struct task_struct *child_reaper = &init
 
 extern initcall_t __initcall_start[], __initcall_end[];
 
+void __init disable_initcall(void *fn)
+{
+	initcall_t *call;
+
+	for (call = __initcall_start; call < __initcall_end; call++) {
+
+		if (*call == fn)
+			*call = NULL;
+	}
+}
+
 static void __init do_initcalls(void)
 {
 	initcall_t *call;
@@ -553,7 +564,8 @@ static void __init do_initcalls(void)
 			printk("\n");
 		}
 
-		(*call)();
+		if (*call)
+			(*call)();
 
 		msg = NULL;
 		if (preempt_count() != count) {
