Return-Path: <linux-kernel-owner+willy=40w.ods.org-S381745AbUKAX0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S381745AbUKAX0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S381669AbUKAXZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:25:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:14756 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S323732AbUKAV73 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:29 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10993462772266@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:57 -0800
Message-Id: <10993462772836@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2452, 2004/11/01 13:06:49-08:00, kay.sievers@vrfy.org

[PATCH] take me home, hotplug_path[]

Move hotplug_path[] out of kmod.[ch] to kobject_uevent.[ch] where
it belongs now. At some time in the future we should fix the remaining bad
hotplug calls (no SEQNUM, no netlink uevent):

  ./drivers/input/input.c (no DEVPATH on some hotplug events!)
  ./drivers/pnp/pnpbios/core.c
  ./drivers/s390/crypto/z90main.c

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/input/input.c          |    2 +-
 drivers/pnp/pnpbios/core.c     |    2 +-
 drivers/s390/crypto/z90main.c  |    1 +
 include/linux/kmod.h           |    4 ----
 include/linux/kobject_uevent.h |    5 +++++
 kernel/cpu.c                   |    1 -
 kernel/kmod.c                  |   23 -----------------------
 kernel/sysctl.c                |    2 +-
 lib/kobject_uevent.c           |    1 +
 9 files changed, 10 insertions(+), 31 deletions(-)


diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	2004-11-01 13:35:57 -08:00
+++ b/drivers/input/input.c	2004-11-01 13:35:57 -08:00
@@ -19,7 +19,7 @@
 #include <linux/major.h>
 #include <linux/pm.h>
 #include <linux/proc_fs.h>
-#include <linux/kmod.h>
+#include <linux/kobject_uevent.h>
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/device.h>
diff -Nru a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	2004-11-01 13:35:57 -08:00
+++ b/drivers/pnp/pnpbios/core.c	2004-11-01 13:35:57 -08:00
@@ -56,7 +56,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/slab.h>
-#include <linux/kmod.h>
+#include <linux/kobject_uevent.h>
 #include <linux/completion.h>
 #include <linux/spinlock.h>
 #include <linux/dmi.h>
diff -Nru a/drivers/s390/crypto/z90main.c b/drivers/s390/crypto/z90main.c
--- a/drivers/s390/crypto/z90main.c	2004-11-01 13:35:57 -08:00
+++ b/drivers/s390/crypto/z90main.c	2004-11-01 13:35:57 -08:00
@@ -33,6 +33,7 @@
 #include <linux/ioctl32.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/kobject_uevent.h>
 #include <linux/proc_fs.h>
 #include <linux/syscalls.h>
 #include <linux/version.h>
diff -Nru a/include/linux/kmod.h b/include/linux/kmod.h
--- a/include/linux/kmod.h	2004-11-01 13:35:57 -08:00
+++ b/include/linux/kmod.h	2004-11-01 13:35:57 -08:00
@@ -37,8 +37,4 @@
 extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
 extern void usermodehelper_init(void);
 
-#ifdef CONFIG_HOTPLUG
-extern char hotplug_path [];
-#endif
-
 #endif /* __LINUX_KMOD_H__ */
diff -Nru a/include/linux/kobject_uevent.h b/include/linux/kobject_uevent.h
--- a/include/linux/kobject_uevent.h	2004-11-01 13:35:57 -08:00
+++ b/include/linux/kobject_uevent.h	2004-11-01 13:35:57 -08:00
@@ -11,6 +11,11 @@
 #ifndef _KOBJECT_EVENT_H_
 #define _KOBJECT_EVENT_H_
 
+#define HOTPLUG_PATH_LEN	256
+
+/* path to the hotplug userspace helper executed on an event */
+extern char hotplug_path[];
+
 /*
  * If you add an action here, you must also add the proper string to the
  * lib/kobject_uevent.c file.
diff -Nru a/kernel/cpu.c b/kernel/cpu.c
--- a/kernel/cpu.c	2004-11-01 13:35:57 -08:00
+++ b/kernel/cpu.c	2004-11-01 13:35:57 -08:00
@@ -11,7 +11,6 @@
 #include <linux/unistd.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
-#include <linux/kmod.h>		/* for hotplug_path */
 #include <linux/kthread.h>
 #include <linux/stop_machine.h>
 #include <asm/semaphore.h>
diff -Nru a/kernel/kmod.c b/kernel/kmod.c
--- a/kernel/kmod.c	2004-11-01 13:35:57 -08:00
+++ b/kernel/kmod.c	2004-11-01 13:35:57 -08:00
@@ -115,29 +115,6 @@
 EXPORT_SYMBOL(request_module);
 #endif /* CONFIG_KMOD */
 
-#ifdef CONFIG_HOTPLUG
-/*
-	hotplug path is set via /proc/sys
-	invoked by hotplug-aware bus drivers,
-	with call_usermodehelper
-
-	argv [0] = hotplug_path;
-	argv [1] = "usb", "scsi", "pci", "network", etc;
-	... plus optional type-specific parameters
-	argv [n] = 0;
-
-	envp [*] = HOME, PATH; optional type-specific parameters
-
-	a hotplug bus should invoke this for device add/remove
-	events.  the command is expected to load drivers when
-	necessary, and may perform additional system setup.
-*/
-char hotplug_path[KMOD_PATH_LEN] = "/sbin/hotplug";
-
-EXPORT_SYMBOL(hotplug_path);
-
-#endif /* CONFIG_HOTPLUG */
-
 struct subprocess_info {
 	struct completion *complete;
 	char *path;
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	2004-11-01 13:35:57 -08:00
+++ b/kernel/sysctl.c	2004-11-01 13:35:57 -08:00
@@ -394,7 +394,7 @@
 		.ctl_name	= KERN_HOTPLUG,
 		.procname	= "hotplug",
 		.data		= &hotplug_path,
-		.maxlen		= KMOD_PATH_LEN,
+		.maxlen		= HOTPLUG_PATH_LEN,
 		.mode		= 0644,
 		.proc_handler	= &proc_dostring,
 		.strategy	= &sysctl_string,
diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-11-01 13:35:57 -08:00
+++ b/lib/kobject_uevent.c	2004-11-01 13:35:57 -08:00
@@ -177,6 +177,7 @@
 
 
 #ifdef CONFIG_HOTPLUG
+char hotplug_path[HOTPLUG_PATH_LEN] = "/sbin/hotplug";
 u64 hotplug_seqnum;
 static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
 

