Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbVKCEa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbVKCEa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbVKCEaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:30:35 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:37521 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030322AbVKCEac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:30:32 -0500
Message-Id: <20051103042818.385348000.dtor_core@ameritech.net>
References: <20051103042121.394220000.dtor_core@ameritech.net>
Date: Wed, 02 Nov 2005 23:21:24 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@ucw.cz>
Subject: [patch 3/7] Do not register statically allocated input devices
Content-Disposition: inline; filename=input-dont-register-statically-allocated.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: do not register statically allocated devices

Do not register statically allocated input devices to prevent
OOPS when attaching input interfaces since it requires class
device to be properly initialized.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |   26 +++++++++++++++-----------
 include/linux/input.h |    2 +-
 2 files changed, 16 insertions(+), 12 deletions(-)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -377,7 +377,7 @@ static int input_devices_read(char *buf,
 
 	list_for_each_entry(dev, &input_dev_list, node) {
 
-		path = dev->dynalloc ? kobject_get_path(&dev->cdev.kobj, GFP_KERNEL) : NULL;
+		path = kobject_get_path(&dev->cdev.kobj, GFP_KERNEL);
 
 		len = sprintf(buf, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
 			dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
@@ -741,15 +741,21 @@ static void input_register_classdevice(s
 	sysfs_create_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
 }
 
-void input_register_device(struct input_dev *dev)
+int input_register_device(struct input_dev *dev)
 {
 	struct input_handle *handle;
 	struct input_handler *handler;
 	struct input_device_id *id;
 
-	set_bit(EV_SYN, dev->evbit);
+	if (!dev->dynalloc) {
+		printk(KERN_WARNING "input: device %s is statically allocated, will not register\n"
+			"Please convert to input_allocate_device() or contact dtor_core@ameritech.net\n",
+			dev->name ? dev->name : "<Unknown>");
+		return -EINVAL;
+	}
 
 	init_MUTEX(&dev->sem);
+	set_bit(EV_SYN, dev->evbit);
 
 	/*
 	 * If delay and period are pre-set by the driver, then autorepeating
@@ -767,8 +773,7 @@ void input_register_device(struct input_
 	INIT_LIST_HEAD(&dev->h_list);
 	list_add_tail(&dev->node, &input_dev_list);
 
-	if (dev->dynalloc)
-		input_register_classdevice(dev);
+	input_register_classdevice(dev);
 
 	list_for_each_entry(handler, &input_handler_list, node)
 		if (!handler->blacklist || !input_match_device(handler->blacklist, dev))
@@ -776,8 +781,9 @@ void input_register_device(struct input_
 				if ((handle = handler->connect(handler, dev, id)))
 					input_link_handle(handle);
 
-
 	input_wakeup_procfs_readers();
+
+	return 0;
 }
 
 void input_unregister_device(struct input_dev *dev)
@@ -797,11 +803,9 @@ void input_unregister_device(struct inpu
 
 	list_del_init(&dev->node);
 
-	if (dev->dynalloc) {
-		sysfs_remove_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
-		sysfs_remove_group(&dev->cdev.kobj, &input_dev_id_attr_group);
-		class_device_unregister(&dev->cdev);
-	}
+	sysfs_remove_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
+	sysfs_remove_group(&dev->cdev.kobj, &input_dev_id_attr_group);
+	class_device_unregister(&dev->cdev);
 
 	input_wakeup_procfs_readers();
 }
Index: work/include/linux/input.h
===================================================================
--- work.orig/include/linux/input.h
+++ work/include/linux/input.h
@@ -1007,7 +1007,7 @@ static inline void input_put_device(stru
 	class_device_put(&dev->cdev);
 }
 
-void input_register_device(struct input_dev *);
+int input_register_device(struct input_dev *);
 void input_unregister_device(struct input_dev *);
 
 void input_register_handler(struct input_handler *);

