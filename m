Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbULURnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbULURnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 12:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbULURnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 12:43:50 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:29570 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261761AbULURnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 12:43:42 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] export PCI resources in sysfs
Date: Tue, 21 Dec 2004 09:43:39 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MDGyBpDZCsE/WP6"
Message-Id: <200412210943.40101.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_MDGyBpDZCsE/WP6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch sits on top of the last one that added mmap support to
struct bin_attribute.  It exports PCI resources from each device as a
file in the device's sysfs directory as resourceN where N is the
resource number.  The file is mmapable so that userspace can do
register reads and writes.

 drivers/pci/pci-sysfs.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |    1
 2 files changed, 73 insertions(+)

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_MDGyBpDZCsE/WP6
Content-Type: text/plain;
  charset="us-ascii";
  name="sysfs-pci-resource.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-pci-resource.patch"

===== drivers/pci/pci-sysfs.c 1.13 vs edited =====
--- 1.13/drivers/pci/pci-sysfs.c	2004-11-30 11:54:02 -08:00
+++ edited/drivers/pci/pci-sysfs.c	2004-12-21 09:38:49 -08:00
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/stat.h>
 #include <linux/topology.h>
+#include <linux/mm.h>
 
 #include "pci.h"
 
@@ -178,6 +179,32 @@
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
+#endif /* HAVE_PCI_MMAP */
+
 /**
  * pci_write_rom - used to enable access to the PCI ROM display
  * @kobj: kernel object handle
@@ -261,6 +288,10 @@
 
 int pci_create_sysfs_dev_files (struct pci_dev *pdev)
 {
+#ifdef HAVE_PCI_MMAP
+	int i;
+#endif
+
 	if (!sysfs_initialized)
 		return -EACCES;
 
@@ -269,6 +300,31 @@
 	else
 		sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
 
+#ifdef HAVE_PCI_MMAP
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
+#endif /* HAVE_PCI_MMAP */
+
 	/* If the device has a ROM, try to expose it in sysfs. */
 	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
 		struct bin_attribute *rom_attr;
@@ -299,10 +355,26 @@
  */
 void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 {
+#ifdef HAVE_PCI_MMAP
+	int i;
+#endif
+
 	if (pdev->cfg_size < 4096)
 		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	else
 		sysfs_remove_bin_file(&pdev->dev.kobj, &pcie_config_attr);
+
+#ifdef HAVE_PCI_MMAP
+	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+		struct bin_attribute *res_attr;
+
+		res_attr = pdev->res_attr[i];
+		if (res_attr) {
+			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
+			kfree(res_attr);
+		}
+	}
+#endif /* HAVE_PCI_MMAP */
 
 	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
 		if (pdev->rom_attr) {
===== include/linux/pci.h 1.142 vs edited =====
--- 1.142/include/linux/pci.h	2004-10-31 14:10:04 -08:00
+++ edited/include/linux/pci.h	2004-12-21 09:08:37 -08:00
@@ -539,6 +539,7 @@
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
+	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE	96
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */

--Boundary-00=_MDGyBpDZCsE/WP6--
