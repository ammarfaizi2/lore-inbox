Return-Path: <linux-kernel-owner+w=401wt.eu-S932074AbWLLGgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWLLGgH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 01:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWLLGgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 01:36:07 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:50202 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbWLLGgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 01:36:03 -0500
Message-ID: <457E4DD0.4050204@bx.jp.nec.com>
Date: Tue, 12 Dec 2006 15:36:00 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2.6.19 4/6] switch function of netpoll
References: <457E498C.1050806@bx.jp.nec.com>
In-Reply-To: <457E498C.1050806@bx.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keiichi KII <k-keiichi@bx.jp.nec.com>

This patch contains switch function of netpoll.

if "enable" attribute of certain port is '1', this port is used.
if "enable" attribute of certain port is '0', this port isn't used.

active_netconsole_dev list manages a list of active ports.
inactive_netconsole_dev list manages a list of inactive ports.

If you write '0' to "enable" attribute of a port included in
active_netconsole_dev_list, This port moves from active_netconsole_dev to
inactive_netconsole_dev and won't used to send kernel message.

-+- /sys/class/misc/
 |-+- netconsole/
   |-+- port1/
   | |--- id          [r--r--r--]  id
   | |--- enable      [rw-r--r--]  0: disable, 1: enable, writable
   | ...
   |--- port2/
   ...

Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
---
--- linux-2.6.19/drivers/net/netconsole.c	2006-12-06 14:37:26.858826500 +0900
+++ enhanced-netconsole/drivers/net/netconsole.c.switch	2006-12-06
13:32:56.744959500 +0900
@@ -86,9 +86,25 @@ static void netcon_dev_cleanup(struct ne
 static int netcon_miscdev_configured = 0;

 static LIST_HEAD(active_netconsole_dev);
+static LIST_HEAD(inactive_netconsole_dev);

 static DEFINE_SPINLOCK(netconsole_dev_list_lock);

+static ssize_t show_enable(struct netconsole_device *nd, char *buf) {
+	struct netconsole_device *dev;
+
+	spin_lock(&netconsole_dev_list_lock);
+	list_for_each_entry(dev, &active_netconsole_dev, list) {
+		if (dev->id == nd->id) {
+			spin_unlock(&netconsole_dev_list_lock);
+			return sprintf(buf, "1\n");
+		}
+	}
+	spin_unlock(&netconsole_dev_list_lock);
+
+	return sprintf(buf, "0\n");
+}
+
 #define SHOW_CLASS_ATTR(field, type, format, ...) \
 static ssize_t show_##field(type, char *buf) \
 { \
@@ -180,6 +196,36 @@ static ssize_t store_remote_mac(struct n
 	return count;
 }

+static ssize_t store_enable(struct netconsole_device *nd, const char *buf,
+			    size_t count)
+{
+	struct netconsole_device *dev, *tmp;
+	struct list_head *src, *dst;
+
+	if (strncmp(buf, "1", 1) == 0) {
+		src = &inactive_netconsole_dev;
+		dst = &active_netconsole_dev;
+	} else if(strncmp(buf, "0", 1) == 0) {
+		src = &active_netconsole_dev;
+		dst = &inactive_netconsole_dev;
+	} else {
+		printk(KERN_INFO "netconsole: invalid argument: %s\n", buf);
+		return -EINVAL;
+	}
+	
+	spin_lock(&netconsole_dev_list_lock);
+	list_for_each_entry_safe(dev, tmp, src, list) {
+		if (dev->id == nd->id) {
+			list_del(&nd->list);
+			list_add(&nd->list, dst);
+			break;
+		}
+	}
+	spin_unlock(&netconsole_dev_list_lock);
+
+	return count;
+}
+
 static ssize_t store_remove(struct netconsole_device *nd, const char *buf,
 			    size_t count)
 {
@@ -204,6 +250,7 @@ static NETCON_CLASS_ATTR(remote_ip, S_IR
 static NETCON_CLASS_ATTR(local_mac, S_IRUGO, show_local_mac, NULL);
 static NETCON_CLASS_ATTR(remote_mac, S_IRUGO | S_IWUSR,
 			 show_remote_mac, store_remote_mac);
+static NETCON_CLASS_ATTR(enable, S_IRUGO | S_IWUSR, show_enable, store_enable);
 static NETCON_CLASS_ATTR(remove, S_IWUSR, NULL, store_remove);

 static struct attribute *netcon_dev_attrs[] = {
@@ -215,6 +262,7 @@ static struct attribute *netcon_dev_attr
 	&netcon_dev_attr_remote_ip.attr,
 	&netcon_dev_attr_local_mac.attr,
 	&netcon_dev_attr_remote_mac.attr,
+	&netcon_dev_attr_enable.attr,
 	&netcon_dev_attr_remove.attr,
 	NULL
 };
@@ -434,6 +482,9 @@ static void cleanup_netconsole(void)
 	list_for_each_entry_safe(dev, tmp, &active_netconsole_dev, list) {
 		kobject_unregister(&dev->obj);
 	}
+	list_for_each_entry_safe(dev, tmp, &inactive_netconsole_dev, list) {
+		kobject_unregister(&dev->obj);
+	}

 	if (netcon_miscdev_configured) {
 		misc_deregister(&netcon_miscdev);

-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com
