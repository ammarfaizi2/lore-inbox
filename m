Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUKHERO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUKHERO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 23:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUKHERO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 23:17:14 -0500
Received: from fmr05.intel.com ([134.134.136.6]:17128 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261724AbUKHERB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 23:17:01 -0500
Subject: [PATCH/RFC 1/4]device core changes
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Content-Type: multipart/mixed; boundary="=-kDnXXP/hKOE0jrMqzvOt"
Message-Id: <1099887071.1750.243.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 08 Nov 2004 12:11:11 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kDnXXP/hKOE0jrMqzvOt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
This is the device core change required. Add .platform_bind method for
bus_type, so platform can do addition things when add a new device. A
case is ACPI, we want to utilize some ACPI methods for physical devices.
1. Why doesn't use 'platform_notify'?
Current device core has a 'platform_notify' mechanism, but it's not
sufficient for this. Only sepcific bus type know how to parse dev.bus_id
and know how to encode specific device's address into ACPI _ADR syntax.
2. Why adds new 'handle' in 'struct device'?
'Platform_data' is the best candidate, but a search shows some drivers
have used it. We can remove 'handle' after the drivers changes their
behavior.


Thanks,
Shaohua
---

 2.6-root/drivers/base/bus.c     |    2 ++
 2.6-root/include/linux/device.h |    2 ++
 2 files changed, 4 insertions(+)

diff -puN drivers/base/bus.c~devcore-platformbind drivers/base/bus.c
--- 2.6/drivers/base/bus.c~devcore-platformbind	2004-11-08
10:57:57.996568552 +0800
+++ 2.6-root/drivers/base/bus.c	2004-11-08 11:02:42.045386568 +0800
@@ -463,6 +463,8 @@ int bus_add_device(struct device * dev)
 		list_add_tail(&dev->bus_list, &dev->bus->devices.list);
 		device_attach(dev);
 		up_write(&dev->bus->subsys.rwsem);
+		if (bus->platform_bind)
+			bus->platform_bind(dev);
 		device_add_attrs(bus, dev);
 		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
 	}
diff -puN include/linux/device.h~devcore-platformbind
include/linux/device.h
--- 2.6/include/linux/device.h~devcore-platformbind	2004-11-08
10:57:57.998568248 +0800
+++ 2.6-root/include/linux/device.h	2004-11-08 10:57:58.001567792 +0800
@@ -63,6 +63,7 @@ struct bus_type {
 				    int num_envp, char *buffer, int buffer_size);
 	int		(*suspend)(struct device * dev, u32 state);
 	int		(*resume)(struct device * dev);
+	int		(*platform_bind)(struct device *dev);
 };
 
 extern int bus_register(struct bus_type * bus);
@@ -290,6 +291,7 @@ struct device {
 					     override */
 
 	void	(*release)(struct device * dev);
+	void			*handle;
 };
 
 static inline struct device *
_


--=-kDnXXP/hKOE0jrMqzvOt
Content-Disposition: attachment; filename=p00001_devcore-platformbind.patch
Content-Type: text/x-patch; name=p00001_devcore-platformbind.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


Add .platform_bind method for bus_type, so platform can do addition things
when add a new device. A case is ACPI, we want to utilize some ACPI methods
for physical devices.
1. Why doesn't use 'platform_notify'?
Current device core has a 'platform_notify' mechanism, but it's not
sufficient for this. Only sepcific bus type know how to parse dev.bus_id and
know how to encode specific device's address into ACPI _ADR syntax.
2. Why adds new 'handle' in 'struct device'?
'Platform_data' is the best candidate, but a search shows some drivers have
used it. We can remove 'handle' after the drivers changes their behavior.

---

 2.6-root/drivers/base/bus.c     |    2 ++
 2.6-root/include/linux/device.h |    2 ++
 2 files changed, 4 insertions(+)

diff -puN drivers/base/bus.c~devcore-platformbind drivers/base/bus.c
--- 2.6/drivers/base/bus.c~devcore-platformbind	2004-11-08 10:57:57.996568552 +0800
+++ 2.6-root/drivers/base/bus.c	2004-11-08 11:02:42.045386568 +0800
@@ -463,6 +463,8 @@ int bus_add_device(struct device * dev)
 		list_add_tail(&dev->bus_list, &dev->bus->devices.list);
 		device_attach(dev);
 		up_write(&dev->bus->subsys.rwsem);
+		if (bus->platform_bind)
+			bus->platform_bind(dev);
 		device_add_attrs(bus, dev);
 		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
 	}
diff -puN include/linux/device.h~devcore-platformbind include/linux/device.h
--- 2.6/include/linux/device.h~devcore-platformbind	2004-11-08 10:57:57.998568248 +0800
+++ 2.6-root/include/linux/device.h	2004-11-08 10:57:58.001567792 +0800
@@ -63,6 +63,7 @@ struct bus_type {
 				    int num_envp, char *buffer, int buffer_size);
 	int		(*suspend)(struct device * dev, u32 state);
 	int		(*resume)(struct device * dev);
+	int		(*platform_bind)(struct device *dev);
 };
 
 extern int bus_register(struct bus_type * bus);
@@ -290,6 +291,7 @@ struct device {
 					     override */
 
 	void	(*release)(struct device * dev);
+	void			*handle;
 };
 
 static inline struct device *
_

--=-kDnXXP/hKOE0jrMqzvOt--

