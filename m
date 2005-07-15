Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVGOIJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVGOIJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVGOIJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:09:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:19102 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261865AbVGOIJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:09:26 -0400
Message-ID: <42D76F35.2080402@suse.de>
Date: Fri, 15 Jul 2005 10:09:25 +0200
From: Hannes Reinecke <hare@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: [PATCH] Add cmos attribute to floppy driver
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030109090909000404000506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030109090909000404000506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

this patch adds a 'cmos' attribute to the floppy driver. This lets you
figure out which drive types are actually supported by this drive.

When using udev you currently have to either not create any device node
beside /dev/fdX (and make quite some users unhappy) or create every
single possible device nodes (and defeat the purpose of udev to create
device nodes for existing devices only).

Please apply.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de

--------------030109090909000404000506
Content-Type: text/plain;
 name="floppy-add-cmos-attr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="floppy-add-cmos-attr"

From: Hannes Reinecke <hare@suse.de>
Subject: Add 'cmos' attribute to floppy driver

Currently only a device 'fdX' shows up in sysfs; the other possible
device for this drive (like fd0h1440 etc) must be guessed from there.

This patch corrects the floppy driver to create a platform device for
each floppy found; each platform device also has an attribute 'cmos'
which represents the cmos type for this drive. From this attribute the
other possible device types can be computed.

--- linux-2.6.12/drivers/block/floppy.c.orig	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/block/floppy.c	2005-07-15 09:29:05.000000000 +0200
@@ -493,6 +493,8 @@ static struct floppy_struct user_params[
 
 static sector_t floppy_sizes[256];
 
+static char floppy_device_name[] = "floppy";
+
 /*
  * The driver is trying to determine the correct media format
  * while probing is set. rw_interrupt() clears it after a
@@ -4191,18 +4193,25 @@ static int __init floppy_setup(char *str
 
 static int have_no_fdc = -ENODEV;
 
+static ssize_t floppy_cmos_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct platform_device *p = container_of(dev,struct platform_device,dev);
+	int drive = p->id;
+	ssize_t retval;
+
+	retval = sprintf(buf,"%X\n", UDP->cmos);
+
+	return retval;
+}
+
+DEVICE_ATTR(cmos,S_IRUGO,floppy_cmos_show,NULL);
+
 static void floppy_device_release(struct device *dev)
 {
 	complete(&device_release);
 }
 
-static struct platform_device floppy_device = {
-	.name		= "floppy",
-	.id		= 0,
-	.dev		= {
-			.release = floppy_device_release,
-			}
-};
+static struct platform_device floppy_device[N_DRIVE];
 
 static struct kobject *floppy_find(dev_t dev, int *part, void *data)
 {
@@ -4370,20 +4379,26 @@ static int __init floppy_init(void)
 		goto out_flush_work;
 	}
 
-	err = platform_device_register(&floppy_device);
-	if (err)
-		goto out_flush_work;
-
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		if (!(allowed_drive_mask & (1 << drive)))
 			continue;
 		if (fdc_state[FDC(drive)].version == FDC_NONE)
 			continue;
+
+		floppy_device[drive].name = floppy_device_name;
+		floppy_device[drive].id = drive;
+		floppy_device[drive].dev.release = floppy_device_release;
+
+		err = platform_device_register(&floppy_device[drive]);
+		if (err)
+			goto out_flush_work;
+
+		device_create_file(&floppy_device[drive].dev,&dev_attr_cmos);
 		/* to be cleaned up... */
 		disks[drive]->private_data = (void *)(long)drive;
 		disks[drive]->queue = floppy_queue;
 		disks[drive]->flags |= GENHD_FL_REMOVABLE;
-		disks[drive]->driverfs_dev = &floppy_device.dev;
+		disks[drive]->driverfs_dev = &floppy_device[drive].dev;
 		add_disk(disks[drive]);
 	}
 
@@ -4603,10 +4618,11 @@ void cleanup_module(void)
 		    fdc_state[FDC(drive)].version != FDC_NONE) {
 			del_gendisk(disks[drive]);
 			unregister_devfs_entries(drive);
+			device_remove_file(&floppy_device[drive].dev, &dev_attr_cmos);
+			platform_device_unregister(&floppy_device[drive]);
 		}
 		put_disk(disks[drive]);
 	}
-	platform_device_unregister(&floppy_device);
 	devfs_remove("floppy");
 
 	del_timer_sync(&fd_timeout);

--------------030109090909000404000506--
