Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267488AbUHDWqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267488AbUHDWqD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267489AbUHDWqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:46:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50428 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267488AbUHDWpq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:45:46 -0400
Date: Wed, 4 Aug 2004 15:45:39 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: [PATCH] IDE probe delay symbol
Message-ID: <20040804224539.GA10142@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since making IDE probe delays variable met with resistance, how about
defining the magic constant in a single place and with a somewhat
meaningful identifier?

--- linux-2.6.8-rc3-orig/drivers/ide/ide-iops.c	2004-08-04 14:09:00.000000000 -0700
+++ linux-2.6.8-rc3-ide-delay-sym/drivers/ide/ide-iops.c	2004-08-04 14:53:35.000000000 -0700
@@ -767,7 +767,7 @@
 	SELECT_MASK(drive, 1);
 	if (IDE_CONTROL_REG)
 		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);
-	msleep(50);
+	msleep(IDE_PROBE_DELAY);
 	hwif->OUTB(WIN_IDENTIFY, IDE_COMMAND_REG);
 	timeout = jiffies + WAIT_WORSTCASE;
 	do {
@@ -775,9 +775,9 @@
 			SELECT_MASK(drive, 0);
 			return 0;	/* drive timed-out */
 		}
-		msleep(50);	/* give drive a breather */
+		msleep(IDE_PROBE_DELAY);	/* give drive a breather */
 	} while (hwif->INB(IDE_ALTSTATUS_REG) & BUSY_STAT);
-	msleep(50);	/* wait for IRQ and DRQ_STAT */
+	msleep(IDE_PROBE_DELAY);	/* wait for IRQ and DRQ_STAT */
 	if (!OK_STAT(hwif->INB(IDE_STATUS_REG),DRQ_STAT,BAD_R_STAT)) {
 		SELECT_MASK(drive, 0);
 		printk("%s: CHECK for good STATUS\n", drive->name);
@@ -827,7 +827,7 @@
 	u8 stat;
 
 //	while (HWGROUP(drive)->busy)
-//		msleep(50);
+//		msleep(IDE_PROBE_DELAY);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->ide_dma_check)	 /* check if host supports DMA */
--- linux-2.6.8-rc3-orig/drivers/ide/ide-probe.c	2004-08-04 14:09:00.000000000 -0700
+++ linux-2.6.8-rc3-ide-delay-sym/drivers/ide/ide-probe.c	2004-08-04 14:54:13.000000000 -0700
@@ -273,7 +273,7 @@
 	u8 s = 0, a = 0;
 
 	/* take a deep breath */
-	msleep(50);
+	msleep(IDE_PROBE_DELAY);
 
 	if (IDE_CONTROL_REG) {
 		a = hwif->INB(IDE_ALTSTATUS_REG);
@@ -312,11 +312,11 @@
 			return 1;
 		}
 		/* give drive a breather */
-		msleep(50);
+		msleep(IDE_PROBE_DELAY);
 	} while ((hwif->INB(hd_status)) & BUSY_STAT);
 
 	/* wait for IRQ and DRQ_STAT */
-	msleep(50);
+	msleep(IDE_PROBE_DELAY);
 	if (OK_STAT((hwif->INB(IDE_STATUS_REG)), DRQ_STAT, BAD_R_STAT)) {
 		unsigned long flags;
 
@@ -445,15 +445,15 @@
 	/* needed for some systems
 	 * (e.g. crw9624 as drive0 with disk as slave)
 	 */
-	msleep(50);
+	msleep(IDE_PROBE_DELAY);
 	SELECT_DRIVE(drive);
-	msleep(50);
+	msleep(IDE_PROBE_DELAY);
 	if (hwif->INB(IDE_SELECT_REG) != drive->select.all && !drive->present) {
 		if (drive->select.b.unit != 0) {
 			/* exit with drive0 selected */
 			SELECT_DRIVE(&hwif->drives[0]);
 			/* allow BUSY_STAT to assert & clear */
-			msleep(50);
+			msleep(IDE_PROBE_DELAY);
 		}
 		/* no i/f present: mmm.. this should be a 4 -ml */
 		return 3;
@@ -476,14 +476,14 @@
 			printk("%s: no response (status = 0x%02x), "
 				"resetting drive\n", drive->name,
 				hwif->INB(IDE_STATUS_REG));
-			msleep(50);
+			msleep(IDE_PROBE_DELAY);
 			hwif->OUTB(drive->select.all, IDE_SELECT_REG);
-			msleep(50);
+			msleep(IDE_PROBE_DELAY);
 			hwif->OUTB(WIN_SRST, IDE_COMMAND_REG);
 			timeout = jiffies;
 			while (((hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) &&
 			       time_before(jiffies, timeout + WAIT_WORSTCASE))
-				msleep(50);
+				msleep(IDE_PROBE_DELAY);
 			rc = try_to_identify(drive, cmd);
 		}
 		if (rc == 1)
@@ -498,7 +498,7 @@
 	if (drive->select.b.unit != 0) {
 		/* exit with drive0 selected */
 		SELECT_DRIVE(&hwif->drives[0]);
-		msleep(50);
+		msleep(IDE_PROBE_DELAY);
 		/* ensure drive irq is clear */
 		(void) hwif->INB(IDE_STATUS_REG);
 	}
@@ -515,7 +515,7 @@
 
 	printk("%s: enabling %s -- ", hwif->name, drive->id->model);
 	SELECT_DRIVE(drive);
-	msleep(50);
+	msleep(IDE_PROBE_DELAY);
 	hwif->OUTB(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
 	timeout = jiffies + WAIT_WORSTCASE;
 	do {
@@ -523,10 +523,10 @@
 			printk("failed (timeout)\n");
 			return;
 		}
-		msleep(50);
+		msleep(IDE_PROBE_DELAY);
 	} while ((hwif->INB(IDE_STATUS_REG)) & BUSY_STAT);
 
-	msleep(50);
+	msleep(IDE_PROBE_DELAY);
 
 	if (!OK_STAT((hwif->INB(IDE_STATUS_REG)), 0, BAD_STAT)) {
 		printk("failed (status = 0x%02x)\n", hwif->INB(IDE_STATUS_REG));
@@ -767,7 +767,7 @@
 		udelay(10);
 		hwif->OUTB(8, hwif->io_ports[IDE_CONTROL_OFFSET]);
 		do {
-			msleep(50);
+			msleep(IDE_PROBE_DELAY);
 			stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
 		} while ((stat & BUSY_STAT) && time_after(timeout, jiffies));
 
--- linux-2.6.8-rc3-orig/drivers/ide/legacy/pdc4030.c	2004-08-04 14:15:13.000000000 -0700
+++ linux-2.6.8-rc3-ide-delay-sym/drivers/ide/legacy/pdc4030.c	2004-08-04 14:57:10.000000000 -0700
@@ -283,7 +283,7 @@
 	hwif->OUTB(0x14, IDE_SELECT_REG);
 	hwif->OUTB(PROMISE_EXTENDED_COMMAND, IDE_COMMAND_REG);
 
-	msleep(50);
+	msleep(IDE_PROBE_DELAY);
 
 	if (hwif->INB(IDE_ERROR_REG) == 'P' &&
 	    hwif->INB(IDE_NSECTOR_REG) == 'T' &&
--- linux-2.6.8-rc3-orig/include/linux/ide.h	2004-08-04 14:15:41.000000000 -0700
+++ linux-2.6.8-rc3-ide-delay-sym/include/linux/ide.h	2004-08-04 14:56:11.000000000 -0700
@@ -1664,4 +1664,6 @@
 
 extern struct bus_type ide_bus_type;
 
+#define IDE_PROBE_DELAY	50	/* milliseconds */
+
 #endif /* _IDE_H */



-- 
Todd Poynor
MontaVista Software

