Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbWIETTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWIETTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWIETTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:19:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49625 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161006AbWIETTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:19:19 -0400
From: David Howells <dhowells@redhat.com>
To: dwmw2@infradead.org
cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Make MTD chardev mmap available under some circumstances
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Sep 2006 20:18:06 +0100
Message-ID: <24712.1157483886@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make it possible to mmap MTD chardevs directly or by copy on a NOMMU system.
This is done by:

 (1) Presenting backing device capabilities for MTD character device files to
     allow NOMMU mmap to do direct mapping where possible.

     Three BDIs are made available:

     (a) One to indicate that a device supports direct mapping with both read
     	 and write capability (eg: a RAM device).

     (b) One to indicate that a device supports direct mapping, but only with
     	 read capability (eg: a ROM device).

     (c) One to indicate that a device does not support direct mapping (eg: a
     	 NAND flash device).

     In all three cases, private mmap by copying *is* supported, which means
     that such as NAND flashes *can* be mapped privately.  The NOMMU mmap
     routine allocates some memory to hold the private mapping and then reads
     the data from the device into it.  This memory is then presented as the
     mapping.  This is *not* currently possible under MMU conditions; to
     support that will require changes to mm/mmap.c.

 (2) Providing a get_unmapped_area() op to permit the device driver to specify
     the whereabouts of the mappable data.

     If the get_unmapped_area() op is not present in mtd_info, -ENOSYS is
     returned to the caller to indicate that mapping isn't actually supported.
     The device driver may also return -ENOSYS if it doesn't want to handle the
     mapping.

 (3) Have the MTD partitioning code adjust and transfer the get_unmapped_area()
     op to the master device.

The MTDRAM driver has been modified to support this new op, and thus is able to
support full readable, writable and executable shared and private mappings.


This can be seen in the following strace excerpt:

	open("/dev/mtd0", O_RDWR)               = 4
	mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0xc0c00000
	mmap2(NULL, 16384, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0xc0c00000

which results in the following appearing in the /proc/pid/maps file:

	c0c00000-c0c04000 rw-S 00000000 00:0b 8561016    /dev/mtd0
	c0c00000-c0c04000 rw-S 00000000 00:0b 8561016    /dev/mtd0

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/mtd/devices/mtdram.c |   14 ++++++
 drivers/mtd/mtdchar.c        |   99 ++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/mtdpart.c        |   13 ++++++
 include/linux/mtd/mtd.h      |    9 ++++
 4 files changed, 134 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/devices/mtdram.c b/drivers/mtd/devices/mtdram.c
index e427c82..438cdb9 100644
--- a/drivers/mtd/devices/mtdram.c
+++ b/drivers/mtd/devices/mtdram.c
@@ -62,6 +62,19 @@ static void ram_unpoint(struct mtd_info 
 {
 }
 
+/*
+ * Allow NOMMU mmap() to directly map the device (if not NULL)
+ * - return the address to which the offset maps
+ * - return -ENOSYS to indicate refusal to do the mapping
+ */
+static unsigned long ram_get_unmapped_area(struct mtd_info *mtd,
+					   unsigned long len,
+					   unsigned long offset,
+					   unsigned long flags)
+{
+	return (unsigned long) mtd->priv + offset;
+}
+
 static int ram_read(struct mtd_info *mtd, loff_t from, size_t len,
 		size_t *retlen, u_char *buf)
 {
@@ -113,6 +126,7 @@ int mtdram_init_device(struct mtd_info *
 	mtd->erase = ram_erase;
 	mtd->point = ram_point;
 	mtd->unpoint = ram_unpoint;
+	mtd->get_unmapped_area = ram_get_unmapped_area;
 	mtd->read = ram_read;
 	mtd->write = ram_write;
 
diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index fb8b4f7..9742570 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -12,6 +12,7 @@ #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/backing-dev.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/compatmac.h>
@@ -20,6 +21,35 @@ #include <asm/uaccess.h>
 
 static struct class *mtd_class;
 
+/*
+ * backing device capabilities for non-mappable devices (such as NAND flash)
+ * - permits private mappings, copies are taken of the data
+ */
+static struct backing_dev_info mtd_bdi_unmappable = {
+	.capabilities	= BDI_CAP_MAP_COPY,
+};
+
+/*
+ * backing device capabilities for R/O mappable devices (such as ROM)
+ * - permits private mappings, copies are taken of the data
+ * - permits non-writable shared mappings
+ */
+static struct backing_dev_info mtd_bdi_ro_mappable = {
+	.capabilities	= (BDI_CAP_MAP_COPY | BDI_CAP_MAP_DIRECT |
+			   BDI_CAP_EXEC_MAP | BDI_CAP_READ_MAP),
+};
+
+/*
+ * backing device capabilities for writable mappable devices (such as RAM)
+ * - permits private mappings, copies are taken of the data
+ * - permits non-writable shared mappings
+ */
+static struct backing_dev_info mtd_bdi_rw_mappable = {
+	.capabilities	= (BDI_CAP_MAP_COPY | BDI_CAP_MAP_DIRECT |
+			   BDI_CAP_EXEC_MAP | BDI_CAP_READ_MAP |
+			   BDI_CAP_WRITE_MAP),
+};
+
 static void mtd_notify_add(struct mtd_info* mtd)
 {
 	if (!mtd)
@@ -106,9 +136,19 @@ static int mtd_open(struct inode *inode,
 	if (!mtd)
 		return -ENODEV;
 
-	if (MTD_ABSENT == mtd->type) {
+	switch (mtd->type) {
+	case MTD_ABSENT:
 		put_mtd_device(mtd);
 		return -ENODEV;
+	case MTD_RAM:
+		file->f_mapping->backing_dev_info = &mtd_bdi_rw_mappable;
+		break;
+	case MTD_ROM:
+		file->f_mapping->backing_dev_info = &mtd_bdi_ro_mappable;
+		break;
+	default:
+		file->f_mapping->backing_dev_info = &mtd_bdi_unmappable;
+		break;
 	}
 
 	/* You can't open it RW if it's not a writeable device */
@@ -763,6 +803,59 @@ #endif
 	return ret;
 } /* memory_ioctl */
 
+/*
+ * try to determine where a shared mapping can be made
+ * - only supported for NOMMU at the moment (MMU can't doesn't copy private
+ *   mappings)
+ */
+#ifndef CONFIG_MMU
+static unsigned long mtd_get_unmapped_area(struct file *file,
+					   unsigned long addr,
+					   unsigned long len,
+					   unsigned long pgoff,
+					   unsigned long flags)
+{
+	struct mtd_file_info *mfi = file->private_data;
+	struct mtd_info *mtd = mfi->mtd;
+
+	if (mtd->get_unmapped_area) {
+		unsigned long offset;
+
+		if (addr != 0)
+			return (unsigned long) -EINVAL;
+
+		if (len > mtd->size || pgoff >= (mtd->size >> PAGE_SHIFT))
+			return (unsigned long) -EINVAL;
+
+		offset = pgoff << PAGE_SHIFT;
+		if (offset > mtd->size - len)
+			return (unsigned long) -EINVAL;
+
+		return mtd->get_unmapped_area(mtd, len, offset, flags);
+	}
+
+	/* can't map directly */
+	return (unsigned long) -ENOSYS;
+}
+#endif
+
+/*
+ * set up a mapping for shared memory segments
+ */
+static int mtd_mmap(struct file *file, struct vm_area_struct *vma)
+{
+#ifdef CONFIG_MMU
+	struct mtd_file_info *mfi = file->private_data;
+	struct mtd_info *mtd = mfi->mtd;
+
+	if (mtd->type == MTD_RAM || mtd->type == MTD_ROM)
+		return 0;
+	return -ENOSYS;
+#else
+	return vma->vm_flags & VM_SHARED ? 0 : -ENOSYS;
+#endif
+}
+
 static struct file_operations mtd_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= mtd_lseek,
@@ -771,6 +864,10 @@ static struct file_operations mtd_fops =
 	.ioctl		= mtd_ioctl,
 	.open		= mtd_open,
 	.release	= mtd_close,
+	.mmap		= mtd_mmap,
+#ifndef CONFIG_MMU
+	.get_unmapped_area = mtd_get_unmapped_area,
+#endif
 };
 
 static int __init init_mtdchar(void)
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 06a9303..48bbc77 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -86,6 +86,17 @@ static void part_unpoint (struct mtd_inf
 	part->master->unpoint (part->master, addr, from + part->offset, len);
 }
 
+static unsigned long part_get_unmapped_area(struct mtd_info *mtd,
+					    unsigned long len,
+					    unsigned long offset,
+					    unsigned long flags)
+{
+	struct mtd_part *part = PART(mtd);
+
+	offset += part->offset;
+	return part->master->get_unmapped_area(mtd, len, offset, flags);
+}
+
 static int part_read_oob(struct mtd_info *mtd, loff_t from,
 			 struct mtd_oob_ops *ops)
 {
@@ -354,6 +365,8 @@ int add_mtd_partitions(struct mtd_info *
 			slave->mtd.unpoint = part_unpoint;
 		}
 
+		if (master->get_unmapped_area)
+			slave->mtd.get_unmapped_area = part_get_unmapped_area;
 		if (master->read_oob)
 			slave->mtd.read_oob = part_read_oob;
 		if (master->write_oob)
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 94a443d..ab0f21f 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -156,6 +156,15 @@ #define MTD_PROGREGION_CTRLMODE_INVALID(
 	/* We probably shouldn't allow XIP if the unpoint isn't a NULL */
 	void (*unpoint) (struct mtd_info *mtd, u_char * addr, loff_t from, size_t len);
 
+	/* Allow NOMMU mmap() to directly map the device (if not NULL)
+	 * - return the address to which the offset maps
+	 * - return -ENOSYS to indicate refusal to do the mapping
+	 */
+	unsigned long (*get_unmapped_area) (struct mtd_info *mtd,
+					    unsigned long len,
+					    unsigned long offset,
+					    unsigned long flags);
+
 
 	int (*read) (struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen, u_char *buf);
 	int (*write) (struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen, const u_char *buf);
