Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265762AbSKFR3E>; Wed, 6 Nov 2002 12:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbSKFR3E>; Wed, 6 Nov 2002 12:29:04 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:47656 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265762AbSKFR3C>; Wed, 6 Nov 2002 12:29:02 -0500
Message-ID: <3DC952E3.42B749E5@cinet.co.jp>
Date: Thu, 07 Nov 2002 02:35:31 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.45-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCHSET 2/17] support PC-9800 against 2.5.45-ac1
References: <3DC94C7B.79DE5EBC@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------4A9224F487D10D01ADF8C31A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4A9224F487D10D01ADF8C31A
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This is for already merged file, too.
Merged PC-9800 specific "#define"s into floppy98.c.
And don't change include/asm-i386/floppy.h, include/linux/fdreg.h

-- 
Osamu tomita
--------------4A9224F487D10D01ADF8C31A
Content-Type: text/plain; charset=iso-2022-jp;
 name="floppy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="floppy.patch"

--- linux-2.5.45-ac1/drivers/block/floppy98.c.orig	Tue Nov  5 10:16:20 2002
+++ linux-2.5.45-ac1/drivers/block/floppy98.c	Wed Nov  6 20:51:58 2002
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
@@ -2344,7 +2352,7 @@
 {
 	if (end_that_request_first(req, uptodate, current_count_sectors))
 		return;
-	add_blkdev_randomness(MAJOR_NR);
+	add_disk_randomness(req->rq_disk);
 	floppy_off((int)req->rq_disk->private_data);
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
@@ -4251,6 +4259,7 @@
 	int err;
 
 	raw_cmd = NULL;
+	FDC1 = 0x90;
 
 	for (i=0; i<N_DRIVE; i++) {
 		disks[i] = alloc_disk(1);

--------------4A9224F487D10D01ADF8C31A--

