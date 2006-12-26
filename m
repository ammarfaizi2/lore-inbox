Return-Path: <linux-kernel-owner+w=401wt.eu-S932342AbWLZFa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWLZFa0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 00:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWLZFa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 00:30:26 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:40178 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932321AbWLZFaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 00:30:25 -0500
Message-ID: <4590B365.8010707@bx.jp.nec.com>
Date: Tue, 26 Dec 2006 14:30:13 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH -mm take2 3/5] add interface for netconsole using sysfs
References: <4590AE00.5040102@bx.jp.nec.com>
In-Reply-To: <4590AE00.5040102@bx.jp.nec.com>
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
Signed-off-by: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
---
[changes]
1. use ETH_ALEN from if_ether.h.
2. remove initialization for static variable.
3. follow the kernel coding style.

--- linux-mm/drivers/net/netconsole.c	2006-12-26 14:19:01.441854500 +0900
+++ enhanced-netconsole/drivers/net/netconsole.c.sysfs	2006-12-25 16:44:49.520912750 +0900
@@ -45,6 +45,8 @@
 #include <linux/sysrq.h>
 #include <linux/smp.h>
 #include <linux/netpoll.h>
+#include <linux/miscdevice.h>
+#include <linux/inet.h>
 
 MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
@@ -56,18 +58,231 @@ MODULE_PARM_DESC(netconsole, " netconsol
 
 struct netconsole_target {
 	struct list_head list;
+	struct kobject obj;
 	int id;
 	struct netpoll np;
 };
 
+#define MAX_PRINT_CHUNK 1000
+#define CONFIG_SEPARATOR ";"
+
+struct target_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct netconsole_target*, char*);
+	ssize_t (*store)(struct netconsole_target*, const char*,
+			 size_t count);
+};
+
 static int add_target(char* target_config);
+static void setup_target_sysfs(struct netconsole_target *nt);
 static void cleanup_netconsole(void);
 static void delete_target(struct netconsole_target *nt);
 
+static int miscdev_configured;
+
 static LIST_HEAD(target_list);
 
 static DEFINE_SPINLOCK(target_list_lock);
 
+static ssize_t show_id(struct netconsole_target *nt, char *buf)
+{
+	return sprintf(buf, "%d\n", nt->id);
+}
+
+static ssize_t show_dev_name(struct netconsole_target *nt, char *buf)
+{
+	return sprintf(buf, "%s\n", nt->np.dev_name);
+}
+
+static ssize_t show_local_port(struct netconsole_target *nt, char *buf)
+{
+	return sprintf(buf, "%d\n", nt->np.local_port);
+}
+
+static ssize_t show_remote_port(struct netconsole_target *nt, char *buf)
+{
+	return sprintf(buf, "%d\n", nt->np.remote_port);
+}
+
+static ssize_t show_local_ip(struct netconsole_target *nt, char *buf)
+{
+	return sprintf(buf, "%d.%d.%d.%d\n", HIPQUAD(nt->np.local_ip));
+}
+
+static ssize_t show_remote_ip(struct netconsole_target *nt, char *buf)
+{
+	return sprintf(buf, "%d.%d.%d.%d\n", HIPQUAD(nt->np.remote_ip));
+}
+
+static ssize_t show_local_mac(struct netconsole_target *nt, char *buf)
+{
+	return sprintf(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
+		       nt->np.local_mac[0], nt->np.local_mac[1],
+		       nt->np.local_mac[2], nt->np.local_mac[3],
+		       nt->np.local_mac[4], nt->np.local_mac[5]);
+}
+
+static ssize_t show_remote_mac(struct netconsole_target *nt, char *buf)
+{
+	return sprintf(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
+		       nt->np.remote_mac[0], nt->np.remote_mac[1],
+		       nt->np.remote_mac[2], nt->np.remote_mac[3],
+		       nt->np.remote_mac[4], nt->np.remote_mac[5]);
+}
+
+static ssize_t store_local_port(struct netconsole_target *nt, const char *buf,
+				size_t count)
+{
+	spin_lock(&target_list_lock);
+	nt->np.local_port = simple_strtol(buf, NULL, 10);
+	spin_unlock(&target_list_lock);
+
+	return count;
+}
+
+static ssize_t store_remote_port(struct netconsole_target *nt, const char *buf,
+				size_t count)
+{
+	spin_lock(&target_list_lock);
+	nt->np.remote_port = simple_strtol(buf, NULL, 10);
+	spin_unlock(&target_list_lock);
+
+	return count;
+}
+
+static ssize_t store_local_ip(struct netconsole_target *nt, const char *buf,
+			      size_t count)
+{
+	spin_lock(&target_list_lock);
+	nt->np.local_ip = ntohl(in_aton(buf));
+	spin_unlock(&target_list_lock);
+
+	return count;
+}
+
+static ssize_t store_remote_ip(struct netconsole_target *nt, const char *buf,
+			       size_t count)
+{
+	spin_lock(&target_list_lock);
+	nt->np.remote_ip = ntohl(in_aton(buf));
+	spin_unlock(&target_list_lock);
+
+	return count;
+}
+
+static ssize_t store_remote_mac(struct netconsole_target *nt, const char *buf,
+			       size_t count)
+{
+	unsigned char input_mac[ETH_ALEN] =
+		{0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	const char *cur = buf;
+	char *delim;
+	int i = 0;
+
+	for(i = 0; i < ETH_ALEN; i++) {
+		input_mac[i] = simple_strtol(cur, NULL, 16);
+		if (i != ETH_ALEN - 1 && (delim = strchr(cur, ':')) == NULL)
+			return -EINVAL;
+		cur = delim + 1;
+	}
+	spin_lock(&target_list_lock);
+	memcpy(nt->np.remote_mac, input_mac, ETH_ALEN);
+	spin_unlock(&target_list_lock);
+
+	return count;
+}
+
+static ssize_t store_remove(struct netconsole_target *nt, const char *buf,
+			    size_t count)
+{
+	kobject_unregister(&nt->obj);
+	return count;
+}
+
+#define NETCON_CLASS_ATTR(_name, _mode, _show, _store) \
+struct target_attr target_attr_##_name = \
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
+static struct attribute *target_attrs[] = {
+	&target_attr_id.attr,
+	&target_attr_dev_name.attr,
+	&target_attr_local_port.attr,
+	&target_attr_remote_port.attr,
+	&target_attr_local_ip.attr,
+	&target_attr_remote_ip.attr,
+	&target_attr_local_mac.attr,
+	&target_attr_remote_mac.attr,
+	&target_attr_remove.attr,
+	NULL
+};
+
+static ssize_t show_target_attr(struct kobject *kobj,
+				    struct attribute *attr,
+				    char *buffer)
+{
+	struct target_attr *na =
+		container_of(attr, struct target_attr, attr);
+	struct netconsole_target * nt =
+		container_of(kobj, struct netconsole_target, obj);
+	if (na->show)
+		return na->show(nt, buffer);
+	else
+		return -EACCES;
+}
+
+static ssize_t store_target_attr(struct kobject *kobj,
+				     struct attribute *attr,
+				     const char *buffer, size_t count)
+{
+	struct target_attr *na =
+		container_of(attr, struct target_attr, attr);
+	struct netconsole_target *nt =
+		container_of(kobj, struct netconsole_target, obj);
+	if (na->store)
+		return na->store(nt, buffer, count);
+	else
+		return -EACCES;
+}
+
+static void release_target(struct kobject *kobj)
+{
+	struct netconsole_target *nt =
+		container_of(kobj, struct netconsole_target, obj);
+
+	delete_target(nt);
+}
+
+static struct sysfs_ops target_sysfs_ops = {
+	.show = show_target_attr,
+	.store = store_target_attr
+};
+
+static struct kobj_type target_ktype = {
+	.release = release_target,
+	.sysfs_ops = &target_sysfs_ops,
+	.default_attrs = target_attrs,
+};
+
+static struct miscdevice netconsole_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "netconsole",
+};
+
 static struct netpoll np = {
 	.name = "netconsole",
 	.dev_name = "eth0",
@@ -76,9 +291,6 @@ static struct netpoll np = {
 	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
 };
 
-#define MAX_PRINT_CHUNK 1000
-#define CONFIG_SEPARATOR ";"
-
 static int add_target(char* target_config)
 {
 	int retval = 0;
@@ -119,10 +331,19 @@ static int add_target(char* target_confi
 	list_add(&new_target->list, &target_list);
 	spin_unlock(&target_list_lock);
 
+	setup_target_sysfs(new_target);
  out:
 	return retval;
 }
 
+static void setup_target_sysfs(struct netconsole_target *nt)
+{
+	kobject_set_name(&nt->obj, "port%d", nt->id);
+	nt->obj.parent = &netconsole_miscdev.class->kobj;
+	nt->obj.ktype = &target_ktype;
+	kobject_register(&nt->obj);
+}
+
 static void delete_target(struct netconsole_target *nt)
 {
 	spin_lock(&target_list_lock);
@@ -178,6 +399,15 @@ static int __init init_netconsole(void)
 	char *p;
 	char *tmp = config;
 
+	if (misc_register(&netconsole_miscdev)) {
+		printk(KERN_ERR
+		       "netconsole: failed to register misc device for "
+		       "name = %s, id = %d\n",
+		       netconsole_miscdev.name, netconsole_miscdev.minor);
+		return -EIO;
+	} else
+		miscdev_configured = 1;
+
 	register_console(&netconsole);
 
 	if(!strlen(config)) {
@@ -202,9 +432,13 @@ static void cleanup_netconsole(void)
 	struct netconsole_target *nt, *tmp;
 
 	unregister_console(&netconsole);
+
 	list_for_each_entry_safe(nt, tmp, &target_list, list) {
-		delete_target(nt);
+		kobject_unregister(&nt->obj);
 	}
+
+	if (miscdev_configured)
+		misc_deregister(&netconsole_miscdev);
 }
 
 module_init(init_netconsole);

-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com
