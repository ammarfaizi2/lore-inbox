Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263113AbVG3TDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbVG3TDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbVG3TD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:03:29 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:52875 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S263113AbVG3TDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:03:16 -0400
Subject: [patch 2/3] uml: workaround GDB problems on debugging
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sat, 30 Jul 2005 21:05:36 +0200
Message-Id: <20050730190537.22C771AE9B@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Apparently, GDB gets confused when we do an execvp() on ourselves.

Since it's simply done to allocate further space for command line arguments
(which we'll use to allow gathering the startup command line for guest
processes through the host), allow the user to disable that to get a
debuggable UML binary.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/Kconfig.debug    |   11 +++++++++++
 linux-2.6.git-paolo/arch/um/kernel/main.c    |    2 +-
 linux-2.6.git-paolo/arch/um/kernel/um_arch.c |    6 +++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff -puN arch/um/Kconfig.debug~uml-fix-host-debug-on-TT-binaries arch/um/Kconfig.debug
--- linux-2.6.git/arch/um/Kconfig.debug~uml-fix-host-debug-on-TT-binaries	2005-07-30 16:50:53.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/Kconfig.debug	2005-07-30 16:58:52.000000000 +0200
@@ -2,6 +2,17 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+config CMDLINE_ON_HOST
+	bool "Show command line arguments on the host in TT mode"
+	depends on MODE_TT
+	default !DEBUG_INFO
+	help
+	This controls whether arguments in guest processes should be shown on
+	the host's ps output.
+	Enabling this option hinders debugging on some recent GDB versions
+	(because GDB gets "confused" when we do an execvp()). So probably you
+	should disable it.
+
 config PT_PROXY
 	bool "Enable ptrace proxy"
 	depends on XTERM_CHAN && DEBUG_INFO && MODE_TT
diff -puN arch/um/kernel/main.c~uml-fix-host-debug-on-TT-binaries arch/um/kernel/main.c
--- linux-2.6.git/arch/um/kernel/main.c~uml-fix-host-debug-on-TT-binaries	2005-07-30 16:50:53.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/main.c	2005-07-30 16:50:53.000000000 +0200
@@ -97,7 +97,7 @@ int main(int argc, char **argv, char **e
 		exit(1);
 	}
 
-#ifdef UML_CONFIG_MODE_TT
+#ifdef UML_CONFIG_CMDLINE_ON_HOST
 	/* Allocate memory for thread command lines */
 	if(argc < 2 || strlen(argv[1]) < THREAD_NAME_LEN - 1){
 
diff -puN arch/um/kernel/um_arch.c~uml-fix-host-debug-on-TT-binaries arch/um/kernel/um_arch.c
--- linux-2.6.git/arch/um/kernel/um_arch.c~uml-fix-host-debug-on-TT-binaries	2005-07-30 16:50:53.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/um_arch.c	2005-07-30 16:50:53.000000000 +0200
@@ -126,7 +126,7 @@ unsigned long start_vm;
 unsigned long end_vm;
 int ncpus = 1;
 
-#ifdef CONFIG_MODE_TT
+#ifdef CONFIG_CMDLINE_ON_HOST
 /* Pointer set in linux_main, the array itself is private to each thread,
  * and changed at address space creation time so this poses no concurrency
  * problems.
@@ -141,7 +141,7 @@ long physmem_size = 32 * 1024 * 1024;
 
 void set_cmdline(char *cmd)
 {
-#ifdef CONFIG_MODE_TT
+#ifdef CONFIG_CMDLINE_ON_HOST
 	char *umid, *ptr;
 
 	if(CHOOSE_MODE(honeypot, 0)) return;
@@ -385,7 +385,7 @@ int linux_main(int argc, char **argv)
 
 	setup_machinename(system_utsname.machine);
 
-#ifdef CONFIG_MODE_TT
+#ifdef CONFIG_CMDLINE_ON_HOST
 	argv1_begin = argv[1];
 	argv1_end = &argv[1][strlen(argv[1])];
 #endif
_
