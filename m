Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268035AbUIJXzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268035AbUIJXzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUIJXzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:55:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:26846 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268035AbUIJXyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:54:45 -0400
Date: Fri, 10 Sep 2004 16:54:09 -0700
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>, Robert Love <rml@ximian.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040910235409.GA32424@kroah.com>
References: <20040831145643.08fdf612.akpm@osdl.org> <1093989513.4815.45.camel@betsy.boston.ximian.com> <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906020601.GA3199@vrfy.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thanks to a respin of the patch by Kay, and some further tweaks by
me to make the patch a bit smaller (and make the functions
EXPORT_SYMBOL_GPL, Robert and Kay, speak up if you don't like that
change), I've commited the following patch to my trees, and it should
show up in the next -mm release

(Andrew, you can drop your other patch in your stack that contained a
version of this.)

thanks,

greg k-h

----------------------
Subject: Kobject Userspace Event Notification
  
Implemetation of userspace events through a netlink socket. The kernel events
layer provides the functionality to raise an event from a given kobject
represented by its sysfs-path and a signal string to describe the type of
event.
  
Currently, kobject additions and removals are signalized to userspace by forking
the /sbin/hotplug helper. This patch moves this special case of userspace-event
out of the kobject core to the new kobject_uevent implementation. This makes it
possible to send all hotplug messages also through the new netlink transport.
  
Possible new users of the kernel userspace functionality are filesystem
mount events (block device claim/release) or simple device state transitions
(cpu overheating).
  
To send an event, the user needs to pass the kobject, a optional
sysfs-attribute and the signal string to the following function:
  
  kobject_uevent(const char *signal,
                 struct kobject *kobj,
                 struct attribute *attr)
  
  Example:
  kobject_uevent("overheating", &cpu->kobj, NULL);
  
The message itself is sent over multicast netlink socket, which makes
it possible for userspace to listen with multiple applications for the same
messages.
  
Signed-off-by: Robert Love <rml@novell.com>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	2004-09-10 16:45:59 -07:00
+++ b/include/linux/kobject.h	2004-09-10 16:45:59 -07:00
@@ -62,9 +62,7 @@
 extern struct kobject * kobject_get(struct kobject *);
 extern void kobject_put(struct kobject *);
 
-extern void kobject_hotplug(const char *action, struct kobject *);
-
-extern char * kobject_get_path(struct kset *, struct kobject *, int);
+extern char * kobject_get_path(struct kobject *, int);
 
 struct kobj_type {
 	void (*release)(struct kobject *);
@@ -236,6 +234,34 @@
 
 extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
 extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
+
+
+#ifdef CONFIG_HOTPLUG
+extern void kobject_hotplug(const char *action, struct kobject *kobj);
+#else
+static inline void kobject_hotplug(const char *action, struct kobject *kobj) { }
+#endif
+
+
+#ifdef CONFIG_KOBJECT_UEVENT
+extern int kobject_uevent(const char *signal, struct kobject *kobj,
+			  struct attribute *attr);
+
+extern int kobject_uevent_atomic(const char *signal, struct kobject *kobj,
+				 struct attribute *attr);
+#else
+static inline int kobject_uevent(const char *signal, struct kobject *kobj,
+				 struct attribute *attr)
+{
+	return 0;
+}
+
+static inline int kobject_uevent_atomic(const char *signal, struct kobject *kobj,
+					struct attribute *attr)
+{
+	return 0;
+}
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _KOBJECT_H_ */
diff -Nru a/include/linux/netlink.h b/include/linux/netlink.h
--- a/include/linux/netlink.h	2004-09-10 16:45:59 -07:00
+++ b/include/linux/netlink.h	2004-09-10 16:45:59 -07:00
@@ -17,6 +17,7 @@
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
+#define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
 #define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
 
 #define MAX_LINKS 32		
diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2004-09-10 16:45:59 -07:00
+++ b/init/Kconfig	2004-09-10 16:45:59 -07:00
@@ -195,6 +195,25 @@
 	  agent" (/sbin/hotplug) to load modules and set up software needed
 	  to use devices as you hotplug them.
 
+config KOBJECT_UEVENT
+	bool "Kernel Userspace Events"
+	depends on NET
+	default y
+	help
+	  This option enables the kernel userspace event layer, which is a
+	  simple mechanism for kernel-to-user communication over a netlink
+	  socket.
+	  The goal of the kernel userspace events layer is to provide a simple
+	  and efficient events system, that notifies userspace about kobject
+	  state changes. This will enable applications to just listen for
+	  events instead of polling system devices and files.
+	  Hotplug events (kobject addition and removal) are also available on
+	  the netlink socket in addition to the execution of /sbin/hotplug if
+	  CONFIG_HOTPLUG is enabled.
+
+	  Say Y, unless you are building a system requiring minimal memory
+	  consumption.
+
 config IKCONFIG
 	bool "Kernel .config support"
 	---help---
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	2004-09-10 16:45:59 -07:00
+++ b/lib/Makefile	2004-09-10 16:45:59 -07:00
@@ -6,7 +6,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
-	 bitmap.o extable.o
+	 bitmap.o extable.o kobject_uevent.o
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-09-10 16:45:59 -07:00
+++ b/lib/kobject.c	2004-09-10 16:45:59 -07:00
@@ -63,7 +63,7 @@
 	return container_of(entry,struct kobject,entry);
 }
 
-static int get_kobj_path_length(struct kset *kset, struct kobject *kobj)
+static int get_kobj_path_length(struct kobject *kobj)
 {
 	int length = 1;
 	struct kobject * parent = kobj;
@@ -79,7 +79,7 @@
 	return length;
 }
 
-static void fill_kobj_path(struct kset *kset, struct kobject *kobj, char *path, int length)
+static void fill_kobj_path(struct kobject *kobj, char *path, int length)
 {
 	struct kobject * parent;
 
@@ -99,146 +99,24 @@
  * kobject_get_path - generate and return the path associated with a given kobj
  * and kset pair.  The result must be freed by the caller with kfree().
  *
- * @kset:	kset in question, with which to build the path
  * @kobj:	kobject in question, with which to build the path
  * @gfp_mask:	the allocation type used to allocate the path
  */
-char * kobject_get_path(struct kset *kset, struct kobject *kobj, int gfp_mask)
+char *kobject_get_path(struct kobject *kobj, int gfp_mask)
 {
 	char *path;
 	int len;
 
-	len = get_kobj_path_length(kset, kobj);
+	len = get_kobj_path_length(kobj);
 	path = kmalloc(len, gfp_mask);
 	if (!path)
 		return NULL;
 	memset(path, 0x00, len);
-	fill_kobj_path(kset, kobj, path, len);
+	fill_kobj_path(kobj, path, len);
 
 	return path;
 }
 
-#ifdef CONFIG_HOTPLUG
-
-u64 hotplug_seqnum;
-#define BUFFER_SIZE	1024	/* should be enough memory for the env */
-#define NUM_ENVP	32	/* number of env pointers */
-static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
-
-static void kset_hotplug(const char *action, struct kset *kset,
-			 struct kobject *kobj)
-{
-	char *argv [3];
-	char **envp = NULL;
-	char *buffer = NULL;
-	char *scratch;
-	int i = 0;
-	int retval;
-	char *kobj_path = NULL;
-	char *name = NULL;
-	unsigned long seq;
-
-	/* If the kset has a filter operation, call it. If it returns
-	   failure, no hotplug event is required. */
-	if (kset->hotplug_ops->filter) {
-		if (!kset->hotplug_ops->filter(kset, kobj))
-			return;
-	}
-
-	pr_debug ("%s\n", __FUNCTION__);
-
-	if (!hotplug_path[0])
-		return;
-
-	envp = kmalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
-	if (!envp)
-		return;
-	memset (envp, 0x00, NUM_ENVP * sizeof (char *));
-
-	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
-	if (!buffer)
-		goto exit;
-
-	if (kset->hotplug_ops->name)
-		name = kset->hotplug_ops->name(kset, kobj);
-	if (name == NULL)
-		name = kset->kobj.name;
-
-	argv [0] = hotplug_path;
-	argv [1] = name;
-	argv [2] = NULL;
-
-	/* minimal command environment */
-	envp [i++] = "HOME=/";
-	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-
-	scratch = buffer;
-
-	envp [i++] = scratch;
-	scratch += sprintf(scratch, "ACTION=%s", action) + 1;
-
-	spin_lock(&sequence_lock);
-	seq = ++hotplug_seqnum;
-	spin_unlock(&sequence_lock);
-
-	envp [i++] = scratch;
-	scratch += sprintf(scratch, "SEQNUM=%ld", seq) + 1;
-
-	kobj_path = kobject_get_path(kset, kobj, GFP_KERNEL);
-	if (!kobj_path)
-		goto exit;
-
-	envp [i++] = scratch;
-	scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
-
-	if (kset->hotplug_ops->hotplug) {
-		/* have the kset specific function add its stuff */
-		retval = kset->hotplug_ops->hotplug (kset, kobj,
-				  &envp[i], NUM_ENVP - i, scratch,
-				  BUFFER_SIZE - (scratch - buffer));
-		if (retval) {
-			pr_debug ("%s - hotplug() returned %d\n",
-				  __FUNCTION__, retval);
-			goto exit;
-		}
-	}
-
-	pr_debug ("%s: %s %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
-		  envp[0], envp[1], envp[2], envp[3], envp[4]);
-	retval = call_usermodehelper (argv[0], argv, envp, 0);
-	if (retval)
-		pr_debug ("%s - call_usermodehelper returned %d\n",
-			  __FUNCTION__, retval);
-
-exit:
-	kfree(kobj_path);
-	kfree(buffer);
-	kfree(envp);
-	return;
-}
-
-void kobject_hotplug(const char *action, struct kobject *kobj)
-{
-	struct kobject * top_kobj = kobj;
-
-	/* If this kobj does not belong to a kset,
-	   try to find a parent that does. */
-	if (!top_kobj->kset && top_kobj->parent) {
-		do {
-			top_kobj = top_kobj->parent;
-		} while (!top_kobj->kset && top_kobj->parent);
-	}
-
-	if (top_kobj->kset && top_kobj->kset->hotplug_ops)
-		kset_hotplug(action, top_kobj->kset, kobj);
-}
-#else
-void kobject_hotplug(const char *action, struct kobject *kobj)
-{
-	return;
-}
-#endif	/* CONFIG_HOTPLUG */
-
 /**
  *	kobject_init - initialize object.
  *	@kobj:	object in question.
@@ -654,7 +532,6 @@
 EXPORT_SYMBOL(kobject_add);
 EXPORT_SYMBOL(kobject_del);
 EXPORT_SYMBOL(kobject_rename);
-EXPORT_SYMBOL(kobject_hotplug);
 
 EXPORT_SYMBOL(kset_register);
 EXPORT_SYMBOL(kset_unregister);
diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/lib/kobject_uevent.c	2004-09-10 16:45:59 -07:00
@@ -0,0 +1,264 @@
+/*
+ * kernel userspace event delivery
+ *
+ * Copyright (C) 2004 Red Hat, Inc.  All rights reserved.
+ * Copyright (C) 2004 Novell, Inc.  All rights reserved.
+ * Copyright (C) 2004 IBM, Inc. All rights reserved.
+ *
+ * Licensed under the GNU GPL v2.
+ *
+ * Authors:
+ *	Robert Love		<rml@novell.com>
+ *	Kay Sievers		<kay.sievers@vrfy.org>
+ *	Arjan van de Ven	<arjanv@redhat.com>
+ *	Greg Kroah-Hartman	<greg@kroah.com>
+ */
+
+#include <linux/spinlock.h>
+#include <linux/socket.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/string.h>
+#include <linux/kobject.h>
+#include <net/sock.h>
+
+#ifdef CONFIG_KOBJECT_UEVENT
+static struct sock *uevent_sock;
+
+/**
+ * send_uevent - notify userspace by sending event trough netlink socket
+ *
+ * @signal: signal name
+ * @obj: object path (kobject)
+ * @buf: buffer used to pass auxiliary data like the hotplug environment
+ * @buflen:
+ * gfp_mask:
+ */
+static int send_uevent(const char *signal, const char *obj, const void *buf,
+			int buflen, int gfp_mask)
+{
+	struct sk_buff *skb;
+	char *pos;
+	int len;
+
+	if (!uevent_sock)
+		return -EIO;
+
+	len = strlen(signal) + 1;
+	len += strlen(obj) + 1;
+	len += buflen;
+
+	skb = alloc_skb(len, gfp_mask);
+	if (!skb)
+		return -ENOMEM;
+
+	pos = skb_put(skb, len);
+
+	pos += sprintf(pos, "%s@%s", signal, obj) + 1;
+	memcpy(pos, buf, buflen);
+
+	return netlink_broadcast(uevent_sock, skb, 0, 1, gfp_mask);
+}
+
+static int do_kobject_uevent(const char *signal, struct kobject *kobj,
+			     struct attribute *attr, int gfp_mask)
+{
+	char *path;
+	char *attrpath;
+	int len;
+	int rc = -ENOMEM;
+
+	path = kobject_get_path(kobj, gfp_mask);
+	if (!path)
+		return -ENOMEM;
+
+	if (attr) {
+		len = strlen(path);
+		len += strlen(attr->name) + 2;
+		attrpath = kmalloc(len, gfp_mask);
+		if (!attrpath)
+			goto exit;
+		sprintf(attrpath, "%s/%s", path, attr->name);
+		rc = send_uevent(signal, attrpath, NULL, 0, gfp_mask);
+		kfree(attrpath);
+	} else {
+		rc = send_uevent(signal, path, NULL, 0, gfp_mask);
+	}
+
+exit:
+	kfree(path);
+	return rc;
+}
+
+/**
+ * kobject_uevent - notify userspace by sending event through netlink socket
+ * 
+ * @signal: signal name
+ * @kobj: struct kobject that the event is happening to
+ * @attr: optional struct attribute the event belongs to
+ */
+int kobject_uevent(const char *signal, struct kobject *kobj,
+		   struct attribute *attr)
+{
+	return do_kobject_uevent(signal, kobj, attr, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(kobject_uevent);
+
+int kobject_uevent_atomic(const char *signal, struct kobject *kobj,
+			  struct attribute *attr)
+{
+	return do_kobject_uevent(signal, kobj, attr, GFP_ATOMIC);
+}
+
+EXPORT_SYMBOL_GPL(kobject_uevent_atomic);
+
+static int __init kobject_uevent_init(void)
+{
+	uevent_sock = netlink_kernel_create(NETLINK_KOBJECT_UEVENT, NULL);
+
+	if (!uevent_sock) {
+		printk(KERN_ERR
+		       "kobject_uevent: unable to create netlink socket!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+core_initcall(kobject_uevent_init);
+
+#else
+static inline int send_uevent(const char *signal, const char *obj,
+			      const void *buf, int buflen, int gfp_mask)
+{
+	return 0;
+}
+
+#endif /* CONFIG_KOBJECT_UEVENT */
+
+
+#ifdef CONFIG_HOTPLUG
+u64 hotplug_seqnum;
+static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
+
+#define BUFFER_SIZE	1024	/* should be enough memory for the env */
+#define NUM_ENVP	32	/* number of env pointers */
+/**
+ * kobject_hotplug - notify userspace by executing /sbin/hotplug
+ *
+ * @action: action that is happening (usually "ADD" or "REMOVE")
+ * @kobj: struct kobject that the action is happening to
+ */
+void kobject_hotplug(const char *action, struct kobject *kobj)
+{
+	char *argv [3];
+	char **envp = NULL;
+	char *buffer = NULL;
+	char *scratch;
+	int i = 0;
+	int retval;
+	char *kobj_path = NULL;
+	char *name = NULL;
+	u64 seq;
+	struct kobject *top_kobj = kobj;
+	struct kset *kset;
+
+	if (!top_kobj->kset && top_kobj->parent) {
+		do {
+			top_kobj = top_kobj->parent;
+		} while (!top_kobj->kset && top_kobj->parent);
+	}
+
+	if (top_kobj->kset && top_kobj->kset->hotplug_ops)
+		kset = top_kobj->kset;
+	else
+		return;
+
+	/* If the kset has a filter operation, call it.
+	   Skip the event, if the filter returns zero. */
+	if (kset->hotplug_ops->filter) {
+		if (!kset->hotplug_ops->filter(kset, kobj))
+			return;
+	}
+
+	pr_debug ("%s\n", __FUNCTION__);
+
+	envp = kmalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
+	if (!envp)
+		return;
+	memset (envp, 0x00, NUM_ENVP * sizeof (char *));
+
+	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
+	if (!buffer)
+		goto exit;
+
+	if (kset->hotplug_ops->name)
+		name = kset->hotplug_ops->name(kset, kobj);
+	if (name == NULL)
+		name = kset->kobj.name;
+
+	argv [0] = hotplug_path;
+	argv [1] = name;
+	argv [2] = NULL;
+
+	/* minimal command environment */
+	envp [i++] = "HOME=/";
+	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+
+	scratch = buffer;
+
+	envp [i++] = scratch;
+	scratch += sprintf(scratch, "ACTION=%s", action) + 1;
+
+	kobj_path = kobject_get_path(kobj, GFP_KERNEL);
+	if (!kobj_path)
+		goto exit;
+
+	envp [i++] = scratch;
+	scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
+
+	spin_lock(&sequence_lock);
+	seq = ++hotplug_seqnum;
+	spin_unlock(&sequence_lock);
+
+	envp [i++] = scratch;
+	scratch += sprintf(scratch, "SEQNUM=%lld", seq) + 1;
+
+	envp [i++] = scratch;
+	scratch += sprintf(scratch, "SUBSYSTEM=%s", name) + 1;
+
+	if (kset->hotplug_ops->hotplug) {
+		/* have the kset specific function add its stuff */
+		retval = kset->hotplug_ops->hotplug (kset, kobj,
+				  &envp[i], NUM_ENVP - i, scratch,
+				  BUFFER_SIZE - (scratch - buffer));
+		if (retval) {
+			pr_debug ("%s - hotplug() returned %d\n",
+				  __FUNCTION__, retval);
+			goto exit;
+		}
+	}
+
+	pr_debug ("%s: %s %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
+		  envp[0], envp[1], envp[2], envp[3], envp[4]);
+
+	send_uevent(action, kobj_path, buffer, scratch - buffer, GFP_KERNEL);
+
+	if (!hotplug_path[0])
+		goto exit;
+
+	retval = call_usermodehelper (argv[0], argv, envp, 0);
+	if (retval)
+		pr_debug ("%s - call_usermodehelper returned %d\n",
+			  __FUNCTION__, retval);
+
+exit:
+	kfree(kobj_path);
+	kfree(buffer);
+	kfree(envp);
+	return;
+}
+EXPORT_SYMBOL(kobject_hotplug);
+#endif /* CONFIG_HOTPLUG */
+
+
