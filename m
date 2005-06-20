Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVFTWGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVFTWGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVFTWA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:00:59 -0400
Received: from coderock.org ([193.77.147.115]:3480 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261627AbVFTVuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:50:44 -0400
Message-Id: <20050620214916.220102000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:49:16 +0200
From: domen@coderock.org
To: spyro@f2s.com
Cc: linux-kernel@vger.kernel.org, James Nelson <james4765@gmail.com>,
       domen@coderock.org
Subject: [patch 2/3] acorn: clean up printk()s in drivers/acorn/block/fd1772.c
Content-Disposition: inline; filename=printk-drivers_acorn_block_fd1772.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Nelson <james4765@cwazy.co.uk>


This patch puts KERN_ constants in printk()'s and makes the debugging printk()'s
more consistent in drivers/acorn/block/fd1772.c

Signed-off-by: James Nelson <james4765@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 fd1772.c |  138 +++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 68 insertions(+), 70 deletions(-)

Index: quilt/drivers/acorn/block/fd1772.c
===================================================================
--- quilt.orig/drivers/acorn/block/fd1772.c
+++ quilt/drivers/acorn/block/fd1772.c
@@ -124,6 +124,8 @@
  *                Minor parameter, name layouts for 2.4.x differences
  */
 
+#undef DEBUG /* define to enable debugging statements */
+
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/fcntl.h>
@@ -165,13 +167,6 @@
 /* Ditto worries for Arc - DAG */
 #define FD_MAX_UNITS 4
 #define TRACKBUFFER 0
-/*#define DEBUG*/
-
-#ifdef DEBUG
-#define DPRINT(a)	printk a
-#else
-#define DPRINT(a)
-#endif
 
 static struct request_queue *floppy_queue;
 
@@ -180,6 +175,9 @@ static struct request_queue *floppy_queu
 #define DEVICE_NAME "floppy"
 #define QUEUE (floppy_queue)
 #define CURRENT elv_next_request(floppy_queue)
+#define PFX DEVICE_NAME ": "
+
+#define DBG(fmt, args...) pr_debug(PFX "%s(): " fmt, __FUNCTION__ , ## args)
 
 /* Disk types: DD */
 static struct archy_disk_type {
@@ -240,9 +238,9 @@ extern volatile int fdc1772_fdc_int_done
 void FDC1772_WRITE(int reg, unsigned char val)
 {
 	if (reg == FDC1772REG_CMD) {
-		DPRINT(("FDC1772_WRITE new command 0x%x @ %d\n", val,jiffies));
+		DBG("new command 0x%x @ %d\n", val,jiffies);
 		if (fdc1772_fdc_int_done) {
-			DPRINT(("FDC1772_WRITE: Hmm fdc1772_fdc_int_done true - resetting\n"));
+			DBG("Hmm fdc1772_fdc_int_done true - resetting\n");
 			fdc1772_fdc_int_done = 0;
 		};
 	};
@@ -409,9 +407,7 @@ static void fd_select_side(int side)
 
 static void fd_select_drive(int drive)
 {
-#ifdef DEBUG
-	printk("fd_select_drive:%d\n", drive);
-#endif
+	DBG("%d\n", drive);
 	/* Hmm - nowhere do we seem to turn the motor on - I'm going to do it here! */
 	oldlatch_aupdate(LATCHA_MOTOR | LATCHA_INUSE, 0);
 
@@ -434,7 +430,7 @@ static void fd_deselect(void)
 {
 	unsigned long flags;
 
-	DPRINT(("fd_deselect\n"));
+	DBG("start\n");
 
 	oldlatch_aupdate(LATCHA_FDSELALL | LATCHA_MOTOR | LATCHA_INUSE, 0xf | LATCHA_MOTOR | LATCHA_INUSE);
 
@@ -474,7 +470,7 @@ static void fd_motor_off_timer(unsigned 
 		 * off on the Arc, since the motor control is actually on
 		 * Latch A
 		 */
-		DPRINT(("fdc1772: deselecting in fd_motor_off_timer\n"));
+		DBG("deselecting\n");
 		fd_deselect();
 		MotorOn = 0;
 		restore_flags(flags);
@@ -523,7 +519,7 @@ static void check_change(unsigned long d
 		/* The idea here is that if the write protect line has changed then
 		the disc must have changed */
 		if (stat != unit[drive].wpstat) {
-			DPRINT(("wpstat[%d] = %d\n", drive, stat));
+			DBG("wpstat[%d] = %d\n", drive, stat);
 			unit[drive].wpstat = stat;
 			set_bit(drive, &changed_floppies);
 		}
@@ -579,12 +575,13 @@ static void floppy_irqconsequencehandler
 	if (handler) {
 		nop();
 		status = (unsigned char) fdc1772_comendstatus;
-		DPRINT(("FDC1772 irq, status = %02x handler = %08lx\n", (unsigned int) status, (unsigned long) handler));
+		DBG("status = %02x handler = %08lx\n", (unsigned int) status,
+			(unsigned long) handler);
 		handler(status);
 	} else {
-		DPRINT(("FDC1772 irq, no handler status=%02x\n", fdc1772_comendstatus));
+		DBG("no handler status=%02x\n", fdc1772_comendstatus);
 	}
-	DPRINT(("FDC1772 irq: end of floppy_irq\n"));
+	DBG("end\n");
 }
 
 
@@ -594,16 +591,16 @@ static void floppy_irqconsequencehandler
 
 static void fd_error(void)
 {
-	printk("FDC1772: fd_error\n");
+	DBG("start\n");
 	/*panic("fd1772: fd_error"); *//* DAG tmp */
 	if (!CURRENT)
 		return;
 	CURRENT->errors++;
 	if (CURRENT->errors >= MAX_ERRORS) {
-		printk("fd%d: too many errors.\n", SelectedDrive);
+		printk(KERN_ERR "fd%d: too many errors, giving up\n", SelectedDrive);
 		end_request(CURRENT, 0);
 	} else if (CURRENT->errors == RECALIBRATE_ERRORS) {
-		printk("fd%d: recalibrating\n", SelectedDrive);
+		printk(KERN_ERR "fd%d: error, recalibrating...\n", SelectedDrive);
 		if (SelectedDrive != -1)
 			unit[SelectedDrive].track = -1;
 	}
@@ -627,7 +624,7 @@ static void fd_error(void)
 static void do_fd_action(int drive)
 {
 	struct request *req;
-	DPRINT(("do_fd_action unit[drive].track=%d\n", unit[drive].track));
+	DBG("unit[drive].track=%d\n", unit[drive].track);
 
 #ifdef TRACKBUFFER
 repeat:
@@ -675,12 +672,12 @@ repeat:
 
 static void fd_calibrate(void)
 {
-	DPRINT(("fd_calibrate\n"));
+	DBG("start\n");
 	if (unit[SelectedDrive].track >= 0) {
 		fd_calibrate_done(0);
 		return;
 	}
-	DPRINT(("fd_calibrate (after track compare)\n"));
+	DBG("(after track compare)\n");
 	SET_IRQ_HANDLER(fd_calibrate_done);
 	/* we can't verify, since the speed may be incorrect */
 	FDC1772_WRITE(FDC1772REG_CMD, FDC1772CMD_RESTORE | unit[SelectedDrive].steprate);
@@ -694,12 +691,12 @@ static void fd_calibrate(void)
 
 static void fd_calibrate_done(int status)
 {
-	DPRINT(("fd_calibrate_done()\n"));
+	DBG("start\n");
 	STOP_TIMEOUT();
 
 	/* set the correct speed now */
 	if (status & FDC1772STAT_RECNF) {
-		printk("fd%d: restore failed\n", SelectedDrive);
+		printk(KERN_ERR "fd%d: restore failed\n", SelectedDrive);
 		fd_error();
 	} else {
 		unit[SelectedDrive].track = 0;
@@ -715,8 +712,8 @@ static void fd_calibrate_done(int status
 static void fd_seek(void)
 {
 	unsigned long flags;
-	DPRINT(("fd_seek() to track %d (unit[SelectedDrive].track=%d)\n", ReqTrack,
-		unit[SelectedDrive].track));
+	DBG("to track %d (unit[SelectedDrive].track=%d)\n", ReqTrack,
+		unit[SelectedDrive].track);
 	if (unit[SelectedDrive].track == ReqTrack <<
 	    unit[SelectedDrive].disktype->stretch) {
 		fd_seek_done(0);
@@ -742,12 +739,12 @@ static void fd_seek(void)
 
 static void fd_seek_done(int status)
 {
-	DPRINT(("fd_seek_done()\n"));
+	DBG("start\n");
 	STOP_TIMEOUT();
 
 	/* set the correct speed */
 	if (status & FDC1772STAT_RECNF) {
-		printk("fd%d: seek error (to track %d)\n",
+		printk(KERN_ERR "fd%d: seek error (to track %d)\n",
 		       SelectedDrive, ReqTrack);
 		/* we don't know exactly which track we are on now! */
 		unit[SelectedDrive].track = -1;
@@ -776,7 +773,7 @@ static void fd_rwsec(void)
 	unsigned int rwflag, old_motoron;
 	unsigned int track;
 
-	DPRINT(("fd_rwsec(), Sec=%d, Access=%c\n", ReqSector, ReqCmd == WRITE ? 'w' : 'r'));
+	DBG("Sec=%d, Access=%c\n", ReqSector, ReqCmd == WRITE ? 'w' : 'r');
 	if (ReqCmd == WRITE) {
 		/*cache_push( (unsigned long)ReqData, 512 ); */
 		paddr = (unsigned long) ReqData;
@@ -790,11 +787,11 @@ static void fd_rwsec(void)
 		rwflag = 0;
 	}
 
-	DPRINT(("fd_rwsec() before sidesel rwflag=%d sec=%d trk=%d\n", rwflag,
-		ReqSector, FDC1772_READ(FDC1772REG_TRACK)));
+	DBG("before sidesel rwflag=%d sec=%d trk=%d\n", rwflag,
+		ReqSector, FDC1772_READ(FDC1772REG_TRACK));
 	fd_select_side(ReqSide);
 
-	/*DPRINT(("fd_rwsec() before start sector \n")); */
+	/*DBG("before start sector\n"); */
 	/* Start sector of this operation */
 #ifdef TRACKBUFFER
 	FDC1772_WRITE( FDC1772REG_SECTOR, !read_track ? ReqSector : 1 );
@@ -810,7 +807,7 @@ static void fd_rwsec(void)
 	}
 	udelay(25);
 
-	DPRINT(("fd_rwsec() before setup DMA \n"));
+	DBG("before setup DMA\n");
 	/* Setup DMA - Heavily modified by DAG */
 	save_flags(flags);
 	clf();
@@ -838,7 +835,7 @@ static void fd_rwsec(void)
 		));
 
 	restore_flags(flags);
-	DPRINT(("fd_rwsec() after DMA setup flags=0x%08x\n", flags));
+	DBG("after DMA setup flags=0x%08x\n", flags);
 	/*sti(); *//* DAG - Hmm */
 	/* Hmm - should do something DAG */
 	old_motoron = MotorOn;
@@ -857,15 +854,15 @@ static void fd_rwsec(void)
 		 */
 		/* 1 rot. + 5 rot.s if motor was off  */
 		mod_timer(&readtrack_timer, jiffies + HZ/5 + (old_motoron ? 0 : HZ));
-		DPRINT(("Setting readtrack_timer to %d @ %d\n",
-			readtrack_timer.expires,jiffies));
+		DBG("setting readtrack_timer to %d @ %d\n",
+			readtrack_timer.expires,jiffies);
 		MultReadInProgress = 1;
 	}
 #endif
 
-	/*DPRINT(("fd_rwsec() before START_TIMEOUT \n")); */
+	/*DBG("before START_TIMEOUT\n"); */
 	START_TIMEOUT();
-	/*DPRINT(("fd_rwsec() after START_TIMEOUT \n")); */
+	/*DBG("after START_TIMEOUT\n"); */
 }
 
 
@@ -876,7 +873,7 @@ static void fd_readtrack_check(unsigned 
 	unsigned long flags, addr;
 	extern unsigned char *fdc1772_dataaddr;
 
-	DPRINT(("fd_readtrack_check @ %d\n",jiffies));
+	DBG("%d jiffies\n", jiffies);
 
 	save_flags(flags);
 	clf();
@@ -896,7 +893,7 @@ static void fd_readtrack_check(unsigned 
 
 	/* get the current DMA address */
 	addr=(unsigned long)fdc1772_dataaddr; /* DAG - ? */
-	DPRINT(("fd_readtrack_check: addr=%x PhysTrackBuffer=%x\n",addr,PhysTrackBuffer));
+	DBG("addr=%x PhysTrackBuffer=%x\n",__FUNCTION__, addr,PhysTrackBuffer);
 
 	if (addr >= (unsigned int)PhysTrackBuffer + unit[SelectedDrive].disktype->spt*512) {
 		/* already read enough data, force an FDC interrupt to stop
@@ -904,7 +901,7 @@ static void fd_readtrack_check(unsigned 
 		 */
 		SET_IRQ_HANDLER( NULL );
 		restore_flags(flags);
-		DPRINT(("fd_readtrack_check(): done\n"));
+		DBG("done\n");
 		FDC1772_WRITE( FDC1772REG_CMD, FDC1772CMD_FORCI );
 		udelay(25);
 
@@ -915,7 +912,7 @@ static void fd_readtrack_check(unsigned 
 	} else {
 		/* not yet finished, wait another tenth rotation */
 		restore_flags(flags);
-		DPRINT(("fd_readtrack_check(): not yet finished\n"));
+		DBG("not yet finished\n");
 		readtrack_timer.expires = jiffies + HZ/5/10;
 		add_timer( &readtrack_timer );
 	}
@@ -927,7 +924,7 @@ static void fd_rwsec_done(int status)
 {
 	unsigned int track;
 
-	DPRINT(("fd_rwsec_done() status=%d @ %d\n", status,jiffies));
+	DBG("status=%d @ %d\n", status,jiffies);
 
 #ifdef TRACKBUFFER
 	if (read_track && !MultReadInProgress)
@@ -949,7 +946,7 @@ static void fd_rwsec_done(int status)
 			      unit[SelectedDrive].disktype->stretch);
 	}
 	if (ReqCmd == WRITE && (status & FDC1772STAT_WPROT)) {
-		printk("fd%d: is write protected\n", SelectedDrive);
+		printk(KERN_ERR "fd%d: floppy is write protected\n", SelectedDrive);
 		goto err_end;
 	}
 	if ((status & FDC1772STAT_RECNF)
@@ -986,17 +983,17 @@ static void fd_rwsec_done(int status)
 			do_fd_action(SelectedDrive);
 			return;
 		}
-		printk("fd%d: sector %d not found (side %d, track %d)\n",
+		printk(KERN_ERR "fd%d: sector %d not found (side %d, track %d)\n",
 		       SelectedDrive, FDC1772_READ(FDC1772REG_SECTOR), ReqSide, ReqTrack);
 		goto err_end;
 	}
 	if (status & FDC1772STAT_CRC) {
-		printk("fd%d: CRC error (side %d, track %d, sector %d)\n",
+		printk(KERN_ERR "fd%d: CRC error (side %d, track %d, sector %d)\n",
 		       SelectedDrive, ReqSide, ReqTrack, FDC1772_READ(FDC1772REG_SECTOR));
 		goto err_end;
 	}
 	if (status & FDC1772STAT_LOST) {
-		printk("fd%d: lost data (side %d, track %d, sector %d)\n",
+		printk(KERN_ERR "fd%d: lost data (side %d, track %d, sector %d)\n",
 		       SelectedDrive, ReqSide, ReqTrack, FDC1772_READ(FDC1772REG_SECTOR));
 		goto err_end;
 	}
@@ -1050,7 +1047,7 @@ static void fd_times_out(unsigned long d
 	FDC1772_WRITE(FDC1772REG_CMD, FDC1772CMD_FORCI);
 	udelay(25);
 
-	printk("floppy timeout\n");
+	printk(KERN_WARNING "floppy timeout\n");
 	STOP_TIMEOUT();		/* hmm - should we do this ? */
 	fd_error();
 }
@@ -1072,7 +1069,7 @@ static void finish_fdc(void)
 	if (!NeedSeek) {
 		finish_fdc_done(0);
 	} else {
-		DPRINT(("finish_fdc: dummy seek started\n"));
+		DBG("dummy seek started\n");
 		FDC1772_WRITE(FDC1772REG_DATA, unit[SelectedDrive].track);
 		SET_IRQ_HANDLER(finish_fdc_done);
 		FDC1772_WRITE(FDC1772REG_CMD, FDC1772CMD_SEEK);
@@ -1090,7 +1087,7 @@ static void finish_fdc_done(int dummy)
 {
 	unsigned long flags;
 
-	DPRINT(("finish_fdc_done entered\n"));
+	DBG("start\n");
 	STOP_TIMEOUT();
 	NeedSeek = 0;
 
@@ -1113,7 +1110,7 @@ static void finish_fdc_done(int dummy)
 	wake_up(&fdc_wait);
 	restore_flags(flags);
 
-	DPRINT(("finish_fdc() finished\n"));
+	DBG("end\n");
 }
 
 
@@ -1193,8 +1190,8 @@ static void setup_req_params(int drive)
 	read_track = (ReqCmd == READ && CURRENT->errors == 0);
 #endif
 
-	DPRINT(("Request params: Si=%d Tr=%d Se=%d Data=%08lx\n", ReqSide,
-		ReqTrack, ReqSector, (unsigned long) ReqData));
+	DBG("Request params: Si=%d Tr=%d Se=%d Data=%08lx\n", ReqSide,
+		ReqTrack, ReqSector, (unsigned long) ReqData);
 }
 
 
@@ -1203,9 +1200,9 @@ static void redo_fd_request(void)
 	int drive, type;
 	struct archy_floppy_struct *floppy;
 
-	DPRINT(("redo_fd_request: CURRENT=%p dev=%s CURRENT->sector=%ld\n",
+	DBG("CURRENT=%p dev=%s CURRENT->sector=%ld\n"
 		CURRENT, CURRENT ? CURRENT->rq_disk->disk_name : "",
-		CURRENT ? CURRENT->sector : 0));
+		CURRENT ? CURRENT->sector : 0);
 
 repeat:
 
@@ -1218,7 +1215,7 @@ repeat:
 
 	if (!floppy->connected) {
 		/* drive not connected */
-		printk("Unknown Device: fd%d\n", drive);
+		printk(KERN_ERR "Unknown Device: fd%d\n", drive);
 		end_request(CURRENT, 0);
 		goto repeat;
 	}
@@ -1233,7 +1230,7 @@ repeat:
 		/* user supplied disk type */
 		--type;
 		if (type >= NUM_DISK_TYPES) {
-			printk("fd%d: invalid disk format", drive);
+			printk(KERN_ERR "fd%d: invalid disk format", drive);
 			end_request(CURRENT, 0);
 			goto repeat;
 		}
@@ -1279,7 +1276,7 @@ static void do_fd_request(request_queue_
 {
 	unsigned long flags;
 
-	DPRINT(("do_fd_request for pid %d\n", current->pid));
+	DBG("pid %d\n", current->pid);
 	if (fdc_busy) return;
 	save_flags(flags);
 	cli();
@@ -1359,7 +1356,7 @@ static int fd_test_drive_present(int dri
 	unsigned char status;
 	int ok;
 
-	printk("fd_test_drive_present %d\n", drive);
+	DBG("drive %d\n", drive);
 	if (drive > 1)
 		return (0);
 	return (1);		/* Simple hack for the moment - the autodetect doesn't seem to work on arc */
@@ -1397,15 +1394,15 @@ static int fd_test_drive_present(int dri
 		/* dummy seek command to make WP bit accessible */
 		FDC1772_WRITE(FDC1772REG_DATA, 0);
 		FDC1772_WRITE(FDC1772REG_CMD, FDC1772CMD_SEEK);
-		printk("fd_test_drive_present: just before wait for int\n");
+		DBG("just before wait for int\n");
 		/* DAG: Guess means wait for interrupt */
 		while (!(ioc_readb(IOC_FIQSTAT) & 2));
-		printk("fd_test_drive_present: just after wait for int\n");
+		DBG("just after wait for int\n");
 		status = FDC1772_READ(FDC1772REG_STATUS);
 	}
-	printk("fd_test_drive_present: just before ENABLE_IRQ\n");
+	DBG("just before ENABLE_IRQ\n");
 	ENABLE_IRQ();
-	printk("fd_test_drive_present: about to return\n");
+	DBG("about to return\n");
 	return (ok);
 }
 
@@ -1418,14 +1415,15 @@ static void config_types(void)
 {
 	int drive, cnt = 0;
 
-	printk("Probing floppy drive(s):\n");
+	pr_info("Probing floppy drive(s):");
 	for (drive = 0; drive < FD_MAX_UNITS; drive++) {
 		fd_probe(drive);
 		if (unit[drive].connected) {
-			printk("fd%d\n", drive);
+			printk(" fd%d", drive);
 			++cnt;
 		}
 	}
+	printk ("\n");
 
 	if (FDC1772_READ(FDC1772REG_STATUS) & FDC1772STAT_BUSY) {
 		/* If FDC1772 is still busy from probing, give it another FORCI
@@ -1495,7 +1493,7 @@ static int floppy_release(struct inode *
 	if (fd_ref[drive] < 0)
 		fd_ref[drive] = 0;
 	else if (!fd_ref[drive]--) {
-		printk("floppy_release with fd_ref == 0");
+		printk(KERN_WARNING "floppy_release with fd_ref == 0\n");
 		fd_ref[drive] = 0;
 	}
 
@@ -1540,12 +1538,12 @@ int fd1772_init(void)
 
 	err = -EBUSY;
 	if (request_dma(FLOPPY_DMA, "fd1772")) {
-		printk("Unable to grab DMA%d for the floppy (1772) driver\n", FLOPPY_DMA);
+		printk(KERN_ERR "Unable to grab DMA%d for the floppy (1772) driver\n", FLOPPY_DMA);
 		goto err_blkdev;
 	};
 
 	if (request_dma(FIQ_FD1772, "fd1772 end")) {
-		printk("Unable to grab DMA%d for the floppy (1772) driver\n", FIQ_FD1772);
+		printk(KERN_ERR "Unable to grab DMA%d for the floppy (1772) driver\n", FIQ_FD1772);
 		goto err_dma1;
 	};
 

--
