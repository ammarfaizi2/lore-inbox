Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbULPTPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbULPTPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbULPTPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:15:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24525 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261995AbULPTIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:08:04 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci
Date: Thu, 16 Dec 2004 11:07:56 -0800
User-Agent: KMail/1.7.1
Cc: davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, willy@debian.org
References: <200412160850.20223.jbarnes@engr.sgi.com> <16833.55270.601527.754270@napali.hpl.hp.com> <200412161056.13019.jbarnes@engr.sgi.com>
In-Reply-To: <200412161056.13019.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_N0dwBJUOr4io4Zp"
Message-Id: <200412161107.57457.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_N0dwBJUOr4io4Zp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, December 16, 2004 10:56 am, Jesse Barnes wrote:
> > No offense, but what's up with this castamania?

Maybe this is a little better?  I talked with Bjorn and willy on irc about 
this and there are some other approaches we could take.  I still think domain 
support is a separate issue from the additions in this patch, but there are 
definitely other ways to export this stuff to userspace.  One would be adding 
sys_ioport system call to ia64 that would allow reads and writes to arbitrary 
I/O ports (not just legacy ones) coupled with exporting the legacy memory 
base address in /proc/iomem somewhere and letting users map it in /dev/mem.  
Doing things that way wouldn't help platforms like ppc though, and the API 
would be a bit more confusing (more places to poke to find the info you 
need).

Jesse

--Boundary-00=_N0dwBJUOr4io4Zp
Content-Type: text/plain;
  charset="iso-8859-1";
  name="legacy-ioctl-mem-api-7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="legacy-ioctl-mem-api-7.patch"

===== arch/ia64/pci/pci.c 1.59 vs edited =====
--- 1.59/arch/ia64/pci/pci.c	2004-11-05 11:55:25 -08:00
+++ edited/arch/ia64/pci/pci.c	2004-12-16 11:02:53 -08:00
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
@@ -530,6 +538,91 @@
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
+		outb((unsigned char)val, port);
+		break;
+	case 2:
+		outw((unsigned short)val, port);
+		break;
+	case 4:
+		outl((unsigned int)val, port);
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
+++ edited/arch/ia64/sn/pci/pci_dma.c	2004-12-16 10:56:58 -08:00
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
===== drivers/pci/proc.c 1.41 vs edited =====
--- 1.41/drivers/pci/proc.c	2004-10-06 09:44:51 -07:00
+++ edited/drivers/pci/proc.c	2004-12-16 10:56:58 -08:00
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
+	enum pci_rw_state rw_state;
 };
 
+static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
+				 size_t nbytes, loff_t *ppos)
+{
+	const struct inode *ino = file->f_dentry->d_inode;
+	const struct proc_dir_entry *dp = PDE(ino);
+	struct pci_dev *dev = dp->data;
+	struct pci_filp_private *fpriv = file->private_data;
+
+	if (fpriv->rw_state == pci_rw_config)
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
+	if (fpriv->rw_state == pci_rw_config)
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
@@ -233,6 +298,17 @@
 
 #endif /* HAVE_PCI_MMAP */
 
+#ifdef HAVE_PCI_LEGACY
+	case PCIIOC_RW_LEGACY_IO:
+		fpriv->rw_state = pci_rw_legacy_io;
+		break;
+
+	case PCIIOC_RW_CONFIG:
+		fpriv->rw_state = pci_rw_config;
+		break;
+
+#endif /* HAVE_PCI_LEGACY */
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -271,6 +347,7 @@
 
 	fpriv->mmap_state = pci_mmap_io;
 	fpriv->write_combine = 0;
+	fpriv->rw_state = pci_rw_config;
 
 	file->private_data = fpriv;
 
@@ -403,7 +480,8 @@
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
-	e->size = dev->cfg_size;
+	/* includes config space *and* legacy I/O port space */
+	e->size = 0xffff;
 
 	return 0;
 }
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
+++ edited/include/asm-ia64/pci.h	2004-12-16 10:56:59 -08:00
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
===== include/asm-ia64/sn/sn_sal.h 1.17 vs edited =====
--- 1.17/include/asm-ia64/sn/sn_sal.h	2004-11-03 13:41:17 -08:00
+++ edited/include/asm-ia64/sn/sn_sal.h	2004-12-16 10:56:59 -08:00
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
===== include/linux/pci.h 1.142 vs edited =====
--- 1.142/include/linux/pci.h	2004-10-31 14:10:04 -08:00
+++ edited/include/linux/pci.h	2004-12-16 10:57:00 -08:00
@@ -455,6 +455,9 @@
 #define PCIIOC_MMAP_IS_IO	(PCIIOC_BASE | 0x01)	/* Set mmap state to I/O space. */
 #define PCIIOC_MMAP_IS_MEM	(PCIIOC_BASE | 0x02)	/* Set mmap state to MEM space. */
 #define PCIIOC_WRITE_COMBINE	(PCIIOC_BASE | 0x03)	/* Enable/disable write-combining. */
+#define PCIIOC_RW_LEGACY_IO	(PCIIOC_BASE | 0x04)	/* Read/write access functions go to legacy space */
+#define PCIIOC_RW_CONFIG	(PCIIOC_BASE | 0x05)	/* Read/write access functions go to config space */
+#define PCIIOC_MMAP_IS_LEGACY_MEM (PCIIOC_BASE | 0x6)	/* Legacy memory */
 
 #ifdef __KERNEL__
 
@@ -468,7 +471,14 @@
 /* File state for mmap()s on /proc/bus/pci/X/Y */
 enum pci_mmap_state {
 	pci_mmap_io,
-	pci_mmap_mem
+	pci_mmap_mem,
+	pci_mmap_legacy_mem
+};
+
+/* Mode state for read/write routines on /proc/bus/pci/X/Y */
+enum pci_rw_state {
+	pci_rw_config, /* r/w config space */
+	pci_rw_legacy_io /* r/w legacy I/O port space */
 };
 
 /* This defines the direction arg to the DMA mapping routines. */
--- /dev/null	1969-12-31 16:00:00.000000000 -0800
+++ Documentation/filesystems/proc-pci.txt	2004-12-16 11:03:47.000000000 -0800
@@ -0,0 +1,127 @@
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
+  to config space can be arbitrarily sized.  Legacy I/O port space
+  reads and writes must also be to a file position <64k--the kernel will
+  route them to the target device.
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
+    PCIIOC_MMAP_IS_LEGACY_MEM - next mmap maps to legacy memory space
+    PCIIOC_WRITE_COMBINE - try to use write gathering for the new
+                           region if the ioctl argument is true,
+                           otherwise disable write gathering
+    PCIIOC_RW_LEGACY_IO - read/writes will go to legacy I/O space
+    PCIIOC_RW_CONFIG - read/writes will go to config space, this is the
+                       default for newly opened files
+  Note that not all architectures support the *_MMAP_* or *_RW_* ioctl
+  commands.  If they're not supported, ioctl will return -EINVAL.
+
+mmap
+  The final argument of mmap(2) must be a host address obtained from
+  /proc/bus/pci/devices or an address between 0 and 1M for legacy
+  memory mappings.  Only supported on some architectures.
+
+Examples
+
+	/* Read from the 3rd BAR of device in slot 1 of bus 1 */
+	int fd = open("/proc/bus/pci/01/01.0", O_RDONLY);
+	ioctl(fd, PCIIOC_RW_CONFIG); /* make sure we're using config space */
+	lseek(fd, 0x20, SEEK_SET);
+	read(fd, buf, 8);
+	close(fd);
+
+	/*
+	 * Do a legacy read of 1 byte (inb) from port 0x3cc from 1:1.0.
+	 * Note that this will just generate a bus cycle on bus 1 for port
+	 * 0x3cc, which the device in question may or may not respond to.
+	 * If there is no response, -1 will be returned.  Also note that
+	 * it may not be possible to generate legacy I/O port requests on
+	 * the bus or device specified, in that case the write will fail
+	 * with an appropriate error code.
+	 */
+	int fd = open("/proc/bus/pci/01/01.0", O_RDONLY);
+	ioctl(fd, PCIIOC_RW_LEGACY_IO); /* enable legacy I/O */
+	lseek(fd, 0x3cc, SEEK_SET);
+	read(fd, &val, 1);
+	close(fd);

--Boundary-00=_N0dwBJUOr4io4Zp--
