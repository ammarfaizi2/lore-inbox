Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268982AbUHaWON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268982AbUHaWON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269091AbUHaWMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:12:20 -0400
Received: from peabody.ximian.com ([130.57.169.10]:14014 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268982AbUHaWFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:05:53 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: greg@kroah.com, akpm@osdl.org, kay.sievers@vrfy.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040831150645.4aa8fd27.akpm@osdl.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 31 Aug 2004 18:05:24 -0400
Message-Id: <1093989924.4815.56.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 15:06 -0700, Andrew Morton wrote:

> Robert Love <rml@ximian.com> wrote:
> >
> > 	- 	len = strlen(object) + 1 + strlen(signal);
> > 	+ 	len = strlen(object) + 1 + strlen(signal) + 1;
> > 
> > should fix it, right?


Attached.

	Robert Love


Kernel Events Layer.  A simple sysfs change notifier over netlink.
Signed-Off-By: Robert Love <rml@novell.com>

 fs/super.c              |   11 ++++-
 include/linux/kevent.h  |   42 +++++++++++++++++++
 include/linux/netlink.h |    1 
 init/Kconfig            |   14 ++++++
 kernel/Makefile         |    1 
 kernel/kevent.c         |  105 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 173 insertions(+), 1 deletion(-)

diff -urN linux-2.6.9-rc1-mm2/fs/super.c linux/fs/super.c
--- linux-2.6.9-rc1-mm2/fs/super.c	2004-08-31 16:46:15.912777856 -0400
+++ linux/fs/super.c	2004-08-31 16:44:41.023203264 -0400
@@ -35,6 +35,7 @@
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
+#include <linux/kevent.h>
 #include <asm/uaccess.h>
 
 
@@ -875,8 +876,12 @@
 			up_write(&s->s_umount);
 			deactivate_super(s);
 			s = ERR_PTR(error);
-		} else
+		} else {
 			s->s_flags |= MS_ACTIVE;
+			if (bdev->bd_disk)
+				send_kevent(KEVENT_FS, NULL,
+					    &bdev->bd_disk->kobj, "mount");
+		}
 	}
 
 	return s;
@@ -891,6 +896,10 @@
 void kill_block_super(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
+
+	if (bdev->bd_disk)
+		send_kevent(KEVENT_FS, NULL, &bdev->bd_disk->kobj, "umount");
+
 	generic_shutdown_super(sb);
 	set_blocksize(bdev, sb->s_old_blocksize);
 	close_bdev_excl(bdev);
diff -urN linux-2.6.9-rc1-mm2/include/linux/kevent.h linux/include/linux/kevent.h
--- linux-2.6.9-rc1-mm2/include/linux/kevent.h	1969-12-31 19:00:00.000000000 -0500
+++ linux/include/linux/kevent.h	2004-08-31 16:21:05.706364128 -0400
@@ -0,0 +1,42 @@
+#ifndef _LINUX_KEVENT_H
+#define _LINUX_KEVENT_H
+
+#include <linux/config.h>
+#include <linux/kobject.h>
+
+/* kevent types - these are used as the multicast group */
+enum kevent {
+	KEVENT_GENERAL	=	0,
+	KEVENT_STORAGE	=	1,
+	KEVENT_POWER	=	2,
+	KEVENT_FS	= 	3,
+	KEVENT_HOTPLUG	=	4,
+};
+
+#ifdef __KERNEL__
+#ifdef CONFIG_KERNEL_EVENTS
+
+int send_kevent(enum kevent type, struct kset *kset,
+		struct kobject *kobj, const char *signal);
+
+int send_kevent_atomic(enum kevent type, struct kset *kset,
+		       struct kobject *kobj, const char *signal);
+
+#else
+
+static inline int send_kevent(enum kevent type, struct kset *kset,
+			      struct kobject *kobj, const char *signal)
+{
+	return 0;
+}
+
+static inline int send_kevent_atomic(enum kevent type, struct kset *kset,
+				     struct kobject *kobj, const char *signal)
+{
+	return 0;
+}
+
+#endif /* CONFIG_KERNEL_EVENTS */
+#endif /* __KERNEL__ */
+
+#endif	/* _LINUX_KEVENT_H */
diff -urN linux-2.6.9-rc1-mm2/include/linux/netlink.h linux/include/linux/netlink.h
--- linux-2.6.9-rc1-mm2/include/linux/netlink.h	2004-08-31 16:46:16.316716448 -0400
+++ linux/include/linux/netlink.h	2004-08-31 16:44:41.372150216 -0400
@@ -17,6 +17,7 @@
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
+#define NETLINK_KEVENT		15	/* Kernel messages to userspace */
 #define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
 
 #define MAX_LINKS 32		
diff -urN linux-2.6.9-rc1-mm2/init/Kconfig linux/init/Kconfig
--- linux-2.6.9-rc1-mm2/init/Kconfig	2004-08-31 16:46:16.454695472 -0400
+++ linux/init/Kconfig	2004-08-31 16:44:41.445139120 -0400
@@ -149,6 +149,20 @@
 	  logging of avc messages output).  Does not do system-call
 	  auditing without CONFIG_AUDITSYSCALL.
 
+config KERNEL_EVENTS
+	bool "Kernel Events Layer"
+	depends on NET
+	default y
+	help
+	  This option enables the kernel events layer, which is a simple
+	  mechanism for kernel-to-user communication over a netlink socket.
+	  The goal of the kernel events layer is to provide a simple and
+	  efficient logging, error, and events system.  Specifically, code
+	  is available to link the events into D-BUS.  Say Y, unless you
+	  are building a system requiring minimal memory consumption.
+
+	  D-BUS is available at http://dbus.freedesktop.org/
+
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
 	depends on AUDIT && (X86 || PPC64 || ARCH_S390 || IA64)
diff -urN linux-2.6.9-rc1-mm2/kernel/kevent.c linux/kernel/kevent.c
--- linux-2.6.9-rc1-mm2/kernel/kevent.c	1969-12-31 19:00:00.000000000 -0500
+++ linux/kernel/kevent.c	2004-08-31 16:20:00.280310400 -0400
@@ -0,0 +1,105 @@
+/*
+ * kernel/kevent.c - sysfs event delivery via netlink socket
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
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/socket.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/string.h>
+#include <linux/kobject.h>
+#include <linux/kevent.h>
+#include <net/sock.h>
+
+static struct sock *kevent_sock = NULL;	/* kevent's global netlink socket */
+
+/**
+ * send_kevent - send a message to user-space via the kernel events layer
+ */
+static int do_send_kevent(enum kevent type, int gfp_mask,
+			  const char *object, const char *signal)
+{
+	struct sk_buff *skb;
+	char *buffer;
+	int len;
+
+	if (!kevent_sock)
+		return -EIO;
+
+	if (!object || !signal)
+		return -EINVAL;
+
+	len = strlen(object) + 1 + strlen(signal) + 1;
+
+	skb = alloc_skb(len, gfp_mask);
+	if (!skb)
+		return -ENOMEM;
+
+	buffer = skb_put(skb, len);
+
+	sprintf(buffer, "%s\n%s", object, signal);
+
+	return netlink_broadcast(kevent_sock, skb, 0, (1 << type), gfp_mask);
+}
+
+int send_kevent(enum kevent type, struct kset *kset,
+		struct kobject *kobj, const char *signal)
+{
+	const char *path;
+	int ret;
+
+	path = kobject_get_path(kset, kobj, GFP_KERNEL);
+	if (!path)
+		return -ENOMEM;
+
+	ret =  do_send_kevent(type, GFP_KERNEL, path, signal);
+	kfree(path);
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(send_kevent);
+
+int send_kevent_atomic(enum kevent type, struct kset *kset,
+		       struct kobject *kobj, const char *signal)
+{
+	const char *path;
+	int ret;
+
+	path = kobject_get_path(kset, kobj, GFP_ATOMIC);
+	if (!path)
+		return -ENOMEM;
+
+	ret =  do_send_kevent(type, GFP_ATOMIC, path, signal);
+	kfree(path);
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(send_kevent_atomic);
+
+static int kevent_init(void)
+{
+	kevent_sock = netlink_kernel_create(NETLINK_KEVENT, NULL);
+
+	if (!kevent_sock) {
+		printk(KERN_ERR
+		       "kevent: unable to create netlink socket!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+module_init(kevent_init);
diff -urN linux-2.6.9-rc1-mm2/kernel/Makefile linux/kernel/Makefile
--- linux-2.6.9-rc1-mm2/kernel/Makefile	2004-08-31 16:46:16.471692888 -0400
+++ linux/kernel/Makefile	2004-08-31 16:45:49.025865288 -0400
@@ -27,6 +27,7 @@
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
+obj-$(CONFIG_KERNEL_EVENTS) += kevent.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is


