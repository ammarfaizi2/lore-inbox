Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbUKHETS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbUKHETS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 23:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUKHESi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 23:18:38 -0500
Received: from fmr06.intel.com ([134.134.136.7]:35999 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261751AbUKHERO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 23:17:14 -0500
Subject: [PATCH/RFC 2/4]ACPI helper routines
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Content-Type: multipart/mixed; boundary="=-/FtoVCyqys9NO3dAMW4V"
Message-Id: <1099887074.1750.245.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 08 Nov 2004 12:11:17 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/FtoVCyqys9NO3dAMW4V
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
Add ACPI helper for binding physical devices with ACPI devices

Thanks,
Shaohua
---

 2.6-root/drivers/acpi/acpi_ksyms.c   |    1 +
 2.6-root/drivers/acpi/bus.c          |   35
+++++++++++++++++++++++++++++++++++
 2.6-root/drivers/acpi/pci_root.c     |   13 +++++++++++++
 2.6-root/include/acpi/acpi_bus.h     |    1 +
 2.6-root/include/acpi/acpi_drivers.h |    1 +
 5 files changed, 51 insertions(+)

diff -puN drivers/acpi/acpi_ksyms.c~acpihelper drivers/acpi/acpi_ksyms.c
--- 2.6/drivers/acpi/acpi_ksyms.c~acpihelper	2004-11-08
11:05:22.767953024 +0800
+++ 2.6-root/drivers/acpi/acpi_ksyms.c	2004-11-08 11:05:22.776951656
+0800
@@ -57,6 +57,7 @@ EXPORT_SYMBOL(acpi_ut_trace);
 
 EXPORT_SYMBOL(acpi_get_handle);
 EXPORT_SYMBOL(acpi_get_parent);
+EXPORT_SYMBOL(acpi_get_child);
 EXPORT_SYMBOL(acpi_get_type);
 EXPORT_SYMBOL(acpi_get_name);
 EXPORT_SYMBOL(acpi_get_object_info);
diff -puN drivers/acpi/bus.c~acpihelper drivers/acpi/bus.c
--- 2.6/drivers/acpi/bus.c~acpihelper	2004-11-08 11:05:22.768952872
+0800
+++ 2.6-root/drivers/acpi/bus.c	2004-11-08 11:05:22.776951656 +0800
@@ -271,7 +271,42 @@ end:
 	return_VALUE(result);
 }
 
+struct acpi_find_child {
+	acpi_handle     handle;
+	acpi_integer    address;
+};
 
+static acpi_status
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
+acpi_handle acpi_get_child(acpi_handle parent, acpi_integer address)
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
 
 /*
--------------------------------------------------------------------------
                                 Event Management
diff -puN drivers/acpi/pci_root.c~acpihelper drivers/acpi/pci_root.c
--- 2.6/drivers/acpi/pci_root.c~acpihelper	2004-11-08 11:05:22.770952568
+0800
+++ 2.6-root/drivers/acpi/pci_root.c	2004-11-08 11:05:22.777951504 +0800
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
diff -puN include/acpi/acpi_bus.h~acpihelper include/acpi/acpi_bus.h
--- 2.6/include/acpi/acpi_bus.h~acpihelper	2004-11-08 11:05:22.771952416
+0800
+++ 2.6-root/include/acpi/acpi_bus.h	2004-11-08 11:05:22.777951504 +0800
@@ -313,6 +313,7 @@ extern struct subsystem acpi_subsys;
  * External Functions
  */
 
+acpi_handle acpi_get_child(acpi_handle parent, acpi_integer address);
 int acpi_bus_get_device(acpi_handle, struct acpi_device **device);
 int acpi_bus_get_status (struct acpi_device *device);
 int acpi_bus_get_power (acpi_handle handle, int *state);
diff -puN include/acpi/acpi_drivers.h~acpihelper
include/acpi/acpi_drivers.h
--- 2.6/include/acpi/acpi_drivers.h~acpihelper	2004-11-08
11:05:22.773952112 +0800
+++ 2.6-root/include/acpi/acpi_drivers.h	2004-11-08 11:05:22.777951504
+0800
@@ -53,6 +53,7 @@
 
 #define ACPI_PCI_COMPONENT		0x00400000
 
+acpi_handle acpi_get_rootbridge_handle(u16 segment, u16 bus);
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
 int acpi_irq_penalty_init (void);
_


--=-/FtoVCyqys9NO3dAMW4V
Content-Disposition: attachment; filename=p00002_acpihelper.patch
Content-Type: text/x-patch; name=p00002_acpihelper.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


Add ACPI helper for binding physical devices with ACPI devices

---

 2.6-root/drivers/acpi/acpi_ksyms.c   |    1 +
 2.6-root/drivers/acpi/bus.c          |   35 +++++++++++++++++++++++++++++++++++
 2.6-root/drivers/acpi/pci_root.c     |   13 +++++++++++++
 2.6-root/include/acpi/acpi_bus.h     |    1 +
 2.6-root/include/acpi/acpi_drivers.h |    1 +
 5 files changed, 51 insertions(+)

diff -puN drivers/acpi/acpi_ksyms.c~acpihelper drivers/acpi/acpi_ksyms.c
--- 2.6/drivers/acpi/acpi_ksyms.c~acpihelper	2004-11-08 11:05:22.767953024 +0800
+++ 2.6-root/drivers/acpi/acpi_ksyms.c	2004-11-08 11:05:22.776951656 +0800
@@ -57,6 +57,7 @@ EXPORT_SYMBOL(acpi_ut_trace);
 
 EXPORT_SYMBOL(acpi_get_handle);
 EXPORT_SYMBOL(acpi_get_parent);
+EXPORT_SYMBOL(acpi_get_child);
 EXPORT_SYMBOL(acpi_get_type);
 EXPORT_SYMBOL(acpi_get_name);
 EXPORT_SYMBOL(acpi_get_object_info);
diff -puN drivers/acpi/bus.c~acpihelper drivers/acpi/bus.c
--- 2.6/drivers/acpi/bus.c~acpihelper	2004-11-08 11:05:22.768952872 +0800
+++ 2.6-root/drivers/acpi/bus.c	2004-11-08 11:05:22.776951656 +0800
@@ -271,7 +271,42 @@ end:
 	return_VALUE(result);
 }
 
+struct acpi_find_child {
+	acpi_handle     handle;
+	acpi_integer    address;
+};
 
+static acpi_status
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
+acpi_handle acpi_get_child(acpi_handle parent, acpi_integer address)
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
 
 /* --------------------------------------------------------------------------
                                 Event Management
diff -puN drivers/acpi/pci_root.c~acpihelper drivers/acpi/pci_root.c
--- 2.6/drivers/acpi/pci_root.c~acpihelper	2004-11-08 11:05:22.770952568 +0800
+++ 2.6-root/drivers/acpi/pci_root.c	2004-11-08 11:05:22.777951504 +0800
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
diff -puN include/acpi/acpi_bus.h~acpihelper include/acpi/acpi_bus.h
--- 2.6/include/acpi/acpi_bus.h~acpihelper	2004-11-08 11:05:22.771952416 +0800
+++ 2.6-root/include/acpi/acpi_bus.h	2004-11-08 11:05:22.777951504 +0800
@@ -313,6 +313,7 @@ extern struct subsystem acpi_subsys;
  * External Functions
  */
 
+acpi_handle acpi_get_child(acpi_handle parent, acpi_integer address);
 int acpi_bus_get_device(acpi_handle, struct acpi_device **device);
 int acpi_bus_get_status (struct acpi_device *device);
 int acpi_bus_get_power (acpi_handle handle, int *state);
diff -puN include/acpi/acpi_drivers.h~acpihelper include/acpi/acpi_drivers.h
--- 2.6/include/acpi/acpi_drivers.h~acpihelper	2004-11-08 11:05:22.773952112 +0800
+++ 2.6-root/include/acpi/acpi_drivers.h	2004-11-08 11:05:22.777951504 +0800
@@ -53,6 +53,7 @@
 
 #define ACPI_PCI_COMPONENT		0x00400000
 
+acpi_handle acpi_get_rootbridge_handle(u16 segment, u16 bus);
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
 int acpi_irq_penalty_init (void);
_

--=-/FtoVCyqys9NO3dAMW4V--

