Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbULUUtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbULUUtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 15:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbULUUtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 15:49:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60294 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261845AbULUUr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 15:47:58 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: [PATCH] add legacy resources to sysfs
Date: Tue, 21 Dec 2004 12:47:44 -0800
User-Agent: KMail/1.7.1
Cc: willy@debian.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wvIyB+s6UBT9coc"
Message-Id: <200412211247.44883.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_wvIyB+s6UBT9coc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a rediff against Greg's current tree.  It adds legacy_io and legacy_mem 
files to each PCI bus directory in sysfs for use by applications that want to 
do old school ISA style programming from userspace.

I'm not sure I've got the sysfs file creation correct, Greg?  Am I passing the 
wrong thing around?  The compile warnings in pci-sysfs.c for the new routines 
seem to indicate that...  Basically I need to get to a pci_bus structure from 
the read/write/mmap routines, and that should be accessible from the kobject 
somewhere, right?

I'll need buy in from Tony, willy, Ben, and Bjorn (and of course Greg) in 
order to submit this for inclusion since I want to make sure that their 
legacy needs are fulfilled.

Thanks,
Jesse

--Boundary-00=_wvIyB+s6UBT9coc
Content-Type: text/plain;
  charset="us-ascii";
  name="sysfs-legacy-resource-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-legacy-resource-2.patch"

===== arch/ia64/pci/pci.c 1.59 vs edited =====
--- 1.59/arch/ia64/pci/pci.c	2004-11-05 11:55:25 -08:00
+++ edited/arch/ia64/pci/pci.c	2004-12-21 12:32:35 -08:00
@@ -6,6 +6,7 @@
  * Copyright (C) 2002 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  *	Bjorn Helgaas <bjorn_helgaas@hp.com>
+ * Copyright (C) 2004 Silicon Graphics, Inc.
  *
  * Note: Above list of copyright holders is incomplete...
  */
@@ -518,7 +519,7 @@
 	 * Leave vm_pgoff as-is, the PCI space address is the physical
 	 * address on this platform.
 	 */
-	vma->vm_flags |= (VM_SHM | VM_LOCKED | VM_IO);
+	vma->vm_flags |= (VM_SHM | VM_RESERVED | VM_IO);
 
 	if (write_combine)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
@@ -530,6 +531,123 @@
 		return -EAGAIN;
 
 	return 0;
+}
+
+/**
+ * pci_mmap_legacy_page_range - map legacy memory space to userland
+ * @bus: bus whose legacy space we're mapping
+ * @vma: vma passed in by mmap
+ *
+ * Map legacy memory space for this device back to userspace using a machine
+ * vector to get the base address.
+ */
+int
+pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma)
+{
+	unsigned long addr;
+	int ret;
+
+	if ((ret = pci_get_legacy_mem(bus, &addr)))
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
+ * @bus: bus to get legacy memory base address for
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
+int ia64_pci_get_legacy_mem(struct pci_bus *bus, unsigned long *addr)
+{
+	*addr = 0;
+	return 0;
+}
+
+/**
+ * ia64_pci_legacy_read - read from legacy I/O space
+ * @bus: bus to read
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
+int ia64_pci_legacy_read(struct pci_bus *bus, u16 port, u32 *val, u8 size)
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
+ * @bus: bus pointer
+ * @port: port to write
+ * @val: value to write
+ * @size: number of bytes to write from @val
+ *
+ * Simply writes @size bytes of @val to @port.
+ */
+int ia64_pci_legacy_write(struct pci_dev *bus, u16 port, u32 val, u8 size)
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
+++ edited/arch/ia64/sn/pci/pci_dma.c	2004-12-21 12:32:35 -08:00
@@ -475,3 +475,77 @@
 EXPORT_SYMBOL(sn_pci_free_consistent);
 EXPORT_SYMBOL(sn_pci_dma_supported);
 EXPORT_SYMBOL(sn_dma_mapping_error);
+
+int sn_pci_get_legacy_mem(struct pci_bus *bus, unsigned long *addr)
+{
+	if (!SN_PCIBUS_BUSSOFT(bus))
+		return -ENODEV;
+
+	*addr = SN_PCIBUS_BUSSOFT(bus)->bs_legacy_mem | __IA64_UNCACHED_OFFSET;
+
+	return 0;
+}
+
+int sn_pci_legacy_read(struct pci_bus *bus, u16 port, u32 *val, u8 size)
+{
+	int ret = size;
+	unsigned long addr;
+
+	if (!SN_PCIBUS_BUSSOFT(bus)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	addr = SN_PCIBUS_BUSSOFT(bus)->bs_legacy_io | __IA64_UNCACHED_OFFSET;
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
+int sn_pci_legacy_write(struct pci_bus *bus, u16 port, u32 val, u8 size)
+{
+	int ret = 0;
+	unsigned long paddr;
+	unsigned long *addr;
+
+	if (!SN_PCIBUS_BUSSOFT(bus)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* Put the phys addr in uncached space */
+	paddr = SN_PCIBUS_BUSSOFT(bus)->bs_legacy_io | __IA64_UNCACHED_OFFSET;
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
===== drivers/pci/pci-sysfs.c 1.14 vs edited =====
--- 1.14/drivers/pci/pci-sysfs.c	2004-12-21 11:28:57 -08:00
+++ edited/drivers/pci/pci-sysfs.c	2004-12-21 12:41:31 -08:00
@@ -179,6 +179,73 @@
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
+ssize_t
+pci_read_legacy_io(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+        struct pci_bus *bus = to_pci_bus(container_of(kobj,
+                                                      struct device, kobj));
+
+        /* Only support 1, 2 or 4 byte accesses */
+        if (count != 1 && count != 2 && count != 4)
+                return -EINVAL;
+
+        return pci_legacy_read(bus, off, (u32 *)buf, count);
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
+ssize_t
+pci_write_legacy_io(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+        struct pci_bus *bus = to_pci_bus(container_of(kobj,
+                                                      struct device, kobj));
+        /* Only support 1, 2 or 4 byte accesses */
+        if (count != 1 && count != 2 && count != 4)
+                return -EINVAL;
+
+        return pci_legacy_write(bus, off, *(u32 *)buf, count);
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
+int
+pci_mmap_legacy_mem(struct kobject *kobj, struct bin_attribute *attr,
+                    struct vm_area_struct *vma)
+{
+        struct pci_bus *bus = to_pci_bus(container_of(kobj,
+                                                      struct device, kobj));
+
+        return pci_mmap_legacy_page_range(bus, vma);
+}
+#endif /* HAVE_PCI_LEGACY */
+
 #ifdef HAVE_PCI_MMAP
 /**
  * pci_mmap_resource - map a PCI resource into user memory space
===== drivers/pci/probe.c 1.72 vs edited =====
--- 1.72/drivers/pci/probe.c	2004-11-11 12:53:33 -08:00
+++ edited/drivers/pci/probe.c	2004-12-21 12:40:52 -08:00
@@ -764,6 +764,42 @@
 	return max;
 }
 
+#ifdef HAVE_PCI_LEGACY
+/**
+ * pci_create_legacy_files - create legacy I/O port and memory files
+ * @b: bus to create files under
+ *
+ * Some platforms allow access to legacy I/O port and ISA memory space on
+ * a per-bus basis.  This routine creates the files and ties them into
+ * their associated read, write and mmap files from pci-sysfs.c
+ */
+static void pci_create_legacy_files(struct pci_bus *b)
+{
+	b->legacy_io = kmalloc(sizeof(struct bin_attribute) * 2,
+			       GFP_ATOMIC);
+	if (b->legacy_io) {
+		b->legacy_io->attr.name = "legacy_io";
+		b->legacy_io->size = 0xffff;
+		b->legacy_io->attr.mode = S_IRUSR | S_IWUSR;
+		b->legacy_io->attr.owner = THIS_MODULE;
+		b->legacy_io->read = pci_read_legacy_io;
+		b->legacy_io->write = pci_write_legacy_io;
+		sysfs_create_bin_file(&b->bridge->kobj, b->legacy_io);
+
+		/* Allocated above after the legacy_io struct */
+		b->legacy_mem = b->legacy_io + 1;
+		b->legacy_mem->attr.name = "legacy_mem";
+		b->legacy_mem->size = 1024*1024;
+		b->legacy_mem->attr.mode = S_IRUSR | S_IWUSR;
+		b->legacy_mem->attr.owner = THIS_MODULE;
+		b->legacy_mem->mmap = pci_mmap_legacy_mem;
+		sysfs_create_bin_file(&b->bridge->kobj, b->legacy_mem);
+	}
+}
+#else /* !HAVE_PCI_LEGACY */
+static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
+#endif /* HAVE_PCI_LEGACY */
+
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
 {
 	int error;
@@ -802,11 +838,15 @@
 	b->class_dev.class = &pcibus_class;
 	sprintf(b->class_dev.class_id, "%04x:%02x", pci_domain_nr(b), bus);
 	error = class_device_register(&b->class_dev);
+
 	if (error)
 		goto class_dev_reg_err;
 	error = class_device_create_file(&b->class_dev, &class_device_attr_cpuaffinity);
 	if (error)
 		goto class_dev_create_file_err;
+
+	/* Create legacy_io and legacy_mem files for this bus */
+	pci_create_legacy_files(b);
 
 	error = sysfs_create_link(&b->class_dev.kobj, &b->bridge->kobj, "bridge");
 	if (error)
===== include/asm-ia64/machvec.h 1.29 vs edited =====
--- 1.29/include/asm-ia64/machvec.h	2004-10-25 13:06:49 -07:00
+++ edited/include/asm-ia64/machvec.h	2004-12-21 12:32:37 -08:00
@@ -20,6 +20,7 @@
 struct irq_desc;
 struct page;
 struct mm_struct;
+struct pci_bus;
 
 typedef void ia64_mv_setup_t (char **);
 typedef void ia64_mv_cpu_init_t (void);
@@ -31,6 +32,11 @@
 typedef struct irq_desc *ia64_mv_irq_desc (unsigned int);
 typedef u8 ia64_mv_irq_to_vector (unsigned int);
 typedef unsigned int ia64_mv_local_vector_to_irq (u8);
+typedef int ia64_mv_pci_get_legacy_mem_t (struct pci_bus *, unsigned long *);
+typedef int ia64_mv_pci_legacy_read_t (struct pci_bus *, u16 port, u32 *val,
+				       u8 size);
+typedef int ia64_mv_pci_legacy_write_t (struct pci_bus *, u16 port, u32 val,
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
+++ edited/include/asm-ia64/machvec_init.h	2004-12-21 12:32:37 -08:00
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
+++ edited/include/asm-ia64/machvec_sn2.h	2004-12-21 12:32:37 -08:00
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
+++ edited/include/asm-ia64/pci.h	2004-12-21 12:32:38 -08:00
@@ -85,6 +85,20 @@
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
 				enum pci_mmap_state mmap_state, int write_combine);
+#define HAVE_PCI_LEGACY
+extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
+				      struct vm_area_struct *vma);
+extern ssize_t pci_read_legacy_io(struct kobject *kobj, char *buf, loff_t off,
+				  size_t count);
+extern ssize_t pci_write_legacy_io(struct kobject *kobj, char *buf, loff_t off,
+				   size_t count);
+extern int pci_mmap_legacy_mem(struct kobject *kobj,
+			       struct bin_attribute *attr,
+			       struct vm_area_struct *vma);
+
+#define pci_get_legacy_mem platform_pci_get_legacy_mem
+#define pci_legacy_read platform_pci_legacy_read
+#define pci_legacy_write platform_pci_legacy_write
 
 struct pci_window {
 	struct resource resource;
===== include/asm-ia64/sn/sn_sal.h 1.17 vs edited =====
--- 1.17/include/asm-ia64/sn/sn_sal.h	2004-11-03 13:41:17 -08:00
+++ edited/include/asm-ia64/sn/sn_sal.h	2004-12-21 12:32:38 -08:00
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
===== include/linux/pci.h 1.143 vs edited =====
--- 1.143/include/linux/pci.h	2004-12-21 11:21:50 -08:00
+++ edited/include/linux/pci.h	2004-12-21 12:32:38 -08:00
@@ -594,6 +594,8 @@
 	unsigned short  pad2;
 	struct device		*bridge;
 	struct class_device	class_dev;
+	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */
+	struct bin_attribute	*legacy_mem; /* legacy mem */
 };
 
 #define pci_bus_b(n)	list_entry(n, struct pci_bus, node)

--Boundary-00=_wvIyB+s6UBT9coc--
