Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUHJQgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUHJQgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267493AbUHJQfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:35:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267553AbUHJQUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:20:20 -0400
Date: Tue, 10 Aug 2004 12:19:11 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: IDE hackery: lock fixes and hotplug controller stuff
Message-ID: <20040810161911.GA10565@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apply this patch at your peril. Its a work in progress but my IDE exposure
meter is beeping and the sick bucket needs emptying 8)

-	Fix the drivers list locking by using a semaphore/spinlock combo
	to give us the semantics we need to clean up the cases that drop
	it unsafely

-	Assorted code commenting so I can figure out what it does

-	Remove unsafe and essentially unfixable proc code for flipping
	between ide-cd and ide-scsi. Its no longer relevant with SG_IO.

-	Document the lock order

-	ide_unregister is now ide_unregister_hwif and takes a hwif.
	Cleaned up callers. 

-	Added hwif->remove callback so a driver can free resources
	on unload

-	Fixed holes in the proc/config locking

-	Disallow users unregistering pci hotplug hwifs (FIXME: should
	have a "user added" flag instead)

-	Fixed hang in ide-disk when it saw invalid geometry (locking)

-	Added "device has gone away" iops back

-	Quietened the Probing IDE/Wait for ready messages

-	Added check for drives that go M00000000000000000

-	IT8212 driver. Still needs work for non pass through. Alas
	I had to give the 8212D back so only have 8212H now (without
	the raid stuff)

-	Added pci IDE helpers to do hot unplug


diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/drivers/ide/ide.c linux-2.6.8-rc3/drivers/ide/ide.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide.c	2004-08-10 16:46:13.012774496 +0100
@@ -320,13 +320,19 @@
 #endif
 }
 
-/*
- * ide_system_bus_speed() returns what we think is the system VESA/PCI
- * bus speed (in MHz).  This is used for calculating interface PIO timings.
- * The default is 40 for known PCI systems, 50 otherwise.
- * The "idebus=xx" parameter can be used to override this value.
- * The actual value to be used is computed/displayed the first time through.
+/**
+ *	ide_system_bus_speed	-	guess bus speed
+ *
+ *	ide_system_bus_speed() returns what we think is the system VESA/PCI
+ *	bus speed (in MHz).  This is used for calculating interface PIO timings.
+ *	The default is 40 for known PCI systems, 50 otherwise.
+ *	The "idebus=xx" parameter can be used to override this value.
+ *	The actual value to be used is computed/displayed the first time
+ *	through. Drivers should only use this as a last resort.
+ *
+ *	Returns a guessed speed in Mhz
  */
+
 int ide_system_bus_speed (void)
 {
 	if (!system_bus_speed) {
@@ -347,10 +353,15 @@
 	return system_bus_speed;
 }
 
-/*
- * current_capacity() returns the capacity (in sectors) of a drive
- * according to its current geometry/LBA settings.
+/**
+ *	current_capacity	-	drive capacity
+ *	@drive: drive to query
+ *
+ *	Return the current capacity (in sectors) of a drive according to
+ *	its current geometry/LBA settings. Empty removables are reported
+ *	as size zero
  */
+ 
 sector_t current_capacity (ide_drive_t *drive)
 {
 	if (!drive->present)
@@ -360,9 +371,17 @@
 
 EXPORT_SYMBOL(current_capacity);
 
-/*
- * Error reporting, in human readable form (luxurious, but a memory hog).
+/**
+ *	ide_dump_status		-	translate ATA error
+ *	@drive: drive the error occured on
+ *	@msg: information string
+ *	@stat: status byte
+ *
+ *	Error reporting, in human readable form (luxurious, but a memory hog).
+ *	Combines the drive name, message and status byte to provide a
+ *	user understandable explanation of the device error.
  */
+ 
 u8 ide_dump_status (ide_drive_t *drive, const char *msg, u8 stat)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -371,7 +390,6 @@
 
 	local_irq_set(flags);
 	printk(KERN_WARNING "%s: %s: status=0x%02x", drive->name, msg, stat);
-#if FANCY_STATUS_DUMPS
 	printk(" { ");
 	if (stat & BUSY_STAT) {
 		printk("Busy ");
@@ -385,12 +403,10 @@
 		if (stat & ERR_STAT)	printk("Error ");
 	}
 	printk("}");
-#endif	/* FANCY_STATUS_DUMPS */
 	printk("\n");
 	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
 		err = hwif->INB(IDE_ERROR_REG);
 		printk("%s: %s: error=0x%02x", drive->name, msg, err);
-#if FANCY_STATUS_DUMPS
 		if (drive->media == ide_disk) {
 			printk(" { ");
 			if (err & ABRT_ERR)	printk("DriveStatusError ");
@@ -434,7 +450,6 @@
 					printk(", sector=%llu", (unsigned long long)HWGROUP(drive)->rq->sector);
 			}
 		}
-#endif	/* FANCY_STATUS_DUMPS */
 		printk("\n");
 	}
 	local_irq_restore(flags);
@@ -448,31 +463,46 @@
 	return -ENXIO;
 }
 
+/*
+ *	drives_lock protects the list of drives, drivers lock the
+ *	list of drivers. Currently nobody takes both at once.
+ *	drivers_sem guards the drivers_list for readers that may
+ *	sleep. It must be taken before drivers_lock. Take drivers_sem
+ *	before ide_setting_sem and idecfg_sem before either of the
+ *	others.
+ */
+ 
 static spinlock_t drives_lock = SPIN_LOCK_UNLOCKED;
+static DECLARE_MUTEX(drivers_sem);
 static spinlock_t drivers_lock = SPIN_LOCK_UNLOCKED;
+
 static LIST_HEAD(drivers);
 
-/* Iterator */
+/* Iterator for the driver list. */
+
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct list_head *p;
 	loff_t l = *pos;
-	spin_lock(&drivers_lock);
+	down(&drivers_sem);
 	list_for_each(p, &drivers)
 		if (!l--)
 			return list_entry(p, ide_driver_t, drivers);
 	return NULL;
 }
+
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct list_head *p = ((ide_driver_t *)v)->drivers.next;
 	(*pos)++;
 	return p==&drivers ? NULL : list_entry(p, ide_driver_t, drivers);
 }
+
 static void m_stop(struct seq_file *m, void *v)
 {
-	spin_unlock(&drivers_lock);
+	up(&drivers_sem);
 }
+
 static int show_driver(struct seq_file *m, void *v)
 {
 	ide_driver_t *driver = v;
@@ -515,6 +545,7 @@
  *	MMIO leaves it to the controller driver,
  *	PIO will migrate this way over time.
  */
+ 
 int ide_hwif_request_regions(ide_hwif_t *hwif)
 {
 	unsigned long addr;
@@ -564,6 +595,7 @@
  *	importantly our caller should be doing this so we need to 
  *	restructure this as a helper function for drivers.
  */
+
 void ide_hwif_release_regions(ide_hwif_t *hwif)
 {
 	u32 i = 0;
@@ -581,7 +613,15 @@
 			release_region(hwif->io_ports[i], 1);
 }
 
-/* restore hwif to a sane state */
+/**
+ *	ide_hwif_restore	-	restore hwif to template
+ *	@hwif: hwif to update
+ *	@tmp_hwif: template
+ *
+ *	Restore hwif to a default state by copying most settngs
+ *	from the template.
+ */
+ 
 static void ide_hwif_restore(ide_hwif_t *hwif, ide_hwif_t *tmp_hwif)
 {
 	hwif->hwgroup			= tmp_hwif->hwgroup;
@@ -678,15 +718,15 @@
 }
 
 /**
- *	ide_unregister		-	free an ide interface
- *	@index: index of interface (will change soon to a pointer)
+ *	ide_unregister_hwif	-	free an ide interface
+ *	@hwif: interface to unregister
  *
  *	Perform the final unregister of an IDE interface. At the moment
  *	we don't refcount interfaces so this will also get split up.
  *
  *	Locking:
  *	The caller must not hold the IDE locks
- *	The drive present/vanishing is not yet properly locked
+ *	The drive present/vanishing is not yet perfectly locked
  *	Take care with the callbacks. These have been split to avoid
  *	deadlocking the IDE layer. The shutdown callback is called
  *	before we take the lock and free resources. It is up to the
@@ -699,26 +739,21 @@
  *	This is raving bonkers.
  */
 
-void ide_unregister(unsigned int index)
+void ide_unregister_hwif(ide_hwif_t *hwif)
 {
 	ide_drive_t *drive;
-	ide_hwif_t *hwif, *g, *tmp_hwif;
+	ide_hwif_t *g;
 	ide_hwgroup_t *hwgroup;
 	int irq_count = 0, unit, i;
+	int index;	
+	static ide_hwif_t tmp_hwif;	/* Serialized by locking */
 
-	BUG_ON(index >= MAX_HWIFS);
-
-	tmp_hwif = kmalloc(sizeof(*tmp_hwif), GFP_KERNEL|__GFP_NOFAIL);
-	if (!tmp_hwif) {
-		printk(KERN_ERR "%s: unable to allocate memory\n", __FUNCTION__);
-		return;
-	}
-
+	index = hwif->index;
+	
 	BUG_ON(in_interrupt());
 	BUG_ON(irqs_disabled());
 	down(&ide_cfg_sem);
 	spin_lock_irq(&ide_lock);
-	hwif = &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
@@ -729,6 +764,7 @@
 			goto abort;
 		drive->dead = 1;
 	}
+	/* Protect against new users (in part) */
 	hwif->present = 0;
 
 	spin_unlock_irq(&ide_lock);
@@ -757,6 +793,12 @@
 	if (irq_count == 1)
 		free_irq(hwif->irq, hwgroup);
 
+	/*
+	 * Let the driver free up private objects
+	 */
+	if(hwif->remove)
+		hwif->remove(hwif);
+		
 	spin_lock_irq(&ide_lock);
 	/*
 	 * Note that we only release the standard ports,
@@ -845,8 +887,16 @@
 		put_disk(disk);
 	}
 	unregister_blkdev(hwif->major, hwif->name);
+
 	spin_lock_irq(&ide_lock);
 
+	/*
+	 * Let the driver free up private objects
+	 */
+
+	if(hwif->remove)
+		hwif->remove(hwif);
+		
 	if (hwif->dma_base) {
 		(void) ide_release_dma(hwif);
 
@@ -860,22 +910,20 @@
 	}
 
 	/* copy original settings */
-	*tmp_hwif = *hwif;
+	tmp_hwif = *hwif;
 
 	/* restore hwif data to pristine status */
 	init_hwif_data(hwif, index);
 	init_hwif_default(hwif, index);
 
-	ide_hwif_restore(hwif, tmp_hwif);
+	ide_hwif_restore(hwif, &tmp_hwif);
 
 abort:
 	spin_unlock_irq(&ide_lock);
 	up(&ide_cfg_sem);
-
-	kfree(tmp_hwif);
 }
 
-EXPORT_SYMBOL(ide_unregister);
+EXPORT_SYMBOL(ide_unregister_hwif);
 
 
 /**
@@ -931,10 +979,17 @@
  */
 }
 
-/*
- * Register an IDE interface, specifying exactly the registers etc
- * Set init=1 iff calling before probes have taken place.
+/**
+ *	ide_register_hw		-	register IDE interface
+ *	@hw: hardware registers
+ *	@hwifp: pointer to returned hwif
+ *
+ *	Register an IDE interface, specifying exactly the registers etc
+ *	Set init=1 iff calling before probes have taken place.
+ *
+ *	Returns -1 on error.
  */
+ 
 int ide_register_hw (hw_regs_t *hw, ide_hwif_t **hwifp)
 {
 	int index, retry = 1;
@@ -955,12 +1010,15 @@
 				goto found;
 		}
 		for (index = 0; index < MAX_HWIFS; index++)
-			ide_unregister(index);
+		{
+			hwif = &ide_hwifs[index];
+			ide_unregister_hwif(hwif);
+		}
 	} while (retry--);
 	return -1;
 found:
 	if (hwif->present)
-		ide_unregister(index);
+		ide_unregister_hwif(hwif);
 	else if (!hwif->hold) {
 		init_hwif_data(hwif, index);
 		init_hwif_default(hwif, index);
@@ -1008,21 +1066,21 @@
  *	@set: setting
  *
  *	Removes the setting named from the device if it is present.
- *	The function takes the settings_lock to protect against 
- *	parallel changes. This function must not be called from IRQ
- *	context. Returns 0 on success or -1 on failure.
+ *	This function must not be called from IRQ context. Returns 0
+ *	on success or -1 on failure.
  *
  *	BUGS: This code is seriously over-engineered. There is also
  *	magic about how the driver specific features are setup. If
  *	a driver is attached we assume the driver settings are auto
  *	remove.
+ *
+ *	The caller must hold settings_lock
  */
  
 int ide_add_setting (ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
 {
 	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting = NULL;
 
-	down(&ide_setting_sem);
 	while ((*p) && strcmp((*p)->name, name) < 0)
 		p = &((*p)->next);
 	if ((setting = kmalloc(sizeof(*setting), GFP_KERNEL)) == NULL)
@@ -1046,10 +1104,8 @@
 	if (drive->driver != &idedefault_driver)
 		setting->auto_remove = 1;
 	*p = setting;
-	up(&ide_setting_sem);
 	return 0;
 abort:
-	up(&ide_setting_sem);
 	if (setting)
 		kfree(setting);
 	return -1;
@@ -1058,7 +1114,7 @@
 EXPORT_SYMBOL(ide_add_setting);
 
 /**
- *	__ide_remove_setting	-	remove an ide setting option
+ *	ide_remove_setting	-	remove an ide setting option
  *	@drive: drive to use
  *	@name: setting name
  *
@@ -1066,7 +1122,7 @@
  *	The caller must hold the setting semaphore.
  */
  
-static void __ide_remove_setting (ide_drive_t *drive, char *name)
+static void ide_remove_setting (ide_drive_t *drive, char *name)
 {
 	ide_settings_t **p, *setting;
 
@@ -1144,7 +1200,7 @@
 	setting = drive->settings;
 	while (setting) {
 		if (setting->auto_remove) {
-			__ide_remove_setting(drive, setting->name);
+			ide_remove_setting(drive, setting->name);
 			goto repeat;
 		}
 		setting = setting->next;
@@ -1188,6 +1244,15 @@
 	return val;
 }
 
+/**
+ *	ide_spin_wait_hwgroup	-	wait for group
+ *	@drive: drive in the group
+ *
+ *	Wait for an IDE device group to go non busy and then return
+ *	holding the ide_lock which guards the hwgroup->busy status
+ *	and right to use it.
+ */
+ 
 int ide_spin_wait_hwgroup (ide_drive_t *drive)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
@@ -1229,6 +1294,7 @@
  *	to the driver to change settings, and then wait on a sema for completion.
  *	The current scheme of polling is kludgy, though safe enough.
  */
+
 int ide_write_setting (ide_drive_t *drive, ide_settings_t *setting, int val)
 {
 	int i;
@@ -1322,25 +1388,19 @@
 	return err;
 }
 
-int ide_atapi_to_scsi (ide_drive_t *drive, int arg)
-{
-	if (drive->media == ide_disk) {
-		drive->scsi = 0;
-		return 0;
-	}
-
-	if (DRIVER(drive)->cleanup(drive)) {
-		drive->scsi = 0;
-		return 0;
-	}
-
-	drive->scsi = (u8) arg;
-	ata_attach(drive);
-	return 0;
-}
 
+/**
+ *	ide_add_generic_settings	-	generic /proc settings
+ *	@drive: drive being configured
+ *
+ *	Add the generic parts of the system settings to the /proc files
+ *	for this IDE device. The caller must not be holding the settings_sem
+ *	.lock
+ */
+ 
 void ide_add_generic_settings (ide_drive_t *drive)
 {
+	down(&ide_setting_sem);
 /*
  *			drive	setting name		read/write access				read ioctl		write ioctl		data type	min	max				mul_factor	div_factor	data pointer			set function
  */
@@ -1353,10 +1413,17 @@
 	ide_add_setting(drive,	"init_speed",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	70,				1,		1,		&drive->init_speed,		NULL);
 	ide_add_setting(drive,	"current_speed",	SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	70,				1,		1,		&drive->current_speed,		set_xfer_rate);
 	ide_add_setting(drive,	"number",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	3,				1,		1,		&drive->dn,			NULL);
-	if (drive->media != ide_disk)
-		ide_add_setting(drive,	"ide-scsi",		SETTING_RW,					-1,		HDIO_SET_IDE_SCSI,		TYPE_BYTE,	0,	1,				1,		1,		&drive->scsi,			ide_atapi_to_scsi);
+	
+	up(&ide_setting_sem);
 }
 
+/**
+ *	system_bus_clock	-	clock guess
+ *
+ *	External version of the bus clock guess used by old old IDE drivers
+ *	for things like VLB timings. Should not be used.
+ */
+ 
 int system_bus_clock (void)
 {
 	return((int) ((!system_bus_speed) ? ide_system_bus_speed() : system_bus_speed ));
@@ -1364,52 +1431,42 @@
 
 EXPORT_SYMBOL(system_bus_clock);
 
-/*
- *	Locking is badly broken here - since way back.  That sucker is
- * root-only, but that's not an excuse...  The real question is what
- * exclusion rules do we want here.
+/**
+ *	ata_attach		-	attach an ATA/ATAPI device
+ *	@drive: drive to attach
+ *
+ *	Takes a drive that is as yet not assigned to any midlayer IDE
+ *	module and figures out which driver would like to own it. If 
+ *	nobody claims the driver then it is automatically attached
+ *	to the default driver used for unclaimed objects.
+ *
+ *	A return of zero indicates attachment to a driver, of one
+ *	attachment to the default driver
+ *
+ *	Takes the driver list lock and the ide_settings semaphore.
  */
-int ide_replace_subdriver (ide_drive_t *drive, const char *driver)
-{
-	if (!drive->present || drive->usage || drive->dead)
-		goto abort;
-	if (DRIVER(drive)->cleanup(drive))
-		goto abort;
-	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
-	if (ata_attach(drive)) {
-		spin_lock(&drives_lock);
-		list_del_init(&drive->list);
-		spin_unlock(&drives_lock);
-		drive->driver_req[0] = 0;
-		ata_attach(drive);
-	} else {
-		drive->driver_req[0] = 0;
-	}
-	if (DRIVER(drive)!= &idedefault_driver && !strcmp(DRIVER(drive)->name, driver))
-		return 0;
-abort:
-	return 1;
-}
-
+ 
 int ata_attach(ide_drive_t *drive)
 {
 	struct list_head *p;
-	spin_lock(&drivers_lock);
+	down(&drivers_sem);
+	down(&ide_setting_sem);
 	list_for_each(p, &drivers) {
 		ide_driver_t *driver = list_entry(p, ide_driver_t, drivers);
 		if (!try_module_get(driver->owner))
 			continue;
-		spin_unlock(&drivers_lock);
 		if (driver->attach(drive) == 0) {
 			module_put(driver->owner);
 			drive->gendev.driver = &driver->gen_driver;
+			up(&ide_setting_sem);
+			up(&drivers_sem);
 			return 0;
 		}
-		spin_lock(&drivers_lock);
 		module_put(driver->owner);
 	}
 	drive->gendev.driver = &idedefault_driver.gen_driver;
-	spin_unlock(&drivers_lock);
+	up(&ide_setting_sem);
+	up(&drivers_sem);
 	if(idedefault_driver.attach(drive) != 0)
 		panic("ide: default attach failed");
 	return 1;
@@ -1549,8 +1606,11 @@
 		}
 	        case HDIO_UNREGISTER_HWIF:
 			if (!capable(CAP_SYS_RAWIO)) return -EACCES;
-			/* (arg > MAX_HWIFS) checked in function */
-			ide_unregister(arg);
+			if(arg > MAX_HWIFS || arg < 0)
+				return -EINVAL;
+			if(ide_hwifs[arg].pci_dev)
+				return -EINVAL;
+			ide_unregister_hwif(&ide_hwifs[arg]);
 			return 0;
 		case HDIO_SET_NICE:
 			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
@@ -2199,9 +2259,23 @@
 
 EXPORT_SYMBOL(ide_register_subdriver);
 
+/**
+ *	ide_unregister_subdriver	-	disconnect drive from driver
+ *	@drive: drive to unplug
+ *
+ *	Disconnect a drive from the driver it was attached to and then
+ *	clean up the various proc files and other objects attached to it.
+ *	Takes ide_sem, ide_lock, and drive_lock. Caller must hold none of
+ *	the locks.
+ *
+ *	No locking versus subdriver unload because we are moving to the
+ *	default driver anyway. Wants double checking.
+ */
+ 
 int ide_unregister_subdriver (ide_drive_t *drive)
 {
 	unsigned long flags;
+	ide_proc_entry_t *dir;
 	
 	down(&ide_setting_sem);
 	spin_lock_irqsave(&ide_lock, flags);
@@ -2210,13 +2284,14 @@
 		up(&ide_setting_sem);
 		return 1;
 	}
+	dir = DRIVER(drive)->proc;
+	drive->driver = &idedefault_driver;
+	spin_unlock_irqrestore(&ide_lock, flags);
 #ifdef CONFIG_PROC_FS
-	ide_remove_proc_entries(drive->proc, DRIVER(drive)->proc);
+	ide_remove_proc_entries(drive->proc, dir);
 	ide_remove_proc_entries(drive->proc, generic_subdriver_entries);
 #endif
 	auto_remove_settings(drive);
-	drive->driver = &idedefault_driver;
-	spin_unlock_irqrestore(&ide_lock, flags);
 	up(&ide_setting_sem);
 	spin_lock(&drives_lock);
 	list_del_init(&drive->list);
@@ -2234,6 +2309,18 @@
 	return 0;
 }
 
+/**
+ *	ide_register_driver	-	new driver loaded
+ *	@driver: the IDE driver module
+ *
+ *	Register a new driver module and then scan the devices
+ *	on the IDE bus in case any should be attached to the 
+ *	driver we have just attached. If so attach them
+ *
+ *	Takes the drivers and drives lock. Should take the
+ *	ide_sem but doesn't - FIXME
+ */
+ 
 int ide_register_driver(ide_driver_t *driver)
 {
 	struct list_head list;
@@ -2242,9 +2329,11 @@
 
 	setup_driver_defaults(driver);
 
+	down(&drivers_sem);
 	spin_lock(&drivers_lock);
 	list_add(&driver->drivers, &drivers);
 	spin_unlock(&drivers_lock);
+	up(&drivers_sem);
 
 	INIT_LIST_HEAD(&list);
 	spin_lock(&drives_lock);
@@ -2265,13 +2354,25 @@
 
 EXPORT_SYMBOL(ide_register_driver);
 
+/**
+ *	ide_unregister_driver	-	IDE module unload
+ *	@driver: IDE driver module
+ *
+ *	Unload a driver module and reattach any devices to whatever
+ *	driver claims them next (typically the default driver). Takes
+ *	the drivers lock, and called functions will take the 
+ *	IDE setting semaphore.
+ */
+ 
 void ide_unregister_driver(ide_driver_t *driver)
 {
 	ide_drive_t *drive;
 
+	down(&drivers_sem);
 	spin_lock(&drivers_lock);
 	list_del(&driver->drivers);
 	spin_unlock(&drivers_lock);
+	up(&drivers_sem);
 
 	driver_unregister(&driver->gen_driver);
 
@@ -2385,7 +2486,7 @@
 	int index;
 
 	for (index = 0; index < MAX_HWIFS; ++index) {
-		ide_unregister(index);
+		ide_unregister_hwif(&ide_hwifs[index]);
 		if (ide_hwifs[index].dma_base)
 			(void) ide_release_dma(&ide_hwifs[index]);
 	}
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/drivers/ide/ide-disk.c linux-2.6.8-rc3/drivers/ide/ide-disk.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-disk.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-disk.c	2004-08-10 14:30:57.705488728 +0100
@@ -1723,11 +1723,10 @@
 	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n",
 			drive->name, drive->head);
-		ide_cacheflush_p(drive);
-		ide_unregister_subdriver(drive);
-		DRIVER(drive)->busy--;
-		goto failed;
+		drive->attach = 0;
 	}
+	else
+		drive->attach = 1;
 	DRIVER(drive)->busy--;
 	g->minors = 1 << PARTN_BITS;
 	strcpy(g->devfs_name, drive->devfs_name);
@@ -1735,7 +1734,6 @@
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	set_capacity(g, current_capacity(drive));
 	g->fops = &idedisk_ops;
-	drive->attach = 1;
 	add_disk(g);
 	return 0;
 failed:
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/drivers/ide/ide-iops.c linux-2.6.8-rc3/drivers/ide/ide-iops.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-iops.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-iops.c	2004-08-10 16:47:57.560880768 +0100
@@ -107,6 +107,74 @@
 EXPORT_SYMBOL(default_hwif_iops);
 
 /*
+ *	Conventional PIO operations for ATA devices
+ */
+
+static u8 ide_no_inb(unsigned long port)
+{
+	return 0xFF;
+}
+
+static u16 ide_no_inw (unsigned long port)
+{
+	return 0xFFFF;
+}
+
+static void ide_no_insw (unsigned long port, void *addr, u32 count)
+{
+}
+
+static u32 ide_no_inl (unsigned long port)
+{
+	return 0xFFFFFFFF;
+}
+
+static void ide_no_insl (unsigned long port, void *addr, u32 count)
+{
+}
+
+static void ide_no_outb (u8 val, unsigned long port)
+{
+}
+
+static void ide_no_outbsync (ide_drive_t *drive, u8 addr, unsigned long port)
+{
+}
+
+static void ide_no_outw (u16 val, unsigned long port)
+{
+}
+
+static void ide_no_outsw (unsigned long port, void *addr, u32 count)
+{
+}
+
+static void ide_no_outl (u32 val, unsigned long port)
+{
+}
+
+static void ide_no_outsl (unsigned long port, void *addr, u32 count)
+{
+}
+
+void removed_hwif_iops (ide_hwif_t *hwif)
+{
+	hwif->OUTB	= ide_no_outb;
+	hwif->OUTBSYNC	= ide_no_outbsync;
+	hwif->OUTW	= ide_no_outw;
+	hwif->OUTL	= ide_no_outl;
+	hwif->OUTSW	= ide_no_outsw;
+	hwif->OUTSL	= ide_no_outsl;
+	hwif->INB	= ide_no_inb;
+	hwif->INW	= ide_no_inw;
+	hwif->INL	= ide_no_inl;
+	hwif->INSW	= ide_no_insw;
+	hwif->INSL	= ide_no_insl;
+}
+
+EXPORT_SYMBOL(removed_hwif_iops);
+
+/*
  *	MMIO operations, typically used for SATA controllers
  */
 
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c linux-2.6.8-rc3/drivers/ide/ide-probe.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-10 15:48:11.511043208 +0100
@@ -635,12 +635,11 @@
 	device_register(&hwif->gendev);
 }
 
-#ifdef CONFIG_PPC
 static int wait_hwif_ready(ide_hwif_t *hwif)
 {
 	int rc;
 
-	printk(KERN_INFO "Probing IDE interface %s...\n", hwif->name);
+	printk(KERN_DEBUG "Probing IDE interface %s...\n", hwif->name);
 
 	/* Let HW settle down a bit from whatever init state we
 	 * come from */
@@ -671,7 +670,6 @@
 	
 	return rc;
 }
-#endif
 
 /*
  * This routine only knows how to look for drive units 0 and 1
@@ -717,7 +715,6 @@
 
 	local_irq_set(flags);
 
-#ifdef CONFIG_PPC
 	/* This is needed on some PPCs and a bunch of BIOS-less embedded
 	 * platforms. Typical cases are:
 	 * 
@@ -738,8 +735,7 @@
 	 *  BenH.
 	 */
 	if (wait_hwif_ready(hwif))
-		printk(KERN_WARNING "%s: Wait for ready failed before probe !\n", hwif->name);
-#endif /* CONFIG_PPC */
+		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
 
 	/*
 	 * Second drive should only exist if first drive was found,
@@ -749,6 +745,20 @@
 		ide_drive_t *drive = &hwif->drives[unit];
 		drive->dn = (hwif->channel ? 2 : 0) + unit;
 		(void) probe_for_drive(drive);
+		if (drive->present && hwif->present && unit == 1)
+		{
+			if(strcmp(hwif->drives[0].id->model, drive->id->model) == 0 &&
+			   /* Don't do this for noprobe or non ATA */
+			   strcmp(drive->id->model, "UNKNOWN") &&
+			   /* And beware of confused Maxtor drives that go "M0000000000" 
+			      "The SN# is garbage in the ID block..." [Eric] */
+			   strncmp(drive->id->serial_no, "M0000000000000000000", 20) && 
+			   strncmp(hwif->drives[0].id->serial_no, drive->id->serial_no, 20) == 0)
+			{
+				printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
+				drive->present = 0;
+			}
+		}
 		if (drive->present && !hwif->present) {
 			hwif->present = 1;
 			if (hwif->chipset != ide_4drives ||
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/drivers/ide/ide-proc.c linux-2.6.8-rc3/drivers/ide/ide-proc.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-proc.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-proc.c	2004-08-10 14:44:23.792944808 +0100
@@ -573,24 +573,6 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
-static int proc_ide_write_driver
-	(struct file *file, const char __user *buffer, unsigned long count, void *data)
-{
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	char name[32];
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-	if (count > 31)
-		count = 31;
-	if (copy_from_user(name, buffer, count))
-		return -EFAULT;
-	name[count] = '\0';
-	if (ide_replace_subdriver(drive, name))
-		return -EINVAL;
-	return count;
-}
-
 static int proc_ide_read_media
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -616,7 +598,7 @@
 }
 
 static ide_proc_entry_t generic_drive_entries[] = {
-	{ "driver",	S_IFREG|S_IRUGO,	proc_ide_read_driver,	proc_ide_write_driver },
+	{ "driver",	S_IFREG|S_IRUGO,	proc_ide_read_driver,	NULL },
 	{ "identify",	S_IFREG|S_IRUSR,	proc_ide_read_identify,	NULL },
 	{ "media",	S_IFREG|S_IRUGO,	proc_ide_read_media,	NULL },
 	{ "model",	S_IFREG|S_IRUGO,	proc_ide_read_dmodel,	NULL },
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/drivers/ide/Kconfig linux-2.6.8-rc3/drivers/ide/Kconfig
--- linux.vanilla-2.6.8-rc3/drivers/ide/Kconfig	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/Kconfig	2004-08-09 19:49:32.000000000 +0100
@@ -621,6 +621,12 @@
 	  <http://www.ite.com.tw/ia/brief_it8172bsp.htm>; picture of the
 	  board at <http://www.mvista.com/partners/semiconductor/ite.html>.
 
+config BLK_DEV_IT8212
+	tristate "IT8212 IDE support"
+	help
+	  This driver adds support for the ITE 8212 IDE RAID controller in
+	  both RAID and pass-through mode. 
+
 config BLK_DEV_NS87415
 	tristate "NS87415 chipset support"
 	help
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/drivers/ide/legacy/ide-cs.c linux-2.6.8-rc3/drivers/ide/legacy/ide-cs.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/legacy/ide-cs.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/legacy/ide-cs.c	2004-08-10 16:43:56.923463216 +0100
@@ -90,6 +90,7 @@
     int		ndev;
     dev_node_t	node;
     int		hd;
+    ide_hwif_t *hwif;
 } ide_info_t;
 
 static void ide_release(dev_link_t *);
@@ -199,14 +200,14 @@
     
 } /* ide_detach */
 
-static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq)
+static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq, ide_hwif_t **hwif)
 {
     hw_regs_t hw;
     memset(&hw, 0, sizeof(hw));
     ide_init_hwif_ports(&hw, io, ctl, NULL);
     hw.irq = irq;
     hw.chipset = ide_pci;
-    return ide_register_hw(&hw, NULL);
+    return ide_register_hw(&hw, hwif);
 }
 
 /*======================================================================
@@ -224,6 +225,7 @@
 {
     client_handle_t handle = link->handle;
     ide_info_t *info = link->priv;
+    ide_hwif_t *hwif;
     tuple_t tuple;
     struct {
 	u_short		buf[128];
@@ -343,14 +345,17 @@
     if (is_kme)
 	outb(0x81, ctl_base+1);
 
-    /* retry registration in case device is still spinning up */
+    /* retry registration in case device is still spinning up 
+    
+       FIXME: now handled by IDE layer... ?? */
+       
     for (hd = -1, i = 0; i < 10; i++) {
-	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
+	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ, &hwif);
 	if (hd >= 0) break;
 	if (link->io.NumPorts1 == 0x20) {
 	    outb(0x02, ctl_base + 0x10);
 	    hd = idecs_register(io_base + 0x10, ctl_base + 0x10,
-				link->irq.AssignedIRQ);
+				link->irq.AssignedIRQ, &hwif);
 	    if (hd >= 0) {
 		io_base += 0x10;
 		ctl_base += 0x10;
@@ -373,6 +378,7 @@
     info->node.major = ide_major[hd];
     info->node.minor = 0;
     info->hd = hd;
+    info->hwif = hwif;
     link->dev = &info->node;
     printk(KERN_INFO "ide-cs: %s: Vcc = %d.%d, Vpp = %d.%d\n",
 	   info->node.dev_name, link->conf.Vcc / 10, link->conf.Vcc % 10,
@@ -411,7 +417,7 @@
     if (info->ndev) {
 	/* FIXME: if this fails we need to queue the cleanup somehow
 	   -- need to investigate the required PCMCIA magic */
-	ide_unregister(info->hd);
+	ide_unregister_hwif(info->hwif);
 	/* deal with brain dead IDE resource management */
 	request_region(link->io.BasePort1, link->io.NumPorts1,
 		       info->node.dev_name);
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/drivers/ide/pci/it8212.c linux-2.6.8-rc3/drivers/ide/pci/it8212.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/it8212.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/it8212.c	2004-08-10 16:45:23.055369176 +0100
@@ -0,0 +1,758 @@
+/*
+ * linux/drivers/ide/pci/it8212.c		Version 0.02	August 2004
+ *
+ * Copyright (C) 2004		Red Hat <alan@redhat.com>
+ *
+ *  May be copied or modified under the terms of the GNU General Public License
+ *
+ *  Documentation available from
+ * 	http://www.ite.com.tw/pc/IT8212F_V04.pdf
+ *
+ *  The ITE8212 isn't exactly a standard IDE controller. It has two
+ *  modes. In pass through mode then it is an IDE controller. In its smart
+ *  mode its actually quite a capable hardware raid controller disguised
+ *  as an IDE controller.
+ *
+ *  Errata:
+ *	Rev 0x10 also requires master/slave use the same UDMA timing and
+ *	cannot do ATAPI DMA, while the other revisions can do ATAPI UDMA
+ *	but not MWDMA.
+ *
+ *  This has a few impacts on the driver
+ *  - In pass through mode we do all the work you would expect
+ *  - In smart mode the clocking set up is done by the controller generally
+ *  - There are a few extra vendor commands that actually talk to the 
+ *    controller but only work PIO with no IRQ.
+ *
+ *  Vendor areas of the identify block in smart mode are used for the
+ *  timing and policy set up. Each HDD in raid mode also has a serial
+ *  block on the disk. The hardware extra commands are get/set chip status,
+ *  rebuild, get rebuild status.
+ *
+ *  In Linux the driver supports pass through mode as if the device was
+ *  just another IDE controller. If the smart mode is running then
+ *  volumes are managed by the controller firmware and each IDE "disk"
+ *  is a raid volume. Even more cute - the controller can do automated
+ *  hotplug and rebuild.
+ *
+ *  The pass through controller itself is a little demented. It has a
+ *  flaw that it has a single set of PIO/MWDMA timings per channel so
+ *  non UDMA devices restrict each others performance. It also has a 
+ *  single clock source per channel so mixed UDMA100/133 performance
+ *  isn't perfect and we have to pick a clock. Thankfully none of this
+ *  matters in smart mode. ATAPI DMA is not supported. 
+ *
+ *  TODO
+ *	-	Rev 0x10 in pass through mode needs UDMA clock whacking
+ *		to work around h/w issues
+ *	-	Is rev 0x10 out anywhere - test it if so
+ *	-	More testing
+ *	-	Find an Innovision 8401D r R board somewhere to test that
+ *	-	See if we can kick the cheapo board into smart mode
+ *		ourselves 8)
+ *	-	ATAPI UDMA is ok but not MWDMA it seems
+ *	-	RAID configuration ioctls
+ */
+ 
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/hdreg.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+
+struct it8212_dev
+{
+	int	smart:1,		/* Are we in smart raid mode */
+		timing10:1;		/* Rev 0x10 */
+	u8	clock_mode;		/* 0, ATA_50 or ATA_66 */
+	u8	want[2][2];		/* Mode/Pri log for master slave */
+	/* We need these for switching the clock when DMA goes on/off 
+	   The high byte is the 66Mhz timing */
+	u16	pio[2];			/* Cached PIO values */
+	u16	mwdma[2];		/* Cached MWDMA values */
+	u16	udma[2];		/* Cached UDMA values (per drive) */
+};
+
+#define ATA_66		0
+#define ATA_50		1
+#define ATA_ANY		2
+
+#define UDMA_OFF	0
+#define MWDMA_OFF	0
+
+
+/**
+ *	it8212_program	-	program the PIO/MWDMA registers
+ *	@drive: drive to tune
+ *
+ *	Program the PIO/MWDMA timing for this channel according to the
+ *	current clock.
+ */
+ 
+static void it8212_program(ide_drive_t *drive, u16 timing)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct it8212_dev *itdev = ide_get_hwifdata(hwif);
+	int channel = hwif->channel;
+	u8 conf;
+	
+	/* Program PIO/MWDMA timing bits */
+	if(itdev->clock_mode == ATA_66)
+		conf = timing >> 8;
+	else	
+		conf = timing & 0xFF;
+	pci_write_config_byte(hwif->pci_dev, 0x54 + 4 * channel, conf);
+}
+
+/**
+ *	it8212_program	-	program the PIO/MWDMA registers
+ *	@drive: drive to tune
+ *
+ *	Program the UDMA timing for this drive according to the
+ *	current clock.
+ */
+ 
+static void it8212_program_udma(ide_drive_t *drive, u16 timing)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct it8212_dev *itdev = ide_get_hwifdata(hwif);
+	int channel = hwif->channel;
+	int unit = drive->select.b.unit;
+	u8 conf;
+	
+	/* Program UDMA timing bits */
+	if(itdev->clock_mode == ATA_66)
+		conf = timing >> 8;
+	else
+		conf = timing & 0xFF;
+	pci_write_config_byte(hwif->pci_dev, 0x56 + 4 * channel + unit, conf);
+}
+
+
+/**
+ *	it8212_clock_strategy
+ *	@hwif: hardware interface
+ *
+ *	Select between the 50 and 66Mhz base clocks to get the best
+ *	results for this interface.
+ */
+ 
+static void it8212_clock_strategy(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct it8212_dev *itdev = ide_get_hwifdata(hwif);
+
+	u8 unit = drive->select.b.unit;
+	ide_drive_t *pair = &hwif->drives[1-unit];
+
+	int clock, altclock;
+	u8 v;
+	int sel = 0;
+
+	if(itdev->want[0][0] > itdev->want[1][0])
+	{
+		clock = itdev->want[0][1];
+		altclock = itdev->want[1][1];
+	}
+	else
+	{
+		clock = itdev->want[1][1];
+		altclock = itdev->want[0][1];
+	}
+
+	/* Master doesn't care does the secondary ? */
+	if(clock == ATA_ANY)
+		clock = altclock;
+		
+	/* Nobody cares - keep the same clock */
+	if(clock == ATA_ANY)
+		return;
+	/* No change */
+	if(clock == itdev->clock_mode)
+		return;
+		
+	/* Load this into the controller ? */
+	if(clock == ATA_66)
+		itdev->clock_mode = ATA_66;
+	else
+	{
+		itdev->clock_mode = ATA_50;
+		sel = 1;
+	}
+	pci_read_config_byte(hwif->pci_dev, 0x50, &v);
+	v &= ~(1 << (1 + hwif->channel));
+	v |= sel << (1 + hwif->channel);
+	pci_write_config_byte(hwif->pci_dev, 0x50, v);
+	printk(KERN_INFO "it8212: selected %dMHz clock.\n", itdev->clock_mode == ATA_66?66:50);
+	
+	/*
+	 *	Reprogram the UDMA/PIO of the pair drive for the switch
+	 *	MWDMA will be dealt with by the dma switcher
+	 */
+	if(pair && itdev->udma[1-unit] != UDMA_OFF)
+	{
+		it8212_program_udma(pair, itdev->udma[1-unit]);
+		it8212_program(pair, itdev->pio[1-unit]);
+	}
+	/*
+	 *	Reprogram the UDMA/PIO of our drive for the switch.
+	 *	MWDMA will be dealt with by the dma switcher
+	 */
+	if(itdev->udma[unit] != UDMA_OFF)
+	{
+		it8212_program_udma(drive, itdev->udma[unit]);
+		it8212_program(drive, itdev->pio[unit]);
+	}
+}
+
+/**
+ *	it8212_ratemask	-	Compute available modes
+ *	@drive: IDE drive
+ *
+ *	Compute the available speeds for the devices on the interface. This
+ *	is all modes to ATA133 clipped by drive cable setup.
+ */
+ 
+static byte it8212_ratemask (ide_drive_t *drive)
+{
+	u8 mode	= 4;
+	if (!eighty_ninty_three(drive))
+		mode = min(mode, (u8)1);
+	return mode;
+}
+
+/**
+ *	it8212_tuneproc	-	tune a drive 
+ *	@drive: drive to tune
+ *	@mode_wanted: the target operating mode
+ *
+ *	Load the timing settings for this device mode into the
+ *	controller. By the time we are called the mode has been 
+ *	modified as neccessary to handle the absence of seperate
+ *	master/slave timers for MWDMA/PIO.
+ *
+ *	This code is only used in pass through mode.
+ */
+ 
+static void it8212_tuneproc (ide_drive_t *drive, byte mode_wanted)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct it8212_dev *itdev = ide_get_hwifdata(hwif);
+	int unit = drive->select.b.unit;
+	
+	/* Spec says 89 ref driver uses 88 */
+	static u16 pio[]	= { 0xAA88, 0xA382, 0xA181, 0x3332, 0x3121 };
+	static u8 pio_want[]    = { ATA_66, ATA_66, ATA_66, ATA_66, ATA_ANY };
+	
+	/* We prefer 66Mhz clock for PIO 0-3, don't care for PIO4 */
+	itdev->want[unit][1] = pio_want[mode_wanted];
+	itdev->want[unit][0] = 1;	/* PIO is lowest priority */
+	itdev->pio[unit] = pio[mode_wanted];
+	it8212_clock_strategy(drive);
+	it8212_program(drive, itdev->pio[unit]);
+}
+
+/**
+ *	it8212_tune_mwdma	-	tune a channel for MWDMA
+ *	@drive: drive to set up
+ *	@mode_wanted: the target operating mode
+ *
+ *	Load the timing settings for this device mode into the
+ *	controller when doing MWDMA in pass through mode. The caller
+ *	must manage the whole lack of per device MWDMA/PIO timings and
+ *	the shared MWDMA/PIO timing register.
+ */
+ 
+static void it8212_tune_mwdma (ide_drive_t *drive, byte mode_wanted)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct it8212_dev *itdev = (void *)ide_get_hwifdata(hwif);
+	int unit = drive->select.b.unit;
+	int channel = hwif->channel;
+	u8 conf;
+	
+	static u16 dma[]	= { 0x8866, 0x3222, 0x3121 };
+	static u8 mwdma_want[]	= { ATA_ANY, ATA_66, ATA_ANY };
+	
+	itdev->want[unit][1] = mwdma_want[mode_wanted];
+	itdev->want[unit][0] = 2;	/* MWDMA is low priority */
+	itdev->mwdma[unit] = dma[mode_wanted];
+	itdev->udma[unit] = UDMA_OFF;
+	
+	/* UDMA bits off */
+	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
+	conf |= 1 << (3 + 2 * channel + unit);
+	pci_write_config_byte(hwif->pci_dev, 0x50, conf);
+
+	it8212_clock_strategy(drive);
+	/* FIXME: do we need to program this ? */
+	it8212_program(drive, itdev->mwdma[unit]);
+}
+
+/**
+ *	it8212_tune_udma	-	tune a channel for UDMA
+ *	@drive: drive to set up
+ *	@mode_wanted: the target operating mode
+ *
+ *	Load the timing settings for this device mode into the
+ *	controller when doing UDMA modes in pass through.
+ */
+ 
+static void it8212_tune_udma (ide_drive_t *drive, byte mode_wanted)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct it8212_dev *itdev = ide_get_hwifdata(hwif);
+	int unit = drive->select.b.unit;
+	int channel = hwif->channel;
+	u8 conf;
+
+	static u16 udma[]	= { 0x4433, 0x4231, 0x3121, 0x2121, 0x1111, 0x2211, 0x1111 };
+	static u8 udma_want[]	= { ATA_ANY, ATA_50, ATA_ANY, ATA_66, ATA_66, ATA_50, ATA_66 };
+	
+	itdev->want[unit][1] = udma_want[mode_wanted];
+	itdev->want[unit][0] = 3;	/* UDMA is high priority */
+	itdev->mwdma[unit] = MWDMA_OFF;
+	itdev->udma[unit] = udma[mode_wanted];
+	if(mode_wanted >= 5)
+		itdev->udma[unit] |= 0x8080;	/* UDMA 5/6 select on */
+		
+	/* UDMA on */
+	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
+	conf &= ~ (1 << (3 + 2 * channel + unit));
+	pci_write_config_byte(hwif->pci_dev, 0x50, conf);
+
+	it8212_clock_strategy(drive);
+	it8212_program_udma(drive, itdev->udma[unit]);
+	
+}
+
+/**
+ *	config_it8212_chipset_for_pio	-	set drive timings
+ *	@drive: drive to tune
+ *	@speed we want
+ *
+ *	Compute the best pio mode we can for a given device. We must
+ *	pick a speed that does not cause problems with the other device
+ *	on the cable.
+ */
+ 
+static void config_it8212_chipset_for_pio (ide_drive_t *drive, byte set_speed)
+{
+	u8 unit = drive->select.b.unit;
+	ide_hwif_t *hwif = HWIF(drive);
+	ide_drive_t *pair = &hwif->drives[1-unit];
+	struct it8212_dev *itdev = ide_get_hwifdata(hwif);
+	u8 speed = 0, set_pio	= ide_get_best_pio_mode(drive, 4, 5, NULL);
+	u8 pair_pio;
+	
+	/* We have to deal with this mess in pairs */
+	if(pair != NULL)
+	{
+		pair_pio = ide_get_best_pio_mode(pair, 4, 5, NULL);
+		/* Trim PIO to the slowest of the master/slave */
+		if(pair_pio < set_pio)
+			set_pio = pair_pio;
+	}
+	if(!itdev->smart)
+		it8212_tuneproc(drive, set_pio);
+	speed = XFER_PIO_0 + set_pio;
+	/* XXX - We trim to the lowest of the pair so the other drive
+	   will always be fine at this point until we do hotplug passthru */
+	   
+	if (set_speed)
+		(void) ide_config_drive_speed(drive, speed);
+}
+
+static void config_chipset_for_pio (ide_drive_t *drive, byte set_speed)
+{
+	config_it8212_chipset_for_pio(drive, set_speed);
+}
+
+/**
+ *	it8212_dma_read	-	DMA hook
+ *	@drive: drive for DMA
+ *
+ *	The IT8212 has a single timing register for MWDMA and for PIO
+ *	operations. As we flip back and forth we have to reload the
+ *	clock.
+ *
+ *	FIXME: for 0x10 model we should reprogram UDMA here
+ */
+ 
+static int it8212_dma_begin(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct it8212_dev *itdev = ide_get_hwifdata(hwif);
+	int unit = drive->select.b.unit;
+	if(itdev->mwdma[unit] != MWDMA_OFF)
+		it8212_program(drive, itdev->mwdma[unit]);
+	return __ide_dma_begin(drive);
+}
+
+/**
+ *	it8212_dma_write	-	DMA hook
+ *	@drive: drive for DMA stop
+ *
+ *	The IT8212 has a single timing register for MWDMA and for PIO
+ *	operations. As we flip back and forth we have to reload the
+ *	clock.
+ *
+ *	FIXME: for 0x10 model we should reprogram UDMA here
+ */
+ 
+static int it8212_dma_end(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	int unit = drive->select.b.unit;
+	struct it8212_dev *itdev = ide_get_hwifdata(hwif);
+	int ret = __ide_dma_end(drive);
+	if(itdev->mwdma[unit] != MWDMA_OFF)
+		it8212_program(drive, itdev->pio[unit]);
+	return ret;
+}
+
+	
+/**
+ *	it8212_tune_chipset	-	set controller timings
+ *	@drive: Drive to set up
+ *	@xferspeed: speed we want to achieve
+ *
+ *	Tune the ITE chipset for the desired mode. If we can't achieve
+ *	the desired mode then tune for a lower one, but ultimately
+ *	make the thing work.
+ */
+ 
+static int it8212_tune_chipset (ide_drive_t *drive, byte xferspeed)
+{
+
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct it8212_dev *itdev = ide_get_hwifdata(hwif);
+	u8 speed		= ide_rate_filter(it8212_ratemask(drive), xferspeed);
+				    
+	switch(speed) {
+		case XFER_PIO_4:
+		case XFER_PIO_3:
+		case XFER_PIO_2:
+		case XFER_PIO_1:
+		case XFER_PIO_0:
+			if(!itdev->smart)
+				it8212_tuneproc(drive, (speed - XFER_PIO_0));
+			break;
+		/* MWDMA tuning is really hard because our MWDMA and PIO
+		   timings are kept in the same place. We can switch in the 
+		   host dma on/off callbacks */
+		case XFER_MW_DMA_2:
+		case XFER_MW_DMA_1:
+		case XFER_MW_DMA_0:
+			if(!itdev->smart)
+				it8212_tune_mwdma(drive, (speed - XFER_MW_DMA_0));
+			break;
+		case XFER_UDMA_6:
+		case XFER_UDMA_5:
+		case XFER_UDMA_4:
+		case XFER_UDMA_3:
+		case XFER_UDMA_2:
+		case XFER_UDMA_1:
+		case XFER_UDMA_0:
+			if(!itdev->smart)
+				it8212_tune_udma(drive, (speed - XFER_UDMA_0));
+			break;
+		default:
+			return 1;
+	}
+	/*
+	 *	In smart mode the clocking is done by the host controller
+	 * 	snooping the mode we picked. The rest of it is not our problem
+	 */
+	return (ide_config_drive_speed(drive, speed));
+}
+
+/**
+ *	config_chipset_for_dma	-	configure for DMA
+ *	@drive: drive to configure
+ *
+ *	Called by the IDE layer when it wants the timings set up.
+ */
+ 
+static int config_chipset_for_dma (ide_drive_t *drive)
+{
+	u8 speed	= ide_dma_speed(drive, it8212_ratemask(drive));
+
+	config_chipset_for_pio(drive, !speed);
+
+	if (!speed)
+		return 0;
+
+	if (ide_set_xfer_rate(drive, speed))
+		return 0;
+
+	if (!drive->init_speed)
+		drive->init_speed = speed;
+
+	return ide_dma_enable(drive);
+}
+
+/**
+ *	it8212_configure_drive_for_dma	-	set up for DMA transfers
+ *	@drive: drive we are going to set up
+ *
+ *	Set up the drive for DMA, tune the controller and drive as 
+ *	required. If the drive isn't suitable for DMA or we hit
+ *	other problems then we will drop down to PIO and set up
+ *	PIO appropriately
+ */
+ 
+static int it8212_config_drive_for_dma (ide_drive_t *drive)
+{
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct hd_driveid *id	= drive->id;
+
+	if ((id->capability & 1) != 0 && drive->autodma) {
+		/* Consult the list of known "bad" drives */
+		if (__ide_dma_bad_drive(drive))
+			goto fast_ata_pio;
+
+		if ((id->field_valid & 4) && it8212_ratemask(drive)) {
+			if (id->dma_ultra & hwif->ultra_mask) {
+				/* Force if Capable UltraDMA */
+				int dma = config_chipset_for_dma(drive);
+				if ((id->field_valid & 2) && !dma)
+					goto try_dma_modes;
+			}
+		} else if (id->field_valid & 2) {
+try_dma_modes:
+			if ((id->dma_mword & hwif->mwdma_mask) ||
+			    (id->dma_1word & hwif->swdma_mask)) {
+				/* Force if Capable regular DMA modes */
+				if (!config_chipset_for_dma(drive))
+					goto no_dma_set;
+			}
+		} else if (__ide_dma_good_drive(drive) &&
+			   (id->eide_dma_time < 150)) {
+			/* Consult the list of known "good" drives */
+			if (!config_chipset_for_dma(drive))
+				goto no_dma_set;
+		} else {
+			goto fast_ata_pio;
+		}
+		return hwif->ide_dma_on(drive);
+	} else if ((id->capability & 8) || (id->field_valid & 2)) {
+fast_ata_pio:
+no_dma_set:
+		config_chipset_for_pio(drive, 1);
+		return hwif->ide_dma_off_quietly(drive);
+	}
+	/* IORDY not supported */
+	return 0;
+}
+
+/**
+ *	init_chipset_it8212	-	set up an ITE device
+ *	@dev: PCI device
+ *	@name: device name
+ *
+ */
+
+static unsigned int __devinit init_chipset_it8212(struct pci_dev *dev, const char *name)
+{
+	return 0;
+}
+
+/**
+ *	ata66_it8212	-	check for 80 pin cable
+ *	@hwif: interface to check
+ *
+ *	Check for the presence of an ATA66 capable cable on the
+ *	interface. Note that the firmware writes bits 4-7 having done 
+ *	the drive side sampling. This may impact hotplug.
+ */
+
+static unsigned int __devinit ata66_it8212(ide_hwif_t *hwif)
+{
+	/* The reference driver also only does disk side */
+	return 1;
+}
+
+/**
+ *	it8212_memfree		-	free resources
+ *	@hwif: hwif to clean up
+ *
+ *	Called during the shutdown of an IDE interface at the later
+ *	stages so that we can clean up resources
+ */
+ 
+static void __devinit it8212_memfree(ide_hwif_t *hwif)
+{
+	void *p = ide_get_hwifdata(hwif);
+	ide_set_hwifdata(hwif, NULL);
+	kfree(p);
+}
+
+/**
+ *	init_hwif_it8212	-	set up hwif structs
+ *	@hwif: interface to set up
+ *
+ *	We do the basic set up of the interface structure. The IT8212
+ *	requires several custom handlers so we override the default
+ *	ide DMA handlers appropriately
+ */
+
+static void __devinit init_hwif_it8212(ide_hwif_t *hwif)
+{
+	struct it8212_dev *idev = kmalloc(sizeof(struct it8212_dev), GFP_KERNEL);
+	u8 conf;
+	
+	if(idev == NULL)
+	{
+		printk(KERN_ERR "it8212: out of memory, falling back to legacy behaviour.\n");
+		goto fallback;
+	}
+	memset(idev, 0, sizeof(*idev));
+	ide_set_hwifdata(hwif, idev);
+	
+	hwif->remove = it8212_memfree;
+	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
+	if(conf & 1)
+	{
+		if(hwif->channel == 0)
+			printk(KERN_INFO "it8212: controller in smart mode.\n");
+		idev->smart = 1;
+	}
+	else if(hwif->channel == 0)
+		printk(KERN_INFO "it8212: controller in pass through mode.\n");
+		
+	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
+	if (conf & (1 << (1 + hwif->channel)))
+		idev->clock_mode = ATA_50;
+	else
+		idev->clock_mode = ATA_66;
+		
+	idev->want[0][1] = ATA_ANY;
+	idev->want[1][1] = ATA_ANY;
+		
+	printk(KERN_INFO "it8212: BIOS seleted a %dMHz clock.\n", idev->clock_mode == ATA_66 ? 66:50);
+	/*
+	 *	Not in the docs but according to the reference driver
+	 *	this is neccessary.
+	 */
+	pci_read_config_byte(hwif->pci_dev, 0x08, &conf);
+	if(conf == 0x10)
+		idev->timing10 = 1;
+#if 0	/* Needs more research */
+	else
+		hwif->atapi_dma = 1;
+#endif
+
+	if(idev->timing10 && !idev->smart)
+	{
+		printk(KERN_WARNING "it8212: DMA is not currently supported on revision 0x10 in pass through.\n");
+		goto fallback;
+	}
+		
+	hwif->speedproc = &it8212_tune_chipset;
+	hwif->tuneproc	= &it8212_tuneproc;
+	
+	/* MWDMA/PIO clock switching for pass through mode */
+	if(!idev->smart)
+	{
+		hwif->ide_dma_begin = &it8212_dma_begin;
+		hwif->ide_dma_end = &it8212_dma_end;
+	}
+
+	if (!hwif->dma_base)
+		goto fallback;
+
+	hwif->ultra_mask = 0x7f;
+	hwif->mwdma_mask = 0x07;
+	hwif->swdma_mask = 0x07;
+
+	hwif->ide_dma_check = &it8212_config_drive_for_dma;
+	if (!(hwif->udma_four))
+		hwif->udma_four = ata66_it8212(hwif);
+
+	/*
+	 *	The BIOS often doesn't set up DMA on this controller
+	 *	so we always do it.
+	 */
+
+	hwif->autodma = 1;
+	hwif->drives[0].autodma = hwif->autodma;
+	hwif->drives[1].autodma = hwif->autodma;
+	return;
+
+fallback:
+	hwif->autodma = 0;
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
+	return;
+}
+
+#define DECLARE_ITE_DEV(name_str)			\
+	{						\
+		.name		= name_str,		\
+		.init_chipset	= init_chipset_it8212,	\
+		.init_hwif	= init_hwif_it8212,	\
+		.channels	= 2,			\
+		.autodma	= AUTODMA,		\
+		.bootable	= ON_BOARD,		\
+	}
+
+static ide_pci_device_t it8212_chipsets[] __devinitdata = {
+	/* 0 */ DECLARE_ITE_DEV("IT8212"),
+};
+
+/**
+ *	it8212_init_one	-	pci layer discovery entry
+ *	@dev: PCI device
+ *	@id: ident table entry
+ *
+ *	Called by the PCI code when it finds an ITE8212 controller.
+ *	We then use the IDE PCI generic helper to do most of the work.
+ */
+ 
+static int __devinit it8212_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	ide_setup_pci_device(dev, &it8212_chipsets[id->driver_data]);
+	return 0;
+}
+
+static void __devexit it8212_remove_one(struct pci_dev *dev)
+{
+	ide_pci_remove_hwifs(dev);
+}
+
+static struct pci_device_id it8212_pci_tbl[] = {
+	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8212,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, it8212_pci_tbl);
+
+static struct pci_driver driver = {
+	.name		= "ITE8212 IDE",
+	.id_table	= it8212_pci_tbl,
+	.probe		= it8212_init_one,
+	.remove		= it8212_remove_one
+};
+
+static int it8212_ide_init(void)
+{
+	return ide_pci_register_driver(&driver);
+}
+
+static void it8212_ide_exit(void)
+{
+	ide_pci_unregister_driver(&driver);
+}
+
+module_init(it8212_ide_init);
+module_exit(it8212_ide_exit);
+
+MODULE_AUTHOR("Alan Cox");
+MODULE_DESCRIPTION("PCI driver module for the ITE 8212");
+MODULE_LICENSE("GPL");
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/drivers/ide/pci/Makefile linux-2.6.8-rc3/drivers/ide/pci/Makefile
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/Makefile	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/Makefile	2004-08-09 19:51:50.000000000 +0100
@@ -13,6 +13,7 @@
 obj-$(CONFIG_BLK_DEV_HPT366)		+= hpt366.o
 #obj-$(CONFIG_BLK_DEV_HPT37X)		+= hpt37x.o
 obj-$(CONFIG_BLK_DEV_IT8172)		+= it8172.o
+obj-$(CONFIG_BLK_DEV_IT8212)		+= it8212.o
 obj-$(CONFIG_BLK_DEV_NS87415)		+= ns87415.o
 obj-$(CONFIG_BLK_DEV_OPTI621)		+= opti621.o
 obj-$(CONFIG_BLK_DEV_PDC202XX_OLD)	+= pdc202xx_old.o
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/drivers/ide/setup-pci.c linux-2.6.8-rc3/drivers/ide/setup-pci.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/setup-pci.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/setup-pci.c	2004-08-10 16:49:18.523572568 +0100
@@ -1,7 +1,8 @@
 /*
- *  linux/drivers/ide/setup-pci.c		Version 1.10	2002/08/19
+ *  linux/drivers/ide/setup-pci.c		Version 1.14	2004/08/10
  *
  *  Copyright (c) 1998-2000  Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (c) 2004 Red Hat <alan@redhat.com>
  *
  *  Copyright (c) 1995-1998  Mark Lord
  *  May be copied or modified under the terms of the GNU General Public License
@@ -11,6 +12,7 @@
  *	Use pci_set_master
  *	Fix misreporting of I/O v MMIO problems
  *	Initial fixups for simplex devices
+ *	Hot unplug paths
  */
 
 /*
@@ -762,6 +764,44 @@
 
 EXPORT_SYMBOL_GPL(ide_setup_pci_devices);
 
+/**
+ *	ide_pci_remove_hwifs	-	remove PCI interfaces
+ *	@dev: PCI device
+ *
+ *	Remove any hwif attached to this PCI device. This will call
+ *	back the various hwif->remove functions. In order to get the
+ *	best results when delays occur we kill the iops before we
+ *	potentially start blocking for long periods untangling the
+ *	IDE layer.
+ */
+ 
+void ide_pci_remove_hwifs(struct pci_dev *dev)
+{
+	int i;
+	ide_hwif_t *hwif = ide_hwifs;
+
+	for(i = 0; i < MAX_HWIFS; i++)
+	{
+		if(hwif->present && hwif->pci_dev == dev)
+			removed_hwif_iops(hwif);
+		i++;
+		hwif++;
+	}
+
+	hwif = ide_hwifs;
+	
+	for(i = 0; i < MAX_HWIFS; i++)
+	{
+		if(hwif->present && hwif->pci_dev == dev)
+			ide_unregister_hwif(hwif);
+		i++;
+		hwif++;
+	}
+}
+
+EXPORT_SYMBOL_GPL(ide_pci_remove_hwifs);
+
+
 /*
  *	Module interfaces
  */
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/include/linux/ide.h linux-2.6.8-rc3/include/linux/ide.h
--- linux.vanilla-2.6.8-rc3/include/linux/ide.h	2004-08-09 15:50:59.000000000 +0100
+++ linux-2.6.8-rc3/include/linux/ide.h	2004-08-10 16:46:37.000000000 +0100
@@ -909,10 +909,8 @@
 	int	(*quirkproc)(ide_drive_t *);
 	/* driver soft-power interface */
 	int	(*busproc)(ide_drive_t *, int);
-//	/* host rate limiter */
-//	u8	(*ratemask)(ide_drive_t *);
-//	/* device rate limiter */
-//	u8	(*ratefilter)(ide_drive_t *, u8);
+	/* hwif remove hook, called on unload/pci remove paths*/
+	void	(*remove)(struct hwif_s *);
 #endif
 
 #if 0
@@ -1503,9 +1501,11 @@
 extern void ide_pci_unregister_driver(struct pci_driver *driver);
 extern void ide_pci_setup_ports(struct pci_dev *dev, struct ide_pci_device_s *d, int autodma, int pciirq, ata_index_t *index);
 extern void ide_setup_pci_noise (struct pci_dev *dev, struct ide_pci_device_s *d);
+extern void ide_pci_remove_hwifs(struct pci_dev *dev);
 
 extern void default_hwif_iops(ide_hwif_t *);
 extern void default_hwif_mmiops(ide_hwif_t *);
+extern void removed_hwif_iops(ide_hwif_t *);
 extern void default_hwif_transport(ide_hwif_t *);
 
 int ide_register_driver(ide_driver_t *driver);
@@ -1603,8 +1603,8 @@
 #endif
 
 extern int ide_hwif_request_regions(ide_hwif_t *hwif);
-extern void ide_hwif_release_regions(ide_hwif_t* hwif);
-extern void ide_unregister (unsigned int index);
+extern void ide_hwif_release_regions(ide_hwif_t *hwif);
+extern void ide_unregister_hwif(ide_hwif_t *hwif);
 
 extern int probe_hwif_init(ide_hwif_t *);
 
diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.8-rc3/include/linux/pci_ids.h linux-2.6.8-rc3/include/linux/pci_ids.h
--- linux.vanilla-2.6.8-rc3/include/linux/pci_ids.h	2004-08-09 15:50:59.000000000 +0100
+++ linux-2.6.8-rc3/include/linux/pci_ids.h	2004-08-09 19:54:17.000000000 +0100
@@ -1638,6 +1638,7 @@
 #define PCI_VENDOR_ID_ITE		0x1283
 #define PCI_DEVICE_ID_ITE_IT8172G	0x8172
 #define PCI_DEVICE_ID_ITE_IT8172G_AUDIO 0x0801
+#define PCI_DEVICE_ID_ITE_8212		0x8212
 #define PCI_DEVICE_ID_ITE_8872		0x8872
 #define PCI_DEVICE_ID_ITE_IT8330G_0	0xe886
 
