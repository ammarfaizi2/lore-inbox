Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290851AbSBLJSt>; Tue, 12 Feb 2002 04:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290862AbSBLJSd>; Tue, 12 Feb 2002 04:18:33 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:63753 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290852AbSBLJIR>;
	Tue, 12 Feb 2002 04:08:17 -0500
Date: Tue, 12 Feb 2002 09:59:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: sys & legacy buses plus interrupt controller and IDE support
Message-ID: <20020212085954.GA618@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here it goes. For now I only put one device on each bus (sys &
legacy), but I'll quickly expand it once merged. Please apply,

							Pavel

--- linux/arch/i386/kernel/i8259.c	Thu Jan 31 23:39:28 2002
+++ linux-dm/arch/i386/kernel/i8259.c	Tue Feb 12 09:48:48 2002
@@ -11,6 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
+#include <linux/device.h>
 
 #include <asm/atomic.h>
 #include <asm/system.h>
@@ -333,6 +334,19 @@
 		goto handle_real_irq;
 	}
 }
+
+static struct device device_i8259A = {
+	name:	       	"i8259A",
+	bus_id:		"0020",
+	parent:		&device_sys,
+};
+
+static void __init init_8259A_devicefs(void)
+{
+	device_register(&device_i8259A);
+}
+
+__initcall(init_8259A_devicefs);
 
 void __init init_8259A(int auto_eoi)
 {
--- linux/drivers/base/core.c	Mon Feb 11 20:51:46 2002
+++ linux-dm/drivers/base/core.c	Mon Feb 11 23:35:55 2002
@@ -24,6 +24,18 @@
 	name:		"System Root",
 };
 
+struct device device_sys = {
+	bus_id:		"sys",
+	name:		"Bus for motherboard devices",
+	parent:		&device_root,
+};
+
+struct device device_legacy = {
+	bus_id:		"legacy",
+	name:		"Bus for devices on southbridge/X-BUS/ISA",
+	parent:		&device_root,
+};
+
 int (*platform_notify)(struct device * dev) = NULL;
 int (*platform_notify_remove)(struct device * dev) = NULL;
 
@@ -121,7 +133,13 @@
 
 static int __init device_init_root(void)
 {
-	return device_register(&device_root);
+	int res;
+	res = device_register(&device_root);
+	if (res) return res;
+	res = device_register(&device_sys);
+	if (res) return res;
+	res = device_register(&device_legacy);
+	if (res) return res;
 }
 
 static int __init device_init(void)
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
--- linux/drivers/ide/ide-probe.c	Thu Jan 31 23:39:35 2002
+++ linux-dm/drivers/ide/ide-probe.c	Mon Feb 11 23:36:41 2002
@@ -469,6 +469,11 @@
 
 static void hwif_register (ide_hwif_t *hwif)
 {
+	sprintf(hwif->device.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
+	sprintf(hwif->device.name, "ide");
+	hwif->device.driver_data = hwif;
+	hwif->device.parent = &device_legacy;
+	device_register(&hwif->device);
 	if (((unsigned long)hwif->io_ports[IDE_DATA_OFFSET] | 7) ==
 	    ((unsigned long)hwif->io_ports[IDE_STATUS_OFFSET])) {
 		ide_request_region(hwif->io_ports[IDE_DATA_OFFSET], 8, hwif->name);
--- linux/drivers/ide/ide.c	Mon Feb 11 20:51:47 2002
+++ linux-dm/drivers/ide/ide.c	Mon Feb 11 23:35:09 2002
@@ -2027,6 +2024,7 @@
 	hwif = &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
+	put_device(&hwif->device);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
 		if (!drive->present)
--- linux/include/linux/device.h	Mon Feb 11 21:10:52 2002
+++ linux-dm/include/linux/device.h	Mon Feb 11 23:35:09 2002
@@ -162,5 +142,7 @@
 }
 
 extern void put_device(struct device * dev);
+extern struct device device_legacy;
+extern struct device device_sys;
 
 #endif /* _DEVICE_H_ */
--- linux/include/linux/ide.h	Mon Feb 11 21:15:04 2002
+++ linux-dm/include/linux/ide.h	Mon Feb 11 23:35:09 2002
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
