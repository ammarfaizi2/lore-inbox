Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSFQNSz>; Mon, 17 Jun 2002 09:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSFQNSy>; Mon, 17 Jun 2002 09:18:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313181AbSFQNSx>;
	Mon, 17 Jun 2002 09:18:53 -0400
Date: Mon, 17 Jun 2002 14:18:47 +0100
From: Matthew Wilcox <willy@debian.org>
To: "David A. van Leeuwen" <david@tm.tno.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Remove CM206_BH
Message-ID: <20020617141847.V9435@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi David.  My quest to kill Bottom Halves continues, and I've stumbled
into your driver.  Can you test to see if this works, please?

--- linux-2.5.22/drivers/cdrom/cm206.c	Mon Jun 17 04:49:04 2002
+++ linux-2.5.22-bh/drivers/cdrom/cm206.c	Mon Jun 17 05:42:50 2002
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

-- 
Revolutions do not require corporate support.
