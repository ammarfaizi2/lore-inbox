Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUILUez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUILUez (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 16:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUILUez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 16:34:55 -0400
Received: from relay.bostream.com ([81.26.227.9]:32670 "EHLO
	endeavour.mit.um.bostream.net") by vger.kernel.org with ESMTP
	id S261451AbUILUdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 16:33:55 -0400
Subject: [PATCH] thinkpad fn+fx key driver
From: Erik Rigtorp <erik@rigtorp.com>
Reply-To: erik@rigtorp.com
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-bJRr7ggJLfrc959U06CD"
Date: Sun, 12 Sep 2004 22:33:52 +0200
Message-Id: <1095021232.19024.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bJRr7ggJLfrc959U06CD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Changes since last version:
 - use the acpi handle provided by acpi_bus_register_driver, this way it
   should work on more models.
 - correct handling of return value from acpi_bus_register_driver

-- 
Erik Rigtorp <rigtorp@kth.se>

--=-bJRr7ggJLfrc959U06CD
Content-Disposition: attachment; filename=thinkpad-acpi-hkey-driver.patch
Content-Type: text/x-patch; name=thinkpad-acpi-hkey-driver.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: linux-2.6.9-rc1-mm3/drivers/acpi/thinkpad_acpi.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-rc1-mm3/drivers/acpi/thinkpad_acpi.c	2004-09-03 23:09:03.796394976 +0200
@@ -0,0 +1,265 @@
+/*
+ * IBM Thinkpad Fn+Fx key driver
+ * (C) 2004 Erik Rigtorp <erik@rigtorp.com>
+ * All Rights Reserved
+ *
+ * This code was inspired from the acpi button and thoshiba drivers.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+
+MODULE_AUTHOR("Erik Rigtorp");
+MODULE_DESCRIPTION("IBM Thinkpad Fn+Fx key driver");
+MODULE_LICENSE("GPL");
+
+#define LOGPREFIX "thinkpad_acpi: "
+
+/* Switch between LCD and VGA video output */
+#define METHOD_VID_VSWT  "\\_SB.PCI0.AGP.VID.VSWT"
+
+/* Toggle screen expansion */
+#define METHOD_EC_VEXP   "\\_SB.PCI0.LPC.EC.VEXP"
+
+/* device(HKEY) definitions */
+#define HKEY_HID "IBM0068"
+#define HKEY_NOTIFY 0x80
+
+#define DRIVER_VERSION "1.1"
+#define DRIVER_NAME "IBM Thinkpad Fn+Fx key driver"
+#define DEVICE_NAME "IBM Thinkpad keys"
+#define DEVICE_CLASS "hkey"
+
+static int acpi_thinkpad_add (struct acpi_device *device);
+static int acpi_thinkpad_remove (struct acpi_device *device, int type);
+
+static struct acpi_driver acpi_thinkpad_driver = {
+	.name =  DRIVER_NAME,
+	.class = DEVICE_CLASS,
+	.ids =   HKEY_HID,
+	.ops = {
+		.add = acpi_thinkpad_add,
+		.remove = acpi_thinkpad_remove,
+	},
+};
+
+struct acpi_thinkpad {
+	acpi_handle handle;
+	struct acpi_device *device;
+};
+
+/* Activate/deactivate handling of keys
+ * @val     1 to activate, 0 to deactivate */
+static int handle_keys(int val, acpi_handle handle)
+{
+	struct acpi_object_list params;
+	union acpi_object objs[1];
+	acpi_status status;
+
+	params.count = 1;
+	params.pointer = objs;
+	objs[0].type = ACPI_TYPE_INTEGER;
+	if (val)
+		objs[0].integer.value = 1;
+	else
+		objs[0].integer.value = 0;
+
+	status = acpi_evaluate_object(handle, "MHKC", 
+				      &params, 0);
+	return (status == AE_OK);
+}
+
+/* Activate/deactivate Fn+Fx key
+ * @key    the x in Fx
+ * @state  1 for active, 0 for disabled/firmware */
+static int set_key(unsigned int key, unsigned int state, acpi_handle handle)
+{
+	struct acpi_object_list params;
+	union acpi_object args[2];
+	acpi_status status;
+
+	if (state)
+		state = 1;
+
+	params.count = 2;
+	params.pointer = args;
+	args[0].type = ACPI_TYPE_INTEGER;
+	args[0].integer.value = key;
+	args[1].type = ACPI_TYPE_INTEGER;
+	args[1].integer.value = state;
+
+	status = acpi_evaluate_object(handle, "MHKM", &params, 0);
+	return (status == AE_OK);
+}
+
+/* Gets value of the pressed key */
+static int get_key(acpi_handle handle)
+{
+	acpi_status status;
+	unsigned long key;
+
+	status = acpi_evaluate_integer(handle, "MHKP", NULL, &key);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_INFO LOGPREFIX "acpi evaluate error on %s\n", 
+		       "HKEY.MHKP");
+		printk(KERN_INFO LOGPREFIX "error getting hotkey status\n");
+		return (-EFAULT);
+	}
+
+	return (key);
+}
+
+void acpi_thinkpad_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_thinkpad *thinkpad = (struct acpi_thinkpad *) data;
+	int status;
+	
+	if (!thinkpad || !thinkpad->device)
+		return;
+
+	switch(event) {
+	case HKEY_NOTIFY:
+		status = get_key(handle);
+		if (status > 0)
+		{
+			if (status == 0x1004)
+				acpi_evaluate_object(handle, "MHKS", NULL, 
+						     NULL);
+			else if (status == 0x1007)
+				acpi_evaluate_object(NULL, METHOD_VID_VSWT, 
+						     NULL, NULL);
+			else if (status == 0x1005)
+				acpi_evaluate_object(handle, "DTGL", NULL, 
+						     NULL);
+
+			acpi_bus_generate_event(thinkpad->device, event, 
+						status);
+		}
+		break;
+	default:
+		/* nothing to do */
+		break;
+	}
+
+	return;
+}
+
+static int acpi_thinkpad_add (struct acpi_device *device)
+{
+	int result = 0;
+	acpi_status status = AE_OK;
+	struct acpi_thinkpad *thinkpad = NULL;
+
+	if (!device)
+		return (-EINVAL);
+
+	thinkpad = kmalloc(sizeof(struct acpi_thinkpad), GFP_KERNEL);
+	if (!thinkpad)
+		return (-ENOMEM);
+
+	memset(thinkpad, 0, sizeof(struct acpi_thinkpad));
+
+	thinkpad->device = device;
+	thinkpad->handle = device->handle;
+	acpi_driver_data(device) = thinkpad;
+	strcpy(acpi_device_name(device), DEVICE_NAME);
+	strcpy(acpi_device_class(device), DEVICE_CLASS);
+	
+	/* activate handling of extra Fn keys (indicate driver is present) */
+	handle_keys(1, thinkpad->handle);
+
+	set_key(5, 1, thinkpad->handle);
+	set_key(7, 1, thinkpad->handle);
+	set_key(8, 1, thinkpad->handle);
+	set_key(9, 1, thinkpad->handle);
+
+	status = acpi_install_notify_handler (thinkpad->handle,
+					      ACPI_DEVICE_NOTIFY,
+					      acpi_thinkpad_notify,
+					      thinkpad);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_INFO LOGPREFIX "Error registering notify handler\n");
+		result = -ENODEV;
+	}
+
+	if (result)
+		kfree(thinkpad);
+
+	return (result);
+}
+
+static int acpi_thinkpad_remove(struct acpi_device *device, int type)
+{
+	acpi_status status = 0;
+	struct acpi_thinkpad *thinkpad = NULL;
+
+	if (!device || !acpi_driver_data(device))
+		return(-EINVAL);
+
+	thinkpad = acpi_driver_data(device);
+	status = acpi_remove_notify_handler(thinkpad->handle,
+					    ACPI_DEVICE_NOTIFY,
+					    acpi_thinkpad_notify);
+	
+	/* disable handling of extra Fn keys */
+	handle_keys(0, thinkpad->handle);
+
+	/* return handling of these keys to the firmware */
+	set_key(5, 0, thinkpad->handle);
+	set_key(7, 0, thinkpad->handle);
+	set_key(8, 0, thinkpad->handle);
+	set_key(9, 0, thinkpad->handle);
+
+	if (ACPI_FAILURE(status))
+		printk(KERN_INFO LOGPREFIX "Error removing notify handler\n");
+
+	kfree(thinkpad);
+
+	return(0);
+}
+
+static int __init acpi_thinkpad_init(void)
+{
+	acpi_status result = AE_OK;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	result = acpi_bus_register_driver(&acpi_thinkpad_driver);
+	if (result != 1)
+		return -ENODEV;
+	
+	printk(KERN_INFO LOGPREFIX "ACPI IBM Thinkpad Fn+Fx key driver version %s\n", DRIVER_VERSION);
+		
+	return 0;
+}
+
+static void __exit acpi_thinkpad_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_thinkpad_driver);
+	return;
+}
+
+module_init(acpi_thinkpad_init);
+module_exit(acpi_thinkpad_exit);
Index: linux-2.6.9-rc1-mm3/drivers/acpi/Makefile
===================================================================
--- linux-2.6.9-rc1-mm3.orig/drivers/acpi/Makefile	2004-09-03 21:06:08.000000000 +0200
+++ linux-2.6.9-rc1-mm3/drivers/acpi/Makefile	2004-09-03 23:10:29.543359456 +0200
@@ -47,4 +47,5 @@
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
+obj-$(CONFIG_ACPI_THINKPAD)	+= thinkpad_acpi.o
 obj-$(CONFIG_ACPI_BUS)		+= scan.o motherboard.o
Index: linux-2.6.9-rc1-mm3/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.9-rc1-mm3.orig/drivers/acpi/Kconfig	2004-09-03 21:19:58.000000000 +0200
+++ linux-2.6.9-rc1-mm3/drivers/acpi/Kconfig	2004-09-03 23:17:46.299962360 +0200
@@ -175,6 +175,17 @@
           driver is still under development, so if your laptop is unsupported or
           something works not quite as expected, please use the mailing list
           available on the above page (acpi4asus-user@lists.sourceforge.net)
+
+config ACPI_THINKPAD
+	tristate "Thinkpad Fn+Fx key driver"
+	depends on X86
+	depends on ACPI_INTERPRETER
+	default m
+	---help---
+	  This driver adds support for the Fn+Fx keys on modern Thinkpad 
+	  laptops.
+	  
+	  If you have a IBM Thinkpad laptop say Y or M here.
           
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"

--=-bJRr7ggJLfrc959U06CD--

