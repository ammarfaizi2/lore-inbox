Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUIPLRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUIPLRx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267920AbUIPLRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:17:53 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:35714 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267940AbUIPLRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:17:16 -0400
Subject: [PATCH] Suspend2 Merge: init hooks
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095333524.3324.186.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 21:18:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Only sent this to Andrew the first time, sorry].

Hi.

This patch adds code to files in the init directory to fire suspend at
the right time during boot. Suspend2 can now be built as modules which
can be loaded from an initrd, so we don't use straight initcalls. The
check as to whether we need to resume is initiated just before mounting
the root fs if we're not using an initrd. If an initrd is in use, it is
expected that it will be configured to mount /proc and echo >
/proc/software_suspend/activate after loading modules and/or setting up
access to the storage medium (should allow for encryption of the image).
If the linuxrc doesn't include the activate call, it is fired after the
initrd finishes.

The patch also makes try_name and name_to_devt non __init so they can be
used to parse new storage locations. The location of the header
(equivalent to resume=) can be [re]set from a proc entry without needing
to reboot.

Regards,

Nigel

diff -ruN linux-2.6.9-rc1/init/do_mounts.c software-suspend-linux-2.6.9-rc1-rev3/init/do_mounts.c
--- linux-2.6.9-rc1/init/do_mounts.c	2004-05-19 22:10:47.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/init/do_mounts.c	2004-09-09 19:36:24.000000000 +1000
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
 	sys_mkdir("/sys", 0700);
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
 	sys_rmdir("/sys");
 #endif
@@ -204,6 +210,8 @@
 	res = 0;
 	goto done;
 }
+/* Exported for Software Suspend */
+EXPORT_SYMBOL(name_to_dev_t);
 
 static int __init root_dev_setup(char *line)
 {
@@ -397,9 +405,27 @@
 
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
 
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	if (!(software_suspend_state & SUSPEND_RESUME_DONE))
+		software_suspend_try_resume();
+#endif
+	
 	if (is_floppy && rd_doload && rd_load_disk(0))
 		ROOT_DEV = Root_RAM0;
 
diff -ruN linux-2.6.9-rc1/init/do_mounts_initrd.c software-suspend-linux-2.6.9-rc1-rev3/init/do_mounts_initrd.c
--- linux-2.6.9-rc1/init/do_mounts_initrd.c	2004-09-07 21:59:00.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/init/do_mounts_initrd.c	2004-09-09 19:36:24.000000000 +1000
@@ -7,6 +7,7 @@
 #include <linux/romfs_fs.h>
 #include <linux/initrd.h>
 #include <linux/sched.h>
+#include <linux/suspend.h>
 
 #include "do_mounts.h"
 
@@ -56,12 +57,24 @@
 	sys_chroot(".");
 	mount_devfs_fs ();
 
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	software_suspend_state |= SUSPEND_RUNNING_INITRD;
+#endif
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
-		while (pid != sys_wait4(-1, &i, 0, NULL))
+		while (pid != sys_wait4(-1, &i, 0, NULL)) {
 			yield();
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_FREEZE);
+		}
 	}
 
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	software_suspend_state &= ~SUSPEND_RUNNING_INITRD;
+	if (!(software_suspend_state & SUSPEND_RESUME_DONE))
+		software_suspend_try_resume();
+#endif
+
 	/* move initrd to rootfs' /old */
 	sys_fchdir(old_fd);
 	sys_mount("/", ".", NULL, MS_MOVE, NULL);
diff -ruN linux-2.6.9-rc1/init/main.c software-suspend-linux-2.6.9-rc1-rev3/init/main.c
--- linux-2.6.9-rc1/init/main.c	2004-09-07 21:59:00.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/init/main.c	2004-09-09 19:36:24.000000000 +1000
@@ -45,6 +45,7 @@
 #include <linux/unistd.h>
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
+#include <linux/suspend.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -696,6 +697,10 @@
 	else
 		prepare_namespace();
 
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	software_suspend_state &= ~SOFTWARE_SUSPEND_BOOT_TIME;
+#endif
+
 	/*
 	 * Ok, we have completed the initial bootup, and
 	 * we're essentially up and running. Get rid of the


-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

