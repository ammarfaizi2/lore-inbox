Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUHBNMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUHBNMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUHBNMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:12:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32458 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264884AbUHBNL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:11:59 -0400
Date: Mon, 2 Aug 2004 15:11:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: serialize access to ide device
Message-ID: <20040802131150.GR10496@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

2.6 breaks really really easily if you have any traffic on a device and
issue a hdparm (or similar) command to it. Things like set_using_dma()
and ide_set_xfer_rate() just stomp all over the drive regardless of what
it's doing right now.

I hacked something up for the SUSE kernel to fix this _almost_, it still
doesn't handle cases where you want to serialize across more than a
single channel. Not a common case, but I think there is such hardware
out there (which?).

Clearly something needs to be done about this, it's extremely
frustrating not to be able to reliably turn on dma on a drive at all.
I'm just tossing this one out there to solve 99% of the case, I'd like
some input from you on what you feel we should do.

(Note patch is for the SLES9 base kernel, should be easy to adapt. I
didn't do that, since I'm just sparking conversation - I will if you
want it, though).

diff -urp /opt/kernel/linux-2.6.5/drivers/ide/ide.c linux-2.6.5/drivers/ide/ide.c
--- /opt/kernel/linux-2.6.5/drivers/ide/ide.c	2004-05-25 11:50:14.797583926 +0200
+++ linux-2.6.5/drivers/ide/ide.c	2004-05-25 11:52:40.367855970 +0200
@@ -1289,18 +1289,28 @@ static int set_io_32bit(ide_drive_t *dri
 static int set_using_dma (ide_drive_t *drive, int arg)
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
+	int ret = -EPERM;
+
+	ide_pin_hwgroup(drive);
+
 	if (!drive->id || !(drive->id->capability & 1))
-		return -EPERM;
+		goto out;
 	if (HWIF(drive)->ide_dma_check == NULL)
-		return -EPERM;
+		goto out;
+	ret = -EIO;
 	if (arg) {
-		if (HWIF(drive)->ide_dma_check(drive)) return -EIO;
-		if (HWIF(drive)->ide_dma_on(drive)) return -EIO;
+		if (HWIF(drive)->ide_dma_check(drive))
+			goto out;
+		if (HWIF(drive)->ide_dma_on(drive))
+			goto out;
 	} else {
 		if (__ide_dma_off(drive))
-			return -EIO;
+			goto out;
 	}
-	return 0;
+	ret = 0;
+out:
+	ide_unpin_hwgroup(drive);
+	return ret;
 #else
 	return -EPERM;
 #endif
diff -urp /opt/kernel/linux-2.6.5/drivers/ide/ide-io.c linux-2.6.5/drivers/ide/ide-io.c
--- /opt/kernel/linux-2.6.5/drivers/ide/ide-io.c	2004-05-25 11:50:15.174543192 +0200
+++ linux-2.6.5/drivers/ide/ide-io.c	2004-05-25 11:53:34.606000019 +0200
@@ -881,6 +881,46 @@ void ide_stall_queue (ide_drive_t *drive
 	drive->sleep = timeout + jiffies;
 }
 
+void ide_unpin_hwgroup(ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+
+	if (hwgroup) {
+		spin_lock_irq(&ide_lock);
+		HWGROUP(drive)->busy = 0;
+		drive->blocked = 0;
+		do_ide_request(drive->queue);
+		spin_unlock_irq(&ide_lock);
+	}
+}
+
+void ide_pin_hwgroup(ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+
+	/*
+	 * should only happen very early, so not a problem
+	 */
+	if (!hwgroup)
+		return;
+
+	spin_lock_irq(&ide_lock);
+	do {
+		if (!hwgroup->busy && !drive->blocked && !drive->doing_barrier)
+			break;
+		spin_unlock_irq(&ide_lock);
+		schedule_timeout(HZ/100);
+		spin_lock_irq(&ide_lock);
+	} while (hwgroup->busy || drive->blocked || drive->doing_barrier);
+
+	/*
+	 * we've now secured exclusive access to this hwgroup
+	 */
+	hwgroup->busy = 1;
+	drive->blocked = 1;
+	spin_unlock_irq(&ide_lock);
+}
+
 EXPORT_SYMBOL(ide_stall_queue);
 
 #define WAKEUP(drive)	((drive)->service_start + 2 * (drive)->service_time)
diff -urp /opt/kernel/linux-2.6.5/drivers/ide/ide-lib.c linux-2.6.5/drivers/ide/ide-lib.c
--- /opt/kernel/linux-2.6.5/drivers/ide/ide-lib.c	2004-05-25 11:50:15.204539951 +0200
+++ linux-2.6.5/drivers/ide/ide-lib.c	2004-05-25 11:52:40.433848845 +0200
@@ -436,13 +436,17 @@ EXPORT_SYMBOL(ide_toggle_bounce);
  
 int ide_set_xfer_rate(ide_drive_t *drive, u8 rate)
 {
+	int ret;
 #ifndef CONFIG_BLK_DEV_IDEDMA
 	rate = min(rate, (u8) XFER_PIO_4);
 #endif
-	if(HWIF(drive)->speedproc)
-		return HWIF(drive)->speedproc(drive, rate);
+	ide_pin_hwgroup(drive);
+	if (HWIF(drive)->speedproc)
+		ret = HWIF(drive)->speedproc(drive, rate);
 	else
-		return -1;
+		ret = -1;
+	ide_unpin_hwgroup(drive);
+	return ret;
 }
 
 EXPORT_SYMBOL_GPL(ide_set_xfer_rate);
diff -urp /opt/kernel/linux-2.6.5/include/linux/ide.h linux-2.6.5/include/linux/ide.h
--- /opt/kernel/linux-2.6.5/include/linux/ide.h	2004-05-25 11:50:29.701973356 +0200
+++ linux-2.6.5/include/linux/ide.h	2004-05-25 11:52:40.457846254 +0200
@@ -1474,6 +1474,9 @@ extern irqreturn_t ide_intr(int irq, voi
 extern void do_ide_request(request_queue_t *);
 extern void ide_init_subdrivers(void);
 
+extern void ide_pin_hwgroup(ide_drive_t *);
+extern void ide_unpin_hwgroup(ide_drive_t *);
+
 extern struct block_device_operations ide_fops[];
 extern ide_proc_entry_t generic_subdriver_entries[];
 

-- 
Jens Axboe

