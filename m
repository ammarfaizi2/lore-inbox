Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUKHETO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUKHETO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 23:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUKHERu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 23:17:50 -0500
Received: from fmr05.intel.com ([134.134.136.6]:21992 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261750AbUKHERK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 23:17:10 -0500
Subject: [PATCH/RFC 3/4]An implementation for PCI bus
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Content-Type: multipart/mixed; boundary="=-+SBsETwcAhkJXYOy2dDT"
Message-Id: <1099887077.1750.247.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 08 Nov 2004 12:11:21 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+SBsETwcAhkJXYOy2dDT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
An implementation to bind PCI devices with ACPI devices


Thanks,
Shaohua
---

 2.6-root/drivers/pci/pci-driver.c |   52
++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+)

diff -puN drivers/pci/pci-driver.c~pci-bind-acpi
drivers/pci/pci-driver.c
--- 2.6/drivers/pci/pci-driver.c~pci-bind-acpi	2004-11-08
11:06:53.249197784 +0800
+++ 2.6-root/drivers/pci/pci-driver.c	2004-11-08 11:08:50.244411808
+0800
@@ -530,12 +530,64 @@ int pci_hotplug (struct device *dev, cha
 }
 #endif
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+int pci_device_platform_bind(struct device *dev)
+{
+	struct pci_dev * pci_dev;
+	acpi_handle parent_handle = NULL;
+	acpi_integer address;
+
+	pci_dev = to_pci_dev(dev);
+	if (!pci_dev->bus->parent) {
+		/* It's device under root bridge
+		 * This is a little ugly, but now root bridge
+		 * is added in special way.
+		 */
+		parent_handle = acpi_get_rootbridge_handle(
+			pci_domain_nr(pci_dev->bus), pci_dev->bus->number);
+	} else {
+		if (dev->parent)
+			parent_handle = dev->parent->handle;
+	}
+	if (!parent_handle) {
+		printk("Can't find parent handle \n");
+		return -1;
+	}
+	/* Please ref to ACPI spec for syntax of _ADR */
+	address = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
+	dev->handle = acpi_get_child(parent_handle, address);
+
+#if 1
+	{/* For Debug */
+		char		name[80] = {'?','\0'};
+		struct acpi_buffer	buffer = {sizeof(name), name};
+
+		printk("Device %s:", pci_name(pci_dev));
+		if (dev->handle) {
+			acpi_get_name(dev->handle, ACPI_FULL_PATHNAME, &buffer);
+			printk("%s", name);
+		}
+		printk("\n");
+	}
+#endif
+
+	return 0;
+}
+#else
+int pci_device_platform_bind(struct device *dev)
+{
+	return 0;
+}
+#endif
+
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
 	.hotplug	= pci_hotplug,
 	.suspend	= pci_device_suspend,
 	.resume		= pci_device_resume,
+	.platform_bind	= pci_device_platform_bind,
 	.dev_attrs	= pci_dev_attrs,
 };
 
_


--=-+SBsETwcAhkJXYOy2dDT
Content-Disposition: attachment; filename=p00003_pci-bind-acpi.patch
Content-Type: text/x-patch; name=p00003_pci-bind-acpi.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


A sample implementation to bind PCI devices with ACPI devices

---

 2.6-root/drivers/pci/pci-driver.c |   52 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+)

diff -puN drivers/pci/pci-driver.c~pci-bind-acpi drivers/pci/pci-driver.c
--- 2.6/drivers/pci/pci-driver.c~pci-bind-acpi	2004-11-08 11:06:53.249197784 +0800
+++ 2.6-root/drivers/pci/pci-driver.c	2004-11-08 11:08:50.244411808 +0800
@@ -530,12 +530,64 @@ int pci_hotplug (struct device *dev, cha
 }
 #endif
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+int pci_device_platform_bind(struct device *dev)
+{
+	struct pci_dev * pci_dev;
+	acpi_handle parent_handle = NULL;
+	acpi_integer address;
+
+	pci_dev = to_pci_dev(dev);
+	if (!pci_dev->bus->parent) {
+		/* It's device under root bridge
+		 * This is a little ugly, but now root bridge
+		 * is added in special way.
+		 */
+		parent_handle = acpi_get_rootbridge_handle(
+			pci_domain_nr(pci_dev->bus), pci_dev->bus->number);
+	} else {
+		if (dev->parent)
+			parent_handle = dev->parent->handle;
+	}
+	if (!parent_handle) {
+		printk("Can't find parent handle \n");
+		return -1;
+	}
+	/* Please ref to ACPI spec for syntax of _ADR */
+	address = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
+	dev->handle = acpi_get_child(parent_handle, address);
+
+#if 1
+	{/* For Debug */
+		char		name[80] = {'?','\0'};
+		struct acpi_buffer	buffer = {sizeof(name), name};
+
+		printk("Device %s:", pci_name(pci_dev));
+		if (dev->handle) {
+			acpi_get_name(dev->handle, ACPI_FULL_PATHNAME, &buffer);
+			printk("%s", name);
+		}
+		printk("\n");
+	}
+#endif
+
+	return 0;
+}
+#else
+int pci_device_platform_bind(struct device *dev)
+{
+	return 0;
+}
+#endif
+
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
 	.hotplug	= pci_hotplug,
 	.suspend	= pci_device_suspend,
 	.resume		= pci_device_resume,
+	.platform_bind	= pci_device_platform_bind,
 	.dev_attrs	= pci_dev_attrs,
 };
 
_

--=-+SBsETwcAhkJXYOy2dDT--

