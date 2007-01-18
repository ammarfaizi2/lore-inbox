Return-Path: <linux-kernel-owner+w=401wt.eu-S932293AbXARNEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbXARNEz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbXARNEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:20 -0500
Received: from cantor2.suse.de ([195.135.220.15]:54866 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932257AbXARNEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:16 -0500
Message-Id: <20070118130028.268691000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:58:50 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 01/26] Dynamic kernel command-line - common
Content-Disposition: inline; filename=dynamic-kernel-command-line-common.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Rename saved_command_line into boot_command_line, mark
   as init disposable.
2. Add dynamic allocated saved_command_line.
3. Add dynamic allocated static_command_line.
4. During startup copy:
   boot_command_line into saved_command_line.
   arch command_line into static_command_line.
5. Parse static_command_line and not
   arch command_line, so arch command_line may
   be freed.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 include/linux/init.h |    5 +++--
 init/main.c          |   29 ++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 7 deletions(-)

Index: linux-2.6.20-rc4-mm1/include/linux/init.h
===================================================================
--- linux-2.6.20-rc4-mm1.orig/include/linux/init.h
+++ linux-2.6.20-rc4-mm1/include/linux/init.h
@@ -67,7 +67,8 @@ extern initcall_t __con_initcall_start[]
 extern initcall_t __security_initcall_start[], __security_initcall_end[];
 
 /* Defined in init/main.c */
-extern char saved_command_line[];
+extern char __initdata boot_command_line[];
+extern char *saved_command_line;
 extern unsigned int reset_devices;
 
 /* used by init/main.c */
@@ -164,7 +165,7 @@ struct obs_kernel_param {
 #define early_param(str, fn)					\
 	__setup_param(str, fn, fn, 1)
 
-/* Relies on saved_command_line being set */
+/* Relies on boot_command_line being set */
 void __init parse_early_param(void);
 #endif /* __ASSEMBLY__ */
 
Index: linux-2.6.20-rc4-mm1/init/main.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/init/main.c
+++ linux-2.6.20-rc4-mm1/init/main.c
@@ -122,8 +122,12 @@ extern void time_init(void);
 void (*late_time_init)(void);
 extern void softirq_init(void);
 
-/* Untouched command line (eg. for /proc) saved by arch-specific code. */
-char saved_command_line[COMMAND_LINE_SIZE];
+/* Untouched command line saved by arch-specific code. */
+char __initdata boot_command_line[COMMAND_LINE_SIZE];
+/* Untouched saved command line (eg. for /proc) */
+char *saved_command_line;
+/* Command line for parameter parsing */
+static char *static_command_line;
 
 static char *execute_command;
 static char *ramdisk_execute_command;
@@ -406,6 +410,20 @@ static void __init smp_init(void)
 #endif
 
 /*
+ * We need to store the untouched command line for future reference.
+ * We also need to store the touched command line since the parameter
+ * parsing is performed in place, and we should allow a component to
+ * store reference of name/value for future reference.
+ */
+static void __init setup_command_line(char *command_line)
+{
+	saved_command_line = alloc_bootmem(strlen (boot_command_line)+1);
+	static_command_line = alloc_bootmem(strlen (command_line)+1);
+	strcpy (saved_command_line, boot_command_line);
+	strcpy (static_command_line, command_line);
+}
+
+/*
  * We need to finalize in a non-__init function or else race conditions
  * between the root thread and the init thread may cause start_kernel to
  * be reaped by free_initmem before the root thread has proceeded to
@@ -459,7 +477,7 @@ void __init parse_early_param(void)
 		return;
 
 	/* All fall through to do_early_param. */
-	strlcpy(tmp_cmdline, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	parse_args("early options", tmp_cmdline, NULL, 0, do_early_param);
 	done = 1;
 }
@@ -509,6 +527,7 @@ asmlinkage void __init start_kernel(void
 	printk(KERN_NOTICE);
 	printk(linux_banner);
 	setup_arch(&command_line);
+	setup_command_line(command_line);
 	unwind_setup();
 	setup_per_cpu_areas();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
@@ -526,9 +545,9 @@ asmlinkage void __init start_kernel(void
 	preempt_disable();
 	build_all_zonelists();
 	page_alloc_init();
-	printk(KERN_NOTICE "Kernel command line: %s\n", saved_command_line);
+	printk(KERN_NOTICE "Kernel command line: %s\n", boot_command_line);
 	parse_early_param();
-	parse_args("Booting kernel", command_line, __start___param,
+	parse_args("Booting kernel", static_command_line, __start___param,
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
 	if (!irqs_disabled()) {

-- 
