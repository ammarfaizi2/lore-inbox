Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVAECxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVAECxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVAECxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:53:37 -0500
Received: from fmr19.intel.com ([134.134.136.18]:15851 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262221AbVAECvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:51:37 -0500
Subject: [PATCH 1/4]bind physical devices with ACPI devices framework
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@suse.cz>
Content-Type: multipart/mixed; boundary="=-wfwOPoQTLYs8frb4jTsC"
Message-Id: <1104893447.5550.129.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 10:50:50 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wfwOPoQTLYs8frb4jTsC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
This patch implemented the framework for binding physical devices with
ACPI devices. It's based on Pat's suggestion and uses 'platform_notify'
and 'platform_notify_remove' callbacks. It would be better the device
core can unified handle this, but it requires big device core changes,
so we use helper here.
Every physical bus type should provide a helper ACPI bus type and
provides two callbacks.
.find_device:
	For device which has parent such as normal PCI devices.
.find_bridge:
	It's for special devices, such as PCI root bridge and IDE controller.
such devices generally haven't parent or bus type. We use the special
method to get an ACPI handle.

Thanks,
Shaohua

Signed-off-by: Li Shaohua<shaohua.li@intel.com>
---

 2.5-root/drivers/acpi/Makefile   |    2 
 2.5-root/drivers/acpi/glue.c     |  283 +++++++++++++++++++++++++++++++++++++++
 2.5-root/include/acpi/acpi_bus.h |   21 ++
 3 files changed, 305 insertions(+), 1 deletion(-)

diff -puN /dev/null drivers/acpi/glue.c
--- /dev/null	2004-02-24 05:02:56.000000000 +0800
+++ 2.5-root/drivers/acpi/glue.c	2005-01-05 09:56:48.762736416 +0800
@@ -0,0 +1,283 @@
+/*
+ * Link physical devices with ACPI devices support
+ */
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/rwsem.h>
+#include <linux/acpi.h>
+
+#define _COMPONENT              ACPI_BUS_COMPONENT
+ACPI_MODULE_NAME                ("acpi_glue")
+
+static LIST_HEAD(bus_type_list);
+static DECLARE_RWSEM(bus_type_sem);
+
+int register_acpi_bus_type(struct acpi_bus_type *type)
+{
+	if (acpi_disabled)
+		return -ENODEV;
+	if (type && type->bus) {
+		down_write(&bus_type_sem);
+		list_add_tail(&type->list, &bus_type_list);
+		up_write(&bus_type_sem);
+		return 0;
+	}
+	return -ENODEV;
+}
+EXPORT_SYMBOL(register_acpi_bus_type);
+
+int unregister_acpi_bus_type(struct acpi_bus_type *type)
+{
+	if (acpi_disabled)
+		return 0;
+	if (type) {
+		down_write(&bus_type_sem);
+		list_del_init(&type->list);
+		up_write(&bus_type_sem);
+		return 0;
+	}
+	return -ENODEV;
+}
+EXPORT_SYMBOL(unregister_acpi_bus_type);
+
+static struct acpi_bus_type *
+acpi_get_bus_type(struct bus_type *type)
+{
+	struct acpi_bus_type *tmp, *ret = NULL;
+
+	down_read(&bus_type_sem);
+	list_for_each_entry(tmp, &bus_type_list, list) {
+		if (tmp->bus == type) {
+			ret = tmp;
+			break;
+		}
+	}
+	up_read(&bus_type_sem);
+	return ret;
+}
+
+static int
+acpi_find_bridge_device(struct device *dev, acpi_handle *handle)
+{
+	struct acpi_bus_type *tmp;
+	int	ret = -ENODEV;
+
+	down_read(&bus_type_sem);
+	list_for_each_entry(tmp, &bus_type_list, list) {
+		if (tmp->find_bridge && !tmp->find_bridge(dev, handle)) {
+			ret = 0;
+			break;
+		}
+	}
+	up_read(&bus_type_sem);
+	return ret;
+}
+
+/* Get PCI root bridge's handle from its segment and bus number */
+struct acpi_find_pci_root {
+	unsigned int seg;
+	unsigned int bus;
+	acpi_handle handle;
+};
+
+static acpi_status
+find_pci_rootbridge(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	struct acpi_find_pci_root *find = (struct acpi_find_pci_root *)context;
+	unsigned long seg, bus;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL,
+		&seg);
+	if (status == AE_NOT_FOUND) {
+		/* Assume seg = 0 */
+		status = AE_OK;
+		seg = 0;
+	}
+	if (ACPI_FAILURE(status))
+		return AE_CTRL_DEPTH;
+
+	status = acpi_evaluate_integer(handle, METHOD_NAME__BBN, NULL,
+		&bus);
+	if (status == AE_NOT_FOUND) {
+		/* Assume bus = 0 */
+		status = AE_OK;
+		bus = 0;
+	}
+	if (ACPI_FAILURE(status))
+		return AE_CTRL_DEPTH;
+
+	if (seg == find->seg && bus == find->bus)
+		find->handle = handle;
+	return AE_OK;
+}
+
+acpi_handle
+acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
+{
+	struct acpi_find_pci_root find = {seg, bus, NULL};
+
+	acpi_get_devices(PCI_ROOT_HID_STRING,
+		find_pci_rootbridge,
+		&find,
+		NULL);
+	return find.handle;
+}
+
+/* Get device's handler per its address under its parent */
+struct acpi_find_child {
+	acpi_handle     handle;
+	acpi_integer    address;
+};
+
+static acpi_status
+find_child(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	acpi_status     status;
+	struct acpi_device_info *info;
+	struct acpi_buffer      buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_find_child *find = (struct acpi_find_child*)context;
+
+	status = acpi_get_object_info(handle, &buffer);
+	if (ACPI_SUCCESS(status)) {
+		info = buffer.pointer;
+		if (info->address == find->address)
+			find->handle = handle;
+		acpi_os_free(buffer.pointer);
+	}
+	return AE_OK;
+}
+
+acpi_handle
+acpi_get_child(acpi_handle parent, acpi_integer address)
+{
+	struct acpi_find_child find = {NULL, address};
+
+	if (!parent)
+		return NULL;
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, parent,
+		1, find_child,
+		&find, NULL);
+	return find.handle;
+}
+EXPORT_SYMBOL(acpi_get_child);
+
+/* Link ACPI devices with physical devices */
+static void acpi_device_glue_handle(acpi_handle handle, u32 function, void *context)
+{
+	/* do nothing */
+}
+
+/* Note: a success call will increase reference count by one */
+struct device *acpi_get_physical_device(acpi_handle handle)
+{
+	acpi_status status;
+	struct device *dev;
+
+	status = acpi_get_data(handle, acpi_device_glue_handle, (void **)&dev);
+	if (ACPI_SUCCESS(status))
+		return get_device(dev);
+	return NULL;
+}
+EXPORT_SYMBOL(acpi_get_physical_device);
+
+static int acpi_bind_one(struct device *dev, acpi_handle handle)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_bind_one");
+
+	if (dev->platform_data) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+		    "Drivers changed 'platform_data' for %s\n",
+		    dev->bus_id));
+		return_VALUE(-EINVAL);
+	}
+	get_device(dev);
+	status = acpi_attach_data(handle, acpi_device_glue_handle, dev);
+	if (ACPI_FAILURE(status)) {
+		put_device(dev);
+		return_VALUE(-EINVAL);
+	}
+	dev->platform_data = handle;
+
+	return_VALUE(0);
+}
+
+static int acpi_unbind_one(struct device *dev)
+{
+	ACPI_FUNCTION_TRACE("acpi_unbind_one");
+
+	if (!dev->platform_data)
+		return_VALUE(0);
+	if (dev == acpi_get_physical_device(dev->platform_data)) {
+		/* For acpi_get_physical_device */
+		put_device(dev);
+		acpi_detach_data(dev->platform_data, acpi_device_glue_handle);
+		dev->platform_data = NULL;
+		/* For acpi_bind_one */
+		put_device(dev);
+	} else {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+		  "Oops, data corrupt for %s\n", dev->bus_id));
+	}
+	return_VALUE(0);
+}
+
+static int acpi_platform_notify (struct device *dev)
+{
+	struct acpi_bus_type	*type;
+	acpi_handle		handle;
+	int			ret = -EINVAL;
+
+	ACPI_FUNCTION_TRACE("acpi_platform_notify");
+
+	if (!dev->bus || !dev->parent) {
+		/* bridge devices genernally haven't bus or parent */
+		ret = acpi_find_bridge_device(dev, &handle);
+		goto end;
+	}
+	type = acpi_get_bus_type(dev->bus);
+	if (!type) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No ACPI bus support"));
+		ret = -EINVAL;
+		goto end;
+	}
+	if ((ret = type->find_device(dev, &handle)))
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Can't find child"));
+end:
+	if (!ret)
+		acpi_bind_one(dev, handle);
+
+#if 0
+	if (!ret) {
+		struct acpi_buffer      buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+		acpi_get_name(dev->platform_data, ACPI_FULL_PATHNAME, &buffer);
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device %s -> %s\n",
+			dev->bus_id, (char *)buffer.pointer));
+		acpi_os_free(buffer.pointer);
+	} else
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device %s -> No ACPI support\n",
+			dev->bus_id));
+#endif
+
+	return_VALUE(ret);
+}
+
+static int acpi_platform_notify_remove(struct device *dev)
+{
+	acpi_unbind_one(dev);
+	return 0;
+}
+
+static int __init init_acpi_device_notify(void)
+{
+	if (acpi_disabled)
+		return 0;
+	platform_notify = acpi_platform_notify;
+	platform_notify_remove = acpi_platform_notify_remove;
+	return 0;
+}
+arch_initcall(init_acpi_device_notify);
diff -puN drivers/acpi/Makefile~bind-acpi-devcore drivers/acpi/Makefile
--- 2.5/drivers/acpi/Makefile~bind-acpi-devcore	2005-01-05 09:56:48.756737328 +0800
+++ 2.5-root/drivers/acpi/Makefile	2005-01-05 09:56:48.762736416 +0800
@@ -36,7 +36,7 @@ processor-objs	+= processor_perflib.o			
 endif
 
 obj-$(CONFIG_ACPI_BUS)		+= sleep/
-obj-$(CONFIG_ACPI_BUS)		+= bus.o
+obj-$(CONFIG_ACPI_BUS)		+= bus.o glue.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
diff -puN include/acpi/acpi_bus.h~bind-acpi-devcore include/acpi/acpi_bus.h
--- 2.5/include/acpi/acpi_bus.h~bind-acpi-devcore	2005-01-05 09:56:48.758737024 +0800
+++ 2.5-root/include/acpi/acpi_bus.h	2005-01-05 09:56:48.762736416 +0800
@@ -337,6 +337,27 @@ int acpi_match_ids (struct acpi_device	*
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
+
+/*
+ * Bind physical devices with ACPI devices
+ */
+#include <linux/device.h>
+struct acpi_bus_type {
+	struct list_head	list;
+	struct bus_type		*bus;
+	/* For general devices under the bus*/
+	int (*find_device)(struct device *, acpi_handle*);
+	/* For bridges, such as PCI root bridge, IDE controller */
+	int (*find_bridge)(struct device *, acpi_handle *);
+};
+int register_acpi_bus_type(struct acpi_bus_type *);
+int unregister_acpi_bus_type(struct acpi_bus_type *);
+struct device *acpi_get_physical_device(acpi_handle);
+/* helper */
+acpi_handle acpi_get_child(acpi_handle, acpi_integer);
+acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
+#define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->platform_data))
+
 #endif /*CONFIG_ACPI_BUS*/
 
 #endif /*__ACPI_BUS_H__*/
_


--=-wfwOPoQTLYs8frb4jTsC
Content-Disposition: attachment; filename=p00001_bind-acpi-devcore.patch
Content-Type: text/x-patch; name=p00001_bind-acpi-devcore.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


This patch implemented the framework for binding physical devices with ACPI
devices. A physical bus like PCI bus should create a 'acpi_bus_type'.
The method in 'acpi_bus_type':
.find_device:
	For device which has parent such as normal PCI devices.
.find_bridge:
	It's for special devices, such as PCI root bridge and IDE controller. 
such devices generally haven't parent or ->bus. We use the special method 
to get an ACPI handle.

---

 2.5-root/drivers/acpi/Makefile   |    2 
 2.5-root/drivers/acpi/glue.c     |  283 +++++++++++++++++++++++++++++++++++++++
 2.5-root/include/acpi/acpi_bus.h |   21 ++
 3 files changed, 305 insertions(+), 1 deletion(-)

diff -puN /dev/null drivers/acpi/glue.c
--- /dev/null	2004-02-24 05:02:56.000000000 +0800
+++ 2.5-root/drivers/acpi/glue.c	2005-01-05 09:56:48.762736416 +0800
@@ -0,0 +1,283 @@
+/*
+ * Link physical devices with ACPI devices support
+ */
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/rwsem.h>
+#include <linux/acpi.h>
+
+#define _COMPONENT              ACPI_BUS_COMPONENT
+ACPI_MODULE_NAME                ("acpi_glue")
+
+static LIST_HEAD(bus_type_list);
+static DECLARE_RWSEM(bus_type_sem);
+
+int register_acpi_bus_type(struct acpi_bus_type *type)
+{
+	if (acpi_disabled)
+		return -ENODEV;
+	if (type && type->bus) {
+		down_write(&bus_type_sem);
+		list_add_tail(&type->list, &bus_type_list);
+		up_write(&bus_type_sem);
+		return 0;
+	}
+	return -ENODEV;
+}
+EXPORT_SYMBOL(register_acpi_bus_type);
+
+int unregister_acpi_bus_type(struct acpi_bus_type *type)
+{
+	if (acpi_disabled)
+		return 0;
+	if (type) {
+		down_write(&bus_type_sem);
+		list_del_init(&type->list);
+		up_write(&bus_type_sem);
+		return 0;
+	}
+	return -ENODEV;
+}
+EXPORT_SYMBOL(unregister_acpi_bus_type);
+
+static struct acpi_bus_type *
+acpi_get_bus_type(struct bus_type *type)
+{
+	struct acpi_bus_type *tmp, *ret = NULL;
+
+	down_read(&bus_type_sem);
+	list_for_each_entry(tmp, &bus_type_list, list) {
+		if (tmp->bus == type) {
+			ret = tmp;
+			break;
+		}
+	}
+	up_read(&bus_type_sem);
+	return ret;
+}
+
+static int
+acpi_find_bridge_device(struct device *dev, acpi_handle *handle)
+{
+	struct acpi_bus_type *tmp;
+	int	ret = -ENODEV;
+
+	down_read(&bus_type_sem);
+	list_for_each_entry(tmp, &bus_type_list, list) {
+		if (tmp->find_bridge && !tmp->find_bridge(dev, handle)) {
+			ret = 0;
+			break;
+		}
+	}
+	up_read(&bus_type_sem);
+	return ret;
+}
+
+/* Get PCI root bridge's handle from its segment and bus number */
+struct acpi_find_pci_root {
+	unsigned int seg;
+	unsigned int bus;
+	acpi_handle handle;
+};
+
+static acpi_status
+find_pci_rootbridge(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	struct acpi_find_pci_root *find = (struct acpi_find_pci_root *)context;
+	unsigned long seg, bus;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL,
+		&seg);
+	if (status == AE_NOT_FOUND) {
+		/* Assume seg = 0 */
+		status = AE_OK;
+		seg = 0;
+	}
+	if (ACPI_FAILURE(status))
+		return AE_CTRL_DEPTH;
+
+	status = acpi_evaluate_integer(handle, METHOD_NAME__BBN, NULL,
+		&bus);
+	if (status == AE_NOT_FOUND) {
+		/* Assume bus = 0 */
+		status = AE_OK;
+		bus = 0;
+	}
+	if (ACPI_FAILURE(status))
+		return AE_CTRL_DEPTH;
+
+	if (seg == find->seg && bus == find->bus)
+		find->handle = handle;
+	return AE_OK;
+}
+
+acpi_handle
+acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
+{
+	struct acpi_find_pci_root find = {seg, bus, NULL};
+
+	acpi_get_devices(PCI_ROOT_HID_STRING,
+		find_pci_rootbridge,
+		&find,
+		NULL);
+	return find.handle;
+}
+
+/* Get device's handler per its address under its parent */
+struct acpi_find_child {
+	acpi_handle     handle;
+	acpi_integer    address;
+};
+
+static acpi_status
+find_child(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	acpi_status     status;
+	struct acpi_device_info *info;
+	struct acpi_buffer      buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_find_child *find = (struct acpi_find_child*)context;
+
+	status = acpi_get_object_info(handle, &buffer);
+	if (ACPI_SUCCESS(status)) {
+		info = buffer.pointer;
+		if (info->address == find->address)
+			find->handle = handle;
+		acpi_os_free(buffer.pointer);
+	}
+	return AE_OK;
+}
+
+acpi_handle
+acpi_get_child(acpi_handle parent, acpi_integer address)
+{
+	struct acpi_find_child find = {NULL, address};
+
+	if (!parent)
+		return NULL;
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, parent,
+		1, find_child,
+		&find, NULL);
+	return find.handle;
+}
+EXPORT_SYMBOL(acpi_get_child);
+
+/* Link ACPI devices with physical devices */
+static void acpi_device_glue_handle(acpi_handle handle, u32 function, void *context)
+{
+	/* do nothing */
+}
+
+/* Note: a success call will increase reference count by one */
+struct device *acpi_get_physical_device(acpi_handle handle)
+{
+	acpi_status status;
+	struct device *dev;
+
+	status = acpi_get_data(handle, acpi_device_glue_handle, (void **)&dev);
+	if (ACPI_SUCCESS(status))
+		return get_device(dev);
+	return NULL;
+}
+EXPORT_SYMBOL(acpi_get_physical_device);
+
+static int acpi_bind_one(struct device *dev, acpi_handle handle)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_bind_one");
+
+	if (dev->platform_data) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+		    "Drivers changed 'platform_data' for %s\n",
+		    dev->bus_id));
+		return_VALUE(-EINVAL);
+	}
+	get_device(dev);
+	status = acpi_attach_data(handle, acpi_device_glue_handle, dev);
+	if (ACPI_FAILURE(status)) {
+		put_device(dev);
+		return_VALUE(-EINVAL);
+	}
+	dev->platform_data = handle;
+
+	return_VALUE(0);
+}
+
+static int acpi_unbind_one(struct device *dev)
+{
+	ACPI_FUNCTION_TRACE("acpi_unbind_one");
+
+	if (!dev->platform_data)
+		return_VALUE(0);
+	if (dev == acpi_get_physical_device(dev->platform_data)) {
+		/* For acpi_get_physical_device */
+		put_device(dev);
+		acpi_detach_data(dev->platform_data, acpi_device_glue_handle);
+		dev->platform_data = NULL;
+		/* For acpi_bind_one */
+		put_device(dev);
+	} else {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+		  "Oops, data corrupt for %s\n", dev->bus_id));
+	}
+	return_VALUE(0);
+}
+
+static int acpi_platform_notify (struct device *dev)
+{
+	struct acpi_bus_type	*type;
+	acpi_handle		handle;
+	int			ret = -EINVAL;
+
+	ACPI_FUNCTION_TRACE("acpi_platform_notify");
+
+	if (!dev->bus || !dev->parent) {
+		/* bridge devices genernally haven't bus or parent */
+		ret = acpi_find_bridge_device(dev, &handle);
+		goto end;
+	}
+	type = acpi_get_bus_type(dev->bus);
+	if (!type) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No ACPI bus support"));
+		ret = -EINVAL;
+		goto end;
+	}
+	if ((ret = type->find_device(dev, &handle)))
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Can't find child"));
+end:
+	if (!ret)
+		acpi_bind_one(dev, handle);
+
+#if 0
+	if (!ret) {
+		struct acpi_buffer      buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+		acpi_get_name(dev->platform_data, ACPI_FULL_PATHNAME, &buffer);
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device %s -> %s\n",
+			dev->bus_id, (char *)buffer.pointer));
+		acpi_os_free(buffer.pointer);
+	} else
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device %s -> No ACPI support\n",
+			dev->bus_id));
+#endif
+
+	return_VALUE(ret);
+}
+
+static int acpi_platform_notify_remove(struct device *dev)
+{
+	acpi_unbind_one(dev);
+	return 0;
+}
+
+static int __init init_acpi_device_notify(void)
+{
+	if (acpi_disabled)
+		return 0;
+	platform_notify = acpi_platform_notify;
+	platform_notify_remove = acpi_platform_notify_remove;
+	return 0;
+}
+arch_initcall(init_acpi_device_notify);
diff -puN drivers/acpi/Makefile~bind-acpi-devcore drivers/acpi/Makefile
--- 2.5/drivers/acpi/Makefile~bind-acpi-devcore	2005-01-05 09:56:48.756737328 +0800
+++ 2.5-root/drivers/acpi/Makefile	2005-01-05 09:56:48.762736416 +0800
@@ -36,7 +36,7 @@ processor-objs	+= processor_perflib.o			
 endif
 
 obj-$(CONFIG_ACPI_BUS)		+= sleep/
-obj-$(CONFIG_ACPI_BUS)		+= bus.o
+obj-$(CONFIG_ACPI_BUS)		+= bus.o glue.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
diff -puN include/acpi/acpi_bus.h~bind-acpi-devcore include/acpi/acpi_bus.h
--- 2.5/include/acpi/acpi_bus.h~bind-acpi-devcore	2005-01-05 09:56:48.758737024 +0800
+++ 2.5-root/include/acpi/acpi_bus.h	2005-01-05 09:56:48.762736416 +0800
@@ -337,6 +337,27 @@ int acpi_match_ids (struct acpi_device	*
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
+
+/*
+ * Bind physical devices with ACPI devices
+ */
+#include <linux/device.h>
+struct acpi_bus_type {
+	struct list_head	list;
+	struct bus_type		*bus;
+	/* For general devices under the bus*/
+	int (*find_device)(struct device *, acpi_handle*);
+	/* For bridges, such as PCI root bridge, IDE controller */
+	int (*find_bridge)(struct device *, acpi_handle *);
+};
+int register_acpi_bus_type(struct acpi_bus_type *);
+int unregister_acpi_bus_type(struct acpi_bus_type *);
+struct device *acpi_get_physical_device(acpi_handle);
+/* helper */
+acpi_handle acpi_get_child(acpi_handle, acpi_integer);
+acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
+#define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->platform_data))
+
 #endif /*CONFIG_ACPI_BUS*/
 
 #endif /*__ACPI_BUS_H__*/
_

--=-wfwOPoQTLYs8frb4jTsC--

