Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbUK2Kqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbUK2Kqx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUK2Kqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:46:53 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:12945 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261653AbUK2KkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:40:12 -0500
Date: Mon, 29 Nov 2004 19:41:45 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [ANNOUNCE 3/7] Diskdump 1.0 Release
In-reply-to: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
To: linux-kernel@vger.kernel.org, lkdump-develop@lists.sourceforge.net
Message-id: <3DC4D60005C89Bindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.71
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for ide-dump.


diff -Nur linux-2.6.9.org/drivers/ide/Kconfig linux-2.6.9/drivers/ide/Kconfig
--- linux-2.6.9.org/drivers/ide/Kconfig	2004-10-19 06:54:07.000000000 +0900
+++ linux-2.6.9/drivers/ide/Kconfig	2004-11-26 18:54:54.586808980 +0900
@@ -263,6 +263,12 @@
 	  If both this SCSI emulation and native ATAPI support are compiled
 	  into the kernel, the native support will be used.
 
+config BLK_DEV_IDEDUMP
+	tristate "Include IDE disk dump support"
+	depends on DISKDUMP && BLK_DEV_IDE && MODULES && m
+	help
+	  Include IDE disk dump support
+
 config IDE_TASK_IOCTL
 	bool "IDE Taskfile Access"
 	help
diff -Nur linux-2.6.9.org/drivers/ide/Makefile linux-2.6.9/drivers/ide/Makefile
--- linux-2.6.9.org/drivers/ide/Makefile	2004-10-19 06:54:08.000000000 +0900
+++ linux-2.6.9/drivers/ide/Makefile	2004-11-26 18:54:54.587785543 +0900
@@ -49,6 +49,7 @@
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+= ide-floppy.o
+obj-$(CONFIG_BLK_DEV_IDEDUMP)		+= ide-dump.o
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ arm/
 obj-$(CONFIG_BLK_DEV_HD)		+= legacy/
diff -Nur linux-2.6.9.org/drivers/ide/ide-dump.c linux-2.6.9/drivers/ide/ide-dump.c
--- linux-2.6.9.org/drivers/ide/ide-dump.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.9/drivers/ide/ide-dump.c	2004-11-26 18:55:57.030167590 +0900
@@ -0,0 +1,421 @@
+/*
+ *  linux/drivers/ide/ide_dump.c
+ *
+ *  Copyright (C) 2004  FUJITSU LIMITED
+ *  Written by Nobuhiro Tachino (ntachino@jp.fujitsu.com)
+ *
+ */
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/ide.h>
+#include <linux/crc32.h>
+#include <linux/diskdump.h>
+
+#define Dbg(x, ...)	pr_debug("ide_dump: " x "\n", ## __VA_ARGS__)
+#define Err(x, ...)	pr_err  ("ide_dump: " x "\n", ## __VA_ARGS__)
+#define Warn(x, ...)	pr_warn ("ide_dump: " x "\n", ## __VA_ARGS__)
+#define Info(x, ...)	pr_info ("ide_dump: " x "\n", ## __VA_ARGS__)
+
+#define DriveErr(drv, x, ...)						\
+	printk(KERN_ERR "ide_dump: %s" x "status %x error %x\n",	\
+	(drv)->name, ## __VA_ARGS__,					\
+	HWIF(drv)->INB(IDE_STATUS_REG), HWIF(drv)->INB(IDE_ERROR_REG));
+
+
+#define IDE_DUMP_MAX_BLOCKS	(256 >> (DUMP_BLOCK_SHIFT - 9))
+
+/* module parameters */
+static unsigned int no_io_32bit	= 0;
+static int pio_mode		= -1;
+
+static int quiesce_ok	= 0;
+static uint32_t module_crc;
+
+#define IDE_DUMP_TIMEOUT	30000000
+
+static int ide_dump_wait(ide_drive_t *drive, u8 good, u8 bad)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	u8 stat;
+	int i;
+ 
+	udelay(1);	/* spec allows drive 400ns to assert "BUSY" */
+	if ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT)
+		while ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT);
+
+	/*
+	 * Allow status to settle, then read it again.
+	 * A few rare drives vastly violate the 400ns spec here,
+	 * so we'll wait up to 10usec for a "good" status
+	 * rather than expensively fail things immediately.
+	 * This fix courtesy of Matthew Faupel & Niccolo Rigacci.
+	 */
+	for (i = 0; i < IDE_DUMP_TIMEOUT; i++) {
+		udelay(1);
+		if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), good, bad))
+			return 0;
+	}
+	return -EIO;
+}
+
+static void pre_reset(ide_drive_t *drive)
+{
+	DRIVER(drive)->pre_reset(drive);
+
+	if (HWIF(drive)->pre_reset != NULL)
+		HWIF(drive)->pre_reset(drive);
+}
+
+static int ide_dump_reset(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	u8 tmp;
+	unsigned int unit;
+	
+	/*
+	 * First, reset any device state data we were maintaining
+	 * for any of the drives on this interface.
+	 */
+	for (unit = 0; unit < MAX_DRIVES; ++unit)
+		pre_reset(&hwif->drives[unit]);
+
+#if OK_TO_RESET_CONTROLLER
+	if (!IDE_CONTROL_REG)
+		return 0;
+
+	/* set SRST and nIEN */
+	hwif->OUTBSYNC(drive, drive->ctl|4,IDE_CONTROL_REG);
+	/* more than enough time */
+	udelay(10);
+	/* clear SRST, leave nIEN */
+	hwif->OUTBSYNC(drive, drive->ctl|2, IDE_CONTROL_REG);
+	/* more than enough time */
+	udelay(10);
+	
+	while (!OK_STAT(tmp = hwif->INB(IDE_STATUS_REG), 0, BUSY_STAT))
+		mdelay(1);
+
+	if ((tmp = hwif->INB(IDE_ERROR_REG)) != 1) {
+		Err("reset failed %x", tmp);
+		return -EIO;
+	}
+#endif	/* OK_TO_RESET_CONTROLLER */
+	return 0;
+}
+
+/*
+ * Check whether the dump device is sane enough to handle I/O.
+ *
+ * Return value:
+ * 	0:	the device is ok
+ * 	< 0:	the device is not ok
+ * 	> 0:	Cannot determine
+ */
+static int
+ide_dump_sanity_check(struct disk_dump_device *dump_device)
+{
+	ide_drive_t *drive = dump_device->device;
+
+	if (!check_crc_module()) {
+		Err("checksum error. ide dump module may be compromised.");
+		return -EINVAL;
+	}
+
+	if (drive->suspend_reset || drive->sleep) {
+		Err("%s: bad state", drive->name);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int issue_simple_cmd(ide_drive_t *drive, u8 cmd, u8 feature, u8 nsector)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	select_t select;
+
+	select.all = 0;
+	select.b.unit = drive->select.b.unit;
+
+	hwif->OUTB(feature,	IDE_FEATURE_REG);
+	hwif->OUTB(nsector,	IDE_NSECTOR_REG);
+	hwif->OUTB(0x00,	IDE_SECTOR_REG);
+	hwif->OUTB(0x00,	IDE_LCYL_REG);
+	hwif->OUTB(0x00,	IDE_HCYL_REG);
+	hwif->OUTB(select.all,	IDE_SELECT_REG);
+	hwif->OUTB(cmd,		IDE_COMMAND_REG);
+
+	if (ide_dump_wait(drive, 0, ERR_STAT) < 0) {
+		DriveErr(drive, "Cmd %x failed", cmd);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int set_pio_mode(ide_drive_t *drive, int pio_mode)
+{
+	pio_mode |= 0x08 /* Flow Control bit*/;
+
+	issue_simple_cmd(drive, WIN_SETFEATURES, SETFEATURES_XFER, pio_mode);
+
+	return 0;
+}
+
+static int set_multiple(ide_drive_t *drive, int mult_count)
+{
+	if (issue_simple_cmd(drive, WIN_SETMULT, 0, mult_count) < 0)
+		drive->mult_count = 0;
+	else
+		drive->mult_count = mult_count;
+
+	return 0;
+}
+
+static int
+ide_dump_quiesce(struct disk_dump_device *dump_device)
+{
+	ide_drive_t *drive = dump_device->device;
+	int ret;
+
+	ret = ide_dump_reset(drive);
+	if (ret < 0)
+		return 0;
+
+	/* use PIO mode */
+	if (pio_mode >= 0)
+		set_pio_mode(drive, pio_mode);
+	set_multiple(drive, drive->id->max_multsect);
+
+	if (!no_io_32bit && !drive->no_io_32bit)
+		drive->io_32bit = 3;
+
+	quiesce_ok = 1;
+	return 0;
+}
+
+static int ide_dump_do_rw_disk(ide_drive_t *drive, unsigned long sector, unsigned long nr_sectors, int rw, void *buf)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	task_ioreg_t command;
+	ata_nsector_t nsectors;
+	unsigned long nsect, msect;
+	
+	if (drive->mult_count == 0)
+		msect = 1;
+	else
+		msect = drive->mult_count;
+
+	nsectors.all = (u16)nr_sectors;
+
+	if (lba48) {
+		task_ioreg_t tasklets[10];
+
+		tasklets[0] = 0;
+		tasklets[1] = 0;
+		tasklets[2] = nsectors.b.low;
+		tasklets[3] = nsectors.b.high;
+		tasklets[4] = (task_ioreg_t) sector;
+		tasklets[5] = (task_ioreg_t) (sector>>8);
+		tasklets[6] = (task_ioreg_t) (sector>>16);
+		tasklets[7] = (task_ioreg_t) (sector>>24);
+		tasklets[8] = (task_ioreg_t) 0;
+		tasklets[9] = (task_ioreg_t) 0;
+
+		hwif->OUTB(tasklets[1], IDE_FEATURE_REG);
+		hwif->OUTB(tasklets[3], IDE_NSECTOR_REG);
+		hwif->OUTB(tasklets[7], IDE_SECTOR_REG);
+		hwif->OUTB(tasklets[8], IDE_LCYL_REG);
+		hwif->OUTB(tasklets[9], IDE_HCYL_REG);
+
+		hwif->OUTB(tasklets[0], IDE_FEATURE_REG);
+		hwif->OUTB(tasklets[2], IDE_NSECTOR_REG);
+		hwif->OUTB(tasklets[4], IDE_SECTOR_REG);
+		hwif->OUTB(tasklets[5], IDE_LCYL_REG);
+		hwif->OUTB(tasklets[6], IDE_HCYL_REG);
+		hwif->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
+	} else {
+		hwif->OUTB(0x00, IDE_FEATURE_REG);
+		hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
+		hwif->OUTB(sector, IDE_SECTOR_REG);
+		hwif->OUTB(sector>>=8, IDE_LCYL_REG);
+		hwif->OUTB(sector>>=8, IDE_HCYL_REG);
+		hwif->OUTB(((sector>>8)&0x0f)|drive->select.all,IDE_SELECT_REG);
+	}
+
+	if (rw == READ)
+		command = lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
+	else
+		command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
+
+	hwif->OUTB(command, IDE_COMMAND_REG);
+
+	while (nr_sectors > 0) {
+		if (ide_dump_wait(drive, DRQ_STAT, ERR_STAT) < 0) {
+			DriveErr(drive, "no DRQ after issueing command");
+			return -EIO;
+		}
+
+		nsect = min(nr_sectors, msect);
+
+		if (rw == READ)
+			taskfile_input_data(drive, buf, nsect << 7);
+		else
+			taskfile_output_data(drive, buf, nsect << 7);
+
+		nr_sectors -= nsect;
+		buf += (nsect << 9);
+	}
+
+	return 0;
+}
+
+/* blocks to 512byte sectors */
+#define BLOCK_SECTOR(s)	((s) << (DUMP_BLOCK_SHIFT - 9))
+
+static int ide_dump_rw_block(struct disk_dump_partition *dump_part, int rw, unsigned long block, void *buf, int nr_blocks)
+{
+	ide_drive_t *drive	= dump_part->device->device;
+	unsigned long sector, nr_sectors;
+
+	sector     = BLOCK_SECTOR(block);
+	nr_sectors = BLOCK_SECTOR(nr_blocks);
+
+	sector += dump_part->start_sect + drive->sect0;
+	if ((nr_sectors > dump_part->nr_sects)) {
+		dev_t dev = dump_part->bdev->bd_dev;
+		Err("%s%c: bad access: block=%ld, count=%ld",
+			drive->name, (MINOR(dev)) ?'0'+ MINOR(dev) :' ',
+			block, nr_sectors);
+			return -EIO;
+	}
+
+	/* Yecch - this will shift the entire interval,
+	   possibly killing some innocent following sector */
+	if (block == 0 && drive->remap_0_to_1 == 1)
+		block = 1;  /* redirect MBR access to EZ-Drive partn table */
+
+	SELECT_DRIVE(drive);
+
+	if (ide_dump_wait(drive, drive->ready_stat, BUSY_STAT|DRQ_STAT)) {
+		DriveErr(drive, "no DRQ after selecting drive");
+		return -EIO;
+	}
+
+	return ide_dump_do_rw_disk(drive, sector, nr_sectors, rw, buf);
+}
+
+static int ide_dump_shutdown(struct disk_dump_device *dump_device)
+{
+	ide_drive_t *drive	= dump_device->device;
+	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
+	task_ioreg_t command;
+
+	if (drive->id->cfs_enable_2 & 0x2400 && lba48)
+		command = WIN_FLUSH_CACHE_EXT;
+	else
+		command = WIN_FLUSH_CACHE;
+
+	issue_simple_cmd(drive, command, 0, 0);
+
+	return 0;
+}
+
+static void *ide_dump_probe(struct device *dev)
+{
+	ide_drive_t *drive;
+
+	if ((dev->bus == NULL) || (dev->bus->name == NULL) ||
+	    strncmp(dev->bus->name, "ide", 3))
+		return NULL;
+
+	drive = dev->driver_data;
+	if (drive == NULL)
+		return NULL;
+	if (drive->media != ide_disk) {
+		Err("not a IDE disk");
+		return NULL;
+	}
+	if (!drive->select.b.lba) {
+		Err("IDE disk does not support LBA access");
+		return NULL;
+	}
+
+	return drive;
+}
+
+
+struct disk_dump_device_ops ide_dump_device_ops = {
+	.sanity_check	= ide_dump_sanity_check,
+	.rw_block	= ide_dump_rw_block,
+	.quiesce	= ide_dump_quiesce,
+	.shutdown	= ide_dump_shutdown,
+};
+
+static int ide_dump_add_device(struct disk_dump_device *dump_device)
+{
+	memcpy(&dump_device->ops, &ide_dump_device_ops,
+						sizeof(ide_dump_device_ops));
+	dump_device->max_blocks = IDE_DUMP_MAX_BLOCKS;
+	set_crc_modules();
+	return 0;
+}
+
+static void ide_dump_remove_device(struct disk_dump_device *dump_device)
+{
+}
+
+static struct disk_dump_type ide_dump_type = {
+	.probe		= ide_dump_probe,
+	.add_device	= ide_dump_add_device,
+	.remove_device	= ide_dump_remove_device,
+	.owner		= THIS_MODULE,
+};
+
+static int init_ide_dump(void)
+{
+	int ret;
+
+	if ((ret = register_disk_dump_type(&ide_dump_type)) < 0) {
+		Err("register failed");
+		return ret;
+	}
+	set_crc_modules();
+	return ret;
+}
+
+static void cleanup_ide_dump(void)
+{
+	if (unregister_disk_dump_type(&ide_dump_type) < 0)
+		Err("register failed");
+}
+
+module_init(init_ide_dump);
+module_exit(cleanup_ide_dump);
+
+MODULE_AUTHOR("Nobuhiro Tachino <tachino@jp.fujitsu.com>");
+MODULE_DESCRIPTION("IDE diskdump driver");
+MODULE_LICENSE("GPL");
+MODULE_PARM(no_io_32bit, "i");
+MODULE_PARM(pio_mode, "i");
+MODULE_PARM_DESC(no_io_32bit, "Inhibit 32bit transfer for PIO mode (1)");
+MODULE_PARM_DESC(pio_mode, "use PIO mode (0-4)");
diff -Nur linux-2.6.9.org/drivers/ide/ide.c linux-2.6.9/drivers/ide/ide.c
--- linux-2.6.9.org/drivers/ide/ide.c	2004-10-19 06:53:45.000000000 +0900
+++ linux-2.6.9/drivers/ide/ide.c	2004-11-26 18:54:54.589738668 +0900
@@ -159,6 +159,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/bitops.h>
+#include <linux/diskdump.h>
 
 
 /* default maximum number of failures */
@@ -190,6 +191,28 @@
 EXPORT_SYMBOL(noautodma);
 
 /*
+ * IDE sysfs interface routines
+ */
+static DEVICE_ATTR(dump, S_IRUGO | S_IWUSR, diskdump_sysfs_show, diskdump_sysfs_store);
+
+/* device attributes */
+static struct device_attribute *ide_sysfs_attrs[] = {
+	&dev_attr_dump,
+	NULL
+};
+
+static int ide_attr_add(ide_drive_t *drive)
+{
+	int i, error = 0;
+	for (i = 0; ide_sysfs_attrs[i]; i++) {
+		error = device_create_file(&drive->gendev, ide_sysfs_attrs[i]);
+		if (error)
+			break;
+	}
+	return error;
+}
+
+/*
  * This is declared extern in ide.h, for access by other IDE modules:
  */
 ide_hwif_t ide_hwifs[MAX_HWIFS];	/* master data repository */
@@ -2363,8 +2386,10 @@
 	list_for_each_safe(list_loop, tmp_storage, &list) {
 		ide_drive_t *drive = container_of(list_loop, ide_drive_t, list);
 		list_del_init(&drive->list);
-		if (drive->present)
+		if (drive->present) {
 			ata_attach(drive);
+			ide_attr_add(drive);
+		}
 	}
 	driver->gen_driver.name = (char *) driver->name;
 	driver->gen_driver.bus = &ide_bus_type;
