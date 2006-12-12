Return-Path: <linux-kernel-owner+w=401wt.eu-S1751202AbWLLGfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWLLGfL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 01:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWLLGfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 01:35:11 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:49855 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbWLLGfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 01:35:09 -0500
Message-ID: <457E4D8E.6020903@bx.jp.nec.com>
Date: Tue, 12 Dec 2006 15:34:54 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2.6.19 3/6] add interface for netconsole using sysfs
References: <457E498C.1050806@bx.jp.nec.com>
In-Reply-To: <457E498C.1050806@bx.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keiichi KII <k-keiichi@bx.jp.nec.com>

This patch contains the following changes.

create a sysfs entry for netconsole in /sys/class/misc.
This entry has elements related to netconsole as follows.
You can change configuration of netconsole(writable attributes such as IP
address, port number and so on) and check current configuration of netconsole.

-+- /sys/class/misc/
 |-+- netconsole/
   |-+- port1/
   | |--- id          [r--r--r--]  unique port id
   | |--- remove      [-w-------]  if you write something to "remove",
   | |                             this port is removed.
   | |--- dev_name    [r--r--r--]  network interface name
   | |--- local_ip    [rw-r--r--]  source IP to use, writable
   | |--- local_port  [rw-r--r--]  source port number for UDP packets, writable
   | |--- local_mac   [r--r--r--]  source MAC address
   | |--- remote_ip   [rw-r--r--]  port number for logging agent, writable
   | |--- remote_port [rw-r--r--]  IP address for logging agent, writable
   | ---- remote_mac  [rw-r--r--]  MAC address for logging agent, writable
   |--- port2/
   |--- port3/
   ...

Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
---
--- linux-2.6.19/drivers/net/netconsole.c	2006-12-06 14:37:26.842825500 +0900
+++ enhanced-netconsole/drivers/net/netconsole.c.sysfs	2006-12-06
13:32:47.488381000 +0900
@@ -45,6 +45,8 @@
 #include <linux/sysrq.h>
 #include <linux/smp.h>
 #include <linux/netpoll.h>
+#include <linux/miscdevice.h>
+#include <linux/inet.h>

 MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
@@ -53,6 +55,7 @@ MODULE_LICENSE("GPL");
 enum {
 	MAX_PRINT_CHUNK = 1000,
 	MAX_CONFIG_LENGTH = 256,
+	MAC_ADDR_DIGIT = 6,
 };

 static char config[MAX_CONFIG_LENGTH];
@@ -62,19 +65,214 @@ MODULE_PARM_DESC(netconsole, " netconsol

 struct netconsole_device {
 	struct list_head list;
+	struct kobject obj;
 	spinlock_t netpoll_lock;
 	int id;
 	struct netpoll np;
 };

+struct netcon_dev_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct netconsole_device*, char*);
+	ssize_t (*store)(struct netconsole_device*, const char*,
+			 size_t count);
+};
+
 static int add_netcon_dev(const char*);
+static void setup_netcon_dev_sysfs(struct netconsole_device*);
 static void cleanup_netconsole(void);
 static void netcon_dev_cleanup(struct netconsole_device *nd);

+static int netcon_miscdev_configured = 0;
+
 static LIST_HEAD(active_netconsole_dev);

 static DEFINE_SPINLOCK(netconsole_dev_list_lock);

+#define SHOW_CLASS_ATTR(field, type, format, ...) \
+static ssize_t show_##field(type, char *buf) \
+{ \
+     return sprintf(buf, format, __VA_ARGS__); \
+} \
+
+SHOW_CLASS_ATTR(id, struct netconsole_device *nd, "%d\n", nd->id);
+SHOW_CLASS_ATTR(dev_name, struct netconsole_device *nd,
+		"%s\n", nd->np.dev_name);
+SHOW_CLASS_ATTR(local_port, struct netconsole_device *nd,
+		"%d\n", nd->np.local_port);
+SHOW_CLASS_ATTR(remote_port, struct netconsole_device *nd,
+		"%d\n", nd->np.remote_port);
+SHOW_CLASS_ATTR(local_ip, struct netconsole_device *nd,
+		"%d.%d.%d.%d\n", HIPQUAD(nd->np.local_ip));
+SHOW_CLASS_ATTR(remote_ip, struct netconsole_device *nd,
+		"%d.%d.%d.%d\n", HIPQUAD(nd->np.remote_ip));
+SHOW_CLASS_ATTR(local_mac, struct netconsole_device *nd,
+		"%02x:%02x:%02x:%02x:%02x:%02x\n",
+		nd->np.local_mac[0], nd->np.local_mac[1], nd->np.local_mac[2],
+		nd->np.local_mac[3], nd->np.local_mac[4], nd->np.local_mac[5]);
+SHOW_CLASS_ATTR(remote_mac, struct netconsole_device *nd,
+		"%02x:%02x:%02x:%02x:%02x:%02x\n",
+		nd->np.remote_mac[0], nd->np.remote_mac[1],
+		nd->np.remote_mac[2], nd->np.remote_mac[3],
+		nd->np.remote_mac[4], nd->np.remote_mac[5]);
+
+static ssize_t store_local_port(struct netconsole_device *nd, const char *buf,
+				size_t count)
+{
+	spin_lock(&nd->netpoll_lock);
+	nd->np.local_port = simple_strtol(buf, NULL, 10);
+	spin_unlock(&nd->netpoll_lock);
+
+	return count;
+}
+
+static ssize_t store_remote_port(struct netconsole_device *nd, const char *buf,
+				size_t count)
+{
+	spin_lock(&nd->netpoll_lock);
+	nd->np.remote_port = simple_strtol(buf, NULL, 10);
+	spin_unlock(&nd->netpoll_lock);
+
+	return count;
+}
+
+static ssize_t store_local_ip(struct netconsole_device *nd, const char *buf,
+			      size_t count)
+{
+	spin_lock(&nd->netpoll_lock);
+	nd->np.local_ip = ntohl(in_aton(buf));
+	spin_unlock(&nd->netpoll_lock);
+
+	return count;
+}
+
+static ssize_t store_remote_ip(struct netconsole_device *nd, const char *buf,
+			       size_t count)
+{
+	spin_lock(&nd->netpoll_lock);
+	nd->np.remote_ip = ntohl(in_aton(buf));
+	spin_unlock(&nd->netpoll_lock);
+
+	return count;
+}
+
+static ssize_t store_remote_mac(struct netconsole_device *nd, const char *buf,
+			       size_t count)
+{
+	unsigned char input_mac[MAC_ADDR_DIGIT] =
+		{0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	const char *cur=buf;
+	char *delim;
+	int i = 0;
+
+	for(i=0; i < MAC_ADDR_DIGIT; i++) {
+		input_mac[i] = simple_strtol(cur, NULL, 16);
+		if (i != MAC_ADDR_DIGIT - 1 &&
+		    (delim = strchr(cur, ':')) == NULL) {
+			return -EINVAL;
+		}
+		cur=delim+1;
+	}
+	spin_lock(&nd->netpoll_lock);
+	memcpy(nd->np.remote_mac, input_mac, MAC_ADDR_DIGIT);
+	spin_unlock(&nd->netpoll_lock);
+
+	return count;
+}
+
+static ssize_t store_remove(struct netconsole_device *nd, const char *buf,
+			    size_t count)
+{
+	kobject_unregister(&nd->obj);
+	return count;
+}
+
+#define NETCON_CLASS_ATTR(_name, _mode, _show, _store) \
+struct netcon_dev_attr netcon_dev_attr_##_name = \
+                           __ATTR(_name, _mode, _show, _store)
+
+static NETCON_CLASS_ATTR(id, S_IRUGO, show_id, NULL);
+static NETCON_CLASS_ATTR(dev_name, S_IRUGO, show_dev_name, NULL);
+static NETCON_CLASS_ATTR(local_port, S_IRUGO | S_IWUSR,
+			 show_local_port, store_local_port);
+static NETCON_CLASS_ATTR(remote_port, S_IRUGO | S_IWUSR,
+			 show_remote_port, store_remote_port);
+static NETCON_CLASS_ATTR(local_ip, S_IRUGO | S_IWUSR,
+			 show_local_ip, store_local_ip);
+static NETCON_CLASS_ATTR(remote_ip, S_IRUGO | S_IWUSR,
+			 show_remote_ip, store_remote_ip);
+static NETCON_CLASS_ATTR(local_mac, S_IRUGO, show_local_mac, NULL);
+static NETCON_CLASS_ATTR(remote_mac, S_IRUGO | S_IWUSR,
+			 show_remote_mac, store_remote_mac);
+static NETCON_CLASS_ATTR(remove, S_IWUSR, NULL, store_remove);
+
+static struct attribute *netcon_dev_attrs[] = {
+	&netcon_dev_attr_id.attr,
+	&netcon_dev_attr_dev_name.attr,
+	&netcon_dev_attr_local_port.attr,
+	&netcon_dev_attr_remote_port.attr,
+	&netcon_dev_attr_local_ip.attr,
+	&netcon_dev_attr_remote_ip.attr,
+	&netcon_dev_attr_local_mac.attr,
+	&netcon_dev_attr_remote_mac.attr,
+	&netcon_dev_attr_remove.attr,
+	NULL
+};
+
+static ssize_t show_netcon_dev_attr(struct kobject *kobj,
+				    struct attribute *attr,
+				    char *buffer)
+{
+	struct netcon_dev_attr *na = container_of(attr, struct netcon_dev_attr,
+						  attr);
+	struct netconsole_device * nd =
+		container_of(kobj, struct netconsole_device, obj);
+	if (na->show) {
+		return na->show(nd, buffer);
+	} else {
+		return -EACCES;
+	}
+}
+
+static ssize_t store_netcon_dev_attr(struct kobject *kobj,
+				     struct attribute *attr,
+				     const char *buffer, size_t count)
+{
+	struct netcon_dev_attr *na = container_of(attr, struct netcon_dev_attr,
+						  attr);
+	struct netconsole_device *nd =
+		container_of(kobj, struct netconsole_device, obj);
+	if (na->store) {
+		return na->store(nd, buffer, count);
+	} else {
+		return -EACCES;
+	}
+}
+
+static void netcon_dev_release(struct kobject *kobj)
+{
+	struct netconsole_device *nd =
+		container_of(kobj, struct netconsole_device, obj);
+
+	netcon_dev_cleanup(nd);
+}
+
+static struct sysfs_ops netcon_dev_sysfs_ops = {
+	.show = show_netcon_dev_attr,
+	.store = store_netcon_dev_attr
+};
+
+static struct kobj_type netcon_dev_ktype = {
+	.release = netcon_dev_release,
+	.sysfs_ops = &netcon_dev_sysfs_ops,
+	.default_attrs = netcon_dev_attrs,
+};
+
+static struct miscdevice netcon_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "netconsole",
+};
+
 static struct netpoll np = {
 	.name = "netconsole",
 	.dev_name = "eth0",
@@ -129,6 +327,8 @@ static int add_netcon_dev(const char* ta
 	list_add(&new_dev->list, &active_netconsole_dev);
 	spin_unlock(&netconsole_dev_list_lock);

+	setup_netcon_dev_sysfs(new_dev);
+
 	kfree(netcon_dev_config);
 	return 0;

@@ -138,6 +338,14 @@ static int add_netcon_dev(const char* ta
 	return -EINVAL;
 }

+static void setup_netcon_dev_sysfs(struct netconsole_device *target)
+{
+	kobject_set_name(&target->obj, "port%d", target->id);
+	target->obj.parent = &netcon_miscdev.class->kobj;
+	target->obj.ktype = &netcon_dev_ktype;
+	kobject_register(&target->obj);
+}
+
 static void netcon_dev_cleanup(struct netconsole_device *nd)
 {
 	spin_lock(&netconsole_dev_list_lock);
@@ -191,6 +399,13 @@ static int __init init_netconsole(void)
 	char *p;
 	char *tmp = config;

+	if (misc_register(&netcon_miscdev)) {
+		printk(KERN_INFO
+		       "netconsole: unable netconsole misc device\n");
+		return -EIO;
+	} else {
+		netcon_miscdev_configured = 1;
+	}
 	register_console(&netconsole);

 	if(!strlen(config)) {
@@ -215,8 +430,13 @@ static void cleanup_netconsole(void)
 	struct netconsole_device *dev, *tmp;

 	unregister_console(&netconsole);
+
 	list_for_each_entry_safe(dev, tmp, &active_netconsole_dev, list) {
-		netcon_dev_cleanup(dev);
+		kobject_unregister(&dev->obj);
+	}
+
+	if (netcon_miscdev_configured) {
+		misc_deregister(&netcon_miscdev);
 	}
 }

-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com
