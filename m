Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269608AbUJSSPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269608AbUJSSPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269786AbUJSQ4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:56:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:49092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269775AbUJSQin convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:43 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037753073@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:18 -0700
Message-Id: <10982037783139@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1867.3.4, 2004/09/15 11:36:09-07:00, greg@kroah.com

kevent: standardize on the event types

This prevents any potential typos from happening.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/firmware_class.c  |    2 -
 include/linux/kobject.h        |   27 ++--------------------
 include/linux/kobject_uevent.h |   50 +++++++++++++++++++++++++++++++++++++++++
 lib/kobject.c                  |    4 +--
 lib/kobject_uevent.c           |   46 +++++++++++++++++++++++++++++++------
 5 files changed, 94 insertions(+), 35 deletions(-)


diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c	2004-10-19 09:22:44 -07:00
+++ b/drivers/base/firmware_class.c	2004-10-19 09:22:44 -07:00
@@ -420,7 +420,7 @@
 		add_timer(&fw_priv->timeout);
 	}
 
-	kobject_hotplug("add", &class_dev->kobj);
+	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
 	wait_for_completion(&fw_priv->completion);
 	set_bit(FW_STATUS_DONE, &fw_priv->status);
 
diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	2004-10-19 09:22:44 -07:00
+++ b/include/linux/kobject.h	2004-10-19 09:22:44 -07:00
@@ -22,6 +22,7 @@
 #include <linux/sysfs.h>
 #include <linux/rwsem.h>
 #include <linux/kref.h>
+#include <linux/kobject_uevent.h>
 #include <asm/atomic.h>
 
 #define KOBJ_NAME_LEN	20
@@ -235,32 +236,10 @@
 extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
 extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
 
-
 #ifdef CONFIG_HOTPLUG
-extern void kobject_hotplug(const char *action, struct kobject *kobj);
-#else
-static inline void kobject_hotplug(const char *action, struct kobject *kobj) { }
-#endif
-
-
-#ifdef CONFIG_KOBJECT_UEVENT
-extern int kobject_uevent(const char *signal, struct kobject *kobj,
-			  struct attribute *attr);
-
-extern int kobject_uevent_atomic(const char *signal, struct kobject *kobj,
-				 struct attribute *attr);
+extern void kobject_hotplug(struct kobject *kobj, enum kobject_action action);
 #else
-static inline int kobject_uevent(const char *signal, struct kobject *kobj,
-				 struct attribute *attr)
-{
-	return 0;
-}
-
-static inline int kobject_uevent_atomic(const char *signal, struct kobject *kobj,
-					struct attribute *attr)
-{
-	return 0;
-}
+static inline void kobject_hotplug(struct kobject *kobj, enum kobject_action action) { }
 #endif
 
 #endif /* __KERNEL__ */
diff -Nru a/include/linux/kobject_uevent.h b/include/linux/kobject_uevent.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/kobject_uevent.h	2004-10-19 09:22:44 -07:00
@@ -0,0 +1,50 @@
+/*
+ * kobject_uevent.h - list of kobject user events that can be generated
+ *
+ * Copyright (C) 2004 IBM Corp.
+ * Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ *
+ * This file is released under the GPLv2.
+ *
+ */
+
+#ifndef _KOBJECT_EVENT_H_
+#define _KOBJECT_EVENT_H_
+
+/*
+ * If you add an action here, you must also add the proper string to the
+ * lib/kobject_uevent.c file.
+ */
+
+enum kobject_action {
+	KOBJ_ADD	= 0x00,	/* add event, for hotplug */
+	KOBJ_REMOVE	= 0x01,	/* remove event, for hotplug */
+	KOBJ_CHANGE	= 0x02,	/* a sysfs attribute file has changed */
+	KOBJ_MOUNT	= 0x03,	/* mount event for block devices */
+	KOBJ_MAX_ACTION,	/* must be last action listed */
+};
+
+
+#ifdef CONFIG_KOBJECT_UEVENT
+int kobject_uevent(struct kobject *kobj,
+		   enum kobject_action action,
+		   struct attribute *attr);
+int kobject_uevent_atomic(struct kobject *kobj,
+			  enum kobject_action action,
+			  struct attribute *attr);
+#else
+static inline int kobject_uevent(struct kobject *kobj,
+				 enum kobject_action action,
+				 struct attribute *attr)
+{
+	return 0;
+}
+static inline int kobject_uevent_atomic(struct kobject *kobj,
+				        enum kobject_action action,
+					struct attribute *attr)
+{
+	return 0;
+}
+#endif
+
+#endif
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-10-19 09:22:44 -07:00
+++ b/lib/kobject.c	2004-10-19 09:22:44 -07:00
@@ -186,7 +186,7 @@
 		if (parent)
 			kobject_put(parent);
 	} else {
-		kobject_hotplug("add", kobj);
+		kobject_hotplug(kobj, KOBJ_ADD);
 	}
 
 	return error;
@@ -300,7 +300,7 @@
 
 void kobject_del(struct kobject * kobj)
 {
-	kobject_hotplug("remove", kobj);
+	kobject_hotplug(kobj, KOBJ_REMOVE);
 	sysfs_remove_dir(kobj);
 	unlink(kobj);
 }
diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-10-19 09:22:44 -07:00
+++ b/lib/kobject_uevent.c	2004-10-19 09:22:44 -07:00
@@ -19,9 +19,29 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/string.h>
+#include <linux/kobject_uevent.h>
 #include <linux/kobject.h>
 #include <net/sock.h>
 
+/* 
+ * These must match up with the values for enum kobject_action
+ * as found in include/linux/kobject_uevent.h
+ */
+static char *actions[] = {
+	"add",		/* 0x00 */
+	"remove",	/* 0x01 */
+	"change",	/* 0x02 */
+	"mount",	/* 0x03 */
+};
+
+static char *action_to_string(enum kobject_action action)
+{
+	if (action >= KOBJ_MAX_ACTION)
+		return NULL;
+	else
+		return actions[action];
+}
+
 #ifdef CONFIG_KOBJECT_UEVENT
 static struct sock *uevent_sock;
 
@@ -60,11 +80,12 @@
 	return netlink_broadcast(uevent_sock, skb, 0, 1, gfp_mask);
 }
 
-static int do_kobject_uevent(const char *signal, struct kobject *kobj,
+static int do_kobject_uevent(struct kobject *kobj, enum kobject_action action, 
 			     struct attribute *attr, int gfp_mask)
 {
 	char *path;
 	char *attrpath;
+	char *signal;
 	int len;
 	int rc = -ENOMEM;
 
@@ -72,6 +93,10 @@
 	if (!path)
 		return -ENOMEM;
 
+	signal = action_to_string(action);
+	if (!signal)
+		return -EINVAL;
+
 	if (attr) {
 		len = strlen(path);
 		len += strlen(attr->name) + 2;
@@ -97,17 +122,17 @@
  * @kobj: struct kobject that the event is happening to
  * @attr: optional struct attribute the event belongs to
  */
-int kobject_uevent(const char *signal, struct kobject *kobj,
+int kobject_uevent(struct kobject *kobj, enum kobject_action action,
 		   struct attribute *attr)
 {
-	return do_kobject_uevent(signal, kobj, attr, GFP_KERNEL);
+	return do_kobject_uevent(kobj, action, attr, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(kobject_uevent);
 
-int kobject_uevent_atomic(const char *signal, struct kobject *kobj,
+int kobject_uevent_atomic(struct kobject *kobj, enum kobject_action action,
 			  struct attribute *attr)
 {
-	return do_kobject_uevent(signal, kobj, attr, GFP_ATOMIC);
+	return do_kobject_uevent(kobj, action, attr, GFP_ATOMIC);
 }
 
 EXPORT_SYMBOL_GPL(kobject_uevent_atomic);
@@ -149,7 +174,7 @@
  * @action: action that is happening (usually "ADD" or "REMOVE")
  * @kobj: struct kobject that the action is happening to
  */
-void kobject_hotplug(const char *action, struct kobject *kobj)
+void kobject_hotplug(struct kobject *kobj, enum kobject_action action)
 {
 	char *argv [3];
 	char **envp = NULL;
@@ -159,6 +184,7 @@
 	int retval;
 	char *kobj_path = NULL;
 	char *name = NULL;
+	char *action_string;
 	u64 seq;
 	struct kobject *top_kobj = kobj;
 	struct kset *kset;
@@ -183,6 +209,10 @@
 
 	pr_debug ("%s\n", __FUNCTION__);
 
+	action_string = action_to_string(action);
+	if (!action_string)
+		return;
+
 	envp = kmalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
 	if (!envp)
 		return;
@@ -208,7 +238,7 @@
 	scratch = buffer;
 
 	envp [i++] = scratch;
-	scratch += sprintf(scratch, "ACTION=%s", action) + 1;
+	scratch += sprintf(scratch, "ACTION=%s", action_string) + 1;
 
 	kobj_path = kobject_get_path(kobj, GFP_KERNEL);
 	if (!kobj_path)
@@ -242,7 +272,7 @@
 	pr_debug ("%s: %s %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
 		  envp[0], envp[1], envp[2], envp[3], envp[4]);
 
-	send_uevent(action, kobj_path, buffer, scratch - buffer, GFP_KERNEL);
+	send_uevent(action_string, kobj_path, buffer, scratch - buffer, GFP_KERNEL);
 
 	if (!hotplug_path[0])
 		goto exit;

