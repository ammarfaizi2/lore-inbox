Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVGMQiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVGMQiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVGMQiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:38:50 -0400
Received: from peabody.ximian.com ([130.57.169.10]:31877 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262699AbVGMQiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:38:46 -0400
Subject: [patch 1/3] inotify: move sysctl
From: Robert Love <rml@novell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, ttb@tentacle.dhs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 12:38:18 -0400
Message-Id: <1121272698.6384.25.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached patch moves the inotify sysctl knobs to "/proc/sys/fs/inotify"
from "/proc/sys/fs".  Also some related cleanup.

Patch is against current git tree.  Please, apply.

	Robert Love


Signed-off-by: Robert Love <rml@novell.com>

 fs/inotify.c           |   49 +++++++++++++++++++++++++++++++++++++++++++----
 include/linux/sysctl.h |   12 +++++------
 kernel/sysctl.c        |   51 ++++++++++---------------------------------------
 3 files changed, 62 insertions(+), 50 deletions(-)

diff -urN linux-2.6.13-rc3/fs/inotify.c linux/fs/inotify.c
--- linux-2.6.13-rc3/fs/inotify.c	2005-07-13 10:51:12.000000000 -0400
+++ linux/fs/inotify.c	2005-07-13 12:36:12.000000000 -0400
@@ -45,8 +45,8 @@
 
 static struct vfsmount *inotify_mnt;
 
-/* These are configurable via /proc/sys/inotify */
-int inotify_max_user_devices;
+/* these are configurable via /proc/sys/fs/inotify/ */
+int inotify_max_user_instances;
 int inotify_max_user_watches;
 int inotify_max_queued_events;
 
@@ -125,6 +125,47 @@
 	u32			mask;	/* event mask for this watch */
 };
 
+#ifdef CONFIG_SYSCTL
+
+#include <linux/sysctl.h>
+
+static int zero;
+
+ctl_table inotify_table[] = {
+	{
+		.ctl_name	= INOTIFY_MAX_USER_INSTANCES,
+		.procname	= "max_user_instances",
+		.data		= &inotify_max_user_instances,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+	{
+		.ctl_name	= INOTIFY_MAX_USER_WATCHES,
+		.procname	= "max_user_watches",
+		.data		= &inotify_max_user_watches,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero, 
+	},
+	{
+		.ctl_name	= INOTIFY_MAX_QUEUED_EVENTS,
+		.procname	= "max_queued_events",
+		.data		= &inotify_max_queued_events,
+		.maxlen		= sizeof(int),
+		.mode		= 0644, 
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec, 
+		.extra1		= &zero
+	},
+	{ .ctl_name = 0 }
+};
+#endif /* CONFIG_SYSCTL */
+
 static inline void get_inotify_dev(struct inotify_device *dev)
 {
 	atomic_inc(&dev->count);
@@ -842,7 +883,7 @@
 
 	user = get_uid(current->user);
 
-	if (unlikely(atomic_read(&user->inotify_devs) >= inotify_max_user_devices)) {
+	if (unlikely(atomic_read(&user->inotify_devs) >= inotify_max_user_instances)) {
 		ret = -EMFILE;
 		goto out_err;
 	}
@@ -979,7 +1020,7 @@
 	inotify_mnt = kern_mount(&inotify_fs_type);
 
 	inotify_max_queued_events = 8192;
-	inotify_max_user_devices = 128;
+	inotify_max_user_instances = 8;
 	inotify_max_user_watches = 8192;
 
 	atomic_set(&inotify_cookie, 0);
diff -urN linux-2.6.13-rc3/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2.6.13-rc3/include/linux/sysctl.h	2005-07-13 10:51:15.000000000 -0400
+++ linux/include/linux/sysctl.h	2005-07-13 11:11:24.000000000 -0400
@@ -61,8 +61,7 @@
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
-	CTL_INOTIFY=11		/* Inotify */
+	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
 };
 
 /* CTL_BUS names: */
@@ -71,12 +70,12 @@
 	CTL_BUS_ISA=1		/* ISA */
 };
 
-/* CTL_INOTIFY names: */
+/* /proc/sys/fs/inotify/ */
 enum
 {
-	INOTIFY_MAX_USER_DEVICES=1,	/* max number of inotify device instances per user */
-	INOTIFY_MAX_USER_WATCHES=2,	/* max number of inotify watches per user */
-	INOTIFY_MAX_QUEUED_EVENTS=3	/* Max number of queued events per inotify device instance */
+	INOTIFY_MAX_USER_INSTANCES=1,	/* max instances per user */
+	INOTIFY_MAX_USER_WATCHES=2,	/* max watches per user */
+	INOTIFY_MAX_QUEUED_EVENTS=3	/* max queued events per instance */
 };
 
 /* CTL_KERN names: */
@@ -685,6 +684,7 @@
 	FS_XFS=17,	/* struct: control xfs parameters */
 	FS_AIO_NR=18,	/* current system-wide number of aio requests */
 	FS_AIO_MAX_NR=19,	/* system-wide maximum number of aio requests */
+	FS_INOTIFY=20,	/* inotify submenu */
 };
 
 /* /proc/sys/fs/quota/ */
diff -urN linux-2.6.13-rc3/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.6.13-rc3/kernel/sysctl.c	2005-07-13 10:51:15.000000000 -0400
+++ linux/kernel/sysctl.c	2005-07-13 12:34:20.000000000 -0400
@@ -67,12 +67,6 @@
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
 
-#ifdef CONFIG_INOTIFY
-extern int inotify_max_user_devices;
-extern int inotify_max_user_watches;
-extern int inotify_max_queued_events;
-#endif
-
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
 extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
@@ -152,6 +146,9 @@
 #ifdef CONFIG_UNIX98_PTYS
 extern ctl_table pty_table[];
 #endif
+#ifdef CONFIG_INOTIFY
+extern ctl_table inotify_table[];
+#endif
 
 #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
 int sysctl_legacy_va_layout;
@@ -957,6 +954,14 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#ifdef CONFIG_INOTIFY
+	{
+		.ctl_name	= FS_INOTIFY,
+		.procname	= "inotify",
+		.mode		= 0555,
+		.child		= inotify_table,
+	},
+#endif	
 #endif
 	{
 		.ctl_name	= KERN_SETUID_DUMPABLE,
@@ -966,40 +971,6 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
-#ifdef CONFIG_INOTIFY
-	{
-		.ctl_name	= INOTIFY_MAX_USER_DEVICES,
-		.procname	= "max_user_devices",
-		.data		= &inotify_max_user_devices,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= &sysctl_intvec,
-		.extra1		= &zero,
-	},
-
-	{
-		.ctl_name	= INOTIFY_MAX_USER_WATCHES,
-		.procname	= "max_user_watches",
-		.data		= &inotify_max_user_watches,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= &sysctl_intvec,
-		.extra1		= &zero, 
-	},
-
-	{
-		.ctl_name	= INOTIFY_MAX_QUEUED_EVENTS,
-		.procname	= "max_queued_events",
-		.data		= &inotify_max_queued_events,
-		.maxlen		= sizeof(int),
-		.mode		= 0644, 
-		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= &sysctl_intvec, 
-		.extra1		= &zero
-	},
-#endif
 	{ .ctl_name = 0 }
 };
 


