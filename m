Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVBPPlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVBPPlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVBPPlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:41:13 -0500
Received: from sd291.sivit.org ([194.146.225.122]:12972 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262045AbVBPPhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:37:45 -0500
Date: Wed, 16 Feb 2005 16:39:25 +0100
From: Stelian Pop <stelian@popies.net>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       Pekka Enberg <penberg@gmail.com>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050216153924.GC4372@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Jean Delvare <khali@linux-fr.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
	Pekka Enberg <penberg@gmail.com>
References: <20050214100738.GC3233@crusoe.alcove-fr> <CKthPPXN.1108383209.9808960.khali@localhost> <20050214123822.GF3233@crusoe.alcove-fr> <20050214194235.073f5850.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214194235.073f5850.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 07:42:35PM +0100, Jean Delvare wrote:

> Hi all,
> 
> > > > * pbr is the power-on brightness. It's the brightness that the
> > > >   laptop uses at power-on time.
> > > 
> > > Will test this evening.
> 
> I can confirm, that works for me too.

All right, here is a third version of the driver, which adds the
'brightness_default' entry and rewrites a big part of the code in
a more extensible way.

Stelian.

--- linux-2.6-linus/drivers/acpi/sony_acpi.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-stelian/drivers/acpi/sony_acpi.c	2005-02-16 16:28:36.000000000 +0100
@@ -0,0 +1,392 @@
+/*
+ * ACPI Sony Notebook Control Driver (SNC)
+ *
+ * Copyright (C) 2004-2005 Stelian Pop <stelian@popies.net>
+ *
+ * Parts of this driver inspired from asus_acpi.c and ibm_acpi.c
+ * which are copyrighted by their respective authors.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acpi_bus.h>
+#include <asm/uaccess.h>
+
+#define ACPI_SNC_CLASS		"sony"
+#define ACPI_SNC_HID		"SNY5001"
+#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.2"
+
+#define LOG_PFX			KERN_WARNING "sony_acpi: "
+
+MODULE_AUTHOR("Stelian Pop");
+MODULE_DESCRIPTION(ACPI_SNC_DRIVER_NAME);
+MODULE_LICENSE("GPL");
+
+static int debug;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want to help "
+			"the development of this driver");
+
+static int sony_acpi_add (struct acpi_device *device);
+static int sony_acpi_remove (struct acpi_device *device, int type);
+
+static struct acpi_driver sony_acpi_driver = {
+	.name	= ACPI_SNC_DRIVER_NAME,
+	.class	= ACPI_SNC_CLASS,
+	.ids	= ACPI_SNC_HID,
+	.ops	= {
+			.add	= sony_acpi_add,
+			.remove	= sony_acpi_remove,
+		  },
+};
+
+static acpi_handle sony_acpi_handle;
+static struct proc_dir_entry *sony_acpi_dir;
+
+static struct sony_acpi_value {
+	char			*name;	 /* name of the entry */
+	struct proc_dir_entry 	*proc;	 /* /proc entry */
+	char			*acpiget;/* name of the ACPI get function */
+	char			*acpiset;/* name of the ACPI get function */
+	int 			min;	 /* minimum allowed value or -1 */
+	int			max;	 /* maximum allowed value or -1 */
+	int			debug;	 /* active only in debug mode ? */
+} sony_acpi_values[] = {
+	{
+		.name		= "brightness",
+		.acpiget	= "GBRT",
+		.acpiset	= "SBRT",
+		.min		= 1,
+		.max		= 8,
+		.debug		= 0,
+	},
+	{
+		.name		= "brightness_default",
+		.acpiget	= "GPBR",
+		.acpiset	= "SPBR",
+		.min		= 1,
+		.max		= 8,
+		.debug		= 0,
+	},
+	{
+		.name		= "cdpower",
+		.acpiget	= "GCDP",
+		.acpiset	= "SCDP",
+		.min		= -1,
+		.max		= -1,
+		.debug		= 0,
+	},
+	{
+		.name		= "PID",
+		.acpiget	= "GPID",
+		.debug		= 1,
+	},
+	{
+		.name		= "CTR",
+		.acpiget	= "GCTR",
+		.acpiset	= "SCTR",
+		.min		= -1,
+		.max		= -1,
+		.debug		= 1,
+	},
+	{
+		.name		= "PCR",
+		.acpiget	= "GPCR",
+		.acpiset	= "SPCR",
+		.min		= -1,
+		.max		= -1,
+		.debug		= 1,
+	},
+	{
+		.name		= "CMI",
+		.acpiget	= "GCMI",
+		.acpiset	= "SCMI",
+		.min		= -1,
+		.max		= -1,
+		.debug		= 1,
+	},
+	{
+		.name		= NULL,
+	}
+};
+
+static int acpi_callgetfunc(acpi_handle handle, char *name, int *result)
+{
+	struct acpi_buffer output;
+	union acpi_object out_obj;
+	acpi_status status;
+
+	output.length = sizeof(out_obj);
+	output.pointer = &out_obj;
+
+	status = acpi_evaluate_object(handle, name, NULL, &output);
+	if ((status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER)) {
+		*result = out_obj.integer.value;
+		return 0;
+	}
+
+	printk(LOG_PFX "acpi_callreadfunc failed\n");
+
+	return -1;
+}
+
+static int acpi_callsetfunc(acpi_handle handle, char *name, int value,
+			    int *result)
+{
+	struct acpi_object_list params;
+	union acpi_object in_obj;
+	struct acpi_buffer output;
+	union acpi_object out_obj;
+	acpi_status status;
+
+	params.count = 1;
+	params.pointer = &in_obj;
+	in_obj.type = ACPI_TYPE_INTEGER;
+	in_obj.integer.value = value;
+
+	output.length = sizeof(out_obj);
+	output.pointer = &out_obj;
+
+	status = acpi_evaluate_object(handle, name, &params, &output);
+	if (status == AE_OK) {
+		if (result != NULL) {
+			if (out_obj.type != ACPI_TYPE_INTEGER) {
+				printk(LOG_PFX "acpi_evaluate_object bad "
+				       "return type\n");
+				return -1;
+			}
+			*result = out_obj.integer.value;
+		}
+		return 0;
+	}
+
+	printk(LOG_PFX "acpi_evaluate_object failed\n");
+
+	return -1;
+}
+
+static int parse_buffer(const char __user *buffer, unsigned long count,
+			int *val) {
+	char s[32];
+	int ret;
+
+	if (count > 31)
+		return -EINVAL;
+	if (copy_from_user(s, buffer, count))
+		return -EFAULT;
+	s[count] = '\0';
+	ret = simple_strtoul(s, NULL, 10);
+	*val = ret;
+	return 0;
+}
+
+static int sony_acpi_read(char* page, char** start, off_t off, int count,
+			  int* eof, void *data)
+{
+	struct sony_acpi_value *item = data;
+	int value;
+
+	if (!item->acpiget)
+		return -EIO;
+
+	if (acpi_callgetfunc(sony_acpi_handle, item->acpiget, &value) < 0)
+		return -EIO;
+
+	return sprintf(page, "%d\n", value);
+}
+
+static int sony_acpi_write(struct file *file, const char __user *buffer,
+			   unsigned long count, void *data)
+{
+	struct sony_acpi_value *item = data;
+	int result;
+	int value;
+
+	if (!item->acpiset)
+		return -EIO;
+
+	if ((result = parse_buffer(buffer, count, &value)) < 0)
+		return result;
+
+	if (item->min != -1 && value < item->min)
+		return -EINVAL;
+	if (item->max != -1 && value > item->max)
+		return -EINVAL;
+
+	if (acpi_callsetfunc(sony_acpi_handle, item->acpiset, value, NULL) < 0)
+		return -EIO;
+
+	return count;
+}
+
+static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
+{
+	printk(LOG_PFX "sony_acpi_notify\n");
+}
+
+static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
+				      void *context, void **return_value)
+{
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *operand;
+
+	node = (struct acpi_namespace_node *) handle;
+	operand = (union acpi_operand_object *) node->object;
+
+	printk(LOG_PFX "method: name: %4.4s, args %X\n", node->name.ascii,
+	       (u32) operand->method.param_count);
+
+	return AE_OK;
+}
+
+static int __init sony_acpi_add(struct acpi_device *device)
+{
+	acpi_status status;
+	int result;
+	struct sony_acpi_value *item;
+
+	sony_acpi_handle = device->handle;
+
+	acpi_driver_data(device) = NULL;
+	acpi_device_dir(device) = sony_acpi_dir;
+
+	if (debug) {
+		status = acpi_walk_namespace(ACPI_TYPE_METHOD, sony_acpi_handle,
+					     1, sony_walk_callback, NULL, NULL);
+		if (ACPI_FAILURE(status)) {
+			printk(LOG_PFX "unable to walk acpi resources\n");
+			result = -ENODEV;
+			goto outwalk;
+		}
+
+		status = acpi_install_notify_handler(sony_acpi_handle,
+						     ACPI_DEVICE_NOTIFY,
+						     sony_acpi_notify,
+						     NULL);
+		if (ACPI_FAILURE(status)) {
+			printk(LOG_PFX "unable to install notify handler\n");
+			result = -ENODEV;
+			goto outnotify;
+		}
+	}
+
+	for (item = sony_acpi_values; item->name; ++item) {
+		acpi_handle handle;
+
+		if (!debug && item->debug)
+			continue;
+
+		if (item->acpiget &&
+		    ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
+		    		 item->acpiget, &handle)))
+		    	continue;
+
+		if (item->acpiset &&
+		    ACPI_FAILURE(acpi_get_handle(sony_acpi_handle,
+		    		 item->acpiset, &handle)))
+		    	continue;
+
+		item->proc = create_proc_entry(item->name, 0600,
+					       acpi_device_dir(device));
+		if (!item->proc) {
+			printk(LOG_PFX "unable to create proc entry\n");
+			result = -EIO;
+			goto outproc;
+		}
+
+		item->proc->read_proc = sony_acpi_read;
+		item->proc->write_proc = sony_acpi_write;
+		item->proc->data = item;
+		item->proc->owner = THIS_MODULE;
+	}
+
+	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully installed\n");
+
+	return 0;
+
+outproc:
+	if (debug) {
+		status = acpi_remove_notify_handler(sony_acpi_handle,
+						    ACPI_DEVICE_NOTIFY,
+						    sony_acpi_notify);
+		if (ACPI_FAILURE(status))
+			printk(LOG_PFX "unable to remove notify handler\n");
+	}
+outnotify:
+	for (item = sony_acpi_values; item->name; ++item)
+		if (item->proc)
+			remove_proc_entry(item->name, acpi_device_dir(device));
+outwalk:
+	return result;
+}
+
+
+static int __exit sony_acpi_remove(struct acpi_device *device, int type)
+{
+	acpi_status status;
+	struct sony_acpi_value *item;
+
+	if (debug) {
+		status = acpi_remove_notify_handler(sony_acpi_handle,
+						    ACPI_DEVICE_NOTIFY,
+						    sony_acpi_notify);
+		if (ACPI_FAILURE(status))
+			printk(LOG_PFX "unable to remove notify handler\n");
+	}
+
+	for (item = sony_acpi_values; item->name; ++item)
+		if (item->proc)
+			remove_proc_entry(item->name, acpi_device_dir(device));
+
+	printk(KERN_INFO ACPI_SNC_DRIVER_NAME " successfully removed\n");
+
+	return 0;
+}
+
+static int __init sony_acpi_init(void)
+{
+	int result;
+
+	sony_acpi_dir = proc_mkdir("sony", acpi_root_dir);
+	if (!sony_acpi_dir) {
+		printk(LOG_PFX "unable to create /proc entry\n");
+		return -ENODEV;
+	}
+	sony_acpi_dir->owner = THIS_MODULE;
+
+	result = acpi_bus_register_driver(&sony_acpi_driver);
+	if (result < 0) {
+		remove_proc_entry("sony", acpi_root_dir);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+
+static void __exit sony_acpi_exit(void)
+{
+	acpi_bus_unregister_driver(&sony_acpi_driver);
+	remove_proc_entry("sony", acpi_root_dir);
+}
+
+module_init(sony_acpi_init);
+module_exit(sony_acpi_exit);
--- linux-2.6-linus/drivers/acpi/Kconfig	2005-01-31 16:55:23.000000000 +0100
+++ linux-2.6-stelian/drivers/acpi/Kconfig	2005-02-11 12:10:36.000000000 +0100
@@ -242,6 +242,21 @@
 	  If you have a legacy free Toshiba laptop (such as the Libretto L1
 	  series), say Y.
 
+config ACPI_SONY
+	tristate "Sony Laptop Extras" 
+	depends on X86
+	depends on ACPI_INTERPRETER
+	default m
+	  ---help---
+	  This mini-driver drives the ACPI SNC device present in the
+	  ACPI BIOS of the Sony Vaio laptops.
+
+	  It gives access to some extra laptop functionalities. In
+	  its current form, the only thing this driver does is letting 
+	  the user set or query the screen brightness.
+
+	  Read <file:Documentation/acpi/sony_acpi.txt> for more information.
+
 config ACPI_CUSTOM_DSDT
 	bool "Include Custom DSDT"
 	depends on ACPI_INTERPRETER && !STANDALONE
--- linux-2.6-linus/drivers/acpi/Makefile	2005-01-31 16:55:23.000000000 +0100
+++ linux-2.6-stelian/drivers/acpi/Makefile	2005-01-31 17:00:10.000000000 +0100
@@ -54,4 +54,5 @@
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
+obj-$(CONFIG_ACPI_SONY)		+= sony_acpi.o
 obj-$(CONFIG_ACPI_BUS)		+= scan.o motherboard.o
--- linux-2.6-linus/Documentation/acpi/sony_acpi.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-stelian/Documentation/acpi/sony_acpi.txt	2005-02-16 16:36:24.000000000 +0100
@@ -0,0 +1,87 @@
+ACPI Sony Notebook Control Driver (SNC) Readme
+----------------------------------------------
+	Copyright (C) 2004- 2005 Stelian Pop <stelian@popies.net>
+
+This mini-driver drives the ACPI SNC device present in the 
+ACPI BIOS of the Sony Vaio laptops.
+
+It gives access to some extra laptop functionalities. In 
+its current form, this driver is mainly useful for controlling the
+screen brightness, but it may do more in the future.
+
+You should probably start by trying the sonypi driver, and try
+sony_acpi only if sonypi doesn't work for you.
+
+Usage:
+------
+
+Loading the sony_acpi module will create a /proc/acpi/sony/
+directory populated with a couple of files.
+
+You then read/write integer values from/to those files by using
+standard UNIX tools.
+
+The files are:
+	brightness		current screen brightness
+	brightness_default	screen brightness which will be set
+				when the laptop will be rebooted
+	cdpower			power on/off the internal CD drive
+
+Note that some files may be missing if they are not supported
+by your particular laptop model.
+
+Example usage:
+	# echo "1" > /proc/acpi/sony/brightness
+sets the lowest screen brightness,
+	# echo "8" > /proc/acpi/sony/brightness
+sets the highest screen brightness,
+	# cat /proc/acpi/sony/brightness
+retrieves the current screen brightness.
+
+Development:
+------------
+
+If you want to help with the development of this driver (and
+you are not afraid of any side effects doing strange things with
+your ACPI BIOS could have on your laptop), load the driver and
+pass the option 'debug=1'.
+
+REPEAT: DON'T DO THIS IF YOU DON'T LIKE RISKY BUSINESS.
+
+In your kernel logs you will find the list of all ACPI methods
+the SNC device has on your laptop. You can see the GBRT/SBRT methods
+used to get/set the brightness, but there are others.
+
+I HAVE NO IDEA WHAT THOSE METHODS DO.
+
+The sony_acpi driver creates, for some of those methods (the most 
+current ones found on several Vaio models), an entry under
+/proc/acpi/sony/, just like the 'brightness' one. You can create
+other entries corresponding to your own laptop methods by further
+editing the source (see the 'sony_acpi_values' table, and add a new
+structure to this table with your get/set method names).
+
+Your mission, should you accept it, is to try finding out what 
+those entries are for, by reading/writing random values from/to those
+files and find out what is the impact on your laptop.
+
+Should you find anything interesting, please report it back to me,
+I will not disavow all knowledge of your actions :)
+
+Bugs/Limitations:
+-----------------
+
+* This driver is not based on official documentation from Sony
+  (because there is none), so there is no guarantee this driver
+  will work at all, or do the right thing. Although this hasn't
+  happened to me, this driver could do very bad things to your
+  laptop, including permanent damage.
+  
+* The sony_acpi and sonypi drivers do not interact at all. In the
+  future, sonypi could use sony_acpi to do (part of) its business.
+
+* spicctrl, which is the userspace tool used to communicate with the
+  sonypi driver (through /dev/sonypi) does not try to use the 
+  sony_acpi driver. In the future, spicctrl could try sonypi first, 
+  and if it isn't present, try sony_acpi instead.
+
-- 
Stelian Pop <stelian@popies.net>
