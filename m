Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUIECS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUIECS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 22:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUIECS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 22:18:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:62686 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265930AbUIECSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 22:18:44 -0400
Date: Sun, 5 Sep 2004 04:18:30 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Robert Love <rml@ximian.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040905021830.GA534@vrfy.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com> <20040831145643.08fdf612.akpm@osdl.org> <1093989513.4815.45.camel@betsy.boston.ximian.com> <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20040904005433.GA18229@kroah.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 04, 2004 at 02:54:33AM +0200, Greg KH wrote:
> 
> How about you just add the ability to send hotplug calls across netlink?
> Make it so the kobject_hotplug() function does both the exec() call, and
> a netlink call (based on a config option for those people who like to
> configure such stuff.)
> 
> That way, programs who want to listen to netlink messages to get hotplug
> events do so, and so does programs who want to do the /etc/hotplug.d/
> type of notification?
> 
> Oh, and attributes.  How about we just change kobject_hotplug() to be:
> 	int kobject_hotplug(const char *action, struct kobject *kobj, struct attribute *attr);
> and if we set attr to be a valid pointer, we make the DEVPATH paramater
> contain the attribute name at the end of it.

If we add this to the kobject_hotplug function, how do we prevent the
execution of /sbin/hotplug for ksets that have positive hotplug filters?
So I've created a new function for now:
  int kobj_notify(const char *signal, struct kobject *kobj, struct attribute *attr)

which can be used from the subsystems. This function is also called for
the normal /sbin/hotplug event. (The subsystems may provide a additional
environment for the /sbin/hotplug events, this is ignored by now.)

Here is the debug output of a simple listener, while inserting a
USB-memory-stick, mounting, unmounting and removing it:

  [root@pim kdbusd]# ./kdbusd
  main: [1094349091] 'add' from '/org/kernel/devices/pci0000:00/0000:00:1d.1/usb3/3-1'
  main: [1094349091] 'add' from '/org/kernel/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0'
  main: [1094349091] 'add' from '/org/kernel/class/scsi_host/host2'
  main: [1094349091] 'add' from '/org/kernel/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/host2/2:0:0:0'
  main: [1094349091] 'add' from '/org/kernel/block/sda'
  main: [1094349091] 'add' from '/org/kernel/class/scsi_device/2:0:0:0'
  main: [1094349091] 'add' from '/org/kernel/class/scsi_generic/sg0'
  main: [1094349092] 'add' from '/org/kernel/block/sda/sda1'

  main: [1094349094] 'claim' from '/org/kernel/block/sda/sda1'
  main: [1094349101] 'release' from '/org/kernel/block/sda/sda1'

  main: [1094349106] 'remove' from '/org/kernel/class/scsi_generic/sg0'
  main: [1094349106] 'remove' from '/org/kernel/class/scsi_device/2:0:0:0'
  main: [1094349106] 'remove' from '/org/kernel/block/sda/sda1'
  main: [1094349106] 'remove' from '/org/kernel/block/sda'
  main: [1094349106] 'remove' from '/org/kernel/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/host2/2:0:0:0'
  main: [1094349106] 'remove' from '/org/kernel/class/scsi_host/host2'
  main: [1094349106] 'remove' from '/org/kernel/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0'
  main: [1094349106] 'remove' from '/org/kernel/devices/pci0000:00/0000:00:1d.1/usb3/3-1'

Thanks,
Kay

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="knotify-07.patch"

diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	2004-09-05 03:54:23 +02:00
+++ b/fs/super.c	2004-09-05 03:54:23 +02:00
@@ -35,6 +35,7 @@
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
+#include <linux/kobj_notify.h>
 #include <asm/uaccess.h>
 
 
@@ -633,6 +634,16 @@
 	return (void *)s->s_bdev == data;
 }
 
+static void notify_device_claim(const char *action, struct block_device *bdev)
+{
+	if (bdev->bd_disk) {
+		if (bdev->bd_part)
+			kobj_notify(action, &bdev->bd_part->kobj, NULL);
+		else
+			kobj_notify(action, &bdev->bd_disk->kobj, NULL);
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
+			notify_device_claim("claim", bdev);
+		}
 	}
 
 	return s;
@@ -691,6 +704,8 @@
 void kill_block_super(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
+
+	notify_device_claim("release", bdev);
 	generic_shutdown_super(sb);
 	set_blocksize(bdev, sb->s_old_blocksize);
 	close_bdev_excl(bdev);
@@ -717,6 +732,7 @@
 		return ERR_PTR(error);
 	}
 	s->s_flags |= MS_ACTIVE;
+
 	return s;
 }
 
diff -Nru a/include/linux/kobj_notify.h b/include/linux/kobj_notify.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/kobj_notify.h	2004-09-05 03:54:23 +02:00
@@ -0,0 +1,31 @@
+#ifndef _KOBJ_NOTIFY_H_
+#define _KOBJ_NOTIFY_H_
+
+#ifdef __KERNEL__
+#ifdef CONFIG_KOBJ_NOTIFY
+
+extern int kobj_notify(const char *signal, struct kobject *kobj,
+		       struct attribute *attr);
+
+extern int kobj_notify_atomic(const char *signal, struct kobject *kobj,
+			      struct attribute *attr);
+
+#else
+
+static inline int kobj_notify(const char *signal, struct kobject *kobj,
+		       struct attribute *attr)
+{
+	return 0;
+}
+
+static inline int kobj_notify_atomic(const char *signal, struct kobject *kobj,
+			      struct attribute *attr)
+{
+	return 0;
+}
+
+
+#endif /* CONFIG_KOBJ_NOTIFY */
+#endif /* __KERNEL__ */
+
+#endif /* _KOBJ_NOTIFY_H_ */
diff -Nru a/include/linux/netlink.h b/include/linux/netlink.h
--- a/include/linux/netlink.h	2004-09-05 03:54:23 +02:00
+++ b/include/linux/netlink.h	2004-09-05 03:54:23 +02:00
@@ -17,6 +17,7 @@
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
+#define NETLINK_KOBJ_NOTIFY	15	/* Kernel messages to userspace */
 #define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
 
 #define MAX_LINKS 32		
diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2004-09-05 03:54:23 +02:00
+++ b/init/Kconfig	2004-09-05 03:54:23 +02:00
@@ -195,6 +195,21 @@
 	  agent" (/sbin/hotplug) to load modules and set up software needed
 	  to use devices as you hotplug them.
 
+config KOBJ_NOTIFY
+	bool "Kernel Events Layer"
+	depends on NET && HOTPLUG
+	default y
+	help
+	  This option enables the kernel events layer, which is a simple
+	  mechanism for kernel-to-user communication over a netlink socket.
+	  The goal of the kernel events layer is to provide a simple and
+	  efficient events system, that notifies userspace about kobject state
+	  changes e.g. hotplug events, power state changes or block device
+	  claiming (mount/unmount).
+
+	  Say Y, unless you are building a system requiring minimal memory
+	  consumption.
+
 config IKCONFIG
 	bool "Kernel .config support"
 	---help---
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2004-09-05 03:54:23 +02:00
+++ b/kernel/Makefile	2004-09-05 03:54:23 +02:00
@@ -24,6 +24,7 @@
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
+obj-$(CONFIG_KOBJ_NOTIFY) += kobj_notify.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Nru a/kernel/kobj_notify.c b/kernel/kobj_notify.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/kobj_notify.c	2004-09-05 03:54:23 +02:00
@@ -0,0 +1,88 @@
+/*
+ * kernel/kobj_notify.c - sysfs event delivery via netlink socket
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
+#include <net/sock.h>
+
+static struct sock *kobj_notify_sock = NULL;
+
+static int do_kobj_notify(const char *signal, struct kobject *kobj,
+			  struct attribute *attr, int gfp_mask)
+{
+	const char *path;
+	struct sk_buff *skb;
+	char *buffer;
+	int len;
+
+	if (!kobj_notify_sock)
+		return -EIO;
+
+	path = kobject_get_path(NULL, kobj, gfp_mask);
+	if (!path)
+		return -ENOMEM;
+
+	len = strlen(signal) + 1;
+	len += strlen(path) + 1;
+	if (attr)
+		len += strlen(attr->name) + 1;
+
+	skb = alloc_skb(len, gfp_mask);
+	if (!skb)
+		return -ENOMEM;
+
+	buffer = skb_put(skb, len);
+	if (attr)
+		sprintf(buffer, "%s\n%s/%s", signal, path, attr->name);
+	else
+		sprintf(buffer, "%s\n%s", signal, path);
+	kfree(path);
+
+	return netlink_broadcast(kobj_notify_sock, skb, 0, 1, gfp_mask);
+}
+
+int kobj_notify(const char *signal, struct kobject *kobj,
+		struct attribute *attr)
+{
+	return do_kobj_notify(signal, kobj, attr, GFP_KERNEL);
+}
+
+EXPORT_SYMBOL(kobj_notify);
+
+int kobj_notify_atomic(const char *signal, struct kobject *kobj,
+		       struct attribute *attr)
+{
+	return do_kobj_notify(signal, kobj, attr, GFP_ATOMIC);
+}
+
+EXPORT_SYMBOL(kobj_notify_atomic);
+
+static int __init kobj_notify_init(void)
+{
+	kobj_notify_sock = netlink_kernel_create(NETLINK_KOBJ_NOTIFY, NULL);
+
+	if (!kobj_notify_sock) {
+		printk(KERN_ERR
+		       "kobj_notify: unable to create netlink socket!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+core_initcall(kobj_notify_init);
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-09-05 03:54:23 +02:00
+++ b/lib/kobject.c	2004-09-05 03:54:23 +02:00
@@ -13,6 +13,7 @@
 #undef DEBUG
 
 #include <linux/kobject.h>
+#include <linux/kobj_notify.h>
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/stat.h>
@@ -202,6 +203,8 @@
 			goto exit;
 		}
 	}
+
+	kobj_notify(action, kobj, NULL);
 
 	pr_debug ("%s: %s %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
 		  envp[0], envp[1], envp[2], envp[3], envp[4]);

--azLHFNyN32YCQGCU--
