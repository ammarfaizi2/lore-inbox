Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274902AbTHFHNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274903AbTHFHNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:13:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:13965 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S274902AbTHFHNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:13:47 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 6 Aug 2003 09:13:42 +0200 (MEST)
Message-Id: <UTC200308060713.h767Dg001328.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Kill identify decoding 1/4
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part one of four: delete the identify decoding from ide-floppy.c.

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	Sun Jun 15 01:40:55 2003
+++ b/drivers/ide/ide-floppy.c	Wed Aug  6 09:48:34 2003
@@ -1638,13 +1638,15 @@
  *	idefloppy_identify_device checks if we can support a drive,
  *	based on the ATAPI IDENTIFY command results.
  */
+
+#if IDEFLOPPY_DEBUG_INFO
+#define IDE_IDENTIFY_DEBUG
+#include <linux/ide-identify.h>
+#endif
+
 static int idefloppy_identify_device (ide_drive_t *drive,struct hd_driveid *id)
 {
 	struct idefloppy_id_gcw gcw;
-#if IDEFLOPPY_DEBUG_INFO
-	u16 mask,i;
-	char buffer[80];
-#endif /* IDEFLOPPY_DEBUG_INFO */
 
 	*((u16 *) &gcw) = id->config;
 
@@ -1657,88 +1659,8 @@
 #endif
 
 #if IDEFLOPPY_DEBUG_INFO
-	printk(KERN_INFO "Dumping ATAPI Identify Device floppy parameters\n");
-	switch (gcw.protocol) {
-		case 0: case 1: sprintf(buffer, "ATA");break;
-		case 2:	sprintf(buffer, "ATAPI");break;
-		case 3: sprintf(buffer, "Reserved (Unknown to ide-floppy)");break;
-	}
-	printk(KERN_INFO "Protocol Type: %s\n", buffer);
-	switch (gcw.device_type) {
-		case 0: sprintf(buffer, "Direct-access Device");break;
-		case 1: sprintf(buffer, "Streaming Tape Device");break;
-		case 2: case 3: case 4: sprintf (buffer, "Reserved");break;
-		case 5: sprintf(buffer, "CD-ROM Device");break;
-		case 6: sprintf(buffer, "Reserved");
-		case 7: sprintf(buffer, "Optical memory Device");break;
-		case 0x1f: sprintf(buffer, "Unknown or no Device type");break;
-		default: sprintf(buffer, "Reserved");
-	}
-	printk(KERN_INFO "Device Type: %x - %s\n", gcw.device_type, buffer);
-	printk(KERN_INFO "Removable: %s\n",gcw.removable ? "Yes":"No");	
-	switch (gcw.drq_type) {
-		case 0: sprintf(buffer, "Microprocessor DRQ");break;
-		case 1: sprintf(buffer, "Interrupt DRQ");break;
-		case 2: sprintf(buffer, "Accelerated DRQ");break;
-		case 3: sprintf(buffer, "Reserved");break;
-	}
-	printk(KERN_INFO "Command Packet DRQ Type: %s\n", buffer);
-	switch (gcw.packet_size) {
-		case 0: sprintf(buffer, "12 bytes");break;
-		case 1: sprintf(buffer, "16 bytes");break;
-		default: sprintf(buffer, "Reserved");break;
-	}
-	printk(KERN_INFO "Command Packet Size: %s\n", buffer);
-	printk(KERN_INFO "Model: %.40s\n",id->model);
-	printk(KERN_INFO "Firmware Revision: %.8s\n",id->fw_rev);
-	printk(KERN_INFO "Serial Number: %.20s\n",id->serial_no);
-	printk(KERN_INFO "Write buffer size(?): %d bytes\n",id->buf_size*512);
-	printk(KERN_INFO "DMA: %s",id->capability & 0x01 ? "Yes\n":"No\n");
-	printk(KERN_INFO "LBA: %s",id->capability & 0x02 ? "Yes\n":"No\n");
-	printk(KERN_INFO "IORDY can be disabled: %s",id->capability & 0x04 ? "Yes\n":"No\n");
-	printk(KERN_INFO "IORDY supported: %s",id->capability & 0x08 ? "Yes\n":"Unknown\n");
-	printk(KERN_INFO "ATAPI overlap supported: %s",id->capability & 0x20 ? "Yes\n":"No\n");
-	printk(KERN_INFO "PIO Cycle Timing Category: %d\n",id->tPIO);
-	printk(KERN_INFO "DMA Cycle Timing Category: %d\n",id->tDMA);
-	printk(KERN_INFO "Single Word DMA supported modes:\n");
-	for (i=0,mask=1;i<8;i++,mask=mask << 1) {
-		if (id->dma_1word & mask)
-			printk(KERN_INFO "   Mode %d%s\n", i,
-			(id->dma_1word & (mask << 8)) ? " (active)" : "");
-	}
-	printk(KERN_INFO "Multi Word DMA supported modes:\n");
-	for (i=0,mask=1;i<8;i++,mask=mask << 1) {
-		if (id->dma_mword & mask)
-			printk(KERN_INFO "   Mode %d%s\n", i,
-			(id->dma_mword & (mask << 8)) ? " (active)" : "");
-	}
-	if (id->field_valid & 0x0002) {
-		printk(KERN_INFO "Enhanced PIO Modes: %s\n",
-			id->eide_pio_modes & 1 ? "Mode 3":"None");
-		if (id->eide_dma_min == 0)
-			sprintf(buffer, "Not supported");
-		else
-			sprintf(buffer, "%d ns",id->eide_dma_min);
-		printk(KERN_INFO "Minimum Multi-word DMA cycle per word: %s\n", buffer);
-		if (id->eide_dma_time == 0)
-			sprintf(buffer, "Not supported");
-		else
-			sprintf(buffer, "%d ns",id->eide_dma_time);
-		printk(KERN_INFO "Manufacturer\'s Recommended Multi-word cycle: %s\n", buffer);
-		if (id->eide_pio == 0)
-			sprintf(buffer, "Not supported");
-		else
-			sprintf(buffer, "%d ns",id->eide_pio);
-		printk(KERN_INFO "Minimum PIO cycle without IORDY: %s\n",
-			buffer);
-		if (id->eide_pio_iordy == 0)
-			sprintf(buffer, "Not supported");
-		else
-			sprintf(buffer, "%d ns",id->eide_pio_iordy);
-		printk(KERN_INFO "Minimum PIO cycle with IORDY: %s\n", buffer);
-	} else
-		printk(KERN_INFO "According to the device, fields 64-70 are not valid.\n");
-#endif /* IDEFLOPPY_DEBUG_INFO */
+        ide_dump_identify_info(id, "ide-floppy");
+#endif /* IDETAPE_DEBUG_INFO */
 
 	if (gcw.protocol != 2)
 		printk(KERN_ERR "ide-floppy: Protocol is not ATAPI\n");

