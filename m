Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264281AbTCXQ4B>; Mon, 24 Mar 2003 11:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264282AbTCXQuC>; Mon, 24 Mar 2003 11:50:02 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:45546 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264281AbTCXQa4>; Mon, 24 Mar 2003 11:30:56 -0500
Message-Id: <200303241642.h2OGg535008290@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:53 +0000
To: alan@redhat.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: ide-scsi quirk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
as mentioned a few weeks back, something similar to
this went into 2.4 (I munged this one a bit).

It deals with the issue of DMA starting before the
drive is ready iirc.


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/ide-scsi.c linux-2.5/drivers/scsi/ide-scsi.c
--- bk-linus/drivers/scsi/ide-scsi.c	2003-02-04 12:58:09.000000000 +0000
+++ linux-2.5/drivers/scsi/ide-scsi.c	2003-03-17 23:42:33.000000000 +0000
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
 
