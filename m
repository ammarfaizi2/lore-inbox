Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVCVR7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVCVR7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVCVR6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:58:52 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:34985 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261495AbVCVR4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:56:38 -0500
Subject: [patch 05/12] uml: extend cmd line limits
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       util@deuroconsult.ro
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 17:21:29 +0100
Message-Id: <20050322162129.2A53297669@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>
Increase UML command line size. And fix a crash from passing an overly-long
command line to UML.

XXX: check that init can handle 128 params and 128 env. var. The original
patch set this limit to 256, but it seems me too much. Think!

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/include/user_util.h |    2 -
 linux-2.6.11-paolo/arch/um/kernel/um_arch.c    |   34 ++++++++++++++-----------
 linux-2.6.11-paolo/arch/um/kernel/user_util.c  |   15 -----------
 linux-2.6.11-paolo/include/asm-um/setup.h      |    5 ++-
 linux-2.6.11-paolo/init/Kconfig                |    8 +++++
 linux-2.6.11-paolo/init/main.c                 |    4 +-
 6 files changed, 35 insertions(+), 33 deletions(-)

diff -puN arch/um/kernel/um_arch.c~uml-extend-cmd-line-limits arch/um/kernel/um_arch.c
--- linux-2.6.11/arch/um/kernel/um_arch.c~uml-extend-cmd-line-limits	2005-03-21 15:25:42.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/um_arch.c	2005-03-21 15:25:42.000000000 +0100
@@ -25,6 +25,7 @@
 #include "asm/user.h"
 #include "ubd_user.h"
 #include "asm/current.h"
+#include "asm/setup.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"
@@ -40,6 +41,20 @@
 
 #define DEFAULT_COMMAND_LINE "root=98:0"
 
+/* Changed in linux_main and setup_arch, which run before SMP is started */
+char command_line[COMMAND_LINE_SIZE] = { 0 };
+
+void add_arg(char *arg)
+{
+	if (strlen(command_line) + strlen(arg) + 1 > COMMAND_LINE_SIZE) {
+		printf("add_arg: Too much command line!\n");
+		exit(1);
+	}
+	if(strlen(command_line) > 0)
+		strcat(command_line, " ");
+	strcat(command_line, arg);
+}
+
 struct cpuinfo_um boot_cpu_data = { 
 	.loops_per_jiffy	= 0,
 	.ipi_pipe		= { -1, -1 }
@@ -314,9 +329,11 @@ int linux_main(int argc, char **argv)
 		if((i == 1) && (argv[i][0] == ' ')) continue;
 		add = 1;
 		uml_checksetup(argv[i], &add);
-		if(add) add_arg(saved_command_line, argv[i]);
+		if (add)
+			add_arg(argv[i]);
 	}
-	if(have_root == 0) add_arg(saved_command_line, DEFAULT_COMMAND_LINE);
+	if(have_root == 0)
+		add_arg(DEFAULT_COMMAND_LINE);
 
 	mode_tt = force_tt ? 1 : !can_do_skas();
 #ifndef CONFIG_MODE_TT
@@ -432,7 +449,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	notifier_chain_register(&panic_notifier_list, &panic_exit_notifier);
 	paging_init();
- 	strcpy(command_line, saved_command_line);
+ 	strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
 	setup_hostinfo();
 }
@@ -448,14 +465,3 @@ void __init check_bugs(void)
 void apply_alternatives(void *start, void *end)
 {
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/user_util.c~uml-extend-cmd-line-limits arch/um/kernel/user_util.c
--- linux-2.6.11/arch/um/kernel/user_util.c~uml-extend-cmd-line-limits	2005-03-21 15:25:42.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/user_util.c	2005-03-21 15:25:42.000000000 +0100
@@ -31,21 +31,6 @@
 #include "ptrace_user.h"
 #include "uml-config.h"
 
-#define COMMAND_LINE_SIZE _POSIX_ARG_MAX
-
-/* Changed in linux_main and setup_arch, which run before SMP is started */
-char command_line[COMMAND_LINE_SIZE] = { 0 };
-
-void add_arg(char *cmd_line, char *arg)
-{
-	if (strlen(cmd_line) + strlen(arg) + 1 > COMMAND_LINE_SIZE) {
-		printf("add_arg: Too much command line!\n");
-		exit(1);
-	}
-	if(strlen(cmd_line) > 0) strcat(cmd_line, " ");
-	strcat(cmd_line, arg);
-}
-
 void stop(void)
 {
 	while(1) sleep(1000000);
diff -puN include/asm-um/setup.h~uml-extend-cmd-line-limits include/asm-um/setup.h
--- linux-2.6.11/include/asm-um/setup.h~uml-extend-cmd-line-limits	2005-03-21 15:25:42.000000000 +0100
+++ linux-2.6.11-paolo/include/asm-um/setup.h	2005-03-21 15:25:42.000000000 +0100
@@ -1,6 +1,9 @@
 #ifndef SETUP_H_INCLUDED
 #define SETUP_H_INCLUDED
 
-#define COMMAND_LINE_SIZE 512
+/* POSIX mandated with _POSIX_ARG_MAX that we can rely on 4096 chars in the
+ * command line, so this choice is ok.*/
+
+#define COMMAND_LINE_SIZE 4096
 
 #endif		/* SETUP_H_INCLUDED */
diff -puN init/Kconfig~uml-extend-cmd-line-limits init/Kconfig
--- linux-2.6.11/init/Kconfig~uml-extend-cmd-line-limits	2005-03-21 15:25:42.000000000 +0100
+++ linux-2.6.11-paolo/init/Kconfig	2005-03-21 15:25:42.000000000 +0100
@@ -55,6 +55,14 @@ config LOCK_KERNEL
 	depends on SMP || PREEMPT
 	default y
 
+config INIT_ENV_ARG_LIMIT
+	int
+	default 32 if !USERMODE
+	default 128 if USERMODE
+	help
+	  This is the value of the two limits on the number of argument and of
+	  env.var passed to init from the kernel command line.
+
 endmenu
 
 menu "General setup"
diff -puN init/main.c~uml-extend-cmd-line-limits init/main.c
--- linux-2.6.11/init/main.c~uml-extend-cmd-line-limits	2005-03-21 15:25:42.000000000 +0100
+++ linux-2.6.11-paolo/init/main.c	2005-03-21 15:25:42.000000000 +0100
@@ -110,8 +110,8 @@ EXPORT_SYMBOL(system_state);
 /*
  * Boot command-line arguments
  */
-#define MAX_INIT_ARGS 32
-#define MAX_INIT_ENVS 32
+#define MAX_INIT_ARGS CONFIG_INIT_ENV_ARG_LIMIT
+#define MAX_INIT_ENVS CONFIG_INIT_ENV_ARG_LIMIT
 
 extern void time_init(void);
 /* Default late time init is NULL. archs can override this later. */
diff -puN arch/um/include/user_util.h~uml-extend-cmd-line-limits arch/um/include/user_util.h
--- linux-2.6.11/arch/um/include/user_util.h~uml-extend-cmd-line-limits	2005-03-21 15:25:42.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/include/user_util.h	2005-03-21 15:25:42.000000000 +0100
@@ -67,7 +67,7 @@ extern void *um_kmalloc(int size);
 extern int switcheroo(int fd, int prot, void *from, void *to, int size);
 extern void setup_machinename(char *machine_out);
 extern void setup_hostinfo(void);
-extern void add_arg(char *cmd_line, char *arg);
+extern void add_arg(char *arg);
 extern void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int));
 extern void init_new_thread_signals(int altstack);
 extern void do_exec(int old_pid, int new_pid);
_
