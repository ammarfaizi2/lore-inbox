Return-Path: <linux-kernel-owner+w=401wt.eu-S965297AbXAKGI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbXAKGI0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 01:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965300AbXAKGI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 01:08:26 -0500
Received: from [202.75.186.170] ([202.75.186.170]:1228 "EHLO
	localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965297AbXAKGIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 01:08:25 -0500
X-Greylist: delayed 1300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 01:08:19 EST
Date: Thu, 11 Jan 2007 13:19:47 +0800
Message-Id: <200701110519.l0B5Jl5B026909@localhost.localdomain>
From: jayakumar.acpi@gmail.com
Subject: [PATCH 2.6.19 1/1] input: Atlas button driver 
To: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       dmitry.torokhov@gmail.com, akpm@osdl.org, akpm@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the buttons on the Atlas wallmount
touchscreen.

Signed-off-by: Jaya Kumar <jayakumar.acpi@gmail.com>

---

 Kconfig      |   10 +++
 Makefile     |    1 
 atlas_btns.c |  170 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)

---

diff -X linux-2.6.19-vanilla/Documentation/dontdiff -uprN linux-2.6.19-vanilla/drivers/input/misc/atlas_btns.c linux-2.6.19-atlas/drivers/input/misc/atlas_btns.c
--- linux-2.6.19-vanilla/drivers/input/misc/atlas_btns.c	1970-01-01 07:30:00.000000000 +0730
+++ linux-2.6.19-atlas/drivers/input/misc/atlas_btns.c	2007-01-07 09:38:23.000000000 +0800
@@ -0,0 +1,170 @@
+/*
+ *  atlas_btns.c - Atlas Wallmount Touchscreen ACPI Extras
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
+#include <linux/input.h>
+#include <linux/types.h>
+#include <asm/uaccess.h>
+#include <acpi/acpi_drivers.h>
+
+#define ACPI_ATLAS_NAME			"Atlas ACPI"
+#define ACPI_ATLAS_CLASS		"Atlas"
+#define ACPI_ATLAS_BUTTON_HID		"ASIM0000"
+
+static struct input_dev *input_dev;
+
+/* button handling code */
+static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
+		    u32 function, void *handler_context, void **return_context)
+{
+	*return_context =
+		(function != ACPI_REGION_DEACTIVATE) ? handler_context : NULL;
+
+	return AE_OK;
+}
+
+static acpi_status acpi_atlas_button_handler(u32 function,
+		      acpi_physical_address address,
+		      u32 bit_width, acpi_integer *value,
+		      void *handler_context, void *region_context)
+{
+	acpi_status status;
+	int keycode;
+
+	if (function == ACPI_WRITE)  {
+		keycode = KEY_F1 + (address & 0x0F);
+		input_report_key(input_dev, keycode, !(address & 0x10));
+		input_sync(input_dev);
+		status = 0;
+	} else {
+		printk(KERN_WARNING "atlas: shrugged on unexpected function"
+			":function=%x,address=%lx,value=%x\n",
+			function, (unsigned long)address, (u32)*value);
+		status = -EINVAL;
+	}
+
+	return status;
+}
+
+static int atlas_acpi_button_add(struct acpi_device *device)
+{
+	acpi_status status;
+	int err;
+
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		printk(KERN_ERR "atlas: insufficient mem to allocate input "
+				"device\n");
+		return -ENOMEM;
+	}
+
+	input_dev->name = "Atlas ACPI button driver";
+	input_dev->phys = "ASIM0000/atlas/input0";
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->evbit[LONG(EV_KEY)] = BIT(EV_KEY);
+
+	set_bit(KEY_F1, input_dev->keybit);
+	set_bit(KEY_F2, input_dev->keybit);
+	set_bit(KEY_F3, input_dev->keybit);
+	set_bit(KEY_F4, input_dev->keybit);
+	set_bit(KEY_F5, input_dev->keybit);
+	set_bit(KEY_F6, input_dev->keybit);
+	set_bit(KEY_F7, input_dev->keybit);
+	set_bit(KEY_F8, input_dev->keybit);
+	set_bit(KEY_F9, input_dev->keybit);
+
+	err = input_register_device(input_dev);
+	if (err) {
+		printk(KERN_ERR "atlas: couldn't register input device\n");
+		input_free_device(input_dev);
+		return err;
+	}
+
+	/* hookup button handler */
+	status = acpi_install_address_space_handler(device->handle,
+				0x81, &acpi_atlas_button_handler,
+				&acpi_atlas_button_setup, device);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR "Atlas: Error installing addr spc handler\n");
+		input_unregister_device(input_dev);
+		status = -EINVAL;
+	}
+
+	return status;
+}
+
+static int atlas_acpi_button_remove(struct acpi_device *device, int type)
+{
+	acpi_status status;
+
+	status = acpi_remove_address_space_handler(device->handle,
+				0x81, &acpi_atlas_button_handler);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR "Atlas: Error removing addr spc handler\n");
+		status = -EINVAL;
+	}
+
+	input_unregister_device(input_dev);
+	return status;
+}
+
+static struct acpi_driver atlas_acpi_driver = {
+	.name = ACPI_ATLAS_NAME,
+	.class = ACPI_ATLAS_CLASS,
+	.ids = ACPI_ATLAS_BUTTON_HID,
+	.ops = {
+		.add = atlas_acpi_button_add,
+		.remove = atlas_acpi_button_remove,
+	},
+};
+
+static int atlas_acpi_init(void)
+{
+	int result;
+
+	if (acpi_disabled)
+		return -ENODEV;
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
+MODULE_DESCRIPTION("Atlas button driver");
+
diff -X linux-2.6.19-vanilla/Documentation/dontdiff -uprN linux-2.6.19-vanilla/drivers/input/misc/Kconfig linux-2.6.19-atlas/drivers/input/misc/Kconfig
--- linux-2.6.19-vanilla/drivers/input/misc/Kconfig	2006-12-10 13:37:46.000000000 +0800
+++ linux-2.6.19-atlas/drivers/input/misc/Kconfig	2007-01-07 09:26:15.000000000 +0800
@@ -50,6 +50,16 @@ config INPUT_WISTRON_BTNS
 	  To compile this driver as a module, choose M here: the module will
 	  be called wistron_btns.
 
+config INPUT_ATLAS_BTNS
+	tristate "x86 Atlas button interface"
+	depends on X86 && ACPI
+	help
+	  Say Y here for support of Atlas wallmount touchscreen buttons. 
+	  The events will show up as scancodes F1 through F9 via evdev.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called atlas_btns.
+
 config INPUT_IXP4XX_BEEPER
 	tristate "IXP4XX Beeper support"
 	depends on ARCH_IXP4XX
diff -X linux-2.6.19-vanilla/Documentation/dontdiff -uprN linux-2.6.19-vanilla/drivers/input/misc/Makefile linux-2.6.19-atlas/drivers/input/misc/Makefile
--- linux-2.6.19-vanilla/drivers/input/misc/Makefile	2006-12-10 13:37:46.000000000 +0800
+++ linux-2.6.19-atlas/drivers/input/misc/Makefile	2007-01-07 09:26:15.000000000 +0800
@@ -9,5 +9,6 @@ obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
+obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
