Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbUKIJJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbUKIJJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 04:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUKIJJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 04:09:50 -0500
Received: from fmr05.intel.com ([134.134.136.6]:62360 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261448AbUKIJJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 04:09:00 -0500
Subject: Re: [PATCH/RFC 1/4]device core changes
From: Li Shaohua <shaohua.li@intel.com>
To: Greg KH <greg@kroah.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20041109045843.GA4849@kroah.com>
References: <1099887071.1750.243.camel@sli10-desk.sh.intel.com>
	 <20041108225810.GB16197@kroah.com>
	 <1099961418.15294.11.camel@sli10-desk.sh.intel.com>
	 <1099971341.15294.48.camel@sli10-desk.sh.intel.com>
	 <20041109045843.GA4849@kroah.com>
Content-Type: multipart/mixed; boundary="=-Q7GYKsMFHNb31RbuR7bp"
Message-Id: <1099990981.15294.57.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 09 Nov 2004 17:03:01 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q7GYKsMFHNb31RbuR7bp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-11-09 at 12:58, Greg KH wrote:
> On Tue, Nov 09, 2004 at 11:35:41AM +0800, Li Shaohua wrote:
> > On Tue, 2004-11-09 at 08:50, Li Shaohua wrote:
> > > On Tue, 2004-11-09 at 06:58, Greg KH wrote:
> > > > On Mon, Nov 08, 2004 at 12:11:11PM +0800, Li Shaohua wrote:
> > > > > Hi,
> > > > > This is the device core change required. Add .platform_bind method for
> > > > > bus_type, so platform can do addition things when add a new device. A
> > > > > case is ACPI, we want to utilize some ACPI methods for physical devices.
> > > > > 1. Why doesn't use 'platform_notify'?
> > > > > Current device core has a 'platform_notify' mechanism, but it's not
> > > > > sufficient for this. Only sepcific bus type know how to parse dev.bus_id
> > > > > and know how to encode specific device's address into ACPI _ADR syntax.
> > > > 
> > > > I don't see why platform_notify is not sufficient.  This is the exact
> > > > reason it was added to the code.
> > > As I said in the email, we need know the bus type to decode and encode
> > > address. If you use platform_notify, you must do something like this:
> > > switch (dev->bus)
> > > {
> > > case pci_bus_type:
> > > bind PCI devices with ACPI devices
> > > break;
> > > case ide_bus_type:
> > > bind IDE devices with ACPI devices
> > > break;
> > > ....
> > > }
> > > But note this method requires all bus types are build-in. If a bus type
> > > is in a loadable module (such as IDE bus), the method will failed. I
> > > searched current tree, only ARM implemented 'platform_notify', but ARM
> > > only cares PCI bus, ACPI cares about all bus types.
> > > > 
> > Oops, it's my bad. we can identify the bus type from bus_type->name, but
> > it looks like a little ugly. Why the bus_type hasn't a flag to identify
> > which bus it is?
> 
> Because if you have a struct bus * you _have_ to know what type it is.
> 
> > Anyway, thanks Greg. I will add as you said.
> 
> Hm, hopefully Pat will chime in about what would be best for this, as he
> created the platform_notify interface.
Ok, an updated version. Use 'platform_notify', but add a 'type' in 
'struct bus_type'. Using bus_type->name to identify the bus type is
pretty much ugly and slow. 

Thanks,
Shaohua

--=-Q7GYKsMFHNb31RbuR7bp
Content-Disposition: attachment; filename=p00001_devcore-addflag.patch
Content-Type: text/x-patch; name=p00001_devcore-addflag.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


Add a flag in bus_type, so we can quickly identify the bus type.
Only adds limited bus types currently.

---

 2.6-root/drivers/ide/ide.c        |    1 +
 2.6-root/drivers/pci/pci-driver.c |    1 +
 2.6-root/drivers/pnp/driver.c     |    1 +
 2.6-root/include/linux/device.h   |    9 +++++++++
 4 files changed, 12 insertions(+)

diff -puN include/linux/device.h~devcore-addflag include/linux/device.h
--- 2.6/include/linux/device.h~devcore-addflag	2004-11-09 12:16:58.000000000 +0800
+++ 2.6-root/include/linux/device.h	2004-11-09 14:43:13.000000000 +0800
@@ -47,8 +47,17 @@ struct class;
 struct class_device;
 struct class_simple;
 
+enum bus_types {
+	BUS_TYPE_PCI = 1,
+	BUS_TYPE_IDE,
+	BUS_TYPE_PLATFORM,
+	BUS_TYPE_PNP,
+	/* TBD: add more */
+};
+
 struct bus_type {
 	char			* name;
+	enum bus_types		type;
 
 	struct subsystem	subsys;
 	struct kset		drivers;
diff -puN drivers/pci/pci-driver.c~devcore-addflag drivers/pci/pci-driver.c
--- 2.6/drivers/pci/pci-driver.c~devcore-addflag	2004-11-09 12:19:13.000000000 +0800
+++ 2.6-root/drivers/pci/pci-driver.c	2004-11-09 12:19:58.000000000 +0800
@@ -532,6 +532,7 @@ int pci_hotplug (struct device *dev, cha
 
 struct bus_type pci_bus_type = {
 	.name		= "pci",
+	.type		= BUS_TYPE_PCI,
 	.match		= pci_bus_match,
 	.hotplug	= pci_hotplug,
 	.suspend	= pci_device_suspend,
diff -puN drivers/ide/ide.c~devcore-addflag drivers/ide/ide.c
--- 2.6/drivers/ide/ide.c~devcore-addflag	2004-11-09 12:20:55.000000000 +0800
+++ 2.6-root/drivers/ide/ide.c	2004-11-09 12:21:30.000000000 +0800
@@ -2414,6 +2414,7 @@ EXPORT_SYMBOL(ide_lock);
 
 struct bus_type ide_bus_type = {
 	.name		= "ide",
+	.type		= BUS_TYPE_IDE,
 	.suspend	= generic_ide_suspend,
 	.resume		= generic_ide_resume,
 };
diff -puN drivers/pnp/driver.c~devcore-addflag drivers/pnp/driver.c
--- 2.6/drivers/pnp/driver.c~devcore-addflag	2004-11-09 14:52:31.000000000 +0800
+++ 2.6-root/drivers/pnp/driver.c	2004-11-09 14:53:10.000000000 +0800
@@ -156,6 +156,7 @@ static int pnp_bus_match(struct device *
 
 struct bus_type pnp_bus_type = {
 	.name	= "pnp",
+	.type	= BUS_TYPE_PNP,
 	.match	= pnp_bus_match,
 };
 
_

--=-Q7GYKsMFHNb31RbuR7bp
Content-Disposition: attachment; filename=p00002_acpi_platform_notify.patch
Content-Type: text/x-patch; name=p00002_acpi_platform_notify.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


Bind physical devices with ACPI devices.
The PCI and PNP bind code are ok in the patch, but IDE bus type is just an
experiment.

---

 2.6-root/drivers/acpi/Makefile               |    2 
 2.6-root/drivers/acpi/acpi_platform_notify.c |  214 +++++++++++++++++++++++++++
 2.6-root/drivers/acpi/bus.c                  |    3 
 2.6-root/drivers/acpi/pci_root.c             |   13 +
 2.6-root/include/acpi/acpi_bus.h             |    1 
 2.6-root/include/acpi/acpi_drivers.h         |    1 
 6 files changed, 233 insertions(+), 1 deletion(-)

diff -puN drivers/acpi/bus.c~acpi_platform_notify drivers/acpi/bus.c
--- 2.6/drivers/acpi/bus.c~acpi_platform_notify	2004-11-09 16:27:12.041700736 +0800
+++ 2.6-root/drivers/acpi/bus.c	2004-11-09 16:27:12.052699064 +0800
@@ -763,6 +763,9 @@ static int __init acpi_init (void)
 	} else
 		disable_acpi();
 
+	if (!result)
+		init_acpi_device_notify();
+
 	return_VALUE(result);
 }
 
diff -puN /dev/null drivers/acpi/acpi_platform_notify.c
--- /dev/null	2004-02-24 05:02:56.000000000 +0800
+++ 2.6-root/drivers/acpi/acpi_platform_notify.c	2004-11-09 16:42:10.898053800 +0800
@@ -0,0 +1,214 @@
+/*
+ * Bind physical devices with ACPI devices
+ */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/pnp.h>
+#include <linux/acpi.h>
+
+struct acpi_find_child {
+	acpi_handle     handle;
+	acpi_integer    address;
+};
+
+static acpi_status __devinit
+find_child(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	acpi_status	status;
+	struct acpi_device_info *info;
+	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_find_child *find = (struct acpi_find_child*)context;
+
+	status = acpi_get_object_info(handle, &buffer);
+	if (ACPI_SUCCESS(status)) {
+		info = buffer.pointer;
+		if (info->address == find->address) {
+			find->handle = handle;
+			return AE_CTRL_TERMINATE;
+		}
+	}
+	return AE_OK;
+}
+
+/* Move it to ACPICA? */
+static acpi_handle __devinit
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
+
+/*---------------- PCI BUS ------------------------*/
+static int __devinit is_pci_root_bridge(struct device *dev,
+		unsigned int *segment, unsigned int *bus)
+{
+	int num;
+	num = sscanf(dev->bus_id, "pci%04x:%02x", segment, bus);
+	if (num == 2)
+		return 1;
+	return 0;
+}
+
+static int __devinit acpi_bind_pci_root_bridge(struct device *dev,
+		unsigned int seg, unsigned int bus)
+{
+	dev->platform_data = acpi_get_rootbridge_handle(seg, bus);
+	return 0;
+}
+
+static int __devinit acpi_bind_pci_bus(struct device *dev)
+{
+	struct pci_dev * pci_dev;
+	acpi_handle parent_handle = NULL;
+	acpi_integer address;
+
+	pci_dev = to_pci_dev(dev);
+	if (dev->parent)
+		parent_handle = dev->parent->platform_data;
+
+	if (!parent_handle) {
+		printk("Can't find parent handle \n");
+		return -EINVAL;
+	}
+
+	/* Please ref to ACPI spec for syntax of _ADR */
+	address = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
+	dev->platform_data = acpi_get_child(parent_handle, address);
+	return 0;
+}
+
+/*----------------- IDE BUS --------------------------*/
+/* This possibly is completly wrong, IDE guru please correct it */
+static int __devinit is_ide_channel(struct device *dev,
+		unsigned int *channel)
+{
+	int num;
+	num = sscanf(dev->bus_id, "ide%d", channel);
+	if (num == 1)
+		return 1;
+	return 0;
+}
+
+static int __devinit acpi_bind_ide_channel(struct device *dev, unsigned int channel)
+{
+	acpi_handle parent_handle = NULL;
+	acpi_integer address;
+
+	/* Seems dev->parent is the PCI IDE controller */
+	if (dev->parent)
+		parent_handle = dev->parent->platform_data;
+
+	if (!parent_handle) {
+		printk("Can't find parent handle \n");
+		return -EINVAL;
+	}
+
+	/* Please ref to ACPI spec for syntax of _ADR */
+	address = channel;
+	dev->platform_data = acpi_get_child(parent_handle, address);
+	return 0;
+}
+
+static int __devinit acpi_bind_ide_bus(struct device *dev)
+{
+	acpi_handle parent_handle = NULL;
+	acpi_integer address;
+	int i;
+
+	/* Seems dev->parent is the IDE channel device */
+	if (dev->parent)
+		parent_handle = dev->parent->platform_data;
+
+	if (!parent_handle) {
+		printk("Can't find parent handle \n");
+		return -1;
+	}
+
+	/* Please ref to ACPI spec for syntax of _ADR */
+	sscanf(dev->bus_id, "%d", &i);
+	address = i;
+	dev->platform_data = acpi_get_child(parent_handle, address);
+	return 0;
+}
+
+/*--------------------- PNP Bus -----------------------*/
+static int __devinit acpi_bind_pnp_bus(struct device *dev)
+{
+	struct pnp_dev *pnp_dev;
+
+	pnp_dev = to_pnp_dev(dev);
+	/* PNPACPI adds ACPI handle in pnp_dev->data */
+	/*dev->platform_data = pnp_dev->data;*/
+	return 0;
+}
+
+/*----------------------------------------------------*/
+static int __devinit acpi_platform_notify (struct device *dev)
+{
+	int ret = -EINVAL;
+
+	if (!dev->bus) {
+		unsigned int tmp1, tmp2;
+
+		/* PCI root bridge device hasn't a bus type */
+		if (is_pci_root_bridge(dev, &tmp1, &tmp2)) {
+			ret = acpi_bind_pci_root_bridge(dev, tmp1, tmp2);
+			goto end;
+		}
+		/* IDE channel device hasn't a bus type */
+		if (is_ide_channel(dev, &tmp1)) {
+			ret = acpi_bind_ide_channel(dev, tmp1);
+			goto end;
+		}
+		goto end;
+	}
+	switch (dev->bus->type) {
+	case BUS_TYPE_PCI:
+		ret = acpi_bind_pci_bus(dev);
+		break;
+	case BUS_TYPE_IDE:
+		ret = acpi_bind_ide_bus(dev);
+		break;
+	case BUS_TYPE_PNP:
+		ret = acpi_bind_pnp_bus(dev);
+		break;
+	/* TBD: add more bus types */
+	default:
+		printk("Please add an implementation for bus %s\n", dev->bus->name);
+		break;
+	}
+end:
+#if 1
+	{/* For debug */
+		char            name[80] = {'?','\0'};
+		struct acpi_buffer      buffer = {sizeof(name), name};
+
+		printk("Device %s -> ", dev->bus_id);
+		if (dev->platform_data) {
+			acpi_get_name(dev->platform_data, ACPI_FULL_PATHNAME, &buffer);
+			printk("%s", name);
+		}
+		printk("\n");
+	}
+#endif
+	return ret;
+}
+
+static int __devinitdata (*saved_platform_notify)(struct device *dev);
+
+void __init init_acpi_device_notify(void)
+{
+	saved_platform_notify = platform_notify;
+	platform_notify = acpi_platform_notify;
+}
+
+void __exit exit_acpi_device_notify(void)
+{
+	platform_notify = saved_platform_notify;
+}
diff -puN include/acpi/acpi_drivers.h~acpi_platform_notify include/acpi/acpi_drivers.h
--- 2.6/include/acpi/acpi_drivers.h~acpi_platform_notify	2004-11-09 16:27:12.043700432 +0800
+++ 2.6-root/include/acpi/acpi_drivers.h	2004-11-09 16:27:12.053698912 +0800
@@ -53,6 +53,7 @@
 
 #define ACPI_PCI_COMPONENT		0x00400000
 
+acpi_handle acpi_get_rootbridge_handle(u16 segment, u16 bus);
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
 int acpi_irq_penalty_init (void);
diff -puN drivers/acpi/pci_root.c~acpi_platform_notify drivers/acpi/pci_root.c
--- 2.6/drivers/acpi/pci_root.c~acpi_platform_notify	2004-11-09 16:27:12.044700280 +0800
+++ 2.6-root/drivers/acpi/pci_root.c	2004-11-09 16:27:12.053698912 +0800
@@ -343,3 +343,16 @@ static int __init acpi_pci_root_init (vo
 
 subsys_initcall(acpi_pci_root_init);
 
+acpi_handle acpi_get_rootbridge_handle(u16 segment, u16 bus)
+{
+	struct list_head *entry;
+
+	list_for_each(entry, &acpi_pci_roots) {
+		struct acpi_pci_root *root;
+
+		root = list_entry(entry, struct acpi_pci_root, node);
+		if ((root->id.segment == segment) && (root->id.bus == bus))
+			return root->handle;
+	}
+	return NULL;
+}
diff -puN include/acpi/acpi_bus.h~acpi_platform_notify include/acpi/acpi_bus.h
--- 2.6/include/acpi/acpi_bus.h~acpi_platform_notify	2004-11-09 16:27:12.046699976 +0800
+++ 2.6-root/include/acpi/acpi_bus.h	2004-11-09 16:27:12.053698912 +0800
@@ -325,6 +325,7 @@ int acpi_bus_unregister_driver (struct a
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
+void init_acpi_device_notify(void);
 #endif /*CONFIG_ACPI_BUS*/
 
 #endif /*__ACPI_BUS_H__*/
diff -puN drivers/acpi/Makefile~acpi_platform_notify drivers/acpi/Makefile
--- 2.6/drivers/acpi/Makefile~acpi_platform_notify	2004-11-09 16:27:12.047699824 +0800
+++ 2.6-root/drivers/acpi/Makefile	2004-11-09 16:27:12.053698912 +0800
@@ -32,7 +32,7 @@ obj-$(CONFIG_ACPI_INTERPRETER)	+= osl.o 
 # ACPI Bus and Device Drivers
 #
 obj-$(CONFIG_ACPI_BUS)		+= sleep/
-obj-$(CONFIG_ACPI_BUS)		+= bus.o
+obj-$(CONFIG_ACPI_BUS)		+= bus.o acpi_platform_notify.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
_

--=-Q7GYKsMFHNb31RbuR7bp--

