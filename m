Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263798AbTCUTZn>; Fri, 21 Mar 2003 14:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263796AbTCUTZJ>; Fri, 21 Mar 2003 14:25:09 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49540
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263778AbTCUTX4>; Fri, 21 Mar 2003 14:23:56 -0500
Date: Fri, 21 Mar 2003 20:39:11 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212039.h2LKdBS4026413@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: ide-probe update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make drive->id not NULL an invariant
Clean up a few things from that
hwif specific queue length
initialisation/IRQ cleanups

Note: this changes the default blocks limit per I/O to 256. I've still seen
no credible evidence that its a problem and "other OS's" do it.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-probe.c linux-2.5.65-ac2/drivers/ide/ide-probe.c
--- linux-2.5.65/drivers/ide/ide-probe.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-probe.c	2003-03-20 18:26:41.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/ide-probe.c	Version 1.10	Feb 11, 2003
+ *  linux/drivers/ide/ide-probe.c	Version 1.11	Mar 05, 2003
  *
  *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
  */
@@ -65,23 +65,14 @@
  *	and make drive properties unconditional outside of this file
  */
  
-static int generic_id(ide_drive_t *drive)
+static void generic_id(ide_drive_t *drive)
 {
-	drive->id = kmalloc(SECTOR_WORDS *4, GFP_KERNEL);
-	if(drive->id == NULL)
-	{
-		printk(KERN_ERR "ide: out of memory for id data.\n");
-		return -ENOMEM;
-	}
-	memset(drive->id, 0, SECTOR_WORDS * 4);
 	drive->id->cyls = drive->cyl;
 	drive->id->heads = drive->head;
 	drive->id->sectors = drive->sect;
 	drive->id->cur_cyls = drive->cyl;
 	drive->id->cur_heads = drive->head;
 	drive->id->cur_sectors = drive->sect;
-	strcpy(drive->id->model, "UNKNOWN");
-	return 0;
 }
 		
 /**
@@ -107,7 +98,7 @@
 {
 	struct hd_driveid *id = drive->id;
 
-	if (drive->removable && id != NULL) {
+	if (drive->removable) {
 		if (id->config == 0x848a) return 1;	/* CompactFlash */
 		if (!strncmp(id->model, "KODAK ATA_FLASH", 15)	/* Kodak */
 		 || !strncmp(id->model, "Hitachi CV", 10)	/* Hitachi */
@@ -138,16 +129,11 @@
 	int bswap = 1;
 	struct hd_driveid *id;
 
-	/* called with interrupts disabled! */
-	id = drive->id = kmalloc(SECTOR_WORDS*4, GFP_ATOMIC);
-	if (!id) {
-		printk(KERN_WARNING "(ide-probe::do_identify) "
-			"Out of memory.\n");
-		goto err_kmalloc;
-	}
+	id = drive->id;
 	/* read 512 bytes of id info */
 	hwif->ata_input_data(drive, id, SECTOR_WORDS);
 
+	drive->id_read = 1;
 	local_irq_enable();
 	ide_fix_driveid(id);
 
@@ -290,7 +276,6 @@
 
 err_misc:
 	kfree(id);
-err_kmalloc:
 	drive->present = 0;
 	return;
 }
@@ -592,6 +577,25 @@
  
 static inline u8 probe_for_drive (ide_drive_t *drive)
 {
+	/*
+	 *	In order to keep things simple we have an id
+	 *	block for all drives at all times. If the device
+	 *	is pre ATA or refuses ATA/ATAPI identify we
+	 *	will add faked data to this.
+	 *
+	 *	Also note that 0 everywhere means "can't do X"
+	 */
+ 
+	drive->id = kmalloc(SECTOR_WORDS *4, GFP_KERNEL);
+	drive->id_read = 0;
+	if(drive->id == NULL)
+	{
+		printk(KERN_ERR "ide: out of memory for id data.\n");
+		return 0;
+	}
+	memset(drive->id, 0, SECTOR_WORDS * 4);
+	strcpy(drive->id->model, "UNKNOWN");
+	
 	/* skip probing? */
 	if (!drive->noprobe)
 	{
@@ -600,14 +604,14 @@
 			/* look for ATAPI device */
 			(void) do_probe(drive, WIN_PIDENTIFY);
 		}
-		if (drive->id && strstr(drive->id->model, "E X A B Y T E N E S T"))
+		if (strstr(drive->id->model, "E X A B Y T E N E S T"))
 			enable_nest(drive);
 		if (!drive->present)
 			/* drive not found */
 			return 0;
 	
 		/* identification failed? */
-		if (drive->id == NULL) {
+		if (!drive->id_read) {
 			if (drive->media == ide_disk) {
 				printk(KERN_INFO "%s: non-IDE drive, CHS=%d/%d/%d\n",
 					drive->name, drive->cyl,
@@ -616,6 +620,7 @@
 				printk(KERN_INFO "%s: ATAPI cdrom (?)\n", drive->name);
 			} else {
 				/* nuke it */
+				printk(KERN_WARNING "%s: Unknown device on bus refused identification. Ignoring.\n", drive->name);
 				drive->present = 0;
 			}
 		}
@@ -623,9 +628,9 @@
 	}
 	if(!drive->present)
 		return 0;
-	if(drive->id == NULL)
-		if(generic_id(drive) < 0)
-			drive->present = 0;
+	/* The drive wasn't being helpful. Add generic info only */
+	if(!drive->id_read)
+		generic_id(drive);
 	return drive->present;
 }
 
@@ -945,6 +950,9 @@
 		u16 unit = 0;
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
 			ide_drive_t *drive = &hwif->drives[unit];
+			/* For now don't attach absent drives, we may
+			   want them on default or a new "empty" class
+			   for hotplug reprobing ? */
 			if (drive->present) {
 				ata_attach(drive);
 			}
@@ -990,18 +998,23 @@
 static void ide_init_queue(ide_drive_t *drive)
 {
 	request_queue_t *q = &drive->queue;
-	int max_sectors;
+	int max_sectors = 256;
 
+	/*
+	 *	Our default set up assumes the normal IDE case,
+	 *	that is 64K segmenting, standard PRD setup
+	 *	and LBA28. Some drivers then impose their own
+	 *	limits and LBA48 we could raise it but as yet
+	 *	do not.
+	 */
+	 
 	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request, &ide_lock);
 	drive->queue_setup = 1;
 	blk_queue_segment_boundary(q, 0xffff);
 
-#ifdef CONFIG_BLK_DEV_PDC4030
-	max_sectors = 127;
-#else
-	max_sectors = 255;
-#endif
+	if (HWIF(drive)->rqsize)
+		max_sectors = HWIF(drive)->rqsize;
 	blk_queue_max_sectors(q, max_sectors);
 
 	/* IDE DMA can do PRD_ENTRIES number of segments. */
@@ -1009,7 +1022,13 @@
 
 	/* This is a driver limit and could be eliminated. */
 	blk_queue_max_phys_segments(q, PRD_ENTRIES);
+}
 
+/*
+ * Setup the drive for request handling.
+ */
+static void ide_init_drive(ide_drive_t *drive)
+{
 	ide_toggle_bounce(drive, 1);
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
@@ -1032,16 +1051,14 @@
  */
 static int init_irq (ide_hwif_t *hwif)
 {
-	unsigned long flags;
 	unsigned int index;
-	ide_hwgroup_t *hwgroup, *new_hwgroup;
+	ide_hwgroup_t *hwgroup;
 	ide_hwif_t *match = NULL;
 
-	/* Allocate the buffer and potentially sleep first */
-	new_hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_KERNEL);
-	
-	spin_lock_irqsave(&ide_lock, flags);
 
+	BUG_ON(in_interrupt());
+	BUG_ON(irqs_disabled());	
+	down(&ide_cfg_sem);
 	hwif->hwgroup = NULL;
 #if MAX_HWIFS > 1
 	/*
@@ -1073,14 +1090,28 @@
 	 */
 	if (match) {
 		hwgroup = match->hwgroup;
-		if(new_hwgroup)
-			kfree(new_hwgroup);
+		hwif->hwgroup = hwgroup;
+		/*
+		 * Link us into the hwgroup.
+		 * This must be done early, do ensure that unexpected_intr
+		 * can find the hwif and prevent irq storms.
+		 * No drives are attached to the new hwif, choose_drive
+		 * can't do anything stupid (yet).
+		 * Add ourself as the 2nd entry to the hwgroup->hwif
+		 * linked list, the first entry is the hwif that owns
+		 * hwgroup->handler - do not change that.
+		 */
+		spin_lock_irq(&ide_lock);
+		hwif->next = hwgroup->hwif->next;
+		hwgroup->hwif->next = hwif;
+		spin_unlock_irq(&ide_lock);
 	} else {
-		hwgroup = new_hwgroup;
-		if (!hwgroup) {
-			spin_unlock_irqrestore(&ide_lock, flags);
-			return 1;
-		}
+		hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_KERNEL);
+		if (!hwgroup)
+	       		goto out_up;
+
+		hwif->hwgroup = hwgroup;
+
 		memset(hwgroup, 0, sizeof(ide_hwgroup_t));
 		hwgroup->hwif     = hwif->next = hwif;
 		hwgroup->rq       = NULL;
@@ -1112,44 +1143,35 @@
 			/* clear nIEN */
 			hwif->OUTB(0x08, hwif->io_ports[IDE_CONTROL_OFFSET]);
 
-		if (request_irq(hwif->irq,&ide_intr,sa,hwif->name,hwgroup)) {
-			if (!match)
-				kfree(hwgroup);
-			spin_unlock_irqrestore(&ide_lock, flags);
-			return 1;
-		}
+		if (request_irq(hwif->irq,&ide_intr,sa,hwif->name,hwgroup))
+	       		goto out_unlink;
 	}
 
 	/*
-	 * Everything is okay, so link us into the hwgroup
+	 * Link any new drives into the hwgroup, allocate
+	 * the block device queue and initialize the drive.
+	 * Note that ide_init_drive sends commands to the new
+	 * drive.
 	 */
-	hwif->hwgroup = hwgroup;
-	hwif->next = hwgroup->hwif->next;
-	hwgroup->hwif->next = hwif;
-
 	for (index = 0; index < MAX_DRIVES; ++index) {
 		ide_drive_t *drive = &hwif->drives[index];
 		if (!drive->present)
 			continue;
-		if (!hwgroup->drive)
-			hwgroup->drive = drive;
-		drive->next = hwgroup->drive->next;
-		hwgroup->drive->next = drive;
-		spin_unlock_irqrestore(&ide_lock, flags);
 		ide_init_queue(drive);
-		spin_lock_irqsave(&ide_lock, flags);
-	}
-
-	if (!hwgroup->hwif) {
-		hwgroup->hwif = HWIF(hwgroup->drive);
-#ifdef DEBUG
-		printk("%s : Adding missed hwif to hwgroup!!\n", hwif->name);
-#endif
+		spin_lock_irq(&ide_lock);
+		if (!hwgroup->drive) {
+			/* first drive for hwgroup. */
+			drive->next = drive;
+			hwgroup->drive = drive;
+			hwgroup->hwif = HWIF(hwgroup->drive);
+		} else {
+			drive->next = hwgroup->drive->next;
+			hwgroup->drive->next = drive;
+		}
+		spin_unlock_irq(&ide_lock);
+		ide_init_drive(drive);
 	}
 
-	/* all CPUs; safe now that hwif->hwgroup is set up */
-	spin_unlock_irqrestore(&ide_lock, flags);
-
 #if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__sparc__)
 	printk("%s at 0x%03lx-0x%03lx,0x%03lx on irq %d", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET],
@@ -1168,6 +1190,30 @@
 		printk(" (%sed with %s)",
 			hwif->sharing_irq ? "shar" : "serializ", match->name);
 	printk("\n");
+	up(&ide_cfg_sem);
+	return 0;
+out_unlink:
+	spin_lock_irq(&ide_lock);
+	if (hwif->next == hwif) {
+		BUG_ON(match);
+		BUG_ON(hwgroup->hwif != hwif);
+		kfree(hwgroup);
+	} else {
+		ide_hwif_t *g;
+		g = hwgroup->hwif;
+		while (g->next != hwif)
+			g = g->next;
+		g->next = hwif->next;
+		if (hwgroup->hwif == hwif) {
+			/* Impossible. */
+			printk(KERN_ERR "Duh. Uninitialized hwif listed as active hwif.\n");
+			hwgroup->hwif = g;
+		}
+		BUG_ON(hwgroup->hwif == hwif);
+	}
+	spin_unlock_irq(&ide_lock);
+out_up:
+	up(&ide_cfg_sem);
 	return 0;
 }
 
@@ -1340,6 +1386,7 @@
 void export_ide_init_queue (ide_drive_t *drive)
 {
 	ide_init_queue(drive);
+	ide_init_drive(drive);
 }
 
 EXPORT_SYMBOL(export_ide_init_queue);
@@ -1384,7 +1431,8 @@
 			if (!hwif->present)
 				continue;
 			for (unit = 0; unit < MAX_DRIVES; ++unit)
-				ata_attach(&hwif->drives[unit]);
+				if (hwif->drives[unit].present)
+					ata_attach(&hwif->drives[unit]);
 		}
 	}
 	if (!ide_probe)
