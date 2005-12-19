Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVLSAnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVLSAnD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 19:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbVLSAnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 19:43:01 -0500
Received: from soundwarez.org ([217.160.171.123]:46549 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1030197AbVLSAnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 19:43:01 -0500
Date: Mon, 19 Dec 2005 01:42:56 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: net: swich device attribute creation to default attrs
Message-ID: <20051219004256.GA29285@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent udev versions don't longer cover bad sysfs timing with built-in
logic. Explicit rules are required to do that. For net devices, the
following is needed:
  ACTION=="add", SUBSYSTEM=="net", WAIT_FOR_SYSFS="address"
to handle access to net device properties from an event handler without
races.

This patch changes the main net attributes to be created by the driver
core, which is done _before_ the event is sent out and will not require
the stat() loop of the WAIT_FOR_SYSFS key.

Thanks,
Kay



Author: Kay Sievers <kay.sievers@suse.de>
Date:   Sun Dec 18 12:00:00 2005 +0100

net: swich device attribute creation to default attrs

All standard attributes should be created by the driver core, to
be available at the time the uevent for the device is sent out.

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
---

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 198655d..e1da81d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -84,16 +84,11 @@ static ssize_t netdev_store(struct class
 	return ret;
 }
 
-/* generate a read-only network device class attribute */
-#define NETDEVICE_ATTR(field, format_string)				\
-NETDEVICE_SHOW(field, format_string)					\
-static CLASS_DEVICE_ATTR(field, S_IRUGO, show_##field, NULL)		\
-
-NETDEVICE_ATTR(addr_len, fmt_dec);
-NETDEVICE_ATTR(iflink, fmt_dec);
-NETDEVICE_ATTR(ifindex, fmt_dec);
-NETDEVICE_ATTR(features, fmt_long_hex);
-NETDEVICE_ATTR(type, fmt_dec);
+NETDEVICE_SHOW(addr_len, fmt_dec);
+NETDEVICE_SHOW(iflink, fmt_dec);
+NETDEVICE_SHOW(ifindex, fmt_dec);
+NETDEVICE_SHOW(features, fmt_long_hex);
+NETDEVICE_SHOW(type, fmt_dec);
 
 /* use same locking rules as GIFHWADDR ioctl's */
 static ssize_t format_addr(char *buf, const unsigned char *addr, int len)
@@ -136,10 +131,6 @@ static ssize_t show_carrier(struct class
 	return -EINVAL;
 }
 
-static CLASS_DEVICE_ATTR(address, S_IRUGO, show_address, NULL);
-static CLASS_DEVICE_ATTR(broadcast, S_IRUGO, show_broadcast, NULL);
-static CLASS_DEVICE_ATTR(carrier, S_IRUGO, show_carrier, NULL);
-
 /* read-write attributes */
 NETDEVICE_SHOW(mtu, fmt_dec);
 
@@ -153,8 +144,6 @@ static ssize_t store_mtu(struct class_de
 	return netdev_store(dev, buf, len, change_mtu);
 }
 
-static CLASS_DEVICE_ATTR(mtu, S_IRUGO | S_IWUSR, show_mtu, store_mtu);
-
 NETDEVICE_SHOW(flags, fmt_hex);
 
 static int change_flags(struct net_device *net, unsigned long new_flags)
@@ -167,8 +156,6 @@ static ssize_t store_flags(struct class_
 	return netdev_store(dev, buf, len, change_flags);
 }
 
-static CLASS_DEVICE_ATTR(flags, S_IRUGO | S_IWUSR, show_flags, store_flags);
-
 NETDEVICE_SHOW(tx_queue_len, fmt_ulong);
 
 static int change_tx_queue_len(struct net_device *net, unsigned long new_len)
@@ -182,9 +169,6 @@ static ssize_t store_tx_queue_len(struct
 	return netdev_store(dev, buf, len, change_tx_queue_len);
 }
 
-static CLASS_DEVICE_ATTR(tx_queue_len, S_IRUGO | S_IWUSR, show_tx_queue_len, 
-			 store_tx_queue_len);
-
 NETDEVICE_SHOW(weight, fmt_dec);
 
 static int change_weight(struct net_device *net, unsigned long new_weight)
@@ -198,24 +182,21 @@ static ssize_t store_weight(struct class
 	return netdev_store(dev, buf, len, change_weight);
 }
 
-static CLASS_DEVICE_ATTR(weight, S_IRUGO | S_IWUSR, show_weight, 
-			 store_weight);
-
-
-static struct class_device_attribute *net_class_attributes[] = {
-	&class_device_attr_ifindex,
-	&class_device_attr_iflink,
-	&class_device_attr_addr_len,
-	&class_device_attr_tx_queue_len,
-	&class_device_attr_features,
-	&class_device_attr_mtu,
-	&class_device_attr_flags,
-	&class_device_attr_weight,
-	&class_device_attr_type,
-	&class_device_attr_address,
-	&class_device_attr_broadcast,
-	&class_device_attr_carrier,
-	NULL
+static struct class_device_attribute net_class_attributes[] = {
+	__ATTR(addr_len, S_IRUGO, show_addr_len, NULL),
+	__ATTR(iflink, S_IRUGO, show_iflink, NULL),
+	__ATTR(ifindex, S_IRUGO, show_ifindex, NULL),
+	__ATTR(features, S_IRUGO, show_features, NULL),
+	__ATTR(type, S_IRUGO, show_type, NULL),
+	__ATTR(address, S_IRUGO, show_address, NULL),
+	__ATTR(broadcast, S_IRUGO, show_broadcast, NULL),
+	__ATTR(carrier, S_IRUGO, show_carrier, NULL),
+	__ATTR(mtu, S_IRUGO | S_IWUSR, show_mtu, store_mtu),
+	__ATTR(flags, S_IRUGO | S_IWUSR, show_flags, store_flags),
+	__ATTR(tx_queue_len, S_IRUGO | S_IWUSR, show_tx_queue_len,
+	       store_tx_queue_len),
+	__ATTR(weight, S_IRUGO | S_IWUSR, show_weight, store_weight),
+	{}
 };
 
 /* Show a given an attribute in the statistics group */
@@ -407,6 +388,7 @@ static void netdev_release(struct class_
 static struct class net_class = {
 	.name = "net",
 	.release = netdev_release,
+	.class_dev_attrs = net_class_attributes,
 #ifdef CONFIG_HOTPLUG
 	.uevent = netdev_uevent,
 #endif
@@ -431,8 +413,6 @@ void netdev_unregister_sysfs(struct net_
 int netdev_register_sysfs(struct net_device *net)
 {
 	struct class_device *class_dev = &(net->class_dev);
-	int i;
-	struct class_device_attribute *attr;
 	int ret;
 
 	class_dev->class = &net_class;
@@ -442,12 +422,6 @@ int netdev_register_sysfs(struct net_dev
 	if ((ret = class_device_register(class_dev)))
 		goto out;
 
-	for (i = 0; (attr = net_class_attributes[i]) != NULL; i++) {
-		if ((ret = class_device_create_file(class_dev, attr)))
-		    goto out_unreg;
-	}
-
-
 	if (net->get_stats &&
 	    (ret = sysfs_create_group(&class_dev->kobj, &netstat_group)))
 		goto out_unreg; 

