Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUD1Tws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUD1Tws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUD1TwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:52:20 -0400
Received: from atlantis.8hz.com ([212.129.237.78]:56329 "EHLO atlantis.8hz.com")
	by vger.kernel.org with ESMTP id S265035AbUD1SS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 14:18:26 -0400
Date: Wed, 28 Apr 2004 20:18:06 +0200
From: Sean Young <sean@mess.org>
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Chester <fitchett@phidgets.com>,
       Bryan Small <code_smith@comcast.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: add new USB PhidgetServo driver
Message-ID: <20040428181806.GA36322@atlantis.8hz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a driver for the usb servo controllers from Phidgets 
<http://www.phidgets.com/>, using sysfs. 

Note that the devices claim to be hid devices, so I've added them to the 
hid_blacklist (HID_QUIRK_IGNORE). A servo controller isn't really an hid
device (or is it?).

diff against 2.6.6-rc2.


Sean


diff -Nur linux-2.6.0/drivers/usb/Makefile /usr/src/linux-2.6.0/drivers/usb/Makefile
--- linux-2.6.0/drivers/usb/Makefile	2004-04-22 11:25:19.000000000 +0200
+++ /usr/src/linux-2.6.0/drivers/usb/Makefile	2004-04-21 18:02:00.000000000 +0200
@@ -66,3 +66,4 @@
 obj-$(CONFIG_USB_TEST)		+= misc/
 obj-$(CONFIG_USB_TIGL)		+= misc/
 obj-$(CONFIG_USB_USS720)	+= misc/
+obj-$(CONFIG_USB_PHIDGETSERVO)  += misc/
diff -Nur linux-2.6.0/drivers/usb/input/hid-core.c /usr/src/linux-2.6.0/drivers/usb/input/hid-core.c
--- linux-2.6.0/drivers/usb/input/hid-core.c	2004-04-12 19:36:21.000000000 +0200
+++ /usr/src/linux-2.6.0/drivers/usb/input/hid-core.c	2004-04-22 11:54:25.000000000 +0200
@@ -1412,6 +1412,14 @@
 #define USB_VENDOR_ID_CHIC		0x05fe
 #define USB_DEVICE_ID_CHIC_GAMEPAD	0x0014
 
+#define USB_VENDOR_ID_GLAB		0x06c2
+#define USB_DEVICE_ID_4_PHIDGETSERVO_30	0x0038
+#define USB_DEVICE_ID_1_PHIDGETSERVO_30	0x0039
+                                                                                
+#define USB_VENDOR_ID_WISEGROUP		0x0925
+#define USB_DEVICE_ID_1_PHIDGETSERVO_20	0x8101
+#define USB_DEVICE_ID_4_PHIDGETSERVO_20	0x8104
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1459,6 +1467,10 @@
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 7, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_VOLITO, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PTU, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_4_PHIDGETSERVO_30, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_1_PHIDGETSERVO_30, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_4_PHIDGETSERVO_20, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20, HID_QUIRK_IGNORE },
 
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
diff -Nur linux-2.6.0/drivers/usb/misc/Kconfig /usr/src/linux-2.6.0/drivers/usb/misc/Kconfig
--- linux-2.6.0/drivers/usb/misc/Kconfig	2004-04-22 11:25:20.000000000 +0200
+++ /usr/src/linux-2.6.0/drivers/usb/misc/Kconfig	2004-04-21 18:02:00.000000000 +0200
@@ -133,6 +133,18 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called speedtch.
 
+config USB_PHIDGETSERVO
+	tristate "USB PhidgetServo support"
+	depends on USB
+	help
+	  Say Y here if you want to connect an 1 or 4 Motor PhidgetServo 
+	  servo controller version 2.0 or 3.0.
+
+	  Phidgets Inc. has a web page at <http://www.phidgets.com/>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called phidgetservo.
+
 config USB_TEST
 	tristate "USB testing driver (DEVELOPMENT)"
 	depends on USB && USB_DEVICEFS && EXPERIMENTAL
diff -Nur linux-2.6.0/drivers/usb/misc/Makefile /usr/src/linux-2.6.0/drivers/usb/misc/Makefile
--- linux-2.6.0/drivers/usb/misc/Makefile	2004-04-22 11:25:20.000000000 +0200
+++ /usr/src/linux-2.6.0/drivers/usb/misc/Makefile	2004-04-21 18:02:00.000000000 +0200
@@ -15,3 +15,4 @@
 obj-$(CONFIG_USB_TEST)		+= usbtest.o
 obj-$(CONFIG_USB_TIGL)		+= tiglusb.o
 obj-$(CONFIG_USB_USS720)	+= uss720.o
+obj-$(CONFIG_USB_PHIDGETSERVO)	+= phidgetservo.o
diff -Nur linux-2.6.0/drivers/usb/misc/phidgetservo.c /usr/src/linux-2.6.0/drivers/usb/misc/phidgetservo.c
--- linux-2.6.0/drivers/usb/misc/phidgetservo.c	1970-01-01 01:00:00.000000000 +0100
+++ /usr/src/linux-2.6.0/drivers/usb/misc/phidgetservo.c	2004-04-27 13:03:07.000000000 +0200
@@ -0,0 +1,330 @@
+/*
+ * USB PhidgetServo driver 1.0
+ *
+ * Copyright (C) 2004 Sean Young <sean@mess.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This is a driver for the USB PhidgetServo version 2.0 and 3.0 servo 
+ * controllers available at: http://www.phidgets.com/ 
+ *
+ * Note that the driver takes input as: degrees.minutes
+ * -23 < degrees < 203
+ * 0 < minutes < 59
+ *
+ * CAUTION: Generally you should use 0 < degrees < 180 as anything else
+ * is probably beyond the range of your servo and may damage it.
+ */
+
+#include <linux/config.h>
+#ifdef CONFIG_USB_DEBUG
+#define DEBUG	1
+#endif
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#define DRIVER_AUTHOR "Sean Young <sean@mess.org>"
+#define DRIVER_DESC "USB PhidgetServo Driver"
+
+#define VENDOR_ID_GLAB			0x06c2
+#define DEVICE_ID_4MOTOR_SERVO_30	0x0038
+#define DEVICE_ID_1MOTOR_SERVO_30	0x0039
+
+#define VENDOR_ID_WISEGROUP		0x0925
+#define DEVICE_ID_1MOTOR_SERVO_20	0x8101
+#define DEVICE_ID_4MOTOR_SERVO_20	0x8104
+
+static struct usb_device_id id_table[] = {
+	{USB_DEVICE(VENDOR_ID_GLAB, DEVICE_ID_4MOTOR_SERVO_30)},
+	{USB_DEVICE(VENDOR_ID_GLAB, DEVICE_ID_1MOTOR_SERVO_30)},
+	{USB_DEVICE(VENDOR_ID_WISEGROUP, DEVICE_ID_4MOTOR_SERVO_20)},
+	{USB_DEVICE(VENDOR_ID_WISEGROUP, DEVICE_ID_1MOTOR_SERVO_20)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, id_table);
+
+struct phidget_servo {
+	struct usb_device *udev;
+	int version;
+	int quad_servo;
+	int pulse[4];
+	int degrees[4];
+	int minutes[4];
+};
+
+static void
+change_position_v30(struct phidget_servo *servo, int servo_no, int degrees, 
+								int minutes)
+{
+	int retval;
+	unsigned char *buffer;
+
+	/*
+	 * pulse = 0 - 4095
+	 * angle = 0 - 180 degrees
+	 *
+	 * pulse = angle * 10.6 + 243.8	
+	 */
+	servo->pulse[servo_no] = ((degrees*60 + minutes)*106 + 2438*60)/600;	
+	servo->degrees[servo_no]= degrees;
+	servo->minutes[servo_no]= minutes;	
+
+	buffer = kmalloc(6, GFP_KERNEL);
+	if (!buffer) {
+		dev_err(&servo->udev->dev, "%s - out of memory\n",
+			__FUNCTION__);
+		return;
+	}
+
+	/* 
+	 * The PhidgetServo v3.0 is controlled by sending 6 bytes,
+	 * 4 * 12 bits for each servo.
+	 *
+	 * low = lower 8 bits pulse
+	 * high = higher 4 bits pulse
+	 *
+	 * offset     bits
+	 * +---+-----------------+
+	 * | 0 |      low 0      |
+	 * +---+--------+--------+
+	 * | 1 | high 1 | high 0 |
+	 * +---+--------+--------+
+	 * | 2 |      low 1      |
+	 * +---+-----------------+
+	 * | 3 |      low 2      |
+	 * +---+--------+--------+
+	 * | 4 | high 3 | high 2 |
+	 * +---+--------+--------+
+	 * | 5 |      low 3      |
+	 * +---+-----------------+
+	 */
+
+	buffer[0] = servo->pulse[0] & 0xff;
+	buffer[1] = (servo->pulse[0] >> 8 & 0x0f)
+	    | (servo->pulse[1] >> 4 & 0xf0);
+	buffer[2] = servo->pulse[1] & 0xff;
+	buffer[3] = servo->pulse[2] & 0xff;
+	buffer[4] = (servo->pulse[2] >> 8 & 0x0f)
+	    | (servo->pulse[3] >> 4 & 0xf0);
+	buffer[5] = servo->pulse[3] & 0xff;
+
+	dev_dbg(&servo->udev->dev,
+		"data: %02x %02x %02x %02x %02x %02x\n",
+		buffer[0], buffer[1], buffer[2],
+		buffer[3], buffer[4], buffer[5]);
+
+	retval = usb_control_msg(servo->udev,
+				 usb_sndctrlpipe(servo->udev, 0),
+				 0x09, 0x21, 0x0200, 0x0000, buffer, 6, 2 * HZ);
+	if (retval != 6)
+		dev_err(&servo->udev->dev, "retval = %d\n", retval);
+	kfree(buffer);
+}
+
+static void
+change_position_v20(struct phidget_servo *servo, int servo_no, int degrees,
+								int minutes)
+{
+	int retval;
+	unsigned char *buffer;
+
+	/*
+	 * angle = 0 - 180 degrees
+	 * pulse = angle + 23
+	 */
+	servo->pulse[servo_no]= degrees + 23;
+	servo->degrees[servo_no]= degrees;
+	servo->minutes[servo_no]= 0;
+
+	buffer = kmalloc(2, GFP_KERNEL);
+	if (!buffer) {
+		dev_err(&servo->udev->dev, "%s - out of memory\n",
+			__FUNCTION__);
+		return;
+	}
+
+	/*
+	 * The PhidgetServo v2.0 is controlled by sending two bytes. The
+	 * first byte is the servo number xor'ed with 2:
+	 *
+	 * servo 0 = 2
+	 * servo 1 = 3
+	 * servo 2 = 0
+	 * servo 3 = 1
+	 *
+	 * The second byte is the position.
+	 */
+
+	buffer[0] = servo_no ^ 2;
+	buffer[1] = servo->pulse[servo_no];
+
+	dev_dbg(&servo->udev->dev, "data: %02x %02x\n", buffer[0], buffer[1]);
+
+	retval = usb_control_msg(servo->udev,
+				 usb_sndctrlpipe(servo->udev, 0),
+				 0x09, 0x21, 0x0200, 0x0000, buffer, 2, 2 * HZ);
+	if (retval != 2)
+		dev_err(&servo->udev->dev, "retval = %d\n", retval);
+	kfree(buffer);
+}
+
+#define show_set(value)	\
+static ssize_t set_servo##value (struct device *dev,			\
+					const char *buf, size_t count)	\
+{									\
+	int degrees, minutes;						\
+	struct usb_interface *intf = to_usb_interface (dev);		\
+	struct phidget_servo *servo = usb_get_intfdata (intf);		\
+									\
+	minutes = 0;							\
+	/* must at least convert degrees */				\
+	if (sscanf (buf, "%d.%d", &degrees, &minutes) < 1) {		\
+		return -EINVAL;						\
+	}								\
+									\
+	if (degrees < -23 || degrees > (180 + 23) ||			\
+	    minutes < 0 || minutes > 59) {				\
+		return -EINVAL;						\
+	}								\
+									\
+	if (servo->version >= 3) 					\
+		change_position_v30 (servo, value, degrees, minutes);	\
+	else 								\
+		change_position_v20 (servo, value, degrees, minutes);	\
+									\
+	return count;							\
+}									\
+									\
+static ssize_t show_servo##value (struct device *dev, char *buf) 	\
+{									\
+	struct usb_interface *intf = to_usb_interface (dev);		\
+	struct phidget_servo *servo = usb_get_intfdata (intf);		\
+									\
+	return sprintf (buf, "%d.%02d\n", servo->degrees[value],	\
+				servo->minutes[value]);			\
+}									\
+static DEVICE_ATTR(servo##value, S_IWUGO | S_IRUGO,			\
+	  show_servo##value, set_servo##value);
+
+show_set(0);
+show_set(1);
+show_set(2);
+show_set(3);
+
+static int
+servo_probe(struct usb_interface *interface, const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(interface);
+	struct phidget_servo *dev = NULL;
+
+	dev = kmalloc(sizeof (struct phidget_servo), GFP_KERNEL);
+	if (dev == NULL) {
+		dev_err(&interface->dev, "%s - out of memory\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	memset(dev, 0x00, sizeof (*dev));
+
+	dev->udev = usb_get_dev(udev);
+	switch (udev->descriptor.idVendor) {
+	case VENDOR_ID_WISEGROUP:
+		dev->version = 2;
+		break;
+	case VENDOR_ID_GLAB:
+		dev->version = 3;
+		break;
+	}
+	switch (udev->descriptor.idProduct) {
+	case DEVICE_ID_4MOTOR_SERVO_20:
+	case DEVICE_ID_4MOTOR_SERVO_30:
+		dev->quad_servo = 1;
+		break;
+	case DEVICE_ID_1MOTOR_SERVO_20:
+	case DEVICE_ID_1MOTOR_SERVO_30:
+		dev->quad_servo = 0;
+		break;
+	}
+
+	usb_set_intfdata(interface, dev);
+
+	device_create_file(&interface->dev, &dev_attr_servo0);
+	if (dev->quad_servo) {
+		device_create_file(&interface->dev, &dev_attr_servo1);
+		device_create_file(&interface->dev, &dev_attr_servo2);
+		device_create_file(&interface->dev, &dev_attr_servo3);
+	}
+
+	dev_info(&interface->dev, "USB %d-Motor PhidgetServo v%d.0 attached\n",
+		 dev->quad_servo ? 4 : 1, dev->version);
+	if (dev->version == 2) 
+		dev_info(&interface->dev,
+			 "WARNING: v2.0 not tested! Please report if it works.\n");
+
+	return 0;
+}
+
+static void
+servo_disconnect(struct usb_interface *interface)
+{
+	struct phidget_servo *dev;
+
+	dev = usb_get_intfdata(interface);
+	usb_set_intfdata(interface, NULL);
+
+	device_remove_file(&interface->dev, &dev_attr_servo0);
+	if (dev->quad_servo) {
+		device_remove_file(&interface->dev, &dev_attr_servo1);
+		device_remove_file(&interface->dev, &dev_attr_servo2);
+		device_remove_file(&interface->dev, &dev_attr_servo3);
+	}
+
+	usb_put_dev(dev->udev);
+
+	kfree(dev);
+
+	dev_info(&interface->dev, "USB %d-Motor PhidgetServo v%d.0 detached\n",
+		 dev->quad_servo ? 4 : 1, dev->version);
+
+	dev_info(&interface->dev,
+		 "WARNING: version 2.0 not tested. Please report if this works.\n");
+}
+
+static struct usb_driver servo_driver = {
+	.owner = THIS_MODULE,
+	.name = "phidgetservo",
+	.probe = servo_probe,
+	.disconnect = servo_disconnect,
+	.id_table = id_table
+};
+
+static int __init
+phidget_servo_init(void)
+{
+	int retval = 0;
+
+	retval = usb_register(&servo_driver);
+	if (retval)
+		err("usb_register failed. Error number %d", retval);
+
+	return retval;
+}
+
+static void __exit
+phidget_servo_exit(void)
+{
+	usb_deregister(&servo_driver);
+}
+
+module_init(phidget_servo_init);
+module_exit(phidget_servo_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
