Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271824AbTGRW1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270397AbTGRWX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:23:56 -0400
Received: from mail.iskon.hr ([213.191.128.4]:58536 "HELO mail.iskon.hr")
	by vger.kernel.org with SMTP id S271924AbTGRWTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:19:31 -0400
Date: Sat, 19 Jul 2003 00:34:25 +0200
From: Kresimir Kukulj <madmax@iskon.hr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] siimage.c - turning DMA on because of 'md' kernel thread.
Message-ID: <20030718223425.GA21110@max.zg.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

	I'm trying to use Sil3112a controller with two Seagate 120Gb SATA
disks for RAID-1 (mirror) with 'md - multiple devices' driver. I am aware
that I need to use some tricks to get it working, like this:

 # hdparm -d1 -X69 /dev/xxx
 # echo "max_kb_per_request:15" > /proc/ide/hd?/settings

First one prevents freezing the system when enabling DMA.
Second one stops IO errors.

As far as I can tell, it works ok, but with reduced bandwidth (because of
max_kb_per_request). When using 'md' driver for RAID-1 mirror (rootfs, swap)
with persistent superblocks I have problems. If server crashes (for some
reason), 'md' tries to resync mirrors automatically. That is done by a kernel
thread that is activated before init(8) is started. I have put 'hdparm' cludge
very early in the boot process, but that happens _after_ 'md' thread starts to
resync.  That means that disks are busy (in PIO mode), and when hdparm -d1 -X69
executes, system freezes [if there is no disk/little activity hdparm cludge
passes ok - for example, if RAID-1 is clean so there is no resync].

For past two days I tried to find a way to force ide driver to initialize disk
in dma mode automatically by the kernel itself although disks are set to PIO by
the bios for some reason. I devised a patch that does hdparm + echo cludge. I
have never seen linux kernel, so I am unsure if I did it correctly. Patch is
attached.  Please, if anyone uses it, test it to see if  it works ok for you! I
am not familiar with linux ide driver so I did this with a lot of printk's and
trial & error.

With this patch, disks are initialized by kernel to UDMA100, with
max_kb_per_request:15.  Now, RAID-1 is resynced at boot with DMA already
activated (so there is no need for hdparm) and it completed successfully.
At least it works for me. I need to do more disk stress tests to be sure it is
stable.

This is all done with vanilla 2.4.21.
2.4.22-pre4 didn't work at all. Copying a few MB of data freezes the kernel.

My motherboard is Asus P4G8X deluxe.
http://www.asus.com/products/mb/socket478/p4g8x-d/overview.htm

--- siimage.c.orig	Fri Jul 18 23:36:58 2003
+++ siimage.c	Fri Jul 18 23:36:59 2003
@@ -97,7 +97,7 @@
 
 	switch(hwif->pci_dev->device) {
 		case PCI_DEVICE_ID_SII_3112:
-			return 4;
+			return 3;
 		case PCI_DEVICE_ID_SII_680:
 			if ((scsc & 0x30) == 0x10)	/* 133 */
 				mode = 4;
@@ -297,7 +297,7 @@
 	struct hd_driveid *id	= drive->id;
 
 	if ((id->capability & 1) != 0 && drive->autodma) {
-		if (!(hwif->atapi_dma))
+		if ((hwif->atapi_dma))
 			goto fast_ata_pio;
 		/* Consult the list of known "bad" drives */
 		if (hwif->ide_dma_bad_drive(drive))
@@ -803,7 +803,7 @@
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
 
-	hwif->rqsize = 128;
+	hwif->rqsize = 15;
 	if ((dev->device == PCI_DEVICE_ID_SII_3112) && (!(class_rev)))
 		hwif->rqsize = 16;
 
-----------------------

I'm confused why is this check there:
 	if ((id->capability & 1) != 0 && drive->autodma) {
 		if (!(hwif->atapi_dma))
 			goto fast_ata_pio;

Is it intentional ?

-- 
Kresimir Kukulj                      madmax@iskon.hr
+--------------------------------------------------+
Old PC's never die. They just become Unix terminals.
