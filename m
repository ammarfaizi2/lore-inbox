Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271526AbTGQSBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271549AbTGQSBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:01:24 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:51922 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S271526AbTGQSBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:01:17 -0400
Date: Thu, 17 Jul 2003 14:14:10 -0400
From: Ben Collins <bcollins@debian.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>, alan@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH] Fix ALi15x3 DMA on sparc64 (maybe others)
Message-ID: <20030717181410.GI1171@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a patch that is known to fix atleast the DMA corruption
occuring on sparc64 in 2.4.x kernels for ALi15x3 IDE chipsets. I think
Alan hinted that someone also reported it fixed a similar problem on
alpha.

I've been using this patch for some time now, with great results, and
Debian unstable sparc64 users have unknowingly been testing the patch
aswell. No reports of problems.

Please apply for 2.4.22. Original patch was from Ivan Kokshaysky.

--- linux/drivers/ide/pci/alim15x3.c.orig	Tue Apr 22 19:17:22 2003
+++ linux/drivers/ide/pci/alim15x3.c	Tue May 27 17:42:17 2003
@@ -525,10 +525,14 @@ static int ali15x3_config_drive_for_dma(
 
 	drive->init_speed = 0;
 
+	/* Set reasonable PIO timings first - some of them are needed
+	   for DMA as well. */
+	hwif->tuneproc(drive, 255);
+
 	if ((id->capability & 1) != 0 && drive->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (hwif->ide_dma_bad_drive(drive))
-			goto ata_pio;
+			goto no_dma_set;
 		if ((id->field_valid & 4) && (m5229_revision >= 0xC2)) {
 			if (id->dma_ultra & hwif->ultra_mask) {
 				/* Force if Capable UltraDMA */
@@ -550,11 +554,9 @@ try_dma_modes:
 			if (!config_chipset_for_dma(drive))
 				goto no_dma_set;
 		} else {
-			goto ata_pio;
+			goto no_dma_set;
 		}
 	} else {
-ata_pio:
-		hwif->tuneproc(drive, 255);
 no_dma_set:
 		return hwif->ide_dma_off_quietly(drive);
 	}

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
