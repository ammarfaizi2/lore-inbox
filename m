Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319817AbSIMWn0>; Fri, 13 Sep 2002 18:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319818AbSIMWn0>; Fri, 13 Sep 2002 18:43:26 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:26384
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319817AbSIMWnV>; Fri, 13 Sep 2002 18:43:21 -0400
Date: Fri, 13 Sep 2002 15:46:06 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix 2.5.34+swsusp data corruption on IDE
In-Reply-To: <20020913211529.GA25502@elf.ucw.cz>
Message-ID: <Pine.LNX.4.10.10209131537190.6925-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pavel,

I spoke with Jens, and he wants us to hold off until we can settle the
current issues.  I have one concern about the model, and maybe you can
explain away the concern.

Why are we not blocking read/write requests in the mainloop regardless?
If the request gets to the subdriver, ide-disk, has it not gotten to far
down the pipes?

If get to "static ide_startstop_t do_rw_disk()" and that is called from
the mainloop, is it not preferred to block there?  Would it not also
prevent other suspended media from suffering the same corruption?

Specifically ls120's and zips.

I understand you are address disk but suspend is more than disk in the
power management picture.  Can you walk me through your process of sole
concern with platter media?  Remember microdrvies are platters too, as are
flash drives, and memory drives.

I look forward to the details and the comfort they are to provide.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Fri, 13 Sep 2002, Pavel Machek wrote:

> Hi!
> 
> 2.5.34 will eat disks if there's any disk activity during
> suspend-to-disk. This patch fixes that. Please apply,
> 
> 							Pavel
> 
> --- clean/drivers/ide/ide-disk.c	2002-09-13 22:20:51.000000000 +0200
> +++ linux-swsusp/drivers/ide/ide-disk.c	2002-09-13 22:37:24.000000000 +0200
> @@ -365,6 +365,7 @@
>   */
>  static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
>  {
> +	BUG_ON(drive->blocked);
>  	if (!(rq->flags & REQ_CMD)) {
>  		blk_dump_rq_flags(rq, "do_rw_disk - bad command");
>  		idedisk_end_request(drive, 0);
> @@ -1514,10 +1515,63 @@
>   	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
>  }
>  
> +static int idedisk_suspend(struct device *dev, u32 state, u32 level)
> +{
> +	ide_drive_t *drive = dev->driver_data;
> +
> +	/* I hope that every freeze operations from the upper levels have
> +	 * already been done...
> +	 */
> +
> +	BUG_ON(in_interrupt());
> +
> +	if (level != SUSPEND_SAVE_STATE)
> +		return 0;
> +
> +	/* wait until all commands are finished */
> +	/* FIXME: waiting for spinlocks should be done instead. */
> +	while (HWGROUP(drive)->handler)
> +		yield();
> +
> +	/* set the drive to standby */
> +	printk(KERN_INFO "suspending: %s ", drive->name);
> +	if (drive->driver) {
> +		if (drive->driver->standby)
> +			drive->driver->standby(drive);
> +	}
> +	drive->blocked = 1;
> +
> +	return 0;
> +}
> +
> +static int idedisk_resume(struct device *dev, u32 level)
> +{
> +	ide_drive_t *drive = dev->driver_data;
> +
> +	if (level != RESUME_RESTORE_STATE)
> +		return 0;
> +	if (!drive->blocked)
> +		panic("ide: Resume but not suspended?\n");
> +
> +	drive->blocked = 0;
> +	return 0;
> +}
> +
> +
> +/* This is just a hook for the overall driver tree.
> + */
> +
> +static struct device_driver idedisk_devdrv = {
> +	.lock = RW_LOCK_UNLOCKED,
> +	.suspend = idedisk_suspend,
> +	.resume = idedisk_resume,
> +};
> +
>  static void idedisk_setup (ide_drive_t *drive)
>  {
>  	struct hd_driveid *id = drive->id;
>  	unsigned long capacity;
> +	int myid = -1;
>  	
>  	idedisk_add_settings(drive);
>  
> @@ -1536,6 +1590,15 @@
>  			drive->doorlocking = 1;
>  		}
>  	}
> +	{
> +		ide_hwif_t *hwif = HWIF(drive);
> +		sprintf(drive->device.bus_id, "%d", myid);
> +		sprintf(drive->device.name, "ide-disk");
> +		drive->device.driver = &idedisk_devdrv;
> +		drive->device.parent = &hwif->device;
> +		drive->device.driver_data = drive;
> +		device_register(&drive->device);
> +	}
>  
>  #if 1
>  	(void) probe_lba_addressing(drive, 1);
> @@ -1619,6 +1682,8 @@
>  static int idedisk_cleanup (ide_drive_t *drive)
>  {
>  	struct gendisk *g = drive->disk;
> +
> +	put_device(&drive->device);
>  	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
>  		if (do_idedisk_flushcache(drive))
>  			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
> --- clean/drivers/ide/ide-pnp.c	2002-08-28 22:38:45.000000000 +0200
> +++ linux-swsusp/drivers/ide/ide-pnp.c	2002-09-06 00:28:57.000000000 +0200
> @@ -57,6 +57,7 @@
>  static int __init pnpide_generic_init(struct pci_dev *dev, int enable)
>  {
>  	hw_regs_t hw;
> +	ide_hwif_t *hwif;
>  	int index;
>  
>  	if (!enable)
> @@ -69,9 +70,10 @@
>  			generic_ide_offsets, (ide_ioreg_t) DEV_IO(dev, 1),
>  			0, NULL, DEV_IRQ(dev, 0));
>  
> -	index = ide_register_hw(&hw, NULL);
> +	index = ide_register_hw(&hw, &hwif);
>  
>  	if (index != -1) {
> +		hwif->pci_dev = dev;
>  	    	printk("ide%d: %s IDE interface\n", index, DEV_NAME(dev));
>  		return 0;
>  	}
> --- clean/drivers/ide/ide-probe.c	2002-09-13 22:20:51.000000000 +0200
> +++ linux-swsusp/drivers/ide/ide-probe.c	2002-09-13 22:24:08.000000000 +0200
> @@ -46,6 +46,7 @@
>  #include <linux/delay.h>
>  #include <linux/ide.h>
>  #include <linux/spinlock.h>
> +#include <linux/pci.h>
>  
>  #include <asm/byteorder.h>
>  #include <asm/irq.h>
> @@ -477,6 +478,14 @@
>  
>  static void hwif_register (ide_hwif_t *hwif)
>  {
> +	sprintf(hwif->device.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
> +	sprintf(hwif->device.name, "ide");
> +	hwif->device.driver_data = hwif;
> +	if (hwif->pci_dev)
> +		hwif->device.parent = &hwif->pci_dev->dev;
> +	else
> +		hwif->device.parent = NULL; /* Would like to do = &device_legacy */
> +	device_register(&hwif->device);
>  	if (((unsigned long)hwif->io_ports[IDE_DATA_OFFSET] | 7) ==
>  	    ((unsigned long)hwif->io_ports[IDE_STATUS_OFFSET])) {
>  		ide_request_region(hwif->io_ports[IDE_DATA_OFFSET], 8, hwif->name);
> --- clean/drivers/ide/ide.c	2002-09-13 22:20:51.000000000 +0200
> +++ linux-swsusp/drivers/ide/ide.c	2002-09-13 22:24:09.000000000 +0200
> @@ -141,9 +141,7 @@
>  #include <linux/genhd.h>
>  #include <linux/blkpg.h>
>  #include <linux/slab.h>
> -#ifndef MODULE
>  #include <linux/init.h>
> -#endif /* MODULE */
>  #include <linux/pci.h>
>  #include <linux/delay.h>
>  #include <linux/ide.h>
> @@ -152,6 +150,8 @@
>  #include <linux/reboot.h>
>  #include <linux/cdrom.h>
>  #include <linux/seq_file.h>
> +#include <linux/device.h>
> +#include <linux/kmod.h>
>  
>  #include <asm/byteorder.h>
>  #include <asm/irq.h>
> @@ -161,9 +161,6 @@
>  
>  #include "ide_modes.h"
>  
> -#ifdef CONFIG_KMOD
> -#include <linux/kmod.h>
> -#endif /* CONFIG_KMOD */
>  
>  /* default maximum number of failures */
>  #define IDE_DEFAULT_MAX_FAILURES 	1
> @@ -1951,6 +1948,7 @@
>  	hwif = &ide_hwifs[index];
>  	if (!hwif->present)
>  		goto abort;
> +	put_device(&hwif->device);
>  	for (unit = 0; unit < MAX_DRIVES; ++unit) {
>  		drive = &hwif->drives[unit];
>  		if (!drive->present)
> --- clean/include/linux/ide.h	2002-09-13 22:21:19.000000000 +0200
> +++ linux-swsusp/include/linux/ide.h	2002-09-13 22:34:19.000000000 +0200
> @@ -15,6 +15,7 @@
>  #include <linux/proc_fs.h>
>  #include <linux/devfs_fs_kernel.h>
>  #include <linux/bio.h>
> +#include <linux/device.h>
>  #include <asm/byteorder.h>
>  #include <asm/system.h>
>  #include <asm/hdreg.h>
> @@ -476,6 +477,7 @@
>  	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
>  	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
>  	unsigned ata_flash	: 1;	/* 1=present, 0=default */
> +	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
>  	unsigned addressing;		/*	: 3;
>  					 *  0=28-bit
>  					 *  1=48-bit
> @@ -528,6 +530,7 @@
>  	unsigned int	max_failures;	/* maximum allowed failure count */
>  	struct list_head list;
>  	struct gendisk *disk;
> +	struct device	device;		/* for driverfs */
>  } ide_drive_t;
>  
>  /*
> @@ -762,6 +765,7 @@
>  	byte		straight8;	/* Alan's straight 8 check */
>  	void		*hwif_data;	/* extra hwif data */
>  	byte		bus_state;	/* power state of the IDE bus */
> +	struct device	device;
>  } ide_hwif_t;
>  
>  /*
> 
> -- 
> Worst form of spam? Adding advertisment signatures ala sourceforge.net.
> What goes next? Inserting advertisment *into* email?
> 

