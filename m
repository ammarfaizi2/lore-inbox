Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269850AbUJSQp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269850AbUJSQp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269819AbUJSQoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:44:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:59076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269805AbUJSQiv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:51 -0400
X-Donotread: and you are reading this why?
Subject: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <20041019163429.GA2402@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:35:55 -0700
Message-Id: <10982037552948@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.55.4, 2004/09/04 00:11:26+02:00, kay.sievers@vrfy.org

[PATCH] export of SEQNUM to userspace (creates /sys/kernel)

o /sys/kernel/hotplug_seqnum exports the current number
o lib/kobject.c's  sequence_num is renamed to hotplug_seqnum and
  exported by include/linux/kobject.h
o the source file ksysfs.c in kernel/ creates on init the
  sybsystem "/sys/kernel/" in sysfs


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/kobject.h |    3 ++
 kernel/Makefile         |    2 -
 kernel/ksysfs.c         |   52 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/kobject.c           |    4 +--
 4 files changed, 58 insertions(+), 3 deletions(-)


diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	2004-10-19 09:23:35 -07:00
+++ b/include/linux/kobject.h	2004-10-19 09:23:35 -07:00
@@ -26,6 +26,9 @@
 
 #define KOBJ_NAME_LEN	20
 
+/* counter to tag the hotplug event, read only except for the kobject core */
+extern unsigned long hotplug_seqnum;
+
 struct kobject {
 	char			* k_name;
 	char			name[KOBJ_NAME_LEN];
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2004-10-19 09:23:35 -07:00
+++ b/kernel/Makefile	2004-10-19 09:23:35 -07:00
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o ksysfs.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -Nru a/kernel/ksysfs.c b/kernel/ksysfs.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/ksysfs.c	2004-10-19 09:23:35 -07:00
@@ -0,0 +1,52 @@
+/*
+ * kernel/ksysfs.c - sysfs attributes in /sys/kernel, which
+ * 		     are not related to any other subsystem
+ *
+ * Copyright (C) 2004 Kay Sievers <kay.sievers@vrfy.org>
+ * 
+ * This file is release under the GPLv2
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kobject.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#define KERNEL_ATTR_RO(_name) \
+static struct subsys_attribute _name##_attr = __ATTR_RO(_name)
+
+#define KERNEL_ATTR_RW(_name) \
+static struct subsys_attribute _name##_attr = \
+	__ATTR(_name, 0644, _name##_show, _name##_store)
+
+static ssize_t hotplug_seqnum_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%lu\n", hotplug_seqnum);
+}
+KERNEL_ATTR_RO(hotplug_seqnum);
+
+
+static decl_subsys(kernel, NULL, NULL);
+
+static struct attribute * kernel_attrs[] = {
+	&hotplug_seqnum_attr.attr,
+	NULL
+};
+
+static struct attribute_group kernel_attr_group = {
+	.attrs = kernel_attrs,
+};
+
+static int __init ksysfs_init(void)
+{
+	int error = subsystem_register(&kernel_subsys);
+	if (!error)
+		error = sysfs_create_group(&kernel_subsys.kset.kobj, &kernel_attr_group);
+
+	return error;
+}
+
+core_initcall(ksysfs_init);
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-10-19 09:23:35 -07:00
+++ b/lib/kobject.c	2004-10-19 09:23:35 -07:00
@@ -122,7 +122,7 @@
 
 #define BUFFER_SIZE	1024	/* should be enough memory for the env */
 #define NUM_ENVP	32	/* number of env pointers */
-static unsigned long sequence_num;
+unsigned long hotplug_seqnum;
 static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
 
 static void kset_hotplug(const char *action, struct kset *kset,
@@ -178,7 +178,7 @@
 	scratch += sprintf(scratch, "ACTION=%s", action) + 1;
 
 	spin_lock(&sequence_lock);
-	seq = sequence_num++;
+	seq = hotplug_seqnum++;
 	spin_unlock(&sequence_lock);
 
 	envp [i++] = scratch;

