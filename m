Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263793AbTCUT2Z>; Fri, 21 Mar 2003 14:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263834AbTCUT14>; Fri, 21 Mar 2003 14:27:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52612
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263793AbTCUT0X>; Fri, 21 Mar 2003 14:26:23 -0500
Date: Fri, 21 Mar 2003 20:41:39 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212041.h2LKfdxV026437@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: rework the reset code tof ix posting and races
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This isnt perfect, there is a race left somewhere still but its closer.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-iops.c linux-2.5.65-ac2/drivers/ide/ide-iops.c
--- linux-2.5.65/drivers/ide/ide-iops.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-iops.c	2003-03-07 18:43:58.000000000 +0000
@@ -1050,7 +1071,7 @@
 
 
 /* needed below */
-ide_startstop_t do_reset1 (ide_drive_t *, int);
+static ide_startstop_t do_reset1 (ide_drive_t *, int);
 
 /*
  * atapi_reset_pollfunc() gets invoked to poll the interface for completion every 50ms
@@ -1167,8 +1188,7 @@
 
 void pre_reset (ide_drive_t *drive)
 {
-	if (drive->driver != NULL)
-		DRIVER(drive)->pre_reset(drive);
+	DRIVER(drive)->pre_reset(drive);
 
 	if (!drive->keep_settings) {
 		if (drive->using_dma) {
@@ -1202,14 +1222,20 @@
  * (up to 30 seconds worstcase).  So, instead of busy-waiting here for it,
  * we set a timer to poll at 50ms intervals.
  */
-ide_startstop_t do_reset1 (ide_drive_t *drive, int do_not_try_atapi)
+static ide_startstop_t do_reset1 (ide_drive_t *drive, int do_not_try_atapi)
 {
 	unsigned int unit;
 	unsigned long flags;
-	ide_hwif_t *hwif = HWIF(drive);
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	ide_hwif_t *hwif;
+	ide_hwgroup_t *hwgroup;
+	
+	spin_lock_irqsave(&ide_lock, flags);
+	hwif = HWIF(drive);
+	hwgroup = HWGROUP(drive);
 
-	local_irq_save(flags);
+	/* We must not reset with running handlers */
+	if(hwgroup->handler != NULL)
+		BUG();
 
 	/* For an ATAPI device, first try an ATAPI SRST. */
 	if (drive->media != ide_disk && !do_not_try_atapi) {
@@ -1218,10 +1244,8 @@
 		udelay (20);
 		hwif->OUTB(WIN_SRST, IDE_COMMAND_REG);
 		hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
-		if (HWGROUP(drive)->handler != NULL)
-			BUG();
-		ide_set_handler(drive, &atapi_reset_pollfunc, HZ/20, NULL);
-		local_irq_restore(flags);
+		__ide_set_handler(drive, &atapi_reset_pollfunc, HZ/20, NULL);
+		spin_unlock_irqrestore(&ide_lock, flags);
 		return ide_started;
 	}
 
@@ -1234,20 +1258,10 @@
 
 #if OK_TO_RESET_CONTROLLER
 	if (!IDE_CONTROL_REG) {
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&ide_lock, flags);
 		return ide_stopped;
 	}
 
-# if 0
-        {
-		u8 control = hwif->INB(IDE_CONTROL_REG);
-		control |= 0x04;
-		hwif->OUTB(control,IDE_CONTROL_REG);
-		udelay(30);
-		control &= 0xFB;
-		hwif->OUTB(control, IDE_CONTROL_REG);
-	}
-# else
 	/*
 	 * Note that we also set nIEN while resetting the device,
 	 * to mask unwanted interrupts from the interface during the reset.
@@ -1257,23 +1271,21 @@
 	 * recover from reset very quickly, saving us the first 50ms wait time.
 	 */
 	/* set SRST and nIEN */
-	hwif->OUTB(drive->ctl|6,IDE_CONTROL_REG);
+	hwif->OUTBSYNC(drive, drive->ctl|6,IDE_CONTROL_REG);
 	/* more than enough time */
 	udelay(10);
 	if (drive->quirk_list == 2) {
 		/* clear SRST and nIEN */
-		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
+		hwif->OUTBSYNC(drive, drive->ctl, IDE_CONTROL_REG);
 	} else {
 		/* clear SRST, leave nIEN */
-		hwif->OUTB(drive->ctl|2, IDE_CONTROL_REG);
+		hwif->OUTBSYNC(drive, drive->ctl|2, IDE_CONTROL_REG);
 	}
 	/* more than enough time */
 	udelay(10);
 	hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
-	if (HWGROUP(drive)->handler != NULL)
-		BUG();
-	ide_set_handler(drive, &reset_pollfunc, HZ/20, NULL);
-# endif
+	__ide_set_handler(drive, &reset_pollfunc, HZ/20, NULL);
+
 	/*
 	 * Some weird controller like resetting themselves to a strange
 	 * state when the disks are reset this way. At least, the Winbond
@@ -1281,71 +1293,22 @@
 	 */
 	if (hwif->resetproc != NULL) {
 		hwif->resetproc(drive);
-
-# if 0
-		if (drive->failures) {
-			local_irq_restore(flags);
-			return ide_stopped;
-		}
-# endif
 	}
-
+	
 #endif	/* OK_TO_RESET_CONTROLLER */
 
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ide_lock, flags);
 	return ide_started;
 }
 
-#if 0
 /*
  * ide_do_reset() is the entry point to the drive/interface reset code.
  */
+
 ide_startstop_t ide_do_reset (ide_drive_t *drive)
 {
 	return do_reset1(drive, 0);
 }
-#else
-/*
- * ide_do_reset() is the entry point to the drive/interface reset code.
- */
-ide_startstop_t ide_do_reset (ide_drive_t *drive)
-{
-	ide_startstop_t start_stop = ide_started;
-# if 0
-        u8 tmp_dma	= drive->using_dma;
-        u8 cspeed	= drive->current_speed;
-	u8 unmask	= drive->unmask;
-# endif
-
-	if (HWGROUP(drive)->handler != NULL) {
-		unsigned long flags;
-		spin_lock_irqsave(&ide_lock, flags);
-		HWGROUP(drive)->handler = NULL;
-		del_timer(&HWGROUP(drive)->timer);
-		spin_unlock_irqrestore(&ide_lock, flags);
-	}
-
-	start_stop = do_reset1(drive, 0);
-# if 0
-	/*
-	 * check for suspend-spindown flag,
-	 * to attempt a restart or spinup of device.
-	 */
-	if (drive->suspend_reset) {
-		/*
-		 * APM WAKE UP todo !!
-		 * int nogoodpower = 1;
-		 * while(nogoodpower) {
-		 * 	check_power1() or check_power2()
-		 * 	nogoodpower = 0;
-		 * }
-		 * HWIF(drive)->multiproc(drive);
-		 */
-# endif
-
-	return start_stop;
-}
-#endif
 
 EXPORT_SYMBOL(ide_do_reset);
 
