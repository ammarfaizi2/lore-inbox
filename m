Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266093AbSKOK5F>; Fri, 15 Nov 2002 05:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266106AbSKOK5F>; Fri, 15 Nov 2002 05:57:05 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:23170 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266093AbSKOK5B>; Fri, 15 Nov 2002 05:57:01 -0500
Message-ID: <3DD4D48E.D7BF3FF6@cinet.co.jp>
Date: Fri, 15 Nov 2002 20:03:42 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.47-ac4-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PC-9800 patch for 2.5.47-ac4: Update floppy98.c
References: <3DD4C5A7.84AB38B6@cinet.co.jp> <3DD4D0EA.C44F5ED7@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------E846A8C151E038F3E116F4D3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E846A8C151E038F3E116F4D3
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This patch updates floppy driver for PC-9800.
Synchronized with latest drivers/block/floppy.c.

diffstat:
 drivers/block/floppy98.c |   57 ++++++++++++++++++++++++++++-------------------
 1 files changed, 34 insertions(+), 23 deletions(-)

-- 
Osamu Tomita
tomita@cinet.co.jp
--------------E846A8C151E038F3E116F4D3
Content-Type: text/plain; charset=iso-2022-jp;
 name="floppy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="floppy.patch"

--- linux-2.5.47-ac1/drivers/block/floppy98.c.ac1	Wed Nov 13 09:25:33 2002
+++ linux-2.5.47-ac1/drivers/block/floppy98.c	Wed Nov 13 10:28:40 2002
@@ -176,7 +176,15 @@
 
 
 #include <linux/fd.h>
+#define FLOPPY98_MOTOR_MASK 0x08
+
+#define FDPATCHES
 #include <linux/hdreg.h>
+#define FD98_STATUS	(0 + FD_IOPORT )
+#define FD98_DATA	(2 + FD_IOPORT )
+#define FD_MODE		(4 + FD_IOPORT )
+#define FD_MODE_CHANGE	0xbe
+#define FD_EMODE_CHANGE	0x4be
 
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -585,7 +593,7 @@
 static void floppy_start(void);
 static void process_fd_request(void);
 static void recalibrate_floppy(void);
-static void floppy_shutdown(void);
+static void floppy_shutdown(unsigned long);
 
 static int floppy_grab_irq_and_dma(void);
 static void floppy_release_irq_and_dma(void);
@@ -659,7 +667,7 @@
 }
 
 typedef void (*timeout_fn)(unsigned long);
-static struct timer_list fd_timeout ={ function: (timeout_fn) floppy_shutdown };
+static struct timer_list fd_timeout = TIMER_INITIALIZER(floppy_shutdown, 0, 0);
 
 static const char *timeout_message;
 
@@ -784,10 +792,10 @@
 		fd_outb(newdor, FD_MODE);
 	}
 
-	if (newdor & FLOPPY_MOTOR_MASK)
+	if (newdor & FLOPPY98_MOTOR_MASK)
 		floppy_grab_irq_and_dma();
 
-	if (olddor & FLOPPY_MOTOR_MASK)
+	if (olddor & FLOPPY98_MOTOR_MASK)
 		floppy_release_irq_and_dma();
 
 	return olddor;
@@ -828,7 +836,7 @@
 	if (FDCS->rawcmd == 2)
 		reset_fdc_info(1);
 
-	if (fd_inb(FD_STATUS) != STATUS_READY)
+	if (fd_inb(FD98_STATUS) != STATUS_READY)
 		FDCS->reset = 1;
 }
 
@@ -991,7 +999,7 @@
 	schedule_work(&floppy_work);
 }
 
-static struct timer_list fd_timer;
+static struct timer_list fd_timer = TIMER_INITIALIZER(NULL, 0, 0);
 
 static void cancel_activity(void)
 {
@@ -1146,7 +1154,7 @@
 	if (FDCS->reset)
 		return -1;
 	for (counter = 0; counter < READY_DELAY; counter++) {
-		status = fd_inb(FD_STATUS);		
+		status = fd_inb(FD98_STATUS);		
 		if (status & STATUS_READY)
 			return status;
 	}
@@ -1167,7 +1175,7 @@
 	if ((status = wait_til_ready()) < 0)
 		return -1;
 	if ((status & (STATUS_READY|STATUS_DIR|STATUS_DMA)) == STATUS_READY){
-		fd_outb(byte,FD_DATA);
+		fd_outb(byte,FD98_DATA);
 #ifdef FLOPPY_SANITY_CHECK
 		output_log[output_log_pos].data = byte;
 		output_log[output_log_pos].status = status;
@@ -1203,7 +1211,7 @@
 			return i;
 		}
 		if (status == (STATUS_DIR|STATUS_READY|STATUS_BUSY))
-			reply_buffer[i] = fd_inb(FD_DATA);
+			reply_buffer[i] = fd_inb(FD98_DATA);
 		else
 			break;
 	}
@@ -1793,7 +1801,7 @@
 	printk("\n");
 #endif
 
-	printk("status=%x\n", fd_inb(FD_STATUS));
+	printk("status=%x\n", fd_inb(FD98_STATUS));
 	printk("fdc_busy=%lu\n", fdc_busy);
 	if (do_floppy)
 		printk("do_floppy=%p\n", do_floppy);
@@ -1812,7 +1820,7 @@
 	printk("\n");
 }
 
-static void floppy_shutdown(void)
+static void floppy_shutdown(unsigned long data)
 {
 	unsigned long flags;
 	
@@ -2198,15 +2206,16 @@
 		DRS->track = NEED_2_RECAL;
 }
 
-static void set_floppy(kdev_t device)
+static void set_floppy(int drive)
 {
-	if (TYPE(device)) {
+	int type = ITYPE(UDRS->fd_device);
+	if (type) {
 		auto_detect_mode = 0;
-		_floppy = TYPE(device) + floppy_type;
+		_floppy = floppy_type + type;
 	} else if (auto_detect_mode == 0) {
 		auto_detect_mode = 1;
 		retry_auto_detect = 0;
-		_floppy = current_type[DRIVE(device)];
+		_floppy = current_type[drive];
 	}
 #ifdef PC9800_DEBUG_FLOPPY2
 	printk("set_floppy: set floppy type=%d\n", (int)(_floppy - floppy_type));
@@ -2316,7 +2325,7 @@
 	int drive=DRIVE(device);
 
 	LOCK_FDC(drive,1);
-	set_floppy(device);
+	set_floppy(drive);
 	if (!_floppy ||
 	    _floppy->track > DP->tracks ||
 	    tmp_format_req->track >= _floppy->track ||
@@ -2344,7 +2353,7 @@
 {
 	if (end_that_request_first(req, uptodate, current_count_sectors))
 		return;
-	add_blkdev_randomness(MAJOR_NR);
+	add_disk_randomness(req->rq_disk);
 	floppy_off((int)req->rq_disk->private_data);
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
@@ -2678,7 +2687,7 @@
 		return 0;
 	}
 
-	set_fdc(DRIVE(current_req->rq_dev));
+	set_fdc((int)current_req->rq_disk->private_data);
 
 	raw_cmd = &default_raw_cmd;
 	raw_cmd->flags = FD_RAW_SPIN | FD_RAW_NEED_DISK | FD_RAW_NEED_DISK |
@@ -2949,7 +2958,7 @@
 static void redo_fd_request(void)
 {
 #define REPEAT {request_done(0); continue; }
-	kdev_t device;
+	int drive;
 	int tmp;
 
 	lastredo = jiffies;
@@ -2966,11 +2975,11 @@
 			}
 			current_req = req;
 		}
-		device = current_req->rq_dev;
-		set_fdc(DRIVE(device));
+		drive = (int)current_req->rq_disk->private_data;
+		set_fdc(drive);
 		reschedule_timeout(current_reqD, "redo fd request", 0);
 
-		set_floppy(device);
+		set_floppy(drive);
 		raw_cmd = & default_raw_cmd;
 		raw_cmd->flags = 0;
 		if (start_motor(redo_fd_request)) return;
@@ -3665,7 +3674,7 @@
 			if (type)
 				return -EINVAL;
 			LOCK_FDC(drive,1);
-			set_floppy(device);
+			set_floppy(drive);
 			CALL(i = raw_cmd_ioctl(cmd,(void *) param));
 			process_fd_request();
 			return i;
@@ -4251,6 +4260,7 @@
 	int err;
 
 	raw_cmd = NULL;
+	FDC1 = 0x90;
 
 	for (i=0; i<N_DRIVE; i++) {
 		disks[i] = alloc_disk(1);
@@ -4372,6 +4382,7 @@
 	}
 	
 	for (drive = 0; drive < N_DRIVE; drive++) {
+		init_timer(&motor_off_timer[drive]);
 		motor_off_timer[drive].data = drive;
 		motor_off_timer[drive].function = motor_off_callback;
 		if (!(allowed_drive_mask & (1 << drive)))

--------------E846A8C151E038F3E116F4D3--

