Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281500AbRKPT0W>; Fri, 16 Nov 2001 14:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281502AbRKPT0E>; Fri, 16 Nov 2001 14:26:04 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:57102 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S281500AbRKPTZv>; Fri, 16 Nov 2001 14:25:51 -0500
Date: Fri, 16 Nov 2001 20:25:35 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] fix incorrect jiffies compares
In-Reply-To: <Pine.LNX.4.30.0111111735040.11130-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.30.0111162019220.32119-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this patch again changes comparisons of jiffies to use the
> time_{before,after} macros which are safe against wraparound.
>
> However, this time I only fix places that actually get the wraparound
> wrong. I hope that will silence the legitimate voices that accused my
> previous patches of being too intrusive.
>
> The parts of my previous patches that actually fix incorrect
> comparisons are included. I am about halfway through the list of
> suspicious files, so another patch like this is to be expected if no
> objections are raised.
>
> With these changes I do not see the solid lockups after jiffies wrap
> anymore that I have reported in the "Re: [Patch] Re: Nasty suprise with
> uptime" thread.
>

Rediffed for 2.4.15-pre5.
The 64 bit jiffies patch for enabling uptimes > 497 days
(http://www.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-45/1559.html)
still applies to 2.4.15-pre5.

Tim



diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/block/paride/pseudo.h linux-2.4.15-pre5-jiffies64/drivers/block/paride/pseudo.h
--- linux-2.4.15-pre5/drivers/block/paride/pseudo.h	Sun Feb  4 19:05:29 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/block/paride/pseudo.h	Fri Nov 16 20:09:42 2001
@@ -102,7 +102,7 @@
 		spin_unlock_irqrestore(&ps_spinlock,flags);
 		return;
 	}
-        if (!ps_ready || ps_ready() || (jiffies >= ps_timeout)) {
+        if (!ps_ready || ps_ready() || time_after_eq(jiffies, ps_timeout)) {
                 ps_continuation = NULL;
         	spin_unlock_irqrestore(&ps_spinlock,flags);
                 con();
@@ -131,7 +131,7 @@
 	        spin_unlock_irqrestore(&ps_spinlock,flags);
 		return;
 	}
-        if (!ps_ready || ps_ready() || (jiffies >= ps_timeout)) {
+        if (!ps_ready || ps_ready() || time_after_eq(jiffies, ps_timeout)) {
                 ps_continuation = NULL;
 	        spin_unlock_irqrestore(&ps_spinlock,flags);
                 con();
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/char/esp.c linux-2.4.15-pre5-jiffies64/drivers/char/esp.c
--- linux-2.4.15-pre5/drivers/char/esp.c	Fri Nov 16 20:08:26 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/char/esp.c	Fri Nov 16 20:09:42 2001
@@ -2162,7 +2162,7 @@
 		if (signal_pending(current))
 			break;

-		if (timeout && ((orig_jiffies + timeout) < jiffies))
+		if (timeout && (time_after(jiffies, orig_jiffies + timeout)))
 			break;

 		serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/char/ip2/i2lib.c linux-2.4.15-pre5-jiffies64/drivers/char/ip2/i2lib.c
--- linux-2.4.15-pre5/drivers/char/ip2/i2lib.c	Sat Nov  3 02:26:17 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/char/ip2/i2lib.c	Fri Nov 16 20:09:42 2001
@@ -1330,7 +1330,7 @@

 	// if expires == 0 then timer poped, then do not need to del_timer
 	if ((timeout > 0) && pCh->BookmarkTimer.expires &&
-				(pCh->BookmarkTimer.expires > jiffies)) {
+	                     time_before(jiffies, pCh->BookmarkTimer.expires)) {
 		del_timer( &(pCh->BookmarkTimer) );
 		pCh->BookmarkTimer.expires = 0;

diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/char/mxser.c linux-2.4.15-pre5-jiffies64/drivers/char/mxser.c
--- linux-2.4.15-pre5/drivers/char/mxser.c	Thu Oct 25 22:53:47 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/char/mxser.c	Fri Nov 16 20:09:42 2001
@@ -847,7 +847,7 @@
 		while (!(inb(info->base + UART_LSR) & UART_LSR_TEMT)) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(5);
-			if (jiffies > timeout)
+			if (time_after(jiffies, timeout))
 				break;
 		}
 	}
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/i2c/i2c-adap-ite.c linux-2.4.15-pre5-jiffies64/drivers/i2c/i2c-adap-ite.c
--- linux-2.4.15-pre5/drivers/i2c/i2c-adap-ite.c	Thu Oct 11 17:05:47 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/i2c/i2c-adap-ite.c	Fri Nov 16 20:09:42 2001
@@ -82,7 +82,7 @@
         unsigned long j = jiffies + 10;

 	DEB3(printk(" Write 0x%02x to 0x%x\n",(unsigned short)val, ctl&0xff));
-	DEB3({while (jiffies < j) schedule();})
+	DEB3({while (time_before(jiffies, j)) schedule();})
 	outw(val,ctl);
 }

diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/i2c/i2c-algo-bit.c linux-2.4.15-pre5-jiffies64/drivers/i2c/i2c-algo-bit.c
--- linux-2.4.15-pre5/drivers/i2c/i2c-algo-bit.c	Thu Oct 11 17:05:47 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/i2c/i2c-algo-bit.c	Fri Nov 16 20:09:42 2001
@@ -49,7 +49,7 @@
 /* respectively. This makes sure that the algorithm works. Some chips   */
 /* might not like this, as they have an internal timeout of some mils	*/
 /*
-#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
+#define SLO_IO      jif=jiffies;while(time_before_eq(jiffies, jif+i2c_table[minor].veryslow))\
                         if (need_resched) schedule();
 */

@@ -117,7 +117,7 @@
  		 * while they are processing data internally.
  		 */
 		setscl(adap,1);
-		if (start+adap->timeout <= jiffies) {
+		if (time_after_eq(jiffies, start+adap->timeout)) {
 			return -ETIMEDOUT;
 		}
 		if (current->need_resched)
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/ide/ide-probe.c linux-2.4.15-pre5-jiffies64/drivers/ide/ide-probe.c
--- linux-2.4.15-pre5/drivers/ide/ide-probe.c	Thu Oct 11 18:14:32 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/ide/ide-probe.c	Fri Nov 16 20:09:42 2001
@@ -370,7 +370,7 @@
 	OUT_BYTE(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
 	timeout = jiffies + WAIT_WORSTCASE;
 	do {
-		if (jiffies > timeout) {
+		if (time_after(jiffies, timeout)) {
 			printk("failed (timeout)\n");
 			return;
 		}
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/ide/ide-tape.c linux-2.4.15-pre5-jiffies64/drivers/ide/ide-tape.c
--- linux-2.4.15-pre5/drivers/ide/ide-tape.c	Mon Aug 13 23:56:19 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/ide/ide-tape.c	Fri Nov 16 20:09:42 2001
@@ -2418,26 +2418,26 @@
 	idetape_tape_t *tape = drive->driver_data;
 	int full = 125, empty = 75;

-	if (jiffies > tape->controlled_pipeline_head_time + 120 * HZ) {
+	if (time_after(jiffies, tape->controlled_pipeline_head_time + 120 * HZ)) {
 		tape->controlled_previous_pipeline_head = tape->controlled_last_pipeline_head;
 		tape->controlled_previous_head_time = tape->controlled_pipeline_head_time;
 		tape->controlled_last_pipeline_head = tape->pipeline_head;
 		tape->controlled_pipeline_head_time = jiffies;
 	}
-	if (jiffies > tape->controlled_pipeline_head_time + 60 * HZ)
+	if (time_after(jiffies, tape->controlled_pipeline_head_time + 60 * HZ))
 		tape->controlled_pipeline_head_speed = (tape->pipeline_head - tape->controlled_last_pipeline_head) * 32 * HZ / (jiffies - tape->controlled_pipeline_head_time);
-	else if (jiffies > tape->controlled_previous_head_time)
+	else if (time_after(jiffies, tape->controlled_previous_head_time))
 		tape->controlled_pipeline_head_speed = (tape->pipeline_head - tape->controlled_previous_pipeline_head) * 32 * HZ / (jiffies - tape->controlled_previous_head_time);

 	if (tape->nr_pending_stages < tape->max_stages /*- 1 */) { /* -1 for read mode error recovery */
-		if (jiffies > tape->uncontrolled_previous_head_time + 10 * HZ) {
+		if (time_after(jiffies, tape->uncontrolled_previous_head_time + 10 * HZ)) {
 			tape->uncontrolled_pipeline_head_time = jiffies;
 			tape->uncontrolled_pipeline_head_speed = (tape->pipeline_head - tape->uncontrolled_previous_pipeline_head) * 32 * HZ / (jiffies - tape->uncontrolled_previous_head_time);
 		}
 	} else {
 		tape->uncontrolled_previous_head_time = jiffies;
 		tape->uncontrolled_previous_pipeline_head = tape->pipeline_head;
-		if (jiffies > tape->uncontrolled_pipeline_head_time + 30 * HZ) {
+		if (time_after(jiffies, tape->uncontrolled_pipeline_head_time + 30 * HZ)) {
 			tape->uncontrolled_pipeline_head_time = jiffies;
 		}
 	}
@@ -2500,7 +2500,7 @@
 		tape->insert_time = jiffies;
 		tape->insert_size = 0;
 	}
-	if (jiffies > tape->insert_time)
+	if (time_after(jiffies, tape->insert_time))
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 	if (jiffies - tape->avg_time >= HZ) {
 		tape->avg_speed = tape->avg_size * HZ / (jiffies - tape->avg_time) / 1024;
@@ -2680,11 +2680,11 @@
 		tape->reads_since_buffer_fill = 0;
 		tape->last_buffer_fill = jiffies;
 		idetape_queue_onstream_buffer_fill(drive);
-		if (jiffies > tape->insert_time)
+		if (time_after(jiffies, tape->insert_time))
 			tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 		return ide_stopped;
 	}
-	if (jiffies > tape->insert_time)
+	if (time_after(jiffies, tape->insert_time))
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 	calculate_speeds(drive);
 	if (tape->onstream && tape->max_frames &&
@@ -2756,7 +2756,7 @@
 			if (tape->onstream) {
 				if (tape->cur_frames + tape->writes_since_buffer_fill >= tape->max_frames)
 					tape->req_buffer_fill = 1;
-				if (jiffies > tape->last_buffer_fill + 5 * HZ / 100)
+				if (time_after(jiffies, tape->last_buffer_fill + 5 * HZ / 100))
 					tape->req_buffer_fill = 1;
 				calculate_speeds(drive);
 			}
@@ -3214,7 +3214,7 @@
 	 * Wait for the tape to become ready
 	 */
 	timeout += jiffies;
-	while (jiffies < timeout) {
+	while (time_before(jiffies, timeout)) {
 		idetape_create_test_unit_ready_cmd(&pc);
 		if (!__idetape_queue_pc_tail(drive, &pc))
 			return 0;
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/net/arlan.c linux-2.4.15-pre5-jiffies64/drivers/net/arlan.c
--- linux-2.4.15-pre5/drivers/net/arlan.c	Fri Nov 16 20:08:26 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/net/arlan.c	Fri Nov 16 20:09:42 2001
@@ -677,7 +677,7 @@
 		arlan_retransmit_now(dev);
 	}
 	if (!registrationBad(dev) &&
-		priv->tx_done_delayed < jiffies &&
+		time_after(jiffies, priv->tx_done_delayed) &&
 		priv->tx_done_delayed != 0)
 	{
 		TXLAST(dev).offset = 0;
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/net/rrunner.c linux-2.4.15-pre5-jiffies64/drivers/net/rrunner.c
--- linux-2.4.15-pre5/drivers/net/rrunner.c	Fri Nov 16 20:08:27 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/net/rrunner.c	Fri Nov 16 20:09:42 2001
@@ -770,7 +770,7 @@
 	 * Give the FirmWare time to chew on the `get running' command.
 	 */
 	myjif = jiffies + 5 * HZ;
-	while ((jiffies < myjif) && !rrpriv->fw_running);
+	while (time_before(jiffies, myjif) && !rrpriv->fw_running);

 	netif_start_queue(dev);

diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/net/sb1000.c linux-2.4.15-pre5-jiffies64/drivers/net/sb1000.c
--- linux-2.4.15-pre5/drivers/net/sb1000.c	Sun Sep 30 21:26:07 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/net/sb1000.c	Fri Nov 16 20:09:42 2001
@@ -403,7 +403,7 @@
 	}
 	timeout = jiffies + Sb1000TimeOutJiffies;
 	while (!(inb(ioaddr[1] + 6) & 0x40)) {
-		if (jiffies >= timeout) {
+		if (time_after_eq(jiffies, timeout)) {
 			printk(KERN_WARNING "%s: sb1000_wait_for_ready timeout\n",
 				name);
 			return -ETIME;
@@ -421,7 +421,7 @@

 	timeout = jiffies + Sb1000TimeOutJiffies;
 	while (inb(ioaddr[1] + 6) & 0x80) {
-		if (jiffies >= timeout) {
+		if (time_after_eq(jiffies, timeout)) {
 			printk(KERN_WARNING "%s: sb1000_wait_for_ready_clear timeout\n",
 				name);
 			return -ETIME;
@@ -429,7 +429,7 @@
 	}
 	timeout = jiffies + Sb1000TimeOutJiffies;
 	while (inb(ioaddr[1] + 6) & 0x40) {
-		if (jiffies >= timeout) {
+		if (time_after_eq(jiffies, timeout)) {
 			printk(KERN_WARNING "%s: sb1000_wait_for_ready_clear timeout\n",
 				name);
 			return -ETIME;
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/sbus/char/aurora.c linux-2.4.15-pre5-jiffies64/drivers/sbus/char/aurora.c
--- linux-2.4.15-pre5/drivers/sbus/char/aurora.c	Wed Oct 31 00:08:11 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/sbus/char/aurora.c	Fri Nov 16 20:09:42 2001
@@ -180,7 +180,7 @@
 #ifdef AURORA_DEBUG
 	printk("aurora_long_delay: start\n");
 #endif
-	for (i = jiffies + delay; i > jiffies; ) ;
+	for (i = jiffies + delay; time_before(jiffies, i); ) ;
 #ifdef AURORA_DEBUG
 	printk("aurora_long_delay: end\n");
 #endif
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/scsi/53c7,8xx.c linux-2.4.15-pre5-jiffies64/drivers/scsi/53c7,8xx.c
--- linux-2.4.15-pre5/drivers/scsi/53c7,8xx.c	Thu Oct 25 22:53:48 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/scsi/53c7,8xx.c	Fri Nov 16 20:09:42 2001
@@ -1867,7 +1867,7 @@
 	 */

 	timeout = jiffies + 5 * HZ / 10;
-	while ((hostdata->test_completed == -1) && jiffies < timeout) {
+	while ((hostdata->test_completed == -1) && time_before(jiffies, timeout)) {
 		barrier();
 		cpu_relax();
 	}
@@ -1953,7 +1953,7 @@
 	    restore_flags(flags);

 	    timeout = jiffies + 5 * HZ;	/* arbitrary */
-	    while ((hostdata->test_completed == -1) && jiffies < timeout) {
+	    while ((hostdata->test_completed == -1) && time_before(jiffies, timeout)) {
 	    	barrier();
 		cpu_relax();
 	    }
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/scsi/53c7xx.c linux-2.4.15-pre5-jiffies64/drivers/scsi/53c7xx.c
--- linux-2.4.15-pre5/drivers/scsi/53c7xx.c	Thu Oct 25 22:53:48 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/scsi/53c7xx.c	Fri Nov 16 20:09:42 2001
@@ -1627,7 +1627,7 @@
 	 */

 	timeout = jiffies + 5 * HZ / 10;
-	while ((hostdata->test_completed == -1) && jiffies < timeout)
+	while ((hostdata->test_completed == -1) && time_before(jiffies, timeout))
 		barrier();

 	failed = 1;
@@ -1713,7 +1713,7 @@
 	    restore_flags(flags);

 	    timeout = jiffies + 5 * HZ;	/* arbitrary */
-	    while ((hostdata->test_completed == -1) && jiffies < timeout)
+	    while ((hostdata->test_completed == -1) && time_before(jiffies, timeout))
 	    	barrier();

 	    NCR53c7x0_write32 (DSA_REG, 0);
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/scsi/cpqfcTSstructs.h linux-2.4.15-pre5-jiffies64/drivers/scsi/cpqfcTSstructs.h
--- linux-2.4.15-pre5/drivers/scsi/cpqfcTSstructs.h	Thu Oct 25 22:53:50 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/scsi/cpqfcTSstructs.h	Fri Nov 16 20:09:42 2001
@@ -27,7 +27,7 @@

 #define DbgDelay(secs) { int wait_time; printk( " DbgDelay %ds ", secs); \
                          for( wait_time=jiffies + (secs*HZ); \
-		         wait_time > jiffies ;) ; }
+		         time_before(jiffies, wait_time) ;) ; }

 #define CPQFCTS_DRIVER_VER(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
 // don't forget to also change MODULE_DESCRIPTION in cpqfcTSinit.c
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/scsi/gdth_proc.c linux-2.4.15-pre5-jiffies64/drivers/scsi/gdth_proc.c
--- linux-2.4.15-pre5/drivers/scsi/gdth_proc.c	Fri Sep  7 18:28:37 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/scsi/gdth_proc.c	Fri Nov 16 20:09:42 2001
@@ -1464,7 +1464,7 @@
             timer_table[SCSI_TIMER].expires = jiffies + timeout;
             timer_active |= 1 << SCSI_TIMER;
         } else {
-            if (jiffies + timeout < timer_table[SCSI_TIMER].expires)
+            if (time_before(jiffies + timeout, timer_table[SCSI_TIMER].expires))
                 timer_table[SCSI_TIMER].expires = jiffies + timeout;
         }
     }
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/scsi/mac_scsi.c linux-2.4.15-pre5-jiffies64/drivers/scsi/mac_scsi.c
--- linux-2.4.15-pre5/drivers/scsi/mac_scsi.c	Sun Nov 12 04:01:11 2000
+++ linux-2.4.15-pre5-jiffies64/drivers/scsi/mac_scsi.c	Fri Nov 16 20:09:42 2001
@@ -353,7 +353,7 @@
 	NCR5380_write( INITIATOR_COMMAND_REG, ICR_BASE );
 	NCR5380_read( RESET_PARITY_INTERRUPT_REG );

-	for( end = jiffies + AFTER_RESET_DELAY; jiffies < end; )
+	for( end = jiffies + AFTER_RESET_DELAY; time_before(jiffies, end); )
 		barrier();

 	/* switch on SCSI IRQ again */
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/scsi/qlogicfas.c linux-2.4.15-pre5-jiffies64/drivers/scsi/qlogicfas.c
--- linux-2.4.15-pre5/drivers/scsi/qlogicfas.c	Thu Oct 25 22:53:51 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/scsi/qlogicfas.c	Fri Nov 16 20:09:42 2001
@@ -271,11 +271,11 @@
 int	i,k;
 	k = 0;
 	i = jiffies + WATCHDOG;
-	while ( i > jiffies && !qabort && !((k = inb(qbase + 4)) & 0xe0)) {
+	while (time_before(jiffies, i) && !qabort && !((k = inb(qbase + 4)) & 0xe0)) {
 		barrier();
 		cpu_relax();
 	}
-	if (i <= jiffies)
+	if (time_after_eq(jiffies, i))
 		return (DID_TIME_OUT);
 	if (qabort)
 		return (qabort == 1 ? DID_ABORT : DID_RESET);
@@ -405,8 +405,8 @@
 	}
 /*** Enter Status (and Message In) Phase ***/
 	k = jiffies + WATCHDOG;
-	while ( k > jiffies && !qabort && !(inb(qbase + 4) & 6));	/* wait for status phase */
-	if ( k <= jiffies ) {
+	while ( time_before(jiffies, k) && !qabort && !(inb(qbase + 4) & 6));	/* wait for status phase */
+	if ( time_after_eq(jiffies, k) ) {
 		ql_zap();
 		return (DID_TIME_OUT << 16);
 	}
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/scsi/qlogicfc.c linux-2.4.15-pre5-jiffies64/drivers/scsi/qlogicfc.c
--- linux-2.4.15-pre5/drivers/scsi/qlogicfc.c	Thu Oct 25 22:53:51 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/scsi/qlogicfc.c	Fri Nov 16 20:09:42 2001
@@ -803,7 +803,7 @@
 			outw(HCCR_CLEAR_RISC_INTR, host->io_port + HOST_HCCR);
 			isp2x00_enable_irqs(host);
 			/* wait for the loop to come up */
-			for (wait_time = jiffies + 10 * HZ; wait_time > jiffies && hostdata->adapter_state == AS_LOOP_DOWN;) {
+			for (wait_time = jiffies + 10 * HZ; time_before(jiffies, wait_time) && hostdata->adapter_state == AS_LOOP_DOWN;) {
 			        barrier();
 				cpu_relax();
 			}
@@ -820,7 +820,7 @@
 	   some time before recognizing it is attached to a fabric */

 #if ISP2x00_FABRIC
-	for (wait_time = jiffies + 5 * HZ; wait_time > jiffies;) {
+	for (wait_time = jiffies + 5 * HZ; time_before(jiffies, wait_time);) {
 		barrier();
 		cpu_relax();
 	}
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/scsi/sun3_scsi.c linux-2.4.15-pre5-jiffies64/drivers/scsi/sun3_scsi.c
--- linux-2.4.15-pre5/drivers/scsi/sun3_scsi.c	Thu Oct 25 22:53:51 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/scsi/sun3_scsi.c	Fri Nov 16 20:09:42 2001
@@ -357,7 +357,7 @@
 	NCR5380_write( INITIATOR_COMMAND_REG, ICR_BASE );
 	NCR5380_read( RESET_PARITY_INTERRUPT_REG );

-	for( end = jiffies + AFTER_RESET_DELAY; jiffies < end; )
+	for( end = jiffies + AFTER_RESET_DELAY; time_before(jiffies, end); )
 		barrier();

 	/* switch on SCSI IRQ again */
diff -u -r --exclude-from dontdiff linux-2.4.15-pre5/drivers/scsi/sym53c416.c linux-2.4.15-pre5-jiffies64/drivers/scsi/sym53c416.c
--- linux-2.4.15-pre5/drivers/scsi/sym53c416.c	Sun Sep 30 21:26:07 2001
+++ linux-2.4.15-pre5-jiffies64/drivers/scsi/sym53c416.c	Fri Nov 16 20:09:42 2001
@@ -277,7 +277,7 @@
 		{
 			i = jiffies + timeout;
 			restore_flags(flags);
-			while(jiffies < i && (inb(base + PIO_INT_REG) & EMPTY) && timeout)
+			while(time_before(jiffies, i) && (inb(base + PIO_INT_REG) & EMPTY) && timeout)
 				if(inb(base + PIO_INT_REG) & SCI)
 					timeout = 0;
 			save_flags(flags);
@@ -323,7 +323,7 @@
 		{
 			i = jiffies + timeout;
 			restore_flags(flags);
-			while(jiffies < i && (inb(base + PIO_INT_REG) & FULL) && timeout)
+			while(time_before(jiffies, i) && (inb(base + PIO_INT_REG) & FULL) && timeout)
 				;
 			save_flags(flags);
 			cli();
@@ -559,9 +559,9 @@
 	outb(0x00, base + DEST_BUS_ID);
 	/* Wait for interrupt to occur */
 	i = jiffies + 20;
-	while(i > jiffies && !(inb(base + STATUS_REG) & SCI))
+	while(time_before(jiffies, i) && !(inb(base + STATUS_REG) & SCI))
 		barrier();
-	if(i <= jiffies) /* timed out */
+	if(time_after_eq(jiffies, i)) /* timed out */
 		return 0;
 	/* Get occurred irq */
 	irq = probe_irq_off(irqs);

