Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTDRQFB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTDRQDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:03:48 -0400
Received: from verein.lst.de ([212.34.181.86]:13837 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263140AbTDRQBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:01:13 -0400
Date: Fri, 18 Apr 2003 18:13:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devfs (6/7) - cleanup partition handling interaction
Message-ID: <20030418181307.F363@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Always pass around the pathnames for the devfs entries / directories
instead of the devfs_handle_ts.  Cleanes up the code massivly.


diff -Nru a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/block/cpqarray.c	Fri Apr 18 15:58:55 2003
@@ -400,7 +400,6 @@
 			sprintf(disk->disk_name, "ida/c%dd%d", i, j);
 			disk->major = COMPAQ_SMART2_MAJOR + i;
 			disk->first_minor = j<<NWD_SHIFT;
-			disk->flags = GENHD_FL_DEVFS;
 			disk->fops = &ida_fops; 
 			if (!drv->nr_blks)
 				continue;
@@ -1678,10 +1677,9 @@
                 			return;
 
 				}
-				if (!disk->de) {
-					disk->de = devfs_mk_dir("ida/c%dd%d",
-							ctlr, log_unit);
-				}
+
+				sprintf(disk->devfs_name, "ida/c%dd%d", ctlr, log_unit);
+
 				info_p->phys_drives =
 				    sense_config_buf->ctlr_phys_drv;
 				info_p->drv_assign_map
diff -Nru a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
--- a/drivers/cdrom/sbpcd.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/cdrom/sbpcd.c	Fri Apr 18 15:58:55 2003
@@ -5645,7 +5645,6 @@
 int __init sbpcd_init(void)
 #endif
 {
-	char nbuff[16];
 	int i=0, j=0;
 	int addr[2]={1, CDROM_PORT};
 	int port_index;
@@ -5869,8 +5868,7 @@
 		disk->fops = &sbpcd_bdops;
 		strcpy(disk->disk_name, sbpcd_infop->name);
 		disk->flags = GENHD_FL_CD;
-		sprintf(nbuff, "sbp/c0t%d", p->drv_id);
-		disk->de = devfs_mk_dir(NULL, nbuff, NULL);
+		sprintf(disk->devfs_name, "sbp/c0t%d", p->drv_id);
 		p->disk = disk;
 		if (register_cdrom(sbpcd_infop))
 		{
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/ide/ide-cd.c	Fri Apr 18 15:58:55 2003
@@ -3366,7 +3366,7 @@
 	DRIVER(drive)->busy++;
 	g->minors = 1;
 	g->minor_shift = 0;
-	g->de = drive->de;
+	strcpy(g->devfs_name, drive->devfs_name);
 	g->driverfs_dev = &drive->gendev;
 	g->flags = GENHD_FL_CD;
 	if (ide_cdrom_setup(drive)) {
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/ide/ide-disk.c	Fri Apr 18 15:58:55 2003
@@ -1816,10 +1816,9 @@
 	DRIVER(drive)->busy--;
 	g->minors = 1 << PARTN_BITS;
 	g->minor_shift = PARTN_BITS;
-	g->de = drive->de;
+	strcpy(g->devfs_name, drive->devfs_name);
 	g->driverfs_dev = &drive->gendev;
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
-	g->flags |= GENHD_FL_DEVFS;
 	set_capacity(g, current_capacity(drive));
 	g->fops = &idedisk_ops;
 	add_disk(g);
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/ide/ide-floppy.c	Fri Apr 18 15:58:55 2003
@@ -2059,9 +2059,8 @@
 	g->minors = 1 << PARTN_BITS;
 	g->minor_shift = PARTN_BITS;
 	g->driverfs_dev = &drive->gendev;
-	g->de = drive->de;
+	strcpy(g->devfs_name, drive->devfs_name);
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
-	g->flags |= GENHD_FL_DEVFS;
 	g->fops = &idefloppy_ops;
 	add_disk(g);
 	return 0;
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/ide/ide-io.c	Fri Apr 18 15:58:55 2003
@@ -41,7 +41,6 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/completion.h>
 #include <linux/reboot.h>
 #include <linux/cdrom.h>
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/ide/ide-probe.c	Fri Apr 18 15:58:55 2003
@@ -1303,7 +1303,6 @@
 				(hwif->channel && hwif->mate) ?
 				hwif->mate->index : hwif->index,
 				hwif->channel, unit, drive->lun);
-			drive->de = devfs_mk_dir(drive->devfs_name);
 		}
 	}
 	blk_register_region(MKDEV(hwif->major, 0), MAX_DRIVES << PARTN_BITS,
diff -Nru a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
--- a/drivers/s390/block/dasd.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/s390/block/dasd.c	Fri Apr 18 15:58:55 2003
@@ -157,9 +157,10 @@
 
 #ifdef CONFIG_DEVFS_FS
 	/* Add a proc directory and the dasd device entry to devfs. */
- 	device->gdp->de = devfs_mk_dir("dasd/%04x",
+ 	sprintf(device->gdp->devfs_name, "dasd/%04x",
 		_ccw_device_get_device_number(device->cdev));
 #endif
+
 	if (device->ro_flag)
 		devfs_perm = S_IFBLK | S_IRUSR;
 	else
diff -Nru a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
--- a/drivers/s390/block/dasd_genhd.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/s390/block/dasd_genhd.c	Fri Apr 18 15:58:55 2003
@@ -137,7 +137,6 @@
 	gdp->major = mi->major;
 	gdp->first_minor = index << DASD_PARTN_BITS;
 	gdp->fops = &dasd_device_operations;
-	gdp->flags |= GENHD_FL_DEVFS;
 
 	/*
 	 * Set device name.
diff -Nru a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Fri Apr 18 15:58:55 2003
+++ b/drivers/scsi/scsi.h	Fri Apr 18 15:58:55 2003
@@ -16,7 +16,6 @@
 #define _SCSI_H
 
 #include <linux/config.h>	    /* for CONFIG_SCSI_LOGGING */
-#include <linux/devfs_fs_kernel.h>  /* some morons don't know struct pointers */
 #include <scsi/scsi.h>
 
 
@@ -589,7 +588,6 @@
 
 	void *hostdata;		/* available to low-level driver */
 	char devfs_name[256];	/* devfs junk */
-	devfs_handle_t de;	/* will go away soon */
 	char type;
 	char scsi_level;
 	unsigned char inquiry_len;	/* valid bytes in 'inquiry' */
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/scsi/scsi_scan.c	Fri Apr 18 15:58:55 2003
@@ -1247,7 +1247,6 @@
 	sprintf(sdev->devfs_name, "scsi/host%d/bus%d/target%d/lun%d",
 				sdev->host->host_no, sdev->channel,
 				sdev->id, sdev->lun);
-	sdev->de = devfs_mk_dir(sdev->devfs_name);
 
 	/*
 	 * End driverfs/devfs code.
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/scsi/sd.c	Fri Apr 18 15:58:55 2003
@@ -1327,7 +1327,6 @@
 	sdkp->disk = gd;
 	sdkp->index = index;
 
-	gd->de = sdp->de;
 	gd->major = sd_major(index >> 4);
 	gd->first_minor = (index & 15) << 4;
 	gd->minors = 16;
@@ -1340,10 +1339,12 @@
 		sprintf(gd->disk_name, "sd%c", 'a' + index % 26);
 	}
 
+	strcpy(gd->devfs_name, sdp->devfs_name);
+
 	sd_init_onedisk(sdkp, gd);
 
 	gd->driverfs_dev = &sdp->sdev_driverfs_dev;
-	gd->flags = GENHD_FL_DRIVERFS | GENHD_FL_DEVFS;
+	gd->flags = GENHD_FL_DRIVERFS;
 	if (sdp->removable)
 		gd->flags |= GENHD_FL_REMOVABLE;
 	gd->private_data = &sdkp->driver;
diff -Nru a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	Fri Apr 18 15:58:55 2003
+++ b/drivers/scsi/sr.c	Fri Apr 18 15:58:55 2003
@@ -569,7 +569,7 @@
 	get_capabilities(cd);
 	sr_vendor_init(cd);
 
-	disk->de = sdev->de;
+	strcpy(disk->devfs_name, sdev->devfs_name);
 	disk->driverfs_dev = &sdev->sdev_driverfs_dev;
 	register_cdrom(&cd->cdi);
 	set_capacity(disk, cd->capacity);
diff -Nru a/fs/devfs/util.c b/fs/devfs/util.c
--- a/fs/devfs/util.c	Fri Apr 18 15:58:55 2003
+++ b/fs/devfs/util.c	Fri Apr 18 15:58:55 2003
@@ -346,78 +346,71 @@
 static struct unique_numspace disc_numspace = UNIQUE_NUMBERSPACE_INITIALISER;
 static struct unique_numspace cdrom_numspace = UNIQUE_NUMBERSPACE_INITIALISER;
 
-void devfs_create_partitions(struct gendisk *dev)
+void devfs_create_partitions(struct gendisk *disk)
 {
-	int pos = 0;
-	devfs_handle_t dir;
-	char dirname[64], symlink[16];
-
-	if (dev->flags & GENHD_FL_DEVFS) {
-		dir = dev->de;
-		if (!dir)  /*  Aware driver wants to block disc management  */
-			return;
-		pos = devfs_generate_path(dir, dirname + 3, sizeof dirname-3);
-		if (pos < 0)
-			return;
-		strncpy(dirname + pos, "../", 3);
-	} else {
-		/*  Unaware driver: construct "real" directory  */
-		sprintf(dirname, "../%s/disc%d", dev->disk_name,
-			dev->first_minor >> dev->minor_shift);
-		dir = devfs_mk_dir(dirname + 3);
-		dev->de = dir;
-	}
-	dev->number = devfs_alloc_unique_number (&disc_numspace);
-	sprintf(symlink, "discs/disc%d", dev->number);
-	devfs_mk_symlink(symlink, dirname + pos);
-	dev->disk_de = devfs_register(dir, "disc", 0,
-			    dev->major, dev->first_minor,
-			    S_IFBLK | S_IRUSR | S_IWUSR, dev->fops, NULL);
+	char dirname[64], diskname[64], symlink[16];
+
+	if (!disk->devfs_name)
+		sprintf(disk->devfs_name, "%s/disc%d", disk->disk_name,
+				disk->first_minor >> disk->minor_shift);
+
+	devfs_mk_dir(disk->devfs_name);
+	disk->number = devfs_alloc_unique_number(&disc_numspace);
+
+	sprintf(diskname, "%s/disc", disk->devfs_name);
+	devfs_register(NULL, diskname, 0,
+			disk->major, disk->first_minor,
+			S_IFBLK | S_IRUSR | S_IWUSR,
+			disk->fops, NULL);
+
+	sprintf(symlink, "discs/disc%d", disk->number);
+	sprintf(dirname, "../%s", disk->devfs_name);
+	devfs_mk_symlink(symlink, dirname);
+
+}
+
+void devfs_create_cdrom(struct gendisk *disk)
+{
+	char dirname[64], cdname[64], symlink[16];
+
+	if (!disk->devfs_name)
+		strcat(disk->devfs_name, disk->disk_name);
+
+	devfs_mk_dir(disk->devfs_name);
+	disk->number = devfs_alloc_unique_number(&cdrom_numspace);
+
+	sprintf(cdname, "%s/cd", disk->devfs_name);
+	devfs_register(NULL, cdname, 0,
+			disk->major, disk->first_minor,
+			S_IFBLK | S_IRUGO | S_IWUGO,
+			disk->fops, NULL);
+
+	sprintf(symlink, "cdroms/cdrom%d", disk->number);
+	sprintf(dirname, "../%s", disk->devfs_name);
+	devfs_mk_symlink(symlink, dirname);
 }
 
-void devfs_create_cdrom(struct gendisk *dev)
+void devfs_register_partition(struct gendisk *dev, int part)
 {
-	char vname[23];
+	char devname[64];
 
-	dev->number = devfs_alloc_unique_number(&cdrom_numspace);
-	sprintf(vname, "cdroms/cdrom%d", dev->number);
-	if (dev->de) {
-		int pos;
-		char rname[64];
-
-		dev->disk_de = devfs_register(dev->de, "cd", DEVFS_FL_DEFAULT,
-				     dev->major, dev->first_minor,
-				     S_IFBLK | S_IRUGO | S_IWUGO,
-				     dev->fops, NULL);
-
-		pos = devfs_generate_path(dev->disk_de, rname+3, sizeof(rname)-3);
-		if (pos >= 0) {
-			strncpy(rname + pos, "../", 3);
-			devfs_mk_symlink(vname, rname + pos);
-		}
-	} else {
-		dev->disk_de = devfs_register (NULL, vname, DEVFS_FL_DEFAULT,
-				    dev->major, dev->first_minor,
-				    S_IFBLK | S_IRUGO | S_IWUGO,
-				    dev->fops, NULL);
-	}
+	sprintf(devname, "%s/part%d", dev->devfs_name, part);
+	devfs_register(NULL, devname, 0,
+			dev->major, dev->first_minor + part,
+			S_IFBLK | S_IRUSR | S_IWUSR,
+			dev->fops, NULL);
 }
 
-void devfs_remove_partitions(struct gendisk *dev)
+void devfs_remove_partitions(struct gendisk *disk)
 {
-	devfs_unregister(dev->disk_de);
-	dev->disk_de = NULL;
+	devfs_remove("discs/disc%d", disk->number);
+	devfs_remove(disk->devfs_name);
+	devfs_dealloc_unique_number(&disc_numspace, disk->number);
+}
 
-	if (dev->flags & GENHD_FL_CD) {
-		if (dev->de)
-			devfs_remove("cdroms/cdrom%d", dev->number);
-		devfs_dealloc_unique_number(&cdrom_numspace, dev->number);
-	} else {
-		devfs_remove("discs/disc%d", dev->number);
-		if (!(dev->flags & GENHD_FL_DEVFS)) {
-			devfs_unregister(dev->de);
-			dev->de = NULL;
-		}
-		devfs_dealloc_unique_number(&disc_numspace, dev->number);
-	}
+void devfs_remove_cdrom(struct gendisk *disk)
+{
+	devfs_remove("cdroms/cdrom%d", disk->number);
+	devfs_remove(disk->devfs_name);
+	devfs_dealloc_unique_number(&cdrom_numspace, disk->number);
 }
diff -Nru a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Fri Apr 18 15:58:55 2003
+++ b/fs/partitions/check.c	Fri Apr 18 15:58:55 2003
@@ -94,25 +94,26 @@
 
 char *disk_name(struct gendisk *hd, int part, char *buf)
 {
-	int pos;
 	if (!part) {
-		if (hd->disk_de) {
-			pos = devfs_generate_path(hd->disk_de, buf, 64);
-			if (pos >= 0)
-				return buf + pos;
-		}
-		sprintf(buf, "%s", hd->disk_name);
+#ifdef CONFIG_DEVFS_FS
+		if (hd->devfs_name)
+			sprintf(buf, "%s/%s", hd->devfs_name,
+				(hd->flags & GENHD_FL_CD) ? "cd" : "disc");
+		else
+#endif
+			sprintf(buf, "%s", hd->disk_name);
 	} else {
-		if (hd->part[part-1].de) {
-			pos = devfs_generate_path(hd->part[part-1].de, buf, 64);
-			if (pos >= 0)
-				return buf + pos;
-		}
-		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1]))
+#ifdef CONFIG_DEVFS_FS
+		if (hd->devfs_name)
+			sprintf(buf, "%s/part%d", hd->devfs_name, part);
+		else
+#endif
+		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1]))
 			sprintf(buf, "%sp%d", hd->disk_name, part);
 		else
 			sprintf(buf, "%s%d", hd->disk_name, part);
 	}
+
 	return buf;
 }
 
@@ -120,19 +116,17 @@
 check_partition(struct gendisk *hd, struct block_device *bdev)
 {
 	struct parsed_partitions *state;
-	devfs_handle_t de = NULL;
-	char buf[64];
 	int i, res;
 
 	state = kmalloc(sizeof(struct parsed_partitions), GFP_KERNEL);
 	if (!state)
 		return NULL;
 
-	if (hd->flags & GENHD_FL_DEVFS)
-		de = hd->de;
-	i = devfs_generate_path (de, buf, sizeof buf);
-	if (i >= 0) {
-		printk(KERN_INFO " /dev/%s:", buf + i);
+#ifdef CONFIG_DEVFS_FS
+	if (hd->devfs_name) {
+		printk(KERN_INFO " /dev/%s:", hd->devfs_name);
 		sprintf(state->name, "p");
-	} else {
+	}
+#endif
+	else {
 		disk_name(hd, 0, state->name);
@@ -156,26 +147,6 @@
 	return NULL;
 }
 
-static void devfs_register_partition(struct gendisk *dev, int part)
-{
-#ifdef CONFIG_DEVFS_FS
-	devfs_handle_t dir;
-	struct hd_struct *p = dev->part;
-	char devname[16];
-
-	if (p[part-1].de)
-		return;
-	dir = dev->de;
-	if (!dir)
-		return;
-	sprintf(devname, "part%d", part);
-	p[part-1].de = devfs_register (dir, devname, 0,
-				    dev->major, dev->first_minor + part,
-				    S_IFBLK | S_IRUSR | S_IWUSR,
-				    dev->fops, NULL);
-#endif
-}
-
 /*
  * sysfs bindings for partitions
  */
@@ -261,8 +232,7 @@
 	p->start_sect = 0;
 	p->nr_sects = 0;
 	p->reads = p->writes = p->read_sectors = p->write_sectors = 0;
-	devfs_unregister(p->de);
-	p->de = NULL;
+	devfs_remove("%s/part%d", disk->devfs_name, part);
 	kobject_unregister(&p->kobj);
 }
 
@@ -414,7 +384,10 @@
 	unlink_gendisk(disk);
 	disk_stat_set_all(disk, 0);
 	disk->stamp = disk->stamp_idle = 0;
-	devfs_remove_partitions(disk);
+	if (disk->flags & GENHD_FL_CD)
+		devfs_remove_cdrom(disk);
+	else
+		devfs_remove_partitions(disk);
 	if (disk->driverfs_dev) {
 		sysfs_remove_link(&disk->kobj, "device");
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
diff -Nru a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h	Fri Apr 18 15:58:55 2003
+++ b/include/linux/devfs_fs_kernel.h	Fri Apr 18 15:58:55 2003
@@ -37,7 +37,9 @@
 extern void devfs_create_partitions(struct gendisk *dev);
 extern void devfs_create_cdrom(struct gendisk *dev);
 extern void devfs_remove_partitions(struct gendisk *dev);
-extern void mount_devfs_fs (void);
+extern void devfs_remove_cdrom(struct gendisk *dev);
+extern void devfs_register_partition(struct gendisk *dev, int part);
+extern void mount_devfs_fs(void);
 #else  /*  CONFIG_DEVFS_FS  */
 static inline devfs_handle_t devfs_register (devfs_handle_t dir,
 					     const char *name,
@@ -83,6 +85,12 @@
 {
 }
 static inline void devfs_remove_partitions(struct gendisk *dev)
+{
+}
+static inline void devfs_remove_cdrom(struct gendisk *dev)
+{
+}
+static inline void devfs_register_partition(struct gendisk *dev, int part)
 {
 }
 static inline void mount_devfs_fs (void)
diff -Nru a/include/linux/genhd.h b/include/linux/genhd.h
--- a/include/linux/genhd.h	Fri Apr 18 15:58:55 2003
+++ b/include/linux/genhd.h	Fri Apr 18 15:58:55 2003
@@ -55,12 +55,13 @@
 } __attribute__((packed));
 
 #ifdef __KERNEL__
-#  include <linux/devfs_fs_kernel.h>
-
+#include <linux/devfs_fs_kernel.h>	/* we don't need any devfs crap
+					   here, but some of the implicitly
+					   included headers.   will clean
+					   this mess up later.	--hch */
 struct hd_struct {
 	sector_t start_sect;
 	sector_t nr_sects;
-	devfs_handle_t de;              /* primary (master) devfs entry  */
 	struct kobject kobj;
 	unsigned reads, read_sectors, writes, write_sectors;
 	int policy;
@@ -68,7 +69,6 @@
 
 #define GENHD_FL_REMOVABLE  1
 #define GENHD_FL_DRIVERFS  2
-#define GENHD_FL_DEVFS	4
 #define GENHD_FL_CD	8
 #define GENHD_FL_UP	16
 
@@ -96,9 +96,8 @@
 	sector_t capacity;
 
 	int flags;
-	int number;			/* devfs crap */
-	devfs_handle_t de;		/* more of the same */
-	devfs_handle_t disk_de;		/* piled higher and deeper */
+	char devfs_name[64];		/* devfs crap */
+	int number;			/* more of the same */
 	struct device *driverfs_dev;
 	struct kobject kobj;
 
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Fri Apr 18 15:58:55 2003
+++ b/include/linux/ide.h	Fri Apr 18 15:58:55 2003
@@ -13,7 +13,6 @@
 #include <linux/hdsmart.h>
 #include <linux/blkdev.h>
 #include <linux/proc_fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <linux/bio.h>
@@ -700,7 +699,6 @@
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
 	struct ide_settings_s *settings;/* /proc/ide/ drive settings */
 	char		devfs_name[64];	/* devfs crap */
-	devfs_handle_t		de;	/* will go away soon */
 
 	struct hwif_s		*hwif;	/* actually (ide_hwif_t *) */
 
