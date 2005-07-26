Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVGZUKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVGZUKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVGZUKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:10:36 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:18188 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261986AbVGZUKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:10:30 -0400
Message-Id: <200507262004.j6QK45Fn010068@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/4] UML - Add skas0 command-line option
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jul 2005 16:04:05 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This adds the "skas0" parameter to force skas0 operation on SKAS3 host and
shows which operating mode has been selected.

Not intrusive, much more trivial than Bodo's patch, to merge for 2.6.13.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/process.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/process.c	2005-07-23 09:27:27.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/process.c	2005-07-23 10:56:54.000000000 -0400
@@ -212,12 +212,26 @@
 
 static int force_sysemu_disabled = 0;
 
+int ptrace_faultinfo = 1;
+int proc_mm = 1;
+
+static int __init skas0_cmd_param(char *str, int* add)
+{
+	ptrace_faultinfo = proc_mm = 0;
+	return 0;
+}
+
 static int __init nosysemu_cmd_param(char *str, int* add)
 {
 	force_sysemu_disabled = 1;
 	return 0;
 }
 
+__uml_setup("skas0", skas0_cmd_param,
+		"skas0\n"
+		"    Disables SKAS3 usage, so that SKAS0 is used, unless you \n"
+		"    specify mode=tt.\n\n");
+
 __uml_setup("nosysemu", nosysemu_cmd_param,
 		"nosysemu\n"
 		"    Turns off syscall emulation patch for ptrace (SYSEMU) on.\n"
@@ -359,12 +373,10 @@
 		kill(target, SIGIO);
 }
 
-int ptrace_faultinfo = 0;
-int proc_mm = 1;
-
 extern void *__syscall_stub_start, __syscall_stub_end;
 
 #ifdef UML_CONFIG_MODE_SKAS
+
 static inline void check_skas3_ptrace_support(void)
 {
 	struct ptrace_faultinfo fi;
@@ -375,6 +387,7 @@
 
 	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
 	if (n < 0) {
+		ptrace_faultinfo = 0;
 		if(errno == EIO)
 			printf("not found\n");
 		else {
@@ -382,8 +395,10 @@
 		}
 	}
 	else {
-		ptrace_faultinfo = 1;
-		printf("found\n");
+		if (!ptrace_faultinfo)
+			printf("found but disabled on command line\n");
+		else
+			printf("found\n");
 	}
 
 	init_registers(pid);
@@ -396,13 +411,13 @@
 	if (os_access("/proc/mm", OS_ACC_W_OK) < 0) {
 		proc_mm = 0;
 		printf("not found\n");
-		goto out;
-	}
-	else {
-		printf("found\n");
+	} else {
+		if (!proc_mm)
+			printf("found but disabled on command line\n");
+		else
+			printf("found\n");
 	}
 
-out:
 	check_skas3_ptrace_support();
 	return 1;
 }
Index: linux-2.6.12/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/um_arch.c	2005-07-23 09:27:27.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/um_arch.c	2005-07-23 10:59:25.000000000 -0400
@@ -38,6 +38,9 @@
 #include "choose-mode.h"
 #include "mode_kern.h"
 #include "mode.h"
+#ifdef UML_CONFIG_MODE_SKAS
+#include "skas.h"
+#endif
 
 #define DEFAULT_COMMAND_LINE "root=98:0"
 
@@ -318,6 +321,7 @@
 	unsigned long avail, diff;
 	unsigned long virtmem_size, max_physmem;
 	unsigned int i, add;
+	char * mode;
 
 	for (i = 1; i < argc; i++){
 		if((i == 1) && (argv[i][0] == ' ')) continue;
@@ -338,6 +342,21 @@
 		exit(1);
 	}
 #endif
+
+#ifndef CONFIG_MODE_SKAS
+	mode = "TT";
+#else
+	/* Show to the user the result of selection */
+	if (mode_tt)
+		mode = "TT";
+	else if (proc_mm && ptrace_faultinfo)
+		mode = "SKAS3";
+	else
+		mode = "SKAS0";
+#endif
+
+	printf("UML running in %s mode\n", mode);
+
 	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas, 0,
 				     &host_task_size, &task_size);
 

