Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVCSXef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVCSXef (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 18:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVCSXef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 18:34:35 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:45775 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261909AbVCSXe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 18:34:29 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050319230648.19238.42743.71351@clementine.local>
Subject: [PATCH] disable builtin modules
Date: Sun, 20 Mar 2005 00:34:27 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it possible to disable built in code from the kernel
command line. The patch is rather simple - it extends the compiled-in case 
of module_init() to include __setup() with a name based on KBUILD_MODNAME.

Problem: Say that your Firewire PHY breaks and you find yourself unable to 
boot any installation cd that includes built in Firewire support because 
the ohci1394 code together with your broken hardware makes the kernel crash 
during bootup.

Solution: Boot a kernel that includes this patch and pass ohci1394=off.

Signed-off-by: Magnus Damm <damm@opensource.se>

diff -urNp linux-2.6.11.4/include/linux/init.h linux-2.6.11.4-disable_builtin/include/linux/init.h
--- linux-2.6.11.4/include/linux/init.h	2005-03-16 10:56:20.000000000 +0100
+++ linux-2.6.11.4-disable_builtin/include/linux/init.h	2005-03-19 23:42:29.417496240 +0100
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
+__setup(__stringify(KBUILD_MODNAME) "=off", x##_disable_module)
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
diff -urNp linux-2.6.11.4/init/main.c linux-2.6.11.4-disable_builtin/init/main.c
--- linux-2.6.11.4/init/main.c	2005-03-16 10:56:20.000000000 +0100
+++ linux-2.6.11.4-disable_builtin/init/main.c	2005-03-19 23:31:52.676295616 +0100
@@ -527,6 +527,17 @@ struct task_struct *child_reaper = &init
 
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
@@ -541,7 +552,8 @@ static void __init do_initcalls(void)
 			printk("\n");
 		}
 
-		(*call)();
+		if (*call)
+			(*call)();
 
 		msg = NULL;
 		if (preempt_count() != count) {
