Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269050AbUIXXXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269050AbUIXXXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269054AbUIXXXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:23:47 -0400
Received: from fmr03.intel.com ([143.183.121.5]:29327 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269050AbUIXXWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:22:34 -0400
Date: Fri, 24 Sep 2004 16:22:23 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       acpi-devel@lists.sourceforge.net, "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[1/6]-ACPI core enhancement support
Message-ID: <20040924162222.A27778@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409201326.44946.dtor_core@ameritech.net> <20040920120128.A15677@unix-os.sc.intel.com> <200409201426.31672.bjorn.helgaas@hp.com> <20040920134432.A16611@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040920134432.A16611@unix-os.sc.intel.com>; from anil.s.keshavamurthy@intel.com on Mon, Sep 20, 2004 at 01:44:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 01:44:32PM -0700, Keshavamurthy Anil S wrote:
> On Mon, Sep 20, 2004 at 02:26:31PM -0600, Bjorn Helgaas wrote:
> > On Monday 20 September 2004 1:01 pm, Keshavamurthy Anil S wrote:
> > > On Mon, Sep 20, 2004 at 01:26:44PM -0500, Dmitry Torokhov wrote:
> > I'm also in favor of removing the recursion, if only because it
> > allows local analysis.  I.e., a correctness argument based solely
> > on the code in the patch is much more useful than one that relies
> > on properties of an external and mostly unknown ACPI namespace.
> 
> Okay, I am convinced, I will post an updated patch to address this soon.
> Again thanks for the feedback and more comments are welcome:)

Hi Bjorn, 
	I reworked my patch based on the review feedback I got. Please let me know
if you have any other issues.

	Changes from previous version
	- Changed acpi_bus_trim() from recursion version to non-recursive version
	- Removed unnecessary local varable initializations.

Thanks,
Anil


---
Name:acpi_core.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Depends: None	
Version: applies on 2.6.9-rc2	

Description:
This patch provides core hotplug support in acpi by providing
acpi_bus_trim(), acpi_bus_remove() and acpi_pci_unbind()
which does exactly reverse of acpi_bus_scan(), acpi_bus_add()
and acpi_pci_bind(). 
	Changes from previous version
	- Changed acpi_bus_trim() from recursion version to interation version
	- Removed unnecessary local varable initializations.
---

 linux-2.6.9-rc2-askeshav/drivers/acpi/acpi_ksyms.c   |    3 
 linux-2.6.9-rc2-askeshav/drivers/acpi/bus.c          |    4 
 linux-2.6.9-rc2-askeshav/drivers/acpi/pci_bind.c     |   45 ++++++
 linux-2.6.9-rc2-askeshav/drivers/acpi/pci_irq.c      |   42 +++++-
 linux-2.6.9-rc2-askeshav/drivers/acpi/scan.c         |  131 +++++++++++++++++--
 linux-2.6.9-rc2-askeshav/include/acpi/acpi_bus.h     |   10 +
 linux-2.6.9-rc2-askeshav/include/acpi/acpi_drivers.h |    2 
 7 files changed, 220 insertions(+), 17 deletions(-)

diff -puN include/acpi/acpi_bus.h~acpi_core include/acpi/acpi_bus.h
--- linux-2.6.9-rc2/include/acpi/acpi_bus.h~acpi_core	2004-09-24 15:26:16.673473776 -0700
+++ linux-2.6.9-rc2-askeshav/include/acpi/acpi_bus.h	2004-09-24 15:26:16.797497212 -0700
@@ -104,6 +104,7 @@ typedef int (*acpi_op_suspend)	(struct a
 typedef int (*acpi_op_resume)	(struct acpi_device *device, int state);
 typedef int (*acpi_op_scan)	(struct acpi_device *device);
 typedef int (*acpi_op_bind)	(struct acpi_device *device);
+typedef int (*acpi_op_unbind)	(struct acpi_device *device);
 
 struct acpi_device_ops {
 	acpi_op_add		add;
@@ -115,6 +116,7 @@ struct acpi_device_ops {
 	acpi_op_resume		resume;
 	acpi_op_scan		scan;
 	acpi_op_bind		bind;
+	acpi_op_unbind		unbind;
 };
 
 struct acpi_driver {
@@ -313,7 +315,8 @@ extern struct subsystem acpi_subsys;
  * External Functions
  */
 
-int acpi_bus_get_device(acpi_handle, struct acpi_device **device);
+int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device);
+void acpi_bus_data_handler(acpi_handle handle, u32 function, void *context);
 int acpi_bus_get_status (struct acpi_device *device);
 int acpi_bus_get_power (acpi_handle handle, int *state);
 int acpi_bus_set_power (acpi_handle handle, int state);
@@ -321,6 +324,11 @@ int acpi_bus_generate_event (struct acpi
 int acpi_bus_receive_event (struct acpi_bus_event *event);
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
+int acpi_bus_scan (struct acpi_device *start);
+int acpi_bus_trim(struct acpi_device *start, int rmdevice);
+int acpi_bus_add (struct acpi_device **child, struct acpi_device *parent,
+		acpi_handle handle, int type);
+
 
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
diff -puN drivers/acpi/acpi_ksyms.c~acpi_core drivers/acpi/acpi_ksyms.c
--- linux-2.6.9-rc2/drivers/acpi/acpi_ksyms.c~acpi_core	2004-09-24 15:26:16.681286276 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/acpi/acpi_ksyms.c	2004-09-24 15:26:16.797497212 -0700
@@ -135,6 +135,9 @@ EXPORT_SYMBOL(acpi_bus_generate_event);
 EXPORT_SYMBOL(acpi_bus_receive_event);
 EXPORT_SYMBOL(acpi_bus_register_driver);
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
+EXPORT_SYMBOL(acpi_bus_scan);
+EXPORT_SYMBOL(acpi_bus_trim);
+EXPORT_SYMBOL(acpi_bus_add);
 
 #endif /*CONFIG_ACPI_BUS*/
 
diff -puN drivers/acpi/scan.c~acpi_core drivers/acpi/scan.c
--- linux-2.6.9-rc2/drivers/acpi/scan.c~acpi_core	2004-09-24 15:26:16.686169089 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/acpi/scan.c	2004-09-24 15:26:16.799450337 -0700
@@ -57,6 +57,7 @@ static void acpi_device_register(struct 
 	INIT_LIST_HEAD(&device->children);
 	INIT_LIST_HEAD(&device->node);
 	INIT_LIST_HEAD(&device->g_list);
+	INIT_LIST_HEAD(&device->wakeup_list);
 
 	spin_lock(&acpi_device_lock);
 	if (device->parent) {
@@ -64,6 +65,8 @@ static void acpi_device_register(struct 
 		list_add_tail(&device->g_list,&device->parent->g_list);
 	} else
 		list_add_tail(&device->g_list,&acpi_device_list);
+	if (device->wakeup.flags.valid)
+		list_add_tail(&device->wakeup_list,&acpi_wakeup_device_list);
 	spin_unlock(&acpi_device_lock);
 
 	kobject_init(&device->kobj);
@@ -80,6 +83,18 @@ acpi_device_unregister (
 	struct acpi_device	*device, 
 	int			type)
 {
+	spin_lock(&acpi_device_lock);
+	if (device->parent) {
+		list_del(&device->node);
+		list_del(&device->g_list);
+	} else
+		list_del(&device->g_list);
+
+	list_del(&device->wakeup_list);
+
+	spin_unlock(&acpi_device_lock);
+
+	acpi_detach_data(device->handle, acpi_bus_data_handler);
 	kobject_unregister(&device->kobj);
 	return 0;
 }
@@ -269,12 +284,6 @@ acpi_bus_get_wakeup_device_flags (
 	if (!acpi_match_ids(device, "PNP0C0D,PNP0C0C,PNP0C0E"))
 		device->wakeup.flags.run_wake = 1;
 
-	/* TBD: lock */
-	INIT_LIST_HEAD(&device->wakeup_list);
-	spin_lock(&acpi_device_lock);
-	list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
-	spin_unlock(&acpi_device_lock);
-
 end:
 	if (ACPI_FAILURE(status))
 		device->flags.wake_capable = 0;
@@ -723,7 +732,7 @@ void acpi_device_get_debug_info(struct a
 #ifdef CONFIG_ACPI_DEBUG_OUTPUT
 	char		*type_string = NULL;
 	char		name[80] = {'?','\0'};
-	acpi_buffer	buffer = {sizeof(name), name};
+	struct acpi_buffer	buffer = {sizeof(name), name};
 
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
@@ -760,7 +769,55 @@ void acpi_device_get_debug_info(struct a
 #endif /*CONFIG_ACPI_DEBUG_OUTPUT*/
 }
 
-static int 
+
+int
+acpi_bus_remove (
+	struct acpi_device *dev,
+	int rmdevice)
+{
+	int 			result = 0;
+	struct acpi_driver	*driver;
+	
+	ACPI_FUNCTION_TRACE("acpi_bus_remove");
+
+	if (!dev)
+		return_VALUE(-EINVAL);
+
+	driver = dev->driver;
+
+	if ((driver) && (driver->ops.remove)) {
+
+		if (driver->ops.stop) {
+			result = driver->ops.stop(dev, ACPI_BUS_REMOVAL_EJECT);
+			if (result)
+				return_VALUE(result);
+		}
+
+		result = dev->driver->ops.remove(dev, ACPI_BUS_REMOVAL_EJECT);
+		if (result) {
+			return_VALUE(result);
+		}
+
+		atomic_dec(&dev->driver->references);
+		dev->driver = NULL;
+		acpi_driver_data(dev) = NULL;
+	}
+
+	if (!rmdevice)
+		return_VALUE(0);
+
+	if (dev->flags.bus_address) {
+		if ((dev->parent) && (dev->parent->ops.unbind))
+			dev->parent->ops.unbind(dev);
+	}
+	
+	acpi_device_unregister(dev, ACPI_BUS_REMOVAL_EJECT);
+
+	return_VALUE(0);
+}
+
+
+int
 acpi_bus_add (
 	struct acpi_device	**child,
 	struct acpi_device	*parent,
@@ -907,7 +964,7 @@ end:
 
 
 
-static int acpi_bus_scan (struct acpi_device	*start)
+int acpi_bus_scan (struct acpi_device	*start)
 {
 	acpi_status		status = AE_OK;
 	struct acpi_device	*parent = NULL;
@@ -1010,6 +1067,62 @@ static int acpi_bus_scan (struct acpi_de
 }
 
 
+int
+acpi_bus_trim(struct acpi_device	*start,
+		int rmdevice)
+{
+	acpi_status		status;
+	struct acpi_device	*parent, *child;
+	acpi_handle		phandle, chandle;
+	acpi_object_type	type;
+	u32			level = 1;
+	int			err = 0;
+
+	parent  = start;
+	phandle = start->handle;
+	child = chandle = NULL;
+
+	while ((level > 0) && parent && (!err)) {
+		status = acpi_get_next_object(ACPI_TYPE_ANY, phandle,
+			chandle, &chandle);
+
+		/*
+		 * If this scope is exhausted then move our way back up.
+		 */
+		if (ACPI_FAILURE(status)) {
+			level--;
+			chandle = phandle;
+			acpi_get_parent(phandle, &phandle);
+			child = parent;
+			parent = parent->parent;
+
+			if (level == 0)
+				err = acpi_bus_remove(child, rmdevice);
+			else
+				err = acpi_bus_remove(child, 1);
+
+			continue;
+		}
+
+		status = acpi_get_type(chandle, &type);
+		if (ACPI_FAILURE(status)) {
+			continue;
+		}
+		/*
+		 * If there is a device corresponding to chandle then
+		 * parse it (depth-first).
+		 */
+		if (acpi_bus_get_device(chandle, &child) == 0) {
+			level++;
+			phandle = chandle;
+			chandle = NULL;
+			parent = child;
+		}
+		continue;
+	}
+	return err;
+}
+
 static int
 acpi_bus_scan_fixed (
 	struct acpi_device	*root)
diff -puN include/acpi/acpi_drivers.h~acpi_core include/acpi/acpi_drivers.h
--- linux-2.6.9-rc2/include/acpi/acpi_drivers.h~acpi_core	2004-09-24 15:26:16.691051901 -0700
+++ linux-2.6.9-rc2-askeshav/include/acpi/acpi_drivers.h	2004-09-24 15:26:16.800426900 -0700
@@ -61,12 +61,14 @@ int acpi_pci_link_get_irq (acpi_handle h
 /* ACPI PCI Interrupt Routing (pci_irq.c) */
 
 int acpi_pci_irq_add_prt (acpi_handle handle, int segment, int bus);
+void acpi_pci_irq_del_prt (int segment, int bus);
 
 /* ACPI PCI Device Binding (pci_bind.c) */
 
 struct pci_bus;
 
 int acpi_pci_bind (struct acpi_device *device);
+int acpi_pci_unbind (struct acpi_device *device);
 int acpi_pci_bind_root (struct acpi_device *device, struct acpi_pci_id *id, struct pci_bus *bus);
 
 /* Arch-defined function to add a bus to the system */
diff -puN drivers/acpi/pci_irq.c~acpi_core drivers/acpi/pci_irq.c
--- linux-2.6.9-rc2/drivers/acpi/pci_irq.c~acpi_core	2004-09-24 15:26:16.696911276 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/acpi/pci_irq.c	2004-09-24 15:26:16.801403462 -0700
@@ -43,7 +43,7 @@
 ACPI_MODULE_NAME		("pci_irq")
 
 struct acpi_prt_list		acpi_prt;
-
+spinlock_t acpi_prt_lock = SPIN_LOCK_UNLOCKED;
 
 /* --------------------------------------------------------------------------
                          PCI IRQ Routing Table (PRT) Support
@@ -68,18 +68,20 @@ acpi_pci_irq_find_prt_entry (
 	 * Parse through all PRT entries looking for a match on the specified
 	 * PCI device's segment, bus, device, and pin (don't care about func).
 	 *
-	 * TBD: Acquire/release lock
 	 */
+	spin_lock(&acpi_prt_lock);
 	list_for_each(node, &acpi_prt.entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
 		if ((segment == entry->id.segment) 
 			&& (bus == entry->id.bus) 
 			&& (device == entry->id.device)
 			&& (pin == entry->pin)) {
+			spin_unlock(&acpi_prt_lock);
 			return_PTR(entry);
 		}
 	}
 
+	spin_unlock(&acpi_prt_lock);
 	return_PTR(NULL);
 }
 
@@ -141,14 +143,29 @@ acpi_pci_irq_add_entry (
 		entry->id.segment, entry->id.bus, entry->id.device, 
 		('A' + entry->pin), prt->source, entry->link.index));
 
-	/* TBD: Acquire/release lock */
+	spin_lock(&acpi_prt_lock);
 	list_add_tail(&entry->node, &acpi_prt.entries);
 	acpi_prt.count++;
+	spin_unlock(&acpi_prt_lock);
 
 	return_VALUE(0);
 }
 
 
+static void
+acpi_pci_irq_del_entry (
+	int				segment,
+	int				bus,
+	struct acpi_prt_entry		*entry)
+{
+	if (segment == entry->id.segment && bus == entry->id.bus){
+		acpi_prt.count--;
+		list_del(&entry->node);
+		kfree(entry);
+	}
+}
+
+
 int
 acpi_pci_irq_add_prt (
 	acpi_handle		handle,
@@ -222,7 +239,26 @@ acpi_pci_irq_add_prt (
 	return_VALUE(0);
 }
 
+void
+acpi_pci_irq_del_prt (int segment, int bus)
+{
+	struct list_head        *node = NULL, *n = NULL;
+	struct acpi_prt_entry   *entry = NULL;
+
+	if (!acpi_prt.count)    {
+		return;
+	}
 
+	printk(KERN_DEBUG "ACPI: Delete PCI Interrupt Routing Table for %x:%x\n",
+		segment, bus);
+	spin_lock(&acpi_prt_lock);
+	list_for_each_safe(node, n, &acpi_prt.entries) {
+		entry = list_entry(node, struct acpi_prt_entry, node);
+
+		acpi_pci_irq_del_entry(segment, bus, entry);
+	}
+	spin_unlock(&acpi_prt_lock);
+}
 /* --------------------------------------------------------------------------
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
diff -puN drivers/acpi/pci_bind.c~acpi_core drivers/acpi/pci_bind.c
--- linux-2.6.9-rc2/drivers/acpi/pci_bind.c~acpi_core	2004-09-24 15:26:16.701794088 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/acpi/pci_bind.c	2004-09-24 15:26:16.802380025 -0700
@@ -214,6 +214,7 @@ acpi_pci_bind (
 			data->id.device, data->id.function));
 		data->bus = data->dev->subordinate;
 		device->ops.bind = acpi_pci_bind;
+		device->ops.unbind = acpi_pci_unbind;
 	}
 
 	/*
@@ -257,6 +258,49 @@ end:
 	return_VALUE(result);
 }
 
+int acpi_pci_unbind(
+	struct acpi_device      *device)
+{
+	int                     result = 0;
+	acpi_status             status = AE_OK;
+	struct acpi_pci_data    *data = NULL;
+	char                    pathname[ACPI_PATHNAME_MAX] = {0};
+	struct acpi_buffer      buffer = {ACPI_PATHNAME_MAX, pathname};
+
+	ACPI_FUNCTION_TRACE("acpi_pci_unbind");
+
+	if (!device || !device->parent)
+		return_VALUE(-EINVAL);
+
+	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Unbinding PCI device [%s]...\n",
+		pathname));
+
+	status = acpi_get_data(device->handle, acpi_pci_data_handler, (void**)&data);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Unable to get data from device %s\n",
+			acpi_device_bid(device)));
+		result = -ENODEV;
+		goto end;
+	}
+
+	status = acpi_detach_data(device->handle, acpi_pci_data_handler);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Unable to detach data from device %s\n",
+			acpi_device_bid(device)));
+		result = -ENODEV;
+		goto end;
+	}
+	if (data->dev->subordinate) {
+		acpi_pci_irq_del_prt(data->id.segment, data->bus->number);
+	}
+	kfree(data);
+
+end:
+	return_VALUE(result);
+}
 
 int 
 acpi_pci_bind_root (
@@ -283,6 +327,7 @@ acpi_pci_bind_root (
 	data->id = *id;
 	data->bus = bus;
 	device->ops.bind = acpi_pci_bind;
+	device->ops.unbind = acpi_pci_unbind;
 
 	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
 
diff -puN drivers/acpi/bus.c~acpi_core drivers/acpi/bus.c
--- linux-2.6.9-rc2/drivers/acpi/bus.c~acpi_core	2004-09-24 15:26:16.709606588 -0700
+++ linux-2.6.9-rc2-askeshav/drivers/acpi/bus.c	2004-09-24 15:26:16.803356587 -0700
@@ -53,10 +53,6 @@ struct proc_dir_entry		*acpi_root_dir;
                                 Device Management
    -------------------------------------------------------------------------- */
 
-extern void acpi_bus_data_handler (
-	acpi_handle		handle,
-	u32			function,
-	void			*context);
 int
 acpi_bus_get_device (
 	acpi_handle		handle,
_


