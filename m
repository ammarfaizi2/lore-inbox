Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbULTW6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbULTW6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 17:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbULTW6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:58:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27014 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261683AbULTWvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:51:01 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] add PCI API to sysfs
Date: Mon, 20 Dec 2004 14:50:46 -0800
User-Agent: KMail/1.7.1
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, willy@debian.org,
       benh@kernel.crashing.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Hd1xBaE+eVDP5oF"
Message-Id: <200412201450.47952.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Hd1xBaE+eVDP5oF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, how does this one look?  It needs some obvious work, but is the approach 
of adding functionality to sysfs instead of /proc the right way to go?  What 
I've done:

  o add mmap support to bin files in sysfs
  o make PCI resources available via mmap
  o make legacy I/O and memory space available in sysfs

e.g.

0000:01:03.0/
|-- class
|-- config
|-- detach_state
|-- device
|-- driver -> ../../../bus/pci/drivers/qla1280
|-- host0
| <snip host stuff>
|-- irq
|-- legacy_io
|-- legacy_mem
|-- local_cpus
|-- resource
|-- resource0
|-- resource1
|-- rom
|-- subsystem_device
|-- subsystem_vendor
`-- vendor

Things that need work:
  o documentation
  o file placement
  o more error checking (e.g. don't call attr->read() unless it exists!)

I'm not sure where we should put the legacy stuff.  On sn2, each PCI root bus 
could have its own legacy files, but on other machines it might be a 
per-domain attribute.  Maybe we could define the API to be such that 
applications have to walk upward from the device they're interested in to get 
to legacy stuff?  Also, some arches (like ia64) don't allow mmap of I/O 
space, so I/O resources exported above will be useless unless I add 
read/write methods for I/O space.

Thanks,
Jesse

--Boundary-00=_Hd1xBaE+eVDP5oF
Content-Type: text/plain;
  charset="us-ascii";
  name="sysfs-pci-api-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-pci-api-2.patch"

===== arch/ia64/pci/pci.c 1.59 vs edited =====
--- 1.59/arch/ia64/pci/pci.c	2004-11-05 11:55:25 -08:00
+++ edited/arch/ia64/pci/pci.c	2004-12-20 14:26:13 -08:00
@@ -518,7 +518,7 @@
 	 * Leave vm_pgoff as-is, the PCI space address is the physical
 	 * address on this platform.
 	 */
-	vma->vm_flags |= (VM_SHM | VM_LOCKED | VM_IO);
+	vma->vm_flags |= (VM_SHM | VM_RESERVED | VM_IO);
 
 	if (write_combine)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
@@ -530,6 +530,123 @@
 		return -EAGAIN;
 
 	return 0;
+}
+
+/**
+ * pci_mmap_legacy_page_range - map legacy memory space to userland
+ * @dev: device to map
+ * @vma: vma passed in by mmap
+ *
+ * Map legacy memory space for this device back to userspace using a machine
+ * vector to get the base address.
+ */
+int
+pci_mmap_legacy_page_range(struct pci_dev *dev, struct vm_area_struct *vma)
+{
+	unsigned long addr;
+	int ret;
+
+	if ((ret = pci_get_legacy_mem(dev, &addr)))
+		return ret;
+
+	vma->vm_pgoff += addr >> PAGE_SHIFT;
+
+	/*
+	 * Leave vm_pgoff as-is, the PCI space address is the physical
+	 * address on this platform.
+	 */
+	vma->vm_flags |= (VM_SHM | VM_RESERVED | VM_IO);
+
+	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			    vma->vm_end - vma->vm_start, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
+/**
+ * ia64_pci_get_legacy_mem - generic legacy mem routine
+ * @dev: device pointer
+ * @addr: caller allocated variable for the base address
+ *
+ * Find the base of legacy memory for @dev.  This is typically the first
+ * megabyte of bus address space for @dev or is simply 0 on platforms whose
+ * chipsets support legacy I/O and memory routing.  Returns 0 on success
+ * or a standard error code on failure.
+ *
+ * This is the ia64 generic version of this routine.  Other platforms
+ * are free to override it with a machine vector.
+ */
+int ia64_pci_get_legacy_mem(struct pci_dev *dev, unsigned long *addr)
+{
+	*addr = 0;
+	return 0;
+}
+
+/**
+ * ia64_pci_legacy_read - read from legacy I/O space
+ * @dev: device to read
+ * @port: legacy port value
+ * @val: caller allocated storage for returned value
+ * @size: number of bytes to read
+ *
+ * Simply reads @size bytes from @port and puts the result in @val.
+ *
+ * Again, this (and the write routine) are generic versions that can be
+ * overridden by the platform.  This is necessary on platforms that don't
+ * support legacy I/O routing or that hard fail on legacy I/O timeouts.
+ */
+int ia64_pci_legacy_read(struct pci_dev *dev, u16 port, u32 *val, u8 size)
+{
+	int ret = size;
+
+	switch (size) {
+	case 1:
+		*val = inb(port);
+		break;
+	case 2:
+		*val = inw(port);
+		break;
+	case 4:
+		*val = inl(port);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+/**
+ * ia64_pci_legacy_write - perform a legacy I/O write
+ * @dev: device pointer
+ * @port: port to write
+ * @val: value to write
+ * @size: number of bytes to write from @val
+ *
+ * Simply writes @size bytes of @val to @port.
+ */
+int ia64_pci_legacy_write(struct pci_dev *dev, u16 port, u32 val, u8 size)
+{
+	int ret = 0;
+
+	switch (size) {
+	case 1:
+		outb(val, port);
+		break;
+	case 2:
+		outw(val, port);
+		break;
+	case 4:
+		outl(val, port);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
 }
 
 /**
===== arch/ia64/sn/pci/pci_dma.c 1.2 vs edited =====
--- 1.2/arch/ia64/sn/pci/pci_dma.c	2004-10-20 12:00:10 -07:00
+++ edited/arch/ia64/sn/pci/pci_dma.c	2004-12-20 13:47:49 -08:00
@@ -475,3 +475,77 @@
 EXPORT_SYMBOL(sn_pci_free_consistent);
 EXPORT_SYMBOL(sn_pci_dma_supported);
 EXPORT_SYMBOL(sn_dma_mapping_error);
+
+int sn_pci_get_legacy_mem(struct pci_dev *dev, unsigned long *addr)
+{
+	if (!SN_PCIDEV_BUSSOFT(dev))
+		return -ENODEV;
+
+	*addr = SN_PCIDEV_BUSSOFT(dev)->bs_legacy_mem | __IA64_UNCACHED_OFFSET;
+
+	return 0;
+}
+
+int sn_pci_legacy_read(struct pci_dev *dev, u16 port, u32 *val, u8 size)
+{
+	int ret = size;
+	unsigned long addr;
+
+	if (!SN_PCIDEV_BUSSOFT(dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	addr = SN_PCIDEV_BUSSOFT(dev)->bs_legacy_io | __IA64_UNCACHED_OFFSET;
+	addr += port;
+
+	ret = ia64_sn_probe_mem(addr, (long)size, (void *)val);
+
+	/* Read timed out, return -1 to emulate soft fail */
+	if (ret == 1)
+		*val = -1;
+
+	/* Invalid argument */
+	if (ret == 2)
+		ret = -EINVAL;
+
+ out:
+	return ret;
+}
+
+int sn_pci_legacy_write(struct pci_dev *dev, u16 port, u32 val, u8 size)
+{
+	int ret = 0;
+	unsigned long paddr;
+	unsigned long *addr;
+
+	if (!SN_PCIDEV_BUSSOFT(dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* Put the phys addr in uncached space */
+	paddr = SN_PCIDEV_BUSSOFT(dev)->bs_legacy_io | __IA64_UNCACHED_OFFSET;
+	paddr += port;
+	addr = (unsigned long *)paddr;
+
+	switch (size) {
+	case 1:
+		*(volatile u8 *)(addr) = (u8)(val);
+		ret = 1;
+		break;
+	case 2:
+		*(volatile u16 *)(addr) = (u16)(val);
+		ret = 2;
+		break;
+	case 4:
+		*(volatile u32 *)(addr) = (u32)(val);
+		ret = 4;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+ out:
+	return ret;
+}
===== drivers/pci/pci-sysfs.c 1.13 vs edited =====
--- 1.13/drivers/pci/pci-sysfs.c	2004-11-30 11:54:02 -08:00
+++ edited/drivers/pci/pci-sysfs.c	2004-12-20 14:31:13 -08:00
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/stat.h>
 #include <linux/topology.h>
+#include <linux/mm.h>
 
 #include "pci.h"
 
@@ -178,6 +179,99 @@
 	return count;
 }
 
+#ifdef HAVE_PCI_LEGACY
+/**
+ * pci_read_legacy_io - read byte(s) from legacy I/O port space
+ * @kobj: kobject corresponding to file to read from
+ * @buf: buffer to store results
+ * @off: offset into legacy I/O port space
+ * @count: number of bytes to read
+ *
+ * Reads 1, 2, or 4 bytes from legacy I/O port space using an arch specific
+ * callback routine (pci_legacy_read).
+ */
+static ssize_t
+pci_read_legacy_io(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct pci_dev *dev = to_pci_dev(container_of(kobj,
+						      struct device, kobj));
+
+	/* Only support 1, 2 or 4 byte accesses */
+	if (count != 1 && count != 2 && count != 4)
+		return -EINVAL;
+
+	return pci_legacy_read(dev, off, (u32 *)buf, count);
+}
+
+/**
+ * pci_write_legacy_io - write byte(s) to legacy I/O port space
+ * @kobj: kobject corresponding to file to read from
+ * @buf: buffer containing value to be written
+ * @off: offset into legacy I/O port space
+ * @count: number of bytes to write
+ *
+ * Writes 1, 2, or 4 bytes from legacy I/O port space using an arch specific
+ * callback routine (pci_legacy_write).
+ */
+static ssize_t
+pci_write_legacy_io(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct pci_dev *dev = to_pci_dev(container_of(kobj,
+						      struct device, kobj));
+	/* Only support 1, 2 or 4 byte accesses */
+	if (count != 1 && count != 2 && count != 4)
+		return -EINVAL;
+
+	return pci_legacy_write(dev, off, *(u32 *)buf, count);
+}
+
+/**
+ * pci_mmap_legacy_mem - map legacy PCI memory into user memory space
+ * @kobj: kobject corresponding to device to be mapped
+ * @attr: struct bin_attribute for this file
+ * @vma: struct vm_area_struct passed to mmap
+ *
+ * Uses an arch specific callback, pci_mmap_legacy_page_range, to mmap
+ * legacy memory space (first meg of bus space) into application virtual
+ * memory space.
+ */
+static int
+pci_mmap_legacy_mem(struct kobject *kobj, struct bin_attribute *attr,
+		    struct vm_area_struct *vma)
+{
+	struct pci_dev *pdev = to_pci_dev(container_of(kobj,
+						       struct device, kobj));
+
+	return pci_mmap_legacy_page_range(pdev, vma);
+}
+#endif /* HAVE_PCI_LEGACY */
+
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
@@ -261,6 +355,8 @@
 
 int pci_create_sysfs_dev_files (struct pci_dev *pdev)
 {
+	int i;
+
 	if (!sysfs_initialized)
 		return -EACCES;
 
@@ -269,6 +365,54 @@
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
+#ifdef HAVE_PCI_LEGACY
+	pdev->legacy_io = kmalloc(sizeof(struct bin_attribute) * 2,
+				  GFP_ATOMIC);
+	if (pdev->legacy_io) {
+		pdev->legacy_io->attr.name = "legacy_io";
+		pdev->legacy_io->size = 0xffff;
+		pdev->legacy_io->attr.mode = S_IRUSR | S_IWUSR;
+		pdev->legacy_io->attr.owner = THIS_MODULE;
+		pdev->legacy_io->read = pci_read_legacy_io;
+		pdev->legacy_io->write = pci_write_legacy_io;
+		sysfs_create_bin_file(&pdev->dev.kobj, pdev->legacy_io);
+
+		/* Allocated above after the legacy_io struct */
+		pdev->legacy_mem = pdev->legacy_io + 1;
+		pdev->legacy_mem->attr.name = "legacy_mem";
+		pdev->legacy_mem->size = 1024*1024;
+		pdev->legacy_mem->attr.mode = S_IRUSR | S_IWUSR;
+		pdev->legacy_mem->attr.owner = THIS_MODULE;
+		pdev->legacy_mem->mmap = pci_mmap_legacy_mem;
+		sysfs_create_bin_file(&pdev->dev.kobj, pdev->legacy_mem);
+	}
+#endif
+
 	/* If the device has a ROM, try to expose it in sysfs. */
 	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
 		struct bin_attribute *rom_attr;
@@ -299,10 +443,32 @@
  */
 void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 {
+	int i;
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
+
+#ifdef HAVE_PCI_LEGACY
+	/* Having one means having both */
+	if (pdev->legacy_io) {
+		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->legacy_io);
+		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->legacy_mem);
+	}
+#endif
 
 	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
 		if (pdev->rom_attr) {
===== fs/sysfs/bin.c 1.19 vs edited =====
--- 1.19/fs/sysfs/bin.c	2004-11-01 12:46:46 -08:00
+++ edited/fs/sysfs/bin.c	2004-12-20 11:07:58 -08:00
@@ -92,6 +92,15 @@
 	return count;
 }
 
+static int mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct dentry *dentry = file->f_dentry;
+	struct bin_attribute *attr = to_bin_attr(dentry);
+	struct kobject *kobj = to_kobj(dentry->d_parent);
+
+	return attr->mmap(kobj, attr, vma);
+}
+
 static int open(struct inode * inode, struct file * file)
 {
 	struct kobject *kobj = sysfs_get_kobject(file->f_dentry->d_parent);
@@ -107,9 +116,9 @@
 		goto Done;
 
 	error = -EACCES;
-	if ((file->f_mode & FMODE_WRITE) && !attr->write)
+	if ((file->f_mode & FMODE_WRITE) && !(attr->write || attr->mmap))
 		goto Error;
-	if ((file->f_mode & FMODE_READ) && !attr->read)
+	if ((file->f_mode & FMODE_READ) && !(attr->read || attr->mmap))
 		goto Error;
 
 	error = -ENOMEM;
@@ -144,6 +153,7 @@
 struct file_operations bin_fops = {
 	.read		= read,
 	.write		= write,
+	.mmap		= mmap,
 	.llseek		= generic_file_llseek,
 	.open		= open,
 	.release	= release,
===== include/asm-ia64/machvec.h 1.29 vs edited =====
--- 1.29/include/asm-ia64/machvec.h	2004-10-25 13:06:49 -07:00
+++ edited/include/asm-ia64/machvec.h	2004-12-16 10:56:59 -08:00
@@ -20,6 +20,7 @@
 struct irq_desc;
 struct page;
 struct mm_struct;
+struct pci_dev;
 
 typedef void ia64_mv_setup_t (char **);
 typedef void ia64_mv_cpu_init_t (void);
@@ -31,6 +32,11 @@
 typedef struct irq_desc *ia64_mv_irq_desc (unsigned int);
 typedef u8 ia64_mv_irq_to_vector (unsigned int);
 typedef unsigned int ia64_mv_local_vector_to_irq (u8);
+typedef int ia64_mv_pci_get_legacy_mem_t (struct pci_dev *, unsigned long *);
+typedef int ia64_mv_pci_legacy_read_t (struct pci_dev *, u16 port, u32 *val,
+				       u8 size);
+typedef int ia64_mv_pci_legacy_write_t (struct pci_dev *, u16 port, u32 val,
+					u8 size);
 
 /* DMA-mapping interface: */
 typedef void ia64_mv_dma_init (void);
@@ -125,6 +131,9 @@
 #  define platform_irq_desc		ia64_mv.irq_desc
 #  define platform_irq_to_vector	ia64_mv.irq_to_vector
 #  define platform_local_vector_to_irq	ia64_mv.local_vector_to_irq
+#  define platform_pci_get_legacy_mem	ia64_mv.pci_get_legacy_mem
+#  define platform_pci_legacy_read	ia64_mv.pci_legacy_read
+#  define platform_pci_legacy_write	ia64_mv.pci_legacy_write
 #  define platform_inb		ia64_mv.inb
 #  define platform_inw		ia64_mv.inw
 #  define platform_inl		ia64_mv.inl
@@ -172,6 +181,9 @@
 	ia64_mv_irq_desc *irq_desc;
 	ia64_mv_irq_to_vector *irq_to_vector;
 	ia64_mv_local_vector_to_irq *local_vector_to_irq;
+	ia64_mv_pci_get_legacy_mem_t *pci_get_legacy_mem;
+	ia64_mv_pci_legacy_read_t *pci_legacy_read;
+	ia64_mv_pci_legacy_write_t *pci_legacy_write;
 	ia64_mv_inb_t *inb;
 	ia64_mv_inw_t *inw;
 	ia64_mv_inl_t *inl;
@@ -215,6 +227,9 @@
 	platform_irq_desc,			\
 	platform_irq_to_vector,			\
 	platform_local_vector_to_irq,		\
+	platform_pci_get_legacy_mem,		\
+	platform_pci_legacy_read,		\
+	platform_pci_legacy_write,		\
 	platform_inb,				\
 	platform_inw,				\
 	platform_inl,				\
@@ -329,6 +344,15 @@
 #endif
 #ifndef platform_local_vector_to_irq
 # define platform_local_vector_to_irq	__ia64_local_vector_to_irq
+#endif
+#ifndef platform_pci_get_legacy_mem
+# define platform_pci_get_legacy_mem	ia64_pci_get_legacy_mem
+#endif
+#ifndef platform_pci_legacy_read
+# define platform_pci_legacy_read	ia64_pci_legacy_read
+#endif
+#ifndef platform_pci_legacy_write
+# define platform_pci_legacy_write	ia64_pci_legacy_write
 #endif
 #ifndef platform_inb
 # define platform_inb		__ia64_inb
===== include/asm-ia64/machvec_init.h 1.8 vs edited =====
--- 1.8/include/asm-ia64/machvec_init.h	2004-10-25 13:06:49 -07:00
+++ edited/include/asm-ia64/machvec_init.h	2004-12-16 10:56:59 -08:00
@@ -5,6 +5,9 @@
 extern ia64_mv_irq_desc __ia64_irq_desc;
 extern ia64_mv_irq_to_vector __ia64_irq_to_vector;
 extern ia64_mv_local_vector_to_irq __ia64_local_vector_to_irq;
+extern ia64_mv_pci_get_legacy_mem_t ia64_pci_get_legacy_mem;
+extern ia64_mv_pci_legacy_read_t ia64_pci_legacy_read;
+extern ia64_mv_pci_legacy_write_t ia64_pci_legacy_write;
 
 extern ia64_mv_inb_t __ia64_inb;
 extern ia64_mv_inw_t __ia64_inw;
===== include/asm-ia64/machvec_sn2.h 1.16 vs edited =====
--- 1.16/include/asm-ia64/machvec_sn2.h	2004-10-25 13:06:49 -07:00
+++ edited/include/asm-ia64/machvec_sn2.h	2004-12-16 10:56:59 -08:00
@@ -43,6 +43,9 @@
 extern ia64_mv_irq_desc sn_irq_desc;
 extern ia64_mv_irq_to_vector sn_irq_to_vector;
 extern ia64_mv_local_vector_to_irq sn_local_vector_to_irq;
+extern ia64_mv_pci_get_legacy_mem_t sn_pci_get_legacy_mem;
+extern ia64_mv_pci_legacy_read_t sn_pci_legacy_read;
+extern ia64_mv_pci_legacy_write_t sn_pci_legacy_write;
 extern ia64_mv_inb_t __sn_inb;
 extern ia64_mv_inw_t __sn_inw;
 extern ia64_mv_inl_t __sn_inl;
@@ -105,6 +108,9 @@
 #define platform_irq_desc		sn_irq_desc
 #define platform_irq_to_vector		sn_irq_to_vector
 #define platform_local_vector_to_irq	sn_local_vector_to_irq
+#define platform_pci_get_legacy_mem	sn_pci_get_legacy_mem
+#define platform_pci_legacy_read	sn_pci_legacy_read
+#define platform_pci_legacy_write	sn_pci_legacy_write
 #define platform_dma_init		machvec_noop
 #define platform_dma_alloc_coherent	sn_dma_alloc_coherent
 #define platform_dma_free_coherent	sn_dma_free_coherent
===== include/asm-ia64/pci.h 1.27 vs edited =====
--- 1.27/include/asm-ia64/pci.h	2004-11-03 13:36:55 -08:00
+++ edited/include/asm-ia64/pci.h	2004-12-20 14:29:52 -08:00
@@ -85,6 +85,12 @@
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
 				enum pci_mmap_state mmap_state, int write_combine);
+#define HAVE_PCI_LEGACY
+extern int pci_mmap_legacy_page_range (struct pci_dev *dev,
+				       struct vm_area_struct *vma);
+#define pci_get_legacy_mem platform_pci_get_legacy_mem
+#define pci_legacy_read platform_pci_legacy_read
+#define pci_legacy_write platform_pci_legacy_write
 
 struct pci_window {
 	struct resource resource;
===== include/asm-ia64/sn/sn_sal.h 1.17 vs edited =====
--- 1.17/include/asm-ia64/sn/sn_sal.h	2004-11-03 13:41:17 -08:00
+++ edited/include/asm-ia64/sn/sn_sal.h	2004-12-16 11:19:33 -08:00
@@ -474,6 +474,52 @@
 	return isrv.v0;
 }
 
+/**
+ * ia64_sn_probe_mem - read from memory safely
+ * @addr: address to probe
+ * @size: number bytes to read (1,2,4,8)
+ * @data_ptr: address to store value read by probe (-1 returned if probe fails)
+ *
+ * Call into the SAL to do a memory read.  If the read generates a machine
+ * check, this routine will recover gracefully and return -1 to the caller.
+ * @addr is usually a kernel virtual address in uncached space (i.e. the
+ * address starts with 0xc), but if called in physical mode, @addr should
+ * be a physical address.
+ *
+ * Return values:
+ *  0 - probe successful
+ *  1 - probe failed (generated MCA)
+ *  2 - Bad arg
+ * <0 - PAL error
+ */
+static inline u64
+ia64_sn_probe_mem(long addr, long size, void *data_ptr)
+{
+	struct ia64_sal_retval isrv;
+
+	SAL_CALL(isrv, SN_SAL_PROBE, addr, size, 0, 0, 0, 0, 0);
+
+	if (data_ptr) {
+		switch (size) {
+		case 1:
+			*((u8*)data_ptr) = (u8)isrv.v0;
+			break;
+		case 2:
+			*((u16*)data_ptr) = (u16)isrv.v0;
+			break;
+		case 4:
+			*((u32*)data_ptr) = (u32)isrv.v0;
+			break;
+		case 8:
+			*((u64*)data_ptr) = (u64)isrv.v0;
+			break;
+		default:
+			isrv.status = 2;
+		}
+	}
+	return isrv.status;
+}
+
 /*
  * Retrieve the system serial number as an ASCII string.
  */
===== include/linux/pci.h 1.142 vs edited =====
--- 1.142/include/linux/pci.h	2004-10-31 14:10:04 -08:00
+++ edited/include/linux/pci.h	2004-12-20 14:30:37 -08:00
@@ -539,6 +539,9 @@
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
+	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
+	struct bin_attribute *legacy_io; /* sysfs files for legacy stuff */
+	struct bin_attribute *legacy_mem;
 #ifdef CONFIG_PCI_NAMES
 #define PCI_NAME_SIZE	96
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */
===== include/linux/sysfs.h 1.38 vs edited =====
--- 1.38/include/linux/sysfs.h	2004-11-01 12:47:02 -08:00
+++ edited/include/linux/sysfs.h	2004-12-20 11:36:14 -08:00
@@ -47,11 +47,16 @@
 
 #define attr_name(_attr) (_attr).attr.name
 
+struct vm_area_struct; /* circular dependencies? */
+
 struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
+	void			*private;
 	ssize_t (*read)(struct kobject *, char *, loff_t, size_t);
 	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
+	int (*mmap)(struct kobject *, struct bin_attribute *attr,
+		    struct vm_area_struct *vma);
 };
 
 struct sysfs_ops {

--Boundary-00=_Hd1xBaE+eVDP5oF--
