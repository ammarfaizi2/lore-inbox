Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbUBZG1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 01:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbUBZG1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 01:27:16 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:42398 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S262711AbUBZGYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 01:24:06 -0500
Date: Thu, 26 Feb 2004 17:23:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <linus@osdl.org>, anton@samba.org, paulus@samba.org,
       axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iSeries virtual disk
Message-Id: <20040226172325.3a139f73.sfr@canb.auug.org.au>
In-Reply-To: <20040122221136.174550c3.akpm@osdl.org>
References: <20040123163504.36582570.sfr@canb.auug.org.au>
	<20040122221136.174550c3.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__26_Feb_2004_17_23_25_+1100_EjkdIoDgYNsc60u="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__26_Feb_2004_17_23_25_+1100_EjkdIoDgYNsc60u=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

Here is another attempt.  I would appreciate this going into your tree and
also Linus' if possible.  The patch below is against 2.6.3-mm4. I think I
have addressed all the comments that I received.

Unfortunately, things have moved on in the last couple of weeks and to
fix everyone;s abjections, I need to include in this patch a ppc64 specific
version of the dma_mapping routines.  They are pretty straight forward.

So this patch adds a device driver for PPC64 iSeries virtual disks.  Its
only defficiencies over previous published (out of tree) drivers for 2.4
is that it will not recognise dynamically added disks and the IDE emulation
is no longer supported.

Disks are now called /dev/iseries/vd<x><n> (without devfs) or
/dev/viod/disc<n>/part<n> (with devfs).  Up to 7 partitions are supported
on each of up to 32 disks.

I have run this on a 2 way (HT) iSeries machine with 4 virtual disks and
built it for pSeries (with the default pSeries config).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.3-mm4/arch/ppc64/Kconfig 2.6.3-mm4-viodasd/arch/ppc64/Kconfig
--- 2.6.3-mm4/arch/ppc64/Kconfig	2004-02-26 15:40:05.000000000 +1100
+++ 2.6.3-mm4-viodasd/arch/ppc64/Kconfig	2004-02-26 16:08:36.000000000 +1100
@@ -271,15 +271,6 @@
 	  If you are running on an iSeries system and you want to use
  	  virtual disks created and managed by OS/400, say Y.
 
-config VIODASD_IDE
-	bool "iSeries Virtual disk IDE emulation"
-	depends on VIODASD
-	help
-	  This causes the iSeries virtual disks to look like IDE disks.
-	  If you have programs or utilities that only support certain
-	  kinds of disks, this option will cause iSeries virtual disks
-	  to pretend to be IDE disks, which may satisfy the program.
-
 config VIOCD
 	tristate "iSeries Virtual I/O CD support"
 	help
diff -ruN 2.6.3-mm4/arch/ppc64/kernel/Makefile 2.6.3-mm4-viodasd/arch/ppc64/kernel/Makefile
--- 2.6.3-mm4/arch/ppc64/kernel/Makefile	2004-02-26 15:40:06.000000000 +1100
+++ 2.6.3-mm4-viodasd/arch/ppc64/kernel/Makefile	2004-02-26 16:28:10.000000000 +1100
@@ -5,7 +5,7 @@
 EXTRA_CFLAGS	+= -mno-minimal-toc
 extra-y		:= head.o vmlinux.lds.s
 
-obj-y               :=	setup.o entry.o traps.o irq.o idle.o \
+obj-y               :=	setup.o entry.o traps.o irq.o idle.o dma.o \
 			time.o process.o signal.o syscalls.o misc.o ptrace.o \
 			align.o semaphore.o bitops.o stab.o pacaData.o \
 			udbg.o binfmt_elf32.o sys_ppc32.o ioctl32.o \
diff -ruN 2.6.3-mm4/arch/ppc64/kernel/dma.c 2.6.3-mm4-viodasd/arch/ppc64/kernel/dma.c
--- 2.6.3-mm4/arch/ppc64/kernel/dma.c	1970-01-01 10:00:00.000000000 +1000
+++ 2.6.3-mm4-viodasd/arch/ppc64/kernel/dma.c	2004-02-24 14:48:31.000000000 +1100
@@ -0,0 +1,173 @@
+/*
+ * Copyright (C) 2004 IBM Corporation
+ *
+ * Implements the generic device dma API for ppc64. Handles
+ * the pci and vio busses
+ */
+
+#include <linux/config.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+/* Include the busses we support */
+#include <linux/pci.h>
+#ifdef CONFIG_PPC_PSERIES
+#include <asm/vio.h>
+#endif
+#include <asm/scatterlist.h>
+#include <asm/bug.h>
+
+int dma_supported(struct device *dev, u64 mask)
+{
+	if (dev->bus == &pci_bus_type)
+		return pci_dma_supported(to_pci_dev(dev), mask);
+#ifdef CONFIG_PPC_PSERIES
+	if (dev->bus == &vio_bus_type)
+		return vio_dma_supported(to_vio_dev(dev), mask);
+#endif
+	BUG();
+	return 0;
+}
+
+int dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	if (dev->bus == &pci_bus_type)
+		return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
+#ifdef CONFIG_PPC_PSERIES
+	if (dev->bus == &vio_bus_type)
+		return vio_set_dma_mask(to_vio_dev(dev), dma_mask);
+#endif
+	BUG();
+	return 0;
+}
+
+void *dma_alloc_coherent(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, int flag)
+{
+	if (dev->bus == &pci_bus_type)
+		return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
+#ifdef CONFIG_PPC_PSERIES
+	if (dev->bus == &vio_bus_type)
+		return vio_alloc_consistent(to_vio_dev(dev), size, dma_handle);
+#endif
+	BUG();
+	return 0;
+}
+
+void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_handle)
+{
+	if (dev->bus == &pci_bus_type)
+		pci_free_consistent(to_pci_dev(dev), size, cpu_addr, dma_handle);
+#ifdef CONFIG_PPC_PSERIES
+	else if (dev->bus == &vio_bus_type)
+		vio_free_consistent(to_vio_dev(dev), size, cpu_addr, dma_handle);
+#endif
+	else
+		BUG();
+}
+
+dma_addr_t dma_map_single(struct device *dev, void *cpu_addr, size_t size,
+		enum dma_data_direction direction)
+{
+	if (dev->bus == &pci_bus_type)
+		return pci_map_single(to_pci_dev(dev), cpu_addr, size, (int)direction);
+#ifdef CONFIG_PPC_PSERIES
+	if (dev->bus == &vio_bus_type)
+		return vio_map_single(to_vio_dev(dev), cpu_addr, size, (int)direction);
+#endif
+	BUG();
+	return (dma_addr_t)0;
+}
+
+void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		enum dma_data_direction direction)
+{
+	if (dev->bus == &pci_bus_type)
+		pci_unmap_single(to_pci_dev(dev), dma_addr, size, (int)direction);
+#ifdef CONFIG_PPC_PSERIES
+	else if (dev->bus == &vio_bus_type)
+		vio_unmap_single(to_vio_dev(dev), dma_addr, size, (int)direction);
+#endif
+	else
+		BUG();
+}
+
+dma_addr_t dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size,
+		enum dma_data_direction direction)
+{
+	if (dev->bus == &pci_bus_type)
+		return pci_map_page(to_pci_dev(dev), page, offset, size, (int)direction);
+#ifdef CONFIG_PPC_PSERIES
+	if (dev->bus == &vio_bus_type)
+		return vio_map_page(to_vio_dev(dev), page, offset, size, (int)direction);
+#endif
+	BUG();
+	return (dma_addr_t)0;
+}
+
+
+void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
+		enum dma_data_direction direction)
+{
+	if (dev->bus == &pci_bus_type)
+		pci_unmap_page(to_pci_dev(dev), dma_address, size, (int)direction);
+#ifdef CONFIG_PPC_PSERIES
+	else if (dev->bus == &vio_bus_type)
+		vio_unmap_page(to_vio_dev(dev), dma_address, size, (int)direction);
+#endif
+	else
+		BUG();
+}
+
+int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction direction)
+{
+	if (dev->bus == &pci_bus_type)
+		return pci_map_sg(to_pci_dev(dev), sg, nents, (int)direction);
+#ifdef CONFIG_PPC_PSERIES
+	if (dev->bus == &vio_bus_type)
+		return vio_map_sg(to_vio_dev(dev), sg, nents, (int)direction);
+#endif
+	BUG();
+	return 0;
+}
+
+void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
+		enum dma_data_direction direction)
+{
+	if (dev->bus == &pci_bus_type)
+		pci_unmap_sg(to_pci_dev(dev), sg, nhwentries, (int)direction);
+#ifdef CONFIG_PPC_PSERIES
+	else if (dev->bus == &vio_bus_type)
+		vio_unmap_sg(to_vio_dev(dev), sg, nhwentries, (int)direction);
+#endif
+	else
+		BUG();
+}
+
+void dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction)
+{
+	if (dev->bus == &pci_bus_type)
+		pci_dma_sync_single(to_pci_dev(dev), dma_handle, size, (int)direction);
+#ifdef CONFIG_PPC_PSERIES
+	else if (dev->bus == &vio_bus_type)
+		vio_dma_sync_single(to_vio_dev(dev), dma_handle, size, (int)direction);
+#endif
+	else
+		BUG();
+}
+
+void dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
+		enum dma_data_direction direction)
+{
+	if (dev->bus == &pci_bus_type)
+		pci_dma_sync_sg(to_pci_dev(dev), sg, nelems, (int)direction);
+#ifdef CONFIG_PPC_PSERIES
+	else if (dev->bus == &vio_bus_type)
+		vio_dma_sync_sg(to_vio_dev(dev), sg, nelems, (int)direction);
+#endif
+	else
+		BUG();
+}
diff -ruN 2.6.3-mm4/arch/ppc64/kernel/pci_dma.c 2.6.3-mm4-viodasd/arch/ppc64/kernel/pci_dma.c
--- 2.6.3-mm4/arch/ppc64/kernel/pci_dma.c	2004-02-18 16:40:26.000000000 +1100
+++ 2.6.3-mm4-viodasd/arch/ppc64/kernel/pci_dma.c	2004-02-26 16:34:45.000000000 +1100
@@ -67,10 +67,10 @@
 struct iSeries_Device_Node iSeries_vio_dev_node  = { .LogicalSlot = 0xFF, .DevTceTable = &virtBusVioTceTable };
 
 struct pci_dev    iSeries_veth_dev_st = { .sysdata = &iSeries_veth_dev_node };
-struct pci_dev    iSeries_vio_dev_st  = { .sysdata = &iSeries_vio_dev_node  };
+struct pci_dev    iSeries_vio_dev_st  = { .sysdata = &iSeries_vio_dev_node, .dev.bus = &pci_bus_type };
 
 struct pci_dev  * iSeries_veth_dev = &iSeries_veth_dev_st;
-struct pci_dev  * iSeries_vio_dev  = &iSeries_vio_dev_st;
+struct device  * iSeries_vio_dev  = &iSeries_vio_dev_st.dev;
 
 /* Device TceTable is stored in Device Node */
 /* struct TceTable * tceTables[256]; */	/* Tce tables for 256 busses
diff -ruN 2.6.3-mm4/arch/ppc64/kernel/viopath.c 2.6.3-mm4-viodasd/arch/ppc64/kernel/viopath.c
--- 2.6.3-mm4/arch/ppc64/kernel/viopath.c	2004-02-04 17:24:36.000000000 +1100
+++ 2.6.3-mm4-viodasd/arch/ppc64/kernel/viopath.c	2004-02-12 16:51:35.000000000 +1100
@@ -35,7 +35,8 @@
 #include <linux/vmalloc.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
-#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/wait.h>
 
 #include <asm/hardirq.h>	/* for is_atomic */
@@ -48,7 +49,7 @@
 #include <asm/iSeries/iSeries_proc.h>
 #include <asm/iSeries/vio.h>
 
-extern struct pci_dev *iSeries_vio_dev;
+extern struct device *iSeries_vio_dev;
 
 /* Status of the path to each other partition in the system.
  * This is overkill, since we will only ever establish connections
@@ -194,8 +195,7 @@
 	HvLpEvent_Rc hvrc;
 	DECLARE_MUTEX_LOCKED(Semaphore);
 	dma_addr_t dmaa =
-	    pci_map_single(iSeries_vio_dev, buf, PAGE_SIZE,
-			   PCI_DMA_FROMDEVICE);
+	    dma_map_single(iSeries_vio_dev, buf, PAGE_SIZE, DMA_FROM_DEVICE);
 	int len = PAGE_SIZE;
 
 	if (len > blen)
@@ -215,8 +215,7 @@
 
 	down(&Semaphore);
 
-	pci_unmap_single(iSeries_vio_dev, dmaa, PAGE_SIZE,
-			 PCI_DMA_FROMDEVICE);
+	dma_unmap_single(iSeries_vio_dev, dmaa, PAGE_SIZE, DMA_FROM_DEVICE);
 
 	sprintf(buf + strlen(buf), "SRLNBR=");
 	buf[strlen(buf)] = e2a(xItExtVpdPanel.mfgID[2]);
diff -ruN 2.6.3-mm4/drivers/block/Makefile 2.6.3-mm4-viodasd/drivers/block/Makefile
--- 2.6.3-mm4/drivers/block/Makefile	2004-02-26 15:40:12.000000000 +1100
+++ 2.6.3-mm4-viodasd/drivers/block/Makefile	2004-02-26 16:24:57.000000000 +1100
@@ -39,3 +39,5 @@
 obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
 obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
+
+obj-$(CONFIG_VIODASD)		+= viodasd.o
diff -ruN 2.6.3-mm4/drivers/block/viodasd.c 2.6.3-mm4-viodasd/drivers/block/viodasd.c
--- 2.6.3-mm4/drivers/block/viodasd.c	1970-01-01 10:00:00.000000000 +1000
+++ 2.6.3-mm4-viodasd/drivers/block/viodasd.c	2004-02-26 13:54:11.000000000 +1100
@@ -0,0 +1,869 @@
+/* -*- linux-c -*-
+ * viodasd.c
+ *  Authors: Dave Boutcher <boutcher@us.ibm.com>
+ *           Ryan Arnold <ryanarn@us.ibm.com>
+ *           Colin Devilbiss <devilbis@us.ibm.com>
+ *           Stephen Rothwell <sfr@au1.ibm.com>
+ *
+ * (C) Copyright 2000-2004 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * This routine provides access to disk space (termed "DASD" in historical
+ * IBM terms) owned and managed by an OS/400 partition running on the
+ * same box as this Linux partition.
+ *
+ * All disk operations are performed by sending messages back and forth to
+ * the OS/400 partition.
+ */
+#include <linux/major.h>
+#include <linux/fs.h>
+#include <asm/uaccess.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/genhd.h>
+#include <linux/hdreg.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/seq_file.h>
+#include <linux/completion.h>
+
+#include <asm/iSeries/HvTypes.h>
+#include <asm/iSeries/HvLpEvent.h>
+#include <asm/iSeries/HvLpConfig.h>
+#include <asm/iSeries/vio.h>
+
+MODULE_DESCRIPTION("iSeries Virtual DASD");
+MODULE_AUTHOR("Dave Boutcher");
+MODULE_LICENSE("GPL");
+
+/*
+ * We only support 7 partitions per physical disk....so with minor
+ * numbers 0-255 we get a maximum of 32 disks.
+ */
+#define VIOD_GENHD_DEVFS_NAME	"viod/disc"
+#define VIOD_GENHD_NAME		"iseries/vd"
+
+#define VIOD_VERS		"1.63"
+
+#define VIOD_KERN_WARNING	KERN_WARNING "viod: "
+#define VIOD_KERN_INFO		KERN_INFO "viod: "
+
+enum {
+	PARTITION_SHIFT = 3,
+	MAX_DISKNO = 32,
+	MAX_DISK_NAME = sizeof(((struct gendisk *)0)->disk_name)
+};
+
+static int		viodasd_max_disk;
+static spinlock_t	viodasd_spinlock = SPIN_LOCK_UNLOCKED;
+
+#define VIOMAXREQ		16
+#define VIOMAXBLOCKDMA		12
+
+#define DEVICE_NO(cell)	((struct viodasd_device *)(cell) - &viodasd_devices[0])
+
+extern struct device *iSeries_vio_dev;
+
+struct open_data {
+	u64	disk_size;
+	u16	max_disk;
+	u16	cylinders;
+	u16	tracks;
+	u16	sectors;
+	u16	bytes_per_sector;
+};
+
+struct rw_data {
+	u64	offset;
+	struct {
+		u32	token;
+		u32	reserved;
+		u64	len;
+	} dma_info[VIOMAXBLOCKDMA];
+};
+
+struct vioblocklpevent {
+	struct HvLpEvent	event;
+	u32			reserved;
+	u16			version;
+	u16			sub_result;
+	u16			disk;
+	u16			flags;
+	union {
+		struct open_data	open_data;
+		struct rw_data		rw_data;
+		u64			changed;
+	} u;
+};
+
+#define vioblockflags_ro   0x0001
+
+enum vioblocksubtype {
+	vioblockopen = 0x0001,
+	vioblockclose = 0x0002,
+	vioblockread = 0x0003,
+	vioblockwrite = 0x0004,
+	vioblockflush = 0x0005,
+	vioblockcheck = 0x0007
+};
+
+struct viodasd_waitevent {
+	struct completion	com;
+	int			rc;
+	union {
+		int		changed;	/* Used only for check_change */
+		u16		sub_result;
+	} data;
+};
+
+static const struct vio_error_entry viodasd_err_table[] = {
+	{ 0x0201, EINVAL, "Invalid Range" },
+	{ 0x0202, EINVAL, "Invalid Token" },
+	{ 0x0203, EIO, "DMA Error" },
+	{ 0x0204, EIO, "Use Error" },
+	{ 0x0205, EIO, "Release Error" },
+	{ 0x0206, EINVAL, "Invalid Disk" },
+	{ 0x0207, EBUSY, "Cant Lock" },
+	{ 0x0208, EIO, "Already Locked" },
+	{ 0x0209, EIO, "Already Unlocked" },
+	{ 0x020A, EIO, "Invalid Arg" },
+	{ 0x020B, EIO, "Bad IFS File" },
+	{ 0x020C, EROFS, "Read Only Device" },
+	{ 0x02FF, EIO, "Internal Error" },
+	{ 0x0000, 0, NULL },
+};
+
+/*
+ * Figure out the biggest I/O request (in sectors) we can accept
+ */
+#define VIODASD_MAXSECTORS (4096 / 512 * VIOMAXBLOCKDMA)
+
+/*
+ * Number of disk I/O requests we've sent to OS/400
+ */
+static int num_req_outstanding;
+
+/*
+ * This is our internal structure for keeping track of disk devices
+ */
+struct viodasd_device {
+	u16		cylinders;
+	u16		tracks;
+	u16		sectors;
+	u16		bytes_per_sector;
+	u64		size;
+	int		read_only;
+	spinlock_t	q_lock;
+	struct gendisk	*disk;
+} viodasd_devices[MAX_DISKNO];
+
+static void viodasd_init_disk(struct viodasd_device *d);
+
+/*
+ * End a request
+ */
+static void viodasd_end_request(struct request *req, int uptodate,
+		int num_sectors)
+{
+	if (end_that_request_first(req, uptodate, num_sectors))
+		return;
+        add_disk_randomness(req->rq_disk);
+	end_that_request_last(req);
+}
+
+/*
+ * This rebuilds the partition information for a single disk device
+ */
+static int viodasd_revalidate(struct gendisk *gendisk)
+{
+	struct viodasd_device *device = gendisk->private_data;
+
+	set_capacity(gendisk, device->size >> 9);
+	return 0;
+}
+
+/*
+ * Probe a single disk and fill in the viodasd_device structure
+ * for it.
+ */
+static void probe_disk(struct viodasd_device *d)
+{
+	HvLpEvent_Rc hvrc;
+	struct viodasd_waitevent we;
+	int dev_no = DEVICE_NO(d);
+
+	init_completion(&we.com);
+
+	/* Send the open event to OS/400 */
+	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
+			HvLpEvent_Type_VirtualIo,
+			viomajorsubtype_blockio | vioblockopen,
+			HvLpEvent_AckInd_DoAck, HvLpEvent_AckType_ImmediateAck,
+			viopath_sourceinst(viopath_hostLp),
+			viopath_targetinst(viopath_hostLp),
+			(u64)(unsigned long)&we, VIOVERSION << 16,
+			((u64)dev_no << 48) | ((u64)vioblockflags_ro << 32),
+			0, 0, 0);
+	if (hvrc != 0) {
+		printk(VIOD_KERN_WARNING "bad rc on HV open %d\n", (int)hvrc);
+		return;
+	}
+
+	wait_for_completion(&we.com);
+
+	if (we.rc != 0)
+		return;
+
+	/* Send the close event to OS/400.  We DON'T expect a response */
+	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
+			HvLpEvent_Type_VirtualIo,
+			viomajorsubtype_blockio | vioblockclose,
+			HvLpEvent_AckInd_NoAck, HvLpEvent_AckType_ImmediateAck,
+			viopath_sourceinst(viopath_hostLp),
+			viopath_targetinst(viopath_hostLp),
+			0, VIOVERSION << 16,
+			((u64)dev_no << 48) | ((u64)vioblockflags_ro << 32),
+			0, 0, 0);
+	if (hvrc != 0)
+		printk(VIOD_KERN_WARNING
+		       "bad rc sending event to OS/400 %d\n", (int)hvrc);
+	else {
+		printk(VIOD_KERN_INFO "disk %d: %lu sectors (%lu MB) "
+				"CHS=%d/%d/%d sector size %d\n",
+				dev_no, (unsigned long)(d->size >> 9),
+				(unsigned long)(d->size >> 20),
+				(int)d->cylinders, (int)d->tracks,
+				(int)d->sectors, (int)d->bytes_per_sector);
+		viodasd_init_disk(d);
+	}
+}
+
+/*
+ * External open entry point.
+ */
+static int viodasd_open(struct inode *ino, struct file *fil)
+{
+	struct viodasd_device *d = ino->i_bdev->bd_disk->private_data;
+	HvLpEvent_Rc hvrc;
+	struct viodasd_waitevent we;
+
+	init_completion(&we.com);
+
+	/* Send the open event to OS/400 */
+	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
+			HvLpEvent_Type_VirtualIo,
+			viomajorsubtype_blockio | vioblockopen,
+			HvLpEvent_AckInd_DoAck, HvLpEvent_AckType_ImmediateAck,
+			viopath_sourceinst(viopath_hostLp),
+			viopath_targetinst(viopath_hostLp),
+			(u64)(unsigned long)&we, VIOVERSION << 16,
+			((u64)DEVICE_NO(d) << 48) /* | ((u64)flags << 32) */,
+			0, 0, 0);
+	if (hvrc != 0) {
+		printk(VIOD_KERN_WARNING "HV open failed %d\n", (int)hvrc);
+		return -EIO;
+	}
+
+	wait_for_completion(&we.com);
+
+	/* Check the return code */
+	if (we.rc != 0) {
+		const struct vio_error_entry *err =
+			vio_lookup_rc(viodasd_err_table, we.data.sub_result);
+
+		printk(VIOD_KERN_WARNING
+				"bad rc opening disk: %d:0x%04x (%s)\n",
+				(int)we.rc, we.data.sub_result, err->msg);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * External release entry point.
+ */
+static int viodasd_release(struct inode *ino, struct file *fil)
+{
+	struct viodasd_device *d = ino->i_bdev->bd_disk->private_data;
+	HvLpEvent_Rc hvrc;
+
+	/* Send the event to OS/400.  We DON'T expect a response */
+	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
+			HvLpEvent_Type_VirtualIo,
+			viomajorsubtype_blockio | vioblockclose,
+			HvLpEvent_AckInd_NoAck, HvLpEvent_AckType_ImmediateAck,
+			viopath_sourceinst(viopath_hostLp),
+			viopath_targetinst(viopath_hostLp),
+			0, VIOVERSION << 16,
+			((u64)DEVICE_NO(d) << 48) /* | ((u64)flags << 32) */,
+			0, 0, 0);
+	if (hvrc != 0)
+		printk(VIOD_KERN_WARNING "HV close call failed %d\n",
+				(int)hvrc);
+	return 0;
+}
+
+
+/* External ioctl entry point.
+ */
+static int viodasd_ioctl(struct inode *ino, struct file *fil,
+			 unsigned int cmd, unsigned long arg)
+{
+	int err;
+	unsigned char sectors;
+	unsigned char heads;
+	unsigned short cylinders;
+	struct hd_geometry *geo;
+	struct gendisk *gendisk;
+	struct viodasd_device *d;
+
+	switch (cmd) {
+	case HDIO_GETGEO:
+		geo = (struct hd_geometry *)arg;
+		if (geo == NULL)
+			return -EINVAL;
+		err = verify_area(VERIFY_WRITE, geo, sizeof(*geo));
+		if (err)
+			return err;
+		gendisk = ino->i_bdev->bd_disk;
+		d = gendisk->private_data;
+		sectors = d->sectors;
+		if (sectors == 0)
+			sectors = 32;
+		heads = d->tracks;
+		if (heads == 0)
+			heads = 64;
+		cylinders = d->cylinders;
+		if (cylinders == 0)
+			cylinders = get_capacity(gendisk) / (sectors * heads);
+		if (__put_user(sectors, &geo->sectors) ||
+		    __put_user(heads, &geo->heads) ||
+		    __put_user(cylinders, &geo->cylinders) ||
+		    __put_user(get_start_sect(ino->i_bdev), &geo->start))
+			return -EFAULT;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * Send an actual I/O request to OS/400
+ */
+static int send_request(struct request *req)
+{
+	u64 start;
+	int direction;
+	int nsg;
+	u16 viocmd;
+	HvLpEvent_Rc hvrc;
+	struct vioblocklpevent *bevent;
+	struct scatterlist sg[VIOMAXBLOCKDMA];
+	int sgindex;
+	int statindex;
+	struct viodasd_device *d;
+	unsigned long flags;
+
+	start = (u64)req->sector << 9;
+
+	if (rq_data_dir(req) == READ) {
+		direction = DMA_FROM_DEVICE;
+		viocmd = viomajorsubtype_blockio | vioblockread;
+		statindex = 0;
+	} else {
+		direction = DMA_TO_DEVICE;
+		viocmd = viomajorsubtype_blockio | vioblockwrite;
+		statindex = 1;
+	}
+
+        d = req->rq_disk->private_data;
+
+	/* Now build the scatter-gather list */
+	nsg = blk_rq_map_sg(req->q, req, sg);
+	nsg = dma_map_sg(iSeries_vio_dev, sg, nsg, direction);
+
+	spin_lock_irqsave(&viodasd_spinlock, flags);
+	num_req_outstanding++;
+
+	/* This optimization handles a single DMA block */
+	if (nsg == 1)
+		hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
+				HvLpEvent_Type_VirtualIo, viocmd,
+				HvLpEvent_AckInd_DoAck,
+				HvLpEvent_AckType_ImmediateAck,
+				viopath_sourceinst(viopath_hostLp),
+				viopath_targetinst(viopath_hostLp),
+				(u64)(unsigned long)req, VIOVERSION << 16,
+				((u64)DEVICE_NO(d) << 48), start,
+				((u64)sg[0].dma_address) << 32,
+				sg[0].dma_length);
+	else {
+		bevent = (struct vioblocklpevent *)
+			vio_get_event_buffer(viomajorsubtype_blockio);
+		if (bevent == NULL) {
+			num_req_outstanding--;
+			spin_unlock_irqrestore(&viodasd_spinlock, flags);
+			dma_unmap_sg(iSeries_vio_dev, sg, nsg, direction);
+			printk(VIOD_KERN_WARNING
+			       "error allocating disk event buffer\n");
+			return -1;
+		}
+
+		/*
+		 * Now build up the actual request.  Note that we store
+		 * the pointer to the request in the correlation
+		 * token so we can match the response up later
+		 */
+		memset(bevent, 0, sizeof(struct vioblocklpevent));
+		bevent->event.xFlags.xValid = 1;
+		bevent->event.xFlags.xFunction = HvLpEvent_Function_Int;
+		bevent->event.xFlags.xAckInd = HvLpEvent_AckInd_DoAck;
+		bevent->event.xFlags.xAckType = HvLpEvent_AckType_ImmediateAck;
+		bevent->event.xType = HvLpEvent_Type_VirtualIo;
+		bevent->event.xSubtype = viocmd;
+		bevent->event.xSourceLp = HvLpConfig_getLpIndex();
+		bevent->event.xTargetLp = viopath_hostLp;
+		bevent->event.xSizeMinus1 =
+			offsetof(struct vioblocklpevent, u.rw_data.dma_info) +
+			(sizeof(bevent->u.rw_data.dma_info[0]) * nsg) - 1;
+		bevent->event.xSourceInstanceId =
+			viopath_sourceinst(viopath_hostLp);
+		bevent->event.xTargetInstanceId =
+			viopath_targetinst(viopath_hostLp);
+		bevent->event.xCorrelationToken = (u64)req;
+		bevent->version = VIOVERSION;
+		bevent->disk = DEVICE_NO(d);
+		bevent->u.rw_data.offset = start;
+
+		/*
+		 * Copy just the dma information from the sg list
+		 * into the request
+		 */
+		for (sgindex = 0; sgindex < nsg; sgindex++) {
+			bevent->u.rw_data.dma_info[sgindex].token =
+				sg[sgindex].dma_address;
+			bevent->u.rw_data.dma_info[sgindex].len =
+				sg[sgindex].dma_length;
+		}
+
+		/* Send the request */
+		hvrc = HvCallEvent_signalLpEvent(&bevent->event);
+		vio_free_event_buffer(viomajorsubtype_blockio, bevent);
+	}
+
+	if (hvrc != HvLpEvent_Rc_Good) {
+		num_req_outstanding--;
+		spin_unlock_irqrestore(&viodasd_spinlock, flags);
+		dma_unmap_sg(iSeries_vio_dev, sg, nsg, direction);
+		printk(VIOD_KERN_WARNING
+		       "error sending disk event to OS/400 (rc %d)\n",
+		       (int)hvrc);
+		return -1;
+	}
+	spin_unlock_irqrestore(&viodasd_spinlock, flags);
+	return 0;
+}
+
+/*
+ * This is the external request processing routine
+ */
+static void do_viodasd_request(request_queue_t *q)
+{
+	struct request *req;
+
+	while ((req = elv_next_request(q)) != NULL) {
+		/*
+		 * If we already have the maximum number of requests
+		 * outstanding to OS/400 just bail out. We'll come
+		 * back later.
+		 */
+		if (num_req_outstanding >= VIOMAXREQ)
+			break;
+
+		/* dequeue the current request from the queue */
+		blkdev_dequeue_request(req);
+		/* check that request contains a valid command */
+		if (!blk_fs_request(req)) {
+			viodasd_end_request(req, 0, req->hard_nr_sectors);
+			continue;
+		}
+
+		/* Try sending the request */
+		if (send_request(req) != 0)
+			viodasd_end_request(req, 0, req->hard_nr_sectors);
+	}
+}
+
+/*
+ * Check for changed disks
+ */
+static int viodasd_check_change(struct gendisk *gendisk)
+{
+	struct viodasd_waitevent we;
+	HvLpEvent_Rc hvrc;
+	struct viodasd_device *d = gendisk->private_data;
+
+	/* Check that we are dealing with a valid hosting partition */
+	if (viopath_hostLp == HvLpIndexInvalid) {
+		printk(VIOD_KERN_WARNING "Invalid hosting partition\n");
+		return -EIO;
+	}
+
+	init_completion(&we.com);
+
+	/* Send the open event to OS/400 */
+	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
+			HvLpEvent_Type_VirtualIo,
+			viomajorsubtype_blockio | vioblockcheck,
+			HvLpEvent_AckInd_DoAck, HvLpEvent_AckType_ImmediateAck,
+			viopath_sourceinst(viopath_hostLp),
+			viopath_targetinst(viopath_hostLp),
+			(u64)(unsigned long)&we, VIOVERSION << 16,
+			((u64)DEVICE_NO(d) << 48), 0, 0, 0);
+	if (hvrc != 0) {
+		printk(VIOD_KERN_WARNING "bad rc on signalLpEvent %d\n",
+				(int)hvrc);
+		return -EIO;
+	}
+
+	wait_for_completion(&we.com);
+
+	/* Check the return code.  If bad, assume no change */
+	if (we.rc != 0) {
+		printk(VIOD_KERN_WARNING
+			"bad rc %d on check_change. Assuming no change\n",
+			(int)we.rc);
+		return 0;
+	}
+
+	return we.data.changed;
+}
+
+/*
+ * Our file operations table
+ */
+static struct block_device_operations viodasd_fops = {
+	.owner = THIS_MODULE,
+	.open = viodasd_open,
+	.release = viodasd_release,
+	.ioctl = viodasd_ioctl,
+	.media_changed = viodasd_check_change,
+	.revalidate_disk = viodasd_revalidate
+};
+
+/* returns the total number of scatterlist elements converted */
+static int block_event_to_scatterlist(const struct vioblocklpevent *bevent,
+		struct scatterlist *sg, int *total_len)
+{
+	int i, numsg;
+	const struct rw_data *rw_data = &bevent->u.rw_data;
+	static const int offset =
+		offsetof(struct vioblocklpevent, u.rw_data.dma_info);
+	static const int element_size = sizeof(rw_data->dma_info[0]);
+
+	numsg = ((bevent->event.xSizeMinus1 + 1) - offset) / element_size;
+	if (numsg > VIOMAXBLOCKDMA)
+		numsg = VIOMAXBLOCKDMA;
+
+	*total_len = 0;
+	memset(sg, 0, sizeof(sg[0]) * VIOMAXBLOCKDMA);
+
+	for (i = 0; (i < numsg) && (rw_data->dma_info[i].len > 0); ++i) {
+		sg[i].dma_address = rw_data->dma_info[i].token;
+		sg[i].dma_length = rw_data->dma_info[i].len;
+		*total_len += rw_data->dma_info[i].len;
+	}
+	return i;
+}
+
+/*
+ * Restart all queues, starting with the one _after_ the disk given,
+ * thus reducing the chance of starvation of higher numbered disks.
+ */
+static void viodasd_restart_all_queues_starting_from(int first_index)
+{
+	int i;
+
+	for (i = first_index + 1; i < MAX_DISKNO; ++i)
+		if (viodasd_devices[i].disk)
+			blk_run_queue(viodasd_devices[i].disk->queue);
+	for (i = 0; i <= first_index; ++i)
+		if (viodasd_devices[i].disk)
+			blk_run_queue(viodasd_devices[i].disk->queue);
+}
+
+/*
+ * For read and write requests, decrement the number of outstanding requests,
+ * Free the DMA buffers we allocated.
+ */
+static int viodasd_handleReadWrite(struct vioblocklpevent *bevent)
+{
+	int num_sg, num_sect, pci_direction, total_len;
+	struct request *req;
+	struct scatterlist sg[VIOMAXBLOCKDMA];
+	struct HvLpEvent *event = &bevent->event;
+	unsigned long irq_flags;
+	int device_no;
+	int error;
+	spinlock_t *qlock;
+
+	num_sg = block_event_to_scatterlist(bevent, sg, &total_len);
+	num_sect = total_len >> 9;
+	if (event->xSubtype == (viomajorsubtype_blockio | vioblockread))
+		pci_direction = DMA_FROM_DEVICE;
+	else
+		pci_direction = DMA_TO_DEVICE;
+	dma_unmap_sg(iSeries_vio_dev, sg, num_sg, pci_direction);
+
+	/*
+	 * Since this is running in interrupt mode, we need to make sure
+	 * we're not stepping on any global I/O operations
+	 */
+	spin_lock_irqsave(&viodasd_spinlock, irq_flags);
+	num_req_outstanding--;
+	spin_unlock_irqrestore(&viodasd_spinlock, irq_flags);
+
+	req = (struct request *)bevent->event.xCorrelationToken;
+	device_no = DEVICE_NO(req->rq_disk->private_data);
+
+	error = event->xRc != HvLpEvent_Rc_Good;
+	if (error) {
+		const struct vio_error_entry *err;
+		err = vio_lookup_rc(viodasd_err_table, bevent->sub_result);
+		printk(VIOD_KERN_WARNING "read/write error %d:0x%04x (%s)\n",
+				event->xRc, bevent->sub_result, err->msg);
+		num_sect = req->hard_nr_sectors;
+	}
+	qlock = req->q->queue_lock;
+	spin_lock(qlock);
+	viodasd_end_request(req, !error, num_sect);
+	spin_unlock(qlock);
+
+	/* Finally, try to get more requests off of this device's queue */
+	viodasd_restart_all_queues_starting_from(device_no);
+
+	return 0;
+}
+
+/* This routine handles incoming block LP events */
+static void vioHandleBlockEvent(struct HvLpEvent *event)
+{
+	struct vioblocklpevent *bevent = (struct vioblocklpevent *)event;
+	struct viodasd_waitevent *pwe;
+
+	if (event == NULL)
+		/* Notification that a partition went away! */
+		return;
+	/* First, we should NEVER get an int here...only acks */
+	if (event->xFlags.xFunction == HvLpEvent_Function_Int) {
+		printk(VIOD_KERN_WARNING
+		       "Yikes! got an int in viodasd event handler!\n");
+		if (event->xFlags.xAckInd == HvLpEvent_AckInd_DoAck) {
+			event->xRc = HvLpEvent_Rc_InvalidSubtype;
+			HvCallEvent_ackLpEvent(event);
+		}
+	}
+
+	switch (event->xSubtype & VIOMINOR_SUBTYPE_MASK) {
+	case vioblockopen:
+		/*
+		 * Handle a response to an open request.  We get all the
+		 * disk information in the response, so update it.  The
+		 * correlation token contains a pointer to a waitevent
+		 * structure that has a completion in it.  update the
+		 * return code in the waitevent structure and post the
+		 * completion to wake up the guy who sent the request
+		 */
+		pwe = (struct viodasd_waitevent *)event->xCorrelationToken;
+		pwe->rc = event->xRc;
+		pwe->data.sub_result = bevent->sub_result;
+		if (event->xRc == HvLpEvent_Rc_Good) {
+			const struct open_data *data = &bevent->u.open_data;
+			struct viodasd_device *device =
+				&viodasd_devices[bevent->disk];
+			device->read_only =
+				bevent->flags & vioblockflags_ro;
+			device->size = data->disk_size;
+			device->cylinders = data->cylinders;
+			device->tracks = data->tracks;
+			device->sectors = data->sectors;
+			device->bytes_per_sector = data->bytes_per_sector;
+			viodasd_max_disk = data->max_disk;
+		}
+		complete(&pwe->com);
+		break;
+	case vioblockclose:
+		break;
+	case vioblockcheck:
+		pwe = (struct viodasd_waitevent *)event->xCorrelationToken;
+		pwe->rc = event->xRc;
+		pwe->data.changed = bevent->u.changed;
+		complete(&pwe->com);
+		break;
+#if 0
+	case vioblockflush:
+		complete((struct completion *)event->xCorrelationToken);
+		break;
+#endif
+	case vioblockread:
+	case vioblockwrite:
+		viodasd_handleReadWrite(bevent);
+		break;
+
+	default:
+		printk(VIOD_KERN_WARNING "invalid subtype!");
+		if (event->xFlags.xAckInd == HvLpEvent_AckInd_DoAck) {
+			event->xRc = HvLpEvent_Rc_InvalidSubtype;
+			HvCallEvent_ackLpEvent(event);
+		}
+	}
+}
+
+static void viodasd_init_disk(struct viodasd_device *d)
+{
+	struct gendisk *g;
+	struct request_queue *q;
+	int disk_no = DEVICE_NO(d);
+
+	if (d->disk)
+		return;
+
+	/* create the request queue for the disk */
+	spin_lock_init(&d->q_lock);
+	q = blk_init_queue(do_viodasd_request, &d->q_lock);
+	if (q == NULL) {
+		printk(VIOD_KERN_WARNING "cannot allocate queue for disk %d\n",
+				disk_no);
+		return;
+	}
+	g = alloc_disk(1 << PARTITION_SHIFT);
+	if (g == NULL) {
+		printk(VIOD_KERN_WARNING
+				"cannot allocate disk structure for disk %d\n",
+				disk_no);
+		blk_cleanup_queue(q);
+		return;
+	}
+
+	d->disk = g;
+	blk_queue_max_hw_segments(q, VIOMAXBLOCKDMA);
+	blk_queue_max_sectors(q, VIODASD_MAXSECTORS);
+	g->major = VIODASD_MAJOR;
+	g->first_minor = disk_no << PARTITION_SHIFT;
+	if (disk_no >= 26)
+		snprintf(g->disk_name, sizeof(g->disk_name),
+				VIOD_GENHD_NAME "%c%c",
+				'a' + (disk_no / 26) - 1, 'a' + (disk_no % 26));
+	else
+		snprintf(g->disk_name, sizeof(g->disk_name),
+				VIOD_GENHD_NAME "%c", 'a' + (disk_no % 26));
+	snprintf(g->devfs_name, sizeof(g->devfs_name),
+			"%s%d", VIOD_GENHD_DEVFS_NAME, disk_no);
+	g->fops = &viodasd_fops;
+	g->queue = q;
+	g->private_data = (void *)d;
+	set_capacity(g, d->size >> 9);
+
+	/* register us in the global list */
+	add_disk(g);
+}
+
+/*
+ * Initialize the whole device driver.  Handle module and non-module
+ * versions
+ */
+static int __init viodasd_init(void)
+{
+	int i;
+
+	/* Try to open to our host lp */
+	if (viopath_hostLp == HvLpIndexInvalid)
+		vio_set_hostlp();
+
+	if (viopath_hostLp == HvLpIndexInvalid) {
+		printk(VIOD_KERN_WARNING "invalid hosting partition\n");
+		return -EIO;
+	}
+
+	printk(VIOD_KERN_INFO "vers " VIOD_VERS ", hosting partition %d\n",
+			viopath_hostLp);
+
+        /* register the block device */
+	if (register_blkdev(VIODASD_MAJOR, VIOD_GENHD_NAME)) {
+		printk(VIOD_KERN_WARNING
+				"Unable to get major number %d for %s\n",
+				VIODASD_MAJOR, VIOD_GENHD_NAME);
+		return -EIO;
+	}
+	/* Actually open the path to the hosting partition */
+	if (viopath_open(viopath_hostLp, viomajorsubtype_blockio,
+				VIOMAXREQ + 2)) {
+		printk(VIOD_KERN_WARNING
+		       "error opening path to host partition %d\n",
+		       viopath_hostLp);
+		unregister_blkdev(VIODASD_MAJOR, VIOD_GENHD_NAME);
+		return -EIO;
+	}
+
+	/* Initialize our request handler */
+	vio_setHandler(viomajorsubtype_blockio, vioHandleBlockEvent);
+
+	viodasd_max_disk = MAX_DISKNO - 1;
+	for (i = 0; (i <= viodasd_max_disk) && (i < MAX_DISKNO); i++) {
+		/*
+		 * Note that probe_disk has side effects:
+		 *  a) it updates the size of the disk
+		 *  b) it updates viodasd_max_disk
+		 *  c) it registers the disk if it has not done so already
+		 */
+		probe_disk(&viodasd_devices[i]);
+	}
+
+	if (viodasd_max_disk > (MAX_DISKNO - 1))
+		printk(VIOD_KERN_INFO
+			"Only examining the first %d of %d disks connected\n",
+			MAX_DISKNO, viodasd_max_disk + 1);
+
+	return 0;
+}
+module_init(viodasd_init);
+
+void viodasd_exit(void)
+{
+	int i;
+	struct viodasd_device *d;
+
+        for (i = 0; i < MAX_DISKNO; i++) {
+		d = &viodasd_devices[i];
+		if (d->disk) {
+			if (d->disk->queue)
+				blk_cleanup_queue(d->disk->queue);
+			del_gendisk(d->disk);
+			put_disk(d->disk);
+			d->disk = NULL;
+		}
+	}
+	vio_clearHandler(viomajorsubtype_blockio);
+	unregister_blkdev(VIODASD_MAJOR, VIOD_GENHD_NAME);
+	viopath_close(viopath_hostLp, viomajorsubtype_blockio, VIOMAXREQ + 2);
+}
+
+module_exit(viodasd_exit);
diff -ruN 2.6.3-mm4/include/asm-ppc64/dma-mapping.h 2.6.3-mm4-viodasd/include/asm-ppc64/dma-mapping.h
--- 2.6.3-mm4/include/asm-ppc64/dma-mapping.h	2002-12-24 17:12:29.000000000 +1100
+++ 2.6.3-mm4-viodasd/include/asm-ppc64/dma-mapping.h	2004-02-24 16:04:33.000000000 +1100
@@ -1 +1,75 @@
-#include <asm-generic/dma-mapping.h>
+/* Copyright (C) 2004 IBM
+ *
+ * Implements the generic device dma API for ppc64. Handles
+ * the pci and vio busses
+ */
+
+#ifndef _ASM_DMA_MAPPING_H
+#define _ASM_DMA_MAPPING_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/cache.h>
+/* need struct page definitions */
+#include <linux/mm.h>
+#include <asm/scatterlist.h>
+#include <asm/bug.h>
+
+extern int dma_supported(struct device *dev, u64 mask);
+extern int dma_set_mask(struct device *dev, u64 dma_mask);
+extern void *dma_alloc_coherent(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, int flag);
+extern void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_handle);
+extern dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
+		size_t size, enum dma_data_direction direction);
+extern void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction direction);
+extern dma_addr_t dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size,
+		enum dma_data_direction direction);
+extern void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
+		size_t size, enum dma_data_direction direction);
+extern int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction direction);
+extern void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+		int nhwentries, enum dma_data_direction direction);
+extern void dma_sync_single(struct device *dev, dma_addr_t dma_handle,
+		size_t size, enum dma_data_direction direction);
+extern void dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
+		enum dma_data_direction direction);
+
+/* Now for the API extensions over the pci_ one */
+
+#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
+#define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
+#define dma_is_consistent(d)	(1)
+
+static inline int
+dma_get_cache_alignment(void)
+{
+	/* no easy way to get cache size on all processors, so return
+	 * the maximum possible, to be safe */
+	return (1 << L1_CACHE_SHIFT_MAX);
+}
+
+static inline void
+dma_sync_single_range(struct device *dev, dma_addr_t dma_handle,
+		      unsigned long offset, size_t size,
+		      enum dma_data_direction direction)
+{
+	/* just sync everything, that's all the pci API can do */
+	dma_sync_single(dev, dma_handle, offset+size, direction);
+}
+
+static inline void
+dma_cache_sync(void *vaddr, size_t size,
+	       enum dma_data_direction direction)
+{
+	/* could define this in terms of the dma_cache ... operations,
+	 * but if you get this on a platform, you should convert the platform
+	 * to using the generic device DMA API */
+	BUG();
+}
+
+#endif	/* _ASM_DMA_MAPPING_H */
diff -ruN 2.6.3-mm4/include/asm-ppc64/vio.h 2.6.3-mm4-viodasd/include/asm-ppc64/vio.h
--- 2.6.3-mm4/include/asm-ppc64/vio.h	2004-02-18 16:41:01.000000000 +1100
+++ 2.6.3-mm4-viodasd/include/asm-ppc64/vio.h	2004-02-26 17:06:08.000000000 +1100
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/device.h>
+#include <linux/pci.h>
 #include <asm/hvcall.h>
 #include <asm/prom.h>
 #include <asm/scatterlist.h>
@@ -65,6 +66,33 @@
 void vio_free_consistent(struct vio_dev *dev, size_t size, void *vaddr, 
 			 dma_addr_t dma_handle);
 
+static inline int vio_dma_supported(struct vio_dev *hwdev, u64 mask)
+{
+	return 1;
+}
+
+#define vio_map_page(dev, page, off, size, dir) \
+		vio_map_single(dev, (page_address(page) + (off)), size, dir)
+#define vio_unmap_page(dev,addr,sz,dir) vio_unmap_single(dev,addr,sz,dir)
+
+
+static inline void vio_dma_sync_single(struct vio_dev *hwdev,
+				       dma_addr_t dma_handle,
+				       size_t size, int direction)
+{
+	BUG_ON(direction == PCI_DMA_NONE);
+	/* nothing to do */
+}
+
+static inline void vio_dma_sync_sg(struct vio_dev *hwdev,
+				   struct scatterlist *sg,
+				   int nelems, int direction)
+{
+	BUG_ON(direction == PCI_DMA_NONE);
+	/* nothing to do */
+}
+static inline int vio_set_dma_mask(struct vio_dev *dev, u64 mask) { return -EIO; }
+
 extern struct bus_type vio_bus_type;
 
 struct vio_device_id {
diff -ruN 2.6.3-mm4/include/linux/major.h 2.6.3-mm4-viodasd/include/linux/major.h
--- 2.6.3-mm4/include/linux/major.h	2003-09-29 11:40:33.000000000 +1000
+++ 2.6.3-mm4-viodasd/include/linux/major.h	2004-02-26 16:36:24.000000000 +1100
@@ -126,6 +126,9 @@
 #define COMPAQ_CISS_MAJOR6      110
 #define COMPAQ_CISS_MAJOR7      111
 
+#define VIODASD_MAJOR		112
+#define VIOCD_MAJOR		113
+
 #define ATARAID_MAJOR		114
 
 #define SCSI_DISK8_MAJOR	128

--Signature=_Thu__26_Feb_2004_17_23_25_+1100_EjkdIoDgYNsc60u=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPZDdFG47PeJeR58RAje2AKDpCt3QT2IVGVXmhYYSqb1cq9HvdACg3GQY
sjYn9XGGxhj2Kr6opkCI6Mk=
=rXpn
-----END PGP SIGNATURE-----

--Signature=_Thu__26_Feb_2004_17_23_25_+1100_EjkdIoDgYNsc60u=--
