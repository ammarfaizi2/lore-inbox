Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbULUUAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbULUUAv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 15:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbULUUAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 15:00:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19164 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261602AbULUT4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:56:42 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] export PCI resources in sysfs
Date: Tue, 21 Dec 2004 11:56:39 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200412210943.40101.jbarnes@engr.sgi.com> <20041221184355.GB8557@kroah.com> <200412211109.03826.jbarnes@engr.sgi.com>
In-Reply-To: <200412211109.03826.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3/HyBLOujNcKe48"
Message-Id: <200412211156.39491.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_3/HyBLOujNcKe48
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, December 21, 2004 11:09 am, Jesse Barnes wrote:
> > How about wrapping these two #ifdef blocks into one function, and moving
> > it up in the file under the other #ifdef.  Do that for the other cleanup
> > function, and it will drop a bunch of #ifdefs.
>
> Yeah, that sounds good.  I really don't like adding these ifdefs, and
> limiting their scope to a function somewhere up above would be nicer.  I'll
> do that and respin.

Ok, here you go.

This patch exports PCI resources to userspace in the corresponding sysfs 
device directory.  It depends on the platform HAVE_PCI_MMAP code, and is 
#ifdef'd accordingly.  I've also added documentation describing the sysfs PCI 
device file layout.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_3/HyBLOujNcKe48
Content-Type: text/plain;
  charset="iso-8859-1";
  name="sysfs-pci-resource-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-pci-resource-2.patch"

===== drivers/pci/pci-sysfs.c 1.13 vs edited =====
--- 1.13/drivers/pci/pci-sysfs.c	2004-11-30 11:54:02 -08:00
+++ edited/drivers/pci/pci-sysfs.c	2004-12-21 11:28:57 -08:00
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
+static void pci_create_resource_files(struct pci_dev *dev) { return; }
+static void pci_remove_resource_files(struct pci_dev *dev) { return; }
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
===== include/linux/pci.h 1.142 vs edited =====
--- 1.142/include/linux/pci.h	2004-10-31 14:10:04 -08:00
+++ edited/include/linux/pci.h	2004-12-21 11:21:50 -08:00
@@ -539,6 +539,7 @@
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
+	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE	96
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */
--- /dev/null	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.5-pcires/Documentation/filesystems/sysfs-pci.txt	2004-12-21 11:50:26.000000000 -0800
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

--Boundary-00=_3/HyBLOujNcKe48--
