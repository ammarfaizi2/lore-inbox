Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262641AbSJIXls>; Wed, 9 Oct 2002 19:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbSJIXls>; Wed, 9 Oct 2002 19:41:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19378 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262641AbSJIXld>;
	Wed, 9 Oct 2002 19:41:33 -0400
Date: Wed, 9 Oct 2002 16:49:14 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.GSO.4.21.0210091550150.8980-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210091612140.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Notice that for partitions (and even more so for superblocks) we are talking
> about _way_ more than "if it's busy, it can't be removed".  Unlike PCI and
> friends, here we have non-trivial locking and driverfs accesses changing
> refcount would need to play nice with that.

Noted. The refcounting concerning driverfs file I/O doesn't work exactly
the way I want it to, and as you've pointed out, can be racy. I think I
know a way to fix it, and streamline the object access, so it should
become easier to add support for new object types in driverfs.

> Sigh...  Screw it.  Tell me what directory tree you want for block
> device and I'll do that, ugly or not ;-/  I really don't like the
> direction it's going, but it's your tree and since it hadn't reached
> my fork threshold yet...

The patch below is a start to implementing a little of what both Linus and 
I want. It replaces the struct device for partitions with just a driverfs 
directory. For now, it kills the attributes, though. There must be 
wrappers for each object type to create and remove attributes, as well as 
ops to read and write from them. I plan on adding those, but not until I 
clean up some of the per-object stuff. 

This has been tested on IDE only, as the driver for my SCSI controller 
(qla1280.o) has stopped working...

	-pat

Please pull from 

	bk://ldm.bkbits.net/linux-2.5-disk

This will update the following files:

 drivers/ide/ide-probe.c |    1 
 drivers/scsi/sd.c       |    2 -
 fs/partitions/check.c   |   90 +++++++++++-------------------------------------
 include/linux/genhd.h   |    3 -
 4 files changed, 25 insertions(+), 71 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (02/10/09 1.714.4.7)
   driver model: replace devices allocated for partitions with just driverfs directories
   
   Partitions are not devices and shouldn't be treated as such. But consensus
   says that they should be represented somehow in driverfs. 
   
   This is a first step in doing so. It stops treating them like devices, and 
   adds just a driverfs directory for them. The attribute files don't show
   up for them anymore, but that should be only temporary (until wrappers
   are created to do so for partitions).
   
   This also removes struct hd_struct::hd_driverfs_dev and struct 
   gendisk::driverfs_dev. 

<mochel@osdl.org> (02/10/09 1.714.4.6)
   SCSI: don't use struct gendisk::dirverfs_dev pointer. 
   
   They appear to be pointing to the disk that they've just found. But, we 
   can just use struct gendisk::parent to do the same thing, and have a 
   cleaner result.

<mochel@osdl.org> (02/10/09 1.714.4.5)
   IDE: Make sure we set the part for struct gendisk::disk_dev when we initialize it. 
   
   It doesn't seem like we should even have this struct device, as its only
   purpose is to add a layer of separation between the disk device and the 
   partitions. But, it can't be removed yet...

===== drivers/ide/ide-probe.c 1.20 vs edited =====
--- 1.20/drivers/ide/ide-probe.c	Wed Oct  9 10:29:29 2002
+++ edited/drivers/ide/ide-probe.c	Wed Oct  9 15:36:12 2002
@@ -998,6 +998,7 @@
 		sprintf(disk->disk_name,"hd%c",'a'+hwif->index*MAX_DRIVES+unit);
 		disk->minor_shift = PARTN_BITS; 
 		disk->fops = ide_fops;
+		disk->disk_dev.parent = &hwif->drives[unit].gendev;
 		hwif->drives[unit].disk = disk;
 	}
 
===== drivers/scsi/sd.c 1.65 vs edited =====
--- 1.65/drivers/scsi/sd.c	Wed Oct  9 02:09:33 2002
+++ edited/drivers/scsi/sd.c	Wed Oct  9 16:05:25 2002
@@ -1430,7 +1430,7 @@
 	else
 		sprintf(gd->disk_name, "sd%c",'a'+dsk_nr%26);
         gd->flags = sdp->removable ? GENHD_FL_REMOVABLE : 0;
-        gd->driverfs_dev = &sdp->sdev_driverfs_dev;
+	gd->disk_dev.parent = &sdp->sdev_driverfs_dev;
         gd->flags |= GENHD_FL_DRIVERFS | GENHD_FL_DEVFS;
 	sd_disks[dsk_nr] = gd;
 	printk(KERN_NOTICE "Attached scsi %sdisk %s at scsi%d, channel %d, "
===== fs/partitions/check.c 1.65 vs edited =====
--- 1.65/fs/partitions/check.c	Tue Oct  8 11:36:39 2002
+++ edited/fs/partitions/check.c	Wed Oct  9 15:47:12 2002
@@ -132,80 +132,44 @@
 {
 	int max_p = 1<<hd->minor_shift;
 	struct hd_struct *p = hd->part;
-	char name[DEVICE_NAME_SIZE];
-	char bus_id[BUS_ID_SIZE];
-	struct device *dev, *parent;
+	struct device *dev;
 	int part;
 
-	/* if driverfs not supported by subsystem, skip partitions */
-	if (!(hd->flags & GENHD_FL_DRIVERFS))
-		return;
-
-	parent = hd->driverfs_dev;
-
-	if (parent)  {
-		sprintf(name, "%s", parent->name);
-		sprintf(bus_id, "%s:", parent->bus_id);
-	} else {
-		*name = *bus_id = '\0';
-	}
-
 	dev = &hd->disk_dev;
 	dev->driver_data = (void *)(long)__mkdev(hd->major, hd->first_minor);
-	sprintf(dev->name, "%sdisc", name);
-	sprintf(dev->bus_id, "%sdisc", bus_id);
-	for (part=1; part < max_p; part++) {
-		dev = &p[part-1].hd_driverfs_dev;
-		sprintf(dev->name, "%spart%d", name, part);
-		sprintf(dev->bus_id, "%s:p%d", bus_id, part);
-		if (!p[part-1].nr_sects)
-			continue;
-		dev->driver_data =
-				(void *)(long)__mkdev(hd->major, hd->first_minor+part);
-	}
-
-	dev = &hd->disk_dev;
-	dev->parent = parent;
-	if (parent)
-		dev->bus = parent->bus;
+	sprintf(dev->name, "disk");
+	sprintf(dev->bus_id, "disk");
 	device_register(dev);
 	device_create_file(dev, &dev_attr_type);
 	device_create_file(dev, &dev_attr_kdev);
 
-	for (part=0; part < max_p-1; part++) {
-		dev = &p[part].hd_driverfs_dev;
-		dev->parent = parent;
-		if (parent)
-			dev->bus = parent->bus;
-		if (!dev->driver_data)
+	for (part=1; part < max_p; part++) {
+		struct driver_dir_entry * dir = &p[part-1].dir;
+		dir->name = kmalloc(BUS_ID_SIZE,GFP_KERNEL);
+		if (!dir->name)
 			continue;
-		device_register(dev);
-		device_create_file(dev, &dev_attr_type);
-		device_create_file(dev, &dev_attr_kdev);
+		snprintf(dir->name,BUS_ID_SIZE,"partition%d",part);
+		dir->mode = (S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO);
+		if (p[part-1].nr_sects)
+			driverfs_create_dir(dir,&dev->dir);
 	}
 }
 
 static void driverfs_remove_partitions(struct gendisk *hd)
 {
 	int max_p = 1<<hd->minor_shift;
-	struct device *dev;
+	struct device *dev = &hd->disk_dev;
 	struct hd_struct *p;
 	int part;
 
 	for (part=1, p = hd->part; part < max_p; part++, p++) {
-		dev = &p->hd_driverfs_dev;
-		if (dev->driver_data) {
-			device_remove_file(dev, &dev_attr_type);
-			device_remove_file(dev, &dev_attr_kdev);
-			put_device(dev);	
-			dev->driver_data = NULL;
-		}
+		driverfs_remove_dir(&p->dir);
 	}
-	dev = &hd->disk_dev;
+
 	if (dev->driver_data) {
 		device_remove_file(dev, &dev_attr_type);
 		device_remove_file(dev, &dev_attr_kdev);
-		put_device(dev);	
+		device_unregister(dev);
 		dev->driver_data = NULL;
 	}
 }
@@ -400,6 +364,8 @@
 	if (disk->flags & GENHD_FL_CD)
 		devfs_create_cdrom(disk);
 
+	printk("registering disk %s\n",disk->disk_name);
+
 	/* No minors to use for partitions */
 	if (!disk->minor_shift)
 		return;
@@ -420,30 +386,18 @@
 void update_partition(struct gendisk *disk, int part)
 {
 	struct hd_struct *p = disk->part + part - 1;
-	struct device *dev = &p->hd_driverfs_dev;
 
 	if (!p->nr_sects) {
 		if (p->de) {
 			devfs_unregister(p->de);
 			p->de = NULL;
 		}
-		if (dev->driver_data) {
-			device_remove_file(dev, &dev_attr_type);
-			device_remove_file(dev, &dev_attr_kdev);
-			put_device(dev);	
-			dev->driver_data = NULL;
-		}
-		return;
+		driverfs_remove_dir(&p->dir);
+	} else {
+		if (!p->de)
+			devfs_register_partition(disk, part);
+		driverfs_create_dir(&p->dir,&disk->disk_dev.dir);
 	}
-	if (!p->de)
-		devfs_register_partition(disk, part);
-	if (dev->driver_data || !(disk->flags & GENHD_FL_DRIVERFS))
-		return;
-	dev->driver_data =
-		(void *)(long)__mkdev(disk->major, disk->first_minor+part);
-	device_register(dev);
-	device_create_file(dev, &dev_attr_type);
-	device_create_file(dev, &dev_attr_kdev);
 }
 
 int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
===== include/linux/genhd.h 1.31 vs edited =====
--- 1.31/include/linux/genhd.h	Tue Oct  8 11:36:39 2002
+++ edited/include/linux/genhd.h	Wed Oct  9 15:49:50 2002
@@ -61,8 +61,8 @@
 struct hd_struct {
 	sector_t start_sect;
 	sector_t nr_sects;
+	struct driver_dir_entry dir;	/* driverfs support */
 	devfs_handle_t de;              /* primary (master) devfs entry  */
-	struct device hd_driverfs_dev;  /* support driverfs hiearchy     */
 };
 
 #define GENHD_FL_REMOVABLE  1
@@ -86,7 +86,6 @@
 	int number;			/* devfs crap */
 	devfs_handle_t de;		/* more of the same */
 	devfs_handle_t disk_de;		/* piled higher and deeper */
-	struct device *driverfs_dev;
 	struct device disk_dev;
 };
 

