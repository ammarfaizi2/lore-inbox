Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUIFCGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUIFCGi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 22:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUIFCGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 22:06:38 -0400
Received: from soundwarez.org ([217.160.171.123]:33249 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S267397AbUIFCFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 22:05:49 -0400
Date: Mon, 6 Sep 2004 04:06:01 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Robert Love <rml@ximian.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040906020601.GA3199@vrfy.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com> <20040831145643.08fdf612.akpm@osdl.org> <1093989513.4815.45.camel@betsy.boston.ximian.com> <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20040905121814.GA1855@vrfy.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 05, 2004 at 02:18:14PM +0200, Kay Sievers wrote:
> On Sat, Sep 04, 2004 at 10:58:08PM -0400, Robert Love wrote:
> > On Sat, 2004-09-04 at 02:54 +0200, Greg KH wrote:
> > 
> > > So, we're back to the original issue.  Why is this kernel event system
> > > different from the hotplug system?  I would argue there isn't one,
> > > becides the transport, as you seem to want everything that we currently
> > > provide in the current kobject_hotplug() call.
> > > 
> > > But transports are important, I agree.
> > > 
> > > How about you just add the ability to send hotplug calls across netlink?
> > > Make it so the kobject_hotplug() function does both the exec() call, and
> > > a netlink call (based on a config option for those people who like to
> > > configure such stuff.)
> > 
> > This smells.
> > 
> > Look, I agree that unifying the two ideas and transports as much as
> > possible is the right way to proceed.  But the fact is, as you said,
> > transports _are_ important.  And simply always sending out a hotplug
> > event _and_ a netlink event is silly and superfluous.  We need to make
> > up our minds.
> > 
> > I don't think anyone argues that netlink makes sense for these low
> > priority asynchronous events.
> > 
> > I'd prefer to integrate the two approaches as much as possible, but keep
> > the two transports separate.  Use hotplug for hotplug events as we do
> > now and use kevent, which is over netlink, for the new events we want to
> > add.
> > 
> > Maybe always do the kevent from the hotplug, but definitely do not do
> > the hotplug from all kevents.  It is redundant and extra overhead.
> > 
> > Doing both simultaneous begs the question of why have both.  Picking the
> > right tool for the job is, well, the right tool for the job.
> 
> Yes, it doesn't make much sense to pipe the kevents through
> /sbin/hotplug, but I definitely want the hotplug-events over netlink,
> to get rid of the SEQNUM reorder nightmare and unpredictable delay of
> the execution of the /etc/hotplug.d/ helpers, we currently can't handle
> very well with HAL.
> 
> I expect, that we need to have both transports (for hotplug), cause early
> boot is unable to react to netlink messages.
> The /sbin/hotplug can easily switched off, after some "advanced event daemon"
> is running by: "echo -n "" > /proc/sys/kernel/hotplug".
> 
> What about moving the /sbin/hotplug execution from lib/kobject.c to
> kernel/kobj_notify.c and merge it with our netlink code? This would
> separate the "object-storage" from the "object-notification" which is
> nice. And we would have a single place to implement all kind of event
> transports.
> If anybody invents some other kind of transport it can go into
> kobj_notify.c. All transports can share some code and are highly
> configurable then.

I tried it! Here is a version that moves kobject_hotplug() event out of the
kobject core to the new "userspace event"-file kernel/kobject_uevent.c.

The /sbin/hotplug message is now just a special kind of userspace notification.
All hotplug messages are also send over netlink, with the whole hotplug
environment attached to the message. It looks like this on the wire:

  recv(3, "add@/class/input/mouse2\0ACTION=add\0DEVPATH=/class/input/mouse2\0SEQNUM=768\0SUBSYSTEM=input\0", 1024, 0) = 90

All other events like the filesystem device claim/release are only sent
through the netlink interface by kobject_uevent().

Thanks,
Kay


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="kuevents-01.patch"

diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	2004-09-06 03:47:59 +02:00
+++ b/fs/super.c	2004-09-06 03:47:59 +02:00
@@ -35,6 +35,7 @@
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
+#include <linux/kobject_uevent.h>
 #include <asm/uaccess.h>
 
 
@@ -633,6 +634,16 @@
 	return (void *)s->s_bdev == data;
 }
 
+static void bdev_claim_uevent(const char *action, struct block_device *bdev)
+{
+	if (bdev->bd_disk) {
+		if (bdev->bd_part)
+			kobject_uevent(action, &bdev->bd_part->kobj, NULL);
+		else
+			kobject_uevent(action, &bdev->bd_disk->kobj, NULL);
+	}
+}
+
 struct super_block *get_sb_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
@@ -675,8 +686,10 @@
 			up_write(&s->s_umount);
 			deactivate_super(s);
 			s = ERR_PTR(error);
-		} else
+		} else {
 			s->s_flags |= MS_ACTIVE;
+			bdev_claim_uevent("claim", bdev);
+		}
 	}
 
 	return s;
@@ -691,6 +704,8 @@
 void kill_block_super(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
+
+	bdev_claim_uevent("release", bdev);
 	generic_shutdown_super(sb);
 	set_blocksize(bdev, sb->s_old_blocksize);
 	close_bdev_excl(bdev);
diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	2004-09-06 03:47:59 +02:00
+++ b/include/linux/kobject.h	2004-09-06 03:47:59 +02:00
@@ -61,7 +61,7 @@
 
 extern void kobject_hotplug(const char *action, struct kobject *);
 
-extern char * kobject_get_path(struct kset *, struct kobject *, int);
+extern char * kobject_get_path(struct kobject *, int);
 
 struct kobj_type {
 	void (*release)(struct kobject *);
diff -Nru a/include/linux/kobject_uevent.h b/include/linux/kobject_uevent.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/kobject_uevent.h	2004-09-06 03:47:59 +02:00
@@ -0,0 +1,39 @@
+#ifndef _KOBJECT_UEVENT_H_
+#define _KOBJECT_UEVENT_H_
+
+#ifdef __KERNEL__
+
+#ifdef CONFIG_HOTPLUG
+/* counter to tag the hotplug event, read only except for the kobject uevent */
+extern u64 hotplug_seqnum;
+extern void kobject_hotplug(const char *action, struct kobject *kobj);
+#else
+static inline void kobject_hotplug(const char *action, struct kobject *kobj)
+{
+	return;
+}
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
+
+#endif /* __KERNEL__ */
+#endif /* _KOBJECT_UEVENT_H_ */
diff -Nru a/include/linux/netlink.h b/include/linux/netlink.h
--- a/include/linux/netlink.h	2004-09-06 03:47:59 +02:00
+++ b/include/linux/netlink.h	2004-09-06 03:47:59 +02:00
@@ -17,6 +17,7 @@
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
+#define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
 #define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
 
 #define MAX_LINKS 32		
diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2004-09-06 03:47:59 +02:00
+++ b/init/Kconfig	2004-09-06 03:47:59 +02:00
@@ -195,6 +195,22 @@
 	  agent" (/sbin/hotplug) to load modules and set up software needed
 	  to use devices as you hotplug them.
 
+config KOBJECT_UEVENT
+	bool "Kernel Userspace Events"
+	depends on NET && HOTPLUG
+	default y
+	help
+	  This option enables the kernel userspace events layer, which is a
+	  simple mechanism for kernel-to-user communication over a netlink
+	  socket.
+	  The goal of the kernel userspace events layer is to provide a simple
+	  and efficient events system, that notifies userspace about kobject
+	  state changes e.g. hotplug events, power state transitions or block
+	  device claiming (mount/unmount).
+
+	  Say Y, unless you are building a system requiring minimal memory
+	  consumption.
+
 config IKCONFIG
 	bool "Kernel .config support"
 	---help---
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2004-09-06 03:47:59 +02:00
+++ b/kernel/Makefile	2004-09-06 03:47:59 +02:00
@@ -24,6 +24,7 @@
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
+obj-$(CONFIG_HOTPLUG) += kobject_uevent.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Nru a/kernel/kobject_uevent.c b/kernel/kobject_uevent.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/kobject_uevent.c	2004-09-06 03:47:59 +02:00
@@ -0,0 +1,233 @@
+/*
+ * kernel/kobj_uevent.c - kernel userspace event delivery
+ *
+ * Copyright (C) 2004 Red Hat, Inc.  All rights reserved.
+ * Copyright (C) 2004 Novell, Inc.  All rights reserved.
+ *
+ * Licensed under the GNU GPL v2.
+ *
+ * Authors:
+ *	Robert Love		<rml@novell.com>
+ *	Kay Sievers		<kay.sievers@vrfy.org>
+ *	Arjan van de Ven	<arjanv@redhat.com>
+ */
+
+#include <linux/spinlock.h>
+#include <linux/socket.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/string.h>
+#include <linux/kobject.h>
+#include <linux/kobject_uevent.h>
+#include <net/sock.h>
+
+#ifdef CONFIG_HOTPLUG
+u64 hotplug_seqnum;
+static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
+#ifdef CONFIG_KOBJECT_UEVENT
+static struct sock *uevent_sock = NULL;
+#endif
+
+static int send_uevent(const char *signal, const char *obj,
+		       const void *buf, int buflen, int gfp_mask)
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
+int kobject_uevent(const char *signal, struct kobject *kobj,
+		   struct attribute *attr)
+{
+	return do_kobject_uevent(signal, kobj, attr, GFP_KERNEL);
+}
+
+EXPORT_SYMBOL(kobject_uevent);
+
+int kobject_uevent_atomic(const char *signal, struct kobject *kobj,
+			  struct attribute *attr)
+{
+	return do_kobject_uevent(signal, kobj, attr, GFP_ATOMIC);
+}
+
+EXPORT_SYMBOL(kobject_uevent_atomic);
+
+
+#define BUFFER_SIZE	1024	/* should be enough memory for the env */
+#define NUM_ENVP	32	/* number of env pointers */
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
+	struct kobject * top_kobj = kobj;
+	struct kset * kset;
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
+	spin_lock(&sequence_lock);
+	seq = ++hotplug_seqnum;
+	spin_unlock(&sequence_lock);
+
+	kobj_path = kobject_get_path(kobj, GFP_KERNEL);
+	if (!kobj_path)
+		goto exit;
+
+	envp [i++] = scratch;
+	scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
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
+
+EXPORT_SYMBOL(kobject_hotplug);
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
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-09-06 03:47:59 +02:00
+++ b/lib/kobject.c	2004-09-06 03:47:59 +02:00
@@ -13,6 +13,7 @@
 #undef DEBUG
 
 #include <linux/kobject.h>
+#include <linux/kobject_uevent.h>
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/stat.h>
@@ -63,7 +64,7 @@
 	return container_of(entry,struct kobject,entry);
 }
 
-static int get_kobj_path_length(struct kset *kset, struct kobject *kobj)
+static int get_kobj_path_length(struct kobject *kobj)
 {
 	int length = 1;
 	struct kobject * parent = kobj;
@@ -79,7 +80,7 @@
 	return length;
 }
 
-static void fill_kobj_path(struct kset *kset, struct kobject *kobj, char *path, int length)
+static void fill_kobj_path(struct kobject *kobj, char *path, int length)
 {
 	struct kobject * parent;
 
@@ -103,146 +104,21 @@
  * @kobj:	kobject in question, with which to build the path
  * @gfp_mask:	the allocation type used to allocate the path
  */
-char * kobject_get_path(struct kset *kset, struct kobject *kobj, int gfp_mask)
+char * kobject_get_path(struct kobject *kobj, int gfp_mask)
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
-#define BUFFER_SIZE	1024	/* should be enough memory for the env */
-#define NUM_ENVP	32	/* number of env pointers */
-static unsigned long sequence_num;
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
-	seq = sequence_num++;
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
-/**
- *	kobject_init - initialize object.
- *	@kobj:	object in question.
- */
 void kobject_init(struct kobject * kobj)
 {
  	kref_init(&kobj->kref);
@@ -654,7 +530,6 @@
 EXPORT_SYMBOL(kobject_add);
 EXPORT_SYMBOL(kobject_del);
 EXPORT_SYMBOL(kobject_rename);
-EXPORT_SYMBOL(kobject_hotplug);
 
 EXPORT_SYMBOL(kset_register);
 EXPORT_SYMBOL(kset_unregister);

--+QahgC5+KEYLbs62--
