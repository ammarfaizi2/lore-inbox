Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbULNRtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbULNRtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbULNRtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:49:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4010 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261574AbULNRmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:42:07 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cu, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] add legacy I/O and memory access routines to /proc/bus/pci API
Date: Tue, 14 Dec 2004 09:41:55 -0800
User-Agent: KMail/1.7.1
Cc: benh@kernel.crashing.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kXyvB8jWptIwo5e"
Message-Id: <200412140941.56116.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_kXyvB8jWptIwo5e
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds a new optional arch specific API to /proc/bus/pci to get at 
legacy I/O and memory space.  I know most platforms will correctly route 
legacy I/O and memory accesses to some well defined bus, but some don't (I 
think some PPC machines fall into the latter category?), thus the need for 
this patch.  I've also included draft documentation for the /proc/bus/pci API 
in general since it didn't appear to be documented anywhere but in the 
source.  Comments?  I'm successfully using this to bring up gfx stuff (i.e. 
card POSTing, X) on an Altix machine.

Thanks,
Jesse

--Boundary-00=_kXyvB8jWptIwo5e
Content-Type: text/plain;
  charset="us-ascii";
  name="legacy-ioctl-mem-api-4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="legacy-ioctl-mem-api-4.patch"

diff -Nru a/Documentation/filesystems/proc-pci.txt b/Documentation/filesystems/proc-pci.txt
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/filesystems/proc-pci.txt	2004-12-14 09:36:08 -08:00
@@ -0,0 +1,114 @@
+Directory layout
+
+/proc/bus/pci contains a list of PCI devices available on the system
+and can be used for driving PCI devices from userspace, getting a list
+of PCI devices, and hotplug support.  Example:
+
+  $ tree /proc/bus/pci
+  /proc/bus/pci/
+  |-- 01		directory for devices on bus 1 
+  |   |-- 01.0		single fn device in slot 1
+  |   |-- 03.0		single fn device in slot 3
+  |   `-- 04.0		single fn device in slot 4
+  |-- 02
+  |   |-- 01.0		single fn device in slot 1
+  |   |-- 02.0		<
+  |   |-- 02.1		< three function device on bus 2
+  |   `-- 02.2		< 
+  |-- 17
+  |   `-- 00.0		busses 17 and 1b have only one device each in
+  |			slot 0
+  |-- 1b
+  |   `-- 00.0
+  `-- devices		see below
+
+  4 directories, 10 files
+
+The devices file contains an entry for each PCI device in the system
+with information about the host addresses corresponding to the device
+BARs and which driver is bound to a device (if present).  This
+information can be used as an offset argument to mmap specific device
+files in the tree above.  Each field in the devices file is seperated
+by tabs with each device on a line by itself.  The fields are
+
+bus id
+?
+?
+host resource 0
+host resource 1
+host resource 2
+host resource 3
+host resource 4
+host resource 5
+host resource 6
+host resource 7
+BAR value 0
+BAR value 1
+BAR value 2
+BAR value 3
+BAR value 4
+BAR value 5
+BAR value 6
+driver name (if present)
+
+For example:
+
+0108	10a9100a	3e	c00000080f200000	0	0	0	0	0	0	100000	0	0	0	0	0	0	SGI-IOC4_IDE
+
+Available interfaces
+
+Each file corresponding to a device in /proc/bus/pci has open, read,
+write, lseek, ioctl, and mmap methods available.
+
+open
+  simply opens the device and returns a handle as expected
+
+read
+  reads from either PCI config space or legacy I/O space, using the
+  current file postion, depending on the current I/O mode setting.
+
+write
+  writes to either PCI config space or legacy I/O space, using the
+  current file postion, depending on the current I/O mode setting.
+
+  Note that reads and writes to legacy I/O space must be 1, 2 or 4
+  bytes in size with the appropriate buffer pointer.  Reads and writes
+  to config space can be arbitrarily sized.
+
+lseek
+  Can be used to set the current file position.  Note that the file
+  size is limited to 64k as that's how big legacy I/O space is.
+
+ioctl
+  ioctl is used to set the mode of a subsequent read, write or mmap
+  call.  Available ioctls (in linux/pci.h) include
+    PCIIOC_CONTROLLER - return PCI domain number
+    PCIIOC_MMAP_IS_IO - next mmap maps to I/O space
+    PCIIOC_MMAP_IS_MEM - next mmap maps to memory space
+    PCIIOC_WRITE_COMBINE - try to use write gathering for the new
+                           region if the ioctl argument is true,
+			   otherwise disable write gathering
+    PCIIOC_LEGACY_IO - read/write legacy I/O space if ioctl argument
+                       is true, otherwise subsequent read/writes will
+		       go to config space
+    PCIIOC_MMAP_IS_LEGACY_MEM - next mmap maps to legacy memory space
+
+mmap
+  The final argument of mmap(2) must be a host address obtained from
+  /proc/bus/pci/devices or an address between 0 and 1M for legacy
+  memory mappings.
+
+Examples
+
+	/* Read from the 3rd BAR of device in slot 1 of bus 1 */
+	int fd = open("/proc/bus/pci/01/01.0", O_RDONLY);
+	lseek(fd, 0x20, SEEK_SET);
+	read(fd, buf, 8);
+	close(fd);
+
+	/* Do a legacy read of 1 byte (inb) from port 0x3cc */
+	int fd = open("/proc/bus/pci/01/01.0", O_RDONLY);
+	ioctl(fd, PCIIOC_LEGACY_IO, 1); /* enable legacy I/O */
+	lseek(fd, 0x3cc, SEEK_SET);
+	read(fd, &val, 1);
+	close(fd);
diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c	2004-12-14 09:36:08 -08:00
+++ b/arch/ia64/pci/pci.c	2004-12-14 09:36:08 -08:00
@@ -514,11 +514,19 @@
 		 */
 		return -EINVAL;
 
+	if (mmap_state == pci_mmap_legacy_mem) {
+		unsigned long addr;
+		int ret;
+		if ((ret = pci_get_legacy_mem(dev, &addr)))
+			return ret;
+		vma->vm_pgoff += addr >> PAGE_SHIFT;
+	}
+
 	/*
 	 * Leave vm_pgoff as-is, the PCI space address is the physical
 	 * address on this platform.
 	 */
-	vma->vm_flags |= (VM_SHM | VM_LOCKED | VM_IO);
+	vma->vm_flags |= (VM_SHM | VM_RESERVED | VM_IO);
 
 	if (write_combine)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
@@ -530,6 +538,101 @@
 		return -EAGAIN;
 
 	return 0;
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
+	int ret = 0;
+	unsigned long paddr = port;
+	unsigned long *addr;
+
+	switch (size) {
+	case 1:
+		addr = (unsigned long *)paddr;
+		*val = (u8)(*(volatile u8 *)(addr));
+		break;
+	case 2:
+		addr = (unsigned long *)paddr;
+		*val = (u16)(*(volatile u16 *)(addr));
+		break;
+	case 4:
+		addr = (unsigned long *)paddr;
+		*val = (u32)(*(volatile u32 *)(addr));
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
+	unsigned long paddr = port;
+	unsigned long *addr;
+
+	switch (size) {
+	case 1:
+		addr = (unsigned long *)paddr;
+		*(volatile u8 *)(addr) = (u8)(val);
+		break;
+	case 2:
+		addr = (unsigned long *)paddr;
+		*(volatile u16 *)(addr) = (u16)(val);
+		break;
+	case 4:
+		addr = (unsigned long *)paddr;
+		*(volatile u32 *)(addr) = (u32)(val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
 }
 
 /**
diff -Nru a/arch/ia64/sn/pci/pci_dma.c b/arch/ia64/sn/pci/pci_dma.c
--- a/arch/ia64/sn/pci/pci_dma.c	2004-12-14 09:36:08 -08:00
+++ b/arch/ia64/sn/pci/pci_dma.c	2004-12-14 09:36:08 -08:00
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
+	int ret = 0;
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
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	2004-12-14 09:36:08 -08:00
+++ b/drivers/pci/proc.c	2004-12-14 09:36:08 -08:00
@@ -44,12 +44,9 @@
 	return new;
 }
 
-static ssize_t
-proc_bus_pci_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+static ssize_t proc_bus_pci_config_read(struct pci_dev *dev, char __user *buf,
+					size_t nbytes, loff_t *ppos)
 {
-	const struct inode *ino = file->f_dentry->d_inode;
-	const struct proc_dir_entry *dp = PDE(ino);
-	struct pci_dev *dev = dp->data;
 	unsigned int pos = *ppos;
 	unsigned int cnt, size;
 
@@ -126,12 +123,10 @@
 	return nbytes;
 }
 
-static ssize_t
-proc_bus_pci_write(struct file *file, const char __user *buf, size_t nbytes, loff_t *ppos)
+static ssize_t proc_bus_pci_config_write(struct pci_dev *dev,
+					 const char __user *buf, size_t nbytes,
+					 loff_t *ppos)
 {
-	const struct inode *ino = file->f_dentry->d_inode;
-	const struct proc_dir_entry *dp = PDE(ino);
-	struct pci_dev *dev = dp->data;
 	int pos = *ppos;
 	int size = dev->cfg_size;
 	int cnt;
@@ -196,11 +191,77 @@
 	return nbytes;
 }
 
+#ifdef HAVE_PCI_LEGACY
+static int proc_bus_pci_legacy_read(struct pci_dev *dev, char __user *buf,
+				    size_t size, loff_t *ppos)
+{
+	int ret;
+	u32 v;
+
+	/* Only support 1, 2 or 4 byte accesses */
+	if (size != 1 && size != 2 && size != 4)
+		return -EINVAL;
+
+	if ((ret = pci_legacy_read(dev, *ppos, &v, size)))
+		return ret;
+
+	if (copy_to_user(buf, &v, size))
+		return -EFAULT;
+
+	return size;
+}
+
+static int proc_bus_pci_legacy_write(struct pci_dev *dev,
+				     const char __user *buf, size_t size,
+				     loff_t *ppos)
+{
+	u32 v = 0;
+
+	/* Only support 1, 2 or 4 byte accesses */
+	if (size != 1 && size != 2 && size != 4)
+		return -EINVAL;
+
+	if (copy_from_user(&v, buf, size))
+		return -EFAULT;
+
+	return pci_legacy_write(dev, *ppos, v, size);
+}
+#endif /* HAVE_PCI_LEGACY */
+
 struct pci_filp_private {
 	enum pci_mmap_state mmap_state;
 	int write_combine;
+	int legacy_io; /* read/write corresponds to legacy space */
 };
 
+static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
+				 size_t nbytes, loff_t *ppos)
+{
+	const struct inode *ino = file->f_dentry->d_inode;
+	const struct proc_dir_entry *dp = PDE(ino);
+	struct pci_dev *dev = dp->data;
+	struct pci_filp_private *fpriv = file->private_data;
+
+	if (!fpriv->legacy_io)
+		return proc_bus_pci_config_read(dev, buf, nbytes, ppos);
+	else
+		return proc_bus_pci_legacy_read(dev, buf, nbytes, ppos);
+}
+
+static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
+				  size_t nbytes, loff_t *ppos)
+{
+	const struct inode *ino = file->f_dentry->d_inode;
+	const struct proc_dir_entry *dp = PDE(ino);
+	struct pci_dev *dev = dp->data;
+	struct pci_filp_private *fpriv = file->private_data;
+
+	if (!fpriv->legacy_io)
+		return proc_bus_pci_config_write(dev, buf, nbytes, ppos);
+	else
+		return proc_bus_pci_legacy_write(dev, buf, nbytes, ppos);
+}
+
 static int proc_bus_pci_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	const struct proc_dir_entry *dp = PDE(inode);
@@ -224,6 +285,10 @@
 		fpriv->mmap_state = pci_mmap_mem;
 		break;
 
+	case PCIIOC_MMAP_IS_LEGACY_MEM:
+		fpriv->mmap_state = pci_mmap_legacy_mem;
+		break;
+
 	case PCIIOC_WRITE_COMBINE:
 		if (arg)
 			fpriv->write_combine = 1;
@@ -233,6 +298,16 @@
 
 #endif /* HAVE_PCI_MMAP */
 
+#ifdef HAVE_PCI_LEGACY
+	case PCIIOC_LEGACY_IO:
+		if (arg)
+			fpriv->legacy_io = 1;
+		else
+			fpriv->legacy_io = 0;
+		break;
+
+#endif /* HAVE_PCI_LEGACY */
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -271,6 +346,7 @@
 
 	fpriv->mmap_state = pci_mmap_io;
 	fpriv->write_combine = 0;
+	fpriv->legacy_io = 0;
 
 	file->private_data = fpriv;
 
@@ -403,7 +479,8 @@
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
-	e->size = dev->cfg_size;
+	/* includes config space *and* legacy I/O port space */
+	e->size = 0xffff;
 
 	return 0;
 }
diff -Nru a/include/asm-ia64/machvec.h b/include/asm-ia64/machvec.h
--- a/include/asm-ia64/machvec.h	2004-12-14 09:36:08 -08:00
+++ b/include/asm-ia64/machvec.h	2004-12-14 09:36:08 -08:00
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
diff -Nru a/include/asm-ia64/machvec_init.h b/include/asm-ia64/machvec_init.h
--- a/include/asm-ia64/machvec_init.h	2004-12-14 09:36:08 -08:00
+++ b/include/asm-ia64/machvec_init.h	2004-12-14 09:36:08 -08:00
@@ -5,6 +5,9 @@
 extern ia64_mv_irq_desc __ia64_irq_desc;
 extern ia64_mv_irq_to_vector __ia64_irq_to_vector;
 extern ia64_mv_local_vector_to_irq __ia64_local_vector_to_irq;
+extern ia64_mv_pci_get_legacy_mem_t ia64_pci_get_legacy_mem;
+extern ia64_mv_pci_legacy_read_t ia64_pci_legacy_read;
+extern ia64_mv_pci_legacy_write_t ia64_pci_legacy_write;
 
 extern ia64_mv_inb_t __ia64_inb;
 extern ia64_mv_inw_t __ia64_inw;
diff -Nru a/include/asm-ia64/machvec_sn2.h b/include/asm-ia64/machvec_sn2.h
--- a/include/asm-ia64/machvec_sn2.h	2004-12-14 09:36:08 -08:00
+++ b/include/asm-ia64/machvec_sn2.h	2004-12-14 09:36:08 -08:00
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
diff -Nru a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h	2004-12-14 09:36:08 -08:00
+++ b/include/asm-ia64/pci.h	2004-12-14 09:36:08 -08:00
@@ -85,6 +85,10 @@
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
 				enum pci_mmap_state mmap_state, int write_combine);
+#define HAVE_PCI_LEGACY
+#define pci_get_legacy_mem platform_pci_get_legacy_mem
+#define pci_legacy_read platform_pci_legacy_read
+#define pci_legacy_write platform_pci_legacy_write
 
 struct pci_window {
 	struct resource resource;
diff -Nru a/include/asm-ia64/sn/sn_sal.h b/include/asm-ia64/sn/sn_sal.h
--- a/include/asm-ia64/sn/sn_sal.h	2004-12-14 09:36:08 -08:00
+++ b/include/asm-ia64/sn/sn_sal.h	2004-12-14 09:36:08 -08:00
@@ -474,6 +474,53 @@
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
+			case 1:
+				*((u8*)data_ptr) = (u8)isrv.v0;
+				break;
+			case 2:
+				*((u16*)data_ptr) = (u16)isrv.v0;
+				break;
+			case 4:
+				*((u32*)data_ptr) = (u32)isrv.v0;
+				break;
+			case 8:
+				*((u64*)data_ptr) = (u64)isrv.v0;
+				break;
+			default:
+				isrv.status = 2;
+		}
+	}
+
+	return isrv.status;
+}
+
 /*
  * Retrieve the system serial number as an ASCII string.
  */
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-12-14 09:36:08 -08:00
+++ b/include/linux/pci.h	2004-12-14 09:36:08 -08:00
@@ -455,6 +455,8 @@
 #define PCIIOC_MMAP_IS_IO	(PCIIOC_BASE | 0x01)	/* Set mmap state to I/O space. */
 #define PCIIOC_MMAP_IS_MEM	(PCIIOC_BASE | 0x02)	/* Set mmap state to MEM space. */
 #define PCIIOC_WRITE_COMBINE	(PCIIOC_BASE | 0x03)	/* Enable/disable write-combining. */
+#define PCIIOC_LEGACY_IO	(PCIIOC_BASE | 0x04)	/* Read/write access functions go to legacy space */
+#define PCIIOC_MMAP_IS_LEGACY_MEM (PCIIOC_BASE | 0x5)	/* Legacy memory */
 
 #ifdef __KERNEL__
 
@@ -468,7 +470,8 @@
 /* File state for mmap()s on /proc/bus/pci/X/Y */
 enum pci_mmap_state {
 	pci_mmap_io,
-	pci_mmap_mem
+	pci_mmap_mem,
+	pci_mmap_legacy_mem
 };
 
 /* This defines the direction arg to the DMA mapping routines. */

--Boundary-00=_kXyvB8jWptIwo5e--
