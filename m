Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbTFZAh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbTFZAgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:36:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:59127 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265256AbTFZAfG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:35:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10565884933148@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.73
In-Reply-To: <10565884923370@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Jun 2003 17:48:13 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1429.2.2, 2003/06/24 15:09:40-07:00, willy@debian.org

[PATCH] PCI: [PATCH] pcibios_scan_acpi()

On Mon, Jun 23, 2003 at 02:39:05PM -0700, Greg KH wrote:
> > How about acpi_scan_pci_bus_root()?
>
> I agree, that sounds better.

I think it's too long ... so unless anyone has a better idea, I'm going with
pci_acpi_scan_root().  Here's the patch, presented in patch -p1 format to
make greg's scripts happy ;-)

ia64 needs to be passed the pci domain and the acpi handle corresponding
to each root bus.  Rather than change pcibios_scan_root to take additional
arguments, this patch introduces pci_acpi_scan_root().


 arch/i386/pci/acpi.c        |   10 ++++++++++
 arch/ia64/pci/pci.c         |   14 +++++++-------
 drivers/acpi/pci_root.c     |    4 +---
 include/acpi/acpi_drivers.h |    4 ++++
 include/asm-ia64/pci.h      |    1 -
 5 files changed, 22 insertions(+), 11 deletions(-)


diff -Nru a/arch/i386/pci/acpi.c b/arch/i386/pci/acpi.c
--- a/arch/i386/pci/acpi.c	Wed Jun 25 17:38:23 2003
+++ b/arch/i386/pci/acpi.c	Wed Jun 25 17:38:23 2003
@@ -3,6 +3,16 @@
 #include <linux/init.h>
 #include "pci.h"
 
+struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_device *device, int domain, int busnum)
+{
+	if (domain != 0) {
+		printk(KERN_WARNING "PCI: Multiple domains not supported\n");
+		return NULL;
+	}
+
+	return pcibios_scan_root(busnum);
+}
+
 static int __init pci_acpi_init(void)
 {
 	if (pcibios_scanned)
diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c	Wed Jun 25 17:38:23 2003
+++ b/arch/ia64/pci/pci.c	Wed Jun 25 17:38:23 2003
@@ -284,21 +284,21 @@
 }
 
 struct pci_bus *
-pcibios_scan_root (void *handle, int seg, int bus)
+pci_acpi_scan_root (struct acpi_device *device, int domain, int bus)
 {
 	struct pci_root_info info;
 	struct pci_controller *controller;
 	unsigned int windows = 0;
 	char *name;
 
-	printk("PCI: Probing PCI hardware on bus (%02x:%02x)\n", seg, bus);
-	controller = alloc_pci_controller(seg);
+	printk("PCI: Probing PCI hardware on bus (%04x:%02x)\n", domain, bus);
+	controller = alloc_pci_controller(domain);
 	if (!controller)
 		goto out1;
 
-	controller->acpi_handle = handle;
+	controller->acpi_handle = device->handle;
 
-	acpi_walk_resources(handle, METHOD_NAME__CRS, count_window, &windows);
+	acpi_walk_resources(device->handle, METHOD_NAME__CRS, count_window, &windows);
 	controller->window = kmalloc(sizeof(*controller->window) * windows, GFP_KERNEL);
 	if (!controller->window)
 		goto out2;
@@ -307,10 +307,10 @@
 	if (!name)
 		goto out3;
 
-	sprintf(name, "PCI Bus %02x:%02x", seg, bus);
+	sprintf(name, "PCI Bus %04x:%02x", domain, bus);
 	info.controller = controller;
 	info.name = name;
-	acpi_walk_resources(handle, METHOD_NAME__CRS, add_window, &info);
+	acpi_walk_resources(device->handle, METHOD_NAME__CRS, add_window, &info);
 
 	return scan_root_bus(bus, &pci_root_ops, controller);
 
diff -Nru a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
--- a/drivers/acpi/pci_root.c	Wed Jun 25 17:38:23 2003
+++ b/drivers/acpi/pci_root.c	Wed Jun 25 17:38:23 2003
@@ -246,8 +246,6 @@
 	switch (status) {
 	case AE_OK:
 		root->id.segment = (u16) value;
-		printk("_SEG exists! Unsupported. Abort.\n");
-		BUG();
 		break;
 	case AE_NOT_FOUND:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
@@ -309,7 +307,7 @@
 	 * PCI namespace does not get created until this call is made (and 
 	 * thus the root bridge's pci_dev does not exist).
 	 */
-	root->bus = pcibios_scan_root(root->id.bus);
+	root->bus = pci_acpi_scan_root(device, root->id.segment, root->id.bus);
 	if (!root->bus) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
 			"Bus %02x:%02x not present in PCI namespace\n", 
diff -Nru a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
--- a/include/acpi/acpi_drivers.h	Wed Jun 25 17:38:23 2003
+++ b/include/acpi/acpi_drivers.h	Wed Jun 25 17:38:23 2003
@@ -73,6 +73,10 @@
 int acpi_pci_bind (struct acpi_device *device);
 int acpi_pci_bind_root (struct acpi_device *device, struct acpi_pci_id *id, struct pci_bus *bus);
 
+/* Arch-defined function to add a bus to the system */
+
+struct pci_bus *pci_acpi_scan_root(struct acpi_device *device, int domain, int bus);
+
 #endif /*CONFIG_ACPI_PCI*/
 
 
diff -Nru a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h	Wed Jun 25 17:38:23 2003
+++ b/include/asm-ia64/pci.h	Wed Jun 25 17:38:23 2003
@@ -21,7 +21,6 @@
 #define PCIBIOS_MIN_MEM		0x10000000
 
 void pcibios_config_init(void);
-struct pci_bus * pcibios_scan_root(void *acpi_handle, int segment, int bus);
 
 struct pci_dev;
 

