Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUIOAIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUIOAIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 20:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUIOAIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 20:08:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:20965 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266741AbUIOAIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 20:08:30 -0400
Date: Tue, 14 Sep 2004 17:07:53 -0700
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Robert Love <rml@ximian.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915000753.GA24125@kroah.com>
References: <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913144553.GA10620@vrfy.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 04:45:53PM +0200, Kay Sievers wrote:
> On Sat, Sep 11, 2004 at 09:53:00AM -0700, Greg KH wrote:
> > On Sat, Sep 11, 2004 at 12:09:35AM -0400, Robert Love wrote:
> > > > +/**
> > > > + * send_uevent - notify userspace by sending event trough netlink socket
> > > 
> > > s/trough/through/ ;-)
> > 
> > Heh, give something for the "spelling nit-pickers" to submit a patch
> > against :)
> > 
> > > We should probably add at least _some_ user.  The filesystem mount
> > > events are good, since we want to add those to HAL.
> > 
> > True, anyone want to send me a patch with a user of this?
> 
> Do we agree on the model that the signal is a simple verb and we keep
> only a small dictionary of _static_ signal strings and no fancy compositions?

I agree with this.  And because of that, we should enforce that, and
help prevent typos in the signals.  So, here's a patch that does just
that, making it a lot harder to mess up (although you still can, as
enumerated types aren't checked by the compiler...)  This patch booted
on my test box.

Anyone object to me adding this patch?  If not, I'll fix up Kay's patch
for mounting to use this interface and add both of them.

> And we should reserve the "add" and "remove" only for the hotplug events.

I don't know, the firmware objects already use "add" for an event.  I
didn't put a check in the kobject_uevent() calls to prevent the add and
remove, but now it's a lot easier to do so if you think it's necessary.

thanks,

greg k-h

-----------

kevent: force users to use a type, not a string to help prevent typos
and so that we all can keep track of the different event types much
easier.


===== drivers/base/firmware_class.c 1.13 vs edited =====
--- 1.13/drivers/base/firmware_class.c	2004-09-13 09:46:22 -07:00
+++ edited/drivers/base/firmware_class.c	2004-09-14 16:33:20 -07:00
@@ -420,7 +420,7 @@
 		add_timer(&fw_priv->timeout);
 	}
 
-	kobject_hotplug("add", &class_dev->kobj);
+	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
 	wait_for_completion(&fw_priv->completion);
 	set_bit(FW_STATUS_DONE, &fw_priv->status);
 
===== include/linux/kobject.h 1.30 vs edited =====
--- 1.30/include/linux/kobject.h	2004-09-13 12:58:51 -07:00
+++ edited/include/linux/kobject.h	2004-09-14 16:24:00 -07:00
@@ -236,27 +236,33 @@
 extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
 
 
+enum kobject_action {
+	KOBJ_ADD	= 0x00,
+	KOBJ_REMOVE	= 0x01,
+	KOBJ_MAX_ACTION,
+};
+
 #ifdef CONFIG_HOTPLUG
-extern void kobject_hotplug(const char *action, struct kobject *kobj);
+extern void kobject_hotplug(struct kobject *kobj, enum kobject_action action);
 #else
-static inline void kobject_hotplug(const char *action, struct kobject *kobj) { }
+static inline void kobject_hotplug(struct kobject *kobj, enum kobject_action action) { }
 #endif
 
 
 #ifdef CONFIG_KOBJECT_UEVENT
-extern int kobject_uevent(const char *signal, struct kobject *kobj,
+extern int kobject_uevent(struct kobject *kobj, enum kobject_action action,
 			  struct attribute *attr);
 
-extern int kobject_uevent_atomic(const char *signal, struct kobject *kobj,
+extern int kobject_uevent_atomic(struct kobject *kobj, enum kobject_action action,
 				 struct attribute *attr);
 #else
-static inline int kobject_uevent(const char *signal, struct kobject *kobj,
+static inline int kobject_uevent(struct kobject *kobj, enum kobject_action action,
 				 struct attribute *attr)
 {
 	return 0;
 }
 
-static inline int kobject_uevent_atomic(const char *signal, struct kobject *kobj,
+static inline int kobject_uevent_atomic(struct kobject *kobj, enum kobject_action action,
 					struct attribute *attr)
 {
 	return 0;
===== lib/kobject.c 1.55 vs edited =====
--- 1.55/lib/kobject.c	2004-09-13 09:54:04 -07:00
+++ edited/lib/kobject.c	2004-09-14 16:20:21 -07:00
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
===== lib/kobject_uevent.c 1.2 vs edited =====
--- 1.2/lib/kobject_uevent.c	2004-09-11 18:50:05 -07:00
+++ edited/lib/kobject_uevent.c	2004-09-14 16:28:21 -07:00
@@ -22,6 +22,20 @@
 #include <linux/kobject.h>
 #include <net/sock.h>
 
+/* these match up with the values for enum kobject_action */
+static char *actions[] = {
+	"add",		/* 0x00 */
+	"remove",	/* 0x01 */
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
 
@@ -60,11 +74,12 @@
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
 
@@ -72,6 +87,10 @@
 	if (!path)
 		return -ENOMEM;
 
+	signal = action_to_string(action);
+	if (!signal)
+		return -EINVAL;
+
 	if (attr) {
 		len = strlen(path);
 		len += strlen(attr->name) + 2;
@@ -97,17 +116,17 @@
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
@@ -149,7 +168,7 @@
  * @action: action that is happening (usually "ADD" or "REMOVE")
  * @kobj: struct kobject that the action is happening to
  */
-void kobject_hotplug(const char *action, struct kobject *kobj)
+void kobject_hotplug(struct kobject *kobj, enum kobject_action action)
 {
 	char *argv [3];
 	char **envp = NULL;
@@ -159,6 +178,7 @@
 	int retval;
 	char *kobj_path = NULL;
 	char *name = NULL;
+	char *action_string;
 	u64 seq;
 	struct kobject *top_kobj = kobj;
 	struct kset *kset;
@@ -183,6 +203,10 @@
 
 	pr_debug ("%s\n", __FUNCTION__);
 
+	action_string = action_to_string(action);
+	if (!action_string)
+		return;
+
 	envp = kmalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
 	if (!envp)
 		return;
@@ -208,7 +232,7 @@
 	scratch = buffer;
 
 	envp [i++] = scratch;
-	scratch += sprintf(scratch, "ACTION=%s", action) + 1;
+	scratch += sprintf(scratch, "ACTION=%s", action_string) + 1;
 
 	kobj_path = kobject_get_path(kobj, GFP_KERNEL);
 	if (!kobj_path)
@@ -242,7 +266,7 @@
 	pr_debug ("%s: %s %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
 		  envp[0], envp[1], envp[2], envp[3], envp[4]);
 
-	send_uevent(action, kobj_path, buffer, scratch - buffer, GFP_KERNEL);
+	send_uevent(action_string, kobj_path, buffer, scratch - buffer, GFP_KERNEL);
 
 	if (!hotplug_path[0])
 		goto exit;
