Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262423AbSJISgH>; Wed, 9 Oct 2002 14:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbSJISfv>; Wed, 9 Oct 2002 14:35:51 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5552 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262423AbSJISfU>;
	Wed, 9 Oct 2002 14:35:20 -0400
Date: Wed, 9 Oct 2002 11:43:32 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] IDE driver model update
In-Reply-To: <Pine.LNX.4.44.0210091131360.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210091143220.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.727, 2002-10-09 10:29:48-07:00, mochel@osdl.org
  IDE: add struct device to ide_drive_t and use that for IDE drives
  
  ... instead of the one in struct gendisk.

diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Wed Oct  9 11:41:41 2002
+++ b/drivers/ide/ide-probe.c	Wed Oct  9 11:41:41 2002
@@ -998,15 +998,6 @@
 		sprintf(disk->disk_name,"hd%c",'a'+hwif->index*MAX_DRIVES+unit);
 		disk->minor_shift = PARTN_BITS; 
 		disk->fops = ide_fops;
-
-		snprintf(disk->disk_dev.bus_id,BUS_ID_SIZE,"%u.%u",
-			 hwif->index,unit);
-		snprintf(disk->disk_dev.name,DEVICE_NAME_SIZE,
-			 "%s","IDE Drive");
-		disk->disk_dev.parent = &hwif->gendev;
-		disk->disk_dev.bus = &ide_bus_type;
-		if (hwif->drives[unit].present)
-			device_register(&disk->disk_dev);
 		hwif->drives[unit].disk = disk;
 	}
 
@@ -1020,6 +1011,20 @@
 		if (hwif->drives[unit].present)
 			hwif->drives[unit].de = devfs_mk_dir(ide_devfs_handle, name, NULL);
 	}
+	
+	for (unit = 0; unit < units; ++unit) {
+		ide_drive_t * drive = &hwif->drives[unit];
+
+		snprintf(drive->gendev.bus_id,BUS_ID_SIZE,"%u.%u",
+			 hwif->index,unit);
+		snprintf(drive->gendev.name,DEVICE_NAME_SIZE,
+			 "%s","IDE Drive");
+		drive->gendev.parent = &hwif->gendev;
+		drive->gendev.bus = &ide_bus_type;
+		if (drive->present)
+			device_register(&drive->gendev);
+	}
+
 	return;
 
 err_kmalloc_gd:
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Wed Oct  9 11:41:41 2002
+++ b/include/linux/ide.h	Wed Oct  9 11:41:41 2002
@@ -794,6 +794,7 @@
 	int		lun;		/* logical unit */
 	int		crc_count;	/* crc counter to reduce drive speed */
 	struct list_head list;
+	struct device	gendev;
 	struct gendisk *disk;
 } ide_drive_t;
 

