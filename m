Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292556AbSBPVrh>; Sat, 16 Feb 2002 16:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292557AbSBPVr1>; Sat, 16 Feb 2002 16:47:27 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:25615 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S292556AbSBPVrQ>;
	Sat, 16 Feb 2002 16:47:16 -0500
Date: Thu, 14 Feb 2002 23:50:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Cc: vojtech@ucw.cz
Subject: /proc/driver support for ide
Message-ID: <20020214225006.GA161@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Attached. This will allow me to do suspend to disk/ram, without eating
data, once I add suspend/resume functions to ide-disk.c. As of now, it
adds ide interface and ide disk to /proc/driver...

Does it look like it could find its way to Linus?
									Pavel

--- linux/drivers/ide/ide-disk.c	Mon Feb 11 20:51:47 2002
+++ linux-dm/drivers/ide/ide-disk.c	Mon Feb 11 23:35:09 2002
@@ -925,12 +925,16 @@
 	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }
 
+static struct device_driver idedisk_device_driver = {
+};
+
 static void idedisk_setup (ide_drive_t *drive)
 {
 	int i;
 	
 	struct hd_driveid *id = drive->id;
 	unsigned long capacity;
+	int myid = -1;
 	
 	idedisk_add_settings(drive);
 
@@ -953,11 +957,20 @@
 		ide_hwif_t *hwif = HWIF(drive);
 
 		if (drive != &hwif->drives[i]) continue;
+		myid = i;
 		hwif->gd->de_arr[i] = drive->de;
 		if (drive->removable)
 			hwif->gd->flags[i] |= GENHD_FL_REMOVABLE;
 		break;
 	}
+	{
+		ide_hwif_t *hwif = HWIF(drive);
+		sprintf(drive->device.bus_id, "%d", myid);
+		sprintf(drive->device.name, "ide-disk");
+		drive->device.driver = &idedisk_device_driver;
+		drive->device.parent = &hwif->device;
+		device_register(&drive->device);
+	}
 
 	/* Extract geometry if we did not already have one for the drive */
 	if (!drive->cyl || !drive->head || !drive->sect) {
@@ -1033,6 +1046,7 @@
 
 static int idedisk_cleanup (ide_drive_t *drive)
 {
+	put_device(&drive->device);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
--- linux/drivers/ide/ide-pnp.c	Thu Oct 25 13:25:37 2001
+++ linux-dm/drivers/ide/ide-pnp.c	Thu Feb 14 22:45:13 2002
@@ -57,6 +57,7 @@
 static int __init pnpide_generic_init(struct pci_dev *dev, int enable)
 {
 	hw_regs_t hw;
+	ide_hwif_t *hwif;
 	int index;
 
 	if (!enable)
@@ -69,9 +70,10 @@
 			generic_ide_offsets, (ide_ioreg_t) DEV_IO(dev, 1),
 			0, NULL, DEV_IRQ(dev, 0));
 
-	index = ide_register_hw(&hw, NULL);
+	index = ide_register_hw(&hw, &hwif);
 
 	if (index != -1) {
+		hwif->pci_dev = dev;
 	    	printk("ide%d: %s IDE interface\n", index, DEV_NAME(dev));
 		return 0;
 	}
--- linux/drivers/ide/ide-probe.c	Thu Jan 31 23:39:35 2002
+++ linux-dm/drivers/ide/ide-probe.c	Thu Feb 14 22:50:53 2002
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/spinlock.h>
+#include <linux/pci.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -469,6 +470,14 @@
 
 static void hwif_register (ide_hwif_t *hwif)
 {
+	sprintf(hwif->device.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
+	sprintf(hwif->device.name, "ide");
+	hwif->device.driver_data = hwif;
+	if (hwif->pci_dev)
+		hwif->device.parent = &hwif->pci_dev->dev;
+	else
+		hwif->device.parent = NULL; /* Would like to do = &device_legacy */
+	device_register(&hwif->device);
 	if (((unsigned long)hwif->io_ports[IDE_DATA_OFFSET] | 7) ==
 	    ((unsigned long)hwif->io_ports[IDE_STATUS_OFFSET])) {
 		ide_request_region(hwif->io_ports[IDE_DATA_OFFSET], 8, hwif->name);
--- linux/drivers/ide/ide.c	Mon Feb 11 20:51:47 2002
+++ linux-dm/drivers/ide/ide.c	Mon Feb 11 23:35:09 2002
@@ -153,6 +151,8 @@
 #include <linux/completion.h>
 #include <linux/reboot.h>
 #include <linux/cdrom.h>
+#include <linux/device.h>
+#include <linux/kmod.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -162,9 +162,6 @@
 
 #include "ide_modes.h"
 
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-#endif /* CONFIG_KMOD */
 
 /* default maximum number of failures */
 #define IDE_DEFAULT_MAX_FAILURES 	1
@@ -2027,6 +2024,7 @@
 	hwif = &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
+	put_device(&hwif->device);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
 		if (!drive->present)
--- linux/include/linux/ide.h	Mon Feb 11 21:15:04 2002
+++ linux-dm/include/linux/ide.h	Thu Feb 14 22:47:23 2002
@@ -14,6 +14,7 @@
 #include <linux/blkdev.h>
 #include <linux/proc_fs.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 #include <asm/hdreg.h>
 
 /*
@@ -448,6 +449,7 @@
 	byte		acoustic;	/* acoustic management */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
+	struct device	device;
 } ide_drive_t;
 
 /*
@@ -580,6 +582,7 @@
 	void		*hwif_data;	/* extra hwif data */
 	ide_busproc_t	*busproc;	/* driver soft-power interface */
 	byte		bus_state;	/* power state of the IDE bus */
+	struct device	device;
 } ide_hwif_t;
 
 /*

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
