Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTDTL1S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 07:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263559AbTDTL1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 07:27:17 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:57506 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263558AbTDTL1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 07:27:14 -0400
Message-ID: <3EA286D5.30706@colorfullife.com>
Date: Sun, 20 Apr 2003 13:39:01 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Northup <lkml@digitaleric.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68 IDE Oops at boot
Content-Type: multipart/mixed;
 boundary="------------020901090404070904060306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020901090404070904060306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric,

the oops occurs in __elv_add_request, because the elevator structure is 
not initialized:
Eric wrote:

>EIP:    0060:[<00000000>]    Not tainted
>[ snip ]
>Call Trace:
> [<c02839e3>] __elv_add_request+0x33/0x50
>  
>
A jump to an uninitialized function pointer within __elv_add_request.


Eric wrote:

>SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
>SiI3112 Serial ATA: chipset revision 1
>SiI3112 Serial ATA: not 100% native mode: will probe irqs later
>    ide0: MMIO-DMA at 0xf8808000-0xf8808007, BIOS settings: hda:pio, hdb:pio
>    ide1: MMIO-DMA at 0xf8808008-0xf880800f, BIOS settings: hdc:pio, hdd:pio
>hda: MAXTOR 6L080L4, ATA DISK drive
>hdc: MAXTOR 6L080L4, ATA DISK drive
>NFORCE2: IDE controller at PCI slot 00:09.0
>NFORCE2: chipset revision 162
>NFORCE2: not 100% native mode: will probe irqs later
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 controller 
>on pci00:09.0
>    ide2: BM-DMA at 0xf000-0xf007, BIOS settings: hde:DMA, hdf:DMA
>    ide3: BM-DMA at 0xf008-0xf00f, BIOS settings: hdg:DMA, hdh:DMA
>hde: MAXTOR 6L040L2, ATA DISK drive
>ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
>
That line is from init_irq(), called within hwif_init(): hwif and drives 
fully initialized.

>hdg: PLEXTOR CD-R PX-W4012A, ATAPI CD/DVD-ROM drive
>hdh: Pioneer DVD-ROM ATAPIModel DVD-104S 020, ATAPI CD/DVD-ROM drive
>ide3 at 0x170-0x177,0x376 on irq 15
>  
>
Dito.

Hmm. But where is "ide0 at ... on irq ..."?

It seems the drives attached to the sata controller were not initialized 
properly. No idea why. Could you apply the attached patch? I assume that 
the hwif_init fails somewhere before calling init_irq(), the printks 
would show me where.

--
    Manfred

--------------020901090404070904060306
Content-Type: text/plain;
 name="patch-elv-search"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-elv-search"

diff -u -r 2.5/drivers/block/elevator.c build-2.5/drivers/block/elevator.c
--- 2.5/drivers/block/elevator.c	2003-04-20 11:19:13.000000000 +0200
+++ build-2.5/drivers/block/elevator.c	2003-04-20 12:51:30.000000000 +0200
@@ -290,6 +290,7 @@
 	if (plug)
 		blk_plug_device(q);
 
+if(!q->elevator.elevator_add_req_fn) printk(KERN_INFO "Duh. Elevator %p not initialized.\n", q);
 	q->elevator.elevator_add_req_fn(q, rq, insert);
 }
 
diff -u -r 2.5/drivers/block/ll_rw_blk.c build-2.5/drivers/block/ll_rw_blk.c
--- 2.5/drivers/block/ll_rw_blk.c	2003-04-20 11:19:13.000000000 +0200
+++ build-2.5/drivers/block/ll_rw_blk.c	2003-04-20 12:51:13.000000000 +0200
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
diff -u -r 2.5/drivers/ide/ide.c build-2.5/drivers/ide/ide.c
--- 2.5/drivers/ide/ide.c	2003-04-20 11:13:39.000000000 +0200
+++ build-2.5/drivers/ide/ide.c	2003-04-20 13:08:29.000000000 +0200
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
diff -u -r 2.5/drivers/ide/ide-probe.c build-2.5/drivers/ide/ide-probe.c
--- 2.5/drivers/ide/ide-probe.c	2003-04-20 11:13:39.000000000 +0200
+++ build-2.5/drivers/ide/ide-probe.c	2003-04-20 13:28:28.000000000 +0200
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
@@ -1315,8 +1317,10 @@
 {
 	int old_irq, unit;
 
+printk(KERN_INFO "hwif_init: hwif %s, stage 1.\n", hwif->name);
 	if (!hwif->present)
 		return 0;
+printk(KERN_INFO "hwif_init: hwif %s, stage 2.\n", hwif->name);
 
 	if (!hwif->irq) {
 		if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET])))
@@ -1325,6 +1329,7 @@
 			return (hwif->present = 0);
 		}
 	}
+printk(KERN_INFO "hwif_init: hwif %s, stage 3.\n", hwif->name);
 #ifdef CONFIG_BLK_DEV_HD
 	if (hwif->irq == HD_IRQ && hwif->io_ports[IDE_DATA_OFFSET] != HD_DATA) {
 		printk("%s: CANNOT SHARE IRQ WITH OLD "
@@ -1335,15 +1340,19 @@
 
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
@@ -1355,6 +1364,7 @@
 			hwif->name, old_irq);
 		goto out_disks;
 	}
+printk(KERN_INFO "hwif_init: hwif %s, stage 8.\n", hwif->name);
 	if (init_irq(hwif)) {
 		printk("%s: probed IRQ %d and default IRQ %d failed.\n",
 			hwif->name, old_irq, hwif->irq);
diff -u -r 2.5/drivers/ide/setup-pci.c build-2.5/drivers/ide/setup-pci.c
--- 2.5/drivers/ide/setup-pci.c	2003-03-17 22:44:04.000000000 +0100
+++ build-2.5/drivers/ide/setup-pci.c	2003-04-20 13:31:58.000000000 +0200
@@ -751,6 +751,7 @@
 {
 	ata_index_t index_list = do_ide_setup_pci_device(dev, d, 1);
 
+printk(KERN_INFO "ide_setup_pci_device for %s called.\n", dev->dev.name);
 	if ((index_list.b.low & 0xf0) != 0xf0)
 		probe_hwif_init(&ide_hwifs[index_list.b.low]);
 	if ((index_list.b.high & 0xf0) != 0xf0)

--------------020901090404070904060306--

