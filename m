Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261884AbSJIQad>; Wed, 9 Oct 2002 12:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261890AbSJIQad>; Wed, 9 Oct 2002 12:30:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:11694 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261884AbSJIQaa>;
	Wed, 9 Oct 2002 12:30:30 -0400
Date: Wed, 9 Oct 2002 09:38:05 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Alexander Viro <viro@math.psu.edu>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.GSO.4.21.0210082102440.5897-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210090929220.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> > --- a/drivers/ide/ide-disk.c	Tue Oct  8 17:55:17 2002
> > +++ b/drivers/ide/ide-disk.c	Tue Oct  8 17:55:17 2002
> > @@ -1692,7 +1692,7 @@
> >  {
> >  	struct gendisk *g = drive->disk;
> >  
> > -	put_device(&drive->disk->disk_dev);
> > +	device_unregister(&drive->disk->disk_dev);
> 
> 
> While you are at it, _please_, take it into ide_drive.  ->disk_dev is
> handled by parititions/check.c; please don't overload it.

No problem; I'll do that today. But, I also think some of the stuff in 
fs/partitions/check.c is bogus and should die. Partitions are not devices, 
and shouldn't be treated as such. 

The patch below kills the struct device in struct hd_struct, and all the
code in fs/partitions/check.c to create and remove them. This should also
fix at least one periodic Oops that people have been seeing on shutdown.

Linus, as long as Al doesn't have a problem, please pull from the address 
below.

Thanks,

	-pat

Please pull from 

	bk://ldm.bkbits.net/linux-2.5-core

This will update the following files:

 fs/partitions/check.c |  115 --------------------------------------------------
 include/linux/genhd.h |    2 
 2 files changed, 117 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (02/10/09 1.716.1.1)
   driver model: don't treat partitions as devices.
   
   fs/partitions/check.c has been treating partitions as devices, and using the struct device in
   struct hd_struct to describe them. This was introcduced when SCSI was initially converted to use
   the new driver model.
   
   However, partitions are devices; they're logical divisions. They shouldn't be treated as devices,
   and shouldn't show up in the device hierarchy. This changeset kills the creation and teardown of 
   the partition 'devices', and their attributes. It also removes the struct device from struct 
   hd_struct, and the struct device * from struct gendisk. 


diff -Nru a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Wed Oct  9 09:28:11 2002
+++ b/fs/partitions/check.c	Wed Oct  9 09:28:11 2002
@@ -111,105 +111,6 @@
 	return buf;
 }
 
-/* Driverfs file support */
-static ssize_t partition_device_kdev_read(struct device *driverfs_dev, 
-			char *page, size_t count, loff_t off)
-{
-	kdev_t kdev; 
-	kdev.value=(int)(long)driverfs_dev->driver_data;
-	return off ? 0 : sprintf (page, "%x\n",kdev.value);
-}
-static DEVICE_ATTR(kdev,S_IRUGO,partition_device_kdev_read,NULL);
-
-static ssize_t partition_device_type_read(struct device *driverfs_dev, 
-			char *page, size_t count, loff_t off) 
-{
-	return off ? 0 : sprintf (page, "BLK\n");
-}
-static DEVICE_ATTR(type,S_IRUGO,partition_device_type_read,NULL);
-
-static void driverfs_create_partitions(struct gendisk *hd)
-{
-	int max_p = 1<<hd->minor_shift;
-	struct hd_struct *p = hd->part;
-	char name[DEVICE_NAME_SIZE];
-	char bus_id[BUS_ID_SIZE];
-	struct device *dev, *parent;
-	int part;
-
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
-	dev = &hd->disk_dev;
-	dev->driver_data = (void *)(long)__mkdev(hd->major, hd->first_minor);
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
-	device_register(dev);
-	device_create_file(dev, &dev_attr_type);
-	device_create_file(dev, &dev_attr_kdev);
-
-	for (part=0; part < max_p-1; part++) {
-		dev = &p[part].hd_driverfs_dev;
-		dev->parent = parent;
-		if (parent)
-			dev->bus = parent->bus;
-		if (!dev->driver_data)
-			continue;
-		device_register(dev);
-		device_create_file(dev, &dev_attr_type);
-		device_create_file(dev, &dev_attr_kdev);
-	}
-}
-
-static void driverfs_remove_partitions(struct gendisk *hd)
-{
-	int max_p = 1<<hd->minor_shift;
-	struct device *dev;
-	struct hd_struct *p;
-	int part;
-
-	for (part=1, p = hd->part; part < max_p; part++, p++) {
-		dev = &p->hd_driverfs_dev;
-		if (dev->driver_data) {
-			device_remove_file(dev, &dev_attr_type);
-			device_remove_file(dev, &dev_attr_kdev);
-			put_device(dev);	
-			dev->driver_data = NULL;
-		}
-	}
-	dev = &hd->disk_dev;
-	if (dev->driver_data) {
-		device_remove_file(dev, &dev_attr_type);
-		device_remove_file(dev, &dev_attr_kdev);
-		put_device(dev);	
-		dev->driver_data = NULL;
-	}
-}
-
 static void check_partition(struct gendisk *hd, struct block_device *bdev)
 {
 	devfs_handle_t de = NULL;
@@ -412,7 +313,6 @@
 	if (blkdev_get(bdev, FMODE_READ, 0, BDEV_RAW) < 0)
 		return;
 	check_partition(disk, bdev);
-	driverfs_create_partitions(disk);
 	devfs_create_partitions(disk);
 	blkdev_put(bdev, BDEV_RAW);
 }
@@ -420,30 +320,16 @@
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
 		return;
 	}
 	if (!p->de)
 		devfs_register_partition(disk, part);
-	if (dev->driver_data || !(disk->flags & GENHD_FL_DRIVERFS))
-		return;
-	dev->driver_data =
-		(void *)(long)__mkdev(disk->major, disk->first_minor+part);
-	device_register(dev);
-	device_create_file(dev, &dev_attr_type);
-	device_create_file(dev, &dev_attr_kdev);
 }
 
 int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
@@ -528,7 +414,6 @@
 
 void del_gendisk(struct gendisk *disk)
 {
-	driverfs_remove_partitions(disk);
 	wipe_partitions(disk);
 	unlink_gendisk(disk);
 	devfs_remove_partitions(disk);
diff -Nru a/include/linux/genhd.h b/include/linux/genhd.h
--- a/include/linux/genhd.h	Wed Oct  9 09:28:11 2002
+++ b/include/linux/genhd.h	Wed Oct  9 09:28:11 2002
@@ -62,7 +62,6 @@
 	unsigned long start_sect;
 	unsigned long nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
-	struct device hd_driverfs_dev;  /* support driverfs hiearchy     */
 };
 
 #define GENHD_FL_REMOVABLE  1
@@ -86,7 +85,6 @@
 	int number;			/* devfs crap */
 	devfs_handle_t de;		/* more of the same */
 	devfs_handle_t disk_de;		/* piled higher and deeper */
-	struct device *driverfs_dev;
 	struct device disk_dev;
 };
 

