Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWAEAyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWAEAyc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWAEAum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:57529 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750944AbWAEAtu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:50 -0500
Cc: kay.sievers@suse.de
Subject: [PATCH] remove CONFIG_KOBJECT_UEVENT option
In-Reply-To: <20060105004826.GA17328@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:28 -0800
Message-Id: <11364221683611@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] remove CONFIG_KOBJECT_UEVENT option

It makes zero sense to have hotplug, but not the netlink
events enabled today. Remove this option and merge the
kobject_uevent.h header into the kobject.h header file.

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0296b2281352e4794e174b393c37f131502e09f0
tree 874e1de7ffaf56ab14f031d2818b69853c4914d8
parent 034382117725f6b6b26fbb138498139c5c012c1b
author Kay Sievers <kay.sievers@suse.de> Fri, 11 Nov 2005 05:33:52 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:07 -0800

 MAINTAINERS                    |    6 ----
 drivers/input/input.c          |    1 -
 drivers/s390/crypto/z90main.c  |    1 -
 include/linux/kobject.h        |   35 ++++++++++++++++++++++++-
 include/linux/kobject_uevent.h |   57 ----------------------------------------
 init/Kconfig                   |   19 -------------
 kernel/sysctl.c                |    4 +--
 lib/kobject_uevent.c           |   24 ++++-------------
 8 files changed, 40 insertions(+), 107 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6af6830..b49a4ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1476,12 +1476,6 @@ W:	http://nfs.sourceforge.net/
 W:	http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/
 S:	Maintained
 
-KERNEL EVENT LAYER (KOBJECT_UEVENT)
-P:	Robert Love
-M:	rml@novell.com
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
-
 KEXEC
 P:	Eric Biederman
 P:	Randy Dunlap
diff --git a/drivers/input/input.c b/drivers/input/input.c
index bdd2a7f..43b49cc 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -18,7 +18,6 @@
 #include <linux/random.h>
 #include <linux/major.h>
 #include <linux/proc_fs.h>
-#include <linux/kobject_uevent.h>
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/device.h>
diff --git a/drivers/s390/crypto/z90main.c b/drivers/s390/crypto/z90main.c
index 4010f2b..790fcbb 100644
--- a/drivers/s390/crypto/z90main.c
+++ b/drivers/s390/crypto/z90main.c
@@ -34,7 +34,6 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/kobject_uevent.h>
 #include <linux/proc_fs.h>
 #include <linux/syscalls.h>
 #include "z90crypt.h"
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 7f7403a..baf5251 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -23,15 +23,31 @@
 #include <linux/spinlock.h>
 #include <linux/rwsem.h>
 #include <linux/kref.h>
-#include <linux/kobject_uevent.h>
 #include <linux/kernel.h>
 #include <asm/atomic.h>
 
 #define KOBJ_NAME_LEN	20
 
+#define HOTPLUG_PATH_LEN	256
+
+/* path to the userspace helper executed on an event */
+extern char hotplug_path[];
+
 /* counter to tag the hotplug event, read only except for the kobject core */
 extern u64 hotplug_seqnum;
 
+/* the actions here must match the proper string in lib/kobject_uevent.c */
+typedef int __bitwise kobject_action_t;
+enum kobject_action {
+	KOBJ_ADD	= (__force kobject_action_t) 0x01,	/* add event, for hotplug */
+	KOBJ_REMOVE	= (__force kobject_action_t) 0x02,	/* remove event, for hotplug */
+	KOBJ_CHANGE	= (__force kobject_action_t) 0x03,	/* a sysfs attribute file has changed */
+	KOBJ_MOUNT	= (__force kobject_action_t) 0x04,	/* mount event for block devices */
+	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices */
+	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* offline event for hotplug devices */
+	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* online event for hotplug devices */
+};
+
 struct kobject {
 	const char		* k_name;
 	char			name[KOBJ_NAME_LEN];
@@ -243,16 +259,33 @@ extern void subsys_remove_file(struct su
 
 #ifdef CONFIG_HOTPLUG
 void kobject_hotplug(struct kobject *kobj, enum kobject_action action);
+
 int add_hotplug_env_var(char **envp, int num_envp, int *cur_index,
 			char *buffer, int buffer_size, int *cur_len,
 			const char *format, ...)
 	__attribute__((format (printf, 7, 8)));
+
+int kobject_uevent(struct kobject *kobj,
+		   enum kobject_action action,
+		   struct attribute *attr);
+int kobject_uevent_atomic(struct kobject *kobj,
+			  enum kobject_action action,
+			  struct attribute *attr);
+
 #else
 static inline void kobject_hotplug(struct kobject *kobj, enum kobject_action action) { }
 static inline int add_hotplug_env_var(char **envp, int num_envp, int *cur_index, 
 				      char *buffer, int buffer_size, int *cur_len, 
 				      const char *format, ...)
 { return 0; }
+int kobject_uevent(struct kobject *kobj,
+		   enum kobject_action action,
+		   struct attribute *attr)
+{ return 0; }
+int kobject_uevent_atomic(struct kobject *kobj,
+			  enum kobject_action action,
+			  struct attribute *attr)
+{ return 0; }
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/include/linux/kobject_uevent.h b/include/linux/kobject_uevent.h
deleted file mode 100644
index aa664fe..0000000
--- a/include/linux/kobject_uevent.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * kobject_uevent.h - list of kobject user events that can be generated
- *
- * Copyright (C) 2004 IBM Corp.
- * Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
- *
- * This file is released under the GPLv2.
- *
- */
-
-#ifndef _KOBJECT_EVENT_H_
-#define _KOBJECT_EVENT_H_
-
-#define HOTPLUG_PATH_LEN	256
-
-/* path to the hotplug userspace helper executed on an event */
-extern char hotplug_path[];
-
-/*
- * If you add an action here, you must also add the proper string to the
- * lib/kobject_uevent.c file.
- */
-typedef int __bitwise kobject_action_t;
-enum kobject_action {
-	KOBJ_ADD	= (__force kobject_action_t) 0x01,	/* add event, for hotplug */
-	KOBJ_REMOVE	= (__force kobject_action_t) 0x02,	/* remove event, for hotplug */
-	KOBJ_CHANGE	= (__force kobject_action_t) 0x03,	/* a sysfs attribute file has changed */
-	KOBJ_MOUNT	= (__force kobject_action_t) 0x04,	/* mount event for block devices */
-	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices */
-	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* offline event for hotplug devices */
-	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* online event for hotplug devices */
-};
-
-
-#ifdef CONFIG_KOBJECT_UEVENT
-int kobject_uevent(struct kobject *kobj,
-		   enum kobject_action action,
-		   struct attribute *attr);
-int kobject_uevent_atomic(struct kobject *kobj,
-			  enum kobject_action action,
-			  struct attribute *attr);
-#else
-static inline int kobject_uevent(struct kobject *kobj,
-				 enum kobject_action action,
-				 struct attribute *attr)
-{
-	return 0;
-}
-static inline int kobject_uevent_atomic(struct kobject *kobj,
-				        enum kobject_action action,
-					struct attribute *attr)
-{
-	return 0;
-}
-#endif
-
-#endif
diff --git a/init/Kconfig b/init/Kconfig
index 9fc0759..0de8b77 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -205,25 +205,6 @@ config HOTPLUG
 	  modules require HOTPLUG functionality, but a module built
 	  outside the kernel tree does. Such modules require Y here.
 
-config KOBJECT_UEVENT
-	bool "Kernel Userspace Events" if EMBEDDED
-	depends on NET
-	default y
-	help
-	  This option enables the kernel userspace event layer, which is a
-	  simple mechanism for kernel-to-user communication over a netlink
-	  socket.
-	  The goal of the kernel userspace events layer is to provide a simple
-	  and efficient events system, that notifies userspace about kobject
-	  state changes. This will enable applications to just listen for
-	  events instead of polling system devices and files.
-	  Hotplug events (kobject addition and removal) are also available on
-	  the netlink socket in addition to the execution of /sbin/hotplug if
-	  CONFIG_HOTPLUG is enabled.
-
-	  Say Y, unless you are building a system requiring minimal memory
-	  consumption.
-
 config IKCONFIG
 	bool "Kernel .config support"
 	---help---
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b53115b..6a51e25 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -31,6 +31,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/net.h>
 #include <linux/sysrq.h>
 #include <linux/highuid.h>
@@ -83,9 +84,6 @@ static int ngroups_max = NGROUPS_MAX;
 #ifdef CONFIG_KMOD
 extern char modprobe_path[];
 #endif
-#ifdef CONFIG_HOTPLUG
-extern char hotplug_path[];
-#endif
 #ifdef CONFIG_CHR_DEV_SG
 extern int sg_big_buff;
 #endif
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 3ab3754..1f90eea 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -19,14 +19,17 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/string.h>
-#include <linux/kobject_uevent.h>
 #include <linux/kobject.h>
 #include <net/sock.h>
 
 #define BUFFER_SIZE	1024	/* buffer for the hotplug env */
 #define NUM_ENVP	32	/* number of env pointers */
 
-#if defined(CONFIG_KOBJECT_UEVENT) || defined(CONFIG_HOTPLUG)
+#if defined(CONFIG_HOTPLUG)
+char hotplug_path[HOTPLUG_PATH_LEN] = "/sbin/hotplug";
+u64 hotplug_seqnum;
+static DEFINE_SPINLOCK(sequence_lock);
+
 static char *action_to_string(enum kobject_action action)
 {
 	switch (action) {
@@ -48,9 +51,7 @@ static char *action_to_string(enum kobje
 		return NULL;
 	}
 }
-#endif
 
-#ifdef CONFIG_KOBJECT_UEVENT
 static struct sock *uevent_sock;
 
 /**
@@ -168,21 +169,6 @@ static int __init kobject_uevent_init(vo
 
 postcore_initcall(kobject_uevent_init);
 
-#else
-static inline int send_uevent(const char *signal, const char *obj,
-			      char **envp, int gfp_mask)
-{
-	return 0;
-}
-
-#endif /* CONFIG_KOBJECT_UEVENT */
-
-
-#ifdef CONFIG_HOTPLUG
-char hotplug_path[HOTPLUG_PATH_LEN] = "/sbin/hotplug";
-u64 hotplug_seqnum;
-static DEFINE_SPINLOCK(sequence_lock);
-
 /**
  * kobject_hotplug - notify userspace by executing /sbin/hotplug
  *

