Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263965AbTCUUGZ>; Fri, 21 Mar 2003 15:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263854AbTCUTbl>; Fri, 21 Mar 2003 14:31:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56452
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263838AbTCUTaG>; Fri, 21 Mar 2003 14:30:06 -0500
Date: Fri, 21 Mar 2003 20:45:21 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212045.h2LKjLdn026467@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update ide core 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- New style ide-default driver
- Don't attach non existant drives
- DRIVER()==NULL checks can go
- Ioctl checks that were missing are now in
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide.c linux-2.5.65-ac2/drivers/ide/ide.c
--- linux-2.5.65/drivers/ide/ide.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide.c	2003-03-20 18:23:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/ide.c		Version 7.00alpha1	August 19 2002
+ *  linux/drivers/ide/ide.c		Version 7.00beta2	Mar 05 2003
  *
  *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
  */
@@ -177,6 +177,7 @@
 static int system_bus_speed;	/* holds what we think is VESA/PCI bus speed */
 static int initializing;	/* set while initializing built-in drivers */
 
+DECLARE_MUTEX(ide_cfg_sem);
 spinlock_t ide_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 static int ide_scan_direction; /* THIS was formerly 2.2.x pci=reverse */
@@ -214,6 +215,8 @@
 EXPORT_SYMBOL(idetape);
 EXPORT_SYMBOL(idescsi);
 
+extern ide_driver_t idedefault_driver;
+static void setup_driver_defaults (ide_drive_t *drive);
 
 /*
  * Do not even *think* about calling this!
@@ -271,6 +274,8 @@
 		drive->max_failures		= IDE_DEFAULT_MAX_FAILURES;
 		drive->using_dma		= 0;
 		drive->is_flash			= 0;
+		drive->driver			= &idedefault_driver;
+		setup_driver_defaults(drive);
 		drive->vdma			= 0;
 		INIT_LIST_HEAD(&drive->list);
 	}
@@ -349,9 +354,7 @@
 {
 	if (!drive->present)
 		return 0;
-	if (drive->driver != NULL)
-		return DRIVER(drive)->capacity(drive);
-	return 0;
+	return DRIVER(drive)->capacity(drive);
 }
 
 EXPORT_SYMBOL(current_capacity);
@@ -580,17 +583,19 @@
  
 void ide_unregister (unsigned int index)
 {
-	ide_drive_t *drive, *d;
+	ide_drive_t *drive;
 	ide_hwif_t *hwif, *g;
 	ide_hwgroup_t *hwgroup;
 	int irq_count = 0, unit, i;
-	unsigned long flags;
 	ide_hwif_t old_hwif;
 
 	if (index >= MAX_HWIFS)
 		BUG();
 		
-	spin_lock_irqsave(&ide_lock, flags);
+	BUG_ON(in_interrupt());
+	BUG_ON(irqs_disabled());
+	down(&ide_cfg_sem);
+	spin_lock_irq(&ide_lock);
 	hwif = &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
@@ -600,25 +605,23 @@
 			continue;
 		if (drive->usage)
 			goto abort;
-		if (drive->driver != NULL && DRIVER(drive)->shutdown(drive))
+		if (DRIVER(drive)->shutdown(drive))
 			goto abort;
 	}
 	hwif->present = 0;
 	
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irq(&ide_lock);
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
 		if (!drive->present)
 			continue;
-		if (drive->driver != NULL)
-			DRIVER(drive)->cleanup(drive);
+		DRIVER(drive)->cleanup(drive);
 	}
 	
 #ifdef CONFIG_PROC_FS
 	destroy_proc_ide_drives(hwif);
 #endif
-	spin_lock_irqsave(&ide_lock, flags);
 	hwgroup = hwif->hwgroup;
 
 	/*
@@ -633,6 +636,7 @@
 	if (irq_count == 1)
 		free_irq(hwif->irq, hwgroup);
 
+	spin_lock_irq(&ide_lock);
 	/*
 	 * Note that we only release the standard ports,
 	 * and do not even try to handle any extra ports
@@ -644,7 +648,6 @@
 	 * Remove us from the hwgroup, and free
 	 * the hwgroup if we were the only member
 	 */
-	d = hwgroup->drive;
 	for (i = 0; i < MAX_DRIVES; ++i) {
 		drive = &hwif->drives[i];
 		if (drive->de) {
@@ -653,11 +656,23 @@
 		}
 		if (!drive->present)
 			continue;
-		while (hwgroup->drive->next != drive)
-			hwgroup->drive = hwgroup->drive->next;
-		hwgroup->drive->next = drive->next;
-		if (hwgroup->drive == drive)
+		if (drive == drive->next) {
+			/* special case: last drive from hwgroup. */
+			BUG_ON(hwgroup->drive != drive);
 			hwgroup->drive = NULL;
+		} else {
+			ide_drive_t *walk;
+
+			walk = hwgroup->drive;
+			while (walk->next != drive)
+				walk = walk->next;
+			walk->next = drive->next;
+			if (hwgroup->drive == drive) {
+				hwgroup->drive = drive->next;
+				hwgroup->hwif = HWIF(hwgroup->drive);
+			}
+		}
+		BUG_ON(hwgroup->drive == drive);
 		if (drive->id != NULL) {
 			kfree(drive->id);
 			drive->id = NULL;
@@ -665,15 +680,28 @@
 		drive->present = 0;
 		blk_cleanup_queue(&drive->queue);
 	}
-	if (d->present)
-		hwgroup->drive = d;
-	while (hwgroup->hwif->next != hwif)
-		hwgroup->hwif = hwgroup->hwif->next;
-	hwgroup->hwif->next = hwif->next;
-	if (hwgroup->hwif == hwif)
+	if (hwif->next == hwif) {
 		kfree(hwgroup);
-	else
-		hwgroup->hwif = HWIF(hwgroup->drive);
+		BUG_ON(hwgroup->hwif != hwif);
+	} else {
+		/* There is another interface in hwgroup.
+		 * Unlink us, and set hwgroup->drive and ->hwif to
+		 * something sane.
+		 */
+		g = hwgroup->hwif;
+		while (g->next != hwif)
+			g = g->next;
+		g->next = hwif->next;
+		if (hwgroup->hwif == hwif) {
+			/* Chose a random hwif for hwgroup->hwif.
+			 * It's guaranteed that there are no drives
+			 * left in the hwgroup.
+			 */
+			BUG_ON(hwgroup->drive != NULL);
+			hwgroup->hwif = g;
+		}
+		BUG_ON(hwgroup->hwif == hwif);
+	}
 
 #if !defined(CONFIG_DMA_NONPCI)
 	if (hwif->dma_base) {
@@ -813,7 +841,8 @@
 
 	hwif->hwif_data			= old_hwif.hwif_data;
 abort:
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irq(&ide_lock);
+	up(&ide_cfg_sem);
 }
 
 EXPORT_SYMBOL(ide_unregister);
@@ -998,7 +1027,7 @@
 	setting->set = set;
 	
 	setting->next = *p;
-	if (drive->driver)
+	if (drive->driver != &idedefault_driver)
 		setting->auto_remove = 1;
 	*p = setting;
 	up(&ide_setting_sem);
@@ -1304,15 +1334,9 @@
 		return 0;
 	}
 
-	if (drive->driver != NULL) {
-#if 0
-		ide_unregister_subdriver(drive);
-#else
-		if (DRIVER(drive)->cleanup(drive)) {
-			drive->scsi = 0;
-			return 0;
-		}
-#endif
+	if (DRIVER(drive)->cleanup(drive)) {
+		drive->scsi = 0;
+		return 0;
 	}
 
 	drive->scsi = (u8) arg;
@@ -1353,7 +1377,7 @@
 	mdelay(50);
 #else
 	__set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/20);
+	schedule_timeout(1+HZ/20);
 #endif /* CONFIG_BLK_DEV_IDECS */
 }
 
@@ -1375,7 +1399,7 @@
 {
 	if (!drive->present || drive->usage || drive->dead)
 		goto abort;
-	if (drive->driver != NULL && DRIVER(drive)->cleanup(drive))
+	if (DRIVER(drive)->cleanup(drive))
 		goto abort;
 	strncpy(drive->driver_req, driver, 9);
 	if (ata_attach(drive)) {
@@ -1387,7 +1411,7 @@
 	} else {
 		drive->driver_req[0] = 0;
 	}
-	if (DRIVER(drive) && !strcmp(DRIVER(drive)->name, driver))
+	if (DRIVER(drive)!= &idedefault_driver && !strcmp(DRIVER(drive)->name, driver))
 		return 0;
 abort:
 	return 1;
@@ -1412,10 +1436,12 @@
 		spin_lock(&drivers_lock);
 		module_put(driver->owner);
 	}
+	drive->gendev.driver = &idedefault_driver.gen_driver;
 	spin_unlock(&drivers_lock);
+	if(idedefault_driver.attach(drive) != 0)
+		panic("ide: default attach failed");
 	spin_lock(&drives_lock);
 	list_add_tail(&drive->list, &ata_unused);
-	drive->gendev.driver = NULL;
 	spin_unlock(&drives_lock);
 	return 1;
 }
@@ -1476,7 +1502,7 @@
 		case HDIO_GET_IDENTITY:
 			if (bdev != bdev->bd_contains)
 				return -EINVAL;
-			if (drive->id == NULL)
+			if (drive->id_read == 0)
 				return -ENOMSG;
 			if (copy_to_user((char *)arg, (char *)drive->id, (cmd == HDIO_GET_IDENTITY) ? sizeof(*drive->id) : 142))
 				return -EFAULT;
@@ -1521,7 +1547,7 @@
 		case HDIO_SCAN_HWIF:
 		{
 			int args[3];
-			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
+			if (!capable(CAP_SYS_RAWIO)) return -EACCES;
 			if (copy_from_user(args, (void *)arg, 3 * sizeof(int)))
 				return -EFAULT;
 			if (ide_register(args[0], args[1], args[2]) == -1)
@@ -1529,14 +1555,12 @@
 			return 0;
 		}
 	        case HDIO_UNREGISTER_HWIF:
-			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
+			if (!capable(CAP_SYS_RAWIO)) return -EACCES;
 			/* (arg > MAX_HWIFS) checked in function */
 			ide_unregister(arg);
 			return 0;
 		case HDIO_SET_NICE:
 			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-			if (drive->driver == NULL)
-				return -EPERM;
 			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP) | (1 << IDE_NICE_1))))
 				return -EPERM;
 			drive->dsc_overlap = (arg >> IDE_NICE_DSC_OVERLAP) & 1;
@@ -1550,18 +1574,26 @@
 		{
 			unsigned long flags;
 			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-#if 1
+			
+			/*
+			 *	Abort the current command on the
+			 *	group if there is one, taking
+			 *	care not to allow anything else
+			 *	to be queued and to die on the
+			 *	spot if we miss one somehow
+			 */
+
 			spin_lock_irqsave(&ide_lock, flags);
-			if ( HWGROUP(drive)->handler != NULL) {
-				printk(KERN_ERR "%s: ide_set_handler: handler not null; %p\n", drive->name, HWGROUP(drive)->handler);
-				(void) HWGROUP(drive)->handler(drive);
-//				HWGROUP(drive)->handler = NULL;
-				HWGROUP(drive)->expiry	= NULL;
-				del_timer(&HWGROUP(drive)->timer);
-			}
+			
+			DRIVER(drive)->abort(drive, "drive reset");
+			if(HWGROUP(drive)->handler)
+				BUG();
+				
+			/* Ensure nothing gets queued after we
+			   drop the lock. Reset will clear the busy */
+		   
+			HWGROUP(drive)->busy = 1;
 			spin_unlock_irqrestore(&ide_lock, flags);
-
-#endif
 			(void) ide_do_reset(drive);
 			if (drive->suspend_reset) {
 /*
@@ -1593,9 +1625,8 @@
 			if (!capable(CAP_SYS_ADMIN))
 				return -EACCES;
 			if (HWIF(drive)->busproc)
-				HWIF(drive)->busproc(drive, (int)arg);
-			return 0;
-
+				return HWIF(drive)->busproc(drive, (int)arg);
+			return -EOPNOTSUPP;
 		default:
 			return -EINVAL;
 	}
@@ -2193,7 +2224,7 @@
  
 static int default_shutdown(ide_drive_t *drive)
 {
-	if (drive->usage || drive->driver == NULL || DRIVER(drive)->busy) {
+	if (drive->usage || DRIVER(drive)->busy) {
 		return 1;
 	}
 	drive->dead = 1;
@@ -2261,6 +2292,11 @@
 	return 0;
 }
 
+static ide_startstop_t default_abort (ide_drive_t *drive, const char *msg)
+{
+	return ide_abort(drive, msg);
+}
+
 static void setup_driver_defaults (ide_drive_t *drive)
 {
 	ide_driver_t *d = drive->driver;
@@ -2272,6 +2308,7 @@
 	if (d->end_request == NULL)	d->end_request = default_end_request;
 	if (d->sense == NULL)		d->sense = default_sense;
 	if (d->error == NULL)		d->error = default_error;
+	if (d->abort == NULL)		d->abort = default_abort;
 	if (d->pre_reset == NULL)	d->pre_reset = default_pre_reset;
 	if (d->capacity == NULL)	d->capacity = default_capacity;
 	if (d->special == NULL)		d->special = default_special;
@@ -2282,9 +2319,11 @@
 {
 	unsigned long flags;
 	
+	BUG_ON(drive->driver == NULL);
+	
 	spin_lock_irqsave(&ide_lock, flags);
 	if (version != IDE_SUBDRIVER_VERSION || !drive->present ||
-	    drive->driver != NULL || drive->usage || drive->dead) {
+	    drive->driver != &idedefault_driver || drive->usage || drive->dead) {
 		spin_unlock_irqrestore(&ide_lock, flags);
 		return 1;
 	}
@@ -2294,6 +2333,7 @@
 	spin_lock(&drives_lock);
 	list_add(&drive->list, &driver->drives);
 	spin_unlock(&drives_lock);
+//	printk(KERN_INFO "%s: attached %s driver.\n", drive->name, driver->name);
 	if ((drive->autotune == IDE_TUNE_DEFAULT) ||
 		(drive->autotune == IDE_TUNE_AUTO)) {
 		/* DMA timings and setup moved to ide-probe.c */
@@ -2318,7 +2358,7 @@
 	unsigned long flags;
 	
 	spin_lock_irqsave(&ide_lock, flags);
-	if (drive->usage || drive->driver == NULL || DRIVER(drive)->busy) {
+	if (drive->usage || drive->driver == &idedefault_driver || DRIVER(drive)->busy) {
 		spin_unlock_irqrestore(&ide_lock, flags);
 		return 1;
 	}
@@ -2330,10 +2370,12 @@
 	ide_remove_proc_entries(drive->proc, generic_subdriver_entries);
 #endif
 	auto_remove_settings(drive);
-	drive->driver = NULL;
+	drive->driver = &idedefault_driver;
+	setup_driver_defaults(drive);
 	spin_unlock_irqrestore(&ide_lock, flags);
 	spin_lock(&drives_lock);
 	list_del_init(&drive->list);
+	list_add(&drive->list, &drive->driver->drives);
 	spin_unlock(&drives_lock);
 	return 0;
 }
@@ -2343,10 +2385,7 @@
 static int ide_drive_remove(struct device * dev)
 {
 	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
-	ide_driver_t * driver = drive->driver;
-
-	if (driver && driver->cleanup)
-		driver->cleanup(drive);
+	DRIVER(drive)->cleanup(drive);
 	return 0;
 }
 
@@ -2366,7 +2405,8 @@
 	while (!list_empty(&list)) {
 		ide_drive_t *drive = list_entry(list.next, ide_drive_t, list);
 		list_del_init(&drive->list);
-		ata_attach(drive);
+		if (drive->present)
+			ata_attach(drive);
 	}
 	driver->gen_driver.name = (char *) driver->name;
 	driver->gen_driver.bus = &ide_bus_type;
