Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277371AbRK1SeY>; Wed, 28 Nov 2001 13:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279303AbRK1SeP>; Wed, 28 Nov 2001 13:34:15 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:13600 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S277371AbRK1Sdz>; Wed, 28 Nov 2001 13:33:55 -0500
Message-ID: <3C052E94.4010407@paulbristow.net>
Date: Wed, 28 Nov 2001 19:36:04 +0100
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: [PATCH] ide-floppy real devfs support for testing
In-Reply-To: <000601c1773f$d80d9ba0$21c9ca95@mow.siemens.ru> <3C03D197.7050605@paulbristow.net> <20011127123804.F9391@mikef-linux.matchmail.com>
Content-Type: multipart/mixed;
 boundary="------------040805030601070804070400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040805030601070804070400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Right :-),


the following patch depends on the previous via fix patch, which is also 
available at http://paulbristow.net/linux/idefloppy.html

Both patches can be applied against 2.4.14-16

This patch implements devfs support in the ide-floppy driver, as it is 
documented in Richards FAQ.

If there is a disk in the drive, a disc node and any partitions are 
created in
   /dev/ide/hostx/busx/targetx/lunx/

and a symlink is created in
   /dev/ide/fd/cxbxtxux to the disc node

If there is no disk in the drive, you just get no partition information, 
a disc node is still created so you have something to revalidate

against.

Cheers,

-- 

Paul

Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223




--------------040805030601070804070400
Content-Type: text/plain;
 name="ide-floppy-devfs-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-floppy-devfs-patch"

diff -burN -X dontdiff linux-2.4.16-clean/drivers/ide/ide-floppy.c linux-2.4.16/drivers/ide/ide-floppy.c
--- linux-2.4.16-clean/drivers/ide/ide-floppy.c	Wed Nov 28 19:25:34 2001
+++ linux-2.4.16/drivers/ide/ide-floppy.c	Wed Nov 28 19:30:36 2001
@@ -1,10 +1,12 @@
 /*
- * linux/drivers/ide/ide-floppy.c	Version 0.97.sv	Jan 14 2001
+ * linux/drivers/ide/ide-floppy.c	
  *
  * Copyright (C) 1996 - 1999 Gadi Oxman <gadio@netvision.net.il>
  * Copyright (C) 2000 - 2001 Paul Bristow <paul@paulbristow.net>
  */
 
+#define IDEFLOPPY_VERSION "0.99-devfs-test4"
+
 /*
  * IDE ATAPI floppy driver.
  *
@@ -82,9 +84,9 @@
  *		msec works on my system. The variable ticks is exposed 
  *		in /proc/ide/hdx/settings. Each tick is 10 msec. If ticks is
  *		set to zero, the driver reverts to the old algorithm. --Skip
+ * Ver 0.99   Nov 22 01  Add devfs support
  */
 
-#define IDEFLOPPY_VERSION "0.98"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -101,6 +103,7 @@
 #include <linux/slab.h>
 #include <linux/cdrom.h>
 #include <linux/ide.h>
+#include <linux/devfs_fs_kernel.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -275,6 +278,7 @@
  */
 typedef struct {
 	ide_drive_t *drive;
+	devfs_handle_t de;		/* devfs entry */
 
 	idefloppy_pc_t *pc;			/* Current packet command */
 	idefloppy_pc_t *failed_pc; 		/* Last failed packet command */
@@ -673,6 +677,8 @@
 #define IDEFLOPPY_MIN(a,b)	((a)<(b) ? (a):(b))
 #define	IDEFLOPPY_MAX(a,b)	((a)>(b) ? (a):(b))
 
+extern devfs_handle_t ide_devfs_handle; /* Hook into ide devfs chain */
+
 /*
  *	Too bad. The drive wants to send us data which we are not ready to accept.
  *	Just throw it away.
@@ -1097,6 +1103,7 @@
 	return ide_started;
 }
 
+
 /*
  *	Issue a packet command
  */
@@ -1483,9 +1490,14 @@
                         if (memcmp (descriptor, &floppy->capacity, sizeof (idefloppy_capacity_descriptor_t)))
                                 printk (KERN_INFO "%s: %dkB, %d blocks, %d sector size\n", drive->name, blocks * length / 1024, blocks, length);
                         floppy->capacity = *descriptor;
-                        if (!length || length % 512)
+			                  if (!length || length % 512) {
                                 printk (KERN_NOTICE "%s: %d bytes block size not supported\n", drive->name, length);
-                        else {
+		                    } else if (!i && descriptor->dc == CAPACITY_NO_CARTRIDGE                                   && drive->removable && !(length % 512)) {
+			                    /* Set these two so that idefloppy_capacity returns a 
+			                       positive value, needed for devfs registration. */
+			                    floppy->blocks = blocks;
+			                    floppy->bs_factor = length / 512;
+			                  } else {
                                 floppy->blocks = blocks;
                                 floppy->block_size = length;
                                 if ((floppy->bs_factor = length / 512) != 1)
@@ -2027,6 +2039,7 @@
 	ide_add_setting(drive,	"ticks",		SETTING_RW,	-1,		-1,		TYPE_BYTE,	0,	255,		1,	1,	&floppy->ticks,			NULL);
 }
 
+
 /*
  *	Driver initialization.
  */
@@ -2035,6 +2048,9 @@
 	struct idefloppy_id_gcw gcw;
 	int major = HWIF(drive)->major, i;
 	int minor = drive->select.b.unit << PARTN_BITS;
+	char fname[64],iname[64]; /* for devfs */
+ 	devfs_handle_t idefloppy_devfs_handle; /* for devfs */
+ 	ide_hwif_t *hwif = HWIF(drive);
 
 	*((unsigned short *) &gcw) = drive->id->config;
 	drive->driver_data = floppy;
@@ -2080,26 +2096,46 @@
 		set_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags);
 	}
 
-
 	(void) idefloppy_get_capacity (drive);
 	idefloppy_add_settings(drive);
+	
 	for (i = 0; i < MAX_DRIVES; ++i) {
-		ide_hwif_t *hwif = HWIF(drive);
 
 		if (drive != &hwif->drives[i]) continue;
 		hwif->gd->de_arr[i] = drive->de;
+
 		if (drive->removable)
 			hwif->gd->flags[i] |= GENHD_FL_REMOVABLE;
 		break;
 	}
+  
+  /* Always register drive with devfs */
+	floppy->de = devfs_register (drive->de, "disc", DEVFS_FL_REMOVABLE,
+	       			 major, minor,
+				       S_IFBLK | S_IRUGO | S_IWUGO,
+				       ide_fops, NULL);
+	/* Create ide/fd entry in devfs */			       
+  idefloppy_devfs_handle = devfs_mk_dir(ide_devfs_handle,"fd",NULL);
+	
+	sprintf (fname, "c%db%dt%du%d",
+		 (hwif->channel && hwif->mate) ? hwif->mate->index : hwif->index,
+  		hwif->channel, i, hwif->drives[i].lun);
+	sprintf (iname, "../host%d/bus%d/target%d/lun%d/disc",
+		 (hwif->channel && hwif->mate) ? hwif->mate->index : hwif->index,
+  		hwif->channel, i, hwif->drives[i].lun);
+  devfs_mk_symlink(idefloppy_devfs_handle, fname, DEVFS_FL_REMOVABLE, iname, NULL, NULL);
 }
 
+
 static int idefloppy_cleanup (ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
 
 	if (ide_unregister_subdriver (drive))
 		return 1;
+	
+	devfs_unregister(floppy->de);
+
 	drive->driver_data = NULL;
 	kfree (floppy);
 	return 0;
@@ -2212,6 +2248,7 @@
 
 module_init(idefloppy_init);
 module_exit(idefloppy_exit);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Maintainer: Paul Bristow <paul@paulbristow.net>");
 MODULE_DESCRIPTION("ATAPI Floppy Driver V"IDEFLOPPY_VERSION);
diff -burN -X dontdiff linux-2.4.16-clean/drivers/ide/ide-probe.c linux-2.4.16/drivers/ide/ide-probe.c
--- linux-2.4.16-clean/drivers/ide/ide-probe.c	Mon Nov 26 14:29:17 2001
+++ linux-2.4.16/drivers/ide/ide-probe.c	Wed Nov 28 18:49:38 2001
@@ -121,6 +121,7 @@
 					if (!strstr(id->model, "oppy") && !strstr(id->model, "poyp") && !strstr(id->model, "ZIP"))
 						printk("cdrom or floppy?, assuming ");
 					if (drive->media != ide_cdrom) {
+				    drive->removable = 1;
 						printk ("FLOPPY");
 						break;
 					}

--------------040805030601070804070400--

