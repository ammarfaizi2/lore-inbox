Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261983AbTCQUoS>; Mon, 17 Mar 2003 15:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261987AbTCQUoS>; Mon, 17 Mar 2003 15:44:18 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:9195 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261983AbTCQUoM>;
	Mon, 17 Mar 2003 15:44:12 -0500
Message-ID: <3E763626.3060600@colorfullife.com>
Date: Mon, 17 Mar 2003 21:55:02 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC, PATCH] ide-probe init_irq cleanup
Content-Type: multipart/mixed;
 boundary="------------060101050907070705060400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060101050907070705060400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

init_irq calls request_irq while holding the ide_lock spinlock. This can 
deadlock, because request_irq can sleep under some circumstances - e.g. 
for the allocation of the /proc/irq entries, or for randomness 
management structures.

The attached patch modifies init_irq and calls request_irq without the 
spinlock held. It also fixes a potential race between choose_drive and 
init_irq.

The patch is against 2.5.64-ac4, it should apply to 2.5.64 with some 
offsets.


--
    Manfred

--------------060101050907070705060400
Content-Type: text/plain;
 name="patch-ide"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ide"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 64
//  EXTRAVERSION = -ac4
--- 2.5/include/linux/ide.h	2003-03-15 18:57:02.000000000 +0100
+++ build-2.5/include/linux/ide.h	2003-03-15 18:59:44.000000000 +0100
@@ -1740,6 +1740,19 @@
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
 
 extern spinlock_t ide_lock;
+extern struct semaphore ide_cfg_sem;
+/*
+ * Structure locking:
+ *
+ * ide_cfg_sem and ide_lock together protect changes to
+ * ide_hwif_t->{next,hwgroup}
+ * ide_drive_t->next
+ *
+ * ide_hwgroup_t->busy: ide_lock
+ * ide_hwgroup_t->hwif: ide_lock
+ * ide_hwif_t->mate: constant, no locking
+ * ide_drive_t->hwif: constant, no locking
+ */
 
 #define local_irq_set(flags)	do { local_save_flags((flags)); local_irq_enable(); } while (0)
 
--- 2.5/drivers/ide/ide-probe.c	2003-03-15 18:57:00.000000000 +0100
+++ build-2.5/drivers/ide/ide-probe.c	2003-03-17 21:52:44.000000000 +0100
@@ -1017,7 +1017,13 @@
 
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
@@ -1040,16 +1046,14 @@
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
@@ -1081,14 +1085,28 @@
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
@@ -1120,44 +1138,35 @@
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
@@ -1176,6 +1185,30 @@
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
 
@@ -1351,6 +1384,7 @@
 void export_ide_init_queue (ide_drive_t *drive)
 {
 	ide_init_queue(drive);
+	ide_init_drive(drive);
 }
 
 EXPORT_SYMBOL(export_ide_init_queue);
--- 2.5/drivers/ide/ide.c	2003-03-15 18:57:00.000000000 +0100
+++ build-2.5/drivers/ide/ide.c	2003-03-15 18:59:44.000000000 +0100
@@ -177,6 +177,7 @@
 static int system_bus_speed;	/* holds what we think is VESA/PCI bus speed */
 static int initializing;	/* set while initializing built-in drivers */
 
+DECLARE_MUTEX(ide_cfg_sem);
 spinlock_t ide_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 static int ide_scan_direction; /* THIS was formerly 2.2.x pci=reverse */
@@ -582,17 +583,19 @@
  
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
@@ -607,7 +610,7 @@
 	}
 	hwif->present = 0;
 	
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irq(&ide_lock);
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
@@ -619,7 +622,6 @@
 #ifdef CONFIG_PROC_FS
 	destroy_proc_ide_drives(hwif);
 #endif
-	spin_lock_irqsave(&ide_lock, flags);
 	hwgroup = hwif->hwgroup;
 
 	/*
@@ -634,6 +636,7 @@
 	if (irq_count == 1)
 		free_irq(hwif->irq, hwgroup);
 
+	spin_lock_irq(&ide_lock);
 	/*
 	 * Note that we only release the standard ports,
 	 * and do not even try to handle any extra ports
@@ -645,7 +648,6 @@
 	 * Remove us from the hwgroup, and free
 	 * the hwgroup if we were the only member
 	 */
-	d = hwgroup->drive;
 	for (i = 0; i < MAX_DRIVES; ++i) {
 		drive = &hwif->drives[i];
 		if (drive->de) {
@@ -654,11 +656,23 @@
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
@@ -666,15 +680,28 @@
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
@@ -814,7 +841,8 @@
 
 	hwif->hwif_data			= old_hwif.hwif_data;
 abort:
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irq(&ide_lock);
+	up(&ide_cfg_sem);
 }
 
 EXPORT_SYMBOL(ide_unregister);
--- 2.5/drivers/ide/ide-io.c	2003-03-15 18:57:00.000000000 +0100
+++ build-2.5/drivers/ide/ide-io.c	2003-03-15 18:59:44.000000000 +0100
@@ -771,8 +771,8 @@
 	/* for atari only: POSSIBLY BROKEN HERE(?) */
 	ide_get_lock(ide_intr, hwgroup);
 
-	/* necessary paranoia: ensure IRQs are masked on local CPU */
-	local_irq_disable();
+	/* caller must own ide_lock */
+	BUG_ON(!irqs_disabled());
 
 	while (!hwgroup->busy) {
 		hwgroup->busy = 1;

--------------060101050907070705060400--

