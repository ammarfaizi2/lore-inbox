Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVFTTF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVFTTF4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVFTTFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:05:01 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:28170 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261457AbVFTS51
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:57:27 -0400
Message-Id: <200506201851.j5KIpJux008493@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/8] UML - Always disable kmalloc during shutdown
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Jun 2005 14:51:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc wasn't being disabled during panic.  This patch ensures that, no
matter how UML is exiting, it is disabled.  This matters because part of
the cleanup is to remove the umid file, which involves readdir, which calls
malloc.  This must map to libc malloc, rather than kmalloc or vmalloc.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/main.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/main.c	2005-06-20 11:54:50.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/main.c	2005-06-20 12:08:11.000000000 -0400
@@ -69,7 +69,6 @@ static __init void do_uml_initcalls(void
 
 static void last_ditch_exit(int sig)
 {
-        kmalloc_ok = 0;
 	signal(SIGINT, SIG_DFL);
 	signal(SIGTERM, SIG_DFL);
 	signal(SIGHUP, SIG_DFL);
Index: linux-2.6.12/arch/um/kernel/reboot.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/reboot.c	2005-06-20 11:54:45.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/reboot.c	2005-06-20 12:07:55.000000000 -0400
@@ -38,14 +38,14 @@ static void kill_off_processes(void)
 
 void uml_cleanup(void)
 {
-	kill_off_processes();
+        kmalloc_ok = 0;
 	do_uml_exitcalls();
+	kill_off_processes();
 }
 
 void machine_restart(char * __unused)
 {
-	do_uml_exitcalls();
-	kill_off_processes();
+        uml_cleanup();
 	CHOOSE_MODE(reboot_tt(), reboot_skas());
 }
 
@@ -53,8 +53,7 @@ EXPORT_SYMBOL(machine_restart);
 
 void machine_power_off(void)
 {
-	do_uml_exitcalls();
-	kill_off_processes();
+        uml_cleanup();
 	CHOOSE_MODE(halt_tt(), halt_skas());
 }
 

