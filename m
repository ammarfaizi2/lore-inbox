Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSFTPKS>; Thu, 20 Jun 2002 11:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSFTPKS>; Thu, 20 Jun 2002 11:10:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54546 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314829AbSFTPKQ>;
	Thu, 20 Jun 2002 11:10:16 -0400
Date: Thu, 20 Jun 2002 16:10:17 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Convert cm206 to a tasklet
Message-ID: <20020620161017.X9435@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Removes CM206_BH (patch approved by maintainer).
Deletes the no-longer-used BH entries from the enum.  Explicit numbers
added so as not to destroy binary compatibility needlessly.

diff -urNX dontdiff linux-2.5.23/drivers/cdrom/cm206.c linux-2.5.23-imm/drivers/cdrom/cm206.c
--- linux-2.5.23/drivers/cdrom/cm206.c	Mon Jun 17 04:49:04 2002
+++ linux-2.5.23-imm/drivers/cdrom/cm206.c	Thu Jun 20 07:58:09 2002
@@ -345,6 +345,8 @@
 	}
 }
 
+static struct tasklet_struct cm206_tasklet;
+
 /* The interrupt handler. When the cm260 generates an interrupt, very
    much care has to be taken in reading out the registers in the right
    order; in case of a receive_buffer_full interrupt, first the
@@ -432,7 +434,7 @@
 	if (cd->background
 	    && (cd->adapter_last - cd->adapter_first == cd->max_sectors
 		|| cd->fifo_overflowed))
-		mark_bh(CM206_BH);	/* issue a stop read command */
+		tasklet_schedule(&cm206_tasklet);	/* issue a stop read command */
 	stats(interrupt);
 }
 
@@ -701,7 +703,7 @@
    4 c_stop waits for receive_buffer_full: 0xff
 */
 
-void cm206_bh(void)
+static void cm206_tasklet_func(unsigned long ignore)
 {
 	debug(("bh: %d\n", cd->background));
 	switch (cd->background) {
@@ -745,6 +747,8 @@
 	}
 }
 
+static DECLARE_TASKLET(cm206_tasklet, cm206_tasklet_func, 0);
+
 /* This command clears the dsb_possible_media_change flag, so we must 
  * retain it.
  */
@@ -1503,7 +1507,6 @@
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_cm206_request,
 		       &cm206_lock);
 	blk_queue_hardsect_size(BLK_DEFAULT_QUEUE(MAJOR_NR), 2048);
-	init_bh(CM206_BH, cm206_bh);
 
 	memset(cd, 0, sizeof(*cd));	/* give'm some reasonable value */
 	cd->sector_last = -1;	/* flag no data buffered */
diff -urNX dontdiff linux-2.5.23/include/linux/interrupt.h linux-2.5.23-imm/include/linux/interrupt.h
--- linux-2.5.23/include/linux/interrupt.h	Thu Jun  6 06:57:51 2002
+++ linux-2.5.23-imm/include/linux/interrupt.h	Thu Jun 20 08:01:04 2002
@@ -28,20 +28,17 @@
    
 enum {
 	TIMER_BH = 0,
-	TQUEUE_BH,
-	DIGI_BH,
-	SERIAL_BH,
-	RISCOM8_BH,
-	SPECIALIX_BH,
-	AURORA_BH,
-	ESP_BH,
-	SCSI_BH,
-	IMMEDIATE_BH,
-	CYCLADES_BH,
-	CM206_BH,
-	JS_BH,
-	MACSERIAL_BH,
-	ISICOM_BH
+	TQUEUE_BH = 1,
+	DIGI_BH = 2,
+	SERIAL_BH = 3,
+	RISCOM8_BH = 4,
+	SPECIALIX_BH = 5,
+	AURORA_BH = 6,
+	ESP_BH = 7,
+	IMMEDIATE_BH = 9,
+	CYCLADES_BH = 10,
+	MACSERIAL_BH = 13,
+	ISICOM_BH = 14
 };
 
 #include <asm/hardirq.h>

-- 
Revolutions do not require corporate support.
