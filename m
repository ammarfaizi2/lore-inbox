Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269031AbUJEOXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269031AbUJEOXg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 10:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUJEOXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 10:23:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63925 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269031AbUJEOWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 10:22:55 -0400
Date: Tue, 5 Oct 2004 16:20:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] ide-dma blacklist behaviour broken
Message-ID: <20041005142001.GR2433@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The blacklist stuff is broken. When set_using_dma() calls into
ide_dma_check(), it returns ide_dma_off() for a blacklisted drive. This
of course succeeds, returning success to the caller of ide_dma_check().
Not so good... It then uncondtionally calls ide_dma_on(), which turns on
dma for the drive.

This moves the check to ide_dma_on() so we also catch the buggy
->ide_dma_check() defined by various chipset drivers.

--- drivers/ide/ide-dma.c~	2004-10-05 16:11:49.631910586 +0200
+++ drivers/ide/ide-dma.c	2004-10-05 16:21:58.828330845 +0200
@@ -354,11 +355,13 @@
 	struct hd_driveid *id = drive->id;
 	ide_hwif_t *hwif = HWIF(drive);
 
-	if ((id->capability & 1) && hwif->autodma) {
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			return __ide_dma_off(drive);
+	/* Consult the list of known "bad" drives */
+	if (__ide_dma_bad_drive(drive)) {
+		__ide_dma_off(drive);
+		return 1;
+	}
 
+	if ((id->capability & 1) && hwif->autodma) {
 		/*
 		 * Enable DMA on any drive that has
 		 * UltraDMA (mode 0/1/2/3/4/5/6) enabled
@@ -512,6 +515,9 @@
  
 int __ide_dma_on (ide_drive_t *drive)
 {
+	if (__ide_dma_bad_drive(drive))
+		return 1;
+
 	drive->using_dma = 1;
 	ide_toggle_bounce(drive, 1);
 

-- 
Jens Axboe

