Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274889AbTHFHQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274892AbTHFHQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:16:45 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7822 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S274889AbTHFHQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:16:41 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 6 Aug 2003 09:16:38 +0200 (MEST)
Message-Id: <UTC200308060716.h767Gcv01755.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Kill identify decoding 2/4
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part two of four: delete the identify decoding from ide-tape.c.

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	Fri May 30 18:12:56 2003
+++ b/drivers/ide/ide-tape.c	Wed Aug  6 09:43:01 2003
@@ -5580,13 +5580,16 @@
  *
  *	0 	If this tape driver is not currently supported by us.
  */
+
+#if IDETAPE_DEBUG_INFO
+#define IDE_IDENTIFY_DEBUG
+#include <linux/ide-identify.h>
+#endif
+
 static int idetape_identify_device (ide_drive_t *drive)
 {
 	struct idetape_id_gcw gcw;
 	struct hd_driveid *id = drive->id;
-#if IDETAPE_DEBUG_INFO
-	unsigned short mask,i;
-#endif /* IDETAPE_DEBUG_INFO */
 
 	if (drive->id_read == 0)
 		return 1;
@@ -5594,94 +5597,7 @@
 	*((unsigned short *) &gcw) = id->config;
 
 #if IDETAPE_DEBUG_INFO
-	printk(KERN_INFO "ide-tape: Dumping ATAPI Identify Device tape parameters\n");
-	printk(KERN_INFO "ide-tape: Protocol Type: ");
-	switch (gcw.protocol) {
-		case 0: case 1: printk("ATA\n");break;
-		case 2:	printk("ATAPI\n");break;
-		case 3: printk("Reserved (Unknown to ide-tape)\n");break;
-	}
-	printk(KERN_INFO "ide-tape: Device Type: %x - ",gcw.device_type);	
-	switch (gcw.device_type) {
-		case 0: printk("Direct-access Device\n");break;
-		case 1: printk("Streaming Tape Device\n");break;
-		case 2: case 3: case 4: printk("Reserved\n");break;
-		case 5: printk("CD-ROM Device\n");break;
-		case 6: printk("Reserved\n");
-		case 7: printk("Optical memory Device\n");break;
-		case 0x1f: printk("Unknown or no Device type\n");break;
-		default: printk("Reserved\n");
-	}
-	printk(KERN_INFO "ide-tape: Removable: %s",gcw.removable ? "Yes\n":"No\n");	
-	printk(KERN_INFO "ide-tape: Command Packet DRQ Type: ");
-	switch (gcw.drq_type) {
-		case 0: printk("Microprocessor DRQ\n");break;
-		case 1: printk("Interrupt DRQ\n");break;
-		case 2: printk("Accelerated DRQ\n");break;
-		case 3: printk("Reserved\n");break;
-	}
-	printk(KERN_INFO "ide-tape: Command Packet Size: ");
-	switch (gcw.packet_size) {
-		case 0: printk("12 bytes\n");break;
-		case 1: printk("16 bytes\n");break;
-		default: printk("Reserved\n");break;
-	}
-	printk(KERN_INFO "ide-tape: Model: %.40s\n",id->model);
-	printk(KERN_INFO "ide-tape: Firmware Revision: %.8s\n",id->fw_rev);
-	printk(KERN_INFO "ide-tape: Serial Number: %.20s\n",id->serial_no);
-	printk(KERN_INFO "ide-tape: Write buffer size: %d bytes\n",id->buf_size*512);
-	printk(KERN_INFO "ide-tape: DMA: %s",id->capability & 0x01 ? "Yes\n":"No\n");
-	printk(KERN_INFO "ide-tape: LBA: %s",id->capability & 0x02 ? "Yes\n":"No\n");
-	printk(KERN_INFO "ide-tape: IORDY can be disabled: %s",id->capability & 0x04 ? "Yes\n":"No\n");
-	printk(KERN_INFO "ide-tape: IORDY supported: %s",id->capability & 0x08 ? "Yes\n":"Unknown\n");
-	printk(KERN_INFO "ide-tape: ATAPI overlap supported: %s",id->capability & 0x20 ? "Yes\n":"No\n");
-	printk(KERN_INFO "ide-tape: PIO Cycle Timing Category: %d\n",id->tPIO);
-	printk(KERN_INFO "ide-tape: DMA Cycle Timing Category: %d\n",id->tDMA);
-	printk(KERN_INFO "ide-tape: Single Word DMA supported modes: ");
-	for (i=0,mask=1;i<8;i++,mask=mask << 1) {
-		if (id->dma_1word & mask)
-			printk("%d ",i);
-		if (id->dma_1word & (mask << 8))
-			printk("(active) ");
-	}
-	printk("\n");
-	printk(KERN_INFO "ide-tape: Multi Word DMA supported modes: ");
-	for (i=0,mask=1;i<8;i++,mask=mask << 1) {
-		if (id->dma_mword & mask)
-			printk("%d ",i);
-		if (id->dma_mword & (mask << 8))
-			printk("(active) ");
-	}
-	printk("\n");
-	if (id->field_valid & 0x0002) {
-		printk(KERN_INFO "ide-tape: Enhanced PIO Modes: %s\n",
-			id->eide_pio_modes & 1 ? "Mode 3":"None");
-		printk(KERN_INFO "ide-tape: Minimum Multi-word DMA cycle per word: ");
-		if (id->eide_dma_min == 0)
-			printk("Not supported\n");
-		else
-			printk("%d ns\n",id->eide_dma_min);
-
-		printk(KERN_INFO "ide-tape: Manufacturer\'s Recommended Multi-word cycle: ");
-		if (id->eide_dma_time == 0)
-			printk("Not supported\n");
-		else
-			printk("%d ns\n",id->eide_dma_time);
-
-		printk(KERN_INFO "ide-tape: Minimum PIO cycle without IORDY: ");
-		if (id->eide_pio == 0)
-			printk("Not supported\n");
-		else
-			printk("%d ns\n",id->eide_pio);
-
-		printk(KERN_INFO "ide-tape: Minimum PIO cycle with IORDY: ");
-		if (id->eide_pio_iordy == 0)
-			printk("Not supported\n");
-		else
-			printk("%d ns\n",id->eide_pio_iordy);
-		
-	} else
-		printk(KERN_INFO "ide-tape: According to the device, fields 64-70 are not valid.\n");
+	ide_dump_identify_info(id, "ide-tape");
 #endif /* IDETAPE_DEBUG_INFO */
 
 	/* Check that we can support this device */
