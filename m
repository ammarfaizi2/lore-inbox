Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270882AbTHAU0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 16:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272431AbTHAU0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 16:26:12 -0400
Received: from [217.157.19.70] ([217.157.19.70]:35596 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S270882AbTHAUZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 16:25:38 -0400
Date: Fri, 1 Aug 2003 22:25:35 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: linux-kernel@vger.kernel.org
Subject: [PATCH] (2.4.2x) Driver for Medley software RAID (Silicon Image 3112
 SATARaid, CMD680, etc?) for testing
Message-ID: <Pine.LNX.4.40.0308012225130.29551-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have written a driver for Medley software RAID as used by Silicon Image
3112 SATA IDE controller, and also other IDE RAID controllers like CMD680
based ones (and possibly others). Currently it's only for 2.4.2X.

This driver uses the ATA RAID driver framework and is based on code from
Arjan van de Ven's silraid.c and hptraid.c (it replaces the invalid
silraid.c driver).

The driver only supports striped sets (RAID 0 mode). If anyone is actually
using the other modes and want Linux support for this, please let me know,
and maybe we can work together on getting it supported.

I have currently only tested it on my own system, a Silicon Image 3112 (as
found on the Asus A7N8X Deluxe), with 2 80GB Maxtor disks using Serillel
SATA adapters.

The driver has only been tested on my system and may well be unstable and
cause data corruption. Please make sure you mount all partitions read-only
until you are fairly confident that the partitions appear uncorrupted,
before trying to write anything.

I will need some feedback before I can try to get the driver included in
the kernel, so please try the driver and let me know your results (be it
good or bad), if you get a kernel oops or similar please let me have as
many details as possible (details about your drives etc. would be helpful,
see my previous posting about the 3112 for what info I need).

Success or failure, please let me know, and also any other comments you
may have. I am particularly interested in hearing from you if you have
tried the driver with a striped set of more than 2 disks, or a
non-standard stride length (ie. not 16 sectors), or 2 different disks but
in any case please feel free to give feedback.

When I have sufficient feedback I'll either declare it stale or (more
likely) send out a new test release. At that point I will also try to get
a 2.6 version out.

If you provide feedback please indicate if you want to be informed
about updates to this driver (other than official releases) and if you
have a system that is different from mine, if you would help testing it.

PS: This is my first public Linux driver, so if I have done something
horribly wrong please go easy on me.

Regards,

Thomas


-------

diff -u -r -N linux-2.4.22-pre9.orig/Documentation/Configure.help linux-2.4.22-pre9/Documentation/Configure.help
--- linux-2.4.22-pre9.orig/Documentation/Configure.help	2003-07-31 23:12:00.000000000 +0100
+++ linux-2.4.22-pre9/Documentation/Configure.help	2003-08-01 20:51:00.000000000 +0100
@@ -2001,6 +2001,24 @@
   If you choose to compile this as a module, the module will be called
   hptraid.o.

+Medley Software RAID (CMD/Silicon Image)
+CONFIG_BLK_DEV_ATARAID_MEDLEY
+  Say Y or M if you have a Highpoint HPT 370 Raid controller
+  and want linux to use the software raid feature of this card.
+  This driver uses /dev/ataraid/dXpY (X and Y numbers) as device
+  names.
+
+  Say Y or M if you have a Silicon Image 3112 SATA RAID controller,
+  a CMD680 based controller, or another IDE RAID controller that uses
+  Medley software RAID, and want linux to use the softwareraid feature
+  of this card.
+
+  This driver uses /dev/ataraid/dXpY (X and Y numbers) as device
+  names.
+
+  If you choose to compile this as a module, the module will be called
+  medley.o.
+
 Support for Acer PICA 1 chipset
 CONFIG_ACER_PICA_61
   This is a machine with a R4400 133/150 MHz CPU. To compile a Linux
diff -u -r -N linux-2.4.22-pre9.orig/drivers/ide/Config.in linux-2.4.22-pre9/drivers/ide/Config.in
--- linux-2.4.22-pre9.orig/drivers/ide/Config.in	2003-07-31 23:12:03.000000000 +0100
+++ linux-2.4.22-pre9/drivers/ide/Config.in	2003-08-01 19:31:45.000000000 +0100
@@ -219,6 +219,6 @@
 dep_tristate 'Support for IDE Raid controllers (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL
 dep_tristate '   Support Promise software RAID (Fasttrak(tm)) (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID_PDC $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL $CONFIG_BLK_DEV_ATARAID
 dep_tristate '   Highpoint 370 software RAID (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID_HPT $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL $CONFIG_BLK_DEV_ATARAID
-dep_tristate '   Silicon Image Medley software RAID (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID_SII $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL $CONFIG_BLK_DEV_ATARAID
+dep_tristate '   Medley software RAID (CMD/Silicon Image)' CONFIG_BLK_DEV_ATARAID_MEDLEY $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL $CONFIG_BLK_DEV_ATARAID

 endmenu
diff -u -r -N linux-2.4.22-pre9.orig/drivers/ide/raid/Makefile linux-2.4.22-pre9/drivers/ide/raid/Makefile
--- linux-2.4.22-pre9.orig/drivers/ide/raid/Makefile	2003-06-13 15:51:34.000000000 +0100
+++ linux-2.4.22-pre9/drivers/ide/raid/Makefile	2003-08-01 19:32:15.000000000 +0100
@@ -12,7 +12,7 @@
 obj-$(CONFIG_BLK_DEV_ATARAID)		+= ataraid.o
 obj-$(CONFIG_BLK_DEV_ATARAID_PDC)	+= pdcraid.o
 obj-$(CONFIG_BLK_DEV_ATARAID_HPT)	+= hptraid.o
-obj-$(CONFIG_BLK_DEV_ATARAID_SII)	+= silraid.o
+obj-$(CONFIG_BLK_DEV_ATARAID_MEDLEY)	+= medley.o

 EXTRA_CFLAGS	:= -I../

diff -u -r -N linux-2.4.22-pre9.orig/drivers/ide/raid/medley.c linux-2.4.22-pre9/drivers/ide/raid/medley.c
--- linux-2.4.22-pre9.orig/drivers/ide/raid/medley.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.22-pre9/drivers/ide/raid/medley.c	2003-08-01 19:26:46.000000000 +0100
@@ -0,0 +1,620 @@
+/*
+ * MEDLEY SOFTWARE RAID DRIVER (Silicon Image 3112 and others)
+ *
+ * Copyright (C) 2003 Thomas Horsten <thomas@horsten.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307	 USA
+ * Copyright (C) 2003 Thomas Horsten <thomas@horsten.com>
+ * All Rights Reserved.
+ *
+ * This driver uses the ATA RAID driver framework and is based on
+ * code from Arjan van de Ven's silraid.c and hptraid.c.
+ *
+ * It is a driver for the Medley software RAID, which is used by
+ * some IDE controllers, including the Silicon Image 3112 SATA
+ * controller found onboard many modern motherboards, and the
+ * CMD680 stand-alone PCI RAID controller.
+ *
+ * The author has only tested this on the Silicon Image SiI3112.
+ * If you have any luck using more than 2 drives, and/or more
+ * than one RAID set, and/or any other chip than the SiI3112,
+ * please let me know by sending me mail at the above address.
+ *
+ * Currently, only striped mode is supported for these RAIDs.
+ *
+ * You are welcome to contact me if you have any questions or
+ * suggestions for improvement.
+ *
+ * Change history:
+ *
+ * 20030801 - thomas@horsten.com
+ *   First test release
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/blkdev.h>
+#include <linux/blkpg.h>
+#include <linux/genhd.h>
+#include <linux/ioctl.h>
+
+#include <linux/ide.h>
+#include <asm/uaccess.h>
+
+#include "ataraid.h"
+
+/*
+ * These options can be tuned if the need should occur.
+ *
+ * Even better, this driver could be changed to allocate the structures
+ * dynamically.
+ */
+#define MAX_DRIVES_PER_SET 8
+#define MAX_MEDLEY_ARRAYS 4
+
+/*
+ * Define this only if you are debugging the driver.
+ */
+#define DEBUGGING_MEDLEY 0
+
+#ifdef DEBUGGING_MEDLEY
+#define dprintk(fmt, args...) printk(fmt, ##args)
+#else
+#define dprintk(fmt, args...)
+#endif
+
+/*
+ * Medley RAID metadata structure.
+ *
+ * The metadata structure is based on the ATA drive ID from the drive itself,
+ * with the RAID information in the vendor specific regions.
+ *
+ * We do not use all the fields, since we only support Striped Sets.
+ */
+struct medley_metadata {
+	u8   driveid0[46];
+	u8   ascii_version[8];
+	u8   driveid1[52];
+	u32  total_sectors_low;
+	u32  total_sectors_high;
+	u16  reserved0;
+	u8   driveid2[142];
+	u16  product_id;
+	u16  vendor_id;
+	u16  minor_ver;
+	u16  major_ver;
+	u16  creation_timestamp[3];
+	u16  chunk_size;
+	u16  reserved1;
+	u8   drive_number;
+	u8   raid_type;
+	u8   drives_per_striped_set;
+	u8   striped_set_number;
+	u8   drives_per_mirrored_set;
+	u8   mirrored_set_number;
+	u32  rebuild_ptr_low;
+	u32  rebuild_ptr_high;
+	u32  incarnation_no;
+	u8   member_status;
+	u8   mirrored_set_state;
+	u8   reported_device_location;
+	u8   member_location;
+	u8   auto_rebuild;
+	u8   reserved3[17];
+	u16  checksum;
+};
+
+/*
+ * This struct holds the information about a Medley array
+ */
+struct medley_array {
+	u8     drives;
+	u16    chunk_size;
+	u32    sectors_per_row;
+	u8     chunk_size_log;
+	u16    present;
+	u16    timestamp[3];
+	u32    sectors;
+	int    registered;
+
+	kdev_t members[MAX_DRIVES_PER_SET];
+};
+static struct medley_array raid[MAX_MEDLEY_ARRAYS];
+
+/*
+ * Here we keep the offset of the ATARAID device ID's compared to our
+ * own (this will normally be 0, unless another ATARAID driver has
+ * registered some arrays before us).
+ */
+static int medley_devid_offset=0;
+
+/*
+ * This holds the number of detected arrays.
+ */
+static int medley_arrays=0;
+
+/*
+ * The interface functions used by the ataraid framework.
+ */
+static int medley_open(struct inode * inode, struct file * filp);
+static int medley_release(struct inode * inode, struct file * filp);
+static int medley_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
+static int medley_make_request (request_queue_t *q, int rw, struct buffer_head * bh);
+
+static struct raid_device_operations medley_ops = {
+	open:		 medley_open,
+	release:	 medley_release,
+	ioctl:		 medley_ioctl,
+	make_request:	 medley_make_request
+};
+
+/*
+ * This is the list of devices to probe.
+ */
+static const kdev_t probelist[]= {
+	MKDEV(IDE0_MAJOR, 0),
+	MKDEV(IDE0_MAJOR, 64),
+	MKDEV(IDE1_MAJOR, 0),
+	MKDEV(IDE1_MAJOR, 64),
+	MKDEV(IDE2_MAJOR, 0),
+	MKDEV(IDE2_MAJOR, 64),
+	MKDEV(IDE3_MAJOR, 0),
+	MKDEV(IDE3_MAJOR, 64),
+	MKDEV(IDE4_MAJOR, 0),
+	MKDEV(IDE4_MAJOR, 64),
+	MKDEV(IDE5_MAJOR, 0),
+	MKDEV(IDE5_MAJOR, 64),
+	MKDEV(IDE6_MAJOR, 0),
+	MKDEV(IDE6_MAJOR, 64),
+	MKDEV(0,0)
+};
+
+/*
+ * Handler for ioctl calls to the virtual device
+ */
+static int medley_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	unsigned int minor;
+	unsigned long sectors;
+
+	dprintk("medley_ioctl\n");
+
+	if (!inode || !inode->i_rdev)
+	{
+		return -EINVAL;
+	}
+
+	minor = MINOR(inode->i_rdev)>>SHIFT;
+
+	switch (cmd) {
+
+	case BLKGETSIZE:   /* Return device size */
+		if (!arg) return -EINVAL;
+		sectors = ataraid_gendisk.part[MINOR(inode->i_rdev)].nr_sects;
+		dprintk("medley_ioctl: BLKGETSIZE\n");
+		if (MINOR(inode->i_rdev)&15)
+			return put_user(sectors, (unsigned long *) arg);
+		return put_user(raid[minor-medley_devid_offset].sectors, (unsigned long *) arg);
+		break;
+
+	case HDIO_GETGEO:
+	{
+		struct hd_geometry *loc = (struct hd_geometry *) arg;
+		unsigned short bios_cyl = (unsigned short)(raid[minor].sectors/255/63); /* truncate */
+
+		dprintk("medley_ioctl: HDIO_GETGEO\n");
+		if (!loc) return -EINVAL;
+		if (put_user(255, (byte *) &loc->heads)) return -EFAULT;
+		if (put_user(63, (byte *) &loc->sectors)) return -EFAULT;
+		if (put_user(bios_cyl, (unsigned short *) &loc->cylinders)) return -EFAULT;
+		if (put_user((unsigned)ataraid_gendisk.part[MINOR(inode->i_rdev)].start_sect,
+			     (unsigned long *) &loc->start)) return -EFAULT;
+		return 0;
+	}
+
+	case HDIO_GETGEO_BIG:
+	{
+		struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
+
+		dprintk("medley_ioctl: HDIO_GETGEO_BIG\n");
+		if (!loc) return -EINVAL;
+		if (put_user(255, (byte *) &loc->heads)) return -EFAULT;
+		if (put_user(63, (byte *) &loc->sectors)) return -EFAULT;
+		if (put_user(raid[minor-medley_devid_offset].sectors/255/63, (unsigned int *) &loc->cylinders)) return -EFAULT;
+		if (put_user((unsigned)ataraid_gendisk.part[MINOR(inode->i_rdev)].start_sect,
+			     (unsigned long *) &loc->start)) return -EFAULT;
+		return 0;
+	}
+
+	case BLKROSET:
+	case BLKROGET:
+	case BLKSSZGET:
+		dprintk("medley_ioctl: BLK*\n");
+		return blk_ioctl(inode->i_rdev, cmd, arg);
+
+	default:
+		return -EINVAL;
+	};
+
+	return 0;
+}
+
+/*
+ * Handler to map a request to the real device.
+ * If the request cannot be made because it spans multiple disks,
+ * we return -1, otherwise we modify the request and return 1.
+ */
+static int medley_make_request(request_queue_t *q, int rw, struct buffer_head * bh)
+{
+	u8 disk;
+	u32 rsect = bh->b_rsector;
+	int device = ((bh->b_rdev >> SHIFT)&MAJOR_MASK) - medley_devid_offset;
+	struct medley_array *r = raid+device;
+
+	/* Add the partition offset */
+	rsect = rsect + ataraid_gendisk.part[MINOR(bh->b_rdev)].start_sect;
+
+	dprintk("medley_make_request, rsect=%ul\n",rsect);
+
+	/* Detect if the request crosses a chunk barrier */
+	if (r->chunk_size_log)
+	{
+		if ( ((rsect & (r->chunk_size-1)) + (bh->b_size/512)) > (1<<r->chunk_size_log))
+		{
+			return -1;
+		}
+	} else {
+		if ((rsect/r->chunk_size) != ((rsect+(bh->b_size/512)-1)/r->chunk_size))
+		{
+			return -1;
+		}
+	}
+
+	/*
+	 * Medley arrays are simple enough, since the smallest disk decides the
+	 * number of sectors used per disk. So there is no need for the cutoff
+	 * magic found in other drivers like hptraid.
+	 */
+	if (r->chunk_size_log)
+	{
+		/* We save some expensive operations (1 div, 1 mul, 1 mod), if the chunk
+		 * size is a power of 2, which is the normal case.
+		 */
+		disk = (rsect >> r->chunk_size_log) % r->drives;
+		rsect = ((rsect / r->sectors_per_row) << r->chunk_size_log) + (rsect & (r->chunk_size-1));
+	}
+	else
+	{
+		disk = (rsect / r->chunk_size) % r->drives;
+		rsect = rsect / r->sectors_per_row * r->chunk_size + rsect % r->chunk_size;
+	}
+
+	dprintk("medley_make_request :-), disk=%d, rsect=%ul\n",disk,rsect);
+	bh->b_rdev = r->members[disk];
+	bh->b_rsector = rsect;
+	return 1;
+}
+
+/*
+ * Find out which array a drive belongs to, and add it to that array.
+ * If it is not a member of a detected array, add a new array for it.
+ */
+void medley_add_raiddrive(kdev_t dev, struct medley_metadata *md)
+{
+	dprintk("Candidate drive %02x:%02x - drive %d of %d, stride %d, sectors %ul (%d MB)\n",
+	       MAJOR(dev),MINOR(dev),md->drive_number,md->drives_per_striped_set,md->chunk_size,md->total_sectors_low,md->total_sectors_low/1024/1024/2);
+
+	int c;
+	for (c=0; c<medley_arrays; c++)
+	{
+		if ( (raid[c].timestamp[0]==md->creation_timestamp[0]) &&
+		     (raid[c].timestamp[1]==md->creation_timestamp[1]) &&
+		     (raid[c].timestamp[2]==md->creation_timestamp[2]) &&
+		     (raid[c].drives==md->drives_per_striped_set) &&
+		     (raid[c].chunk_size==md->chunk_size) &&
+		     ((raid[c].present & (1<<md->drive_number)) == 0) )
+		{
+			dprintk("Existing array %d\n", c);
+			raid[c].present |= (1 << md->drive_number);
+			raid[c].members[md->drive_number]=dev;
+			break;
+		}
+	}
+	if (c==medley_arrays)
+	{
+		dprintk("New array %d\n",medley_arrays);
+		if (medley_arrays==MAX_MEDLEY_ARRAYS)
+		{
+			printk(KERN_ERR "Medley RAID: Too many RAID sets detected - you can change the max in the driver.\n");
+		}
+		else
+		{
+			raid[c].timestamp[0]=md->creation_timestamp[0];
+			raid[c].timestamp[1]=md->creation_timestamp[1];
+			raid[c].timestamp[2]=md->creation_timestamp[2];
+			raid[c].drives=md->drives_per_striped_set;
+			raid[c].chunk_size=md->chunk_size;
+			raid[c].sectors_per_row=md->chunk_size*md->drives_per_striped_set;
+
+			/* Speedup if chunk size is a power of 2 */
+			if ( ((raid[c].chunk_size-1) & (raid[c].chunk_size)) == 0)
+			{
+				raid[c].chunk_size_log = ffs(raid[c].chunk_size)-1;
+			}
+			else
+			{
+				raid[c].chunk_size_log = 0;
+			}
+			raid[c].present=(1<<md->drive_number);
+			raid[c].members[md->drive_number]=dev;
+			if (md->major_ver == 1)
+			{
+				raid[c].sectors=((u32 *)(md))[27];
+			}
+			else
+			{
+				raid[c].sectors=md->total_sectors_low;
+			}
+			medley_arrays++;
+		}
+	}
+}
+
+/*
+ * Read the Medley metadata from a drive.
+ * Returns the bh if it was found, otherwise NULL.
+ */
+struct buffer_head *medley_get_metadata(kdev_t dev)
+{
+	struct buffer_head *bh = NULL;
+
+	ide_drive_t *drvinfo = get_info_ptr(dev);
+	if ((drvinfo==NULL) || drvinfo->capacity<1)
+	{
+		return NULL;
+	}
+
+	dprintk("Probing %02x:%02x\n",MAJOR(dev),MINOR(dev));
+	/* If this drive is not on a PCI controller, it is not Medley RAID.
+	 * Medley matches the PCI device ID with the metadata to check if it is valid. */
+	struct pci_dev *pcidev = drvinfo->hwif?drvinfo->hwif->pci_dev:NULL;
+	if (!pcidev)
+	{
+		return NULL;
+	}
+
+	/*
+	 * 4 copies of the metadata exist, in the following 4 sectors:
+	 * last, last-0x200, last-0x400, last-0x600.
+	 *
+	 * We must try each of these in order, until we find the metadata.
+	 * FIXME: This does not take into account drives with 48/64-bit LBA addressing,
+	 * even though the Medley RAID version 2 supports these.
+	 */
+	u32 lba=drvinfo->capacity-1;
+	int pos;
+	for (pos=0; pos<4; pos++,lba-=0x200)
+	{
+		bh = bread(dev, lba, 512);
+		if (!bh)
+		{
+			printk(KERN_ERR "Medley RAID (%02x:%02x): Error reading metadata (lba=%d)\n", MAJOR(dev),MINOR(dev),lba);
+			break;
+		}
+
+		/* A valid Medley RAID has the PCI vendor/device ID of its IDE controller,
+		 * and the correct checksum. */
+		struct medley_metadata *md = (void *)(bh->b_data);
+
+		if (pcidev->vendor == md->vendor_id && pcidev->device == md->product_id)
+		{
+			u16 checksum=0;
+			u16 *p = (void *)(bh->b_data);
+			int c;
+			for (c=0; c<160; c++)
+			{
+				checksum += *p++;
+			}
+			dprintk("Probing %02x:%02x csum=%d, major_ver=%d\n",MAJOR(dev),MINOR(dev),checksum,md->major_ver);
+			if (((checksum == 0xffff) && (md->major_ver == 1)) || (checksum == 0))
+			{
+				dprintk("Probing %02x:%02x VALID\n",MAJOR(dev),MINOR(dev));
+				/* Found a valid block */
+				break;
+			}
+		}
+		/* Was not a valid superblock */
+		if (bh)
+		{
+			brelse(bh);
+			bh=NULL;
+		}
+	}
+	return bh;
+}
+
+/*
+ * Determine if this drive belongs to a Medley array.
+ */
+static void medley_probe_drive(int major, int minor)
+{
+	struct buffer_head *bh;
+	kdev_t dev = MKDEV(major,minor);
+
+	bh=medley_get_metadata(dev);
+	if (!bh)
+		return;
+
+	struct medley_metadata *md = (void *)(bh->b_data);
+
+	if (md->raid_type != 0x0)
+	{
+		printk(KERN_INFO "Medley RAID (%02x:%02x): Sorry, this driver currently only supports striped sets (RAID level 0).\n",
+		       major,minor);
+	}
+	else if (md->major_ver == 2 && md->total_sectors_high != 0)
+	{
+		printk(KERN_ERR "Medley RAID (%02x:%02x): Sorry, the driver only supports 32 bit LBA disks (disk too big).\n",
+		       major,minor);
+	}
+	else if (md->major_ver > 0 && md->major_ver > 2)
+	{
+		printk(KERN_INFO "Medley RAID (%02x:%02x): Unsupported version (%d.%d) - this driver supports version 1.x and 2.x\n",
+		       major,minor,md->major_ver,md->minor_ver);
+	}
+	else if (md->drives_per_striped_set > MAX_DRIVES_PER_SET)
+	{
+		printk(KERN_ERR "Medley RAID (%02x:%02x): Striped set too large (%d drives) - please report this and change max in driver.\n",
+		       major,minor,md->drives_per_striped_set);
+	}
+	else if ((md->drive_number > md->drives_per_striped_set) ||
+	         (md->drives_per_striped_set<1) ||
+	         (md->chunk_size < 1))
+	{
+		printk(KERN_ERR "Medley RAID (%02x:%02x): Metadata appears to be corrupt.\n",
+		       major,minor);
+	}
+	else
+	{
+		/* We have a good candidate, put it in the correct array */
+		medley_add_raiddrive(dev,md);
+	}
+
+	if (bh)
+	{
+		brelse(bh);
+	}
+}
+
+/*
+ * Initialise the driver.
+ */
+static __init int medley_init(void)
+{
+	int c;
+
+	memset(raid, 0, MAX_MEDLEY_ARRAYS*sizeof(struct medley_array));
+
+	/* Probe each of the drives on our list */
+	for (c=0; probelist[c] != MKDEV(0,0); c++)
+	{
+		medley_probe_drive(MAJOR(probelist[c]),MINOR(probelist[c]));
+	}
+
+	/* Check if the detected sets are complete */
+	for (c=0; c<medley_arrays; c++)
+	{
+		if (raid[c].present != (1<<raid[c].drives)-1)
+		{
+			printk(KERN_ERR "Medley RAID: Incomplete RAID set deleted - disks:");
+			int d;
+			for (d=0; c<raid[c].drives; c++)
+			{
+				if (raid[c].present & (1<<d))
+				{
+					printk(" %02x:%02x", MAJOR(raid[c].members[d]), MINOR(raid[c].members[d]));
+				}
+			}
+			printk("\n");
+			/* Delete it */
+			if (c+1<medley_arrays) {
+				memmove(raid+c+1,raid+c,(medley_arrays-c-1)*sizeof(struct medley_array));
+			}
+			medley_arrays--;
+		}
+	}
+
+	/* Register any remaining array(s) */
+	for (c=0; c<medley_arrays; c++)
+	{
+		int device=ataraid_get_device(&medley_ops);
+		if (device<0) {
+			printk(KERN_ERR "Medley RAID: Could not get ATARAID device.\n");
+			break;
+		}
+		if (c==0)
+		{
+			/* First array, compute offset to our device ID's */
+			medley_devid_offset=device;
+			dprintk("Medley_devid_offset: %d\n",medley_devid_offset);
+		}
+		else if (device-medley_devid_offset != medley_arrays)
+		{
+			printk(KERN_ERR "Medley RAID: ATARAID gave us an illegal device ID.\n");
+			ataraid_release_device(device);
+			break;
+		}
+
+		printk(KERN_INFO "Medley RAID: Striped set %d consists of %d disks, total %dMB - disks:",
+		       c, raid[c].drives,raid[c].sectors/1024/1024/2);
+		int d;
+		for (d=0; d<raid[c].drives; d++)
+		{
+			printk(" %02x:%02x", MAJOR(raid[c].members[d]), MINOR(raid[c].members[d]));
+		}
+		printk("\n");
+		raid[c].registered=1;
+		ataraid_register_disk(c,raid[c].sectors);
+	}
+
+	if (medley_arrays > 0)
+	{
+		printk(KERN_INFO "Medley RAID: %d active RAID set%s\n",medley_arrays,medley_arrays==1?"":"s");
+		return 0;
+	}
+
+	printk(KERN_INFO "Medley RAID: No usable RAID sets found\n");
+	return -ENODEV;
+}
+
+static void __exit medley_exit (void)
+{
+	int device;
+	for (device = 0; medley_arrays; device++) {
+#if 0
+		for (i=0;i<8;i++) {
+			struct block_device *bdev = raid[device].disk[i].bdev;
+			raid[device].disk[i].bdev = NULL;
+			if (bdev)
+				blkdev_put(bdev, BDEV_RAW);
+		}
+#endif
+		if (raid[device].registered) {
+			ataraid_release_device(device+medley_devid_offset);
+			raid[device].registered=0;
+		}
+	}
+}
+
+static int medley_open(struct inode * inode, struct file * filp)
+{
+	dprintk("medley_open\n");
+	MOD_INC_USE_COUNT;
+	return 0;
+}
+static int medley_release(struct inode * inode, struct file * filp)
+{
+	dprintk("medley_release\n");
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+module_init(medley_init);
+module_exit(medley_exit);
+MODULE_LICENSE("GPL");
diff -u -r -N linux-2.4.22-pre9.orig/drivers/ide/raid/silraid.c linux-2.4.22-pre9/drivers/ide/raid/silraid.c
--- linux-2.4.22-pre9.orig/drivers/ide/raid/silraid.c	2003-06-13 15:51:34.000000000 +0100
+++ linux-2.4.22-pre9/drivers/ide/raid/silraid.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,487 +0,0 @@
-/*
-   silraid.c  Copyright (C) 2002 Red Hat, Inc. All rights reserved.
-
-   The contents of this file are subject to the Open Software License version 1.1
-   that can be found at http://www.opensource.org/licenses/osl-1.1.txt and is
-   included herein by reference.
-
-   Alternatively, the contents of this file may be used under the
-   terms of the GNU General Public License version 2 (the "GPL") as
-   distributed in the kernel source COPYING file, in which
-   case the provisions of the GPL are applicable instead of the
-   above.  If you wish to allow the use of your version of this file
-   only under the terms of the GPL and not to allow others to use
-   your version of this file under the OSL, indicate your decision
-   by deleting the provisions above and replace them with the notice
-   and other provisions required by the GPL.  If you do not delete
-   the provisions above, a recipient may use your version of this
-   file under either the OSL or the GPL.
-
-   Authors: 	Arjan van de Ven <arjanv@redhat.com>
-
-
-*/
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/smp_lock.h>
-#include <linux/blkdev.h>
-#include <linux/blkpg.h>
-#include <linux/genhd.h>
-#include <linux/ioctl.h>
-
-#include <linux/ide.h>
-#include <asm/uaccess.h>
-
-#include "ataraid.h"
-
-static int silraid_open(struct inode * inode, struct file * filp);
-static int silraid_release(struct inode * inode, struct file * filp);
-static int silraid_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
-static int silraid0_make_request (request_queue_t *q, int rw, struct buffer_head * bh);
-
-struct disk_dev {
-	int major;
-	int minor;
-	int device;
-};
-
-static struct disk_dev devlist[]= {
-	{IDE0_MAJOR,  0,  -1 },
-	{IDE0_MAJOR, 64,  -1 },
-	{IDE1_MAJOR,  0,  -1 },
-	{IDE1_MAJOR, 64,  -1 },
-	{IDE2_MAJOR,  0,  -1 },
-	{IDE2_MAJOR, 64,  -1 },
-	{IDE3_MAJOR,  0,  -1 },
-	{IDE3_MAJOR, 64,  -1 },
-	{IDE4_MAJOR,  0,  -1 },
-	{IDE4_MAJOR, 64,  -1 },
-	{IDE5_MAJOR,  0,  -1 },
-	{IDE5_MAJOR, 64,  -1 },
-	{IDE6_MAJOR,  0,  -1 },
-	{IDE6_MAJOR, 64,  -1 },
-};
-
-
-struct sildisk {
-	kdev_t	device;
-	unsigned long sectors;
-	struct block_device *bdev;
-	unsigned long last_pos;
-};
-
-struct silraid {
-	unsigned int stride;
-	unsigned int disks;
-	unsigned long sectors;
-	struct geom geom;
-
-	struct sildisk disk[8];
-
-	unsigned long cutoff[8];
-	unsigned int cutoff_disks[8];
-};
-
-static struct raid_device_operations silraid0_ops = {
-        open:                   silraid_open,
-	release:                silraid_release,
-	ioctl:			silraid_ioctl,
-	make_request:		silraid0_make_request
-};
-
-static struct silraid raid[16];
-
-
-static int silraid_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
-{
-	unsigned int minor;
-   	unsigned long sectors;
-
-	if (!inode || !inode->i_rdev)
-		return -EINVAL;
-
-	minor = MINOR(inode->i_rdev)>>SHIFT;
-
-	switch (cmd) {
-
-         	case BLKGETSIZE:   /* Return device size */
- 			if (!arg)  return -EINVAL;
-			sectors = ataraid_gendisk.part[MINOR(inode->i_rdev)].nr_sects;
-			if (MINOR(inode->i_rdev)&15)
-				return put_user(sectors, (unsigned long *) arg);
-			return put_user(raid[minor].sectors , (unsigned long *) arg);
-			break;
-
-
-		case HDIO_GETGEO:
-		{
-			struct hd_geometry *loc = (struct hd_geometry *) arg;
-			unsigned short bios_cyl = raid[minor].geom.cylinders; /* truncate */
-
-			if (!loc) return -EINVAL;
-			if (put_user(raid[minor].geom.heads, (byte *) &loc->heads)) return -EFAULT;
-			if (put_user(raid[minor].geom.sectors, (byte *) &loc->sectors)) return -EFAULT;
-			if (put_user(bios_cyl, (unsigned short *) &loc->cylinders)) return -EFAULT;
-			if (put_user((unsigned)ataraid_gendisk.part[MINOR(inode->i_rdev)].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
-			return 0;
-		}
-
-		case HDIO_GETGEO_BIG:
-		{
-			struct hd_big_geometry *loc = (struct hd_big_geometry *) arg;
-			if (!loc) return -EINVAL;
-			if (put_user(raid[minor].geom.heads, (byte *) &loc->heads)) return -EFAULT;
-			if (put_user(raid[minor].geom.sectors, (byte *) &loc->sectors)) return -EFAULT;
-			if (put_user(raid[minor].geom.cylinders, (unsigned int *) &loc->cylinders)) return -EFAULT;
-			if (put_user((unsigned)ataraid_gendisk.part[MINOR(inode->i_rdev)].start_sect,
-				(unsigned long *) &loc->start)) return -EFAULT;
-			return 0;
-		}
-
-
-		case BLKROSET:
-		case BLKROGET:
-		case BLKSSZGET:
-			return blk_ioctl(inode->i_rdev, cmd, arg);
-
-		default:
-			printk("Invalid ioctl \n");
-			return -EINVAL;
-	};
-
-	return 0;
-}
-
-
-static unsigned long partition_map_normal(unsigned long block, unsigned long partition_off, unsigned long partition_size, int stride)
-{
-	return block + partition_off;
-}
-
-static int silraid0_make_request (request_queue_t *q, int rw, struct buffer_head * bh)
-{
-	unsigned long rsect;
-	unsigned long rsect_left,rsect_accum = 0;
-	unsigned long block;
-	unsigned int disk=0,real_disk=0;
-	int i;
-	int device;
-	struct silraid *thisraid;
-
-	rsect = bh->b_rsector;
-
-	/* Ok. We need to modify this sector number to a new disk + new sector number.
-	 * If there are disks of different sizes, this gets tricky.
-	 * Example with 3 disks (1Gb, 4Gb and 5 GB):
-	 * The first 3 Gb of the "RAID" are evenly spread over the 3 disks.
-	 * Then things get interesting. The next 2Gb (RAID view) are spread across disk 2 and 3
-	 * and the last 1Gb is disk 3 only.
-	 *
-	 * the way this is solved is like this: We have a list of "cutoff" points where everytime
-	 * a disk falls out of the "higher" count, we mark the max sector. So once we pass a cutoff
-	 * point, we have to divide by one less.
-	 */
-
-	device = (bh->b_rdev >> SHIFT)&MAJOR_MASK;
-	thisraid = &raid[device];
-	if (thisraid->stride==0)
-		thisraid->stride=1;
-
-	/* Partitions need adding of the start sector of the partition to the requested sector */
-
-	rsect = partition_map_normal(rsect, ataraid_gendisk.part[MINOR(bh->b_rdev)].start_sect, ataraid_gendisk.part[MINOR(bh->b_rdev)].nr_sects, thisraid->stride);
-
-	/* Woops we need to split the request to avoid crossing a stride barrier */
-	if ((rsect/thisraid->stride) != ((rsect+(bh->b_size/512)-1)/thisraid->stride)) {
-		return -1;
-	}
-
-	rsect_left = rsect;
-
-	for (i=0;i<8;i++) {
-		if (thisraid->cutoff_disks[i]==0)
-			break;
-		if (rsect > thisraid->cutoff[i]) {
-			/* we're in the wrong area so far */
-			rsect_left -= thisraid->cutoff[i];
-			rsect_accum += thisraid->cutoff[i]/thisraid->cutoff_disks[i];
-		} else {
-			block = rsect_left / thisraid->stride;
-			disk = block % thisraid->cutoff_disks[i];
-			block = (block / thisraid->cutoff_disks[i]) * thisraid->stride;
-			rsect = rsect_accum + (rsect_left % thisraid->stride) + block;
-			break;
-		}
-	}
-
-	for (i=0;i<8;i++) {
-		if ((disk==0) && (thisraid->disk[i].sectors > rsect_accum)) {
-			real_disk = i;
-			break;
-		}
-		if ((disk>0) && (thisraid->disk[i].sectors >= rsect_accum)) {
-			disk--;
-		}
-
-	}
-	disk = real_disk;
-
-
-	/*
-	 * The new BH_Lock semantics in ll_rw_blk.c guarantee that this
-	 * is the only IO operation happening on this bh.
-	 */
-	bh->b_rdev = thisraid->disk[disk].device;
-	bh->b_rsector = rsect;
-
-	/*
-	 * Let the main block layer submit the IO and resolve recursion:
-	 */
-	return 1;
-}
-
-#include "silraid.h"
-
-static unsigned long calc_silblock_offset (int major,int minor)
-{
-	unsigned long lba = 0, cylinders;
-	kdev_t dev;
-	ide_drive_t *ideinfo;
-
-	dev = MKDEV(major,minor);
-	ideinfo = get_info_ptr (dev);
-	if (ideinfo==NULL)
-		return 0;
-
-
-	/* last sector second to last cylinder */
-	if (ideinfo->head==0)
-		return 0;
-	if (ideinfo->sect==0)
-		return 0;
-	cylinders = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
-	lba = (cylinders - 1) * (ideinfo->head*ideinfo->sect);
-	lba = lba - ideinfo->head -1;
-
-//	return 80417215;
-	printk("Guestimating sector %li for superblock\n",lba);
-	return lba;
-
-}
-
-
-
-static int read_disk_sb (int major, int minor, unsigned char *buffer,int bufsize)
-{
-	int ret = -EINVAL;
-	struct buffer_head *bh = NULL;
-	kdev_t dev = MKDEV(major,minor);
-	unsigned long sb_offset;
-
-	if (blksize_size[major]==NULL)   /* device doesn't exist */
-		return -EINVAL;
-
-
-	/*
-	 * Calculate the position of the superblock,
-	 * it's at first sector of the last cylinder
-	 */
-	sb_offset = calc_silblock_offset(major,minor)/8;
-	/* The /8 transforms sectors into 4Kb blocks */
-
-	if (sb_offset==0)
-		return -1;
-
-	set_blocksize (dev, 4096);
-
-	bh = bread (dev, sb_offset, 4096);
-
-	if (bh) {
-		memcpy (buffer, bh->b_data, bufsize);
-	} else {
-		printk(KERN_ERR "silraid: Error reading superblock.\n");
-		goto abort;
-	}
-	ret = 0;
-abort:
-	if (bh)
-		brelse (bh); return ret;
-}
-
-static unsigned short checksum1(unsigned short *buffer)
-{
-	int i;
-	int sum = 0;
-	for (i=0; i<0x13f/2; i++)
-		sum += buffer[i];
-	return (-sum)&0xFFFF;
-}
-
-static int cookie = 0;
-
-static void __init probedisk(int devindex,int device, int raidlevel)
-{
-	int i;
-	int major, minor;
-        struct signature *superblock;
-	static unsigned char block[4096];
-	struct block_device *bdev;
-
-	if (devlist[devindex].device!=-1) /* already assigned to another array */
-		return;
-
-	major = devlist[devindex].major;
-	minor = devlist[devindex].minor;
-
-        if (read_disk_sb(major,minor,(unsigned char*)&block,sizeof(block)))
-        	return;
-
-        superblock = (struct signature*)&block[4096-512];
-
-        if (superblock->unknown[0] != 'Z') /* Need better check here */
-        	return;
-
-        if (superblock->checksum1 != checksum1((unsigned short*)superblock))
-        	return;
-
-
-
-	if (superblock->raidlevel!=raidlevel) /* different raidlevel */
-		return;
-
-	/* This looks evil. But basically, we have to search for our adapternumber
-	   in the arraydefinition, both of which are in the superblock */
-	 i = superblock->disk_in_set;
-
-	bdev = bdget(MKDEV(major,minor));
-        if (bdev && blkdev_get(bdev, FMODE_READ|FMODE_WRITE, 0, BDEV_RAW) == 0) {
-		raid[device].disk[i].bdev = bdev;
-	}
-	raid[device].disk[i].device = MKDEV(major,minor);
-	raid[device].disk[i].sectors = superblock->thisdisk_sectors;
-	raid[device].stride = superblock->raid0_sectors_per_stride;
-	raid[device].disks = superblock->disks_in_set;
-	raid[device].sectors = superblock->array_sectors;
-	raid[device].geom.heads = 255;
-	raid[device].geom.sectors = 63;
-	raid[device].geom.cylinders =  raid[device].sectors / raid[device].geom.heads / raid[device].geom.sectors;
-
-	devlist[devindex].device=device;
-
-}
-
-static void __init fill_cutoff(int device)
-{
-	int i,j;
-	unsigned long smallest;
-	unsigned long bar;
-	int count;
-
-	bar = 0;
-	for (i=0;i<8;i++) {
-		smallest = ~0;
-		for (j=0;j<8;j++)
-			if ((raid[device].disk[j].sectors < smallest) && (raid[device].disk[j].sectors>bar))
-				smallest = raid[device].disk[j].sectors;
-		count = 0;
-		for (j=0;j<8;j++)
-			if (raid[device].disk[j].sectors >= smallest)
-				count++;
-
-		smallest = smallest * count;
-		bar = smallest;
-		raid[device].cutoff[i] = smallest;
-		raid[device].cutoff_disks[i] = count;
-	}
-}
-
-static __init int silraid_init_one(int device,int raidlevel)
-{
-	int i, count;
-
-	for (i=0; i<14; i++)
-		probedisk(i, device, raidlevel);
-
-	if (raidlevel==0)
-		fill_cutoff(device);
-
-	/* Initialize the gendisk structure */
-
-	ataraid_register_disk(device,raid[device].sectors);
-
-	count=0;
-
-	for (i=0;i<8;i++) {
-		if (raid[device].disk[i].device!=0) {
-			printk(KERN_INFO "Drive %i is %li Mb (%i / %i) \n",
-				i,raid[device].disk[i].sectors/2048,MAJOR(raid[device].disk[i].device),MINOR(raid[device].disk[i].device));
-			count++;
-		}
-	}
-	if (count) {
-		printk(KERN_INFO "Raid%i array consists of %i drives. \n",raidlevel,count);
-		return 0;
-	} else {
-		return -ENODEV;
-	}
-}
-
-static __init int silraid_init(void)
-{
-	int retval, device, count = 0;
-
-	do {
-		cookie = 0;
-		device=ataraid_get_device(&silraid0_ops);
-		if (device<0)
-			break;
-		retval = silraid_init_one(device,0);
-		if (retval) {
-			ataraid_release_device(device);
-			break;
-		} else {
-			count++;
-		}
-	} while (1);
-
-	if (count) {
-		printk(KERN_INFO "driver for Silicon Image(tm) Medley(tm) hardware version 0.0.1\n");
-		return 0;
-	}
-	printk(KERN_DEBUG "driver for Silicon Image(tm) Medley(tm) hardware version 0.0.1: No raid array found\n");
-	return -ENODEV;
-}
-
-static void __exit silraid_exit (void)
-{
-	int i,device;
-	for (device = 0; device<16; device++) {
-		for (i=0;i<8;i++) {
-			struct block_device *bdev = raid[device].disk[i].bdev;
-			raid[device].disk[i].bdev = NULL;
-			if (bdev)
-				blkdev_put(bdev, BDEV_RAW);
-		}
-		if (raid[device].sectors)
-			ataraid_release_device(device);
-	}
-}
-
-static int silraid_open(struct inode * inode, struct file * filp)
-{
-	MOD_INC_USE_COUNT;
-	return 0;
-}
-static int silraid_release(struct inode * inode, struct file * filp)
-{
-	MOD_DEC_USE_COUNT;
-	return 0;
-}
-
-module_init(silraid_init);
-module_exit(silraid_exit);
-MODULE_LICENSE("GPL and additional rights");
diff -u -r -N linux-2.4.22-pre9.orig/drivers/ide/raid/silraid.h linux-2.4.22-pre9/drivers/ide/raid/silraid.h
--- linux-2.4.22-pre9.orig/drivers/ide/raid/silraid.h	2003-06-13 15:51:34.000000000 +0100
+++ linux-2.4.22-pre9/drivers/ide/raid/silraid.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,30 +0,0 @@
-struct signature {
-	char unknown[0x36];  		/* 0x00 to 0x35 */
-	char diskname[32];	     	/* 0x36 to 0x56 */
-	char unknown2[0x6c-86];		/* 0x57 to 0x6B */
-	unsigned int array_sectors;	/* 0x6C to 0x6F */
-	char unknown2b[8];		/* 0x70 to 0x77 */
-	unsigned int thisdisk_sectors;	/* 0x78 to 0x7B */
-	char unknown2c[0xFF-0x7B];	/* 0x7C to 0xFF */
-	char unknown3[4];		/* 0x100 to 0x103 */
-	unsigned short PCI_DEV_ID;	/* 0x104 and 0x105 */
-	unsigned short PCI_VEND_ID;	/* 0x106 and 0x107 */
-	char unknown4[4];		/* 0x108 to 0x10B */
-	unsigned char seconds;		/* 0x10C */
-	unsigned char minutes;		/* 0x10D */
-	unsigned char hour;		/* 0x10E */
-	unsigned char day;		/* 0x10F */
-	unsigned char month;		/* 0x110 */
-	unsigned char year;		/* 0x111 */
-	unsigned short raid0_sectors_per_stride; /* 0x112 */
-	char unknown6[2];		/* 0x113 - 0x115 */
-	unsigned char disk_in_set;	/* 0x116 */
-	unsigned char raidlevel;	/* 0x117 */
-	unsigned char disks_in_set;	/* 0x118 */
-	char unknown7[0x12a - 0x118];   /* 0x118 - 0x12a */
-	unsigned char idechannel;	/* 0x12b */
-	char unknown8[0x13D-0x12B];	/* 0x12c - 0x13d */
-	unsigned short checksum1;	/* 0x13e and 0x13f */
-	char assumed_zeros[509-0x13f];
-	unsigned short checksum2;	/* 0x1FE and 0x1FF */
-} __attribute__((packed));



