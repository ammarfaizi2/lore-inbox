Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTFDM4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 08:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTFDM4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 08:56:50 -0400
Received: from ns.suse.de ([213.95.15.193]:51729 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262737AbTFDM4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 08:56:47 -0400
Date: Wed, 4 Jun 2003 15:10:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] floppy smp (and misc) fixes
Message-ID: <20030604131012.GT4853@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are several smp races in the 2.4.21-rc floppy driver that can
cause a process writing/reading to the drive to stall forever. Basically
it quits out of request handling with requests pending. I verified that
these requests were not seen by the floppy driver yet. It went to unlock
the drive in a bad state.

Additionally, I put a smaller limit on requests sizes. It doesn't make
any sense to have 128 * 255 sectors pending in the write queue (about
16MiB of data) and it just causes huge latencies when someone wants to
stop a dd, for instance.

With this patch I cannot reproduce any more floppy hangs on a 4-way.

--- drivers/block/floppy.c~	2003-06-04 14:58:50.000000000 +0200
+++ drivers/block/floppy.c	2003-06-04 14:59:33.000000000 +0200
@@ -482,6 +482,7 @@
 
 static int floppy_sizes[256];
 static int floppy_blocksizes[256];
+static int floppy_maxsectors[256];
 
 /*
  * The driver is trying to determine the correct media format
@@ -622,7 +623,8 @@
 static void is_alive(const char *message)
 {
 	/* this routine checks whether the floppy driver is "alive" */
-	if (fdc_busy && command_status < 2 && !timer_pending(&fd_timeout)){
+	if (test_bit(0, &fdc_busy) && command_status < 2
+	    && !timer_pending(&fd_timeout)){
 		DPRINT("timeout handler died: %s\n",message);
 	}
 }
@@ -650,7 +652,7 @@
 #define CURRENTD -1
 #define MAXTIMEOUT -2
 
-static void reschedule_timeout(int drive, const char *message, int marg)
+static void __reschedule_timeout(int drive, const char *message, int marg)
 {
 	if (drive == CURRENTD)
 		drive = current_drive;
@@ -669,6 +671,16 @@
 	timeout_message = message;
 }
 
+
+static void reschedule_timeout(int drive, const char *message, int marg)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&io_request_lock, flags);
+	__reschedule_timeout(drive, message, marg);
+	spin_unlock_irqrestore(&io_request_lock, flags);
+}
+
 static int maximum(int a, int b)
 {
 	if (a > b)
@@ -897,7 +909,7 @@
 	}
 	command_status = FD_COMMAND_NONE;
 
-	reschedule_timeout(drive, "lock fdc", 0);
+	__reschedule_timeout(drive, "lock fdc", 0);
 	set_fdc(drive);
 	return 0;
 }
@@ -911,17 +923,23 @@
 /* unlocks the driver */
 static inline void unlock_fdc(void)
 {
+	unsigned long flags;
+
 	raw_cmd = 0;
-	if (!fdc_busy)
+	if (!test_bit(0, &fdc_busy))
 		DPRINT("FDC access conflict!\n");
 
 	if (DEVICE_INTR)
 		DPRINT("device interrupt still active at FDC release: %p!\n",
 			DEVICE_INTR);
 	command_status = FD_COMMAND_NONE;
+	spin_lock_irqsave(&io_request_lock, flags);
 	del_timer(&fd_timeout);
 	cont = NULL;
 	clear_bit(0, &fdc_busy);
+	if (!QUEUE_EMPTY)
+		do_fd_request(BLK_DEFAULT_QUEUE(MAJOR_NR));
+	spin_unlock_irqrestore(&io_request_lock, flags);
 	floppy_release_irq_and_dma();
 	wake_up(&fdc_wait);
 }
@@ -1000,9 +1018,13 @@
 
 static void cancel_activity(void)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&io_request_lock, flags);
 	CLEAR_INTR;
 	floppy_tq.routine = (void *)(void *) empty;
 	del_timer(&fd_timer);
+	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 
 /* this function makes sure that the disk stays in the drive during the
@@ -2986,7 +3008,7 @@
 		printk("sect=%ld cmd=%d\n", CURRENT->sector, CURRENT->cmd);
 		return;
 	}
-	if (fdc_busy){
+	if (test_bit(0, &fdc_busy)) {
 		/* fdc busy, this new request will be treated when the
 		   current one is done */
 		is_alive("do fd request, old request running");
@@ -3878,7 +3900,7 @@
 			/* auto-sensing */
 			int size = floppy_blocksizes[MINOR(dev)];
 			if (!size)
-				size = 1024;
+				size = 512;
 			if (!(bh = getblk(dev,0,size))){
 				process_fd_request();
 				return -ENXIO;
@@ -4170,14 +4192,19 @@
 		return -EBUSY;
 	}
 
-	for (i=0; i<256; i++)
+	for (i=0; i<256; i++) {
 		if (ITYPE(i))
 			floppy_sizes[i] = (floppy_type[ITYPE(i)].size+1) >> 1;
 		else
 			floppy_sizes[i] = MAX_DISK_SIZE;
 
+		floppy_blocksizes[i] = 512;
+		floppy_maxsectors[i] = 64;
+	}
+
 	blk_size[MAJOR_NR] = floppy_sizes;
 	blksize_size[MAJOR_NR] = floppy_blocksizes;
+	max_sectors[MAJOR_NR] = floppy_maxsectors;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	reschedule_timeout(MAXTIMEOUT, "floppy init", MAXTIMEOUT);
 	config_types();

-- 
Jens Axboe

