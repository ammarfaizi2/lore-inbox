Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVAHH6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVAHH6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVAHH5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:57:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:39045 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261852AbVAHFsM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:12 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632623844@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:42 -0800
Message-Id: <11051632624000@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.27, 2004/12/21 12:12:05-08:00, jbarnes@engr.sgi.com

[PATCH] PCI: export PCI resources in sysfs

This patch exports PCI resources to userspace in the corresponding sysfs
device directory.  It depends on the platform HAVE_PCI_MMAP code, and is
#ifdef'd accordingly.  I've also added documentation describing the sysfs PCI
device file layout.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/filesystems/sysfs-pci.txt |   64 ++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 |   92 ++++++++++++++++++++++++++++++++
 include/linux/pci.h                     |    1 
 3 files changed, 157 insertions(+)


diff -Nru a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesystems/sysfs-pci.txt
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/filesystems/sysfs-pci.txt	2005-01-07 15:40:39 -08:00
@@ -0,0 +1,64 @@
+Accessing PCI device resources through sysfs
+
+sysfs, usually mounted at /sys, provides access to PCI resources on platforms
+that support it.  For example, a given bus might look like this:
+
+     pci0000:17
+     |-- 0000:17:00.0
+     |   |-- class
+     |   |-- config
+     |   |-- detach_state
+     |   |-- device
+     |   |-- irq
+     |   |-- local_cpus
+     |   |-- resource
+     |   |-- resource0
+     |   |-- resource1
+     |   |-- resource2
+     |   |-- rom
+     |   |-- subsystem_device
+     |   |-- subsystem_vendor
+     |   `-- vendor
+     `-- detach_state
+
+The topmost element describes the PCI domain and bus number.  In this case,
+the domain number is 0000 and the bus number is 17 (both values are in hex).
+This bus contains a single function device in slot 0.  The domain and bus
+numbers are reproduced for convenience.  Under the device directory are several
+files, each with their own function.
+
+       file		   function
+       ----		   --------
+       class		   PCI class (ascii, ro)
+       config		   PCI config space (binary, rw)
+       detach_state	   connection status (bool, rw)
+       device		   PCI device (ascii, ro)
+       irq		   IRQ number (ascii, ro)
+       local_cpus	   nearby CPU mask (cpumask, ro)
+       resource		   PCI resource host addresses (ascii, ro)
+       resource0..N	   PCI resource N, if present (binary, mmap)
+       rom		   PCI ROM resource, if present (binary, ro)
+       subsystem_device	   PCI subsystem device (ascii, ro)
+       subsystem_vendor	   PCI subsystem vendor (ascii, ro)
+       vendor		   PCI vendor (ascii, ro)
+
+  ro - read only file
+  rw - file is readable and writable
+  mmap - file is mmapable
+  ascii - file contains ascii text
+  binary - file contains binary data
+  cpumask - file contains a cpumask type
+
+The read only files are informational, writes to them will be ignored.
+Writable files can be used to perform actions on the device (e.g. changing
+config space, detaching a device).  mmapable files are available via an
+mmap of the file at offset 0 and can be used to do actual device programming
+from userspace.  Note that some platforms don't support mmapping of certain
+resources, so be sure to check the return value from any attempted mmap.
+
+Supporting PCI access on new platforms
+
+In order to support PCI resource mapping as described above, Linux platform
+code must define HAVE_PCI_MMAP and provide a pci_mmap_page_range function.
+Platforms are free to only support subsets of the mmap functionality, but
+useful return codes should be provided.
diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	2005-01-07 15:40:39 -08:00
+++ b/drivers/pci/pci-sysfs.c	2005-01-07 15:40:39 -08:00
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/stat.h>
 #include <linux/topology.h>
+#include <linux/mm.h>
 
 #include "pci.h"
 
@@ -178,6 +179,93 @@
 	return count;
 }
 
+#ifdef HAVE_PCI_MMAP
+/**
+ * pci_mmap_resource - map a PCI resource into user memory space
+ * @kobj: kobject for mapping
+ * @attr: struct bin_attribute for the file being mapped
+ * @vma: struct vm_area_struct passed into the mmap
+ *
+ * Use the regular PCI mapping routines to map a PCI resource into userspace.
+ * FIXME: write combining?  maybe automatic for prefetchable regions?
+ */
+static int
+pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
+		  struct vm_area_struct *vma)
+{
+	struct pci_dev *pdev = to_pci_dev(container_of(kobj,
+						       struct device, kobj));
+	struct resource *res = (struct resource *)attr->private;
+	enum pci_mmap_state mmap_type;
+
+	vma->vm_pgoff += res->start >> PAGE_SHIFT;
+	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+
+	return pci_mmap_page_range(pdev, vma, mmap_type, 0);
+}
+
+/**
+ * pci_create_resource_files - create resource files in sysfs for @dev
+ * @dev: dev in question
+ *
+ * Walk the resources in @dev creating files for each resource available.
+ */
+static void
+pci_create_resource_files(struct pci_dev *pdev)
+{
+	int i;
+
+	/* Expose the PCI resources from this device as files */
+	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+		struct bin_attribute *res_attr;
+
+		/* skip empty resources */
+		if (!pci_resource_len(pdev, i))
+			continue;
+
+		res_attr = kmalloc(sizeof(*res_attr) + 10, GFP_ATOMIC);
+		if (res_attr) {
+			pdev->res_attr[i] = res_attr;
+			/* Allocated above after the res_attr struct */
+			res_attr->attr.name = (char *)(res_attr + 1);
+			sprintf(res_attr->attr.name, "resource%d", i);
+			res_attr->size = pci_resource_len(pdev, i);
+			res_attr->attr.mode = S_IRUSR | S_IWUSR;
+			res_attr->attr.owner = THIS_MODULE;
+			res_attr->mmap = pci_mmap_resource;
+			res_attr->private = &pdev->resource[i];
+			sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
+		}
+	}
+}
+
+/**
+ * pci_remove_resource_files - cleanup resource files
+ * @dev: dev to cleanup
+ *
+ * If we created resource files for @dev, remove them from sysfs and
+ * free their resources.
+ */
+static void
+pci_remove_resource_files(struct pci_dev *pdev)
+{
+	int i;
+
+	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+		struct bin_attribute *res_attr;
+
+		res_attr = pdev->res_attr[i];
+		if (res_attr) {
+			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
+			kfree(res_attr);
+		}
+	}
+}
+#else /* !HAVE_PCI_MMAP */
+static inline void pci_create_resource_files(struct pci_dev *dev) { return; }
+static inline void pci_remove_resource_files(struct pci_dev *dev) { return; }
+#endif /* HAVE_PCI_MMAP */
+
 /**
  * pci_write_rom - used to enable access to the PCI ROM display
  * @kobj: kernel object handle
@@ -269,6 +357,8 @@
 	else
 		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
 
+	pci_create_resource_files(pdev);
+
 	/* If the device has a ROM, try to expose it in sysfs. */
 	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
 		struct bin_attribute *rom_attr;
@@ -303,6 +393,8 @@
 		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else
 		sysfs_remove_bin_file(&pdev->dev.kobj, &pcie_config_attr);
+
+	pci_remove_resource_files(pdev);
 
 	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
 		if (pdev->rom_attr) {
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-01-07 15:40:39 -08:00
+++ b/include/linux/pci.h	2005-01-07 15:40:39 -08:00
@@ -539,6 +539,7 @@
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
+	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE	96
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */

