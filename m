Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVAQH7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVAQH7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 02:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVAQH7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 02:59:24 -0500
Received: from fmr19.intel.com ([134.134.136.18]:44185 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261287AbVAQH6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 02:58:09 -0500
Subject: Re: [PATCH 0/4]Bind physical devices with ACPI devices - take 2
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <1104893444.5550.127.camel@sli10-desk.sh.intel.com>
References: <1104893444.5550.127.camel@sli10-desk.sh.intel.com>
Content-Type: multipart/mixed; boundary="=-I3ioaI1IvYgxsXQszNAe"
Message-Id: <1105948622.17633.6.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 17 Jan 2005 15:57:02 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I3ioaI1IvYgxsXQszNAe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-01-05 at 10:50, Li Shaohua wrote:
> Hi,
> The series of patches implement binding physical devices with ACPI
> devices. With it, device drivers can utilize methods provided by
> firmware (ACPI). These patches are against 2.6.10, please give your
> comments.
Hi,
This is updated patches according to latest discussion.
Changes from last one:
1. introduce new field 'firmware_data' in 'struct device', since people
complain rename 'platform_data. Greg, could you please check if the
comments I added in 'struct device' are correct?
2. align to Pavel's latest PCI state convention work.
3. Some cleanups and add more comments.
One issue is 'platform_pci_choose_state' doesn't get called, it should
be after Pavel updates the parameter of 'pci_choose_state'

Thanks,
Shaohua


--=-I3ioaI1IvYgxsXQszNAe
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
 2.5-root/drivers/acpi/glue.c     |  360 +++++++++++++++++++++++++++++++++++++++
 2.5-root/drivers/acpi/ibm_acpi.c |    4 
 2.5-root/include/acpi/acpi_bus.h |   21 ++
 2.5-root/include/linux/device.h  |    6 
 5 files changed, 388 insertions(+), 5 deletions(-)

diff -puN /dev/null drivers/acpi/glue.c
--- /dev/null	2004-02-24 05:02:56.000000000 +0800
+++ 2.5-root/drivers/acpi/glue.c	2005-01-17 12:52:16.825046520 +0800
@@ -0,0 +1,360 @@
+/*
+ * Link physical devices with ACPI devices support
+ */
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/rwsem.h>
+#include <linux/acpi.h>
+
+#define ACPI_GLUE_DEBUG	0
+#if ACPI_GLUE_DEBUG
+#define DBG(x...) printk(PREFIX x)
+#else
+#define DBG(x...)
+#endif
+static LIST_HEAD(bus_type_list);
+static DECLARE_RWSEM(bus_type_sem);
+
+int register_acpi_bus_type(struct acpi_bus_type *type)
+{
+	if (acpi_disabled)
+		return -ENODEV;
+	if (type && type->bus && type->find_device) {
+		down_write(&bus_type_sem);
+		list_add_tail(&type->list, &bus_type_list);
+		up_write(&bus_type_sem);
+		DBG("ACPI bus type %s registered\n", type->bus->name);
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
+		DBG("ACPI bus type %s unregistered\n", type->bus->name);
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
+do_root_bridge_busnr_callback (struct acpi_resource *resource, void *data)
+{
+	int *busnr = (int *)data;
+	struct acpi_resource_address64 address;
+
+	if (resource->id != ACPI_RSTYPE_ADDRESS16 &&
+	    resource->id != ACPI_RSTYPE_ADDRESS32 &&
+	    resource->id != ACPI_RSTYPE_ADDRESS64)
+		return AE_OK;
+
+	acpi_resource_to_address64(resource, &address);
+	if ((address.address_length > 0) &&
+	   (address.resource_type == ACPI_BUS_NUMBER_RANGE))
+		*busnr = address.min_address_range;
+
+	return AE_OK;
+}
+
+static int
+get_root_bridge_busnr(acpi_handle handle)
+{
+	acpi_status status;
+	int bus, bbn;
+	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+
+	status = acpi_evaluate_integer(handle, METHOD_NAME__BBN, NULL,
+		(unsigned long *)&bbn);
+	if (status == AE_NOT_FOUND) {
+		/* Assume bus = 0 */
+		printk(KERN_INFO PREFIX
+			"Assume root bridge [%s] bus is 0\n",
+			(char *)buffer.pointer);
+		status = AE_OK;
+		bbn = 0;
+	}
+	if (ACPI_FAILURE(status)) {
+		bbn = -ENODEV;
+		goto exit;
+	}
+	if (bbn > 0)
+		goto exit;
+
+	/* _BBN in some systems return 0 for all root bridges */
+	bus = -1;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+		do_root_bridge_busnr_callback, &bus);
+	/* If _CRS failed, we just use _BBN */
+	if (ACPI_FAILURE(status) || (bus == -1))
+		goto exit;
+	/* We select _CRS */
+	if (bbn != bus) {
+		printk(KERN_INFO PREFIX
+			"_BBN and _CRS returns different value for %s. Select _CRS\n",
+			(char*)buffer.pointer);
+		bbn = bus;
+	}
+exit:
+	acpi_os_free(buffer.pointer);
+	return bbn;
+}
+
+static acpi_status
+find_pci_rootbridge(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	struct acpi_find_pci_root *find = (struct acpi_find_pci_root *)context;
+	unsigned long seg, bus;
+	acpi_status status;
+	int tmp;
+	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+
+	status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL,
+		&seg);
+	if (status == AE_NOT_FOUND) {
+		/* Assume seg = 0 */
+		printk(KERN_INFO PREFIX
+			"Assume root bridge [%s] segment is 0\n",
+			(char *)buffer.pointer);
+		status = AE_OK;
+		seg = 0;
+	}
+	if (ACPI_FAILURE(status)) {
+		status = AE_CTRL_DEPTH;
+		goto exit;
+	}
+
+	tmp = get_root_bridge_busnr(handle);
+	if (tmp < 0) {
+		printk(KERN_ERR PREFIX
+			"Find root bridge failed for %s\n",
+			(char*)buffer.pointer);
+		status = AE_CTRL_DEPTH;
+		goto exit;
+	}
+	bus = tmp;
+
+	if (seg == find->seg && bus == find->bus)
+		find->handle = handle;
+	status = AE_OK;
+exit:
+	acpi_os_free(buffer.pointer);
+	return status;
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
+do_acpi_find_child(acpi_handle handle, u32 lvl, void *context, void **rv)
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
+		1, do_acpi_find_child,
+		&find, NULL);
+	return find.handle;
+}
+EXPORT_SYMBOL(acpi_get_child);
+
+/* Link ACPI devices with physical devices */
+static void acpi_glue_data_handler(acpi_handle handle,
+	u32 function, void *context)
+{
+	/* we provide an empty handler */
+}
+
+/* Note: a success call will increase reference count by one */
+struct device *acpi_get_physical_device(acpi_handle handle)
+{
+	acpi_status status;
+	struct device *dev;
+
+	status = acpi_get_data(handle, acpi_glue_data_handler, (void **)&dev);
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
+	if (dev->firmware_data) {
+		printk(KERN_WARNING PREFIX
+		   "Drivers changed 'firmware_data' for %s\n", dev->bus_id);
+		return -EINVAL;
+	}
+	get_device(dev);
+	status = acpi_attach_data(handle, acpi_glue_data_handler, dev);
+	if (ACPI_FAILURE(status)) {
+		put_device(dev);
+		return -EINVAL;
+	}
+	dev->firmware_data = handle;
+
+	return 0;
+}
+
+static int acpi_unbind_one(struct device *dev)
+{
+	if (!dev->firmware_data)
+		return 0;
+	if (dev == acpi_get_physical_device(dev->firmware_data)) {
+		/* acpi_get_physical_device increase refcnt by one */
+		put_device(dev);
+		acpi_detach_data(dev->firmware_data, acpi_glue_data_handler);
+		dev->firmware_data = NULL;
+		/* acpi_bind_one increase refcnt by one */
+		put_device(dev);
+	} else {
+		printk(KERN_ERR PREFIX
+			"Oops, 'firmware_data' corrupt for %s\n", dev->bus_id);
+	}
+	return 0;
+}
+
+static int acpi_platform_notify (struct device *dev)
+{
+	struct acpi_bus_type	*type;
+	acpi_handle		handle;
+	int			ret = -EINVAL;
+
+	if (!dev->bus || !dev->parent) {
+		/* bridge devices genernally haven't bus or parent */
+		ret = acpi_find_bridge_device(dev, &handle);
+		goto end;
+	}
+	type = acpi_get_bus_type(dev->bus);
+	if (!type) {
+		printk(KERN_INFO PREFIX "No ACPI bus support for %s\n", dev->bus_id);
+		ret = -EINVAL;
+		goto end;
+	}
+	if ((ret = type->find_device(dev, &handle)) != 0)
+		printk(KERN_INFO PREFIX "Can't get handler for %s\n", dev->bus_id);
+end:
+	if (!ret)
+		acpi_bind_one(dev, handle);
+
+#if ACPI_GLUE_DEBUG
+	if (!ret) {
+		struct acpi_buffer      buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+		acpi_get_name(dev->firmware_data, ACPI_FULL_PATHNAME, &buffer);
+		DBG("Device %s -> %s\n", dev->bus_id, (char *)buffer.pointer);
+		acpi_os_free(buffer.pointer);
+	} else
+		DBG("Device %s -> No ACPI support\n", dev->bus_id);
+#endif
+
+	return ret;
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
+	if (platform_notify || platform_notify_remove) {
+		printk(KERN_ERR PREFIX "Can't use platform_notify\n");
+		return 0;
+	}
+	platform_notify = acpi_platform_notify;
+	platform_notify_remove = acpi_platform_notify_remove;
+	return 0;
+}
+arch_initcall(init_acpi_device_notify);
diff -puN drivers/acpi/ibm_acpi.c~bind-acpi-devcore drivers/acpi/ibm_acpi.c
--- 2.5/drivers/acpi/ibm_acpi.c~bind-acpi-devcore	2005-01-17 12:52:16.815048040 +0800
+++ 2.5-root/drivers/acpi/ibm_acpi.c	2005-01-17 12:52:16.826046368 +0800
@@ -1025,7 +1025,7 @@ static int setup_notify(struct ibm_struc
 	return 0;
 }
 
-static int device_add(struct acpi_device *device)
+static int ibmacpi_device_add(struct acpi_device *device)
 {
 	return 0;
 }
@@ -1043,7 +1043,7 @@ static int register_driver(struct ibm_st
 	memset(ibm->driver, 0, sizeof(struct acpi_driver));
 	sprintf(ibm->driver->name, "%s/%s", IBM_NAME, ibm->name);
 	ibm->driver->ids = ibm->hid;
-	ibm->driver->ops.add = &device_add;
+	ibm->driver->ops.add = &ibmacpi_device_add;
 
 	ret = acpi_bus_register_driver(ibm->driver);
 	if (ret < 0) {
diff -puN drivers/acpi/Makefile~bind-acpi-devcore drivers/acpi/Makefile
--- 2.5/drivers/acpi/Makefile~bind-acpi-devcore	2005-01-17 12:52:16.817047736 +0800
+++ 2.5-root/drivers/acpi/Makefile	2005-01-17 12:52:16.826046368 +0800
@@ -36,7 +36,7 @@ processor-objs	+= processor_perflib.o			
 endif
 
 obj-$(CONFIG_ACPI_BUS)		+= sleep/
-obj-$(CONFIG_ACPI_BUS)		+= bus.o
+obj-$(CONFIG_ACPI_BUS)		+= bus.o glue.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
diff -puN include/acpi/acpi_bus.h~bind-acpi-devcore include/acpi/acpi_bus.h
--- 2.5/include/acpi/acpi_bus.h~bind-acpi-devcore	2005-01-17 12:52:16.818047584 +0800
+++ 2.5-root/include/acpi/acpi_bus.h	2005-01-17 12:52:16.826046368 +0800
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
+#define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->firmware_data))
+
 #endif /*CONFIG_ACPI_BUS*/
 
 #endif /*__ACPI_BUS_H__*/
diff -puN include/linux/device.h~bind-acpi-devcore include/linux/device.h
--- 2.5/include/linux/device.h~bind-acpi-devcore	2005-01-17 12:52:16.820047280 +0800
+++ 2.5-root/include/linux/device.h	2005-01-17 12:52:16.827046216 +0800
@@ -268,8 +268,10 @@ struct device {
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
 	void		*driver_data;	/* data private to the driver */
-	void		*platform_data;	/* Platform specific data (e.g. ACPI,
-					   BIOS data relevant to device) */
+	void		*platform_data;	/* Platform specific data, device
+					   core doesn't touch it */
+	void		*firmware_data; /* Firmware specific data (e.g. ACPI,
+					   BIOS data),reserved for device core*/
 	struct dev_pm_info	power;
 
 	u32		detach_state;	/* State to enter when device is
_

--=-I3ioaI1IvYgxsXQszNAe
Content-Disposition: attachment; filename=p00002_bind-acpi-pci.patch
Content-Type: text/x-patch; name=p00002_bind-acpi-pci.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


An implementation for binding ACPI devices with PCI devices.

---

 2.5-root/drivers/pci/pci-acpi.c |   50 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+)

diff -puN drivers/pci/pci-acpi.c~bind-acpi-pci drivers/pci/pci-acpi.c
--- 2.5/drivers/pci/pci-acpi.c~bind-acpi-pci	2005-01-17 12:52:50.100987808 +0800
+++ 2.5-root/drivers/pci/pci-acpi.c	2005-01-17 12:53:52.365522160 +0800
@@ -207,3 +207,53 @@ acpi_status pci_osc_control_set(u32 flag
 	return status;
 }
 EXPORT_SYMBOL(pci_osc_control_set);
+
+/* ACPI bus type */
+static int pci_acpi_find_device(struct device *dev, acpi_handle *handle)
+{
+	struct pci_dev * pci_dev;
+	acpi_integer	addr;
+
+	pci_dev = to_pci_dev(dev);
+	/* Please ref to ACPI spec for the syntax of _ADR */
+	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
+	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
+	if (!*handle)
+		return -ENODEV;
+	return 0;
+}
+
+static int pci_acpi_find_root_bridge(struct device *dev, acpi_handle *handle)
+{
+	int num;
+	unsigned int seg, bus;
+
+	/*
+	 * The string should be the same as root bridge's name
+	 * Please look at 'pci_scan_bus_parented'
+	 */
+	num = sscanf(dev->bus_id, "pci%04x:%02x", &seg, &bus);
+	if (num != 2)
+		return -ENODEV;
+	*handle = acpi_get_pci_rootbridge_handle(seg, bus);
+	if (!*handle)
+		return -ENODEV;
+	return 0;
+}
+
+static struct acpi_bus_type pci_acpi_bus = {
+	.bus = &pci_bus_type,
+	.find_device = pci_acpi_find_device,
+	.find_bridge = pci_acpi_find_root_bridge,
+};
+
+static int __init pci_acpi_init(void)
+{
+	int ret;
+
+	ret = register_acpi_bus_type(&pci_acpi_bus);
+	if (ret)
+		return 0;
+	return 0;
+}
+arch_initcall(pci_acpi_init);
_

--=-I3ioaI1IvYgxsXQszNAe
Content-Disposition: attachment; filename=p00003_acpi-pci-get-suspend-state-callback.patch
Content-Type: text/x-patch; name=p00003_acpi-pci-get-suspend-state-callback.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


An ACPI callback for getting suspend state

---

 2.5-root/drivers/pci/pci-acpi.c |   22 ++++++++++++++++++++++
 2.5-root/drivers/pci/pci.c      |    1 +
 2.5-root/drivers/pci/pci.h      |    4 ++++
 3 files changed, 27 insertions(+)

diff -puN drivers/pci/pci-acpi.c~acpi-pci-get-suspend-state-callback drivers/pci/pci-acpi.c
--- 2.5/drivers/pci/pci-acpi.c~acpi-pci-get-suspend-state-callback	2005-01-17 12:54:05.355547376 +0800
+++ 2.5-root/drivers/pci/pci-acpi.c	2005-01-17 13:09:46.266507168 +0800
@@ -16,6 +16,7 @@
 #include <acpi/acpi_bus.h>
 
 #include <linux/pci-acpi.h>
+#include "pci.h"
 
 static u32 ctrlset_buf[3] = {0, 0, 0};
 static u32 global_ctrlsets = 0;
@@ -208,6 +209,25 @@ acpi_status pci_osc_control_set(u32 flag
 }
 EXPORT_SYMBOL(pci_osc_control_set);
 
+static int acpi_pci_choose_state(struct pci_dev *pdev,
+	pm_message_t state)
+{
+	char dstate_str[] = "_S0D";
+	acpi_status status;
+	unsigned long val;
+	struct device *dev = &pdev->dev;
+
+	/* state is PM_SUSPEND_* */
+	if ((state >= PM_SUSPEND_MAX) || !DEVICE_ACPI_HANDLE(dev))
+		return -EINVAL;
+	dstate_str[2] += (int __force)state;
+	status = acpi_evaluate_integer(DEVICE_ACPI_HANDLE(dev), dstate_str,
+		NULL, &val);
+	if (ACPI_SUCCESS(status))
+		return val;
+	return -EINVAL;;
+}
+
 /* ACPI bus type */
 static int pci_acpi_find_device(struct device *dev, acpi_handle *handle)
 {
@@ -254,6 +274,8 @@ static int __init pci_acpi_init(void)
 	ret = register_acpi_bus_type(&pci_acpi_bus);
 	if (ret)
 		return 0;
+	if (!platform_pci_choose_state)
+		platform_pci_choose_state = acpi_pci_choose_state;
 	return 0;
 }
 arch_initcall(pci_acpi_init);
diff -puN drivers/pci/pci.c~acpi-pci-get-suspend-state-callback drivers/pci/pci.c
--- 2.5/drivers/pci/pci.c~acpi-pci-get-suspend-state-callback	2005-01-17 12:54:05.357547072 +0800
+++ 2.5-root/drivers/pci/pci.c	2005-01-17 13:08:50.835933896 +0800
@@ -317,6 +317,7 @@ pci_set_power_state(struct pci_dev *dev,
  * Returns PCI power state suitable for given device and given system
  * message.
  */
+int (*platform_pci_choose_state)(struct pci_dev *, pm_message_t) = 0;
 
 pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
 {
diff -puN drivers/pci/pci.h~acpi-pci-get-suspend-state-callback drivers/pci/pci.h
--- 2.5/drivers/pci/pci.h~acpi-pci-get-suspend-state-callback	2005-01-17 12:54:05.358546920 +0800
+++ 2.5-root/drivers/pci/pci.h	2005-01-17 13:08:50.835933896 +0800
@@ -11,6 +11,10 @@ extern int pci_bus_alloc_resource(struct
 				  void (*alignf)(void *, struct resource *,
 					  	 unsigned long, unsigned long),
 				  void *alignf_data);
+/* return >= 0 if platform can get correct suspend state */
+extern int (*platform_pci_choose_state)(struct pci_dev *pdev,
+	pm_message_t state);
+
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
 extern int pci_proc_attach_device(struct pci_dev *dev);
_

--=-I3ioaI1IvYgxsXQszNAe
Content-Disposition: attachment; filename=p00004_acpi-pci-set-power-state-callback.patch
Content-Type: text/x-patch; name=p00004_acpi-pci-set-power-state-callback.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit



---

 2.5-root/drivers/acpi/bus.c     |    7 +++++++
 2.5-root/drivers/pci/pci-acpi.c |   15 +++++++++++++++
 2.5-root/drivers/pci/pci.c      |    9 +++++++++
 2.5-root/drivers/pci/pci.h      |    3 +++
 4 files changed, 34 insertions(+)

diff -puN drivers/acpi/bus.c~acpi-pci-set-power-state-callback drivers/acpi/bus.c
--- 2.5/drivers/acpi/bus.c~acpi-pci-set-power-state-callback	2005-01-17 13:09:51.308740632 +0800
+++ 2.5-root/drivers/acpi/bus.c	2005-01-17 13:09:51.316739416 +0800
@@ -212,6 +212,13 @@ acpi_bus_set_power (
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Device is not power manageable\n"));
 		return_VALUE(-ENODEV);
 	}
+	/*
+	 * Get device's current power state if it's unknown
+	 * This means device power state isn't initialized
+	 * or previous setting failed
+	 */
+	if (device->power.state == ACPI_STATE_UNKNOWN)
+		acpi_bus_get_power(device->handle, &device->power.state);
 	if (state == device->power.state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n", state));
 		return_VALUE(0);
diff -puN drivers/pci/pci-acpi.c~acpi-pci-set-power-state-callback drivers/pci/pci-acpi.c
--- 2.5/drivers/pci/pci-acpi.c~acpi-pci-set-power-state-callback	2005-01-17 13:09:51.309740480 +0800
+++ 2.5-root/drivers/pci/pci-acpi.c	2005-01-17 13:09:51.316739416 +0800
@@ -228,6 +228,19 @@ static int acpi_pci_choose_state(struct 
 	return -EINVAL;;
 }
 
+static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+	int acpi_state;
+
+	if (!handle)
+		return -ENODEV;
+	acpi_state = (int __force)state;
+	if (state == PCI_D3cold)
+		acpi_state = 3;
+	return acpi_bus_set_power(handle, acpi_state);
+}
+
 /* ACPI bus type */
 static int pci_acpi_find_device(struct device *dev, acpi_handle *handle)
 {
@@ -276,6 +289,8 @@ static int __init pci_acpi_init(void)
 		return 0;
 	if (!platform_pci_choose_state)
 		platform_pci_choose_state = acpi_pci_choose_state;
+	if (!platform_pci_set_power_state)
+		platform_pci_set_power_state = acpi_pci_set_power_state;
 	return 0;
 }
 arch_initcall(pci_acpi_init);
diff -puN drivers/pci/pci.c~acpi-pci-set-power-state-callback drivers/pci/pci.c
--- 2.5/drivers/pci/pci.c~acpi-pci-set-power-state-callback	2005-01-17 13:09:51.311740176 +0800
+++ 2.5-root/drivers/pci/pci.c	2005-01-17 13:09:51.317739264 +0800
@@ -240,6 +240,7 @@ pci_find_parent_resource(const struct pc
  * -EIO if device does not support PCI PM.
  * 0 if we can successfully change the power state.
  */
+int (*platform_pci_set_power_state)(struct pci_dev*, pci_power_t) = NULL;
 
 int
 pci_set_power_state(struct pci_dev *dev, pci_power_t state)
@@ -304,6 +305,14 @@ pci_set_power_state(struct pci_dev *dev,
 		msleep(10);
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(200);
+
+	/*
+	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
+	 * Firmware method after natice method ?
+	 */
+	if (platform_pci_set_power_state)
+		platform_pci_set_power_state(dev, state);
+
 	dev->current_state = state;
 
 	return 0;
diff -puN drivers/pci/pci.h~acpi-pci-set-power-state-callback drivers/pci/pci.h
--- 2.5/drivers/pci/pci.h~acpi-pci-set-power-state-callback	2005-01-17 13:09:51.312740024 +0800
+++ 2.5-root/drivers/pci/pci.h	2005-01-17 13:11:19.458339856 +0800
@@ -14,6 +14,9 @@ extern int pci_bus_alloc_resource(struct
 /* return >= 0 if platform can get correct suspend state */
 extern int (*platform_pci_choose_state)(struct pci_dev *pdev,
 	pm_message_t state);
+/* return  0 if success, < 0 failed */
+extern int (*platform_pci_set_power_state)(struct pci_dev *pdev,
+	pci_power_t state);
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
_

--=-I3ioaI1IvYgxsXQszNAe--

