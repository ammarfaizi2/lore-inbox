Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752132AbWCNCof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbWCNCof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 21:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWCNCof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 21:44:35 -0500
Received: from [202.75.186.170] ([202.75.186.170]:11780 "EHLO
	ns1.clipsalportal.com") by vger.kernel.org with ESMTP
	id S1751796AbWCNCoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 21:44:34 -0500
Date: Tue, 14 Mar 2006 10:39:57 +0800
Message-Id: <200603140239.k2E2dvgq012339@ns1.clipsalportal.com>
From: jayakumar.acpi@gmail.com
Subject: [RFC/PATCH 2.6.14.7 1/1] ACPI: Atlas ACPI driver
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len, Luming, and ACPI folk,

As per the discussion with Luming here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114225584330589&w=2
I've made the following changes to the original Atlas patch:
- removed __init/__exit as per Bjorn Helgaas' ASUS patch
- removed /proc usage and LCD control using _BCM
- added Atlas LCD brightness to the generic hotkey driver

I've done this patch against 2.6.14.7 + Luming's generic hotkey 
patch as posted here:
http://bugzilla.kernel.org/show_bug.cgi?id=5749

Please let me know if it looks okay and if you have any feedback 
or suggestions.

Thanks,
Jaya Kumar

Signed-off-by: Jaya Kumar <jayakumar.acpi@gmail.com>

---

 MAINTAINERS               |    5 +
 drivers/acpi/Kconfig      |   11 ++++
 drivers/acpi/Makefile     |    1 
 drivers/acpi/atlas_acpi.c |  123 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/hotkey.c     |   14 +++++
 5 files changed, 154 insertions(+)

---

diff -X linux-2.6.14.7/Documentation/dontdiff -uprN linux-2.6.14.7-vanilla/drivers/acpi/atlas_acpi.c linux-2.6.14.7/drivers/acpi/atlas_acpi.c
--- linux-2.6.14.7-vanilla/drivers/acpi/atlas_acpi.c	1970-01-01 07:30:00.000000000 +0730
+++ linux-2.6.14.7/drivers/acpi/atlas_acpi.c	2006-03-14 10:31:04.538158024 +0800
@@ -0,0 +1,123 @@
+/*
+ *  atlas_acpi.c - Atlas Wallmount Touchscreen ACPI Extras
+ *
+ *  Copyright (C) 2006 Jaya Kumar
+ *  Based on Toshiba ACPI by John Belmonte and ASUS ACPI
+ *  This work was sponsored by CIS(M) Sdn Bhd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+#include <acpi/acpi_drivers.h>
+
+#define PROC_ATLAS			"atlas"
+#define ACPI_ATLAS_NAME			"Atlas ACPI"
+#define ACPI_ATLAS_CLASS		"Atlas"
+#define ACPI_ATLAS_BUTTON_HID		"ASIM0000"
+
+/* button handling code */
+static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
+		    u32 function, void *handler_context, void **return_context)
+{
+	*return_context = 
+		(function != ACPI_REGION_DEACTIVATE) ?  handler_context : NULL;
+
+	return AE_OK;
+}
+
+static acpi_status acpi_atlas_button_handler(u32 function,
+		      acpi_physical_address address,
+		      u32 bit_width, acpi_integer * value,
+		      void *handler_context, void *region_context)
+{
+	acpi_status status;
+	struct acpi_device *dev;
+
+	dev = (struct acpi_device *) handler_context;
+	if (function == ACPI_WRITE)
+		status = acpi_bus_generate_event(dev, 0x80, address);
+	else {
+		printk(KERN_WARNING "atlas: shrugged on unexpected function"
+			":function=%x,address=%x,value=%x\n",
+			function, (u32)address, (u32)*value);
+		status = -EINVAL;
+	}
+
+	return status ;
+}
+
+static int atlas_acpi_button_add(struct acpi_device *device)
+{
+	/* hookup button handler */
+	return acpi_install_address_space_handler(device->handle,
+				0x81, &acpi_atlas_button_handler,
+				&acpi_atlas_button_setup, device);
+}
+
+static int atlas_acpi_button_remove(struct acpi_device *device, int type)
+{
+	acpi_status status;
+	
+	status = acpi_remove_address_space_handler(device->handle,
+				0x81, &acpi_atlas_button_handler);
+	if (ACPI_FAILURE(status))
+		printk(KERN_ERR "Atlas: Error removing addr spc handler\n");
+
+	return status;
+}
+
+static struct acpi_driver atlas_acpi_driver = {
+	.name 	= ACPI_ATLAS_NAME,
+	.class 	= ACPI_ATLAS_CLASS,
+	.ids 	= ACPI_ATLAS_BUTTON_HID, 
+	.ops = {
+		.add = atlas_acpi_button_add,
+		.remove = atlas_acpi_button_remove,
+		},
+};
+
+static int atlas_acpi_init(void)
+{
+	int result;
+
+	result = acpi_bus_register_driver(&atlas_acpi_driver);
+	if (result < 0) {
+		printk(KERN_ERR "Atlas ACPI: Unable to register driver\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void atlas_acpi_exit(void)
+{
+	acpi_bus_unregister_driver(&atlas_acpi_driver);
+}
+
+module_init(atlas_acpi_init);
+module_exit(atlas_acpi_exit);
+
+MODULE_AUTHOR("Jaya Kumar");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Atlas ACPI");
+MODULE_SUPPORTED_DEVICE("Atlas ACPI");
+
diff -X linux-2.6.14.7/Documentation/dontdiff -uprN linux-2.6.14.7-vanilla/drivers/acpi/hotkey.c linux-2.6.14.7/drivers/acpi/hotkey.c
--- linux-2.6.14.7-vanilla/drivers/acpi/hotkey.c	2006-03-13 13:50:38.000000000 +0800
+++ linux-2.6.14.7/drivers/acpi/hotkey.c	2006-03-13 23:23:46.000000000 +0800
@@ -187,6 +187,15 @@ static struct acpi_polling_hotkey pollin
 		.id = 10001,
 	},
 	{
+		.ids = "ACPILCD00",
+		.name = "brightness",
+		.poll_method = "_BCL",
+		.action_method = "_BCM",
+		.min = 1,
+		.max = 31,
+		.id = 10001,
+	},
+	{
 		.ids = "SNY5001", 
 		.name		= "brightness_default",
 		.poll_method = "GPBR",
@@ -268,6 +277,11 @@ struct specific_hotkey_driver_config {
 		.ids = "ATK0100",
 		.driver = NULL,
 	},
+ 	{
+		.name = "Atlas ACPI Extras Driver",
+		.ids = "ACPILCD00",
+		.driver = NULL,
+	},
 	{
 		.name = "",
 		.ids = NULL,
diff -X linux-2.6.14.7/Documentation/dontdiff -uprN linux-2.6.14.7-vanilla/drivers/acpi/Kconfig linux-2.6.14.7/drivers/acpi/Kconfig
--- linux-2.6.14.7-vanilla/drivers/acpi/Kconfig	2006-03-12 22:37:04.000000000 +0800
+++ linux-2.6.14.7/drivers/acpi/Kconfig	2006-03-14 10:30:41.439669528 +0800
@@ -193,7 +193,18 @@ config ACPI_ASUS
           driver is still under development, so if your laptop is unsupported or
           something works not quite as expected, please use the mailing list
           available on the above page (acpi4asus-user@lists.sourceforge.net)
+
+config ACPI_ATLAS
+	tristate "Atlas Wallmount Touchscreen Extras"
+	depends on X86
+	default n
+         ---help---
+          This driver is intended for Atlas wallmounted touchscreens. 
+          The button events will show up in /proc/acpi/events and the lcd
+          brightness control is controlled using /sys/hotkey/brightness
           
+          If you have an Atlas wallmounted touchscreen, say Y or M here. 
+
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
diff -X linux-2.6.14.7/Documentation/dontdiff -uprN linux-2.6.14.7-vanilla/drivers/acpi/Makefile linux-2.6.14.7/drivers/acpi/Makefile
--- linux-2.6.14.7-vanilla/drivers/acpi/Makefile	2006-03-13 13:50:38.000000000 +0800
+++ linux-2.6.14.7/drivers/acpi/Makefile	2006-03-13 23:27:48.000000000 +0800
@@ -53,6 +53,7 @@ obj-$(CONFIG_ACPI_SYSTEM)	+= system.o ev
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
+obj-$(CONFIG_ACPI_ATLAS)	+= atlas_acpi.o
 obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-y				+= scan.o motherboard.o hotkeylib.o
diff -X linux-2.6.14.7/Documentation/dontdiff -uprN linux-2.6.14.7-vanilla/MAINTAINERS linux-2.6.14.7/MAINTAINERS
--- linux-2.6.14.7-vanilla/MAINTAINERS	2006-03-12 22:36:46.000000000 +0800
+++ linux-2.6.14.7/MAINTAINERS	2006-03-13 23:29:01.000000000 +0800
@@ -355,6 +355,11 @@ M:	ecashin@coraid.com
 W:	http://www.coraid.com/support/linux
 S:	Supported
 
+ATLAS ACPI EXTRAS DRIVER
+P:	Jaya Kumar
+M:	jayakumar.acpi@gmail.com
+S:	Maintained
+
 ATM
 P:	Chas Williams
 M:	chas@cmf.nrl.navy.mil
