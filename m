Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWGZKmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWGZKmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWGZKmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:42:05 -0400
Received: from [210.76.114.181] ([210.76.114.181]:14262 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932328AbWGZKmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:42:03 -0400
Message-ID: <44C746F1.6090601@ccoss.com.cn>
Date: Wed, 26 Jul 2006 18:41:53 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
Subject: [PATCH 2/2] usbhid: HID device simple driver interface
Content-Type: multipart/mixed;
 boundary="------------050305000207090909020806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050305000207090909020806
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

==================================
HID device simple driver interface
==================================
 
    This patch include the header file for this API.

    I am sorry for sendding patches in the attachment, beacause of my
mail client always break TAB into some spaces.

    Good luck.

-Liyu


--------------050305000207090909020806
Content-Type: text/x-patch;
 name="usbhid-simple-driver-header.kernel-2.6.17.7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usbhid-simple-driver-header.kernel-2.6.17.7.patch"

==================================
HID device simple driver interface
==================================

    This patch include the header file for this API.
    
Signed-off-by:  Yu Li <liyu@ccoss.com.cn>

diff -Naurp linux-2.6.17.6/drivers/usb/input.orig/hid-simple.h linux-2.6.17.6/drivers/usb/input/hid-simple.h
--- linux-2.6.17.6/drivers/usb/input.orig/hid-simple.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.17.6/drivers/usb/input/hid-simple.h	2006-07-26 09:42:36.000000000 +0800
@@ -0,0 +1,106 @@
+/*
+ *  NOTE:
+ *	For use me , you must include hid.h in your source first. 
+ */
+#ifndef __HID_SIMPLE_H
+#define __HID_SIMPLE_H
+
+/* list_*_entry like interface */
+/* FIXME: Would you like move them to include/linux/list.h ? */
+#define list_for_each_continue(pos, head) \
+	for ((pos) = (pos)->next; \
+	prefetch((pos)->next), (pos) != (head); \
+	(pos) = (pos)->next)
+#define list_prepare(pos, head) ((pos) ? : head)
+
+#include <linux/usb.h>
+/***** The private section for simple device implement only *****/
+
+/* 
+ *  matched_device record one device which hid-subsystem handle, it may 
+ *  be one simple device can not handle.
+ *
+ *  The element of matched_device list is inserted at hidinput_connect(), 
+ *  and is removed  at hidinput_disconnect().
+ */ 
+struct matched_device {
+	struct usb_interface *intf;
+	struct list_head node;
+};
+
+/* 
+ *  raw_simple_driver record one device which hid simple device handle.
+ *  It used as one member of hid_simple_driver.
+ */ 
+
+struct raw_simple_device {
+	struct usb_interface *intf;
+	struct list_head node;
+};
+
+
+/* simple device internal flags */
+#define HIDINPUT_SIMPLE_SETUP_USAGE 0x1 /* the reverse is to call clear_usage */
+
+#define hidinput_simple_driver_setup_usage(hid) \
+do {\
+	if (hid->simple) {\
+		hid->simple->flags |= HIDINPUT_SIMPLE_SETUP_USAGE; \
+		hidinput_simple_driver_configure_usage(hid); \
+	}\
+} while (0)
+
+#define hidinput_simple_driver_clear_usage(hid) \
+do {\
+	if (hid->simple) {\
+		hid->simple->flags &= (~HIDINPUT_SIMPLE_SETUP_USAGE); \
+		hidinput_simple_driver_configure_usage(hid); \
+	}\
+} while (0)
+
+/* Note again here, you must include hid.h in your source first. */
+
+struct hidinput_simple_driver;
+void hidinput_simple_driver_configure_usage(struct hid_device *hid);
+int hidinput_simple_driver_init(struct hidinput_simple_driver *simple);
+int hidinput_simple_driver_push(struct hidinput_simple_driver *simple, 
+						struct matched_device *dev);
+void hidinput_simple_driver_pop(struct hidinput_simple_driver *simple, 
+						struct matched_device *dev);
+void hidinput_simple_driver_clear(struct hidinput_simple_driver *simple);
+int hidinput_simple_driver_connect(struct hidinput_simple_driver *simple, 
+							struct hid_device *hid);
+void hidinput_simple_driver_disconnect(struct hid_device *hid);
+
+
+/***** The private section end.  *****/
+
+
+/***** The public interface for simple device driver *****/
+struct hidinput_simple_driver {
+/* private */
+	struct list_head node; /* link with simple_drivers_list */
+	struct list_head raw_devices;
+	int flags;
+/* public */
+	char *name;
+	int (*connect)(struct hid_device *, struct hid_input *);	
+	void (*setup_usage)(struct hid_field *,   struct hid_usage *);
+	int (*pre_event)(const struct hid_device *, const struct hid_field *,
+					const struct hid_usage *, const __s32,
+					const struct pt_regs *regs);
+	int (*post_event)(const struct hid_device *, const struct hid_field *,
+					const struct hid_usage *, const __s32,
+					const struct pt_regs *regs);
+	void (*clear_usage)(struct hid_field *,   struct hid_usage *);
+	void (*disconnect)(struct hid_device *, struct hid_input *);
+	void *private;
+	struct usb_device_id *id_table;
+};
+
+
+int hidinput_register_simple_driver(struct hidinput_simple_driver *device);
+void hidinput_unregister_simple_driver(struct hidinput_simple_driver *device);
+
+/********************* The public section end ***********/
+#endif /* __HID_SIMPLE_H */






--------------050305000207090909020806--
