Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276477AbRJPR5V>; Tue, 16 Oct 2001 13:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276511AbRJPR5M>; Tue, 16 Oct 2001 13:57:12 -0400
Received: from patan.Sun.COM ([192.18.98.43]:25780 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S276477AbRJPR5G>;
	Tue, 16 Oct 2001 13:57:06 -0400
Message-ID: <3BCC744C.A4476B0A@sun.com>
Date: Tue, 16 Oct 2001 10:54:20 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org, alan@redhat.com, torvalds@transmeta.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE timeouts cleanups
Content-Type: multipart/mixed;
 boundary="------------8779504E2B1F44BB089CB34D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8779504E2B1F44BB089CB34D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre, Alan, Linus

This patch cleans up some timeouts in the IDE subsystem.  The changes are
all minor and obvious, and have been in use here for some time.

* change jiffies checks to use time_after()
* add and use IDE_TIMEOUT_* macros

Please apply this for the next 2.4.x kernel, or let me know of any issues.

Thanks!

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------8779504E2B1F44BB089CB34D
Content-Type: text/plain; charset=us-ascii;
 name="ide-timeouts.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-timeouts.diff"

diff -ruN dist-2.4.12+patches/drivers/ide/ide.c cvs-2.4.12+patches/drivers/ide/ide.c
--- dist-2.4.12+patches/drivers/ide/ide.c	Mon Oct 15 10:21:50 2001
+++ cvs-2.4.12+patches/drivers/ide/ide.c	Mon Oct 15 10:21:50 2001
@@ -654,7 +655,7 @@
 	if (OK_STAT(stat=GET_STAT(), 0, BUSY_STAT)) {
 		printk("%s: ATAPI reset complete\n", drive->name);
 	} else {
-		if (0 < (signed long)(hwgroup->poll_timeout - jiffies)) {
+		if (time_after(hwgroup->poll_timeout, jiffies)) {
 			ide_set_handler (drive, &atapi_reset_pollfunc, HZ/20, NULL);
 			return ide_started;	/* continue polling */
 		}
@@ -679,7 +680,7 @@
 	byte tmp;
 
 	if (!OK_STAT(tmp=GET_STAT(), 0, BUSY_STAT)) {
-		if (0 < (signed long)(hwgroup->poll_timeout - jiffies)) {
+		if (time_after(hwgroup->poll_timeout, jiffies)) {
 			ide_set_handler (drive, &reset_pollfunc, HZ/20, NULL);
 			return ide_started;	/* continue polling */
 		}
@@ -1107,15 +1108,18 @@
 
 	udelay(1);	/* spec allows drive 400ns to assert "BUSY" */
 	if ((stat = GET_STAT()) & BUSY_STAT) {
+		long expire;
 		__save_flags(flags);	/* local CPU only */
 		ide__sti();		/* local CPU only */
-		timeout += jiffies;
+
+		expire = IDE_TIMEOUT_MS(timeout);
 		while ((stat = GET_STAT()) & BUSY_STAT) {
-			if (0 < (signed long)(jiffies - timeout)) {
+			if (expire-- < 1) {
 				__restore_flags(flags);	/* local CPU only */
 				*startstop = ide_error(drive, "status timeout", stat);
 				return 1;
 			}
+			mdelay(1);
 		}
 		__restore_flags(flags);	/* local CPU only */
 	}
@@ -1300,7 +1304,7 @@
 	best = NULL;
 	drive = hwgroup->drive;
 	do {
-		if (!list_empty(&drive->queue.queue_head) && (!drive->sleep || 0 <= (signed long)(jiffies - drive->sleep))) {
+		if (!list_empty(&drive->queue.queue_head) && (!drive->sleep || time_after_eq(jiffies, drive->sleep))) {
 			if (!best
 			 || (drive->sleep && (!best->sleep || 0 < (signed long)(best->sleep - drive->sleep)))
 			 || (!best->sleep && 0 < (signed long)(WAKEUP(best) - WAKEUP(drive))))
@@ -1311,7 +1315,7 @@
 		}
 	} while ((drive = drive->next) != hwgroup->drive);
 	if (best && best->nice1 && !best->sleep && best != hwgroup->drive && best->service_time > WAIT_MIN_SLEEP) {
-		long t = (signed long)(WAKEUP(best) - jiffies);
+		long t = (long)WAKEUP(best) - (long) jiffies;
 		if (t >= WAIT_MIN_SLEEP) {
 			/*
 			 * We *may* have some time to spare, but first let's see if
@@ -1320,8 +1324,8 @@
 			drive = best->next;
 			do {
 				if (!drive->sleep
-				 && 0 < (signed long)(WAKEUP(drive) - (jiffies - best->service_time))
-				 && 0 < (signed long)((jiffies + t) - WAKEUP(drive)))
+				    && time_after(WAKEUP(drive), (jiffies - best->service_time))
+				    && time_after(jiffies + t, WAKEUP(drive)))
 				{
 					ide_stall_queue(best, IDE_MIN(t, 10 * WAIT_MIN_SLEEP));
 					goto repeat;
@@ -1395,7 +1399,7 @@
 				 * play fairly with us, just in case there are big differences
 				 * in relative throughputs.. don't want to hog the cpu too much.
 				 */
-				if (0 < (signed long)(jiffies + WAIT_MIN_SLEEP - sleep)) 
+				if (time_after(jiffies + WAIT_MIN_SLEEP, sleep)) 
 					sleep = jiffies + WAIT_MIN_SLEEP;
 #if 1
 				if (timer_pending(&hwgroup->timer))
@@ -1634,7 +1638,7 @@
 				/* Try to not flood the console with msgs */
 				static unsigned long last_msgtime, count;
 				++count;
-				if (0 < (signed long)(jiffies - (last_msgtime + HZ))) {
+				if (time_after(jiffies, last_msgtime + HZ)) {
 					last_msgtime = jiffies;
 					printk("%s%s: unexpected interrupt, status=0x%02x, count=%ld\n",
 					 hwif->name, (hwif->next == hwgroup->hwif) ? "" : "(?)", stat, count);
@@ -2440,7 +2444,7 @@
 		spin_unlock_irq(&io_request_lock);
 		__save_flags(lflags);	/* local CPU only */
 		__sti();		/* local CPU only; needed for jiffies */
-		if (0 < (signed long)(jiffies - timeout)) {
+		if (time_after(jiffies, timeout)) {
 			__restore_flags(lflags);	/* local CPU only */
 			printk("%s: channel busy\n", drive->name);
 			return -EBUSY;
diff -ruN dist-2.4.12+patches/drivers/ide/ide-features.c cvs-2.4.12+patches/drivers/ide/ide-features.c
--- dist-2.4.12+patches/drivers/ide/ide-features.c	Mon Oct 15 10:21:50 2001
+++ cvs-2.4.12+patches/drivers/ide/ide-features.c	Mon Oct 15 10:21:49 2001
@@ -164,16 +164,17 @@
 	 * change (copied from ide-probe.c)
 	 */
 	struct hd_driveid *id;
-	unsigned long timeout, flags;
+	unsigned long flags;
+	long timeout;
 
 	SELECT_MASK(HWIF(drive), drive, 1);
 	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);
 	ide_delay_50ms();
 	OUT_BYTE(WIN_IDENTIFY, IDE_COMMAND_REG);
-	timeout = jiffies + WAIT_WORSTCASE;
+	timeout = IDE_TIMEOUT_50MS(WAIT_WORSTCASE);
 	do {
-		if (0 < (signed long)(jiffies - timeout)) {
+		if (timeout-- < 1) {
 			SELECT_MASK(HWIF(drive), drive, 0);
 			return 0;	/* drive timed-out */
 		}
@@ -316,13 +317,15 @@
 	 * Wait for drive to become non-BUSY
 	 */
 	if ((stat = GET_STAT()) & BUSY_STAT) {
-		unsigned long flags, timeout;
+		unsigned long flags;
+		long timeout;
 		__save_flags(flags);	/* local CPU only */
 		ide__sti();		/* local CPU only -- for jiffies */
-		timeout = jiffies + WAIT_CMD;
+		timeout = IDE_TIMEOUT_MS(WAIT_CMD);
 		while ((stat = GET_STAT()) & BUSY_STAT) {
-			if (0 < (signed long)(jiffies - timeout))
+			if (timeout-- < 1)
 				break;
+			mdelay(1);
 		}
 		__restore_flags(flags); /* local CPU only */
 	}
diff -ruN dist-2.4.12+patches/drivers/ide/ide-probe.c cvs-2.4.12+patches/drivers/ide/ide-probe.c
--- dist-2.4.12+patches/drivers/ide/ide-probe.c	Mon Oct 15 10:21:50 2001
+++ cvs-2.4.12+patches/drivers/ide/ide-probe.c	Mon Oct 15 10:21:50 2001
@@ -191,6 +191,7 @@
 	int rc;
 	ide_ioreg_t hd_status;
 	unsigned long timeout;
+	long expire;
 	byte s, a;
 
 	if (IDE_CONTROL_REG) {
@@ -224,11 +225,10 @@
 #endif /* CONFIG_BLK_DEV_PDC4030 */
 		OUT_BYTE(cmd,IDE_COMMAND_REG);		/* ask drive for ID */
 	timeout = ((cmd == WIN_IDENTIFY) ? WAIT_WORSTCASE : WAIT_PIDENTIFY) / 2;
-	timeout += jiffies;
+	expire = IDE_TIMEOUT_50MS(timeout); 
 	do {
-		if (0 < (signed long)(jiffies - timeout)) {
+		if (expire-- < 1) 
 			return 1;	/* drive timed-out */
-		}
 		ide_delay_50ms();		/* give drive a breather */
 	} while (IN_BYTE(hd_status) & BUSY_STAT);
 
@@ -332,14 +332,14 @@
 		if ((rc = try_to_identify(drive,cmd)))   /* send cmd and wait */
 			rc = try_to_identify(drive,cmd); /* failed: try again */
 		if (rc == 1 && cmd == WIN_PIDENTIFY && drive->autotune != 2) {
-			unsigned long timeout;
+			long timeout;
 			printk("%s: no response (status = 0x%02x), resetting drive\n", drive->name, GET_STAT());
 			ide_delay_50ms();
 			OUT_BYTE (drive->select.all, IDE_SELECT_REG);
 			ide_delay_50ms();
 			OUT_BYTE(WIN_SRST, IDE_COMMAND_REG);
-			timeout = jiffies;
-			while ((GET_STAT() & BUSY_STAT) && time_before(jiffies, timeout + WAIT_WORSTCASE))
+			timeout = IDE_TIMEOUT_50MS(WAIT_WORSTCASE);
+			while ((GET_STAT() & BUSY_STAT) && timeout-- > 0)
 				ide_delay_50ms();
 			rc = try_to_identify(drive, cmd);
 		}
@@ -362,15 +362,15 @@
  */
 static void enable_nest (ide_drive_t *drive)
 {
-	unsigned long timeout;
+	long timeout;
 
 	printk("%s: enabling %s -- ", HWIF(drive)->name, drive->id->model);
 	SELECT_DRIVE(HWIF(drive), drive);
 	ide_delay_50ms();
 	OUT_BYTE(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
-	timeout = jiffies + WAIT_WORSTCASE;
+	timeout = IDE_TIMEOUT_50MS(WAIT_WORSTCASE);
 	do {
-		if (jiffies > timeout) {
+		if (timeout-- < 1) {
 			printk("failed (timeout)\n");
 			return;
 		}
@@ -538,7 +538,7 @@
 		}
 	}
 	if (hwif->io_ports[IDE_CONTROL_OFFSET] && hwif->reset) {
-		unsigned long timeout = jiffies + WAIT_WORSTCASE;
+		long timeout = IDE_TIMEOUT_50MS(WAIT_WORSTCASE);
 		byte stat;
 
 		printk("%s: reset\n", hwif->name);
@@ -548,7 +548,7 @@
 		do {
 			ide_delay_50ms();
 			stat = IN_BYTE(hwif->io_ports[IDE_STATUS_OFFSET]);
-		} while ((stat & BUSY_STAT) && 0 < (signed long)(timeout - jiffies));
+		} while ((stat & BUSY_STAT) && --timeout > 0);
 
 	}
 	__restore_flags(flags);	/* local CPU only */
diff -ruN dist-2.4.12+patches/drivers/ide/ide-proc.c cvs-2.4.12+patches/drivers/ide/ide-proc.c
--- dist-2.4.12+patches/drivers/ide/ide-proc.c	Mon Oct 15 10:21:50 2001
+++ cvs-2.4.12+patches/drivers/ide/ide-proc.c	Mon Oct 15 10:21:50 2001
@@ -192,7 +192,7 @@
 			cli();	/* all CPUs; ensure all writes are done together */
 			while (mygroup->busy || (mategroup && mategroup->busy)) {
 				sti();	/* all CPUs */
-				if (0 < (signed long)(jiffies - timeout)) {
+				if (time_after(jiffies, timeout)) {
 					printk("/proc/ide/%s/config: channel(s) busy, cannot write\n", hwif->name);
 					restore_flags(flags);	/* all CPUs */
 					return -EBUSY;
diff -ruN dist-2.4.12+patches/include/linux/ide.h cvs-2.4.12+patches/include/linux/ide.h
--- dist-2.4.12+patches/include/linux/ide.h	Mon Oct 15 10:23:42 2001
+++ cvs-2.4.12+patches/include/linux/ide.h	Mon Oct 15 10:23:42 2001
@@ -164,6 +164,9 @@
 /*
  * Timeouts for various operations:
  */
+#define IDE_TIMEOUT_50MS(a)  (((a)*20)/HZ)
+#define IDE_TIMEOUT_MS(a)    (((a)*1000)/HZ)
+
 #define WAIT_DRQ	(5*HZ/100)	/* 50msec - spec allows up to 20ms */
 #if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
 #define WAIT_READY	(5*HZ)		/* 5sec - some laptops are very slow */

--------------8779504E2B1F44BB089CB34D--

