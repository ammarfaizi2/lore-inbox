Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWAXLqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWAXLqI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 06:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWAXLqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 06:46:08 -0500
Received: from webapps.arcom.com ([194.200.159.168]:62216 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S964910AbWAXLqH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 06:46:07 -0500
Message-ID: <43D61374.8010208@arcom.com>
Date: Tue, 24 Jan 2006 11:45:56 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] Controller Area Network (CAN) infrastructure
Content-Type: multipart/mixed;
 boundary="------------050909070100040609030405"
X-OriginalArrivalTime: 24 Jan 2006 11:50:19.0281 (UTC) FILETIME=[597BB010:01C620DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050909070100040609030405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


This is a basic Controller Area Network (CAN) infrastructure.

CAN is a serial bus network commonly used in automotive and industrial
control applications.  CAN is exclusively a broadcast network.  Frames
do not have destination addresses and instead have an ID which
identifies the frame (generally the ID identifies the type of data in
the payload of the frame).  Nodes can selectively receive frames based
on their ID (using mask and match bits).

Since CAN is a network, CAN controller drivers are implemented as
network devices with a few extras provided by a CAN class device.  CAN
frame aren't a whole number of octets so the user recv()'s and send()'s
'struct can_frame's which include all the header bits and the 8 octets
of payload.

This infrastructure provides the bare minimum required to test CAN
controllers and is likely missing stuff necessary to actually use it in
an application.  In particular, the requirement that frames are sent via
a packet(7) socket could do with being removed but I'm unclear on a
method that would allow this but wouldn't be a security risk (e.g., a
mechanism needs to be provided so you can't send/receive raw CAN frames
on, say, an ethernet device).

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------050909070100040609030405
Content-Type: text/plain;
 name="drivers-can"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers-can"

Index: linux-2.6-working/arch/arm/Kconfig
===================================================================
--- linux-2.6-working.orig/arch/arm/Kconfig	2006-01-19 17:41:46.000000000 +0000
+++ linux-2.6-working/arch/arm/Kconfig	2006-01-24 11:17:08.000000000 +0000
@@ -784,6 +784,8 @@
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/can/Kconfig"
+
 endmenu
 
 source "fs/Kconfig"
Index: linux-2.6-working/drivers/Kconfig
===================================================================
--- linux-2.6-working.orig/drivers/Kconfig	2006-01-19 17:41:46.000000000 +0000
+++ linux-2.6-working/drivers/Kconfig	2006-01-19 17:42:31.000000000 +0000
@@ -68,4 +68,6 @@
 
 source "drivers/sn/Kconfig"
 
+source "drivers/can/Kconfig"
+
 endmenu
Index: linux-2.6-working/drivers/Makefile
===================================================================
--- linux-2.6-working.orig/drivers/Makefile	2006-01-19 17:41:46.000000000 +0000
+++ linux-2.6-working/drivers/Makefile	2006-01-19 17:42:31.000000000 +0000
@@ -72,3 +72,4 @@
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
+obj-$(CONFIG_CAN)		+= can/
Index: linux-2.6-working/drivers/can/Kconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/drivers/can/Kconfig	2006-01-24 11:17:13.000000000 +0000
@@ -0,0 +1,17 @@
+menu "CAN support"
+
+config CAN
+        tristate "CAN support"
+        depends on NET
+        help
+          Controller Area Network (CAN) is a serial bus network used in
+          industrial and automotive control and monitoring applications.
+
+config CAN_DEBUG
+        boolean "Debug support for CAN drivers"
+        depends on CAN && DEBUG_KERNEL
+        help
+          Say "yes" to enable debug messaging (like dev_dbg and pr_debug),
+          sysfs, and debugfs support in CAN controller drivers.
+
+endmenu
Index: linux-2.6-working/drivers/can/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/drivers/can/Makefile	2006-01-24 11:17:13.000000000 +0000
@@ -0,0 +1,5 @@
+ifeq ($(CONFIG_CAN_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
+
+obj-$(CONFIG_CAN)		+= can.o
Index: linux-2.6-working/drivers/can/can.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/drivers/can/can.c	2006-01-24 11:17:36.000000000 +0000
@@ -0,0 +1,148 @@
+/*
+ * Controller Area Network (CAN) infrastructure.
+ *
+ * Copyright (C) 2006 Arcom Control Systems Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/netdevice.h>
+#include <linux/can/can.h>
+
+
+ssize_t can_bit_rate_show(struct class_device *cdev, char *buf)
+{
+	struct can_device *can = to_can_device(cdev);
+	return sprintf(buf, "%d\n", can->get_bit_rate(can));
+}
+
+ssize_t can_bit_rate_store(struct class_device *cdev, const char *buf, size_t count)
+{
+	struct can_device *can = to_can_device(cdev);
+	int bit_rate;
+
+	if (netif_running(&can->ndev))
+		return -EBUSY;
+
+	bit_rate = simple_strtoul(buf, NULL, 0);
+	can->set_bit_rate(can, bit_rate);
+
+	return count;
+}
+
+CLASS_DEVICE_ATTR(bit_rate, 0644, can_bit_rate_show, can_bit_rate_store);
+
+
+static struct net_device_stats *can_get_stats(struct net_device *netdev)
+{
+	struct can_device *can = netdev->priv;
+
+	return &can->stats;
+}
+
+static void can_device_release(struct class_device *cdev)
+{
+	struct can_device *can = to_can_device(cdev);
+
+	class_device_remove_file(&can->cdev, &class_device_attr_bit_rate);
+
+	unregister_netdev(&can->ndev);
+
+	kfree(can);
+}
+
+static struct class can_device_class = {
+	.name     = "can",
+	.owner   = THIS_MODULE,
+	.release = can_device_release,
+};
+
+struct can_device * __init_or_module
+can_device_alloc(struct device *dev, unsigned size)
+{
+	struct can_device *can;
+
+	if (!dev)
+		return NULL;
+
+	can = kzalloc(size + sizeof(struct can_device), SLAB_KERNEL);
+	if (!can)
+		return NULL;
+
+	class_device_initialize(&can->cdev);
+	can->cdev.class = &can_device_class;
+	can->cdev.dev = get_device(dev);
+	can_device_set_devdata(can, &can[1]);
+
+	return can;
+}
+EXPORT_SYMBOL_GPL(can_device_alloc);
+
+int __init_or_module can_device_register(struct can_device *can)
+{
+	struct device  *dev = can->cdev.dev;
+	int ret;
+
+	/* Network device initialization */
+	SET_NETDEV_DEV(&can->ndev, dev);
+	strcpy(can->ndev.name, "can%d");
+	can->ndev.get_stats       = can_get_stats;
+	can->ndev.flags           = IFF_NOARP | IFF_MULTICAST;
+	can->ndev.mtu             = sizeof(struct can_frame);
+	can->ndev.tx_queue_len    = 10;
+	can->ndev.priv            = can;
+
+	ret = register_netdev(&can->ndev);
+	if (ret < 0) {
+		dev_err(dev, "network device registration failed (ret = %d)\n", ret);
+		goto error_net;
+	}
+
+	/* Use the network interface name as the class device id. */
+	strcpy(can->cdev.class_id, can->ndev.name);
+	ret = class_device_add(&can->cdev);
+	if (ret < 0)
+		goto error_class;
+
+	class_device_create_file(&can->cdev, &class_device_attr_bit_rate);
+
+	return 0;
+
+  error_class:
+	unregister_netdev(&can->ndev);
+  error_net:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(can_device_register);
+
+void can_device_unregister(struct can_device *can)
+{
+	class_device_unregister(&can->cdev);
+	can->cdev.dev = NULL;
+}
+EXPORT_SYMBOL_GPL(can_device_unregister);
+
+static int __init can_init(void)
+{
+	int ret;
+
+	ret = class_register(&can_device_class);
+	if (ret < 0)
+		goto error;
+	return 0;
+
+  error:
+	return ret;
+}
+
+subsys_initcall(can_init);
+
+MODULE_DESCRIPTION("CAN infrastructure");
+MODULE_LICENSE("GPL");
Index: linux-2.6-working/include/linux/can/can.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/include/linux/can/can.h	2006-01-24 11:17:36.000000000 +0000
@@ -0,0 +1,107 @@
+/*
+ * Controller Area Network (CAN) infrastructure.
+ *
+ * Copyright (C) 2006 Arcom Control Systems Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __LINUX_CAN_CAN_H
+#define __LINUX_CAN_CAN_H
+
+#define CAN_FRAME_MAX_DATA_LEN 8
+
+/**
+ * struct can_frame_header - Extended CAN frame header fields
+ * @id: 11 bit standard ID
+ * @srr: Substitute Remote Request bit
+ * @ide: Extended frame bit
+ * @eid: 18 bit extended ID
+ * @rtr: Remote Transmit Request bit
+ * @rb1: Reserved Bit 1
+ * @rb0: Reserved Bit 0
+ * @dlc: 4 bit Data Length Code
+ *
+ * For a standard frame ensure that ide == 0 and fill in only id, rtr and dlc.
+ *
+ * srs, rb1, and rb0 are unused and should be set to zero.
+ *
+ * Note: The memory layout does not correspond to the on-the-wire format for a
+ * CAN frame header.
+ */
+struct can_frame_header {
+	unsigned id:11;
+	unsigned srs:1;
+	unsigned ide:1;
+	unsigned eid:18;
+	unsigned rtr:1;
+	unsigned rb1:1;
+	unsigned rb0:1;
+	unsigned dlc:4;
+};
+
+/**
+ * struct can_frame - CAN frame header fields and data
+ * @header: CAN frame header
+ * @data: 8 bytes of data
+ *
+ * User space transmits and receives struct can_frame's via the network device
+ * socket interface.
+ *
+ * Note: The memory layout does not correspond to the on-the-wire format for a
+ * CAN frame.
+ */
+struct can_frame {
+	struct can_frame_header header;
+	uint8_t data[CAN_FRAME_MAX_DATA_LEN];
+};
+
+#ifdef __KERNEL__
+
+/**
+ * struct can_device - CAN controller class device
+ * @cdev: the class device
+ * @set_bit_rate: driver operation to set the CAN bus bit rate, may return
+ *     -EINVAL if the requested bit rate isn't possible.  This is only called
+ *     if the network device is down.
+ * @get_bit_rate: driver operation to get the current CAN bus bit rate.
+ * @ndev: the network device
+ * @stats: the network device statistics
+ *
+ * The CAN controller driver must provide ndev.open, ndev.stop and
+ * ndev.hard_start_xmit before registering the CAN device.
+ */
+struct can_device {
+	struct class_device cdev;
+
+	int (*set_bit_rate)(struct can_device *can, int bit_rate);
+	int (*get_bit_rate)(struct can_device *can);
+
+	struct net_device ndev;
+	struct net_device_stats stats;
+};
+
+struct can_device * can_device_alloc(struct device *dev, unsigned size);
+int can_device_register(struct can_device *can);
+void can_device_unregister(struct can_device *can);
+
+static inline void *can_device_get_devdata(struct can_device *can)
+{
+        return class_get_devdata(&can->cdev);
+}
+
+static inline void can_device_set_devdata(struct can_device *can, void *data)
+{
+        class_set_devdata(&can->cdev, data);
+}
+
+static inline struct can_device *to_can_device(struct class_device *cdev)
+{
+	return cdev ? container_of(cdev, struct can_device, cdev) : NULL;
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* !__LINUX_CAN_CAN_H */
Index: linux-2.6-working/Documentation/can/can-summary
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-working/Documentation/can/can-summary	2006-01-24 11:18:16.000000000 +0000
@@ -0,0 +1,44 @@
+Controller Area Network (CAN) support
+=====================================
+
+Overview
+--------
+
+Controller Area Network (CAN) is a serial bus network commonly used in
+automotive and industrial control applications.
+
+CAN is (exclusively) a broadcast network, each node selects which frames to
+receive based on the ID (or extended ID) in the frame header.
+
+Two frame formats are specified in the CAN 2.0B specification: standard and
+extended.  Standard frames have an 11 bit ID; extended an 29 bit ID (split
+into 11 bit standard ID the 18 bit extended ID).  All frames have a Remote
+Transmit Request bit which may be set to request a remote node to transmit a
+response.  Frames may have up to 8 octets of payload data.
+
+
+User space interface
+--------------------
+
+CAN frames are transmitted and received using a packet(7) socket bind(2)'ed to
+the CAN network device.
+
+Since a CAN frame is not a whole number of octets the CAN frame is
+encapsulated in a 'struct can_frame' which includes fields for the header and
+the payload.  Note that the in-memory layout of 'struct can_frame' does not
+correspond to the on-the-wire format of the CAN frame.
+
+/sys/class/can/can?/bit_rate may be used to set/query the bit rate of the CAN
+bus.
+
+
+Todo
+----
+
+- a user-space interface that doesn't require root or CAP_NET_RAW and that
+  isn't a security risk. i.e., you shouldn't be able to open a non-CAN network
+  interface and send raw CAN frames down it.
+
+- hardware message filtering?
+
+- report bus errors to user-space (e.g., bus-passive and bus-off modes).

--------------050909070100040609030405--
