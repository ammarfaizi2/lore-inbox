Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbUKXNEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbUKXNEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbUKXNC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:02:58 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:37524 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262643AbUKXNBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:01:11 -0500
Subject: Suspend 2 merge: 9/51: init/* changes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101293918.5805.221.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:57:32 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes all of the changes to init/*.

There are two main parts:

1) Make name_to_dev_t non init. Why should you need to reboot if all you
want to do is change the device you're using to suspend? That's M$'s way
:>. Suspend2 allows the user to change the resume2= parameter after
booting via a proc entry. Making this code non-__init allows us to use
the same code that will be used at boot time to parse that string.

2) Hooks for resuming. Suspend2 functionality can be compiled as modules
or built in. Resuming can be activated via an initrd. These hooks allow
for all of the combinations of the above. Allowing resuming from within
an initrd is important because then you can set up LVM volumes
(including encrypted devices), compile drivers for your resume device as
modules and so on.

diff -ruN 302-init-hooks-old/init/do_mounts.c 302-init-hooks-new/init/do_mounts.c
--- 302-init-hooks-old/init/do_mounts.c	2004-11-24 19:47:36.680646032 +1100
+++ 302-init-hooks-new/init/do_mounts.c	2004-11-24 19:50:37.257194224 +1100
@@ -52,7 +52,7 @@
 __setup("ro", readonly);
 __setup("rw", readwrite);
 
-static dev_t __init try_name(char *name, int part)
+static dev_t try_name(char *name, int part)
 {
 	char path[64];
 	char buf[32];
@@ -134,16 +134,21 @@
  *	is mounted on rootfs /sys.
  */
 
-dev_t __init name_to_dev_t(char *name)
+dev_t name_to_dev_t(char *name)
 {
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
 
@@ -195,7 +200,8 @@
 	res = try_name(s, part);
 done:
 #ifdef CONFIG_SYSFS
-	sys_umount("/sys", 0);
+	if (mount_result >= 0)
+		sys_umount("/sys", 0);
 out:
 	if (!mkdir_err)
 		sys_rmdir("/sys");
@@ -205,6 +211,8 @@
 	res = 0;
 	goto done;
 }
+/* Exported for Software Suspend */
+EXPORT_SYMBOL(name_to_dev_t);
 
 static int __init root_dev_setup(char *line)
 {
@@ -398,9 +406,25 @@
 
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
+		software_suspend_try_resume();
+	
 	if (is_floppy && rd_doload && rd_load_disk(0))
 		ROOT_DEV = Root_RAM0;
 
diff -ruN 302-init-hooks-old/init/do_mounts_initrd.c 302-init-hooks-new/init/do_mounts_initrd.c
--- 302-init-hooks-old/init/do_mounts_initrd.c	2004-11-03 21:51:15.000000000 +1100
+++ 302-init-hooks-new/init/do_mounts_initrd.c	2004-11-24 19:48:29.282649312 +1100
@@ -7,6 +7,7 @@
 #include <linux/romfs_fs.h>
 #include <linux/initrd.h>
 #include <linux/sched.h>
+#include <linux/suspend.h>
 
 #include "do_mounts.h"
 
@@ -58,10 +59,16 @@
 
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
-		while (pid != sys_wait4(-1, &i, 0, NULL))
+		while (pid != sys_wait4(-1, &i, 0, NULL)) {
 			yield();
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_FREEZE);
+		}
 	}
 
+	if (test_suspend_state(SUSPEND_RESUME_NOT_DONE))
+		software_suspend_try_resume();
+
 	/* move initrd to rootfs' /old */
 	sys_fchdir(old_fd);
 	sys_mount("/", ".", NULL, MS_MOVE, NULL);
diff -ruN 302-init-hooks-old/init/main.c 302-init-hooks-new/init/main.c
--- 302-init-hooks-old/init/main.c	2004-11-24 19:50:46.268824248 +1100
+++ 302-init-hooks-new/init/main.c	2004-11-24 19:48:29.293647640 +1100
@@ -46,6 +46,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/suspend.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -758,6 +759,8 @@
 	else
 		prepare_namespace();
 
+	clear_suspend_state(SUSPEND_BOOT_TIME);
+
 	/*
 	 * Ok, we have completed the initial bootup, and
 	 * we're essentially up and running. Get rid of the
diff -ruN 302-init-hooks-old/kernel/power/swsusp.c 302-init-hooks-new/kernel/power/swsusp.c
--- 302-init-hooks-old/kernel/power/swsusp.c	2004-11-24 09:53:12.000000000 +1100
+++ 302-init-hooks-new/kernel/power/swsusp.c	2004-11-24 19:48:29.294647488 +1100
@@ -1168,7 +1168,7 @@
 
 }
 
-extern dev_t __init name_to_dev_t(const char *line);
+extern dev_t name_to_dev_t(char *line);
 
 static int __init read_pagedir(void)
 {


