Return-Path: <linux-kernel-owner+w=401wt.eu-S1752517AbWLSFRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbWLSFRN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 00:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbWLSFRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 00:17:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:45442 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbWLSFRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 00:17:10 -0500
Date: Tue, 19 Dec 2006 10:47:05 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Sam Ravnborg <sam@ravnborg.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4/5] Break init() in two parts to avoid MODPOST warnings
Message-ID: <20061219051705.GD26052@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o init() is a non __init function in .text section but it calls many
  functions which are in .init.text section. Hence MODPOST generates lots
  of cross reference warnings on i386 if compiled with CONFIG_RELOCATABLE=y

WARNING: vmlinux - Section mismatch: reference to .init.text:smp_prepare_cpus from .text between 'init' (at offset 0xc0101049) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:migration_init from .text between 'init' (at offset 0xc010104e) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:spawn_ksoftirqd from .text between 'init' (at offset 0xc0101053) and 'rest_init'

o This patch breaks down init() in two parts. One part which can go
  in .init.text section and can be freed and other part which has to 
  be non __init(init_post()). Now init() calls init_post() and init_post()
  does not call any functions present in .init sections. Hence getting
  rid of warnings.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 init/main.c |   81 +++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 36 deletions(-)

diff -puN init/main.c~brea-init-in-two-parts-to-avoid-warnings init/main.c
--- linux-2.6.19-rc1-reloc/init/main.c~brea-init-in-two-parts-to-avoid-warnings	2006-12-15 14:09:03.000000000 +0530
+++ linux-2.6.19-rc1-reloc-root/init/main.c	2006-12-15 14:09:03.000000000 +0530
@@ -716,7 +716,49 @@ static void run_init_process(char *init_
 	kernel_execve(init_filename, argv_init, envp_init);
 }
 
-static int init(void * unused)
+/* This is a non __init function. Force it to be noinline otherwise gcc
+ * makes it inline to init() and it becomes part of init.text section
+ */
+static int noinline init_post(void)
+{
+	free_initmem();
+	unlock_kernel();
+	mark_rodata_ro();
+	system_state = SYSTEM_RUNNING;
+	numa_default_policy();
+
+	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
+		printk(KERN_WARNING "Warning: unable to open an initial console.\n");
+
+	(void) sys_dup(0);
+	(void) sys_dup(0);
+
+	if (ramdisk_execute_command) {
+		run_init_process(ramdisk_execute_command);
+		printk(KERN_WARNING "Failed to execute %s\n",
+				ramdisk_execute_command);
+	}
+
+	/*
+	 * We try each of these until one succeeds.
+	 *
+	 * The Bourne shell can be used instead of init if we are
+	 * trying to recover a really broken machine.
+	 */
+	if (execute_command) {
+		run_init_process(execute_command);
+		printk(KERN_WARNING "Failed to execute %s.  Attempting "
+					"defaults...\n", execute_command);
+	}
+	run_init_process("/sbin/init");
+	run_init_process("/etc/init");
+	run_init_process("/bin/init");
+	run_init_process("/bin/sh");
+
+	panic("No init found.  Try passing init= option to kernel.");
+}
+
+static int __init init(void * unused)
 {
 	lock_kernel();
 	/*
@@ -764,39 +806,6 @@ static int init(void * unused)
 	 * we're essentially up and running. Get rid of the
 	 * initmem segments and start the user-mode stuff..
 	 */
-	free_initmem();
-	unlock_kernel();
-	mark_rodata_ro();
-	system_state = SYSTEM_RUNNING;
-	numa_default_policy();
-
-	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
-		printk(KERN_WARNING "Warning: unable to open an initial console.\n");
-
-	(void) sys_dup(0);
-	(void) sys_dup(0);
-
-	if (ramdisk_execute_command) {
-		run_init_process(ramdisk_execute_command);
-		printk(KERN_WARNING "Failed to execute %s\n",
-				ramdisk_execute_command);
-	}
-
-	/*
-	 * We try each of these until one succeeds.
-	 *
-	 * The Bourne shell can be used instead of init if we are 
-	 * trying to recover a really broken machine.
-	 */
-	if (execute_command) {
-		run_init_process(execute_command);
-		printk(KERN_WARNING "Failed to execute %s.  Attempting "
-					"defaults...\n", execute_command);
-	}
-	run_init_process("/sbin/init");
-	run_init_process("/etc/init");
-	run_init_process("/bin/init");
-	run_init_process("/bin/sh");
-
-	panic("No init found.  Try passing init= option to kernel.");
+	init_post();
+	return 0;
 }
_
