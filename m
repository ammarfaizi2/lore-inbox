Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTH3URg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 16:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTH3URg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 16:17:36 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:37389 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262086AbTH3URP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 16:17:15 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: Re: Fw: [DAC960] 2.6.0-test1: device files wrong in devfs
Date: Sun, 31 Aug 2003 00:15:53 +0400
User-Agent: KMail/1.5
References: <20030830011607.61537b27.akpm@osdl.org>
In-Reply-To: <20030830011607.61537b27.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Olien <dmo@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5XQU/WDfqSflcfy"
Message-Id: <200308310015.53324.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_5XQU/WDfqSflcfy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 30 August 2003 12:16, Andrew Morton wrote:
> just going through my inbox...
>
>
> Begin forwarded message:
>
> Date: Mon, 28 Jul 2003 22:14:45 -0700
> From: Dave Olien <dmo@osdl.org>
> To: Andrew Morton <akpm@osdl.org>
> Cc: lkml@gert.robben.nu, Christoph Hellwig <hch@lst.de>
> Subject: Re: Fw: [DAC960] 2.6.0-test1: device files wrong in devfs
>
>
>
> I just looked a little more closely at more of the drivers.
> The following are OK.  They call devfs_mk_dir() and devfs_mk_bdev()
> directly to make entries in devfs.
>
> floppy98.c, floppy.c, umem.c, xd.c
>
> This leaves these that don't seem to make devfs entries:
>
> cciss.c and amiflop.c, ataflop.c, z2ram.c, acsi.c, ps2esdi.c
>
> A quick fix might be to just add initialization of devfs_name following
> the init of disk_name, as I did in the DAC960.c
>

this is not quick fix, this is the only right fix. The only problem is what to 
set devfs_name to :)

the attached patch suggests some possible names for non-floppy devices based 
on reading driver source. I have to ask if these make sense. At least for 
cciss Mandrake devfsd patch expects different names but it seems to be 
mistake (it assumes single controller always)

For floppy it is not as simple. Floppy cannot use genhd and must create names 
manually; but I do not know what names are appropriate or expected.

For acsi the target/lun name may have problem of creating compat names (if 
any) by devfsd.

Please note that none of them created any devfs name under 2.4 as well. So it 
is not a regression ...

-andrey

> On Mon, Jul 28, 2003 at 06:35:28PM -0700, Dave Olien wrote:
> > At quick glance, other drivers that look suspicious under drivers/block:
> >
> > 	acsi.c --- driver for Atari hard disks
> > 	ataflop.c
> > 	amiflop.c
> > 	floppy98.c
> > 	floppy.c
> > 	ps2esdi.c
> > 	z2ram.c
> > 	umem.c
> > 	xd.c
> >
> > A lot of these may be obsolete drivers, although they have been
> > updated to use the new gendisk structures.
> >
> > On Mon, Jul 28, 2003 at 06:21:00PM -0700, Andrew Morton wrote:
> > > I assume that IDE gets it right.  And scsi appears to do it centrally.
> > >
> > > cciss.c appears to not be setting devfs_name.  Christoph, could you
> > > please suggest a fix?

--Boundary-00=_5XQU/WDfqSflcfy
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.0-test4-blockdev-devfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test4-blockdev-devfs.patch"

--- linux-2.6.0-test4/drivers/block/acsi.c	2003-08-09 13:10:01.000000000 +0400
+++ ../src/linux-2.6.0-test4-smp/drivers/block/acsi.c	2003-08-30 23:44:16.000000000 +0400
@@ -1729,10 +1729,14 @@
 	for( i = 0; i < NDevices; ++i ) {
 		struct gendisk *disk = acsi_gendisk[i];
 		sprintf(disk->disk_name, "ad%c", 'a'+i);
+		aip = &acsi_info[NDevices];
+		sprintf(disk->devfs_name, "ad/target%d/lun%d", aip->target, aip->lun);
 		disk->major = ACSI_MAJOR;
 		disk->first_minor = i << 4;
-		if (acsi_info[i].type != HARDDISK)
+		if (acsi_info[i].type != HARDDISK) {
 			disk->minors = 1;
+			strcat(disk->devfs_name, "/disc");
+		}
 		disk->fops = &acsi_fops;
 		disk->private_data = &acsi_info[i];
 		set_capacity(disk, acsi_info[i].size);
--- linux-2.6.0-test4/drivers/block/cciss.c	2003-08-23 22:44:55.000000000 +0400
+++ ../src/linux-2.6.0-test4-smp/drivers/block/cciss.c	2003-08-30 23:37:35.000000000 +0400
@@ -2562,6 +2562,7 @@
 		struct gendisk *disk = hba[i]->gendisk[j];
 
 		sprintf(disk->disk_name, "cciss/c%dd%d", i, j);
+		sprintf(disk->devfs_name, "cciss/host%d/target%d", i, j);
 		disk->major = COMPAQ_CISS_MAJOR + i;
 		disk->first_minor = j << NWD_SHIFT;
 		disk->fops = &cciss_fops;
--- linux-2.6.0-test4/drivers/block/ps2esdi.c	2003-08-09 13:10:02.000000000 +0400
+++ ../src/linux-2.6.0-test4-smp/drivers/block/ps2esdi.c	2003-08-30 23:45:11.000000000 +0400
@@ -421,6 +421,7 @@
 		disk->major = PS2ESDI_MAJOR;
 		disk->first_minor = i<<6;
 		sprintf(disk->disk_name, "ed%c", 'a'+i);
+		sprintf(disk->devfs_name, "ed/target%d", i);
 		disk->fops = &ps2esdi_fops;
 		ps2esdi_gendisk[i] = disk;
 	}
--- linux-2.6.0-test4/drivers/block/umem.c	2003-08-09 13:10:03.000000000 +0400
+++ ../src/linux-2.6.0-test4-smp/drivers/block/umem.c	2003-08-30 23:48:02.000000000 +0400
@@ -52,7 +52,6 @@
 
 #include <linux/fcntl.h>        /* O_ACCMODE */
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
-#include <linux/devfs_fs_kernel.h>
 
 #include <linux/umem.h>
 
@@ -1204,11 +1203,10 @@
 			goto out;
 	}
 
-	devfs_mk_dir("umem");
-
 	for (i = 0; i < num_cards; i++) {
 		struct gendisk *disk = mm_gendisk[i];
 		sprintf(disk->disk_name, "umem%c", 'a'+i);
+		sprintf(disk->devfs_name, "umem/card%d", i);
 		spin_lock_init(&cards[i].lock);
 		disk->major = major_nr;
 		disk->first_minor  = i << MM_SHIFT;
@@ -1245,7 +1243,6 @@
 		del_gendisk(mm_gendisk[i]);
 		put_disk(mm_gendisk[i]);
 	}
-	devfs_remove("umem");
 
 	pci_unregister_driver(&mm_pci_driver);
 
--- linux-2.6.0-test4/drivers/block/xd.c	2003-08-09 13:10:03.000000000 +0400
+++ ../src/linux-2.6.0-test4-smp/drivers/block/xd.c	2003-08-30 23:50:00.000000000 +0400
@@ -45,7 +45,6 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/wait.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/blkdev.h>
 #include <linux/blkpg.h>
 
@@ -182,7 +181,6 @@
 	if (!xd_queue)
 		goto out1a;
 
-	devfs_mk_dir("xd");
 	if (xd_detect(&controller,&address)) {
 
 		printk("Detected a%s controller (type %d) at address %06x\n",
@@ -213,6 +211,7 @@
 		disk->major = XT_DISK_MAJOR;
 		disk->first_minor = i<<6;
 		sprintf(disk->disk_name, "xd%c", i+'a');
+		sprintf(disk->devfs_name, "xd/target%d", i);
 		disk->fops = &xd_fops;
 		disk->private_data = p;
 		disk->queue = xd_queue;
@@ -249,7 +248,6 @@
 out3:
 	release_region(xd_iobase,4);
 out2:
-	devfs_remove("xd");
 	blk_cleanup_queue(xd_queue);
 out1a:
 	unregister_blkdev(XT_DISK_MAJOR, "xd");
@@ -1064,7 +1062,6 @@
 	}
 	blk_cleanup_queue(xd_queue);
 	release_region(xd_iobase,4);
-	devfs_remove("xd");
 	if (xd_drives) {
 		free_irq(xd_irq, NULL);
 		free_dma(xd_dma);
--- linux-2.6.0-test4/drivers/block/z2ram.c	2003-08-09 13:10:03.000000000 +0400
+++ ../src/linux-2.6.0-test4-smp/drivers/block/z2ram.c	2003-08-30 23:07:47.000000000 +0400
@@ -354,6 +354,7 @@
     z2ram_gendisk->first_minor = 0;
     z2ram_gendisk->fops = &z2_fops;
     sprintf(z2ram_gendisk->disk_name, "z2ram");
+    strcpy(z2ram_gendisk->devfs_name, z2ram_gendisk->disk_name);
 
     z2ram_gendisk->queue = z2_queue;
     add_disk(z2ram_gendisk);

--Boundary-00=_5XQU/WDfqSflcfy--

