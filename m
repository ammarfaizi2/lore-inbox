Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVKQSED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVKQSED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVKQSED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:04:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:2722 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932458AbVKQSEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:01 -0500
Date: Thu, 17 Nov 2005 09:48:13 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 21/22] USB: delete the nokia_dku2 driver
Message-ID: <20051117174813.GW11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-delete-nokia_dku2.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

It was causing too many problems, and this is not the proper type of
driver for this device.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/serial/Kconfig      |    9 --
 drivers/usb/serial/Makefile     |    1 
 drivers/usb/serial/nokia_dku2.c |  142 ----------------------------------------
 3 files changed, 152 deletions(-)

--- usb-2.6.orig/drivers/usb/serial/Kconfig
+++ usb-2.6/drivers/usb/serial/Kconfig
@@ -394,15 +394,6 @@ config USB_SERIAL_MCT_U232
 	  To compile this driver as a module, choose M here: the
 	  module will be called mct_u232.
 
-config USB_SERIAL_NOKIA_DKU2
-	tristate "USB Nokia DKU2 Driver"
-	depends on USB_SERIAL
-	help
-	  Say Y here if you want to use a Nokia DKU2 device.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called nokia_dku2.
-
 config USB_SERIAL_PL2303
 	tristate "USB Prolific 2303 Single Port Serial Driver"
 	depends on USB_SERIAL
--- usb-2.6.orig/drivers/usb/serial/Makefile
+++ usb-2.6/drivers/usb/serial/Makefile
@@ -31,7 +31,6 @@ obj-$(CONFIG_USB_SERIAL_KEYSPAN_PDA)		+=
 obj-$(CONFIG_USB_SERIAL_KLSI)			+= kl5kusb105.o
 obj-$(CONFIG_USB_SERIAL_KOBIL_SCT)		+= kobil_sct.o
 obj-$(CONFIG_USB_SERIAL_MCT_U232)		+= mct_u232.o
-obj-$(CONFIG_USB_SERIAL_NOKIA_DKU2)		+= nokia_dku2.o
 obj-$(CONFIG_USB_SERIAL_OMNINET)		+= omninet.o
 obj-$(CONFIG_USB_SERIAL_OPTION)			+= option.o
 obj-$(CONFIG_USB_SERIAL_PL2303)			+= pl2303.o
--- usb-2.6.orig/drivers/usb/serial/nokia_dku2.c
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- *  Nokia DKU2 USB driver
- *
- *  Copyright (C) 2004
- *  Author: C Kemp
- *
- *  This program is largely derived from work by the linux-usb group
- *  and associated source files.  Please see the usb/serial files for
- *  individual credits and copyrights.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  20.09.2005 - Matthias Blaesing <matthias.blaesing@rwth-aachen.de>
- *  Added short name to device structure to make driver load into kernel 2.6.13
- *
- *  20.09.2005 - Matthias Blaesing <matthias.blaesing@rwth-aachen.de>
- *  Added usb_deregister to exit code - to allow remove and reinsert of module
- */
-
-
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/tty.h>
-#include <linux/tty_driver.h>
-#include <linux/tty_flip.h>
-#include <linux/module.h>
-#include <linux/usb.h>
-#include "usb-serial.h"
-
-
-#define NOKIA_VENDOR_ID		0x0421
-#define NOKIA7600_PRODUCT_ID	0x0400
-#define NOKIA6230_PRODUCT_ID	0x040f
-#define NOKIA6170_PRODUCT_ID	0x0416
-#define NOKIA6670_PRODUCT_ID	0x041d
-#define NOKIA6680_PRODUCT_ID	0x041e
-#define NOKIA6230i_PRODUCT_ID	0x0428
-
-#define NOKIA_AT_PORT	0x82
-#define NOKIA_FBUS_PORT	0x86
-
-/*
- * Version Information
- */
-#define DRIVER_VERSION	"v0.2"
-#define DRIVER_AUTHOR	"C Kemp"
-#define DRIVER_DESC	"Nokia DKU2 Driver"
-
-static struct usb_device_id id_table [] = {
-	{ USB_DEVICE(NOKIA_VENDOR_ID, NOKIA7600_PRODUCT_ID) },
-	{ USB_DEVICE(NOKIA_VENDOR_ID, NOKIA6230_PRODUCT_ID) },
-	{ USB_DEVICE(NOKIA_VENDOR_ID, NOKIA6170_PRODUCT_ID) },
-	{ USB_DEVICE(NOKIA_VENDOR_ID, NOKIA6670_PRODUCT_ID) },
-	{ USB_DEVICE(NOKIA_VENDOR_ID, NOKIA6680_PRODUCT_ID) },
-	{ USB_DEVICE(NOKIA_VENDOR_ID, NOKIA6230i_PRODUCT_ID) },
-	{ }			/* Terminating entry */
-};
-MODULE_DEVICE_TABLE(usb, id_table);
-
-/* The only thing which makes this device different from a generic
- * device is that we have to set an alternative configuration to make
- * the relevant endpoints available. In 2.6 this is really easy... */
-static int nokia_probe(struct usb_serial *serial,
-		       const struct usb_device_id *id)
-{
-	int retval = -ENODEV;
-
-	if (serial->interface->altsetting[0].endpoint[0].desc.bEndpointAddress == NOKIA_AT_PORT) {
-		/* the AT port */
-		dev_info(&serial->dev->dev, "Nokia AT Port:\n");
-		retval = 0;
-	} else if (serial->interface->num_altsetting == 2 &&
-		   serial->interface->altsetting[1].endpoint[0].desc.bEndpointAddress == NOKIA_FBUS_PORT) {
-		/* the FBUS port */
-		dev_info(&serial->dev->dev, "Nokia FBUS Port:\n");
-		usb_set_interface(serial->dev, 10, 1);
-		retval = 0;
-	}
-
-	return retval;
-}
-
-static struct usb_driver nokia_driver = {
-	.owner =	THIS_MODULE,
-	.name =		"nokia_dku2",
-	.probe =	usb_serial_probe,
-	.disconnect =	usb_serial_disconnect,
-	.id_table =	id_table,
-};
-
-static struct usb_serial_driver nokia_serial_driver = {
-	.driver = {
-		.owner =	THIS_MODULE,
-		.name = 	"nokia_dku2",
-	},
-	.description =		"Nokia 7600/6230(i)/6170/66x0 DKU2 driver",
-	.id_table =		id_table,
-	.num_interrupt_in =	1,
-	.num_bulk_in =		1,
-	.num_bulk_out =		1,
-	.num_ports =		1,
-	.probe =		nokia_probe,
-};
-
-static int __init nokia_init(void)
-{
-        int retval;
-
-	retval = usb_serial_register(&nokia_serial_driver);
-	if (retval)
-		return retval;
-
-	retval = usb_register(&nokia_driver);
-	if (retval) {
-	        usb_serial_deregister(&nokia_serial_driver);
-		return retval;
-	}
-
-	info(DRIVER_VERSION " " DRIVER_AUTHOR);
-	info(DRIVER_DESC);
-
-	return retval;
-}
-
-static void __exit nokia_exit(void)
-{
-	usb_deregister(&nokia_driver);
-	usb_serial_deregister(&nokia_serial_driver);
-}
-
-module_init(nokia_init);
-module_exit(nokia_exit);
-
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");

--
