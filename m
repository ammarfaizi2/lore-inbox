Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbUL0PBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbUL0PBZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbUL0PBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:01:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:33691 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261886AbUL0PBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:01:22 -0500
Subject: PATCH: 2.6.10 - Still mishandles volumes without geometry data
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104155840.20898.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Dec 2004 13:57:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An IDE device can choose not to report geometry. In this situation the
base 2.6 kernel tries to verify the LBA data despite having nothing to
validate it against and prints it out (although now only as pr_debug).

This patch fixes these problems and has in various forms been in
2.6.9-ac and Fedora Core for a considerable time now

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/drivers/ide/ide-disk.c linux-2.6.10/drivers/ide/ide-disk.c
--- linux.vanilla-2.6.10/drivers/ide/ide-disk.c	2004-12-25 21:15:34.000000000 +0000
+++ linux-2.6.10/drivers/ide/ide-disk.c	2004-12-26 21:55:43.084714368 +0000
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
+		if(drive->bios_cyl)
+			pr_debug("%s: CHS=%u/%u/%u\n", drive->name, cyl, head, sect);
 
 		hwif->OUTB(0x00, IDE_FEATURE_REG);
 		hwif->OUTB(nsectors.b.low, IDE_NSECTOR_REG);

