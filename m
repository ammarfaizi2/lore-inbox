Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292911AbSBVPy7>; Fri, 22 Feb 2002 10:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292915AbSBVPyu>; Fri, 22 Feb 2002 10:54:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8454 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S292911AbSBVPyi>; Fri, 22 Feb 2002 10:54:38 -0500
Date: Fri, 22 Feb 2002 16:51:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
Message-ID: <20020222155114.GA313@elf.ucw.cz>
In-Reply-To: <3C75351D.4030200@evision-ventures.com> <E16dxk1-0007kN-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16dxk1-0007kN-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > So you didnt test or consider the upcoming things like hotplug. 
> > 
> > I did plugging and unplugging a CardBus IDE contoller in and out on
> > a hot system.
> 
> IDE hotplug is device level (hence you want ->present)
> 
> > using the struct device_driver infrastructure and not by reduplicating 
> > it's fuctionality inside ide.c. Agreed? Before one could even thing
> 
> Not agreed - its a layer lower I'm talking about

I want both "ide controller" *and* "ide disk" to have struct
device. And my patches do exactly that, see:

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
@@ -143,9 +143,7 @@
 #include <linux/genhd.h>
 #include <linux/blkpg.h>
 #include <linux/slab.h>
-#ifndef MODULE
 #include <linux/init.h>
-#endif /* MODULE */
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
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
@@ -424,12 +425,12 @@
 	unsigned long	capacity;	/* total number of sectors */
 	unsigned long long capacity48;	/* total number of sectors */
 	unsigned int	drive_data;	/* for use by tuneproc/selectproc as needed */
-	void		  *hwif;	/* actually (ide_hwif_t *) */
+	struct hwif_s   *hwif;	/* actually (ide_hwif_t *) */
 	wait_queue_head_t wqueue;	/* used to wait for drive in open() */
 	struct hd_driveid *id;		/* drive model identification info */
 	struct hd_struct  *part;	/* drive partition table */
 	char		name[4];	/* drive name, such as "hda" */
-	void 		*driver;	/* (ide_driver_t *) */
+	struct ide_driver_s *driver;	/* (ide_driver_t *) */
 	void		*driver_data;	/* extra driver data */
 	devfs_handle_t	de;		/* directory for device */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
@@ -448,6 +449,7 @@
 	byte		acoustic;	/* acoustic management */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
+	struct device	device;
 } ide_drive_t;
 
 /*
@@ -529,7 +531,7 @@
 
 typedef struct hwif_s {
 	struct hwif_s	*next;		/* for linked-list in ide_hwgroup_t */
-	void		*hwgroup;	/* actually (ide_hwgroup_t *) */
+	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
 	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
 	hw_regs_t	hw;		/* Hardware info */
 	ide_drive_t	drives[MAX_DRIVES];	/* drive info */
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
