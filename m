Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbSKAXde>; Fri, 1 Nov 2002 18:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265820AbSKAXdd>; Fri, 1 Nov 2002 18:33:33 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:27795 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S265819AbSKAXdb>;
	Fri, 1 Nov 2002 18:33:31 -0500
Subject: [PATCH] ide-scsi driver starts DMA too soon
To: linux-kernel@vger.kernel.org
Date: Fri, 1 Nov 2002 16:39:52 -0700 (MST)
Cc: marcelo@conectiva.com.br, andre@linux-ide.org
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E187lOK-0003Jd-00@lyra.fc.hp.com>
From: Khalid Aziz <khalid@fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide-scsi driver starts DMA as soon as it writes the ATAPI PACKET command
in command register and before sending the ATAPI command. This will
cause problems on many drives. Right way to do it is to start DMA after
sending the ATAPI command. I am attaching a patch that fixes this. This
patch will allow many more CD-RW drives to work reliably in DMA mode 
than do today.

Marcelo, please apply.

--
Khalid

====================================================================
Khalid Aziz                                Linux and Open Source Lab
(970)898-9214                                        Hewlett-Packard
khalid@hp.com                                       Fort Collins, CO


-----------CUT HERE-------------CUT HERE-------------CUT HERE-----------
--- linux-2.4.19/drivers/scsi/ide-scsi.c	Fri Aug  2 18:39:44 2002
+++ linux-2.4.19.cd_dma/drivers/scsi/ide-scsi.c	Fri Nov  1 16:31:30 2002
@@ -397,6 +397,8 @@
 	idescsi_pc_t *pc = scsi->pc;
 	byte ireason;
 	ide_startstop_t startstop;
+	struct request *rq = pc->rq;
+	int dma_ok = 0;
 
 	if (ide_wait_stat (&startstop,drive,DRQ_STAT,BUSY_STAT,WAIT_READY)) {
 		printk (KERN_ERR "ide-scsi: Strange, packet command initiated yet DRQ isn't asserted\n");
@@ -407,8 +409,14 @@
 		printk (KERN_ERR "ide-scsi: (IO,CoD) != (0,1) while issuing a packet command\n");
 		return ide_do_reset (drive);
 	}
+	if (drive->using_dma && rq->bh)
+		dma_ok=!HWIF(drive)->dmaproc(test_bit (PC_WRITING, &pc->flags) ? ide_dma_write : ide_dma_read, drive);
 	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), NULL);	/* Set the interrupt routine */
 	atapi_output_bytes (drive, scsi->pc->c, 12);			/* Send the actual packet */
+	if (dma_ok) {
+		set_bit (PC_DMA_IN_PROGRESS, &pc->flags);
+		(void) (HWIF(drive)->dmaproc(ide_dma_begin, drive));
+	}
 	return ide_started;
 }
 
@@ -437,10 +445,6 @@
 	OUT_BYTE (bcount >> 8,IDE_BCOUNTH_REG);
 	OUT_BYTE (bcount & 0xff,IDE_BCOUNTL_REG);
 
-	if (dma_ok) {
-		set_bit (PC_DMA_IN_PROGRESS, &pc->flags);
-		(void) (HWIF(drive)->dmaproc(ide_dma_begin, drive));
-	}
 	if (test_bit (IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
 		ide_set_handler (drive, &idescsi_transfer_pc, get_timeout(pc), NULL);
 		OUT_BYTE (WIN_PACKETCMD, IDE_COMMAND_REG);		/* Issue the packet command */
