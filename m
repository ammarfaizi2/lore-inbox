Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTEODTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTEODSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:32 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:3308 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263775AbTEODSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:15 -0400
Date: Thu, 15 May 2003 04:31:01 +0100
Message-Id: <200305150331.h4F3V1Pv000529@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: axboe@suse.de, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Avoid ide-scsi from starting DMA too soon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This went into 2.4 with the following comments..

ide-scsi driver starts DMA as soon as it writes the ATAPI PACKET command
in command register and before sending the ATAPI command. This will
cause problems on many drives. Right way to do it is to start DMA after
sending the ATAPI command. I am attaching a patch that fixes this. This
patch will allow many more CD-RW drives to work reliably in DMA mode
than do today

Alan's comment to this diff previously..
"Thats the least of the 2.5 ide-scsi problems, but yes its probably one to add"

--- bk-linus/drivers/scsi/ide-scsi.c	2003-04-10 06:01:23.000000000 +0100
+++ linux-2.5/drivers/scsi/ide-scsi.c	2003-05-15 03:55:52.000000000 +0100
@@ -78,6 +78,7 @@ typedef struct idescsi_pc_s {
 #define PC_DMA_IN_PROGRESS		0	/* 1 while DMA in progress */
 #define PC_WRITING			1	/* Data direction */
 #define PC_TRANSFORM			2	/* transform SCSI commands */
+#define PC_DMA_OK			4	/* Use DMA */
 
 /*
  *	SCSI command transformation layer
@@ -494,6 +495,10 @@ static ide_startstop_t idescsi_transfer_
 	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);
 	/* Send the actual packet */
 	atapi_output_bytes(drive, scsi->pc->c, 12);
+	if (test_bit (PC_DMA_OK, &pc->flags)) {
+		set_bit (PC_DMA_IN_PROGRESS, &pc->flags);
+		(void) (HWIF(drive)->ide_dma_begin(drive));
+	}
 	return ide_started;
 }
 
@@ -527,10 +532,9 @@ static ide_startstop_t idescsi_issue_pc 
 	HWIF(drive)->OUTB(bcount.b.high, IDE_BCOUNTH_REG);
 	HWIF(drive)->OUTB(bcount.b.low, IDE_BCOUNTL_REG);
 
-	if (feature.b.dma) {
-		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
-		(void) (HWIF(drive)->ide_dma_begin(drive));
-	}
+	if (feature.b.dma)
+		set_bit(PC_DMA_OK, &pc->flags);
+
 	if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
 		if (HWGROUP(drive)->handler != NULL)
 			BUG();
