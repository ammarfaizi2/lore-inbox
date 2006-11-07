Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753863AbWKGN7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbWKGN7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbWKGN7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:59:31 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:17867 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1753863AbWKGN72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:59:28 -0500
Date: Tue, 7 Nov 2006 14:58:31 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew Victor <andrew@sanpeople.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [-mm patch 3/3] Adapt MACB driver to net_device changes
Message-ID: <20061107145831.14641f4f@cad-250-152.norway.atmel.com>
In-Reply-To: <20061107145600.3ce4b9e3@cad-250-152.norway.atmel.com>
References: <20061107144942.25c2db42@cad-250-152.norway.atmel.com>
 <20061107145132.4686ba5e@cad-250-152.norway.atmel.com>
 <20061107145600.3ce4b9e3@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The class_dev member in net_device has been replaced by a regular
device. Update the macb driver accordingly.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/net/macb.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

Index: linux-2.6.19-rc4-mm2/drivers/net/macb.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/drivers/net/macb.c	2006-11-06 16:47:08.000000000 +0100
+++ linux-2.6.19-rc4-mm2/drivers/net/macb.c	2006-11-06 16:55:25.000000000 +0100
@@ -27,8 +27,6 @@
 
 #include "macb.h"
 
-#define to_net_dev(class) container_of(class, struct net_device, class_dev)
-
 #define RX_BUFFER_SIZE		128
 #define RX_RING_SIZE		512
 #define RX_RING_BYTES		(sizeof(struct dma_desc) * RX_RING_SIZE)
@@ -912,10 +910,10 @@ static int macb_ioctl(struct net_device 
 	return ret;
 }
 
-static ssize_t macb_mii_show(const struct class_device *cd, char *buf,
+static ssize_t macb_mii_show(const struct device *_dev, char *buf,
 			unsigned long addr)
 {
-	struct net_device *dev = to_net_dev(cd);
+	struct net_device *dev = to_net_dev(_dev);
 	struct macb *bp = netdev_priv(dev);
 	ssize_t ret = -EINVAL;
 
@@ -929,11 +927,13 @@ static ssize_t macb_mii_show(const struc
 }
 
 #define MII_ENTRY(name, addr)					\
-static ssize_t show_##name(struct class_device *cd, char *buf)	\
+static ssize_t show_##name(struct device *_dev,			\
+			   struct device_attribute *attr,	\
+			   char *buf)				\
 {								\
-	return macb_mii_show(cd, buf, addr);			\
+	return macb_mii_show(_dev, buf, addr);			\
 }								\
-static CLASS_DEVICE_ATTR(name, S_IRUGO, show_##name, NULL)
+static DEVICE_ATTR(name, S_IRUGO, show_##name, NULL)
 
 MII_ENTRY(bmcr, MII_BMCR);
 MII_ENTRY(bmsr, MII_BMSR);
@@ -944,13 +944,13 @@ MII_ENTRY(lpa, MII_LPA);
 MII_ENTRY(expansion, MII_EXPANSION);
 
 static struct attribute *macb_mii_attrs[] = {
-	&class_device_attr_bmcr.attr,
-	&class_device_attr_bmsr.attr,
-	&class_device_attr_physid1.attr,
-	&class_device_attr_physid2.attr,
-	&class_device_attr_advertise.attr,
-	&class_device_attr_lpa.attr,
-	&class_device_attr_expansion.attr,
+	&dev_attr_bmcr.attr,
+	&dev_attr_bmsr.attr,
+	&dev_attr_physid1.attr,
+	&dev_attr_physid2.attr,
+	&dev_attr_advertise.attr,
+	&dev_attr_lpa.attr,
+	&dev_attr_expansion.attr,
 	NULL,
 };
 
@@ -961,17 +961,17 @@ static struct attribute_group macb_mii_g
 
 static void macb_unregister_sysfs(struct net_device *net)
 {
-	struct class_device *class_dev = &net->class_dev;
+	struct device *_dev = &net->dev;
 
-	sysfs_remove_group(&class_dev->kobj, &macb_mii_group);
+	sysfs_remove_group(&_dev->kobj, &macb_mii_group);
 }
 
 static int macb_register_sysfs(struct net_device *net)
 {
-	struct class_device *class_dev = &net->class_dev;
+	struct device *_dev = &net->dev;
 	int ret;
 
-	ret = sysfs_create_group(&class_dev->kobj, &macb_mii_group);
+	ret = sysfs_create_group(&_dev->kobj, &macb_mii_group);
 	if (ret)
 		printk(KERN_WARNING
 		       "%s: sysfs mii attribute registration failed: %d\n",
