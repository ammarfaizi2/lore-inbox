Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUL1XM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUL1XM3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUL1XM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:12:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:18847 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261156AbUL1XMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:12:21 -0500
Subject: Re: PATCH: 2.6.10 - Still mishandles volumes without geometry data
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e041228124878cb6e2a@mail.gmail.com>
References: <1104155840.20898.3.camel@localhost.localdomain>
	 <58cb370e041228124878cb6e2a@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104271702.26131.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 22:08:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok how about this revision which also silences the boot time CHS data as
Bartlomiej suggested.

--- linux.vanilla-2.6.10/drivers/ide/ide-disk.c	2004-12-25 21:15:34.000000000 +0000
+++ linux-2.6.10/drivers/ide/ide-disk.c	2004-12-28 23:07:13.195925352 +0000
@@ -84,6 +84,10 @@
 {
 	unsigned long lba_sects, chs_sects, head, tail;
 
+	/* No non-LBA info .. so valid! */
+	if (id->cyls == 0)
+		return 1;
+		
 	/*
 	 * The ATA spec tells large drives to return
 	 * C/H/S = 16383/16/63 independent of their size.
@@ -201,7 +205,8 @@
 		head  = track % drive->head;
 		cyl   = track / drive->head;
 
-		pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
+		if(cyl)
+			pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
 
 		hwif->OUTB(0x00, IDE_FEATURE_REG);
 		hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);
@@ -1239,8 +1257,9 @@
 	if (id->buf_size)
 		printk (" w/%dKiB Cache", id->buf_size/2);
 
-	printk(", CHS=%d/%d/%d", 
-	       drive->bios_cyl, drive->bios_head, drive->bios_sect);
+	if(drive->bios_cyl)
+		printk(", CHS=%d/%d/%d", 
+			drive->bios_cyl, drive->bios_head, drive->bios_sect);
 	if (drive->using_dma)
 		ide_dma_verbose(drive);
 	printk("\n");

