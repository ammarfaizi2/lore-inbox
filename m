Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTDTSYA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbTDTSYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:24:00 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:33469 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263668AbTDTSX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:23:28 -0400
Message-ID: <3EA2E86A.7010606@colorfullife.com>
Date: Sun, 20 Apr 2003 20:35:22 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mailing-lists@digitaleric.net
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68 IDE Oops at boot
References: <3EA286D5.30706@colorfullife.com> <200304201348.34229.lkml@digitaleric.net>
In-Reply-To: <200304201348.34229.lkml@digitaleric.net>
Content-Type: multipart/mixed;
 boundary="------------030801000008060508080103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030801000008060508080103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eric Northup wrote:

>init_irq called for hwif ide0.
>hdc: MAXTOR 6L080L4, ATA DISK drive
>
init_irq called, but does nothing.

>init_irq called for hwif ide2.
>blk_init_queue: c04c99d4 initialized.
>
This is what's supposed to happen: init_irq initialized the queues.

Two bugs:
- why doesn't init_irq initialize the queues for the siimage controller? 
I found a difference between 2.5.67 and 68: init_irq always returns 0, 
even on error. It should return 1 on error. (It wasn't difficult to 
find, I introduced it :-(
- The error handling is bad. Probably drive->present should be forced to 
0, if the queues could not be initialized.

Could you try the attached patch? It fixes the return code and adds some 
additional printks.

--
    Manfred

--------------030801000008060508080103
Content-Type: text/plain;
 name="patch-elv-search"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-elv-search"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 68
//  EXTRAVERSION =
--- 2.5/drivers/block/elevator.c	2003-04-20 11:19:13.000000000 +0200
+++ build-2.5/drivers/block/elevator.c	2003-04-20 20:04:55.000000000 +0200
@@ -290,6 +290,7 @@
 	if (plug)
 		blk_plug_device(q);
 
+if(!q->elevator.elevator_add_req_fn) printk(KERN_INFO "Duh. Elevator %p not initialized.\n", q);
 	q->elevator.elevator_add_req_fn(q, rq, insert);
 }
 
--- 2.5/drivers/block/ll_rw_blk.c	2003-04-20 11:19:13.000000000 +0200
+++ build-2.5/drivers/block/ll_rw_blk.c	2003-04-20 20:04:55.000000000 +0200
@@ -1156,6 +1156,7 @@
 {
 	int count = (queue_nr_requests*2);
 
+printk(KERN_INFO "blk_cleanup_queue: destroying %p.\n", q);
 	elevator_exit(q);
 
 	count -= __blk_cleanup_queue(&q->rq[READ]);
@@ -1273,6 +1274,7 @@
 	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
 
 	INIT_LIST_HEAD(&q->plug_list);
+printk(KERN_INFO "blk_init_queue: %p initialized.\n", q);
 
 	return 0;
 }
--- 2.5/drivers/ide/ide.c	2003-04-20 11:13:39.000000000 +0200
+++ build-2.5/drivers/ide/ide.c	2003-04-20 20:04:55.000000000 +0200
@@ -599,6 +599,7 @@
 	hwif = &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
+printk(KERN_INFO "ide_unregister called for %s.\n", hwif->name);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
 		if (!drive->present)
@@ -1428,6 +1429,7 @@
 		if (!try_module_get(driver->owner))
 			continue;
 		spin_unlock(&drivers_lock);
+printk(KERN_INFO "ata_attach: trying driver %p for drive %s(%p).\n", driver, drive->name, &drive->queue);
 		if (driver->attach(drive) == 0) {
 			module_put(driver->owner);
 			drive->gendev.driver = &driver->gen_driver;
--- 2.5/drivers/ide/ide-probe.c	2003-04-20 11:13:39.000000000 +0200
+++ build-2.5/drivers/ide/ide-probe.c	2003-04-20 20:22:05.000000000 +0200
@@ -1007,8 +1007,8 @@
 	 *	limits and LBA48 we could raise it but as yet
 	 *	do not.
 	 */
-	 
 	blk_init_queue(q, do_ide_request, &ide_lock);
+printk(KERN_INFO "ide_init_queue: drive %s has queue %p.\n", drive->name, q); 
 	q->queuedata = HWGROUP(drive);
 	drive->queue_setup = 1;
 	blk_queue_segment_boundary(q, 0xffff);
@@ -1060,6 +1060,8 @@
 	BUG_ON(irqs_disabled());	
 	down(&ide_cfg_sem);
 	hwif->hwgroup = NULL;
+
+printk(KERN_INFO "init_irq called for hwif %s.\n", hwif->name);
 #if MAX_HWIFS > 1
 	/*
 	 * Group up with any other hwifs that share our irq(s).
@@ -1107,8 +1109,10 @@
 		spin_unlock_irq(&ide_lock);
 	} else {
 		hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_KERNEL);
-		if (!hwgroup)
+		if (!hwgroup) {
+printk(KERN_INFO "init_irq: kmalloc failed.\n");
 	       		goto out_up;
+		}
 
 		hwif->hwgroup = hwgroup;
 
@@ -1143,8 +1147,10 @@
 			/* clear nIEN */
 			hwif->OUTB(0x08, hwif->io_ports[IDE_CONTROL_OFFSET]);
 
-		if (request_irq(hwif->irq,&ide_intr,sa,hwif->name,hwgroup))
+		if (request_irq(hwif->irq,&ide_intr,sa,hwif->name,hwgroup)) {
+printk(KERN_INFO "init_irq: request_irq failed for irq %d.\n", hwif->irq);
 	       		goto out_unlink;
+		}
 	}
 
 	/*
@@ -1155,6 +1161,7 @@
 	 */
 	for (index = 0; index < MAX_DRIVES; ++index) {
 		ide_drive_t *drive = &hwif->drives[index];
+printk(KERN_INFO "init_irq: processing drive %s(%p), present %d.\n", drive->name, &drive->queue, drive->present);
 		if (!drive->present)
 			continue;
 		ide_init_queue(drive);
@@ -1214,7 +1221,7 @@
 	spin_unlock_irq(&ide_lock);
 out_up:
 	up(&ide_cfg_sem);
-	return 0;
+	return 1;
 }
 
 static int ata_lock(dev_t dev, void *data)
@@ -1315,8 +1322,10 @@
 {
 	int old_irq, unit;
 
+printk(KERN_INFO "hwif_init: hwif %s, stage 1.\n", hwif->name);
 	if (!hwif->present)
 		return 0;
+printk(KERN_INFO "hwif_init: hwif %s, stage 2.\n", hwif->name);
 
 	if (!hwif->irq) {
 		if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET])))
@@ -1325,6 +1334,7 @@
 			return (hwif->present = 0);
 		}
 	}
+printk(KERN_INFO "hwif_init: hwif %s, stage 3.\n", hwif->name);
 #ifdef CONFIG_BLK_DEV_HD
 	if (hwif->irq == HD_IRQ && hwif->io_ports[IDE_DATA_OFFSET] != HD_DATA) {
 		printk("%s: CANNOT SHARE IRQ WITH OLD "
@@ -1335,15 +1345,19 @@
 
 	/* we set it back to 1 if all is ok below */	
 	hwif->present = 0;
+printk(KERN_INFO "hwif_init: hwif %s, stage 4.\n", hwif->name);
 
 	if (register_blkdev(hwif->major, hwif->name))
 		return 0;
+printk(KERN_INFO "hwif_init: hwif %s, stage 5.\n", hwif->name);
 
 	if (alloc_disks(hwif) < 0)
 		goto out;
+printk(KERN_INFO "hwif_init: hwif %s, stage 6.\n", hwif->name);
 	
 	if (init_irq(hwif) == 0)
 		goto done;
+printk(KERN_INFO "hwif_init: hwif %s, stage 7.\n", hwif->name);
 
 	old_irq = hwif->irq;
 	/*
@@ -1355,6 +1369,7 @@
 			hwif->name, old_irq);
 		goto out_disks;
 	}
+printk(KERN_INFO "hwif_init: hwif %s, stage 8.\n", hwif->name);
 	if (init_irq(hwif)) {
 		printk("%s: probed IRQ %d and default IRQ %d failed.\n",
 			hwif->name, old_irq, hwif->irq);
--- 2.5/drivers/ide/setup-pci.c	2003-03-17 22:44:04.000000000 +0100
+++ build-2.5/drivers/ide/setup-pci.c	2003-04-20 20:04:55.000000000 +0200
@@ -751,6 +751,7 @@
 {
 	ata_index_t index_list = do_ide_setup_pci_device(dev, d, 1);
 
+printk(KERN_INFO "ide_setup_pci_device for %s called.\n", dev->dev.name);
 	if ((index_list.b.low & 0xf0) != 0xf0)
 		probe_hwif_init(&ide_hwifs[index_list.b.low]);
 	if ((index_list.b.high & 0xf0) != 0xf0)

--------------030801000008060508080103--

