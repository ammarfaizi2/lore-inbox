Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWFIVHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWFIVHr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWFIVHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:07:12 -0400
Received: from AToulouse-252-1-74-163.w81-49.abo.wanadoo.fr ([81.49.44.163]:8147
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932251AbWFIVGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:06:40 -0400
Message-Id: <20060609210633.492644000@localhost.localdomain>
References: <20060609210202.215291000@localhost.localdomain>
Date: Fri, 09 Jun 2006 23:02:08 +0200
From: dlezcano@fr.ibm.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com, dlezcano@fr.ibm.com
Subject: [RFC] [patch 6/6] [Network namespace] Network namespace debugfs
Content-Disposition: inline; filename=net_ns_debugfs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for testing purpose. It allows to read which network
devices are accessible and to add a network device to the view.
This RFC hack is purely for discussing the best way to do that.

After unsharing with CLONE_NEWNET flag:
--------------------------------------
 To see which devices are accessible:
	 cat /sys/kernel/debug/net_ns/dev

 To add a device:
	 echo eth1 > /sys/kernel/debug/net_ns/dev

This functionnality is intended to be implemented in an higher level
container configuration.

Replace-Subject: [Network namespace] Network namespace debugfs
Signed-off-by: Daniel Lezcano <dlezcano@fr.ibm.com> 
--
 fs/debugfs/Makefile |    2 
 fs/debugfs/net_ns.c |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/Kconfig         |    4 +
 3 files changed, 146 insertions(+), 1 deletion(-)

Index: 2.6-mm/fs/debugfs/Makefile
===================================================================
--- 2.6-mm.orig/fs/debugfs/Makefile
+++ 2.6-mm/fs/debugfs/Makefile
@@ -1,4 +1,4 @@
 debugfs-objs	:= inode.o file.o
 
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
-
+obj-$(CONFIG_NET_NS_DEBUG) += net_ns.o
Index: 2.6-mm/fs/debugfs/net_ns.c
===================================================================
--- /dev/null
+++ 2.6-mm/fs/debugfs/net_ns.c
@@ -0,0 +1,141 @@
+/*
+ *  net_ns.c - adds a net_ns/ directory to debug NET namespaces
+ *
+ *  Copyright (C) 2006 IBM
+ *
+ *  Author: Daniel Lezcano <dlezcano@fr.ibm.com>
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation, version 2 of the
+ *     License.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pagemap.h>
+#include <linux/debugfs.h>
+#include <linux/sched.h>
+#include <linux/netdevice.h>
+#include <linux/net_ns.h>
+
+static struct dentry *net_ns_dentry;
+static struct dentry *net_ns_dentry_dev;
+
+static ssize_t net_ns_dev_read_file(struct file *file, char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	size_t len;
+	char *buf;
+	struct net_ns_dev_list *devlist = &(net_ns()->dev_list);
+	struct net_ns_dev *db;
+	struct net_device *dev;
+	struct list_head *l;
+
+	if (*ppos < 0)
+		return -EINVAL;
+	if (*ppos >= count)
+		return 0;
+
+	/* It's for debug, everything should fit */
+	buf = kmalloc(4096, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	buf[0] = '\0';
+
+	read_lock(&devlist->lock);
+	list_for_each(l, &devlist->list) {
+		db = list_entry(l, struct net_ns_dev, list);
+		dev = db->dev;
+		strcat(buf,dev->name);
+		strcat(buf,"\n");
+	}
+	read_unlock(&devlist->lock);
+
+	len = strlen(buf);
+
+	if (len > count)
+		len = count;
+
+	if (copy_to_user(user_buf, buf, len)) {
+		kfree(buf);
+		return -EFAULT;
+	}
+
+	*ppos += count;
+	kfree(buf);
+
+	return count;
+}
+
+static ssize_t net_ns_dev_write_file(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	int ret;
+	size_t len;
+	const char __user *p;
+	char c;
+	char devname[IFNAMSIZ];
+	struct net_ns_dev_list *dev_list = &(net_ns()->dev_list);
+
+	len = 0;
+	p = user_buf;
+	while (len < count) {
+		if (get_user(c, p++))
+			return -EFAULT;
+		if (c == 0 || c == '\n')
+			break;
+		len++;
+	}
+
+	if (len >= IFNAMSIZ)
+		return -EINVAL;
+
+	if (copy_from_user(devname, user_buf, len))
+		return -EFAULT;
+
+	devname[len] = '\0';
+
+	ret = net_ns_dev_add(devname, dev_list);
+	if (ret)
+		return ret;
+
+	*ppos += count;
+	return count;
+}
+
+static int net_ns_dev_open_file(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static struct file_operations net_ns_dev_fops = {
+       .read =         net_ns_dev_read_file,
+       .write =        net_ns_dev_write_file,
+       .open =         net_ns_dev_open_file,
+};
+
+static int __init net_ns_init(void)
+{
+	net_ns_dentry = debugfs_create_dir("net_ns", NULL);
+
+	net_ns_dentry_dev = debugfs_create_file("dev", 0666,
+						net_ns_dentry,
+						NULL,
+						&net_ns_dev_fops);
+	return 0;
+}
+
+static void __exit net_ns_exit(void)
+{
+	debugfs_remove(net_ns_dentry_dev);
+	debugfs_remove(net_ns_dentry);
+}
+
+module_init(net_ns_init);
+module_exit(net_ns_exit);
+
+MODULE_DESCRIPTION("NET namespace debugfs");
+MODULE_AUTHOR("Daniel Lezcano <dlezcano@fr.ibm.com>");
+MODULE_LICENSE("GPL");
Index: 2.6-mm/net/Kconfig
===================================================================
--- 2.6-mm.orig/net/Kconfig
+++ 2.6-mm/net/Kconfig
@@ -69,6 +69,10 @@ config NET_NS
 	  vservers, to use network namespaces to provide isolated
 	  network for different servers.  If unsure, say N.
 
+config NET_NS_DEBUG
+	bool "Debug fs for network namespace"
+	depends on DEBUG_FS && NET_NS
+
 if INET
 source "net/ipv4/Kconfig"
 source "net/ipv6/Kconfig"

--
