Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264011AbTCUUWx>; Fri, 21 Mar 2003 15:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263829AbTCUT1Y>; Fri, 21 Mar 2003 14:27:24 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54148
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263823AbTCUT1F>; Fri, 21 Mar 2003 14:27:05 -0500
Date: Fri, 21 Mar 2003 20:42:21 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212042.h2LKgLpu026449@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update ide-tape to match changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-tape.c linux-2.5.65-ac2/drivers/ide/ide-tape.c
--- linux-2.5.65/drivers/ide/ide-tape.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-tape.c	2003-03-07 17:33:05.000000000 +0000
@@ -422,7 +422,7 @@
  *		sharing a (fast) ATA-2 disk with any (slow) new ATAPI device.
  */
 
-#define IDETAPE_VERSION "1.17b"
+#define IDETAPE_VERSION "1.17b-ac1"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -2128,8 +2128,6 @@
 			if (temp > pc->buffer_size) {
 				printk(KERN_ERR "ide-tape: The tape wants to send us more data than expected - discarding data\n");
 				idetape_discard_data(drive, bcount.all);
-				if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
-					BUG();
 				ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);
 				return ide_started;
 			}
@@ -2156,8 +2154,6 @@
 	if (tape->debug_level >= 2)
 		printk(KERN_INFO "ide-tape: [cmd %x] transferred %d bytes on that interrupt\n", pc->c[0], bcount.all);
 #endif
-	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
-		BUG();
 	ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);	/* And set the interrupt handler again */
 	return ide_started;
 }
@@ -2235,8 +2231,6 @@
 		return ide_do_reset(drive);
 	}
 	tape->cmd_start_time = jiffies;
-	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
-		BUG();
 	/* Set the interrupt routine */
 	ide_set_handler(drive, &idetape_pc_intr, IDETAPE_WAIT_CMD, NULL);
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -2325,8 +2319,6 @@
 	if (dma_ok)			/* Will begin DMA later */
 		set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
 	if (test_bit(IDETAPE_DRQ_INTERRUPT, &tape->flags)) {
-		if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
-			BUG();
 		ide_set_handler(drive, &idetape_transfer_pc, IDETAPE_WAIT_CMD, NULL);
 		OUT_BYTE(WIN_PACKETCMD, IDE_COMMAND_REG);
 		return ide_started;
@@ -5605,15 +5597,16 @@
  *
  *	0 	If this tape driver is not currently supported by us.
  */
-static int idetape_identify_device (ide_drive_t *drive,struct hd_driveid *id)
+static int idetape_identify_device (ide_drive_t *drive)
 {
 	struct idetape_id_gcw gcw;
+	struct hd_driveid *id = drive->id;
 #if IDETAPE_DEBUG_INFO
 	unsigned short mask,i;
 #endif /* IDETAPE_DEBUG_INFO */
 
-	if (!id)
-		return 0;
+	if (drive->id_read == 0)
+		return 1;
 
 	*((unsigned short *) &gcw) = id->config;
 
@@ -6287,7 +6280,7 @@
 		goto failed;
 	if (drive->media != ide_tape)
 		goto failed;
-	if (!idetape_identify_device (drive, drive->id)) {
+	if (!idetape_identify_device (drive)) {
 		printk(KERN_ERR "ide-tape: %s: not supported by this version of ide-tape\n", drive->name);
 		goto failed;
 	}
