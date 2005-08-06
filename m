Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbVHFVBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbVHFVBD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 17:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbVHFVBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 17:01:03 -0400
Received: from lixom.net ([66.141.50.11]:28611 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S263555AbVHFVBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 17:01:01 -0400
Date: Sat, 6 Aug 2005 15:59:30 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] Add rdinit parameter to pick early userspace init
Message-ID: <20050806205930.GA7163@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This would be for -mm until 2.6.14 opens, I suppose:

Since early userspace was added, there's no way to override which init
to run from it. Some people tack on an extra cpio archive with a link
from /init depending on what they want to run, but that's sometimes
impractical.

Changing the "init=" to also override the early userspace isn't feasible,
since it is still used to indicate what init to run from disk when early
userspace has completed doing whatever it's doing (i.e. load filesystem
modules and drivers).

Instead, introduce "rdinit=" and make it override the default "/init"
if specified.

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/init/main.c
===================================================================
--- 2.6.orig/init/main.c	2005-08-03 19:53:46.000000000 -0500
+++ 2.6/init/main.c	2005-08-06 11:11:49.000000000 -0500
@@ -123,6 +123,7 @@ extern void softirq_init(void);
 char saved_command_line[COMMAND_LINE_SIZE];
 
 static char *execute_command;
+static char *ramdisk_execute_command;
 
 /* Setup configured maximum number of CPUs to activate */
 static unsigned int max_cpus = NR_CPUS;
@@ -297,6 +298,18 @@ static int __init init_setup(char *str)
 }
 __setup("init=", init_setup);
 
+static int __init rdinit_setup(char *str)
+{
+	unsigned int i;
+
+	ramdisk_execute_command = str;
+	/* See "auto" comment in init_setup */
+	for (i = 1; i < MAX_INIT_ARGS; i++)
+		argv_init[i] = NULL;
+	return 1;
+}
+__setup("rdinit=", rdinit_setup);
+
 extern void setup_arch(char **);
 
 #ifndef CONFIG_SMP
@@ -680,10 +693,14 @@ static int init(void * unused)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-	if (sys_access((const char __user *) "/init", 0) == 0)
-		execute_command = "/init";
-	else
+
+	if (!ramdisk_execute_command)
+		ramdisk_execute_command = "/init";
+
+	if (sys_access((const char __user *) ramdisk_execute_command, 0) != 0) {
+		ramdisk_execute_command = NULL;
 		prepare_namespace();
+	}
 
 	/*
 	 * Ok, we have completed the initial bootup, and
@@ -708,6 +725,9 @@ static int init(void * unused)
 	 * trying to recover a really broken machine.
 	 */
 
+	if (ramdisk_execute_command)
+		run_init_process(ramdisk_execute_command);
+
 	if (execute_command)
 		run_init_process(execute_command);
 
Index: 2.6/Documentation/kernel-parameters.txt
===================================================================
--- 2.6.orig/Documentation/kernel-parameters.txt	2005-08-03 19:53:08.000000000 -0500
+++ 2.6/Documentation/kernel-parameters.txt	2005-08-06 11:11:49.000000000 -0500
@@ -1169,6 +1169,11 @@ running once the system is up.
 			New name for the ramdisk parameter.
 			See Documentation/ramdisk.txt.
 
+	rdinit=		[KNL]
+			Format: <full_path>
+			Run specified binary instead of /init from the ramdisk,
+			used for early userspace startup. See initrd.
+
 	reboot=		[BUGS=IA-32,BUGS=ARM,BUGS=IA-64] Rebooting mode
 			Format: <reboot_mode>[,<reboot_mode2>[,...]]
 			See arch/*/kernel/reboot.c.
