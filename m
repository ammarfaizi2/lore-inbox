Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVGFCT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVGFCT3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVGFCT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:19:29 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:56216 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262034AbVGFCTO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:14 -0400
Subject: [PATCH] [3/48] Suspend2 2.1.9.8 for 2.6.12: 301-proc-acpi-sleep-activate-hook.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:39 +1000
Message-Id: <11206164393081@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 302-init-hooks.patch-old/init/do_mounts.c 302-init-hooks.patch-new/init/do_mounts.c
--- 302-init-hooks.patch-old/init/do_mounts.c	2005-06-20 11:47:31.000000000 +1000
+++ 302-init-hooks.patch-new/init/do_mounts.c	2005-07-04 23:14:19.000000000 +1000
@@ -140,11 +140,16 @@ dev_t name_to_dev_t(char *name)
 	char s[32];
 	char *p;
 	dev_t res = 0;
-	int part;
+	int part, mount_result;
 
 #ifdef CONFIG_SYSFS
 	int mkdir_err = sys_mkdir("/sys", 0700);
-	if (sys_mount("sysfs", "/sys", "sysfs", 0, NULL) < 0)
+	/* 
+	 * When changing resume2 parameter for Software Suspend, sysfs may
+	 * already be mounted. 
+	 */
+	mount_result = sys_mount("sysfs", "/sys", "sysfs", 0, NULL);
+	if (mount_result < 0 && mount_result != -EBUSY)
 		goto out;
 #endif
 
@@ -196,7 +201,8 @@ dev_t name_to_dev_t(char *name)
 	res = try_name(s, part);
 done:
 #ifdef CONFIG_SYSFS
-	sys_umount("/sys", 0);
+	if (mount_result >= 0)
+		sys_umount("/sys", 0);
 out:
 	if (!mkdir_err)
 		sys_rmdir("/sys");
@@ -413,9 +419,25 @@ void __init prepare_namespace(void)
 
 	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
 
+	/* Suspend2:
+	 * By this point, suspend_early_init has been called to initialise our
+	 * proc interface. If modules are built in, they have registered (all
+	 * of the above via late_initcalls).
+	 * 
+	 * We have not yet looked to see if an image exists, however. If we
+	 * have an initrd, it is expected that the user will have set it up
+	 * to echo > /proc/software_suspend/activate and thus initiate any
+	 * resume. If they don'tdo that, we do it immediately after the initrd
+	 * is finished (major issues if they mount filesystems rw from the
+	 * initrd! - they are warned. If there's no usable initrd, we do our
+	 * check next
+	 */
 	if (initrd_load())
 		goto out;
 
+	if (test_suspend_state(SUSPEND_RESUME_NOT_DONE))
+		suspend2_try_resume();
+	
 	if (is_floppy && rd_doload && rd_load_disk(0))
 		ROOT_DEV = Root_RAM0;
 
diff -ruNp 302-init-hooks.patch-old/init/do_mounts_initrd.c 302-init-hooks.patch-new/init/do_mounts_initrd.c
--- 302-init-hooks.patch-old/init/do_mounts_initrd.c	2004-11-03 21:51:15.000000000 +1100
+++ 302-init-hooks.patch-new/init/do_mounts_initrd.c	2005-07-04 23:14:19.000000000 +1000
@@ -7,6 +7,7 @@
 #include <linux/romfs_fs.h>
 #include <linux/initrd.h>
 #include <linux/sched.h>
+#include <linux/suspend.h>
 
 #include "do_mounts.h"
 
@@ -58,9 +59,20 @@ static void __init handle_initrd(void)
 
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
-		while (pid != sys_wait4(-1, &i, 0, NULL))
+		while (pid != sys_wait4(-1, &i, 0, NULL)) {
 			yield();
+			try_to_freeze();
+		}
+	}
+
+	if (test_suspend_state(SUSPEND_RESUME_NOT_DONE)) {
+		if (resume2_file[0])
+			suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+				"Initrd not properly configured for resuming.");
+		else
+			printk("Suspend2: Initrd not properly configured for resuming and no resume2= specified.\n");
 	}
+	clear_suspend_state(SUSPEND_BOOT_TIME);
 
 	/* move initrd to rootfs' /old */
 	sys_fchdir(old_fd);
diff -ruNp 302-init-hooks.patch-old/init/main.c 302-init-hooks.patch-new/init/main.c
--- 302-init-hooks.patch-old/init/main.c	2005-07-06 11:13:20.000000000 +1000
+++ 302-init-hooks.patch-new/init/main.c	2005-07-04 23:14:19.000000000 +1000
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/suspend.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -701,7 +702,9 @@ static int init(void * unused)
 
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
-	 * the work
+	 * the work. For suspend2, we assume that it will do the right thing
+	 * with regard to trying to resume at the right place. When that
+	 * happens, the BOOT_TIME flag will be cleared.
 	 */
 	if (sys_access((const char __user *) "/init", 0) == 0)
 		execute_command = "/init";

