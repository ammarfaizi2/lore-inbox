Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUIOULe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUIOULe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUIOUKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:10:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:17297 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267350AbUIOUHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:07:08 -0400
Date: Wed, 15 Sep 2004 12:40:18 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@ximian.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915194018.GC24131@kroah.com>
References: <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost> <20040915034455.GB30747@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915034455.GB30747@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:44:55PM -0700, Greg KH wrote:
> On Tue, Sep 14, 2004 at 09:19:27PM -0400, Robert Love wrote:
> > On Tue, 2004-09-14 at 17:07 -0700, Greg KH wrote:
> > 
> > > I don't know, the firmware objects already use "add" for an event.  I
> > > didn't put a check in the kobject_uevent() calls to prevent the add and
> > > remove, but now it's a lot easier to do so if you think it's necessary.
> > 
> > I have no problem with this, either, so long as we are not too anal or
> > strict about adding new actions.
> 
> That's fine.  I'll dump them into a separate header file to make it a
> bit easier to find and add new ones to.

And here's the patch I applied to my trees and will show up in the next
-mm release.

I'll go convert Kay's mount patch to the new interface and add it too.

(and yes, I've added a "change" event that drivers and such can use to
tell userspace they they need to go look at a specific sysfs file.  I
figured that this was going to be the next action request so I might as
well add it now...)

thanks,

greg k-h

-----

kevent: standardize on the event types

This prevents any potential typos from happening.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c	2004-09-15 11:52:49 -07:00
+++ b/drivers/base/firmware_class.c	2004-09-15 11:52:49 -07:00
@@ -420,7 +420,7 @@
 		add_timer(&fw_priv->timeout);
 	}
 
-	kobject_hotplug("add", &class_dev->kobj);
+	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
 	wait_for_completion(&fw_priv->completion);
 	set_bit(FW_STATUS_DONE, &fw_priv->status);
 
diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	2004-09-15 11:52:49 -07:00
+++ b/include/linux/kobject.h	2004-09-15 11:52:49 -07:00
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
+++ b/include/linux/kobject_uevent.h	2004-09-15 11:52:49 -07:00
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
--- a/lib/kobject.c	2004-09-15 11:52:49 -07:00
+++ b/lib/kobject.c	2004-09-15 11:52:49 -07:00
@@ -185,7 +185,7 @@
 		if (parent)
 			kobject_put(parent);
 	} else {
-		kobject_hotplug("add", kobj);
+		kobject_hotplug(kobj, KOBJ_ADD);
 	}
 
 	return error;
@@ -299,7 +299,7 @@
 
 void kobject_del(struct kobject * kobj)
 {
-	kobject_hotplug("remove", kobj);
+	kobject_hotplug(kobj, KOBJ_REMOVE);
 	sysfs_remove_dir(kobj);
 	unlink(kobj);
 }
diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c	2004-09-15 11:52:49 -07:00
+++ b/lib/kobject_uevent.c	2004-09-15 11:52:49 -07:00
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
