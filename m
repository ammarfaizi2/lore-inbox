Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422700AbWIGXNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbWIGXNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422698AbWIGXNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:13:22 -0400
Received: from mga03.intel.com ([143.182.124.21]:56598 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1422697AbWIGXNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:13:19 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,227,1154934000"; 
   d="scan'208"; a="113452043:sNHT171316341"
Date: Thu, 7 Sep 2006 16:13:19 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com
Subject: [patch 2/2]: acpi: add removable drive bay support
Message-Id: <20060907161319.5495fc65.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds generic removable drive bay support.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Index: 2.6-git/drivers/acpi/bay.c
===================================================================
--- /dev/null
+++ 2.6-git/drivers/acpi/bay.c
@@ -0,0 +1,592 @@
+/*
+ *  bay.c - ACPI removable drive bay driver
+ *
+ *  Copyright (C) 2006 Kristen Carlson Accardi <kristen.c.accardi@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/notifier.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <asm/uaccess.h>
+
+#define ACPI_BAY_DRIVER_NAME "ACPI Removable Drive Bay Driver"
+
+ACPI_MODULE_NAME("bay")
+MODULE_AUTHOR("Kristen Carlson Accardi");
+MODULE_DESCRIPTION(ACPI_BAY_DRIVER_NAME);
+MODULE_LICENSE("GPL");
+#define ACPI_BAY_CLASS "bay"
+#define ACPI_BAY_COMPONENT	0x10000000
+#define _COMPONENT ACPI_BAY_COMPONENT
+#define bay_dprintk(h,s) {\
+	char prefix[80] = {'\0'};\
+	struct acpi_buffer buffer = {sizeof(prefix), prefix};\
+	acpi_get_name(h, ACPI_FULL_PATHNAME, &buffer);\
+	printk(KERN_DEBUG PREFIX "%s: %s\n", prefix, s); }
+
+static void bay_notify(acpi_handle handle, u32 event, void *data);
+static int acpi_bay_add(struct acpi_device *device);
+static int acpi_bay_remove(struct acpi_device *device, int type);
+static int acpi_bay_match(struct acpi_device *device,
+				struct acpi_driver *driver);
+
+static struct acpi_driver acpi_bay_driver = {
+	.name = ACPI_BAY_DRIVER_NAME,
+	.class = ACPI_BAY_CLASS,
+	.ops = {
+		.add = acpi_bay_add,
+		.remove = acpi_bay_remove,
+		.match = acpi_bay_match,
+		},
+};
+
+struct bay {
+	acpi_handle handle;
+	char *name;
+	struct list_head list;
+	struct proc_dir_entry *proc;
+};
+
+LIST_HEAD(drive_bays);
+
+static struct proc_dir_entry *acpi_bay_dir;
+
+/*****************************************************************************
+ *                         Drive Bay functions                               *
+ *****************************************************************************/
+/**
+ * is_ejectable - see if a device is ejectable
+ * @handle: acpi handle of the device
+ *
+ * If an acpi object has a _EJ0 method, then it is ejectable
+ */
+static int is_ejectable(acpi_handle handle)
+{
+	acpi_status status;
+	acpi_handle tmp;
+
+	status = acpi_get_handle(handle, "_EJ0", &tmp);
+	if (ACPI_FAILURE(status))
+		return 0;
+	return 1;
+}
+
+/**
+ * bay_present - see if the bay device is present
+ * @bay: the drive bay
+ *
+ * execute the _STA method.
+ */
+static int bay_present(struct bay *bay)
+{
+	unsigned long sta;
+	acpi_status status;
+
+	if (bay) {
+		status = acpi_evaluate_integer(bay->handle, "_STA", NULL, &sta);
+		if (ACPI_SUCCESS(status) && sta)
+			return 1;
+	}
+	return 0;
+}
+
+/**
+ * eject_device - respond to an eject request
+ * @handle - the device to eject
+ *
+ * Call this devices _EJ0 method.
+ */
+static void eject_device(acpi_handle handle)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+
+	bay_dprintk(handle, "Ejecting device");
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = 1;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_EJ0",
+					      &arg_list, NULL)))
+		pr_debug("Failed to evaluate _EJ0!\n");
+}
+
+
+/**
+ * is_ata - see if a device is an ata device
+ * @handle: acpi handle of the device
+ *
+ * If an acpi object has one of 4 ATA ACPI methods defined,
+ * then it is an ATA device
+ */
+static int is_ata(acpi_handle handle)
+{
+	acpi_handle tmp;
+
+	if ((ACPI_SUCCESS(acpi_get_handle(handle, "_GTF", &tmp))) ||
+	   (ACPI_SUCCESS(acpi_get_handle(handle, "_GTM", &tmp))) ||
+	   (ACPI_SUCCESS(acpi_get_handle(handle, "_STM", &tmp))) ||
+	   (ACPI_SUCCESS(acpi_get_handle(handle, "_SDD", &tmp))))
+		return 1;
+
+	return 0;
+}
+
+/**
+ * parent_is_ata(acpi_handle handle)
+ *
+ */
+static int parent_is_ata(acpi_handle handle)
+{
+	acpi_handle phandle;
+
+	if (acpi_get_parent(handle, &phandle))
+		return 0;
+
+	return is_ata(phandle);
+}
+
+/**
+ * is_ejectable_bay - see if a device is an ejectable drive bay
+ * @handle: acpi handle of the device
+ *
+ * If an acpi object is ejectable and has one of the ACPI ATA
+ * methods defined, then we can safely call it an ejectable
+ * drive bay
+ */
+static int is_ejectable_bay(acpi_handle handle)
+{
+	if ((is_ata(handle) || parent_is_ata(handle)) && is_ejectable(handle))
+		return 1;
+	return 0;
+}
+
+/**
+ * eject_removable_drive - try to eject this drive
+ * @dev : the device structure of the drive
+ *
+ * If a device is a removable drive that requires an _EJ0 method
+ * to be executed in order to safely remove from the system, do
+ * it.  ATM - always returns success
+ */
+int eject_removable_drive(struct device *dev)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
+
+	if (handle) {
+		bay_dprintk(handle, "Got device handle");
+		if (is_ejectable_bay(handle))
+			eject_device(handle);
+	} else {
+		printk("No acpi handle for device\n");
+	}
+
+	/* should I return an error code? */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(eject_removable_drive);
+
+static int acpi_bay_add(struct acpi_device *device)
+{
+	bay_dprintk(device->handle, "adding bay device");
+	strcpy(acpi_device_name(device), "Dockable Bay");
+	strcpy(acpi_device_class(device), "bay");
+	return 0;
+}
+
+static int acpi_bay_status_seq_show(struct seq_file *seq, void *offset)
+{
+	struct bay *bay = (struct bay *)seq->private;
+
+	if (!bay)
+		return 0;
+
+	if (bay_present(bay))
+		seq_printf(seq, "present\n");
+	else
+		seq_printf(seq, "removed\n");
+
+	return 0;
+}
+
+static ssize_t
+acpi_bay_write_eject(struct file *file,
+		      const char __user * buffer,
+		      size_t count, loff_t * data)
+{
+	struct seq_file *m = (struct seq_file *)file->private_data;
+	struct bay *bay = (struct bay *)m->private;
+	char str[12] = { 0 };
+	u32 state = 0;
+
+	/* FIXME - our only valid value here is 1 */
+	if (!bay || count + 1 > sizeof str)
+		return -EINVAL;
+
+	if (copy_from_user(str, buffer, count))
+		return -EFAULT;
+
+	str[count] = 0;
+	state = simple_strtoul(str, NULL, 0);
+	if (state)
+		eject_device(bay->handle);
+
+	return count;
+}
+
+static int
+acpi_bay_status_open_fs(struct inode *inode, struct file *file)
+{
+	return single_open(file, acpi_bay_status_seq_show,
+			   PDE(inode)->data);
+}
+
+static int
+acpi_bay_eject_open_fs(struct inode *inode, struct file *file)
+{
+	return single_open(file, acpi_bay_status_seq_show,
+			   PDE(inode)->data);
+}
+
+static struct file_operations acpi_bay_status_fops = {
+	.open = acpi_bay_status_open_fs,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static struct file_operations acpi_bay_eject_fops = {
+	.open = acpi_bay_eject_open_fs,
+	.read = seq_read,
+	.write = acpi_bay_write_eject,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+#if 0
+static struct file_operations acpi_bay_insert_fops = {
+	.open = acpi_bay_insert_open_fs,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+#endif
+static int acpi_bay_add_fs(struct bay *bay)
+{
+	struct proc_dir_entry *entry = NULL;
+
+	if (!bay)
+		return -EINVAL;
+
+	/*
+	 * create a proc entry for this device
+	 * we need to do this a little bit differently than normal
+  	 * acpi device drivers because our device may not be present
+	 * at the moment, and therefore we have no acpi_device struct
+	 */
+
+	bay->proc = proc_mkdir(bay->name, acpi_bay_dir);
+
+	/* 'status' [R] */
+	entry = create_proc_entry("status",
+				  S_IRUGO, bay->proc);
+	if (!entry)
+		return -EIO;
+	else {
+		entry->proc_fops = &acpi_bay_status_fops;
+		entry->data = bay;
+		entry->owner = THIS_MODULE;
+	}
+	/* 'eject' [W] */
+	entry = create_proc_entry("eject",
+				  S_IWUGO, bay->proc);
+	if (!entry)
+		return -EIO;
+	else {
+		entry->proc_fops = &acpi_bay_eject_fops;
+		entry->data = bay;
+		entry->owner = THIS_MODULE;
+	}
+#if 0
+	/* 'insert' [W] */
+	entry = create_proc_entry("insert",
+				  S_IWUGO, bay->proc);
+	if (!entry)
+		return -EIO;
+	else {
+		entry->proc_fops = &acpi_bay_insert_fops;
+		entry->data = bay;
+		entry->owner = THIS_MODULE;
+	}
+#endif
+	return 0;
+}
+
+static void acpi_bay_remove_fs(struct bay *bay)
+{
+	if (!bay)
+		return;
+
+	if (bay->proc) {
+		remove_proc_entry("status", bay->proc);
+		remove_proc_entry("eject", bay->proc);
+#if 0
+		remove_proc_entry("insert", bay->proc);
+#endif
+		remove_proc_entry(bay->name, acpi_bay_dir);
+		bay->proc = NULL;
+	}
+}
+
+static int bay_is_dock_device(acpi_handle handle)
+{
+	acpi_handle parent;
+
+	acpi_get_parent(handle, &parent);
+
+	/* if the device or it's parent is dependent on the
+	 * dock, then we are a dock device
+	 */
+	return (is_dock_device(handle) || is_dock_device(parent));
+}
+
+static int bay_add(acpi_handle handle)
+{
+	acpi_status status;
+	struct bay *new_bay;
+	struct acpi_buffer nbuffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_get_name(handle, ACPI_FULL_PATHNAME, &nbuffer);
+
+	bay_dprintk(handle, "Adding notify handler");
+
+	/*
+	 * if this is the first bay device found, make the root
+	 * proc entry
+	 */
+	if (acpi_bay_dir == NULL)
+		acpi_bay_dir = proc_mkdir(ACPI_BAY_CLASS, acpi_root_dir);
+
+	/*
+	 * Initialize bay device structure
+	 */
+	new_bay = kmalloc(GFP_ATOMIC, sizeof(*new_bay));
+	INIT_LIST_HEAD(&new_bay->list);
+	new_bay->handle = handle;
+	new_bay->name = (char *)nbuffer.pointer;
+	list_add(&new_bay->list, &drive_bays);
+	acpi_bay_add_fs(new_bay);
+
+	/* register for events on this device */
+	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+			bay_notify, new_bay);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX "Error installing bay notify handler\n");
+	}
+
+	/* if we are on a dock station, we should register for dock
+	 * notifications.
+	 */
+	if (bay_is_dock_device(handle)) {
+		bay_dprintk(handle, "Is dependent on dock\n");
+		register_hotplug_dock_device(handle, bay_notify, new_bay);
+	}
+	printk(KERN_INFO PREFIX "Bay [%s] Added\n", new_bay->name);
+	return 0;
+}
+
+static int acpi_bay_remove(struct acpi_device *device, int type)
+{
+	/*** FIXME: do something here */
+	return 0;
+}
+
+static int acpi_bay_match(struct acpi_device *device,
+				struct acpi_driver *driver)
+{
+	if (!device || !driver)
+		return -EINVAL;
+
+	if (is_ejectable_bay(device->handle)) {
+		bay_dprintk(device->handle, "matching bay device");
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * bay_create_acpi_device - add new devices to acpi
+ * @handle - handle of the device to add
+ *
+ *  This function will create a new acpi_device for the given
+ *  handle if one does not exist already.  This should cause
+ *  acpi to scan for drivers for the given devices, and call
+ *  matching driver's add routine.
+ *
+ *  Returns a pointer to the acpi_device corresponding to the handle.
+ */
+static struct acpi_device * bay_create_acpi_device(acpi_handle handle)
+{
+	struct acpi_device *device = NULL;
+	struct acpi_device *parent_device;
+	acpi_handle parent;
+	int ret;
+
+	bay_dprintk(handle, "Trying to get device");
+	if (acpi_bus_get_device(handle, &device)) {
+		/*
+		 * no device created for this object,
+		 * so we should create one.
+		 */
+		bay_dprintk(handle, "No device for handle");
+		acpi_get_parent(handle, &parent);
+		if (acpi_bus_get_device(parent, &parent_device))
+			parent_device = NULL;
+
+		ret = acpi_bus_add(&device, parent_device, handle,
+			ACPI_BUS_TYPE_DEVICE);
+		if (ret) {
+			pr_debug("error adding bus, %x\n",
+				-ret);
+			return NULL;
+		}
+	}
+	return device;
+}
+
+/**
+ * bay_notify - act upon an acpi bay notification
+ * @handle: the bay handle
+ * @event: the acpi event
+ * @data: our driver data struct
+ *
+ */
+static void bay_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_device *dev;
+	struct bay *bay = data;
+
+	bay_dprintk(handle, "Bay event");
+
+	switch(event) {
+	case ACPI_NOTIFY_BUS_CHECK:
+		printk("Bus Check\n");
+	case ACPI_NOTIFY_DEVICE_CHECK:
+		printk("Device Check\n");
+		dev = bay_create_acpi_device(handle);
+		if (dev)
+			acpi_bus_generate_event(dev, event, 0);
+		else
+			printk("No device for generating event\n");
+		/* wouldn't it be a good idea to just rescan SATA
+		 * right here?
+		 */
+		break;
+	case ACPI_NOTIFY_EJECT_REQUEST:
+		printk("Eject request\n");
+		dev = bay_create_acpi_device(handle);
+		if (dev)
+			acpi_bus_generate_event(dev, event, 0);
+		else
+			printk("No device for generating eventn");
+
+		/* wouldn't it be a good idea to just call the
+		 * eject_device here if we were a SATA device?
+		 */
+		break;
+	default:
+		printk("unknown event %d\n", event);
+	}
+}
+
+static acpi_status
+find_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	int *count = (int *)context;
+
+	/*
+	 * there could be more than one ejectable bay.
+	 * so, just return AE_OK always so that every object
+	 * will be checked.
+	 */
+	if (is_ejectable_bay(handle)) {
+		bay_dprintk(handle, "found ejectable bay");
+		bay_add(handle);
+		(*count)++;
+	}
+	return AE_OK;
+}
+
+static int __init bay_init(void)
+{
+	int bays = 0;
+
+	acpi_bay_dir = NULL;
+	INIT_LIST_HEAD(&drive_bays);
+
+	/* look for dockable drive bays */
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+		ACPI_UINT32_MAX, find_bay, &bays, NULL);
+
+	if (bays) {
+		if ((acpi_bus_register_driver(&acpi_bay_driver) < 0)) {
+			printk(KERN_ERR "Unable to register bay driver\n");
+			if (acpi_bay_dir)
+				remove_proc_entry(ACPI_BAY_CLASS,
+					acpi_root_dir);
+		}
+	}
+
+	if (!bays)
+		return -ENODEV;
+
+	return 0;
+}
+
+static void __exit bay_exit(void)
+{
+	struct bay *bay, *tmp;
+
+	list_for_each_entry_safe(bay, tmp, &drive_bays, list) {
+		if (is_dock_device(bay->handle))
+			unregister_hotplug_dock_device(bay->handle);
+		acpi_bay_remove_fs(bay);
+		acpi_remove_notify_handler(bay->handle, ACPI_SYSTEM_NOTIFY,
+			bay_notify);
+		kfree(bay->name);
+		kfree(bay);
+	}
+
+	if (acpi_bay_dir)
+		remove_proc_entry(ACPI_BAY_CLASS, acpi_root_dir);
+
+	acpi_bus_unregister_driver(&acpi_bay_driver);
+}
+
+postcore_initcall(bay_init);
+module_exit(bay_exit);
+
Index: 2.6-git/drivers/acpi/Kconfig
===================================================================
--- 2.6-git.orig/drivers/acpi/Kconfig
+++ 2.6-git/drivers/acpi/Kconfig
@@ -138,6 +138,13 @@ config ACPI_DOCK
 	help
 	  This driver adds support for ACPI controlled docking stations
 
+config ACPI_BAY
+	tristate "Removable Drive Bay"
+	depends on EXPERIMENTAL
+	help
+	  This driver adds support for ACPI controlled removable drive
+	  bays such as the IBM ultrabay or the Dell Module Bay.
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	default y
Index: 2.6-git/drivers/acpi/Makefile
===================================================================
--- 2.6-git.orig/drivers/acpi/Makefile
+++ 2.6-git/drivers/acpi/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_ACPI_BUTTON)	+= button.o
 obj-$(CONFIG_ACPI_EC)		+= ec.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_DOCK)		+= dock.o
+obj-$(CONFIG_ACPI_BAY)		+= bay.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o 
 obj-$(CONFIG_ACPI_HOTKEY)	+= hotkey.o
 obj-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
