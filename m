Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267949AbTBRR7T>; Tue, 18 Feb 2003 12:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267966AbTBRR7T>; Tue, 18 Feb 2003 12:59:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23817 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267949AbTBRR45>; Tue, 18 Feb 2003 12:56:57 -0500
Subject: PATCH: ide-probe updates
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:07:08 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lC97-000681-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix crash with slave and no master
Fix crash with hdb=noprobe hdb=cdrom
Fix crash with pre ATA devices refusing IDENTIFY
Fix flash slave making master disappear
Add interfaces that the PPC uses to do disk spin up when the BIOS has not
Add framework to allow hdparm -d1 on a box built with IDE_DMA_ONLYDISK
Fix identify framework so we can fix the proc identify crash too

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-probe.c linux-2.5.61-ac2/drivers/ide/ide-probe.c
--- linux-2.5.61/drivers/ide/ide-probe.c	2003-02-10 18:38:43.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-probe.c	2003-02-18 18:06:17.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/ide-probe.c	Version 1.07	March 18, 2001
+ *  linux/drivers/ide/ide-probe.c	Version 1.10	Feb 11, 2003
  *
  *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
  */
@@ -27,6 +27,8 @@
  * Version 1.06		stream line request queue and prep for cascade project.
  * Version 1.07		max_sect <= 255; slower disks would get behind and
  * 			then fall over when they get to 256.	Paul G.
+ * Version 1.10		Update set for new IDE. drive->id is now always
+ *			valid after probe time even with noprobe
  */
 
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
@@ -54,22 +56,54 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-/*
- * CompactFlash cards and their brethern pretend to be removable
- * hard disks, except:
- *	(1) they never have a slave unit, and
- *	(2) they don't have doorlock mechanisms.
- * This test catches them, and is invoked elsewhere when setting
- * appropriate config bits.
- *
- * FIXME: This treatment is probably applicable for *all* PCMCIA (PC CARD)
- * devices, so in linux 2.3.x we should change this to just treat all PCMCIA
- * drives this way, and get rid of the model-name tests below
- * (too big of an interface change for 2.2.x).
- * At that time, we might also consider parameterizing the timeouts and retries,
- * since these are MUCH faster than mechanical drives.	-M.Lord
+/**
+ *	generic_id		-	add a generic drive id
+ *	@drive:	drive to make an ID block for
+ *	
+ *	Add a fake id field to the drive we are passed. This allows
+ *	use to skip a ton of NULL checks (which people always miss) 
+ *	and make drive properties unconditional outside of this file
  */
-inline int drive_is_flashcard (ide_drive_t *drive)
+ 
+static int generic_id(ide_drive_t *drive)
+{
+	drive->id = kmalloc(SECTOR_WORDS *4, GFP_KERNEL);
+	if(drive->id == NULL)
+	{
+		printk(KERN_ERR "ide: out of memory for id data.\n");
+		return -ENOMEM;
+	}
+	memset(drive->id, 0, SECTOR_WORDS * 4);
+	drive->id->cyls = drive->cyl;
+	drive->id->heads = drive->head;
+	drive->id->sectors = drive->sect;
+	drive->id->cur_cyls = drive->cyl;
+	drive->id->cur_heads = drive->head;
+	drive->id->cur_sectors = drive->sect;
+	strcpy(drive->id->model, "UNKNOWN");
+	return 0;
+}
+		
+/**
+ *	drive_is_flashcard	-	check for compact flash
+ *	@drive: drive to check
+ *
+ *	CompactFlash cards and their brethern pretend to be removable
+ *	hard disks, except:
+ * 		(1) they never have a slave unit, and
+ *		(2) they don't have doorlock mechanisms.
+ *	This test catches them, and is invoked elsewhere when setting
+ *	appropriate config bits.
+ *
+ *	FIXME: This treatment is probably applicable for *all* PCMCIA (PC CARD)
+ *	devices, so in linux 2.3.x we should change this to just treat all
+ *	PCMCIA  drives this way, and get rid of the model-name tests below
+ *	(too big of an interface change for 2.4.x).
+ *	At that time, we might also consider parameterizing the timeouts and
+ *	retries, since these are MUCH faster than mechanical drives. -M.Lord
+ */
+ 
+static inline int drive_is_flashcard (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
 
@@ -88,6 +122,16 @@
 	return 0;	/* no, it is not a flash memory card */
 }
 
+/**
+ *	do_identify	-	identify a drive
+ *	@drive: drive to identify 
+ *	@cmd: command used
+ *
+ *	Called when we have issued a drive identify command to
+ *	read and parse the results. This function is run with
+ *	interrupts disabled. 
+ */
+ 
 static inline void do_identify (ide_drive_t *drive, u8 cmd)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -207,6 +251,7 @@
 	 */
 	if (id->config & (1<<7))
 		drive->removable = 1;
+		
 	/*
 	 * Prevent long system lockup probing later for non-existant
 	 * slave drive if the hwif is actually a flash memory card of
@@ -214,11 +259,17 @@
 	 */
 	drive->is_flash = 0;
 	if (drive_is_flashcard(drive)) {
+#if 0
+		/* The new IDE adapter widgets don't follow this heuristic
+		   so we must nowdays just bite the bullet and take the
+		   probe hit */	
+		ide_drive_t *mate = &hwif->drives[1^drive->select.b.unit];		
 		ide_drive_t *mate = &hwif->drives[1^drive->select.b.unit];
 		if (!mate->ata_flash) {
 			mate->present = 0;
 			mate->noprobe = 1;
 		}
+#endif		
 		drive->is_flash = 1;
 	}
 	drive->media = ide_disk;
@@ -244,21 +295,26 @@
 	return;
 }
 
-/*
- * try_to_identify() sends an ATA(PI) IDENTIFY request to a drive
- * and waits for a response.  It also monitors irqs while this is
- * happening, in hope of automatically determining which one is
- * being used by the interface.
+/**
+ *	actual_try_to_identify	-	send ata/atapi identify
+ *	@drive: drive to identify
+ *	@cmd: comamnd to use
  *
- * Returns:	0  device was identified
- *		1  device timed-out (no response to identify request)
- *		2  device aborted the command (refused to identify itself)
+ *	try_to_identify() sends an ATA(PI) IDENTIFY request to a drive
+ *	and waits for a response.  It also monitors irqs while this is
+ *	happening, in hope of automatically determining which one is
+ *	being used by the interface.
+ *
+ *	Returns:	0  device was identified
+ *			1  device timed-out (no response to identify request)
+ *			2  device aborted the command (refused to identify itself)
  */
+
 static int actual_try_to_identify (ide_drive_t *drive, u8 cmd)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	int rc;
-	ide_ioreg_t hd_status;
+	unsigned long hd_status;
 	unsigned long timeout;
 	u8 s = 0, a = 0;
 
@@ -268,7 +324,7 @@
 		a = hwif->INB(IDE_ALTSTATUS_REG);
 		s = hwif->INB(IDE_STATUS_REG);
 		if ((a ^ s) & ~INDEX_STAT) {
-			printk("%s: probing with STATUS(0x%02x) instead of "
+			printk(KERN_INFO "%s: probing with STATUS(0x%02x) instead of "
 				"ALTSTATUS(0x%02x)\n", drive->name, s, a);
 			/* ancient Seagate drives, broken interfaces */
 			hd_status = IDE_STATUS_REG;
@@ -327,6 +383,16 @@
 	return rc;
 }
 
+/**
+ *	try_to_identify	-	try to identify a drive
+ *	@drive: drive to probe
+ *	@cmd: comamnd to use
+ *
+ *	Issue the identify command and then do IRQ probing to
+ *	complete the identification when needed by finding the
+ *	IRQ the drive is attached to
+ */
+ 
 static int try_to_identify (ide_drive_t *drive, u8 cmd)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -376,15 +442,19 @@
 }
 
 
-/*
- * do_probe() has the difficult job of finding a drive if it exists,
- * without getting hung up if it doesn't exist, without trampling on
- * ethernet cards, and without leaving any IRQs dangling to haunt us later.
- *
- * If a drive is "known" to exist (from CMOS or kernel parameters),
- * but does not respond right away, the probe will "hang in there"
- * for the maximum wait time (about 30 seconds), otherwise it will
- * exit much more quickly.
+/**
+ *	do_probe		-	probe an IDE device
+ *	@drive: drive to probe
+ *	@cmd: command to use
+ *
+ *	do_probe() has the difficult job of finding a drive if it exists,
+ *	without getting hung up if it doesn't exist, without trampling on
+ *	ethernet cards, and without leaving any IRQs dangling to haunt us later.
+ *
+ *	If a drive is "known" to exist (from CMOS or kernel parameters),
+ *	but does not respond right away, the probe will "hang in there"
+ *	for the maximum wait time (about 30 seconds), otherwise it will
+ *	exit much more quickly.
  *
  * Returns:	0  device was identified
  *		1  device timed-out (no response to identify request)
@@ -392,6 +462,7 @@
  *		3  bad status from device (possible for ATAPI drives)
  *		4  probe was not attempted because failure was obvious
  */
+
 static int do_probe (ide_drive_t *drive, u8 cmd)
 {
 	int rc;
@@ -507,44 +578,55 @@
 	}
 }
 
-/*
- * probe_for_drive() tests for existence of a given drive using do_probe().
+/**
+ *	probe_for_drives	-	upper level drive probe
+ *	@drive: drive to probe for
+ *
+ *	probe_for_drive() tests for existence of a given drive using do_probe()
+ *	and presents things to the user as needed.
  *
- * Returns:	0  no device was found
- *		1  device was found (note: drive->present might still be 0)
+ *	Returns:	0  no device was found
+ *			1  device was found (note: drive->present might
+ *			   still be 0)
  */
+ 
 static inline u8 probe_for_drive (ide_drive_t *drive)
 {
 	/* skip probing? */
-	if (drive->noprobe)
-		return drive->present;
-
-	/* if !(success||timed-out) */
-	if (do_probe(drive, WIN_IDENTIFY) >= 2) {
-		/* look for ATAPI device */
-		(void) do_probe(drive, WIN_PIDENTIFY);
+	if (!drive->noprobe)
+	{
+		/* if !(success||timed-out) */
+		if (do_probe(drive, WIN_IDENTIFY) >= 2) {
+			/* look for ATAPI device */
+			(void) do_probe(drive, WIN_PIDENTIFY);
+		}
+		if (drive->id && strstr(drive->id->model, "E X A B Y T E N E S T"))
+			enable_nest(drive);
+		if (!drive->present)
+			/* drive not found */
+			return 0;
+	
+		/* identification failed? */
+		if (drive->id == NULL) {
+			if (drive->media == ide_disk) {
+				printk(KERN_INFO "%s: non-IDE drive, CHS=%d/%d/%d\n",
+					drive->name, drive->cyl,
+					drive->head, drive->sect);
+			} else if (drive->media == ide_cdrom) {
+				printk(KERN_INFO "%s: ATAPI cdrom (?)\n", drive->name);
+			} else {
+				/* nuke it */
+				drive->present = 0;
+			}
+		}
+		/* drive was found */
 	}
-	if (drive->id && strstr(drive->id->model, "E X A B Y T E N E S T"))
-		enable_nest(drive);
-	if (!drive->present)
-		/* drive not found */
+	if(!drive->present)
 		return 0;
-
-	/* identification failed? */
-	if (drive->id == NULL) {
-		if (drive->media == ide_disk) {
-			printk("%s: non-IDE drive, CHS=%d/%d/%d\n",
-				drive->name, drive->cyl,
-				drive->head, drive->sect);
-		} else if (drive->media == ide_cdrom) {
-			printk("%s: ATAPI cdrom (?)\n", drive->name);
-		} else {
-			/* nuke it */
+	if(drive->id == NULL)
+		if(generic_id(drive) < 0)
 			drive->present = 0;
-		}
-	}
-	/* drive was found */
-	return 1;
+	return drive->present;
 }
 
 static int hwif_check_region(ide_hwif_t *hwif, unsigned long addr, int num)
@@ -560,12 +642,21 @@
 	{
 		printk("%s: %s resource 0x%lX-0x%lX not free.\n",
 			hwif->name, hwif->mmio?"MMIO":"I/O", addr, addr+num-1);
-		mdelay(2000);
 	}
 	return err;
 }
-		
+	
 
+/**
+ *	hwif_check_regions	-	check resources for IDE
+ *	@hwif: interface to use
+ *
+ *	Checks if all the needed resources for an interface are free
+ *	providing the interface is PIO. Right now core IDE code does
+ *	this work which is deeply wrong. MMIO leaves it to the controller
+ *	driver, PIO will migrate this way over time
+ */
+ 
 static int hwif_check_regions (ide_hwif_t *hwif)
 {
 	u32 i		= 0;
@@ -627,6 +718,72 @@
 
 //EXPORT_SYMBOL(hwif_register);
 
+/* Enable code below on all archs later, for now, I want it on PPC
+ */
+#ifdef CONFIG_PPC
+/*
+ * This function waits for the hwif to report a non-busy status
+ * see comments in probe_hwif()
+ */
+static int wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)
+{
+	u8 stat = 0;
+	
+	while(timeout--) {
+		/* Turn this into a schedule() sleep once I'm sure
+		 * about locking issues (2.5 work ?)
+		 */
+		mdelay(1);
+		stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
+		if ((stat & BUSY_STAT) == 0)
+			break;
+		/* Assume a value of 0xff means nothing is connected to
+		 * the interface and it doesn't implement the pull-down
+		 * resistor on D7
+		 */
+		if (stat == 0xff)
+			break;
+	}
+	return ((stat & BUSY_STAT) == 0) ? 0 : -EBUSY;
+}
+
+static int wait_hwif_ready(ide_hwif_t *hwif)
+{
+	int rc;
+
+	printk(KERN_INFO "Probing IDE interface %s...\n", hwif->name);
+
+	/* Let HW settle down a bit from whatever init state we
+	 * come from */
+	mdelay(2);
+
+	/* Wait for BSY bit to go away, spec timeout is 30 seconds,
+	 * I know of at least one disk who takes 31 seconds, I use 35
+	 * here to be safe
+	 */
+	rc = wait_not_busy(hwif, 35000);
+	if (rc)
+		return rc;
+
+	/* Now make sure both master & slave are ready */
+	SELECT_DRIVE(&hwif->drives[0]);
+	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
+	mdelay(2);
+	rc = wait_not_busy(hwif, 10000);
+	if (rc)
+		return rc;
+	SELECT_DRIVE(&hwif->drives[1]);
+	hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
+	mdelay(2);
+	rc = wait_not_busy(hwif, 10000);
+
+	/* Exit function with master reselected (let's be sane) */
+	SELECT_DRIVE(&hwif->drives[0]);
+	
+	return rc;
+}
+#endif /* CONFIG_PPC */
+
 /*
  * This routine only knows how to look for drive units 0 and 1
  * on an interface, so any setting of MAX_DRIVES > 2 won't work here.
@@ -650,13 +807,13 @@
 			ide_drive_t *drive = &hwif->drives[unit];
 			if (drive->present) {
 				drive->present = 0;
-				printk("%s: ERROR, PORTS ALREADY IN USE\n",
+				printk(KERN_ERR "%s: ERROR, PORTS ALREADY IN USE\n",
 					drive->name);
 				msgout = 1;
 			}
 		}
 		if (!msgout)
-			printk("%s: ports already in use, skipping probe\n",
+			printk(KERN_ERR "%s: ports already in use, skipping probe\n",
 				hwif->name);
 		return;	
 	}
@@ -666,17 +823,35 @@
 	 * we'll install our IRQ driver much later...
 	 */
 	irqd = hwif->irq;
-	
-	if (irqd >= NR_IRQS)
-	{
-		printk(KERN_ERR "***WARNING***: Bogus interrupt reported. Probably a bug in the Linux ACPI\n");
-		printk(KERN_ERR "***WARNING***: Attempting to continue as best we can.\n");
-		irqd = 0;
-	}
 	if (irqd)
 		disable_irq(hwif->irq);
 
 	local_irq_set(flags);
+
+#ifdef CONFIG_PPC
+	/* This is needed on some PPCs and a bunch of BIOS-less embedded
+	 * platforms. Typical cases are:
+	 * 
+	 *  - The firmware hard reset the disk before booting the kernel,
+	 *    the drive is still doing it's poweron-reset sequence, that
+	 *    can take up to 30 seconds
+	 *  - The firmware does nothing (or no firmware), the device is
+	 *    still in POST state (same as above actually).
+	 *  - Some CD/DVD/Writer combo drives tend to drive the bus during
+	 *    their reset sequence even when they are non-selected slave
+	 *    devices, thus preventing discovery of the main HD
+	 *    
+	 *  Doing this wait-for-busy should not harm any existing configuration
+	 *  (at least things won't be worse than what current code does, that
+	 *  is blindly go & talk to the drive) and fix some issues like the
+	 *  above.
+	 *  
+	 *  BenH.
+	 */
+	if (wait_hwif_ready(hwif))
+		printk(KERN_WARNING "%s: Wait for ready failed before probe !\n", hwif->name);
+#endif /* CONFIG_PPC */
+
 	/*
 	 * Second drive should only exist if first drive was found,
 	 * but a lot of cdrom drives are configured as single slaves.
@@ -689,6 +864,7 @@
 		if (drive->present && !hwif->present) {
 			hwif->present = 1;
 			if (hwif->chipset != ide_4drives ||
+			    !hwif->mate || 
 			    !hwif->mate->present) {
 				hwif_register(hwif);
 			}
@@ -698,7 +874,7 @@
 		unsigned long timeout = jiffies + WAIT_WORSTCASE;
 		u8 stat;
 
-		printk("%s: reset\n", hwif->name);
+		printk(KERN_WARNING "%s: reset\n", hwif->name);
 		hwif->OUTB(12, hwif->io_ports[IDE_CONTROL_OFFSET]);
 		udelay(10);
 		hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
@@ -718,11 +894,18 @@
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
+		int enable_dma = 1;
+
 		if (drive->present) {
 			if (hwif->tuneproc != NULL && 
 				drive->autotune == IDE_TUNE_AUTO)
 				/* auto-tune PIO mode */
 				hwif->tuneproc(drive, 255);
+
+#ifdef CONFIG_IDEDMA_ONLYDISK
+			if (drive->media != ide_disk)
+				enable_dma = 0;
+#endif
 			/*
 			 * MAJOR HACK BARF :-/
 			 *
@@ -742,7 +925,8 @@
 				 *   PARANOIA!!!
 				 */
 				hwif->ide_dma_off_quietly(drive);
-				hwif->ide_dma_check(drive);
+				if (enable_dma)
+					hwif->ide_dma_check(drive);
 			}
 		}
 	}
@@ -757,7 +941,6 @@
 	probe_hwif(hwif);
 	hwif_init(hwif);
 
-#if 1
 	if (hwif->present) {
 		u16 unit = 0;
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
@@ -767,7 +950,6 @@
 			}
 		}
 	}
-#endif
 	hwif->initializing = 0;
 	return 0;
 }
@@ -855,13 +1037,8 @@
 	ide_hwgroup_t *hwgroup, *new_hwgroup;
 	ide_hwif_t *match = NULL;
 
-#if 0
-	/* Allocate the buffer and no sleep allowed */
-	new_hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_ATOMIC);
-#else
 	/* Allocate the buffer and potentially sleep first */
 	new_hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_KERNEL);
-#endif
 	
 	spin_lock_irqsave(&ide_lock, flags);
 
@@ -1188,7 +1365,7 @@
 {
 	unsigned int index;
 	int probe[MAX_HWIFS];
-
+	
 	MOD_INC_USE_COUNT;
 	memset(probe, 0, MAX_HWIFS * sizeof(int));
 	for (index = 0; index < MAX_HWIFS; ++index)
