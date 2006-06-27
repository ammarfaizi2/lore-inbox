Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932833AbWF0EqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbWF0EqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933427AbWF0Emr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:42:47 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:54235 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030701AbWF0Eme
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:34 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/13] [Suspend2] Boot time hooks.
Date: Tue, 27 Jun 2006 14:42:32 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044231.15066.69247.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hooks for checking whether to resume when booting.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 init/do_mounts.c        |   28 +++++++++++++++++++++++++---
 init/do_mounts_initrd.c |   10 +++++++++-
 init/main.c             |    4 +++-
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 21b3b8f..0cc9233 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -138,11 +138,16 @@ dev_t name_to_dev_t(char *name)
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
 
@@ -194,7 +199,8 @@ dev_t name_to_dev_t(char *name)
 	res = try_name(s, part);
 done:
 #ifdef CONFIG_SYSFS
-	sys_umount("/sys", 0);
+	if (mount_result >= 0)
+		sys_umount("/sys", 0);
 out:
 	if (!mkdir_err)
 		sys_rmdir("/sys");
@@ -420,9 +426,25 @@ void __init prepare_namespace(void)
 
 	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
 
+	/* Suspend2:
+	 * By this point, suspend_early_init has been called to initialise our
+	 * proc interface. If modules are built in, they have registered (all
+	 * of the above via late_initcalls).
+	 * 
+	 * We have not yet looked to see if an image exists, however. If we
+	 * have an initrd, it is expected that the user will have set it up
+	 * to echo > /proc/suspend2/do_resume and thus initiate any
+	 * resume. If they don't do that, we do it immediately after the initrd
+	 * is finished (major issues if they mount filesystems rw from the
+	 * initrd! - they are warned. If there's no usable initrd, we do our
+	 * check next.
+	 */
 	if (initrd_load())
 		goto out;
 
+	if (test_suspend_state(SUSPEND_RESUME_NOT_DONE))
+		suspend2_try_resume();
+	
 	if (is_floppy && rd_doload && rd_load_disk(0))
 		ROOT_DEV = Root_RAM0;
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 405f903..9f8287f 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -7,6 +7,7 @@
 #include <linux/romfs_fs.h>
 #include <linux/initrd.h>
 #include <linux/sched.h>
+#include <linux/suspend.h>
 
 #include "do_mounts.h"
 
@@ -59,10 +60,17 @@ static void __init handle_initrd(void)
 	current->flags |= PF_NOFREEZE;
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
-		while (pid != sys_wait4(-1, NULL, 0, NULL))
+		while (pid != sys_wait4(-1, NULL, 0, NULL)) {
 			yield();
+			try_to_freeze();
+		}
 	}
 
+	if (test_suspend_state(SUSPEND_RESUME_NOT_DONE))
+		printk(KERN_ERR "Suspend2: Initrd lacks echo > /proc/suspend2/do_resume.\n");
+	clear_suspend_state(SUSPEND_BOOT_TIME);
+	current->flags &= ~PF_NOFREEZE;
+
 	/* move initrd to rootfs' /old */
 	sys_fchdir(old_fd);
 	sys_mount("/", ".", NULL, MS_MOVE, NULL);
diff --git a/init/main.c b/init/main.c
index f715b9b..89e1ba3 100644
--- a/init/main.c
+++ b/init/main.c
@@ -681,7 +681,9 @@ static int init(void * unused)
 
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
-	 * the work
+	 * the work. For suspend2, we assume that it will do the right thing
+	 * with regard to trying to resume at the right place. When that
+	 * happens, the BOOT_TIME flag will be cleared.
 	 */
 
 	if (!ramdisk_execute_command)

--
Nigel Cunningham		nigel at suspend2 dot net
